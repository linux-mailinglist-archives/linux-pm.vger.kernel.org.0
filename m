Return-Path: <linux-pm+bounces-32612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F6B2BC2B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66023BEBB5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2824311975;
	Tue, 19 Aug 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="pITY+3T6"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011010.outbound.protection.outlook.com [40.107.74.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF291D88D7;
	Tue, 19 Aug 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593377; cv=fail; b=a7kQJBQmTVjQIG9bU47q7Sb8VnVmPbkLiWxW8Ym7UysCa5VPT0/nu5Ya55mPmk4vRLcCY6jErtOHZzq7egbHTj6/00gwxWwjaJ0427LTcZ4RnA7S7QuL1jOaEOQi3UJvg78Sl9dl/sLcqAhIdvy++4HmEgHinqRR6tvWSfopkDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593377; c=relaxed/simple;
	bh=j2++GbzcdeiCFnsZGspIQeS6SM9Tt/KMZ+GvDOeymTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSC1e2A5WGBSeRMnKEXMH0fJRukZUJwHAk83sxLYpFUafiG4Hoc2pgCw4N0pt9VBNUdLQTAyYPCGVL55I70/XiER1nbHpDW5sMFYctu3+FXIuGat6lqchuW63PJjbI11+paqykgupfF8qXFUCE4BUnOY6mtDXQiNmHHdhre5dOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=pITY+3T6; arc=fail smtp.client-ip=40.107.74.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlfdGlFhgNOhZ7eLMrMqHzgJL9y2RWdCPB/oIOn8YUCzI2AeGURaov66mylYxArnGC5lc6MD+qo4TDtBgOfjkjkZ79b0gXwbW5GWwApNR41vlzzPZGlIz7ETEZU6QqETA5kHin+y08w+8WW4yllEo3V0z7FTc7Y0+LfC5HNWHfWr5dHcr9xxY+pRCOhZG6EcEedwUdvqOJLKoUanIRy2Mj/SPFxcWUmjHI19rK2WnNQj3prbHUqaNvJAEhGfBnIfGTd4CZN+r942n9go9mxZUXk6foowvHFY9wbUu45eqF/WU1cSYyh2QUWcGT5zzBdhGwEQsgNDsI8/+B8/OEdH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2++GbzcdeiCFnsZGspIQeS6SM9Tt/KMZ+GvDOeymTE=;
 b=IFr9ADb9sZf1GDWlKgKaHcmO0SL0mPXGI1lFa/mXrEF9q7g6lbF9KZ6PWzd82k9NfcP9b4I83p+v9EiVkyuuKdO4vAvP4/pj3yqEL28W5Y7o8I/hwOM1On48CUl8a3GRC4HphqSEmcXFYX0NjHbma+w4btmaC8236uxVjTc2oiSbeaqNIUDVrips9aUeeg1/BY8Cxn7u4OPPKimWLcKPtNYfln7Lsp0Bwe1b+r49iYMMXDLiQeo8zc21NtCroAscx9D4Tc9RkWcP5I5oZF5zQZdWUfaSSdLhht2OQrRdgvNchTr+6IylbEkF13cFHJKlWbxv4FVAH2O3HC2SkOaTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2++GbzcdeiCFnsZGspIQeS6SM9Tt/KMZ+GvDOeymTE=;
 b=pITY+3T60BXzjyBiTbSIcOtdsf4lLt18mL5K96O0BNfYcOetRkkt6qzX08hZkoHgN07mawJxV/1aRIjMxxDRaW86Tx39Y2g15cHqCgPkBLvkSrJUjYquZqFF7W+5s9hKOdBcfhSLE+7m7mquIM5J/89zeDMY5AOA2wPfy8y7qvU=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by TYAPR01MB5772.jpnprd01.prod.outlook.com (2603:1096:404:805a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 08:49:31 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:49:31 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "will@kernel.org" <will@kernel.org>, magnus.damm
	<magnus.damm@gmail.com>, "john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>
Subject: RE: [PATCH v7 0/6] thermal: renesas: Add support for RZ/G3E
Thread-Topic: [PATCH v7 0/6] thermal: renesas: Add support for RZ/G3E
Thread-Index: AQHcEF0+vBV+Bhe3t0KXi7JWTOYghrRougAAgADw/UA=
Date: Tue, 19 Aug 2025 08:49:31 +0000
Message-ID:
 <OSCPR01MB1464727EEC57CAC4218AA399FFF30A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
 <175554055722.1719725.13076334498195294379.robh@kernel.org>
In-Reply-To: <175554055722.1719725.13076334498195294379.robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|TYAPR01MB5772:EE_
x-ms-office365-filtering-correlation-id: 631632a7-46ff-4b9b-eb34-08dddefd50af
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnN2eS9DSk53ekdrNGNJY0ZyblNSY0Z1a1FYWlJ3K01TWURZS3B2cE5sWDFo?=
 =?utf-8?B?SzBNUWw2ZVA3dmhtbm1ybkwwODRpeStRWXYwZWdMTGlKQVdaT0FDVS9RYkRG?=
 =?utf-8?B?anFDdUtJcEJPbEMwdURNTHF0aDJrVS8raENWbCt6aGd5bXVjdmtVQlY0YjJF?=
 =?utf-8?B?d1ZUdjdwZHJGOUhDUjJwZTVOaWlNSGU0UFE5ck1rdlB5YnMrdDVZK0tNRDZQ?=
 =?utf-8?B?dGx0aDhXcmluOGV1UW1LRWRubWVidEEwTHNKdDd5RDQwQ3h2aWxjbStXb2gz?=
 =?utf-8?B?MXdCRnZyNFlkaSttVlBiUm9qZTQ1c0RweTNLdG9WM1ZOVjgrRmlvVnI1RTJa?=
 =?utf-8?B?SnBOcUtKL0YvMS9YQTlWUUl5UmJZbVRYaythdGN4QUVJWndjZVpiT0l5dDQz?=
 =?utf-8?B?TGFMV25YTHJocG1Gd21jMENQUnJjNkdJWVpqRFJTWmJtN1dzajgyaTVreFFM?=
 =?utf-8?B?WXR4MjY4bGtYTngvcVBIb1c0MmQxS2RoczJUbE55b2RMNVFLUWJLWmFuSlhI?=
 =?utf-8?B?cWpweHZlOTc2YzVCTFRLbWYxeFZXTmhzczIxd1hubEtQRmFxRUtWTDVTZWxr?=
 =?utf-8?B?S0VOTFUzTzl2ekV6K2hyUStxUjJ0RHZxQTNLclg3ZjJ4Q1lYaXdMSVlnNDMw?=
 =?utf-8?B?SVV4Uko4dGxHVFJnZXh5M2ljQnQzWlAva1VGaEI4YmZYOG1qZU0ycFNPbVZo?=
 =?utf-8?B?emxVNGg5cDZmUWRtSHFJR2R6aXMzMTRYWndpWDA3UFRLT1FJQ2p3N0JSTnJ0?=
 =?utf-8?B?T2hUaUNCT3pmYlpTanNuL3I2bWNNdFEraVpoa2c3aHdaY25CNHhjV0daNVZi?=
 =?utf-8?B?ZjdMaWkrV2M3ZDFWamxSUTJJY2swVU90OUZPNEtZczFRN0V3YXFVUlJtNnRj?=
 =?utf-8?B?RDFrajdCU0dmQnlQVUNOblVlb1ZIY3I5OGlIUGtPWGlaTk1DU1N4aUNockNK?=
 =?utf-8?B?LzJJQ1I0aTl4Z0ZsWEkwSFc5dG9VOWhhRWtlQ2s1SjJVcWtDOEVBZWVtd2dp?=
 =?utf-8?B?RE5tUUlmc2lyTWVYUkZ6U05aUUxCMFJXWTFtOTB0RVFBaGhBUjJ5NE10KytQ?=
 =?utf-8?B?VzAxemUycUtaamFxMHdOTWR2Y010VlRyaGh2REtKVTBvNHJxcDZPTUtxMkZF?=
 =?utf-8?B?RjRia3lHeGJKWGlPNzVRcis0WHZIRXBZbVdYWVdLL0VoOVJrMFJGbytUOU13?=
 =?utf-8?B?YTRTNlFraEFOZEdvakhoWmhpU0pKUFdoQ050Qm5pVmNyMVc1MlBnN2tWRE9r?=
 =?utf-8?B?SnQwUXJKMDdma1NZWlB1UjN3ZldXL2FmbGk0L0sxOXRhT1l1eXNzR1MwZktJ?=
 =?utf-8?B?WWdPRzZFZ2lQWlRXQjIzSVM2L0NNMEVCZGpsRGNpTXY1LzlVdmtMV0cwSFh2?=
 =?utf-8?B?R2VjRmNmamtsYkhhQ1hjUkk3R1BnM0dWRmNoT25ETTU5QitlN1FYdmpGelYw?=
 =?utf-8?B?ajZsamptcHlNSUQ3TzVqM1lHeXVpcVVSOEgxUjNYWmZOREVaRnp1VWl5a1M3?=
 =?utf-8?B?WkYyTG5uK0Q0RHZKOWozb0pNNVhVRWlEamtPZ2wvNEFZZFRtL2hiaW1xL3lZ?=
 =?utf-8?B?K1lJUVJLR25kc1N4UmZtaEErVjZsOGRlR0VWNkIvVmMrQU9Vczh3SnQ5VXpO?=
 =?utf-8?B?azJ1UHRlcHZIN1N1SXBCVjFIRGNUYjA2L1VZbXVnUGJtVTIvUUpsZnIyOU5B?=
 =?utf-8?B?cHkxbW1ka0Q1TG5OOEdBM2xhTnhXVmR0UmJnM3QwUVkyOHRacXFxQStyb1ll?=
 =?utf-8?B?Zklja0IwTkdreXFaTVppM0VNTjFHSEhrUlNRSTcrRlhqMk5MU3QrYlY0dmF3?=
 =?utf-8?B?SlJXNTRjUXZzTTdRdm1GK293RFFqS0ZLa2laOUZGeVFZc3VOUVF6bU9BTkJa?=
 =?utf-8?B?NmZwU2o1SnBvZkhqZlJ2eUlHa3cvWTgvZDY1bTZhRFZPdjVVMW40WmxKeWlz?=
 =?utf-8?Q?LjtJC1Ekihc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzZ2UmMxcFUySm9pSll3VDRXTzlRWVZ5dXYzNGxYcndzOWlyNEIrWGd5bzlX?=
 =?utf-8?B?ZTUveCtHY09YbE1EbG9TQlV4VCs1d2xhYWtudzBvbjNHUjVWcUdHYlJFZHdQ?=
 =?utf-8?B?WDZuQmFXL1d2RER4aXc3azFpYnVGRHpoSDdJR1ZJRHhBZmFuSWJjR1k0Q1gr?=
 =?utf-8?B?cHhVOFpPU1ViQ3p1K2ZXeFAvWkhzUnRleFFyV1BseUJnMVlTWVc4d2RDUlhj?=
 =?utf-8?B?MlZxVW5GcEZvSC9IODZ2ZXh5ZVgycmFsVzdDcldSUnlYNFNrbkwrZWVLdWVO?=
 =?utf-8?B?QXBHSlpsblVBa1NaekFCQ2lWNGR1RDJyb21EUDJuNlVtNXVWTFpsdHdSa09k?=
 =?utf-8?B?L2tncHhIbVhia3dNNGZHTTdHZ3pwcHhZdThzR0svVGVCNmhIV0JkNE5kaHor?=
 =?utf-8?B?WXlESkVGNVBESDl5VExkemlVZkRGSlNiblVkamlVMW8vYXlBQVZUdjkxTkFW?=
 =?utf-8?B?bm1oUjJKbThMSFd5eEZoOTY0QWFtamFaOWRDSlgrbkZSNWdycWdzc2ZaYnE2?=
 =?utf-8?B?Rkh5RDFsUjN5OXhZVzE0ODkzN2VFSGdGeGlEM0FKcHhqN3FHV2lwbGg0SEpX?=
 =?utf-8?B?eVJMcUlFL05RZlNZQnJQOXRiMWJjbUdrT2w0SG0rN1RZRUk2UFgwWWhUdFpx?=
 =?utf-8?B?ZjJDSHowTDJ0dENwWm5SYUFGaWpOSzcwSG14Q09CdERLQ05rRkk5ZlpybHJn?=
 =?utf-8?B?d2R5cEd6QTlFWWltaWxISHJkKzBIYUFTaENNQ1NCWVBBSGloaTY5dGFpR2VJ?=
 =?utf-8?B?OXB5L3R5QzFUck04dHphd0ZiRVJJdHJVMGpyMXV6VGpFTFFHRnZiV01WS1Rt?=
 =?utf-8?B?d25lSDJJUDlwcUw2T2txZXBQeDNpQWZLUkYrWGc3aTNLbmJ4My9zY1FYT2xW?=
 =?utf-8?B?WEhlUHBjYlBKQzRKN3BhQzhyNkR0MzU3aU9MMVZpc2MrdUdUU1BlZkRwWTli?=
 =?utf-8?B?aGEzMGV3VFBHU291TDNhRWpXanpUaVcwYjIzaDc5eWk4bnMzQk05cm95TnA2?=
 =?utf-8?B?Q2tWNWxXWEdSK1dURno2Zk91OFNpRGVuTzhOb3dTQzVoeGJIWkRrQ2Fhcy9S?=
 =?utf-8?B?aUtYL2U1eUllVzFtTHc1ZTFPTlpsanpWREZQbGZFekVCQTVXUFdGR3hSbzdM?=
 =?utf-8?B?Nmt1bEE5UlBBL1ZRN3dQZ3ZTazdCZkl6NnEwYmY0Q0lWSUdRVUh1SFlpMlVx?=
 =?utf-8?B?d2JRMXREY1JFV3ZUbGYwV1owQmI2dlQvdHdGZkQrMGExcEk0ZUx4LzNhc0Jo?=
 =?utf-8?B?SCtLR0c5MGUrZUV2Q2FJV0E0UnZreVZxcXEwYW1HTW9yVHRJN2lzVXV3NEtH?=
 =?utf-8?B?U3laZUV5R3B1VzRKTkRKVEZFbHIyOWJac2JpSnpXcHU1MXlhZTdva1AzU0VV?=
 =?utf-8?B?eFg2enFpTDdpQzRmUko0K2NRMThDWTVyQWhLM1F2L2w3a0xvVFQwSkFtRVRm?=
 =?utf-8?B?S3ZXTXkzTHNwL21Tb1EwaTJLOEhnWGJZVG53Tloxa1VlU3FnY0hDU2lGWVJT?=
 =?utf-8?B?eXlvY0s4N0xCSlRKVnBYQWhGR1YvOE04RXVscS9PeUtEOXdEdEErdmM1dzhs?=
 =?utf-8?B?TVkyUWZuMys2bnlKOW9tdU5XZEVpemE1d0g5MGNKbDFKUWVsTFZlVXJPbnlT?=
 =?utf-8?B?bWhSYkxuZzhscEF3MzVXcWxQVDg0a01nQWtWUjlsakNTaUcwa1RMNm1QMzNy?=
 =?utf-8?B?dXcwenR5cW5NeVFxbHBvVUtrcWNkSlBydE9aaExoeUJGby9GMDlCZ29CWEhS?=
 =?utf-8?B?SjdJenJFZzNpSGF4VEMvZUowYTBYcG5qb1FkV0VWbG5pZlhOQ2FBd0kwdGh3?=
 =?utf-8?B?TXhiMERONnRrai9NMXJnN0hpTHZxekViVjlxdXkxY3FjVFN5YU5JMi82TXpL?=
 =?utf-8?B?Y1hlT0RKcmFUVkZ1QkFqS0VOZ0xHcUxLdSt2cGZqYkJtTmhvQ1dWVGhFeFlR?=
 =?utf-8?B?TEhsZWw1NHdNNGdwaTA0TmUvMDRIdzMrcDR2UXpGaDhUekF2bUc5ek9kYlBk?=
 =?utf-8?B?djJzekIxYTBqTFdjaXdNZHppck43T3hHWm9nYVltU2xITDJ0V2NoNUpSK2l5?=
 =?utf-8?B?N05SL1ErdThsOFE5NEVsd2I4bGVodTRtUDU0UDhmMm1SL2dzNUlCK3dIQ3RW?=
 =?utf-8?B?em4wQUV1ZERKYmhwV1lTMkJMQUlGUlVMd2pEbTZ2Q254VFhlNTVsOTBMaHNT?=
 =?utf-8?B?UHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 631632a7-46ff-4b9b-eb34-08dddefd50af
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 08:49:31.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InkMPzdQcg1XdKXFursGju/JOioTPBLjIww0QaCOvXMDz8MTbgNK+LHmJqp/zR8HMQYjPIb9YqQ76ZRhNz41LJVBjLLkPP/4jdZh5Y/uS44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5772

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjayENCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyAoQXJtKSA8cm9iaEBrZXJuZWwub3JnPg0K
PiBTZW50OiBNb25kYXksIEF1Z3VzdCAxOCwgMjAyNSA4OjI1IFBNDQo+IFRvOiBKb2huIE1hZGll
dSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djcgMC82XSB0aGVybWFsOiByZW5lc2FzOiBBZGQgc3VwcG9ydCBmb3IgUlovRzNFDQo+IA0KPiAN
Cj4gT24gTW9uLCAxOCBBdWcgMjAyNSAxODoyODo0NiArMDIwMCwgSm9obiBNYWRpZXUgd3JvdGU6
DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgdGVtcGVyYXR1cmUgc2Vuc29y
IHVuaXQgKFRTVSkgZm91bmQNCj4gPiBvbiB0aGUgUmVuZXNhcyBSWi9HM0UgU29DLg0KPiA+DQo+
ID4gVGhlIHNlcmllcyBjb25zaXN0cyBvZiA1IHBhdGNoZXMgKG9uZSBvZiB3aGljaCBpcyBub3Qg
cmVsYXRlZCB0byB0aGUNCj4gPiB0aGVybWFsDQo+ID4gZnJhbWV3b3JrKSB0aGF0IHByb2dyZXNz
aXZlbHkgYWRkIFRTVSBzdXBwb3J0IGFzIGZvbGxvd3M6DQo+ID4gLSBwYXRjaCAxLzY6ICAgIGFk
ZHMgc3lzY29uL3JlZ21hcCBzdXBwb3J0IGZvciBhY2Nlc3Npbmcgc3lzdGVtDQo+IGNvbnRyb2xs
ZXINCj4gPiAgICAgICAgICAgICAgICAgcmVnaXN0ZXJzLCBlbmFibGluZyBhY2Nlc3MgdG8gVFNV
IGNhbGlicmF0aW9uIHZhbHVlcw0KPiA+DQo+ID4gLSBwYXRjaCAyLTYvNjogIGFkZHMgZHQtYmlu
ZGluZ3MsIGFjdHVhbCBkcml2ZXIsIERUIG5vZGUsIGFuZCBjb25maWcNCj4gc3ltYm9sLg0KPiA+
DQo+ID4gUGF0Y2ggMS82IGhhcyBiZWVuIGR1cGxpY2F0ZWQgYXQgWzFdIGluIFVTQiBzZXJpZXMu
IFRoaXMgc2VyaWVzDQo+ID4gYWRkcmVzc2VzIGNvbW1lbnRzIGdvdCBmcm9tIHRoZXJlLg0KPiA+
DQo+ID4gQ2hhbmdlczoNCj4gPg0KPiA+IHYxIC0+IHYyDQo+ID4gICogRml4IHlhbWwgd2Fybmlu
Z3MgZnJvbSBkdC1iaW5kaW5nDQo+ID4gICogVXBkYXRlIElSUSBuYW1lcyB0byByZWZsZWN0IFRT
VSBleHBlY3RhdGlvbnMNCj4gPg0KPiA+IHYyIC0+IHYzDQo+ID4gICogUmVtb3ZlIHVzZWxlc3Mg
J3JlbmVzYXMsdHN1LW9wZXJhdGluZy1tb2RlJyBwcm9wZXJ0eQ0KPiA+DQo+ID4gdjMgLT4gdjQN
Cj4gPiAgKiBJbXByb3ZlIGNvbW1pdCBtZXNzYWdlcw0KPiA+DQo+ID4gdjQgLT4gdjUNCj4gPiAg
KiBSZW1vdmUgdXNlbGVzcyBjdXJseSBicmFjZXMgb24gc2luZ2xlIGxpbmUtcHJvdGVjdGVkIHNj
b3BlZCBndWFyZHMNCj4gPg0KPiA+IHY1IC0+IHY2DQo+ID4gICogTWlub3IgdHlwbyBmaXgNCj4g
PiAgKiBDb25zdGlmeSByZWdtYXAgY29uZmlnIGluIHBhdGNoIDEvNQ0KPiA+DQo+ID4gdjYgLT4g
djcNCj4gPiAgKiBVcGRhdGUgRFRTIHRyaW0gcHJpcGVydHkgbmFtZSBhbmQgc3BlY2lmaWVyLCB1
cGRhZGluZyB0aGUNCj4gPiBkb2N1bWVudGF0aW9uICBhY2NvcmRpbmdseQ0KPiA+ICAqIFJlZmFj
dG9yIG1haW4gZHJpdmVyOiByZW1vdmUgc3BpbmxvY2sgdXNhZ2UsIHVzaW5nIHBvbGxpbmcgdGlt
ZW91dA0KPiA+IGFzIGNvbXB1dGVkICBmcm9tIGRhdGFzaGVldC4gQWxzbyB1c2UgcG9sbGluZyBm
b3IgZ2V0X3RlbXAoKSB3aGlsZQ0KPiA+IHVzaW5nIElSUSBmb3IgdHJpcC1wb2ludCAgY3Jvc3Mg
ZGV0ZWN0aW9uLCBhbmQgZmluYWxseSBhZGQgYm90aCBydW50aW1lDQo+IGFuZCBzbGVlcCBQTSBz
dXBwb3J0Lg0KPiA+ICAqIEFkZCBuZXcgcGF0Y2ggdG8gdXBkYXRlIHN5cyAjYWRkcmVzcy1jZWxs
cyBhcyB0cmltIHNwZWNpZmllciBub3cNCj4gPiByZXF1aXJlcyBhbiAgb2ZmZXQgZnJvbSBzeXMg
YmFzZQ0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI1MDgwODA2MTgwNi4yNzI5Mjc0LTItY2xhdWRpdS5iZXpuZWEudWoN
Cj4gPiBAYnAucmVuZXNhcy5jb20vDQo+ID4NCj4gPg0KPiA+IEpvaG4gTWFkaWV1ICg2KToNCj4g
PiAgIHNvYzogcmVuZXNhczogcnotc3lzYzogQWRkIHN5c2Nvbi9yZWdtYXAgc3VwcG9ydA0KPiA+
ICAgZHQtYmluZGluZ3M6IHRoZXJtYWw6IHI5YTA5ZzA0Ny10c3U6IERvY3VtZW50IHRoZSBUU1Ug
dW5pdA0KPiA+ICAgdGhlcm1hbDogcmVuZXNhczogcnpnM2U6IEFkZCB0aGVybWFsIGRyaXZlciBm
b3IgdGhlIFJlbmVzYXMgUlovRzNFIFNvQw0KPiA+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjlh
MDlnMDQ3OiBBZGQgI2FkZHJlc3MtY2VsbHMgcHJvcGVydHkgaW4gc3lzDQo+ID4gICAgIG5vZGUN
Cj4gPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA5ZzA0NzogQWRkIFRTVSBub2RlDQo+ID4g
ICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgdGhlIFJlbmVzYXMgUlovRzNFIHRoZXJtYWwgZHJp
dmVyDQo+ID4NCj4gPiAgLi4uL3RoZXJtYWwvcmVuZXNhcyxyOWEwOWcwNDctdHN1LnlhbWwgICAg
ICAgIHwgIDg3ICsrKw0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDcgKw0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDln
MDQ3LmR0c2kgICAgfCAgNDkgKysNCj4gPiAgYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAg
ICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9zb2MvcmVuZXNhcy9LY29uZmln
ICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9zb2MvcmVuZXNhcy9yOWEw
OGcwNDUtc3lzYy5jICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9zb2MvcmVuZXNhcy9y
OWEwOWcwNDctc3lzLmMgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9zb2MvcmVuZXNh
cy9yOWEwOWcwNTctc3lzLmMgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9zb2MvcmVu
ZXNhcy9yei1zeXNjLmMgICAgICAgICAgICAgICAgIHwgIDI4ICstDQo+ID4gIGRyaXZlcnMvc29j
L3JlbmVzYXMvcnotc3lzYy5oICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4gIGRyaXZlcnMv
dGhlcm1hbC9yZW5lc2FzL0tjb25maWcgICAgICAgICAgICAgICB8ICAgNyArDQo+ID4gIGRyaXZl
cnMvdGhlcm1hbC9yZW5lc2FzL01ha2VmaWxlICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRy
aXZlcnMvdGhlcm1hbC9yZW5lc2FzL3J6ZzNlX3RoZXJtYWwuYyAgICAgICB8IDU3NSArKysrKysr
KysrKysrKysrKysNCj4gPiAgMTMgZmlsZXMgY2hhbmdlZCwgNzYwIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvcmVuZXNhcyxyOWEwOWcwNDctdHN1LnlhbWwNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGhlcm1hbC9yZW5lc2FzL3J6ZzNlX3RoZXJt
YWwuYw0KPiA+DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+ID4NCj4gDQo+IA0KPiBN
eSBib3QgZm91bmQgbmV3IERUQiB3YXJuaW5ncyBvbiB0aGUgLmR0cyBmaWxlcyBhZGRlZCBvciBj
aGFuZ2VkIGluIHRoaXMNCj4gc2VyaWVzLg0KPiANCj4gU29tZSB3YXJuaW5ncyBtYXkgYmUgZnJv
bSBhbiBleGlzdGluZyBTb0MgLmR0c2kuIE9yIHBlcmhhcHMgdGhlIHdhcm5pbmdzDQo+IGFyZSBm
aXhlZCBieSBhbm90aGVyIHNlcmllcy4gVWx0aW1hdGVseSwgaXQgaXMgdXAgdG8gdGhlIHBsYXRm
b3JtDQo+IG1haW50YWluZXIgd2hldGhlciB0aGVzZSB3YXJuaW5ncyBhcmUgYWNjZXB0YWJsZSBv
ciBub3QuIE5vIG5lZWQgdG8gcmVwbHkNCj4gdW5sZXNzIHRoZSBwbGF0Zm9ybSBtYWludGFpbmVy
IGhhcyBjb21tZW50cy4NCj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiBEVCBjaGVja3MgYW5kIGRp
ZG4ndCBzZWUgdGhlc2UgZXJyb3IocyksIHRoZW4gbWFrZSBzdXJlDQo+IGR0LXNjaGVtYSBpcyB1
cCB0byBkYXRlOg0KPiANCj4gICBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0K
PiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgd2FzIGFwcGxpZWQgKHVzaW5nIGI0KSB0byBiYXNlOg0K
PiAgQmFzZTogYXR0ZW1wdGluZyB0byBndWVzcyBiYXNlLWNvbW1pdC4uLg0KPiAgQmFzZTogdGFn
cy92Ni4xNy1yYzEtMTItZzBhMGUwODUyZjNmMyAoYmVzdCBndWVzcywgMTAvMTEgYmxvYnMgbWF0
Y2hlZCkNCj4gDQo+IElmIHRoaXMgaXMgbm90IHRoZSBjb3JyZWN0IGJhc2UsIHBsZWFzZSBhZGQg
J2Jhc2UtY29tbWl0JyB0YWcgKG9yIHVzZSBiNA0KPiB3aGljaCBkb2VzIHRoaXMgYXV0b21hdGlj
YWxseSkNCj4gDQo+IE5ldyB3YXJuaW5ncyBydW5uaW5nICdtYWtlIENIRUNLX0RUQlM9eSBmb3Ig
YXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzLycNCj4gZm9yIDIwMjUwODE4MTYyODU5Ljk2NjEt
MS1qb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbToNCj4gDQo+IGFyY2gvYXJtNjQvYm9vdC9k
dHMvcmVuZXNhcy9yOWEwOWcwNDdlNTctc21hcmMuZHRiOiBzeXN0ZW0tDQo+IGNvbnRyb2xsZXJA
MTA0MzAwMDAgKHJlbmVzYXMscjlhMDlnMDQ3LXN5cyk6ICcjYWRkcmVzcy1jZWxscycgZG9lcyBu
b3QNCj4gbWF0Y2ggYW55IG9mIHRoZSByZWdleGVzOiAnXnBpbmN0cmwtWzAtOV0rJCcNCj4gCWZy
b20gc2NoZW1hICRpZDoNCj4gaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL3JlbmVz
YXMvcmVuZXNhcyxyOWEwOWcwNTctc3lzLnlhbWwjDQo+IA0KDQpJbmRlZWQsIEkgbW9kaWZpZWQg
dGhlIHN5cyBub2RlIGFkZGluZyAjYWRkcmVzcy1jZWxscyB3aXRob3V0IGRvY3VtZW50aW5nIGl0
Lg0KVGhhdCBwYXRjaCB3aWxsIGJlIGRyb3BwZWQgaW4gbmV4dCBzZXJpZXMuDQoNClJlZ2FyZHMs
DQpKb2huDQoNCj4gDQo+IA0KPiANCg0K

