Return-Path: <linux-pm+bounces-34426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97320B52644
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 04:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A77BA856
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 02:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5E1DBB13;
	Thu, 11 Sep 2025 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HJnKq9QU";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MUt1ce2A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZLmP9377"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE8173;
	Thu, 11 Sep 2025 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757556192; cv=fail; b=HHMO/ArtJd+CgjYXra8iNksgB4+BHCRwKNNtR8TBtixQmkMkI9R0BQshsK9Y+nN0y71l/sFku72Wkec3hIGXtz7NfSoygcf2SDBZh1RIzuo7RDX5Dim+GAi1823Mns269T/MiOO3ULPfMkgsKqZFM/BmwP4vnwa8YuZJe7DuX2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757556192; c=relaxed/simple;
	bh=Uh+RRc0yo34IQmLWQygQr5quBo+lpe3KfYTJ80c0GL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SePp7NC0kDenozaCFcRDwy5tQACSg3bpgwk38PD98yOfWUB84EO7AiaGiEwO5je/RRwtlLBgoy80UqSjMAdUKp5ZITLt/H3JHPdDNrLCM5LkYUVS72g+itmoe0YaVxeTM01t6Uv3kIDZfkQVeYKbwoK307Tt7ef0qXyMWGA3bxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HJnKq9QU; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MUt1ce2A; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZLmP9377 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALSuKv024090;
	Wed, 10 Sep 2025 18:32:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Uh+RRc0yo34IQmLWQygQr5quBo+lpe3KfYTJ80c0GL8=; b=
	HJnKq9QUk35GkaDG5KBkURhtKKa9XgLRkWBktz4Kj2IwlSDjrolhpFwoUolb5e/0
	2evfu1TVcQGapZydNBztMPRhmXjjqOXI5lUDcmHS5tAScHcNdBlaVDQlP0ajTjIS
	agHlzwKXme2IgVB0PXuzR9Hq9bxlp0VpuPTCCeleXBH52lwLYKeqSQUzDUQ291CL
	657GcQOOyQONuBziYTyFl08ygv3UBC01J78ATAq33VJy0rn7KlRZv3Podmvt7AOv
	uNmeXcMbShhorkef4hoFwOQC3e1i5DbhaP98BUYJrmAjXGQrXZOaohiKnKBsHZ4t
	d88v5zTjp9Rc3geonMW05w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 490kymyahy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1757554374; bh=Uh+RRc0yo34IQmLWQygQr5quBo+lpe3KfYTJ80c0GL8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MUt1ce2A66gWKj/8nLWraAQ7iCB+3HeSjN7MZrTzlNBCChkIIjGASfRsDRWskch/9
	 2bucs8IP75Xr7YwDUFM9fUmsWzlUuZmHomO+AkufY4fR3BncHoEUl6TvB52kTxtiSy
	 iQJcJg3+xLKqxoHf0Y5puuyDixTFYSU+N6cHQqexyvgPphO5PzSzkGNHKB55s1u2k7
	 GcDCiZGw/5RKrUowTQnkyTcTv/Tq6iwtP62BrMAii/cQ7kW4+RQVYAQz0byxOVCVy1
	 ML4LoofjlxYKztsrdz2VXnLjWnHmY7NinSrXxQ1ibogDkLTL+8+U8eh6lqAoV4H5i6
	 8n5pNoIkZZt0Q==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C346A404B0;
	Thu, 11 Sep 2025 01:32:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 58C33A0071;
	Thu, 11 Sep 2025 01:32:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZLmP9377;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8695840532;
	Thu, 11 Sep 2025 01:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TB0eqi6MfIo5T2k9XoLV5BWROK8fR046gm1t225TAqgbhqqxTb6jJPlgCZ1RmxJ4CqMSRQ+zb+hjkcpGKb1we98UqKdGf0gTIbhkA4Yy3XtsS6B8OcU2MHK7wHfM7d+JS/ByOVMA5fd17Kv94lMmOzftLn1QrahmQCzvccVBrFii2B9EQ2XRSdiGQlGrady9aOECp9icJXHVAa27mpo/wjeivEl4bGwf+xcDNuwIEI8QsDOLBRkt7LkCo/CXAi40zgS43erhFYkweYO+fcNO90JgDsoJu0Oni1EpxYqsf9QMUaoWUPsLz3dUjDXjYy26vgmJso/Kri8HQs21lNUhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh+RRc0yo34IQmLWQygQr5quBo+lpe3KfYTJ80c0GL8=;
 b=s2HCxlfHGoE7BtazUJrx2dPJmizrAZtqLiiwvLnoxR7zqYBFN29v9fJ3XWog3Evy9s6/UshE7QLCccvvkQC686enaqd60iUt9MAh2WzdtBWZoC2nIJI3WeQkcFSSC1x5JBqReHVdor9U51xjSrX9ZGDGlEtjfZDQTwMwFmlO9e7ws1VPjq7ZVkiQsPm/PCIubBo9580gAwwHXDnUqoj/MWdAmKhdQmoU6AJQy19P9Yr8dWsl+Je03jkpgU/y1gttXOObrzNhByi06z4UqFzkjUu1xmMLEpprRmF8bXlM4VMKeEApoREW5HX2l+9SjMjxMcnceKBwRlWtXlMmF8OJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh+RRc0yo34IQmLWQygQr5quBo+lpe3KfYTJ80c0GL8=;
 b=ZLmP9377cwvvR5wTZ6rWCGkN6CtUx6U2Y2nUncRluyATbRjNvnNvVNImt+aCXrnxGUltLXQTcETxXSZp/qxKxPZj8rtToqo78PiqritDsVJNutfvVjDzpfhrjgsFJf2QlUNMHW1Cs8zzKzSw1MxOs3ADNF5zm7ItB+mvZur3ztY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 01:32:47 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 01:32:47 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Ryan Zhou <ryanzhou54@gmail.com>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "royluo@google.com" <royluo@google.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Topic: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Index: AQHcIaV6iqN+tbk/4EyT54IWmyl0IbSNNKMA
Date: Thu, 11 Sep 2025 01:32:47 +0000
Message-ID: <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com>
In-Reply-To: <20250909161901.10733-1-ryanzhou54@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB6056:EE_
x-ms-office365-filtering-correlation-id: 522edce6-987f-4eb0-eb4f-08ddf0d31d38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3pDY09sTjF4M0I5dDY3c2daTWRjMHBMZlVabUtNcXhOMUJEVm8wQnk4Y2do?=
 =?utf-8?B?ZjZSSHdCdFI0dmJkUlhKS0ZlSTlYWSs5UDk1eURZeUJPNndpQm9XWGRmc2Vu?=
 =?utf-8?B?cGg5c2drZGd5OVladE9UUE12MkRnOFlyVUIvUkIvR3FsQTkraUcwOFlXYnoz?=
 =?utf-8?B?RXlPM3EwUUNpelYzRnA2eDlEZGlkZ25GTXh3ajFYNFpKUFQzR0FmZlJvcVZv?=
 =?utf-8?B?SU56YnUvS0RJQkFJbTJYdFRUdUZuU2VqcHgxTmJBZHVYU0lmamgyNlh5ei8z?=
 =?utf-8?B?Nm9POUVaQkhUYjFONVI5WjBEc0NNZHlld3hGNHhzV251NVZyRzNaY3kyRGNs?=
 =?utf-8?B?UHNQSEp6VlBIVEljcnNOUnlpMGhZSDllT2p1SmpqQU4yK25kT3R0ZzV6eVND?=
 =?utf-8?B?NHBiOTVwMEVxU3dkek4zbTdDTHlsM056K0RLRERSR0pKeGw5VTZBbEdOQTdt?=
 =?utf-8?B?R1NQRnZUd0o0bUNKL0gwTUM2Um51VnN5S3ErZ0wxM2F4UXJ1TjF1VkxEUTJX?=
 =?utf-8?B?U3dxRkVRallBT0Nhd1kwcUQzSUVTangwQUZzNVJUUWpoclRnam14cHk2c0pD?=
 =?utf-8?B?bkk2cjJ1clZzOVEzUGpIdFlZMEFwRHVpMUIwRDJlYjRlNDlOQmNQMjhVYkhT?=
 =?utf-8?B?L0RjU3JHYlJjUTZzZ0E4eVFEK1ZBU2NZOVpSZlY2akg0ZjVwODJmWFZEUXA3?=
 =?utf-8?B?Z1U2QjlkWkZmZk01R1NNaHdudU1DRSttN0tFWUowWnlqeUtaZlhOekJzOUVh?=
 =?utf-8?B?VStjU2p6REc2M1BISWt6SS9RNHVEOWR0ODJOVU40TFBucjZJUmVmSVBKeklS?=
 =?utf-8?B?b3RYcEVHWkEwOVRaV2NEK3VOakJkbUpTek9KczhqK0ZDMkV2U05zNFZxRGx3?=
 =?utf-8?B?QkdxUlJwek1WOXlaMUYrb0RhKzNzbVloc2cyOTd3ZUFVL0cvN1NFcExTZk16?=
 =?utf-8?B?UTBIdEM4NmFiRmlWckpOYzVTbWN2aEhUVlc5YVlWcHFWRGdKd1dIYTYreC9Z?=
 =?utf-8?B?K3RvMDNJQXdTMVVQZGtGNDdiUjcyWGJ1K1J1dzFhQ0toMVc2VEVKUFJqSDB1?=
 =?utf-8?B?T2V5RmtmTmpEWFo2eXVyR1FBVEUxYUlLakEvNFUzOW50RHZJVnp2QVV3T3V2?=
 =?utf-8?B?cFk5VSt2QmZ4NjVqVjNoem5nTnNFZmZJNnc1YlFjWHluOFBxRmFjSlRwREpk?=
 =?utf-8?B?YXJlcENHWWFDRUx0NGNzNXFmLzlYY0VKTHhOVGNhT3NmYnZiUE1ZdU9LQit3?=
 =?utf-8?B?bHlFVW1hTnYwUUtRWDFCeXpyQWZwSUZkYmdGcXdTclpRZTNEZUltTkRCNTFp?=
 =?utf-8?B?SkZsWXpUQTNKM2NiRWJBQlRTVkhDZVBWK2ovUVVaajZlTy9obEhyampuQkxY?=
 =?utf-8?B?VlBScSt1N1k4SDY3a0dHYlNSV2pQSXUyOWFidHZ2eXozc21RWE1TVVVLSGpV?=
 =?utf-8?B?eCtBOUFQYXJmL3JvTzBuYXF5bXpXczFQNjNxZi9TaE9ncGlBTytUUGVFKzJu?=
 =?utf-8?B?MEhDd3M0UXNVQ0FOZVVhK1prWm83NUJUc0ppcThaWUVmbzYxdE9NamFMSHRF?=
 =?utf-8?B?QmdqbFhtd1J3c3lwYUl2elJyR01qL1RLOFo1VHkvdE8xQjdpemdxU1BNbGxk?=
 =?utf-8?B?R1BSc1VOd2JBZ3RwMnZvaCtqdzJWUzRXdnFLUkRLS0VUSk5LR096OG9RVkYx?=
 =?utf-8?B?MTZjZ2xqY1lBZFl4VjU5a1RNRlpDK09YTTBZOUhrYmwzWWRVU0hJeUM4VC9s?=
 =?utf-8?B?aE5Yd2x1SFY3UkFPaTQzQXJQK0hGaVVaOXNEWTJmdzJVOHdVa3NMUm85SWkw?=
 =?utf-8?B?QWlxT1kxRTFGOW5kOVdoUkpoUjhtdUYwUStlRkRXaWJ0VDlWdXhQNGsxc3Nn?=
 =?utf-8?B?OXA0SmlzRWtIdGVUSFZhbUUyY2hrSTc4dnEvZTkzYndKVHB1ZnFKMnhjMmha?=
 =?utf-8?B?cVp3V21RQ1dSQ1QyQzdBOURmZ0RJa0tNa0xnVmh0cVN1cTdQakxGUlpMK3VM?=
 =?utf-8?Q?w7zfZEJ3xmHsFYqix7FOjis6YHE0dY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXJlSnRtTERCaFJqQUtjdVhTcXp5V1ZTMGRJS1BPelRMTWFhTmJIMmpGbmln?=
 =?utf-8?B?M0hkNlNJeHBLb1k0eVArTFo3TjkybnBKNCtKYnhFWlZZZ0x4TlE0OEVpT0Rq?=
 =?utf-8?B?eFExT1dOZG04Nk11SFNkWTJqbm1Bb0RpeXFoQjlneUtYRVlGSU85RzJjbXNR?=
 =?utf-8?B?TjFxbzdUdThQOFNYMU9xOFJIMHh1K3lWcjRuZ0RaVStuT1RTVU04eGdnSXpG?=
 =?utf-8?B?NzBBbXVxOGRNaDY0OW1PMlJuVEdua3VsMzhUS3FtZnhmRTJPNjcySTJHejcz?=
 =?utf-8?B?VkYzaFdRRjRYWlB4Qk8xb05mdlIrL3hWSlV3U1l2SWJWaVd4VFhvdWx4VGpP?=
 =?utf-8?B?UHRYckxTQW9hcThSYUEyTlBtdlN5Qm9mSkpKUEp6TTlsRHlDK0JyUk9CeEYz?=
 =?utf-8?B?WFFFQXg0SGhoSExRMTlJZHM5QVgwM3cxODAzWUVhaGlERXRPNk9ZbWxHWHpI?=
 =?utf-8?B?VWhuSjhxN2JmT0JkZGk5ZnpnNkdwek1YR3JHcCs3NmhJRWswZ3NmZTBseHdY?=
 =?utf-8?B?S0pXa202VzVWVkxDVjluTHN6aEs3eG1CcGhDZ2NvdFYzT1JaemgvT2lHdmVl?=
 =?utf-8?B?Z3pSbDhPMDFwMmZaTHJhbHVraVA5ZUNrb1orVG1ja3FqOFpEYVpQZTlNYkRT?=
 =?utf-8?B?VEJBTFZWZDBhZk80WDBneWhxZGRhMk5RelU4cDYrN05hb0pldVNYNEVzd3gz?=
 =?utf-8?B?ZkVIS1piUGNxRkpzcGtFMUpWVjdYOG9SZ1R2bzVBNzlQYitndHprL0g2YlEw?=
 =?utf-8?B?ZExvem1RQ0ZkNmVuSGJqVTJjNWxObFlzdTY3TjNhSUVGa21uVm1OUW1sWTlX?=
 =?utf-8?B?cU9TK3ZWbndHOTQ5Vmd4WlFybU1GWExjWEJYZzlaa3BTem1zU0hrcHJQa0xp?=
 =?utf-8?B?SjM2RjltaEVuRldIQlNKKzZlSTYyNFlLemlDbVVSMjhTN0lOSXNjMDl2azdn?=
 =?utf-8?B?MVIzRElRRVRpR1ZTNVM1emNDZkkrMzhsMnA1aXVXNWNVc1ZXY1B0ZmphbDNx?=
 =?utf-8?B?VnN3Zm1LbmFNUDZKNmJNZmFCUDI0TzZrdFhLaXlHVldIMG1jbzVub1kzTFk1?=
 =?utf-8?B?eXB3RFFicm1IZ1RVM21Jc1RxdFFmNkVSa21aYmdoVTNaWERuUmRWN1Nkb29h?=
 =?utf-8?B?UFRBZTVwRXpaaTUwcUE1RDdWVmNNQ2k2RnVnd0MzR1ZadWNZbmtPcXZvZGUr?=
 =?utf-8?B?WHhkeE5pZVZwM1JuWXQxa1JGOFNjaXFXRGVmeXp3R0p2c2FJTksxeGxtMjJl?=
 =?utf-8?B?b3Z5bC9ndzZKQkJNMmFTWE5sbW1mZFZGak04VzZPZlFGbEFxRHJWZHBzWmdO?=
 =?utf-8?B?QWVkVTRLS3pPVWY1cVROMnlBMzNNUzdtaDc4cllVM1BnMVRvdkRRQlA2eXVx?=
 =?utf-8?B?cE9xcUUvKzJBU0dYYnRGMkZKbVJOanY2M1hTaEt3ckxOOTdyYyt6RGMxcjMv?=
 =?utf-8?B?VndXckZqb2ZLNEJFbElVK1Q2MWRNeVl4SlZpM0NZSStWTmxzd0d4NkRJZFRH?=
 =?utf-8?B?bGpxZ0dqZlhZdFd6OG9LeDlDcE9ubVVRQWI4cEM2NVgwWnBGMWtHNUE5ZHhu?=
 =?utf-8?B?ZGJNNURjN3BOTlNEa1NpRkk5NGRBczBrc1BBTHRxYUNlL0wvbmtUTEcrQjFL?=
 =?utf-8?B?T1B4MXdZVTV1b3dJd1U0YnJaWkdyZ2FPbmR5MGdDdlp6SVpMZFI3bFVLQjZo?=
 =?utf-8?B?SEthNGZCaHN0bUpiU0lUWjlNQkEyOGlhZ2Y4c2Y1RkhMdUtYTmo1WFplK0N0?=
 =?utf-8?B?SWo5VU9DYmNBaHYvQ3Q3ay9kdEdEdUhHOS9DK2g0VUd6UFR3dDFSY2E0MW54?=
 =?utf-8?B?NHJ1YUJJcmszMzQwSldPZnBrN0lkeWo2S2g1L0lhbnZWSUQ1UEJLUnRrbHNJ?=
 =?utf-8?B?MHVDdGdqT3lPYzNPbGg4c2hVTG5VSnN6RFBGVEJTYVRDdW1raTdSTU5yTGM4?=
 =?utf-8?B?QkdGYy82UTUzOXZjb1ZVRWkwS3ZhaElIRERVWjBFTGdZY0l1N0ZrOXIxSXFK?=
 =?utf-8?B?K2tWdDV4RVNxM2ZNNnlUMUJ5ek0zYTBkTy9KY3laMzhHY2x1ZTd1QzM4cXBG?=
 =?utf-8?B?NVN0eWxBM0l6R2lTZmgyenRTaGcxSGJyV0wvK1I0TThkcTdLUUswV2hrNHR4?=
 =?utf-8?Q?kJYtMtyBrJb2dLv3YA7aN5fFP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E789F0DC50D064A975F768D7E7E6854@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x+Bgh44pYvaMooj90CvRgVJHir6JKF4da7SFcs6JmXBppAKn8mvMapo4rUdEVbcBOu5xQNX/evSK4bSe7bYXdXTiAMi8xPbq/toUTFcCqsBjzfWCtRRDQMKTz0nhhbhYTwV+0paykBZKSmxYKg0HaQhbmlum0nbG6FGbQrdm3f1aat9s5IKO9cat9tpXzTqmdI+GxKLiBaa5wBj2ttXIYPiR0DJtUc5EGuovGa/ZW+DTEnQ/Nap9stzyrCl2qMXacYV+VjEeVV6gOwged0PwUuQHHNStXBZNs/jFWwb4zSDZ74dtDpGQO5T66LJ3/R9UlhHfUAc0wkH7fx0sN2+Pzq+8pqL1A8J6QnJvzSSDmjsXwE4yc0NSxItEO0oEhnEwxgSt9EfZ6mt7oyOKIKCI3Z41hyHMMmLZpYe93X+BSOSb895izy1cO9+o7gbzi1UWX8Du0f5Dz5TUpankBXV2UnKZ0jZgvWvjiccIXvzvDDl31a+mZjuqCQ/+ZkpVQtc//UoJNbBXOfhSBUPYVc8dFqh/9OEw1PXFFnz9JAwWnVFqOeCcK6jEXniAABlbfuaTYpK03nE4vzK9uq+TkVnOIXpGfgsb5Xccb/rMguQJUTA0X8kQSgD26hLwFaKKTlsa5x/Qo3bIdFCz8JcwI0V6BQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522edce6-987f-4eb0-eb4f-08ddf0d31d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 01:32:47.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/RfsAUPSzQlIAvyJu8Tt+x/S8W2WbQp7Ij/UVkTp5LVghddPZrr8MvrFia6P5HjF1t+8VO9SjXJSb6vrEK3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
X-Proofpoint-GUID: SSU-LdoLVG8c8iWYgrNDN0IAOXj7acOq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDEwOCBTYWx0ZWRfXyTgcyi0h+Wsp
 Yk8zRgKmuSaUxJ/gHOyhdzgHl35z4cF3mxF8SFqomlMbEc944VRIC+KKnUFecNSgZYNn/wvlMHc
 ILo/XUcSUGX0+C7SybSVDb+9PD9TRyWxezzzQd76qPycy4iHkyk9NluGteyc9EkFXyMxpyxRUW4
 Vi0F8gF7axavJc2BYHMGF5Ff9Bg1P+tnfgp5yfxW4xbVC+DjCObyTefukHbipvlIg8NJrzzD/Tw
 ArM9IEvkH8rHoLa5LmW7Uis9/g9OuuOeveiNuZh81U/jk+Qm84j5tN9d6evLZhxjrn2f9mDX9Ab
 2IsyYoEir/HLkWopVsbLjTWyqARMmuyH22LAVfI1sdW7qg0yTQraaHysC7t9hhbX5Qeq2+v4Cp7
 0cyc0OIM
X-Authority-Analysis: v=2.4 cv=JvrxrN4C c=1 sm=1 tr=0 ts=68c226c6 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=pGLkceISAAAA:8 a=I1w4k3nY7KVhi2xgDI0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SSU-LdoLVG8c8iWYgrNDN0IAOXj7acOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509060108

T24gV2VkLCBTZXAgMTAsIDIwMjUsIFJ5YW4gWmhvdSB3cm90ZToNCj4gSXNzdWUgZGVzY3JpcHRp
b246RHVyaW5nIHRoZSB3YWtlLXVwIHNlcXVlbmNlLCBpZiB0aGUgc3lzdGVtIGludm9rZXMNCj4g
IGR3YzMtPnJlc3VtZSBhbmQgZGV0ZWN0cyB0aGF0IHRoZSBwYXJlbnQgZGV2aWNlIG9mIGR3YzMg
aXMgaW4gYQ0KPiBydW50aW1lIHN1c3BlbmQgc3RhdGUsIHRoZSBzeXN0ZW0gd2lsbCBnZW5lcmF0
ZSBhbiBlcnJvcjogcnVudGltZSBQTQ0KPiB0cnlpbmcgdG8gYWN0aXZhdGUgY2hpbGQgZGV2aWNl
IHh4eC5kd2MzIGJ1dCBwYXJlbnQgaXMgbm90IGFjdGl2ZS4NCj4gDQo+IFNvbHV0aW9uOkF0IHRo
ZSBkd2MzLT5yZXN1bWUgZW50cnkgcG9pbnQsIGlmIHRoZSBkd2MzIGNvbnRyb2xsZXINCj4gaXMg
ZGV0ZWN0ZWQgaW4gYSBzdXNwZW5kZWQgc3RhdGUsIHRoZSBmdW5jdGlvbiBzaGFsbCByZXR1cm4N
Cj4gaW1tZWRpYXRlbHkgd2l0aG91dCBleGVjdXRpbmcgYW55IGZ1cnRoZXIgb3BlcmF0aW9ucy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gWmhvdSA8cnlhbnpob3U1NEBnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggMzcwZmM1MjRhNDY4Li4w
NmE2ZjhhNjcxMjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0yNjg3LDYgKzI2ODcsOSBAQCBpbnQg
ZHdjM19wbV9yZXN1bWUoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYg
PSBkd2MtPmRldjsNCj4gIAlpbnQJCXJldCA9IDA7DQo+ICANCj4gKwlpZiAocG1fcnVudGltZV9z
dXNwZW5kZWQoZGV2KSkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KDQpJcyB0aGlzIGEgZG9jdW1l
bnRlZCBiZWhhdmlvciB3aGVyZSB0aGUgZGV2aWNlIHNob3VsZCByZW1haW4gcnVudGltZQ0Kc3Vz
cGVuZCBvbiBzeXN0ZW0gcmVzdW1lPyBJIGZlZWwgdGhhdCB0aGF0IHRoaXMgc2hvdWxkIGJlIGNv
bmZpZ3VyYWJsZQ0KYnkgdGhlIHVzZXIgb3IgZGVmaW5lZCB0aGUgUE0gY29yZS4gSSBkb24ndCB0
aGluayB3ZSBzaG91bGQgY2hhbmdlDQpkZWZhdWx0IGJlaGF2aW9yIGhlcmUganVzdCB0byB3b3Jr
YXJvdW5kIHRoZSBpc3N1ZSB0aGF0IHdlJ3JlIGZhY2luZy4NCg0KV2hhdCBpZiB0aGUgdXNlciB3
YW50cyB0byBrZWVwIHRoZSBvbGQgYmVoYXZpb3IgYW5kIHJlc3VtZSB1cCB0aGUgZGV2aWNlDQpv
biBzeXN0ZW0gcmVzdW1lPw0KDQpCUiwNClRoaW5oDQoNCj4gIAlwaW5jdHJsX3BtX3NlbGVjdF9k
ZWZhdWx0X3N0YXRlKGRldik7DQo+ICANCj4gIAlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4g
LS0gDQo+IDIuMjUuMQ0KPiA=

