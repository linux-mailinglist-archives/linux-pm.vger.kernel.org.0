Return-Path: <linux-pm+bounces-8216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC08D13C9
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 07:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA192843C3
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 05:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951574AECB;
	Tue, 28 May 2024 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="zQSSFDGn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="lVeeXplT"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4D4F5FB;
	Tue, 28 May 2024 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873530; cv=fail; b=r4cSc1M1cUAh+1/jHswSqPn4/LrkQp3Rb2RfimtskNQ6Y54CD70X0uGM/cGkIKvNLJioh7mqjaZVn5vOtl2Lm4jFZvpuSPhU2AxZhutFPqzJm+ViljNNsu7NpdcqKC5bU1wCYCkb9L0+ec/jffoqkGrtVST4WUuxnz1peMPZguc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873530; c=relaxed/simple;
	bh=qfG5/sKhHOkwJOK64LYnrtuAOBr+i+KubMMT5gJq4D4=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PgsPBKNh275dQfbijbd8HXd+sYUNP2wyxXgMu6jmib3af9Ojc59Blxcfzic0OlLkVuL7zu4/f4xZo1hFxEllFDps+xc9ADdQLCIDQuTI/8l9BuTBxG1jAovOM3pQj6XVJjGH1bemMiCR0IGcKcL752SoVl7FgF0W4q9r26FOhE8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=zQSSFDGn; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=lVeeXplT reason="signature verification failed"; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=LVmazq/gu+u8Agej9gsuGfPcA7Z1jZo6rnpzfpHwGZlxoIa/KrvWeyST1qz7gE5S3TIO2lMDpQ5OAbWbKBDuvbnP1OhvZ5S3tsj2k1mM3P5ExLQSNBN80BthrF6LBm0SLfkILqgTdIPMbUO+kYza/Pzv+I86B4eabN0GtORFrVJ3SYI3Q49wMIm5LpmRrBPzx4Sv91l7rqHnDHndktRyIBCpXEPy1TA9sXFBDlLI1iKCPCXqAJGjIp/lwv5rd3ysWq2RTJcC+tJPo/57V0cJWAsML1Bu60AQQqljsfB9CpUvN8wudD1gApwmoCaeR/eUU8nmna7U2UyxjG8BH39UGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP2mDxsfe5NN4CW9pJPf9WX1YZfwRvrtscqDo9bsSzQ=;
 b=Mg23DFw1HL5w5VEawCEyAN4Yl3npokilqJXVmnrhs53qc1tqC5xmO5AxGDCarlcpNcNRlsypeB51/DJ2/iUfQc19cJr2rMXjAibnP0X7E9Pv6KpAj4Akv4ajpOqLyy0abH4w5yCJ3tpqnLYMioga+1pS2zsUiUOGPvh7HgxkkQTo03Y0t0kXqHzzSChzaIb6136sjEaPJ9hhpdycoo6QtqgwzjSR1SS55NKD1oYEpPQ6gilHgAK1+uWGEoQNcDyPCE4fiLvn4lwn4a+jVZoxLGihu+Ssy+AxLhXHeNFKv71JYN/Nvuhz8Q+4ubvXf/MQeKs16cJHe7fPD0w+huwWIg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=collabora.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP2mDxsfe5NN4CW9pJPf9WX1YZfwRvrtscqDo9bsSzQ=;
 b=zQSSFDGnsXuoITaGTDZO4ntM/+3WpFv+ao2ruIp284kqcAnQO9brm7O6LFDmi2k/dTT+M9OEQXZ7OunB+ffzaJ15OnuOq64RekF9dSx8+xiQqKFFJNNiIwQlNiYj++xyR/hH9JmMxpe5nEWAwcYsaQNryCOItE4i35Xy5Hk81ci7hnmS6FU0tXSuJtCulOSYLophJk3Ps6TuvOg/qGz+4QaYVMB07xg30CpmkV59dH/ig1x4kNCEr5+VlqkdzpkQlSx+Suo2lEuNYF5pRELub6EmIfa2ihCQo2F0cyMGOPPquTF/CXTKQdHrUZ5vSo9ueK5MPXNjJmLCoxMhVx61Hg==
Received: from AS9P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::28)
 by GV1PR04MB9199.eurprd04.prod.outlook.com (2603:10a6:150:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 05:18:41 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:20b:532:cafe::9c) by AS9P250CA0022.outlook.office365.com
 (2603:10a6:20b:532::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Tue, 28 May 2024 05:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 05:18:40 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.40) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 May 2024 05:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW0yGKeG1XT7UWC/QelKhBHDag8JS6B+/j1o1dgQQKbKnETvavt81ZDAecagkOz1E0L6Emvobmstlcu8E5JnLg3Vio5NrZ7Qpx4uXTQqcy4kwNl0Vmu/AvChPKY/C9aAydKrQW/iWO4J83GNYaOWFxGmH0QbEse9xL5+cC0nLSUgLXYVg1PGC+yLkbJQ1HB6G9WMpEhNgXTEtuftf6FbXF/Y/1aX6VGcDmnRrT+yPv4ZwnPiHA+cJeDj8pUK2sp2V/vuPvxXDNd9PSmcjUx6y9vZLaz2Lrs42Xe5g6aLm9U2GqqXOyL/uAb4lKw31kSphtzxhmFPk7nLPmSwIEVbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eg/+iKRJzrVFE/AJzcLAXuaEKwsK6FOQUAkxW2aNrA=;
 b=EJILEy8Id7nlJNI+oufSI+BCGURvSw4phZ2KXiLZ4mNwOqZXSTWiybec7ueKiPwdJNOh0S3swqaPOTcVyhaJ9TIx9RsLBroup1XH8pEsel37+VGQi6+qrEJXF+c8daomFvvOSt21L31OT99m2A93Kz1xOhlwuBpxxJVd0E//ZOToKFG1CDaOIbsQtR80FXw7dwU9B+zMNJZot+210YZWhs4Cz9VEzHtIRw4R0HQnp8DBRCmlZX52mREvWEBQD55Zug5ja11RzlM2WGecoJPdpfy0qjbWHvSi3KjyYZnuV0vBTHQOPOZZHnnBNJ+LQcinpYmitffQ1QV/p0MwnSF9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eg/+iKRJzrVFE/AJzcLAXuaEKwsK6FOQUAkxW2aNrA=;
 b=lVeeXplTA4LeOnpxY7Wrfw01qB7bhjNIBe5ZokhwvpOFFblNMa9zYKGvZ5nGP9iynEvReKcGOWxpDuM+jfsBhy6QwztiDIvEYVc6/Xo/epc80ywGnXhf9Iu/n56hQiy3RnvcUbPXmxKHcjfbFD6V0PpayoYLnEpW58xuxth0QisQX58B9wFGYKnOttqIJsXlVfty9TgeyErgVrHkLxhXu0Z5QlexFPigI1BAAYE01ooheXdrS1wFiJNAbNOYI/bsAfnmT0zCRQx6TZ91DHx9D/RxnSOTMZo9qBtlt8Ea8mD0OnA3NsRyEgm0TvvjIqQzRwnDY9tMCPByYY6ctRUG9Q==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PA2PR04MB10130.eurprd04.prod.outlook.com (2603:10a6:102:408::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 05:18:37 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 05:18:37 +0000
Message-ID: <1468f494-8c36-4ffa-985e-6737bcd9e13d@topic.nl>
Date: Tue, 28 May 2024 07:18:35 +0200
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
X-ClientProxiedBy: AM0PR05CA0079.eurprd05.prod.outlook.com
 (2603:10a6:208:136::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PA2PR04MB10130:EE_|AM1PEPF000252DC:EE_|GV1PR04MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f902206-6e25-4c31-1b29-08dc7ed5a2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V2M1a1JkYzN4MllicytTQ2R5UHBYVUtPRG5Ta3BIMko0KzdRTU1lNlZCY3lQ?=
 =?utf-8?B?WHJSWDFuTmxiUWRFTk1XZVhTVXhHZ2tUK21nNU9wdVdQYUp2QU9BdVJJelhX?=
 =?utf-8?B?RDdHdldub1pjVmhLQlA2K3czWFlPdXE4aFhVbCtEdERuOXptQzRjM1ZCMHQx?=
 =?utf-8?B?ZEpkc0FKaCt0OFdCc0xna3k3Y3ZrMU94M1RKdml1ZEVPTjEzSDFPWGw1Qng1?=
 =?utf-8?B?R2RjSGpWbnpNQ0ZZLzNONStha0ZRTzAzeDFXbWxmVDJWKzNJNDRYdE9pMDA2?=
 =?utf-8?B?aDRudXlLL0pDZUZNcG40MWpFL0VZYVpjK1RjZFpiOXd4NEc4WlJpSmNWNzBT?=
 =?utf-8?B?c1Q1QWV5UGpvbU9OQTZDWWw5NEpxLzBhZTJHVktqWkRxNXd6N1pxU0NIeEpO?=
 =?utf-8?B?YjVVeDkzVDRvc2RZcWJyazIweEltYmNBb0dEay9HdjRWVHhyNGFtV2xCVUFT?=
 =?utf-8?B?eHllM2Q1eFBsdjl0c3dWM0JhRXlmT29oV0xPYW5LN1VzUHRsSUsxQWxjWitF?=
 =?utf-8?B?c3FFZDk3eGprWTYweGNnZ0lLT0lYZkxiSlM3Z2FSSjcxUEFJRDFINTVneWgw?=
 =?utf-8?B?N3R0TGlVUlloSnpSTmJpT0ZNN3J5TVFpcTI3QjlVVm1EenFsWFdkd1RYK2xH?=
 =?utf-8?B?MjRZdTcvZjcxd2VVOHVrYmh6eCszSnBxNkRZT3pTR056aGI4d2l5aXN4U1ZK?=
 =?utf-8?B?aE50T29SaDlmNjRTUjdHQUk3djhISGg3a0IxQ3FxQ0FmK0pBTDZ6T2tvSnN5?=
 =?utf-8?B?WmcxQ2xTbnh0Y2VQYTdFQzFnWWE1VTdFLzFhOG5CK2dEMENZaW1uOHpUZEtn?=
 =?utf-8?B?cTBKM3Fjck1vOEhFRTRvU0t1MjVMZUE5dG1ONDFxVG5rbkszaFlQUmoxZFUx?=
 =?utf-8?B?UEVOelQyMFNwNTh2dzlleFVHMUFpcWNhc0kzZDVVOEgvS1MzY2JFUWI4bUx1?=
 =?utf-8?B?OEYyY3dHRlFNRDJKVVZJRTExKzMwUFovVmxPWTZuUll5UnBIeUt3UjFsOGcv?=
 =?utf-8?B?NWlac21vbUkwT0VzZUl6cjNmb3lMdXFUN1FMeFduL2w2OVQyOG9IUFdjOUpL?=
 =?utf-8?B?M3VxMlJpYlJGVFU4VGNQTmR1bmsyTUVZWU03VkRPUW1uZUhCSU56aFNuYW5x?=
 =?utf-8?B?MFMxLzhOK3JSblFuYXp0YTB5eDNJQWxMQzRiMXdPejZUSmRwck1FVm1ZUTlx?=
 =?utf-8?B?YlBqeUZZZDlOanJ3MGdnem9rQXJUemJ5VXBEWmMxMEFjTmw0cFliSWdhcVJv?=
 =?utf-8?B?eFBvakdYelh4VndvRnNydGhxelBVaElnbEV4VTZnL1JlRXExNTV3ZnUzR05F?=
 =?utf-8?B?eWZTTUoxRTYzd2JLUEw0VzM0RHVXWUgyd1FqQStzV3F1dXNlNFE0bnZiRWJF?=
 =?utf-8?B?RnZHV213VHhYNHpma0VHUlgvK0hobyt1RXk3aG1PTHloQytkVUpsS1p1bDlw?=
 =?utf-8?B?RHg5bnFOWDNlZVJXa3ZLcUZtL1BDdDJHOEppZDBZN3drZnA2WWdCa0MzQVg3?=
 =?utf-8?B?Tmw2WDk0UXRsaDBpb3BlczEyQTcvSldBMXptN20wVVcyRzFFNkszeDduUWlS?=
 =?utf-8?B?dzBwZnFtMG8yV0N4QllCQTBqVXRzQ3c2aGlOM3pPSTNudXN5V1E1dndzajY4?=
 =?utf-8?B?dXN6dk5kWTBjSCtPaUdyZnNaWnRmVk9Sc2UvSnZ3UENKZUUrbE0vMjE1WjVJ?=
 =?utf-8?B?MlRIMmpMOWNQNTdWT3U1ak5IUWZ3bkJ0dXdOY0ttRlEzRlpITVFGU1FnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10130
X-CodeTwo-MessageID: c75d00d7-138b-4d81-96ea-967301dfe4f2.20240528051839@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d02bf31c-683c-4207-e37d-08dc7ed5a0cf
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005|35042699013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1RaVVhNYUhkRWt2VjkwakRNQkpKK0hGQkkxalVQNVlPSWxEOVpnY2RCOTYz?=
 =?utf-8?B?aUtjVTNJZnpwUTBPdlE4cVdlZ3p3QUd6Qy9ZMU5XbE1jcjhWMXpKUWNrbGE5?=
 =?utf-8?B?R1p0WDFsa253cmhTbzF1bmlWVWducnRjZldzbDlVUnpFQ3BrWFBSS0xxRm1M?=
 =?utf-8?B?MW1uV1VmOUFDTHkvWmlRWFh6NE52ZTMzZWlzYkxlZ2xOdGpQNFp4NUxBR3pB?=
 =?utf-8?B?c2VUWUZWWHJKa0FBbVBEV0hCMWdyajhYd0NDZlU5Z1d4VlhDb04xNnB0T3Ns?=
 =?utf-8?B?UVQ2a044bVliVzkybldHNUtjS3RCRnkvN0c2a3JScTA1aG1Ic0YyVGJUOWhO?=
 =?utf-8?B?SnF3cUZHUXlKd0hJRG1pVlFPS3I5R2FDL0JlZmgxdjA0SmFaSTFzaEd2dzdO?=
 =?utf-8?B?TFZqVjdwc1EyMngyZUNNaFVJMENTSVRVSnBHQkhwd2RrY0FLOVFWUDB4TjVl?=
 =?utf-8?B?Y0F2aUE5WGxNN3pMZU1CSW5UZ2ZpY2diMXVYNlhVcWhVbHBFNW45enVyd0gz?=
 =?utf-8?B?TzNzUGsxd0VGODZSNUVweDBQVDB1TC9ER29iRmUzZ2tEZG1LanFEd3NmRkIr?=
 =?utf-8?B?MklZc0RJNXJSdVVKZTlYZzNsbVF4NXdRaGszTUpSbW9mYnVpS3VEQmtlL3JJ?=
 =?utf-8?B?eVp3SGE4bHE2Kyt0MElRRVlOZ3M0NFcxWkZ2RC9DY0oyZnRCanMzelB4bjFJ?=
 =?utf-8?B?UGl2S1N3L0JSZGhadkp0aUk1NlZUK2F2ZGxOclJxTHVDSDhuMEtwcVc2NzE5?=
 =?utf-8?B?dkJhcjhSeXcrK0hwS3kvc3E4ZVJ1MWRFOGJmUStRVGhzZ25DaEVSS3l4VkJN?=
 =?utf-8?B?NTZPRVdRY1FYWXBhdlRwelpYZWxVZWw2ditUbjRTQ3gxQXdEMFRlNUM2S1pi?=
 =?utf-8?B?ZGJxZGdxTGVJdkdzNStLVjhiUm5nMC9PVDBxbGIyNlJHNFBPTW8vYk5HZ0lE?=
 =?utf-8?B?V2tyenpDdTVyV0tkTTZOWFpRbzNsaUJuVVFWdzRHVTdVS2cxaTRWbXFzS2lp?=
 =?utf-8?B?TWJoMGVITUx3ZmhXR2R4a2UvMjgxV3FjT0tSWTJNV1BWTHlhYUI1bTVKMk1E?=
 =?utf-8?B?MG44NjBGK2VJQjhSeGRZalRaR2FPazFScW1vWlphbXc2SXVTL3U0cEtSSDZx?=
 =?utf-8?B?Rys0TlpBU1BFRDB2NUlTK0JoQVFKc29qdkFtKzRabXhGTmNwT0RSWVRPcDg1?=
 =?utf-8?B?MW9aLytra2prL0dIUHY2M3VodmlRVER6R2JWTzNseDFUbjZKMDZHem5ITlJ6?=
 =?utf-8?B?S0tNclhDOTArdHFPQk9sWlBoeFA1TmdXUWdGdWFvcTVtTjYzQ3NLVFpkYVBn?=
 =?utf-8?B?cC92Q0JjTlhienB2YXVxaVBJWW53VFNpNXdnUktlQWpPSkdRNzNEUzlCZ3RD?=
 =?utf-8?B?aG00RVkyL01jSEdSa2diNlV6eURiZXEvZi9LVG5sOVk2djBLLytEb1IrRGdx?=
 =?utf-8?B?SlNXWnRpYytaaHRJNUw2ZzE1alJ2YUdQWnNNcmtibm0rbGtiRjhpZVMyRWFB?=
 =?utf-8?B?bXN3YmVrUGlNU3VUMUZnVVdibmVTNldkSk4vS0Rxd2NoRE9nZGVGYkoyNUFW?=
 =?utf-8?B?Njl5Z3dvOVZvanZzMDBQR282MFRpU3VLNC93L2hHT2lrVWRYSHBUTHREbWFz?=
 =?utf-8?B?ZHVxMm1sakRZa3FseUpVM0owSFV5bGJiSk4wUmZvYmtkd2lkMTY5bThaR1JY?=
 =?utf-8?B?Z1lpTExVVm43emhzY1JMMVZUMXRBMytKUzdSeUl4SkNvNU5PTitvbTViZkpO?=
 =?utf-8?Q?mq6G1k4oB0N0qH3DLOr6rwfdYpeiUh6C0YI7rBd?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005)(35042699013);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 05:18:40.5906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f902206-6e25-4c31-1b29-08dc7ed5a2eb
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9199

On 27-05-2024 22:40, Sebastian Reichel wrote:
> Hi,
>
> Sorry for being late with reviewing v5. Considering this adds quite
> a bit of new userspace ABI, I did not want to rush this.

The project is still ongoing, so I can spend some time still.


>
> On Tue, Apr 16, 2024 at 02:18:18PM +0200, Mike Looijmans wrote:
>> The LTC3350 is a backup power controller that can charge and monitor
>> a series stack of one to four supercapacitors.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>> Changes in v5:
>> Fix ltc3350_set_scaled() arguments in "store" routines
>> Measurement values are signed
>> Report technology as "Capacitor"
>> Report "full" when "capgd" asserts
>> Move charge current to "current_now" of capacitor
>> Add ABI documentation
>>
>> Changes in v4:
>> Split into "charger" and "capacitor" parts
>> Use (new) standard properties
>> Header include fixups
>> Explain local "scale" units
>> Drop i2c_check_functionality
>> Use dev_err_probe
>> Use dev_fwnode
>> Drop of_match_ptr
>>
>> Changes in v2:
>> Duplicate "vin_ov" and "vin_uv" attributes
>>
>>   .../ABI/testing/sysfs-class-power-ltc3350     |  88 ++
>>   drivers/power/supply/Kconfig                  |  10 +
>>   drivers/power/supply/Makefile                 |   1 +
>>   drivers/power/supply/ltc3350-charger.c        | 789 ++++++++++++++++++
>>   4 files changed, 888 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-power-ltc3350
>>   create mode 100644 drivers/power/supply/ltc3350-charger.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power-ltc3350 b/Docum=
entation/ABI/testing/sysfs-class-power-ltc3350
>> new file mode 100644
>> index 000000000000..d4a2bb0fb62b
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-power-ltc3350
>> @@ -0,0 +1,88 @@
>> +What:		/sys/class/power_supply/ltc3350/charge_status
>> +Date:		April 2024
>> +KernelVersion:	6.9
>> +Description:
>> +		Detailed charge status information as reported by the chip. This
>> +		returns the raw register value in hex.
>> +
>> +		Access: Read
> With regmap you should be able to get register content via debugfs
> for debug purposes. Is there any other reason this is needed?

Not really, and it turns out we're not using it either. So this should=20
go away.

>
>> +What:		/sys/class/power_supply/ltc3350/vshunt
>> +Date:		April 2024
>> +KernelVersion:	6.9
>> +Description:
>> +		Voltage for "shunting" the capacitors in the stack. When the
>> +		capacitor voltage is above this value, the chip will discharge
>> +		the excess voltage using a shunt resistor.
>> +		This is typically used to limit the voltage on a single cell,
>> +		to compensate for imbalance and prevent damaging the capacitor
>> +		while charging. It can also be used to forcibly discharge the
>> +		capacitors.
>> +
>> +		Access: Read, Write
>> +
>> +		Valid values: In microvolts, defaults to 2.7V
>> +
>> +What:		/sys/class/power_supply/ltc3350/gpi
>> +Date:		April 2024
>> +KernelVersion:	6.9
>> +Description:
>> +		General purpose input voltage. Returns a single measurement.
> I think this should get this extra sentence:
>
> "For example used for temperature measurement of the supercapacitor
> stack using an NTC thermistor."

ok


>> +
>> +		Access: Read
>> +
>> +		Valid values: In microvolts
>> +
>> +What:		/sys/class/power_supply/ltc3350/gpi_ov
>> +Date:		April 2024
>> +KernelVersion:	6.9
>> +Description:
>> +		General purpose input voltage overvoltage level. Triggers an
>> +		alert for userspace when the voltage goes above this value.
>> +
>> +		Access: Read, Write
>> +
>> +		Valid values: In microvolts
>> +
>> +What:		/sys/class/power_supply/ltc3350/gpi_uv
>> +Date:		April 2024
>> +KernelVersion:	6.9
>> +Description:
>> +		General purpose input voltage undervoltage level. Triggers an
>> +		alert for userspace when the voltage drops below this value.
>> +
>> +		Access: Read, Write
>> +
>> +		Valid values: In microvolts
> The custom properties are not part of the uevent, so I guess there
> won't be much of an alert. A sensible way to properly handle this
> would be registration of a single-channel IIO ADC device. Are you
> using this feature? Otherwise it might be sensible to drop GPI
> support for now.

Lucky guess above, we're indeed using it for NTC measurement.

That the uevent doesn't include the measurement is no problem. Userspace=20
sets various alarm levels, listens to netlink and when an event occurs=20
it just reads the device's properties anyway to determine what to do.

Registering IIO is an option too, but makes things complex. It might be=20
better to leave it out and add the "gpi" functionality in a later patch=20
adding IIO maintainers to the reviewers.


>
>> +What:		/sys/class/power_supply/ltc3350/vin
>> +Date:		April 2024
>> +KernelVersion:	6.9
>> +Description:
>> +		Charger input voltage. Returns a single measurement.
>> +
>> +		Access: Read
>> +
>> +		Valid values: In microvolts
>> +
>> +What:		/sys/class/power_supply/ltc3350/vin_ov
>> +Date:		April 2024
>> +KernelVersion:	6.9
>> +Description:
>> +		Input voltage overvoltage level. Triggers an alert for userspace
>> +		when the voltage goes above this value.
>> +
>> +		Access: Read, Write
>> +
>> +		Valid values: In microvolts
>> +
>> +What:		/sys/class/power_supply/ltc3350/vin_uv
>> +Date:		April 2024
>> +KernelVersion:	6.9
>> +Description:
>> +		Input voltage undervoltage level. Triggers an alert for
>> +		userspace when the voltage drops below this value.
>> +
>> +		Access: Read, Write
>> +
>> +		Valid values: In microvolts
> I added some bits about vin later.

>
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
>
> My understanding for VOUT is, that this is basically the system
> supply - I would expect more regulators to follow, which convert
> it to typical voltages like 3.3V or 1.8V. In that case it would
> make sense to expose VOUT as regulator, so that it can be referenced
> as vin-supply. You can find a few examples for charger drivers doing
> that for USB-OTG functionality.

Correct, VOUT would normally be feeding further DC-DC converters. And=20
for that part, the LTC3350 is a (buck-boost) regulator. I'll dig into it.

If you could name some specific drivers that you'd consider good=20
examples, that'd be helpful (and avoids me picking a bad apple).


> ...
>> +
>> +static const struct i2c_device_id ltc3350_i2c_id_table[] =3D {
>> +	{ "ltc3350", 0 },
> please drop the 0.
ok
>
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ltc3350_i2c_id_table);
>> +
>> +static const struct of_device_id ltc3350_of_match[] =3D {
>> +	{ .compatible =3D "lltc,ltc3350", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ltc3350_of_match);
>> +
>> +static struct i2c_driver ltc3350_driver =3D {
>> +	.probe		=3D ltc3350_probe,
>> +	.alert		=3D ltc3350_alert,
>> +	.id_table	=3D ltc3350_i2c_id_table,
>> +	.driver =3D {
>> +		.name		=3D "ltc3350-charger",
>> +		.of_match_table	=3D ltc3350_of_match,
>> +	},
>> +};
>> +module_i2c_driver(ltc3350_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
>> +MODULE_DESCRIPTION("LTC3350 charger driver");
> Greetings,
>
> -- Sebastian


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




