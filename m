Return-Path: <linux-pm+bounces-15361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8499594F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 23:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055C61F243FF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A98213ED0;
	Tue,  8 Oct 2024 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="h89S6ZuR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N8UWxElR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IKt4/GfJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA42AEFE;
	Tue,  8 Oct 2024 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423399; cv=fail; b=VYEo//jreJrpXkAGmnLCAWObQC4aNFrl0K+8UT8+/kSzGaLwxW19QDmgudeoxhnoxdHv3Ty9H6rkKQYx62O0eSRQ6VtUDNzWtXYLEY5yUHI64C8Q69zsNYuqSrLOY/tJHfh7hmaA3qverpH6Jmk6G+4KsadpUQ/JsR2rQaokze4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423399; c=relaxed/simple;
	bh=gJ7gMkwtTD1iEJvYJBFFwvZ2UfHI3xi5l38uOFAKUVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i6Duhsn6BYOZsqqUbP094LVa7gFB3NKoGr6exa4FjQUrcvEcJwR6yMA4L5gOIgeUeoJpqrMf75WK/iXM4QYVnUOp24x0QB3WPmxAyFmrG6Ii2JyeciubtM+PujpkPeryWzd38qXLsV7MwqCH2MqwsoJ7+6T8QWJO7WBX5pgDvkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=h89S6ZuR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N8UWxElR; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IKt4/GfJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498HQWPS008724;
	Tue, 8 Oct 2024 13:53:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=gJ7gMkwtTD1iEJvYJBFFwvZ2UfHI3xi5l38uOFAKUVo=; b=
	h89S6ZuRXCDworSfkYWd0QqMk1uNAl757lk6navqQw1rxr3CzfgpioOaWDtYI38N
	i4WsNAJErco1Mmx3mdl9P4Sa7a252t6ENdM5kWus3ybbk0kc6ATk7nCSUEp6n5AZ
	xotXzjmqxZe/18EDbPE3l9mXI85pmHI4ttyesICyXqAdF+F482+wrJo5zHZ6uYfF
	v+1uPCopDlvZDoQqdeDRfBm5bb3UHy/m1wZM74sCbyYvadbWE1gyzBS4zDeq/57d
	22yfycic5PdLQXML+H/PqUH46SH0Z5ZWYuDHmYYI16m660KIJ7nYO0u0ojqNfU5f
	o3oO3KDfe25SKDdqmv7MlA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4234q7st3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1728420811; bh=gJ7gMkwtTD1iEJvYJBFFwvZ2UfHI3xi5l38uOFAKUVo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N8UWxElRkXfDIE0nwf31whKLoMPk3KeVnhtOw2Ywo25UZijM7GN32IDAkA3zn+wKT
	 7ZAs9FuCSzcxKwceBCa6mQX9oMc2vmxQ6TQR9HknF5TSwpC/8T2ImIauQpEsrb7/bg
	 pFSoD/c9qQer/DpLHh+72wqQYjE9y+pGxGbRnY9XQB3hqNoabKZZLuQkXEm3dt6YMX
	 xJeJqOSsewhtRQ6TBSylgXS72Acf4uqekINFeLxL5et5OFjv6ccBVRHlh75sn/jE9y
	 N49N+36bAbTrs53O818mwO8AM1jsfPpXeOnVZhzWkCGVC6iTGRhwKEb7EhKpZ+7q8m
	 AKo4n/E30I6dA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 53E6440174;
	Tue,  8 Oct 2024 20:53:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7AED7A007F;
	Tue,  8 Oct 2024 20:53:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IKt4/GfJ;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 15FA94052B;
	Tue,  8 Oct 2024 20:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBBy//vRCdzvUzrJpZuL2PjzLVy1wAgQrdearGaEDbC/4YHiptDZkdWVCn6WrJAGqFuPFw7S8ZRzhuxcTlwEP7E6eshgU4vdM2EnC91NP2cBcJO7LLbLOaGfFHEcymGVkwsY/mgh6moEYrescE2EFnArFe4KDuDnS5wogaLB55NhJo8JuvtmqBs/MkX4tXyS4Hh6kwrK5WvQet8O1zXYhDY3rk1pGcFtOLityJOKEEZmmHR65mGbMjVZuvhakZA6PUJcrSBjzSZHJGS8Zbac0xR94xugmgfuf2wR6EJxS5zemBelmnLbZs9aEBRZGpG6B0WICD61nHLGiiPdfxeKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJ7gMkwtTD1iEJvYJBFFwvZ2UfHI3xi5l38uOFAKUVo=;
 b=Xh3CKxsWeo29xVwYWVtahKxHfTKV0l4+DTJcOkjdzEOQweMhVHP4EAzLEYb18NWbdx6OGt/swr4SdadhSmQ28tz4BGsT9/rZYY2wAQ7xKYMvMuK6wtS0bZNdJUb9CuB8I30otvAnZcPbwowZe83InB8ZG21q9z857pvknsa7dF3tv1Ac45rDXABtssiJD+z5ksDb8HW89KuJo9M1PjpN3n+yhpmoetCmVxiJY3HuVuG/RZq3ow/ygcSIo2gQHieGnzproAR4waw8+T2AhSL9HhAg/NaoLRYsEJxbwGd3XLBgVsvbeONfjtCS4DmYhdxgRLWiJIcTZpm8HexIxzAULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJ7gMkwtTD1iEJvYJBFFwvZ2UfHI3xi5l38uOFAKUVo=;
 b=IKt4/GfJJRvub7Bvq+FbQkf6tJRW9tpHVAGGXLykw4xoQfddhbtp+X9K/UUx+8pQPhGkUjx2XF/XU2Mi5B/OVBIMsYftN8LSQ4ULIN8k+SYqLKVN0bH9RUWKuQfvUy7bvZKCdts8ISUn8NKVbxzRDrbWiyr6IoSO8O2sNKh2YEM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 20:53:17 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 20:53:17 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Vishal Mahaveer <vishalm@ti.com>,
        "msp@baylibre.com" <msp@baylibre.com>, "srk@ti.com" <srk@ti.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: core: Fix system suspend on TI AM62 platforms
Thread-Topic: [PATCH] usb: dwc3: core: Fix system suspend on TI AM62 platforms
Thread-Index: AQHbFBRY6VSHdoFJ0UqFUesMTA9ATLJ3XL2AgAWmBgCAAF1EgA==
Date: Tue, 8 Oct 2024 20:53:17 +0000
Message-ID: <20241008205315.64cxff22uckoich5@synopsys.com>
References: <20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org>
 <20241005010355.zyb54bbqjmpdjnce@synopsys.com>
 <85f1805b-e4c8-48c4-8e99-c36d20182a13@kernel.org>
In-Reply-To: <85f1805b-e4c8-48c4-8e99-c36d20182a13@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4111:EE_
x-ms-office365-filtering-correlation-id: c49c3b1b-c654-4ce4-84b9-08dce7db3c17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bElvUXM2NU9tUGVUWVR5YmR6ZXpkMSttMHRteElROUcxd1E0cUMxb1hKODhF?=
 =?utf-8?B?c3hzNTRLNkxTRmhEZ2ptRGxWVm95dE50TklHZDY3YTZGMllDbVJuV0NBdjBI?=
 =?utf-8?B?ZzczZWFMRXlDb3M0ZThCam9WSU9QaG5zSHVhdk5GcWJCVGJEeEpBS2Ixdkhl?=
 =?utf-8?B?d2tKbzdlR0JJd04wL3B4UzRSalBwQjZjL1RYZjhOa3VoQVVVZ2orNUdmYVBH?=
 =?utf-8?B?YVN4emxKbXhua1RMSldPc2FOclE1Vjg5WlJLU3cwazFmRVl6OHdwbGxRa3U3?=
 =?utf-8?B?cDAweGErdDN4L2lmK3ZFcWNQUFdwSmdhbXhyemVrYmNqN05rSHBXT1ZtRTBF?=
 =?utf-8?B?RThqUVNNUVFBVWVLWlJiZVRsekVBdnFiR0xhaWlYTnhEa0JnRjBnRDh5Tnk4?=
 =?utf-8?B?ei9VbTEzTVh4L1dDbmlvdkJ1UGRwakIydXNKWDlCSUxhaUpPR29pS3NZTnhh?=
 =?utf-8?B?bTlYR21RS0toUnNyVDQvNXlUTkhudFc1VWZFQkw3cURJSytHWW51dTRBeWVV?=
 =?utf-8?B?b2xQYWphK2Z6Zlp3bGZ4bUhQUjhNV0JXOWdWbi8yWnZ5RWp2RnRncGtQRjQ1?=
 =?utf-8?B?MzVqR2oyZVIyUitUeHpuQVBZbGs5dzhkTDdHR3h1V2wwOU15dFd5VDZVU1BF?=
 =?utf-8?B?cms4dVozNUZnNmd0RVFMS282TFN1ekkveTQ2U01zY2tiK1E3ZGlpVnlsZEI1?=
 =?utf-8?B?djFCQ09LS3ZGM0J6VkZjVGYzL1BBek05dHgyRlpmdy83bG9MVWdnbllIVEp5?=
 =?utf-8?B?YlpHQnFrTjduS25yNE5HKzZCWFk1Q3gzZXkrSFA5QmRUL01aSFZCaGxSNFhu?=
 =?utf-8?B?WG5MVUl3N0QrcTlDQ0sweUNSNmFxUzdjS3RMZy80bmVmKzlXdFZKczNhUDF6?=
 =?utf-8?B?VlM3NHB6dTYvUm04Rzl5Z3NTWXBBRWdjZnlmbWMxTXNFL0VCKzBmbnFGaFZF?=
 =?utf-8?B?ZWQxQ3h3N0VrK0thdGd0cGE3eWxkVENwVEtheDJoUDJyeUZCNlluZkdoSEpU?=
 =?utf-8?B?S3VJS3BjSkdST3RtOWxOUTh5NTkvSlVpVjNUM0VuRzJhY3BISzlzbW1oUTMz?=
 =?utf-8?B?SXphWlBaTmpsRHVwdkRvUTdJR3pweWhIeGdDTGE0cFRxMHRPTHozdUdyQWVj?=
 =?utf-8?B?R2IxOHpySWtkaklmNlVpN05Ba29ockZLdCsweUJpQjBpeE9LNmpPODBjaFl3?=
 =?utf-8?B?M1oyOHZVMkhHWGg0Y1Mxa2ZLdmh5U3FhVmlkaFBZU0pxOWRob3BDVXdZQlZr?=
 =?utf-8?B?YmpJNlpmYUFWV1U4UHE1b0Z5aVV0cGk3SFBIUFkxdm1YcTduL0ZwRTBpMUJJ?=
 =?utf-8?B?Yjl5K3FFeVhrR0NycFZSZ0piV3VWcTdKeWVPcWtBQTFHbFEyS0dOZzh4d1Bl?=
 =?utf-8?B?U0ljSlpFZjNnVDlCM0VUTGJEa2RqRW02Tm1LS2RMQWJDcFc4cVRvTHhnYnFV?=
 =?utf-8?B?RmlxWEI0b0o4LzNJYkZ6V0tWNVRNMm1IcDlNL0IvMUNkM3AyemNOT1l1SUxL?=
 =?utf-8?B?VStUQXdSRTNBdDdlWG51SEYyeVdBYTBNMlFSOW94QUFxT0tqUlZRVHc0dXlM?=
 =?utf-8?B?Z1FyazVxdUtNV2w2SXB3bU1oYUxOak1MTlZxMTJhdzNqTHcrbzR1bjdEZmIx?=
 =?utf-8?B?R2E0dGtTSlFIeHByYXpMSlZjSkp5bVBkWHZkNmJEWWJTUXdTWmRsclJaNzZw?=
 =?utf-8?B?ZEJLcm9HRmZ6U3haOCtuaEhTbTNuS2psZGVOUytLWUgrcjY3enV5RjN6alJW?=
 =?utf-8?B?UTFRcmwzWTNaOUtJK3p2RHFoS3ZTZkQxakcrc1dKVmtWUmVnT1ZuUHlqZjQx?=
 =?utf-8?B?MGdXb1ZrUDluN1FuMWNaUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTFRR1VLWThZTmQwQjNYb1BjbXZvR1B0VDdUY3lGK0U1V3Q2Z292ZkV5NWdh?=
 =?utf-8?B?Ryt3N1ZtWXAwSGZOVHpjVGhxUk1PdG9QVkFoeWdVazAvRnRGOFRobEhLclRM?=
 =?utf-8?B?ZUMwT1djWktwMms3bW5RZkkyUThyTXhPMUZrM0N1S25xRTQ4d2JDNmF5MHB0?=
 =?utf-8?B?UkN2UUZySkZxZGZmQkpkOEdNV1RYT3BGcFpST2twZlhYcDlNbnRndlZCZXpw?=
 =?utf-8?B?MERZQ2M3VWNWd1VUZmdWYld1SnRVRFlkbjYwL1VtTGpncit2aVFBRDR6WSt0?=
 =?utf-8?B?OUpxdEFoMkZCbTZTcUMxOTdUVyt2ZUI5VllvM2hMVkZidGpsakRNNEhudjNW?=
 =?utf-8?B?NktxT1JENW94RVVDeTlPYXlqN3B3Nnh5bndmOXZ3Zi9udjVmMW9yYTJJVHlH?=
 =?utf-8?B?NWRFSVdYYzJiQjdzMGVBVlJCckRpM0dKV2NYL0hickRKRlA0UTJhczgzdmJE?=
 =?utf-8?B?dlBIRDhOY0k5VCtOYm5YWHFiR01jdUVzanZXNndJTEp6K3dvdEc1VXpTOVZX?=
 =?utf-8?B?N3B0cUJFTmt3enpEODlvWnVDRklPYURrTTQ5a0FtRklQRjRMaDJIVHRZdGJh?=
 =?utf-8?B?NFdZekNZcWJhRjhlK3pwZ0FQNkJNeFZkRlpCSDM3bVIraFRwdXpHNkFHcFNB?=
 =?utf-8?B?Qnd5RzJOVThkRUNjenVZMldpQzBSVFVvMmcwN0JmNWkyTDd2Y1RvUHNSeEdn?=
 =?utf-8?B?VzhnMGdjcngyOWMxUUt1WnE1MmR2cHJYT0UrQVRqeStLeUdaeXN6U0hrajU2?=
 =?utf-8?B?VlIyNjBJS1FNa3Q4M29ySkpCcTI2MkhMTEUzTmFGVE9lNVc2UzNZMXlMcURJ?=
 =?utf-8?B?T1hlUFhrUXJCeWJoTmRUeEhGQ3dHRDlzQnVMdXhqWVJQMDZDN1F5VHZFOVNv?=
 =?utf-8?B?NmUvWFFOcmRFRUtHaS9jTlVmUWZNaU1aMjVmSUpsSUVnTG1YUTJRTEFtSzhY?=
 =?utf-8?B?WDdSZ3dmMVlqN05xNXh0OXdlU09tT1BZTnFncGEvRWpSS2dpVTFENW5uQzkw?=
 =?utf-8?B?RUljYm9XMjlDSC9jRHhuQlpKakRNS3Vac2dyd3FqQXBxazhTZHNGL3UrcTlj?=
 =?utf-8?B?RlNsbGtRNi9oZmtvNWtUTXQ4VURYa20xZXNnYVo4dXdjaVBXL2JTRUFFa3Nk?=
 =?utf-8?B?NjV5aFZpS2d2RjdGQllxYzl4cVowclozZmsyWHVpRWhhYzlidHh6QXRBV3Fu?=
 =?utf-8?B?Q3lCQ05ZYmZtVlFKUUdGS0l0dzVRQXhiOGZmQnpjRTVEVnpxYnorcUZtN1JQ?=
 =?utf-8?B?VWpMZzlqWkIwcUFCSmE4Q0RhdXYwU0NnSkJ3Q1hIZUZMS2dWaFBMVG0xbGdy?=
 =?utf-8?B?VTl2M2JHakNkL25VVVdlOXJjWVFhS1lMUEZFTzJaOWtKV3pldGJSS3NqV2xR?=
 =?utf-8?B?amFCKytMOEhYMzVHcTNqM1lHSWdQNW43VDd5ZWFXSW10SENlL0llVC9oTktQ?=
 =?utf-8?B?THNGOHhXRS9QMEh2RHc1L0YzQ1hKTzNTdXJJQTVTeHMwcGRXeENyZlcyVVpZ?=
 =?utf-8?B?YWc0OFdWc3RTVnZOYXovRVpBQWtGYTBWdExPZHdLVUtoRVI3Nlg1cFkweXhM?=
 =?utf-8?B?enpJQjhtd2hLMDcxcjFaeVVOTXVBUTdHRVQvb3NTdDFxaTlUSUdBd01ma1N4?=
 =?utf-8?B?czkxT2IwZi90WXk1cEgvV2pnSU9aZUtjOVJ6TzZTMW1oL1k3L2ZlS1VvaGF0?=
 =?utf-8?B?WFlvekM0M0FkTEY3TEpEMlZZbCtXa2ZaRStOdFQ2UkxJVTBFRUJXcHl2QXZP?=
 =?utf-8?B?N1QwbDY5ZEJyZ0hFSkJHZVJ6NGc4YjAxU3pLUDlxU1huY0pBL2RCYSsrUVlj?=
 =?utf-8?B?dzhiTjd0NVBqWEZrZXl4ZDBvK2Yzd3JmWW9iRFlxTEFVQ3prSnl4a2ltTGcy?=
 =?utf-8?B?dThvSk9zaFdEWFZ6RUsxcWJvb1ZtTVNiRVNHNkpXZlFzMWtCZTZlQWZkMnc1?=
 =?utf-8?B?MW9vc2d6aENzWVE3cmZ0SFlXQ2xKbko2Wjlhc3laYkdGN3QzMEp6Vno4dXE5?=
 =?utf-8?B?RS9leFFtZHJJb0ExdTlHTWVqYitwcVpYNW9FS3FJM2RKMW5ENTBocHpaWnRF?=
 =?utf-8?B?RVJtdVNsajJ4czNtTW9nRHFFS1NYWEdCVkcyR2ZVZi96NzRXUXBoeDIwMmJz?=
 =?utf-8?Q?3e1NidxNnhY+MUdgjcAeCOGgY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79382D718F940D419E15A5EE10B80481@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNzun3g1TDSSpYFgmyaZKvnWucfhDHdUsPFE6X+kgniPvbN36Nei0ZHWdf+0rVsHmRk9fqQOBa/0oBWg8hVX8ehPleIT77ejg3IU4KkZpFSPqO4WvUQJoAJlcuEF3xJjhoPYDopHiiGm+lAttiwIlq6zL//tiwnnUhq9/zGWzW8S2GD61z9CePh3rQj39Ds/SgDUPw23JCGc8xY1rLC5t2FDd2TAtJSrGU8By4w4oUvdzqYHEhSQYdYi9SWXUw25pfMZUogfBBmUGt/Z9Dr6FFNKl2Z1zUpyEXMazakISvUMaejf6eCSqjNsQ0DiIQdJUmZV+/TI2HXfcbCQva8UsNtLZnCpdFzjJ8aOibTNh2yfDiQdjSptYnKHZWyUscqPCO1K0GNOOR0QNMGPOJfgpsGV7zG9Y4nPKjYzwK6OkqN3tl1ne8v2nHB8zwbCjPddoKDUZeHq9SeYjcF5UHJng+jAkrafKAGZTz0Nn5WLR/7SCuRuory1t2BEmIlh0WmjoMyS2kNA22n3THL2ce0GUYEjQ7OaZCnmZR73oAMDGbbbaa4W6uDZSqnCkYhLgm1tBwJxThCVUlL+irUfY3iPCaPl134ENYtyLpb9SN0p4eacsy5np7kSkxJh9NoUmCEqQLxK3+dIKI+I2a+agnpPQA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49c3b1b-c654-4ce4-84b9-08dce7db3c17
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 20:53:17.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgmFO0/ScCQccyecCfy7C5Ep0wghaTRM/s3v82Jf1fd3fllbBWqN/2KUsP8hw1S7Ff4shG8ULrF6BPTnpJtNtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
X-Proofpoint-ORIG-GUID: Djwa-LZCP3vk3TcEksO1NRcWzSM4OpXw
X-Authority-Analysis: v=2.4 cv=IPVQCRvG c=1 sm=1 tr=0 ts=67059bcb cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=eiWDQrE85yRClu1fXaAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Djwa-LZCP3vk3TcEksO1NRcWzSM4OpXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080135

SGkgUm9nZXIsDQoNCk9uIFR1ZSwgT2N0IDA4LCAyMDI0LCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiBIaSBUaGluaCwNCj4gDQo+IE9uIDA1LzEwLzIwMjQgMDQ6MDQsIFRoaW5oIE5ndXllbiB3cm90
ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBPbiBUdWUsIE9jdCAwMSwgMjAyNCwgUm9nZXIgUXVhZHJv
cyB3cm90ZToNCj4gPj4gU2luY2UgY29tbWl0IDZkNzM1NzIyMDYzYSAoInVzYjogZHdjMzogY29y
ZTogUHJldmVudCBwaHkgc3VzcGVuZCBkdXJpbmcgaW5pdCIpLA0KPiA+PiBzeXN0ZW0gc3VzcGVu
ZCBpcyBicm9rZW4gb24gQU02MiBUSSBwbGF0Zm9ybXMuDQo+ID4+DQo+ID4+IEJlZm9yZSB0aGF0
IGNvbW1pdCwgYm90aCBEV0MzX0dVU0IzUElQRUNUTF9TVVNQSFkgYW5kIERXQzNfR1VTQjJQSFlD
RkdfU1VTUEhZDQo+ID4+IGJpdHMgKGhlbmNlIGZvcnRoIGNhbGxlZCAyIFNVU1BIWSBiaXRzKSB3
ZXJlIGJlaW5nIHNldCBkdXJpbmcgY29yZQ0KPiA+PiBpbml0aWFsaXphdGlvbiBhbmQgZXZlbiBk
dXJpbmcgY29yZSByZS1pbml0aWFsaXphdGlvbiBhZnRlciBhIHN5c3RlbQ0KPiA+PiBzdXNwZW5k
L3Jlc3VtZS4NCj4gPj4NCj4gPj4gVGhlc2UgYml0cyBhcmUgcmVxdWlyZWQgdG8gYmUgc2V0IGZv
ciBzeXN0ZW0gc3VzcGVuZC9yZXN1bWUgdG8gd29yayBjb3JyZWN0bHkNCj4gPj4gb24gQU02MiBw
bGF0Zm9ybXMuDQo+ID4+DQo+ID4+IFNpbmNlIHRoYXQgY29tbWl0LCB0aGUgMiBTVVNQSFkgYml0
cyBhcmUgbm90IHNldCBmb3IgREVWSUNFL09URyBtb2RlIGlmIGdhZGdldA0KPiA+PiBkcml2ZXIg
aXMgbm90IGxvYWRlZCBhbmQgc3RhcnRlZC4NCj4gPj4gRm9yIEhvc3QgbW9kZSwgdGhlIDIgU1VT
UEhZIGJpdHMgYXJlIHNldCBiZWZvcmUgdGhlIGZpcnN0IHN5c3RlbSBzdXNwZW5kIGJ1dA0KPiA+
PiBnZXQgY2xlYXJlZCBhdCBzeXN0ZW0gcmVzdW1lIGR1cmluZyBjb3JlIHJlLWluaXQgYW5kIGFy
ZSBuZXZlciBzZXQgYWdhaW4uDQo+ID4+DQo+ID4+IFRoaXMgcGF0Y2ggcmVzb3ZsZXMgdGhlc2Ug
dHdvIGlzc3VlcyBieSBlbnN1cmluZyB0aGUgMiBTVVNQSFkgYml0cyBhcmUgc2V0DQo+ID4+IGJl
Zm9yZSBzeXN0ZW0gc3VzcGVuZCBhbmQgcmVzdG9yZWQgdG8gdGhlIG9yaWdpbmFsIHN0YXRlIGR1
cmluZyBzeXN0ZW0gcmVzdW1lLg0KPiA+Pg0KPiA+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZyAjIHY2LjkrDQo+ID4+IEZpeGVzOiA2ZDczNTcyMjA2M2EgKCJ1c2I6IGR3YzM6IGNvcmU6IFBy
ZXZlbnQgcGh5IHN1c3BlbmQgZHVyaW5nIGluaXQiKQ0KPiA+PiBMaW5rOiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE1MTlkYmU3LTczYjYt
NGFmYy1iZmUzLTIzZjRmNzVkNzcyZkBrZXJuZWwub3JnL19fOyEhQTRGMlI5R19wZyFhaENobTRN
YUtkNlZHWXFibk00WDFfcFlfanFhdllEdjVIdlBGYm1pY0t1aHZGc0J3bEVGaTF4TzVpdEd1SG1m
amJSdVVTelJlSklTZjUtMWdYcHIkIA0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9z
IDxyb2dlcnFAa2VybmVsLm9yZz4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyB8IDE2ICsrKysrKysrKysrKysrKysNCj4gPj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5o
IHwgIDIgKysNCj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+Pg0K
PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiA+PiBpbmRleCA5ZWIwODVmMzU5Y2UuLjEyMzM5MjJkNGQ1NCAxMDA2NDQN
Cj4gPj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gPj4gQEAgLTIzMzYsNiArMjMzNiw5IEBAIHN0YXRpYyBpbnQgZHdj
M19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiA+
PiAgCXUzMiByZWc7DQo+ID4+ICAJaW50IGk7DQo+ID4+ICANCj4gPj4gKwlkd2MtPnN1c3BoeV9z
dGF0ZSA9ICEhKGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApKSAmDQo+
ID4+ICsJCQkgICAgRFdDM19HVVNCMlBIWUNGR19TVVNQSFkpOw0KPiA+PiArDQo+ID4+ICAJc3dp
dGNoIChkd2MtPmN1cnJlbnRfZHJfcm9sZSkgew0KPiA+PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENB
UF9ERVZJQ0U6DQo+ID4+ICAJCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+
ID4+IEBAIC0yMzg3LDYgKzIzOTAsMTEgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9u
KHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4+ICAJCWJyZWFrOw0KPiA+
PiAgCX0NCj4gPj4gIA0KPiA+PiArCWlmICghUE1TR19JU19BVVRPKG1zZykpIHsNCj4gPj4gKwkJ
aWYgKCFkd2MtPnN1c3BoeV9zdGF0ZSkNCj4gPj4gKwkJCWR3YzNfZW5hYmxlX3N1c3BoeShkd2Ms
IHRydWUpOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiAgCXJldHVybiAwOw0KPiA+PiAgfQ0KPiA+
PiAgDQo+ID4+IEBAIC0yNDU0LDYgKzI0NjIsMTQgQEAgc3RhdGljIGludCBkd2MzX3Jlc3VtZV9j
b21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPj4gIAkJYnJlYWs7
DQo+ID4+ICAJfQ0KPiA+PiAgDQo+ID4+ICsJaWYgKCFQTVNHX0lTX0FVVE8obXNnKSkgew0KPiA+
PiArCQkvKiBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKCkgZGlzYWJsZXMgU1VTUEhZIHNvIGp1
c3QgaGFuZGxlDQo+ID4+ICsJCSAqIHRoZSBlbmFibGUgY2FzZQ0KPiA+PiArCQkgKi8NCj4gPiAN
Cj4gPiBDYW4gd2Ugbm90ZSB0aGF0IHRoaXMgaXMgYSBwYXJ0aWN1bGFyIGJlaGF2aW9yIG5lZWRl
ZCBmb3IgQU02MiBoZXJlPw0KPiA+IEFuZCBjYW4gd2UgdXNlIHRoaXMgY29tbWVudCBzdHlsZToN
Cj4gDQo+IExvb2tpbmcgYXQgdGhpcyBhZ2FpbiwgdGhpcyBmaXggaXMgbm90IHNwZWNpZmljIHRv
IEFNNjIgYnV0IGZvciBhbGwgcGxhdGZvcm1zLg0KPiBlLmcuIGlmIEhvc3QgUm9sZSB3YXMgYWxy
ZWFkeSBzdGFydGVkIHdoZW4gZ29pbmcgdG8gc3lzdGVtIHN1c3BlbmQsIFNVU1BIWSBiaXRzDQo+
IHdlcmUgZW5hYmxlZCwgdGhlbiBhZnRlciBzeXN0ZW0gcmVzdW1lIFNVU1BIWSBiaXRzIGFyZSBj
bGVhcmVkIGF0IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUoKS4NCj4gDQo+IEhvc3Qgc3RvcC9z
dGFydCB3YXMgbm90IGNhbGxlZCBzbyBTVVNQSFkgYml0cyByZW1haW4gY2xlYXJlZC4gU28gaGVy
ZQ0KPiB3ZSBkZWFsIHdpdGggZW5hYmxpbmcgU1VTUEhZLg0KPiANCg0KSXQncyB0cnVlIHRoYXQg
d2UgaGF2ZSBhIGJ1ZyB3aGVyZSB0aGUgU1VTUEhZIGJpdHMgcmVtYWluIGRpc2FibGVkIGFmdGVy
DQpzdXNwZW5kLiBIb3dldmVyLCB0aGUgU1VTUEhZIGJpdHMgbmVlZGluZyB0byBiZSBzZXQgZHVy
aW5nIHN1c3BlbmQgaXMNCnVuaXF1ZSB0byBBTTYyLiBMZXQncyBhZGQgdGhpcyBub3RlIGluIHRo
ZSBkd2MzX3N1c3BlbmRfY29tbW9uKCkgY2hlY2suDQoNClRoYW5rcywNClRoaW5o

