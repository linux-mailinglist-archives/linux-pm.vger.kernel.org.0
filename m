Return-Path: <linux-pm+bounces-28787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5235BADA9AA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF1D16AB3A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29F91FF1C4;
	Mon, 16 Jun 2025 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WzUm1MRD"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012010.outbound.protection.outlook.com [52.101.71.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C11FECB0;
	Mon, 16 Jun 2025 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059709; cv=fail; b=JIJMsjJ+QXqXDhd4oHFXSBDehtrv231LIcj6tECYUag4tMXCDxcPbqx2xxc3rvObog3wmgQg39ftbjE/FR45Tasj9ZZMhEXspTA8MKA+kdRc9H9hSpGn+Arv2y6z5VTxXzxMapQYU6XMNm3lzhWplNxgWHEWUsKAfC5gydA7CLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059709; c=relaxed/simple;
	bh=rvuEmA2oLJ+w2RjQWFI8tXPxL5qRcJXcYzD+vFEzOeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HSphTWza7CAHWtxzupKWViXQs3vdTgg5QI7TyJnI40ft/jYRSJ0tnjXAUZWfFdB9ungdOdS7AXrkgrWLMYPYGdVnAnjg9LBEg9TPRfqMzcV2t0ijXC/h4iW5hCEq1IaR0OphQAyblyKsGtHcM53PiTMmsvWVJKvw66/Yd91z/tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WzUm1MRD; arc=fail smtp.client-ip=52.101.71.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aysyn3L5XFIfw/EL57Vxg6HZx+RPcQ1iMM1e84uHd2LLeC2YqL13RFz46QFPTLVs7uSnmWwiBqoaOZhyhzNZCbCbit/aM1pnzrcVi5SNUgfc60PenE8xrVOKAyjsOuAhunlKJRkjsfbyyEcUk6m2uq01RduQnbb62W8l6+e7NPaNJguA806ryTwxiPEjn2ynm4PJHFgMBomf5Luu6YfeLFek/1u0rojKFEnrrdrbOu1kXCIk1e6Ze0HfJBc66KLgDMIawnrQ39kZor1N+VCmhMaHCiv3EDp/SGp1nc4WvTPCP/jJp5/Qj8Zg17L+Jo7cZvEJvrBvxqFggNwog/CVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvuEmA2oLJ+w2RjQWFI8tXPxL5qRcJXcYzD+vFEzOeM=;
 b=QvyujmKiuyZ9N+IAiigLKpZGEEFMze9tCGS5IyyjF1zv6U+inWcFxOgmEBSa/5Z+c1KLbsWs7zTOfV/ijnVCpsnt+7RJEnGnS+5aKa/A7/52+UeZrge+JUMUXw6r5gx3Vi4UNDymiDMwrfmc9maB2Ns2BG+NWxatWV3037u70GJMzjDpiIIpXXwipj24tQRTO2jo5ZaMEFugQBpeo2dncrBFPUhPTMKqVF/vTy7OtqcApoRhILS3VuT0xpd7skYtpuzyKHj/ExytxwYeqV9fc6RlpMXAatuCdlhkCoXLp7SbkMic9o7nM46cgRACRDXR+7xIqdswcRitGJcsYtm0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvuEmA2oLJ+w2RjQWFI8tXPxL5qRcJXcYzD+vFEzOeM=;
 b=WzUm1MRD5ihf+hsq6K35EzUjfeN25Hb4eT53CEBM+ySV+Uer83IQbSkXTHUo1D7ZINCvh39i1W1NVA5dpqjR7rV+ZhmyyACYYzuMFX1MO+Yfch8zcvkApM/a6lJPU11qP10DIfrwvHQb8zzcXYTg+ucl+hlM1bF7oMToUJohLK9XiJLq3kwX3N+xAm8zPmz7upK/u0NA6HIK/i+Ud7g+8+5FUyZYIS5RUkRc6I0niqbDjuitxwQxx6I69+Ux2Ql/ZUR8C7YjbxWBn+1vGuze5cNGO74dj5xxGMqCgCd+6PO6oFFQqW9JE7fK3WaqiXr8AFsOBafgVfGHiBZodCt/ww==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 07:41:44 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 07:41:44 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Ye Li
	<ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE:  Re: [PATCH v5 3/9] arm64: dts: freescale: rename imx93.dtsi to
 imx91_93_common.dtsi
Thread-Topic: Re: [PATCH v5 3/9] arm64: dts: freescale: rename imx93.dtsi to
 imx91_93_common.dtsi
Thread-Index: AQHb3pIbaQxGnV82eky+POAn5zXl3A==
Date: Mon, 16 Jun 2025 07:41:44 +0000
Message-ID:
 <AS4PR04MB9386C1638958FD948975B622E170A@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <20250613100255.2131800-4-joy.zou@nxp.com>
 <4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org>
In-Reply-To: <4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|PAXPR04MB8510:EE_
x-ms-office365-filtering-correlation-id: 3b1977a7-7bc3-49fe-e832-08ddaca93dbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?L2kxYnptb3ByMVVTRXdvQ25hdjZ6VFlTSWd4NjVBdWFNeTljRHRoVytwc0tJ?=
 =?gb2312?B?OFJqMi84Ym1DREtxcitKNzBsMExhOW9XNkc2YXV1WnhFNDkydHZSOUNrRUlm?=
 =?gb2312?B?YjBKd3JCblc0OS9RSFUrd2FHNkdqZWl1OU1YQ09kRHhRbG54c1M3bndzMjRt?=
 =?gb2312?B?WXo0TmNrbGhoUFg1THJ6cE1RS2VGNWFqSEpMNktPMVdTZEIvL01TUEw4YUtU?=
 =?gb2312?B?Ri9Sams5NmhRN2U1NVo2blFyTXk2bmVBYlUzVFJsWitKRHJqMFJuSldmNUVR?=
 =?gb2312?B?MDlScll5ZVQzMEczQ1VZOERjWURrdXdtQ3YyNzdBYWZrTVRKVXN0VThvTnVO?=
 =?gb2312?B?SlJuUnRuZUJFbzdDb3gxcG0xYitRWXdZTytVcmVDM3crWEVpUzNkN0hGL2JE?=
 =?gb2312?B?ZndvRHFSZ3I0YVZPWE9mZ0JUQ2gxcUZ5eVIzNVhiSnkwdjQ0QnEvVThJczZX?=
 =?gb2312?B?SmtBbmpyU2M2WFU5dXF1eC9abGtRd1AydlBKR0k0bXYwejJ3WWRwZ3BqODJJ?=
 =?gb2312?B?MXRSZEVnci9aV1hscEIva3MwWXAxcXpvdVVzQWVGOFlqNDFwb0Z0a2FRSGNC?=
 =?gb2312?B?N3ZPN2lNMlJ5NFg3bnBoSCtVQ1M5QkpYNXJYMmxFdVZZa1Bhb3ZaZDVQM2RT?=
 =?gb2312?B?bU8xVVRTZUhnQWxxYzMraVFRbkordEJSaHpFbTkwUU1tdGNTWDcxQnZTNUI0?=
 =?gb2312?B?bUcxb01Cb1NBUTZEeDYrS016cXpoQ3VnQndxbUdiKzA5T3l1WE9zZWpkMWV4?=
 =?gb2312?B?RXlmZGlvbEwyWk5iM1JyajhBTjUrSmI2ak52WUFWNXRGcjEyWVI3L0dpVkI4?=
 =?gb2312?B?bmpoYlRFdHA3VUVGTzRGVVFUSGlMVEQ1NmN3b3pseTBibGpFMGRGMnZEeXZ6?=
 =?gb2312?B?RmRIVmY0aCt4Zi9OMlFsbWNORXVhYjI0MjdqeTFndE5Uc3FtWW5Wa0FPcDVG?=
 =?gb2312?B?T25vcE1JTWNIVkQ0WXB2TDlSV0lQNlBuZVVJZlVDMjI3bitYcE9uTW9pSmYr?=
 =?gb2312?B?aGdUYmlRZGFZOXZEdkwrOTI1aVNYaVFrUDhiaEQvQkxYbzloekdydWxsTGxl?=
 =?gb2312?B?YTlualJiakRiNzk3OXQ0U2lZZ3QzNklIdEFXSTdXYWFFZDhMd0V4bVFCdC9J?=
 =?gb2312?B?ZVNKSXJLcXpKY1JWSWt6ZUdsWVR5QTNFSG5NTFVvZWZzQzZXcHRsa0dvWS9j?=
 =?gb2312?B?bVZTOHN2ZEoxOGxXRGxicElyTG1NUUVaZlFzaXFYYTlaMW5oZGcvSEZodTB0?=
 =?gb2312?B?ei85QWtaVWhodGVpTWJRbndIaFdJUXdRcU83dFpRL25JM0dsQ25YMmp0YnMy?=
 =?gb2312?B?M2k1OEVKT1JvNHFkbGw4UEk5cVhqbTBydTEwMWR0UXJva0F0Mll4SHNRcnlh?=
 =?gb2312?B?RVJLRUVWaWpOR2U4cVVReEdrQVBjNkhXUUYxd3gxQVp2RWNXays3ZHZPeHZP?=
 =?gb2312?B?czBwN2xxV21ERllBUWRXRzVKK1NybkRqOXI2MitUcERQa2swYjhUbEhqeHJC?=
 =?gb2312?B?OUo5dHZ3WHBwQTZYQ2l0dmVZaUQzUmRUa0laU2FnMEFSWnhoMWtia1hsVFor?=
 =?gb2312?B?K01iZ1hIMFR5SXdieHpLZmFCa2xtckRvU2VvV0RXTUdzS1lRRmZhUG44Njhw?=
 =?gb2312?B?WVR3V0RpL2NWQmtCY0oyT2MwVmJkSEdSZm5yVFB2ZUhMVGZKYTA1R3NHSW5n?=
 =?gb2312?B?N1FtYkpyYlN6NUFxR01xVVBvMmYrZGZacC9LVFJYdE9pUGpHRkQyajJOR1Uw?=
 =?gb2312?B?TEtWb2xhZ0RhM0s4dTJEMmpLL2poWDFoU04vUmNpeHFxNS9lcE8zd3ZOa09w?=
 =?gb2312?B?NW9adXBSa3RDWWVCSHVuU0RPSmJrMlgrelhwY2xiNGVGTHE0QnA3S2VvWDE2?=
 =?gb2312?B?WldOcVRvVk03M0hUWE4yQ3U1QkRJM0YzalphcmZ6Y0hzdGpzNWVlb0JtNjJi?=
 =?gb2312?B?U20rQmFqNDQ0UitETXFQcTl6ZmViWTJlWGN4bndIMHFOeGpoU1p0eTkrdVpE?=
 =?gb2312?Q?beNnecOrkPW8pz+sz3ajIZBoQjb3qY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VXRWQktoVTBqTjlwK2FZa1dzWkdHbnhQZFVldlpEazFib3hJMWNrUkd3eUFs?=
 =?gb2312?B?UFk0bTlIUCtsVWVWV1ZIZkVjMHFTK2d2Zy96aDVuV0c4QVF0dDRIWXFWczV4?=
 =?gb2312?B?c3dESWlMWGZpMFZQMlk2SjdaS2NmS3dMcFRhZG8wQnYyNzJ0c2hEUllUdXo1?=
 =?gb2312?B?UXYwc3pkbDVIeld0THR1MVEwWjhxTEtBaGo4cG56QkljMlo5aThLa1pkQWxC?=
 =?gb2312?B?NGpJdFJXbmpneXh6VlpCdmlEOXlKcVV6M0pmTHY1U2tmWExJblIzM21yWkhk?=
 =?gb2312?B?QWZhM1NZVzFua3hoaUtWZVRyazh2L05OcVJXS2p0ZmNVM2VZUVVYbFJ4bm9G?=
 =?gb2312?B?ejN2WUE1bkN4NEErTjhmNEVPdzdzdEhmNVMyZElRMTRSeTArWUNmek1kV01I?=
 =?gb2312?B?b2htVnJ0TmZoNTErd0pXZk1vRzRBd1ZsbnVvUDJqQTJqd0xEc0NiSzNUaDBB?=
 =?gb2312?B?cW1TY3JhaXhCNys4YVpsNjBFYS8ybHQ5TUszNW9OVm5yTDlmRXFRUWFvTTlx?=
 =?gb2312?B?dUp6T2ZpVXNGdHo0TVRzaWRBNHkxNG96bUhtTEhkN28yZkdRK25ZOHVzbGhK?=
 =?gb2312?B?aytPQno4SXF2MVZiMW1qSFhTenQyVEpXYzJpUytkTDNDYTNBc01JMnZETHlu?=
 =?gb2312?B?T3VDOEJGS0JhTC9jQTdUNVVXZGd2TnBKUndyZjBjSHBiRkFRQTdDM01pN2Ir?=
 =?gb2312?B?MU5NVCtvemFFVTVxWVBIMGt0MnU1VGRtTWlMWUZGSi9KOGZXTG1meTZHSFBR?=
 =?gb2312?B?OW4yTzhiVDUrOWUvYk9CV1BQMjBHSG04TzV4Q2hUVjdXaEN3amZNN2M2TlBC?=
 =?gb2312?B?d0tMOXlxMGJUS3plNDNueEpaMklRSDhnaGdxNVVxQ0xJbjg5T0NxRm5Yc0lC?=
 =?gb2312?B?Z2VqeFZXZklNaGFEU0c4T3NtelFSeVEzSzFDTFUrMnZESU4zR2k2bU40cVBD?=
 =?gb2312?B?SGVMRUlkUk1TMHEvTUc1NjZKcEpmc0F1WjRWakJZdHN2c0FnWVUySkJhbVhT?=
 =?gb2312?B?d1l0ZW0rMjBSNHZjcDZVUkEyM2Vxb0tNUXFhWTdXUVdrSHIzdzR4WWJsUDhG?=
 =?gb2312?B?aWY2Smkrd1NFZ3lJYzVCSERSaUNYMk50cmdYUDNza2ZNczl0UTUyT1FmVzl5?=
 =?gb2312?B?VUlyY2x0SVgwRERldzJKN2w0QkNIcDBWNWhrRytPRXFBanVzYzJYeTNsWWVk?=
 =?gb2312?B?T2xQY2RhdHVrMFJrUk1GZnh6MElOdXFBRHlwVllEUE1VN2E5NnhvZDdyS1RD?=
 =?gb2312?B?eUNuSkMyeldwK0lOYW9mWWpuMWpqZXJJcnNiS1pjZWZ6TXJ5ZzVuK1grNksz?=
 =?gb2312?B?QTJhbWpZRU03elRKWnpYZXB3LzVqa01qd25MemJJYng0QVNOSnB0LzNEeTdO?=
 =?gb2312?B?dHZwZ01OK0UxV3FjaFlVeVpYQ1RnNXhnL2djWTRDN3ZkbjFFdnZoZUZJNEgx?=
 =?gb2312?B?U245ekkzQUFJR1JPMnQrOHFYNGxvOVBTRytpKytXYzhaYlFGQmhvUDh2Y3Rs?=
 =?gb2312?B?MVordHZPNS9oK1VuWkI3YUlWYVpEbUJYUFdFNnpaQVh1VUlDcUtRR1lDUnhh?=
 =?gb2312?B?TnN2VUZIQ0pUajJkTEZBN3o0bmIvanU0QnpDR0lhVGM2QTNoVUJFSWtRZXda?=
 =?gb2312?B?bGpsOFp2TTZtRXRKVlhON3IwU05mYUwzcHRGS24yS3ZqWUpXSDloVEZNY1dL?=
 =?gb2312?B?YUo4eER0b2Z6dElaWStOZ0FmSjJCbkVpOG9CeUd6N3NoQWllUnlmWDJLcGR1?=
 =?gb2312?B?ZW9IWFkrU2NTUy9RS1NPZUhRb2lrTHdGbTZuWGlpZjZOVzhvVFJvTjMrbU42?=
 =?gb2312?B?bzNnWDVjUmhzNFB1bGlGSzUrWVdpa3oyblJNWlRLMnA1a2I3QXFNNlJyWlFG?=
 =?gb2312?B?WVN2aVEvZmVqQkJBSXJNRDUrbmVpTjY0bytwT0NkME12bFY3azNoMWR4YVVX?=
 =?gb2312?B?d2RsSGhQc1p6NkQ0TzJBVHlkNGpLd1J6OWpYNytEWmhRUGJXZTE4Y2xXdEVV?=
 =?gb2312?B?aC8rZWlTV1Z2dzFYdFlmOTV6WE1OeXVpeFk1dklmNEV5RjU1dkppb0xFamxV?=
 =?gb2312?B?UWV5aThXYng0MklrZis5T1loZkNRQ3VNdUhKZlFMTUhNUjFOVnUwbzkzbGdt?=
 =?gb2312?Q?T49E=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1977a7-7bc3-49fe-e832-08ddaca93dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:41:44.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2zB4Drcuek+LqhtmZ4OJBRaJZDRue6+/naMiw32bCs8ni/xve3+o7VrbesSo5GD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNcTqNtTCMTPI1SAxODo0Mw0KPiBUbzog
Sm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5l
bC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5l
bC5vcmc7IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsg
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbTsNCj4gYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNv
bTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsNCj4gcmljaGFyZGNvY2hyYW5AZ21haWwuY29tOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBs
aXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJl
cGx5LmNvbTsNCj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPjsNCj4gSmFja3kgQmFpIDxwaW5nLmJhaUBu
eHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBBaXNoZW5nIERvbmcNCj4gPGFp
c2hlbmcuZG9uZ0BueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvOV0gYXJtNjQ6IGR0czogZnJlZXNjYWxlOiByZW5h
bWUgaW14OTMuZHRzaSB0bw0KPiBpbXg5MV85M19jb21tb24uZHRzaQ0KPiANCj4gT24gMTMvMDYv
MjAyNSAxMjowMiwgSm95IFpvdSB3cm90ZToNCj4gPiBSZW5hbWUgaW14OTMuZHRzaSB0byBpbXg5
MV85M19jb21tb24uZHRzaSBmb3IgYWRkaW5nIGlteDkxLmR0c2kuDQo+IA0KPiBXaHk/DQpUaGFu
a3MgZm9yIHlvdXIgY29tbWVudHMhDQpUaGUgZGVzaWduIG9mIGkuTVg5MSBwbGF0Zm9ybSBpcyB2
ZXJ5IHNpbWlsYXIgdG8gaS5NWDkzIGFuZCBvbmx5IHNvbWUgc21hbGwgZGlmZmVyZW5jZXMuDQpU
aGUgaW14OTEuZHRzaSBpbmNsdWRlIHRoZSBpbXg5My5kdHNpLCBlYWNoIGFkZCB0byBpbXg5My5k
dHNpIHJlcXVpcmVzIGFuIHJlbW92ZQ0KaW4gaW14OTEuZHRzaSBmb3IgdGhpcyB1bmlxdWUgdG8g
aS5NWDkzLCBlLmcuIE5QVS4gDQpUaGUgaW14OTEgaXNuJ3QgdGhlIGlteDkzIHN1YnNldCwgaWYg
dGhlIGlteDkzLmR0c2kgaW5jbHVkZSB0aGUgaW14OTEuZHRzaSwNCnRoZSBzYW1lIHByb2JsZW0g
d2lsbCBvY2N1ci4NCkNvbW1vbiArIGRlbHRhIGlzIGJldHRlciB0aGFuIGNvbW1uIC0gZGVsdGEs
IHNvIGFkZCBjb21tb24uZHRzaSBmb3IgaW14OTEgYW5kIGlteDkzLA0KdGhlbiB0aGUgaW14OTMg
YW5kIGlteDkxIHdpbGwgaW5jbHVkZSB0aGUgY29tbW9uLmR0c2kuDQo+IA0KPiBZb3VyIGNvbW1p
dCBtc2cgTVVTVCBleHBsYWluIHRoYXQuIFRoYXQncyB0aGUgbW9yZSBpbXBvcnRhbnQgcGFydC4N
CldpbGwgbW9kaWZ5IGNvbW1pdCBtZXNzYWdlIHRvIGV4cGxhaW4gdGhhdC4gIA0KPiANCj4gPiBU
aGVyZSBpcyBubyBjb2RlIGNoYW5nZS4NCj4gPg0KPiA+IEFkZCBpbXg5My5kdHNpLCB3aGljaCBp
bmNsdWRlIGlteDkxXzkzX2NvbW1vbi5kdHNpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm95
IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDkxXzkzX2NvbW1vbi5kdHNpICAgfCAxMzUxDQo+ICsrKysrKysrKysrKysrKysrDQo+
ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kgICAgICB8IDEzNDkg
Ky0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gR2VuZXJhdGUgcGF0Y2hlcyB3aXRoIHByb3BlciAtTS8t
Qi8tQyBmbGFncyBzbyBpdCB3aWxsIGJlIHBvc3NpYmxlIHRvIGFjdHVhbGx5DQo+IHJldmlldyB0
aGlzLg0KV2lsbCBhZGQgdGhlIHByb3BlciAtTS8tQi8tQyBmbGFncyB3aGVuIGdlbmVyYXRlIHBh
dGNoZXMuIA0KSGF2ZSB0cmllZCBkbyBpdCBhbmQgaXQncyBiZXR0ZXIhDQo+IA0KPiANCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxMzUzIGluc2VydGlvbnMoKyksIDEzNDcgZGVsZXRpb25zKC0pICBj
cmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5
MV85M19jb21tb24uZHRzaQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDkxXzkzX2NvbW1vbi5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg5MV85M19jb21tb24uZHRzaQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42NGNkMDc3NmI0M2QNCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTFfOTNfY29t
bW9uLmR0c2kNCj4gPiBAQCAtMCwwICsxLDEzNTEgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wKyBPUiBNSVQpDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAy
MDIyIE5YUA0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9j
ay9pbXg5My1jbG9jay5oPiAjaW5jbHVkZQ0KPiA+ICs8ZHQtYmluZGluZ3MvZG1hL2ZzbC1lZG1h
Lmg+ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4gPiArI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL2lucHV0L2lucHV0Lmg+ICNpbmNsdWRlDQo+ID4gKzxkdC1iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9w
b3dlci9mc2wsaW14OTMtcG93ZXIuaD4NCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3RoZXJt
YWwvdGhlcm1hbC5oPg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgImlteDkzLXBpbmZ1bmMuaCINCj4g
PiArDQo+ID4gKy8gew0KPiA+ICsgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ID4g
KyAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgI3NpemUtY2VsbHMgPSA8Mj47
DQo+ID4gKw0KPiA+ICsgICAgIGFsaWFzZXMgew0KPiA+ICsgICAgICAgICAgICAgZ3BpbzAgPSAm
Z3BpbzE7DQo+ID4gKyAgICAgICAgICAgICBncGlvMSA9ICZncGlvMjsNCj4gPiArICAgICAgICAg
ICAgIGdwaW8yID0gJmdwaW8zOw0KPiA+ICsgICAgICAgICAgICAgZ3BpbzMgPSAmZ3BpbzQ7DQo+
ID4gKyAgICAgICAgICAgICBpMmMwID0gJmxwaTJjMTsNCj4gPiArICAgICAgICAgICAgIGkyYzEg
PSAmbHBpMmMyOw0KPiA+ICsgICAgICAgICAgICAgaTJjMiA9ICZscGkyYzM7DQo+ID4gKyAgICAg
ICAgICAgICBpMmMzID0gJmxwaTJjNDsNCj4gPiArICAgICAgICAgICAgIGkyYzQgPSAmbHBpMmM1
Ow0KPiA+ICsgICAgICAgICAgICAgaTJjNSA9ICZscGkyYzY7DQo+ID4gKyAgICAgICAgICAgICBp
MmM2ID0gJmxwaTJjNzsNCj4gPiArICAgICAgICAgICAgIGkyYzcgPSAmbHBpMmM4Ow0KPiANCj4g
Tm90IGNvbW1vbiBhbGlhc2VzLiBEcm9wLg0KV2lsbCBkcm9wIHRoZXNlIGFuZCBhZGQgcGFydCB0
byBib2FyZCBkdHMgZm9yIHRoZSBjb252ZW5pZW5jZSBvZiBjdXN0b21lcnMuIA0KPiANCj4gDQo+
ID4gKyAgICAgICAgICAgICBtbWMwID0gJnVzZGhjMTsNCj4gPiArICAgICAgICAgICAgIG1tYzEg
PSAmdXNkaGMyOw0KPiA+ICsgICAgICAgICAgICAgbW1jMiA9ICZ1c2RoYzM7DQo+IA0KPiBOb3Qg
Y29tbW9uIGFsaWFzZXMuIERyb3AuDQpXaWxsIGRyb3AgdGhlc2UgYW5kIGFkZCBwYXJ0IHRvIGJv
YXJkIGR0cyBmb3IgdGhlIGNvbnZlbmllbmNlIG9mIGN1c3RvbWVycy4NCj4gDQo+IA0KPiA+ICsg
ICAgICAgICAgICAgc2VyaWFsMCA9ICZscHVhcnQxOw0KPiA+ICsgICAgICAgICAgICAgc2VyaWFs
MSA9ICZscHVhcnQyOw0KPiA+ICsgICAgICAgICAgICAgc2VyaWFsMiA9ICZscHVhcnQzOw0KPiA+
ICsgICAgICAgICAgICAgc2VyaWFsMyA9ICZscHVhcnQ0Ow0KPiA+ICsgICAgICAgICAgICAgc2Vy
aWFsNCA9ICZscHVhcnQ1Ow0KPiA+ICsgICAgICAgICAgICAgc2VyaWFsNSA9ICZscHVhcnQ2Ow0K
PiA+ICsgICAgICAgICAgICAgc2VyaWFsNiA9ICZscHVhcnQ3Ow0KPiA+ICsgICAgICAgICAgICAg
c2VyaWFsNyA9ICZscHVhcnQ4Ow0KPiANCj4gTm90IGNvbW1vbiBhbGlhc2VzLiBEcm9wLg0KV2ls
bCBkcm9wIHRoZXNlIGFuZCBhZGQgcGFydCB0byBib2FyZCBkdHMgZm9yIHRoZSBjb252ZW5pZW5j
ZSBvZiBjdXN0b21lcnMuDQo+IA0KPiA+ICsgICAgICAgICAgICAgc3BpMCA9ICZscHNwaTE7DQo+
ID4gKyAgICAgICAgICAgICBzcGkxID0gJmxwc3BpMjsNCj4gPiArICAgICAgICAgICAgIHNwaTIg
PSAmbHBzcGkzOw0KPiA+ICsgICAgICAgICAgICAgc3BpMyA9ICZscHNwaTQ7DQo+ID4gKyAgICAg
ICAgICAgICBzcGk0ID0gJmxwc3BpNTsNCj4gPiArICAgICAgICAgICAgIHNwaTUgPSAmbHBzcGk2
Ow0KPiA+ICsgICAgICAgICAgICAgc3BpNiA9ICZscHNwaTc7DQo+ID4gKyAgICAgICAgICAgICBz
cGk3ID0gJmxwc3BpODsNCj4gDQo+IE5vdCBjb21tb24gYWxpYXNlcy4gRHJvcC4NCldpbGwgZHJv
cCB0aGVzZS4gDQpCUg0KSm95IFpvdQ0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQo=

