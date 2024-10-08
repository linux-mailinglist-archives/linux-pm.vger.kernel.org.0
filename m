Return-Path: <linux-pm+bounces-15360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD1995929
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 23:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1981C21145
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 21:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92107212D14;
	Tue,  8 Oct 2024 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BqbWbN+g";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JzyVKKl9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S5IsHStm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9931C1AC0;
	Tue,  8 Oct 2024 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422257; cv=fail; b=NIjfwS+8xqukcWRI3pmlr54eOQ7nHxxqtjOiypaeOoh32Ep8vBPGDINKo0Kepckdkxck5F2r3/Nl2+F2lSEhTnqmfHO7eM2UtCSBk27QbIZTsIkRD2gJUj8VDs6f5hJZwYFKRb7Do2iQu+vi2FE9k6QKRA/SnVV5VxlvX1afHcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422257; c=relaxed/simple;
	bh=CCwwf9MTULzmAuOZzvqWO+g12or1ltsgu7qvb9Me0YA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glkEnD7WPF7/KIeicet/wGqh2TVnWJ6BeqWDy6iP2dxUI9oeogwgKxIGVNK+9FM4k2wQ0esRvvActRyfioO4wZuYTXlsuevjQg5Z9aGkAhvfXPx3ZEUNvZ8Y+iQgdyh8Y69ibLEkXu2o12RrXT9+YSCNZKvSP3ZuESWo3UbXQNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BqbWbN+g; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=JzyVKKl9; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=S5IsHStm reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498G2VJx022162;
	Tue, 8 Oct 2024 13:57:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=CCwwf9MTULzmAuOZzvqWO+g12or1ltsgu7qvb9Me0YA=; b=
	BqbWbN+gPGenBwVlDBF4uEvJ2bYLeYSEG88gsVpfbrxm2zJz08p6Z6pZYciIXm8Q
	HVx+nOZpYUI6v9U0gSpBMlYmS6i4fhymVm81O5cd+XvLFJtnj9/hq5b5qoD7a3hH
	cKMNcDTZfNdllMj6h5xMALQTHYcpwe0m2pKjuYoWit5an2uTfkFuDIdVmipc32la
	gWgTsKiSQwtCnmDQiultwUzIoDsJQuImCafN99QVcsGPIYvcKPui5YVHlm7tAJpu
	WyfCU5q/pqAPSB4iUw7bmwvFJ49y3U4aiwtPeXzgsgyx+s6q+4c0e46nsu6ZQAFv
	l2IUCzqXPkt5Bc+7dTRIJA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4257w89efm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1728421027; bh=CCwwf9MTULzmAuOZzvqWO+g12or1ltsgu7qvb9Me0YA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=JzyVKKl9DQYfFwttXVSms1+9u15Si0OlAsc4r+vZ1WmXLWRKuTnry/UEmoh5Sxabv
	 TqcQZlYpsHLCXzChedzLCpUdo7Oo3jtJ3VJn+Kzjs74zzsRNt9InJ5TelSdtP2NMJI
	 ppeJiQMqSngDW2QkflIi72qwh7K0b0M6OvaBMvXA3dcdMdm2Aven26Z6caEwiOR3hH
	 5JZuoAc1jz4Ib6Sov+wH50GDKiXCnY3I+G8MT7cmqdzGwhKQc5h/6TOYmFryiB1As9
	 Ws5Rlr/dwEnX/5g1ZPvKu3sWvhSLqcqCBivYEX+9Ow8y6R1RVjiuOeagQI517a1XM8
	 HX20msrtvzitw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1E5F440174;
	Tue,  8 Oct 2024 20:57:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 84614A0263;
	Tue,  8 Oct 2024 20:57:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=S5IsHStm;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3B2ED401B8;
	Tue,  8 Oct 2024 20:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfnkvzievDIkYURyF4HoSdwaMnSpmBc78lr6XyqHIPlr5PByMKii3mi0ZVpq8OvCzBPOqo+n7tPsUI86S9qjM7syYKgmbVQIWffNVyzpjadJ4YDSpkbDCwEZ35qo1J8jFITwU8qgHtKZ7MzYi/EAgkLifyGpEUFwjjTG1GG+bwQRM9LT+NiAK04aKa8nMkdCNYmuFeO4pBIr4J+DPnL6FIH7mnDogo0M/1PGp6bk/XCpgSFmabOI7PYabEvAmJE/KSj7hosk/jQ3hBzoFkNhM50xbftzhqEPMPGjIHMi0lB0GfI9LCF3ezT6XeVZ4XomZC+HJO4fxv+r1/H6pfLT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCwwf9MTULzmAuOZzvqWO+g12or1ltsgu7qvb9Me0YA=;
 b=CmhI7bW3xUqm8tZcMQdkFqWS/L8BO89nGBDP2Fl1vky2+2GhtgPBei+624sThyOSErPABXxqwlRbZXY88LgnX5mZMdbzzqGfIRm+CFDZVU5DsOq6/Iia6PBJIWYhg3wvDooTBbMl7nkRRxBYQmb1NuBpZJuVrK7cd1c/ieKpCjeWcfX47Vyl9amfgtN7ahTVApQZHv8K2MYiH+fpcJF0110gQs2uvnkSx9OLzoPC3+dqPQTUXa0n62W+XKMt7+Fqrk8U5pfa/qzwBCe01utiKNyzEkxQqxiBFATUfhs9X0ehoB9+7DV0aeQscXbQAKZDlkMn+GdYdeCuiZHMkXxJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCwwf9MTULzmAuOZzvqWO+g12or1ltsgu7qvb9Me0YA=;
 b=S5IsHStmYBNlrsjwf7GXpZezufUYMS0R6FTeZs64cplFY1fjIzXBFO2Z3OJL5zW2Xl/QXVzGkjIjjTywSbTSqzqhyza3rDsx1rToNbMUWYuRrwqHU9XXe57xX7hNzuxIsOKFqHpY/Bd0fMrwtYhbrEs+pl+sVi4YSTuBOojs87U=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 20:57:00 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 20:57:00 +0000
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
Thread-Index: AQHbFBRY6VSHdoFJ0UqFUesMTA9ATLJ3XL2AgAPXqoCAAiyqAA==
Date: Tue, 8 Oct 2024 20:57:00 +0000
Message-ID: <20241008205658.no3kfap7wmlshci2@synopsys.com>
References: <20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org>
 <20241005010355.zyb54bbqjmpdjnce@synopsys.com>
 <5e6bb315-7896-4e63-86aa-1a219b7a7fb3@kernel.org>
In-Reply-To: <5e6bb315-7896-4e63-86aa-1a219b7a7fb3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB8256:EE_
x-ms-office365-filtering-correlation-id: 132f9723-a0e9-4e8f-fbf3-08dce7dbc10e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enF2T2ZKY1o1NU5tUTBPZU5kMU43SkpuaHBXQVpJeDNIL3h1czQ0aXpUN3Nv?=
 =?utf-8?B?aE1uNE5OZU1zWDNzdnhMWjBreGhPSllmSVdiVW91L0dJZUNGZXFoQ09RWlJD?=
 =?utf-8?B?VmZKVVRhbnRnRml2WVh2ZEJYVzBTc0ZVOVNCU3pqQnBTM2NhSVI5ZE9jdXMw?=
 =?utf-8?B?OVJmVnlyV0dLSTQ2UnhkWlRYY3NGNmhVd2FOQlB0TDYvZGNpWngvVkRBRG9C?=
 =?utf-8?B?c3Z5VWJGWGI5SXlqTTZjamFMRzZCMGNWczM5cFVad2VCQmJxNmhEUTNkckhv?=
 =?utf-8?B?eHM4dDhmMEhtVGIyMjRuL2JHS0N4cU5NTHRDVFhiNzMrV1Mra2h5MWZoOTRi?=
 =?utf-8?B?K3pRb0hxZzRCU3lwNEd0ckROSTI2Nm5ZNng4VU9QVDNFV05EdGRtM3NUUm9Z?=
 =?utf-8?B?eVFiSjV2RlJDMFNRY2hEekZFVjRrMmNKTTVZRUl0bE5hT2dMMHlxRWVhYXYv?=
 =?utf-8?B?QlRzaWlFUDZlbnZxeGFOMFRVNTdDR2RseE9Gb1Byd2VuNWs2ZUVZS2h5Y1hE?=
 =?utf-8?B?RGh6MWRyTk5ZekZuS3ZYd3hYdkFUOE15TnBJNS9tMnp1WFRsRFFFbi9YYlE5?=
 =?utf-8?B?bFRKMGhLUFU3RWQzcDZrbEUwMFNqcnJhVVc3RWRwQlJxb3pnN0M0NlZUL0gx?=
 =?utf-8?B?ZVVXckd3ZHUram16bk52bTVsRjQ3ckxTRmhQQno4YjgyOEZiYUNGUFcxVURs?=
 =?utf-8?B?K29kbDRKOE9tQzVaRnJQWVcweUFiTGJqaUcyVnkwK0Jpei9mYVFQbTRWbTEy?=
 =?utf-8?B?TzltN0tpYVU5MFRXTFJzYkxvOVltTS9TZVF0UzdFNWwwUzZ1MFc1RFV0anZD?=
 =?utf-8?B?MDQ5TmpsM2NoV3FKOGVDUDNXM0ErU1JCREZ3V1FJOC8rVzArM0VuaVZ4eDZC?=
 =?utf-8?B?MnlLT1JHNEZISFBIblhFSm1ndno1NzNONWhxYURDUjlkaVduemZVODJuY0pu?=
 =?utf-8?B?NzZMdVFoWkhONVFjTmc0SEpLc01NSi9OQnJ6RlFGdzBXWEJ5cDVKclA0K1Bm?=
 =?utf-8?B?QVZ5bXJ4Uy9aRytFQmg2THk3RFpPeFVrM09TU0oza1FJblBrc2ZyU0l0SnpB?=
 =?utf-8?B?bVdJN1VKMEdqSklEYlpJUmFqdmRuaC83Z0JPRzd1MU1yZVBuYlovUW5KM2Q3?=
 =?utf-8?B?dmFzK1MwaDVQbnZVWXp6RXI0Y2w4K3pvWURZNXVUNGliMkRYUE1WcVRTUmcz?=
 =?utf-8?B?NjlTU0hualFUeEgzdzBmSXA2UStuUnZ0NHVzakxnTElYckNmU1ZWQnU3ckZk?=
 =?utf-8?B?QkoyalBWVHcvVmNuMGVFcFkwYWZZdjU0WHRIK0F0ZGlSYzRDaUFlNFR3WHZq?=
 =?utf-8?B?R2dRcUZLN3ZTQnVUdHBWNmIyZUJWNUpONXlCVzJVTHdTUkZYVVIzby9ZK1Nr?=
 =?utf-8?B?aVFhRVZPeVlQS1R4d2piTWRwM0NBYThOUmVWV3JjWmNwaHRYL1JzaW0vbVdr?=
 =?utf-8?B?UnNNQ0xUN3pHZzhPRnJrSGQ4aVoxTFNpaEsrVmRsMzlZdCttT2lDUTlVbzVO?=
 =?utf-8?B?ZVd5SkZ4cGlFeTg3NDBjWG1mNG5zVTF0SVRFcXlGVE0rYmE3WldxMmxQdHVs?=
 =?utf-8?B?VWFKWk1SeERRUlJTOUlreG1ZOEJ0VUJiME02YllkRUJjbXZRVUxzOFZuWWdN?=
 =?utf-8?B?NTVtSzU4NllMN3d4TkU3ZFJHOElRaXRpcjJyNUVEZSs2S25ML0VIdStxVFo5?=
 =?utf-8?B?TE5nTVZGSEVWYytpREFaT1puSEVuM2VxaDlGM01IOWxHZUZ5N0MwWk92TUE0?=
 =?utf-8?B?OVd6ZWNwT0o0Q2IxTWhRb2Y2bWJRcTY1aEhiL2RUT005bXlZYTdFRXJJb1pu?=
 =?utf-8?B?cjYwOGJzeFpUanZ4N1JZZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWg1clJRamNWS2pSZHpJTW5XMzFTdU94a3JGOVdnT2kvY1NKV2JXY2pSdmJm?=
 =?utf-8?B?alcwRytKTndhUkhUNmFWRXhKKzkxZGY4d0Y2ZlJLbzJiNFkxSk1ZQnptdzRU?=
 =?utf-8?B?K2xtaXhXWW9NaE9VdmRqREdhRnl6N1dWVDJVZUlUVTV0d1diTnBYRm8rSERt?=
 =?utf-8?B?UTVqMnBmWVdhc1ErQkdGT0RiMlRFY2wwRkQ5eUlTdTJFNU9MSkpuRUxxOHpB?=
 =?utf-8?B?eHdBUGIxazlsVVA2Z0VpeFowRzhnNkhjQ1RNaG1adDJrb3dWcUltbm5vS3pi?=
 =?utf-8?B?R1RoOFN6a2poOWR2YUZJTXN6djFtc1pvTnVXSUF3WEhKSktZNExpcittWXhh?=
 =?utf-8?B?VzhZcTd2RENxbWN3dkdHbkplSGN2UDI2dUtBcUlnK3pyb0N4YmJEbUwyUWJD?=
 =?utf-8?B?ZlhudDUvaGRGZFVUaHZqSmp5eTBRUGVFUnlLQXpXMkd6RFBWTlVydWtlQmZa?=
 =?utf-8?B?OEx1M09SV01QOHJBMDBUekpmSWdDakQxVHlodlhEbjZZSS92THExbjR0KzZq?=
 =?utf-8?B?R1p0Y2xlbmd5d25qV1Z2MHNXYWF6dngxNGYzR2NmdnpwSG5zQ2hJOU1aQ3Vt?=
 =?utf-8?B?Y3lESmRWL3Rhd3RNUTh3VVFEeUtrZzE3TEp0ck5FY1hZL055T0VWWXROSXRv?=
 =?utf-8?B?bkw3RDJkUVdTZG9uODhHM0p4NG12QytYNElEOWc1RjJpNXQ3bUZLZ09LazRq?=
 =?utf-8?B?azN4MnJ1L1hWMGV4bC9BMnRTbGJlR1dCekFYeDJxZ2d6VXFRdEUxNFRmdC9I?=
 =?utf-8?B?QVo0WHhxV1BDRXVobCtFYjBDWTBHZkZsbUhHUnUyMndpSFJlUXJxUUh3QXdW?=
 =?utf-8?B?NDRQVGljV1l6SDZNUWhzM3gzamJrNmhVVy9hYWM5SUpFeTJkbkdVdkJncHVl?=
 =?utf-8?B?aWRiMXdhNkhnZVVwWXV5TVg1QmRJRDhwYllzbHNJeGUxcGhFdUhscHp1TEI3?=
 =?utf-8?B?YzNNTjkyMXl5K2UrUGd3dDR6QUdCRlorMnFXSEZSOEIvSlZ2b3RnSGlsdkYv?=
 =?utf-8?B?RU0ybDFUbS8vejRsSGxxWVFrdHF3SVZWV0pLVHFoKytIRERnUUR4T0tCclox?=
 =?utf-8?B?VGQwOW1ZZ25RcGNVTGF5R25lcjkyZXdPcS9UcjIxbjN6eDQvczZkZHJkMHRm?=
 =?utf-8?B?OTRnaGxVRDRDVnN3U2I1NUNLeHBxRUdVdEhiOGcrd3B2UFVNN3g1bWlVdjk0?=
 =?utf-8?B?dDFOTHBKVStOT3dNazloLzRhOWhtVStSek9peWxLZWY0eXMwN0RVWTIrMjNX?=
 =?utf-8?B?c2k0YURyUnYvbXY3RCsraXQvOUVWWDk3bG13MVQ3OWUvSEFkeDNISDVxVkFW?=
 =?utf-8?B?cUhGVUxIQUluSTNGb3Z5dVZ1MkRobXE1aHllTmZtNytOdG1SOHlvLzZZaVYv?=
 =?utf-8?B?RU9VSEZPdjFHR1JteXA0eEZXVkNCbkk0K2ZzTlFnMGV0QUtRbVkrbU9UaXVl?=
 =?utf-8?B?ZURqRUVBL2pkVCtMbWNick1UNVliNnNIb0pDN2N5RW5xa1M4ajAyam1vVWRv?=
 =?utf-8?B?bmcwOFJvTmNGd1MybE1ZMzUxV05CWWJ2NndaTEV3cDk2VnNERmtiekZMZkI0?=
 =?utf-8?B?ZFFvVko4cU9lMTNSTFN5YmIwRENrV2VzVTd4RkFIL3MxNkZHVHI5WEFybTUr?=
 =?utf-8?B?eVFHRWtFTXpLQUtCN2RPdlVGTG8yaFpBKzBLd0Vzc3ZacFpvSDEwYW5GelNE?=
 =?utf-8?B?cFFnaEUvVzg5cFJ5Qi93aVlaNVF5YW1MYjdvZEMrRnEwMVR2QUF3NWQwUGQ1?=
 =?utf-8?B?M3pBdEQ1U3FJaXRkeDd0RUV4a3JpdnpnNTN5SFMvc1NLRDIrNW9HaGtFS0VL?=
 =?utf-8?B?OVBkd2VsQVlJWW9id2pRa0hrSmZuK1EwWDdVZXp2VVM3aE1KV3NxZUZacjN6?=
 =?utf-8?B?d2ZWWXovVUVaWDRMbFVDelJKTnd5WnUrTWdReXpxMFhsdnZWelFhVmZhZHp5?=
 =?utf-8?B?THVwUHhpdDA0S3FBeU5KclpSQUQ5dExZRldCalgvRmdJODZrSHJ3STdDMlo0?=
 =?utf-8?B?bENaUXM5Um5oVDEwdks4Tk50YVN0Yno2bXA5U3ZHSjIzRjFtOUxOcnpFandT?=
 =?utf-8?B?eFREM3pxUklaQ1l5Mm1Hb0VQN3NyUUZsYTNRYkVlV2E5RkdIRXZQVkxXWDZW?=
 =?utf-8?Q?wAHPjKmwNH51ACVAG6wnwvvKr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <285F9562B46398439C678E77F63CBE14@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GI2cBTn9MBRRSgzFuwob9JYAJdQ1AYUN2/gSigThl8EUxIJp5iN26hmU20UyRP8Py5KkG0zV9fjsH/nmnnCcA5WNRkZ5Bhy6RlVNKEg1Yeb2qSfxq2ej5kB1kWXaOUD4EjVfFW/cIVxk7BRlYbXzeGgSN9qx8x7Je0eme9fniHmYDpZGQ3TfpU8UW2TGaHEANqzCNe2crcE28L9rVkxjrEfxEb++bMjOhTs+4d8pvlIfKaEPzuyXXhs1wcBQyM2syvolNwTCZs0yP3eWxztuT59phYoCvGuvOxdxWNVKxBB4PyEYins1oKbFfJ608ELGZsfEG/giMoZBzlqf5jUDk9P4ZxthkfFkceRaagEfbaYbsYV9uiNydReA4Z3XwOHkRcDJJvBTGcdA0jaVroL9S7tK5Mnnni/mJy/PqZTtt4J/+ZhY4ahedrOnCh0rtaqqrSDvBRRz7AIo3pDjfp4uRaEYjjCi2R621VfYS8gCTci27MGlyzK9SBOOVz60EotJNRnsSb6r7NTuH7LIPwh0IPlZPlyD+TE/fPhJkrUUCqjlGOWaORPV9VsxuRKWcvXzIAIJmp4ecLqR7y4mI2nGMy5ensz/uTXwoeQDEopc4JFK2Yf2JimkzRF0gug6AP4dj+kb9+gD0mCEhlCSAIyAlQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132f9723-a0e9-4e8f-fbf3-08dce7dbc10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 20:57:00.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srrP7GkkJ84uKWQnSzCC9u3frIXHFAVsWp8Yw3hfdI984y7bhCRkkNnAqjnSu6c+G3z/XKexDcwfiAq1NbaUGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
X-Proofpoint-ORIG-GUID: HVzoDxeSOySLq5v5jWc3acq95Dszt8ni
X-Authority-Analysis: v=2.4 cv=IOpQCRvG c=1 sm=1 tr=0 ts=67059ca4 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=6l8yH5Z2b49T-WqHoRUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HVzoDxeSOySLq5v5jWc3acq95Dszt8ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080136

SGksDQoNCk9uIE1vbiwgT2N0IDA3LCAyMDI0LCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiBIaSwN
Cj4gDQo+IE9uIDA1LzEwLzIwMjQgMDQ6MDQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBIaSwN
Cj4gPiANCj4gPiBPbiBUdWUsIE9jdCAwMSwgMjAyNCwgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4g
Pj4gU2luY2UgY29tbWl0IDZkNzM1NzIyMDYzYSAoInVzYjogZHdjMzogY29yZTogUHJldmVudCBw
aHkgc3VzcGVuZCBkdXJpbmcgaW5pdCIpLA0KPiA+PiBzeXN0ZW0gc3VzcGVuZCBpcyBicm9rZW4g
b24gQU02MiBUSSBwbGF0Zm9ybXMuDQo+ID4+DQo+ID4+IEJlZm9yZSB0aGF0IGNvbW1pdCwgYm90
aCBEV0MzX0dVU0IzUElQRUNUTF9TVVNQSFkgYW5kIERXQzNfR1VTQjJQSFlDRkdfU1VTUEhZDQo+
ID4+IGJpdHMgKGhlbmNlIGZvcnRoIGNhbGxlZCAyIFNVU1BIWSBiaXRzKSB3ZXJlIGJlaW5nIHNl
dCBkdXJpbmcgY29yZQ0KPiA+PiBpbml0aWFsaXphdGlvbiBhbmQgZXZlbiBkdXJpbmcgY29yZSBy
ZS1pbml0aWFsaXphdGlvbiBhZnRlciBhIHN5c3RlbQ0KPiA+PiBzdXNwZW5kL3Jlc3VtZS4NCj4g
Pj4NCj4gPj4gVGhlc2UgYml0cyBhcmUgcmVxdWlyZWQgdG8gYmUgc2V0IGZvciBzeXN0ZW0gc3Vz
cGVuZC9yZXN1bWUgdG8gd29yayBjb3JyZWN0bHkNCj4gPj4gb24gQU02MiBwbGF0Zm9ybXMuDQo+
ID4+DQo+ID4+IFNpbmNlIHRoYXQgY29tbWl0LCB0aGUgMiBTVVNQSFkgYml0cyBhcmUgbm90IHNl
dCBmb3IgREVWSUNFL09URyBtb2RlIGlmIGdhZGdldA0KPiA+PiBkcml2ZXIgaXMgbm90IGxvYWRl
ZCBhbmQgc3RhcnRlZC4NCj4gPj4gRm9yIEhvc3QgbW9kZSwgdGhlIDIgU1VTUEhZIGJpdHMgYXJl
IHNldCBiZWZvcmUgdGhlIGZpcnN0IHN5c3RlbSBzdXNwZW5kIGJ1dA0KPiA+PiBnZXQgY2xlYXJl
ZCBhdCBzeXN0ZW0gcmVzdW1lIGR1cmluZyBjb3JlIHJlLWluaXQgYW5kIGFyZSBuZXZlciBzZXQg
YWdhaW4uDQo+ID4+DQo+ID4+IFRoaXMgcGF0Y2ggcmVzb3ZsZXMgdGhlc2UgdHdvIGlzc3VlcyBi
eSBlbnN1cmluZyB0aGUgMiBTVVNQSFkgYml0cyBhcmUgc2V0DQo+ID4+IGJlZm9yZSBzeXN0ZW0g
c3VzcGVuZCBhbmQgcmVzdG9yZWQgdG8gdGhlIG9yaWdpbmFsIHN0YXRlIGR1cmluZyBzeXN0ZW0g
cmVzdW1lLg0KPiA+Pg0KPiA+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjkrDQo+
ID4+IEZpeGVzOiA2ZDczNTcyMjA2M2EgKCJ1c2I6IGR3YzM6IGNvcmU6IFByZXZlbnQgcGh5IHN1
c3BlbmQgZHVyaW5nIGluaXQiKQ0KPiA+PiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE1MTlkYmU3LTczYjYtNGFmYy1iZmUzLTIz
ZjRmNzVkNzcyZkBrZXJuZWwub3JnL19fOyEhQTRGMlI5R19wZyFhaENobTRNYUtkNlZHWXFibk00
WDFfcFlfanFhdllEdjVIdlBGYm1pY0t1aHZGc0J3bEVGaTF4TzVpdEd1SG1mamJSdVVTelJlSklT
ZjUtMWdYcHIkIA0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2Vy
bmVsLm9yZz4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDE2ICsr
KysrKysrKysrKysrKysNCj4gPj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDIgKysNCj4g
Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiA+PiBpbmRleCA5ZWIwODVmMzU5Y2UuLjEyMzM5MjJkNGQ1NCAxMDA2NDQNCj4gPj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gPj4gQEAgLTIzMzYsNiArMjMzNiw5IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2Nv
bW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiA+PiAgCXUzMiByZWc7
DQo+ID4+ICAJaW50IGk7DQo+ID4+ICANCj4gPj4gKwlkd2MtPnN1c3BoeV9zdGF0ZSA9ICEhKGR3
YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApKSAmDQo+ID4+ICsJCQkgICAg
RFdDM19HVVNCMlBIWUNGR19TVVNQSFkpOw0KPiA+PiArDQo+ID4+ICAJc3dpdGNoIChkd2MtPmN1
cnJlbnRfZHJfcm9sZSkgew0KPiA+PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0U6DQo+
ID4+ICAJCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+ID4+IEBAIC0yMzg3
LDYgKzIzOTAsMTEgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2Mz
ICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4+ICAJCWJyZWFrOw0KPiA+PiAgCX0NCj4gPj4g
IA0KPiA+PiArCWlmICghUE1TR19JU19BVVRPKG1zZykpIHsNCj4gPj4gKwkJaWYgKCFkd2MtPnN1
c3BoeV9zdGF0ZSkNCj4gPj4gKwkJCWR3YzNfZW5hYmxlX3N1c3BoeShkd2MsIHRydWUpOw0KPiA+
PiArCX0NCj4gPj4gKw0KPiA+PiAgCXJldHVybiAwOw0KPiA+PiAgfQ0KPiA+PiAgDQo+ID4+IEBA
IC0yNDU0LDYgKzI0NjIsMTQgQEAgc3RhdGljIGludCBkd2MzX3Jlc3VtZV9jb21tb24oc3RydWN0
IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPj4gIAkJYnJlYWs7DQo+ID4+ICAJfQ0K
PiA+PiAgDQo+ID4+ICsJaWYgKCFQTVNHX0lTX0FVVE8obXNnKSkgew0KPiA+PiArCQkvKiBkd2Mz
X2NvcmVfaW5pdF9mb3JfcmVzdW1lKCkgZGlzYWJsZXMgU1VTUEhZIHNvIGp1c3QgaGFuZGxlDQo+
ID4+ICsJCSAqIHRoZSBlbmFibGUgY2FzZQ0KPiA+PiArCQkgKi8NCj4gPiANCj4gPiBDYW4gd2Ug
bm90ZSB0aGF0IHRoaXMgaXMgYSBwYXJ0aWN1bGFyIGJlaGF2aW9yIG5lZWRlZCBmb3IgQU02MiBo
ZXJlPw0KPiA+IEFuZCBjYW4gd2UgdXNlIHRoaXMgY29tbWVudCBzdHlsZToNCj4gPiANCj4gPiAv
Kg0KPiA+ICAqIHh4eHh4DQo+ID4gICogeHh4eHgNCj4gPiAgKi8NCj4gDQo+IE9LLg0KPiANCj4g
PiANCj4gPiANCj4gPj4gKwkJaWYgKGR3Yy0+c3VzcGh5X3N0YXRlKQ0KPiA+IA0KPiA+IFNob3Vs
ZG4ndCB3ZSBjaGVjayBmb3IgaWYgKCFkd2MtPnN1c3BoeV9zdGF0ZSkgYW5kIGNsZWFyIHRoZSBz
dXNwaHkNCj4gPiBiaXRzPw0KPiANCj4gSW4gdGhhdCBjYXNlIGl0IHdvdWxkIGhhdmUgYWxyZWFk
eSBiZWVuIGNsZWFyZWQgc28gbm8gbmVlZCB0byBjaGVjaw0KPiBhbmQgY2xlYXIgYWdhaW4uDQo+
IA0KPiA+IA0KPiA+PiArCQkJZHdjM19lbmFibGVfc3VzcGh5KGR3YywgdHJ1ZSk7DQo+ID4gDQo+
ID4gVGhlIGR3YzNfZW5hYmxlX3N1c3BoeSgpIHNldCBhbmQgY2xlYXIgYm90aCBHVVNCM1BJUEVD
VExfU1VTUEhZIGFuZA0KPiA+IEdVU0IyUEhZQ0ZHX1NVU1BIWSwgcGVyaGFwcyB3ZSBzaG91bGQg
c3BsaXQgdGhhdCBmdW5jdGlvbiBvdXQgc28gd2UgY2FuDQo+ID4gb25seSBuZWVkIHRvIHNldCBm
b3IgR1VTQjJQSFlDRkdfU1VTUEhZIHNpbmNlIHlvdSBvbmx5IHRyYWNrIGZvciB0aGF0Lg0KPiAN
Cj4gQXMgIGR3YzNfZW5hYmxlX3N1c3BoeSgpIHNldHMgYW5kIGNsZWFycyBib3RoIEdVU0IzUElQ
RUNUTF9TVVNQSFkgYW5kDQo+IEdVU0IyUEhZQ0ZHX1NVU1BIWSB0b2dldGhlciBpdCBkb2Vzbid0
IHJlYWxseSBoZWxwIHRvIHRyYWNrIGJvdGgNCj4gc2VwYXJhdGVseSwgYnV0IGp1c3QgY29tcGxp
Y2F0ZXMgdGhpbmdzLg0KDQpUaGVuIHdlIHNob3VsZCBjaGVjayBpZiBlaXRoZXIgR1VTQjJQSFlD
RkdfU1VTUEhZIG9yIEdVU0IzUElQRUNUTF9TVVNQSFkNCmlzIHNldCwgdGhlbiBhcHBseSB0aGlz
Lg0KDQo+IA0KPiA+IA0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiAgCXJldHVybiAwOw0KPiA+PiAg
fQ0KPiA+PiAgDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4+IGluZGV4IGM3MTI0MGU4ZjdjNy4uYjJlZDVhYmE0
YzcyIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+PiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+PiBAQCAtMTE1MCw2ICsxMTUwLDcgQEAgc3Ry
dWN0IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ID4+ICAgKiBAc3lzX3dha2V1cDogc2V0IGlm
IHRoZSBkZXZpY2UgbWF5IGRvIHN5c3RlbSB3YWtldXAuDQo+ID4+ICAgKiBAd2FrZXVwX2NvbmZp
Z3VyZWQ6IHNldCBpZiB0aGUgZGV2aWNlIGlzIGNvbmZpZ3VyZWQgZm9yIHJlbW90ZSB3YWtldXAu
DQo+ID4+ICAgKiBAc3VzcGVuZGVkOiBzZXQgdG8gdHJhY2sgc3VzcGVuZCBldmVudCBkdWUgdG8g
VTMvTDIuDQo+ID4+ICsgKiBAc3VzcGh5X3N0YXRlOiBzdGF0ZSBvZiBEV0MzX0dVU0IyUEhZQ0ZH
X1NVU1BIWSBiZWZvcmUgUE0gc3VzcGVuZC4NCj4gPj4gICAqIEBpbW9kX2ludGVydmFsOiBzZXQg
dGhlIGludGVycnVwdCBtb2RlcmF0aW9uIGludGVydmFsIGluIDI1MG5zDQo+ID4+ICAgKgkJCWlu
Y3JlbWVudHMgb3IgMCB0byBkaXNhYmxlLg0KPiA+PiAgICogQG1heF9jZmdfZXBzOiBjdXJyZW50
IG1heCBudW1iZXIgb2YgSU4gZXBzIHVzZWQgYWNyb3NzIGFsbCBVU0IgY29uZmlncy4NCj4gPj4g
QEAgLTEzODIsNiArMTM4Myw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gPj4gIAl1bnNpZ25lZAkJc3lz
X3dha2V1cDoxOw0KPiA+PiAgCXVuc2lnbmVkCQl3YWtldXBfY29uZmlndXJlZDoxOw0KPiA+PiAg
CXVuc2lnbmVkCQlzdXNwZW5kZWQ6MTsNCj4gPj4gKwl1bnNpZ25lZAkJc3VzcGh5X3N0YXRlOjE7
DQo+ID4+ICANCj4gPj4gIAl1MTYJCQlpbW9kX2ludGVydmFsOw0KPiA+PiAgDQo+ID4+DQo+ID4+
IC0tLQ0KPiA+PiBiYXNlLWNvbW1pdDogOTg1MmQ4NWVjOWQ0OTJlYmVmNTZkYzVmMjI5NDE2Yzky
NTc1OGVkYw0KPiA+PiBjaGFuZ2UtaWQ6IDIwMjQwOTIzLWFtNjItbHBtLXVzYi1mNDIwOTE3YmQ3
MDcNCj4gPj4NCj4gPj4gQmVzdCByZWdhcmRzLA0KPiA+PiAtLSANCj4gPj4gUm9nZXIgUXVhZHJv
cyA8cm9nZXJxQGtlcm5lbC5vcmc+DQo+ID4+DQo+ID4gDQo+ID4gPHJhbnQvPg0KPiA+IFdoaWxl
IHJldmlld2luZyB5b3VyIGNoYW5nZSwgSSBzZWUgdGhhdCB3ZSBtaXN1c2UgdGhlDQo+ID4gZGlz
X3UyX3N1c3BoeV9xdWlyayB0byBtYWtlIHRoaXMgcHJvcGVydHkgYSBjb25kaXRpb25hbCB0aGlu
ZyBkdXJpbmcNCj4gPiBzdXNwZW5kIGFuZCByZXN1bWUgZm9yIGNlcnRhaW4gcGxhdGZvcm0uIFRo
YXQgYnVncyBtZSBiZWNhdXNlIHdlIGNhbid0DQo+ID4gZWFzaWx5IGNoYW5nZSBpdCB3aXRob3V0
IHRoZSByZXBvcnRlZCBoYXJkd2FyZSB0byB0ZXN0Lg0KPiA+IDwvcmFudD4NCj4gDQo+IE5vIGl0
IGlzIG5vdCBjb25kaXRpb25hbC4gaWYgZGlzX3UyX3N1c3BoeV9xdWlyayBvciBkaXNfdTNfc3Vz
cGh5X3F1aXJrDQo+IGlzIHNldCB0aGVuIHdlIG5ldmVyIGVuYWJsZSB0aGUgcmVzcGVjdGl2ZSBV
Mi9VMyBTVVNQSFkgYml0Lg0KPiANCg0KSSdtIG5vdCByZWZlcnJpbmcgdG8geW91ciBjaGFuZ2Uu
IEkgd2FzIHJlZmVycmluZyB0byB0aGlzIGluIHBhcnRpY3VsYXI6DQpiY2IxMjg3NzdhZjUgKCJ1
c2I6IGR3YzM6IGNvcmU6IFN1c3BlbmQgUEhZcyBvbiBydW50aW1lIHN1c3BlbmQgaW4gaG9zdCBt
b2RlIikNCg0KQlIsDQpUaGluaA==

