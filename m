Return-Path: <linux-pm+bounces-7793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1EC8C4BD0
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 06:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082CC282128
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 04:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC12F125AC;
	Tue, 14 May 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nxx9qyvb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE6B645;
	Tue, 14 May 2024 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662475; cv=fail; b=OSla+K5NzzyYmvRqy9i/f+xHmsFL7TC0cAzVNWGd+a10YWUob5PYlFqoxrPzlZZjkQZH28izHQYcr81aGzAcVn51Um5/wU2lfBqIEd7Yy72qlFZ+SOM3jaz07rO8iOxBWbz5XhrgdWiC9RFTg9zjpaeQoEM7GUrLqxVZN6OHLFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662475; c=relaxed/simple;
	bh=0oUBTcvAkqTLtvskXmynssF/82Yx+YZMIMnpjwMugnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bsn/fCM63RRTluD5HAeQEqivInIvYQuzxa3YQolPMj7wk2QGx0dCh9I1jEorbYShdB0HcvwBCoVe108UoeV8rVEM2uNtJoD8I0GJMGErAn+ih3iBgytlRBxPnya97UvqQ+FuIDM4MmO6On+1Kxa1hiOGDdSmOOUSiKvUkSjfifs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nxx9qyvb; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9ZhA09WA/N9sfoYwohP46/KfrQf9wZ4/1dDYour7YGjwG6ql0ekzuzWz9vnFe+aLYivpBdANoSdgTJ82hDRmRikvMU+pgKQWNYTMyGZxIUnzkP8eDimmuT8ZQ1pWu4Cwq8Z6zUMlBVixk/WU10U2yP0IiU03EafFXCygplkJv41ZS4qvprmj3Y5LALCL9pqpmCt3muvhCnnSlKNc3Nt0hxyVaeAV/wuBszr4EuV6ew9gPmMJCMHBs7tB9QfV58l/juaY6Fz697gRPKRZvLhCnUlBrNPElxE+Je/JRL64xPjGcE7BWHPXl5h+zHHnOat1uEMY2TeWPIkSKDIpof0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oUBTcvAkqTLtvskXmynssF/82Yx+YZMIMnpjwMugnE=;
 b=H/DpH+Dso9bJEOEyAAIZtResxNB3LtxnrWjHI1t1ucDSFDQYI9yb6qinY4NzfypIGr2v2WaBB859tR8bgNJDerqRLv1fgtPuE/VV/szsBL1B2O84ZHsJ0ysyP9Pq2Fl36O9G7cYTB8LST4BGOijEMfzvTvTyHezdpI5uR+Y96vPlWJ0WttAxzZ0jVPcF+JO2tLatWNbQ9AThO/fH18z6hGAHdD7k4qyv2rd8Ff1J+godbWBgIn6iMqOGQs9wOBQb/12+jTTNaF4pSn9fGu+l/NWR/fqmolzJ4lrmrKbTiyp834KAuS2Awk0RpubzWEMNV6+YHCBf6eo4KvlGCxlqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oUBTcvAkqTLtvskXmynssF/82Yx+YZMIMnpjwMugnE=;
 b=Nxx9qyvbwjGflO+rK4+/8CqShyTMqnnOFfTqOKEaeJGeNyJK/obY7HgVjV6OCVky018hX1OSvf8mjvq4FslVaSnt6XHM+CAahN26DoYODKLTlaM38i+oYE9BayoSS64QvHiY4lxeMF3751dVwTmZdW9uQ+EQEaaT0zhCzqUom1c=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 04:54:31 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 04:54:31 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Petkov,
 Borislav" <Borislav.Petkov@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 10/10] cpufreq: amd-pstate: automatically load pstate
 driver by default
Thread-Topic: [PATCH v2 10/10] cpufreq: amd-pstate: automatically load pstate
 driver by default
Thread-Index: AQHapNrH3BV3l76At0a3MmIcgB9XorGU6H0AgAFCoKA=
Date: Tue, 14 May 2024 04:54:31 +0000
Message-ID:
 <CYYPR12MB8655E346702A34FAD22300B89CE32@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
 <9b31fbcdfd4e4f00c3302f45e655aa43589b224c.1715356532.git.perry.yuan@amd.com>
 <c3275383-9b3c-41b2-a65f-2df50fefafb5@amd.com>
In-Reply-To: <c3275383-9b3c-41b2-a65f-2df50fefafb5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=62ba041c-6353-43eb-b975-3d6657e412ab;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T04:51:41Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|BY5PR12MB4081:EE_
x-ms-office365-filtering-correlation-id: cc0c5e08-1ace-442a-d78b-08dc73d1f16e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmxJWCs5bFFqUCszVkZXZTNoR0RVTXZ6MnhaUGwyUW1oUHpLWWczZnVZZkJp?=
 =?utf-8?B?NzFsbmMzbC9TcGYxZ2Q2NDFKWjAxUllUK2FWSTBLUmhuYkFMMWVQT3BSMk52?=
 =?utf-8?B?QitkTndTLytZU0o5OUhBbjRSUkg0YTVqdG91NXdMSU84TXFpcUt4UlVTUG9P?=
 =?utf-8?B?bHhFSTg2SEFqdUkwVDJMaGE2QStSekZ3VlN2ZC9XT3NIOTYvdm1wWThESnBO?=
 =?utf-8?B?TzErWWFLcmR6T2Zkc1VzajN6TWtBSEJhNUFiTEhIbnVsZjVjdlN6aHMzZGVV?=
 =?utf-8?B?VEt0b3ZlY2JFQitpeGlkbTFaemVjQWZIVGxYOGFnYkwwaS9jZGFEdjAzeE04?=
 =?utf-8?B?cS96ZndvcDUwVkZYMnhFWkNyUXc1TG5SenIxczFpNEVvNHRGNkNpVjJacnFF?=
 =?utf-8?B?dENOR3hrbUQ3ZmpjWXkzYms3OFBvRVplQ3ZuMjhSVnlXWDhuVDROeUhYakcv?=
 =?utf-8?B?QnByOXFKYXk1bHlMYUpGS0h2aDBzTUdVTThSUU9DQ295QXQrVjY3WG9zUmtD?=
 =?utf-8?B?VW4wcWhiem5BWXZRUmJKOUJNNmJsODVaM1pCMDNFekVMTTB1QTFqOXdjZm5W?=
 =?utf-8?B?anl3cVRtUjJpNzF1WDlJZGNYRThHamluSlFWdnF0NGUwa2hQRGlzSXNiRXlP?=
 =?utf-8?B?NWFzbGVTeW45SitXNUpIUzFGYmZsUk5EUk5WK0tDQlcySUlPVWQxelJBYUJL?=
 =?utf-8?B?Q1NnWWFJb0QyL0V6Qk9TUmFTeVhNQVMySE5HVW9kTktuVU5zNzZ4TjhBZEtE?=
 =?utf-8?B?bFRud2t0N0pia3lCcks4NnY3QWRYd0REeWpoOEtsdjI0SmJhVE5KejlXU3VH?=
 =?utf-8?B?QkgwV1UrKzNPL2YxN3VtZnBudTk4TWhzUXNqZkxUMisvb3pZN1VLWXRHdCtT?=
 =?utf-8?B?TkFHWEUwR3l3RGpaQ2Z5eCtTbWNJR21TTTJYOERvVjFmNjRCbDdjQytDMjB3?=
 =?utf-8?B?UkhoM2xEcTQ1UEhyclhISDZLNDEvb2FTM1lRbm5MVTVISTFTSlRUWmh4NHpE?=
 =?utf-8?B?R1pjaWNJMmtNTW9sMzloUUlIdVlGR1F0aVFaWXlIL3dYOW1UeW90ZmpEakg4?=
 =?utf-8?B?TDdTOEJOWkZkZ2lsYUtZQlh4WlhJZ3kyM0wyL0RGZ28xSEpibzdoNjgxSVZ5?=
 =?utf-8?B?Tjc4blpVaE5EQTE5SmIrK3psS0drdEk2S2pncURiQ2FCUTkvNjc3ZXNnSEY2?=
 =?utf-8?B?QTBkcTFrRDhFd0RTd1BNeUtqaVcyQ0xiQ09jRThLYndkMHBZQnRIOUVVbjNv?=
 =?utf-8?B?R3NBWWdiNXFXck9kODNidEJhaDlKZWIzeWdMVzUwaWo5blRRM1llVy8wU3Qr?=
 =?utf-8?B?RlllQXZIV2FaMERsOHJhRWJ2cDJlblhnTmhvbGFHeXo4ck1UUjBrWE1sanEv?=
 =?utf-8?B?bU5PWGFJbmxZYlV1U3A1enBTcGl3N3BMVFlhN3Ara05ONFA5d3NnZjkrT1VU?=
 =?utf-8?B?bDBnQ240c09Ocmx0Tkx6RzAwTVdqcTE2QWFxM2JybnRiSFYxMTdkaTNsYWRC?=
 =?utf-8?B?Z2FQTmRXdEtOOUpMdzN0czNIZlJPazg3cjNNbGtsR2pFeERhUE9kdG4rTlYw?=
 =?utf-8?B?RlNJNUVpOGhNeHJYeUFjeFZ3aDRvZk9RQUh3ZndmMTBjMlBpUloyc0pYdm03?=
 =?utf-8?B?M0Y5R1N0dUlrTWR4L21TeUtCcE5VNzFzWWViUFY0c3o3UjFsdGFiVTdmTzNq?=
 =?utf-8?B?b210OTdHZmZJRWV6VlBvd0pVVEF0aFZuZGp6MEFRQVFKY1MzcXBodVFEazMr?=
 =?utf-8?Q?YdM1zTzxUPUr66xQ7k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Smxtb3g5ME9KZGJxanprWEZNYTNqN3VMSEVXakk4bWVBRkU2bmRGc1pIUis4?=
 =?utf-8?B?Vjk2N2lmQUZGaVBSMFllWjdxZ3l3WFFnNlhzUU53dUJCVHZyVjlyeGV1TzA0?=
 =?utf-8?B?ZGg5S28zdEhydklBWE55V0ZxMVRHeEhBV0VZcVc2SHJqSVlLVVhTL2ZMVnpG?=
 =?utf-8?B?WXlwL0FHS1Q3TU5uUG9wanh2eGx2SEhaKzF3V05VK0RlSDhLZWdDMHNSb2tH?=
 =?utf-8?B?L29GcDNaR0xlMDRNYkFRR0JlVXY5TU9WMXF5SzhEYTdIVDlDTXJjYnJqUC90?=
 =?utf-8?B?cGxzYTQyNkU2QzVseGZ6VUJwRDd2d3VSckE2Wk5TdVBqcmpyaW5EUXp6OGh2?=
 =?utf-8?B?dU1ZS0JkaEM1RUc0QllFK2Z2eEM5V1BvV0hmTWNRSUlSYU5rb3ZkZk5QcFJi?=
 =?utf-8?B?ZWY2Z3Z5YkdISWszMDl4UklyUlhyZ1lRUHFlcFV0aFRJRHB0VXg3VUJhcTdG?=
 =?utf-8?B?cEt4M1liQ0I1TVlPdGdCSTVJZ21CQ2hmK25VWHpNb21EbWIyL1ZFZjh4VkNk?=
 =?utf-8?B?VEV1VnV4TVNTcDROUHpPY0VOeFFSclpETzRnUGxlbzgxOTluT1QwQlBSb2Jo?=
 =?utf-8?B?NUhsRW1NMzU4UE91WjA0MzZUeGxxOUVMUXR4S3pJWXA5eXdBK0JuRXVXUFpI?=
 =?utf-8?B?c1EvSXEweWpiK211TVFSNXdMRzE5R3ZleWVxVDZ2U0pZTUdnSWVuamVZOWhv?=
 =?utf-8?B?MmYxN0g0akVFK205VTdVT1N0WTlIeGU3WWl5VWEzWFZoRjYzdFJLdDBZUGtv?=
 =?utf-8?B?cU1wSFAzVUM3TEh3VFUwMFE4dXNUMVBwOWgyT1JvUUs1bG9GMXBWdUdkZjhX?=
 =?utf-8?B?ZzVMMGc0UnlkNXZ3STlXV0svVk9URlNVb0hUN2JSeW1UcWl2dU1pRGhWeUIz?=
 =?utf-8?B?UVdQWDZCVm1BZmw3NVk5WUxlR0RuMDQxelR6NGtsR3BNNUQxQzRzQmhXek43?=
 =?utf-8?B?VDFnZ3liTVJDemlRUVVybUI4alNwODFLOVJuR2NkVVlFRXIxYWNVcVArbVVN?=
 =?utf-8?B?UWM2REl6WTJGaG55bUZKRnNmdHc2OUpFLzZOb1ZYb2xTVE9qay9ERGpCTWFS?=
 =?utf-8?B?dklYYmU3MngzYjlrbU52OHpZczZvaFppNUU2cmRab3ZocnkrQzBJNzVFdHBu?=
 =?utf-8?B?cktkV0RTQTJLQkNWdElrRytIQzNHRld4QnM2ejJJR25LZGRoMHlZM3VFOXg1?=
 =?utf-8?B?c09oL2ZnQmdCRmQvZ1lLRTZEd2l4Vk5aUlB0bmVkN3p3eWZTenp2bkJldnFQ?=
 =?utf-8?B?c3Z4MGltV21xVnNBK1VXbkM2eWhtdk9GNHVKSVVQRWFTM3FYNkprRG1FUExM?=
 =?utf-8?B?VFFoQ2pnaGVqaldaQ0M5dVNITTh1QTdENGJ2ejhYenBDa0I0L1dzWVBzRnpr?=
 =?utf-8?B?QnAzSnNOdnQ5YTZZZXI2NVZlb2t3RTEvbWU2OVVMVGo5YmRSbXhTS2w5N0hp?=
 =?utf-8?B?WXEvNmVyL2duc21UcENDcUs0SjZITkNPd1Z6Z01UOG9vdERqTXpScU9wdG40?=
 =?utf-8?B?MVpHK2FkVUVWT1piSVMxQ1I4LzlIYS82N3crUVkwOHc0aUVSSi9GS29kWEVw?=
 =?utf-8?B?L0hEd0xsOXl6U1FvRFdDV0liWWl5VXBCb1pZMUdqVzJ5bFBGSWdXeGNVckZw?=
 =?utf-8?B?eGdPNkZrOEsrMFdUTUtHZjFPaFZIc01KekpNL0JOSmpmMmJaQ3Z6ZTQ1Vy9V?=
 =?utf-8?B?UndOZG5DL2FFYjdhY3ZEdG9jcHkwTkVhUGhxVXFqZnk4SklUK0EyR25RN0pI?=
 =?utf-8?B?cno0U1NxaUNpQ3lFaSt0cmVzYmZNck1qOWJYbFpJdG44QW5Yc0xyQjVMLzlY?=
 =?utf-8?B?SldoUUpKczdZNGozd2E0cC9DcTBrRzB5TEF4VWJPMTRhQjdZUkxsd0xmdUYv?=
 =?utf-8?B?bC8vQzFJa2toUnkzR1pzRXFzd2NnL1lRZDQ3MnpRcEE5LzB5bi94VG9ZVEpl?=
 =?utf-8?B?QW4wTzNFNlZkd1I1dWNzZFg4ZXhkaGliSUdXWE1GaWFYSjQxczh1RElQVWVa?=
 =?utf-8?B?Um9rUUVpZ3hreFFMMVRZdDd3d1hTaVVwdUo4VnZtMnluUXpnYVBDT0ZQbzNW?=
 =?utf-8?B?aWdDd3NwSTI2RDEwVng1OVduSW1qMk9OMlFPQVlPc3ZqYjlFSG0vQnZNNHgr?=
 =?utf-8?Q?BdTg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0c5e08-1ace-442a-d78b-08dc73d1f16e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 04:54:31.5358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGOEZbS33Br/fCLH/zIAie0oh0aDaFpIS8om5ooi3mvFDDCtCDjACw7OYg1JjHMsCYsTsmy2yXAYd4o1wqQwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgRGhhbmFuamF5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
VWd3ZWthciwgRGhhbmFuamF5IDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPg0KPiBTZW50OiBN
b25kYXksIE1heSAxMywgMjAyNCA1OjM3IFBNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVh
bkBhbWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQu
Y29tPjsgU2hlbm95LCBHYXV0aGFtIFJhbmphbA0KPiA8Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT47
IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgUGV0a292LA0KPiBCb3Jpc2xhdiA8Qm9y
aXNsYXYuUGV0a292QGFtZC5jb20+DQo+IENjOiByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsg
RGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcs
IFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2pp
YW4uRHVAYW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47
IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxMC8xMF0gY3B1ZnJlcTogYW1kLXBzdGF0ZTog
YXV0b21hdGljYWxseSBsb2FkIHBzdGF0ZQ0KPiBkcml2ZXIgYnkgZGVmYXVsdA0KPg0KPiBIZWxs
byBQZXJyeSwNCj4NCj4gT24gNS8xMy8yMDI0IDc6MzcgQU0sIFBlcnJ5IFl1YW4gd3JvdGU6DQo+
ID4gSWYgdGhlIGBhbWQtcHN0YXRlYCBkcml2ZXIgaXMgbm90IGxvYWRlZCBhdXRvbWF0aWNhbGx5
IGJ5IGRlZmF1bHQsIGl0DQo+ID4gaXMgYmVjYXVzZSB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBw
YXJhbWV0ZXIgaGFzIG5vdCBiZWVuIGFkZGVkLg0KPiA+IFRvIHJlc29sdmUgdGhpcyBpc3N1ZSwg
aXQgaXMgbmVjZXNzYXJ5IHRvIGNhbGwgdGhlDQo+ID4gYGFtZF9wc3RhdGVfc2V0X2RyaXZlcigp
YCBmdW5jdGlvbiB0byBlbmFibGUgdGhlIGRlc2lyZWQgbW9kZQ0KPiA+IChwYXNzaXZlL2FjdGl2
ZS9ndWlkZWQpIGJlZm9yZSByZWdpc3RlcmluZyB0aGUgZHJpdmVyIGluc3RhbmNlLg0KPiA+IFRo
aXMgZW5zdXJlcyB0aGF0IHRoZSBkcml2ZXIgaXMgbG9hZGVkIGNvcnJlY3RseSB3aXRob3V0IHJl
bHlpbmcgb24NCj4gPiB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIuDQo+ID4NCj4g
PiBbICAgIDAuOTE3Nzg5XSB1c2IgdXNiNjogTWFudWZhY3R1cmVyOiBMaW51eCA2LjkuMC1yYzYt
YW1kLXBzdGF0ZS1uZXctZml4LQ0KPiB2MSB4aGNpLWhjZA0KPiA+IFsgICAgMC45ODI1NzldIGFt
ZF9wc3RhdGU6IGZhaWxlZCB0byByZWdpc3RlciB3aXRoIHJldHVybiAtMjINCj4gPg0KPiA+IFJl
cG9ydGVkLWJ5OiBBbmRyZWkgQW11cmFyaXRlaSA8YW5kYW11QHBvc3Rlby5uZXQ+DQo+ID4gQ2xv
c2VzOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxODcwNQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDM2DQo+ID4gKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNl
cnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5j
IGluZGV4IGRjZTkwMWE0MDNjOS4uMDMzNDJmZWY3ZDk0DQo+IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1k
LXBzdGF0ZS5jDQo+ID4gQEAgLTE3ODUsMjggKzE3ODUsMzAgQEAgc3RhdGljIGludCBfX2luaXQg
YW1kX3BzdGF0ZV9pbml0KHZvaWQpDQo+ID4gICAgIC8qIGNoZWNrIGlmIHRoaXMgbWFjaGluZSBu
ZWVkIENQUEMgcXVpcmtzICovDQo+ID4gICAgIGRtaV9jaGVja19zeXN0ZW0oYW1kX3BzdGF0ZV9x
dWlya3NfdGFibGUpOw0KPiA+DQo+ID4gKyAgIC8qIGdldCBkZWZhdWx0IGRyaXZlciBtb2RlIGZv
ciBsb2FkaW5nICovDQo+ID4gKyAgIGlmIChjcHBjX3N0YXRlID09IEFNRF9QU1RBVEVfVU5ERUZJ
TkVEKQ0KPiA+ICsgICAgICAgICAgIGNwcGNfc3RhdGUgPSBDT05GSUdfWDg2X0FNRF9QU1RBVEVf
REVGQVVMVF9NT0RFOw0KPiA+ICsNCj4gPiArICAgLyogRGlzYWJsZSBvbiB0aGUgZm9sbG93aW5n
IGNvbmZpZ3MgYnkgZGVmYXVsdDoNCj4gPiArICAgICogMS4gVW5kZWZpbmVkIHBsYXRmb3Jtcw0K
PiA+ICsgICAgKiAyLiBTZXJ2ZXIgcGxhdGZvcm1zDQo+ID4gKyAgICAqLw0KPiA+ICsgICBpZiAo
YW1kX3BzdGF0ZV9hY3BpX3BtX3Byb2ZpbGVfdW5kZWZpbmVkKCkgfHwNCj4gPiArICAgICAgICAg
ICBhbWRfcHN0YXRlX2FjcGlfcG1fcHJvZmlsZV9zZXJ2ZXIoKSkgew0KPiA+ICsgICAgICAgICAg
IHByX2luZm8oImRyaXZlciBsb2FkIGlzIGRpc2FibGVkIGZvciBzZXJ2ZXIgb3IgdW5kZWZpbmVk
DQo+IHBsYXRmb3JtXG4iKTsNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gPiAr
ICAgfQ0KPiA+ICsNCj4NCj4gV29udCB0aGlzIGNoYW5nZSBtYWtlIGl0IGltcG9zc2libGUgdG8g
dXNlIGFtZC1wc3RhdGUgb24gc2VydmVyIHBsYXRmb3Jtcz8gSXQNCj4gd29udCB3b3JrIGV2ZW4g
aWYgd2UgcGFzcyAiYW1kLXBzdGF0ZT1hY3RpdmUiIGluIGNtZGxpbmUsIGJlY2F1c2UgdGhpcyBj
aGVjaw0KPiBpcyBiZWZvcmUgdGhlIHN3aXRjaCBjYXNlLg0KPg0KPiBUaGFua3MsDQo+IERoYW5h
bmpheQ0KPg0KDQpHb29kIGNhdGNoLCAgdGhlIG9yaWdpbmFsIGNoZWNraW5nIGlzIGRpc2FibGlu
ZyBzZXJ2ZXIgcGxhdGZvcm0gYnkgZGVmYXVsdCwgaXQgc2hvdWxkIG5vdCBibG9jayB0aGUgc2Vy
dmVyIHBsYXRmb3JtIHdoZW4gdXNpbmcgImFtZC1wc3RhdGU9YWN0aXZlIiBpbiBjbWRsaW5lLCAg
d2lsbCBmaXggaXQgaW4gdjMgdG8gYWxsb3cgcGFyYW1ldGVyIGlucHV0IGZvciBzZXJ2ZXIgcGxh
dGZybSBmcm9tIGNvbW1hbmQgbGluZS4NCg0KDQpSZWdhcmRzLg0KUGVycnkNCg0KPiA+ICAgICBz
d2l0Y2ggKGNwcGNfc3RhdGUpIHsNCj4gPiAtICAgY2FzZSBBTURfUFNUQVRFX1VOREVGSU5FRDoN
Cj4gPiAtICAgICAgICAgICAvKiBEaXNhYmxlIG9uIHRoZSBmb2xsb3dpbmcgY29uZmlncyBieSBk
ZWZhdWx0Og0KPiA+IC0gICAgICAgICAgICAqIDEuIFVuZGVmaW5lZCBwbGF0Zm9ybXMNCj4gPiAt
ICAgICAgICAgICAgKiAyLiBTZXJ2ZXIgcGxhdGZvcm1zDQo+ID4gLSAgICAgICAgICAgICogMy4g
U2hhcmVkIG1lbW9yeSBkZXNpZ25zDQo+ID4gLSAgICAgICAgICAgICovDQo+ID4gLSAgICAgICAg
ICAgaWYgKGFtZF9wc3RhdGVfYWNwaV9wbV9wcm9maWxlX3VuZGVmaW5lZCgpIHx8DQo+ID4gLSAg
ICAgICAgICAgICAgIGFtZF9wc3RhdGVfYWNwaV9wbV9wcm9maWxlX3NlcnZlcigpIHx8DQo+ID4g
LSAgICAgICAgICAgICAgICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0NQUEMpKSB7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICBwcl9pbmZvKCJkcml2ZXIgbG9hZCBpcyBkaXNhYmxl
ZCwgYm9vdCB3aXRoIHNwZWNpZmljDQo+IG1vZGUgdG8gZW5hYmxlIHRoaXNcbiIpOw0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gLSAgICAgICAgICAgfQ0KPiA+
IC0gICAgICAgICAgIHJldCA9DQo+IGFtZF9wc3RhdGVfc2V0X2RyaXZlcihDT05GSUdfWDg2X0FN
RF9QU1RBVEVfREVGQVVMVF9NT0RFKTsNCj4gPiAtICAgICAgICAgICBpZiAocmV0KQ0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAtICAgICAgICAgICBicmVhazsNCj4g
PiAgICAgY2FzZSBBTURfUFNUQVRFX0RJU0FCTEU6DQo+ID4gKyAgICAgICAgICAgcHJfaW5mbygi
ZHJpdmVyIGxvYWQgaXMgZGlzYWJsZWQsIGJvb3Qgd2l0aCBzcGVjaWZpYyBtb2RlIHRvDQo+IGVu
YWJsZQ0KPiA+ICt0aGlzXG4iKTsNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4g
PiAgICAgY2FzZSBBTURfUFNUQVRFX1BBU1NJVkU6DQo+ID4gICAgIGNhc2UgQU1EX1BTVEFURV9B
Q1RJVkU6DQo+ID4gICAgIGNhc2UgQU1EX1BTVEFURV9HVUlERUQ6DQo+ID4gKyAgICAgICAgICAg
cmV0ID0gYW1kX3BzdGF0ZV9zZXRfZHJpdmVyKGNwcGNfc3RhdGUpOw0KPiA+ICsgICAgICAgICAg
IGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgICAg
ICAgICAgIGJyZWFrOw0KPiA+ICAgICBkZWZhdWx0Og0KPiA+ICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPiA+IEBAIC0xODI3LDcgKzE4MjksNyBAQCBzdGF0aWMgaW50IF9faW5pdCBhbWRf
cHN0YXRlX2luaXQodm9pZCkNCj4gPiAgICAgLyogZW5hYmxlIGFtZCBwc3RhdGUgZmVhdHVyZSAq
Lw0KPiA+ICAgICByZXQgPSBhbWRfcHN0YXRlX2VuYWJsZSh0cnVlKTsNCj4gPiAgICAgaWYgKHJl
dCkgew0KPiA+IC0gICAgICAgICAgIHByX2VycigiZmFpbGVkIHRvIGVuYWJsZSB3aXRoIHJldHVy
biAlZFxuIiwgcmV0KTsNCj4gPiArICAgICAgICAgICBwcl9lcnIoImZhaWxlZCB0byBlbmFibGUg
ZHJpdmVyIG1vZGUoJWQpXG4iLCBjcHBjX3N0YXRlKTsNCj4gPiAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiA+ICAgICB9DQo+ID4NCg0K

