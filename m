Return-Path: <linux-pm+bounces-43735-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGa/GT9AqmlQOAEAu9opvQ
	(envelope-from <linux-pm+bounces-43735-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:47:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C267821AB48
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7851B302AD2A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016893254B3;
	Fri,  6 Mar 2026 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L9Uvgt02"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFC2D46A1;
	Fri,  6 Mar 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765243; cv=fail; b=k7vYvBax5ind7rzBHYNLz4rtZvPAGpRvkyVJYfQdwxOx5La4wgqT4zQJ4p4QIUWezSDuULYiwNzmIAYts89jzhc6Axa+siby3cjBKWCyJ/4EjpWYhl6qqt78uKa6/k+Ij64HjfQyebJqzRORQ6ivynKyAp0irGHjVbRyHexzpuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765243; c=relaxed/simple;
	bh=Z3o8lFlgjb8i3JaKal/PSYUA5pOdKm2Vh0uLIx7vZMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bs5xW+o+2I+YwtjbexIJnAKha8v5ODb449WORMBX66uOd6EANW0Kt+Di6cMBsx4q61DOlfqc7fCPM7k1kdHep9L7jIMy0vk214dWOiIU+ZnyYvLvcr/nIYgAeV9fEk62i9TCuTn+X0lw3RfM//7R7onfTmUDxCREF9H+LlY7vXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L9Uvgt02; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ik8bqZuZg79OTcRNa2XPBwqeij3E41NwciwUGmYvRaDQagPIJ4hN0t35g2AxQ6hdWJoG5/tvhJzJSF88/jOwv2OIhpeS0wFkZ8rD6FGFMCirpgEO/aKpsc77qWm4nQCYmbxWtFPZ83lW6CunNNw9ibiFbvDROoNiOHmvNR8oxmfYoVNN0XLdz17kTBg0up+yh7jjILnD+El4ts/EsvhwEACpZvCLPREgUazyfpNn5kvek7bAFaLut5/fFqGT63DvqAnHrt7U+RWLu4ngPmYM1Xh7iqCZuxpPMHaggqRLKaHXNXKTCYqhVM3Uw7TNHpoSh4c7Cj3ELUwLj75xZVzUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcwj3cgeH3xz0HuEN6ZF/bq3FvLA/6VFeUxezhyV5dw=;
 b=T+/D7NpHWS+S7BltcH8q8tfHsiB5QQ63BBSINAltmXcC6/UQAA6lct+MtHiGpxA4N4YO08c43JGBrTFfAdjHMRAEXsYdQZMimJZ+SPQARqElxnlGetDCoPlPn4O9kgZDG+yhvMKMzmodq+9eNjtYrKYDb0THP1Uxmobub1JYaKYNNERhOMzg89ZJPb9zbqv8b13TWT0usmQlgohyEQqRT4kzcRXZsLvU7Sk/TGycShCEQHQTp/6ny+dqWaXHfrhf8gbe5JfFI3AGtOs20hNE11Nnp9lYhSDmP62UxrEqwvKwQHY+4pAvwDyxP+AcK2N2AljAJ34wMaG1Fqzl+DaNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcwj3cgeH3xz0HuEN6ZF/bq3FvLA/6VFeUxezhyV5dw=;
 b=L9Uvgt02Os6TuMHA/niDB5A/TFmKyrOKuNJYhouHtwndt0F+qnPzqEX/KYw0Kv9LlFByTnclu6MqJxMPBuhva9uppKU3rAiNyyCoY6a9dZ7rGmcajMNsX2mimbcCR5HvpZw002RW17Z3/qOahCC9XIquqDwYwXA/kxKcnHZ+1LDDg2gIKYCiMEh38EVriSeyCiN8kKpMfR43OAqaUA91cWiX79koAeNJ9VqbgBIJDYkMsBUJhyS+3afE5eqyBGStddBQ/Q3Cfxf00SbjxgKcfFjq+Jvq4aLMpNo6HFAS/NGXp0qgo34D5bYp6n78qgO8mqadHdzqiiyfnX4rvtE+WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by PA1PR04MB11470.eurprd04.prod.outlook.com (2603:10a6:102:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 02:47:15 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 02:47:15 +0000
Message-ID: <61e260e0-4544-4c51-99bf-c4815367fa94@oss.nxp.com>
Date: Fri, 6 Mar 2026 10:47:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: verisilicon: Fix kernel panic due to
 __initconst misuse
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
 shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, m.felsch@pengutronix.de, fra.schnyder@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com,
 peng.fan@nxp.com, eagle.zhou@nxp.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260306022406.760-1-ming.qian@oss.nxp.com>
 <CAOMZO5BP2aLD+a1r7hVd3F4Qvfovxb8PgQfzcVRKknBHWYBmtg@mail.gmail.com>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <CAOMZO5BP2aLD+a1r7hVd3F4Qvfovxb8PgQfzcVRKknBHWYBmtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|PA1PR04MB11470:EE_
X-MS-Office365-Filtering-Correlation-Id: 001c513e-7b0f-4472-0e56-08de7b2aacbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	o5h5pebJDxZAEADsdgabMwPdh8pY73KWurHMl0YaSW2lLycSgL2XQMTtOSiNJ6eTYBby3c7yS3k7XcfgqDVH1zc+KHY1exU9V8wskRzivXpAZowz/MnC+jyDD/f6ApfumDuu1HHOrLUk2E79qClJ6csdMCpO1JO9QuX6MiIJnDbCWN6c979tx2rOW8UMQlfIvdCYe64O8B3sS6GGJKOXX0x6Nrm7EVxVuc17gB0rIEV4Mx0GYs/fF+c4oViAzxvrjiLjhnStwJiXy6m0aUSqK4MQ753UC9D0bYyKobAjnrBKfYuEoZD8pi24nsFJZvxpRqnS+SueZmQxm5U73j9OGTUHi86DrBk2b9Ox69XSHzMbhNZ514Qxxmj5jt4GIzFBppvBJuAD3SGFs1glroGi732zTnnZnBzvr9Qqrdm2y2InTGkCVrNFxeLUzXbFIhiEuxpJ0DXDkWpuW7a63wrRZmRVNZ0PGAsuD406/xnkrIpk27DWtg0r75S8G5KhWrNTYCxS5QMj7QVtB9uXpVdD+6rFHD9ALEHXjW8M8HMqFMDEZ+mxhZM2BeC+l0bL6wizBUv5do4gqDN5sTC50SkjxigICd2h4ClzkKqjUSyKroTdAdRLLl4oiYTqxC40Ns15DQ9JksEpGIW+V7Wx6gxKnch2DiIovexKGtN6FUaiG29WzF7W/KCkgOlOWntnQnR7cp3fayiYipG00ONY+zqDhivzvx/aUTfJTaflJEXPBU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHdkaitmWWRxMmMxZFlWWjNYUFh6dUgzVlBmV1BxWGFnYklVOVBnNnh0dmgy?=
 =?utf-8?B?S1RhWkdua3YydGpJS0F3cEQrdDBSa3lOVWIvbUxnVVI2ditUeEV3ck4yK1Vw?=
 =?utf-8?B?aGdLaXFrZzRFSHBmMnNMMldrK2daeEFDeU52cGVUdGoxNnZrbHBZOGR4c0kv?=
 =?utf-8?B?ZjJ6dWRMZUhKQVVPWm1hZ05xMDQ4eVZ3QW1QckpEZWRldWg4T09UcWdOWkpk?=
 =?utf-8?B?bVJmSmVLVGVvRitzNHdQWVk0WTRxS0hhdFhFQ21tSW1NMEZXZ3pjOUdZMjg5?=
 =?utf-8?B?NS9SOTVBcHJDblhWUGtwSkhROEZwSnN0QS9HVmo3Vytyc3p3VHRVb0MrMER5?=
 =?utf-8?B?MnU3dmpqdUg0TjNzQWYzbHVSUFR4RHJUR1d1OVlMeUtDSFVWSzhlRjFoM2E3?=
 =?utf-8?B?OFRQRFl4cjgySG5PN1lEN0JkMlJRdXlPYTZwQUVwUEJIT29WN3hiWW0rdzlu?=
 =?utf-8?B?YnNKZmhOT1UxWUM4MVo3WFRjekp1SDcxVWlLL1ZZdHVrODlpcFdKRXRDYk43?=
 =?utf-8?B?KzQvMTVPdS9sWjZvMEgvb1IyS0F6MFQ4UXMrZ1ltNU1GNEhLYXoyQVoweTNN?=
 =?utf-8?B?cG92ZE9QTmdWUVgyUllabDZydjRYYkkrbUtLVEhWS2RhY0NEUlY4UVRzd2VV?=
 =?utf-8?B?U0kyMjVJK3BJeGhpTG1SS0RBeXJvbzVoWUt3ODNQNU9vcDdLYXRZVmhxbW03?=
 =?utf-8?B?OUhoNWZPc0NuVnFVRE5uRDJTL0hiNWFMS09YN1lXUVlHeHZiby9DTjRkTjQy?=
 =?utf-8?B?SGZNNzBnNS90QkpBYkF6V0g2QnNmMFJtMHRwZCtPcDMwSWo1Wk9GZUtJMUNx?=
 =?utf-8?B?TE1xaXo0S01pWXVKek5heGQ2VFlGTkQ5RFRhb25GSDJRWmI5cFBpNmpvbVJ4?=
 =?utf-8?B?Y204TjJ1YXg2eXFWcGplaE9nUEM5anFtMC9uRjhzRm84Y3pRSFdTU0h3dWR5?=
 =?utf-8?B?YytzQWhJT0EwUVlYandOU3pKK2NEN3NiM2FhTXYwMG00am9BUXBCazNPT0xF?=
 =?utf-8?B?M0YzaUlIaDV3WGwvbE4yWVRKUlZQUEE3OE9BdnJtVE9zZmJNRkN5VExOWTZv?=
 =?utf-8?B?L1JJNUxUS3lYbTNQL3FRZm0rYWN4K2p1V0tUeTJady90ZTVjaUc4ZUNUSjJt?=
 =?utf-8?B?MmJDN0E0cW55enlvWUFiVGF0ajkrcDNxeUhaZzcyam5CVUN2aHd2TXdGRm94?=
 =?utf-8?B?ckd1VklEVnhIaktTWWhLd2VGZFJFc0pUcUtjSzZ4TVFDTXlNNlBid21NaFVk?=
 =?utf-8?B?cW5vZHZwODV6Uk5VTlRla285UXIvejNXaDVDK3hmc0VNaGtCeWlpN0pkVFpH?=
 =?utf-8?B?cHBHWXQ3QkhuT0QzMXNFa0JTL29IM1JMWHdIcTlYOHBFT3kwMTFGY0J0b01S?=
 =?utf-8?B?SElUamZDeHkxakdKYktHTjdvME5KVHRNWDRkZ3owcHpISzQrNkIvSUhjYmFW?=
 =?utf-8?B?eEhVM2NqaHo0RFZvbnZOR0NDQ0VXQ3ZmTkdEQnJMUGFIQWpRT2xrbmdVK1Ax?=
 =?utf-8?B?N3A0ZFUwbnBWM2d2dzZWZWxpb0JvdGgvaDhqT0xyaEUzV0JZMUtsWVBnT0dv?=
 =?utf-8?B?Q09JWURYMUN5SVVwNmdpNElaWERxN01VQTZaSzZzWkd2Q2lMQWNsb3dkcEFM?=
 =?utf-8?B?ZGl2Wm0wUjZmeFNOUjNBNkNvUE1QOXRDcnFadjZSb0orZ2NhajJxMm1QUHUx?=
 =?utf-8?B?b0NwbFRaL29PeDd0TGlrNEVQRUo5TkZRWmZXbVZRYTBBWGhxcEFzVVduYmdO?=
 =?utf-8?B?Q2taV0pnelNRN2RmUWo3YmtiZzFDT1NtSVRGNDAyeU5xZEhqMU1DanBZVEV4?=
 =?utf-8?B?UjZTckU4KytPUGI2RzZuRFZNR09wUW14bVJHalZ3c1RLT1EvTEQwdTNmcmpy?=
 =?utf-8?B?a1MwdzNTK25kYkNxN2lzdGtxd1V0TkJYMHgzUVZ4WjRTbzNtc1o4cFV5N3Iw?=
 =?utf-8?B?NUUxN0FDT2N0a000NXBFV0hZL1pFZSt3eHNiOS90bkpEYlFucGh6MnlWcFcz?=
 =?utf-8?B?VVIrTFZJRVFJblZLTTBRdWxyRHJOUzdicmpBRlZIMEIzbGFLR2JGL3EwQ3lF?=
 =?utf-8?B?T2Jta2VvVVA0dlJzNzFtTmxTNUtWcVZxVHREMW53RGtkcE52bWFlenFCbVYy?=
 =?utf-8?B?VEdtTkMwbDhiUlRHTTU0NG5xbkV1dFF6SUJ5RldBeHo1SW1jUUFxQmgrL0pM?=
 =?utf-8?B?RzkwM3BKM3B1SVZCaWNtV0kyOGNsRkgwNng4VllYc3E1b1BzSUdiQkJkeUtw?=
 =?utf-8?B?MGM4SDdKeTZoNFhrcnI4VWhIWXdzY0VwcXFjb1p3Rno5RUZ3N2prVW5KeXM2?=
 =?utf-8?B?S3ZKbzhaMTE1NXdnQVBjbDQrWUE2NzN6ZDN2TjRaTjZKOTg5RlRWUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001c513e-7b0f-4472-0e56-08de7b2aacbf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 02:47:15.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nDJlBifv8sH3/RjmCEf5GmzpQr6PX3xNsuwu/tI3eE4ab9Bn2cX0MNuZxolpzxMvtRx+kjor6iDGGeWFumdaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11470
X-Rspamd-Queue-Id: C267821AB48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43735-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,checkpatch.pl:url]
X-Rspamd-Action: no action

Hi Fabio,

On 3/6/2026 10:38 AM, Fabio Estevam wrote:
> On Thu, Mar 5, 2026 at 11:26 PM <ming.qian@oss.nxp.com> wrote:
> 
>> -       { /* sentinel */ }
>> +       { /* sentinel */ },
> 
> Drop this change. It is unrelated.

But without this, the checkpatch.pl will report error:

ERROR: missing sentinel in ID array
#50: FILE: drivers/media/platform/verisilicon/imx8m_vpu_hw.c:346:
+static const struct of_device_id imx8mq_vpu_shared_resources[] = {
         { .compatible = "XXXXXXXXXXXXXXXXX", },
         { .compatible = "XXXXXXXXXXXXXXXXX", },
         {  }


total: 1 errors, 0 warnings, 8 lines checked
====checkpatch ERROR, please correct it====

I've found two methods to fix this error.
- Add commas
- Remove "/* sentinel */"

Regards,
Ming

