Return-Path: <linux-pm+bounces-31960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8AAB1B174
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1839189CA97
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF477266EFE;
	Tue,  5 Aug 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QX0gUEpb"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010028.outbound.protection.outlook.com [52.101.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042421D416C;
	Tue,  5 Aug 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387529; cv=fail; b=KA0hdAQLwEuya/mMBH5ccleM6ldm0IOpqABkJuMOibKcT6sCq8RDFmNP5q9W6mJ/AMumj36nZDqC+6IlNDjyL91bSD4W49qtEKLd308bm0GxRYesEMplfLt6Mp+lHd4bil3Bzpo2AvVTJLYOzN3JiexjCTCDuoKn7vaX5nJf3W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387529; c=relaxed/simple;
	bh=AEWGAx2MY38U9thrDXwyX3On7j6eVBCS4sPG1hMFyhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+yrh5zPdSuOwh6GLw/lOXZjSWluWOL8rkrmAxYuYaKxqzCWrcPnZsg+WJ88L9h4sIb6yZlEoR6Zt9GK4DQld5cGTlw+4WSoBkxOG+XtRed8hntUdqotfV2Sluc2gRJjX50IPw3a/q5it/IWGYP/4b2H5fYnu9wUETI+PIjr70M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=QX0gUEpb; arc=fail smtp.client-ip=52.101.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3xQwPVMeN/dwXPWwE2m432fWyWT4J8tpS3tbp5d4liDX01/FOlnPU9ziyZZ50cnlz4wHxWkmWYFcJ6efHdXWqWQkn8AFlGwRRSWUNe1SWd0dkwuRMtQsyL8uYelKIVUAgoLBFmsULk4qWCiZGBpw7uwBpFiCU3HI6KV+HSo+zjibe5ymj7QserqtAzSW9sLXE+sfp21ARUs5StmUz5Za1BCPugU+eMymQfEygaUz50GvJGPE86Few07nucfs5+q91ynKAXE7/URk0jLkuZktclBQ1Xe5qs8kUVRxlz1gByAr188twnID+iIEmijAGkGnkxsRErmLyDN/2xKJ0PqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEWGAx2MY38U9thrDXwyX3On7j6eVBCS4sPG1hMFyhY=;
 b=lkaHIzJybGJvGSJmV04H3v2AeoJpoS+W2ZiPT6bvKycoxgPVjzFIbIiERv3fCbJ7bAyJeKXVeZd7SJaMSxHG7u4cO4OeaT5XQ7n9Unca5OvgphSxudMpxwvfYRNnvuM+ev8QTThUDtANwG3T91PMaRqU8EvHwl3kv97QEiAFZWi7vNvYW7k+0DjuSmAwKa3msAlrNrzRhU7ayhGBD78gvb98C5h8a5j3uYZLrQQagTF6NZX0sKtWDfUDWK1kPSYyM4oFEmEHAIJDNfActtNVtae475Yhk78/cCM+ORJj/HvHy03GfWn0SXoGFma5HlCOHf0h1CtX2AnFS1H5/wyt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEWGAx2MY38U9thrDXwyX3On7j6eVBCS4sPG1hMFyhY=;
 b=QX0gUEpb88gb47Ie5SP27cmsXPveJxn0o9pti5eIqaABTXvpSfvVkGGTThr/U3FpFHlxN3K0jNQdLkv00H/CttW2ybdOBFLB5zOJ2ajeMW8DH0tRdiMXEpi7uy6FlrGRyw4TQ7+8U+ZL+IEpcsEDrwtG4m2ObVsBomzeNB97HMs=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by OS7PR01MB14653.jpnprd01.prod.outlook.com (2603:1096:604:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 09:52:02 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:52:02 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, magnus.damm <magnus.damm@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>
Subject: RE: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Topic: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Index:
 AQHby0ai9SCDgo20z0y3b2QkXuPFT7RSraWAgAGApSCAAAY6AIAABXfAgAAH+4CAAAHcoA==
Date: Tue, 5 Aug 2025 09:52:02 +0000
Message-ID:
 <OSCPR01MB146470A6F76C3876F4E9AF388FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
 <CAMuHMdW0CTM+d-N0FgP=dKoSTdmRr2Rpg2Rtzj33gDk8qW+FUw@mail.gmail.com>
 <OSCPR01MB146471D101C6D66C1B81336A1FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <CAMuHMdV2DsJ5_0sW+f6anrqpr5kjLoe9w++E_xKJjdG7TJmGcQ@mail.gmail.com>
 <OSCPR01MB146472833398C4E61B9C5B160FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <CAMuHMdXw4XDkwBOqM47TKa8d_jHBMTM1ZGhK9qm5KQWDfGjGSw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXw4XDkwBOqM47TKa8d_jHBMTM1ZGhK9qm5KQWDfGjGSw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|OS7PR01MB14653:EE_
x-ms-office365-filtering-correlation-id: ab49a7c3-a2c5-4e89-30a5-08ddd405ba41
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2hQbFYyZS9jNVNPRWNOUDA3bDRvME1DcW16R1IxQU5mRlVkeEFTWTVxazRU?=
 =?utf-8?B?QncvMUt5akcwbU1iTG5JTzV4YldkMi94eVJwUUlNQTFoMGlvTXdic0tlY211?=
 =?utf-8?B?K2FrMDBWc1FzaFQ0RkVqN2I1ZXdLdGppdy85MURGNHlQaVZlQ1FhOWZHQ3Bs?=
 =?utf-8?B?ZUtHRWgyTE94djBtK1hDeUdwc3BLVW1FSHhQVmI4ZWlIS1F1cmFBTEwxK3RB?=
 =?utf-8?B?dXRiQ2ZDbVJndHI1UWxSOTZvUHhHRTI3U0xRWkpPdnY4TWd3aTduS1VQNzZk?=
 =?utf-8?B?dGd4L3lJOS90Q1NwVXNxMHZ6bTB5TEkvRzE3aURCV2MyUFloQUExU01OOHRW?=
 =?utf-8?B?VTBVemMxMmw5RlVPUWpNM05jelNodEQ3NkhLWG9XR2JQcUREMUp0TzRpTFZi?=
 =?utf-8?B?c2RDN1hqMXZ6ZGlVRldzT3g1Q3N0Qi95OHplcTNJZUNSajVYYTM4aHd2VzZW?=
 =?utf-8?B?c3liVkhiTEYzWWpuZ3NOS1N5QytSOG8wL0gyY05FQVJhSzJKZ3krTXVJTFFV?=
 =?utf-8?B?czNwQjNzQXBZUUVGUVB4OUFpdEZZaXI5QW92TmxuUUF4dFRpbnArVXhDNnlO?=
 =?utf-8?B?U09QT0F5eVY3VW56YTNmWXByRmxXbklqMkRadTNVQ2Z2eXdPNFA1L0RQWklI?=
 =?utf-8?B?TGFNaEtuWG9aeUo0MW5Fa01FNW1SRTJxQjRLNVV6ZjVaODlPUDVGd1ZBZytG?=
 =?utf-8?B?NFlkdEpIakFlaE52RVNscFZHTzh3WVQ4VXcvcHl5L1h5dzh1ZUU1a3U4ancr?=
 =?utf-8?B?eEd0QlZheERvdmdzZ3pRZzVwcGFCcEhqTGZUaVhmQURiRjJGdEpXWTM1bytY?=
 =?utf-8?B?U3JmSFFsY3RkVUFsMmJweG40Q0Z0cHlxd0RmTWV1ZWNOd1VRbnJwdk9hYXJG?=
 =?utf-8?B?ZGliT1o2TXBFZUlRTzdQU3BINkpmSit5bG94bWwwRFB1MzJSQ3E1TFRENENG?=
 =?utf-8?B?dUMzdW1melBBb28raTVFZWRTQ3lLZk1IRDlNdkFGZlNwRkVMUllNM3YxdkI5?=
 =?utf-8?B?VFpnUlFFY2dVNGxWcGZTUzhITGxVWnkyUnNNdFdoUlFsUDVucEp3L3NLUHVs?=
 =?utf-8?B?cjEvbkdxRDVGeWkzbWtqSzA3R21mRGdXdGM1UjR3RW5UN2NCWjB3dVdPM1Uy?=
 =?utf-8?B?SzNJNUUyNW5YV0djc0lOMUg2dXpGcjJqZlJVa3VJdXM5UVBKODVQN2g0Sk8x?=
 =?utf-8?B?c1lOdk9aWVpsbGFFZGk0OUVaVzVoeXhDNHlxK2cxeVNpZk5lcS9KRWxJL1pl?=
 =?utf-8?B?dkVBUWFvVzlKNWJCUUZwM1ZqMEU0ajQxVnRzeGVpaUNSTFQyaEQyTFpYMTFE?=
 =?utf-8?B?eVlOVUZ4OUZqNFFGUXE3SjI2VUpLWE80Szg3UlFPWk1jT1lYNEdhNllOeEd2?=
 =?utf-8?B?RGhieW9DZnJKYjFWc2FwSUlKb3JUYjVuYmJYek9BY21taUFBS2YvVXFzYlI0?=
 =?utf-8?B?UHpTSE5lVWg0QTE3OWVabkhSNUFGb2d1NVZaekdnbEtERTJwUzN2cUJTQVIv?=
 =?utf-8?B?M1JRSDg4NjA0c2RGL09idXJMdndqcGVsOUZiNmdrVzM2NmJ6Y0tQKzVtZ2di?=
 =?utf-8?B?RUZsb1l2bDFZT0RLNzlGTHdsRkQrK3NmSG5SR3BPRTlNS3BPdkRWSDM5S0o1?=
 =?utf-8?B?UHRKNjZST0VqV0xUYjA0V0hraVlNcHBzbUlRQzJQUE5tZmxzSk5aQ25Pd01r?=
 =?utf-8?B?ZjVmazhFWXBucVQ4MWxkRStrV0R6dkp6c2NZZFRZV2J0SHVXNmFLcnRRVVo1?=
 =?utf-8?B?UDFLV2JNUVAxS0lPZ00vRmZldUhEVFExWlM1NmUzT0NzTklXNnZJemsxTXVW?=
 =?utf-8?B?aHp3cEVUanRYWkMyYnduV2hwbEdwTTh4anFWY2w0TVR5YlpKbHRQWTZHNXlQ?=
 =?utf-8?B?eWtOejlxZWZOeVVscFJVK2FJSGtacDJFRXE3SWhkM1hCbTFEd3N2MmtZTi9J?=
 =?utf-8?B?Y09rbkx5ZElhVml5OUZ0ZktIbk5odlVIOEZVbG5uZWZ5Z29XU1BUdzQ3T0hl?=
 =?utf-8?Q?JGvgfpNhazKS+hHuru+PDgrD55s6dU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDFEdXY2TW1Gb1ZmNmQyREQ3STAzZUgwakNHbktlVkRuM3RJUjFXa3dvcFBU?=
 =?utf-8?B?c1Z6bFRsNFp0cEdralR4ekNlWWhXbm1ZM0xZN0hLRFdibnowMnVhNUhEMmM2?=
 =?utf-8?B?Rk0vWGlwUnhZbUtkODVjd1ZBMFJRVjBmU1I2SlpTMFpRT2xTWGtaNnBTSzJz?=
 =?utf-8?B?QWVDVzlRS1h5eGdNZVBMMHJSa2sxRk9tYzJxQUxDN1VNd3g5QzlzMFFtbEU2?=
 =?utf-8?B?NnF3YXZRaGFpcFNZUjdvcWhnMzFMeStLMytXMFBwUFhkTUtyT3BzbE9mRTY1?=
 =?utf-8?B?bkI4cnEyMmtEZkVFOGE2T2lnZ1RoLzg0WERDRnpTZ3UwT1ZSamlpSXRoMCtO?=
 =?utf-8?B?VURreTNrbnJuQi93ZGYrWUpqNlRkWkc5d2RHQVluWXBZYmNGWVFyWjZ2Y0FW?=
 =?utf-8?B?OGRtcjV3WEJqSGp5d0V2cEw0Q3d6TlZUZnZZYndLaDBtT1lNTFZBSC9tdUF0?=
 =?utf-8?B?VXF0TWdvTmg4blNJeUZsNzlBZi9vakR4WXJSNEY4NkVNaldHY05TZkpJSVl1?=
 =?utf-8?B?blo0MkxNYXpVbnkyWkpUc1U4NXVQNFR6eUc4MmxGZmNoOVpLejBFcUdZVXcr?=
 =?utf-8?B?ekJJa1M0eFE1cll3TnQ2eko4ZlBsUFhTRmN2UWVYazB0RjZWbWM1Z1V5VzB1?=
 =?utf-8?B?cmtFZHY4V0RpUzlpdlRYRGFicmZmYStvcXdpWXdBdVQ4cldvU2g3MzNVQ0xU?=
 =?utf-8?B?ekU3Tm12V1FkUGJpRkdwZW4xUGNFSTZwV1p2VWNFODV0U01YaGZHNDFVdU5r?=
 =?utf-8?B?dVRqUW9lY3Z5dHZURkxESU1qTU1CRFF5bFUrYi9CS0d5ekJHTHRYRjFPZkxH?=
 =?utf-8?B?aFE1MTRTdnArNTVUbkwrVWlseVF2WmFMNkhiY002bS9BcUREemhpOTh5Q21k?=
 =?utf-8?B?dTAwTkZiYTQ1d3BCdU1sUDNMc0pzUWVxbG5Qa1ZCUk92NlBFM2hFWEdqMk1U?=
 =?utf-8?B?dEhIYVdNQnNxQ2IvVmFicituQ0ZKUGExMCtVTHBtZUdLVnl0Nm9xODNUaXpr?=
 =?utf-8?B?ZFhKeXp6RzlqNTJWaTE1b3MrNllZSC9hc2JKQmVXczdMa3o3Ti9CVlpibzlH?=
 =?utf-8?B?c2JaL2h5Yys2QXdtUk9uZEJaS1lscjBHNFp1d2FDUEd2SjNBbEhWcnFWczJK?=
 =?utf-8?B?L1ZYZjlYU3RZcmpEUE5pWlBTVnlvdllBOThoMmk4aFJMRDNMVnZrNEJEbXho?=
 =?utf-8?B?Y0tQNVFUYnhlWGQwNzNMQm8xMXV3MVBWQllLL3BNRHZYWGV4WTNiUUdHdVpz?=
 =?utf-8?B?cnVvZWlja2ZZY0o2dXFEMG1JcjNBM1R0eUNKNGJUSHczVXpTdXFab2RKUDlB?=
 =?utf-8?B?cllPcmZab0NucnA3L1NnZTJDZkl0Q2dVV3d2VndmaWR4UWd0VDQ3UndaZzN3?=
 =?utf-8?B?YlBMZE9uMC9qTW9VYzR5M3cwYU5nNHU1cit6MFdZYktnL2FFWlR4SU9HcC9P?=
 =?utf-8?B?ME1mVDBuWENnRTFXZTVYTExoRVh1YXR6WmFTN0pvaUpWeWs2L3pFaE9rL2RM?=
 =?utf-8?B?VnN5aTJvZ2lvRkU2RnZOR3M5YnRLeVpnVElRQmVLekhpYS9pSEo3bjVNdEpJ?=
 =?utf-8?B?MStGYW5vNUkwcEFsUTRHWVZuNThuYjlBRW1pWmk0SWQyM3BwOGViaGl6NlRa?=
 =?utf-8?B?UlFTUWFRSHg2KytMZ0pjTzlvTWgyZEYydlI4bS8vbWNwSmIxL1Z4OEVERUlU?=
 =?utf-8?B?T0tqcDNYbHNOVzdpb0Y3aFR5U3Nqa2RkbGNTMWxHN2JaaWhHRURIaXNQWkQr?=
 =?utf-8?B?V0RrMWZqN0dTZXVPNjdjY2QvNFMvMG5TU0sreituZGlreDVaUFlsMDNNdm5k?=
 =?utf-8?B?U0hiMUIzNmUydUlqalplTVR1VmVTWEd2aEtyUHVjQ3p3aUFZa1R4YlVUdjcy?=
 =?utf-8?B?aFpIVUpua0pzNUlRUlY2M3VlTTZCVklrRXpURWk3RFV4ei9JZWYva1hXY2dx?=
 =?utf-8?B?Tm0xdU4xV2pWZWVSbFpxcDdvV1p3YlFpVWI2QVlFUmNKWTFEcDNWOGVIRWJk?=
 =?utf-8?B?b2FCMm43VGt2QmdkbVBUVGVVTklMVzBHK3ppQTh1cmViLzF2Z0srRkk1TWxy?=
 =?utf-8?B?cENJcDc4NDdYR0hkdmpndCt0blA3SWkrbk83dVFMWE83eXFWS2RJdlhwY0Rs?=
 =?utf-8?B?bVhhdGNuYVBnNkM5QWhSamgrTEtlcjVTWHJ2Z2I3eThKVEp3YUxaWUJRVGY2?=
 =?utf-8?B?dEE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14647.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab49a7c3-a2c5-4e89-30a5-08ddd405ba41
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 09:52:02.0788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0GbpgsnALqQWGRQxPin63q/sJH3+K1DMsILaF89eILhJ0kADSkkyI1YOYMPehaVM9IQ9RM2ONHynYdGyZjGitMVEQOyGmFrHAo1wzwmV+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14653

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXVn
dXN0IDUsIDIwMjUgMTE6MzUgQU0NCj4gVG86IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBi
cC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAzLzVdIHRoZXJtYWw6IHJl
bmVzYXM6IHJ6ZzNlOiBBZGQgdGhlcm1hbCBkcml2ZXIgZm9yDQo+IHRoZSBSZW5lc2FzIFJaL0cz
RSBTb0MNCj4gDQo+IEhpIEpvaG4sDQo+IA0KPiBPbiBUdWUsIDUgQXVnIDIwMjUgYXQgMTE6MjIs
IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+
ID4gPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiBPbiBU
dWUsIDUgQXVnIDIwMjUNCj4gPiA+IGF0IDEwOjI3LCBKb2huIE1hZGlldSA8am9obi5tYWRpZXUu
eGFAYnAucmVuZXNhcy5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiBPbiBUaHUsIDIyIE1heQ0KPiA+ID4g
PiA+IDIwMjUgYXQgMjA6MjMsIEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2Fz
LmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IFRoZSBSWi9HM0UgU29DIGludGVn
cmF0ZXMgYSBUZW1wZXJhdHVyZSBTZW5zb3IgVW5pdCAoVFNVKQ0KPiA+ID4gPiA+ID4gYmxvY2sg
ZGVzaWduZWQgdG8gbW9uaXRvciB0aGUgY2hpcCdzIGp1bmN0aW9uIHRlbXBlcmF0dXJlLg0KPiA+
ID4gPiA+ID4gVGhpcyBzZW5zb3IgaXMgY29ubmVjdGVkIHRvIGNoYW5uZWwgMSBvZiB0aGUgQVBC
IHBvcnQNCj4gPiA+ID4gPiA+IGNsb2NrL3Jlc2V0IGFuZCBwcm92aWRlcw0KPiA+ID4gPiA+IHRl
bXBlcmF0dXJlIG1lYXN1cmVtZW50cy4NCj4gPg0KPiA+IC8qIG9yICovDQo+ID4NCj4gPiByZW5l
c2FzLHRzdS1jaGFubmVsLW1hcCA9IDwmc3lzYyBvZmYxIG9mZjI+Ow0KPiA+DQo+ID4gSSB3b3Vs
ZCBnbyBmb3IgdGhlIGZpcnN0IG9wdGlvbiB0byBtYWtlIGl0IGVhc2llciBmb3IgVjJIICh3aGls
ZQ0KPiA+IGFkZGluZyBzdXBwb3J0IGZvciBpdCBsYXRlcikgc28gaXQgY2FuIGNob29zZSB1c2lu
ZyBlaXRoZXIsIG9yIGJvdGgsDQo+ID4gcmVnYXJkbGVzcyBvZiB0aGUgaW5kZXguDQo+ID4NCj4g
PiBXaGF0IGRvIHlvdSB0aGluayA/DQo+IA0KPiBBcyB0aGUgcHJvcGVydHkgd291bGQgYmUgcGFy
dCBvZiB0aGUgVFNVIG5vZGUsIGl0IHdvdWxkIGFsd2F5cyByZWZlciB0bw0KPiB0aGF0IHNwZWNp
ZmljIGNoYW5uZWwvaW5zdGFuY2UsIHNvIGUuZy4NCj4gDQo+ICAgICByZW5lc2FzLHRzdS10cmlt
ID0gPCZzeXNjIDB4MzIwPjsNCj4gDQo+IGZvciB0aGUgZmlyc3QgVFNVIGluc3RhbmNlLCBhbmQN
Cj4gDQo+ICAgICByZW5lc2FzLHRzdS10cmltID0gPCZzeXNjIDB4MzMwPjsNCj4gDQo+IGZvciB0
aGUgc2Vjb25kIGluc3RhbmNlLg0KDQpXaWxsIGdvIGZvciB0aGlzLCB3aXRoIGJvdGggbmFtaW5n
IGFuZCBwaGFuZGxlL29mZnNldC4NCg0KPiANCj4gUC5TLiBQbGVhc2UgZG9uJ3Qgd3JpdGUgIlYy
SCIgb24gaXRzIG93biwgYXMgYm90aCBSLUNhciBWMkggYW5kIFJaL1YySA0KPiAgICAgIGV4aXN0
IGluIHRoZSBSZW5lc2FzIFNvQyBwb3J0Zm9saW8gOy0pDQoNCk15IGJhZC4gV2lsbCB0YWtlIGNh
cmUgb2YgdGhpcyBuZXh0IHRpbWVzLg0KDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJo
b2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4
LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2hu
aWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxr
aW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0K
PiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMg
VG9ydmFsZHMNCg0KUmVnYXJkcywNCkpvaG4NCg==

