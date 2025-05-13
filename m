Return-Path: <linux-pm+bounces-27095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44A4AB5D63
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 21:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BF84A775E
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DE92C032A;
	Tue, 13 May 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fLXG15Dd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kai8BRzh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B962C031D;
	Tue, 13 May 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165815; cv=fail; b=CSdmfgqPeyUYiRvo4XMtE7FCMuEnEcL6jHUU7x7ZUNYWdsGULAsTXESmTav4iGi/L8kQ076J1qjIf0miZrTjk5jR3vbTq5zNCjZMN95BE4bKUg02GwbpnOT8m73j1Y4yhD3jGuf4cwKIZiQv8xjmsxebIP9UTMLBeSZBiizMe7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165815; c=relaxed/simple;
	bh=5Tj5TLoHuFPdVh2xPszMpeQfkOuQOQsG1M6gd8Y4GDE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bP1VtBDLQkkWArSchlBEvp5c53XSTUkZnNtE6J6fUXPF7TYWsDe1LpXtf8Nx+JaQwPkq5xkCZczGZDRrj0Iar/DJSNQ0Qb1u9Y2Vx5fIaDPj804GTeFl3BndDmRuch1ppjU2Rhzj1Qvs6IneEBxYG+sFe1eh1zc4U5oAXCZ67ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fLXG15Dd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kai8BRzh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIRSGh020913;
	Tue, 13 May 2025 19:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=y4KblH9SAdoD95CgjJl+EKUCTjteg+IWWPYy+h9UjOU=; b=
	fLXG15DdlOb5QMnt+hOk7kT5Aw4rDK+x3iN5xGzMeMgSlNOV0BCP05MMD3vi8BE+
	VVZGWHpU48qZy1TOy2abfQ39YlO7zX0IPX7U3iizITvujnCXaR8w+KCNgb2i6rNT
	zH6nUrsg5LGeaPxhroszRLrCJfly1sbszULYKImJ+T70xbkDsH1BsJlxYyiR1eSr
	k4ueJkSfmRkYBCHitcgxWK58BEBHliXtwSanib7kPT+QaLwK/9qCSA7DHuNgY1z6
	sujVdRX1IoLDsMXM7IJ2m/xcpI2Hc27wTb4bdEPjsb4P5l0SsnDxk72/HludEMHO
	q4OQXe5lc98DINv2gNNmMg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchr4gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 19:50:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DJKbct016982;
	Tue, 13 May 2025 19:50:02 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011031.outbound.protection.outlook.com [40.93.6.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc5eryyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 19:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfHCctvozLqQgcSSMvJiBrQVXw39pu2cbkujVHFtP4vkjpS0hRwrS30v59VV4f091nUc+RpU3OAXK9BfKBzVc3/UHTpCEmBzax/AZXHAVjB4pHBzJndS4dLeXzZqJPpqxO9sjgBiiyS+BwvcYj+1o3UFqvvIwfbnqOk0i4lAcBShm7uxIcZxo/Xa8DWjq8QAa9ot2QBrmDwyN+uOPcXSI7FObFIxY5yUmp+BYJOjW/ej56DhAIsFK7DtUx2+kuOwlCmQufwo8vH4wQ/5APErnVzuJgGn8w2o4zFbiSX4fmNaw5jFaUtmSEX6BcBIWsQOKLu0ZigiBaaKsxJArliZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4KblH9SAdoD95CgjJl+EKUCTjteg+IWWPYy+h9UjOU=;
 b=EYmmkZi6fVEoix/XCvDNxaHIhDJV+RSuSBehu+u3J6DYPFx5wmDpYr7H5gMNn6Yp4d7XbXhdrP7cM8a4liU4V633Aw6IWv3aZW+FBBDMJs/UtTXrS6aRbS5O6r/DKgqn5erQflG+7VaNd8Z5yvwdApYEUufvQm6GQi3pO5pZQYIDMC/EEqZ6xD/z8z4TWc+2K6HLbR8OXNBKIYNaVcXMmZVspCCvMUSTIbVcYM+aO6wTw0+5OPpqb0n6pefpNm6BQHgLgSwgIMHlUsDZWxKuOaCgiqNttZjiQlknu80stMFIOvGJNxKnQjNpXb49cHbQbzNiW5N1VWUxjHBwzMTIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4KblH9SAdoD95CgjJl+EKUCTjteg+IWWPYy+h9UjOU=;
 b=kai8BRzhN9S+1LtZSIQuL90pkbJAgLAoNLe8Pq9PdZ4Dc5WJefqTQRi9kcx04jX1L2adnNsQb1Oxrt7vM9oRlOygGioigyW4am7XvFFn1UbdHLFs7F7hdfDtwkTpeTFeNbxGHXtIMudKvUw91Xd36cuUoQpf/7GuyL5HQMNG4vY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 13 May
 2025 19:50:00 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Tue, 13 May 2025
 19:50:00 +0000
Message-ID: <084240c5-48aa-406a-9bbe-2f349f9c2509@oracle.com>
Date: Wed, 14 May 2025 01:19:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
To: Christian Marangi <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250510172509.2547273-1-ansuelsmth@gmail.com>
 <20250510172509.2547273-2-ansuelsmth@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250510172509.2547273-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:404:a6::25) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BLAPR10MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c16d62-c0c2-4253-e398-08dd9257583e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG56TnRCUFl6cThKOHlrczRTMmd1cDhRSWhsc2NBSW9VNTFZaS9UeU9uWGV4?=
 =?utf-8?B?T0JMczUxV0VZd09wZVQrMUk3N2RTTmdrS01nV2VMTFVNenVROU1EOEJYVFBS?=
 =?utf-8?B?L2tMZ25vRE5JaDJlQjg4Y1cvcjhBTkxSMncwbFU5UkVwR0dHVW9KTm85eDl6?=
 =?utf-8?B?RU5jTVpDZSt2QUZuZ3c4NDRtcTQvTWFWZzVYRWdBdlBBb29BYTAwUEhmSmJq?=
 =?utf-8?B?ZGE2aHhiWER2SCt1dkIzZ1cyaTlkUWEzN0RBVUJTNmkybG4zbWZpY2psUVdt?=
 =?utf-8?B?bFZKWStTVnM5SVhKa1Q5aWVMQXpvbTJxUHhRU3FsVGxpTG1BZis2bHhNZ3c4?=
 =?utf-8?B?ZlkrSVNWeDFaZHpZWVJPWmhZSnJtdmp6RHNxTXF4WTFHS0hUd2JMWE9wQllw?=
 =?utf-8?B?NG1PL1VSS3VPb09oRUx3UXJ0OGNMOVIrZ1NEL2ZacThuYkZIZ0I0VVgwWWFL?=
 =?utf-8?B?TGthVGNncy90a01NQ1ZQQm0vQXVKc01KeEhhbmxza0FuTWJpSlVzMmEzWlNw?=
 =?utf-8?B?L0Irem5WKzdHNi9UeEh1SktuaGVGRExyT3RvWHhueUo0RElCWHg3eGhTZjN0?=
 =?utf-8?B?VGlJU2tpU05hT1lnbUNpRDFraEw4WkY4ZGh3dHVLMkgwTWVtM3lUVEFjL0dC?=
 =?utf-8?B?VUJmL1NJWDdrZjV6emttQlpwdTZxY2xjMlJROHFUR2pYSXp5R3Y5dmt2VWlH?=
 =?utf-8?B?ME85UzhrYTBPK3VaYmYxdW13UmZ6MnhjVlMwVC81YVRNL2pzU0U1ZmhQYTJX?=
 =?utf-8?B?YURNUG9IY09oT0FITkcrRmJNWkhXODY0Yzc0NlB1clI3ZlA3OVVsdmw0bkFX?=
 =?utf-8?B?eWZ4REdGN01iTWdzUEFFdndxRU40Z1dUa3ZtSklPRkE4bW5Ddjg0T0puSFRl?=
 =?utf-8?B?V204dk8xRXgybEJsUkdHRGlxb1VMRVpBMFNqM2lDOUM5NzQveE5WVm5jNndM?=
 =?utf-8?B?cGV2eHJGU0ZOODE1ZlVmWG5CeGhJMTYzM2RBUXc5RVN6ZXo1SjMrd1BYVEpV?=
 =?utf-8?B?TnhyeDhaa3JCVnNaVnR2UlpmczNxQWNoNXI1NHM2aDNLeSs1c1RqVklRS1lw?=
 =?utf-8?B?VldrMXlER3dYTGpoNWFuTFA4a0pJamU4bnJlSkhWMGphenFPdDRPU2dMbWJQ?=
 =?utf-8?B?UDB2TnJoVm4xanVXaDBLZUJtNW9oU0FBaDUxazlweGhrWTJoRGk5U24remE0?=
 =?utf-8?B?MGc2MTZkcWtmZXp5a0FRdXpBYTNGRjAyRUF5QVV0Q0xQZlNkdThRVitpQ25z?=
 =?utf-8?B?UUhpeGoyWmNEME9SMExLazBhejhUM2lEcFRFYWk2dTBqck80TWxOOC9IVXo5?=
 =?utf-8?B?NWJ6VTliY0xoaGRSWm1tUU03am1rV21tQ2VZOHkrM09FNmFLMG5DVC9wcHU1?=
 =?utf-8?B?OE9jK2hUMEpQbkw3cTNnZ0pXVTRQaHBjQVhJZ08vdGxlbmdvdWR0cC96QmpE?=
 =?utf-8?B?UDVKMEh0Y1lGM1ZTRHZPYkh5MUdVRkpEcWNnNTBvRmQxNHN0N1lnL3VFYWND?=
 =?utf-8?B?dGRPR2lpUmFjM0svdzhSbmJETzkvNEEySCtQbEFJQWpNQllrYWhjRzlWeXdP?=
 =?utf-8?B?TTVsZ25VTkRjQmxRVkhNVXczb0o3aC9EOHhMb01GVkpKUU5PLzJ4Q055Zm02?=
 =?utf-8?B?Yy9UTGJUWENYRnpubzJMSDl6c0tncThGQXRqc2x1ZW5NV3BJalk0Qmg3eFhV?=
 =?utf-8?B?NFlmSVROZStxdC9iQzlWdFdlRmpueHBPZ1NsS256QUlGaE5zWGUxamxXZFdU?=
 =?utf-8?B?czdHeUpWbXNJNyttcWI2M1ZTMHlKMERUSzFVV0JEWnQ4RExiSjNCRVkvRWpx?=
 =?utf-8?B?M2Y4TzczUzdBbzNyK2NDcWkxWUZZTE85SWJHMDRuRWRZd1V1YkkwazRTZUxq?=
 =?utf-8?B?cENTU0xZYjNQMStUTEtnWDFOaU1kbVZxT0J5MUxUMnlXb1QwK3E3c1h3Nzlh?=
 =?utf-8?B?ZUdhWDAyZ3FObXo4U3RHVHE4WHhZMFdkZmx3S3QwWXZ2cmVKSlZFdS9LWkZm?=
 =?utf-8?B?N1Exa2IwZ0pnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dC9RRHcrMVN1YndzMDludW4rWVhjMFFPeEVUcncrSzRES1FIejRwU3hMTzNs?=
 =?utf-8?B?cmhSbGxCdnFEYkViK3JMbVZ0N1Flb1AxeDBIcytSSkl0dHJZK21FQ010Tytj?=
 =?utf-8?B?U3k2NXdVS0JVVFNxMENMVmgyWXFTbStGSWVwTHNkSVpVcVB2ZUNCcGFYclFo?=
 =?utf-8?B?bTRJRGRUUkYwcjFJUmlWTjNjSzB6RzNNVC9XTWMrL1JlOGd2bVdVUHlqWmQx?=
 =?utf-8?B?Sjl6L1ZILzc3aWFZbnM2elRwN01iYjRqc2ltTW9Qd0liOE1JV3F3aFVBQ3F4?=
 =?utf-8?B?cFluYjk3Z0pzVGtrWk5sUWQzdlhGY3FRcndnemdMRDBycVFHOUVUa1RpS3JN?=
 =?utf-8?B?a1c5a0xKUFZvNHhIL3p6Q0lVK1BlQVBaOGNxMVRUcUx2RlU1M1lCY0N6NkRL?=
 =?utf-8?B?MmZXZWtkOWFqejZrNVAyNkZKNnd6ZHlMc1FZL1FBbjI0N2VUWUlCZm81cmph?=
 =?utf-8?B?bzdtNG83SmNYOVdocUYxSXVQc1VsNDN1YzNtQUN3SWE0M2NQdGlJM2JpMHlG?=
 =?utf-8?B?ci8yL3lTNEZ6eU5LZzJVeCtrSHF5ZEo0Uk9YNTM1amgzclp6T09HZzVKWW9l?=
 =?utf-8?B?aXpWRTExbmVQYWkvRXdJMHNVOEdBSFdjbWhPM0hjcExPUHAyYjNUZkczNjBP?=
 =?utf-8?B?L0ZaZTEzRkdxeUlZL1VuM0cyb3I2TWE3Qnpna0VzUVE3eVZyUnVIdk8wdmFN?=
 =?utf-8?B?czFScXM3VURoRXA2Sm9XemRCUWJZU0Z4ZXU0eWw3NjFNTWMrMTJicFJKZDAw?=
 =?utf-8?B?WEhtQ1hlUVhGZnQwODl2VmdIUTY2TGh6M2hlcmhNYnFDZzlyQnIwc3p0NkhI?=
 =?utf-8?B?WXkvbFNOSWVzV2E2cGFmVjdhakJ4eU8wLy8zQUhWMkdwdWwxZHUra2puSWVv?=
 =?utf-8?B?UjRGWi95RWJtRXZQcU9PZFYxZmYwNWE3RGlyQUVxUzErRHNTT0lSOHNGZndU?=
 =?utf-8?B?RVdkZE9PSm9EdnY5WlRhY0U4enZkZi91OWg2dXNvRVJuTFcwMVlJcCs4SGc0?=
 =?utf-8?B?STZKdUgxSjFLT3N0OVpDMWovWktsMXY4a1VFdGZvZnlpNkQzNVhINGc1V2ls?=
 =?utf-8?B?Z0h5b2htZnBnanJWeGxzM0E1emx2TTczUGpkcHVRbG5MWVBXMEZKTjFtTjM1?=
 =?utf-8?B?alJicVB0cFBSSk53c2krUFFZNjRCN3dsc21xcW94RHNrTldma3RqYythamtj?=
 =?utf-8?B?dFBMbGZEWTFQanlQR2plVnR0ZEhxLzhNQXFxK1hDTnovdEI5NklyM2N2akhn?=
 =?utf-8?B?N3IrdFJnVTdCUUNVMkZKNmFIaUpaQnFwbENWdnZ5Q1R0WGhQc25jSWsyZnVE?=
 =?utf-8?B?QWticDBlaW1nczJ6eUZzL0hiY1ZuNXNzVUdIbEg3RDN5b3Q3REN2QUREeGZJ?=
 =?utf-8?B?ZmlqTGlmSmFZY0hPVFhKTW91amQ4aEJhcEphUlFCWFJsbkFCVE10OVlMeFV1?=
 =?utf-8?B?ZlAyb1BaZEV4OG1yTGdtTS80Um5zeWVtdUtydjhjNVN6cjdQUndDRHczOTVP?=
 =?utf-8?B?a0tMdVVHemlZQ051M2lleEZFa2dPUmJqa3BSWjVyb2ZSQWhIYzNQRVF0MTBX?=
 =?utf-8?B?WnppUFg3YWRqN0IvQnZpaXpTc3VhbHdRQm12TFFDSVZ6amZrbTR4aEY3RGpR?=
 =?utf-8?B?bW1xQW41TCt5OEx3clhOK2dENXN5ck96bEdyVk9IVDYxZTREVEprMVJTWFVE?=
 =?utf-8?B?bjZiVCtOVUp4KzZSMDdaTUcvb2xFbkR0bUZ1T1dzOE1MbFRBVkc3NldrbXVy?=
 =?utf-8?B?V2FSRmE3UEl2cEs3Mi82VUhwN0NlcDBtSEs3dEcyTzJvSk5McHUySkNtbDd2?=
 =?utf-8?B?a2pMaG1hTkdxTDB1M0JxZUxUTG1uQUFjckVnMVRLRjVZdlV2ei9ZVDZKY0Fx?=
 =?utf-8?B?eTM0SFJ0WTVZdUNPMW5QcjdIdkZWL3E5Mmh5RzRkVkQxSkRRc1NzL3dreENC?=
 =?utf-8?B?ckFBV3duT1gvdXdMTFBBMTJ0VkJZejR0Zlloa1BHZ3RFTnc3cENFQzRjdnN3?=
 =?utf-8?B?bjdRREl5bkR1bzZsR25qSjU3SlVXV3BJbE83d2E2WGZHcGZBM2liQ1JuNlAx?=
 =?utf-8?B?S0JpTkY3a3ZSUU1UcWc5U2JuRXp4dVhaMGlBNnR2MldWcG94Nk54VUNYVTlI?=
 =?utf-8?B?S0U4dzBEa3VIQnRXeldWMGZmb0xpS0pwaGlhc1FkU2VMMW51OWxCeXJFZUtW?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	275yQwUIHHBZNzml6nWFxgRFvC0WEqNPsWXIt606wYEu+TYHpILqdggNvdHKTRj26nIQ7g5wuvT88cTcu9/7fzLjpVMBFvaIvFD1+Wuqa3+YID5zsw9UOAG4I8cLyIpJY8q2iQ3MflNcVwX4iS4WkiUNreOq6F4Y00sgC4O5HRA6knCSsRYpEurh0Xdfr8pQTa9p5Wsw1bAuqEP1angZ2CLOPeaoeEOFsm1xocP/KqvCdhqwEV/J1Z9wBEfkiZt3MJh4lXf8KJamtl4h50r4ggRd4EZUPzQ7r5fWKalC9vv0eU7ESv+3Eqc9ERqfPmBPQvu4NUnetaXFrQhO62kFqDzJIAvvvssqZmuTRpfnXzW+pw3mFO5OD7Q2QuyDt5U6StQe+qg54gc9UIcefKZfCL2AyVASRbxFqzh/IkTh1/lx0OSkyMAlpmWd5qvsZplAAIxOYycF7A2+6mh36NcmZo6wJ6XyPcjHG50bXP42eZLc9AU4Oelb36tH+or9mM7BWRiR8wUMlm8DVldGUKj+VY40ZRSwfhcyXbTQJNBUKFgFEbUTPunXIkkm2WwPZ0ps2ratt+T5VaM0e743efZyTWwUEU8kw5CmNe4yFfPdfHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c16d62-c0c2-4253-e398-08dd9257583e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:49:59.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQJnl6dlVlS1wzzkjJOfYVad6V6emy1Vi+PqWMvmXH4Z3xE0VrsXPLx9W4p0+9Luz8aEEn/+QkxKapZYjXN6catQQzrJuoMIw8GDKm2/8s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505130189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE4OSBTYWx0ZWRfX/snDwLUhg2Kg NdHtw7fg4H7g4HmuwEqBb6KQEGYfBXNNdOSf956DKVVaB3GOcLDee+XyoBseJnhwOArWUF5ELEe 7zXNkRkFxFYWOTVSG0SITwrVYbha4+FMvb5/CX6KFFBx0/iXCuG6jjzuWcLo0ukR9zg2qe0mVxd
 MD0RILdUARzZyL1As3yZl0XO4I943sT5Kdg0ew+XsDaRjA7yO8TNyXmhQ62frP6RO0zSf3weniO 9SWBcJjl027/g5E7n5T6CC3ZtIbAz+qa7B0ltR7bzintYax/Q7ZxIYnOTbv4VL4ni+9VXMyD3rY uK7CE7pG+scTts6Mi36ru/WF2Oq3th4ug+6rivw2fR00C7rwTAlf0jSPzY/sNYVEuXy3JRpe4uv
 BMmycPlrf5b5S9hOipQdlGYuGJwQKcS1Ixyu80fnP60EKZpkuv9MLqfsEAwD0+fKy0DT6Hpw
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=6823a26b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=RpvRy7E0T3OrAw2H3cUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VxjV38J38Ji5Zo0M2o11QjKQ7J_iLzRu
X-Proofpoint-GUID: VxjV38J38Ji5Zo0M2o11QjKQ7J_iLzRu

> + * the same addr is used for ADC volt and valid reading.
> + * In such case, VALID ADDR is used and volt addr is ignored.
> + */
> +#define   EN7581_RD_CTRL_DIFF			BIT(0)
> +#define EN7581_TEMPADCVALIDMASK			0x884
> +#define   EN7581_ADV_RD_VALID_POLARITY		BIT(5)
> +#define   EN7581_ADV_RD_VALID_POS		GENMASK(4, 0)
> +#define EN7581_TEMPADCVOLTAGESHIFT		0x888
> +#define   EN7581_ADC_VOLTAGE_SHIFT		GENMASK(4, 0)
> +/*
> + * Same values for each CTL.
> + * Can operate in:
> + * - 1 sample
> + * - 2 sample and make average of them
> + * - 4,6,10,16 sample, drop max and min and make avgerage of them

typo avgerage -> average

[...]
> +}
> +
> +static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
> +{
> +	/* Set measure mode */
> +	writel(FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4),
> +	       priv->base + EN7581_TEMPMSRCTL0);
> +
> +	/*
> +	 * Configure ADC valid reading addr
> +	 * The AHB temp monitor system doesn't have direct access to the
> +	 * thermal sensor. It does instead work by providing all kind of
> +	 * address to configure how to access and setup an ADC for the
> +	 * sensor. EN7581 supports only one sensor hence the
> +	 * implementation is greatly simplified but the AHB supports
> +	 * up to 4 different sensor from the same ADC that can be

"all kind of address" ->  "various addresses"
4 different sensor -> 4 different sensors

> +	 * switched by tuning the ADC mux or wiriting address.

typo wiriting -> writing

> +	 *
> +	 * We set valid instead of volt as we don't enable valid/volt
> +	 * split reading and AHB read valid addr in such case.
> +	 */
> +	writel(priv->scu_adc_res.start + EN7581_DOUT_TADC,
> +	       priv->base + EN7581_TEMPADCVALIDADDR);
> +

Thanks,
Alok

