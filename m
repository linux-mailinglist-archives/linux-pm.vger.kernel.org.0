Return-Path: <linux-pm+bounces-25333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A7BA87254
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C577A5BAD
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440881DE2A9;
	Sun, 13 Apr 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="heIP/COc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="orFqX/Ab"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA771DDC08;
	Sun, 13 Apr 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744557402; cv=fail; b=J0vwBXmNURuJxVxAJZK96tnEUzm5Q8u+X3i8Ka4S46yDJnXe+ZKQc3WxEPzfDFr8GANl+AySRLAVwVvpyiMRDqMMqnOowzHjYImwKiF5s/IXPy7l47bRigN6x7efXKEN0OdldOomMxMIAKa+jsLKJGnIk90OVE2u6l7MmshbPMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744557402; c=relaxed/simple;
	bh=x9rnQpVTfTgSN43Sn0nu29sz9hObKABQWu1QpMxWuwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PjFd75ClCYmVB7zM6OFDAPJ2t+42r5xb3SncCAW3f6A3c3zXPoRQ5s4bnxEZDQGbHUCfF9gfOrzscE2Rzv2niC6qEajvxxhuKGSHqDK79UU/THQNK4dz7p3Oj7ffKM2etyWeXuX8pCw7EWLcFVQEh8yBS9wj2W4V1WSE+wgoVRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=heIP/COc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=orFqX/Ab; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DERCvK030801;
	Sun, 13 Apr 2025 15:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WEzKgydV87iush0+MfLW1SJcYUrB3uPnsll6QSs+4ds=; b=
	heIP/COckikm+1lReszuPM99W6n/BSQzhiSHVlY3fiq5B+zkfwJc4iGMQf/urgSQ
	kiNOud5dD4A2ym20RYo6WcIcO6IyS8OxKKup7k69gyuRYUzxBcvqsGL+VM8eeGkY
	OJvXJoTq3jI2+ZYlCG+qjLTpAI/m/rtq/zY6NuPlDv1SvOFWpOAYIVrjHgZEjY/j
	ti+TegufRBYjwLZBNOTaTIkr09fsaMzwpLiosVrrwLlQiXj/l1fZsWdGdtqI54wq
	LEIt7SnTPAOf3mG9nJTeFgnsFxG2/TB+Xzd2fgsNLELJbp3Xw/WaMyQGuHPUTTuj
	uaYue6TEFFR27xLPzt+fTw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460dqgr25u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Apr 2025 15:15:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53DCVpAY005662;
	Sun, 13 Apr 2025 15:15:58 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010002.outbound.protection.outlook.com [40.93.10.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5stqjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Apr 2025 15:15:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du5wNqU+R/93fHpVudkumHKcnl9g+/sn9rbuCBHW6SwgDyLu+CtrXSNlT+V1nF0DEsGBK9KHxKQmNWBiczuQYqgDQH50BmBDPyz00iXbcGpFPv5aWqaXuHtdI0NlZpKxd7trTSvRazC5JlPnMBweWSnq2wL5gH+mLV/ysTw9YTl1hWxlbosVOgNmIxrcpBhysw5Y8yAXBFvAQQZmaEy+miZJb6gfY4QsaN9Se1A/AWA7Ot+8hnUlSZKaTIowYWIB0faYefvNoImBgf1VZrKYYmsRSQBmJj9f/VssCGZyfMxVrlAT8qixQL35ep9AUhDmJOmeGqzpshsTEp0C6L0fJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEzKgydV87iush0+MfLW1SJcYUrB3uPnsll6QSs+4ds=;
 b=KnZ0ZNEcP7fyjj/dg5cVYgTD5HPzGLPf2/c8U46Hjo5vOR0texKdm18dZFKCb6Dwt8bCV7vu/H8kTFjPD6xq3Lb+QvBW3est3vkNYt6NbeuTHrbVGarZUfTpM6GBEcOocRd/SLwjHmNXHxZQZDPAwmi9+iOA8FI5vJO13unY5o4JhNYEiBx8+CoFP7tcnRjCDgHq5/G8ZZRCBSpDAysh52AJAb1htHX0zQy/NASWAO+SZCI4LPVTVrYNhS2iVhM7vpFYZfxkGG32Rmq7mqJ4nOZ+6nSifblmiNSFSiVJVTi0kWWtgTuEnxF+6N23TBHALjSavzsjXWUfkoD73bhwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEzKgydV87iush0+MfLW1SJcYUrB3uPnsll6QSs+4ds=;
 b=orFqX/Abbmw7D+BjNt+Xk5DJFuA9RnLeHJ1bUODUE55KqsKqXXQ4Ys7kW+B4sz+kuEzuxQWVE8578JLsQb280RCv5f2oKoTm9iMB/squk56JVjCBrTAP9S4L11oL4U3cwHpzsbOdxjEJBP/UiErFO9ykon3NOFvN8q0p7WFmPnU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MN2PR10MB4398.namprd10.prod.outlook.com (2603:10b6:208:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Sun, 13 Apr
 2025 15:15:54 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.030; Sun, 13 Apr 2025
 15:15:54 +0000
Message-ID: <1d27b3b5-0ece-4abe-acd7-3a3c86490dae@oracle.com>
Date: Sun, 13 Apr 2025 20:45:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] power/supply: Add driver for Pegatron Chagall
 battery
To: Svyatoslav Ryhel <clamor95@gmail.com>, Sebastian Reichel
 <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250413111033.11408-1-clamor95@gmail.com>
 <20250413111033.11408-4-clamor95@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250413111033.11408-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MN2PR10MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ca7733-0d74-47cf-b2f5-08dd7a9e1583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXd3cDdURXIzcUlZdm9PbEs2SzM5MFRMTnc3dmIxMWI2Y3IvNzBnZG5hU0xJ?=
 =?utf-8?B?UTYvRWM0T0ErSEpaa2VqY2pxQUJXOFF3K2orRnJNU0NxbjA1QVAwM2R5Z2tR?=
 =?utf-8?B?blRqNytkZXdDUE5HU0c3TC9NTVp4OTZqaStxN1ExSHA1aVBOYkVsVXM4eE5Z?=
 =?utf-8?B?WFk4bTRLeHRQQU82ZXFURnQ1dG1Sb1gwNWdOMkxrWWl3eVphdnpJbWRLaFAz?=
 =?utf-8?B?aXZNUkEwbjJmaCsyZzIvVlZuRGJpS3pRLzZOVm50NlliUjA5azZQNU5pYUVt?=
 =?utf-8?B?WWVnTm9yWWUrMWpLWlFzRDY4Y3k3MWk1NGRUNzY2OFg2VDZJMjA3Q1d2bURR?=
 =?utf-8?B?M2lyK0l1eTVxMDhrVlBYblo1K25YYVZtMm9rcS90cXdxZDZUb1VnVlg5Rzl1?=
 =?utf-8?B?RHdpQmlDS1Jsd01VblFrR2MxVDYyb252TzFPa2ZqcUtwV05SK0ZHTzJqTW9O?=
 =?utf-8?B?bW9hSFhwMjY1OUx5Z2Y5ZVlKRHNFNGZCYjZqMmlTaU9ZVy9scnZNZVVJb0pl?=
 =?utf-8?B?M090R3cxZUt1a1I0MzJJNGR6ZkhPMmk5czd1Q2R0eHVIY3liZ3VPNTl3YVdu?=
 =?utf-8?B?dVlFdjVoSHp1NXREbXdPUEk0cXUyMXhKZjBnUEw0VTZwMGpBNnBKelRrdXRy?=
 =?utf-8?B?Y05oSTg5ZVdiWkMwRmNrd1B6clNwMWNrU0ZVQmZhbExTSDdac1BkU0UrNFpw?=
 =?utf-8?B?NzJrM2x3T0d0WG1nM3MxYmVJNEdsQmVCS3NqMkF2Rjh6WStUWHlKWExVMm95?=
 =?utf-8?B?cTJ3aGluMWxqT1Q1cG1ObzAzWXAvaVVwRnlQRFJQNDV0Wno1L2JEMjdRSlk4?=
 =?utf-8?B?Zm5TZ05FWktyU3N1eW1PdHBqUWF5cXVFbGpwMUZaNWdGQitnM3pxallPclVD?=
 =?utf-8?B?eExwbWZ0TGdJdGJ0OHBOT01QOHRHL21MbHhaTlZLVUhYNUkyeGVTbGtZbU1i?=
 =?utf-8?B?cWcwdUtnWGdEQWZ1dStoTHZybGxxV0ptUWcvakRlQlFMOFFqL3pEZENrdHRG?=
 =?utf-8?B?aGxCRXE5NXNJVm9KM3dXY0dDTnIzb2JUNzFxbmgwaDlYcTI0OFJSbnN4citt?=
 =?utf-8?B?TmdqdVJCWlVqZEE1N2tSMTlmR2F3US93MVV3Qkk2WWQ0RWcvc0RKZmNtWTY1?=
 =?utf-8?B?U05PclFRQzhkZnhIUUJ0eTc1OTJDVllMUmNLS1hPU1QrVlVwVURIRVl6R2xY?=
 =?utf-8?B?STV3a0l3S2JNZEY3WG8yeXNXSVE2enZuamFZUnAwTHVveXZwNzdEM2Nwb0JL?=
 =?utf-8?B?N2xaL3hXcmFpM0pNWlhlYldob0w3b0J6dCtmZWFCdlNFVlhWMkhJK2R3a1Bx?=
 =?utf-8?B?SFczckRxSHhYUGIxaERsM3RkZHg3aEMrc3NDYi8vbGtyb1plekx3RmVtai8r?=
 =?utf-8?B?SUMzRFFCOWo5eVFhYldQYVBabnUvM3ZVbkhtSzJyT0ZnOFhWcThHVEU0Uzd5?=
 =?utf-8?B?Qnl5RWpLaTRzQ3FSaXZWMDBRbUtISENxa1lmTUZrN1dPdlRhV3UvbThLRTc3?=
 =?utf-8?B?S2traWpQa3JJT2YxcWtLVnpTUXRmRGRpOEtFQ0NnZXhTNUZUVHNBeCtHY2RD?=
 =?utf-8?B?QU45ckdKaDZNQ0k0a1dmNkIrMW1Fa3hyaU10b04vTDAzdFV0elBmRmNra09D?=
 =?utf-8?B?bi9QNUlhUDNjWnE5SENVRGFNQkVOek5MaUQzaVpFV1kyNHBrNUtXcFRETVl4?=
 =?utf-8?B?ZWRkV0xQQXhWem04UUgzczNWVGRoZ0Fpa1duTm0ycEVuMnlYN2VteGpFSVNq?=
 =?utf-8?B?WmNnbWYxTWFpcjk0dUtKMmc5cGxnNzMzNlgzZUNuZHJpb1JEODJvaTB4UEZk?=
 =?utf-8?B?djFDQ3pMZ2Nid3BpWENIRmZEUk9vTnQ3SkptOXJ6eWRhd0JWL1c5K1BHK2cw?=
 =?utf-8?B?alluUkJ5akUxaTI1c3hFckRJZ3lSa1JwVzFpZUszUnE0Z1Ruc2FlbUhGSUJI?=
 =?utf-8?B?cE9DNWZpenhRaGx0b010RmRQMXdGNGI4cFZaU2djN1oyTXBVaXdoUk8vYy9K?=
 =?utf-8?B?bTRHK1NIeGpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDhJQjQvV1Z3NkNYTDdqaVhqY0ZWNGswYmd6K2FMM1Z4R213MTkvYmJQdCt3?=
 =?utf-8?B?b0s4U3VOeEZvdDFqVWp6WWwvQU9oVTA0SW9LN1AwQ3JPbURIanR4STJUdENK?=
 =?utf-8?B?WGp2blBvS1BzK1QvbjRVZzBicHd1dXNuY1haUmdIN3FFUjJZcFlkZXdyaWs0?=
 =?utf-8?B?V3kzOGwyU3ArejlnbmgvOVJlRnRTeER0TGFMYUtRWnBFT2ROSTFmVGVSeERq?=
 =?utf-8?B?VzUwdFFzalpOMWJWU29hUFIwSjF1Tzd2WEk2WU9JaUJUUjMrV0tQTnFVWmMy?=
 =?utf-8?B?Y0lNR253MmZCdkNMVFY4N0RMNGd1OUJpK0MvMS83SWE3enNMdVRmbUUxcE9q?=
 =?utf-8?B?S2d6aWFQUUNsNEJiU0czVXdyc3BqTVJOeEwvZEpuUndocWlTRkhhSjdMOG5n?=
 =?utf-8?B?TVg2bmdzc2Y0ZFY0enF2SlVUN0Y1bDJkUS9tT1FvSm95VDJUcVdicEpqUUpq?=
 =?utf-8?B?ZkxFWUFHNW10djNlNHdiZ0duZkYvVXZLYWpLS0E4RzFjVkYrRlJqc04waSt5?=
 =?utf-8?B?QmVqNUV3UVJRcmRVMjY5U2QvejJ2RkNpRXFPVHB5Rkhmb3RBMXNzMjJ3RUNM?=
 =?utf-8?B?ekRNY0dIWi95SU82eWd5YWNCOEJNaStwcWVOSkJ5Sk9XK1lUWER4RUp3VXNw?=
 =?utf-8?B?OEcwa0I3TkhJVXJFRlR2R2YyUTc1eUszQWxIWU91OVZFS2xnQUg5Y0FDeFdG?=
 =?utf-8?B?MmxCMkFaMXhMQlJPTTJRVWRhdTA5NUUvVUx2QThGVHY0aml1c0t0NTFOUHR6?=
 =?utf-8?B?d2N5eWM2OFl6cWVUMHE1OHZWbUo1dnJBYjJSSjFIM2JrVHBhcDZNMXk3V0M0?=
 =?utf-8?B?U0s0RXA0UVFqSjdVVWpiNXczWndnZEp1K3pvUG45S1lrTDFJS2Z2WTNZM1NW?=
 =?utf-8?B?cklsT1dCdHBiUDF1MVZ2TFVDazJzL3FxM3dEdzhBSmNrYnlOcUd2ZWdSUjF5?=
 =?utf-8?B?S2FEZzd6R093R3YzcDkvcVc5UUpVQ1pGUTNhTnQvSHUzR0JaaGdaV0I0ZUQr?=
 =?utf-8?B?dXBnaUJJbEVYS3NOS2NsUENjU1dFRW9KWEZRNTl3Ym52NUx5N0xZQW5OUVpo?=
 =?utf-8?B?OUdmTzI3V09tdFBNM1Brazl0M3l5T1JIMDZYci9odDM0ZzY0blhmY2dNU2lq?=
 =?utf-8?B?NmhaTG9pN2xpUGQ5VDcvTENNSi9RRXRYNVdYRjY3aUtJb2JQQU5HdGtqdzFu?=
 =?utf-8?B?aE9rSXRsVlE3YTZqZXNjVkx4QzRqNzk2OVJpU1FvNThmdlplTHJweHI4TVds?=
 =?utf-8?B?VGpTZlRFVTN2WnRYWWpDV2hFTFpMZkRaUHBXNjRzTmphOEdzTDJtOWxuR2po?=
 =?utf-8?B?bE0wQUZTczlCa1F1OUQwWnFSWlFzQzQ1VG9CZTlLREFiZE9udFNQTENBUVln?=
 =?utf-8?B?ekYwZFpaSzIvUi95a3VsMGRLWk05dk4rS1dob3AyMS9UOGRSM0lxRUlTanZC?=
 =?utf-8?B?RFYvaGVvTWkrTVZ3VGlrSVpZSXBFenNKMnY3dkhUQW9oWEUycVVNVVJLem9i?=
 =?utf-8?B?a0w3VG5rYi9rU3dRQ1FGUFlxMUdFcXVEUUFtSnFLaTZVdENMWVZodmtuKzFs?=
 =?utf-8?B?ZXVsM3NHRCtqLzVqdWFrb0gybTNuckRuUG5NNXlyVWhLZGN1ajdGR3g1Wjdl?=
 =?utf-8?B?SzdaRFgzeHdzUlowV1E0d2V5RHdrRU0zR1NCY3dsYWx5a0hsb1ZucHZZNGdN?=
 =?utf-8?B?LzlaK012djFCbXhuWG5JMHMxanFlblBhaVljUFl6S3NaT0VBSFNxV0gyZkRT?=
 =?utf-8?B?THYveGdtMFVTdE1RMFF1QklZMVplNkwzY1JMNVdmNUV1OHlaNHQrZ09YaFVi?=
 =?utf-8?B?b3hQVFVSbGFkRWJKa094aWY3NUFTdkdPajhFYnRJQ3Y0WlhWM1ljUXZxclVS?=
 =?utf-8?B?THk2dHh3cVdDeVRCY0Z1YjExTDFueEgwSmZzZ08wbTZNMXBPa1dicXArc0xE?=
 =?utf-8?B?eVFsNHBYTWVxdHg3WW05L21QbHRHUUFlaG16dW1sK0hZQ3k1TGQ3eno2R3Vy?=
 =?utf-8?B?c1YrTUlUSDkvelUxTU8xUWQxemo3SmFSQ2VaWUZNTzNsY2o5UXFuTk9TbEhC?=
 =?utf-8?B?VXBIVmQzWVY4WGlKQmxWQ2RJWjhTajBOb1hqYlBjSkQ3cWVTNlNkRmJ0Nlo4?=
 =?utf-8?B?a1UvenFOZkpuNDhKTlpkbWJ0dmVhV2NyRVN4ZnQ1amJDNCtpbzNvMjBaTUNU?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1f4+gR2CVw6zx0z82/qtrlV3AbblCh4vKrQNopGrBFX83lC/MoKtQffmK23ysh7UVViz3ES63wVtD/FEHsf0KiqxgulzpbuvTOFrZaUuwZ1LX63is6Ok7QdPznUk53t0C3R7Qkr2DmDsi9Z8d+g/ACWxl7qkq7yJTvDm7qgi6V1TnZmbeW7KbTT3C+OEiakDwd+kGYY3I0Pn8hXJVs84/vIPTVJMHZ/It1PsRGDmAsxFlyLpnesJzsANGcbOC7pDmPOIxdYm/jrphyyw4fKFnsIuH1BGs0gkA/mQ1dk6AY6oRayiAxrgL+4W9RBmeMeftWG8HD1CGD8KDXpCAT8EmkyuGTqRmhvs04Ij2Lrcr3vQ0XsL80FKj+Gy/R5pNB06LLlebFUbVx8b3eLFy0LB7E1Z8sOrii2gdHocwtM4xe3M3zIOCcroA3UQTJBc5dnxxKv6Fnnx/5biaDB3sCXJktH8d2/JjA/s+02erVTB8MSwQ4sAcdW4s2alUN68PHneVdFi61A97u61klkKS3U4mCUVv+yJAgYTYbG/UM+zoxCS1blvPQCaPdEDhaBo/OMTDaewrFZ39HZIZZKe9u372+MN1VYUA86v6VvKdlgVEEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ca7733-0d74-47cf-b2f5-08dd7a9e1583
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2025 15:15:54.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGfRgBKrMxBuwyLgGaRhmcCkDc1KiaN1F0pi920nsGA6xUp+w3mL99iYOoz5hbw5dMYokW1L7XxMB2XnUOv/X9pMRua7zUfOFFNDukyuStQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504130117
X-Proofpoint-ORIG-GUID: w97k5Z_WM-RHEu0CiX2ws6GxAdpHBoc2
X-Proofpoint-GUID: w97k5Z_WM-RHEu0CiX2ws6GxAdpHBoc2



subject  -> "power: supply:"

On 13-04-2025 16:40, Svyatoslav Ryhel wrote:
> The Pegatron Chagall is an Android tablet utilizing a customized Cypress
> CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
> single-cell battery and features a dual-color charging LED.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/power/supply/Kconfig           |  12 +
>   drivers/power/supply/Makefile          |   1 +
>   drivers/power/supply/chagall-battery.c | 308 +++++++++++++++++++++++++
>   3 files changed, 321 insertions(+)
>   create mode 100644 drivers/power/supply/chagall-battery.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 9f2eef6787f7..d0fc9db524bd 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -107,6 +107,18 @@ config BATTERY_ACT8945A
>   	  Say Y here to enable support for power supply provided by
>   	  Active-semi ActivePath ACT8945A charger.
>   
> +config BATTERY_CHAGALL
> +	tristate "Pegatron Chagall battery driver"
> +	depends on I2C
> +	depends on LEDS_CLASS
> +	help
> +	  Say Y to include support for Cypress CG7153AM IC based battery
> +	  fuel gauge with custom firmware found in Pegatron Chagall based
> +	  tablet line.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called chagall-battery.
> +
>   config BATTERY_CPCAP
>   	tristate "Motorola CPCAP PMIC battery driver"
>   	depends on MFD_CPCAP && IIO
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 59c4a9f40d28..4ecf48a33fdd 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_CHARGER_ADP5061)	+= adp5061.o
>   obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
>   obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
>   obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
> +obj-$(CONFIG_BATTERY_CHAGALL)	+= chagall-battery.o
>   obj-$(CONFIG_BATTERY_CPCAP)	+= cpcap-battery.o
>   obj-$(CONFIG_BATTERY_CW2015)	+= cw2015_battery.o
>   obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
> diff --git a/drivers/power/supply/chagall-battery.c b/drivers/power/supply/chagall-battery.c
> new file mode 100644
> index 000000000000..1a278331efe7
> --- /dev/null
> +++ b/drivers/power/supply/chagall-battery.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Blank line require

> +#include <linux/array_size.h>
> +#include <linux/delay.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +#define CHAGALL_REG_LED_AMBER				0x60
> +#define CHAGALL_REG_LED_WHITE				0x70
> +#define CHAGALL_REG_BATTERY_TEMPERATURE			0xa2
> +#define CHAGALL_REG_BATTERY_VOLTAGE			0xa4
> +#define CHAGALL_REG_BATTERY_CURRENT			0xa6
> +#define CHAGALL_REG_BATTERY_CAPACITY			0xa8
> +#define CHAGALL_REG_BATTERY_CHARGING_CURRENT		0xaa
> +#define CHAGALL_REG_BATTERY_CHARGING_VOLTAGE		0xac
> +#define CHAGALL_REG_BATTERY_STATUS			0xae
> +#define   BATTERY_DISCHARGING				BIT(6)
> +#define   BATTERY_FULL_CHARGED				BIT(5)
> +#define   BATTERY_FULL_DISCHARGED			BIT(4)

' ' after "#define", remove extra ' '

> +#define CHAGALL_REG_BATTERY_REMAIN_CAPACITY		0xb0
> +#define CHAGALL_REG_BATTERY_FULL_CAPACITY		0xb2
> +#define CHAGALL_REG_MAX_COUNT				0xb4
> +
> +#define CHAGALL_BATTERY_DATA_REFRESH			5000
> +#define TEMP_CELSIUS_OFFSET				2731
> +
> +static const struct regmap_config chagall_battery_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = CHAGALL_REG_MAX_COUNT,
> +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +struct chagall_battery_data {
> +	struct regmap *regmap;
> +	struct led_classdev amber_led;
> +	struct led_classdev white_led;
> +	struct power_supply *battery;
> +	struct delayed_work poll_work;
> +	u16 last_state;
> +};
> +
> +static void chagall_led_set_brightness_amber(struct led_classdev *led,
> +					     enum led_brightness brightness)
> +{
> +	struct chagall_battery_data *cg =
> +		container_of(led, struct chagall_battery_data, amber_led);
> +
> +	regmap_write(cg->regmap, CHAGALL_REG_LED_AMBER, brightness);
> +}
> +
> +static void chagall_led_set_brightness_white(struct led_classdev *led,
> +					     enum led_brightness brightness)
> +{
> +	struct chagall_battery_data *cg =
> +		container_of(led, struct chagall_battery_data, white_led);
> +
> +	regmap_write(cg->regmap, CHAGALL_REG_LED_WHITE, brightness);
> +}
> +
> +static void chagall_leds_status_update(struct chagall_battery_data *cg, int state)
> +{
> +	switch (state) {
> +	case POWER_SUPPLY_STATUS_FULL:
> +		led_set_brightness(&cg->amber_led, LED_OFF);
> +		led_set_brightness(&cg->white_led,  LED_ON);
> +		break;
> +

no Blank line.

> +	case POWER_SUPPLY_STATUS_CHARGING:
> +		led_set_brightness(&cg->white_led, LED_OFF);
> +		led_set_brightness(&cg->amber_led,  LED_ON);
> +		break;
> +

no Blank line.

> +	default:
> +		led_set_brightness(&cg->amber_led, LED_OFF);
> +		led_set_brightness(&cg->white_led, LED_OFF);
> +		break;
> +	}
> +}
> +
> +static const enum power_supply_property chagall_battery_properties[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +};
> +
> +static const unsigned int chagall_battery_prop_offs[] = {
> +	[POWER_SUPPLY_PROP_TEMP] = CHAGALL_REG_BATTERY_TEMPERATURE,
> +	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = CHAGALL_REG_BATTERY_VOLTAGE,
> +	[POWER_SUPPLY_PROP_CURRENT_NOW] = CHAGALL_REG_BATTERY_CURRENT,
> +	[POWER_SUPPLY_PROP_CAPACITY] = CHAGALL_REG_BATTERY_CAPACITY,
> +	[POWER_SUPPLY_PROP_CURRENT_MAX] = CHAGALL_REG_BATTERY_CHARGING_CURRENT,
> +	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = CHAGALL_REG_BATTERY_CHARGING_VOLTAGE,
> +	[POWER_SUPPLY_PROP_STATUS] = CHAGALL_REG_BATTERY_STATUS,
> +	[POWER_SUPPLY_PROP_CHARGE_NOW] = CHAGALL_REG_BATTERY_REMAIN_CAPACITY,
> +	[POWER_SUPPLY_PROP_CHARGE_FULL] = CHAGALL_REG_BATTERY_FULL_CAPACITY,
> +};
> +
> +static int chagall_battery_get_value(struct chagall_battery_data *cg,
> +				     enum power_supply_property psp, u32 *val)
> +{
> +	if (psp >= ARRAY_SIZE(chagall_battery_prop_offs))
> +		return -EINVAL;
> +	if (!chagall_battery_prop_offs[psp])
> +		return -EINVAL;
> +
> +	/* Battery data is stored in 2 consecutive registers with little-endian */
> +	return regmap_bulk_read(cg->regmap, chagall_battery_prop_offs[psp], val, 2);
> +}
> +
> +static int chagall_battery_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct chagall_battery_data *cg = power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = 1;
> +		break;
> +
> +	default:
> +		ret = chagall_battery_get_value(cg, psp, &val->intval);
> +		if (ret)
> +			return ret;
> +
> +		switch (psp) {
> +		case POWER_SUPPLY_PROP_TEMP:
> +			val->intval -= TEMP_CELSIUS_OFFSET;
> +			break;
> +
> +		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		case POWER_SUPPLY_PROP_CHARGE_NOW:
> +			val->intval *= 1000;
> +			break;
> +
> +		case POWER_SUPPLY_PROP_STATUS:
> +			if (val->intval & BATTERY_FULL_CHARGED)
> +				val->intval = POWER_SUPPLY_STATUS_FULL;
> +			else if (val->intval & BATTERY_FULL_DISCHARGED)
> +				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			else if (val->intval & BATTERY_DISCHARGING)
> +				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +			else
> +				val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +

no blank line is required between a case label.

> +		default:
> +			break;
> +		}
> +
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void chagall_battery_poll_work(struct work_struct *work)
> +{
> +	struct chagall_battery_data *cg =
> +		container_of(work, struct chagall_battery_data, poll_work.work);
> +	u32 state;
> +	int ret;
> +
> +	ret = chagall_battery_get_value(cg, POWER_SUPPLY_PROP_STATUS, &state);
> +	if (ret)
> +		return;
> +
> +	if (state & BATTERY_FULL_CHARGED)
> +		state = POWER_SUPPLY_STATUS_FULL;
> +	else if (state & BATTERY_DISCHARGING)
> +		state = POWER_SUPPLY_STATUS_DISCHARGING;
> +	else
> +		state = POWER_SUPPLY_STATUS_CHARGING;
> +
> +	if (cg->last_state != state) {
> +		cg->last_state = state;
> +		power_supply_changed(cg->battery);
> +	}
> +
> +	chagall_leds_status_update(cg, state);
> +
> +	/* continuously send uevent notification */
> +	schedule_delayed_work(&cg->poll_work,
> +			      msecs_to_jiffies(CHAGALL_BATTERY_DATA_REFRESH));
> +}
> +
> +static const struct power_supply_desc chagall_battery_desc = {
> +	.name = "chagall-battery",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = chagall_battery_properties,
> +	.num_properties = ARRAY_SIZE(chagall_battery_properties),
> +	.get_property = chagall_battery_get_property,
> +	.external_power_changed = power_supply_changed,
> +};
> +
> +static int chagall_battery_probe(struct i2c_client *client)
> +{
> +	struct chagall_battery_data *cg;
> +	struct device *dev = &client->dev;
> +	struct power_supply_config cfg = { };
> +	int ret;
> +
> +	cg = devm_kzalloc(dev, sizeof(*cg), GFP_KERNEL);
> +	if (!cg)
> +		return -ENOMEM;
> +
> +	cfg.drv_data = cg;
> +	cfg.fwnode = dev_fwnode(dev);
> +
> +	i2c_set_clientdata(client, cg);
> +
> +	cg->regmap = devm_regmap_init_i2c(client, &chagall_battery_regmap_config);
> +	if (IS_ERR(cg->regmap))
> +		return dev_err_probe(dev, PTR_ERR(cg->regmap), "cannot allocate regmap\n");
> +
> +	cg->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
> +	cg->battery = devm_power_supply_register(dev, &chagall_battery_desc, &cfg);
> +	if (IS_ERR(cg->battery))
> +		return dev_err_probe(dev, PTR_ERR(cg->battery), "failed to register power supply\n");
> +
> +	cg->amber_led.name = "power::amber";
> +	cg->amber_led.max_brightness = 1;
> +	cg->amber_led.flags = LED_CORE_SUSPENDRESUME;
> +	cg->amber_led.brightness_set = chagall_led_set_brightness_amber;
> +
> +	ret = devm_led_classdev_register(dev, &cg->amber_led);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register amber LED\n");
> +
> +	cg->white_led.name = "power::white";
> +	cg->white_led.max_brightness = 1;
> +	cg->white_led.flags = LED_CORE_SUSPENDRESUME;
> +	cg->white_led.brightness_set = chagall_led_set_brightness_white;
> +
> +	ret = devm_led_classdev_register(dev, &cg->white_led);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register white LED\n");
> +
> +	led_set_brightness(&cg->amber_led, LED_OFF);
> +	led_set_brightness(&cg->white_led, LED_OFF);
> +
> +	ret = devm_delayed_work_autocancel(dev, &cg->poll_work, chagall_battery_poll_work);
> +	if (ret)
> +		return ret;
> +
> +	schedule_delayed_work(&cg->poll_work, msecs_to_jiffies(CHAGALL_BATTERY_DATA_REFRESH));

a '\n' before return is customary

> +	return 0;
> +}
> +
> +static int __maybe_unused chagall_battery_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct chagall_battery_data *cg = i2c_get_clientdata(client);
> +
> +	cancel_delayed_work_sync(&cg->poll_work);

a '\n' before return

> +	return 0;
> +}
> +
> +static int __maybe_unused chagall_battery_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct chagall_battery_data *cg = i2c_get_clientdata(client);
> +
> +	schedule_delayed_work(&cg->poll_work, msecs_to_jiffies(CHAGALL_BATTERY_DATA_REFRESH));

a '\n' before return is customary

> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(chagall_battery_pm_ops,
> +			 chagall_battery_suspend, chagall_battery_resume);
> +
> +static const struct of_device_id chagall_of_match[] = {
> +	{ .compatible = "pegatron,chagall-ec" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, chagall_of_match);
> +
> +static struct i2c_driver chagall_battery_driver = {
> +	.driver = {
> +		.name = "chagall-battery",
> +		.pm = &chagall_battery_pm_ops,
> +		.of_match_table = chagall_of_match,
> +	},
> +	.probe = chagall_battery_probe,
> +};
> +module_i2c_driver(chagall_battery_driver);
> +
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("Pegatron Chagall fuel gauge driver");
> +MODULE_LICENSE("GPL");



Thanks,
Alok

