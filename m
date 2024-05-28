Return-Path: <linux-pm+bounces-8240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A188D1767
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 11:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D201281E14
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC216A391;
	Tue, 28 May 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="iwSqXB8m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="jmiPrUhd"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2107.outbound.protection.outlook.com [40.107.105.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE5C169AC9;
	Tue, 28 May 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.107
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889312; cv=fail; b=WuNWqc3S4c7km0gPekU2JLxNqEGFdo1PP0nRcvImW+tQMsABT08caNczxYKD6agLlkiuJ4DoiVLq+5gek0GBtx9d2g0zqN+aRxiVfrGRMhxMpTMfgG42SI98OWOunkdWinftyvbhEPpVRCGFyTDIcCSdnHN6KpR95bTrj2QECow=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889312; c=relaxed/simple;
	bh=IFza1T4PGQd8KJrQvMtyq7KQHWXZWm45b9ZeNngchrE=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nfJ30JQMUa3A2EvM6Ydda0rISlBx+Teb/pju8hWelFp/CoxY+JK1/FpaKMaMQyxXKBIGi0fKbtxhaJYVuSOVb3q3bF6gNsFP6wn2MIc4LbEOgMaJ4z4nsgjfNh/oFiF2O4v5iDVeo8amQX0BsSJhdK3Tj536bMELEmilPs/4rkI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=iwSqXB8m; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=jmiPrUhd reason="signature verification failed"; arc=fail smtp.client-ip=40.107.105.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=YL8h5RxHZ6KHXnNnZgJNJxoz4ppb3uwIwuIaYF+r3wqkIx20rJcjh40Go8ppmj3BvoWj6rB96inmZtQ587rRBnSu2ORI5VNWr/pwlbIMAzE6f82RErl0nMblprDh/AKONrGjgupL/sg6PXIyIdXYxBI6z0dkXKAKQwwa7tswkSJffr2mmX3soZT8PiMV5eBwjzMCKTjYyzdoTxKOfv/ZafuobvppFPXXYr14dk6DO6StB7Ws62ydXFHpJVE+JcBfg4MyShVUGjm1sY38vfEOp/5OcIgvsAUd3YR1TcQ96kqz3EGTE65EwkME5YeKPcchUi7H6LzN7h1INHPerqUMnA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6knhIh/+RLO6dKKkDWAko3WfDipJ8E3vvB7njV/AaU=;
 b=ixTf+CeHDFcDmShA97YarrRad4JAd0YA0LNk21JNp7tpEPZJ6Lo6C1gKebev5XmzCCojap/4aX1EYrQoWq2wlpYP+pyaz0RD/iQRtOUDUoPAGDYIj8cTbdWobXWibRrjs/rdQg8sPaI4xErt1ooKiB3h7iUzIdQ0vuoSce8bzRklZWxMtMgo7YK1E4TBvh3+SQV76AHuDsUs9YVGLvbYob99rotNuCYR5tBxf2M+0qg3vkuLptMCQzedC2H7FdFgy0TK7m0FYLxvpOG3o4/knbDl+7+abaItKCGBxXZ92IXzbv3o7jsJ4K72WATv9dAE5C2dljgSnu++JHwIhDjcYA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=collabora.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6knhIh/+RLO6dKKkDWAko3WfDipJ8E3vvB7njV/AaU=;
 b=iwSqXB8m4EsrzdNCk9Nkc832WVpulAh5HYfYg3Y5axccnbn2jtyyMRTqj43LzQiapUy8uuuANeEvL9WCnyNNq3rst7pO4SVxP6cKPhdb/D78WdpwFw0CBB09oR+LhBZ15XxhO9TucHtx/hrfZR5qYJfMiuo8hy4E8f8b4HK10eELssek/MxKY5xCeshVjs69Rd6O4AxWm9fd8UNn897oEZ46/dHDwcXIDJln3scFOKcpskYukNBmPr6LukscXiEOUFp7S/4MsdlHdldo8xGELTShh7BaRWMkBOZqgc7AUIsLxwZkiU/EB6LYYeZ0ul48vFQcDpNJHAaYt3U3WmkuxA==
Received: from DB7PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:10:36::15)
 by VI0PR04MB10390.eurprd04.prod.outlook.com (2603:10a6:800:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:41:44 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::35) by DB7PR05CA0002.outlook.office365.com
 (2603:10a6:10:36::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 09:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 09:41:43 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.44) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 May 2024 09:41:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiRLqAhIT91vX1vyo0p2ZrUT+McJgubCuTx382Swcio1I9qPqjzwyqbroPhfABg3p+MXELGRuFaOH259RzaLcvcTYyE101A4OXYbedHocJN0BLyT9ju6BoB1ssHslAsjdgE5Ahu2C+25HvJMqg6qWeHNVLpjUvcq7wxaFFJdU66AmsacxT5QRhkuZdRiT30u7snaqWac4OHxQJ416u+3r7Qy50MNvHRVW6ijGYaK76Scw9yMThPqi57/09Duf04Ri05HbIwVnPyzhGTM3V8Q9fDzZkW2fgYNdAuQ8mpJn//BxtKd8Q3d5oCVxb+rrEclO2t5mSEqQ7v3J67sbtGVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t42hEKMcSdRixlfjWGp4Qb0JySK2nHk+gvvo9CqKVGg=;
 b=VYCwYT0K/DYzUJl/31sLQxHDiOprhgMqKsSkHqrqMKXzQRsZpcTDG0HY4oUZ0+Caaa4ZfIF06Z2kM2GvgBLPRHw7j51RFCX3vdZ1RqLxCzC4L46PXbvKHIF1S4FtPQenrcF3oOo+CVot9v1l5aixx4qtOp05NwMlbwKRyZqv0lDx0xoWF+EM/6Uo4j1jxwkKcUngo5lVxSOpIAkbox9b0Hc5+xQU3/hizKTsTgFLsZiocj8nVpIGO9JjlvFjJpRoZSkxRkmf/pWkjoOw2H84GHKWyE8I4wu+8eehd4lglQVVhMza+atfHKaj4TqW8fnKVaD4Q8qnw4KI92G8rFuwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t42hEKMcSdRixlfjWGp4Qb0JySK2nHk+gvvo9CqKVGg=;
 b=jmiPrUhdI7iU1qjpL+sWs8k9m2J+++1AViO2JsyZmp3saNqS/I/A+Oy0N6BLp46osALyHXjvPrfLHVUERYORFm3/Gyd612VI7NTibNCh++jA3GxtStQFG5WNb/HDFvFT7ni1ToI9Zb+tVOv6TeHYuZUu1SlSvKCpRQ3PuM8D70cLOf6M9v6lPtS/qYdqUBvhXjNKyLQBmcbFP2Le+YqhjNuUU5QRIvvURncU1ztH4lOFeNbakNkTj8duk+j9L+CvmYoNYw0er477kBYXp0AEfm5PEk6u4GUzGWLxxUhgTVqkAMBcxkDp7UHCTlKyCWtz8TXdoIF0X8wPAgSXOfDe7g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Tue, 28 May
 2024 09:41:37 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:41:37 +0000
Message-ID: <fb93cdd9-0c9b-4cb1-91c1-ccf832fcba75@topic.nl>
Date: Tue, 28 May 2024 11:41:36 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v5 5/5] power: supply: ltc3350-charger: Add driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416121818.543896-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4a7cccf3-e7cb-4980-be8e-de8bd2795354@emailsignatures365.codetwo.com>
 <20240416121818.543896-5-mike.looijmans@topic.nl>
 <t4avn7fmzw355a73hu3yu4wzdxyc5gkupi5s4yfio5iyiygkx6@5eubzdbqthqx>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <t4avn7fmzw355a73hu3yu4wzdxyc5gkupi5s4yfio5iyiygkx6@5eubzdbqthqx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::12) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DBBPR04MB7497:EE_|DB1PEPF0003922E:EE_|VI0PR04MB10390:EE_
X-MS-Office365-Filtering-Correlation-Id: 68da24e7-f02e-4213-2b45-08dc7efa6273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YWRoQlB3d3RBMGM1Y2pXRFp6TFppeGdCczN6WE9MZXBlYWs2ZjN1MW1ad2ZI?=
 =?utf-8?B?OVFjYXl1S1NpUVdEUVdjWDhnSTBXVDNMMk5xMFMxNE9GOTVEa1hSbDd1cnBD?=
 =?utf-8?B?ZHQwL284MWZuQUZJY2tuUmdqZi9aK0E3bmV4elU3aGlqRnU4NWdlbHc4ekdr?=
 =?utf-8?B?eWhnQkd1RElIRmFHSldHMi9oeDd2UmdIYmpRRlV2K2k5bVNEcWk1SS9tdVpR?=
 =?utf-8?B?VUVJSEJNbktUTGpiRmxOL25RMndhQVZzcW1WSnZhS0Y4N05pOWxZTmd1dFV2?=
 =?utf-8?B?bUMrZzVqWStaMGtVb29hVC82dmRCQ2FhV1duTWUwN2liQVRzSmZqMzM0UDNG?=
 =?utf-8?B?N1NLKytuS21ndkh0UHdUenk2TkNVc3FPRnhqZlJTbkljMy9PcGNIUUN1eUg4?=
 =?utf-8?B?NFluQ2NhTmtVc2JUYjM1elV2MDRVeXdFM0tPM1d5TkZhUG40QUdJT1BqQlRV?=
 =?utf-8?B?b3ZQK3NPdFVhdkU5M3BnZm41b2VWNlA5dTFiU0FWZlU5YzZwUm9pWFVyTGNv?=
 =?utf-8?B?K0QzVnhkYmpNczQ3ZGllL3QvUEZCTVpETE5tV3VIUnV4N3NIU2JSamRFYi9p?=
 =?utf-8?B?RHNVZ0tPQ0gwdzdKNmZaa0VaRUVLdzZMdFFldGphR3B5bGJadmV6Z01NbjFo?=
 =?utf-8?B?bnNIcTZhL0VWQno1T04zY1B3K1pORUhIbTJCbzg0S3FEdVMybkJ2THdUY05p?=
 =?utf-8?B?Wm8wQWlxTjJYc01nRUJHUkg0VkZoeGd2TDZsWnpkbEo0SUY0cWtJRS9lUXEx?=
 =?utf-8?B?Z1FsSGdxSFdhd0k2MG43a1J0b21oTlpxdmFnZzF6RnpBTmN4S1RlQzdtRXlW?=
 =?utf-8?B?S0FUU3JxK1FYUXVaQ0hiV0tJTUxGZFJncjBaNmpxNnlDRmRFWlBsZjZaOVN2?=
 =?utf-8?B?dFVHci83WVpZV25Nd2xyZWwwR09HM0ZHSkg3OE03RGFvT29kN1FmVFozM2Fu?=
 =?utf-8?B?WWY0UlFHOFdtWnRrRHFWWTgyZVZ2V1JpRzhzOFhCNEhYWUx1YjVoSitkWnd3?=
 =?utf-8?B?SlVQSWIvZzJzN2NWNmpSMXZZSWVvNEJsY0phN0FRQVRoSDl5dmErT2N5MVNZ?=
 =?utf-8?B?WGMrMFdncVlRZjRSRVlSTlBsZmxaVU1GdDNmK3RqL3hSSW1pTzlaZUdJT09u?=
 =?utf-8?B?eVB1NFJNM3FJRGFBMzQzNkx2TkF3YTFqMVNnMFFQemhpSHpRM2lhcjFOaFNH?=
 =?utf-8?B?UXVYT09rcmJxWHhPZTdFQzd0Y3J6ODFXUmdud2JOK055L3Rrb0FvWG1ZRHVo?=
 =?utf-8?B?d3BGdjFjS3p6SGRvVFhYbXQ1bHdNRDBRM3I3aldVcHpaRms0MlVpWGtERVE1?=
 =?utf-8?B?REhhMGtkcnB6RTlac240YnV2bWpoZDVmRGRZd2lsWE1JNWI4Y0RyTjZSME4z?=
 =?utf-8?B?NmZOY3dVd0VHbFRKMXVpMUZQSmcxTk50OHFDb0tqLzBEWWZPQzJHeU5Peld6?=
 =?utf-8?B?MTMwWUdCc1E4YkhCQjhiS0ZHc1FUNjdtMUtqcFQ3VDFpRkR6TmVmNHFPcWpo?=
 =?utf-8?B?MjV0aFRxTHcrc2V6d2t5TmdHUHhLUnRqRHliUWYrTExCUCtxTGd2NW1GTTE4?=
 =?utf-8?B?YnBQbDFFczE5aTMyc21TVXcvc2FxdTljT0IrWE5IVXhuUkYrZUxqSzJPL2tK?=
 =?utf-8?B?TGxXRnVVaDhnc2pManFhUm0xZnNjejR1ZE4zQ1ZVbE4ydzd5UU5PL3VWSEtH?=
 =?utf-8?B?RHVGTzI5T3dZTlJ5THFLNFBUM3NaOEpiYlB5MXRBaVFtN1BQQ0pYQU5nPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7497
X-CodeTwo-MessageID: 2615836a-9f5c-4c6b-b573-cb96acf2d463.20240528094142@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fa8f46e6-ce15-4573-ffc2-08dc7efa5e90
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|35042699013|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnFkSzljNVdUMSs2T2JlOXdtL05iK1krQ1RyKzJKUEEzVTdvWEZyb1FCaWVw?=
 =?utf-8?B?VUpLcUlMOXhYNnV0UnIwZCs4ejdMR251MDNYQXNTcXB4c3MxNU9CbW9zWFFH?=
 =?utf-8?B?Z3M4UTJhMHE3Q2FNRTZPaXNQSmQyY0pzUlZpSUR4ZVBJTzhTdlBLM2h5YzRq?=
 =?utf-8?B?V2xmbUwyU20yeVZOa1FuYlVsRG0vNW9Vc2JzZDVwSkJYOTErRmNzV09GUFNV?=
 =?utf-8?B?OTIxbXRRM3B5d2pOckNsR0RtQ1JPMW9mMFZuZ1NiSmdmZ2g1MnY0ak5RNTF1?=
 =?utf-8?B?aXZFQlpLNkhMU2tlZmMwcU9XMm5sSFlBZzJxTmhYaW5VSEpmaWExWm5sOFNh?=
 =?utf-8?B?QzVFNlZsV2k3VFE5dzRpaHV5djU5SDBUbFlPVGc4ZFk4WTJRUFI5MzZsT3pq?=
 =?utf-8?B?cTBKZ29qNTZsU0ZrbnNFbzJYVDNKQXgvMXZkUHJZN1NsRDI4aE43QW12RjZZ?=
 =?utf-8?B?NGNEZFc2aWsrTTNJRnhtWUhOWi94NVkzTjVDbGZBL2NNQy9YYlVyV3FuOFJE?=
 =?utf-8?B?S3hpR0h3Y3FuS0szQ0dFYWxNNzFDUkRXeU5tL3NoOUY0c0pYMTlrMkJBK1NB?=
 =?utf-8?B?QTBUOFhZYjF3SklpTlllWVlITVdldUN2L3BxbDFTN2UyRjdxc1RYZU9nTm1r?=
 =?utf-8?B?dkIwUlFmSUVDR1BuZTdKNGorWnF3bEdRUjh5YU5iN1U4dUhPbGtOVlZKcDBL?=
 =?utf-8?B?ZXQxM1BXTU9ncHpETWNSeUNqUHRla3M1TE14eVdhWGJseVVWOUJNek5GODZr?=
 =?utf-8?B?VWdmaFk3M2VZamJNaVJsaGEvcjJOMmxZS2s1TEQxWEJzN3FRcjB0U2c3YTF4?=
 =?utf-8?B?TG5DL3FWY0kyQnJITmQxOXZPRkpxSjkzMExJRkFWSEVUQ1V0d1MrYkZGcnNS?=
 =?utf-8?B?b1BlVEd4eitwMlhXZW9JUGUzTUdmcFJuRnVqcVBKQWU3Ry9WSjNLZXFlaDNt?=
 =?utf-8?B?SXdQUkp5bE9vSmVMT1ZsU0NSMVM3bGtMakc5aW04NlNjWTVQVlFURFNnVG0y?=
 =?utf-8?B?WG5ycFk3bUc3bDZtTU5ZbWdsczZqL2tFZStjK010ei9nbXBaZHhWalpNQ0ox?=
 =?utf-8?B?QitMRTN2eFZkcWp2Zm8vL1hLMjEveVZtQnJSUVRXWFk2NUYzLzZXTVg0THlV?=
 =?utf-8?B?Zy9NZU1GV3Q0cXFVUDdJYVNyb0tjNDRneTFHV3hMeFQwbS9RVm9rYzk0SG5X?=
 =?utf-8?B?eFo3M0IyUldld1piblRoY3BHbFltMVlsM3F1eEk4OGo2TldpVzBpQ0ZyemEz?=
 =?utf-8?B?dHdsMzZZNkE0Q2hlNmJhK001Vm9FTXJ1V2NBdnVEa1FvQk4vekF6TFk2QUow?=
 =?utf-8?B?citFWlpUT1o1bldiUjVqbkZscWFGRjAxdFViMng5VWhqcyt0b29jUXpvaTkz?=
 =?utf-8?B?V2U1aXAzZSs3Y01Rd0o2cW9jamhCMWtra1R1WEhrWEU1WkhORUh3Mjhmd0th?=
 =?utf-8?B?akw4OUNMeHlyL0p6QW1zaGxTNUZlRFBLL09CeUlTYlJkRmMrVlF4NUlCbDk3?=
 =?utf-8?B?ODhLOFlucUpQNk1aMGVDUU1UYTkyQzI2KytDdENwdFQzZVFDMk12MktSaGZB?=
 =?utf-8?B?RkgwZ3ZqVGc5SnJxcXJRUUlmLzhNcVpaVTd6ZHFlNFJxaHpBY21OTDZlSWZP?=
 =?utf-8?B?bFVySGNZTjVWVWpveGlFQXdIRWJldmdoeG9vY0hiZ2FlbkM4djNBdlI5azA1?=
 =?utf-8?B?NjNsWnZrc1BsYXVib0ZyNC9SeFhHR2R0UzRBUlJDMURqdlBCUEs0MzNwOVZK?=
 =?utf-8?Q?lTo8uyICZBQex1zDsfTbX8a5xlC4Jdx5DiNvk2o?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(35042699013)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:41:43.7625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68da24e7-f02e-4213-2b45-08dc7efa6273
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10390

On 27-05-2024 22:40, Sebastian Reichel wrote:
>> ...
>> +static int ltc3350_get_property(struct power_supply *psy, enum power_su=
pply_property psp,
>> +				union power_supply_propval *val)
>> +{
>> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		return ltc3350_get_status(info, val);
>> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
>> +		return ltc3350_get_charge_type(info, val);
>> +	case POWER_SUPPLY_PROP_ONLINE:
>> +		return ltc3350_get_online(info, val);
>> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VOUT, 22100, &val->i=
ntval);
>> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
>> +		return ltc3350_get_scaled(info, LTC3350_REG_VOUT_UV_LVL, 22100, &val-=
>intval);
>> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
>> +		return ltc3350_get_scaled(info, LTC3350_REG_VOUT_OV_LVL, 22100, &val-=
>intval);
> For USB chargers VOLTAGE_NOW/MIN/MAX refers to VBUS, which is the
> voltage on the USB lines and thus the input voltage. From my
> understanding of the LTC3350 this would be VIN and not VOUT. With
> VOUT being supplied by either VIN or the Capacitors.
>
> So I think your custom vin/vin_uv/vin_ov should be exposed with the
> above properties.

Yeah, power supplies report their input voltage. So this should report VIN.


> My understanding for VOUT is, that this is basically the system
> supply - I would expect more regulators to follow, which convert
> it to typical voltages like 3.3V or 1.8V. In that case it would
> make sense to expose VOUT as regulator, so that it can be referenced
> as vin-supply. You can find a few examples for charger drivers doing
> that for USB-OTG functionality.

Looked at other drivers for that. Significant difference is that those=20
have something useful to supply to other drivers, e.g. being able to=20
enable/disable the output for one thing.

For the LTC3350, the output (voltage) is just a measurement and there's=20
nothing for the driver to configure. Any regulator_ops would be=20
completely empty.

Given that, I think it should get the same treatment as GPI, so either a=20
custom property or some other device (IIO). Or maybe add a VOLTAGE_OUT=20
property? It's not uncommon for power management devices to report their=20
output voltage.


>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




