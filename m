Return-Path: <linux-pm+bounces-18953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC69EBBD4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8083F18887C8
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101042327A9;
	Tue, 10 Dec 2024 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DYSJN+kj"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E1231CA0;
	Tue, 10 Dec 2024 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866055; cv=fail; b=lp0dP1wCw4ozULlcdunV8XMj9Odkf8Z8/kD2QBuGR/pf/y54dcFZIP1dZg7fTpGT2tAardzspWnkHMt2JWEgiXrDwFNWsNJJoO3vtqTlk4m6H+gr6fwqDkULFBxXk2rsEnZmn/u9PCFgWNBLD/2FsBo+cNu3TE/DLfGgGYrIEiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866055; c=relaxed/simple;
	bh=UBRH/DZ+712KxK9ZDlNSlCh6M3g3qSAyI/ZL35VH1OU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pc04tD1LTx3g1PCyFPJCihhrZXqarg8Z7Rqqi65DxMrIYQVhR8mcwAX/KfX8K3bFLsrWL8rpr/C8G763Zy4/FAnjynE6MuCQTx9xRvi+yxrl0AHgwa2gOIIxmalySV4dz+usn1R1rw9YlTcg3y3EWcqbqOuas9IoVuNqsUlaVXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DYSJN+kj; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueofw3H2iiPyQ2ZFg/wBYbWb04MhvV1t43TWYB7cahEL28X77W9eTftniWlnxlfDXwVig75NCqpiYqswxJL72F9yiPwgU8qJdwagAF3GKe/YUVk13oezjc0f2NIuWnOXSTdcYlrKmtM0/UBm5XyBsAOSkVniksqRAjEb56LnzK/YctzmPC+iCoodd2bGNv9KE3XIWu+UoxKdrKzTev6g3a+ZknkGfM9VByNwaIEcVUB+kd4Pc1URxxV7roT6uW0+ng4NF3HMOKvosoF78ZhsQ1CpIiZkuhiRysRjBcWw0xqDf1UF6GlpsJ4SoFmVeMmreSSTiJqKVL8e3bg7b8/IxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKuh2jrYk7ZziHGoSy1nV2WC7g4UIPaOeOprVp6g0hw=;
 b=X+f1VImxa+vYQJafinOis0L55qSTJGNhwmL4qWwsUpbl0CiP1mtzGxu6/J2f2PThOrYbqSYQsyYWjmVYuV9Yo8pDbmaTs4blmpBDF6sjxSxp49QyEPi0DzRdIpoxIbOw2ht7oQe4wruvfjkZtbm2IfDyeWRhY7sqNnhJ0yM2m2cuji0lIuzCcL4nUrTsv/qt3uiVNGtGxpVHYoIxpEvI+FcJ0I0AdPB7g0RjujzEKgFLka02kAX6rn9kzsiKzx8jIdPgmsEv3tFwetXPJoJ95XZIZgUS7+zZguUhiGn95yK2aFHP5I7gVE38etRc4fnMdDFQk2zNJWFeDTG8ZjzkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKuh2jrYk7ZziHGoSy1nV2WC7g4UIPaOeOprVp6g0hw=;
 b=DYSJN+kje0BnGFNq3sOnGRelXxmXwnKlisY5ckEvsK/0MpRGICt4YpBeYseQLOYxa3ptf6755m/TDpwuQekzAgKxM2WkZa+NXDyDW8IsZU3i6804so5jWJAz6VeygFYGNbJn0h1wBwcGDrRprCES/IC7zSces0mWWTKwc7iciTFu7nPJIxs4r7jHGgTx/+342uRzqavcA08fxNUDDcQA2IhZTsZ5NRzrzOpMfPDd6AM4/3cQKnRvPIF523yAob7iavAWfBQ+izV08oUFr2j1/vYy5joNG9tDjRTlx7JLp5WJElov2On20dOTXv06j8Lm0yZPa+43T8p/U3xdtlAWhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7550.eurprd04.prod.outlook.com (2603:10a6:102:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 21:27:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 21:27:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 10 Dec 2024 16:27:03 -0500
Subject: [PATCH v2 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-imx91tmu-v2-2-5032aad4d88e@nxp.com>
References: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
In-Reply-To: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733866037; l=9362;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GaTapRVMfFiP49k8WRVidYkY+FWOXePac372dgGJZ+Q=;
 b=C/pECoT9LFUgiheY2l7kSsB4nDk9ANUu0WALyWaP+LGXAP7eHfODra31o+yMdlK46RO8Y3wne
 JscyjrDtXUzB1mqdKe9jgn0XE/E46mGhtUrbvUYoFqZLJ5xIbjyNnKJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e46868-6744-4e22-4a0f-08dd1961741e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjZjNmxNTFQzOXpraXMzTTQweDRUdEx0YzMvc3d4YlJvUTlDb0ZCbVBnekNn?=
 =?utf-8?B?NG5KYkRrOUxGRlpUNkM1bDZxaDh5V2R5NWduQ3krOVFUOFJzaTNPWGJmWFNX?=
 =?utf-8?B?djQzNHpBL1J0U3hCOHY4RVFtMDIxNnM0dDkxOC81V0t4OHBSQmc0eU50aUZR?=
 =?utf-8?B?Slk3aER5SmgydXNSY0hWLzlOS3ZnUzJ4SUxSYmt6UE1abG9xL1hFNjRKQzE1?=
 =?utf-8?B?d3dxaXRsbE5EVkgrbGpiWUJNcXFuZXNQYTBZVjVDU1RnZDZBaWNrblY4SlJP?=
 =?utf-8?B?ZzZCajdhQW1sMm5HT3kvZCtNdUZlMWR1U05Na3ZZQVhEK1dtejd0bFdUbGww?=
 =?utf-8?B?Vm9ZZE9HeUEvVjJnY2JuWll6MW92WVY0VVhNYU1DMk8yeGpJN2E5UUJQaERv?=
 =?utf-8?B?NjVOK1lib3lxeS9XN0ZsdFE5UkxWODdvY2NjdHlUNVNrVnBoK0ZzZEx0bWdV?=
 =?utf-8?B?aXVBelZtSzBKamlHRHdEQWlUS2duMzBLK1dXZ3I2ZzNrSEIraTB5QUZMY1I4?=
 =?utf-8?B?a1hYWVpKc1hkalRBdzhDUzZIdmovaStpakhjRE83eHZUQ1RWVHBUa3pZQisy?=
 =?utf-8?B?U29UR3NvdTVzekFSblBHaUMzUzBaNlp3ZTJNMjlLQ2F3ejNUaE1EK1pqVDZF?=
 =?utf-8?B?a1J6U0tiV2tnelQ4eXBSWURMcWxKellISU1reXBzUldQQXdFM2Q0VWx5Wm0v?=
 =?utf-8?B?S2FSb3YzYmorZU1rV2s3U1FEQURFcHpLM0pKcENyVDVxbmd4NmU5SjAyT1JV?=
 =?utf-8?B?cWNuMk1KbWJ1M25uOGh5UVZ0MG9pcm1wRm1wYjVERjhycG95cTRyREhWem5u?=
 =?utf-8?B?WjlteVphdldkT1RQaGNZY3JWOFRDemEyMHZJWTY2VHZzZ0cwZDIxR0o2ZEM1?=
 =?utf-8?B?dzVxSm45ZXNJVDB3RmU5L3RFbEhNSGlLbGRrbG1vV3V1Q2lXK0hFajlaVDdX?=
 =?utf-8?B?SkZDa0J2U0dBZEZBZGZERTI5UGEzY3BWNDUrbm42Z2llcGsxd2lCbnpxQ3pw?=
 =?utf-8?B?bmZIMnF2dytwRkVnYWtTUlpVNkxGLytlREorWjU2SW9JRnVETnM1Vi9IbktY?=
 =?utf-8?B?d2NJeHl3SXRsbU5uTGJncG11MXpaUXBnL09vb2JLWGVRSWRid3pCT1RLd0xX?=
 =?utf-8?B?ZnNac0Rvb01DaDhGcWxlVE5La1dYTy91S2FOdGwyZDZFRzRHQW43S2txSU4r?=
 =?utf-8?B?R3g0RWZkbE1qeThEZ25sME1kVzVVNEhJUExJNkZrbDNMcVZBRlRtM1ZscWN1?=
 =?utf-8?B?TTFKSVpURlJyQWVZT1ZPYldlOWs1WlBReGo1VVFwZjRDejQzNmxpazBiNHV6?=
 =?utf-8?B?Tm1hRkc4aTArNlduZU9zYnZMY282M3dBeWdlSEJjQ1pNS2hSSU9UVEJBbnhV?=
 =?utf-8?B?UFBBTC8ycFBGOCtDOWRpdUhLZUhQaVhSOWc5R3N0SWNYZ3JzK28yc3lzTWJh?=
 =?utf-8?B?bGcrcWFvc3pML3JWY24wZ2xESThaaXBuZld4MmcrdFFEU2t0alF4VGF6Z1Zi?=
 =?utf-8?B?QUgyMFN4emFUaFJCMmhVeTN5bzZBb2JTM3FzV2hXb2F2dmNWa1pJRFFzdU52?=
 =?utf-8?B?S0tVUlAxM2VwOFNvZS92ZXJSSDhvcUYybFNOK2pnZHBSc29qaldTdURiR21u?=
 =?utf-8?B?V2VRTEtEb1p1R3hVNXN2NU1PU2xsdFRDVHgzV3NmendWVkgvVXN5dy9NNStk?=
 =?utf-8?B?amJKNmUvOWJVWEZaQ2NURzdtK1ZRSk8zYnk3aGZnTnpjTHVuTDdJZ2xSWTkz?=
 =?utf-8?B?ODYrOThNY1czbU1sSWkwY05yc2Zqbno3VVRnaGdHdHdYU2JyN1ZjOUpVbzEw?=
 =?utf-8?B?TUdPem9GZHRPTGdaZWZvaGU1YWI0S0hUSGJ4VmNMeFptN0I5WEY3ai9GQTFI?=
 =?utf-8?B?T2RtbWswblNjbkg3dlhWUWg3bC9xN1NlZHNaZW9NWDdhQURFbVIzMVN6ZC9r?=
 =?utf-8?Q?qYGZmC8CTO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWtVYjdSTnpQSVdRdXptTE5UNzV4K3NVWE9LMjJuY3MreVFXVHhCeVFyNTlu?=
 =?utf-8?B?ZFZYQ01ZL094NFhEdmNSOWU1VTZxTm96dE4vc0hIN1hZZkJnTFNpZFJvMndv?=
 =?utf-8?B?a1hoRjRXU3VjTFAzNXRtK25sTFczU3ZTNTlWWFdROEFiU0JVSXdLd2k5THgx?=
 =?utf-8?B?OFZtRmh1RWNCaG1wVklKdDcyM0EzMHBac0JKRzZzNzhSanE5Z3hyMGV1TGRp?=
 =?utf-8?B?NHdUbG1rMlR6NjFYL2lMMENCZjNsNjYxNmp5YlpBdUp2cDFsNVRLSDViYzd5?=
 =?utf-8?B?bkdXNWVKTk1pTStJbzh3UTFHYUNBU0ZYS0piMUZzOHgvL0dWSWd5cEJFc09w?=
 =?utf-8?B?Z2JBbHVJMEdVUS9tOEZvNUYvQnZpMmVEREQ3Snk3cGRCRFJ5aktOamNVUFY2?=
 =?utf-8?B?NGQ1VUVNZmU0cGhxMlN5UkVmWDFlTXkrbkVxS09SZHJyclFyOGhwUjAyS1RX?=
 =?utf-8?B?eXlneWdqUlFncEhvSlRicVA0L1BVOUJzeDZKS1hEcFJNajNHcGo5RFJGY3do?=
 =?utf-8?B?cXZrUXpGZ1IreVM4VlZPbjgrL1hucytDWDhsRSsyVk9hYUx1RDRKaHpxVys1?=
 =?utf-8?B?NGJMSk03N0J0KzQwL1BTTzBJN1oycEREODJGRjI0dXlNelBxVDNQVFd0YnAy?=
 =?utf-8?B?MUhHYTQ0Tk94QVBHcXRBaThXdGV3RVg5RXhRcW9oZ3JsSVJJMUNDb0NaVm5m?=
 =?utf-8?B?cVVFaDhiY3Ixbk84Z0pqUDVkOE9GbUNWelpIdlk4K0tybExsa2l3OU16ZlNZ?=
 =?utf-8?B?d0g2Rm54bDNYSk1KZ1h6ZVYwdUlCcjVCVnJHdG1oeStreXRtUmpGczFmMnc2?=
 =?utf-8?B?dzUvdnNFNHliYUNKU2JiRTh3ZzRyVkxRT0N0U0Q3V0NtbDNCSjF6dWpjSmVF?=
 =?utf-8?B?di8wQkRhNkRHRW5sVGlqWmtibWdBU0JBUk9xckdIVVQxUElkOHVYVFJ3NitU?=
 =?utf-8?B?YzBQVGMrMDdIZWdVbmpSUnlibENUVEVZSmhNZTloV1dmTGw4dDF6M29WbW5R?=
 =?utf-8?B?RG9SRnFObUUySnYva2l0Z3ZBdmJwSmYzdnc2NGJHWGhKekNMTFJlQzR6N1R4?=
 =?utf-8?B?WHB5VzZ0QXpLVXY0UEViYmkvNHRneWthMUVPb2dVK2o4VkI3WUNrcHpYOEN0?=
 =?utf-8?B?TUVSU09kWlhsSWwvTkc0WW9JS1ZxcWg1M2Q1emtIYW41amtKZWcxRGdrWDlS?=
 =?utf-8?B?V204Nk9ObzcvWmx4VGxUb29TUHV2bEhaWlcweDBhOFVOTjZhQ0c1NkNscXlG?=
 =?utf-8?B?eUhaSGVjRExQaW1rVCt6SE9SUm9xb2R0alI2R0JjbmNOY2tZTDE0M01kOWUy?=
 =?utf-8?B?N1k4UTJWUFNLNGxXSENUME1qclNDcXM3MVkxUFF3RjdCRHFBZlZheVJYSWZP?=
 =?utf-8?B?cWtwNVNNRmtxTE5nZFdnWmIyVEZiVVhPT1pSWXkwY0t1dGhIV3hsdGR5VlAv?=
 =?utf-8?B?MXY5aVlMVFJhWVpna1Fpc1BTblBmSm9hNVNLNWhKU25nNWxFUzI5RkJMNGdQ?=
 =?utf-8?B?SXdMYlFMcXB4ay9OZFFsOGZDRXNTby9kWE85TFZsZDcwR2w3NEhHdEszS2Vy?=
 =?utf-8?B?OVFaNmxZVlM3OUlKai9pWktlRThhVFo3bWJkNzRLRWJSWnIrZTd2Mnk3WFBm?=
 =?utf-8?B?L0ljM3laM3NTdzV4c3VYVGQ2bXVZbDdnK25jRFVHVWtvSGF1RDlLUjRhaVAy?=
 =?utf-8?B?MzgrdnFZYkNmRGRjaXZzOXBEdDVkVE5HeThNZ2hmd0YrYTdrR3NWNFVsMFVr?=
 =?utf-8?B?dHpMMlN1SUl1Ukpna0hROUpkRENSOWlqNjdBSXRZQVRveld3UUF6a1ZRdFRL?=
 =?utf-8?B?dmp2eTZETWZZb29mVUo1VUw2aHlUMFlocjRpMm4yU0YwUkwvTkE5c2VrQ0pG?=
 =?utf-8?B?TzRlcWp5OGdSNE9ZZW1VSmVSWVcvS2FMUlMwN1d2NUlTMzdaWmI2TXNRVC9L?=
 =?utf-8?B?VWdSdUcwSzlWcGc2Si95NXJlaS82M00zUlN5NW9TcmlTbi9XRHgzdTZwdnhG?=
 =?utf-8?B?enlKSVVpNDRidy9KanVkV3lSdDV1dThjbjEvMFp3bGRheGx0ME1Wd3REb1Fz?=
 =?utf-8?B?T0N4V0xTUjB6cGoyb2RJdUw0NVVRc1oyaVNQY2RzNUlIRkhRRUdiZDduMnYz?=
 =?utf-8?Q?IIsGLkOMXEIXJ5D9gPapq1G5k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e46868-6744-4e22-4a0f-08dd1961741e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:27:30.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FL245M2iodEP6gHvbLFSXtz2sUd4XYPzKmUviD9X5hmZdhE4dtS1kc/Sswyat6i3y0Q4A0axq8kEl+2cw+Tovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7550

From: Pengfei Li <pengfei.li_1@nxp.com>

Introduce support for the i.MX91 thermal monitoring unit, which features a
single sensor for the CPU. The register layout differs from other chips,
necessitating the creation of a dedicated file for this.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
---
 drivers/thermal/Kconfig         |  10 ++
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/imx91_thermal.c | 265 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d3f9686e26e71..da403ed86aeb1 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -296,6 +296,16 @@ config IMX8MM_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the passive
 	  trip is crossed.
 
+config IMX91_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX91 SoC"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on OF
+	help
+	  Support for Temperature sensor found on NXP i.MX91 SoC.
+	  It supports one critical trip point and one passive trip point. The
+	  cpufreq is used as the cooling device to throttle CPUs when the passive
+	  trip is crossed.
+
 config K3_THERMAL
 	tristate "Texas Instruments K3 thermal support"
 	depends on ARCH_K3 || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9abf43a74f2bb..08da241e6a598 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
+obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
new file mode 100644
index 0000000000000..ebb59eda92951
--- /dev/null
+++ b/drivers/thermal/imx91_thermal.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/thermal.h>
+
+#define CTRL0			0x0
+
+#define STAT0			0x10
+#define STAT0_DRDY0_IF_MASK	BIT(16)
+
+#define DATA0			0x20
+
+#define THR_CTRL01		0x30
+#define THR_CTRL23		0x40
+
+#define CTRL1			0x200
+#define CTRL1_SET		0x204
+#define CTRL1_CLR		0x208
+#define CTRL1_EN		BIT(31)
+#define CTRL1_START		BIT(30)
+#define CTRL1_STOP		BIT(29)
+#define CTRL1_RES_MASK		GENMASK(19, 18)
+#define CTRL1_MEAS_MODE_MASK	GENMASK(25, 24)
+#define   CTRL1_MEAS_MODE_SINGLE	0
+#define   CTRL1_MEAS_MODE_CONTINUES	1
+#define   CTRL1_MEAS_MODE_PERIODIC	2
+
+#define REF_DIV			0x280
+#define DIV_EN			BIT(31)
+#define DIV_MASK		GENMASK(23, 16)
+
+#define PUD_ST_CTRL		0x2B0
+#define PUDL_MASK		GENMASK(23, 16)
+
+#define TRIM1			0x2E0
+#define TRIM2			0x2F0
+
+#define TMU_TEMP_LOW_LIMIT	-40000
+#define TMU_TEMP_HIGH_LIMIT	125000
+
+#define DEFAULT_TRIM1_CONFIG 0xb561bc2d
+#define DEFAULT_TRIM2_CONFIG 0x65d4
+
+struct imx91_tmu {
+	void __iomem *base;
+	struct clk *clk;
+	struct device *dev;
+	struct thermal_zone_device *tzd;
+};
+
+static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
+{
+	u32 val = start ? CTRL1_START : CTRL1_STOP;
+
+	writel_relaxed(val, tmu->base + CTRL1_SET);
+}
+
+static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
+{
+	u32 reg = enable ? CTRL1_SET : CTRL1_CLR;
+
+	writel_relaxed(CTRL1_EN, tmu->base + reg);
+}
+
+static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	s16 data;
+	int ret;
+	u32 val;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = readl_relaxed_poll_timeout(tmu->base + STAT0, val,
+					 val & STAT0_DRDY0_IF_MASK, 1000,
+					 40000);
+	if (ret)
+		return -EAGAIN;
+
+	/* DATA0 is 16bit signed number */
+	data = readw_relaxed(tmu->base + DATA0);
+	*temp = data * 1000 / 64;
+	if (*temp < TMU_TEMP_LOW_LIMIT || *temp > TMU_TEMP_HIGH_LIMIT)
+		return -EAGAIN;
+
+	pm_runtime_put(tmu->dev);
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tmu_tz_ops = {
+	.get_temp = imx91_tmu_get_temp,
+};
+
+static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
+{
+	struct device *dev = tmu->dev;
+	u32 trim1, trim2;
+	int ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
+	if (ret)
+		return ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
+	if (ret)
+		return ret;
+
+	if (trim1 == 0 || trim2 == 0)
+		return -EINVAL;
+
+	writel_relaxed(trim1, tmu->base + TRIM1);
+	writel_relaxed(trim2, tmu->base + TRIM2);
+
+	return 0;
+}
+
+static int imx91_tmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx91_tmu *tmu;
+	unsigned long rate;
+	u32 div;
+	int ret;
+
+	tmu = devm_kzalloc(&pdev->dev, sizeof(struct imx91_tmu), GFP_KERNEL);
+	if (!tmu)
+		return -ENOMEM;
+
+	tmu->dev = &pdev->dev;
+
+	tmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tmu->base))
+		return PTR_ERR(tmu->base);
+
+	tmu->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(tmu->clk))
+		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
+
+	platform_set_drvdata(pdev, tmu);
+
+	/* disable the monitor during initialization */
+	imx91_tmu_enable(tmu, false);
+	imx91_tmu_start(tmu, false);
+
+	ret = imx91_init_from_nvmem_cells(tmu);
+	if (ret) {
+		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
+		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
+	}
+
+	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
+	rate = clk_get_rate(tmu->clk);
+	div = (rate / 4000000) - 1;
+	if (div > FIELD_GET(DIV_MASK, DIV_MASK))
+		return -EINVAL;
+
+	/* Set divider value and enable divider */
+	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
+
+	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
+	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
+
+	/*
+	 * Set resolution mode
+	 * 00b - Conversion time = 0.59325 ms
+	 * 01b - Conversion time = 1.10525 ms
+	 * 10b - Conversion time = 2.12925 ms
+	 * 11b - Conversion time = 4.17725 ms
+	 */
+	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x3), tmu->base + CTRL1_CLR);
+	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x1), tmu->base + CTRL1_SET);
+
+	writel_relaxed(CTRL1_MEAS_MODE_MASK, tmu->base + CTRL1_CLR);
+	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, CTRL1_MEAS_MODE_SINGLE),
+		       tmu->base + CTRL1_SET);
+
+	clk_disable_unprepare(tmu->clk);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_enable(dev);
+
+	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
+	if (IS_ERR(tmu->tzd))
+		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
+				     "failed to register thermal zone sensor\n");
+
+	return 0;
+}
+
+static void imx91_tmu_remove(struct platform_device *pdev)
+{
+	struct imx91_tmu *tmu = platform_get_drvdata(pdev);
+
+	/* disable tmu */
+	imx91_tmu_start(tmu, false);
+	imx91_tmu_enable(tmu, false);
+}
+
+static int imx91_tmu_runtime_suspend(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+
+	/* disable tmu */
+	imx91_tmu_start(tmu, false);
+	imx91_tmu_enable(tmu, false);
+
+	clk_disable_unprepare(tmu->clk);
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_resume(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(tmu->clk);
+	if (ret)
+		return ret;
+
+	imx91_tmu_enable(tmu, true);
+	imx91_tmu_start(tmu, true);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx91_tmu_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(imx91_tmu_runtime_suspend, imx91_tmu_runtime_resume, NULL)
+};
+
+static const struct of_device_id imx91_tmu_table[] = {
+	{ .compatible = "fsl,imx91-tmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx91_tmu_table);
+
+static struct platform_driver imx91_tmu = {
+	.driver = {
+		.name	= "i.MX91_thermal",
+		.pm	= pm_ptr(&imx91_tmu_pm_ops),
+		.of_match_table = imx91_tmu_table,
+	},
+	.probe = imx91_tmu_probe,
+	.remove = imx91_tmu_remove,
+};
+module_platform_driver(imx91_tmu);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


