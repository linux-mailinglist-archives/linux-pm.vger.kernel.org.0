Return-Path: <linux-pm+bounces-12966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ECD960C8D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 15:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170E11C23058
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA271C2DD2;
	Tue, 27 Aug 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="o3FTpZKX"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010006.outbound.protection.outlook.com [52.101.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6321BB6B7;
	Tue, 27 Aug 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766699; cv=fail; b=MRp1HATGwQE2YnBskBRh5Ql6nICx5M4BIlThSuoagnq8GAoGxO6zLypCnVvMxWEPy98TgFJwNDSHmJ1DCvJSN5NE/ui/GBJX7TRYPBSywkb3peSGXrwXip84c08lFAQ9Tdg/EhOhNFAllGVkA9HT0jSnGXq48AIVZqPk8Yr3KhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766699; c=relaxed/simple;
	bh=ohQRTMF5dEpQegnsNNH0BYd73pIT+QsBMLjJhT85vmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MRDdEUe8i19QiVAhPONkdXQovAyfF1f9eLHHicTkY6+s/wSuVBl9l/+zBjV3LbzaDhDUQdGzgJkf3XCU2/GBrgfLO+bDSo6y/FORMDjLhUdjzPCwakM4Ed6DJoTNXPWKgAkge8COL+rFNStDsdTabSCenJBdUG4J5l4Ob4QNEGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=o3FTpZKX; arc=fail smtp.client-ip=52.101.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKY5d+i8yU7q4QS7tDabxr5e9DFXWW00m3Q8pNoGz0AtFzYKmSmUulbv1cjL9YcHHipxnaEdYG2cY+CGT62SfwFyd7/B9aep01Z5vD14/QehgZ6jS+8MhPUIsnVhYF5f4bzJLbVEmyWTcBdPgMxsYjwazpg64ODtyK0QMVXDgk0aST1gc0pT15B70KSNft0ydmoKPe88M+b09l/uYSwdUfwsGRiJJjz/3TiZAPGKqA5YKGaif/4ocqmkbBxfG9NJE0ezFS6h7Y9T1ceOvSx/4X1AXXcH/1KpWLdxpKt7KPh53TVemk3JBqLaC/rAullsGTEj44RXJOM+zxmcLFN6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohQRTMF5dEpQegnsNNH0BYd73pIT+QsBMLjJhT85vmY=;
 b=ZNI85TTfLUeysbQ3LWiC1BGjk/E6H2bTZO6WJUNtJyndGBpExhnUyTo1EXtGzV59MFtRhPHP2hsMBhGI2QYEakD6AjiFNPCwVL4ZWeMqbYFJurb0ciUvIqDZ31bor+1XA8XsRsvxCV8w8oW9h3TIfgi+Lx7yAVK+MAvLw33E9uPgkXTcA7PEHgceYgY36LnoyZskOvq8B66X9e7sVemDbQrWdpVHTWQllZ6IbAPW7zoFqo/0YX/dC5ZjTEaV85AxDPS4WFHpAoRf7rI4JjvAqPHd6iBn98v+qpuU0PYxxLilTijpKlApgbzLzB1BAJMOREKADIeZuwfhZ3QpPqWXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohQRTMF5dEpQegnsNNH0BYd73pIT+QsBMLjJhT85vmY=;
 b=o3FTpZKX1KQHH/TCUEDU4OdFnUPKLW6pbOE+OVQn0c7MTYqH0P8QnS6qm6aXy7rcQcf+/Lurqttf3x2XMKzKDGL0Z/lQGqPKoJOU1A3HSLwEvHRsk/7SeUH9nR71KJXEg2kbSgKRW6HlLVQACcvwJkjffOtL6Ygqh/8ws7ofsd4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8508.jpnprd01.prod.outlook.com (2603:1096:604:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Tue, 27 Aug
 2024 13:51:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:51:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in
 the restart handler
Thread-Topic: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in
 the restart handler
Thread-Index: AQHa98xfGZ/E41sgA0mqBISLrIoXOLI7BK6ggAAGLgCAAAP8AIAADV+AgAACY6A=
Date: Tue, 27 Aug 2024 13:51:29 +0000
Message-ID:
 <TY3PR01MB1134654A11467C617607E2D6E86942@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
 <20240826152529.2080248-4-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346A223DA7462799B9D103786942@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <4823173e-b024-482f-83a3-560c7abd888c@tuxon.dev>
 <TY3PR01MB113464C9751ADB7B0F0356CD686942@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <f65642b5-d18d-43e8-b3c9-1810f3169631@tuxon.dev>
In-Reply-To: <f65642b5-d18d-43e8-b3c9-1810f3169631@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8508:EE_
x-ms-office365-filtering-correlation-id: 4301a1f5-9036-4ddb-3962-08dcc69f5a1c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2dTc3dSUHpSMm1KQTQ3Y2UxaUN5ckZYWGRzRjdiSC9HZjJ5bHlhVncxaVVT?=
 =?utf-8?B?dlBOdi8wU0ZBQ3V0YjIxWUQrN09qRVpmZlRscHFpMXVmQkVUOXdGQ3BHZUVT?=
 =?utf-8?B?RDRnUDVVMy9DbUV2aGZEYmZaVkovamUzaVdYWkJKS3UwMUgrbUJLc2ZmNEt3?=
 =?utf-8?B?ZXBIM3lObEpINXNadW1jYmg4a1cyTGo3K3pnSlNpZnA1ZktzdGVkZ2VOalo0?=
 =?utf-8?B?SzN0WUphQy9xUmpXb2RPcmRsa1BJUEkzdG0xTDloY0FucHZTeHVTcUU2NnJs?=
 =?utf-8?B?ZzJ3TW13dEZqa3loRk1RdlltamsvN1RodG9qK1NsM20yWlRVaW1NRjVCcWJT?=
 =?utf-8?B?OGhqMngxVHpvcEVTamJFRElBYTF0UlRSM0JuMnNVdnRQNFNrODFpMUZFSlBE?=
 =?utf-8?B?bDN2K3JPN3VzR2RzTmxEME5zTXd2bzhHVTVCMXIydGNmSVdJYnE0Y0lKTzU5?=
 =?utf-8?B?Zjc0Y1E5cGRDSHZWbm81TEhyRVFBYXA2VlBCSm4rSVhlS1V2T3Y1VDZaMW1u?=
 =?utf-8?B?WklBNFVLWXJTY0N0THdaR2RhTlUxUm1wNlJrYzUyS2FiT3Y1S3U2M1FvZmhl?=
 =?utf-8?B?MUd6clQ0b3Fjb0VEKys5aGRVZ1ZZcTZGdkZHRHZ4TmI3VkN6aytRK2VmNWtv?=
 =?utf-8?B?QlhCYkFLSVFJdHB6czI1ZUxrZFdNZHlGMW5kWU5Qb3VmdlY1MnBUWDdGczdS?=
 =?utf-8?B?VmhMdVJaVURkdUFQNllNWURSQ09ZWHZnd1Rmc09aak1NWXY4NFMzT0tMTDNZ?=
 =?utf-8?B?Q0F1ek9hNUQ4MXVNbnhKU0tsYTEzamcwQjBVOE5DWU5KbUpqaE5HQS8rV1V3?=
 =?utf-8?B?NnJBR3oxb0NORCtQelFFb0dvR3BWUStFYkt2K01yMlZFNFU4bVRvNzVabmZz?=
 =?utf-8?B?OFNKd2pNdThhWEVFVk9aSVd0aHVwLzhjS2JaYkxXUTVhUExIUm1jcjN2ZG50?=
 =?utf-8?B?dWY5NEpCeDRZM25nRlRZZWhhYmFpb3Jpc3NjNjVjQkQyOEFtd1BvVG9BQm1L?=
 =?utf-8?B?QkpNS2hvZzFzSWdZa0xwbEhURmtqZ25GbkFJNVFOQ2FhVzRCdXhOZHZPZWtD?=
 =?utf-8?B?SUs4cUJqK0I4WVN5WitOUWNJa2tVZ1gyTTNyQjQ0RS9SS3hYWXpwT2g2dnNq?=
 =?utf-8?B?azdELzFqVFhNSDB0WnBpVVFqUWhUTVIzVWlieE1jQ1RTUlJPTkNJT3VnMGhr?=
 =?utf-8?B?YnVJczFjMTBBVUE4ays0b3k1SU1iYVdyWXVQOGJDMzVvVUllNW5Yb2hHdlg3?=
 =?utf-8?B?QlV3Y05tRVFJczQ4NXdDMzVqdWlZSUppZ2dEQytqUUF5ZWRKT0VQT0J3cmoy?=
 =?utf-8?B?Z1BmbGxYN3BOZXRBcjNZY2EyUzRraS92eUJ3b0JmNlFjNjhPWDlURGJNZHRp?=
 =?utf-8?B?N1BLOG41R0ZzNGl2eHpHUGJQWDlYL2ovOURHaDI1eGR3NWpwN25KMGxjb1ph?=
 =?utf-8?B?eGpuNHZLdGpMeGRqSzJwb2hEK1dFRVFiUi9lSEpaUEVCeHIwS1E0MmtaZWVs?=
 =?utf-8?B?S0NJTjgxMXRzNUtCbS9xRWFja3VGUmg1WCtJR210bElMWENGV2Z4TEpNc0FV?=
 =?utf-8?B?VFRURndYR3JsenlNSE9hUS9iUGNPVGVWVVZ4Tkx5SnZ5SXlxNE51WVpJQTlx?=
 =?utf-8?B?QTZzKzlDdGM4MFJraXNEUm1Fazd1Qis1U3RrSy9WVDVOLzhUVGd1OThLK0tz?=
 =?utf-8?B?ejV1OVYyYlNFV3lXRDY0cE1LV05nK0xPdStmV1gzUHNzUzVpMjNNQzVaN0xM?=
 =?utf-8?B?MFIvdUZYYW5SSnFIQkE3WWpHY01UWmpZTUs3VWY3eXRReDNYZXhDUGx2eEly?=
 =?utf-8?B?S20xUzVwekZFRlA3Wk5NcVV2dms1Sm5wQkpFSm9LVC9LZVcyNFNXWEpiRkll?=
 =?utf-8?B?TVBpaXljalFsOGtnUzJlbkI3L2Nra3dGdzRqdDhLcktVa3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0xrdFA4c0lnL3FqeFExd2FuU1lXZXBEWlhQZHBFeXBONHZVV3B3ODFvV2R4?=
 =?utf-8?B?YnBMM29Oa3pyay90MFVoai9SZjVvUmp1M1Ivc08yMlRTbGswZ1dZVlJKNjR4?=
 =?utf-8?B?ZmZsTWlUZXRmWjhWUTBGd1o4MVN2M3JsMmRGQzFUckQ4UTY1dS81allsbHJo?=
 =?utf-8?B?VmE2aTYzTm9yeU5YTnV3eUJxcWlCU3pWS3NybU9tUzFUZUxqOGM1MHkweDNL?=
 =?utf-8?B?YjExMzJFNUg1WjlLb3hQNG9iaXZvM1BrMTRJS3V1clQ5d0VJOTVDYUFFNU43?=
 =?utf-8?B?bk5qaVlZdlFKZmtlTjk4KzViNzR3bHVId0l2aUxESmoySEoyOE14NUtrNjVy?=
 =?utf-8?B?dUpEeXZkTHhCbnhrVkFuZjZFbDV2R0s5YTJqU0h5bkZaTThibFBFdGZzQzRy?=
 =?utf-8?B?NEtUcVVidVNOSmh6Z3pQOUtZZDI4NjFjNUtBZ0FnL0NEYWpxNzcrQ2RaZyty?=
 =?utf-8?B?UlNPNDdQNmx5aXRnU05UMy85MHA4bzJqTEhOSGhKaENMakpMUHc3WE1CSGRV?=
 =?utf-8?B?aUpMNnJhZ0NBeUFYOGNVS25iMldYc1RVZnpqSzdGTW50alI4TDB0UXp2dTJS?=
 =?utf-8?B?YzcrUC9HN3VHL2hiVmk5MWJ0bGc4dHZ0Tm1CMCtad0lzVG1HUnJXRGswc01D?=
 =?utf-8?B?L0lJVlpKZGJZY2xrQ1VVa1FjRlFEZ1BrdjJBbDhHRjRxRE11dFhKMjhsUFJy?=
 =?utf-8?B?SEFQQ01EbXZLZTV4UmlZdm1rVUxldmdMMldFWHJmTVkyY09KQnY3ejBkQm5U?=
 =?utf-8?B?VGltbmRtQy9nVC80elBaNHN0bUtMYVQzYUhuWUQ4YnBhTTY2K2lac2dDVzNw?=
 =?utf-8?B?b3BXMWczRHhNdGZoeU1LS2pSWlRPY0haR1J6dUk1VFB5cTNBVlpOTGJ4NGlq?=
 =?utf-8?B?ZzRqMDlVK1FtRU5XUUlWOTNEV0VKQXlmUllacFJkY0pPZWZhWHg5Q1J6QXhK?=
 =?utf-8?B?aFdUYUlpTVZ4MHhlR0pxeldpZkdRcy9zV2dHUTBIaEZOd1JQTVg0Ynk0M0lB?=
 =?utf-8?B?T2RUbHpadC81ajduZ3dMbm9HWlp1Q2FEdlVjUERMNFNuYXkxd0Qvbi9vU3FI?=
 =?utf-8?B?a3F0NDgzR1BrOHp3V0xncDBRRHZ6Zngxd3BJNjA2VkswRmxONHp4M09lOEdS?=
 =?utf-8?B?NjNyRUZHbFJPUmRjRVU2RStjRnFNNlpFT2NpU3lxYWl0R1k3RjZTZFhCcENN?=
 =?utf-8?B?L08ySnFVcW9qYmQrVG1PK2NPbmNtY084dFZyOUlaZXVaaE9jaWhQWVZYNWpZ?=
 =?utf-8?B?T0JzTUt2MFNUZmozaWhsS0U1Syt0eTJvK25RcmI2NVl6Qnl2bTFobzcvUlNS?=
 =?utf-8?B?alpnTWVMYUpuclBoZTNlbzdqWGttUnUvbFFGM3UydnhHWlpXTWt3d0JRbEdW?=
 =?utf-8?B?aGVMaCtrK2xEVHFuak85UnpYRlJxbEJ0SnhaSWpqcUw3bGc0VmhaYmozZXdH?=
 =?utf-8?B?ZXhkSWh5VFljVElXMUFDYTdKMVJ2YkJ5Z3NFSmE3UE9aWnRpaGxuRllLMlJa?=
 =?utf-8?B?bmk5TzdYeGRwVWViemMxeElaVzZCLzlnaTRWdkp0K2NTRmZxems5NnBnWG53?=
 =?utf-8?B?OGs1TkRwUVBneTM5alVoWjRNN09zdEE0ODRmK3pzZHR4R2dBa0hMelptRWFE?=
 =?utf-8?B?OGNtVnl3UVR3OXMxTnlhSzhIODFkek95K1BON3VsYXNrV1FSeVVXa01QUFdN?=
 =?utf-8?B?T010cFRpbUhBNHFoR1NjUExKdzk3QzVSRVBBWUpDbTJrcWF3WlFsYWxld05w?=
 =?utf-8?B?ZWpxdStkVVFISWR6UlBkV2tQU3czaVByZ2J1eHJDTFo4K3VuVjBkOVhhb0ZV?=
 =?utf-8?B?dzdXSG5qV2tRWUVCb0FjVjVRVVo1ZEFDS2pBaWV5aUhZYS9PMlZGZXI1SEdW?=
 =?utf-8?B?bDFwUHVxWjVLNFc2UExIWVZEVzc3Sy9Fc3NtcU5XQUpZQUpablJ0R2d4b0Jy?=
 =?utf-8?B?TEEvYnU1azYxMlFiOGNhbng4V0VEazhySFhmaUJvcDh3RENGRTQxYWNFM2cy?=
 =?utf-8?B?UUh1b1VIM3ZTNWtVdnFEazFaK20wd2ZVd2F2dlc3ckJiMVlKZ0h4MklLR1U5?=
 =?utf-8?B?aFlzdjh0aWkwcEE1VThGay9ScEVIMkpRV3JPdHFLRDNNMW9DUytUNmRjaldu?=
 =?utf-8?B?ZVlRcURnK21veVJtaUdnaktEZnpFVFZoN21NQXA3b3VHN00zdmNJZkxYUEY2?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4301a1f5-9036-4ddb-3962-08dcc69f5a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 13:51:29.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6oOkdUHAdWCfg/RVdgyWjK9IQE4WxpWwlJdAmwPtvuY6Y2MiBzpkLdNCWO0LwZ41DzUjTeEHRp0ajPmDUgTqpB9lWXNWbCIMC/b0ebf7oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8508

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBUdWVzZGF5LCBB
dWd1c3QgMjcsIDIwMjQgMjozNSBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gd2F0Y2hk
b2c6IHJ6ZzJsX3dkdDogUG93ZXIgb24gdGhlIHdhdGNoZG9nIGRvbWFpbiBpbiB0aGUgcmVzdGFy
dCBoYW5kbGVyDQo+IA0KPiANCj4gDQo+IE9uIDI3LjA4LjIwMjQgMTU6NTEsIEJpanUgRGFzIHdy
b3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJv
bTogY2xhdWRpdSBiZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4gU2VudDog
VHVlc2RheSwgQXVndXN0IDI3LCAyMDI0IDE6MzMgUE0NCj4gPj4gVG86IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOw0KPiA+PiBt
dHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgd2ltQGxpbnV4LXdhdGNo
ZG9nLm9yZzsNCj4gPj4gbGludXhAcm9lY2stdXMubmV0OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
DQo+ID4+IENjOiBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LSB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgQ2xhdWRpdSBCZXpuZWENCj4gPj4gPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29t
Pg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gd2F0Y2hkb2c6IHJ6ZzJsX3dkdDogUG93
ZXIgb24gdGhlIHdhdGNoZG9nDQo+ID4+IGRvbWFpbiBpbiB0aGUgcmVzdGFydCBoYW5kbGVyDQo+
ID4+DQo+ID4+IEhpLCBCaWp1LA0KPiA+Pg0KPiA+PiBPbiAyNy4wOC4yMDI0IDE1OjE1LCBCaWp1
IERhcyB3cm90ZToNCj4gPj4+IEhpIENsYXVkaXUsDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciB0
aGUgZmVlZGJhY2suDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+Pj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+Pj4+IFNl
bnQ6IE1vbmRheSwgQXVndXN0IDI2LCAyMDI0IDQ6MjUgUE0NCj4gPj4+PiBTdWJqZWN0OiBbUEFU
Q0ggMy8zXSB3YXRjaGRvZzogcnpnMmxfd2R0OiBQb3dlciBvbiB0aGUgd2F0Y2hkb2cNCj4gPj4+
PiBkb21haW4gaW4gdGhlIHJlc3RhcnQgaGFuZGxlcg0KPiA+Pj4+DQo+ID4+Pj4gRnJvbTogQ2xh
dWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4+DQo+
ID4+Pj4gT24gUlovRzNTIHRoZSB3YXRjaGRvZyBjYW4gYmUgcGFydCBvZiBhIHNvZnR3YXJlLWNv
bnRyb2xsZWQgUE0NCj4gPj4+PiBkb21haW4uIEluIHRoaXMgY2FzZSwgdGhlIHdhdGNoZG9nIGRl
dmljZSBuZWVkIHRvIGJlIHBvd2VyZWQgb24gaW4NCj4gPj4+PiBzdHJ1Y3Qgd2F0Y2hkb2dfb3Bz
OjpyZXN0YXJ0IEFQSS4gVGhpcyBjYW4gYmUgZG9uZSB0aG91Z2gNCj4gPj4+PiBwbV9ydW50aW1l
X3Jlc3VtZV9hbmRfZ2V0KCkgQVBJIGlmIHRoZSB3YXRjaGRvZyBQTSBkb21haW4gYW5kDQo+ID4+
Pj4gd2F0Y2hkb2cgZGV2aWNlIGFyZSBtYXJrZWQgYXMgSVJRDQo+ID4+IHNhZmUuDQo+ID4+Pj4g
V2UgbWFyayB0aGUgd2F0Y2hkb2cgUE0gZG9tYWluIGFzIElSUSBzYWZlIHdpdGggR0VOUERfRkxB
R19JUlFfU0FGRQ0KPiA+Pj4+IHdoZW4gdGhlIHdhdGNoZG9nIFBNIGRvbWFpbiBpcyByZWdpc3Rl
cmVkIGFuZCB0aGUgd2F0Y2hkb2cgZGV2aWNlIHRob3VnaCBwbV9ydW50aW1lX2lycV9zYWZlKCku
DQo+ID4+Pj4NCj4gPj4+PiBCZWZvcmUgY29tbWl0IGU0Y2Y4OTU5NmMxZiAoIndhdGNoZG9nOiBy
emcybF93ZHQ6IEZpeCAnQlVHOiBJbnZhbGlkDQo+ID4+Pj4gd2FpdA0KPiA+Pj4+IGNvbnRleHQn
IikgcG1fcnVudGltZV9nZXRfc3luYygpIHdhcyB1c2VkIGluIHdhdGNoZG9nIHJlc3RhcnQNCj4g
Pj4+PiBoYW5kbGVyICh3aGljaCBpcyBzaW1pbGFyIHRvDQo+ID4+Pj4gcG1fcnVudGltZV9yZXN1
bWVfYW5kX2dldCgpIGV4Y2VwdCB0aGUgbGF0ZXIgb25lIGhhbmRsZXMgdGhlIHJ1bnRpbWUgcmVz
dW1lIGVycm9ycykuDQo+ID4+Pj4NCj4gPj4+PiBDb21taXQgZTRjZjg5NTk2YzFmICgid2F0Y2hk
b2c6IHJ6ZzJsX3dkdDogRml4ICdCVUc6IEludmFsaWQgd2FpdA0KPiA+Pj4+IGNvbnRleHQnIikg
ZHJvcHBlZCB0aGUgcG1fcnVudGltZV9nZXRfc3luYygpIGFuZCByZXBsYWNlZCBpdCB3aXRoDQo+
ID4+Pj4gY2xrX3ByZXBhcmVfZW5hYmxlKCkgdG8gYXZvaWQgaW52YWxpZCB3YWl0IGNvbnRleHQg
ZHVlIHRvDQo+ID4+Pj4gZ2VucGRfbG9jaygpIGluIGdlbnBkX3J1bnRpbWVfcmVzdW1lKCkgYmVp
bmcgY2FsbGVkIGZyb20gYXRvbWljDQo+ID4+Pj4gY29udGV4dC4gQnV0DQo+ID4+Pj4gY2xrX3By
ZXBhcmVfZW5hYmxlKCkgZG9lc24ndCBmaXQgZm9yIHRoaXMgZWl0aGVyIChhcyByZXBvcnRlZCBi
eQ0KPiA+Pj4+IFVsZg0KPiA+Pj4+IEhhbnNzb24pIGFzIGNsa19wcmVwYXJlKCkgY2FuIGFsc28g
c2xlZXAgKGl0IGp1c3Qgbm90IHRocm93IGludmFsaWQNCj4gPj4+PiB3YWl0IGNvbnRleHQgd2Fy
bmluZyBhcyBpdCBpcw0KPiA+PiBub3Qgd3JpdHRlbiBmb3IgdGhpcykuDQo+ID4+Pj4NCj4gPj4+
PiBCZWNhdXNlIHRoZSB3YXRjaGRvZyBkZXZpY2UgaXMgbWFya2VkIG5vdyBhcyBJUlEgc2FmZSAo
dGhvdWdoIHRoaXMNCj4gPj4+PiBwYXRjaCkgdGhlDQo+ID4+Pj4gaXJxX3NhZmVfZGV2X2luX3Ns
ZWVwX2RvbWFpbigpIGNhbGwgZnJvbSBnZW5wZF9ydW50aW1lX3Jlc3VtZSgpDQo+ID4+Pj4gcmV0
dXJucw0KPiA+Pj4+IDEgZm9yIGRldmljZXMgbm90IHJlZ2lzdGVyaW5nIGFuIElSUSBzYWZlIFBN
IGRvbWFpbiBmb3Igd2F0Y2hkb2cNCj4gPj4+PiAoYXMgdGhlIHdhdGNoZG9nIGRldmljZSBpcyBJ
UlEgc2FmZSwgUE0gZG9tYWluIGlzIG5vdCBhbmQgd2F0Y2hkb2cNCj4gPj4+PiBQTSBkb21haW4g
aXMgYWx3YXlzLW9uKSwgdGhpcyBiZWluZyB0aGUgY2FzZSBvZiBSWi9HMiBkZXZpY2VzIHRoYXQN
Cj4gPj4+PiB1c2VzDQo+ID4+Pg0KPiA+Pj4gUlovRzJMIGFsaWtlIGRldmljZXMgb3IgYmUgc3Bl
Y2lmaWMgUlove0cyTCxHMkxDLEcyVUwsVjJMfSBhcyBpdCBpcw0KPiA+Pj4gbm90IGFwcGxpY2Fi
bGUgZm9yIFJaL0cye0gsTSxOLEV9ZGV2aWNlcy4NCj4gPj4NCj4gPj4gT0ssIGJ1dCBJIHNhaWQg
IlJaL0cyIGRldmljZXMgdGhhdCB1c2VzIHRoaXMgZHJpdmVyIi4gSGVyZSBhcmUgaW5jbHVkZWQg
Ulove0cyTCxHMkxDLEcyVUwsVjJMfQ0KPiBBRkFJQ1QuDQo+ID4NCj4gPiBPSy4gTm90IHN1cmUg
eW91IG1pc3NlZCB0aGUgc2FtZSB0ZXJtaW5vbG9neSBvbiBjb21tZW50IHNlY3Rpb24sIHNlZSBi
ZWxvdz8/DQo+ID4NCj4gPj4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IHRoaXMgZHJpdmVyLCB3ZSBj
YW4gbm93IGRyb3AgYWxzbyB0aGUgY2xrX3ByZXBhcmVfZW5hYmxlKCkgY2FsbHMgaW4NCj4gPj4+
PiByZXN0YXJ0IGhhbmRsZXIgYW5kIHJlbHkgb24gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgp
Lg0KPiA+Pj4+DQo+ID4+Pj4gVGh1cywgZHJvcCBjbGtfcHJlcGFyZV9lbmFibGUoKSBhbmQgdXNl
IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSBpbiB3YXRjaGRvZyByZXN0YXJ0IGhhbmRsZXIu
DQo+ID4+Pg0KPiA+Pj4gQ2FuIHRoaXMgcGF0Y2ggYmUgZml4IGZvciBDb21taXQgZTRjZjg5NTk2
YzFmICgid2F0Y2hkb2c6IHJ6ZzJsX3dkdDoNCj4gPj4+IEZpeCAnQlVHOiBJbnZhbGlkIHdhaXQN
Cj4gPj4+PiBjb250ZXh0JyIpIG9uIFJaL3tHMkwsRzJMQyxHMlVMLFYyTH0gU29DPz8NCj4gPj4N
Cj4gPj4gTm90IHN1cmUuLi4gSSB0aG91Z2h0IGFib3V0IGl0LCB0b28uIEkgY2hvc2UgdG8gaGF2
ZSBpdCBsaWtlIHRoaXMNCj4gPj4gdGhpbmtpbmcNCj4gPj4gdGhhdDoNCj4gPj4NCj4gPj4gMS8g
dGhhdCBtYXkgbm90IGFwcGx5IGNsZWFubHkgYXMgaXQgZGVwZW5kcyBvbiBvdGhlciBjbGVhbnVw
cyBkb25lIG9uIHRoaXMNCj4gPj4gICAgZHJpdmVyLCBlLmcuIGNvbW1pdCBkODk5N2VkNzllZDcg
KCJ3YXRjaGRvZzogcnpnMmxfd2R0OiBSZWx5IG9uIHRoZQ0KPiA+PiAgICByZXNldCBkcml2ZXIg
Zm9yIGRvaW5nIHByb3BlciByZXNldCIpIHNvIGl0IG1heSBiZSB3b3J0aGxlc3MgZm9yDQo+ID4+
ICAgIGJhY2twb3J0IG1hY2hpbmVyeQ0KPiA+PiAyLyBUaGVyZSBpcyBhY3R1YWxseSBubyBzZWVu
IGJ1ZyByZXBvcnRlZCBieSBsb2NrZGVwIChhcyB0aGUgY2xrX3ByZXBhcmUoKQ0KPiA+PiAgICBk
b2Vzbid0IGhhbmRsZSBpdCkNCj4gPj4NCj4gPj4gRG9uJ3Qga25vdywgSSBjYW4gcmVwbHkgaGVy
ZSBhbmQgYWRkIGl0LiBBcHBseWluZyB0aGlzIHBhdGNoIHdpdGggYjQNCj4gPj4gd2lsbCB0YWtl
IGNhcmUgb2YgaXQuIEJ1dCBub3Qgc3VyZSBhYm91dCBpdC4NCj4gPg0KPiA+IE1heWJlIGxlYXZl
IGl0Lg0KPiA+DQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBC
ZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4+IC0tLQ0KPiA+
Pj4+ICBkcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jIHwgMjEgKysrKysrKysrKysrKysrKysr
Ky0tDQo+ID4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0Y2hkb2cvcnpnMmxf
d2R0LmMNCj4gPj4+PiBiL2RyaXZlcnMvd2F0Y2hkb2cvcnpnMmxfd2R0LmMgaW5kZXgNCj4gPj4+
PiAyYTM1Zjg5MGEyODguLmU5ZTA0MDhjOTZmNyAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJz
L3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4+Pj4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9yemcy
bF93ZHQuYw0KPiA+Pj4+IEBAIC0xMiw2ICsxMiw3IEBADQo+ID4+Pj4gICNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4NCj4gPj4+PiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4+Pj4gICNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPj4+PiArI2luY2x1ZGUgPGxpbnV4L3Bt
X2RvbWFpbi5oPg0KPiA+Pj4+ICAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+Pj4+
ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gPj4+PiAgI2luY2x1ZGUgPGxpbnV4L3VuaXRz
Lmg+DQo+ID4+Pj4gQEAgLTE2Niw4ICsxNjcsMjMgQEAgc3RhdGljIGludCByemcybF93ZHRfcmVz
dGFydChzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICp3ZGV2LA0KPiA+Pj4+ICAJc3RydWN0IHJ6ZzJs
X3dkdF9wcml2ICpwcml2ID0gd2F0Y2hkb2dfZ2V0X2RydmRhdGEod2Rldik7DQo+ID4+Pj4gIAlp
bnQgcmV0Ow0KPiA+Pj4+DQo+ID4+Pj4gLQljbGtfcHJlcGFyZV9lbmFibGUocHJpdi0+cGNsayk7
DQo+ID4+Pj4gLQljbGtfcHJlcGFyZV9lbmFibGUocHJpdi0+b3NjX2Nsayk7DQo+ID4+Pj4gKwkv
Kg0KPiA+Pj4+ICsJICogSW4gY2FzZSBvZiBSWi9HM1MgdGhlIHdhdGNoZG9nIGRldmljZSBtYXkg
YmUgcGFydCBvZiBhbiBJUlEgc2FmZSBwb3dlcg0KPiA+Pj4+ICsJICogZG9tYWluIHRoYXQgaXMg
Y3VycmVudGx5IHBvd2VyZWQgb2ZmLiBJbiB0aGlzIGNhc2Ugd2UgbmVlZCB0byBwb3dlcg0KPiA+
Pj4+ICsJICogaXQgb24gYmVmb3JlIGFjY2Vzc2luZyByZWdpc3RlcnMuIEFsb25nIHdpdGggdGhp
cyB0aGUgY2xvY2tzIHdpbGwgYmUNCj4gPj4+PiArCSAqIGVuYWJsZWQuIFdlIGRvbid0IHVuZG8g
dGhlIHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSBhcyB0aGUgZGV2aWNlDQo+ID4+Pj4gKwkg
KiBuZWVkIHRvIGJlIG9uIGZvciB0aGUgcmVib290IHRvIGhhcHBlbi4NCj4gPj4+PiArCSAqDQo+
ID4+Pj4gKwkgKiBGb3IgdGhlIHJlc3Qgb2YgUlovRzIgZGV2aWNlcyAoYW5kIGZvciBSWi9HM1Mg
d2l0aCBvbGQgZGV2aWNlDQo+ID4+Pj4gK3RyZWVzDQo+ID4NCj4gPiBOaXRQaWNrOiBGb3IgdGhl
IHJlc3Qgb2YgUlovRzIgZGV2aWNlcyB0aGF0IHVzZXMgdGhpcyBkcml2ZXIgKFRoaXMNCj4gPiB3
aWxsIG1ha2Ugc3VyZSBJdCBpcyBub3QgbWVhbnQgZm9yIFJaL0cye0gsTSxOLEV9IGRldmljZXMp
DQo+IA0KPiBJZiBvbmUgY29uc2lkZXJzIHRoaXMgZHJpdmVyIGlzIHVzZWQgYnkgUlovRzJ7SCxN
LE4sRX0gd2hlbiByZWFjaGluZyB0aGlzIHBvaW50IHRoZW4gc3VyZWx5IGlzIGluIHRoZQ0KPiB3
cm9uZyBwbGFjZS4NCg0KU28gc3RyaWN0bHkgc3BlYWtpbmcsIHRoZW4gaXQgaXMgUlovRzNTIGFu
ZCByZXN0IG9mIHRoZSBkZXZpY2VzLg0KYXMgUlovRzIgaXMgbm90IGFwcGxpY2FibGUgaGVyZSBh
cyB3ZSBoYXZlIFJaL1YyTCBhbmQgUlovRml2ZSBhcGFydA0KZnJvbSBSWi97RzJMLEcyTEMsRzJV
TH0uDQoNCj4gDQo+IFJaL0ZpdmUgaXMgYWxzbyB1c2VzIHRoaXMgZHJpdmVyLiBMYXRlciwgbWF5
YmUgZGV2aWNlcyBjb21wYXRpYmxlIHdpdGggdGhpcyBkcml2ZXIgd2lsbCBiZSBhZGRlZCBhbmQN
Cj4gdGhpcyBjb21tZW50IHdpbGwgbm90IGZpdC4gTGF0ZXIsIHdpbGwgd2UgYmUgdXBkYXRpbmcg
dGhlIGNvbW1lbnQgZm9yIHRoYXQ/IEknbSBub3QgYSBmYW4gb2YgaXQuDQoNClRoZSBjb21tZW50
IFJaL0cyIG1hZGUgY29uZnVzaW9uIGFzIHRoZSBkcml2ZXIgc3VwcG9ydHMgUlovVjJMIGFuZCBS
Wi9GaXZlIFNvQ3MgYXMgd2VsbC4NCkFsc28sIGl0IGdpdmVzIGFuIGltcHJlc3Npb24gYWJvdXQg
UlovRzJ7SCxNLE4sRX0gZGV2aWNlcy4NCg0KTWF5YmUgcmVwbGFjZSAiRm9yIHRoZSByZXN0IG9m
IFJaL0cyIGRldmljZXMiLT4iRm9yIHRoZSByZXN0IG9mIGRldmljZXMiIHNob3VsZCBiZSBzdWZm
aWNpZW50Lg0KYXMgaXQgY292ZXJzIFJaL3tHMkwsRzJMQyxHMlVMfSwgUlovVjJMIGFuZCBSWi9G
aXZlIFNvQ3MuDQoNCkNoZWVycy4NCkJpanUNCg0KDQoNCg0KPiA+DQo+ID4NCj4gPg0KPiA+Pj4+
ICsJICogd2hlcmUgUE0gZG9tYWlucyBhcmUgcmVnaXN0ZXJlZCBsaWtlIG9uIFJaL0cyIGRldmlj
ZXMpIGl0IGlzIHNhZmUNCj4gPj4+PiArCSAqIHRvIGNhbGwgcG1fcnVudGltZV9yZXN1bWVfYW5k
X2dldCgpIGFzIHRoZQ0KPiA+Pj4+ICsJICogaXJxX3NhZmVfZGV2X2luX3NsZWVwX2RvbWFpbigp
IGNhbGwgaW4gZ2VucGRfcnVudGltZV9yZXN1bWUoKQ0KPiA+Pj4+ICsJICogcmV0dXJucyBub24g
emVybyB2YWx1ZSBhbmQgdGhlIGdlbnBkX2xvY2soKSBpcyBhdm9pZGVkLCB0aHVzLCB0aGVyZQ0K
PiA+Pj4+ICsJICogd2lsbCBiZSBubyBpbnZhbGlkIHdhaXQgY29udGV4dCByZXBvcnRlZCBieSBs
b2NrZGVwLg0KPiA+Pj4+ICsJICovDQo+ID4+Pj4gKwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9h
bmRfZ2V0KHdkZXYtPnBhcmVudCk7DQo+ID4+Pj4gKwlpZiAocmV0KQ0KPiA+Pj4+ICsJCXJldHVy
biByZXQ7DQo+ID4+Pj4NCj4gPj4+PiAgCWlmIChwcml2LT5kZXZ0eXBlID09IFdEVF9SWkcyTCkg
ew0KPiA+Pj4+ICAJCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocHJpdi0+cnN0Yyk7DQo+
ID4+Pj4gQEAgLTI3NSw2ICsyOTEsNyBAQCBzdGF0aWMgaW50IHJ6ZzJsX3dkdF9wcm9iZShzdHJ1
Y3QNCj4gPj4+PiBwbGF0Zm9ybV9kZXZpY2UNCj4gPj4+PiAqcGRldikNCj4gPj4+Pg0KPiA+Pj4+
ICAJcHJpdi0+ZGV2dHlwZSA9ICh1aW50cHRyX3Qpb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRl
dik7DQo+ID4+Pj4NCj4gPj4+PiArCXBtX3J1bnRpbWVfaXJxX3NhZmUoJnBkZXYtPmRldik7DQo+
ID4+Pj4gIAlwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsNCj4gPj4+Pg0KPiA+Pj4+ICAJ
cHJpdi0+d2Rldi5pbmZvID0gJnJ6ZzJsX3dkdF9pZGVudDsNCj4gPj4+PiAtLQ0KPiA+Pj4+IDIu
MzkuMg0KPiA+Pj4+DQo+ID4+Pg0K

