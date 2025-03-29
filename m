Return-Path: <linux-pm+bounces-24603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36424A75656
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26339189285C
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4711C5D61;
	Sat, 29 Mar 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mB87uuSa"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4291E4B2;
	Sat, 29 Mar 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743253489; cv=fail; b=AxBlekYDFuixEjRxEvCZvTjGA5CwAYBn10gRkvx6bpX0MxIftyiaPIr+MSo14+4Cr2AXlQjc239KLbmBS76T0v8HgY1WPxqL77UCDMNZgOU53lt/YEbZxbSas9f3StMHGbP0Ur8aAQ2EI7RyuCZVysS4F2M5EC0+SxvfKzxvaGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743253489; c=relaxed/simple;
	bh=KlAQ1YjVtyTAQ2LN3fV9Rua0KwaUbnezCNsGTRKGQXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8E+WwiHsAUeLaRQ5ghzxtRFBaID0GZr+29ReZhHikPPUER+LnCGkJE4ma4Do5HM8j9LiIUBbKev3mM1e/sZE/fmN29sKxtfgfi2SrfcwCrTmQ+cPVoY3c/xRKBM51OZ905flSOoqcStTion6Xgc00USCF2D7AzO55JAeFzc2vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=mB87uuSa; arc=fail smtp.client-ip=52.101.125.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGA8iHXssHmMYFKa5Y2g1PKheFK62GgVmhthvuVzrFW1LStnLdkA+xfqKax61eQAbL/aatB0ulWT1EIUTe7j6R08Kk5Z1TWTlotBqfvbaYvq1i716a+IhnodMD1qlbO/ntXWfgZSniPzwrw9opTdwTeW+PUe1UqBfUJrosSIKAMFqC3SMMZdN/J0e8wrjzvPNj+rCw4/71sbLIuaI3n2u4kuuxSqjGwx8PoozudpWAzrFIcT6EW6ToFWPKb5IuY2nbzTm+a5RfdrEkk2WDURkCX8hECcnpUfZGb6zyn9WrS04zozBhCE9bD+9rLHP/SKZfgQNADn0noqdMQ6GAAknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlAQ1YjVtyTAQ2LN3fV9Rua0KwaUbnezCNsGTRKGQXc=;
 b=bmzaQjzjYvCS893XyiIdnTTnN/zHXasD2Gmc8nNfcRJVTjrjrDbKHjw20wmvQJTxT0LdtTSUsFZYYxjgvfVV4GuYYq52k3/UCaklhkAl9zyB9XF8o08yE/9+WqWs+EXGTuBbu9N/ALMRWDsHzMyIT/i63URVHgXblSfHxgae6wRVmuzTwylLvcx3C8RSif6uPmqO7pn1yQ1P8cGJz2s99UK91buRSJm8RvSrRxqpXVt0fvpGqIQVRVQh6p4/T3DsFDHGco0aofmRexYceCRfl81MZKDT73wo3KKkaH3TCyKvJDIuHqdsBhYvfaAAvjGkKLOk8oypmgNI9U9vt8JBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlAQ1YjVtyTAQ2LN3fV9Rua0KwaUbnezCNsGTRKGQXc=;
 b=mB87uuSauXTisyPaBrE8Rm5oQKPtAroB2pYBoc4AlqqdAZhMMD7EnWeT3HGVNwEfYPC9hiCRRU0GtMdDW8qMf2hrVWgD86OO+bpGM39K7ZWN1jh8g5j4KR4UFetc5/BeOE4e3z2RqpI3cJfCnflXHQiwQmBpyaXWrxlJyHgd6ks=
Received: from OSAPR01MB2772.jpnprd01.prod.outlook.com (2603:1096:604:4::9) by
 TYYPR01MB15116.jpnprd01.prod.outlook.com (2603:1096:405:1a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sat, 29 Mar
 2025 13:04:43 +0000
Received: from OSAPR01MB2772.jpnprd01.prod.outlook.com
 ([fe80::7280:12fa:872f:e753]) by OSAPR01MB2772.jpnprd01.prod.outlook.com
 ([fe80::7280:12fa:872f:e753%5]) with mapi id 15.20.8534.043; Sat, 29 Mar 2025
 13:04:42 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Markus Elfring <Markus.Elfring@web.de>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring
	<robh@kernel.org>
CC: John Madieu <john.madieu@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Zhang
 Rui <rui.zhang@intel.com>
Subject: RE: [PATCH v4 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Topic: [PATCH v4 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Index: AQHbl0pZnyOCagij30qjRTFMkwrQP7OKJuKAgAAAcbA=
Date: Sat, 29 Mar 2025 13:04:42 +0000
Message-ID:
 <OSAPR01MB27727E4A9C09F399A7A4FA02FFA32@OSAPR01MB2772.jpnprd01.prod.outlook.com>
References: <20250317143442.100590-4-john.madieu.xa@bp.renesas.com>
 <207f5f63-39b2-4801-ab98-8fd8cb7c1302@web.de>
In-Reply-To: <207f5f63-39b2-4801-ab98-8fd8cb7c1302@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB2772:EE_|TYYPR01MB15116:EE_
x-ms-office365-filtering-correlation-id: f09730c8-4880-4729-570f-08dd6ec24541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2hTMVAzTktNRGhNZy9qT1dCbXVCc3JWeWdZb2xUYmF3cnhUTHlDaU1qcjhO?=
 =?utf-8?B?QnZicndLWEZmdkJoRWQvZC9OZlFaVllBUkFhODJmY3J3eXlPc0ZTVWZidlVw?=
 =?utf-8?B?eEdibzhWK0ZKWEthOHI3SUM2QmpGYmU2dHNJRGFBbUJ2MWkrTmVYZ2poRzgw?=
 =?utf-8?B?WEVyUzJBQVhQZTBoS1dBaHZYdFhDd2Q3Z3FCbGhkaUhzc2dvZytCbHZReVhI?=
 =?utf-8?B?c1ZueHBOT3ozWlpENjlvcEszVkJlSUxhaEUxWGJkcy9DbUM3eVdnRW1JVjhD?=
 =?utf-8?B?TFZVYVZ1N1N6bStHL0t6d1dMcDNHUWE3dTdGSkJ3V0JodjJ5dXNyRU1JcTJJ?=
 =?utf-8?B?WHF2NHBScWwyMmNOS0FxM1hrcHNhRHJlZEJsdjdkZ1h6amNuSTJjTjNueHZo?=
 =?utf-8?B?Smd6d24wMjZQR2V6ZnQwai9PeEJJTjBIQW5lak8ydEtEd3RxdFZaaUpibGNp?=
 =?utf-8?B?WS9LVjMzL2tiaTZhMWRyZXN6ancyWEw5aXBSc0JtaDc1YWVNeVM1N0lOVDg1?=
 =?utf-8?B?WUtwKzJPOXdNYlQvZnlwWGtzZzg4bHI1NHpvTDRFVThqZHhTV1QyTmhFak9p?=
 =?utf-8?B?a3RWYWVVZE1DZlc5TmcvNS94L1F0WXpGeEl4UDlxRGRySUsxTHNDR0tLZ3pC?=
 =?utf-8?B?YXAwNWJVWE1FcXZDVTh0bmdlbnJISng3VlU3L2pXbGYvenAwczlmYk1EU1lW?=
 =?utf-8?B?My9xM1RiNHpwVTdRb3MyMEI4QUQ0bDBvbGxKb3QzYkZJZVhReUNwa3dmanNZ?=
 =?utf-8?B?dnV1RHhBcjJGNGFSV01ONnhibS9vdFV1RkxIVHdtdXR2OWF4eEQ0a2ZnNjhS?=
 =?utf-8?B?NEFGRjkzTGtwOENjRG8rdVJjby90aEgwOWxnYm40K3NvOGFGdS85YmR3TlZM?=
 =?utf-8?B?UzNnYkpUZVMrRUlUREREUnAxUkZtM2cxR2szWGJTdVJ2NHJQU3h4NUlpTHRD?=
 =?utf-8?B?Rllic0taZkV6cFlGemtvM09IekRHTThKWVR5TG5jS3NGZUVOc0JiMXprRVZW?=
 =?utf-8?B?VFZDNnFSMXBXcTFzYlBnN0FHb2dGMnBDQks0U2VaZHQyb1F4T1lURk9tajFv?=
 =?utf-8?B?NGFxQVdLL0NPZ2V0ZVRZa0YrTzRleUwxSXJ2bFpMTXZQMlFMOUVWYnEra2Ri?=
 =?utf-8?B?aXFPdGNNU09EajUyTTgraThxd3BENU04ZU5ITEtaaW05OG95L2lMVEs3OFp5?=
 =?utf-8?B?NjUrTVdhenl3aDlQeXhJaFV2OXVKczc0SDMva0t4dVhBd0Z3ZjF5Y2ZJeGxW?=
 =?utf-8?B?SzNEZjFxcS9tRURNQ2NGNGk2WHVjZmxLQSs5ZFBuZXJkUGVwVlRuZXRDbHFn?=
 =?utf-8?B?M2ZXeFNmWGREbnp1bTVJYmZsTW53T0FWeXdUb0p6MUtwc0tQYzFHZ3Nwamg5?=
 =?utf-8?B?WGs1ald4Tm5Sb2QzT2V5bDhDMVpPWm00c1ZmYktVWUwyWEFhZDB6SGc0Z2s3?=
 =?utf-8?B?eDV4d08vdWRwdUh6WFNnMmdtTlRZZXZZdVpyWm1va042cmVIczhzc3pKcjlX?=
 =?utf-8?B?bkFEbmRpK05ZWEJScTYyOWExYkdzNjhZSmJneUpUdVNZYnpaWHhnd2poYis3?=
 =?utf-8?B?QnNqdUxzUFpnbGs5dXhsZ1JHazQ4a0tnai9EL3VNTzR5ZXErRnA2aFFvWXNj?=
 =?utf-8?B?bG0xV3plTU9DYWl4VVFsbDVIUDZBWmRGbmlDUjVlanRZam1nM01pQnlmcmg1?=
 =?utf-8?B?d0FqSzhjWjRlbHVZZkxVcm80ZXRsUVhNL1pjZGxFSDZKQ0Q4aU5kdUxwNlhU?=
 =?utf-8?B?dTBpMDBxbzNlWEVjWWRSOGpMUDE2MzVBaGsra2ZjYk05eWVVZEJGMFNXTTN6?=
 =?utf-8?B?aXNQYjVqSkJxSUJjYWhMdEdGQVVsaUF5MEg0S0xyaGswcENhNytKVUtqMUUz?=
 =?utf-8?B?KzhIM3E4MDVUMzBpTUd5TWx5akFtM0JLTzhnRFMwYmMwR2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZndXckMzckhiS3ZyZUJBQytPenA2VmdzUDBIbnRTQ2hWVjc2aTBoTGhhb1hW?=
 =?utf-8?B?bE9TdVFLcmJwWFNxL1ZpUklSNzRpUUhlOTRzWHFTblFEZzRVRGdFSkVOSG0r?=
 =?utf-8?B?bzR2QzVNZHphQ2h3aDJJM2NQZkVyZmJNNUYydFZrQUlXeVVBNDdOVllhcjlx?=
 =?utf-8?B?TTJXR29TS05iemNWRy9KTnNEbWpwZEtLT2VsV1NTam90dXg4dDZ5dFRDempE?=
 =?utf-8?B?YlZJaGc0anVIdGY0RzB6cFRwdmN0RGdEQ2MyQ3lSbFJYUU44eGs0VVlyYk9P?=
 =?utf-8?B?UzROT0E5ektZdHNmV1lmZXFXTWtTZXhVWkF1TjdWZjh4bnEvRVhXcWhvNlFi?=
 =?utf-8?B?RWdpaGxxam4ycFNaUm1uSkY4QkgyWnljNHBadkFla0E4T3kzVnZUR0xwcVEx?=
 =?utf-8?B?VUprT20ydXpDemxGMkFNaUhGbDJ1Qk80MXByWkg3SUJPZFZiQ3BNTWc3U1kw?=
 =?utf-8?B?Q2ZzSWR5UTYrT0NGMkNncGM3bzRwSDh1ajkrVVd5QlNGN0FVakxFV3NWU3NV?=
 =?utf-8?B?OGsxVXJld2hHdnVmSWFPTjJPTXBMMzJwbUQwV3QxNGdJck9vSnhmc0R2Q0ow?=
 =?utf-8?B?RE9RbTFEK0FJSS9RR3pIVzRSSWUrczNmQ1AySTJQbElXUTNpMzFCMEVHS1Fy?=
 =?utf-8?B?b1pPaVh2K1lYbDB2N1hXMWx6TVRURFM0eksvL2xudlQzKytWN0dmN1hLTE81?=
 =?utf-8?B?SHpXa0FENlBja3dUQVNXL3MwTXJqdlQyNzB4WEJaTCtCRk5PdEJ5ZGF0RVJT?=
 =?utf-8?B?c2w5VkFKc1JXSWxOZXVGN0ZoUCtkcGUwM2JuaVFueUZZVzBSV1N3K2NKUHhZ?=
 =?utf-8?B?MU1jdDNHbGFZa28yeDc3VStpVll1VkplNkZ5YmxUdzM2NVpNcmJQVFByU09J?=
 =?utf-8?B?blNIdUhVWXFkdlB0encvaDBmbHRqRGl1NFBleVduUE03ejlsdEdMTnEzdUt4?=
 =?utf-8?B?WlJjY0VRenI3bHMvR3A0RzNGUGpQY1o1b3VGUFBCQS8rTDJnaGsyeWlVYnVS?=
 =?utf-8?B?Y1lvMENlRDVLd25NbzZuVHAwRmg3a0g0YWx6b3NiNXUxMnZ5RDc2blU4YmNn?=
 =?utf-8?B?bHZQZVRHdk9qY3pPK2FHNFJ4c0lKYTI1NEJUSWxzY3RJUmFGRURZZmxvZVZa?=
 =?utf-8?B?OWJhTlFuN1BHeXY0N21DY3dsTmxYOWdlOW5ybkRhVmJVSTV0TUJrR21reXZj?=
 =?utf-8?B?SGpxQXRrN1hEd2lCWTRtSlpyVnYyVTNLaUhMTTNjNDB6YXVOU2JYS3h3amZi?=
 =?utf-8?B?NjhFV0pJZjAzSWlYYWllSXo5M1B4d2pBVzJvRGVYT3M0QVZjVzR6NnIyUFdi?=
 =?utf-8?B?aEZha1lXZm1jVnA3UTFUYW1hSUw0V3h6Wlh4MjBvY0NzYTJiT0RGVGFuYk9q?=
 =?utf-8?B?bTNwTEVYNFM5QTNZR1Z0d003QzVJak9nQkJkeEU3eGcrQnZlamxvamJreElC?=
 =?utf-8?B?K1hySXpGVlJhSVVIS2pRd1RZb0piL254M2pOR2phRmt4aE10Tmc3d3NQRU8w?=
 =?utf-8?B?YVNHaFZzTjlYNlpBd3gzc091N0VWa1dnZlRQUzJTQ0p2TXE3UWJqbVdrVzNV?=
 =?utf-8?B?bkpSeFNpUDVKVnltbDdmdVB1RklDVkMwdDZNaEFPcnp6TXYwd3RQUlY0STc1?=
 =?utf-8?B?SWRXQXNJTVowbjhSaDRtWUdTblNoUkVlTm41MndJSVJzTWdxNFJEZEJQMGE0?=
 =?utf-8?B?WHJBVzhITEllNE1ZUldDNjVMZDhDS2xXamtzT1pHTW1zNmhaVEpDaDA4MlI1?=
 =?utf-8?B?OVZVV3JTQWJFNW9aQS9oRmcyVVJwei9lN29uZmV4KzFQMUlHRVdiREhrL0RT?=
 =?utf-8?B?dEtOWFBrWUhrK1FaZlpqYTFLdWU1VXp4Qk50TzNwaER6NkZnQnRON1h4cHN6?=
 =?utf-8?B?S3pCcmYwYWZlUGxUSVhNck8wNmdhZVljRlJCc1JSYVFTdDlDYml4SGxPcFhp?=
 =?utf-8?B?dW5yQTZNek53dWVDTGpMallrTy90a0VoMC9uVVJpeU5IN0tvdi9vOTZxZE9V?=
 =?utf-8?B?NG9pUGIvVnM0RU44S3JxelQ4eEVRM0V5RjFxMW1zNUttRzRKOGFEZ3VFdlQz?=
 =?utf-8?B?UUJrR21RbVA4N09TUEVRT3IrSzVQTFBBMlVNRzlUZk1QZFBhZzFnSUxyOXdU?=
 =?utf-8?B?eUVNVVRjanBYeWwxNTlERFhsK2hvK1QxdUFFSlBnQmxlSjhVS1JDRGFvTXc5?=
 =?utf-8?B?RXc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09730c8-4880-4729-570f-08dd6ec24541
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 13:04:42.0809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9hIyf4ah02kg8N9Rdgub2j9X4anfauYDH25bcyR0fd49G71/CzdCoxprgXfQ32ab3jXSejq+zubBPjLVLglM0dbKTF0KnR3Ue7DQvLtEyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15116

SGkgTWFya3VzLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2Vi
LmRlPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMjksIDIwMjUgMjowMiBQTQ0KPiBUbzogSm9o
biBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPjsgbGludXgtcmVuZXNhcy0N
Cj4gc29jQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3Jn
PjsgRGFuaWVsIExlemNhbm8NCj4gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+OyBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsNCj4gS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgUmFmYWVsIEouIFd5c29ja2kNCj4gPHJhZmFlbEBr
ZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NCAzLzVdIHRoZXJtYWw6IHJlbmVzYXM6IHJ6ZzNlOiBBZGQgdGhlcm1hbCBkcml2
ZXINCj4gZm9yIHRoZSBSZW5lc2FzIFJaL0czRSBTb0MNCj4gDQo+IOKApg0KPiA+ICsrKyBiL2Ry
aXZlcnMvdGhlcm1hbC9yZW5lc2FzL3J6ZzNlX3RoZXJtYWwuYw0KPiA+IEBAIC0wLDAgKzEsNDQ1
IEBADQo+IOKApg0KPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgcnpnM2VfdGhlcm1hbF9hZGNfaXJx
KGludCBpcnEsIHZvaWQgKmRldl9pZCkgew0KPiDigKYNCj4gPiArCWludCBuZXdfdGVtcCA9IHRl
bXBfdmFsICogTUlMTElERUdSRUVfUEVSX0RFR1JFRTsNCj4gPiArDQo+ID4gKwlzY29wZWRfZ3Vh
cmQoc3BpbmxvY2tfaXJxc2F2ZSwgJnByaXYtPnJlZ19sb2NrKSB7DQo+ID4gKwkJcHJpdi0+Y2Fj
aGVkX3RlbXAgPSBuZXdfdGVtcDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwljb21wbGV0ZSgmcHJp
di0+Y29udl9jb21wbGV0ZSk7DQo+IOKApg0KPiANCj4gQXJlIGN1cmx5IGJyYWNrZXRzIHJlYWxs
eSByZWxldmFudCBmb3Igc3VjaCBhIOKAnHNjb3BlZCBndWFyZOKAnT8NCj4gaHR0cHM6Ly93ZWIu
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC90cmUNCj4gZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdD9oPXY2LjE0
I24xOTcNCj4gDQoNCldpbGwgZml4IGl0IGluIHY1Lg0KDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0K
DQpSZWdhcmRzLA0KSm9obg0K

