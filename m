Return-Path: <linux-pm+bounces-15510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA269995D9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 01:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24D128487D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 23:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D081E6310;
	Thu, 10 Oct 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="oBFEO/Mx";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mAaJJ0La";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GTPjF/AI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED41E8859;
	Thu, 10 Oct 2024 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604559; cv=fail; b=i0lINGvzDtlsCKH5iEKDxKxP2WscpNB0ioVdy7sSEJW4K7efpB+SJfd5s8WfUr1GDhVBmXHjBN0BfFl4n01vMdd7dvo2ukyxRjQLiHIr2ZAhbKPlJIZnami/gdf06rt/fhf+qrxuIMgYJJyjajr6A2XYb2D+4gRSdt3fB9hgCpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604559; c=relaxed/simple;
	bh=62in/dwijN8rbVhhNQ+bw8GcZXNF1Q76bgnj4UEhv2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CcpeZ89+84hM4fVmU1X7+P12682a5/K7rKy4OVHLcNWJ72bM5ITrxchiZvoDjBCpB/cNzB0u/TW34o7/YbHRQcn6KuRz9omMmk5bQ3kCCK4vOSsGlK8nC9t1xBwxT7PcicF0YOhI+1WNcNickeQVCecTKdKqEl/u0jmW4HvcUIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=oBFEO/Mx; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mAaJJ0La; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GTPjF/AI reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ALWiXU020461;
	Thu, 10 Oct 2024 16:55:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=62in/dwijN8rbVhhNQ+bw8GcZXNF1Q76bgnj4UEhv2Y=; b=
	oBFEO/MxT4P+cdb5dMzrleCgK/YlnopArtUlhgov4YkPJBpLcGIeBlgNFV9DW5YU
	+dyF2KlL6/R66u7yf5bxZsKXSvD2acdCBp1PYJ5kzlkUWMUIX/qefP25/clynV1p
	j756FW2YxAryzLwMCfgXCpu2+4Lh3LXYzKImKqxGcVy7R5I9TJJebwyYtr/Min+Z
	InmK8oYD93/NO02WE+ap3vd7uFR4phreeOSzN0/qO/NC+i3Tf9uH8SDwxElPocQs
	kabOhyJ3DnHCfweEeIoX6CJGwtMY/pB8W+EYPKQ8OzvCTquJZbHea5zvkGiBTrMc
	VcZd/gwS3n7bh1VsF4h1xQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 426pxe8h0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1728604527; bh=62in/dwijN8rbVhhNQ+bw8GcZXNF1Q76bgnj4UEhv2Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mAaJJ0La5sNrXNXTRLqm1aKVIuvjTKoY2V3mCJu+ah9Vh6n1Qd5SFCS3y/+NKGjkK
	 lDGuQ1TKnMF8gZzkdoouxTuGeyAVrlC0DfAQJFEZF2clFW9Fi0HLe+3sogjwIcv11O
	 pQAAEmAlRycFJ3JLzpv4EIz12T8cQm+p28fN8ZtONrG9TzvbC2q91rfMikT13DmPcU
	 dsdtmG+i9ICi99UItLEbA9233wYCY8VsB5rv2eSegKWzUHzwAehOsQNLNLFu2mvbNY
	 rcJtDH4zl/fiCCU0yz1OrtuZt5gC2/ma9PI70K8x20VtINwnTCBDHOkHtQEiJ1uQ4W
	 lxD4bVJDfqWAw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8DB51404CF;
	Thu, 10 Oct 2024 23:55:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CB7B4A0060;
	Thu, 10 Oct 2024 23:55:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GTPjF/AI;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 040A540586;
	Thu, 10 Oct 2024 23:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayzxBvyVNYElofuTecBDiBq8MPQxYqnrUmBXySUjTdgEeHcXQ2Gg5twcBzWJjTHRAKt8CX254n7QGfFrDGyIQaSTDrohFEk1FTbrOVEk73W1YAYGBx+hyHvxUMl7A2+zqvTF9kcialv7Pfxyl0GBicGgP5fdWJ40kHp9UG36vXJ5yHVtfk6WQctUaKa6lB6wHkNuu/zpVBqd5lFn3Obg1t371h0JxIGOoIUTU2mfbT7l3yHPRPmeWhl1UZtAXnHrst/Gmw4ydE2voTEfdDZ/kBROs1V5EFWeGzyyHQqMXRcXdrtVO/HaSNm53wpEc8R+f71RUl/5h8/Bov/FHx7r4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62in/dwijN8rbVhhNQ+bw8GcZXNF1Q76bgnj4UEhv2Y=;
 b=ecjmqZTADg3jxCOFCXZbBGs0s8II1UVtxk6ymOg/siKx3vSG7465BgLjUNr3Cbz7M6exJXbqJnO0szSOeu5AoBueQxKu6TwgkX4qSS3GVpUOQE/m8ursnEurmU7/77+E1GwGNuztM9FNTibf376tMf9qxE9LDd//K/KWMCOUm5Y5eG3DfYh37+/5REUdJ4nHxpZdBu5jGufd/7lq2eh81ZPSSOypk0qbBUsFTAcRxHKBJl1RNKpsQyjBeUAXEq2jyJ0HTzudlpBYqvyIFyO13Ys6cb/x52qBXPTfx2BaFuyv5hQGmTybaK5+PQW8PNDZf+w+D/8gK4EO4xDyQ20K6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62in/dwijN8rbVhhNQ+bw8GcZXNF1Q76bgnj4UEhv2Y=;
 b=GTPjF/AIGhGvxzCNtO+TFRabClVylSnCXAXgH5SIh8TqvTq7zmRSS+nTQFekERtAaBE072+9ggRDjvLkPViOLEJR/9gCwY+agQlkoq0PqHub7KF6MlOuP7lL7e3o4/Y10FJTxeqTqF5ObcTmwKpB5zXsZ1ArJmGDvb1s85j4f2E=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 23:55:16 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 23:55:16 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Dhruva Gole <d-gole@ti.com>,
        Vishal Mahaveer <vishalm@ti.com>,
        "msp@baylibre.com" <msp@baylibre.com>, "srk@ti.com" <srk@ti.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
Thread-Topic: [PATCH v2] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
Thread-Index: AQHbGkrLu5Oz8j/jJEGUjgb8gJfUu7KAqw2A
Date: Thu, 10 Oct 2024 23:55:16 +0000
Message-ID: <20241010235501.pru7iylmmb736cnj@synopsys.com>
References: <20241009-am62-lpm-usb-v2-1-da26c0cd2b1e@kernel.org>
In-Reply-To: <20241009-am62-lpm-usb-v2-1-da26c0cd2b1e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB7118:EE_
x-ms-office365-filtering-correlation-id: da7de8d5-25a9-46cf-0a23-08dce986fd64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmZDekl6NVY3TFpMS2FXbWwxdzdjUUFQUWxuS2pKSGhJM3hDSWxneExIVXR5?=
 =?utf-8?B?ZUo2YUtXeVNkTjg5VWxFOWVOME1CM3Z6ZWVnUU5ZRnBCZDBIQmU4Ky82MTJt?=
 =?utf-8?B?dm84OG15MjIvWkhTYmZnemlxWThsYndMWS81R0FlUG1GMDY2QjhWaU9oN1BR?=
 =?utf-8?B?Slo4bVljZnBYdHdyWWFDaUZTMVpiV2h0WStVTmp6QUlJZHpXWFZLR2FOVCtZ?=
 =?utf-8?B?bFcvSXJHYUNzMlRNZXpieWZQZVp6SENaNFMxSk9tcEpjc0xXQkdxSE85MjZo?=
 =?utf-8?B?N1BRWWJhL01ERGVvekFLc0E4UzVueGZlM3Z3RU9QaFN0ZUFoVVR2RG1jN29V?=
 =?utf-8?B?ODJYR090MTY5ME9vRGxTRFViMGN1S0U5M21QYjNGM0pZNmRQMWJWUDZVck9h?=
 =?utf-8?B?S2Q0a0dENGhXbzRjcE1uQktXc01UOUJKWW10N1J4elQ5Q2NDQnZmSGE2ZTNt?=
 =?utf-8?B?ZnFoRG9BeXo4djhmUXlSWWNPR3VOY2YyWUdrc2JpQ1Jua2NCOUF2ZzVpMHB2?=
 =?utf-8?B?a245MG5iSVNvc0NDMTFiTlQxWTFSa0lMenZCci9DaVQyUmhOSzhRdFpDMkxr?=
 =?utf-8?B?QkNwMTE5RGEzdkk5VGYzWGE5c2NuaHFtSVRrMTJsd3pUdVRCbFN0NEF1Rm9S?=
 =?utf-8?B?NTloem9Tbld0Wm9GL3pXbFVDQWtyNDl6b3p4dTZZNElqdFNBeVdFbkJIZzZl?=
 =?utf-8?B?YUFJYlA4KzQybUhiMEZXd2lEb253ME5jbVlqOFNrTGJra3RQU2dVd1dEWGxs?=
 =?utf-8?B?V1EwVlJ6em1VQ2VSMFM4U015WldCQVBadVdHZUg3UHJLQ3BrMkVXNlM0dUpm?=
 =?utf-8?B?U2FPMkN2ZVVTYlpCdGlyaUs1anYxTm1vYkVnMGxLckRseW5TSDVFdFZQaXpX?=
 =?utf-8?B?c1RmTW5uZ0hScG5UWGdVVFhURksxamIzM2VGNk02dTVFUllSdlpQUE02eDE5?=
 =?utf-8?B?dzM5UE82S2lDOUIxT1Vhdlg0QVBBbk55ZmQydFJhTVU3bzNQQUpvSkVTRnN4?=
 =?utf-8?B?a01kQlE5cnhiV2FBa1J3NFF6TWFHYThpNDRrQXEwUzBlRCt0Y2JiZWFKVXVp?=
 =?utf-8?B?cXJ6RTVUQXJyQnprN1JXdnplVE44d1FESHBYRkdPeldzYWhjdGhkazk5bVpr?=
 =?utf-8?B?QkQ4YVFVWjZiTFlFbkR1TWhZS0tDWjgwc1I0cW1FeWZOVGZwYjhXcnR6a0Ey?=
 =?utf-8?B?bjFVMzFqV1FSWUprVEo1cHNZT0VLaUVmbzJZSDJCdDhLSFJ4ZnoreUIrVUJ4?=
 =?utf-8?B?a2lKQWhlMy9EMTBPREdTejIzbkprWFdlN3FWaHhwSUkzRlhuamxqZ3ljb09s?=
 =?utf-8?B?Yjc0MjVrUDZyTEZQRWpjOFZBcllETGpvcXJ2bThraGU2clJJUXl5RWZmWm5s?=
 =?utf-8?B?QVQxZGF4ZHBsb0M1S1BETTVRSUVoY3lDYXhpUjR3VGlHMmx4VzJMRTFEcFN5?=
 =?utf-8?B?VjdUM0wxb1AxNDFHMjFDbVdNZXRJS0NoWkZqSG40VXZWNmVsN1ozYTNEY2Uz?=
 =?utf-8?B?MjV5aWFsUGpTWkpJcEFMdHZRQkQ1QkVKb25adXpvS014bW1jZkVHQ3JWZmhS?=
 =?utf-8?B?MDBkU1pRZWdCclk1c2xVQUsybFRzRUFXK1huY0s0ZjdJQXJGbzNuZUhMeUZH?=
 =?utf-8?B?TUh4ZVFMMmhIYlZuSk9UQkZadXpYYWVucTFHc2pZWGhsaGg0OXRmeGxHVHVL?=
 =?utf-8?B?Q2J6RjFMRW94YUgvM3lsNlBSVW1zSDUwbDZKUllkQzVUOE91NGtyeGV0YkFP?=
 =?utf-8?B?SFV5YktZMDVMemdNZ3N0ZVVqc2hNd1BHR3pGdFhxSjFpUW5HMUFpUzhUN3Jq?=
 =?utf-8?B?NG9uWmRZa25rU2hHUXlNZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVpCWVZWU1I4bHlVMFhiOUQ2UHBGNmNndE1vUnRkdVlGVk9QS3gyck42ZXps?=
 =?utf-8?B?ZkxBc083WVZDSUVPdXhMSC9zaThEWE1xc0ozbmV3T1BTSkcraU5mSVg5eXk1?=
 =?utf-8?B?dXNjQ0lVSWhEODA2VWpIT1orV0kyZDY4NWlOSVlHTThiRi9EOXBKTGJNRkxU?=
 =?utf-8?B?M0dLVTZDNlJFMzBDTDZvMUVuTUdxbWtKNE11eklEcUhxL2xjdTV6K1BhUEFi?=
 =?utf-8?B?WHBVNVQ4MlJ5TS9TQ2doZ3Vld0YyTWNWUzI0MCsxTDZEL2xTdnFUUmtXRm41?=
 =?utf-8?B?bE9oRndiYnhMU0VtSzJ3N0RJSWFtQTJjK0FPVWVMczdiOUVsV05GalRHUXU0?=
 =?utf-8?B?M2IyTWhrOWJlZDZQQ1BERW44T1pMTTRSQ2Z4QXJWb1h0YjNRbmVKZVRJcFlz?=
 =?utf-8?B?VU9DUEdUVDEzL1QzMDNvdms5K3F0MjdpaU5sTVFPYzE2Ly9PRkhxMU9LNkVF?=
 =?utf-8?B?ZGNoblRWZktnRG1iWjJUNWV5UndwSDZXZkRYcVRSbVRmcXIvMUdpbzZlc0Jk?=
 =?utf-8?B?MXk2bm5SalRLMzVFeEtGQ0NyNXl0UkIzRE5KcFZqTVRIQk5uUEZsTVQ3NXBW?=
 =?utf-8?B?ZHg0UURPalY3bDVnSWt0ZHFkalZydlJqMyt3R2QvTUtoR1VaQWRLeXRRVys3?=
 =?utf-8?B?YnJJdUpJTy8vNWJSQjZvUGVnbzQrS1RQV0VyUGo3Tit6Si9QR3JOZFdYQkp0?=
 =?utf-8?B?NUNrMnBBWUlRZG5rUFhxa2NNaG9HaUY2d08yRWh1c2JsL2kwMWVMZUV5Qmp6?=
 =?utf-8?B?Q2dOUTYxbUZLNXlrNHpoKzREZGo4VVpWd0tkVVBpUExBdUIvZjU5QzJrMHN6?=
 =?utf-8?B?VVVjR3VPaW1qL2ZUbllqb3lQN3ZGNE9uMTdPY2g1R2FJUTgwSHhwUVBPMjBS?=
 =?utf-8?B?UlNGQ3JnZGxzOVlRMGlZTitzcFlNb0tFUGd4dG44dTZiSXBaZ1M0U2xKdTVX?=
 =?utf-8?B?cjlmRHFSNkRGdWsvclplV0JMVG85TmVGUC9wRzZQWHNoY0NCYXQ4cGN1bUZ3?=
 =?utf-8?B?c2pWOVR4RVZ3U0gxT2xGVjFVeU56ZjlISnY2WitCYVk5c1VkYktqcStRalls?=
 =?utf-8?B?SUYwRjNKU0tzM2FMMGtpcXZFREZ6Q3dmbWp4RVFRME5hZUM3NjA3bkp3R0ti?=
 =?utf-8?B?NE80OU9kWE5UK3l4QVBjV20zVGdUT2JlZmlQdzF0SkFjZlBCSmxkN3FUYUw4?=
 =?utf-8?B?UnZrcGFMcWpPZ1cyaGZmeDFjWjF6dFRDWkl3QVN5bmgwQnhFVS9ob2dGVjdX?=
 =?utf-8?B?b2F5eVU2Y2hjOXk2aWdwTThKU2sya1J4ZG5hVHZzU0Y0UEw4VnA5MW1NR1pt?=
 =?utf-8?B?RHVKUVBtZWpXbkFveEl3a25sSitkb1Z4R0dQYVRaUXRRWGhHVTFVYkhnZWNR?=
 =?utf-8?B?eDcyR2xEWmV0eFpnaUI2S1lseEFlV2Q4OEhiRUpIMHk4NHhrTkZRZ2J4Nk82?=
 =?utf-8?B?b3JxaHBkcjRDRVR5TnQ1SmJSYkJIUGhlcjJRWG9Cd09EM29pSUZSa1B5cnd3?=
 =?utf-8?B?UnBkYlRib3Y2K1VyVk1LSkc4NkxmNFlNdGRzV1BIc2JlK1B5akE3TExLTnhP?=
 =?utf-8?B?L1hoa0dLUVBnR2d5b01jZDNYci8xd2xGL0lzL3ZDRlZ3dFo0VEtCMmk3M2pu?=
 =?utf-8?B?cDFIU1ljM0lwVC9Jako1TGhLZm0wZ0o0UERtakVNbTFYalRmMmNoY0tiVEJL?=
 =?utf-8?B?a01FSlB0amVsRlgrUnBmWEZuMGNPdnp3Z3J2SERQdGVTQmUwSVFxNEJTYWFh?=
 =?utf-8?B?VG52WGRuWXp3NzliMzQ0UXI5eUdDYVVxYUZSRTlhUzFQc1BHL0hjUUNZc3VX?=
 =?utf-8?B?VW93RklaWlBKcVRoMWRpejNleENTemRpRnJlMkd4QVdTZlZBTUtVL1QzWlph?=
 =?utf-8?B?aUhKNlk3WVpCblgxZFE5T084Qlphckk5ZDFKUyt4bmxKYjJ1YlA0TzRwbWJX?=
 =?utf-8?B?bWNCbWVaYXQ3R1d4a1BRdVcrVkRBdVFHYVp3NTR5RXFCbTRmaWFYOC94Rito?=
 =?utf-8?B?Q1VRVUtQQ2JTaVo0aTFGSWxuTlQzZ2JDV0lzeG51WUU0N09adExRV2VyZnNk?=
 =?utf-8?B?ZHYvSWtPMVNhMnZXZlVlZEM1bGVYVklvb3pDRjVQY1hzQXFVeWo1Y3lydFdG?=
 =?utf-8?Q?9EmzK02k8W6fwW5dWXPay+qf3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C63CD511B9E9354FA2E23856416D1351@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	un51o3mizSP2vW/alBPoW7VGdI0ZD3yLMNgSsPoHNJ0wWPJANBkobthhOldgwIM9zHpjVFCPFQwY8yBsNs9SboBQUte8sE1CwEYZJmlMaeTobbcv6ajlXCqywkeMpweKzVPUm/jS8mCqmyJP+PNIfN1ikK8eA07H+wOKnV9ceki9oWFaDN3D2TWjkkTlrh0Biu05X/v1gYLQRXu2WhsO2bS0f+sFqKlfHDaa2JhtlEgUcJNXEsQUbYMpGfDYV4fD/z1HnFOZQiJhw85SO976N9Q4qcSM+xJmAXyJITMojcP9xiOwTT9BmgfKo26bGwj6rJLjj3f2rSfdti/edVmRHP5Cn1eyw/EtI3sZ2C5Dd4acZ+0xmiOuE1JMYS3BP6huLYmpJAk9x6ADeu8xgvM3Z+0YjLEVTdfCrIxt7Ha5NNB0JDsg+f20ZZZR8yVkAoAHs4r8QfXhjImN9yXBI5n4FIRqUS2wBm+60WO0zieUYCnn9QxZ9prwrtrmt84/G4/aDsxng0jshTp9LRbFTNqkwV2BoWFQ3o8DT4XiVFvr6tkc3Xe0yUkkC4oymbDW4dornAtFvRkcv459UWPcAfUAWVwzbEOnTzlfqT2uMW0vTmI8K7EiH6DVCE/+hRVK3W3k7pu8g8My3PA+4XV/sAmiHw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7de8d5-25a9-46cf-0a23-08dce986fd64
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 23:55:16.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o39qtKlvTX4Ugeo88Ilo1Cng3glVxT+BzzBGx+pQt0daeB15Hs7Pu9E2CiwEZGu5D6uG2Q9AteyDoAXQACy2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
X-Proofpoint-ORIG-GUID: CVgodzvdZbMjfTv_rZIIW5Fa8nhmWV6m
X-Authority-Analysis: v=2.4 cv=FMlJxPos c=1 sm=1 tr=0 ts=6708696f cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=RmNkgoCxZe7Arfu8SyEA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: CVgodzvdZbMjfTv_rZIIW5Fa8nhmWV6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 phishscore=0 impostorscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100158

T24gV2VkLCBPY3QgMDksIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IFNpbmNlIGNvbW1p
dCA2ZDczNTcyMjA2M2EgKCJ1c2I6IGR3YzM6IGNvcmU6IFByZXZlbnQgcGh5IHN1c3BlbmQgZHVy
aW5nIGluaXQiKSwNCj4gc3lzdGVtIHN1c3BlbmQgaXMgYnJva2VuIG9uIEFNNjIgVEkgcGxhdGZv
cm1zLg0KPiANCj4gQmVmb3JlIHRoYXQgY29tbWl0LCBib3RoIERXQzNfR1VTQjNQSVBFQ1RMX1NV
U1BIWSBhbmQgRFdDM19HVVNCMlBIWUNGR19TVVNQSFkNCj4gYml0cyAoaGVuY2UgZm9ydGggY2Fs
bGVkIDIgU1VTUEhZIGJpdHMpIHdlcmUgYmVpbmcgc2V0IGR1cmluZyBjb3JlDQo+IGluaXRpYWxp
emF0aW9uIGFuZCBldmVuIGR1cmluZyBjb3JlIHJlLWluaXRpYWxpemF0aW9uIGFmdGVyIGEgc3lz
dGVtDQo+IHN1c3BlbmQvcmVzdW1lLg0KPiANCj4gVGhlc2UgYml0cyBhcmUgcmVxdWlyZWQgdG8g
YmUgc2V0IGZvciBzeXN0ZW0gc3VzcGVuZC9yZXN1bWUgdG8gd29yayBjb3JyZWN0bHkNCj4gb24g
QU02MiBwbGF0Zm9ybXMuDQo+IA0KPiBTaW5jZSB0aGF0IGNvbW1pdCwgdGhlIDIgU1VTUEhZIGJp
dHMgYXJlIG5vdCBzZXQgZm9yIERFVklDRS9PVEcgbW9kZSBpZiBnYWRnZXQNCj4gZHJpdmVyIGlz
IG5vdCBsb2FkZWQgYW5kIHN0YXJ0ZWQuDQo+IEZvciBIb3N0IG1vZGUsIHRoZSAyIFNVU1BIWSBi
aXRzIGFyZSBzZXQgYmVmb3JlIHRoZSBmaXJzdCBzeXN0ZW0gc3VzcGVuZCBidXQNCj4gZ2V0IGNs
ZWFyZWQgYXQgc3lzdGVtIHJlc3VtZSBkdXJpbmcgY29yZSByZS1pbml0IGFuZCBhcmUgbmV2ZXIg
c2V0IGFnYWluLg0KPiANCj4gVGhpcyBwYXRjaCByZXNvdmxlcyB0aGVzZSB0d28gaXNzdWVzIGJ5
IGVuc3VyaW5nIHRoZSAyIFNVU1BIWSBiaXRzIGFyZSBzZXQNCj4gYmVmb3JlIHN5c3RlbSBzdXNw
ZW5kIGFuZCByZXN0b3JlZCB0byB0aGUgb3JpZ2luYWwgc3RhdGUgZHVyaW5nIHN5c3RlbSByZXN1
bWUuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjkrDQo+IEZpeGVzOiA2
ZDczNTcyMjA2M2EgKCJ1c2I6IGR3YzM6IGNvcmU6IFByZXZlbnQgcGh5IHN1c3BlbmQgZHVyaW5n
IGluaXQiKQ0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzE1MTlkYmU3LTczYjYtNGFmYy1iZmUzLTIzZjRmNzVkNzcyZkBrZXJu
ZWwub3JnL19fOyEhQTRGMlI5R19wZyFZekxIeHlNN3kwbXFMb0dObkJCZGtRVC14LTA4Y1d3V1NJ
TVliaEpaNVc2a0xaTWFJZW1DUm40dTN0SFdvR0lKeURyc0k3VHBON2cxb1dLdENfdkkkIA0KPiBT
aWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2VybmVsLm9yZz4NCj4gLS0tDQo+
IENoYW5nZXMgaW4gdjI6DQo+IC0gRml4IGNvbW1lbnQgc3R5bGUNCj4gLSBVc2UgYm90aCBVU0Iz
IGFuZCBVU0IyIFNVU1BIWSBiaXRzIHRvIGRldGVybWluZSBzdXNwaHlfc3RhdGUgZHVyaW5nIHN5
c3RlbSBzdXNwZW5kL3Jlc3VtZS4NCj4gLSBSZXN0b3JlIFNVU1BIWSBiaXRzIGF0IHN5c3RlbSBy
ZXN1bWUgcmVnYXJkbGVzcyBpZiBpdCB3YXMgc2V0IG9yIGNsZWFyZWQgYmVmb3JlIHN5c3RlbSBz
dXNwZW5kLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQxMDAxLWFtNjItbHBtLXVzYi12MS0xLTk5MTZiNzEx
NjVmN0BrZXJuZWwub3JnX187ISFBNEYyUjlHX3BnIVl6TEh4eU03eTBtcUxvR05uQkJka1FULXgt
MDhjV3dXU0lNWWJoSlo1VzZrTFpNYUllbUNSbjR1M3RIV29HSUp5RHJzSTdUcE43ZzFvY1NBMVlM
cyQgDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAyMSArKysrKysrKysrKysr
KysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDIgKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggOWViMDg1ZjM1
OWNlLi4yMDIwOWRlMmIyOTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0yMzM2LDYgKzIzMzYsMTEg
QEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21l
c3NhZ2VfdCBtc2cpDQo+ICAJdTMyIHJlZzsNCj4gIAlpbnQgaTsNCj4gIA0KPiArCWR3Yy0+c3Vz
cGh5X3N0YXRlID0gKGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApKSAm
DQo+ICsJCQkgICAgRFdDM19HVVNCMlBIWUNGR19TVVNQSFkpIHx8DQo+ICsJCQkgICAgKGR3YzNf
cmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IzUElQRUNUTCgwKSkgJg0KPiArCQkJICAgIERXQzNf
R1VTQjNQSVBFQ1RMX1NVU1BIWSk7DQo+ICsNCj4gIAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9y
b2xlKSB7DQo+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gIAkJaWYgKHBtX3J1
bnRpbWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSkNCj4gQEAgLTIzODcsNiArMjM5MiwxNSBAQCBzdGF0
aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90
IG1zZykNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+ICsJaWYgKCFQTVNHX0lTX0FVVE8obXNn
KSkgew0KPiArCQkvKg0KPiArCQkgKiBUSSBBTTYyIHBsYXRmb3JtIHJlcXVpcmVzIFNVU1BIWSB0
byBiZQ0KPiArCQkgKiBlbmFibGVkIGZvciBzeXN0ZW0gc3VzcGVuZCB0byB3b3JrLg0KPiArCQkg
Ki8NCj4gKwkJaWYgKCFkd2MtPnN1c3BoeV9zdGF0ZSkNCj4gKwkJCWR3YzNfZW5hYmxlX3N1c3Bo
eShkd2MsIHRydWUpOw0KPiArCX0NCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBA
IC0yNDU0LDYgKzI0NjgsMTMgQEAgc3RhdGljIGludCBkd2MzX3Jlc3VtZV9jb21tb24oc3RydWN0
IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+
ICsJaWYgKCFQTVNHX0lTX0FVVE8obXNnKSkgew0KPiArCQkvKg0KPiArCQkgKiByZXN0b3JlIFNV
U1BIWSBzdGF0ZSB0byB0aGF0IGJlZm9yZSBzeXN0ZW0gc3VzcGVuZC4NCj4gKwkJICovDQoNClZl
cnkgbWlub3Igbml0OiB1c2UgdGhpcyBzdHlsZSBmb3Igc2luZ2xlIGxpbmUgY29tbWVudDoNCg0K
Lyogc2luZ2xlIGxpbmUgY29tbWVudCAqLw0KDQo+ICsJCWR3YzNfZW5hYmxlX3N1c3BoeShkd2Ms
IGR3Yy0+c3VzcGh5X3N0YXRlKTsNCj4gKwl9DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaA0KPiBpbmRleCBjNzEyNDBlOGY3YzcuLmIyZWQ1YWJhNGM3MiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmgNCj4gQEAgLTExNTAsNiArMTE1MCw3IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJy
YXkgew0KPiAgICogQHN5c193YWtldXA6IHNldCBpZiB0aGUgZGV2aWNlIG1heSBkbyBzeXN0ZW0g
d2FrZXVwLg0KPiAgICogQHdha2V1cF9jb25maWd1cmVkOiBzZXQgaWYgdGhlIGRldmljZSBpcyBj
b25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwLg0KPiAgICogQHN1c3BlbmRlZDogc2V0IHRvIHRy
YWNrIHN1c3BlbmQgZXZlbnQgZHVlIHRvIFUzL0wyLg0KPiArICogQHN1c3BoeV9zdGF0ZTogc3Rh
dGUgb2YgRFdDM19HVVNCMlBIWUNGR19TVVNQSFkgYmVmb3JlIFBNIHN1c3BlbmQuDQoNCkNhbiB5
b3UgdXBkYXRlIHRoaXMgZGVzY3JpcHRpb24gbm93IHRoYXQgd2UgY2hlY2sgZm9yDQpEV0MzX0dV
U0IzUElQRUNUTF9TVVNQSFkgYWxzbz8NCg0KPiAgICogQGltb2RfaW50ZXJ2YWw6IHNldCB0aGUg
aW50ZXJydXB0IG1vZGVyYXRpb24gaW50ZXJ2YWwgaW4gMjUwbnMNCj4gICAqCQkJaW5jcmVtZW50
cyBvciAwIHRvIGRpc2FibGUuDQo+ICAgKiBAbWF4X2NmZ19lcHM6IGN1cnJlbnQgbWF4IG51bWJl
ciBvZiBJTiBlcHMgdXNlZCBhY3Jvc3MgYWxsIFVTQiBjb25maWdzLg0KPiBAQCAtMTM4Miw2ICsx
MzgzLDcgQEAgc3RydWN0IGR3YzMgew0KPiAgCXVuc2lnbmVkCQlzeXNfd2FrZXVwOjE7DQo+ICAJ
dW5zaWduZWQJCXdha2V1cF9jb25maWd1cmVkOjE7DQo+ICAJdW5zaWduZWQJCXN1c3BlbmRlZDox
Ow0KPiArCXVuc2lnbmVkCQlzdXNwaHlfc3RhdGU6MTsNCj4gIA0KPiAgCXUxNgkJCWltb2RfaW50
ZXJ2YWw7DQo+ICANCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogOTg1MmQ4NWVjOWQ0OTJlYmVm
NTZkYzVmMjI5NDE2YzkyNTc1OGVkYw0KPiBjaGFuZ2UtaWQ6IDIwMjQwOTIzLWFtNjItbHBtLXVz
Yi1mNDIwOTE3YmQ3MDcNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gDQo+IFJvZ2VyIFF1YWRy
b3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiANCg0KVGhlIHJlc3QgbG9va3MgZ29vZCB0byBtZSEN
CllvdSBjYW4gYWRkIHRoaXMgQWNrIGFmdGVyIHRoZSBjb3VwbGUgbWlub3IgZml4ZXM6DQoNCkFj
a2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5r
cywNClRoaW5o

