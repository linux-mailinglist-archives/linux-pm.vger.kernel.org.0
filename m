Return-Path: <linux-pm+bounces-24662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06760A76CD5
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4414E1888FA8
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6583A21859F;
	Mon, 31 Mar 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KIglP8S1"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A1189528;
	Mon, 31 Mar 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445264; cv=fail; b=As9yacmTj571kN1okBeUnPz3ESnAcRj+9Aua9VhJlcAnwZtkZsq0uFUtvq38f6xIGRWXlNo/YQEjI/fV+a66oYtyfHE60zpOZgyEyfnRhUvlwZQcolCVN7UIeV8O2orec7LAN//oEJP3mZUJEZ8kVxSRO0qNCg7TQ2fhmJ3S3YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445264; c=relaxed/simple;
	bh=YRqp0KUN1MBvsmOQw906BG9sTADTXikiYtmkWa0JrpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBJOKekF+4K0X3RiKwr95lL/hrjC8zXcms6IZ+XmuB2+hKsrBfR39P874yVxE+DJbp8E7eBqIKIGoYmzSL7tn7P8AsYXAixQ+NLNAa15VGRmoOkIrS/CwqrOcGiUyNv+cbl7A4L/OJGgLbj/apRmfWmTQtV01Aljq4pZOtdoSMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=KIglP8S1; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSwvqYNzSuBAetOPBMUein0seogngZgKmVu8rAtPSsY0O2GbxkMwNI+5W2fr6jaWfOW23C/TTAnKD3afb3XbhVSUuUCHWafH4Ex+r5SIepjRnKZu1Mgqb+pZ+Hyce9yfArLemMFV3Tt0WwkuDaO6QFpv0qss6LwqgwS0oAoGqUD18LgbZloCKVu87Vkp67YVDmhakAj66AKB4Ajv+o49wHAswNfqGyRkg11RbZvyGECRPR5/+g8IgxBP2HFdSuAKqavbJpDzCDGHsS1mHTnhGaBRufGpFBmWJqQ9StFI9cin65lRUMT5p+e6uRvZLAz8QC65eVt6dCqy5fYMrIa/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRqp0KUN1MBvsmOQw906BG9sTADTXikiYtmkWa0JrpM=;
 b=SzcPoNMv5O8pgSv0/ZInYEt75emjvv6YIZKdFSqHsfCuhjxeByFjUGHGliHItVBuEcP24NNa21oqLOmSB6akpEbbpnYAhfTv2ZjRPoYx76evPNrSxi6BTJR7eyFdLk/H+V6R/gtJ3jNhdh+e7ksPJprjobMWkdkUkz2KOvb/6iYzHdy5yC0N6DMzu/8jSmhN1UoO9fcd/9TpKZm6HHiqDXGntIF6kAP/mYpf0uU+x+GiLvJIn4s21Zk/bacZjGycHQR+EER9Qfn3XIAR0vJBf2kheos3OmNplIvD2FVO3oOmmk3vG9URw/mrRJN9QX0kyKgo4BGmNzXMq0eSsp8TGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRqp0KUN1MBvsmOQw906BG9sTADTXikiYtmkWa0JrpM=;
 b=KIglP8S18zHa1VS/YyWtFJaQYfDhXw1zinZJ1v82LctQ3F1ORPfkeEylz13GbMewlLBp8A/5WOVyF2GTH9U1qBx88EPuVlGVpGBsn9536NJj2h+FUB1Cs2vbHTjQiJqZX407EIDNsYni8JgRlvUzw7y48gvWk/jNPBQ5EX81gWA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB14449.jpnprd01.prod.outlook.com (2603:1096:405:235::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 18:20:57 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 18:20:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, John Madieu
	<john.madieu.xa@bp.renesas.com>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>, "rui.zhang@intel.com"
	<rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>
Subject: RE: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver
 for the Renesas RZ/G3E SoC
Thread-Topic: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver
 for the Renesas RZ/G3E SoC
Thread-Index: AQHbocDWXZHm58PP+067ToYVjN5OrbONjOOAgAABikA=
Date: Mon, 31 Mar 2025 18:20:56 +0000
Message-ID:
 <TY3PR01MB11346D38AB3F925DA2F46A5CA86AD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-4-john.madieu.xa@bp.renesas.com>
 <a380c593-a2a4-40d2-8b2f-e3e1a2cdbe9e@oracle.com>
In-Reply-To: <a380c593-a2a4-40d2-8b2f-e3e1a2cdbe9e@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB14449:EE_
x-ms-office365-filtering-correlation-id: 42f1a709-8f11-49c3-f252-08dd7080c7a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWxhYkZlckVlb2xTRzc1cDVHbDZKMWI0clpPYkNjaVdKMllrRXNzS3ZYMzVQ?=
 =?utf-8?B?enEvY2dLallSNU5wcmJ0ZEhrdS9DYkxNNThhd1pCNHdHT3RkVmlrT0xMUjRR?=
 =?utf-8?B?N1E3UjRXaG85K1pic3E3NFd1RHVZcVQ2YTY0d05xYWtaeFppRmQzQ3Rmc0NG?=
 =?utf-8?B?ZHp6Q0hzQjRSWmdEUTNWS0FYNnNPbUNDY1kycWgva1B3SHR1NnFHb0RyVGpE?=
 =?utf-8?B?M3lleUprNEUvVXJ0bHE3SGxzdU10TGNQeVl0RFNzbnk4RU9rVnVpbVB0YWY2?=
 =?utf-8?B?MWRLMjJ4U3BLRE5VUysyUzVSRkVLZGJjS0ZYOGowdmlCY2RRY3FMdmxuTlRs?=
 =?utf-8?B?NU54VG5HZ2ZIcjl1ZFVYbUNqSStiWFQyaXcwVTJlKy9Felp2YUNvYVdRSFM3?=
 =?utf-8?B?N1ZvUWU4RlJpaDJ0RG5zdVMrZFh1M1VhdDhMakxQYWJnTlczZy9zc2Qwakgz?=
 =?utf-8?B?elFhK1l0dSt0djF6MG5YMzdJeU9YL0NvSE42L0taeS9tSUN2K1p3RGxmMWhv?=
 =?utf-8?B?Sy9qejl0REl3TmFjK0NRQzhKMm5hekpicGpEYitVNTNGMjhJUnYybml2USsw?=
 =?utf-8?B?bWNuQ0hXK0h2VndUbkhDakpnNDNkMjRkQ2VWK2lpYVVEQ3c4SGlKT21FUXRH?=
 =?utf-8?B?WHZsM0l3V0FQRE4zYW1TRlo5S21KVmw1ejJ2TmN2RjhkK0xvWFI4Z2Q3VXZ3?=
 =?utf-8?B?N2x2ZGIzQ2k5MGJGeUFOcS8rVko3RldNclhlT2F6SFJEOC8wem9UV0xjZEpR?=
 =?utf-8?B?RWVONUlMbVdBL1l3c0dTeEltOXVCUEZ3aXB0SnpNZXBDaUNXaDJOb3c3bTVZ?=
 =?utf-8?B?U0pEdGpLMVljZkRsVVdEbGkzQytzc3pDUnp6SmErTnowYUhOakQvQjBaMWpO?=
 =?utf-8?B?VEZsZjMrUmx6eHJWd21iTVhscTBrNDM4NURQZ0NiS0YyT3E4SkM0UG5iVXBo?=
 =?utf-8?B?bjhkYkkvZWMxTW1KcTIzUGFTOGhRUUM2ZlNaRFlDcHNiWC9vT0lrVERwc3N2?=
 =?utf-8?B?TTl6MzZuTW84N1l5ZzdRWTNPMFNWdjNmbk9yWjkxS0t1YnlwZDRheWN2Q3py?=
 =?utf-8?B?UXBLWElYV21BZFV0T1FnZkRQVlBQOTc0NktlRUJSY09XMUxHTFBSOUhDclgv?=
 =?utf-8?B?YnRZMitNeGh6dUhtSTYxTEdDR3orSWVrR2RFQmxYRFlFbGVmV1RWZENNT0RI?=
 =?utf-8?B?MUpQblhubms0b0pDODdXd01mRUhPcGtMSW5RdnhVckpqSU11TmhyYmZtTDNE?=
 =?utf-8?B?SnhUeUozcHI1M2RYYnhEak1zK004SjRVd0I4YmVNd1hwOVA4bytZWlp0K0Y2?=
 =?utf-8?B?Mm85Qk0xUmtEeXVXVVNvRkdVT1RGZWpGVmR4MnpGTzFYa0hBOXVvdVc4Q25J?=
 =?utf-8?B?bmZIU0FKMWx3ZmNrbkduSnB1TkpTTU5rb2ZTZjkraUN4T3ZvaE1PeWpaVUNS?=
 =?utf-8?B?MEc5VGhacTN1WVcweVlVTFpDbWNSRWV2ZExuZ05yZnNxOTdrdXpSTW1rQVZO?=
 =?utf-8?B?NVFMSDc0YTVZYVVlYzlYMmVTS0w5ZDVtQ0lFL240eEp3Y051QUdXSHZvcng1?=
 =?utf-8?B?blByMU5VVkUyVi81NWVMNC81MVdXSzhQZkMxZEdKeVdpcURlL2F0U2IvaHVU?=
 =?utf-8?B?S01KT2Q0Y2ROaks3Ym9zcGs3VFlSay9mU1VFdVRQdlFSeGtFN0RSdVRZV1dH?=
 =?utf-8?B?VXJXM0xxeTdGT0RnRUlkNlBBVU9hWDRRREwzK2k0dGxsRFRDZVdsRGFoeWVh?=
 =?utf-8?B?RGtqQVhMR0UzYUdiSi91U1hWY0JxRm1OM29MRDhHL1BxT2tjOWhjaTVBSXlm?=
 =?utf-8?B?cS82WkVGaGM0dGk4S2JYWlg2L1N2TC84RUJMTkNYbU1TaGRMWFNpR3lyL0RT?=
 =?utf-8?B?OHdaYTFxUmJEb2sxVFRQbDNPZjcrd0VLMnR3N0N4NnNpMzRWc3dUVk1tN0p6?=
 =?utf-8?Q?M5oVLSAWhEj2gQfR+ggeHtILYIkX/5wx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDVKaHFpcFRmZ0Qvd1gxai91anlYZzMxM3RFa1ppNG9OWGlRK2hUdDhyejVz?=
 =?utf-8?B?cXh4dWtVOU1WM2NuekF3RUV3MFY0bTcxcUVzLzFUaWdNOVl5NXZ6UWxrZlF0?=
 =?utf-8?B?RUthalpiczZvZnlGT3VkNERWYUhORDdhVmIrV3JPZDhKTmV3c2xEdXllaUVv?=
 =?utf-8?B?cWtBcTZjcTI4dWorNUxBMEg1NG1hZ2RwRkppczVjS1dENDZyL2dlTG1lZW9x?=
 =?utf-8?B?VjlZSmdEd1g4RFpXMmFLQzFCRUF0cS9VUmxOMWY5TTBkeGg1V201VGl3Ujd5?=
 =?utf-8?B?cjdMeGlQRmo5N08vQVJhUEJSUFVBY1F0Nk9RenE4aTJxWExVNm5mNEFoTGRj?=
 =?utf-8?B?NjNFTUNzd0Rqbmd6OTFHRE0zS3N0NjNMeWc2cTUzWldxTldLSTVzanJGbEFI?=
 =?utf-8?B?OE5VN0RkN3JWV1hsSHZseVFLUUMwYVNQNzBUWnhQeEN6aDRiRWp3R0t2MUlM?=
 =?utf-8?B?Z0daTWtWTmhERmJlS0lGUW45SnBwTHNUajRrY2dWclJvWHkwMTJlbzVaZXNH?=
 =?utf-8?B?OVJROVNZMzBXMDUyaHQ3UGQ4ZjF5cUNxZ3N2cXNmRllNdDM3bXZ5bXFlL0No?=
 =?utf-8?B?RU9ibUx5ZEpHVi9lWmxhN3VuVkdzWWx5WHlueTB3VUsvb1pRQnpFb3dtZ1JP?=
 =?utf-8?B?MTBRV3puOGlkUk1SaE1LSVJVNXpQQUhBMkhiRW9YMkN1RTM2RDljeG1PL05K?=
 =?utf-8?B?RlNxOW1sL3VWYzVrWDZRZXFzeGdoRDN1aXhSTktrS010a1hNUU8xT0VGQmJV?=
 =?utf-8?B?ZTFHYUJpb2FiVGlZRGhwdGpPSkdiMEtNOWlIbUVUTmtHZVFlamdHbzNXcVZh?=
 =?utf-8?B?cTZKeHdQaGRHR2p0ZGJlZWFaNVdkQ1hsdzNoOGIvRTlsNFppMG1FVk5va0Y3?=
 =?utf-8?B?Ymc1UU5UcjZPOXlkRTl0RUtWUGhXdllESnNYOGtRR2UvR2RPWnRmRFVSaHdp?=
 =?utf-8?B?UE55aUtnMFM3MDVkUGdYTHFINXljaUYzUWkreWZ4Uk5yZnFJQlE5Q0tzemJw?=
 =?utf-8?B?S3M2QVVraEU5OXdSeXliRDZRRWRtanFVdElCbGdTVktkcjB0enhERC96Q01B?=
 =?utf-8?B?UHhINjRSVFkwOTBNd2p3UkpKSzU2cnFyaEVLMmY0bTVoU29kcVRlTkFPZ1Iy?=
 =?utf-8?B?c0piMVNLTkdZdS9VdzJWblFsRVI2SG4yUGw5Nmw5Nk53YW90NXp6VkI3bHlp?=
 =?utf-8?B?ZUJCN2prUU9kYXZFNEJUZWFjVUhtTG5ndFN0UUh6QXFPcVBFWjV6UDc1aFBV?=
 =?utf-8?B?a0hCTmhCbVZLaHh0ZWVad244SVVuOWtwSjVvMHk5VkYvRXhQalNVeFZGNlow?=
 =?utf-8?B?ZGZCYTh1SmYyVkU4RDBRM0tWYjcrTysrS1lDOFUydE1tczdzNldyS0J5KzE1?=
 =?utf-8?B?b1BEWU8vWkc0MnVOVytOWG16TGNNa1lXeGNtUHBsSC85UVdvaWxWQ2htVXB6?=
 =?utf-8?B?V1VUQWNTcEFIN2JaZGR1QjR0ZUl3UDdTSXJTVDhkRjNsNjl3aGdUbVhKNzRj?=
 =?utf-8?B?MVNJVXU5b1V1b3cwdDVuK3paeWh1TU9YVnZlY2V3ZjJXd2xwS2JRMFkyNWw2?=
 =?utf-8?B?N2JlMlJXa0tEZVNtRmI2ODBkdkxEbFJnYXJ0Z2JBZmMrOGcyeDZIaFVwM1l2?=
 =?utf-8?B?eFlLL3A0TGU3amZadDVCbnU4YVAzUEUvTlJzc1g5ZDA1VS9JMHhxNkNJKysx?=
 =?utf-8?B?R2VQQXp5dC90VEgxU0NnRFFTako3YWY4dHZaQlphTmJyc0txOUhPVFR2eTI2?=
 =?utf-8?B?M1hDTDhWNlZDeEh0Q2thZEVDSU9QT1g1RjlFam5jNSs3QkcvM0hMRTdMcmx0?=
 =?utf-8?B?WlhvT2pJWE9kd3lucFppTWFQMUo5eEdIOWhBVHlHMXBVUElEUlllcGRMaEVn?=
 =?utf-8?B?aXN3MXNodnBrNXlCbTFWemFvYzh0UHNCVk12T0JxYmJiTUJYeFMwd2FPaDFH?=
 =?utf-8?B?Ty82UGlDZzBOeXFYaXBSN2VieVJwK1JJY05naUF0YnpuL09sNDV3Ti9uU2hO?=
 =?utf-8?B?UXV0QlloOXN5ckZOeTBlOWx0cnNwQ2VLL1JoTFNYS0s2NFJ4MGozdmdpSTB3?=
 =?utf-8?B?T2dSQ1V6WFVsRmJ6S0FVRjk5QVAyMXZjOU96MTEvNElXbVVmMHgzRVNsZzhQ?=
 =?utf-8?B?WlV4blMvYmwzTnA4c25xT0xPM3RnSkpLei95OFhZUFVrU2lONHcvTitzZkZO?=
 =?utf-8?B?VUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f1a709-8f11-49c3-f252-08dd7080c7a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 18:20:56.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQsRR4aB9qwW7t1X95SbSe3ObmrWrRUkEGNpvTdF9pL/pBVcuSDkXQhYKfn0EhgCX99JEqztJYtplU+p3c+Ao0SB2Vd8J1m7rOctLKwN2P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14449

SGkgQWxvaywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBTE9LIFRJ
V0FSSSA8YWxvay5hLnRpd2FyaUBvcmFjbGUuY29tPg0KPiBTZW50OiAzMSBNYXJjaCAyMDI1IDE5
OjExDQo+IFN1YmplY3Q6IFJlIDogW1BBVENIIHY1IDMvNV0gdGhlcm1hbDogcmVuZXNhczogcnpn
M2U6IEFkZCB0aGVybWFsIGRyaXZlciBmb3IgdGhlIFJlbmVzYXMgUlovRzNFIFNvQw0KPiANCj4g
DQo+IA0KPiBPbiAzMS0wMy0yMDI1IDAzOjE5LCBKb2huIE1hZGlldSB3cm90ZToNCj4gPiBUaGUg
UlovRzNFIFNvQyBpbnRlZ3JhdGVzIGEgVGVtcGVyYXR1cmUgU2Vuc29yIFVuaXQgKFRTVSkgYmxv
Y2sNCj4gPiBkZXNpZ25lZCB0byBtb25pdG9yIHRoZSBjaGlwJ3MganVuY3Rpb24gdGVtcGVyYXR1
cmUuIFRoaXMgc2Vuc29yIGlzDQo+ID4gY29ubmVjdGVkIHRvIGNoYW5uZWwgMSBvZiB0aGUgQVBC
IHBvcnQgY2xvY2svcmVzZXQgYW5kIHByb3ZpZGVzIHRlbXBlcmF0dXJlIG1lYXN1cmVtZW50cy4N
Cj4gPg0KPiA+IEl0IGFsc28gcmVxdWlyZXMgY2FsaWJyYXRpb24gdmFsdWVzIHN0b3JlZCBpbiB0
aGUgc3lzdGVtIGNvbnRyb2xsZXINCj4gPiByZWdpc3RlcnMgZm9yIGFjY3VyYXRlIHRlbXBlcmF0
dXJlIG1lYXN1cmVtZW50LiBBZGQgYSBkcml2ZXIgZm9yIHRoZSBSZW5lc2FzIFJaL0czRSBUU1Uu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAu
cmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gdjEgLT4gdjI6IGZpeGVzIElSUSBuYW1lcw0KPiA+
IHYyIC0+IHYzOiBubyBjaGFuZ2VzDQo+ID4gdjMgLT4gdjQ6IG5vIGNoYW5nZXMNCj4gPiB2NTog
cmVtb3ZlcyBjdXJseSBicmFjZXMgYXJyb3VuZCBzaW5nbGUtbGluZSBwcm90ZWN0ZWQgc2NvcGVk
IGd1YXJkcw0KPiA+DQo+ID4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDcgKw0KPiA+ICAgZHJpdmVycy90aGVybWFsL3JlbmVzYXMvS2NvbmZpZyAgICAgICAg
IHwgICA3ICsNCj4gPiAgIGRyaXZlcnMvdGhlcm1hbC9yZW5lc2FzL01ha2VmaWxlICAgICAgICB8
ICAgMSArDQo+ID4gICBkcml2ZXJzL3RoZXJtYWwvcmVuZXNhcy9yemczZV90aGVybWFsLmMgfCA0
NDMgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDQ1OCBp
bnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90aGVybWFsL3Jl
bmVzYXMvcnpnM2VfdGhlcm1hbC5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMg
Yi9NQUlOVEFJTkVSUyBpbmRleA0KPiA+IGI5ZjdkMjExNWI1Ny4uYmE3Yzk1MTQ2ZjAxIDEwMDY0
NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAt
MjAyODksNiArMjAyODksMTMgQEAgUzoJTWFpbnRhaW5lZA0KPiA+ICAgRjoJRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9wb3RlbnRpb21ldGVyL3JlbmVzYXMseDkyNTAueWFt
bA0KPiA+ICAgRjoJZHJpdmVycy9paW8vcG90ZW50aW9tZXRlci94OTI1MC5jDQo+ID4NCj4gPiAr
UkVORVNBUyBSWi9HM0UgVEhFUk1BTCBTRU5TT1IgVU5JVCBEUklWRVINCj4gPiArTToJSm9obiBN
YWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiA+ICtMOglsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiArUzoJTWFpbnRhaW5lZA0KPiA+ICtGOglEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9yZW5lc2FzLHI5YTA5ZzA0Ny10c3UueWFtbA0K
PiA+ICtGOglkcml2ZXJzL3RoZXJtYWwvcmVuZXNhcy9yemczZV90aGVybWFsLmMNCj4gPiArDQo+
ID4gICBSRVNFVCBDT05UUk9MTEVSIEZSQU1FV09SSw0KPiA+ICAgTToJUGhpbGlwcCBaYWJlbCA8
cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gPiAgIFM6CU1haW50YWluZWQNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90aGVybWFsL3JlbmVzYXMvS2NvbmZpZw0KPiA+IGIvZHJpdmVycy90aGVy
bWFsL3JlbmVzYXMvS2NvbmZpZyBpbmRleCBkY2Y1ZmM1YWUwOGUuLjEwY2Y5MGZjNGJmYQ0KPiA+
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9yZW5lc2FzL0tjb25maWcNCj4gPiAr
KysgYi9kcml2ZXJzL3RoZXJtYWwvcmVuZXNhcy9LY29uZmlnDQo+ID4gQEAgLTI2LDMgKzI2LDEw
IEBAIGNvbmZpZyBSWkcyTF9USEVSTUFMDQo+ID4gICAJaGVscA0KPiA+ICAgCSAgRW5hYmxlIHRo
aXMgdG8gcGx1ZyB0aGUgUlovRzJMIHRoZXJtYWwgc2Vuc29yIGRyaXZlciBpbnRvIHRoZSBMaW51
eA0KPiA+ICAgCSAgdGhlcm1hbCBmcmFtZXdvcmsuDQo+ID4gKw0KPiA+ICtjb25maWcgUlpHM0Vf
VEhFUk1BTA0KPiA+ICsJdHJpc3RhdGUgIlJlbmVzYXMgUlovRzNFIHRoZXJtYWwgZHJpdmVyIg0K
PiA+ICsJZGVwZW5kcyBvbiBBUkNIX1JFTkVTQVMgfHwgQ09NUElMRV9URVNUDQo+ID4gKwloZWxw
DQo+ID4gKwkgIEVuYWJsZSB0aGlzIHRvIHBsdWcgdGhlIFJaL0czRSB0aGVybWFsIHNlbnNvciBk
cml2ZXIgaW50byB0aGUgTGludXgNCj4gPiArCSAgdGhlcm1hbCBmcmFtZXdvcmsuDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9yZW5lc2FzL01ha2VmaWxlDQo+ID4gYi9kcml2ZXJz
L3RoZXJtYWwvcmVuZXNhcy9NYWtlZmlsZQ0KPiA+IGluZGV4IGJmOWNiM2NiOTRkNi4uNWEzZWJh
MGRlZGQwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9yZW5lc2FzL01ha2VmaWxl
DQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3JlbmVzYXMvTWFrZWZpbGUNCj4gPiBAQCAtMywz
ICszLDQgQEANCj4gPiAgIG9iai0kKENPTkZJR19SQ0FSX0dFTjNfVEhFUk1BTCkJKz0gcmNhcl9n
ZW4zX3RoZXJtYWwubw0KPiA+ICAgb2JqLSQoQ09ORklHX1JDQVJfVEhFUk1BTCkJKz0gcmNhcl90
aGVybWFsLm8NCj4gPiAgIG9iai0kKENPTkZJR19SWkcyTF9USEVSTUFMKQkrPSByemcybF90aGVy
bWFsLm8NCj4gPiArb2JqLSQoQ09ORklHX1JaRzNFX1RIRVJNQUwpCSs9IHJ6ZzNlX3RoZXJtYWwu
bw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvcmVuZXNhcy9yemczZV90aGVybWFs
LmMNCj4gPiBiL2RyaXZlcnMvdGhlcm1hbC9yZW5lc2FzL3J6ZzNlX3RoZXJtYWwuYw0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5mZTUwZGYwNTdiNzQN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3JlbmVzYXMvcnpn
M2VfdGhlcm1hbC5jDQo+ID4gQEAgLTAsMCArMSw0NDMgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogUmVuZXNhcyBSWi9HM0UgVFNV
IFRlbXBlcmF0dXJlIFNlbnNvciBVbml0DQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoQykg
MjAyNSBSZW5lc2FzIEVsZWN0cm9uaWNzIENvcnBvcmF0aW9uICAqLyAjaW5jbHVkZQ0KPiA+ICs8
bGludXgvY2xrLmg+ICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPiAjaW5jbHVkZSA8bGludXgvZXJy
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4gI2luY2x1ZGUgPGxpbnV4L2lv
Lmg+ICNpbmNsdWRlDQo+ID4gKzxsaW51eC9pb3BvbGwuaD4gI2luY2x1ZGUgPGxpbnV4L2tlcm5l
bC5oPiAjaW5jbHVkZQ0KPiA+ICs8bGludXgvbWZkL3N5c2Nvbi5oPiAjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+ICNpbmNsdWRlDQo+ID4gKzxsaW51eC9vZl9kZXZpY2UuaD4gI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RldmljZS5oPiAjaW5jbHVkZQ0KPiA+ICs8bGludXgvcmVnbWFwLmg+ICNp
bmNsdWRlIDxsaW51eC9yZXNldC5oPiAjaW5jbHVkZSA8bGludXgvdGhlcm1hbC5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvdW5pdHMuaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRlICIuLi90aGVybWFs
X2h3bW9uLmgiDQoNCjxzbmlwPg0KPiA+ICtzdGF0aWMgaW50IHJ6ZzNlX3RoZXJtYWxfY2hhbmdl
X21vZGUoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LA0KPiA+ICsJCQkJICAgICBlbnVt
IHRoZXJtYWxfZGV2aWNlX21vZGUgbW9kZSkgew0KPiA+ICsJc3RydWN0IHJ6ZzNlX3RoZXJtYWxf
cHJpdiAqcHJpdiA9IHRoZXJtYWxfem9uZV9kZXZpY2VfcHJpdih0eik7DQo+ID4gKw0KPiA+ICsJ
aWYgKG1vZGUgPT0gVEhFUk1BTF9ERVZJQ0VfRElTQUJMRUQpDQo+ID4gKwkJcnpnM2VfdGhlcm1h
bF9od19kaXNhYmxlKHByaXYpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJ6ZzNlX3RoZXJtYWxfaHdf
ZW5hYmxlKHByaXYpOw0KPiA+ICsNCj4gPiArCXByaXYtPm1vZGUgPSBtb2RlOw0KPiA+ICsJcmV0
dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+IGFsd2F5cyByZXR1cm4gMCBoZXJlID8gd2hhdCwgaWYg
KCFwcml2KSByZXR1cm4gLUVJTlZBTDsgPw0KDQpwcml2IGNhbm5vdCBiZSBOVUxMIGFzIGl0IGlz
IGNoZWNrZWQgaW4gcHJvYmUoKS4NCk1heWJlIHJlcGxhY2Ugc3RhdGljIGludCByemczZV90aGVy
bWFsX2NoYW5nZV9tb2RlLT4NCnN0YXRpYyB2b2lkIHJ6ZzNlX3RoZXJtYWxfY2hhbmdlX21vZGUo
KS4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQoNCkNoZWVycywNCkJpanUNCg0KPiANCg==

