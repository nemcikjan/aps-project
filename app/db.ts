import { Client } from 'pg';

export async function connect() {
	const client = await new Client({
		host: 'localhost',
		user: 'postgres',
		password: 'default',
		database: 'aps',
		port: 5432,
		statement_timeout: 600000
	});
	client.connect();
	return client;
}
