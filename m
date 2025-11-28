Return-Path: <linux-pm+bounces-38880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF32C92347
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 15:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A46C352247
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8FE32ED3C;
	Fri, 28 Nov 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Jj3uQ06d"
X-Original-To: linux-pm@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62332E755;
	Fri, 28 Nov 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=63.176.194.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338409; cv=fail; b=nmuQ1aPyGOVoy6izMfwTWQuA6RUVM7HG7W0Bg7sjNXfo1rAZXekVWl5aWYJzJEikTruE/dns/e+Ca1YvKqa2jVZRpw7rVm8J7s/EisEAnB5N7dhu5cV6HEHkWMIH2nbjBzgHrqJzvayHtA3ekHCtuvaQ6NEMCMlrjwLiniUNtS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338409; c=relaxed/simple;
	bh=ifNiDbNCgw0tuusVxEow/1N88K4LsSWIKMgAL2odUjI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIwX8Gy9i1+I13OjZ0ZaO+cl3VcCcAXsie7Tvgscp/i+VIXry6BMIdtrSauJ1+UijDVikcINXpKlXK9Yp1ChEVRD4BF9Vvg6nOgzQoHVdO6Lm0Low6C7NIiRMTleQ7bR9rML+AeURwsNk3nTa+EfTQgIo1CgYDTNeL3tEkefJUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Jj3uQ06d; arc=fail smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764338406; x=1795874406;
  h=from:to:cc:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding:subject;
  bh=ifNiDbNCgw0tuusVxEow/1N88K4LsSWIKMgAL2odUjI=;
  b=Jj3uQ06d0NV61KHTtoeJRL9AuLgW8q2kPBYqXAXNjvv5cuOaP2npZA/4
   kDU6vbcxox52qYlH0+LuDOlRaAtCnIDcff7VNxPZmY1b8K0tAW9dfo5TN
   rSivi+VWz68YPF10JfLHfNQtQlTISul9vsTkOpK5loJ2fbN+cz3a7wNlt
   XcHqQ3Pzo8JFZ0Znw/PIdqvT3zb0Qur8KK/YXO+h6/uooEt/XspdcACyp
   fB7MimhPk/EHxf9fg/Q76PTOx4ax+PJsHQK6jl+6nqr6L6E0l+F6JZYsy
   +eR6BNgRpT2+bZzSUW7yt3hZYdBIg+ikqeiyxWKuc2KFAWPXWfaDLzG/d
   g==;
X-CSE-ConnectionGUID: JAUNzwzpQACewtODjKQPPw==
X-CSE-MsgGUID: ljUIaslQRUCsUgY1SlCocg==
X-IronPort-AV: E=Sophos;i="6.20,234,1758585600"; 
   d="scan'208";a="5952096"
Subject: Re: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP
 calculation fails
Thread-Topic: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP calculation
 fails
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 13:59:49 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:25042]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.14.220:2525] with esmtp (Farcaster)
 id 96d421e4-c402-487a-811c-d7e91c419850; Fri, 28 Nov 2025 13:59:48 +0000 (UTC)
X-Farcaster-Flow-ID: 96d421e4-c402-487a-811c-d7e91c419850
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 13:59:48 +0000
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 13:59:48 +0000
Received: from BEUP281CU002.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29
 via Frontend Transport; Fri, 28 Nov 2025 13:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXslaORP+be2SoBG025eZ/X0QjOxoxo+MSrAW0iejWci+ocWtErPLC9S6B7pd6BawfVEW7FSLUHzes13/XI1H/GQW67E3WdhUQunQq/CLQ4PFRtyJPybRYMBVOTbUz84nJ5P+TTBDkSth1byogCKCNRLJmw5eQBvnLLGMlf8/lcVX534iC2IyUPNyOlU8V2wxyEtLUGmUzOI+v9wKSX64Uf96OdX+v3e4MHR1+u7nP2E0WGFaRVY2kQxK/tsXH53auBSuLDrBjW824P8vqh8p2jkbXUyLXc5avxEljcgO8/Pcp+QpDWam+roooUuuwvc53PZFskR/E3NL2msmMyXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC+/8oZ3GJcbf9OEsyr3+nFV2aBvMDqySLZkMpOs4Tk=;
 b=mgbTSjfrt/0+DpmVKBi8+b7+FR4pN7JOOT0RlfMqPoOEGANVb5TqiuyAueexV5x94eoE3v4qlxKLwk9ZjSLmg3nvkw+rHp+rdjSpO9jihadFIUQGCYGwPzeOZC/wsaA9rGTdu/NKaI3Q20w+qMXdpwWXCCJ/oF0IXpjSR0uacleHvepJ8HARtFsnTBMcz/p/pT84FtqMZT8+c09Ie6kog0RnKCo83F9AnTASAacFKg5OYWiXcl2Q4WYlwRXScNx+uRXZ40ViD+b5XEeKSRFGt024YDwBaIXzHEEH4tTUpxDwbr7nNg3zpqvsg4TlAQMc3FzW2XNAugZNn5+2MK3Jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:e4::19)
 by FR6P281MB3437.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 13:59:46 +0000
Received: from BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fbfe:9bc0:7680:6aea]) by BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fbfe:9bc0:7680:6aea%4]) with mapi id 15.20.9343.016; Fri, 28 Nov 2025
 13:59:46 +0000
From: "Ehlert, Emily" <ehemily@amazon.de>
To: Len Brown <lenb@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emily Ehlert
	<ehemily@amazon.com>
Thread-Index: AQHcVNIx7jX1viWhWUqhOHhYQnsLtbUDxN8AgARscFQ=
Date: Fri, 28 Nov 2025 13:59:46 +0000
Message-ID: <BEYP281MB5509D3D7A01DEC1FAAEB9DBDBADCA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
References: <20251113191609.28574-1-ehemily@amazon.de>
 <20251113191609.28574-2-ehemily@amazon.de>
 <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com>
In-Reply-To: <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEYP281MB5509:EE_|FR6P281MB3437:EE_
x-ms-office365-filtering-correlation-id: 03bee3ab-be02-4fd3-f127-08de2e866360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?c1JDcWNiNVc4bmkwM0RiMmU4YStYVnpKS1FJbENlQWtPQWZRUUMwNVRwTlA4?=
 =?utf-8?B?QWhYbk5EY05vRGFHWUdML0RIUm8velA5ZDN0SitMQXUyOHVLZmV0SmVwdGVW?=
 =?utf-8?B?UjZSMHJFTER2MEZZTyt3UTNtTUZhMFhKMS9CQnhaNGdDZDlnK3BObU1ObXRJ?=
 =?utf-8?B?SU0xeFRJODhnU0lYaE5WbG1uQU5FdUU5WTN2YVViK0oxR2F1QTk4dUh1cEo4?=
 =?utf-8?B?dXg3K29JRW55SWNJRG04RmV2WE9tZ01aNG4xQXM3UEt1M1BzVFZVcTMxUThp?=
 =?utf-8?B?eUsrNm16cUJoeXBxZlpqZkl5YTlrN1hmdE9HZVcrMUpJNXd1UTZnLzlrZE9X?=
 =?utf-8?B?NG0vYTdUSXBGZnRxb1JMVEcrK1NsdlYzOHNYV2E5cjFjZ1FaVlAwNVhocFBP?=
 =?utf-8?B?UjZreVhQM05qdzBGUDN6RXFBRkVuS21hWHo3dFRheHp4WDF1ZWhOYm5IZGZP?=
 =?utf-8?B?cE1RMEl0RXRCY1ByM3ZzMk1uOVMwcVI0SmdodmdXSS8rcXMxbldxUE9Zb1FH?=
 =?utf-8?B?S2VFVlI3b2ovbEFIaHFyaVl3cTAvV0ZOc2dvTWY4Y1gzWUlZcGVUSjRkZU0w?=
 =?utf-8?B?VTZiaEppQVRlRWFPSE13SEhPSXVSaW9xTzJKTGlZdEpudWZpOFFzLzgrK0ty?=
 =?utf-8?B?WkdINWtnemFqNjZ5YTk5NmM4YUdBb2dIeHZRTjlwMGoyNFlKUFo3MnZNNTFP?=
 =?utf-8?B?NCs5VWlOejdZeGhua2luVmcxQ0hRYXoySVVzQ0h4MURCKzlsaTJzUExvYklS?=
 =?utf-8?B?Z1MwT2lKeFBKaWVuRE9MWmFRSVNlVklNMC9EL09naFFxa3g3Mmx0bFRtNS9N?=
 =?utf-8?B?MUxPWk1wYmNRLzNmdWIzRVV2cWhIMnZYemtvamlNVDJOWTRvTEVQRHZLZDhu?=
 =?utf-8?B?cWFnSzBlWkhkcjI5NHkvRHUwTnBNckZyRzd4SG5XSzdmWjUxNER5Q2IyVFNU?=
 =?utf-8?B?eDMraDM5TnRib0RYN1g0L3krU0d6b01tOE1aUTNsOE93cWpWSGFMdmQyd3JN?=
 =?utf-8?B?Uk9TVG9YU2ZHMW1mL01yWW9kdnRhbkZjRnVEVmJmeW5KN1c5YjYzMUdOTnV4?=
 =?utf-8?B?OUtmeFBnT3E4UzFKZEJUSzlDdDhhOUdqSG53OXh3K1hpMi9BOUVGMWxZTWVI?=
 =?utf-8?B?U1JlY1hHbW5paG9CZllieXpTbTlXRUVmQnlKOVF2RUowR2k1SVRUWHphakNB?=
 =?utf-8?B?UGo3bktRK1FsLy9maUkwN0R3RlZLS1diakZKd0s1MDRrYnFLdkgzQ1RaQlc5?=
 =?utf-8?B?ZFlXeW1ENmZPdElDOUI4dkhlWExMbFpGWUxyWHloZzN1RjZOc3ZQSUNoOXFS?=
 =?utf-8?B?eDZkUjBTWmpsSkxEaXVwc3RKWnE3NzRVV2NXQ1lLczFzY3lQZWtJVWNJNk1M?=
 =?utf-8?B?cDMyeGN5eFdmV1YrWCt5a0VJSnRCMkw3d3l0VUtqS3lDZmhsWlRHQVhKUkZj?=
 =?utf-8?B?WEE4QzJYZHFQdVU4R09FS3EvYU1CWEFQd3AvMEJ5VE1rRnJxc2pCQUMwdE5V?=
 =?utf-8?B?Z1Y4amNuWEVyZ0FDQmcraG9GRUFzSlVrQStNTERKb2xCRkRuVVhIR0hHRFdD?=
 =?utf-8?B?eFVETDZKUmRjMVVPWXRjeXVNWXZ2bURPSERubXNYb1VwVVFaWkJBVjg2b2V4?=
 =?utf-8?B?UzhpKzhaSTlSZ0xGMEN5cGRzTGRtVnErbHYwdDFtejRzTkVhR1FUUEphVm9Q?=
 =?utf-8?B?a1VxdStwcHRlcjRLN1B3Ym1KQjQ0Z1FPcTNYTldoQ1hnMnR4Wk9oaXJUdmZ0?=
 =?utf-8?B?c0FmakdpcGIyenlXWm14MVBkOTY5TmRqNkFWZnRXWUFBVSt3b0FaTkZsRnNO?=
 =?utf-8?B?bm9lcjlPK25XaUtQaVlaQWpDNWtQL0VOSUp1TWJJS1pwMXhINitFcFJ5ZTUv?=
 =?utf-8?B?MW9EYjVwc05JYzI5TDh3SlJ4MVBhUnQ3MHhWU0FDb2o2Y083RTFSQlVVd05h?=
 =?utf-8?B?dHI3Z1B3Q3BiMzRYRW14NXZLMGpzSnREOTVyNHQwbC94dDRUVEYwWHRFN3B1?=
 =?utf-8?B?cVF2QWgybDluZ2N2OElqcEEyVWZSd1ZXRmg0U0NXVFJRQU5YNFgwKzBybTdK?=
 =?utf-8?Q?iC5BUX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXlBNWdrNTFmUFZhRE1jMHFheW1rbXZwbzBpLy85RnhZc2xJUTd5Y3FyRkhy?=
 =?utf-8?B?UU9mVTZ4ZXRKVjQ4NFZsYTFQb1ZTUmhEbVFvQ2toTWxXcnM5YzIzRURNelFP?=
 =?utf-8?B?MGtCdFJjeThBS0crV2JidEx0Z01OejZ1MThSQjFhVEFvNXpvQUI2U2o1Y3o5?=
 =?utf-8?B?Y0UxU1VvcmM1ZGdTUDJYdXM3NTBHZGxQU1ZsOHlQSlNqVTdscGRkbEpUdDQz?=
 =?utf-8?B?UUFRWlQzS0tOYkxITHZDUkcyQzJ3TU03amMvbU1MdUNFMzJ0dFh2anRaK1FU?=
 =?utf-8?B?cFRSakhpZGxKSm9icVZCK0UwY1JhMFdhdERBZzVYTkZpZEVERnZ6a0dpN2ho?=
 =?utf-8?B?S21UbEgwUk9kdXI2eXFReXpucGV2ZkFLdGRDN3ZYdnhDd0VzN25IVTVPaVgw?=
 =?utf-8?B?ZDhaVTBnVUJqdnVJWFVseUxxU1FHRVd3SVZoL2g1WFFHQ1pXNStFcHpSRFRr?=
 =?utf-8?B?SWIwRWV1SFZsaDZEeGtCT3J6UVZEdzc1YzhQcEhmeGdSK2JmczRlWXBVaXRY?=
 =?utf-8?B?dnpGbERwTTdpNGtVWFFEVlZlOEU5WW1Wb3Rjdk0vcGhzT3RQcG0xTVk1UC9r?=
 =?utf-8?B?V3RVZ3NRcUEyNEN6TGlzdW9EaEMzeXc2TEtsZElsMVhPNkhYOE16UEJORXVS?=
 =?utf-8?B?T2VlYVc3dWtlaWpOck96NjRXcHl4dUZNdGFqSHFJU3RGOHkreHpDaXkzRTRx?=
 =?utf-8?B?VDN0ZkdKd3hMaU5nLzBkRVQ0MzJsaTErSzUzRVFBTENpMEIramZJSnRDMTl1?=
 =?utf-8?B?YUY3NjJMRHFnd1QyUXh1M1RUb3JoTTRmcy8rMFpIbWVJMGw4clhYMC9aT0Z0?=
 =?utf-8?B?cnpUZ2xiOFB6dGlQenR2V2FtZzVIcTM0MGlNVmt3QnFDeXpaLzFSV2NKQkpn?=
 =?utf-8?B?OGgyaUYzOWxYdlYrVmlPVHdPQnRmNnJlTDZpeGZ1dTRKUFVLRDlqT1ZsUHY5?=
 =?utf-8?B?WHNoaURqak9ZK2p1ZzFVRTRJazF6NGhtYkV4VEpqcDEyazcvQmNJK093NWpv?=
 =?utf-8?B?UmNRN28wVXJzQmttL1VXZUk5QmViYXFkVTllK3VRQ3VCc1M5NGVTeTQrT0V3?=
 =?utf-8?B?UHZkTndhV2JGMkZDd04rdEFaNHdBU0x5R3RTOTdGQzc2UVBpMS9oRzRUaFFo?=
 =?utf-8?B?QUJHT3Jnc2x5bzJVeVhmZDVKa2dwTnhKcDd0TlVYcGl6SmJNWUFKZEFRT3pB?=
 =?utf-8?B?ZE1RZHR1VWdZalM3OE1jQTJTajBlRzVEeHMwQWFuT2xXem5CZCs4UiswMTJj?=
 =?utf-8?B?SE4wQVpBTzZZczNMUDhDbmtWWiswVXVkU0VzY3RmSHNsR083Z1lWWVpVV0xo?=
 =?utf-8?B?Nkhmb3FUVUkzdGtuQmEyZkJXOUVoeWxSbzdIdUNTNUZhRzgzR0ZDUHA5MEZQ?=
 =?utf-8?B?MlpNbDdaQmt1ZkNkbjVQM1lWelhGTVVreWErRUExZWRtT2piQVNQZlBLRUJH?=
 =?utf-8?B?SVJTbU9xYnNwQk9DN3I2U05tZ3orM282TktUS0ZVQTZrQmFOdW05NXpDRkox?=
 =?utf-8?B?K1h2ZHVtS0h1NzFabGdhdmRqR0hJTFlwSklhRloyTFhBWWJXRXRiZkN5R3F0?=
 =?utf-8?B?bEFjRGV2V2N3Sk16UHFNd1pkN2JIYVp6SlQzbjhwaDIrVUJ2V0xKZ2NpeVMr?=
 =?utf-8?B?aUdEcVczZERzQ0xMaVRSelA2OTRZMS9UbEZWbDVYblR5L1hjYVkwSEhGUjR3?=
 =?utf-8?B?WG5nUnUxMUJvUDVkeVJYM3IzclQ2bEQzS09QMlJUMVZtQmpNRC9pYkxvNWwy?=
 =?utf-8?B?NXhhc1ZSQ1NtK0ZRMFFGYWZyck4ySnZ3VEZPREdCaFI5NDZodGtJdDA2aTRq?=
 =?utf-8?B?MnhnR21lYnk4UC9sTEtRWjFhNXBTSG9CZkRaVW50czVMb1NSN3VrRFhOTHVu?=
 =?utf-8?B?MzVROW1wNk4yaUsrRCszSUVFaTArTEhHWXZFZWZ4eU5aSGlxZ3VrbWR3OHhp?=
 =?utf-8?B?V2ZnbUNyU0pWaEwyaWVmMzEvUksrcXpzSXdWQmtBcTdQdTR0S212NnhLa3Qw?=
 =?utf-8?B?WUNvQ3FaNHJ3WmdRUVkrejQvVFVnd0NEanRIR2x2UnE5SXpJeHRtWFg3R2la?=
 =?utf-8?B?V1VwcUhZK1lxcVdSNU5GYnVyMllzanFyTEh6empJVVB3anBpVEtaakp0MzJq?=
 =?utf-8?Q?UAOc=3D?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bee3ab-be02-4fd3-f127-08de2e866360
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 13:59:46.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYbPk9Ib1BeUfBhQoxEk37NixQAprJcttH1E+9OcJXtXHiNBEB4umvH+vwFHEqYoFYT2K7i0d8jlKFd6k8vg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3437
X-OriginatorOrg: amazon.de
Content-Transfer-Encoding: base64

V2UgYXJlIHJ1bm5pbmcgdHVyYm9zdGF0IGluc2lkZSBhIFZNIG9uIHRoZSBBV1MgTml0cm8gSHlw
ZXJ2aXNvci4NCkd1ZXN0cyBhcmUgbm90IHByb3ZpZGVkIHdpdGggYW55IHBvd2VyIG1lYXN1cmVt
ZW50cy4gU28gcmVhZGluZyB0aGUNCk1TUl9SQVBMX1BPV0VSX1VOSVQgd2lsbCByZWFkIDAuIFNp
bmNlIHR1cmJvc3RhdCBleHBlY3RzIHdvcmtpbmcNClJBUEwgZm9yIHRoaXMgQ1BVIGZhbWlseSwg
ZmFpbGluZyB0byByZWFkIHRoZW0gbGVhZHMgdG8gYW4gZXhpdCAoYmVjYXVzZQ0Kc2V0dGluZyB0
aGUgdGhlIHRpbWVyIGZhaWxzKS4gSSBhZ3JlZSB0aGF0IHRoZSBwYXRjaCBzaG91bGQgZGlzYWJs
ZSBSQVBMDQpub3QgYWZ0ZXIgVFBNIGJ1dCBhZnRlciB0aGUgUkFQTF9QT1dFUl9VTklUIE1TUiBy
ZWFkLg0KDQpJIGFtIG5vdCBleHBlcmllbmNlZCB3aXRoIHRoZSB3YXkgdHVyYm9zdGF0IHVzZXMg
dGhlIEJJQyBjb3VudGVyIG1hY3Jvcy4NCkl0IHNlZW1zIGxpa2UgdGhlc2UgYXJlIG1vc3RseSB1
c2VkIGZvciBlbmFibGluZyAvIGRpc2FibGluZyBpbmRpdmlkdWFsIGNvdW50ZXJzPw0KSG93IHdv
dWxkIEkgZ28gYWJvdXQgdXNpbmcgdGhlbSB0byBkaXNhYmxlIFJBUEwgaW4gZ2VuZXJhbCB3aXRo
b3V0IGFmZmVjdGluZw0Kb3RoZXIgTVNScyBzdWNoIGFzIENQVSVjMSB3aGljaCB3ZSBjYW4gYW5k
IHdhbnQgdG8gcmVhZD8gSSB3b3VsZCBhcHByZWNpYXRlDQpzb21lIHBvaW50ZXJzIG9yIHJvdWdo
IG91dGxpbmUgb24gaG93IEkgY2FuIGFwcHJvYWNoIHRoZSBpc3N1ZS4NCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogTGVuIEJyb3duIDxsZW5iQGtlcm5l
bC5vcmc+DQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyNSwgMjAyNSA3OjEzIFBNDQpUbzogRWhs
ZXJ0LCBFbWlseQ0KQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgRW1pbHkgRWhsZXJ0DQpTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBbUEFU
Q0ggMi8yXSB0b29scy9wb3dlci90dXJib3N0YXQ6IEZpeCBkaXZpc2lvbiBieSB6ZXJvIHdoZW4g
VERQIGNhbGN1bGF0aW9uIGZhaWxzDQoNCkNBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBm
cm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCg0KDQpDYW4geW91IHNoYXJlIHdoYXQgc3lzdGVtIGNv
bmZpZ3VyYXRpb24gd2VudCBkb3duIHRoaXMgZXJyb3IgcGF0aD8NCg0KSSBkb24ndCBoYXZlIGEg
Z29vZCBmZWVsaW5nIGFib3V0IHRoaXMgcmVtZWR5Lg0KDQpUaGUgcmVhc29uIHdlIGdldCBURFAg
aXMgdG8gZXN0aW1hdGUgaWYgUkFQTCB3aWxsIG92ZXJmbG93IGl0cw0KdW5kZXJzaXplZCBlbmVy
Z3kgY291bnRlcnMgZHVyaW5nIHRoZSBtZWFzdXJlbWVudCBpbnRlcnZhbC4gIFdlIGFybSBhDQp0
aW1lciBhcHByb3ByaWF0ZWx5IHRvIGFjY3VtdWxhdGUgUkFQTCBpZiBpdCBsb29rcyBsaWtlIHRo
aXMgd2lsbCBiZQ0KcG9zc2libGUuDQoNCkl0IGlzIHBvc3NpYmxlIHRvIHJ1biBpbnRvIHRoYXQg
dW5kZXJseWluZyBpc3N1ZSwgYnV0IGl0IGlzIG5vdCBjb21tb24gdXNhZ2UuDQoNClNvIG15IHF1
ZXN0aW9uIGlzIGlmIHlvdSBoYXZlIGEgc3lzdGVtIHdoZXJlIFJBUEwgd29ya3MgZmluZSwgYnV0
IHdlDQpzaW1wbHkgY2FuJ3QgZ2V0IFREUCB0byBidWlsZCB0aGlzIHNhZmV0eSBuZXQ/DQoNCklm
IHNvLCBpdCBtYXkgbWFrZSBtb3JlIHNlbnNlIHRvIGFkanVzdCB0aGUgc2FmZXR5IG5ldCwgc2F5
LCB1c2luZw0Kc29tZSBjb25zZXJ2YXRpdmUgZGVmYXVsdCB0aW1lciBpbnRlcnZhbCwgcmF0aGVy
IHRoYW4gbm90IHJlcG9ydCBSQVBMDQphdCBhbGwuDQoNCkFuZCBpZiB3ZSBkbyBvcHQgdG8gZGlz
YWJsZSBSQVBMLCBJJ2QgcmF0aGVyIHVuaWZvcm1seSB1c2UgdGhlDQpleGlzdGluZyBidWlsZC1p
bi1jb3VudGVyIG1hY3JvcyBmb3IgdGVzdGluZyBpZiBhIGNvdW50ZXIgaXMgYWN0dWFsbHkNCnBy
ZXNlbnQgYW5kIGVuYWJsZWQgaW5zdGVhZCBvZiBhIG5ldyBnbG9iYWwgZmxhZy4NCg0KdGhhbmtz
LA0KLUxlbg0KDQpPbiBUaHUsIE5vdiAxMywgMjAyNSBhdCAyOjE34oCvUE0gRW1pbHkgRWhsZXJ0
IDxlaGVtaWx5QGFtYXpvbi5kZT4gd3JvdGU6DQo+DQo+IEZyb206IEVtaWx5IEVobGVydCA8ZWhl
bWlseUBhbWF6b24uY29tPg0KPg0KPiB0dXJib3N0YXQgdXNlcyBoYXJkIGNvZGVkIGZlYXR1cmVz
IGZvciBDUFUgZmFtaWxpZXMgYW5kIGV4cGVjdHMgYWNjZXNzIHRvDQo+IFJBUEwgKFJ1bm5pbmcg
QXZlcmFnZSBQb3dlciBMaW1pdCkgTVNScy4gV2hlbiBSQVBMIG9yIHBvd2VyIGluZm8gaXMgbm90
DQo+IGF2YWlsYWJsZSwgdHVyYm9zdGF0IHJlYWRzIFBLR19QT1dFUl9JTkZPIE1TUiB0byBjYWxj
dWxhdGUgVERQIHdpdGgNCj4gUkFQTF9QT1dFUl9VTklUIE1TUi4gSWYgVERQIGNhbGN1bGF0aW9u
IHJlc3VsdHMgaW4gMCwgbm8gemVybyBjaGVjayBpcw0KPiBwZXJmb3JtZWQgYW5kIHRoZSAwIFRE
UCBpcyB1c2VkIGluIGRpdmlzaW9uLCByZXN1bHRpbmcgaW4gYW4gaW52YWxpZA0KPiByYXBsX2pv
dWxlX2NvdW50ZXJfcmFuZ2UuIFRoaXMgdmFyaWFibGUgaXMgbGF0ZXIgdXNlZCBpbiBtc3Jfc3Vt
X3JlY29yZCgpDQo+IGFzIGEgdGltZXIgcGFyYW1ldGVyIHRvIHRpbWVyX3NldHRpbWUoKSBzeXNj
YWxsLCBjYXVzaW5nIGlzc3Vlcy4NCj4NCj4gRml4IHRoZSBpc3N1ZSBieToNCj4NCj4gLSBJbnRy
b2R1Y2UgemVybyBjaGVjayBmb3IgdGRwIGluIHJhcGxfcHJvYmVfaW50ZWwoKSBhbmQgcmFwbF9w
cm9iZV9hbWQoKQ0KPiAtIEludHJvZHVjZSBnbG9iYWwgdmFyaWFibGUgbm9fcmFwbCB3aGljaCBp
cyBzZXQgdG8gdHJ1ZSBpZiB6ZXJvIGNoZWNrIGZhaWxzDQo+IC0gU2tpcCBSQVBMLWRlcGVuZGVu
dCBmdW5jdGlvbnMgd2hlbiBub19yYXBsIGlzIHRydWUNCj4gLSBBZGQgYXNzZXJ0aW9ucyBhbmQg
Z3VhcmRzIHRvIHByZXZlbnQgUkFQTCBvcGVyYXRpb25zIHdoZW4gZGlzYWJsZWQNCj4NCj4gU2ln
bmVkLW9mZi1ieTogRW1pbHkgRWhsZXJ0IDxlaGVtaWx5QGFtYXpvbi5jb20+DQo+IC0tLQ0KPiAg
dG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQuYyB8IDI3ICsrKysrKysrKysrKysr
KysrKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1
cmJvc3RhdC5jIGIvdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQuYw0KPiBpbmRl
eCA5YTJiZTIwMWEzYTYuLjljNmVlMGFjYmUxMiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcG93ZXIv
eDg2L3R1cmJvc3RhdC90dXJib3N0YXQuYw0KPiArKysgYi90b29scy9wb3dlci94ODYvdHVyYm9z
dGF0L3R1cmJvc3RhdC5jDQo+IEBAIC01MzEsNiArNTMxLDcgQEAgc3RhdGljIHN0cnVjdCB0aW1l
dmFsIHByb2NzeXNmc190dl9iZWdpbjsNCj4gIGludCBpZ25vcmVfc3RkaW47DQo+ICBib29sIG5v
X21zcjsNCj4gIGJvb2wgbm9fcGVyZjsNCj4gK2Jvb2wgbm9fcmFwbDsNCj4NCj4gIGVudW0gZ2Z4
X3N5c2ZzX2lkeCB7DQo+ICAgICAgICAgR0ZYX3JjNiwNCj4gQEAgLTMxMTksNiArMzEyMCwxMCBA
QCBpbnQgZHVtcF9jb3VudGVycyhQRVJfVEhSRUFEX1BBUkFNUykNCj4NCj4gIGRvdWJsZSByYXBs
X2NvdW50ZXJfZ2V0X3ZhbHVlKGNvbnN0IHN0cnVjdCByYXBsX2NvdW50ZXIgKmMsIGVudW0gcmFw
bF91bml0IGRlc2lyZWRfdW5pdCwgZG91YmxlIGludGVydmFsKQ0KPiAgew0KPiArICAgICAgIGlm
IChub19yYXBsKSB7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gTkFOOw0KPiArICAgICAgIH0N
Cj4gKw0KPiAgICAgICAgIGFzc2VydChkZXNpcmVkX3VuaXQgIT0gUkFQTF9VTklUX0lOVkFMSUQp
Ow0KPg0KPiAgICAgICAgIC8qDQo+IEBAIC00Njk2LDYgKzQ3MDEsOCBAQCBzdGF0aWMgc2l6ZV90
IGNzdGF0ZV9jb3VudGVyX2luZm9fY291bnRfcGVyZihjb25zdCBzdHJ1Y3QgY3N0YXRlX2NvdW50
ZXJfaW5mb190DQo+DQo+ICB2b2lkIHdyaXRlX3JhcGxfY291bnRlcihzdHJ1Y3QgcmFwbF9jb3Vu
dGVyICpyYywgc3RydWN0IHJhcGxfY291bnRlcl9pbmZvX3QgKnJjaSwgdW5zaWduZWQgaW50IGlk
eCkNCj4gIHsNCj4gKyAgICAgICBhc3NlcnQoIW5vX3JhcGwpOw0KPiArDQo+ICAgICAgICAgaWYg
KHJjaS0+c291cmNlW2lkeF0gPT0gQ09VTlRFUl9TT1VSQ0VfTk9ORSkNCj4gICAgICAgICAgICAg
ICAgIHJldHVybjsNCj4NCj4gQEAgLTQ3MDYsNiArNDcxMyw4IEBAIHZvaWQgd3JpdGVfcmFwbF9j
b3VudGVyKHN0cnVjdCByYXBsX2NvdW50ZXIgKnJjLCBzdHJ1Y3QgcmFwbF9jb3VudGVyX2luZm9f
dCAqcmNpDQo+DQo+ICBpbnQgZ2V0X3JhcGxfY291bnRlcnMoaW50IGNwdSwgdW5zaWduZWQgaW50
IGRvbWFpbiwgc3RydWN0IGNvcmVfZGF0YSAqYywgc3RydWN0IHBrZ19kYXRhICpwKQ0KPiAgew0K
PiArICAgICAgIGFzc2VydCghbm9fcmFwbCk7DQo+ICsNCj4gICAgICAgICBzdHJ1Y3QgcGxhdGZv
cm1fY291bnRlcnMgKnBwbGF0X2NudCA9IHAgPT0gcGFja2FnZV9vZGQgPyAmcGxhdGZvcm1fY291
bnRlcnNfb2RkIDogJnBsYXRmb3JtX2NvdW50ZXJzX2V2ZW47DQo+ICAgICAgICAgdW5zaWduZWQg
bG9uZyBsb25nIHBlcmZfZGF0YVtOVU1fUkFQTF9DT1VOVEVSUyArIDFdOw0KPiAgICAgICAgIHN0
cnVjdCByYXBsX2NvdW50ZXJfaW5mb190ICpyY2k7DQo+IEBAIC01MTQ3LDcgKzUxNTYsNyBAQCBp
bnQgZ2V0X2NvdW50ZXJzKFBFUl9USFJFQURfUEFSQU1TKQ0KPiAgICAgICAgIGlmICghaXNfY3B1
X2ZpcnN0X3RocmVhZF9pbl9jb3JlKHQsIGMsIHApKQ0KPiAgICAgICAgICAgICAgICAgZ290byBk
b25lOw0KPg0KPiAtICAgICAgIGlmIChwbGF0Zm9ybS0+aGFzX3Blcl9jb3JlX3JhcGwpIHsNCj4g
KyAgICAgICBpZiAocGxhdGZvcm0tPmhhc19wZXJfY29yZV9yYXBsICYmICFub19yYXBsKSB7DQo+
ICAgICAgICAgICAgICAgICBzdGF0dXMgPSBnZXRfcmFwbF9jb3VudGVycyhjcHUsIGdldF9yYXBs
X2RvbWFpbl9pZChjcHUpLCBjLCBwKTsNCj4gICAgICAgICAgICAgICAgIGlmIChzdGF0dXMgIT0g
MCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsNCj4gQEAgLTUyMTMs
NyArNTIyMiw3IEBAIGludCBnZXRfY291bnRlcnMoUEVSX1RIUkVBRF9QQVJBTVMpDQo+ICAgICAg
ICAgaWYgKERPX0JJQyhCSUNfU1lTX0xQSSkpDQo+ICAgICAgICAgICAgICAgICBwLT5zeXNfbHBp
ID0gY3B1aWRsZV9jdXJfc3lzX2xwaV91czsNCj4NCj4gLSAgICAgICBpZiAoIXBsYXRmb3JtLT5o
YXNfcGVyX2NvcmVfcmFwbCkgew0KPiArICAgICAgIGlmICghcGxhdGZvcm0tPmhhc19wZXJfY29y
ZV9yYXBsICYmICFub19yYXBsKSB7DQo+ICAgICAgICAgICAgICAgICBzdGF0dXMgPSBnZXRfcmFw
bF9jb3VudGVycyhjcHUsIGdldF9yYXBsX2RvbWFpbl9pZChjcHUpLCBjLCBwKTsNCj4gICAgICAg
ICAgICAgICAgIGlmIChzdGF0dXMgIT0gMCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIHN0YXR1czsNCj4gQEAgLTc2NTAsNiArNzY1OSwxMiBAQCB2b2lkIHJhcGxfcHJvYmVfaW50
ZWwodm9pZCkNCj4NCj4gICAgICAgICB0ZHAgPSBnZXRfdGRwX2ludGVsKCk7DQo+DQo+ICsgICAg
ICAgaWYgKHRkcCA9PSAwLjApIHsNCj4gKyAgICAgICAgICAgICAgIG5vX3JhcGwgPSB0cnVlOw0K
PiArICAgICAgICAgICAgICAgZnByaW50ZihvdXRmLCAiUkFQTDogQ291bGQgbm90IGNhbGN1bGF0
ZSBURFAgKFREUDogJS4wZiwgTVNSX1JBUExfUE9XRVJfVU5JVDogJWxseClcbiIsIHRkcCwgbXNy
KTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICB9DQo+ICsNCj4gICAgICAg
ICByYXBsX2pvdWxlX2NvdW50ZXJfcmFuZ2UgPSAweEZGRkZGRkZGICogcmFwbF9lbmVyZ3lfdW5p
dHMgLyB0ZHA7DQo+ICAgICAgICAgaWYgKCFxdWlldCkNCj4gICAgICAgICAgICAgICAgIGZwcmlu
dGYob3V0ZiwgIlJBUEw6ICUuMGYgc2VjLiBKb3VsZSBDb3VudGVyIFJhbmdlLCBhdCAlLjBmIFdh
dHRzXG4iLCByYXBsX2pvdWxlX2NvdW50ZXJfcmFuZ2UsIHRkcCk7DQo+IEBAIC03NjgwLDYgKzc2
OTUsMTIgQEAgdm9pZCByYXBsX3Byb2JlX2FtZCh2b2lkKQ0KPg0KPiAgICAgICAgIHRkcCA9IGdl
dF90ZHBfYW1kKCk7DQo+DQo+ICsgICAgICAgaWYgKHRkcCA9PSAwLjApIHsNCj4gKyAgICAgICAg
ICAgICAgIG5vX3JhcGwgPSB0cnVlOw0KPiArICAgICAgICAgICAgICAgZnByaW50ZihvdXRmLCAi
UkFQTDogQ291bGQgbm90IGNhbGN1bGF0ZSBURFAgKFREUDogJS4wZiwgTVNSX1JBUExfUE9XRVJf
VU5JVDogJWxseClcbiIsIHRkcCwgbXNyKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4g
KyAgICAgICB9DQo+ICsNCj4gICAgICAgICByYXBsX2pvdWxlX2NvdW50ZXJfcmFuZ2UgPSAweEZG
RkZGRkZGICogcmFwbF9lbmVyZ3lfdW5pdHMgLyB0ZHA7DQo+ICAgICAgICAgaWYgKCFxdWlldCkN
Cj4gICAgICAgICAgICAgICAgIGZwcmludGYob3V0ZiwgIlJBUEw6ICUuMGYgc2VjLiBKb3VsZSBD
b3VudGVyIFJhbmdlLCBhdCAlLjBmIFdhdHRzXG4iLCByYXBsX2pvdWxlX2NvdW50ZXJfcmFuZ2Us
IHRkcCk7DQo+IEBAIC0xMTIxNSw3ICsxMTIzNiw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFy
ICoqYXJndikNCj4NCj4gICAgICAgICB0dXJib3N0YXRfaW5pdCgpOw0KPg0KPiAtICAgICAgIGlm
ICghbm9fbXNyKQ0KPiArICAgICAgIGlmICghbm9fbXNyICYmICFub19yYXBsKQ0KPiAgICAgICAg
ICAgICAgICAgbXNyX3N1bV9yZWNvcmQoKTsNCj4NCj4gICAgICAgICAvKiBkdW1wIGNvdW50ZXJz
IGFuZCBleGl0ICovDQo+IC0tDQo+IDIuNDcuMw0KPg0KPg0KPg0KPg0KPiBBbWF6b24gV2ViIFNl
cnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgNCj4gVGFtYXJhLURhbnotU3Ry
LiAxMw0KPiAxMDI0MyBCZXJsaW4NCj4gR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2No
bGFlZ2VyLCBDaHJpc3RvZiBIZWxsbWlzDQo+IEVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENo
YXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQg0KPiBTaXR6OiBCZXJsaW4NCj4gVXN0LUlE
OiBERSAzNjUgNTM4IDU5Nw0KPg0KDQoNCi0tDQpMZW4gQnJvd24sIEludGVsIE9wZW4gU291cmNl
IFRlY2hub2xvZ3kgQ2VudGVyDQoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENl
bnRlciBHZXJtYW55IEdtYkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0MyBCZXJsaW4KR2VzY2hh
ZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBDaHJpc3RvZiBIZWxsbWlzCkVpbmdl
dHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpT
aXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


