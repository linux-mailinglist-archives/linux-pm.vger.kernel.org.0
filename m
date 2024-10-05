Return-Path: <linux-pm+bounces-15180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0609913A7
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 03:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069E7285181
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 01:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D34C9F;
	Sat,  5 Oct 2024 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UwoicHSo";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j/AWT2z/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EP8CfU6n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC501BDCF;
	Sat,  5 Oct 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728090290; cv=fail; b=YqjYb3mPQaJNc50iE9aTGi+XAYsGfKRllkatc65HuGuCb+lCEdkEPHAWjeykX2HGVbG2kkYzX2X3cPUyh6NZaVgEkV7vcxQ0jLgmkROsnIP5OgNT4RDpNsqdaHXcIva9FJVWG6YKpn1/pte3Ugopkx0E7y0dWqX74pYTUt+nXms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728090290; c=relaxed/simple;
	bh=STFO0HbPXqrarZu2uJK7PwS3kHSy7JtowW9YqlwYPu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SWJqq0m4Ec8ownchRSwocpXve7QvQ46XlxY//QHivQ3Uc7FhLPjLCwz+vaxgS120uRqnU718O0NfYZgKrpbuvhfD6fBKQ7LSp/6DSLC+6FkGbb1XFeXeiKsLWLp/D8NN92Iq0zNVP0/Grt+XGJ5+5ACAJg13KCQxHbMmUOFM5Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UwoicHSo; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=j/AWT2z/; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EP8CfU6n reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494KOZ41003952;
	Fri, 4 Oct 2024 18:04:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=STFO0HbPXqrarZu2uJK7PwS3kHSy7JtowW9YqlwYPu4=; b=
	UwoicHSoTdwro5gD3h3GMGwGXfNcX1sv9sc+o7Bx+4goFYamwIHFko/yCc3eMs1j
	s4Z/mwvhIJsCjJmB3PEopzYkaCRls5J1Rb6ln/SdRbYTju1Sar3wztpMEvXV5GOm
	QZST6bA6MHT602+W431a6FuhhllOD6xNeLDQGRBbCWP8na8WbxqOVZLgfbupHrtV
	6r8Acl/QgzHwdWBC/b0ZziBazE68RuEAM/tfESVdKl8jclKOfo+jKMG/5ta69ifd
	rECVO2lQcePI1514NgwZn1AVuz97Wydkl8emDo1o7w50ZwCxxAjnI4LdQ2awq18d
	/8T1o11UovKml/Ktfi6LmA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42205wf672-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1728090259; bh=STFO0HbPXqrarZu2uJK7PwS3kHSy7JtowW9YqlwYPu4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=j/AWT2z/SsP3eRbdQfrHuLYrK7s7XRwA5QQFDQsDOS8OK7Oc12KQ3/RUjf5Vr45XE
	 VexBu0++sC7vr51Rr7F7jWjAmt20W2bR/TNjF2g/+hEmXOOJHa8I5qFtnlGfP8Sqop
	 cFg9+x99Nfo+tyipTZY1TIhe8oJURtdcRuPngcg+0l3RttLZmim4hMeqm5J7z8DZuB
	 SDZ0vyOd9F67M34cks2JSTetAUIiEqf+A6RoN+/ly84BpENcCgSDWIF9t4lrDpvil4
	 E2EuIj2WYsycV+cL95+ofUfSmbC1LhRgyd77FMgOGhsV2DQBo6Al8z30fd4wrq639a
	 ID4cQpEJHpkxA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5B4B740112;
	Sat,  5 Oct 2024 01:04:17 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4BC9FA00A1;
	Sat,  5 Oct 2024 01:04:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EP8CfU6n;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0620740120;
	Sat,  5 Oct 2024 01:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErjAtzrErUfCqkVSqccccYjaxDhpQX3Jkg8HhdtTPLAq/myPpW6fEIjySerTt2Km4zygkDpGaRt9pfAf63uaXNRlf6qbVdJRK214QjkvK1+Eazq0i3ePqDnCPjkGFM1HWEvu6xi2vtJMRB29NQtkhUHah+NZxEXCfCoumPpdEHIiifrr8WD82wdyoZjtjdpsrZAnZcKj6JU+L0V8FBNQu8E6Y6qOw3YjM3NURkVin9hWaDQUZ9WVhP14j+c6u8z7JRiishwyD5wc2mzVaBvh6i6FHPsdUvdGNiQHHU1eOKmn1z+ufDKUoHkGKKGCdcOO5pmKCjXAXUkA0ONOgzp15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STFO0HbPXqrarZu2uJK7PwS3kHSy7JtowW9YqlwYPu4=;
 b=KMkvfURU9ZNyOMY8QZiaZHfxYrvf+1rF923axn2l9f16MY+j32yR6r0Y6D9HLmIAY2U/+XejZrUYf3bqmhkHfn0o3b/Vo90cLZxSnZLnMfdM+Udng5N1XLYcQfIegjI6Wd4yCRUc6UkZHnlKVRQycAW0fijWkDYH/cwTt80Tk6b4aMhwisEJ2F2ucA6K09mS88+/nPkggjToa8AICeg4QTFGaZyLONZFDqKDTgwJ2qesTZxEYvOj9uo7mI/uh5dC24AMbSTvtn/9+Q2kFQMn5HVe+uhj609NNPfuZEPUtwZQpt02KjO4NTd41vlEV2oKX4rShijHI00I64M72PyK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STFO0HbPXqrarZu2uJK7PwS3kHSy7JtowW9YqlwYPu4=;
 b=EP8CfU6nysR3A5BsThGL5exJktrQO9jHO0KgHtezHptiJSAdE0lDwgNfGJcf0eWkXmbuAcvR8XqHq4wSoZdFpK5bm6k+3cGe1G1qtJ3kt1vPRRNsokIP3NV3NfCqfbOd878pHksrd+myxHzWnB2HTk8ZAgQrfcEBrfZbOE9hA0w=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Sat, 5 Oct
 2024 01:04:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8026.017; Sat, 5 Oct 2024
 01:04:08 +0000
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
Subject: Re: [PATCH] usb: dwc3: core: Fix system suspend on TI AM62 platforms
Thread-Topic: [PATCH] usb: dwc3: core: Fix system suspend on TI AM62 platforms
Thread-Index: AQHbFBRY6VSHdoFJ0UqFUesMTA9ATLJ3XL2A
Date: Sat, 5 Oct 2024 01:04:08 +0000
Message-ID: <20241005010355.zyb54bbqjmpdjnce@synopsys.com>
References: <20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org>
In-Reply-To: <20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB6669:EE_
x-ms-office365-filtering-correlation-id: 1b27a03b-4df1-40aa-b98c-08dce4d99df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmZLOHVqVFdjTEt5MjAxMFpqRWZDdUcyUktHNjFCdFBwS0JnVHFGNjhSaXdN?=
 =?utf-8?B?UVZMZzEvZkFDaGx3dFRZK3F4K09HTzg4TXhmdmlhOHNyTmc0ODlNb2gxV0x4?=
 =?utf-8?B?aUdyMTIzd3hXaTdNOG8xdUpra2ZHT0lKN1Z2Z3pmNVJPdmgyZ0ZnZlE1elJ2?=
 =?utf-8?B?c0t1S1dIRHEwbDZ1Q1JJVTlzbjFwMnJMUERnYVh3dzNKZW9QcnZNWklHVjJL?=
 =?utf-8?B?dHd6eDdwYWpyWHk2MzA3amhWdW8wT0g0VEppMG4zb1U3cVphYU55dFpKSEcw?=
 =?utf-8?B?TENrY0xVTDNQK0E0bnBHUmppSllVK25UbkZvbTFzeUxVU3lwQUxkZS9ldzdG?=
 =?utf-8?B?aGQ1bHg3TE52VzlyZWZyNDRUQ0VNQXFmTzh2UnNieU01dlhCVGFlT1MrMVM4?=
 =?utf-8?B?emJPTHRlY0tXcHlQLy9teE15MldyeHBUQW5uOFU2aXB0bXFJSFlUTlVFTGlG?=
 =?utf-8?B?R3pQSmlIUkZSUkxWZzZrWHJBWUxCd0FBMmZqYVFKVHBraFZZN3QyTUQ3Um5F?=
 =?utf-8?B?MjF3WG5INlNtVVFxbXpFMS9VL0ljem9vdHlyNTNpZWxZVjFvckRUWUJRWlcy?=
 =?utf-8?B?dHYxZElWZzVGd004RkQwTkFRWjB4UzF5VnlDakMzZ2tTdEJta3R0V3pWR21R?=
 =?utf-8?B?MFJuTXhWN1dVcC80emR1STYvN1FmUkw3RUNVTk44bVc5ZmYxcS9abEVSSWRk?=
 =?utf-8?B?WVgzL1ltYlFQZW1nZ0VIUFV1RGRPZk9UNmEvKzNlbEtLSzVpdTlNRHZsWVNI?=
 =?utf-8?B?SWp0UGdPdzBmK09jZmRSOTc3d3J0cGZyOUd3YVQyNy95ODBoYW5ER0hBcG9M?=
 =?utf-8?B?bVk3TFRtU1BLc242dm1MY0ZwQTZ5U3lTMHZmRzdtTndKUC8wWU02ZlFaZ2Vj?=
 =?utf-8?B?NjVZVCtRRmdxa0tLZDdRd1J3QXlwV01STWE1Qms1emZCZklVUThrT3k0UDE0?=
 =?utf-8?B?SDkvYnp0blhpZ05MOU1TSDV5dTRLMnRzNjQ2UElHSzRJK1kyYUlEVy8wUTdH?=
 =?utf-8?B?TGtsZjllT3l2UTJNZUZvWndIa1ZHUVFsS2lmUm9DMU1TYkM3ZGF1YVdjTUhZ?=
 =?utf-8?B?QlM4d3pUcUNBYk9tb3ZYNVgvYVZmdkRMNkp0OHg4NDJJbWJBWUVjcjBDV21T?=
 =?utf-8?B?azJsckVRVzlDN3AzckJKUnBKWVRXOXgvS2tPVFlveEUvVk55YlFIbGhyUkls?=
 =?utf-8?B?VUhFOWxlUDZnVFM3UDI1WEg2YWFNZGhHMC85eXZMQS85UVZ5dWJIWWxSSERk?=
 =?utf-8?B?RnFNM0VyZERZTXJKbmxiWDd0Y0h0Q3hJUi92QW0xU1ZSRzJqamVZVlBhRGpE?=
 =?utf-8?B?ODZxTTVRSXRWRml3dHBmL3RnVHhaTnV4QTZtRWY1QmZRd20rYVdMVy9PcW9t?=
 =?utf-8?B?R2V0OWh3b0F2S2krS0FVNnRJNk9nR2JQT1ZSSUJVdmNhelBVQUFPVDRXa21y?=
 =?utf-8?B?RlcramJIa2pONDZ2U2FHWnlOelJYTnQwQXAvOGJNNkxGV1Y5Q0RvbHAxS3Np?=
 =?utf-8?B?ZU9XWlAvck1zamJaTjNEdnY1NG5IQzlqZHcxZ1FmeGlCTGhqeElqMlVyS3Zp?=
 =?utf-8?B?bVg4d2ZzOEt6YWJXVm1abDMrYlJWWTdsa2trZCtpUUNOWnZkSTJvN3F6bkgv?=
 =?utf-8?B?UWxneXdNNHd6WENDVkk1U2E5WFRiY0Y3SkRDMkt6OHFVQjUyRjZHUVM2RGtJ?=
 =?utf-8?B?Uy83dmlnckg4bGJqRkQzRTFOK2ZEV1RsZGZFd2s5NTlRcFFhR3FWdHhMcWdJ?=
 =?utf-8?B?V0ExbjkzQXViNG8rQTFnWDZ0RnRXcTEyb0FFWDZCemVzRDFxODI4RDNORWdk?=
 =?utf-8?B?b2NvWVRUb3h4cjNrQlB5dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3ltRWkwSUttL3FNOEF6Wm5BTkxYREx1Mmd2d0tSMzE3cTEzaER1cysvZjJk?=
 =?utf-8?B?SzJCZDFCaEwzNE9YWVg3ZDdzWlhDQ1dUa0ZOQjkxTmU4b29pZVU3MVZHbFRI?=
 =?utf-8?B?NjhBekVVZGJxNkJwRGJzamx1VHZKZDdUSldvNTNrVXZZZXN4aVl3SmxaMHZS?=
 =?utf-8?B?SGhYbEp2S0VsWkF3aUNLY0xhYThJZE9TOGMrbWxjWGxnV0p4SDRmZkZoUDBI?=
 =?utf-8?B?dVoveXNGdkZrWjUwWFJIcjlscXNDQTlZbm40RVZBWnRQa3FDbk5tcFB4OThr?=
 =?utf-8?B?WEE3T0wxUGhhdDBWZGF1TTR6am0wdE9kZjNGU0F2OXQ2eTZFbHh3bFF2dnFP?=
 =?utf-8?B?ZEFGTGRnZzROeWhpemJnZkY3bCtpQ1p4QTFxL3AyVkdVMUNtUzRZVkZSblVw?=
 =?utf-8?B?VmM0cEpXM2l6d3hVYTQrclYvZGZrS0RsMjZYMEc4bDE0Vkhsd0FyckFXVnUz?=
 =?utf-8?B?N0RDeVRYeW9qOHZXdDNGblNzTVJSN3A0Uy9pTGpwaTJXVVUvNFlzZmpoVTNI?=
 =?utf-8?B?NDIvaStyd1FmNTdCVGVDeWV6bngwZDcxY1lVRXZOcVRTZE42K2xNZ1l0Y2pS?=
 =?utf-8?B?T3B0U3hkOXhlNUtqMXZza2tyaDBwUFNhelBiVExNV3I3OThBemNLWEt0VXJJ?=
 =?utf-8?B?dHlaSmsrbVQzWjc0R1pubmdJTkdMUUhBdEx4NzRYaFJoOEE4eVhENTJEZnRR?=
 =?utf-8?B?WkVtRW9tWjFlMk9ocHo5dnVoMlBWK2lHWlY3ZHFMWE9GUFpjNUZNOXo3U0hm?=
 =?utf-8?B?WElCclVERHc5UVpSNGdQNWdUSzdTR3pUUjd2bllNaHpyR1FaWDJqMlZhM2ZH?=
 =?utf-8?B?KzMvNVBjMlZUaTYzaDdzMU1uQStjS1NYZW1TSjViVlpzbnBEZEwybUVCWk9Z?=
 =?utf-8?B?Y2g1bFZzNDFKVEFVQlBzNTltcFlLcVRwak9KRGtGOFUrMGdXeTBoRTZJY1dt?=
 =?utf-8?B?MFUzamF2L2V0aHJ4c1BoekZMUkViRy9hSEk4SFJSWTNETGl2RUQvZlNnQmoz?=
 =?utf-8?B?ZmpNMGJ2SUxrRnM4bG1DTlY1UnYvbjJnT252Vkl6eTl4NGFUOXJocjdKdkFB?=
 =?utf-8?B?VFlXU0R1bURTK3NBZTE2VWRack1vM0l4ZXhjUW5qSE9PVmR0V3B5YlpnQW5h?=
 =?utf-8?B?dlZvbFpOR2l5enZyck9MUFRveEtVRUVDZm55UytSOWIwSHhCeGdXSGtKaGhO?=
 =?utf-8?B?N3FWd3h6UFFseTI3WUFobjNwaUFoczh3eDJVNlJZcGUxZTJ4Zi9ibkFVR0Fr?=
 =?utf-8?B?OWdUUXh0TlFyTU1PVDZrRkx5WHg5OXBlcW5lRjlwT3N3b0ljSWZObEwrQnJw?=
 =?utf-8?B?azdpNDFoSkIzRTdzK1JwL1Y4b3V4VWZOTWJBOWxScm0ySWxKL0RtcnEzRm02?=
 =?utf-8?B?RDJzbzAybE8yU0Q0c3lxaGh6OThxTkFLVE9QZ0F6QmxST3l2VDB4TVVtMmk1?=
 =?utf-8?B?STI2aFZ5dDhUNnhnOFhxNk8yaFdVVngxZVZKT3FaQkMvdWtvWEtIWERidDJ1?=
 =?utf-8?B?NStmdTZIS0hxeTlkVWU0L1NFcEx6KzdMSXVqcityQ0F2amljdmR6amp0cVRl?=
 =?utf-8?B?MlJoSGxsb29GdnJMNzVHdk16QjN2YWwvMUhrb21LVG9qeTBiZHlpMk1RWDBG?=
 =?utf-8?B?cEloOUlsaTNJUEpaeGxndkJyUjFzVkVyVTRUWllXbkc4QmxweXVCMTA3V29B?=
 =?utf-8?B?MWJuVkcwZ2lZbmcxVUZvVE5hSElHendTMWZsVGpROFlmNlRRY1hwSFRwQmRM?=
 =?utf-8?B?d1lBYnVFbXNBUm8xVjBmakVQWmdSZUJtYjNDNko3NDlJYTFnNHlrUWJhTmRz?=
 =?utf-8?B?alkwWXhQRUlPaU9aWWRZUjJWMlBOdUlwb1dPbVh0UzZFb21kd3FtNzJBb1Zm?=
 =?utf-8?B?UE5jNzNKMEtTdDI3MHBZZE4yendpNnBNQm03ZWxCQUxSZTBMbURvOUxzMUpZ?=
 =?utf-8?B?MjYzcW9nclpKL1p3RXN2UkZvUzhOOXpUVjM2cUhxTWk2VlVXRHpIMUE5TUNV?=
 =?utf-8?B?K0hTNEFHd0Z3bVhzSGlzREJQbzRPbUVGUWI1SDFyRTJVc04wMUJSd1k2NlhY?=
 =?utf-8?B?YzBjeXIrN3k2b2JJcG1rOXJkVjNrWEJ2SEk1SkZYNG1wUHJ5b1h4RXQ1Tmtw?=
 =?utf-8?B?bk9aYTQ4amY3cFZkV3FzblFwbjh1eElPM0VQZm1hSjluSUdkWU9iNXBENWgy?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C9B48C8432C7B4FBB0072427FAE4729@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hfe8ryZifblrFF9hBvvLo0xST1BuYg3LkAydaGzMJkJza3ueDmrroYvy7bvLvYhrgkBQQvNlUNaMMw7/FO4pkGzZTcKLTQBX3S9PtAb54/j+ZMhA/NTVcZOVu4WSeVahba8d6kpYLQyAsoJErbjoGQYrOIu6isc9Wnt1R5euayB8G7SEbw4tj+WOA9tX5K+bSmsWo/l8maMILzdxYKoBb9AHzVQDKUI2KLXSue5t9844t22lOBkCFqe13rWNiBhNY6eqVCxFWXsovZMygoKny34iR6lZp70Jq/apfwVD8P4OkUL/dT9/HT6Ik1RPOZWrcVjFw863MxZRAuKIyzTpUdds23XD2rinbTnOHye6dMoZDg62gLdDI2/myVZTgz9DM+z3lexsX0ZD7R6GfyfXEDB5jPOezXYAyBvt0zVpNUKHZOiTKKcsJgPhn1fsN314fdk1Jw/8+7Tb7vG5r7sMcNL5v38iOcAOzQIq4M7WHJYbEciy6xnrTUb0hPauVpjQ1E7yIoUycc2EJlY6bDwVPoq7azMIAWMjCHHUZuitqjqvNlKxDWKnFes3TXvyxkGghkoaCXlnTDUorOtsbDBuCYfDKWwDOConHjcjipL65Ljp+67P89IMFntfS5wmH3f0b8G9bwzvdo/YkvMA3tsdnQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b27a03b-4df1-40aa-b98c-08dce4d99df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2024 01:04:08.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRsOEPlWWo5OXvXUd3R9uI6eMquCaPDwWds+AmtMf2oLnWKGJcJZVbrAUBiqMKLMnHh3dofwmmkCXNX/2gqDAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
X-Proofpoint-GUID: rVI2KfGbpLVNm4BxnG-lM1OUK-YyLOJs
X-Proofpoint-ORIG-GUID: rVI2KfGbpLVNm4BxnG-lM1OUK-YyLOJs
X-Authority-Analysis: v=2.4 cv=CtLtcW4D c=1 sm=1 tr=0 ts=67009094 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=MRnR0ZihpqKrGaemOPkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=932
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410050006

SGksDQoNCk9uIFR1ZSwgT2N0IDAxLCAyMDI0LCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiBTaW5j
ZSBjb21taXQgNmQ3MzU3MjIwNjNhICgidXNiOiBkd2MzOiBjb3JlOiBQcmV2ZW50IHBoeSBzdXNw
ZW5kIGR1cmluZyBpbml0IiksDQo+IHN5c3RlbSBzdXNwZW5kIGlzIGJyb2tlbiBvbiBBTTYyIFRJ
IHBsYXRmb3Jtcy4NCj4gDQo+IEJlZm9yZSB0aGF0IGNvbW1pdCwgYm90aCBEV0MzX0dVU0IzUElQ
RUNUTF9TVVNQSFkgYW5kIERXQzNfR1VTQjJQSFlDRkdfU1VTUEhZDQo+IGJpdHMgKGhlbmNlIGZv
cnRoIGNhbGxlZCAyIFNVU1BIWSBiaXRzKSB3ZXJlIGJlaW5nIHNldCBkdXJpbmcgY29yZQ0KPiBp
bml0aWFsaXphdGlvbiBhbmQgZXZlbiBkdXJpbmcgY29yZSByZS1pbml0aWFsaXphdGlvbiBhZnRl
ciBhIHN5c3RlbQ0KPiBzdXNwZW5kL3Jlc3VtZS4NCj4gDQo+IFRoZXNlIGJpdHMgYXJlIHJlcXVp
cmVkIHRvIGJlIHNldCBmb3Igc3lzdGVtIHN1c3BlbmQvcmVzdW1lIHRvIHdvcmsgY29ycmVjdGx5
DQo+IG9uIEFNNjIgcGxhdGZvcm1zLg0KPiANCj4gU2luY2UgdGhhdCBjb21taXQsIHRoZSAyIFNV
U1BIWSBiaXRzIGFyZSBub3Qgc2V0IGZvciBERVZJQ0UvT1RHIG1vZGUgaWYgZ2FkZ2V0DQo+IGRy
aXZlciBpcyBub3QgbG9hZGVkIGFuZCBzdGFydGVkLg0KPiBGb3IgSG9zdCBtb2RlLCB0aGUgMiBT
VVNQSFkgYml0cyBhcmUgc2V0IGJlZm9yZSB0aGUgZmlyc3Qgc3lzdGVtIHN1c3BlbmQgYnV0DQo+
IGdldCBjbGVhcmVkIGF0IHN5c3RlbSByZXN1bWUgZHVyaW5nIGNvcmUgcmUtaW5pdCBhbmQgYXJl
IG5ldmVyIHNldCBhZ2Fpbi4NCj4gDQo+IFRoaXMgcGF0Y2ggcmVzb3ZsZXMgdGhlc2UgdHdvIGlz
c3VlcyBieSBlbnN1cmluZyB0aGUgMiBTVVNQSFkgYml0cyBhcmUgc2V0DQo+IGJlZm9yZSBzeXN0
ZW0gc3VzcGVuZCBhbmQgcmVzdG9yZWQgdG8gdGhlIG9yaWdpbmFsIHN0YXRlIGR1cmluZyBzeXN0
ZW0gcmVzdW1lLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2Ni45Kw0KPiBG
aXhlczogNmQ3MzU3MjIwNjNhICgidXNiOiBkd2MzOiBjb3JlOiBQcmV2ZW50IHBoeSBzdXNwZW5k
IGR1cmluZyBpbml0IikNCj4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNTE5ZGJlNy03M2I2LTRhZmMtYmZlMy0yM2Y0Zjc1ZDc3
MmZAa2VybmVsLm9yZy9fXzshIUE0RjJSOUdfcGchYWhDaG00TWFLZDZWR1lxYm5NNFgxX3BZX2px
YXZZRHY1SHZQRmJtaWNLdWh2RnNCd2xFRmkxeE81aXRHdUhtZmpiUnVVU3pSZUpJU2Y1LTFnWHBy
JCANCj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5vcmc+DQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxNiArKysrKysrKysrKysrKysrDQo+
ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDllYjA4NWYzNTljZS4uMTIzMzky
MmQ0ZDU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMjMzNiw2ICsyMzM2LDkgQEAgc3RhdGljIGlu
dCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cp
DQo+ICAJdTMyIHJlZzsNCj4gIAlpbnQgaTsNCj4gIA0KPiArCWR3Yy0+c3VzcGh5X3N0YXRlID0g
ISEoZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpICYNCj4gKwkJCSAg
ICBEV0MzX0dVU0IyUEhZQ0ZHX1NVU1BIWSk7DQo+ICsNCj4gIAlzd2l0Y2ggKGR3Yy0+Y3VycmVu
dF9kcl9yb2xlKSB7DQo+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gIAkJaWYg
KHBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSkNCj4gQEAgLTIzODcsNiArMjM5MCwxMSBA
QCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVz
c2FnZV90IG1zZykNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+ICsJaWYgKCFQTVNHX0lTX0FV
VE8obXNnKSkgew0KPiArCQlpZiAoIWR3Yy0+c3VzcGh5X3N0YXRlKQ0KPiArCQkJZHdjM19lbmFi
bGVfc3VzcGh5KGR3YywgdHJ1ZSk7DQo+ICsJfQ0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+
ICANCj4gQEAgLTI0NTQsNiArMjQ2MiwxNCBAQCBzdGF0aWMgaW50IGR3YzNfcmVzdW1lX2NvbW1v
bihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgCQlicmVhazsNCj4gIAl9
DQo+ICANCj4gKwlpZiAoIVBNU0dfSVNfQVVUTyhtc2cpKSB7DQo+ICsJCS8qIGR3YzNfY29yZV9p
bml0X2Zvcl9yZXN1bWUoKSBkaXNhYmxlcyBTVVNQSFkgc28ganVzdCBoYW5kbGUNCj4gKwkJICog
dGhlIGVuYWJsZSBjYXNlDQo+ICsJCSAqLw0KDQpDYW4gd2Ugbm90ZSB0aGF0IHRoaXMgaXMgYSBw
YXJ0aWN1bGFyIGJlaGF2aW9yIG5lZWRlZCBmb3IgQU02MiBoZXJlPw0KQW5kIGNhbiB3ZSB1c2Ug
dGhpcyBjb21tZW50IHN0eWxlOg0KDQovKg0KICogeHh4eHgNCiAqIHh4eHh4DQogKi8NCg0KDQo+
ICsJCWlmIChkd2MtPnN1c3BoeV9zdGF0ZSkNCg0KU2hvdWxkbid0IHdlIGNoZWNrIGZvciBpZiAo
IWR3Yy0+c3VzcGh5X3N0YXRlKSBhbmQgY2xlYXIgdGhlIHN1c3BoeQ0KYml0cz8NCg0KPiArCQkJ
ZHdjM19lbmFibGVfc3VzcGh5KGR3YywgdHJ1ZSk7DQoNClRoZSBkd2MzX2VuYWJsZV9zdXNwaHko
KSBzZXQgYW5kIGNsZWFyIGJvdGggR1VTQjNQSVBFQ1RMX1NVU1BIWSBhbmQNCkdVU0IyUEhZQ0ZH
X1NVU1BIWSwgcGVyaGFwcyB3ZSBzaG91bGQgc3BsaXQgdGhhdCBmdW5jdGlvbiBvdXQgc28gd2Ug
Y2FuDQpvbmx5IG5lZWQgdG8gc2V0IGZvciBHVVNCMlBIWUNGR19TVVNQSFkgc2luY2UgeW91IG9u
bHkgdHJhY2sgZm9yIHRoYXQuDQoNCj4gKwl9DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaA0KPiBpbmRleCBjNzEyNDBlOGY3YzcuLmIyZWQ1YWJhNGM3MiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmgNCj4gQEAgLTExNTAsNiArMTE1MCw3IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJy
YXkgew0KPiAgICogQHN5c193YWtldXA6IHNldCBpZiB0aGUgZGV2aWNlIG1heSBkbyBzeXN0ZW0g
d2FrZXVwLg0KPiAgICogQHdha2V1cF9jb25maWd1cmVkOiBzZXQgaWYgdGhlIGRldmljZSBpcyBj
b25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwLg0KPiAgICogQHN1c3BlbmRlZDogc2V0IHRvIHRy
YWNrIHN1c3BlbmQgZXZlbnQgZHVlIHRvIFUzL0wyLg0KPiArICogQHN1c3BoeV9zdGF0ZTogc3Rh
dGUgb2YgRFdDM19HVVNCMlBIWUNGR19TVVNQSFkgYmVmb3JlIFBNIHN1c3BlbmQuDQo+ICAgKiBA
aW1vZF9pbnRlcnZhbDogc2V0IHRoZSBpbnRlcnJ1cHQgbW9kZXJhdGlvbiBpbnRlcnZhbCBpbiAy
NTBucw0KPiAgICoJCQlpbmNyZW1lbnRzIG9yIDAgdG8gZGlzYWJsZS4NCj4gICAqIEBtYXhfY2Zn
X2VwczogY3VycmVudCBtYXggbnVtYmVyIG9mIElOIGVwcyB1c2VkIGFjcm9zcyBhbGwgVVNCIGNv
bmZpZ3MuDQo+IEBAIC0xMzgyLDYgKzEzODMsNyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJdW5zaWdu
ZWQJCXN5c193YWtldXA6MTsNCj4gIAl1bnNpZ25lZAkJd2FrZXVwX2NvbmZpZ3VyZWQ6MTsNCj4g
IAl1bnNpZ25lZAkJc3VzcGVuZGVkOjE7DQo+ICsJdW5zaWduZWQJCXN1c3BoeV9zdGF0ZToxOw0K
PiAgDQo+ICAJdTE2CQkJaW1vZF9pbnRlcnZhbDsNCj4gIA0KPiANCj4gLS0tDQo+IGJhc2UtY29t
bWl0OiA5ODUyZDg1ZWM5ZDQ5MmViZWY1NmRjNWYyMjk0MTZjOTI1NzU4ZWRjDQo+IGNoYW5nZS1p
ZDogMjAyNDA5MjMtYW02Mi1scG0tdXNiLWY0MjA5MTdiZDcwNw0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiAtLSANCj4gUm9nZXIgUXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5vcmc+DQo+IA0KDQo8cmFu
dC8+DQpXaGlsZSByZXZpZXdpbmcgeW91ciBjaGFuZ2UsIEkgc2VlIHRoYXQgd2UgbWlzdXNlIHRo
ZQ0KZGlzX3UyX3N1c3BoeV9xdWlyayB0byBtYWtlIHRoaXMgcHJvcGVydHkgYSBjb25kaXRpb25h
bCB0aGluZyBkdXJpbmcNCnN1c3BlbmQgYW5kIHJlc3VtZSBmb3IgY2VydGFpbiBwbGF0Zm9ybS4g
VGhhdCBidWdzIG1lIGJlY2F1c2Ugd2UgY2FuJ3QNCmVhc2lseSBjaGFuZ2UgaXQgd2l0aG91dCB0
aGUgcmVwb3J0ZWQgaGFyZHdhcmUgdG8gdGVzdC4NCjwvcmFudD4NCg0KVGhhbmtzIGZvciB0aGUg
cGF0Y2ghDQoNCkJSLA0KVGhpbmg=

