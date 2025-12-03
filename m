Return-Path: <linux-pm+bounces-39166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF9C9FF6A
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5394C302920E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F9357718;
	Wed,  3 Dec 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ky512NLR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LEdjnsHD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE63570D9;
	Wed,  3 Dec 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778704; cv=fail; b=lNy+wA3YPd1v2ljzMgmvPtNjL/rqxJ9cWum2dT/bbCbyglLUevF7P/+6mxB1CbhIkfl/l4i/dPovxRQ01ETttytq3s6c5N/t3L+iBcqxbk9SLfjMFSM7+pFEi1WCbgJ6Qd9G9/KGNQU4qlGqiEldAaFVGmzc9pAHAphgAm7hZsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778704; c=relaxed/simple;
	bh=dYAUDYFmQ+LQumd2GTvKtqj/wxW/nLpwNv60PaKtc2E=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=pO9iu+9nhs0VJKwwqukxUa1iLHLg0QWFV0vSgtEvvAHZuPZQa3g3hdC7pjpit+HlQ2k8A9y5KwYRk79OpMV4cxUFtt69XCTh1BbaFyORtCaJgCGMnKKNi2k9xLapwLNgSF8zzGsL8dpGL9MA8PkV4gJcYDgGF8RS4eyeamjIhfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ky512NLR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LEdjnsHD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3F15pr2926526;
	Wed, 3 Dec 2025 16:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=dYAUDYFmQ+LQumd2
	GTvKtqj/wxW/nLpwNv60PaKtc2E=; b=Ky512NLRQQtvdSQnETDx9308tWeaw3L/
	UduF2755A5vmgOr3T4p/RClQTS1hoYNdwh+QAxs83GEuIukSaHaRKqMCELMEdK32
	yagebDjLVoJm5ADgHfZCmrtTFIPXCazJCZzQU17ZIJxIptOeFKXjDhGLdZPT5gji
	1m2cqk+K34cJvdKooawQ+chLKZ7HgVxiJrfaIqe1j8jZoDHupKlp78+FkxeG/KmK
	PfX0oT+YOFiOdhluO+bz+Awp24jNNDptrHoVGnddM2UtyKznNRG6yGP4+2jtE1g/
	CE2R0Q4OTmbg4yWyHUgz8+h6YaWAK8Fl85KSZ0OgUrpK2QQ+IbVJXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7cp5pf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 16:18:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3EU3Lx015067;
	Wed, 3 Dec 2025 16:18:14 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9avmqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 16:18:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIKxWtFLYMqMA2jysqk1HvfHlF2dOjEQLGlT52fOtIWoNE5pxxQBImzyOHTt2MrVGhP5o/5KrR6I3ktHTbv6N3KmKIA8XqLVj4SdMr8wGX1tYbW7xraqeRHJ2TjxRxWHbt2cYBvSf7ZH4PRosrps72dIs5gP+rf0zqn4D7//lxeET7e0+LjBSiSZSa51Egh5gSwf4wsSH0H8y4j28nVeG734fFd7OmR8zXJ/ABpzt/XMipI/+ZIG+fqUa1pRfWnfKGht5XPBXa9RdMmVf9YtHSvO11+OwwrjwItoYrK+f/FPlmsld3QEAGwPAVZAkYaCh60NIX6i4UryOAEuXKKb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYAUDYFmQ+LQumd2GTvKtqj/wxW/nLpwNv60PaKtc2E=;
 b=WQuY1aBa/o7HTJ5LO5+83HbQn3/VBZIdlvLvZed2mK1/4XvusgjIY06AGKdHbpk7OLVdAURfMK9H9mk5RKgk9RvmximxfO4bnCkQfGoxcLQlN6kjoxw6rKbCHIo16lj7Y1wp5ZsnrArFaNp/i9ILaVBYg+AsjUQhInOOCfPbciXZGpNQel5i+xiGG8gWCAZ02ItN4hK9mbCsXvLP1BaAZVeSdt8t1mwtv3wUXAbIvYB4rjQfFCdw1iPKe8eQ2kcZ3WlOwFiG9MOjGldlyOcUOQF0nZo6R3m+5cM+k/eSGFl318cXwtiIg5MG7KaNAV03RSWlx2AJ/sgHqc4CRnthhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYAUDYFmQ+LQumd2GTvKtqj/wxW/nLpwNv60PaKtc2E=;
 b=LEdjnsHD9gSeFQXNXIFX7E8RGyycNoemWROAu9Lc/O+OZLNcJHkFZ+rl6PMEaH4ZLGL3fIZdqs8z4icxi80f219y4V1i8Byh681yppt0SImGuH69agBmRha9TPPm0NHPrKCWxPxYkZ5mGXv6+I6bpa45eZlDtdTWelECWfjdV5k=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by BN0PR10MB5125.namprd10.prod.outlook.com (2603:10b6:408:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 16:18:12 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 16:18:12 +0000
Message-ID: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
Date: Wed, 3 Dec 2025 21:48:06 +0530
User-Agent: Mozilla Thunderbird
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Subject: Performance regressions introduced via Revert "cpuidle: menu: Avoid
 discarding useful information" on 5.15 LTS
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|BN0PR10MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: c370e044-1305-4e1f-feff-08de32878df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmxHU1V4OU03KzB5R0xHYlFtcGxKc3JRZFY2cFBwems1OUtCRjdnSWNsN0tY?=
 =?utf-8?B?WVdZaXI3Y2NuTEw2SC8rZDQ0YUtCNnZQbHdhUURabmdreVRpWkVWLzJxb0Vq?=
 =?utf-8?B?TklCSFFzUHlmbXp3RkVYMHhBT1N3ZXZFUVM2SlVQZzIxaE5CVW9jT01nbGtS?=
 =?utf-8?B?Q1VIMi9SSnRrank4ZmNWek5iVnJpV2d4REt5QW0wdlJxMWcvajlhVGlJSzdM?=
 =?utf-8?B?cDRDRTl5SkNxMTdWTE8zRVNaU0s5U1d3WG12WXpUbGV1ekp5QythWlhDWEtx?=
 =?utf-8?B?SjMyQXZkT2NHMnlJZE1XZTdvVjVaY3N3OUZSdXJkbEN0Ym9GNzdXKzNaQVg0?=
 =?utf-8?B?bzFZZ25IdnFjalV0b2Z4Szk4cXhid2V2ekNsWEdPd1JGWTZEMk5qUy9nTkxH?=
 =?utf-8?B?YWRLWFRrMUJiSW1iTkt4d3ZYV2E2ZzJlYkx4UzB3WllPcXluY1VVTDZITFB6?=
 =?utf-8?B?QjhINDBKTzZDd29XVm8zbHVvYUt6RVhIQVZScjFFZ3Y0dkMvQWJ4S1RqV3c0?=
 =?utf-8?B?MWkxUWd1aHpuTGJRKzU2cTZ4WnNsckFZQjRka0xJVXBrbGxydEZuOXB4dk1O?=
 =?utf-8?B?R1RYZDZhcjU1VVFjUFlqSlkxNjhxc201cExJSHMxa3ljc0RwVTN5K0w0Wk5s?=
 =?utf-8?B?OEdXM2dvVld4bUh1aVRuYjdoMlJlazZKdUtXZUs2ZC9PWkc0aHZXeFQ3V0FO?=
 =?utf-8?B?U1owQ2d4VWZjd2h5RmZvRC9FU3d1eEVPSm1VNXQ3eDVFdEpneUpMWmdqNkJF?=
 =?utf-8?B?TmFuRXpGRlVxRzBldUN0c3RUWEY2UkFYbVg2QVBqWWdwNFZVaXQwcEN5bGIy?=
 =?utf-8?B?Z3lTODV0ekJpSFJKalhHN0JCTCtDck5Nakd5OTNKZmhyWWZidDFLRXZwL0VC?=
 =?utf-8?B?NmpsbzhXQTN5SEhMekNLa0dZOEx1M3FSTVB1TlovdmJyOXE4QzZEd3dHSFBP?=
 =?utf-8?B?dHhBT0g0cGp6NzVVNkpmaTBTbkdBeURSL1JlbnNoZ2FNZTEvMU9wTW9wM3ov?=
 =?utf-8?B?RXBxbU1Qa0VuMDhxRXhYanNtSmJvTHIwUzZ2cXFiS2JPSDVLK2VpV1JSMnlW?=
 =?utf-8?B?TzFtSUVwcVR2Y0F6MUpOQkFuTTZ1eExPSUI4WmRVb2FKUFA4Ri9Ea1BGLzNE?=
 =?utf-8?B?Y3U1eVpjRCtRNDF4ZWUwNnpWbG5ONkFhVTVsOWtFNVJuN2VUSkk4dlFVTGE3?=
 =?utf-8?B?Rlgwb1VLallqTEZOWm01YjBJcTFkY0VzYmtrMllLMHlTM1Y1QkMvVXV3R3Jr?=
 =?utf-8?B?SUZnT2dIakZkTUxubWVDNThacGNqdkJ3eGtXQ3ZQNU4zOE50TlRFL1lXUEFh?=
 =?utf-8?B?ekh5NjhNNUxaRDB6dkNXOC9iVXhQcXcxN1NhZnozNzhvQmZpV0VSTDhCQmJX?=
 =?utf-8?B?eHZodytFdGhyWkJ5RUFDandMenVoUFQyckU4TVBYU2k3OFplU3pmc0xjZlM3?=
 =?utf-8?B?TnhSbytQSENJRzF1TXRxWFpUMkN0Nk1Cb2tacWE3cDExOWJScDZsMU1BNFVH?=
 =?utf-8?B?SWZwaTJ4QXhPSExkMDEzNEM4YS9ndVlCMXVabGZ0VS8ySU1MZ3ppMVNVK0Vn?=
 =?utf-8?B?RXlqUnBrdlliWDNmM0FOY05MRU5PTUc0ZnYwQy9JQnFzSUk0Q2xCRUhaNC9P?=
 =?utf-8?B?UEVxVUFtRXZxa0xJSUhpRkhQZ0UxY0JtTGNhaEtpb0N5WVQwNFJQVDRoREc2?=
 =?utf-8?B?WGJIN1o5SEJRSitYZ1hmL3JKejAzeWY1WUlnVEVQWE40MmtaQVE1MHN1VEFD?=
 =?utf-8?B?L3dmUkpDTHhuWGF6cmpCNDVkT01DY1R5MnhIL2dIbjhDYVMzN2tQMTNNT08x?=
 =?utf-8?B?YjhjOHQxSTB1aDFValRIVWNBaFFDOXJRWG5KVUhtWkVoNEtkSEhtT3QxYU13?=
 =?utf-8?B?M1UzUXJSL0RBODNWbEdnTGcvL1hPWjg2eE80TUJRYlY3WE0wbFZoSjFSdU9C?=
 =?utf-8?Q?jW5BNJ6zxw8UFEnddS6me2QtZsyvt+FV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0RkT25RRG5CWmFRVzBqUmNsMUt6Y3hVNjFwSTFRS0Q2MnY2UHAxK21BUC9K?=
 =?utf-8?B?TUF1aXp5Rk5pMGxZdDArU3hIUTRsaXlSWXpyTmdoUHBMMC9jY3FibC90UE5h?=
 =?utf-8?B?TUEzWnJ0a2ZOaXNFQ1gzSjJJTTZ2c0NuMC8ybllhbmZvd0QwZjFZRjVBNTJ6?=
 =?utf-8?B?ekF0ZGdrSytBMVJhN2JzYlhWeDMzY1hSRzBXbnpyT0pyTitwZDhnYlBqYTlP?=
 =?utf-8?B?TXFoSlg3SGxoSmpldG9mUG1JUHVBNFpaNjBVa3B5aGdmOTM3V1dJZ1VUU2lt?=
 =?utf-8?B?dWFZd2lOK1dhUHE5b2pBOThuV25iQ1hlaFBOY29vWHJ5Umw4dXFTTno0dTQ0?=
 =?utf-8?B?dk51THcxcTB3WG45Zy9BamxSVmRBVnhwb1AyVjNqNW1aK0VWcWFLQkk3R1Zw?=
 =?utf-8?B?aXpvZTYrZW9seTRtdjhzRHEwaDJtbFkvbmVwYjVON25ES2dXZlpDL29NTEEx?=
 =?utf-8?B?WGdmYW9RYVhxUmdacHl0M2xjNHFZajFmMHFDZzZRWjdnYzROSkNaZW8vZDQ2?=
 =?utf-8?B?WWRlcW1IOVdDaGw4MERQRUpVR0YwL3NuV1V3cDFNeDNxQ2JSVm9hanI4QlhV?=
 =?utf-8?B?emN4cnc2aVcydWNHTTNnVkJ1NE14ZXdqK3JTK2UyajVZZW5OSnJoNVdycnM1?=
 =?utf-8?B?Ry9JenJSUjJibmRaYVVIc3drL0I2U3BOY2RudVFZMG8rNjJPdXVCS0EzVkMw?=
 =?utf-8?B?amZDTjMrbkVnZ1VUSHNuNGRTeTR1cGkxOFgvTEdlV0RwN1ViM240NkRncUlB?=
 =?utf-8?B?QVhSYXNYS3h3eTE1TTJjTHNXWExCOFZjVWRxQ1BsN2xHOWc2enNZTS9GbGpx?=
 =?utf-8?B?R2pYZXhtQ09LMXVScVRidFdFcFlnQnhTSjA5enRuWnRwYUxmY2IwM0pkTEFO?=
 =?utf-8?B?MEdHbTdFQUc2ZS9CUzQzSTZPWU4rOWd2elZVMms2eU4ybkhESlB1T1ZUUUpr?=
 =?utf-8?B?WjNhREdEbTdHWTdXdTJDRnhHYkJsYUlRc3d6T1RqY3lBaWNLb0Z5MHFWWmwr?=
 =?utf-8?B?K0NFTFl6R2lRK1JUTHJjNlViZlB0MW5KUkI0ajNwTGZRQkJTTGk1bVFWYkd3?=
 =?utf-8?B?VVBEdmJhei9mck00U3g2N1I0WmpYTTNRVHVsSE9kYjFZS044eEdNYkh2VGZC?=
 =?utf-8?B?R2k3QnRiYXJNcFZUUlpjQVJJOXA5ZlJ4ZjJTeVZjaEl4dVcvbytUbE5LSEZp?=
 =?utf-8?B?SnU3UlRmOGxuNGszY2RlMDZZSzFlbFU2RFNNRmxoUnlVaU1VZnY4d1VKNVk0?=
 =?utf-8?B?dlBZRUtDaGNydVVCR2x3a2wxSitnR2I1REs2RVgvUDdlY1hpVkhtaWlLdEZa?=
 =?utf-8?B?OGhTU0RvcUhxWVU4UVpEOFJpSFlVdVJodHJKTGdJMVY5VGhFTk9IbmdoTHBS?=
 =?utf-8?B?T0NKQVhIWVF3MWZZUlIvOURLaWovOVFQQnFuN1FIbWJLSHlkY2Rxd2tERmJD?=
 =?utf-8?B?SlRGbUFGazZHcGlhUzdTTDlSN29RZCtPcXJ4RHBiKzFHRUhwTXBHR0Q1aXZr?=
 =?utf-8?B?UDl2SUgrWDJIUklRVk53a1h2REpnVTRvNDlEenJERGJjV0lVYjU1bUJTNjNI?=
 =?utf-8?B?a1B1MG5xY3UwNW9VWnZJYXFjMlNjVXJ4OWpmWmFUVHVLaUgyL0lHMnFOdG5x?=
 =?utf-8?B?bmF1SDhIRWd0WkxBNC9nSi9ZQmwwUWMzd28vb3dxNG0xVUE2ZExuMS9TNE5M?=
 =?utf-8?B?UHJIbTlXOTV2Sy9VVWVobGNwcEprV2hpYlZYNTJwaXpYeHBxOWJCQnhVcEU1?=
 =?utf-8?B?cWpweDNESGdpU3VuUkd1d1lFTDlxblUzdks3aFEzMGY4WWxSeHNUMnpHT09k?=
 =?utf-8?B?bXRFMXFZTnd0aUw3OUhDeTladHIwOUMvakZvMVpINjR1M0FnRDlCTHlrVDVD?=
 =?utf-8?B?alRxNi9lc0FCVFJhN1NHQnltMHdIa1poSWZMM3h2YXpneG9HNXZ1am82UDB2?=
 =?utf-8?B?RFdlRDREYURsaE9nZ0hITkRpQmMvaDZIWnBmVnhGcmFGNVg0YTBmTmpWZWtp?=
 =?utf-8?B?V0RCNHE1K0xyNE1RRE1nOVdWWmg3ZzhLVHFiNXU4VU43SWQ4ZE1pQlFQbk5J?=
 =?utf-8?B?UThNUkhxeE54L3FZNkJhQ2hiTnNoN2d2NzZRSUtFMXFDaGVVTjBQUVcrMk10?=
 =?utf-8?B?MjkweGxFQWFLa1hDRWFnV0VMSm1rU1NhWGt0d2NmcXBVS0gxSVZlQ0dWdTlm?=
 =?utf-8?B?L1NEWkJ1aXNuVmtZaWQ3UjZvT3RsdDF2RzlIM3FhZzJ2bCtJd2NaQzl2dEd1?=
 =?utf-8?B?UmJDK1ZWRHIvbXVUVk9tVXV5Vmt3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	//P8GM6cgrpM5PVpk+g8rhZHROk7W4sskwl2BrB0MGyfs3KS8XX6fd9ytMrkyTyg1+J8/JdI2yHpiiQJkCSeObI9AhazmohO/kW4bXwlMpkZOq6CN5Ydkq2yi4yDf/VK0X5Ic0roR3a/WbY3nIZuCH8usaLCCNQqwHwYmAT4OBt1p2p5rbVmZ0fOxt8PORhwhrY9KQWjSP8OX+AFuLQlXc0G6Kdt/kmZQPn+LNE7/9iu7TX1RTZSe5BAjInWtInkRi8vuMjsIxEIFPEUb2T08QL7LpRHVZVuHI+DafqIuEvag5N6gOYDKiZpjOnnK8jS7sl+oxyncQh1CZ+ZJmZH2IqDUy+1UZbKLXgoeFzEYECm3WM9uLKB5N/3D+OJ5YPtyfEHE9pP/sWllOzVy6g7bBghXu1kF/W+hy47HxoQRGQec/J08ajkgVTvhD/wEQ0fbQucpcMFG2ZC9QIWcoAJfjIfMHE+6I9cs6Pq3ayIbA44BkuEezt4bQKQDNkbgvNzuIWrvpIfEA6fjM6Rm8gHC+zlxY62ntqKC2BmjAGhzYtBtBCShWN8ar+El9jHXR3I5kbMf1ExpSqPJyCaA1lobd2vgEG2t8ibTIOMjacrGJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c370e044-1305-4e1f-feff-08de32878df7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 16:18:12.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPtObbblW4mrMiyxAeKUBT8IWAZNHx7IRbcsFinfawpvXGsCDy8dy6E1egA3rW8Lb3atenN7i1U2g4v8UTj/ZfKif7XXymHnKTG6+mUyRs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030129
X-Authority-Analysis: v=2.4 cv=ZfgQ98VA c=1 sm=1 tr=0 ts=693062c7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MXfgPkPWAoq_H1jDnSwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: k2gEG-oEK15Q8fBGdNChLuqdxJOZy_-v
X-Proofpoint-GUID: k2gEG-oEK15Q8fBGdNChLuqdxJOZy_-v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEyOSBTYWx0ZWRfX+OcY+f9mCCjB
 l530Jg46oaCk+eMiHmUpc83JcAOsoVTQ6zf6mhzoMMD6z+K95wy3FWPYoEzUhR+6NwKKd78bN75
 zfbOCIZQgDljrdYUq7zJ8sa5PEB95As1yYKyyR5khwSTU+iyYpxRBhLOt+qheUgkTg1OmNnXU7h
 tbOvkZUQJmxpELWTUzm+nTg4+AuchqKRkakWyeez9/8BOJhCeOiXxeZjpo8axM7RizVEaNneb5i
 rFdwal1aTPfAzkDAM34motp3zg7V/++HSJYSxo380cE42fdhubJznakktQB/AVnxfu3w5VG1zmh
 eEyP87Blk+/Mn+TkYWr9Xc5u1ymEjhdt0LYgNYdqu9GpFD4GbUbNksTukcGOZ3G74d44J61YcU1
 GFsUqkSQ0leNWJ8k6xE5ZKZIWbJE0Q==

Hi there,

While running performance benchmarks for the 5.15.196 LTS tags , it was
observed that several regressions across different benchmarks is being
introduced when compared to the previous 5.15.193 kernel tag. Running an
automated bisect on both of them narrowed down the culprit commit to:
- 5666bcc3c00f7 Revert "cpuidle: menu: Avoid discarding useful
information" for 5.15

Regressions on 5.15.196 include:
-9.3% : Phoronix pts/sqlite using 2 processes on OnPrem X6-2
-6.3% : Phoronix system/sqlite on OnPrem X6-2
-18%  : rds-stress -M 1 (readonly rdma-mode) metrics with 1 depth & 1
thread & 1M buffer size on OnPrem X6-2
-4 -> -8% : rds-stress -M 2 (writeonly rdma-mode) metrics with 1 depth &
1 thread & 1M buffer size on OnPrem X6-2
Up to -30% : Some Netpipe metrics on OnPrem X5-2

The culprit commits' messages mention that these reverts were done due
to performance regressions introduced in Intel Jasper Lake systems but
this revert is causing issues in other systems unfortunately. I wanted
to know the maintainers' opinion on how we should proceed in order to
fix this. If we reapply it'll bring back the previous regressions on
Jasper Lake systems and if we don't revert it then it's stuck with
current regressions. If this problem has been reported before and a fix
is in the works then please let me know I shall follow developments to
that mail thread.

Thanks & Regards,
Harshvardhan


