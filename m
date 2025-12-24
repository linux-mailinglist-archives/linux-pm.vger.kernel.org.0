Return-Path: <linux-pm+bounces-39915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B610CDC2F2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 13:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B88230206A7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7F2D1907;
	Wed, 24 Dec 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QwmiG6h/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c1pz0IU1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D6218ADD;
	Wed, 24 Dec 2025 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766578724; cv=fail; b=rELlNX7rSt/z8n/P8Ytm3cjc6+7y7asCXKu1UL1gB1MukzyUh31FMUrMqwIoDN3LhAn9U8hTeoQKVOB7+PjBdWoTKHYO8CIkYiCBCQbqULuPNC46xmkSjbfLfX30M3reiS99WOStlm/dzzSTgz4QOhIoF3DoAJa9Dav7xCGpwgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766578724; c=relaxed/simple;
	bh=P7xFX25qdjvwIFjHhQMYTGlu0eIjKypYiqoQ2qLB5bY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bj8fcS2jz8MuSg1wF9HamTQS3nI+G56yVAGG0peGi1khhhsAm7rlHqF8tmmfjtOweocbP8+sTYZrUzgYmNFwK/1s0fpUDTzC5sdrYKHTYak5uFT8VY5GLtwhu93sk2GgdDPREwApmcEOmEhTiyE9rFh1ZR9Xn+yL9LIQ+IEQMZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QwmiG6h/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c1pz0IU1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BOAjNV92516674;
	Wed, 24 Dec 2025 12:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NbP5P0jg6Ocz8Kl0T/74rXaDOZy5iCDh34Da+VqAZbg=; b=
	QwmiG6h/dV5YlOKjWh6fjdPON5AhUBtkxh4MypGAtvP/lIvsd12Jv4mnrSvhYMEs
	31ASpgdxU088tcEmumgtojGnOU5TTXEbACPpVJcCZR/m7C6LZxs37sWK3i/IQ0Ob
	sftTPZZ3dkW3kynDDdxK19AfxqqDqOdmkc8byjEMfnnocgMPGmTVZotjOEsHoXR9
	7qCKABexDBHfzVw4XigBJ5J0kHe1UJO/oZuBIkGSeKC5Ek+xXvdjGvAYIaDEt2ZU
	pCOgHQMMfxYZf+dWtcL+1dzIycMoVFCABzo3TYE8ech6FhGyC7ztwXfd1dSKIcXE
	h/VchJRw6851iWrtqylvjA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b8epvr243-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Dec 2025 12:18:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BOBsgPU002698;
	Wed, 24 Dec 2025 12:18:27 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j89cpy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Dec 2025 12:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9FBKAm2T/PY1ymConM8quVLHSL0AK4zXgLXplv1pWiUKpaFqNRM5N5Qx9VUiR9b/AkpQI5HB46ivlKmt99uerK84UiDMJh3mpo1gGKCZsG9xVQTbSWC9kp4a0N216DknYixm1lMho+K0wHRvtM32LO6dzAq6RWUyXhY+rMoyUV3wsJHrp/Cqframnoaf0JFc1Slq7RBO3ECQblBkm3jq0EEcrmxhAuHfkg66dM3vj3O//Bm9KEzlnmoHHiTFrxN2NbZdMwqhk+NBPwPP/7O6YmH/hrEbnpBBqALWP9T4MAS9fFMyayuqX1rNHD4AlPwDZlr61fG4eWeAP9WskfAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbP5P0jg6Ocz8Kl0T/74rXaDOZy5iCDh34Da+VqAZbg=;
 b=XfeR19t3WxENgQNObiDLltJsFptVvz+3My3seTGa858LhWXQIqJuIs+EdMZfguLGZKIDv6oub8SAF1WRF3i3iEXPbO34av03PkIO6h/rK9MVb3R4PZlo3fa4KKK88b4xniG9sKN91HM9/iEsObBQe892M1a0sbgA3rvR6MRvK+nmzgnOT34UH0YL2ozLjPmhd89SdnFo7TRJOZ6MpDbKKT5if3By/5iEJY2ZBBZ1VNagIGrkQlEUDc0kWTpMfGn6Zj6pTSmCAQTFcZeGpLU3JG9ralgq9OdUKNjULmctzWonfRrp8fyrwGmQQND4ftoMog4ah56s2svdu8nDvf1iXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbP5P0jg6Ocz8Kl0T/74rXaDOZy5iCDh34Da+VqAZbg=;
 b=c1pz0IU1LB+yZbCXm61unxTwHiJ1CXz6VGKMiiqhCYCk3DnFrS6vH6dDkZ8gELzA3Ke126fmvKIEIzgb0GK3oeOw+Za3c44Hhm8+8NBF1+M1INVYtVBnl2B0py1qtXJqmabz/DrkvuQEhhiymrPK0PoTIUgenkYS8PQubjCb0GI=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB7431.namprd10.prod.outlook.com (2603:10b6:8:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 12:18:10 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 12:18:10 +0000
Message-ID: <c44a14db-28b6-41f3-984b-bfe67fecfa66@oracle.com>
Date: Wed, 24 Dec 2025 17:48:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [report] Performance regressions introduced via "cpuidle: menu:
 Remove iowait influence" on 6.12.y
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
To: christian.loehle@arm.com, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <c0b5c308-ea18-4736-b507-01cb06cb8dfc@oracle.com>
Content-Language: en-US
In-Reply-To: <c0b5c308-ea18-4736-b507-01cb06cb8dfc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cfa15e-9815-4014-0cf2-08de42e68098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emZpRGg1MS8yNGIybnYrMFhDUjEvbW9xTWp0V2poYVlRamVwNHVPQnd5amZx?=
 =?utf-8?B?WkFHeUhFWkJmUDA2NGtVRG8xYmZjdFpSUHBYcVBWNURCVDBVdklXWTYzQWVl?=
 =?utf-8?B?eWlmekNTc1BjR2VNRXpNazBXSllISVUxQVVNMWhmZWFob0h4TUJ5WkVieVBL?=
 =?utf-8?B?VVNJUW9STHp2aml4azYzZ1RNb2t5Y1ZrVFJsWmhCVkVrWFpvQnRLWlc2YldF?=
 =?utf-8?B?VUZDSTdaVlZweW9nZm8veDlvS2dzdmtZTWZmcHBZV3pSWlo0TThVeElGRnd5?=
 =?utf-8?B?ck50RW1Rc1N5aXhFWENZOC9yb29OQ2lqM0N5cWIxR1Jnb2ZRY25lWHVuc3Mv?=
 =?utf-8?B?TmxrWFg4clhIWk5tbUJrWjAyd1BKUHp3MGdZVndVOG1tbkpiTGpoVUc4bmpK?=
 =?utf-8?B?bHJMeGJOcEdEQ1VuNEVuOVR4QU91dlBmK0p2RXZOMUZuUkNsTGZOY210TStV?=
 =?utf-8?B?bnpyUHFLem5Vd3lOVjlqRmRWbFlPQWYwOXN6UHlNZzk0YXd1bVpmMHdEeENt?=
 =?utf-8?B?VmdjZi85Mm0yRmxZMTFIVllkUTJCS2ZzVTR0ZVIxcSsxWGcrL0NEakNNQk5I?=
 =?utf-8?B?YU03RDlIekRoU0JIb3ZyUkVRRVVhT3lRaHRKK1lSSjh2bHdSTC9lR3h4V2pG?=
 =?utf-8?B?TW5EZGhDTGxwQ2RKOXJFVXZjZWczbTJXUkFhSkV2Mm9QL3FvV3EzQmhjd0pj?=
 =?utf-8?B?MEJYZTcvZXJFTFFKMXR6L2M2U2N6N2o4SHZBSlBoZnRsSTluOThnSTh6U0Nk?=
 =?utf-8?B?c0VGRW5lek9NV29jK25mVGx6WG41YXhrK29IU1U3dFpRLzZaN2g2SFoxU25C?=
 =?utf-8?B?V2RGcUtrdTZMSWVma1Y4SlJoRExPc1NlWWN2K2JmdWx5OXhqWFJmcWJFanZt?=
 =?utf-8?B?U09zdGNNeVlqb0FCKzgxbXJXY01YUGRtR3hYT09aeDIwSkFmT0lIZU8xdnhm?=
 =?utf-8?B?M2RiUzFMZjBKV05RSERJOHZTdXBENUNqdFIrUCtLMjJCb3BieDFGVWJmM3dj?=
 =?utf-8?B?OHdSRDlXYnFnR1hYNE1KRzUyUG1xd2d6WGJpQUxoSE1nSEFOK0dnZGY1Wm1I?=
 =?utf-8?B?NTN6akhldHVWRXNKSXR0WmhhZVd4WFdyZkl4YkNrQnVpRkF3cDVlTFlsTS9k?=
 =?utf-8?B?anJQdWJIZ2tKandibU5HWlFrMDZwdnFhUEtjcVhvclc4UXRZQXQ0Z2I5WERK?=
 =?utf-8?B?UmcxVFhjMzVoSCtnbUdxTXd6UEtETi9BUDc3U2JXSVJjdVpldHBDekFGeTY2?=
 =?utf-8?B?K1RtelBuTmVRZWR5cUpDd0xlcWhYREwyR3JydG50YzBZQ0J6c3AyWFp1Yi9s?=
 =?utf-8?B?aWFocE1iU1V5dTJXb0dRVklZS2xtRnAzYS8xNnZJR1duWDBGaFpqRDdiejNR?=
 =?utf-8?B?MENoaWZkVEpid3daelFWSjlETTFteGdWT1ZnT1h2NHhLMWlRMGJNdVFNbVFD?=
 =?utf-8?B?S1JBQ21IME8wSUhHdHh2SkpCR0E4UmNJZWJLN0tTNXJyVytQTWtjYStQckZ2?=
 =?utf-8?B?WUhvV2ZhckE3b2w4RmlCSUJDOTVUSHlESnlNaUJtMHJQZVEzd2x0THVlN3p2?=
 =?utf-8?B?OGk5a29OMDdkNUpxSjBlS0piOWdDd004NlZ1b0lZeEZUQk9TL0xvYW9EcUNu?=
 =?utf-8?B?R2YwR05ZRFJ0SlZENFRiSXo1TkRyVDZkbkhkRmQ1VUhucnpZMk5VVWt6b1Fx?=
 =?utf-8?B?c29HMjJNOXhYTjVmS0VGSjlBL1YrejZrWjI5ejNMTEVwWUs2TDJTY3NnRWdP?=
 =?utf-8?B?VStZR2JZd0IxaDlHYWh0WjdnelYzUmd4UzZ3bGUydmR2UUdqT3FIOCtlcFA1?=
 =?utf-8?B?c2ZoU2RiMGtaTmNaMFpIWXdRTnBiMjRhL25kYTFjWXpuVjgvclBYcFd2c2N1?=
 =?utf-8?B?eHhuWENpZkV5TXlGQ2lJVGhmMDB3WnVKZHZURzRta2J1aklINUtON2RsSnZq?=
 =?utf-8?Q?d7hgyEVu6wd0oYdGbIWG4rDRIOA4XoRm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHZSSUZGNzFkdDZQcjRzeVlWZGRid3h5b3B1cm5rVTIwaktpOTBIVERQWEFZ?=
 =?utf-8?B?eFVTVVdxSVc4YXhJdmUxMXJBdFp5bHlxN2o1MURvMitDY0FtQmF0T2x6N3BW?=
 =?utf-8?B?QlRYU21oT0IxWTB3OHFHdWtJRkJwQzFScFdUY2cxVloxbFhXMEtBaVJmK3JE?=
 =?utf-8?B?UkVid20vSFN4VitpRjB6Mis3djE4cC81UXpFaVlsSGd6Nkc0L0Q3TEZuUjJY?=
 =?utf-8?B?ZzlYNjRubEZSVjJUNFQreUFRbVhxT08xeVVuOUJFYlBkOWQ0bm9OMjNIakkx?=
 =?utf-8?B?NGhwMU85K2t1VEszVi9jZWZPazZaaXVqVEtocHpYS2FaWU9qWkUvbi9hc1pM?=
 =?utf-8?B?L0lxVzFaUjg4K0xnQmFDbDZuMHV5bGxIMzJKdFR6OGJKZGVxWitmby9GcU01?=
 =?utf-8?B?MzZ6eE5iUFlYWm5RMTNRR1Yyd1NSbU1WTXFra1RMdTNzTnJaS1hPaEMzM2pl?=
 =?utf-8?B?ZkptWk5UT3RSS1VlZjVUVFJadHZyZDlad3NuZzQwVGE0SUk0OUFjOTNHdkkr?=
 =?utf-8?B?b3lpMnIzN1pKaFNEUWx6SWU1VXZRbnlKeXlHS0orYkc0RW5YNDhZUU5yZFF5?=
 =?utf-8?B?V3YzdHdES3B1L1llRVhYWllqRjlxRFdBUlFKSm5uT2N3bFpBdGpFN2VrOG1l?=
 =?utf-8?B?VnRuSFYraXN5Ky9TZC84SEs0bUlWVzZDUVRUeUdXUHBzM2hFa3FCR3B1dldJ?=
 =?utf-8?B?SmZ3TmtzcGh6MXFtbWN5NU5jWUFrTy90T0NHSzlLS2x6d1RDYzNZY2VFR0E5?=
 =?utf-8?B?ZXlZbi96MW5vSjFZRGNoUGYySDU4SFcrUUkyNmxCanZmQWRyRnVhWHkzREFo?=
 =?utf-8?B?ZkpYSXh4OTMyWXhqWnRXSWUvM0RaMk5JeU50WnhrbElEYU12NzhDUTB3Yy9P?=
 =?utf-8?B?RTVMdkU4RkQ3UlcwSloveGNFdktCQkFkSlllcHhEOUc2ODZyZFFZUUZWR0Js?=
 =?utf-8?B?TDNlK3A5OGkwdHdrdURRQndRTUo2NlR1QmtpUVE2YVZKVWpNMnJjcmNRV3RO?=
 =?utf-8?B?SzZUNXI4dzlFWmRNSjFQTkI3Wkx0aitaZFZCYzVUelNmYzVid0QvZi9iNDBV?=
 =?utf-8?B?QkdUQmFBb1UvanQrcmwzZFpnSUxWK1B2UTdNaUZUa2xiYUtlZlpIZWJLMXBq?=
 =?utf-8?B?MHlsdXdOYURHY1IzdHpwMzNNMzVqQUgwVkQxaFNxbUdRNFNnL1NRNmdvckx0?=
 =?utf-8?B?bFN6eWZpU3RHblZLcnNpanluVFEwVUNzRFV1K0lTcEtQblVhaGQyWHZQUmlU?=
 =?utf-8?B?cWF4Ukh3RHkyRHI1ak5mR0o4M3BEaTFZOHhEaHd5aWJrQmNCY3NhMVhWMzF6?=
 =?utf-8?B?VDBUUUErNllFMmhUd0IwR3VzR1pwMUYvSDVKdzluMVpmQWEwNldzck1oalJk?=
 =?utf-8?B?RGNXUWI2a1E2TEdNYkV2bmpiMTE3Y2FaeU1mK0ZFcXJjT0RVcC90NzdaMy9X?=
 =?utf-8?B?MmlCQWlSVU1xZUZRejVPeWtMdS9KVWJGdjZNSHorNlJJZXExcVdNcHhwR1Zz?=
 =?utf-8?B?OGE4amJDS3oycDVFRmlOWDVJYzJrYmd6WnZxYktoRFdNWDR1UlN6TEZvZlJx?=
 =?utf-8?B?eXdYQzdBY1pwaUVOZXZXeGNqVHhlRy9pOVhuYXdzRE5HeG96TXFYdksxZWZB?=
 =?utf-8?B?b2RPNThONDh0VTZEWDdlUGdWVngxUzNuZWM0djhwdk03em9PTnlodERHRmZV?=
 =?utf-8?B?T2l1R2FNa1B3R1hKMjJ4OVEzbVpWZFBLZDZqR1JUK3ArcXF4Ykk4cXVnL1Vu?=
 =?utf-8?B?MFB2MXNBRDdHN2xJREh0VmRUOWxNNzJwV1VtVS9yM1pIWnczQi9Sc2VnZ0tK?=
 =?utf-8?B?cnZKdVUrNWxDbXNXOG1XVTlDemhZdEh4bmlUcHY4dUQreUQ3M0w3dkhaSmo0?=
 =?utf-8?B?SE12OXZxSzVFejF6RHdKWEpIQ0xoZUdOa1VzNnhiZml0MVh6ellUM1hNVmpn?=
 =?utf-8?B?UE40WHlYb0hjM25NaExMQ1diQzZxbEJtOS83ZWsxaUV2SktUVjZYUVFPRGpP?=
 =?utf-8?B?NnBFb0FIMUFKVm4zeVM0OERkakdXKzdtQ3hsbnlSZzU5Z0V5QlJKVWJNY3Bw?=
 =?utf-8?B?SVo3YmVpVmtTY3ZXRUdYZGc1RWRJM1lrR01HZTVTV2ZQQlY5UU5pVitXWmEy?=
 =?utf-8?B?Qi9TRWVNSFV0R3gzeTg1Q090dEtKamFqaXZ2TnVwcjlMeDVSR1FtdFkyZk4z?=
 =?utf-8?B?eXJlKzEweG16Tlh1dHJqY083RURXMmRlZmhxaDEvZjB4TW9Dbm83WmhlcTJR?=
 =?utf-8?B?MUhJZHZnbThDUERKcGdDNCs1UHdZY0t0REI4STdBSzZmcjRuMXk5SXZuUWdx?=
 =?utf-8?B?TWdxbFlxU1RvZ0d5VFhpOUV3ZlYwQVZONXVHa3dCakNtUjdmdzdGWjJoZXhS?=
 =?utf-8?Q?TWZy6udfKmdiDic4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I/kSfKH2+jUM3d45bIaeI+sMnVkU/tFtL04HiesvNRo4JwNYHHbyq34OCYamqsnnGvcjpw0H2xEyvGP9PckTfruESd779TGcGJQyfZLDDNGNrWOKKdrd8HALi2UUXmCAcIv1oxNYe8snk7jXo/692RqqE5J2iyaOlPFxpPvjk6Vk1VLSYbkm2URL3AmymocHyZeFG+s2xUpbHJmXn4C1nFxc/auZxrA8JvS48BRLb+EYcjDxTXDg2AQeyxpqxspCtnW0JVt+zBnoUA83+wCegwEtzrhYwfazp98MrTsXIqOV/vE+tutvwl1f7VVCV9+rnyNHIz7xl83ZAk+iobrSM1aSTg1i1UjUMpJJ9K8NhHsUhuFth72XOWdBGqOT5sUFyZ2b48CoXhXPFRPJyKm4WPKDFG9MMSMZyJfZ/4d8I1T4O5YerQ74cxAHZaAlBSskZxW13VjtdbvNFiQG4SbuA6pbULweyeDVzVvDnu2nkX7NcgcXxumfgEjxcAfRHNkFqcMZV5b4txMFMM3M1tPxXRxxt8FXvUQ0hBTnI2Be92mRhzqaZj/PNxEs3WStkfWNNuuB1hgMmC+L3QEUc2+suLo76pYI5eeOXnOcpokA2F0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cfa15e-9815-4014-0cf2-08de42e68098
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 12:18:10.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5/h7YftFlaJVEb1MeTERilfoZ4IDcUyKuRSv5e6vSZTf3KcaxdK8vD1G829v4IqorvnnUcztqLjc6p1r+9+pvRyY5+zpBmdBMxMzDmCea4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512240107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDEwNyBTYWx0ZWRfX5uZES+wBe1lY
 gRdjECAV/Hs4LFFLVSI844efYCrZP7zZqWKYj3hang7Zr7880bB6x+8HM2JGN0mDaeczea6pFCX
 WZgCBgCG2MahSiyKW4AhpFrkgqzPcO/teMkYHeLLLiIFuKseaiDMyDAKhnQrMOEMrl9GHZaZAnw
 wIWSoIrIsiejYS3qml5LHCdLKi/R96H/YDaN02+DJhejE05vIgOqkr9zS6NEjwZrDUwbcNmLKS7
 kE2zaPSUHxrKRwKaV04/g2caHOwVB/7GP2lOa85aLZpL2KvsKvnzY+SMAceEpOj2nTG3hyTTNpu
 WrHzAaylRaEcHiZcPvv4hIavwSxNogeYNxEbUPFfBsPsXDUZDSLOqoCT7vl1/xQyqxjzUO1kWr1
 DDdkdBpLDj9YbnMYreASHSZdLNhtSFNF5SPIoXIIM9CboAbVaYfqTdeOi3mpoe1K/fRIKsexWnS
 18bT0erDN9g+b1booTg==
X-Authority-Analysis: v=2.4 cv=KY7fcAYD c=1 sm=1 tr=0 ts=694bda14 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Els47FiLMW8_tq_3vaoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R_P1ZrVIEWmEWVrvTsgIvlEsvoItzWZE
X-Proofpoint-GUID: R_P1ZrVIEWmEWVrvTsgIvlEsvoItzWZE

Hi Christian,


On 12/3/2025 11:01 PM, ALOK TIWARI wrote:
> Hi,
> 
> I’m reporting a performance regression of up to 6% sequential I/O
> vdbench regression observed on 6.12.y kernel.
> While running performance benchmarks on v6.12.60 kernel the sequential 
> I/O vdbench metrics are showing a 5-6% performance regression when 
> compared to v6.12.48
> 
> Bisect root cause commit
> ========================
> - commit b39b62075ab4 ("cpuidle: menu: Remove iowait influence")
> 
> Things work fine again when the previously removed performance- 
> multiplier code is added back.
> 
> Test details
> ============
> The system is connected to a number of disks in disk array using 
> multipathing and directio configuration in the vdbench profile.
> 
> wd=wd1,sd=sd*,rdpct=0,seekpct=sequential,xfersize=128k
> rd=128k64T,wd=wd1,iorate=max,elapsed=600,interval=1,warmup=300,threads=64
> 
> 
> Thanks,
> Alok
> 

Just a gentle ping in case this was missed.
Please let us know if we are missing anything or if there are additional 
things to consider.

Thanks,
Alok

