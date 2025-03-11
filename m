Return-Path: <linux-pm+bounces-23839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B0A5BF63
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 12:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA453B30E6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF6254879;
	Tue, 11 Mar 2025 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OGXbuutw"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010030.outbound.protection.outlook.com [52.101.229.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE9253F3B;
	Tue, 11 Mar 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693281; cv=fail; b=q3fmPnXbio8eYWrp4CDt9x02SYl0oHteDVlaOlo06h+/JmK+EeMSlM8hLsHCRS0/DNRhxFXubrkqSS0gSUugYQGyIm8FnHK2YrZjIPQ4Aek94HyignvwWzMWf1EyWRUkGCceIp2vxtT7ZU0cPhD5+Vk3zYLmu5U+SOnoQTlZ7iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693281; c=relaxed/simple;
	bh=RR/BMh2OdN64nVFfytiA930XiQf3cerCT/O+l+u+1wU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iuDs2V2ZRd/oF5ZTUWHj/lxhdtUvCWOVl72akPNGnEtOdzdAQxJRVJRyOaTLPq/5gbT7dyxBuHKrWAmukVb9Kr5cJ5KmrgJmHH3pkuGCQV+xCV2+z6vWfMPuDguqhOSnU1uH/FPEU/afzQMVbXaayjdo/ZuFrYtlE22j2SEGTM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OGXbuutw; arc=fail smtp.client-ip=52.101.229.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeJLaz0KEHdAnJZJCkogN5Q1TiHbfZDqxoCS1xsyPXSuJPthIv+WPK3LBFOsr1vRSB6ZLpw5rZ2QDNyLpKkAOzKpK6wEAIBXKzuCZZDASAFvMIptIlloTt3dtoGyhclfSxv8GXkOgPFmR8/p+uDbWdTJ3xrHAkyGKUY71/Le18xkpLK6k0r3V0ub1J24Fg0VI7dQwEt9EyERi0hc02Xw58X9S7CSvfxUj/wwofgXZxkpTHlVPa+nBl8cfht+44jm6LY23Weg2olgQUPvMb6Se9BlWXjystocaBfD5FIUW/5rS37j9/fcSRJg2uDvBtL2czaoGiScB7H6xO9y/4uUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR/BMh2OdN64nVFfytiA930XiQf3cerCT/O+l+u+1wU=;
 b=ozIgeK5jIw8jlqECVpm1b9v7+fWQwMjqX82DrpgSxmhUPPHb0EhfRMOj4UasfKny8maiiwM/d7a800IrYtU/P7UhzOcG8nePmOSxxlBTTN+oWq0ROG3fa4v/6RhE/1JBejsuSQQRA5QGjRKKkrCTRcHYsc3HWyDfv2IDJFqt3tjsGQY+T4zWy55LvedwpUbHw8sZ3t3sLIKHwtk2po2O9UHO9cNv4WvB2YRjQnctb3iLNtPwC61/wzfDT+qBugDc3hOtd7HSCLH2iDQhIUyQQb7s91CWDvwpgu/ca6AtoPQLwVZBeSFMEhNyzVJBVwtn3Js+QANNgllS0yArlAik6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR/BMh2OdN64nVFfytiA930XiQf3cerCT/O+l+u+1wU=;
 b=OGXbuutw17x5K0VwNZs/mK3nlwEucQ3F8SJhZOKgR9g9MOKAjxBJcfI3EtSO0kHaE505MSANkBDg96wLla+yA8QvBjlfMEbBDE5kv9QulROQEzQ8ms9jwut9/iTBKUhyQ1xFr859+FnCQoEWhjwa2bppwpHJUCL39nzGukQ95So=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TYCPR01MB10414.jpnprd01.prod.outlook.com (2603:1096:400:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 11:41:15 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%4]) with mapi id 15.20.8511.025; Tue, 11 Mar 2025
 11:41:15 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Biju
 Das <biju.das.jz@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [RFC PATCH 1/3] thermal/cpuplog_cooling: Add CPU hotplug cooling
 driver
Thread-Topic: [RFC PATCH 1/3] thermal/cpuplog_cooling: Add CPU hotplug cooling
 driver
Thread-Index: AQHbkOyzMk7go+0SS0ecPf0EBnfnzrNtnSeAgAA1duA=
Date: Tue, 11 Mar 2025 11:41:15 +0000
Message-ID:
 <OSBPR01MB27750EEBDC394321FEB84B1EFFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
 <20250309121324.29633-2-john.madieu.xa@bp.renesas.com>
 <CAMuHMdWV7CNBJbPKpymBvvQTbHcpSYFA7DfbOr27CRwwGxh18A@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWV7CNBJbPKpymBvvQTbHcpSYFA7DfbOr27CRwwGxh18A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TYCPR01MB10414:EE_
x-ms-office365-filtering-correlation-id: c6d69289-500c-4221-3026-08dd6091a198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTZPSE13SGI3aGdYVjl2SGtPeHVBWk9zdkQ3YXdwQS9MYitqcWg5YUozdy93?=
 =?utf-8?B?anIyL0R6VHZnKzAyWVFxNmx2TGg1amhXdFhhN1llZ3VxTlNQSlpidFkyaFZB?=
 =?utf-8?B?QTMrdUE1ZTZlbFQySy9vY0xZOSszeElWTE5BYTNkb3lPOGIraFJNeEx0RmtH?=
 =?utf-8?B?SU43Ri9hWndHSWRKN2FLbDVxREJvMHRqRlpEYUh1Y0s5ZjJpd0lZRzBSV3ZV?=
 =?utf-8?B?aUliVk12bUNvVFY4eWFQL0hOZmJYb1Y3cHhLR25WYzdjd2U5Z1FHWlBlaFVh?=
 =?utf-8?B?bllhcHZUWGhoUkpBNmZueWJxWlZrdE13ZkZlSjEzamU4UVVlWitxNVhiZSs3?=
 =?utf-8?B?dGozVW9GejNVRUZrL1NvMlB2OVpiQzlnTFNvdjVWTUdhcGlxbFpJNzJpTGVW?=
 =?utf-8?B?ZXl6aTZtOXlLczRhQ0F1b3U4UVdDWG5ZVm9Tb0xZRVg4aTF5alJieUhRdGQ5?=
 =?utf-8?B?OU9IaElXNHVrUVQxSlVwUHpZTytDNDhZRVdiNmlkQitFMytYczBiMDN6UXdy?=
 =?utf-8?B?MmRiRzBaT1FpZVlHUEw5c1NvWS9Ed0hSRUFJS0VidzVXby9xYUhJMUtZRnZr?=
 =?utf-8?B?aVdYZUhjM0Z1WFNUY2t0K3I3Ung4Q2h0ZXJmdE10U1VhZnd1bFFGT3NycDlB?=
 =?utf-8?B?eTljNTRmWW9xRzZQTWZpT2hiekg2Wnp6MzZzZ3VXOUQ4cHUzWGlQZ1VhNC92?=
 =?utf-8?B?ajhxaEpqK2dYVTBrc21JMEt6b2N6em1tcWRIU1o3SWZ1VE13U256czNWdHFL?=
 =?utf-8?B?b2dvTkpqbXFIWlI2NW9JMEhSOTM3cXhKZkpOQWR3Q1NLWUdET1R5enNJN3Qx?=
 =?utf-8?B?OE9FaWgxMmVJOEd1RUFGV0dHSTRnSTRtMWlucEV6MjQ0ekJVK29LNjZKSmhF?=
 =?utf-8?B?N3JsdDVsUzV1VFhQQ2RLM0tkSnRzQWFGVU95TzFVRXhPSU1nMXBGeVFBM1Jj?=
 =?utf-8?B?L21RdCtqZmtiL3VRZHN5V211Y0c4T0ZpNmJHYlFVd2ZnRDN4ZW84RXVDY3lV?=
 =?utf-8?B?bHgvcU1uU0hCNXRUOWVEOWtvN0ZlNHFMZklmeTRneXRPclVjRTB4bjlVZEF5?=
 =?utf-8?B?bmVrZ212amtkS29wZitBWFUrUjBNbWl5dmlvR25JYVBJYnhOWmpkamZhYWtj?=
 =?utf-8?B?WHh2MHhtVG9ENmFKeHRTT0hkdURVb25oVnRSZCtkak5jdXhDTGxVenAzRzhN?=
 =?utf-8?B?ZFduSnpNOEkzWi81VGo3OEVQTGRvemloeEt3dTJFZlhvQ2M4SDdtRHFCUEwr?=
 =?utf-8?B?Y2hGQkcxdlFsWDdHUGpwQzN2U3VHMUQyQzVlQTJTOWZoN0ZQbTgyWVNTWmtJ?=
 =?utf-8?B?MkRhbE5KdmNSaEdNYXk1LytZR3I2U21sc2RONWVEMHUwQ1lBSzdaa1pvakx0?=
 =?utf-8?B?cE5ON01pck5jWkM2Y2RWaDdxYnFKSUZJUko3U1hTd05iR28xQjVRR2xWODdy?=
 =?utf-8?B?bisxUGFzaHZSUGRzNnk4ZytRenNLVW9kclQ1ZTI1dEZCNEdtR3FUSDZJSGhD?=
 =?utf-8?B?VU9HaFhTeTY3OHBUQXpkSXBtUytGaTUyNEpYQlBPck11UzRBRHVTQTlkOUh2?=
 =?utf-8?B?dDAxT0x5aXluVjV6b2M1eE5XbWNJUksyU1BTOGcwUVcrUDR1ellMaVRKWVV5?=
 =?utf-8?B?UkZlRnFJWk5WemVld2tobXJlUE0wYklPdTVpWGVsdk1ZUFJWRHdralJNVUdr?=
 =?utf-8?B?d1RrVit4UmJ4K2wxUE4vTDVKUXlNVFpKL0VTTGNzNk5xeStNYW1IU2pPdmkw?=
 =?utf-8?B?TG1yL3lybExNZFcyT2liWlFra3pLQ1VTSlQwRkcwMzhLdjJmR0RWdHNmcXNO?=
 =?utf-8?B?STlIMVJrME1JZEg5TVRtZW5tQ05DdmQ2cUlsTFE3L3FMQUs5Z05LNzczZHFS?=
 =?utf-8?B?Q1Q0Z1RQTWMvcERjWWtOdHNPRmlWNDlndzl1S0t6eU5WVzhlN2dCNnpPWCtE?=
 =?utf-8?Q?VQgWzCcYSqz4aE2zdXCqTgp9nupSYWlH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWdCbThrbGhOcCtOeENTL0dPVWdqbHhtSVRQRFNZV3FHcm5aNkJYZFc4djdZ?=
 =?utf-8?B?cUt3S20rTVE2QkZ3YXc0OU5WYUdNOVlUZ0J5WGVqSldlMjFpUG5jWVVqcVNR?=
 =?utf-8?B?UGkyQ1hUMlo1aURXdFNaTlhrcHliMU1JM1dSMzBrZDBKeUZhSEY5aWJYTE9B?=
 =?utf-8?B?NWJUZUtSUDYwUFVuV1MvWHZJd1MyajNidlNMMHd1SjlGTjFTUm1YNHNIZGJT?=
 =?utf-8?B?YU1ZL2ZKV0c4cXJDSHo0M1FoRXh3YWVCbVduT3BSL3FESGhmUVZ3QnkrNTM5?=
 =?utf-8?B?ZStsZFZMYUd1ZHZVcDh2MGZDdWd5bldkd1RQYlhWcnFDN3RnbFIzQ0FYUGpx?=
 =?utf-8?B?TnNRL1d3ZHhnQUwzWFhmR1A5TmI2SUJtOHdOMFluMFFPTktlTFB0YjR2bGxQ?=
 =?utf-8?B?dWdtNU5rN0FUclM1bkc0aGg3dVZiK1V3V1BZdEt4UmYyZVd6QnRhcUx0L3pU?=
 =?utf-8?B?L01YckQ1MWwrU1pQd1pnK1hUWktXaXBhc2hhMUpsMCtCcnIxQkhQNjhxZkcv?=
 =?utf-8?B?V1pLZWxyU1dhT2xlYi82VFpoT3RaZzNCVm80K0JwQjhQV1NDK2F5a2kvYkY0?=
 =?utf-8?B?TjR5RFpkaC9lekpMaU1zZmx3a1ZsNkxFbVBnTG11bUlPd05GZnJ3SGNzSDNZ?=
 =?utf-8?B?Rkd0VEtzYWtHaE1JcldjWlhtWUtsenN3Rit3QW5leFlYaHo0NDFEMXdiZjFv?=
 =?utf-8?B?TGlld20vajRjc3dKVXp3a05mMkwveUJkS3VWak42NzZCSE02SUFnMytRUlBO?=
 =?utf-8?B?M083bHJYMmVlVzNLa2Z1Y05SaTdNaTY2UysrRHE0ek44VVVibVN6akdQSGZj?=
 =?utf-8?B?NERpVXZCNXNJNE1qczRwZlhERVo4L1NHZ0tDL3FGU1lpT2xmZ0piZ3NGOVZ4?=
 =?utf-8?B?ek80dFRiZGkvZ1ZYWExLbVlFZWVZK0t4U1pFQlI2N0F4aHUrVER6R20rT2JN?=
 =?utf-8?B?ckxBbzJjRXFkRm1vLy91dUI2TGlJakQwcEk3R0xMZkxaWHppNm9WcTJGbjZV?=
 =?utf-8?B?ODBBQ3BRaG1SbzZNYXVXRndMQ2xPQ2pJbnluMGVWaDkvR1gzS3BMeEtlTThD?=
 =?utf-8?B?UTNHN3ZkVzhBZitLK1lSTlVkWEVPaGRleFkxNXB0ZUcvVG9TVndVZ1hOSHpt?=
 =?utf-8?B?OEtoYWt6SEh4SXIzYkRCNTNrZnlrM1ZZT0o4SDcxRDRyTmVEclREMCtLZEVx?=
 =?utf-8?B?VTQ3YnUxbkVXU2dBdDl6NzRkYjN5c1drK1lrRW1WZm15bnZGc1hqdXh2OWdp?=
 =?utf-8?B?YlJQV1ZiMDNxZmloS0x5VGZlL3d5d2NXRy9LMnhTTmdnNWMzL2ZmZytVN0JZ?=
 =?utf-8?B?SG1rSjZ0Z1UyRE5LM0NLamlieit4V1ljL29ZYWIvaU85Zm11Z0lBeHd3K3ZN?=
 =?utf-8?B?empwRkwwOUQvUE03ZFNwblFHYjRFQU91VzVoM0JiSU42eW91VDQrNVJwc29x?=
 =?utf-8?B?eEVieEdLNy9SWEFUZU5xeWVXQmo4VjRCUXJCa1cwcjdzNlAwK2diUjgyendR?=
 =?utf-8?B?UW91R2tVazA4RStUdFdpUjNJaEdJa3drbDYzY0xtS0Q3ckVmR01wZlVrdy9L?=
 =?utf-8?B?bGo1TjdiVjZqMW5ZNHZYN1E1OXJLblBQdEREanQycGJIaGFVcTZGS0Z1MU1x?=
 =?utf-8?B?Z09PUjB3WGsvVUdoMUJ1c1JEenNMNDU0dnVuSWZDdEg1bXhXd2NITEtPTm1p?=
 =?utf-8?B?S2FhcTFtdDVCemdGUTZ3YlA3b2JGQm0rMU5mUWlCOXQ2cm5xMTE1U2tUK3N1?=
 =?utf-8?B?YkJyRFlxSC9oVlg2a0FjeGRKNjRwZGZVY2pBc2VBVVBuSmhOTXZLc05jb3g3?=
 =?utf-8?B?TEY4L1g4ZXRLcDJKM2hCKzJmQW1ldThxd1RLUXdlM2lleUJWSXpCdzl4RlZH?=
 =?utf-8?B?TlpONm1DVkFva1Nid0NxTHV0N1VveVhPMjZ4NHY1T3FNMDdYTDlxOGtLWGRH?=
 =?utf-8?B?WjlNdlY2dVhldFpGRC9nSCtCcStuRFZWV3l2QTAwd1IySTR5WEpPa1E0eGhB?=
 =?utf-8?B?TXBTNHZEb3lzaEpxaFcyT2JiZEVORWx6c0FsUmtxZDltc3BJWEcwa1JnZTkz?=
 =?utf-8?B?MTZTMEd0U2ZrVVZOa0JrUnhHTUFWY00zaEQzVTRYN0Jxb3FTdmlsT09DM3Jx?=
 =?utf-8?B?NzZnNHFHVE4rMWdmSnFmUHlHdEtZMytZZS9BZktIY2ZsbDhJVExwaiszR2xZ?=
 =?utf-8?B?K2c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d69289-500c-4221-3026-08dd6091a198
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 11:41:15.3499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrcvHuOcmxEIrhv2U5IefrOlT/W2FKbcB8iTAVBdMQTcRt02y7JWD/r90HZWrvBlr2P4PsFnWwZKvArqjOHk0CHZIHnuDUmoJodYSy1og8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10414

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTEsIDIwMjUgOToyOCBBTQ0KPiBUbzogSm9o
biBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1JGQyBQQVRDSCAxLzNdIHRoZXJtYWwvY3B1cGxvZ19jb29saW5nOiBBZGQgQ1BVIGhvdHBsdWcN
Cj4gY29vbGluZyBkcml2ZXINCj4gDQo+IEhpIEpvaG4sDQo+IA0KPiBPbiBTdW4sIDkgTWFyIDIw
MjUgYXQgMTM6MTQsIEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4N
Cj4gd3JvdGU6DQo+ID4gQWRkIHRoZXJtYWwgY29vbGluZyBtZWNoYW5pc20gdGhhdCBkeW5hbWlj
YWxseSBtYW5hZ2VzIENQVQ0KPiA+IG9ubGluZS9vZmZsaW5lIHN0YXRlcyB0byBwcmV2ZW50IG92
ZXJoZWF0aW5nLiBJdCByZWdpc3RlcnMgIHBlci1DUFUNCj4gPiBjb29saW5nIGRldmljZXMgdGhh
dCBjYW4gdGFrZSBDUFVzIG9mZmxpbmUgd2hlbiB0aGVybWFsIHRocmVzaG9sZHMgYXJlDQo+ID4g
ZXhjZWUgYW5kIHRoYXQgaW50ZWdyYXRlcyB3aXRoIHRoZSBMaW51eCB0aGVybWFsIGZyYW1ld29y
ayBhcyBhIGNvb2xpbmcNCj4gZGV2aWNlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvaG4g
TWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3Ig
eW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvdGhl
cm1hbC9jcHVwbHVnX2Nvb2xpbmcuYw0KPiANCj4gPiArc3RhdGljIGludCByZWdpc3Rlcl9jcHVf
aG90cGx1Z19jb29saW5nKHN0cnVjdCBkZXZpY2Vfbm9kZSAqY3B1X25vZGUsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBjcHVfaWQpIHsNCj4gDQo+ID4g
KyAgICAgICBob3RwbHVnX2NkZXYgPSBremFsbG9jKHNpemVvZigqaG90cGx1Z19jZGV2KSwgR0ZQ
X0tFUk5FTCk7DQo+ID4gKyAgICAgICBpZiAoIWhvdHBsdWdfY2Rldikgew0KPiA+ICsgICAgICAg
ICAgICAgICBwcl9lcnIoIkZhaWxlZCB0byBhbGxvY2F0ZSBtZW1vcnkgZm9yIGNvb2xpbmcNCj4g
PiArIGRldmljZVxuIik7DQo+IA0KPiBzY3JpcHRzL2NoZWNrcGF0Y2gucGw6DQo+IA0KPiBXQVJO
SU5HOiBQb3NzaWJsZSB1bm5lY2Vzc2FyeSAnb3V0IG9mIG1lbW9yeScgbWVzc2FnZQ0KPiANCj4g
YW5kIGNoZWNrcGF0Y2ggaXMgcmlnaHQsIGFzIHRoZSBtZW1vcnkgY29yZSBhbHJlYWR5IHRha2Vz
IGNhcmUgb2YgcHJpbnRpbmcNCj4gYSBtZXNzYWdlLg0KPiANCg0KV2lsbCBiZSByZW1vdmVkIGlu
IHYyLg0KDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsgICAgICAg
fQ0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBHZWVydA0KPiANCj4gLS0NCg0KUmVnYXJkcywNCkpvaG4NCg0K

