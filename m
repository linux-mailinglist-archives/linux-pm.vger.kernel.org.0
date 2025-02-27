Return-Path: <linux-pm+bounces-23036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5EA47339
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 03:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9F2188E347
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 02:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68DE19E968;
	Thu, 27 Feb 2025 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cpcinrj+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nY4jvx7q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AD1917FB;
	Thu, 27 Feb 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740624795; cv=fail; b=UqWKi0BNhK+HWn7plycwrAWmNl3WMUAaeUY7OwYBY73Mc5NJzzd7uUFGrUWEDn2dJd63uBT/o+Apr7ELh+UGVLrbmkgRNyGaMdYYmMpT68e7/l6bPVWmCruiQv/92JAQtRjrFOwttfPvOW3bmg0HbvoTkKI1BbrfJFpVg7+LwUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740624795; c=relaxed/simple;
	bh=DCJcsIY+67uI25xN/Bh/XDQ/XNsGmmvVyA+v7dMwqvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKOrzGwbvFCqaptUWcklKcamiC0Kp9YI3n5QELiKTAWDRqLU9fpvJ6eDl4ygNWWvk5iwu8dYCxmFdNstI5MuLFXJAzdX8sguVwEYNh7niTGPKs9XS/ZnOC0frUdp39oIkhPwGUcoQA7LS5UYg04CF6T9Nn0hkZ7E3oUjL9Cv1vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cpcinrj+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nY4jvx7q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1gZZ9029207;
	Thu, 27 Feb 2025 02:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=roDHLQ4NDanYjztc9nsjHSRYOlDJAgqFMsd17odqHx0=; b=
	Cpcinrj+Bi0L9Vd1dds8edsMEF2LzORBUkY06HocryS6moPvKw+Y9KGnd+Ys2tZj
	ON1RjM94xuik8bNGjeYP8YESH9FsDgq1Vvxu2nJC8zLla7xUAOxraHo9MRuerKzK
	euBJ7xYHYEQ0GA5eyRM9UUgkTJJvbB/G8WDzqjxb2IVAeP1SHXse4ZAW0+b+oqgw
	Qu9tyZGa8a0UB54/reXtK0SB71Mi685Iw6ZzKoiwNnIdsYbAeMsUS9vbPixdg4+M
	kYZPbS/S/oUA70leKX5hHXgpqyTy3WLEOBJQ2GBufztRcku2vx+tgLPsEP00KxFQ
	wR5MB0XIX8iOybIDErho1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdjh8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 02:50:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2C09o008187;
	Thu, 27 Feb 2025 02:50:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51hkg37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 02:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsR7Od1GGGBvCFQPACJzui7QvJomlh5X1Q353jkUenPMvUayfoIb9R9Dbj5wrTLPHTmsGmUbTbv+mSCAHHyGwwIBI+dzs18HhyiGFe70R2gw3NJV7ybjk0OswgL2n69PwXXU3GWFg9sN+HAr5T4Le2KpUOnurzpMXj6OjPOBbeIFc7SUaHi/b9OihvhmXo/b1MXgTRPCa5JSF/mYJy7UtVeRVZQhCKQcbvATES44w3YKJHDkWpJyYgLjNthUvpS1jxl41hKeyjy97xByGl890bNz6VlVZasN3/4lNsRPI8ER6cdqHylmzMiTmGwU4aEDzH5zj8iAYDpNyMuewrT+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roDHLQ4NDanYjztc9nsjHSRYOlDJAgqFMsd17odqHx0=;
 b=wkrAGQhM+Sxgu0OPckr4RjLO0cWKI3xS+LarUuFpVQsji6h+RfCfrZGIFaRtZeCskF6KPcVBBsDmgjhXrL9mZPGVqocLsMsyCf6V/4YAzISDAXHco2B3YaSGu8xDDwKN94PKE2VoO5E2jn34sgeuoV+5yQ1gu8zzfpsGfkIzKE9xzkeXUDLgyfFOIFpyLdgSg5LDlT9rjG1DfE6y9mNlkDN48uxxyx7APh/tEXs5zAZ8YH7K0gzRaO7XOTVz4zp2g3OMnmiyJ/q1k8tdS2Br0tsL7IQkzhngtBIGPrvDtSMXET+reYSPTzjCVnOCjUxzXuHcrSgI1Omv2jP71SvX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roDHLQ4NDanYjztc9nsjHSRYOlDJAgqFMsd17odqHx0=;
 b=nY4jvx7qrVm84CdnHvOq1HDDw/0uhGsqO+92cTyoKPRIeBUdqYnl6Xnf8tOxl3nJwaoLXPqCADnv2Q33CCCZaMg2Mx/u/JCSfshaodwNGxSOz+Qp3EuJHiPiwRgu+RAToSphLabkY6pD+dNqYFR4aEVC181Gp1d5DvsIxxIlczE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB8143.namprd10.prod.outlook.com (2603:10b6:208:4f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 02:50:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 02:50:49 +0000
Date: Thu, 27 Feb 2025 11:50:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
        GONG Ruiqi <gongruiqi@huaweicloud.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, stable@vger.kernel.org,
        Yuli Wang <wangyuli@uniontech.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        GONG Ruiqi <gongruiqi1@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Subject: ARM64 crashes when resuming from hibernation (randomization features
 enabled)
Message-ID: <Z7_S__ExtqvNmD-3@harry>
References: <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
 <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
 <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>
 <202502190921.6E26F49@keescook>
 <CAJZ5v0hZZdRPwp=OgPw4w8r9X=VbL6Hn6R4ZX6ZujNhBmMV3_A@mail.gmail.com>
 <CAAhV-H5UaEbA0DrAUfROJoiatwrjsge4DNcVTJi=8vtk2Zn+tQ@mail.gmail.com>
 <202502251240.49E8674AD@keescook>
 <CAAhV-H43RS9Kfj__eHrzffUcC6BSESYTc0JiKWsn+Bg2BJkyZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H43RS9Kfj__eHrzffUcC6BSESYTc0JiKWsn+Bg2BJkyZw@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0012.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: c676d68b-5206-4b49-7af3-08dd56d98a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elU1SmJhTTQxUVdydGtDdW95QVcvYUMvVndwZ2tmWmVub1JvVGx2czk0WkVG?=
 =?utf-8?B?cmR6S0FwbmdRQkY2b3hYaCtGWmNMUXF3bFJJVitETXk3TS8wS0JmcjBIYjZs?=
 =?utf-8?B?YktMYzZtcHBpUlRES2kvdlpvdWEraitBQ2ZrS3JHYUZwUHJYRko4cjJDTHJG?=
 =?utf-8?B?b1ZwZXAwZUZOcFhlSUkrUGV3bEJlNnUwb1dFMjMvNVpMY0R6MlprMTNwODho?=
 =?utf-8?B?K1ZlSTdQd0VYMHAzeHI5aEphMElHbjN1Y2dUQ3ArSjdKL3VWRWJZT0dib0tE?=
 =?utf-8?B?U09HSmk2NEpCMGZ5cm5zQ0pGUTYvM3UrUXByeHhtQi91WWJ2ZXBSeTNnRitZ?=
 =?utf-8?B?bnpmdHFyRytkWFQwa280NEJqNUM4ZU5MN1A0YnZxRUdOaExDZEpKMGl3ZWE4?=
 =?utf-8?B?ZnNNdHBjTTJvWVF3N0VnRGNueG92RGFxRjRJZ3NRaDBEWnVxbUNCeU15MHBu?=
 =?utf-8?B?YngyT1pEWVRxaFJrOThjN0gveU9FUjNiTDVrbWNLMnlGSWVOMitUV1JiRllq?=
 =?utf-8?B?elBSTjBOODNYc0E3ak5kMlpJblpqU3FHemYrcWNUUkprb3hVdEJqRkdLZWIv?=
 =?utf-8?B?T1B5TnJVNjZKblNxWnM1SkUzY1FlRUFjYU9MVllZS08wVWZEOTcwZW53akt3?=
 =?utf-8?B?b0RmM3NRcWVuVVErYmd5VVB4QkxOTlFWRndaUlZ1Y3BVcEtVTjZHMTMwc3VC?=
 =?utf-8?B?Q3BoSmk4ckpobWFVa1Y1YVl0UTlGaVdKeGx0Zy9kWWcwTXF2c3hsWFo1S0dZ?=
 =?utf-8?B?MENpVlhOQnlDQnNHWmdUNTZtWkxlNFp4NlhyR0liSzNoMUIzRHhUbndnYUt6?=
 =?utf-8?B?LzM4dG14NnBsWVFkU3dreDVxbUQzazB1QWZWb1crTGZCWnpRTkR1WEp1ZG1a?=
 =?utf-8?B?U0pNNFF6cG9pZGQrMWxGb2Vjc0tjbGJKWEMzcWppZHpRUjFtUno4TmN6QzJK?=
 =?utf-8?B?Y3NJdFF6RUJjRC8yTTJJNmVobVRVTjJXMkhuS1ZULzA0YWUzaStsVFZNL0pU?=
 =?utf-8?B?Z3dJYmpLbGpuMzBPT0djZzNYbElNL2dSdm5nNUxaVDU0aEQrcExyZm5VdCtQ?=
 =?utf-8?B?bjJpVS93NEpNY3VzR1BHNUVjdnBSV1F3VmtocWNJSjBEejQxbWhmTW9oZDBl?=
 =?utf-8?B?bE5mWUZrWG8xL0tnQllEandzQ3Vna0FuUHAxQU02SjZxY2NhRk92V1NUYXRw?=
 =?utf-8?B?ZVVLc3RvM0s4K0laazJLem5KS0FTcGk5MVIxUUZDeEVxYVpFWmdMcVhZV2wx?=
 =?utf-8?B?OU1hOWcrS215TUV5OEZ0dTJETUg1VkNCN0U2NHRJejQzd09YdHZ0b0ttN2lj?=
 =?utf-8?B?Zk83YVJ0WnRKQjRJK0lQQ2RxejFJNFVWbytlbU5xMTIzbktPaEIzeFhDUk0x?=
 =?utf-8?B?ak5GSVJrYUxncjNrb0lqVzZDb1ZFd05NR3FwU1FPUHR3MU4xUmVPNWo1NURW?=
 =?utf-8?B?SmVsLzgrME96WWpGWmdLZ09RYWFpdCt3WHVCZlo3cEFwbEZudkUwZGZ5MTl3?=
 =?utf-8?B?V24xcGhrK2RLaVU2TDNkaXhlWTcxbTc3Q0ozd3VnWnMvNWhTdVhNUGhhQmJK?=
 =?utf-8?B?TnVERDlBajEycElqMjdKVmV3THBVVVk1VEkvLzl5MmpVcHcrazBEQjd1U3I3?=
 =?utf-8?B?aVJtSDVkM3dBOUVMcHBTLzgrbDRMR0JkanNBWDYreHJ6Q0d6NXJ0NnV2dTIy?=
 =?utf-8?B?VmEvS2xEVTdiVE9nSDQyd0djalp6cmg1eFhkOWdpRTRxY0JxbW5RNk15ZXc0?=
 =?utf-8?B?TkZBSzJJekRYZ1FwR2hER1EySS9JamRYZ0JJM0dwL01lTFdBQTRnSGNiZ1dj?=
 =?utf-8?B?aTY3UlphVkpPQmJjbDQ2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVdSS1JMOHA2d2o1a0ZXVG1tRFFneGt5M1ZXV0IyVDVrTHF5ODl1NDUwTmky?=
 =?utf-8?B?S0MzMEdyR21uTjBtVHBnRHh5TFhOam9STEovMnpBVmpkRTVRb2ZWSlFBUnYz?=
 =?utf-8?B?eS96bEpQblV1OFkwN0hLRzMxVUFtWm5nUVN2ZkhoQU1NVHZzUW45UHh1Sitv?=
 =?utf-8?B?UzVNeVZFVm16Y1krOTVKbHovaGR1amNYcTBmZDF4YzBYZVRYNERNbWFlajBm?=
 =?utf-8?B?NVhkYTZFeWRLQldaR3BjWE9GZ0FUa2cxdzZhc3Rya3Z3WDlJem9EYkxVWi85?=
 =?utf-8?B?NW9ENlBDNFlnTXdSM1NHdDVKRXNlNktRL1VRbmliRGQrbHUvMy9hS3RzQUdG?=
 =?utf-8?B?RDZWSUptTHNLcWxCeWJxNjhOV05pNllpcDRhYlc1akp2d1dzNEFjaEs4T3Vl?=
 =?utf-8?B?UW81OHU1aGE4RHEwUXQ5MmdwWExJR2pUU1RPQVo3cG5Ta2NScWdVY08zdTFu?=
 =?utf-8?B?cjZaNmtHQWp2YTBsQVZKak4ydU1uOU5nQ21Ob3pjNG5pbU9LclpobzE1VU9h?=
 =?utf-8?B?QjZITzZKaFVxbHdqb0FGODE5NWkyMC9ROGZBRGtEVzVCTmI1N2Z2VjUwanVN?=
 =?utf-8?B?Snp1MUpKNitXejg1NktLUUFRdFlwQjFqdk5hQXNkd2FvNS9HbVNsMG9WbHFx?=
 =?utf-8?B?Y1Zhd0FOWmFjM1Z6OXMvZ25BR1JIczRZWDBXTHBjckV2Yy9YeDlpQlpmaDJm?=
 =?utf-8?B?T2F5cWhkNXgyM0Q4U2RvMVN2RnlibjR1Y2diM2M5aWJMQ1VFS2o3cVRuNmdP?=
 =?utf-8?B?TFR4eUdZVVF5aE1PTUdieWVIUzUrWEE5VDY0bDZaOUZsRm9zcU1HbjIwUmNR?=
 =?utf-8?B?QjNQbVpBZm8yVmFFdXlrUGNqb1Z4QzRzdFpSQVZzZi9jTVh2L1R3eHZpZ2Ny?=
 =?utf-8?B?dGlSU2RaODJ0K3hrODF6SUNIVmZwTnVBWktiUjg3ckhCeTk0UmNnVlE5Z28x?=
 =?utf-8?B?bmh6UHAzbW01WGJTZ2lhM0x2NjFCWlBUK0xwNW9WWHBBdjVWKzA1R2MwamU3?=
 =?utf-8?B?T01aSE8rZU5ZRGMwenBYSksrZXZKazFKVEpZYjFBREVNMWZVd0NFN3gzUnhG?=
 =?utf-8?B?UnkvQzlSd0RTZExmQVQ2czlqMDAzalJpWkpLZHcrK2c5ZmhhRU5TN25xUndK?=
 =?utf-8?B?Ujg2U3N5cEhRTkFRMVF0SHdUaGtFa3psR2ZFYXpGU2daYzNJUVdLYzJXSG9N?=
 =?utf-8?B?Yk1YRXZBd1E2VGJnZHM1NWpFd1RDR0VKQVlxK09EUFcza2Vqb2ozd25tV2cv?=
 =?utf-8?B?bkMybkl0VFZWc2daRlJRMGpDRWphdVpoVVhoWXp0cW0zeHJTZ21nV0ZZU0Iz?=
 =?utf-8?B?cEJ1dzVzZ3MyREI5OU9BQWx2NWlwOTlKdHFsOGdHS3ZuLy9pQWcyY0Y5cjQr?=
 =?utf-8?B?YXcwWndibWpNaEZNbzgwUkVJajlxRy9pKzExejlLb01Qcm92RDZNdkk2N2FV?=
 =?utf-8?B?RGRXcDZRT0FnMkJYWGlrQXhsYkNZUmNxT3JJM0ZmczFEU0VHOWJRRzJPYThh?=
 =?utf-8?B?Z2tBMkxlbDgrYzZJRVFrVFVYV0h0V1oxemgza1dsdEl1aWFROEFUOWlIdGU2?=
 =?utf-8?B?azVNcEwyYkZkdDVEWUdmNStEZG5XY0F4cDQ4UXFSbHYyUHRLSnlMZWVXWExj?=
 =?utf-8?B?QzRObzlVc0xBcFhITnJBQTE5bnY1S2pZbDNzY21RQVBsWXRuY2c2Q1hLcGpt?=
 =?utf-8?B?WFRraUNZN1IyajltbXdCZGEyaUo2ZVNDeEo3Vm5aUnVtbjNOUUJtVnkzUElk?=
 =?utf-8?B?RzI5ZmY4MU0xUzYwc1QrL2EyZ25WZHlOY0JLTERmYllJZTFIYWlQUENIakV6?=
 =?utf-8?B?SmZFSE54a0NacFZ0S0tDSWxjN1BHVkNrejRnWi81cld3OWsrMnhNa0lIVnZl?=
 =?utf-8?B?ZjNpQ3laQ0lKV1ZGSEtQUEpSa0dvYklGVmQ5elBDdlJPZlVwWU5VSi9WaEpJ?=
 =?utf-8?B?b2hBSkxRbjNzTk1PUzRid0dyektoS1lJSHdNb2czYkwvbXF3QzRnRlNOVWc5?=
 =?utf-8?B?Rm03ZkVFMkJFMjNPaDBiazJGbGFpYWZzVUZvOG8xYjMvUTlnaWFsRi9rNS9H?=
 =?utf-8?B?TkxqL0svZ1lZRE5KZzN1dms1UDRrT1J2SmJSZXFkbml0ekpZdDZNWndzcmNu?=
 =?utf-8?Q?98DxA4vYbsoO8XbzmQHDaOkzf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Iq8wxISC3Paez21czdCn8dvBXoc/t0Ukuf5mBI5/emAKIkUwSW7o3uJ8f3F9DoWWIeKaYV36UFSK2uHYquowKEq7gq3i113jKEXHnMIywDYEeVXWsXb1/omaIx++S1C10q8pjaUR84fG9J7zC1ltw3DHSGoiIcybS++vgRBE8k1Tgg9x0t5vRq2zpXHMMjy5dpm8zcdmZAEnZkgA9qcLKAODWQbFwIw7Ol4QMZ+bdlHtS6w3BH/J3aT97sPJGZXgbfGy7pddbGEc3GE3a/Q2ESUT1VdIAITFUFQpU9OScgibuTUMC1HUQYaeL0hJIcKADf3qYlRRkKcgquLJFh78C5d/4yFisWwYGykLw3DkKoALE5gYrokMXbdHM+jkUIXPlWN5MfBUHSmmQpwZ0I946D8tDUiJSmL4JZj8nZ+kUlEzJwpjTszKfbPmnvZSZ7mbEv6+5isIG8BF+KEX6IlCky66eXCLFdzmDM+WeRGqsPkl0uunvQa6x0s8+ZcjwQHpyHr4vaoCfs6f4IhGpgiR50pzpYIFnhC5Wt6/Kyg1EuatdshOk2TsfPwxtPUPO9SBt43x65soV4o4TLt/g9Cr3R57bGXgaNG5/FSLHHFNZIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c676d68b-5206-4b49-7af3-08dd56d98a72
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 02:50:48.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1VgfxToVA8pYdTlollNpRTMS3HTxUwnLYk6q/0npRjMkXsUTqVcet1Lo+chFcQYLjlR2iTHrkQEQ8C5zqLilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=806
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270021
X-Proofpoint-GUID: 5xSLR_8xj7_PKgjrpyblOVz9yuOBjnKQ
X-Proofpoint-ORIG-GUID: 5xSLR_8xj7_PKgjrpyblOVz9yuOBjnKQ

On Wed, Feb 26, 2025 at 03:31:03PM +0800, Huacai Chen wrote:
> On Wed, Feb 26, 2025 at 4:41 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Tue, Feb 25, 2025 at 07:35:13PM +0800, Huacai Chen wrote:
> > > I have investigated deeper, and then found it is an arch-specific
> > > problem (at least for LoongArch), and the correct solution is here:
> > > https://lore.kernel.org/loongarch/20250225111812.3065545-1-chenhuacai@loongson.cn/T/#u
> >
> > Ah-ha, so it seems like some system start was being incorrectly shared
> > between restoration image and hibernated image? Yeah, that's important
> > to fix.
> >
> > > But I don't know how to fix arm64.
> >
> > Is arm64 broken in this same way?
> ARM64 is broken but I don't know whether it is in the same way, I just
> know this patch can solve ARM64's problem:
> https://lore.kernel.org/linux-mm/CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com/T/#m6ca3bd9fd3fe519161f28715279d0dc371027506

Let's Cc ARM folks :)

A bit of context: LoongArch and ARM64 crash when resuming from hibernation if
CONFIG_RANDOM_KMALLOC_CACHES=y. Initially it was argued that kmalloc
randomization should be disabled during early boot. Kees and Rafael
thinks [1] randomization features should not be the root cause of the bug.
Later, Huacai fixed [2] the issue on LoongArch side by addressing
LoongArch-specific problem.

A similar crash related to the kmalloc randomization feature was reported [3]
on a ARM64-based laptop. ARM64 might be broken in a similar way, but
we don't know for sure yet.

[1] https://lore.kernel.org/linux-mm/CAJZ5v0hZZdRPwp=OgPw4w8r9X=VbL6Hn6R4ZX6ZujNhBmMV3_A@mail.gmail.com/
[2] https://lore.kernel.org/loongarch/20250225111812.3065545-1-chenhuacai@loongson.cn/T/#u
[3] https://lore.kernel.org/linux-mm/CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com/T/#m6ca3bd9fd3fe519161f28715279d0dc371027506

> Huacai
> 
> >
> > --
> > Kees Cook

-- 
Cheers,
Harry

