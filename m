Return-Path: <linux-pm+bounces-35136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C1CB8EC2E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAC518996AE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172C15855E;
	Mon, 22 Sep 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRwTvReb"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F971BC3F;
	Mon, 22 Sep 2025 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507532; cv=fail; b=E1M1+r9AA9GEXrGPj5kf/K1tgS+LODUvuTe9prKVBLLfHSS5H7vbaNbybO77AkjI8/h/nUjc8TkOBPvMf0h4vSHZlnSsmKX7HUgHv3wpFWLzalaoiS3PW78XKgzwk2NIPP8reI9TnsbNo8pZjY8ZW0TE6UMEtkZaeRUcVu2axxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507532; c=relaxed/simple;
	bh=WXWmnOLMvScYacHVHM+C0xLS1dQfF9BGlSKm2ZqyxNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I4UZFxPRF0Jc/Sg5MXxyynZ4sx1jtDI+q+FTjzNxJhQDrxJh4hSg8jojWOESSF3B6Q7N7GIYTd83fq6DD3i6rfXjeJigYVk/OSKppxUHnrrN7G1sc85+TCsHhkl8shSYX/pdvilgvY+vIJ8/yLNnR9mE6PrceHDyHMyXuM2ZbVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SRwTvReb; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciJc/FX/5eNl9qjZtJlWfQ8D5yNrHOXKa89Fgr8If3L6Z6HQrht6vYmtlgdI6N9NR523AjCgn0AewRXuUtsO19CBfE6WIm+C/0YNTX/xI6rZNQ54mXfpu0kx9gQAM0TV5/tKFUUXygmscIZ5a67jVA4urGdF98PuayIsnrh1xGDJ0tVNeCxWdMXYCBFiU+zdmW0ZR6lD3GlLilmwh8AsI0ikJW9wdVBS83XnwP4wS27zI/m8hYOaQlv/s89vggTVq4TWZNKHwvMSLzauDaOg1q9fyMn+erCPVYVUaXAVCM0AF2+iB04f4zuwJ8RyM8/rJtCULbphM7ZB3RM1346KNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXWmnOLMvScYacHVHM+C0xLS1dQfF9BGlSKm2ZqyxNY=;
 b=kKzy2LD8CRXpqW6hXEux6rx/1wIAQG6paSIw5YBGY6J2ynWMfrFfejQh0+vWr806sXws181axgKxyVAogIfk0/BWZjPLhadpBVt4sXCZBujRdDHiuvVXjxNKKxbapZ55R5zaUWweD/Ho2g9bX64F/fMBIyD7bsffeg0A6c8wOoHq/bOcgMBc2QJi6aKpUpL1UXFJrxhrRo9n8Drrj1pQVMdiiOgWgAg9kOO173MmnkHGKGeC8ETJpDGtE/RzV4cIJTpUasF8wmqHpFgqGrciAiXTCfelJfsGKGSmclvruDeJ9ZyGWmzbzpfZ7sRug0DZvMaL/1Ob2fyO/CKB6zwrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXWmnOLMvScYacHVHM+C0xLS1dQfF9BGlSKm2ZqyxNY=;
 b=SRwTvReb7xvOPAdVI02LgiaUA/OS7beCGJw0iZUnq6JxFH+Zfv9xV43C3AKNOerkCd5+JgTz1S/oLC/twbyS6uN/BgqVn5EM+AEgElyupCDO2vo9uLOSi5h//+NGNHK9vky87ekAb0WA65bWkDj5QHUFA6VFMY+9rfIPHU7AuYpHOcjzOsHUxpii2sKJ+O5YC2TxTxZhcJ3tCe2e1B3P3cbg+rqKxQl4fb42I3c/XtH0HbtKoV3lnDEoKYSJbbbOsjGFLzLXc7ClaSxoCN9/vVDosNk8o2+GZ9tfVXvohCBe4EWUTFbDHMxoqhRInaJVvn5yhrTXGucXS2fMILe0LA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:18:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:18:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Peter Chen <peter.chen@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH 0/5] pmdomain: core: Introduce device_set_out_band_wakeup
 and use it in usb
Thread-Topic: [PATCH 0/5] pmdomain: core: Introduce device_set_out_band_wakeup
 and use it in usb
Thread-Index: AQHcK2agmO0lZ1N1k0G8R+GycH4N97Sed2yA
Date: Mon, 22 Sep 2025 02:18:47 +0000
Message-ID:
 <PAXPR04MB8459B59B752E5D1F4D7100C58812A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
In-Reply-To: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8622:EE_
x-ms-office365-filtering-correlation-id: bd2002d0-e442-43ae-d401-08ddf97e5cb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|921020|13003099007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZG1VTGlHMS9zM0psUlRaVUl5RzFWRDdRejVjODNYSnR0UVlLZ3Y5OGpRNlB5?=
 =?utf-8?B?YjZKU0tWYVl1cm1HYWNTZWQ5SjhUZUova1pIOTRZQkhLTDhkODVLR2VrUWVt?=
 =?utf-8?B?RHJ2UkpCQWJ5V1pGcmo2T0RqZkpFOGZxZ3ovN0Q5eEt1aE16RVZxSmRvc1dr?=
 =?utf-8?B?ZTdidGkxaStQaHhva05Qb2JvYjJvRzQwY3hsRHZna1p3UUI5emVrSUVTeVRT?=
 =?utf-8?B?RWtNNVZKQ1ZiT09acEF5ZjRBWmsrdlhybkdUZkVBQ09yTUo1ejhaQUZpcEVQ?=
 =?utf-8?B?M3Y4QmpDQ1YvTXBmcFU2OEVMUkRaZWRaV2krNHA5ZkRYZDNhRXlVdmppWG4r?=
 =?utf-8?B?M0ZvNHhWVnV3eS9iRk1tRjlweHAyWXN3aFVIdHpITzVkZTVCakI0VjVkMCsv?=
 =?utf-8?B?dlN5OXVScEF2VUpsaVFvMi9Kd1BYRlZzbmhZQTJ6Rys4ODFYL0xrSmdIRHUy?=
 =?utf-8?B?SWR5U2x5Uzg4VktPaTNWNmZJMkNNTkpEdDIxYWZLZ0FmZmtJbGUzMlJrZ0l2?=
 =?utf-8?B?bmJUUHE3eERMS2VHcXp2K1ZPWkNWcllwMVFTUTl6Ulp2QlZ1a2dTRTM2RFpT?=
 =?utf-8?B?c3BQb01DU28wbktEcWVFU09jckR3bFRRR1o5cmV5RWdCYUZqSE80a3VLVWRE?=
 =?utf-8?B?Z2x4dVJLQTczQTc1ZkxPRy9uRTNBZGM1TEN0ZTQza0V6WERLQUxEZ0R5SlR5?=
 =?utf-8?B?b3U0SEIwaFE2YXJHZEhGVnNKYjJvSFQ2amR1cjRVblh3djFMMWJNd205YmZE?=
 =?utf-8?B?WkxmZWR2enlNRXRlaXNyYVRwWVZUQlpCN082enJIYVVBODdUd3JVWVI1SDM5?=
 =?utf-8?B?UHdOVjRBcGVROWMrckhzbTEweUNhdTd5OHprY09vSHRDa3RmdnVDeUQrcEcr?=
 =?utf-8?B?WG83Z1ArdTdUTTNGSnRyLzJpVjNXZzA2NnpvNDdvYXliVk0vZFdMV29Ja2RF?=
 =?utf-8?B?RjU4clJxNHRaUDhZL0hlU1E3U2JUVzFjS2N5dDdtVmZSNXYvaytnR2daNExr?=
 =?utf-8?B?dWN0SVBNNGlxektJQ2IyQUNaT2FVMCtJUjFDT0VicXNWT1ltZWFuTHMwUGd2?=
 =?utf-8?B?dWUrbktPd3VRc3ozMjU5aXZyUFMxcUMyNHltOWNnYU9JdnAwZExGZ3ZSSitS?=
 =?utf-8?B?RjBWUG9BSW16SXFBcEVNOEkyVGNiak1xUnhEa3lFdml5RW1EOXE5SjdNaFox?=
 =?utf-8?B?ck5CNm5ZVDlsaHh1bkhBTTVpczZnY3lueTR4VGpBN3A5M0M0RzJFUTJtMExI?=
 =?utf-8?B?MWNVbjE5RHJqNzdxeWpiTlN3YmhaekNwOTJWbGtvRlRSRnBqZ3lOMktYdlFi?=
 =?utf-8?B?ZnRNQ0x4bTExL1lWM3UwQ05tQ1JlUncxZzNJRHZmekFCV1Ixd3lUZ01zYTFO?=
 =?utf-8?B?QzdjTEc0cHhHakpNZFdranE2aGdSQTB3dUc1OWFtRXRmcHFKcE9TNzZLM1hx?=
 =?utf-8?B?TDJERFUzOEcrYjhyS2xUNEduWUNURkl0MlhLczZ0ZTRFVDJYMjV5eHRwL3BS?=
 =?utf-8?B?NnpEbzB1OW9hZE9SM3R6Zm1kRUd4ZWQwaUFOSFVRMkkvVWRaQ3NDTUdwTGJP?=
 =?utf-8?B?THc2QnhFdDRqajB4WXBvemJuVlhhTndzbER5Y3dScTFGelpLNU5TMlM2QTY1?=
 =?utf-8?B?bmdZUVh6Njkwc1JHSzZFK3k1bThjOGxwZW10eVBmZnE4V2Z1K0lMMkd5eVB4?=
 =?utf-8?B?ZVdVc1RrbzVzdDlZeUp2R09YSzArak5mdXpidVlMUzZROGZzaFh2YkRlck03?=
 =?utf-8?B?V3FYRVlpWWRpdW1vcnV3N2tvVDFnOXBrOTlsVnhtVEJEY1BEbFUxYTVFMEov?=
 =?utf-8?B?dVdNZFRiMXdadnZqZlVXdDV5S0N5MWlyaTlQYzNlZWVRYzlYNlZaRjZmaEJK?=
 =?utf-8?B?NE1FcTJqRTB4MnVhUXN0d1R0TDVmNnd0N3NUOURsTHdSd1RzQnVwd0Z2ZVRt?=
 =?utf-8?B?ZlVYcWZlVncxWll0V1l4TzgxemJNZ0hIVTg2QWJLaUhPTnhWWVNDcUZLaEU0?=
 =?utf-8?B?Mi9rVGx2SEdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(921020)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SW03VndJNzNWMEhDSGdwczRNUDJDa1dPZGdXUi9hVVlrajRnTDI1Sk9YcWFa?=
 =?utf-8?B?QVo1cEMwaTQ4SEl4dUExQzZ5YTFPQ0JacGh4Uk5USVFCVmw0VUhLS09QUHho?=
 =?utf-8?B?eUJnWmxUeVoxTG9haVZuMHA3SFhmQ3V2VzhXZlBPeHdEUWhDWG5pZjhCK3Mz?=
 =?utf-8?B?VVAwdUpHK2hrdEc3bVR5UTZlam52Y1JGVjExNG5rTFBMdDUzZm5wMzJHeXQ3?=
 =?utf-8?B?U3Y1Q0F4b0lBdFFGQ0VrSjlyZUlZeExxRVBPVDBzSUlSMHNkU2ZDY3RSSE5m?=
 =?utf-8?B?Uk94d3BkN09ud3VvcGIwVVFUUmg4TmpoczN6V1RXMjVGVjVYRXRTRmsxdjRB?=
 =?utf-8?B?NGpHUVhXRm1aZitFbm1VdnhmMHlIdGVBYWRBTWZMQW80M04rK3NwZlFtUGZI?=
 =?utf-8?B?TFNFanZZU0ZvU2hMQzJCcEZsTUR1TGdQSjhkSkg5eUlFc3V5SXVCUnJ4eGNC?=
 =?utf-8?B?ZU1VekdxWXc3Q1lRTDZ4UjZ0SUFHUjR3M1ROMWhEdXZmZXVkanJHdWJFTmFq?=
 =?utf-8?B?TlA3RnBPZUMyZmQrV3N3TE9vV2daQzZmejZNOVlRMEpxUmJZSkt6blU1d3FR?=
 =?utf-8?B?akFRdUxTYVZpTzRkUjJ4ODA5Nkl4YjFiZ3FUZnlvMGRPVHFKdXdma1c5YXBh?=
 =?utf-8?B?Ni9YVG93ZlRzOGxQckdDcW1GaXZmSlFPdEEzcm5TNDIxOEt1Z1ViZHdEcHkv?=
 =?utf-8?B?TFIvRi9zY3NlZktSb0hiQ2hoT29CY1dmRnU0VFRtUW9SaGFML1hSRmFZNGpv?=
 =?utf-8?B?aUtSQVI0RENkOTBSdnE0U3BWNG96ZHFFYnJmUnhhNkZwS3V1ays4UnR1S0tK?=
 =?utf-8?B?R1ZoaEJ1YUNBZkUrMmNZSmRJWTRsYks5MUd1ZkFtUzVHSk9Oc2VLVmgvaDJt?=
 =?utf-8?B?UUJDcmJzS3NRYU5Qc00vQ1hWUGxGLzkveG1lUnRjNnFIZyttM1VWZUVmd3FB?=
 =?utf-8?B?TE5VbXRwNGF0WUtSOVFvYVFFeVdLNVFQTjMxV2xsTzZ5UU9JcDZNODRsNWl4?=
 =?utf-8?B?blFxdmdRcDIxRjU0VHpxVFk3Zm8yUlVxM2p4RDZOQ3BYVHNmQ3d4K0FlQ2wy?=
 =?utf-8?B?bU03T2tpRTJyRVlJcWNXWWxtL1R2ZDBraVk0U0VReFlIK2kzUEY1bUhHTDF5?=
 =?utf-8?B?a3c4ZG4xU1NpSVlZdXRiZGxMM3NvMzhHTVBtYU1pM0JvNEdUalIxd2V6eEhX?=
 =?utf-8?B?K3lKSWxlZndZa2h0eEZJMU4xQzZKN2hCeUFjQTlURzJxRkt2Njl6ZnYxa3Fq?=
 =?utf-8?B?N3hvUEV2THduWXlvZE5vKzR5R0s4dlE4MnZzT3JpcE5rWjdJVkdNeXIrT2pJ?=
 =?utf-8?B?M2M4djhjcVlBcFNsN0xITHc4SkdNaHFOaTNrdTVCM2pOemdHeTdCQUtDTW1s?=
 =?utf-8?B?bThaUXAwVU5VZ3UvTkNqa29WMDFQdDZQVXVkRVJteUFSNmc0YUtWRzdKQnhi?=
 =?utf-8?B?ZVZlUUVqbGtOdU5Cd3QyMXBmZkZ4NWNuMVpBMGpyRjNJOFpSWU81dm54Ym1q?=
 =?utf-8?B?YlU5RCt3Zy85dVN0eHI3L0pid0J5NlVZSm0vbG55cFJ6MEgxSUJIUmo4Yk56?=
 =?utf-8?B?RERnNXJvRVFGQWxxdkFJTU0vK296eVAyeGRwUWVLRVR0djE0cS9tblFBSHNC?=
 =?utf-8?B?VWh5R3FRRFV2R3RxUEo4Y3Y5d2xsKzljMEozQlorZjZyb3BkNXZabGJYY2h2?=
 =?utf-8?B?Z2d1dkxDSGpNMzRwcWt5Z0tPRkRMTkJjZERKcnRNQStqQnNLUWNPcFhQeEVN?=
 =?utf-8?B?ZjJjRzhiY0pBWWJPajRBcHp1S3AySmJWR0FEalVaVEVHdnoxYWZ3K01QaEVv?=
 =?utf-8?B?UXlOcGFhRU84RTd4VzlZVWNiOG53QWZhQi8wZE1ySXJJdzE4SUlRdERwWjhn?=
 =?utf-8?B?bzE2UnBMbU1LSFYrM0o3dDFtWjJUN1BaZDNoMkVYSm8xY05FSlRXK3QrQlZC?=
 =?utf-8?B?Y21CcTREZVhlTW5iS1RrTlNlV3ZlY0FRNi9TbWJGR0FrbmROZiszOFRNRVdC?=
 =?utf-8?B?SUN6Nm03MUNtbW9YNjlJcjJqbmpZeFVBcWplQTBaNlFxa20vSURXdndxMm1V?=
 =?utf-8?B?SGYydldYSStKU25qWlRJRFROKzNERDJGakRaZjI4UVZVMit1amppUElkZjNv?=
 =?utf-8?Q?HWGY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2002d0-e442-43ae-d401-08ddf97e5cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 02:18:47.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2cHkF8ksOyqQXnQEl9e2M/5J7eHKSHJIHowPt0/li6pKU+dGvyLvVC0O/NDwrwPnNxJkXAxNdhJj0TR+C2D8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoc2V0LiAgVjQgd2FzIG1pc3NlZCBpbiBzdWJqZWN0LCAN
Ckkgd2lsbCBhZGQgVjQgYW5kIHJlc2VuZC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiBTdWJqZWN0
OiBbUEFUQ0ggMC81XSBwbWRvbWFpbjogY29yZTogSW50cm9kdWNlDQo+IGRldmljZV9zZXRfb3V0
X2JhbmRfd2FrZXVwIGFuZCB1c2UgaXQgaW4gdXNiDQo+IA0KPiBUbyBpLk1YOTUsIFVTQjIgYW5k
IFVTQjMgYXJlIGluIEhTSU9NSVggZG9tYWluLCBidXQgdGhlcmUgaXMgYWx3YXlzDQo+IG9uIGxv
Z2ljIHRvIG1ha2UgVVNCMiBhbmQgVVNCMyBoYXMgd2FrZXVwIGNhcGFiaWxpdHkgd2hlbiBIU0lP
TUlYDQo+IHBvd2VyIGRvbWFpbiBpcyBpbiBvZmYgc3RhdGUuIFNvIHdoZW4gaW4gc3lzdGVtLXN1
c3BlbmQgc3RhdGUsDQo+IFVTQjIvVVNCMyBjb3VsZCB3YWtldXAgdGhlIHN5c3RlbSBldmVuIHRo
ZSBVU0IyL1VTQjMgSFNJT01JWA0KPiBwb3dlciBkb21haW4gaXMgdHVybmVkIG9mZi4gVGhpcyBt
ZWFucyBVU0IyL1VTQjMgaGFzIG91dC1vZi1iYW5kDQo+IHdha2V1cCBjYXBhYmlsaXR5IHRvIHdh
a2V1cCBzeXN0ZW0gZnJvbSBzdXNwZW5kZWQgc3RhdGUuDQo+IA0KPiBXaXRob3V0IHRoaXMgcGF0
Y2hzZXQsIGlmIFVTQjIvVVNCMyBhcmUgY29uZmlndXJlZCB3aXRoIHdha2V1cA0KPiBlbmFibGVk
LCB0aGUgSFNJT01JWCBwb3dlciBkb21haW4gd2lsbCBub3QgYmUgdHVybmVkIG9mZi4gVGhpcyBs
ZWFkcw0KPiB0byBtb3JlIHBvd2VyIGNvbnN1bWVkIGluIHN5c3RlbSBzdXNwZW5kIHN0YXRlLg0K
PiANCj4gVGhpcyBwYXRjaHNldCBpbnRyb2R1Y2VzIGRldmljZV9zZXRfb3V0X2JhbmRfd2FrZXVw
IGFuZA0KPiBkZXZpY2Vfb3V0X2JhbmRfd2FrZXVwIHR3byBBUElzIHRvIHNldCBvdXQtb2YtYmFu
ZCBhbmQgcXVlcnkgdGhlDQo+IGZsYWcuDQo+IEluIGdlbnBkX2ZpbmlzaF9zdXNwZW5kLCB0aGVy
ZSBpcyBhIGNoZWNrLCBpZiBvdXQtb2YtYmFuZCBpcyBzZXQsIGl0IHdpbGwNCj4gY29udGludWUg
dG8gdHVybiBvZmYgdGhlIHBvd2VyIGRvbWFpbi4gSW4gZ2VucGQgcmVzdW1lIGZsb3csIHRoZXJl
IGlzDQo+IGEgc2ltaWxhciBjaGVjayB0byB0dXJuIG9uIHRoZSBwb3dlciBkb21haW4uDQo+IA0K
PiBQYXRjaCAxLDIgaW50cm9kdWNlcyBkZXZpY2Vfc2V0X291dF9iYW5kX3dha2V1cCBhbmQNCj4g
ZGV2aWNlX291dF9iYW5kX3dha2V1cCBQYXRjaCAzIGFuZCA0IGFyZSBkcml2ZXJzIGNoYW5nZXMg
dG8gdXNlDQo+IGRldmljZV9vdXRfYmFuZF93YWtldXANCj4gDQo+IE1vcmUgb2xkIGRpc2N1c3Np
b25zOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wbS8yMDI1MDMxMTA4MzIzOS4z
MzM2NDM5LTEtDQo+IHBlbmcuZmFuQG9zcy5ueHAuY29tLw0KPiANCj4gVGhpcyBpcyBwaWNrIHVw
IG9mIFsxXQ0KPiBUaGlzIFYyIHBhdGNoc2V0DQo+IC0gaW5jbHVkZXMgdXNiIGRyaXZlciBjaGFu
Z2VzIHRvIGdpdmUgcGVvcGxlIGEgZnVsbCBwaWN0dXJlIG9uIGhvdyBpdCBpcw0KPiB1c2VkLg0K
PiAtIFJlYmFzZWQgbmV4dC0yMDI1MDcyOSB0byByZXNvbHZlIGNvbmZsaWN0cw0KPiANCj4gWzFd
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMjAyNTAzMTEwODMyMzkuMzMzNjQzOS0x
LQ0KPiBwZW5nLmZhbkBvc3MubnhwLmNvbS8NCj4gDQo+IFRvOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFRvOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGtlcm5lbC5vcmc+
DQo+IFRvOiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz4NCj4gVG86IEdyZWcgS3JvYWgtSGFy
dG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFRvOiBEYW5pbG8gS3J1bW1yaWNo
IDxkYWtyQGtlcm5lbC5vcmc+DQo+IFRvOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJv
Lm9yZz4NCj4gVG86IFBldGVyIENoZW4gPHBldGVyLmNoZW5Aa2VybmVsLm9yZz4NCj4gVG86IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gVG86IFNhc2NoYSBIYXVlciA8cy5oYXVl
ckBwZW5ndXRyb25peC5kZT4NCj4gVG86IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxA
cGVuZ3V0cm9uaXguZGU+DQo+IFRvOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+
DQo+IFRvOiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IENjOiBs
aW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGlteEBsaXN0cy5saW51
eC5kZXYNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IENoYW5nZXMgaW4g
djQ6DQo+IC0gU3BsaXQgZGV2aWNlX3NldF9vdXRfYmFuZF93YWtldXAgQVBJIGFuZCBwbWRvbWFp
biBjaGFuZ2VzIGludG8NCj4gcGF0Y2ggMQ0KPiAgIGFuZCAyIGFuZCBjbGVhciB0aGUgZmxhZyBp
biBkZXZpY2VfcHJlcGFyZSAoZnJvbSBVbGYpDQo+IC0gQWRkIFItYiBpbiBwYXRjaCAyDQo+IC0g
TW92ZSB0aGUgY2FsbCBvZiBkZXZpY2Vfc2V0X291dF9iYW5kX3dha2V1cCB0byBzeXN0ZW0gc3Vz
cGVuZA0KPiAgIGNhbGxiYWNrIGluIHBhdGNoIDMgYW5kIDQuIChmcm9tIFVsZikNCj4gLSBGb3Ig
cGF0Y2ggMyw0LCBJIHN0aWxsIGtlZXAgdGhlIFRhZ3MsIHNpbmNlIGNvbXBhcmVkIHdpdGggVjMs
IGl0IGlzIHF1aXRlDQo+ICAgc21hbGwgY2hhbmdlcy4NCj4gLSBMaW5rIHRvIHYzOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjUwOTAyLXBtLXYzLTAtDQo+IGZmYWRiYjQ1NGNkY0BueHAu
Y29tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEFkZCBhIG5ldyBwYXRjaCBmcm9tIFh1IFlh
bmcgdG8gZGV0YWNoIHBvd2VyIGRvbWFpbiBmb3IgY2kgaGRyYw0KPiAtIEFkZCBBLWIgZm9yIHBh
dGNoIDQNCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwODAx
LXBtLXYyLTAtDQo+IDk3YzhmYjJhNDMzY0BueHAuY29tDQo+IA0KPiAtLS0NCj4gUGVuZyBGYW4g
KDQpOg0KPiAgICAgICBQTTogd2FrZXVwOiBBZGQgb3V0LW9mLWJhbmQgc3lzdGVtIHdha2V1cCBz
dXBwb3J0IGZvciBkZXZpY2VzDQo+ICAgICAgIFBNOiBkb21haW5zOiBBbGxvdyBwb3dlci1vZmYg
Zm9yIG91dC1vZi1iYW5kIHdha2V1cC1jYXBhYmxlDQo+IGRldmljZXMNCj4gICAgICAgdXNiOiBj
aGlwaWRlYTogY2lfaGRyY19pbXg6IFNldCBvdXQgb2YgYmFuZCB3YWtldXAgZm9yIGkuTVg5NQ0K
PiAgICAgICB1c2I6IGR3YzM6IGlteDhtcDogU2V0IG91dCBvZiBiYW5kIHdha2V1cCBmb3IgaS5N
WDk1DQo+IA0KPiBYdSBZYW5nICgxKToNCj4gICAgICAgdXNiOiBjaGlwaWRlYTogY29yZTogZGV0
YWNoIHBvd2VyIGRvbWFpbiBmb3IgY2lfaGRyYyBwbGF0Zm9ybQ0KPiBkZXZpY2UNCj4gDQo+ICBk
cml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jICAgICAgICAgIHwgIDEgKw0KPiAgZHJpdmVycy9wbWRv
bWFpbi9jb3JlLmMgICAgICAgICAgICB8ICA2ICsrKystLQ0KPiAgZHJpdmVycy91c2IvY2hpcGlk
ZWEvY2lfaGRyY19pbXguYyB8IDExICsrKysrKysrKystDQo+ICBkcml2ZXJzL3VzYi9jaGlwaWRl
YS9jb3JlLmMgICAgICAgIHwgIDMgKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1w
LmMgICAgIHwgIDkgKysrKysrKy0tDQo+ICBpbmNsdWRlL2xpbnV4L3BtLmggICAgICAgICAgICAg
ICAgIHwgIDEgKw0KPiAgaW5jbHVkZS9saW51eC9wbV93YWtldXAuaCAgICAgICAgICB8IDE3ICsr
KysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L3VzYi9jaGlwaWRlYS5oICAgICAgIHwg
IDEgKw0KPiAgOCBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDhmN2Y4YjFiM2Y0YzYxM2RkODg2ZjUzZjc2OGY4Mjgx
NmI0MWVhYTMNCj4gY2hhbmdlLWlkOiAyMDI1MDkxOS1wbS12NC0xODc5NTY4ZGU1MDANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNCg==

