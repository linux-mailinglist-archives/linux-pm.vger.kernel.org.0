Return-Path: <linux-pm+bounces-35559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0883BA924C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087E6189499E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCA305040;
	Mon, 29 Sep 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KS0kjnNH"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F62EC567;
	Mon, 29 Sep 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147571; cv=fail; b=qW3C5Dn+cQNlc8d02s6lx731LQmsRmY0scIJncIum7gUHdrs60ch8onZmXiDC3SnFRFOMw+ObPLSzxWSYAGqPXkoPAC2mWUR69sM8rDzQRwEmnw96pvKUEJpqb5FIY71aVX/6boOuqeYxUElz6mE8QxrbayVtaXXWBL4ZnEI5Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147571; c=relaxed/simple;
	bh=RwE1otnQxBTp2ZLyEVam6dykJsa1r0+X5zQCK52tWsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyutJkmMncpWxJb1GVis67k9wYeZmzd9sfzQcu366Z2jqV0NrwlMSLQKKdN9u8IX9xaSWof7n65qjdN8irYsvazc5wTzDbE1Exi1rHBtSbLSj0Uo4UskRNkq/juPTey3PbplQ2Ff/k/1vzsaFvQwFYxLCx/EphgX2JwMUyqntBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KS0kjnNH; arc=fail smtp.client-ip=52.101.83.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIPLsAxuin3oT1J2ay4uZ/g3KKsZQI1BN575ke/d4WddqO4UD+nGEHbqrrgGafub4XGICCd/WU65VonfjtDOwI3Nmw5hz28xTuF0IqiIRx87ZZmQcgvIAiaz1l6uCdbSeDWukZJF8e1OdPhd2OdgZVvCIcJdOTpzMOKXMjNAS4Yp+tZqKzmLZg9v8g8uYf8uxCg6zlIm+eTQEGsLrnGiD6J20eGKwwrxtIizBe3dj44qr1ggOQ7nwhcoM2C2L/d3rXZnxIo/daP992YEkgIMkeccibMR8cUndRD2i0Rri4hVyVdaPaJGaZ2EkqJxwuiomImA5cWsJa2Qz+BVYAQsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwE1otnQxBTp2ZLyEVam6dykJsa1r0+X5zQCK52tWsg=;
 b=wswVkxTAny97MyvX4f1cKIEeeU6mP39szJlbWjdPppIjuHaJnCgF1m0DK3qCUbm6DBvZ2P19NXIaU4piT/hElyTVWglkvmgJj/vm3DCaa7M3fbQ22XYY+7HQt24JLDRnv16Sw7apXmI9if2ogmh/7EpVKWvaeML45QbiHmMtZlIsVDHqflFScWUueyv0/ZvcTOQG6uxnwBjifq2YyKMkAVRMYVD9NQ6CU8nHxZrP3jLKMw6I2hWGYRxnYZzeN7Q0Z11sqyL1IAAmm27zsbIi3sLkKFhvl/Pd/lpSKa+MVA69Irs7SFh7WHP1MJqE2Z0TIXD9rexuCSazK62xROo+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwE1otnQxBTp2ZLyEVam6dykJsa1r0+X5zQCK52tWsg=;
 b=KS0kjnNHEG0nbOxOS0qxah8vYVMi/XCrB1gDm7HLYnKIBkXSJJZ9J9QKx5E5T5K2iXDhQeMgTzRuhKPnzQ5rukJbmZZ8kMHaQ1TfAw622bwstqRCQ9uNMJnDGtXmg+jtXLRm0e9n/ekQ7jRpxBShlI9YipPFs2b4tsSazQPlF0nrQ994JjkvUvVq1qvRewkGfeMMtki6okf5mSg/ok+KV/eD0UkJ559Y3fEjF8ofIlfuYalYBhfsDCIpwXLqSSJr/UMDoYAPEszocdr0CYl/v2uNsrigEo3f9gks+kenuI/jiwfW6WbVYbNLdFNxbADMjvwWHesD71r/xAqpMEcYJQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11700.eurprd04.prod.outlook.com (2603:10a6:800:2fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 12:06:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 12:06:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Peter Chen <peter.chen@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH v4 0/5] pmdomain: core: Introduce
 device_set_out_band_wakeup and use it in usb
Thread-Topic: [PATCH v4 0/5] pmdomain: core: Introduce
 device_set_out_band_wakeup and use it in usb
Thread-Index: AQHcK2eXc3Qg1iO+uE+ovysSEhEJ9LSgjM0AgAkCFACAAGHMAIAAKxhQ
Date: Mon, 29 Sep 2025 12:06:06 +0000
Message-ID:
 <PAXPR04MB845918DD700C45DA1599B7D1881BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
 <CAPDyKFqQgS9j4uGkTL_taPTL96su1tqpyoek1cpZgTiaaBMpCA@mail.gmail.com>
 <20250929034048.GD29690@nxa18884-linux.ap.freescale.net>
 <CAPDyKFp1NrdA6nZMQFrgrpc5Ub4osgYTiSJ=Gf1m1q4X8RYCmA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFp1NrdA6nZMQFrgrpc5Ub4osgYTiSJ=Gf1m1q4X8RYCmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB11700:EE_
x-ms-office365-filtering-correlation-id: e2d2c79c-7bee-49d6-28ac-08ddff5091ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzBCSHR4cUFDbzNKQVBoTUVvYXJJQTBKQkJuUXcvdTBlcFRmemdpUm1pWkZ6?=
 =?utf-8?B?Wll4UGU3QmxQekZWUytCQUFITFlZakI2MndTclYrMUl1TTdrY0NiSGJyVXJ2?=
 =?utf-8?B?SDU1MVliL0F2UlR0cVR6VXBjTEhnNGpWNEMrSW1ZQVY0TjNDclEyUDlYNXBI?=
 =?utf-8?B?VkNybFpCc0tzQ1Fvdm1zSVlWM0hqZndOOGRTVjFEVWU3L1FUYk5zZVlibjJX?=
 =?utf-8?B?VnJmNVFwd3BjanVZWEF2UWliM3c1MTZUVWVhNGsrbkl5YXExaFBvM1Jvd1hC?=
 =?utf-8?B?T2krZUdMWnNpTjN1djkyNUpNVFNIRDRlL2JrNkdBaitub2FEbU5rdzBqcTRh?=
 =?utf-8?B?MHNiRDlhK3JaWGNUOUx5RDZ1Y1FTblZEc2dROU9DSlhHNGtXS29lWW13dzRC?=
 =?utf-8?B?SzNrdjJWMUFLdmRwVUI0Mk9OcUxHZzhWUURmNFB0and2anRSaTBpWmdvZWY4?=
 =?utf-8?B?bkhwekcyQ25ZV0ZIM2NGRjg5bWRDdGVFVGVuS0NGZFh5WVBrb3NxbDdHb3BZ?=
 =?utf-8?B?UWFaVmJ1N08xa3FiczZRT3orK3JvN2ZyRTNmL1BVODNvcUExenFydStwWE1L?=
 =?utf-8?B?UkFvRk1jeFNwQVppalRDMU5xcVhnQ2ZvdWJDOE9vYzVHUStkK1pPaTNZZkw4?=
 =?utf-8?B?aWkzZ1R5VGpBKzlDMXNia1d5MEc3MTRpclJRNTMvdUNXMG9icTVXNmd2OFFi?=
 =?utf-8?B?dnVHUU9MQytMcUFrZ0w2aFkvY2hsTW43QTJtM0lxd2kzZkZXRXNYUk1Ca3pB?=
 =?utf-8?B?aDNqd0xqQXZic3JjWm5kQTN2bzdSaWNqQjZldkFTeEViL05BU1dCcHFFL2hz?=
 =?utf-8?B?SDJlenFCOGlvZmUvUlJtb1pzazFVWjdmYnZIVUdqdzdjK05LejhOT0ZRV0tT?=
 =?utf-8?B?dmtEMmxIU3FIck56L2Z0bW9yR3NzVWY2bEJwM1pKbFlEVzdOdyttdjMyaWJF?=
 =?utf-8?B?NXNWR3VHYklQOGxMQVVjRHY4dzc2NDdickhsd2RvQWNGTUtZVnh0WURmL3V4?=
 =?utf-8?B?eVFrNng2YlduenBrSWlXN2FWbnJFaUtFNHRBUjVGNys1Q01ITy8wMWxQTERo?=
 =?utf-8?B?cHlyRTVHVmsrT3ZHM3lta3RhenpNZ2o2U1V5RGtJdFkxb0xkT2p2VktMd2FQ?=
 =?utf-8?B?YnlaSSs3UTZablh4SlloRTUrUHErVFFJYy9OdG1mcTVrWXFsd0JnbjdHOU9h?=
 =?utf-8?B?ejJnemNZaEp6SU04TDBOdFBUQ2JlMFhEYkxTcW1Vc3FRN1dZbjdKMTdxU3JX?=
 =?utf-8?B?V2tSSFIyUWJvTW1oTUlWU2ZuZXUwYVBVdkRjMStlQjhKaTZhMDBRTkxwRW1N?=
 =?utf-8?B?TG4vdXFCYjZ1VGIzLzJWZk1PQzlnTWdwdnhReDd6R052QTFmZC9vTTVWVmFh?=
 =?utf-8?B?YnJiTXZiQ2FBenVHM1F1MW9wZWVrLzVlWkM2NUg3MjZoMTRQYzFBTnRPWVZ5?=
 =?utf-8?B?OGVwSzBrUXRnVW55UDllaWRqQTB5Tkx5RWROdjFHZ0ZQSUN4VFZ5MG1ucVFI?=
 =?utf-8?B?ZWlyMGwzbUtwL1VrdEl4YU5UQVNJUGUwL09SQVJwbmlENmplaGd0UzU0V2gv?=
 =?utf-8?B?Nysxby96SnMwZ0p3YUVqbzAzR0orY0FXMzdTSVJCZnI4dXljMGZLczFHOU11?=
 =?utf-8?B?OWdaWStKQWVoclNVSHNsNXVtcyt5emk2THJOWThlSCtGbWpSWUtoeHNCZmRo?=
 =?utf-8?B?QzFBY3NJaEpsTmpjS0ZJRzdLN1Q1RzcwbDVUdFhqM2xqeGlEbU1vakpSZzJq?=
 =?utf-8?B?c1A5NWw2c1gwUEtsNjFMODlXM2RiZ0YxQjJiOGVQU0JZb1RxbmttNi9oMEoy?=
 =?utf-8?B?bEhwSER0OFNjVGlROUgzR3ZoTTNNSDlGVURpS3pYWjg2TUhEeE1uaE1WamJG?=
 =?utf-8?B?LzRrRHVoWlB5MjhRR3M1RDFYZlFKbnZES1Q4ZHZDaVpOVE14bzdHMEdvODZj?=
 =?utf-8?B?bStSdCtTSVM3TlU1UGVIa2JBMXQ5UllwMVNVb0FyWExlam41NTBadVVtWE5W?=
 =?utf-8?B?VVRORG9vUlhmbGlwM00xTVFjNjhjTWxGK0s3Kzc2S2NROTJSN3FrMFVhS01u?=
 =?utf-8?Q?l1raGG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SG1nbmpBZVJNc0dwQzhlb3IwSTl0VGJLVlgrQml3ZTRVQTFmSHJ4ak1uWnFD?=
 =?utf-8?B?TjZxVWxXWUllclFwcjN0QnZnZWlZWC9MNHJTWFZaYjFINDdqVllOV242ZFVa?=
 =?utf-8?B?S3JHZWRxVXJwSllyWnNQZVVBc1FxWTlPT2FRaVhRSURUcFpsMlJYWlNMQzJP?=
 =?utf-8?B?NTVzNnNmcHdrTTBMaHJRU2N0V2N5Z0hHSDVxMlNpRFoyMVdmRHZyZis3SFlx?=
 =?utf-8?B?bjErbUhaelEzekpMejJzUVBTbkVrWk5MaTJoZ1BCY0F1VjJ5VExpTVpvY2xl?=
 =?utf-8?B?WXVMbnFFMS9KKzlnR1NkbjRsWHlpUWdmNCsyM2wzODIxWUFwaHV4aFFzWTVZ?=
 =?utf-8?B?WUpZdDRSOTY1UzZvWk0rOStybjBVbS9VZytQaXZEdjdjektldWY2bTBCUWxo?=
 =?utf-8?B?czFZaHN6VlgyUUczenJHRGttNVVjamczS2hORlhETjNCclJpbDdwOUJISEx3?=
 =?utf-8?B?cEhOaWJkZk1wRmF4NUQ3ZUthSXE4Snphbk1Pb0E2UXlDRWtmdlVjTzllQWh2?=
 =?utf-8?B?MjhTSlRaT3ZxOTRkU2tKN3FGbitEWUJpbjlzRTV5WFF3Qkt5UDZUMmhlY2J4?=
 =?utf-8?B?Z1U1YmltTCtzU2VtVDJDdFJ5eDFCN01uc3JLVGFoaDJPbGZTQjg1YmIwWTds?=
 =?utf-8?B?bC9FSHQrck1BZGVWUEZMWEY2Rm1lVk1LMUEyaHQrSSsxYjI0aEp1MVJSZTY1?=
 =?utf-8?B?dHFBTllSZDVhdWdQR1h6U0Y4V0ZSTDhLRFhKYm1IVFhZQXJ3ZGl3NnRXZmtQ?=
 =?utf-8?B?MXVFbk1zWVpUNHJJaTU5NVY3dS9GWWdXbG5IZzdITGVTWFlQK2I5aHNDWmt1?=
 =?utf-8?B?eTZXOStJOXVvTVVVdzhpaDYzMUlqeFpMV1ZselkrenU2ZkN4WDRGNGo4NWtO?=
 =?utf-8?B?aXNoL0hndXF4c1c4N2N4VmhoNzVVb0xmZHJEeW00bEpmaURTYXRvU0w0ckJ2?=
 =?utf-8?B?VzBvZFJ2UVhUc2h1NktqM1QxR1ZLRkUzVkJNbnVNYStxWVVvbkVYYmZON3NQ?=
 =?utf-8?B?ZEo3L3RkekhrZVYwR3ZoazBRclFuK2NBbjRQdzhWQVFjTVF1SWQzQWVkNXkx?=
 =?utf-8?B?YU11UXo2SDNYKy9ya3ZRT0JSSldob2hWRVpyelBmU1R1WHk0VUg3VXQ2VzlP?=
 =?utf-8?B?UFR1NEVHd0Joci9kVWM5cHhMb3RLTGhUU05NMTNsUk5xVHcwR0N4MXVnZEU4?=
 =?utf-8?B?dWFRUUNGSFpJYXFXNENEQXFQUnBXWjY3djZSdGhWWHlSK0tFbkFxdnkrMTJF?=
 =?utf-8?B?aWNlQVZPWmxRbFlWVUsveW1Od25WdzFPcCtvSitVY3VZZmpjTngzY2JnRnR5?=
 =?utf-8?B?TTZKNVBkNWY3V0hqWG9nbkpXTDFIWEFRTm9mUXoyTTFOaVVKTFkwVnVad3A5?=
 =?utf-8?B?VWFiUG4vaDE4d2EzRVc5VWhpODRzNnREQklpZ0xMU0luSVVReEtMMUVUN2lV?=
 =?utf-8?B?N3c5WjRrV2dONDduMkZwRHc2OVJ0VDJYd3Fjc2pDRjZXZHAvY21IS01WWEkz?=
 =?utf-8?B?UGV1d3lVV05sMHFpSVhvK2RGdTN1TitCU0NtNmN0OHluT0M0M3diaFpPVVJD?=
 =?utf-8?B?ZU5MaGE0aUZVYUhIMU5uT3hHYXBJQWNwcVYrZmRXWnR1ZG40ZzlHVVlqMk5o?=
 =?utf-8?B?N0dYV2JGTmRxSDcxaFd1RFI1ZnJxNlI0RGMyYVphSnIrLzhRbENJS3ZiajhN?=
 =?utf-8?B?QW5jZFYzbnRkVk4ydjlQRG5mNHJnNU1Dc3JKeXVvMnJraFJVZ3NlYjZtQTVQ?=
 =?utf-8?B?V0kzMUhCRFVKSHFtY0RqM1UxS3FnbVpBbi96NERReHJFT3kveE54eEE3dEZF?=
 =?utf-8?B?d01KV0kvWmNQMmpQbUY0WXBIdFZOTnFmSzhlekpJaWh0c3NuT2NOQUpxT1lu?=
 =?utf-8?B?Q3B2bHhvT1N0MnpJWUxxdE5vZmJlZ1RPaHVzNVEzdHg2c29Jd3RRV1M2Wi9Z?=
 =?utf-8?B?U3JyVVNQS2ZLUktoUG1lWmdVazNUQURnTHJpT1hxbGFwNmZ1U2NReTVnMnh1?=
 =?utf-8?B?NFJKbnlreTIyRE1MNnRxaEM1alNLMzRuSno5M05tYUJrRm9kQzMrN1E0amZV?=
 =?utf-8?B?MlUvUnV4ZktNQmJVVVFXeXhZbVNMTFFselV1b2QvbTJ4YmNTN0tTVTV0aGVY?=
 =?utf-8?Q?VFcI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d2c79c-7bee-49d6-28ac-08ddff5091ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 12:06:06.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLodGI9A57ydEHGIj/FMx8mAXkVN3BtJ8Y/BYDI8y9GXqRXXCDtirB3smLUjudTuFsgeWIrUuDQsPBJc/h1HSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11700

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNV0gcG1kb21haW46IGNvcmU6IEludHJvZHVjZQ0K
PiBkZXZpY2Vfc2V0X291dF9iYW5kX3dha2V1cCBhbmQgdXNlIGl0IGluIHVzYg0KPiA+DQo+ID4g
U29ycnkgZm9yIGFuIGVhcmx5IHBpbmcuIEkgc2VlIHY2LjE3IGlzIHJlbGVhc2VkLiBKdXN0IHdh
bnQgdG8ga25vdw0KPiA+IHdoZXRoZXIgeW91IHdvdWxkIHBpY2sgdGhpcyB1cCBmb3IgNi4xOC4N
Cj4gDQo+IElmIHdlIGhhdmUgaGFkIGFub3RoZXIgd2VlaywgdGhlbiB2Ni4xOCBzaG91bGQgaGF2
ZSB3b3JrZWQuIFRoYXQNCj4gc2FpZCwgSSBwbGFuIHRvIHF1ZXVlIHRoaXMgZm9yIHY2LjE5IGFz
IHNvb24gYXMgd2UgaGF2ZSB2Ni4xOC1yYzEuDQoNClRoYW5rcyBmb3IgbGV0dGluZyBtZSBrbm93
LiBBcHByZWNpYXRlIHlvdXIgaGVscC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gS2luZCBy
ZWdhcmRzDQo+IFVmZmUNCg==

