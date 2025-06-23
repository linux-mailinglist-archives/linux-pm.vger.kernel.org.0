Return-Path: <linux-pm+bounces-29303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D056DAE4088
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3668F176EEA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C9B13C9D4;
	Mon, 23 Jun 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HbXu+JUm"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012011.outbound.protection.outlook.com [40.107.75.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866621E485;
	Mon, 23 Jun 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682030; cv=fail; b=mpicVsyLTC1iNzh5As+sJZF7kW/nFPxqI32/ysmyHrSzmjL5tta1yK1wQLIPmWA+s7SW2GFvMsyd5HeQ4PbnOV7pdntyPtz/U2yxZjmEduRFv/Hd5eLKWE0nGdjDtUFS7Cp0VFHeVF738JB5YvPZKsSqyRWoYV26Fc+cR3k+DhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682030; c=relaxed/simple;
	bh=Vn3bqdk0D/j9g6jp7kzggFwyMpC0ceI3T2mc/NZE3VY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tw9owxh/jVAviIH3+5jrIDJwtSJfnAGSMuN1Edd1VyeTjcmN638TFMGA2a6CcGucFfACPw4iTLkll1B1gym6kzMPj17EQL32tp00bPdrWVZscy0+C2EuJhLQncXQsN0ItGRZ1uTs+htp8Zd9dBb+Bylxl7eg8WxlNf6MuIA3Pq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HbXu+JUm; arc=fail smtp.client-ip=40.107.75.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4tomiHNj2x/oyQynA91H6cRcZJJuKpOqL6oWZ5MXTdDET11RGbbEX52UN1FKlKFtTnPgeFqJHeV3n0qW5OVNjoiCMaYv4ArgljUpzPjuAaBAtB8hlgf1+IfClkhYvvtLAXqZ/8wsS7dIA/OuCNT5p9ezusP7SjZp+49z/uLxzAp/xFuy1rP1o2R0IEOEyu4Fi1TV0Gy+VLo1FZDtaLLe92RynBAJo3umqE4TGwyjwAkNxHrdRJpI7AjBWEY4gs9frclsQplofYEyCVIXN+1fNqiZ6n6hpPjso+gIwsm7Dp2r+PABL+qtpFs7bfv6p1QTUulvt9xoff/+R8o3Z5wLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O12I20UkBFxfBJucpc9E5+BkI6diKvISUmKOHDr1dQ=;
 b=rE+yMzDLSzlQjJp+svhmbTPVwI2zXybb+/YD+WD95KeVygHbtMMO3MgEmWE+rRyuPjqzZd7zrTegb4TvbX9Z5CjIIEn2N6ZT8uPeQoKgdCY/JUZ3/P1fabfhMQVn3QJ5lS2k/WgU/LhzGP1X73nxZT25e7t7dI9/Lhs4kWMXkW1e44+p039yCvUp7cJ47ZG9pV9rXAWiRDpAs3ng3+hKefwa0T00Yg71p0AEVSB9OnbA5zlDg7GEuzOX8a2bo3oDWNak5I6gxFKPyIJciLuwox2Gh0P5C/4F5id9o/GIY4fMrLxE51gT2TmuiuQphD0+DbBA9mBU4HuCtWifMPto7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O12I20UkBFxfBJucpc9E5+BkI6diKvISUmKOHDr1dQ=;
 b=HbXu+JUmXSSCzyXKKaLGHarB0v9/qFXRAYWoUK3eJyhDwa4v1r0wTAyfHefdBvDyBuj/iAUnzE9mN44CQIPo2gftZl3josraSZM24FvgFsiEfDImuZRnFhWA91Bder8VSK+E5GGX3wo0DM50seMTmJRv7Xt5V4kO8Pj5eW8ceUlxM/B4108BGgsV14IxEKygL+1W/9S6sJLARQCkBFmPbJeKLi7mxX/kXamqDuGXk9WwhZjx52JLjxr5lXsF+a6Ht4CpskyFwibPBhIqGsSpQs9iqZHCRKhdArPF66x5ORt31CTZ0LeYC5ENDUQDsDszk1b2pyX9jtIfpGBqxgtHww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TY0PR06MB5185.apcprd06.prod.outlook.com (2603:1096:400:21f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 12:33:45 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:33:45 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 03/24] thermal/drivers/armada: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:33:36 +0800
Message-Id: <20250623123336.472598-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TY0PR06MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 91da6121-d6dd-47af-62e5-08ddb2523225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVVWOE55YkQxbG5ab0c3RlNGNzduaFNWUzgxOVZDb2tSMmZDNmVCMHowaGt4?=
 =?utf-8?B?TG1kWm1SSDBLSVdrdkNKS0s0TFhySXVxUEhKS0kwNWs0YjRkZ01RYzMzZVF6?=
 =?utf-8?B?UGIwMGxpTTlRMkNlQWRQeFNxb1RZTWgzdDNTbFJVbWVUZkI2bm9zYnEwT2dU?=
 =?utf-8?B?c2RYRjI5UjV3MzdRT1B2RXU1ZkZCd1FoTTZSNkxtSW9FVm5BTTdrZnl1Mmd5?=
 =?utf-8?B?bVE4a3hIa0ltY05ja3ZCWXVGSG9CS2t4cGpIUysxaWRJbk1jMkFJQW43eVZO?=
 =?utf-8?B?YWpyNDlCSFdqZzlqMmI2T3FKbzgySWtHQmpXTnJyd2dETzFvbW5GcEU2VTM0?=
 =?utf-8?B?VWZTcEl4THF5ck9lSnlDYW0zcFRJdzBibG9vbDhiODVjQjdJUVVmUUFFemZ1?=
 =?utf-8?B?cTNUMFRLM0Izb0hKalJ2cnpxUmordklqc2lCeDZqUXlGcnVINm84OHFUM0dv?=
 =?utf-8?B?RFg5QWVoMjJUT2wyT3NRc0xyb09CbmNicFpzMU0wWk0yZFdPSFQwSW1yZ29W?=
 =?utf-8?B?SnA4M3FXelJYMFV3bGdldGJFQ0Y3MWM5elNPWC8rMzlxRDhkbldvekgzeVNj?=
 =?utf-8?B?N2ZFalV3MGYvS1A0WS85YUNjaU84Q1ErT2FPRGJMdm01Y29ZSnV3QjhhWkho?=
 =?utf-8?B?ZGpMRzdVdEZJQURlb2Z1ZXZrMDFLTEtBemFMS2pJdHZVblVGV3VoZ2Q3SXVa?=
 =?utf-8?B?VjZZWDdROVJSNi8yS3d1NlNqUWpJWnpPZGRMUE9XMW51VEVFY2tzYmJSRnJS?=
 =?utf-8?B?QjNOdmV5YlJESnRYb3ZWenhPRWNyeGdrMlQ2b2dyT2JwdTJpaU1kcHVSM0hY?=
 =?utf-8?B?aWMreDFRc3owRkJaNVZDRGdZdjVRNTFUOGpyVGlEU0MwWmVjSW9hZG15Wjhv?=
 =?utf-8?B?OEc1ODIxUklTZzJUVkZ4cEtuM0hqeFUyekdRSVVmcDVFb1ViSTVZRUt3N0ly?=
 =?utf-8?B?VUxOallrdnBJU0tNOTBGbVV3QmY2ZWJhZWs3V216V0kwcXlFTkxpeXZaRFRT?=
 =?utf-8?B?L2srbURMSXEybngyZGtCWmFqcVA4czlIUWUvWTBZd2pSdDJEdmJzeHBaY3Jm?=
 =?utf-8?B?c2UyWTVkUllOWHByV0ViZld1a3AvbjZGWUM4MGRHVlZlNlV4TS9NVXdIQU9P?=
 =?utf-8?B?RkM3MGtJVlg5M3daQVJtNklMb0dyM2lSdStNZlNLK292VXdIK1Nra0dGWGpR?=
 =?utf-8?B?TjNlbFlyenBic1FySXc0clFBVllpL2lpZFlkUnJiRG8xUkVvK3JISlMrdnBw?=
 =?utf-8?B?YzZBbGE4T1ZiczB6cDM4dWVyTndYeFgwYkFEV09Dbm8vRGQvY2JUNWxla3Vr?=
 =?utf-8?B?ekcwclc0OWVWTUpMMldEbVNjNEtpUlJyQ2Z0VEhrVmEwZ2ZOc0greXFJUERX?=
 =?utf-8?B?Z20wcGIrUmViNGdzeEw4TFlQcFZ1ZGVQTFFBR0g3dzdYUStaZ1EyREllelFL?=
 =?utf-8?B?OGJxM3dPb1UrNHdSeDVRTkVhNHZTeGdUZWVGL1RieHIyem9oMmltOGdjV0lX?=
 =?utf-8?B?WXBqZlNLcWRmM0xRRy83NnJ2S2EzNEt3MFVCeWFBVGVhT0EzSmhnV1ZPNWo3?=
 =?utf-8?B?eGJFNDd2T1NDakovTE0zM3lPWFIwUXJWRTZJd2lOcUsrUWJxbmhoSUR5NEI4?=
 =?utf-8?B?Q0lLTUV2a2U3K2RrUk1JN0hkUE40NEo4dEpVUW55emMydnQ0Q1N6YW5qS3NC?=
 =?utf-8?B?VytEMHIyQWU2NlA4ektNVHllblpTV1BwODNoUFNyemJHUCtuYzRETFhPMFB5?=
 =?utf-8?B?elR0eURqSnBGOVBONjdxd25FbVEyWGMyTUtQNDZXcVU0dmR0dURCMlZieFhH?=
 =?utf-8?B?bXhqbDdGRGhoZVJxenJjWEM5UXEvOXdPYzFPb2hJM3NybjhsSUsrYTVPMmoy?=
 =?utf-8?B?c3hyVDZMOG8wUEtGdEhIUHVHTUhnbW5SOVJLWHB5ZWtkS0dobUhZMFlkUEdY?=
 =?utf-8?B?M0l3TlEvVGgwdnR1MTUzZDRIN091Ylo0RDNadFZKZ1ZweklLN2hBeUVRcGFK?=
 =?utf-8?B?cXlURWQwOGtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTJvekROV0YxQjNCM0U2eHBHWVdqZVBaWFVEWlpOb25PSzNqZ3ZTWXlyb25M?=
 =?utf-8?B?dnR3bGFNODRYdW9MMmdPQXY3ajdITFZnUEFOdjNIMVVRbi84SXUxL01iWFNn?=
 =?utf-8?B?cEppcXpNcGgxY2ZRRG1BMGZneFJHcW9Fc2pQdHpENjI0c1J0aVVMcHVOdUtO?=
 =?utf-8?B?ckFORUFuN3FEcWFIMXhpR3VYaUVYaTU0cC9GMWxrR3hBc3NVRDBCQzRRMHU3?=
 =?utf-8?B?SzZleFZhRS8veWNiTDF0cEt6Q2VDaXdQcjRBOFBUcU85SFA5Wk9KSkNXUVoy?=
 =?utf-8?B?K3BDd2hqMWFwL1BYUXRxWG5ZcU5XWVJWaEFvRDZjMmpWbUNHSmZLMFNRanFZ?=
 =?utf-8?B?Y1BSazRjajl5eEV3NUo3eklRUFplUjJtOHNaZVU5ZjdRWDRUMzhlOEo3OVMv?=
 =?utf-8?B?STU4RWEyRXFaZURMOXNzSDNpQkJkbU1DOUJ6L2dMM2xPVmdIdFYzUzdGd0Ez?=
 =?utf-8?B?VkJOWGd2SlU4cnFUelhkVGpGdWl3NldmM1lmYkVJa1hDRDNVNkRtWHpYOElo?=
 =?utf-8?B?UU5icGtnODRjRDMvcWNHTHdFTnpSUFhEUkU5dFFEalpvOWExMnIrZkdvN0RM?=
 =?utf-8?B?dEZUZ1dsM3VKZm83OTBiSjNBcXhRdE9ZY2l0YmtLblFUM3daMVJSMWNVWDZ5?=
 =?utf-8?B?YjVXVlZEaUpPbEcrR3R0ZWprUkNMUmQ4SUp3eHNmVEl4YU52bkJWN2tYT3N4?=
 =?utf-8?B?cFlad3BaU1hVQWhHZTFiS3l1dkM2TUNjVHQ3bC9IMkJqblZ1TnhJcVRwNW5l?=
 =?utf-8?B?aGI1NHA1QkhkbFpHcFhDSHBoaUt0c2N2ZXdxUGtxTnUvMmc0M3ZDZ0g5aXpD?=
 =?utf-8?B?N0t2MkdTbzVzSEcwaGd6ZmFvczFGSHdvUHJocnZnVG83ZlE4QVRpUkd2YWdv?=
 =?utf-8?B?TjRzTjZhWWFpN1ZaQ1ZJdmlVU3pjN0JuSG1aeklsUVRXeXN3L1RFZEYrcmRz?=
 =?utf-8?B?elp0bG5lTnFpRmFJS3g2Z3ZIdlEwUWwvM21KZWJXdGRST3gwd2d3NjZNOUpp?=
 =?utf-8?B?Q0RlVGlVVEUzWTE4dllRWXNLMkY1RjNtZkZzQlozT05wdGNyWFQ0dmlHZG9N?=
 =?utf-8?B?aGFlZHN1VmU5UTNXN0ExelNoUXZGRlVvWXRTT1hHTVVhcFlmZ2tNWFdPZTlQ?=
 =?utf-8?B?bC9JTEhBRk9idlBhNTBTcXBVZGhyMkJqa3ZwTGZoNTZycWdZRFptT2NtNEZo?=
 =?utf-8?B?MGZydmdWM3RwYTdCNG95ajU5VXpwZU81RlhoTzlPV2hlQjhZeVNOTDJYV25n?=
 =?utf-8?B?WEJLVC9QTGw5NXpUM2x3SlZYMmFGV3E3UDlrZmp5WW5pdjFlMmRvdXF0QkJQ?=
 =?utf-8?B?QkZnSlVHL2ZyKzN5MTU5TnNBbk54bTZ0VEVkKzBuaUg2c0NidGpJT2E0UDV6?=
 =?utf-8?B?d0dLN1h0ZEhsM3F6MmF1MU1CTndpNTZ3UzJQNitvV3VVaUI5czFGOUlGY2Jn?=
 =?utf-8?B?N092NHRUdGVPamxkRzN6SUJUYzcwR0dkTTJOZWorS0FRakJjajFnSDFSczdN?=
 =?utf-8?B?K2V2anl1cHU4dGVmTFo5Z2ltYVhKakhqa05OeFpqTHEvVmZYWU04eDgxdm9x?=
 =?utf-8?B?YlllNktUWVZoNVd4Ulg0d1QwMEFtbjE3OEVmODJGd2xkSFRySUJETDhKQUFE?=
 =?utf-8?B?dGR3Q2FMZFZPMWQzaFhZN2d1Z1RrMUNNQlhwa01QZWZxWm0zQitxR2U0YmQ3?=
 =?utf-8?B?aXBGcytDcU9IQUV0czYrTGFHMFhHYTJEQzZobFZ3M3lHZWdSd2FiQlY0bzFU?=
 =?utf-8?B?U0tsSXhXNDVUYWNYa29IWXhQZ3BFWFZ6UGErS3N0L0U0Vy9LSlhZVDJCM3FP?=
 =?utf-8?B?SWtjM21NbGp2Ujh1TkdaOGJOWm5na1FGcHFtSzQrRW1EUmFCYmVQUjg1SEtr?=
 =?utf-8?B?RnNmNGc4SFBheXY3Wi9lSzVyZG1xTTFuS0FKT0tZbEpCSmYwbGd4cGVkYTV0?=
 =?utf-8?B?SW5QdWN5eGhkUzdBdjFiRVRSNytKSDhJTXFJNUsxTDA2a0dpeFAzdVUyZVk4?=
 =?utf-8?B?ZmVDeHdRVjZxR002dUdzY00xT1U1TnRXYXAwZlRnSzlwNUVjREgzTnJxb0hH?=
 =?utf-8?B?QjFQUEZTb050d3NEYlF5Z1A5cUhoZVNnSDNYV2hkRXVybnFkYUNST3EwSVJ2?=
 =?utf-8?Q?ijIWynLNbj8gJbGuKyD0zKV8t?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91da6121-d6dd-47af-62e5-08ddb2523225
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:33:45.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP7XfAsB9qgwPHOxc8EZzioCknezbG1IzpiacUDtSk5P9udBU/cjLkorL+4Jh5PMSf3Z6BlF6o15XRDF+ef14Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5185

From: Yangtao Li <frank.li@vivo.com>

The new devm_request_*irq_probe API prints an error message by default
when the request fails, and consumers can provide custom error messages.

Converting drivers to use this API has the following benefits:

  1.More than 2,000 lines of code can be saved by removing redundant error
  messages in drivers.

  2.Upper-layer functions can directly return error codes without missing
  debugging information.

  3.Having proper and consistent information about why the device cannot
  be used is useful.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/armada_thermal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9bff21068721..c8a4f9765dca 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -909,15 +909,12 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 	/* The overheat interrupt feature is not mandatory */
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						armada_overheat_isr,
-						armada_overheat_isr_thread,
-						0, NULL, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
-				irq);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, irq,
+						      armada_overheat_isr,
+						      armada_overheat_isr_thread,
+						      0, NULL, priv, NULL);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/*
-- 
2.39.0


