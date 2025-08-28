Return-Path: <linux-pm+bounces-33208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3CB39140
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 03:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52147980DE2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 01:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D4C2356C7;
	Thu, 28 Aug 2025 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nL7jyd+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1F227BA4;
	Thu, 28 Aug 2025 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756345906; cv=fail; b=g5CFt1/N3xSHRRW+TUMK0zDcVRBTGVuTNY/2X2NcVkwMNylPRsojf2hMwoLnxfNh2o/nTtMlK+qYTFxRIJ3XT73hB9B8+ZuBMeGvfReJILrN7zPjmtOeStKyasQKrHxYk/ekHE11zTsUZqYcXbJRYuUe9ZCPS2dXuiQQqSbomhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756345906; c=relaxed/simple;
	bh=ceImnxNBaEVMfxIDnBiB32mBbCP8g+7MT1sQC/p/JWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IFoMCLsNsX8NOgCuQNCa7yD4bFd3LQOlDvUto+qoCMujsBUqvj9MhZjvYA2Gjv9lRWt6A8rD6T3z0f1LEcNiMxaEVczZtpWtGr9Pu4eegtaTPdI63mkdLgZlwycODtiA69dzYQyMGSYV/R9joYTz/PgnB75/+fd0OmaEFxp7erM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nL7jyd+K; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1ylgc5v8be4QrPYpDJhPqg+HRm3e/X7xHI3PkOWe6BBt7Czw7249cVkWbyWMfjrRzDoB5uqNIv3zZ50faBsuanpVA4qmzmxdCuuKtTPvkGrAmu+7NChKQaTxHK2XAx9jZXnVDg5IgTMSPwRzI31esTCaRQ/fHA4feGrwQfRbwYU8NPbL3YOP5Fy9ZW1FpqC9WmddGxX03n3uvS2r5dLkvkOAvMK7AMYU0TZETDUUu4qz1CbWna/CTROAjZNv6L4BcaB0Plr31euJ9LV9wOdpunH4AD/U+uikME4rCgd8Df4/S5PXQN/F7q/l4UX2Og1SdNLDQXP6o643xIZFi/wuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceImnxNBaEVMfxIDnBiB32mBbCP8g+7MT1sQC/p/JWc=;
 b=J4O/FKH9orvpD8rm8UM3Br8q4DAATIXXC9jCvEqOhPAaZxVFnwoCMQLyO3QYy8qMCE5tSnuiZnLwATb7Q9BUk9ONx2HzHh+cPmx0tYMWPLsBHxPBThbUeckIrjBmyxwBkfnOCsCy+jzggRCC/ravxY3T6Xhae6L2FJ02hxWWkF9NUMnyclEwY5YM75ltymZcVuWAfqAJC4DL8eT6SS4449QzOqrBkN6+1pb2UnEQVkyHv/jbzNEAG5rPPpaZkME/jHk2YIBYJFQfMnNbgmfjNoKMViFH+aKaDVg8AUMSI9C6BBtBEyLPf7evcl+HxDFpdQ+YW9+XdEspVy5uDNyBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceImnxNBaEVMfxIDnBiB32mBbCP8g+7MT1sQC/p/JWc=;
 b=nL7jyd+KH5tb8/UnCmTxphWRy/bFKtQYVQldMPc3gYI+nDpZX0N+myR+T4pGtzi7GwAdlvzDeVtnzAjeszakFRqbU84nSQlpHOoHahg1xqYq1QxLW2Sf9U44ILNSAkGxopRry5U4+PNfKSpDPlTxE81hzrSt/fhbitspDWEUs6t52rDyfuzqOmUJrFPg33/bNHkbS3OW504kLZX1fUn7Lx3AQGsLiJMa3Chij5t0M91DVN1+MSPhMUqiyYX9gxt9Aq5JKqlouB9O9y7hbcsTQgvPecBCF/r2MEOiBBKml0Z2CGy/eYlP+ZMb+3Nkf8vxFbDQGROJZAFxvltYi+1tMg==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM7PR04MB6838.eurprd04.prod.outlook.com (2603:10a6:20b:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Thu, 28 Aug
 2025 01:51:40 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 01:51:40 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
	"primoz.fiser@norik.com" <primoz.fiser@norik.com>, "othacehe@gnu.org"
	<othacehe@gnu.org>, "Markus.Niebel@ew.tq-group.com"
	<Markus.Niebel@ew.tq-group.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, Frank Li <frank.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH v9 2/6] arm64: dts: freescale: rename imx93.dtsi
 to imx91_93_common.dtsi and modify them
Thread-Topic: [EXT] Re: [PATCH v9 2/6] arm64: dts: freescale: rename
 imx93.dtsi to imx91_93_common.dtsi and modify them
Thread-Index: AQHcFaCFY0W65SVmdkugTloFC6FzyrR2LwOAgAEf+TA=
Date: Thu, 28 Aug 2025 01:51:40 +0000
Message-ID:
 <AS4PR04MB9386E069DA4BA0877C951F53E13BA@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20250825091223.1378137-1-joy.zou@nxp.com>
 <20250825091223.1378137-3-joy.zou@nxp.com> <2326064.iZASKD2KPV@steina-w>
In-Reply-To: <2326064.iZASKD2KPV@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AM7PR04MB6838:EE_
x-ms-office365-filtering-correlation-id: d47215d1-1ec4-45d1-6a27-08dde5d56ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmFIQitlcEQ2WGdSaE4xQk9ENzd6VjIrVnRxTUxtalF0amZ0VHgrOGh0SVVs?=
 =?utf-8?B?UGNveVUyNk4ySHV0a2FRME5nak5lODl1ZnNRU2h4TlhsL2JtMFp0cEpMOGhz?=
 =?utf-8?B?TzFUTmJpaEh6Mi8wdHkzalZUVVBlWXI2NDJBRHhwSSsvWHh0anBvNCtTMHdJ?=
 =?utf-8?B?TUx5dzJuVjBQNkZWN1ZrRWE3cjAwQjU0Vnh4T29vamp3WkFic2xybWwzTThj?=
 =?utf-8?B?cUU4TlNONzhNaUhoNVQxS3c1N1ZHUHhmSzNicEhyb0E0V1I5SnhsQmZ1bUdU?=
 =?utf-8?B?QnNBeGJKUlFMWU9NUkwraXUxbUJibXRacDcrUytEK280VzZvZ0lxTFFZcUR5?=
 =?utf-8?B?WCs0RzJ6K0k4cDNzZGFlcDQ2RCtWbmhkc0IvWDNVSHl6UmJqaVVsaU1lRE1a?=
 =?utf-8?B?ZTlPZTlwR3JpTG0vcjhoUWRidThPRGR4T2ZJQ3hpVTVFZHUxWWVuM2NVdXV1?=
 =?utf-8?B?Zit6NlFqRUxndFdOYzVhSXRsZmV2QjliaHdaUnJjRzB1TEh5SEJKY3pBY3pa?=
 =?utf-8?B?Ymo3YXVGMWlHYjkvTkJyV3ZEV1hQQzUxR3RFYi9Wb25VVGlwSkZKdFZSYW0w?=
 =?utf-8?B?dHF0ek1KTmNjMlNYa1FrYmhqM3ZKN21DTHpTSFRtd3R5M0x4cWM3aUtYUVVn?=
 =?utf-8?B?a1FjdFFXWFRhRVVQaU5uUmRmdytRQVZlUDFkODZ3NktiRVU1ektjaWtSanVr?=
 =?utf-8?B?d0p1VHRrRmZWWGpvNXNzVkxSWlUrdCtUMEVIMTcrTUQ4VlI3QmZLeHptVGhl?=
 =?utf-8?B?eXlvZ3hURkdBSjlsMms4Tjc1RnB4TnA1bFYxaWlZT1FBNTE2bkg3N1p3Y0ph?=
 =?utf-8?B?SEtWME9Sb1pOUHRXZ0V5T2xHYWMyR0RWak05ZDhvV0ZGVmh0ZGlkMVYxU29x?=
 =?utf-8?B?a0FjTk5wV0doWDRHdHphZE9KVUxFNlc3NjVnd2pHVS9QQlF2UVZ6am5rRXB6?=
 =?utf-8?B?Y0lybHhkelBJRlRyL05USnhZYk1HRUZTNFFlWlBlOHM0cUh6TDgwTmtteC9Z?=
 =?utf-8?B?d2NVOWJoQmFZSmsxQU9SV3Q1QlV4MURiRE01aHNiTlA2a3hIQkc5MS9aWXpW?=
 =?utf-8?B?M2pDQzI1dkVZUGFRV3hVUlpXSVNYWHJjZ3oxZW11NTV1ODNhK29GRVdXMzY1?=
 =?utf-8?B?TjBXT3E0SitEL1dXVUM3cys0VnNpTnJDbXpCOXpwTlFseURNUjU2WnhNUTZm?=
 =?utf-8?B?NkY0SkVmSGFIUTg0bys0a2FNbjhUdXJYN2lIOVpGdU1QRGUvVG1UMlJ5Zksw?=
 =?utf-8?B?cnU1VmM5aWU3K2pzNjV0WE0wTlpYa3d2a1BGZHVDMEhRcjdNQ2RqMDZ1NDZW?=
 =?utf-8?B?ekFsMlBZK0VmWTJTeEpEdEJLY2IvMUJYRUVaMkVTd2NqS3RZaU9sZkI3cXhT?=
 =?utf-8?B?cVQ2RE4yaW40b2F0TTVqMEhkeWtxVndGYzFvcS9RWGRwVy8vVFZDMG1iTWV4?=
 =?utf-8?B?L01va3U2ZXR6aVRqc1FvTERPczFtTkRkdVhKaGdtZlV1emJJMzViNXJUYWov?=
 =?utf-8?B?Ym92R0ZiVEJFMTZZQXpNaGtyU0ZmTzVwUGJFU3RaOUFqc3VjelhxRGM2SzJW?=
 =?utf-8?B?c0p0M0VUdG9zL2lHSEY5ak9wd1J4bjlvYXRUUUl1amtmWHN1VFR1eDYrYity?=
 =?utf-8?B?cXBEUGcxSE1QM3hJa0oyd0haSGxxdFp4R3hkMmsyZjNIeThIM1c4cVRrU25M?=
 =?utf-8?B?S3FOYTNmQ1Buc2tyTytmNDRXalVDZHpGTjM4ZkZ4YUpKQVBVbEVVN1hNQ0sr?=
 =?utf-8?B?VWkrbHM1OElSNXFQRjZUM0hmWFYrTWdXMWZMdHk0Qk9qcHR0S2hKRFhSSDJR?=
 =?utf-8?B?ZWx1bFRWNWVDUjVOSWRCcUFnUzJ3RlkrQjJYK0orQzRrRXBvdklGQ1dLRE0y?=
 =?utf-8?B?ZVVYUUlySndpQzcwMFBPbE1ZcS8vWU1TRXRtUVhyNitBMFJBcTV3a3pPdzdu?=
 =?utf-8?B?RnlOTTFTaGlKekQrRVgwZGx5bE0rN0picXBmbTcxdk5jWmptRHdjS1psd1hE?=
 =?utf-8?Q?3qpl7mJbfFJYJg2VBzC6Zz4ASwYH8c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1lRb2xKYk9zdDhZcy90cEdzVU1wOVBSTU5DMkh5ZksrZGRpS2lSbnQ5OGdG?=
 =?utf-8?B?YitjOW5KK2RPTmx5S2pSeGFBK3NOYmhEek45NVZlQ2RveW5GNjh6Mmh1QTFr?=
 =?utf-8?B?ekxUN053UGlta3AydGh0OVlwRmxYZ1BZdUJRblJBY3NYbUdkVDVDUGJoTHF3?=
 =?utf-8?B?SFQzbnVrTkZOV2NnR0FIeStyZzF3QkFzVU9vUjYwN1UyUVI3S05LUWthY1pB?=
 =?utf-8?B?UzQzQ1FTbEt4RW5ja0VGM0RlN0lIS3NqYW9sRzNLaThhUzBzMS9uUmUxcEZ6?=
 =?utf-8?B?dlExczZJcldsTUVxZnlFNXpkOHMzS2dJeUNCY2U0bndtZUpEaVZ4bGl0VE5u?=
 =?utf-8?B?dEJpN3Z6dCtUUTVXV0lpTVB5QjY0bFY3YXk0TzlxOXVqSkVPOUltNGhHQ201?=
 =?utf-8?B?YTBJb3I2blhCZUFzOVM5QklOVVRXQ3NmSThYQ0k0K05pbVVmMzJ2UldmU2Ju?=
 =?utf-8?B?aW9lcFJhQmd1Vjl4K1FtOGZwejBxYnM5L3dXb2E2bGcvR05SSE10VjJ5NTU2?=
 =?utf-8?B?c0s0NXBocmtiaTB1TysxbU1jYUJHSVpDeWtXYmNHYTh6ZUhIUVF1NzNMRWU4?=
 =?utf-8?B?YmRmZWJIL1BieXFObWdxODNIS3FhYTZqYWVUZFk4U1Y4NTZMNXZHODZCN0tn?=
 =?utf-8?B?aU9CanBNV0pmOGFaZU1sa2kzUm55OWFhd0U3eEg5dFF6Z0pFTVhyL2w0Z1Zn?=
 =?utf-8?B?Mmo1eHhYYi9FSVdxaEFUWTRkZmF3clB6cTEyeHhIZXU2QW4vc3ZGanVoZk0w?=
 =?utf-8?B?NUp5b0FuczBXSFR2SENsRTZMWWRtRCtJeWdkRmtKOURMUGRKVmRvOGpJMXQy?=
 =?utf-8?B?SUtRNm5nMmVHcWdCYkRoR1VHeVd3akZnMkk0NmVqTndJVkl5SFBEcU5mdlNv?=
 =?utf-8?B?TVEzNjhEb05XUkJmb2hlSTl1TGxydVU5V0tBVnNQQVd6Vll4ZXhvbTR4c3FV?=
 =?utf-8?B?cXdCTUYxK1RpenV5aUNSMU5FdzJmUVFSbWZiQUNhK1RtNG9vNXhGaEsrblVQ?=
 =?utf-8?B?eW11SGl0bktZUWxPOGhrbWZ3QzNEVmR2cGpPOXRyRlZwWDhPT1Zac2tCYzhR?=
 =?utf-8?B?UGxRaVdmd0RPWHdlZnhyZEJzeUVMc3NWM1h1L1JDdzBMQXRDdVdNZlN3L0w5?=
 =?utf-8?B?VkRMbkt6anhtN3VuYlNWclNNaXFMVDJsQXorMkU1RU1GdW5Ga0tTNHdWSDJV?=
 =?utf-8?B?ZlJoSDdvRC8venBhRThFWWY2YlU3dFMxajZVelRDdG53aitEM0NSYkRNcnNN?=
 =?utf-8?B?WFIzYXZsUEl4K2Z4dVZyRDFCMHE1Nk4zWlFEWUtuUmNCcTdVYmdFWU00cGtx?=
 =?utf-8?B?cnRiNWNYTXZTRGoyZmFucmtRblFhMjViSmVyU3d0NTNxZy9TYmVIQmpyNC91?=
 =?utf-8?B?aXR1NlFaUm1XZkZSbVdFMzZ0VThNcDhNVnR4RXNNTFFuUldzVys0SVZ2dWc2?=
 =?utf-8?B?dGM5YVNINVM2M2hGTDZSUjZvZWJENVFZMjV4Wk1IQVRBMUp2cnRhVEtVZVdO?=
 =?utf-8?B?bEVSdllraTRXcHZ3UnFNK2NBakNBajVrMGJtalhsYnBzMmZUZjhXMk12dEll?=
 =?utf-8?B?dUZOY2VmZTRUaEZxbE5CWksxRm9TMlYvS0d3S1RPbmZXV01tTjNqVy9rZkhw?=
 =?utf-8?B?ZE54K21JREJFTEJ2S2Q2R1RWdjdhekp6dFhXcXg3M1VqYkVxRmNkVkxMTEla?=
 =?utf-8?B?WWRnK3JiYlVBTXNJTDNoU3ZXaHl6V093NzZ6VzNSYkVTbGRFV3MvdDB6RTVT?=
 =?utf-8?B?aW5OTVBkNDQrcHpDUTc5MlRQa09xNWY2NXcwL05KbTVTa1dzVWxRWWJCMGdR?=
 =?utf-8?B?VndFTTJhRWt2cmRaNXhrMSsrUGgxNjdIaXp6VEpqNTIrY1RRSUxJQXRmSHAv?=
 =?utf-8?B?c0thRExyU3lqQWE5V2xTNHVWVGdHRUVhWG5Yb1NsdDY1VFV5YmU3cmprZUdZ?=
 =?utf-8?B?aGNEZjcrK204amZmYnl1WXEwaGZ2N3Nob1NZTkFJcmdXeUc3RFdRRW9XT29C?=
 =?utf-8?B?Ykx6OVJRdkpZaGQwN3FLYmtCbzBKcVdZS0xhZ3lkRnNDMkh6S21UU1JTM2Y4?=
 =?utf-8?B?cVBncWNzYUpTUUJ5UmJsZk5wamt5SENvZHBBNWwrbnZBeGFsUXZJc2RwMHN4?=
 =?utf-8?Q?nYZ8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47215d1-1ec4-45d1-6a27-08dde5d56ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 01:51:40.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1THP6Fz4xyHk+1Jb89QwaY+OSIsC6ckUVKIy2symUG4U7YFihGoZj4NhbNGfjztv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6838

SGkgQWxleGFuZGXvvIwNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxl
eGFuZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPg0KPiBTZW50OiAy
MDI15bm0OOaciDI35pelIDE2OjMzDQo+IFRvOiByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2Vy
bmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBn
bWFpbC5jb207IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgYW5kcmV3K25ldGRldkBsdW5uLmNo
Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5l
bC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tOw0K
PiBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tOyBmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24u
ZGU7DQo+IHByaW1vei5maXNlckBub3Jpay5jb207IG90aGFjZWhlQGdudS5vcmc7DQo+IE1hcmt1
cy5OaWViZWxAZXcudHEtZ3JvdXAuY29tOyBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+IENj
OiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eEBldy50cS1ncm91cC5jb207IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5z
dG9ybXJlcGx5LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFtF
WFRdIFJlOiBbUEFUQ0ggdjkgMi82XSBhcm02NDogZHRzOiBmcmVlc2NhbGU6IHJlbmFtZSBpbXg5
My5kdHNpIHRvDQo+IGlteDkxXzkzX2NvbW1vbi5kdHNpIGFuZCBtb2RpZnkgdGhlbQ0KPiANCj4g
Q2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVu
IGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQs
IHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0
b24NCj4gDQo+IA0KPiBIaSwNCj4gDQo+IEFtIE1vbnRhZywgMjUuIEF1Z3VzdCAyMDI1LCAxMTox
MjoxOSBDRVNUIHNjaHJpZWIgSm95IFpvdToNCj4gPiBUaGUgZGVzaWduIG9mIGkuTVg5MSBwbGF0
Zm9ybSBpcyB2ZXJ5IHNpbWlsYXIgdG8gaS5NWDkzIGFuZCBvbmx5DQo+ID4gc29tZSBzbWFsbCBk
aWZmZXJlbmNlcy4NCj4gPg0KPiA+IElmIHRoZSBpbXg5MS5kdHNpIGluY2x1ZGUgdGhlIGlteDkz
LmR0c2ksIGVhY2ggYWRkIHRvIGlteDkzLmR0c2kNCj4gPiByZXF1aXJlcyBhbiByZW1vdmUgaW4g
aW14OTEuZHRzaSBmb3IgdGhpcyB1bmlxdWUgdG8gaS5NWDkzLCBlLmcuIE5QVS4NCj4gPiBUaGUg
aS5NWDkxIGlzbid0IHRoZSBpLk1YOTMgc3Vic2V0LCBpZiB0aGUgaW14OTMuZHRzaSBpbmNsdWRl
IHRoZQ0KPiA+IGlteDkxLmR0c2ksIHRoZSBzYW1lIHByb2JsZW0gd2lsbCBvY2N1ci4NCj4gPg0K
PiA+IENvbW1vbiArIGRlbHRhIGlzIGJldHRlciB0aGFuIGNvbW1vbiAtIGRlbHRhLCBzbyBhZGQN
Cj4gaW14OTFfOTNfY29tbW9uLmR0c2kNCj4gPiBmb3IgaS5NWDkxIGFuZCBpLk1YOTMsIHRoZW4g
dGhlIGlteDkzLmR0c2kgYW5kIGlteDkxLmR0c2kgd2lsbCBpbmNsdWRlIHRoZQ0KPiA+IGlteDkx
XzkzX2NvbW1vbi5kdHNpLg0KPiA+DQo+ID4gUmVuYW1lIGlteDkzLmR0c2kgdG8gaW14OTFfOTNf
Y29tbW9uLmR0c2kgYW5kIG1vdmUgaS5NWDkzIHNwZWNpZmljDQo+ID4gcGFydCBmcm9tIGlteDkx
XzkzX2NvbW1vbi5kdHNpIHRvIGlteDkzLmR0c2kuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogRnJh
bmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm95IFpvdSA8am95
LnpvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgZm9yIHY3Og0KPiA+IDEuVGhlIGFs
aWFzZXMgYXJlIHJlbW92ZWQgZnJvbSBjb21tb24uZHRzaSBiZWNhdXNlIHRoZSBpbXg5My5kdHNp
IGFsaWFzZXMNCj4gPiAgIGFyZSByZW1vdmVkLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjY6DQo+
ID4gMS4gbWVyZ2UgcmVuYW1lIGlteDkzLmR0c2kgdG8gaW14OTFfOTNfY29tbW9uLmR0c2kgYW5k
IG1vdmUgaS5NWDkzDQo+ID4gICAgc3BlY2lmaWMgcGFydCBmcm9tIGlteDkxXzkzX2NvbW1vbi5k
dHNpIHRvIGlteDkzLmR0c2kgcGF0Y2guDQo+ID4gMi4gcmVzdG9yZSBjb3B5cmlnaHQgdGltZSBh
bmQgYWRkIG1vZGlmaWNhdGlvbiB0aW1lLg0KPiA+IDMuIHJlbW92ZSB1bnVzZWQgbWFwMCBsYWJl
bCBpbiBpbXg5MV85M19jb21tb24uZHRzaS4NCj4gPiAtLS0NCj4gPiAgLi4uL3tpbXg5My5kdHNp
ID0+IGlteDkxXzkzX2NvbW1vbi5kdHNpfSAgICAgIHwgIDE0MCArLQ0KPiA+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpICAgICAgfCAxNDg0ICsrLS0tLS0tLS0tLS0t
LS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTYzIGluc2VydGlvbnMoKyksIDE0NjEgZGVsZXRp
b25zKC0pDQo+ID4gIGNvcHkgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUve2lteDkzLmR0
c2kgPT4NCj4gaW14OTFfOTNfY29tbW9uLmR0c2l9ICg5MSUpDQo+ID4gIHJld3JpdGUgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaSAoOTclKQ0KPiANCj4gSXQncyBub3Qg
c2hvd24gaW4gdGhlIGRpZmYsIGJ1dCBjYW4geW91IGFkZCBhICdzb2MnIHBoYW5kbGUgZm9yICdz
b2NAMCcgbm9kZT8NCj4gU28gaXQgY2FuIGJlIHJlZmVyZW5jZWQgYnkgaW14OTEgb3IgaW14OTMg
aW5kaXZpZHVhbGx5Lg0KQWRkIGl0IHdoZW4gbmVlZGVkIHRvIHJlZHVjZSBkaWZmZXJlbmNlIGFu
ZCBmYWNpbGl0YXRlIHJldmlldy4NCkJSDQpKb3kgWm91DQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4g
QWxleGFuZGVyDQo+IA0KDQo=

