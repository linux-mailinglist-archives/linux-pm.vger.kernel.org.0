Return-Path: <linux-pm+bounces-41287-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDH2Fez7cWmvZwAAu9opvQ
	(envelope-from <linux-pm+bounces-41287-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 11:29:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9226542F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9907000B6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179E3337BB4;
	Thu, 22 Jan 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W+CNA1MF"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61E2BD00C;
	Thu, 22 Jan 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077060; cv=fail; b=LKbHrATP/sDOtpiv3PY2daqp3/TAu7CFZEazXOaPCfA9nG/hGzt2kt7aKdjhCv5WWZ5hWE+LgQePDyVxxPBhPdoXFF6j+GNWE9ntXPSME3g3aNk8nyGRQe0Rbj1QNBpKRZv10kzlhPAgr8xQnde8pMzdVfe+8v08DS4KVckchQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077060; c=relaxed/simple;
	bh=fEU5TZ0f/jRgDXHSou77F6KV9ZYyl/yeRScmjgTpXjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LUyhzHv6i3aoddnNXpNM6zRGW7dAejaTfp9BWZSyAZLmALX/HR5bMZYgqnXS1VecGuGpBBWbQUUasFjyUQbDt5tP9Kv9KbCyTDFPukLs4X+mdRif+xCvGlTvaGoOL2PiglvzMSfDi0d1G//2Ii13fa2mdBk6yPuusqzC6VL+CfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W+CNA1MF; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k25ivoopPtumJurLjLXpz3iIwcfn4JqxfXqEFRBzOgIiP532EIZNzdFqkessQHQBdxwt6BwkZt26Cql4pjtN19RxlsJbFuVDm0xHEegqneF/LqrikpL1c25SeEuSBQf+7eLxZvx7mABKqcss1xuFdXxfL4ykEzRNmofX396WhQXuAUa9iQ6n/sGdQ5LQDyfNF7qlFiMkdYfE9iEF0hA08nKCUECg6QaJYw7fK1aF6D1t9hTGBK0jIPgGqxE4onQSPJuPBXLdW8PgFSMCZPohre/GIqY3cGz/BAfxdceaFvGzcZ8z4q13/f6v/xPeLxKAA7DJfy5tgYiktQGPrkHWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEU5TZ0f/jRgDXHSou77F6KV9ZYyl/yeRScmjgTpXjk=;
 b=xRX2xZf1N2yC/t2si5wjjglbfk6yPNFPMTidAJGjUev7c0KNZBNslP9D6ppNOMjjbDu/0tUG/cGTd1WewP4e55pTshccg7UNPDN/ZbkRGyKU1ffy3WnqavDwmjVnqVqtU7LcXInycPUJJ22DNJ6dOj2G/RTyj6EgAO2mA3ikyB8zGOtcSBXsxolrKnI4dduBwSw1+0TGq8hKhYFhCtzZ3zRUfQ7OofLVC6SeC/J5FqBlZWzgHl4IaBfOxJeANgeD/46de0LMRDhIZJYh5ZLXNcoTsdxBPktQ34xZyTsKl3odlGIzhmqVZ5ZdVD6sDHeMVsxwcTGh3yAe+hPoe9MJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEU5TZ0f/jRgDXHSou77F6KV9ZYyl/yeRScmjgTpXjk=;
 b=W+CNA1MFxWSLCmzH+PC5sWjfbZApcD0JRjRD3/wqioTZnUxfLMLQQ+ww/GD3ditwLvwDHUiRPiOf9Vp+C6abymhoSo2aIKMe9IHGo2958ZZYNtGZEipPlmwCvyWOcaQJd0ZtptDqbVL9hb6o/6iXaZQeeflcOlo/ey3X/rB3C0s0ColSuZ58MAWCi0lqqet8rHK/V0v57tY0AmhSCGa2mXJHlZeq2n5RkraWnG0o5kgfAX2SEkx1b3WCgbJMLeMKnM59xPkRTPxIq2MGb+tEcbislWaI52h9lxzvaVn2Ucd3B0WhWTNXU+L43MZIx8f7MSyUbRAKDulDGTOFWltPgA==
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by AM9PR04MB7508.eurprd04.prod.outlook.com (2603:10a6:20b:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 10:17:33 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d%7]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:17:33 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
Thread-Topic: [PATCH v2] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
Thread-Index: AQHcidxUaQTTT1diqkiqMUDQtcBT7bVd50sAgAABKRA=
Date: Thu, 22 Jan 2026 10:17:33 +0000
Message-ID:
 <VE1PR04MB721300DE72A9181F0A8A470E8797A@VE1PR04MB7213.eurprd04.prod.outlook.com>
References: <20260120-imx8mm_gpu_power_domain-v2-1-be10fd018108@nxp.com>
 <CAEnQRZDo3Y+m3+Pdq3QTaPi0M71NGAc40NxCw0c-GUuAQ5ZRhQ@mail.gmail.com>
In-Reply-To:
 <CAEnQRZDo3Y+m3+Pdq3QTaPi0M71NGAc40NxCw0c-GUuAQ5ZRhQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR04MB7213:EE_|AM9PR04MB7508:EE_
x-ms-office365-filtering-correlation-id: c54d39cc-3016-4501-3613-08de599f751c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3F3RFFzczJBdnpJR3J0dHRLSzYwdk5EQjNVd25QcFZqNHZQS0FWT1Z4cEZI?=
 =?utf-8?B?OEJHdTVjZ0NmWWJBVm5tQncyWE5XeXUxNUIvVDdLM3VaUmU5SkhkQXYyaWh0?=
 =?utf-8?B?aFFOZHF2YWxReFcyUVZULysyQ0xLU01Ici92YzBSUks3eCtuSGJ0WGNLUUtQ?=
 =?utf-8?B?UC85aWxEcDVsNzlvVFNZa2Z3OFFrUkhjTUdobjFWeGxvRWFZcUVWWGFtN2hV?=
 =?utf-8?B?Y00yZ29CUWhqV3B5anlVTkZwRk0zclVaR2txRE9PTnpXSnQ2ZFlMUTFqODlT?=
 =?utf-8?B?MjlMZHM2SHI0V0tiRTBHdlNoOFhURUJyb1dpbnh0TmxGNmo1WlVvYkxvRUFD?=
 =?utf-8?B?ODN5VGJ0SUJkek01RktNWDhlQ0F6TTFCWHF1aVRXbGhuWUtwdjVuZjNCZnZT?=
 =?utf-8?B?eXlaVGVFWGtzUSswaGR4aXFPeFMwbGxkOWZieTcwb2lyS0JWTkxSTFdLbjRy?=
 =?utf-8?B?blNoeko1QWRSdWhWdWhqRzNKR3JoYnA0Q2tHRzdxRVZtRWZVTUpTU2p0QTY3?=
 =?utf-8?B?SEpyYVVuNTc1SG9iS1BvcWpJR1kxTkFraDFqTHdkbW1vM2g1bDZSUTJRQkg1?=
 =?utf-8?B?RW8xZldma3J3KzJVbWJvOFgyV29yVGZjV0puR3l2WDQ1aEsyUms5YXpLT1lD?=
 =?utf-8?B?ZTZsWWNqbi9FNkk3RGlTc3g0SFZoR0pPL2ZiMG5PQjJubGtBNHZNb0pBcU9L?=
 =?utf-8?B?aTg2eHdsQnJkandXZ2M2TTVBcS9ORHZyVzBlV0tPckVmaDZoNDdOWkxWNlN6?=
 =?utf-8?B?Ykc2MkdOSSthbHVuWkxRbnJBa3JiNG84Nk5DL2lqeUZjWTVRUGRrcGcydTBQ?=
 =?utf-8?B?bVJqOUNGc0dhRFR0WTZObkdNRmN2d1F4enU1MTM0dnRSTGY1eVowa05WTE9F?=
 =?utf-8?B?RGRpZTRJY1NWWDliZ3FMNmdTR2ZOeHNDUTJhaTh5S0dmc20vMkI2aHpid1RO?=
 =?utf-8?B?Mkl3Y3NKLzJXOC9PU2RrR3dlc2Z4RkV2YXh4RlBQZU55bXpock95U2JvdWxu?=
 =?utf-8?B?eVdma1g1enZ3UmhTRWhsOER4d1dIMkVlbURZSitRRm1HYkVvVnRTUEtFT0xY?=
 =?utf-8?B?SWxNY0ZWd1d0NmRwMFg3ZVVodFpjVXJXejloYnYrckRrNVlHWm1XaHQxMWxR?=
 =?utf-8?B?UlBQYkpsYzRhUEY3WXRpcnJSd094QjVYZVkyaWNGUXBQUHN1YnFlYytWWHJ2?=
 =?utf-8?B?Ty9pbXJadTZIL1dodGhBdmRMQlBUaTIrZlJBTjV5dTIxdGNyU2l6Y2tkTWtR?=
 =?utf-8?B?OHZuQkhEUWM0TEFQOW9vT052ZXA2RE51d29BdkFHdnJBOC9sNFFJMFBTN3hP?=
 =?utf-8?B?UjBKNjNrZEZUN1hnNGhIeG9lK1g1eWQwR0NicXYrcGp3dzdCTnVrRlN5WFEv?=
 =?utf-8?B?VjhEVDczZ0ExalptZWs4YVlEUVdLOEVGR1IzWldFSytZczJYbUx3Z0tKS24v?=
 =?utf-8?B?eXFXd1lYUk5YUnBwUFNkSFJBVW52SWh6bW00dm1hOHNlYTk5OFAvdm1TVGsy?=
 =?utf-8?B?TXpNUUFIZjh2YjJWY3RqUDNrQ29FYVgzbkVMOHM3ZzJDVFVPZmxJYTBwSFJO?=
 =?utf-8?B?Mzc5OVd6bXlvQk1KWnJWVkIrRnFkMUowbm1UbjFwejhkSExoRzFoTUxXL1Bt?=
 =?utf-8?B?cS9vVTI2REdNVFpJbDMzaFV3VENob3ZWMk5Ob3I2dGJzQldCbWNXanF4Z2xv?=
 =?utf-8?B?RW1sZ3J1SUNLTTVoN1pXMDFVd3Rka0JnK2VhR25JaGNPZHBMZnBDMWRyRjNv?=
 =?utf-8?B?UTNJVEZmU2k5OUJUaE9OYUV2WFltRG9CS3QxTFp3anlLZWpWZHljNUhraStm?=
 =?utf-8?B?NWtYQUp0UVJrTmxTNzVIUUcwRW9uVk5jVHJ0RitTbnJ0c2FPVFJqWFoxSkZH?=
 =?utf-8?B?ckZNdjlqWThlZjdnWWNLUDJlajllZDNkNThkdldIdXJleDJMMWtlNlMyakZ4?=
 =?utf-8?B?ckhQekVrR3ZEN2NyWHhzdDBCZHBhQ2k2YnYrZVpRd2hDTVBXemhVVzZwNk93?=
 =?utf-8?B?c2l4R0VmVmNRQ3lZWDZtSzBKS1V0b3YvNGwzOTU4MVBqZzc3N2V1RWZpWE1Z?=
 =?utf-8?B?Sng5Q0dDRUI0UWlEL3AzcUhjYzl4Nm5Pb25vbjVwcXcrZldDMHpJOCtGckls?=
 =?utf-8?B?OWFxR2I0Z3krODB3My9PMWVEZXFpUWlpWnJPem9Eanp0bVlucXcwNkVEQUxa?=
 =?utf-8?Q?Q82f+86fyWvX6iE5aIy9U8w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWZWaUluU3B6RkZRZ1lsSkptVFFMQlNyWWpUQVFwZHEyekl1TjBlZ0RtU2pW?=
 =?utf-8?B?RDBUL2U2ZVdPNTNMYVZ4S0R1VTJHcDNnS291NllrL3d6OW1WVWRVUGE3WGJx?=
 =?utf-8?B?MWFKSGo2d2tXbWU4bWQwK05BbVNEZG9JWkJJSGFnemZLOUhTT29iK2RMZUdW?=
 =?utf-8?B?KzJIeWp4RDI0ZmlQWFVqZkFsVU02VVZJN0M0SUNVZm5zOGE4MFJHNEhTaWxU?=
 =?utf-8?B?d05sNENhZXlRaTJWTzk2SkY2YVg3LzVKK2Uxei9COVZXSm5veE1lYUZlMnJM?=
 =?utf-8?B?Rm1UQzVWR3E2akU3ektVeitMVU1CS1Y4SE9ncFdmOGZEbXplZ0c0M2VSZUpz?=
 =?utf-8?B?K1hBNnpxV3VOd2FYYXZkV1F5QlpBZHhoMitvVWZMK0RsclQ5b1N4NlJHZk42?=
 =?utf-8?B?VXdSY0k4di9QOGFRblJjUk1WQ1dWby9KS2doVHpra2R5NmcrQWpPL2Z5SlNr?=
 =?utf-8?B?Q0V1cmNwQ0UwYWQzUUR0WEowSFI3VEluN2QrdXlBVmg1TVZ2NzdKQzA1OUUy?=
 =?utf-8?B?Vkt4TUJQSUIzZUtMZUs5eGVCb2hiYS9HYXBoc3BCTURmTnVxcStkWlZOSW9w?=
 =?utf-8?B?ZzZsVi9oeVBFRHNLZTJrTnYzUE5SWUFLeTZTTXRHMFdUTGxFdFNFS0I1SFdO?=
 =?utf-8?B?WHFRdzcremRkRVF5K2xqVVB2ZU9veGk2QmREcjVJT25rdVBrSlNKV1NwVmJ2?=
 =?utf-8?B?OTVVdFF3OFFwOUJjNDUyMVZCT1RiVGNQWmx1elgzZ3RCM3VkYVN1alprMTMv?=
 =?utf-8?B?MDVKWVI4cDhLMlUxZldhT0VEcmsrY2g5THFraFh0bzJ5ZVU5YVlCZDdxMDQv?=
 =?utf-8?B?RGVNM2d4K1FXUkZ6aTRUbzNZSit2L3ZLeXVQZDA5Qk5VWFJXV1RtbGlmaUtt?=
 =?utf-8?B?N1BCbTFpeVdHYzhZcm80bnBkQU1Qbkk0ODJGMHNlT3dEUS8wYkhqa1R0U1Vj?=
 =?utf-8?B?NGlnNFhjd0hqaWZCV1hYTUo4ZlJjcDFTMFhzQ2FOMUpjQXJtcHVwRlZjOFNy?=
 =?utf-8?B?UmlHejNpcmQ2RUNxZDBBeFlLcG1sZldVWTBCbEhUSHRjcnBwSU1rZGtsUnJF?=
 =?utf-8?B?S1RNV3RnUHF4alM3RWo2TmN5SnZ5ZVBFQkRZRHRvQmF4MmlLdGl5L2dKQzdq?=
 =?utf-8?B?dlErY1Z0eXExek8vMnI3VnhvSXRuNVVWa2d1b0RwdGkyc1ZRcG5IaUVYWUxu?=
 =?utf-8?B?QWxiU0RPK0pqU2ZpSnJXK3lwYXlMWHFPNzgzWFpYa01haGVTa1BoT01ZZnd5?=
 =?utf-8?B?MEFqNVBYQ2ZVVFdEUVRWY2p6KzBmMkNRTHNoU0RyVVlnRzR1MmxXQm1GR1Fh?=
 =?utf-8?B?MWk2MXZhY2dEMlRsZVBaV0gyWXpwZjRjZUJXVzdmQm5zWWFFL2Rvb2JCNE9a?=
 =?utf-8?B?Sm90VnM1QSs1VHZxNmR4S3lQWDBjUzI1bmJtNENnQlJYU1lvQ2JRUFhMK3Yy?=
 =?utf-8?B?MFQ3RXVSK0JxVkY4aUpHdVdEK1JqNmJvWkROZmpxTFRVbHFUSk9iQm16Rmsx?=
 =?utf-8?B?Y1ZqRGNCZFlwSndZNzAvc2tjSFF4Tm93ZE5QOEZ2UVFWL0I2bXN2Qnk5dGJa?=
 =?utf-8?B?VG1QUGNFeHh3MnZhYXpPQTVlR0RaeW0yMHI5TnpIemVEU2Zudk5JVjZobkt3?=
 =?utf-8?B?QS84UVJDRUJ4aWJ4S1NEb1FCeUZETWZvZW81WnRTQ0NkNkc5NElKVkZnMGVO?=
 =?utf-8?B?T0FVMWFLNzhEdVBFa0RHWDBnWDJSM0s5TFFiM2JaaDQ4dEV6cHJCbVRaMnQ3?=
 =?utf-8?B?bERMczFKaDFmVFVtZ1pJTk9aeEhWN1gySzl5a0RaSEJaRnBOSU9ia29TdDB2?=
 =?utf-8?B?ZGFqb1hqZ0RBTjk0LzVsVDZMTWJWMTlaT2VLNmRkTHZqMnRIZnFlQjhZY2NY?=
 =?utf-8?B?QzlBQUdNOVhOelorMCttTXM2d2Y0aUx6TW4xYllEZlJlK0w4bU02NStnZFp0?=
 =?utf-8?B?cWRuS1RCRHQ4L2twOTN0czhGVTlRM0k5c285WEw2cW56dE91ZGVkWmxnR3JT?=
 =?utf-8?B?azJWRGp1UnBMQlRPalJ1b0xtekdNTDFjS0VTTHlWMTZnOVpZUU5uRjJJYXN3?=
 =?utf-8?B?VUxGRFluaVFvNU8vNi8zWTBtd0FJSDZnUzBmS1RyQkViUDVYdUNFdDBpR0dZ?=
 =?utf-8?B?eHZZNVRocUZIMVhKUU5XRGlXbXh6TEszcjE1YXVIUmhBS2JXejZSVytpODBM?=
 =?utf-8?B?ZlVaTVJ3aHNqcFl5anFQUHVQcFBJLzBiWWNycG5paVVXUkVjVTNmM01xQWMv?=
 =?utf-8?B?aGdXNkNHV2dsSGZBdC9BNzhCYVU4aGs2eTFSdVFFS2ZPVU9udU1qbmdkeVZX?=
 =?utf-8?Q?c9tDFPk9LHeSRUDRw4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54d39cc-3016-4501-3613-08de599f751c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 10:17:33.2206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYiTB+5sJHeKAMFOEAu97FPrdPGuH0JIHMzFctNzcsAW+7/Vjni1xtv+Jib6kOthwAqW5Mqn7KzDMqTjM275Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7508
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41287-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[ping.bai@nxp.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,pengutronix.de:email,VE1PR04MB7213.eurprd04.prod.outlook.com:mid,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: DB9226542F
X-Rspamd-Action: no action

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBwbWRvbWFpbjogaW14OiBncGN2MjogRml4IHRoZSBp
bXg4bW0gZ3B1IGhhbmcgZHVlDQo+IHRvIHdyb25nIGFkYjQwMCByZXNldA0KPiANCj4gT24gVGh1
LCBKYW4gMjIsIDIwMjYgYXQgNzo1NOKAr0FNIEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBpLk1YOE1NLCB0aGUgR1BVTUlYLCBHUFUyRCwgYW5kIEdQVTNE
IGJsb2NrcyBzaGFyZSBhIGNvbW1vbg0KPiByZXNldA0KPiA+IGRvbWFpbi4gRHVlIHRvIHRoaXMg
aGFyZHdhcmUgbGltaXRhdGlvbiwgcG93ZXJpbmcgb2ZmL29uIEdQVTJEIG9yDQo+ID4gR1BVM0Qg
YWxzbyB0cmlnZ2VycyBhIHJlc2V0IG9mIHRoZSBHUFVNSVggZG9tYWluLCBpbmNsdWRpbmcgaXRz
IEFEQjQwMA0KPiBwb3J0Lg0KPiA+IEhvd2V2ZXIsIFRoZSBBREI0MDAgaW50ZXJmYWNlIG11c3Qg
YWx3YXlzIGJlIHBsYWNlZCBpbnRvIHBvd2Vy4oCRZG93bg0KPiA+IGJlZm9yZSBiZWluZyByZXNl
dC4NCj4gPg0KPiA+IEN1cnJlbnRseSB0aGUgR1BVTUlYIGFuZCBHUFUyRC8zRCBwb3dlciBkb21h
aW5zIHJlbHkgb24gcnVudGltZSBQTQ0KPiB0bw0KPiA+IGhhbmRsZSBkZXBlbmRlbmN5IG9yZGVy
aW5nLiBJbiBzb21lIGNvcm5lciBjYXNlcywgdGhlIEdQVU1JWCBwb3dlcuKAkW9mZg0KPiA+IHNl
cXVlbmNlIGlzIHNraXBwZWQsIGxlYXZpbmcgdGhlIEFEQjQwMCBwb3J0IGFjdGl2ZSB3aGVuIEdQ
VTJELzNEDQo+IHJlc2V0cy4NCj4gPiBUaGlzIGNhdXNlcyB0aGUgR1BVTUlYIEFEQjQwMCBwb3J0
IHRvIGJlIHJlc2V0IHdoaWxlIHN0aWxsIGFjdGl2ZSwNCj4gPiBsZWFkaW5nIHRvIHVucHJlZGlj
dGFibGUgYnVzIGJlaGF2aW9yIGFuZCBHUFUgaGFuZ3MuDQo+ID4NCj4gPiBUbyBhdm9pZCB0aGlz
LCByZWZpbmUgdGhlIHBvd2Vy4oCRZG9tYWluIGNvbnRyb2wgbG9naWMgc28gdGhhdCB0aGUNCj4g
PiBHUFVNSVgNCj4gPiBBREI0MDAgcG9ydCBpcyBleHBsaWNpdGx5IHBvd2VyZWQgZG93biBhbmQg
cG93ZXJlZCB1cCBhcyBwYXJ0IG9mIHRoZQ0KPiA+IEdQVSBwb3dlcuKAkWRvbWFpbiBvbi9vZmYg
c2VxdWVuY2UuIFRoaXMgZW5zdXJlcyBwcm9wZXIgb3JkZXJpbmcgYW5kDQo+ID4gcHJldmVudHMg
aW5jb3JyZWN0IEFEQjQwMCByZXNldHMuDQo+ID4NCj4gPiBTdWdnZXN0ZWQgYnk6IEx1Y2FzIFN0
YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiANCj4gQ29ycmVjdCB0YWcgaGVyZSBpczoN
Cj4gDQo+IFN1Z2dlc3RlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+
DQo+IA0KPiBBbHNvLCBubyBuZWVkIGZvciBhIG5ldyBsaW5lIGJldHdlZW4gdGFncy4NCg0KRG9u
4oCZdCBrbm93IHdoeSBpdCBjaGFuZ2VkIGFmdGVyIHNlbnQgb3V0LiBMZXQgbWUgY2hlY2sgYW5k
IHJlc2VuZCBpdC4NCg0KQlINCkphY2t5IEJhaQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFj
a3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPg0K

