Return-Path: <linux-pm+bounces-31945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E92B1AFC3
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC31E7ADE8A
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26878242D87;
	Tue,  5 Aug 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tk7sU7j2"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010029.outbound.protection.outlook.com [52.101.228.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0371EDA09;
	Tue,  5 Aug 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380184; cv=fail; b=FIyjOJJeaxELVRi0RiZhf0Bs2oB3ciQH0EpazRuQhdLaXMHibqp9O9NTcIYXoHoZIOGUd077Zhd3x+QAUT99ifoM6D4lKNS4h0ZDCkndKXaqNee0XWZdz4DZRXqX1ub/4DLvbD4OV7RLKE3ym8Zp/5imWAxhBpSoBBJ23fUsKfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380184; c=relaxed/simple;
	bh=5e+NgCX00cRDAl8chrH0a+iw6m2zf25IXwrQaUhB9aE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EV5IKHTNHdC7eErnWTkOj+S08x7dqah/lezJFZE1/x8uu2xJMJEY1LNQP71+6ydbx1GZ5vgz9/lFd5SsMuOSay4OSjdto0gdOvfibbKhDMB0z5CzA2n6H7nCojv53LlRTLANmiB51Of86QKktwMzFdfciLUw7mpZefO0mJbmLDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tk7sU7j2; arc=fail smtp.client-ip=52.101.228.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cne/9u82cVQMpfWHdUDeorRABtffrYJfZJ+vbeqn2V25pwqiFR1Fmai2A5P5xHwDYsmB+VFSKdl3vpEJXkagg6+cFXZFde/U0z9f71gGlUk8LcOorsdkItdGPy1uzbbbUklJA22C9CPo4W1mEHQRvUVAcZRxyeavG5YIgBzAOMWFw4XOJVfyM4Plu4gqQ48IQpb3rXz/YMxXLG1QuwmX+WYLf/vvq6tTpRTKOWS4x5PG5KfS0XVUXKwESzHudZfchtJ1TcDQ7zdQCNwJkBF5/73jfGPaWvU5pdDxu3AogYiLlKS/l/F3iiIh/f+mQSrKexrIaCRIaB/CRNrKPRPRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e+NgCX00cRDAl8chrH0a+iw6m2zf25IXwrQaUhB9aE=;
 b=bHTsYcO+zyFsyF4FGHBC1aXTWqG5IQQ3pZdHVRiB1CqTY6k87Ij9jgl3NsCMkMSbO/lHN6iVG5B244eL3wTWbD+Uj3IqgqQQkjk81xl2xQCSZ2CQT1mtPFTw+zuZsF3BbS4OpJddwry6Pc4mcfwLMBfSlJq3QaItPbv3NXpjlZEC540uj5jLvk0Qeb5qAyEJIF/b3FXqEArIgmG7Vxar3DGDrsGeaWvWn/11sskpnEPs75K/hl2YNc5iT76kutrHcQgGzl3LFwkCM75dRd0TkqtH5sXxEvfqDQ/nS2Byw7rwwchPSEWIWtYg0mWZcmBfUysci5SauD+XKz6Ar8/vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e+NgCX00cRDAl8chrH0a+iw6m2zf25IXwrQaUhB9aE=;
 b=tk7sU7j2kPFpuUCrtEyvtmEpAb9Ma1tEjWYHNDgkWoYylKbVbsDc7yPJvP8PwQ1Oz6zcT50VGbU3PUmg1yJkil0fofPs3WrYACPRfKMDRHEKFtoh+ZAs3fv9Zc1GES2Th2vR0hR/VbONzTjeyXuZfqPwRwp1bwmJH/L3LlQC4LM=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by TYYPR01MB6974.jpnprd01.prod.outlook.com (2603:1096:400:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 07:49:37 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 07:49:34 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
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
Thread-Index: AQHby0ai9SCDgo20z0y3b2QkXuPFT7Q1ldCAgAJIPtCAGz9OgIABBmmg
Date: Tue, 5 Aug 2025 07:49:33 +0000
Message-ID:
 <OSCPR01MB1464771054F720542F817E84FFF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
 <aHgVe0YwPWapIYed@mai.linaro.org>
 <OSCPR01MB14647DE009925C982AE6BB5D2FF27A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <64622ffd-05d1-43c3-85d0-cf98f3012477@linaro.org>
In-Reply-To: <64622ffd-05d1-43c3-85d0-cf98f3012477@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|TYYPR01MB6974:EE_
x-ms-office365-filtering-correlation-id: 702ec0f3-0b74-4dbb-ec84-08ddd3f49e6a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjNxL2hiSlhPY2JNbm83RnI0Q2JQdkIvQno1MXErdkJXQTFlVE9GdEFmVmRB?=
 =?utf-8?B?SXg0SE1ReStkdGNUSWFDVTVLNk9QdnZjdCt0NGtzM0hzQnlSZ253Umowd21k?=
 =?utf-8?B?a1UxclVGZlR3aUM0c2RmSk54c2c0Q1haYmhFOUZmMnBuVVdHamoza3NrbzlQ?=
 =?utf-8?B?MlhmbGxFU091bXdDb1dIOXdvTlptbTg2aGhLaGhhS0tic2NuWHcrOFZGS0tL?=
 =?utf-8?B?bUNvT0RsOXZqUDB6MHlqU2o4bzM4MTh5ZkYrTU5nM1l6aEZHT0tRSlYrMFln?=
 =?utf-8?B?N0FFc2JpdjlLQXJnMmFIUmFhWUlEb0hMWTBHc3VDb3Z6VmEwQi9vSUNrWGh4?=
 =?utf-8?B?YzIwT1ZEditFdWpVSGtrNGpNN3lKMnZBaldPTUJEMmFGaEJRMUpDcFczTHRQ?=
 =?utf-8?B?Y2dqT052dUdSM3hHWFR2eWZoMXNJdUh0MGt5dDcwbCtMTWUzNkdqankwbzkz?=
 =?utf-8?B?amFvUEJzaUI5TEVxcitGczcxV0VwdXNPcVVYOVpsak81OHlTUEJWOU1ZV3F4?=
 =?utf-8?B?ZEFVcmZrQ0RrWjExZU9jT3BXVzUzNk9xaktvOUR2QzVST2NDTitVR29XVlYx?=
 =?utf-8?B?TXllaGpxL0swOUpXS2ZWTUUrTncvcVlmSThNbVFvUzhlTG9vY0RsNmYvQjEx?=
 =?utf-8?B?Ym1sSit0VkI4L2NoM1RDSmU2SmNMRkpGVWdmUGtSOHhqUVBNUWhTTHVGMjZk?=
 =?utf-8?B?R0d4OE43TEZyd2RTbXBRb2N3TW02U1A0REh3UE5WNTRuWVBMNHNBbFFGNjlh?=
 =?utf-8?B?ZWZMSy9kSmw3TlJCK1RYWjBqVHpNQ0Y1Yk0vNUQwdXVXSkFJR0V0aGFnMTNs?=
 =?utf-8?B?eVFzM3N0RkxnUURaNUp0SmNrbU0wRmtDUHVUNDcrU0hkdVZiZTRqa3FXc3BH?=
 =?utf-8?B?bnRlQWhPRWNFSHlTZ1FxYmYzeFNXL3I2K0p6cDN2ZmVKYitMUkxRK2d5R214?=
 =?utf-8?B?cGNIMmxxbjJjZjlRSnNjKyszQnVPTFJaUktMVVRUZXA4NStPN0k0eDN1UTln?=
 =?utf-8?B?UnhubkM4djBBY2JqMTlNTWg5cUdWaGtOazlBYmdMdDNDTG5NWU9pdEl2eGJq?=
 =?utf-8?B?cW93WDBKOVFkN05xbm1jYTd6UlpJUUh6Z2RnRGV5d3FxUlBONTBwMWdLU3Yy?=
 =?utf-8?B?RHp6eDdzZ0dwT2ZtNXliRmdRLzV5TE90UTRJM25vd0tka3JpN25ETGhGc3lK?=
 =?utf-8?B?WW5sTkV5YVZqQWRCOXRXY2E1L2Z1Zmsvdy9YMHNQTE8yazI4UUNMa2tUL0Vs?=
 =?utf-8?B?L0YzY2krL2RwNGljVVFnZVNRelNzVjArd3VITVdOZ3FpbVovTDRHSXB4R0J6?=
 =?utf-8?B?UmNoRll4YWRDRkpkV3RidTJuZDREbFp1Lzg5aEhVVTlLb1lBMWlzSzkyS2Mr?=
 =?utf-8?B?YjQvL0oxdSs0ZGpoYUxzWVd4QnV2a2R0b20wTWtkbHVZUlpEZ1JhZjBhbVRk?=
 =?utf-8?B?UWVCZS91aUVHdUJ6TU9mcHRoMkg0MmpPV2ZraVlkUmJTYUVmTko1N21ldS96?=
 =?utf-8?B?Yk5UcjlvUUxSV0tQZXVYUnNCL00rVEFHWDRNSHZPNnN3VStQUGFqa3NURXFX?=
 =?utf-8?B?Mzd3NmdRWFlyaEpPVU52RS9yQWthZmp2RDNBTU93L01wYnRLdzVFeDYzSlRw?=
 =?utf-8?B?cEg5S01KUklFR2hYTnhkU0Y1WUJNRlJHK3l4NjgrWGJDTk00T01VUmtTeHJ0?=
 =?utf-8?B?RStSWTJ1dGFXcEFlMDZXQWI5YTE1SmRQbUorcjZTOEtBYVNja0VVUk8xT3JE?=
 =?utf-8?B?ZzR4R3lEeUNTTU1qck5PVFltQ0EvcmEzWFhTangwTngyRjlsUGVVbmxSZGlD?=
 =?utf-8?B?SGN6S2hBSXViQXk0TVJ2czlldVZ6NW5wb3pKWnhHQmF2T2Q5Q0I0Skt3QWs4?=
 =?utf-8?B?QzJuVDRhaTB2VVhUZXpoZWw4YzFDbHdFVDhjV01HdWxFRjNvdGlhY2tpUU1w?=
 =?utf-8?B?U3R3MjQzcExwUjZYenhDRElZbk50RnQwN0tDUTl3ZjAxeS9JYmlkS1NDQ2lx?=
 =?utf-8?Q?vODs/FhzrAC7AULnoUYrGXmlZZ87Gs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUFOcVBRZzFjT2kwMDBxQUtkK0ZKbUxOY2IrSXZGeWVqWjl2TWFSb0EvVGdY?=
 =?utf-8?B?K2Nud2M1Z3plZjFSTUc3akNNQ3ExMFIyZm5NbStNWkh4NmhpY1hMUVJVZnds?=
 =?utf-8?B?OEZ3NStDZ1FhdDFPV0ZRTFloNVBaMEQzYzdORFFmZXpFVGJCVVl1TmVvNEVp?=
 =?utf-8?B?VjlmVkFUVDJmeG9mYjFKTWVic1A4ckFjZ2c0M2NBSkxyZzBlSGIzY2VuMnZH?=
 =?utf-8?B?NGtqM2lJU0R2ZmZCUHFJRDNZRzJXT2dxMWozVFU4OGNrMUc4ZzFVQVRDVDdX?=
 =?utf-8?B?dDUxdGdDc2tlMk1zU0JRSytBdVBMbDdDZFNzODAzblJSYUJWSmZhR1IrR09a?=
 =?utf-8?B?Sk1MUjYwaTZ1WUx1QzZQWGRva3NxSHVTSU1zMk9JZlpUNzBMVWxvR0dRdFFG?=
 =?utf-8?B?cEp5bDh6cVRJcWdjVkpUZ1ZkR2NPR2FCTG5FY20wMVQyalVOSXJVNWtSNkc5?=
 =?utf-8?B?Uk5wNEttdlorOUhhRUsrOGFpZllFZXVDTXhITVZFS29SUUNjOHlhMFZaMWpR?=
 =?utf-8?B?TEJDcStGUnlSQXJJUGtVU0Z1N1FmVkRkV056S1c3TS9DTk1GcUJ6NkFReGFv?=
 =?utf-8?B?UlkrN04vdU1pb1h5Nm9DcE13UkU2SzJIM2s3U2lac1Q4UUw2MXZXT1JUUG9Z?=
 =?utf-8?B?Nm9PTUQxU3dtVHhaSUR2ajgybDF4OTZ3WUNUN3NHVHYyenJySnNmM05KOE15?=
 =?utf-8?B?alQxMW9jSTNKQUlJaHFIMHFuZ3NBOEMwMHdZZ0t2UHdCc3cvNXZqMFZhVHdW?=
 =?utf-8?B?ck1HNzhPSlBtNWpKRFBpazNXR3ZQaEtrbUdtcUNpTEZ2dU1CaUJXT0NtLzJm?=
 =?utf-8?B?S3g3YkhpUmNjeG5MOFp5N09JRk1aeDUrbkpDeXowbWk5akVYaFdodEZIVFhM?=
 =?utf-8?B?Y2tHeEJDbVVva3VFbkZWSjJmeEpmcnlGMUlvRWF2MHlJZEpGM2pGQVZvakxZ?=
 =?utf-8?B?MzNDL2FPcDZJNVpFbkZsUWdWZDhLenZ3M253eU9OVFkzN2s2U3hpTHJ0Qm5T?=
 =?utf-8?B?YlBmUTg3dDcrUXEzWEVFTDV0b3BSeW16NmtUaUpUVGpyLzcrSzBFYXAyYW1x?=
 =?utf-8?B?TTc4QkRLVjRHdktaYXdnZlJQVjdOWSs1U3lTeUZXb0ppSFhFcXZOcU9vSVl1?=
 =?utf-8?B?Z2NQdWpNOWF0RG1EbkVabHQ0VFVYTnliV3A2eW5xS1pYYmlMT1dDQWtZbVRu?=
 =?utf-8?B?Skk1MEtyUzRtSmJLOWkwVFVRVzF5UkN1TzFoRDQ1aHUweHVuZXJqMTZZajI0?=
 =?utf-8?B?b283cmlHZ1VjclVUSXl6ZW9FWXVxMzJDNWp5WHNEcE9Kb3RTQkdTRUIzZVls?=
 =?utf-8?B?NDdFNGtTNlN3aEMrTnRqS2dLOEh4VUczNnhMTFZIWi9KNDVKVlpuSE10RXFl?=
 =?utf-8?B?Vk5FZHdPcFhZdGxKR0pDWDRPQ3FNSkR2UmhILy9ici9pSEV6VVJKWVNJNm9E?=
 =?utf-8?B?S2RqczcxcE1hanljdHYydlNCOGc2Y1BrOGQ2Rm1RL3Vxc0RiVFV3R3RQdE9X?=
 =?utf-8?B?Q3dQSHdEVERsVHBqemNNSHFna2hENTlpSHZoYjBFN1pmWGJxMVA4M0ljSllQ?=
 =?utf-8?B?NndaSDBJYW1LdGZUUENPbmVZZzJFQnZURks2dWM3R25ZKzJSR3F2MzlsT2ZH?=
 =?utf-8?B?bE9ySXNrbDBmV25FcnRxMU5VV2ROMGhWYlRDeDZHdHJyQmVyS096ZXNRblVT?=
 =?utf-8?B?SnRUL3RyZ3l0c0dRVUJtVEN0SWRPU21xdGpIZW5ZSGhTY1BLNXkyc1dwbUky?=
 =?utf-8?B?UzEzSGZSeEN2a1ZOQ1BKWnVGeGNJT1o4d0VJZ05vU0UwS3N2RUxqKzU5T2R3?=
 =?utf-8?B?aTVwYU0xZitYVDZJRityYVZpRW5aNmUxczlYOTU0blQzNXF2SktaRDh0QTc2?=
 =?utf-8?B?UzNYeXErc0VpaDVuNVFRRzRQNnB3ZGgrcEdQOEgyRHd1dWdnTENPMC83TlBB?=
 =?utf-8?B?NERucGY2eGN0dHVKOGx2UXUyTHJiNXU5cVpJOGkvUllmbDd2YU9lei8wOWlW?=
 =?utf-8?B?NTZwRUdzMjA1NmhRZHRzMUlnSkUyMmNEVEtpVENjN3ozOXphVnR1eldya3Rj?=
 =?utf-8?B?c0czOGYrNExMcDZTSmFsaGFGNGNZcmpkU3FWRkRjT1lZMVkrbjFDdmwrdXpu?=
 =?utf-8?B?VDkrSmYvT1ErbHljYVVVYUpBcnYxUHcvNHRySUQ0V3lqUk5zdUdPNTdYMk1s?=
 =?utf-8?B?VVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 702ec0f3-0b74-4dbb-ec84-08ddd3f49e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 07:49:33.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5++tO7fNMN8EI4Wkea1WiuFnjGijJguu6JdSmvIIgkCAUX4S/7lEgpv+FWx5NLIi5hmfUzPX2o3Ux/GskE33nu9UbJAGmDwPbGmyaCNYzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6974

SGkgRGFub2VsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEF1
Z3VzdCA0LCAyMDI1IDY6MDggUE0NCj4gVG86IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBi
cC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAzLzVdIHRoZXJtYWw6IHJl
bmVzYXM6IHJ6ZzNlOiBBZGQgdGhlcm1hbCBkcml2ZXIgZm9yDQo+IHRoZSBSZW5lc2FzIFJaL0cz
RSBTb0MNCj4gDQo+IE9uIDMxLzA3LzIwMjUgMTk6MTksIEpvaG4gTWFkaWV1IHdyb3RlOg0KPiA+
IEhpIERhbmllbCwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+ID4NCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRGFuaWVsIExlemNhbm8gPGRh
bmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxNiwg
MjAyNSAxMToxMSBQTQ0KPiA+PiBUbzogSm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJl
bmVzYXMuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDMvNV0gdGhlcm1hbDogcmVu
ZXNhczogcnpnM2U6IEFkZCB0aGVybWFsDQo+ID4+IGRyaXZlciBmb3IgdGhlIFJlbmVzYXMgUlov
RzNFIFNvQw0KPiA+Pg0KPiA+PiBPbiBUaHUsIE1heSAyMiwgMjAyNSBhdCAwODoyMjo0NlBNICsw
MjAwLCBKb2huIE1hZGlldSB3cm90ZToNCj4gPj4+IFRoZSBSWi9HM0UgU29DIGludGVncmF0ZXMg
YSBUZW1wZXJhdHVyZSBTZW5zb3IgVW5pdCAoVFNVKSBibG9jaw0KPiA+Pj4gZGVzaWduZWQgdG8g
bW9uaXRvciB0aGUgY2hpcCdzIGp1bmN0aW9uIHRlbXBlcmF0dXJlLiBUaGlzIHNlbnNvciBpcw0K
PiA+Pj4gY29ubmVjdGVkIHRvIGNoYW5uZWwgMSBvZiB0aGUgQVBCIHBvcnQgY2xvY2svcmVzZXQg
YW5kIHByb3ZpZGVzDQo+ID4+IHRlbXBlcmF0dXJlIG1lYXN1cmVtZW50cy4NCj4gPj4+DQo+ID4+
PiBJdCBhbHNvIHJlcXVpcmVzIGNhbGlicmF0aW9uIHZhbHVlcyBzdG9yZWQgaW4gdGhlIHN5c3Rl
bSBjb250cm9sbGVyDQo+ID4+PiByZWdpc3RlcnMgZm9yIGFjY3VyYXRlIHRlbXBlcmF0dXJlIG1l
YXN1cmVtZW50LiBBZGQgYSBkcml2ZXIgZm9yIHRoZQ0KPiA+PiBSZW5lc2FzIFJaL0czRSBUU1Uu
DQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1Lnhh
QGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4gLS0tDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+Pj4gK3N0
YXRpYyBpbnQgcnpnM2VfdGhlcm1hbF9nZXRfdGVtcChzdHJ1Y3QgdGhlcm1hbF96b25lX2Rldmlj
ZSAqem9uZSwNCj4gPj4+ICtpbnQgKnRlbXApIHsNCj4gPj4+ICsJc3RydWN0IHJ6ZzNlX3RoZXJt
YWxfcHJpdiAqcHJpdiA9IHRoZXJtYWxfem9uZV9kZXZpY2VfcHJpdih6b25lKTsNCj4gPj4+ICsJ
dTMyIHZhbDsNCj4gPj4+ICsJaW50IHJldDsNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKHByaXYtPm1v
ZGUgPT0gVEhFUk1BTF9ERVZJQ0VfRElTQUJMRUQpDQo+ID4+PiArCQlyZXR1cm4gLUVCVVNZOw0K
PiANCj4gWyAuLi4gXQ0KPiANCj4gPj4+ICsJcmVpbml0X2NvbXBsZXRpb24oJnByaXYtPmNvbnZf
Y29tcGxldGUpOw0KPiA+Pj4gKw0KPiA+Pj4gKwkvKiBFbmFibGUgQURDIGludGVycnVwdCAqLw0K
PiA+Pj4gKwl3cml0ZWwoVFNVX1NJRVJfQURJRSwgcHJpdi0+YmFzZSArIFRTVV9TSUVSKTsNCj4g
Pj4NCj4gPj4gV2h5IGVuYWJsZSBpcnEgaGVyZSA/DQo+ID4+DQo+ID4NCj4gPiBJIGRpZCBpdCB0
aGlzIHdheSBiZWNhdXNlLCBpbiAnc2V0X3RyaXBzJyBjYWxsYmFjaywgdGhlIGRyaXZlciBkb2Vz
DQo+ID4gdHJpZ2dlciBjb252ZXJzaW9uIHRvIGNoZWNrIHdoZXRoZXIgdGhlIGN1cnJlbnQgdGVt
cGVyYXR1cmUgaXMgcGFydCBvZg0KPiA+IHRoZSB3aW5kb3cgb3Igbm90LCBhbmQgdHJpZ2dlcnMg
dGhlIGNvbXBhcmlzb24gaW50ZXJydXB0IGFjY29yZGluZ2x5Lg0KPiA+IEJlY2F1c2Ugb2YgdGhh
dCwgSSBkaWQgbm90IHdhbnQgdGhlIGNvbnZlcnNpb24tY29tcGxldGUgaW50ZXJydXB0IHRvDQo+
ID4gYWxzbyBiZSB0cmlnZ2VyZWQuDQo+ID4NCj4gPiBUaGF0J3MgdGhlIHJlYXNvbiB3aHkgSSBl
bmFibGUgY29udmVyc2lvbi1jb21wbGV0ZSBpbnRlcnJ1cHQgaW4NCj4gPiAnZ2V0X3RlbXAnLCB0
byBtYWtlIHN1cmUgaXRzIGludGVycnVwdCBpcyBiZWluZyB0cmlnZ2VyZWQgb25seSB3aGVuDQo+
ID4gdGhlIHRoZXJtYWwgY29yZSBjYWxscyBpdC4NCj4gPg0KPiA+IFNob3VsZCBJIGRvIGl0IGFu
b3RoZXIgd2F5ID8NCj4gDQo+IEkgZG9uJ3QgQVRNLCB0aGUgYXBwcm9hY2ggaXMgdmVyeSB1bnVz
dWFsIHNvIEknbSBzdGlsbCB0cnlpbmcgdG8gZmlndXJlIG91dA0KPiB3aGF0IGlzIHRoaXMgY29t
cGxldGlvbiBhcHByb2FjaCBhbmQgcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYy4gQXQgdGhlDQo+
IGZpcnN0IGdsYW5jZSBJIHdvdWxkIHNheSBpdCBpcyB3cm9uZy4NCj4gDQo+IA0KPiA+Pj4gKwkv
KiBWZXJpZnkgbm8gb25nb2luZyBjb252ZXJzaW9uICovDQo+ID4+PiArCXJldCA9IHJlYWRsX3Bv
bGxfdGltZW91dF9hdG9taWMocHJpdi0+YmFzZSArIFRTVV9TU1IsIHZhbCwNCj4gPj4+ICsJCQkJ
CSEodmFsICYgVFNVX1NTUl9DT05WX1JVTk5JTkcpLA0KPiA+Pj4gKwkJCQkJVFNVX1BPTExfREVM
QVlfVVMsIFRTVV9USU1FT1VUX1VTKTsNCj4gPj4+ICsJaWYgKHJldCkgew0KPiA+Pj4gKwkJZGV2
X2Vycihwcml2LT5kZXYsICJBREMgY29udmVyc2lvbiB0aW1lZCBvdXRcbiIpOw0KPiA+Pj4gKwkJ
cmV0dXJuIHJldDsNCj4gPj4+ICsJfQ0KPiA+Pj4gKw0KPiA+Pj4gKwkvKiBTdGFydCBjb252ZXJz
aW9uICovDQo+ID4+PiArCXdyaXRlbChUU1VfU1RSR1JfQURTVCwgcHJpdi0+YmFzZSArIFRTVV9T
VFJHUik7DQo+ID4+PiArDQo+ID4+PiArCWlmICghd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0
KCZwcml2LT5jb252X2NvbXBsZXRlLA0KPiA+Pj4gKwkJCQkJIG1zZWNzX3RvX2ppZmZpZXMoMTAw
KSkpIHsNCj4gPj4+ICsJCWRldl9lcnIocHJpdi0+ZGV2LCAiQURDIGNvbnZlcnNpb24gY29tcGxl
dGlvbiB0aW1lb3V0XG4iKTsNCj4gPj4+ICsJCXJldHVybiAtRVRJTUVET1VUOw0KPiA+Pj4gKwl9
DQo+ID4+DQo+ID4+IENhbiB5b3UgZXhwbGFpbiB3aGF0IGlzIGhhcHBlbmluZyBoZXJlID8NCj4g
Pj4NCj4gPg0KPiA+IEkgbWlnaHQgbm90IGdldCB3aGF0IHlvdSBhcmUgYXNraW5nLCBidXQgc2lu
Y2UgSSBjb21wdXRlIHRoZQ0KPiA+IHRlbXBlcmF0dXJlIGluIHRoZSBoYXJkIElSUSBoYW5kbGVy
LCBJIGp1c3Qgd2FpdCBmb3IgaXQgdG8gY29tcGxldGUNCj4gPiBhbmQgbm90aWZ5IHRoZSBjb21w
bGV0aW9uIHNvIEkgY2FuIGdyYWIgdGhlIHByb2Nlc3NlZCB2YWx1ZSB0byBub3RpZnkNCj4gPiB0
aGUgdGhlcm1hbCBjb3JlLg0KPiA+DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoaXMgZG9l
cyBub3QgYW5zd2VyIHlvdXIgcXVlc3Rpb24uDQo+IA0KPiBDYW4geW91IGRlc2NyaWJlIGhvdyB0
aGUgc2Vuc29yIHdvcmtzID8gQW5kIHBlcmhhcHMgaWYgeW91IGhhdmUgYSBwb2ludGVyDQo+IHRv
IHNvbWUgZG9jdW1lbnRhdGlvbiA/DQoNCkhlcmUgaXMgdGhlIGRvY3VtZW50YXRpb24gWzFdLiBU
aGUgdGhlcm1hbCBkZXZpY2UgaXMgcmVmZXJyZWQgdG8gYXMgVFNVLg0KDQpbMV0gaHR0cHM6Ly93
d3cucmVuZXNhcy5jb20vZW4vZG9jdW1lbnQvbWFoL3J6ZzNlLWdyb3VwLXVzZXJzLW1hbnVhbC1o
YXJkd2FyZT9yPTI1NTc0NDkzDQoNCj4gICBbIC4uLiBdDQpSZWdhcmRzLA0KSm9obg0K

