Return-Path: <linux-pm+bounces-35139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B6B8EC60
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053623BCB7A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99482F0C68;
	Mon, 22 Sep 2025 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SFkKmkeq"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1B2ECE86;
	Mon, 22 Sep 2025 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507698; cv=fail; b=aOoWR8PNgYMOaYulCsdnmGTaFHWtFD1SM5nFsSjUGGkcPeq+NN4Hxi4OmY6ZMIOyhXOtJaB1Oj3dHW9Cizc6TM0EsZ5z2JqmBTzEXehm5GfNEGwZQh0lM3zdJSbPsUjmExcl1NyUYFAqX0+ZMdwnfTtzweu1VtE/CAxEYadoorU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507698; c=relaxed/simple;
	bh=oT9Gp2ORJVRd6IFtnNDXwCgxzgI+pxdl81Trau+N2sM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GTt+gyGZUw5yl2i8vxa3ZcViwnX0LSJn8LpIENGwlqiWuaucDATt1e5zpVexISvvqXev7BOJDUoMDUM2aIVBqVVr6Q+WhdDdvJTYJxAdnDqoSqlGUETr2akckrkx3Cu1ma2LEmy9e3C7xbqOmF6AhSTBD6O7dRfmqjrP55sL10c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SFkKmkeq; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz53KrvLt8qCVzDv91rMcIfgHB02n1gYZIoYkZX0b5T/Cbq90G0xXf8XvQJnsrJloqutGv5ToM0yO/3tTDFZ4AMO6OPmMYs7gOQhRg0uv+o4W2RLlU/4v4LngoLxfWIl2d6mh2UvRKzf6T5+Bwn2BZzABQVyuTo/1Q7yBBEOzHu5DZKdJr/IJQRPN95/I/HBr6U+3wr0m58N0uwpjOTJYHCRtsL8waihYYW3D4mSOSC8eWAsEX16bU5X2Ltfl7qHBwSgzr6Fj/RgHNemQ+wl8fqtz929ebO/JE167KAEyk/6BmjjB++oJA81dSwgK+cSZCZ8Fe5mv60lcSen4Qa2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPz1ZBbyXHtcXfw5XSMg63R/KGLZDFT3o47tjZSJ3/I=;
 b=FWs34XbAIjXBL9rm3rZu3OJ1OmOwHGSe/1ByHnb6petV7kGeYLkOBMxKa4c1hOgOHVkF94xW+E00YbqUULzfOxIHYJYAIuqv4xmSL/FPe6MZ5uCkd6o7HZJmn0yfYNTw/aL4qJiDi1a9Jz+gKJBDthmH18w6olmnbxSNY3NZMv/3EdrywDEFLSTDSP+J4fE0F93zP2J162Z8oFe+Awu6onj/EFCO+e5c9RL1GG0L6Lz3eljjc947y+6N/ihdKqTkTjDJnR9Rywd2FzlWCHNNxdHHDNNaeDb5dYHGGSSeQOxa21QhfVo//r+3lHCDPywmZojabZ3qMre8WQzNu3jJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPz1ZBbyXHtcXfw5XSMg63R/KGLZDFT3o47tjZSJ3/I=;
 b=SFkKmkeq06xbfuHMiJT6koE9vNgCIV4TdoE9XNX8QQyXif08PNHqXu4tUXvsZ9zDbOrmar8ZRTGlLWFQ/aNdv40HGZ+3xwZhOGQa68fYmTu/z/xXZMamyCA6qomRqxYdOoUuDQWi6weN08xqznVbgMQa3fqNMyBlHRW1QTfbrVnFgufE+BidnzowJHna2ejq8ZmdSf+uobFX3teVsGkR32L0rxoSMbETiltuW/DPBCXpJof2WXGtXhcbrSQ60ogCO5A8iP4syeHptLajyf96zVI89BRfLiv26dOTmmyAQuIa4CQ62ccIOgAvtFGeaOF90PTWIVxYx7rd9RPXYeDWyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:21:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:21:33 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:21:07 +0800
Subject: [PATCH v4 2/5] PM: domains: Allow power-off for out-of-band
 wakeup-capable devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v4-2-ef48428e8fe0@nxp.com>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
In-Reply-To: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507676; l=1751;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=oT9Gp2ORJVRd6IFtnNDXwCgxzgI+pxdl81Trau+N2sM=;
 b=NPNk0As/bluxtUyNGjOykMzLeOIzUM503G4la1dDb8D52FnCkS2rb2OIQMY6OYt9S2hgYvFHa
 3YOnKxWWRQMCQUJIe441G3wE9OWvL+zt7iU9DTFlB/jm6OUD41yp/0h
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2ff6d8-7c3b-4398-e8e9-08ddf97ebfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU5OZndYZ3I2Y0VTYVh0UlA0U2JuY21zRHBacGZSOHdtTDFaQVhxMVZyeU5B?=
 =?utf-8?B?clk1dGFGS1FNMVVOZ1BvT0twazlUbm9aMUcxUzNUWmdSRUp3dElWNnAwbkFV?=
 =?utf-8?B?MGJ1SmsyeVBEZHhpSDNORVZLeld3WjU3TlRLUFRqdHp1RmZhU0hnN1BPeEls?=
 =?utf-8?B?L01YeWx5cFdzRzRFdGNTMm5KRjh2SWpOZWNBdFg4TDcwdkFwbktWa2dqaDhi?=
 =?utf-8?B?Wko2V3o3Y0VmT3hUczVteTg2V2ZRNDQ5bEg2ak1rdVd5bSt6WjdLMGlFRGF6?=
 =?utf-8?B?QjJlUHcxd1ByTGlYTDdPSkd3aVo1NHhBZHVYMVhmekRaQndkQWZraS8zbVly?=
 =?utf-8?B?eThTOEU5cGw5SGIvU0tPTENYQU9LWVk3dHdBeVVxampHaTBpQmQ2bzRjcEFN?=
 =?utf-8?B?SU5xOVljYTVsd2E1bm9NSUw2amZWTWUybVlvM1VqejRoam1hamxwM0dBNVlt?=
 =?utf-8?B?S2lVT3pCQ1d6Ulpna28zWmhEem1FRENONitLZHdMbDBDRHZpUjgrcHRSNnlm?=
 =?utf-8?B?RHlzakY0cjVzUlRwNVRnZWozOUxYUFhYUWFES0p5UG42cFhHa2lXOVcrMXN3?=
 =?utf-8?B?Q0FlVnlGTnUzUC9iOS9TWm5GbGlmMCt1QXJFL3BiUkw3VmVTd2VTbkJXQjVD?=
 =?utf-8?B?S2Z1RVlUald2WDVLNXg4cVRaWkowTW1uSUhSRkhXZHNUYldhcjhFQklWbDY5?=
 =?utf-8?B?RHQxSlFzNlM4dDJkMUlmdUVzSHhQSi84aFZvTEpXSUw1MzNaMnBlaTF4VDdF?=
 =?utf-8?B?cmQxUm9COVhtblZjM0R2MG1nWE53cDZHcXp0c3RhZHQ4YlpTeXY0cVN4QVk4?=
 =?utf-8?B?UU1uenZCUUpHbjlRYTFtUUZYZkpwVUk5Q2E3dmpRNDlpcjdFMFdLZ2tqcmd0?=
 =?utf-8?B?WXo4NENMeloxc0NkYlorQWVUVCtLWHFMaVk2Z0h4V3h5MlVyNEtndm5MeG1F?=
 =?utf-8?B?UFFLdGh3RmpJOUJTaWtaTWJPSWs5b0UvQThUN1VQMHh1ZmNFV0thaGVPMEtO?=
 =?utf-8?B?c2JGQW9pTUpMWno2bVNESVFMdGNUZE1jbk0yYnRxc242dlM1ZzRVVldPRUIw?=
 =?utf-8?B?YkhJc1pRVlBMZlZLQ3I3R3JrZkIwUURhVHdPSWZENlduSmp3anVmd2ZTakQ0?=
 =?utf-8?B?WTEyeVIweG5ZQmxUUmsvNWtYRndIdlVIMVlxcHRFTDlDU0h0L2hYUkRLTHhW?=
 =?utf-8?B?dWI0V1ByNmRaZlAvZUxodGc4cUZMSTBPb0g0S3VaWFlIczFRRjMzMDBPSFFn?=
 =?utf-8?B?Qk1yUUZWcW1HcU51NDA2RUt3c3FqWnVlUjJURUhQRDBxZXZjQWpkdnB0dGYr?=
 =?utf-8?B?VzhhNEtnbENTZ1d6UURTY1UzanBUS1hkalRjbDdXK29CNHgvb2EvYVlFbEVa?=
 =?utf-8?B?elo0ZFc2ZkR6UzYyd213R3VxWXkrbkZ3RGtUYXBtdCsvQWk4dmszQTM3MUtL?=
 =?utf-8?B?VG1OTFNCWmw4TW1aanhZQzQ4NHgxejBUcWFCMWtGS2NnaU9sTFBNekphM213?=
 =?utf-8?B?NVBEWkRhdWdtU2NHdzBQSkxkZ1VHMG1mSVU0d3Bua2R5NlRNMkVuN2RtTXdD?=
 =?utf-8?B?eTM4dHk4MWJBNk1ERHJSMC90aE1WeFVhTFYrRWtSVzh1ck1QOWFOSDBxYUxT?=
 =?utf-8?B?bzNXL1N4eGtUSlRQYjN1eVNuNmZZVWVTQ0J1bWlPcTB1Z1pzQ1pncjYzQkls?=
 =?utf-8?B?aGJxcjcyRldObXlwM1hUd2liQ3ZoRzRsVTR2NFRJMkp5eGRUaUw1M281cHdx?=
 =?utf-8?B?a2hFK01EcDVTNEU1Mm1mZFNqdm1tSEJhOGliTlFJeC9UNmRaeHBNNWthaVc4?=
 =?utf-8?B?WFVuV2FPRDVodGp2RlAzOC9DazhlZkZCWWlWUnZ5RmJrZEhhNEI0ZkRNeDJH?=
 =?utf-8?B?citWREpMaUlOajhlcUxZVzFMREIyT1k0M1FuOS96OFBjNkd1Z09oMjFxZTZQ?=
 =?utf-8?B?QlVXREh4SVVmTVVUaklaeDVMeGljck51NExidlNzUEVRNVlNWThtd25PbGJX?=
 =?utf-8?Q?G+6O7TPby5CMMmL429qLmHOmccJOxI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q045TzdMWE82VVhzc2J1cHN2TTBZYjVRMmlJSlhJS1VJbzBVK2p4SEp0elB6?=
 =?utf-8?B?c0dxRG9nRGRMUDhUbG50VUVUU2RubDZlSjFCdGFna2xJZEc1WHYva2loQS9s?=
 =?utf-8?B?dEpKU1lLSzlxVFAwVXh6aEJ5QkhqOXMwNDVUU2V2dWhHV2txTTd1a0UzaDJi?=
 =?utf-8?B?dFBJdTdSb1hRR3FQNm9DbTMzTTNKVis4OS9vVkFKQ2VSZWQ1UWV3UGZDelVz?=
 =?utf-8?B?SDNIYjVhZXZPZzNBR2RXc21oR3NoVVV6UEtzclE3bFZkYnVueVFpSVFOdnVO?=
 =?utf-8?B?T2FrWHJTMXVkbFRJcDdKeGs2cFZwa0xHVHkxU0JBS2xCT1M5OVNUT2l0UmIv?=
 =?utf-8?B?bEd4OENncDZFRXpWeXRtdTBtN0dGTHdIbzNDNW9BSVY1Zk5JODlpZUhKSnQz?=
 =?utf-8?B?TXFkdGZoeGt6bFZDOXlPek1CaGQyN0V2aXhrbDF3cG9pcWVyaWQ1OEhabGpp?=
 =?utf-8?B?blEyL0RVeHBQYUg4YkI1alBHMWJZNk5jdjVYUVUvdUxxMDVVOUZ6MFlGT0hv?=
 =?utf-8?B?bEZMUjZtVXY5a1E1Zm9oU3J3eTNiMzBheXFjUGwxMUR2Q0JNKzAyK01aK2JU?=
 =?utf-8?B?dmxsUjZvNU1yVTU1bFdMeXYzbm9VUUowVnU5OTgzdUdWeWdhVzdpWDVWUlVv?=
 =?utf-8?B?bWRpMG5sekVFMGE0eXk5MnpLQU1XbW1DM2lydHh6aFJQMGNlWXBDWlVXZWlj?=
 =?utf-8?B?azJkUEpLNWtTdWR4VlJ1cEpmQXJIejRLZFgremtRZlJYeUpwcW1oZ1p6SDhN?=
 =?utf-8?B?QkRHM3hNcHV6dEF5TE0xYThZckJPY0VNNW9vVWpQYjUrUW1WR0h6Ri9hVXd0?=
 =?utf-8?B?ZE1JRVExZDlOOHlaN2tsUEdqUHh1aHdtbWJkOUR2RE9JUno2Rm9FaEIvZjRQ?=
 =?utf-8?B?MVFURVQ3Zng4TzRjNXVIajVVcnJvYS9zQ1h0U0ZrdExsaGFWdU9SODZuakJn?=
 =?utf-8?B?dTBSL0hxUDcwZmpMb1lkcmplOXZzMEZoeVA1QzR6OFNRbjBranNnbWJVL2dB?=
 =?utf-8?B?NkViOThkQWYvQjhUSnpKRnhqWCtrZmZBTDZ3cHQrVkxvTUI5WDRjL2ZENFpX?=
 =?utf-8?B?Ny9sY0p6OCtiQVo2TFl3U0JUdUFac0ZvWUZCODkrRjFaQXNBUjU4L25BM3la?=
 =?utf-8?B?MkRSRkFjRVdkaDNNK3lVWndmdFJzWmdSKzFBb1RObFExcWtnNFdjSUhuVWJx?=
 =?utf-8?B?VzV6SllPN2c2UXNFRU4wckZmTE9ZaTB5TFlaQXNmMzByekVqVVFQdGlHVXZ5?=
 =?utf-8?B?Y3FUS0N2SHorcGhHb3BsMnBVdVZaUGd6dXRjSjFScHRhUzFXVU0rRjhVcHA0?=
 =?utf-8?B?MHdGdE4xb3VnNGJGekxQTUh3bE11Sk1PbWlWOTJJWE9mNjRmMXpwSlZsbGtF?=
 =?utf-8?B?TWFSQWdXaFRpWkkwK3cycFhwZGpTcjZTUzlUKzJwT3VEVTljL3pIejRVR1Rl?=
 =?utf-8?B?N000b0lLeU9sVXI4ZlBtK3YwVU9CTUw5K0xYMU1mZ2tFQ25nZVhicHU4TFdS?=
 =?utf-8?B?R00zT2laYU5RNVYrVExVUUdhVjJlaEdKbUs5czRiam81VE9nMEw2WStkRWFU?=
 =?utf-8?B?dEw0M2lzUXd5VmFrU3R4VFB6YkF3K01XOVBjV2I0bUZQcm1WbFc0bTE5aVZh?=
 =?utf-8?B?L3g4MHhDZlc3SjVjaW1hVFZqbGxMU0FPeCttZnJOcUVVZS9OZWVEUkJYcXF0?=
 =?utf-8?B?bDVwb3VKZ2llSGpidlNpOU1FME5oQU1TbmJYa21paldoa0tia3lGTWcreXRH?=
 =?utf-8?B?dmpLUTRLLzVXc0ZPSHJJV2RXT0NmRnhRdVB4d2t1dk9RanE3QW9yQm1lYW8z?=
 =?utf-8?B?Tld2MUMzalBNMloxRnhRK3BodGJMb0wrcjlaRHRONlN6M2I0NzZPUmN4a00r?=
 =?utf-8?B?RHd5TytTakRhQ0F3Q2dkYVIrV1FkSjE4NlZSSm9pY1loWm5OQkl6aWc0aVh1?=
 =?utf-8?B?MjJ2TnBKd0E3bDI4SWJWR0RTMXk0bEYwa1o2Nm8wNkVKS3c3Sm5KVnd5b1E0?=
 =?utf-8?B?TjUybDYrejFPVC9xeURFM0lJRjJoNkJCaFlvd2poUHpyOXR1SDFER1VpbS9E?=
 =?utf-8?B?alB0RWo2K3U1VXB4M0Q1b2Q1YVh2ZVQ5dnRxVTNDNUpDMlFzNFNzNks1Yzg5?=
 =?utf-8?Q?tTR8yMzc74wxu2KvCnxSuZ+i/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2ff6d8-7c3b-4398-e8e9-08ddf97ebfbe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:21:33.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHhY0ccoNnYFnxa8sO8rAYBaGeGrAiEhxpCm3YOlvS/pZIM8Or+J9MGqsVpB+pSfeFqI1Zy876g2X8VrnCDI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053

Currently, if a device is configured as a system wakeup source, the PM
domain core avoids powering off its power domain during system-wide
suspend. However, this can lead to unnecessary power consumption,
especially for devices whose wakeup logic resides in an always-on domain,
i.e., devices with out-of-band wakeup capability.

To address this, add a check for device_out_band_wakeup() in
genpd_finish_suspend(). If the device supports out-of-band wakeup, its
power domain can be safely powered off, just like regular devices without
wakeup enabled. And same check in genpd_finish_resume().

This change improves power efficiency without compromising wakeup
functionality.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 61c2277c9ce39fcd2f7e77df549626e49a4d5310..4925bc1c441078a8d38600192ee696bf550e80f0 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1545,7 +1545,8 @@ static int genpd_finish_suspend(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_out_band_wakeup(dev))
 		return 0;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1600,7 +1601,8 @@ static int genpd_finish_resume(struct device *dev,
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_out_band_wakeup(dev))
 		return resume_noirq(dev);
 
 	genpd_lock(genpd);

-- 
2.37.1


