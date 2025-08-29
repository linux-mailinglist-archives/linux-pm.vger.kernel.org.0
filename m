Return-Path: <linux-pm+bounces-33349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71FB3AFE9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 02:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5483A98FE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 00:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7484D02;
	Fri, 29 Aug 2025 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lLVzruyb";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hNM37O8K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="moKwXG63"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14771FDA;
	Fri, 29 Aug 2025 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428218; cv=fail; b=gu3YO98mUM59bYN7WsDfDTPLUimiR0yOx+HbkhpBR0RPdvW4pjg00orJjuXorMM84y50Qw+OzUlpCtVMxkcpmWWyN8amhhdsi1A+bullkcOZ9CFyDvvZIDUhFAURvEOzAOyL52QoRIrKtnrcy6FfB1UfyRHRM/hMCjR5wJ4wMt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428218; c=relaxed/simple;
	bh=5McxChy5KvIm8mJZL3cN8iIS/WS1q8pub8sZq3c8mlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7OPmx2F8ttK/kCbg4UL4u5K/FFD4wMFA1OSMEk6BWOXQ+4MMma1MiM4c1+lLZYYRnAsWpWDKdF4Le3TXLUSKE8pyacK4fyb9HLaAdILWnORv+okTJckQZ68aLXxLBvvdL83GtvBNZwx4ib1qALdcH63UNyXc+chE8vp6NTt4Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lLVzruyb; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hNM37O8K; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=moKwXG63 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SJ7Wds004043;
	Thu, 28 Aug 2025 17:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=5McxChy5KvIm8mJZL3cN8iIS/WS1q8pub8sZq3c8mlE=; b=
	lLVzruybGJS4ElKJfr3nWvzv36IBJHwiFPy8sEQ8lr3mJ5npCpgh1oP7eTPjho+t
	xvkBiHM6Sh0YcD+Ux/3a8SMBoLmWGmmgOmRoF/sV4elezjcELAvsoQZjSYkUI9dy
	eAxm+/+7drRvkSxuHU5Bao9KvOGICywz46iSPSCM/9Ibzu47JVny5g1uyADenIHJ
	wty+uZoLKwvNw4UQaceokUII2/DvWO2uXaRcmInY8xvEq5NwJTnYmbmpltblYenj
	nVwrzLoa8SeIuRHzT1L9ot0T7GiQW8/NfdgGQdB3VQ+EwCEe12z1yLH1XgU3G39c
	yybbr7j8oyBePDYPV66fdg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48qc9ddes6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756428207; bh=5McxChy5KvIm8mJZL3cN8iIS/WS1q8pub8sZq3c8mlE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=hNM37O8KWmQM3uJcPPsSgMTgiUU2t7InWdO3WE/JR9I1WorHtfzoDtciOD0KvSkXt
	 przizW9CbMKwH+BrdErzGxPBguD9IktSKW9m2A4JJ4ATlDgG8fs5QvY+lyq/gWhxc3
	 zmC5PVzpBgjobgdtaxYd1TfYzEwwE3Y+/USYyK01DR4nri1eEp4LZH81LGDvFZ7BmI
	 pDfoRq9s6Q3ocFgRPBLaGQSvy60YyB0NXayvnBl59g34UlT3/XnTvtcWmo+o9C14RN
	 sGXuYxtbzsIPYaKJd5CzPeYUoulwkZV2U4cFD1ynYeba+hX7Ukr5DY21aol23JKizx
	 jdE+qhdSFhexg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F5B8401F0;
	Fri, 29 Aug 2025 00:43:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7F03AA00AE;
	Fri, 29 Aug 2025 00:43:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=moKwXG63;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9305F40087;
	Fri, 29 Aug 2025 00:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8ZDwy1vE2HTHdBvWW8LoLOuXZKGmKPkmLxrfpbvooWvO0DWG6oQuLg88hnEy4KDmUCIScA+5G3K3x3dHEkbMmIW1RkdD12nI28G5vIwv0nqle2Swhh5Nt40HR6aGvFAFLi5FS3HGaesZC4+PRzCvHcXqNvUEBAXGdG7LolO4Z5/1PjNuUs6vknEgJ7t49mA7O/jCxPpOd2saqNMQlne4BQg8cn0Ln8KwNk38FZgTobTQk7FIxge2fvGsDif9VFdf2e/F8609nHdmyeYicw8rLuMKWTWMbDvltImv1AAKSe3CqLro5JkZQUB2aCf/VZfHfsd2315hoVfEr5cAp9LIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5McxChy5KvIm8mJZL3cN8iIS/WS1q8pub8sZq3c8mlE=;
 b=K1NA/9DsyK10I1Ve+KgmDlT/sBY9UnyJe5NP84nIELOqG155/95U3gn5JpfeU8D8OUPudJOuUpSY7RAgdhMrBjr1AQxOxQ15GTNHGYigBrSY4BUgbT24FyzQ5x4R7ZzDzzXFqDXW+8HkkmY04IWtcqRer+Mea+s6vYljnqe7MsRJdDBaOZFeeJUFmsDbyR9e61BlD5qc3rlnzVY4ciAkV/y8KkCCh7O/0u8q9Olm/60pKS3hjPgVDtccR7WKDhcLHjyab8FM/kb5xrMqLSbni86Z3x2uwHrH/ChYuat2WvW0a6YvA2VQJittWGOvASp+yR7rBq1U4sg7SR7GWTeH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5McxChy5KvIm8mJZL3cN8iIS/WS1q8pub8sZq3c8mlE=;
 b=moKwXG63Cuq5pQO5K5akA9zjzw2EdPOcYY071Cnqo1JV7DzBdf2HNtHCesGCRvBKkWGh5iYOPaOLehGI8Tr92HdcLtTOardge8Nwo4dGYn3FTM5AkOUZnhQwFbTO+F/eOmk09X5PmaNsccao/smJCoVjZAtAReSvpjlrqK805D8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 00:43:17 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 00:43:17 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Alan Stern <stern@rowland.harvard.edu>, ryan zhou <ryanzhou54@gmail.com>,
        Roy Luo <royluo@google.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Topic: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Index: AQHcFpwLhCI1/x1c70ew6xjKTgeHrrR1Q/eAgAFHIgCAAAwMgIAARF6AgAHzEAA=
Date: Fri, 29 Aug 2025 00:43:17 +0000
Message-ID: <20250829004312.5fw5jxj2gpft75nx@synopsys.com>
References: <20250826150826.11096-1-ryanzhou54@gmail.com>
 <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
 <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CYYPR12MB8655:EE_
x-ms-office365-filtering-correlation-id: 3bc4226c-3ece-4907-8f7a-08dde6950b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjFXaXNkYW01eU1wT1lZS3pDNWdJNFJaT2NUMHBsYUlhQVc1c3UxcTAvZGVH?=
 =?utf-8?B?OUo2d2UwT0tjMkI1R2ZDZ3QrTU9zbFVuL0FFN1JOdURsOGlJNmh6TTRXb3h4?=
 =?utf-8?B?RTR0NXpzNG41NjdKenloRDBsbUEzRHBNbnV6TEVmVWdyMjExSmZjSHNIOGJl?=
 =?utf-8?B?TWhieGxJVVhienU2djl4NTR4ZzM5ZVl3aTQ2R0wyUWFBb2lLOHNpZHBGUlRl?=
 =?utf-8?B?Q1NoQm9XSWh4WDVLVGEyOHA0dy9tMHllNVp1bjBaVWdMaURmVUt3bmFTbzl4?=
 =?utf-8?B?elpNbm55QlR2OHRQMzhDeEhCeXNnVXFvL1JNUWRLUmo2VmFXUzZuQTEwL1Fo?=
 =?utf-8?B?N0RhaDM1eFdxWWRpN3QwbFROYnVKdzA2OGVYRTF6dkVueW1YaTNjTlZXWGRa?=
 =?utf-8?B?eHl0M1l0V2Q1VS9TVGZiVjZuMStYaG1nV3dkNE56bHhLZXFyWXJMTVkydm9T?=
 =?utf-8?B?NzBab3dUSnV2b0JBcWFXdlVtWnZnUHZMaDlJWmIvLzdXYlQzVktYTUNnZ0VU?=
 =?utf-8?B?djJQUHNoQjRCK25jSFI0V2RpTUg0Z1FBZFZ4cTg4bHNzcDdFejQxWEpXTVRx?=
 =?utf-8?B?Zjh2empQSU1FZ3ZwcjZzbDVjVTJNV1FiQXAyS3hteFREaThiRExjMDM5M2NF?=
 =?utf-8?B?Mmg1SEJMSW56MWEyWml1TkdWR3FtZTlHc1lBS2lzSTdIYyszSDNHWkZlQklY?=
 =?utf-8?B?SzNyYVkwd2R0TUNyQjRMeEpMSDJQMWs5dlBIWGt4YXFoWlFNNVA3QWRyazJ1?=
 =?utf-8?B?NUcxY2JFODljTm11NDFCMysvSnQ2YU1iRWVWd3dEVEVjWVVlTlJZNE9nRTN3?=
 =?utf-8?B?K3N1dFV6dEticzN0VHg3d3VLYktkNXJ4MTlZWFd5NStOVHZHb3VKbWFuaUhL?=
 =?utf-8?B?RlpUTUViaVRQTjRJbndLQzU4YnF1dUsxZUkxeis1bFNxZWMrSTF1UWcwMjFB?=
 =?utf-8?B?MnZNamNJL1Jaa25TY3M3MTJLaEhMQ0VibFJHRXdFQ2djcUhKeWtRaG1mUERr?=
 =?utf-8?B?NlNWd0hKUDF6L2plLzJvUFZyTk81VUtQNVZBRHYvMlQ5NEVaZklOeXZ5SG9J?=
 =?utf-8?B?QnhMUVFlQmZpWnpseHk0VC85S0RWY1JnY2N2ZER6MVdYLzBvU2ZsZENSdHNy?=
 =?utf-8?B?Zmp0SHliMFQ0YngvQlFIOWxVQWNjaVRvTW5QdVVVT05CMWxyKzhUTWkxV2lh?=
 =?utf-8?B?bXM5NVpLVEFpTW5td1A1NFp0MzlOeVBVRzBJeHY3dERpNTU2Qk9YTjYrbEw1?=
 =?utf-8?B?bitLQ3o0ZE42bW4wZ3Z3Qm5mY1pnczlEbTJWYzROL3BzcitVbTd5R1ZxM0FR?=
 =?utf-8?B?K0pqbXZJVlRoemsrNkhmTXBrNTBXSTIxdDVnTUJWTkE5K3F3UzI2bERLbnZQ?=
 =?utf-8?B?Sm9YbGtXRWpFZGZCNnYyaDhQdUwyaE9FdnZrcTJnNEw4UU01RVRHZHJja01u?=
 =?utf-8?B?MlVRbVFNSHF2M2JVaGdvVW85UWJvbXJPSnBKZlBNRVRTWDVOWGZHd2Z5b1g3?=
 =?utf-8?B?bkFKbjg5Nk9BZjJNcXRIdXRPUENKMldXaHExYjR4SmtrMTVsUGV1VnkydDRO?=
 =?utf-8?B?TzVha3BNM0dTZjBlMTRyL3RMd2RkaDdmcGROaWtOV0xBOFdsWUhXc0dlZnlm?=
 =?utf-8?B?SHErYUJHT1BGbGVhOXpKZld4MGZjUkxXWVhzQnBXR2grTHFqL0hMVVI1RG1r?=
 =?utf-8?B?dVF2TGxhckF2RVRRMzdhWkpqRStsVS9HcjRHc3N1YnBRSWl2cUp1eENJbno5?=
 =?utf-8?B?MUJ4TTJUNmJQSDIyMDRJUlNKMTc1ek9jWEZacllVZnRYRkxXUzRDRFJpcERn?=
 =?utf-8?B?YnNqTTBoMTJwcDlKd1RFQ2p6Vy96ckxaT25BTCtLWHBhYWNKeXdCTG1wV01V?=
 =?utf-8?B?NUdMMjBMa2h2dm05bll0eGlkQWt0VDZWS1lOLzRONVhQODVvRlhzVnFqQm1U?=
 =?utf-8?B?TmxjK1JuNGtmN29VWnI0YTdWWHVEck43K3VNVWlUa3dkOFdldU1LWXZmdllP?=
 =?utf-8?B?UTBmL1A4MDlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ME5WTHVhOGdlL2pPTEY4SHQra2ZvNWF3SnlwalZpS0RLQ05qeGt5elN4aEM5?=
 =?utf-8?B?bjNHUVpoNVIyemVMY0x3cXZKZG9jL3plQVp1Y1liRTNQQzNXZjA1WDlwYzRO?=
 =?utf-8?B?M1VwQTlSV3hMbUl4ZE1jVW05QzFFYmhsVlkwc25GbXMreGtXU21XOHBDMGRG?=
 =?utf-8?B?SkhCSmJaS0sweGFYaWpYeW5wUTJrZHUvaFVhZmdKRS9idTVvTDJXbkVxcEVy?=
 =?utf-8?B?RExIQ09Ed2hDemtwRExLOTdta3dVemVvL0FIbm5oWlFkU3hsVitCWCt2VkxX?=
 =?utf-8?B?aVpvTFlkNktVNThzZVc0VnVrbmdWYTZ5OUhqekg4L3p3Mmh3ODlUZHd5STlI?=
 =?utf-8?B?VXZsRlJ1RDg5YTlQamRCdi9jZjRTTHEyOGtNUU1JL3JyS1dYTVhpUU9SaFFx?=
 =?utf-8?B?MlE0cDk5MEZQN1p3ekR6N0FITkpoMVh0SXh3Wnk0SHNNWmlJbHNIdkM1Mmc1?=
 =?utf-8?B?L0hDMTFWejBxd25vZFVibjhLTWdhQk9IMlRpTDM5cDdzb3pmVCtQbVdkYTRy?=
 =?utf-8?B?REVJSFFKQlBYUHN0SWthN2NXTEpBTitkbVRVem5ET2k5Y2lNVmxHV0V3VC96?=
 =?utf-8?B?aHZWUSthTitac3V2d1BlYmRtaEVBSCtBcDF1VlBST2lzT05hT2hoUnhhMzNo?=
 =?utf-8?B?NE05dnZJYkYyZzh5MWh2QncrNy9BVldOc3VFSTRtZXZhUU9ZZEc2SU5ucmNU?=
 =?utf-8?B?eko1R1crcldPZG93RnBuSCtLMWZlYXZGckxtdjlESDVxTzlPb1lKbHh6aEtw?=
 =?utf-8?B?TlBmUVRzdlAyZGVVcXdBZ0ZnZzVVMmNoQjBBcWV5RzVUSE1UMzU2R0NzU2kw?=
 =?utf-8?B?Wk8rYlQ5MEx3clN1ZVQvczFtWFNZdndDSnBiK0ZuZXpnUVdlandST0ZaS0d2?=
 =?utf-8?B?VnR0OGpwUy96RUJBZE1rQmh1OG1QUW5OWlEyUkFvakt0dVB2TFpmbGh5RGRs?=
 =?utf-8?B?QllIbDlidEdsYm9LN0JiQklwMHRmSnpyaFppV3BRNkhvTUdWSXFYNnJHck02?=
 =?utf-8?B?b01zV2wySzdycncyRnNDczBvb0ZTcW1uZkl0YU1oSXFkWkRXRnpVZktOeS81?=
 =?utf-8?B?cjZOMjE4NXZuNUphb0ZESks5SUtxRk02WVp6M2xtMWNVWkd3ZWYrb2l2cTcr?=
 =?utf-8?B?UjVzRVJVUnAzdzBoVU9hekZXU1lCYjlJQmw5WDRMMEFRK2hCbzRNd3NBbXcv?=
 =?utf-8?B?YUtjdEZPTFZvL3g0YzBQL01zbG9QODB6SHp2V0N4UkxIWHRmTERJZW4vYVFo?=
 =?utf-8?B?R1VLWmNSWjk1b0FXclplR1dTYXU1QnJwWU1pM2gxWnQ3OU9BU2dHelg1QXQy?=
 =?utf-8?B?T01ESUhrbER1RkpmREJxNnZaZ2lXVks3YWdpQW8zM2RTS3kzTmZmOGhETzlM?=
 =?utf-8?B?ZjEvZVd2Vnd0YTZvYW9PK1A4UDZUZlc3c2tERTNKbGkvUkcxTE80S2FEUWpr?=
 =?utf-8?B?WTNRNkkwRHBzYTZ3YTBUWFZnL0dBWWJXaUF1alcwaVp3M3RJdTdYNDJtV3Zm?=
 =?utf-8?B?UmFBTVZBT3hVRUNMc1ljc2JZMlczVGlCSTRkZmdJN2EzVHRWQTd4MlgvYWZ4?=
 =?utf-8?B?eGROaCtlaHZqVHJhenZENHNndFM3WGVSbHhqTXBXTUlxMHhZYXFNajdzdDFC?=
 =?utf-8?B?dmV5S20vb2lXMzIvRjJvOXJvZWtKL1c3ZGlVRkI3QktHRUl1NTdKVjc3Wlh5?=
 =?utf-8?B?Vm1wMFdGYXNmcnVhV0E5WEMzSnZVV1BKeHRrK240RjlycWt0aDJQZXBSai9h?=
 =?utf-8?B?UEtSeGtaKys4S1VkUjExRUJjZUtjWHNxZW5jeUxDdUtJeVBSYlVJQ0xmaFE5?=
 =?utf-8?B?aE1lbm15VGxZNkNHNDJVMTJvdmJiTzNjZldyVlN2R2cwYTlITTRTWU9ONW5L?=
 =?utf-8?B?UGpHY2JkVnhKZWNINzZxZndtS0ROQzFlUWhKUzEyMXBBdnYxdTdpUGVWK25v?=
 =?utf-8?B?OC80Sm9nbVhNT2IzeThodWhnRXVOZUV2SXJrcUZJMWNUakhXbVV6ODg5ZXFP?=
 =?utf-8?B?STQ0cTFOVE42U21PTGN1K3NuTVF4MkgyK0ZzeUphd1NIQWNKZlNHOXIwUFJC?=
 =?utf-8?B?QVk2RU5Bd3pzM1ZGblZkN2NYdEJOS3B4SnI1VHBZazgzdmpibDJJbWtSdFRU?=
 =?utf-8?Q?fMWFHcTtWh1RMGFepGfJIvFmN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA80E04DD7B7AE4F9BD93746C2F703D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kG+aoVoM2W/cgpmd5uP04aHHuvSChthlVRXsPGKIYuybdvvfEklJK3d2ETdS/ZaxyTKawgxiY3MtwXpW2e8sxEhiCJmxKgDddAcI5uigdCmZ1JKhNjfhtb++I8NZMcjL39lMZmlqJ2+KMnp3LSO2B5thUjPGpykPSJARraeu/mPSPp1ZnEynxHr3bMbveOEYE7i6qeWXIcQNvvNtg8vBxsab8HEu4Y7qnJreXn2gvp4Inh28lG/6mxawixAwzJhYdQRA1tQz9PnbO1ABtCg/fNDFcYvP46nZErAyHoLqJ15oKm5/aRnP99qcTFJe0mKyS0T3ZIKB2FLUYupeBWmzt/klcMBxBLcmaaHlA0MvyfulI5rsED2oa/EL1l3q/DnNzfwaFSoZOVOds0pJ6IONNgCag66JX3LlfmjM1nl0nGF9w25ZStdSOSi8PbleJ3gohfb0WaP2OzoPC7ouliUcUf97Y2mg3AR00hHGOm2Vc2SB3gh4w+cdHyBLmxWqcJzceP/Tyla+0WvB5+HwDmO5hLDqqlk+AxokzxTwsNWNdJ7q5TO9fI9YTIPYDgYVyHfTrg0S5/h6h80UhO+EhrHW+5O1BIYhAstfw/FmGFUBguQyPJ9EVkCdhs/2tJ3e4+0I23naV748SlnJMu2bpNEDxw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc4226c-3ece-4907-8f7a-08dde6950b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 00:43:17.5685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DCye9w+xjVYzbe5swfOFwwOpCr19AGRpbm42BVJpzNVFvprILcD1S/EaHr1b9zLk6vFE6TErCwI1mEis5QFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDEwNyBTYWx0ZWRfX4pJCKr7R70Yc
 U70NqaAq0/5xDs/YfMCb/HFTSJWPwDSxzWstGkFx6Q/iNhDSnz15mH2l37t0u1ZP3I+kvjE6rz/
 1n1PcM2ewISUy4R+W+zB2rcy6qms7XAWBBXynOKMjLXom0yH+KfLVUfEKT7Of39B9SBuWYqo9K6
 gJQo4DVQopksoRmsL+wQmW/PWWxWn3pTbX1sZh0xS9/G9UeVxYRa8enu6heMW3SrGeGQ55jSrEw
 SNq94UWYZ+Qbn6gDx8hPWG5w/gf4ZhCUe17DcHYNdbKms+877AH6pYOGf27lrIIa1/9y6+iSp9q
 2i17M4Zxp9pqa1SWOpQbD/1s3cfBCYPA9ERlmlsVsp8TW1Nlk7m0hrLdxfY1H5wo6Qn0ogvbK1z
 QmSIF72T
X-Authority-Analysis: v=2.4 cv=TbGWtQQh c=1 sm=1 tr=0 ts=68b0f7b0 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=0nVEsHsK_qYor8nofYUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EJ1O_Zy6R6dWYrwiycLkMf3aOxB6aOwX
X-Proofpoint-ORIG-GUID: EJ1O_Zy6R6dWYrwiycLkMf3aOxB6aOwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508230107

T24gV2VkLCBBdWcgMjcsIDIwMjUsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiBXZWQs
IEF1ZyAyNywgMjAyNSBhdCA0OjUy4oCvUE0gQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5oYXJ2
YXJkLmVkdT4gd3JvdGU6DQo+ID4NCj4gPiBSeWFuOg0KPiA+DQo+ID4gWW91IHNob3VsZCBwcmVz
ZW50IHlvdXIgcXVlc3Rpb25zIHRvIHRoZSBtYWludGFpbmVyIG9mIHRoZSBrZXJuZWwncw0KPiA+
IFBvd2VyIE1hbmFnZW1lbnQgc3Vic3lzdGVtLCBSYWZhZWwgV3lzb2NraSAoYWRkZWQgdG8gdGhl
IFRvOiBsaXN0IGZvcg0KPiA+IHRoaXMgZW1haWwpLg0KPiANCj4gVGhhbmtzIEFsYW4hDQo+IA0K
PiANCj4gPiBPbiBXZWQsIEF1ZyAyNywgMjAyNSBhdCAxMDowOToxMFBNICswODAwLCByeWFuIHpo
b3Ugd3JvdGU6DQo+ID4gPiBIaSBSb3ksDQo+ID4gPiBUaGFuayB5b3UgZm9yIHJldmlld2luZyBt
eSBwYXRjaC4NCj4gPiA+ID4NCj4gPiA+ID4gV291bGRuJ3QgdGhlIHBhcmVudCBnbHVlIGRldiBh
bHJlYWR5IHJlc3VtZSBiZWZvcmUgcmVzdW1pbmcgdGhlIGNoaWxkIGR3YzM/DQo+ID4gPiA+DQo+
ID4gPiBObywgaW4gdGhlIGZvbGxvd2luZyBjYXNlLCB0aGUgcGFyZW50IGRldmljZSB3aWxsIG5v
dCBiZSByZXZpZXdlZA0KPiA+ID4gYmVmb3JlIHJlc3VtaW5nIHRoZSBjaGlsZCBkZXZpY2UuDQo+
ID4gPiBUYWtpbmcgdGhlICdpbXg4bXAtZHdjMycgZHJpdmVyIGFzIGFuIGV4YW1wbGUuDQo+ID4g
PiBTdGVwIDEudXNiIGRpc2Nvbm5lY3QgdHJpZ2dlcjogdGhlIGNoaWxkIGRldmljZSBkd2MzIGVu
dGVyIHJ1bnRpbWUNCj4gPiA+IHN1c3BlbmQgc3RhdGUgZmlyc3RseSwgZm9sbG93ZWQgYnkNCj4g
PiA+IHRoZSBwYXJlbnQgZGV2aWNlIGlteDhtcC1kd2MzIGVudGVycyBydW50aW1lIHN1c3BlbmQN
Cj4gPiA+IGZsb3c6ZHdjM19ydW50aW1lX3N1c3BlbmQtPmR3YzNfaW14OG1wX3J1bnRpbWVfc3Vz
cGVuZA0KPiA+ID4gU3RlcDIuc3lzdGVtIGRlZXAgdHJpZ2dlcjpjb25zaXN0ZW50IHdpdGggdGhl
IHJ1bnRpbWUgc3VzcGVuZCBmbG93LA0KPiA+ID4gY2hpbGQgZW50ZXJzIHBtIHN1c3BlbmQgYW5k
IGZvbGxvd2VkDQo+ID4gPiBieSBwYXJlbnQNCj4gPiA+IGZsb3c6IGR3YzNfcG1fc3VzcGVuZC0+
ZHdjM19pbXg4bXBfcG1fc3VzcGVuZA0KPiA+ID4gU3RlcDM6IEFmdGVyIGR3YzNfcG1fc3VzcGVu
ZCwgYW5kIGJlZm9yZSBkd2MzX2lteDhtcF9wbV9zdXNwZW5kLCBhDQo+ID4gPiB0YXNrIHRlcm1p
bmF0ZWQgdGhlIHN5c3RlbSBzdXNwZW5kIHByb2Nlc3MNCj4gPiA+IC4gVGhlIHN5c3RlbSB3aWxs
IHJlc3VtZSBmcm9tIHRoZSBjaGVja3BvaW50LCBhbmQgcmVzdW1lIGRldmljZXMgaW4NCj4gPiA+
IHRoZSBzdXNwZW5kZWQgc3RhdGUgaW4gdGhlIHJldmVyc2UNCj4gPiA+IG9mIHBtIHN1c3BlbmQs
IGJ1dCBleGNsdWRpbmcgdGhlIHBhcmVudCBkZXZpY2UgaW14OG1wLWR3YzMgc2luY2UgaXQNCj4g
PiA+IGRpZCBub3QgZXhlY3V0ZSB0aGUgc3VzcGVuZCBwcm9jZXNzLg0KPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID5XaHkgd291bGQgJ3J1bnRpbWUgUE0gdHJ5aW5nIHRvIGFjdGl2YXRlIGNoaWxkIGRl
dmljZSB4eHguZHdjMyBidXQgcGFyZW50IGlzIG5vdCBhY3RpdmUnIGhhcHBlbiBpbiB0aGUgZmly
c3QgcGxhY2U/DQo+ID4gPiA+DQo+ID4gPiBGb2xsb3dpbmcgdGhlIGFib3ZlIGFuYWx5c2lzLCBk
d2MzX3Jlc3VtZSBjYWxscw0KPiANCj4gSSBhc3N1bWUgdGhhdCBkd2MzX3BtX3Jlc3VtZSgpIGlz
IG1lYW50IGhlcmUuDQo+IA0KPiA+ID4gcG1fcnVudGltZV9zZXRfYWN0aXZlKGRldiksIGl0IGNo
ZWNrcyB0aGUNCj4gPiA+IHBhcmVudC5wb3dlci0+cnVudGltZV9zdGF0dXMgaXMgbm90IFJQTV9B
Q1RJVkUgYW5kIG91dHB1dHMgdGhlIGVycm9yIGxvZy4NCj4gDQo+IEFuZCBpdCBkb2VzIHNvIGJl
Y2F1c2UgZW5hYmxpbmcgcnVudGltZSBQTSBmb3IgdGhlIGNoaWxkIHdpdGgNCj4gcnVudGltZV9z
dGF0dXMgPT0gUlBNX0FDVElWRSBkb2VzIG5vdCBtYWtlIHNlbnNlIHdoZW4gdGhlIHBhcmVudCBo
YXMNCj4gcnVudGltZSBQTSBlbmFibGVkIGFuZCBpdHMgc3RhdHVzIGlzIG5vdCBSUE1fQUNUSVZF
Lg0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgcnVudGltZSBQTSBzdGF0dXMgb2YgdGhlIHBhcmVu
dCBpcyBub3QgYXMgZXhwZWN0ZWQsDQoNClNvIGlzIHRoZSBzY2VuYXJpbyBSeWFuIGJyb3VnaHQg
dXAgdW5leHBlY3RlZD8gV2hhdCBhcmUgd2UgbWlzc2luZyBoZXJlDQphbmQgd2hlcmUgc2hvdWxk
IHRoZSBmaXggYmUgaW4/DQoNCj4gYnV0IHF1aXRlIGZyYW5rbHkgSSBkb24ndCBxdWl0ZSBmb2xs
b3cgdGhlIGxvZ2ljIGluIGR3YzNfcG1fcmVzdW1lKCkuDQo+IA0KPiBXaHkgZG9lcyBpdCBkaXNh
YmxlIHJ1bnRpbWUgUE0ganVzdCBmb3IgdGhlIGR1cmF0aW9uIG9mDQo+IGR3YzNfcmVzdW1lX2Nv
bW1vbigpPyAgSWYgcnVudGltZSBQTSBpcyBmdW5jdGlvbmFsIGJlZm9yZSB0aGUNCj4gcG1fcnVu
dGltZV9kaXNhYmxlKCkgY2FsbCBpbiBkd2MzX3BtX3Jlc3VtZSgpLCB0aGUgZGV2aWNlIG1heSBh
cyB3ZWxsDQo+IGJlIHJlc3VtZWQgYnkgY2FsbGluZyBwbV9ydW50aW1lX3Jlc3VtZSgpIG9uIGl0
IHdpdGhvdXQgZGlzYWJsaW5nDQo+IHJ1bnRpbWUgUE0uICBJbiB0dXJuLCBpZiBydW50aW1lIFBN
IGlzIG5vdCBmdW5jdGlvbmFsIGF0IHRoYXQgcG9pbnQsDQo+IGl0IHNob3VsZCBub3QgYmUgZW5h
YmxlZC4NCg0KQmFzZSBvbiBnaXQtYmxhbWUsIEkgaG9wZSB0aGlzIHdpbGwgYW5zd2VyIHlvdXIg
cXVlc3Rpb246DQoNCiAgICA2OGMyNmZlNTgxODIgKCJ1c2I6IGR3YzM6IHNldCBwbSBydW50aW1l
IGFjdGl2ZSBiZWZvcmUgcmVzdW1lIGNvbW1vbiIpDQoNCiAgICBGb3IgZGV2aWNlIG1vZGUsIGlm
IFBNIHJ1bnRpbWUgYXV0b3N1c3BlbmQgZmVhdHVyZSBlbmFibGVkLCB0aGUNCiAgICBydW50aW1l
IHBvd2VyIHN0YXR1cyBvZiBkd2MzIG1heSBiZSBzdXNwZW5kZWQgd2hlbiBydW4gZHdjM19yZXN1
bWUoKSwNCiAgICBhbmQgZHdjMyBnYWRnZXQgd291bGQgbm90IGJlIGNvbmZpZ3VyZWQgaW4gZHdj
M19nYWRnZXRfcnVuX3N0b3AoKS4NCiAgICBJdCB3b3VsZCBjYXVzZSBnYWRnZXQgY29ubmVjdGVk
IGZhaWxlZCBpZiBVU0IgY2FibGUgaGFzIGJlZW4gcGx1Z2dlZA0KICAgIGJlZm9yZSBQTSByZXN1
bWUuIFNvIG1vdmUgZm9yd2FyZCBwbV9ydW50aW1lX3NldF9hY3RpdmUoKSB0byBmaXggaXQuDQoN
Cg0KSW4gY2VydGFpbiBwbGF0Zm9ybXMsIHRoZXkgcHJvYmFibHkgbmVlZCB0aGUgcGh5IHRvIGJl
IGFjdGl2ZSB0byBwZXJmb3JtDQpkd2MzX3Jlc3VtZV9jb21tb24oKS4NCg0KQlIsDQpUaGluaA==

