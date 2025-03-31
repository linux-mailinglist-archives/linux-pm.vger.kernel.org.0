Return-Path: <linux-pm+bounces-24661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E47C8A76CC4
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 20:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A0E188785E
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 18:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E4214A96;
	Mon, 31 Mar 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VtgJMEgR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eBGAMuvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80E79C0;
	Mon, 31 Mar 2025 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743444670; cv=fail; b=cSLufA91uROWII3w/SVL3p0gVQZv5W39nRBMbZchVxtFPpljmWS2PZ6Tvyf2OOZ5eiudJdJqIsu2r6gjU4BJP3i/njITgJ1/EcAMFFyflJRMnvUVNFIyRVWsEPO7oW4QqQeEefffEP6P1hesfdyBojsK3X+fEasOPtqIZuiDJKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743444670; c=relaxed/simple;
	bh=pfp91jUDR4e2i57Sl0feFkPUu3MkCza/9aw/f9w41zk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=khxmdA1NdEbiAjA6tsZkHAkIwE011GCwhB98htNUIfoqlSvvmSp4TJAJWXA6bL+OWR7dZ4BC3Y4v1yO0CUfvDWoGBjAZj1YNA8KNnJsJlOKC0zG9JUv2GYt6VDnZ8G+a3l+//yDqkRnamZZvL5XQ00htEhrISdOHIjpRatQcqg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VtgJMEgR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eBGAMuvh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VHu5Dx018769;
	Mon, 31 Mar 2025 18:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tvsiSqOJY4Fp61xI4g+Pu+N+W1YBaubxLVmpsGR0QPs=; b=
	VtgJMEgRi9yE8hpbYY4QnUzzHhEgQ29uPg1ghZkrjI+wRQ1T776zGBO6IeAB/fQk
	EB43kBOLBDVCZ+14sE3TtO4EKNY9xRbpC6w8m0lmRIjcz7NQhq2NbvbFbc9ELNIa
	u92VVNR+x7tpCHxolJ/gCTRkSvS6dUf7mOIJeiVj5jiSNPbcQAg0S3QyLbEMNnkS
	8KszNHnT0A74bEpLW9QT9XNn7nszOVwiFSbV5msKcPDsL9XEttKByYP9OStPMp7p
	onLSo7kB1HQxs/ea94napIdy48VTklNWEh2QVrVEJam1cGBajr9gKxxraUxygdTc
	vyyMJQXjV4OrWNrynRMqhg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7saku7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 18:10:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VI4Sn0010697;
	Mon, 31 Mar 2025 18:10:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7ae86bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 18:10:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vjhm6N5q46fuoZk/GBizrrP2UhPfbcG4Uet/YVCf1ZoVJ3K6e2QhteqUlNXKpy9Mz+QsjFDXNF6wniW2E4WT0kykn4VVswmrQEXcvDvM7/ixF7BU8v50XU4bLhTZAz4s3uRKd07VwZZchcOLzoO5agv8k5iK9HhdViyKOwn3RHbZFIMw7sN1g3ypTD49NOJJoLDeDDI6HoGCTAXJ6egiaWdZk9nGehGEPAkP2jPN97lL29W2n+hOnPNMOuFLKp8pWGuDv43YtADL7unC/4tzLGT5Bhj1F/c99py5JrkWz4sfgchL5L5bW2Yxo6YAoeFKJIMQMOOJ53czKA8/UvD6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvsiSqOJY4Fp61xI4g+Pu+N+W1YBaubxLVmpsGR0QPs=;
 b=vsXHk7IeolBDNwmIprBF78xqq8M0gjOPwV48F7tyIOxNi87baTJtRC7fs4Ja5w/2t49ZYzpPDszr5sxYNLaDH2FIHup7Zc0fk0WDgUc6m/zDmRdqnzK083RAxcYqPcpsGAIbzaWl9m7CgGJJRWHL7cFjQQFAc4L7YruZwVPENC5Q3GUfDvREPfjgQIvx8VuDg5uJYzSUiPZhV5bubl+RCw9OI/vJ5ye1I0ighZ824VlymzNx2pLeb70kPmQi7KT6+Xw/JI0SJ5MyiiMPRFnPpSk+JwZKbh/27oZNkISQOqFb08lBZQ2Y1iEwZsq/nPAlvA5qLdLcyObmxURjI71XgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvsiSqOJY4Fp61xI4g+Pu+N+W1YBaubxLVmpsGR0QPs=;
 b=eBGAMuvhXT5AF55ImHKYiSKlT9aWegIxBwNjkixcYWByG7tURfHwOyy3ubJ7jTism+0Ruxx+28f6LlLu6ShKcJuuYNmK+AD67hlOPXiuWbI7f96wxrNI/lNK3An1OLwFztm+oGgJ4e+CnMExjyrhzoj4tuJu7fpS/wfpw2e5rbU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB7693.namprd10.prod.outlook.com (2603:10b6:510:2e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.31; Mon, 31 Mar
 2025 18:10:48 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 18:10:47 +0000
Message-ID: <a380c593-a2a4-40d2-8b2f-e3e1a2cdbe9e@oracle.com>
Date: Mon, 31 Mar 2025 23:40:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>, geert+renesas@glider.be,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com, devicetree@vger.kernel.org, john.madieu@gmail.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, sboyd@kernel.org,
        biju.das.jz@bp.renesas.com, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-4-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250330214945.185725-4-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a38364a-d378-4fc0-fdcd-08dd707f5c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0U1dGFoanZVbXNRQjBpbi9QREg4RHVWR0djTWM0a2VuSTVJdk5Ob3RZSHpC?=
 =?utf-8?B?cFBsOHpPc0gveFJGRzBZa3pkU1hrUHBLR1F1SWhjZWN4RnVlZGQzd3ZLYUJP?=
 =?utf-8?B?YTlDTW14STRSTWp3UFB3ZEx3TDZxS05uV0t4ZEVjWlRCMmYrYjI4N2pOU1Vx?=
 =?utf-8?B?Z2JrelNHL1N6RDZETTRlWnFQNHdadWROTzNMWEdOMjJBdTBjV0IyTVhORTRx?=
 =?utf-8?B?d1ZjWGFyUCtpbTNLRzNUNG9hY3E0SHZJcTZ5RDJ2RUJJc3EyQUd6WVZHb3Vw?=
 =?utf-8?B?Y05kZUpjWnFSQ0Nxbm9ObVFnSkRaSldYVmpvODhZdGpwRTJhZ1hKcUdQNVU3?=
 =?utf-8?B?ZlhmTGNISGJOa0pHSEFacTBqL21uZm1lbHpLYlpRRkFleWdQMlQzV0hwUUQx?=
 =?utf-8?B?NmQxMnJKbjMzQ0YrV0pYNXRPdFdqdyt3UjRMZC9CRm5LeFdkT3JreG5pZ1Ur?=
 =?utf-8?B?REZOQUNMcjZ0WlBYajNLa1NkWEM3MHI4bWgwenRnWHkxR1J4RGgxMjFmQ2tq?=
 =?utf-8?B?T3Azci9EWXEwcnFxRWlzTTlKRUp2bS9zMit5bkN6TFNPMDQ5K2hBSXhKb2RX?=
 =?utf-8?B?NlZZNDJ6WmJyUWFmOVY5cEY5My84MEpVTFpBTjkrdnUyVWl2dlZwbHluWWNI?=
 =?utf-8?B?d3VveEpKVWxvaUZqTzdaQlMzZHI4WTlJSHBXWHU4KzhESmtBMXZwLzJ5NlBH?=
 =?utf-8?B?ZHA0cUlYSEdkb2t3UmlaeGdLL3pPQ3huRThaMVJOTFRUM242ZGNFS3pnQTF0?=
 =?utf-8?B?MnJEbjlTekVPNU5hOUppQjlVOGkzQ3FuczlYV0laekpyTDU0d01hcmRDMmVG?=
 =?utf-8?B?TzBDOVJOYW1ER3JJZDVKbk5NSDlaTEl0d2Y2VHlwS2N0U01rL2xoU2E0SEU0?=
 =?utf-8?B?a3JSb1lPTTg2VTh4L1g5cWx1QldwYnVHVEV5bjNCZHRQc3hEM1BMVWJHKzFn?=
 =?utf-8?B?R1BmTGRJZVgzRXZjOGRFTmkvQWN5K3FYRnQ0Y0g1cnZQbmdYQU1MaVZLckZW?=
 =?utf-8?B?TkppOWNLQjhMR0hxQUo4MDZBUU9qT01oVUMvTkdZaHY4UmxPTGV1bFR1S2lm?=
 =?utf-8?B?SDg0TXY5cldxY2tNdWQwaU81K21LbmtIb0gzZlZNVCtYTkxkSloxQUNXcS9x?=
 =?utf-8?B?YlU2TFdpL1hsbW8xdXh1amZCNnBjV0w5U1IyRzBGeXMvSmFkOFNXSTRFZ0Yz?=
 =?utf-8?B?UzRNa3AzaWRNRW9sbkh1bTA3SXdRNjgyZXAySC9UK0dkbk5FbjljVGhkN2hn?=
 =?utf-8?B?RGVBM01Td0poaTlydWo4cHcyTzNLU0RqVkVrWWg1QkV4THh6YVYxcGpLbDdx?=
 =?utf-8?B?RllMS3IyQ0RzOGxCOGNPNExvYUVPV3lxQVVBdUhRZ0J4VVAyV21haU5UOHZ0?=
 =?utf-8?B?dWlDZm9iT0xjOHp2RXFOdU1tNG1FcGtVb2swbmZBSGw1cmNWOUhNZ0JTZXNu?=
 =?utf-8?B?Uk5jZzlEb0tJUXlBZlZQWk1DOGtQTEhET0dVNnRrdDR4U05uRXF1YVoreVFY?=
 =?utf-8?B?VmR5UVM4Z0VsUmNlUGg5d1VPQ0VvdEU0QU0rZWlpcDVpWXorNXJUak5XamZ2?=
 =?utf-8?B?bUViRlExVEJMSlhaT3Z1S0k3SzlYbDErNk1KUnBCVU13dzkvOWw5bVIyM1hl?=
 =?utf-8?B?RCt0VWVBTk41VEFYaWJBaHQvWHZpdHdyM05xNkFIUGsyWGdXUnFvWjNRdUtx?=
 =?utf-8?B?a0dBeEZqSCtWaWlPTllHUHJGUTNseC84ZFhDa09kMXVRS3R6ZkVUaHYxdjUy?=
 =?utf-8?B?SlNZRGZmTHBXVVdrT09icHIvTUd5MWR5VDhNd2xyT1l5VnNXeWdaaWVUdGlk?=
 =?utf-8?B?S2p6UHpQWGtRcU9wN3BreFhkdDF3bFR6V0ZqZWlkQ0QvSkQ0dVhmWnlBbTFk?=
 =?utf-8?Q?sdJbxw0fNtXnN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEQ4TzhRdk00TC9yMFhoQUJOTGxNdkFJVDBzTVJFUnBaWDhOb2JQUE1lSkpB?=
 =?utf-8?B?K0N6cFNwTFErczlVQStqM0dzTzE0ZzFNWEpDeUhnSVBxUVpXMkF3VEZENzlm?=
 =?utf-8?B?K2xZV1RFZTFsTjUzeWtFeHVHc0VLMjhtMkhkM2Q0bldnaFBiQnJSeG5sZUV1?=
 =?utf-8?B?d0k1ZWkremY3ZDRkL3cwQ3pORzA3WE5mWjhKcFlqZDgxekk0bTZHM0NVV1Zv?=
 =?utf-8?B?R1ZaR3E0ODAwUmhwY2txOVdRUGE5ZXpVbE5jcnRDMHV3TUltbk9lTE1aVFNI?=
 =?utf-8?B?SjVjcUJJZEcwaHdRVjQ5RW95K2JLYktrbzFqQ0J3bUlnd1l2YjRlNE5JWDc4?=
 =?utf-8?B?NzliMTJyTG0wczF1bEpGTUQ2RUFFMFV4bHcxS2VwWlhYQnk3RjRaVjNlU2hM?=
 =?utf-8?B?OGtzTW1XZldhai9xWXF5YWFVMUxTY0RhbWhjSU5vZHV6M1RGZVdDQ3UzR3ZC?=
 =?utf-8?B?SVZ2MnlyZzVyalBiaEtpdk9WWWR1OWlmMXd3V05DOEFYYlBwc3F6UTdVT1l3?=
 =?utf-8?B?NEVTTHhHeW12WkVNaUhFM2lqdGNvU3JDS2RZMVRKZnRrWndKelNtWTQ4MnNu?=
 =?utf-8?B?MExWZitDbXRQcGwvSHh5aVE5SzlKUVovTEhLSTEyaXJvMnZLNjBVQk1kVjFv?=
 =?utf-8?B?MENlanIvTk5XYkdRUDV0QVdlb0taUFF1RzRWcnBSZ3B1K21sb0hNRHliYVVm?=
 =?utf-8?B?Y0NNWVpLbkFNL1poOXE5dlRZWWtRdHZtZmJuMURMYWxNSzk1VWl6KzFLT2tU?=
 =?utf-8?B?YzFHaUxVdVNPbnBFN1JxS3pwTHBmeW4raTJteDBkaU9pRE4zMkxXcXNpYW40?=
 =?utf-8?B?ZExpM0NUZHRpUFM1SDhzMDhJL1htOXRKcnRldzIrUU90Nno1RXJ4UklDcTlF?=
 =?utf-8?B?aThwUDFzSTBiMHRYNWJkMnlVVzIvQjFkamI0UWkxMjR0MFpzNFFSVWJIVVky?=
 =?utf-8?B?Ky9MeGJvbUFHcTJiQlpJcmVqRWM2d2o2RUIwUVoyUTJ0Zkl4ZUtWMTV1a1Mw?=
 =?utf-8?B?Q0F1TjFHdmd4TmN3Uy9UOThFRHNyMktkZXpHN2J5VlVMS3RUbFR1V3owZ3p5?=
 =?utf-8?B?Y1Fyb3U5dGdLdzNNRWM3OHBRemtwNG8yU0lrTHVxTW1RY0xaNlU0bXRCWloy?=
 =?utf-8?B?ZElnUHNNc3A4dDM5cm9XZUdUa3pEQTIwY1pBUjdsNldqRlFsQUtPQXMvUkx0?=
 =?utf-8?B?K2ZkelZrVmNOQ3RCVHZSUk9QK2tSQ0kzNjQ2cVN1bm12RWRobVRKOWl6RmF0?=
 =?utf-8?B?Qmh6MXkwbVdZejZxdHowd2ppdnk0OHpXeTNkTGVTckZXcHlwL01JeHhseGg0?=
 =?utf-8?B?c0ZVczBDRmlrbW9PTi9aRTZOZ0xwM0w5QUtGQ2xSVHR0K2lYNGhsdFEwNzZK?=
 =?utf-8?B?eldUQVVBdjlkR0pveHBycXhpQk9LR3IwL1VpZTFoUkQwWlV4UmI1cVVKVEpw?=
 =?utf-8?B?V1R0TE90L2o0QVp0SWhpenNSZzlGVUM0ZjFnNEIvNjhiZWdwd2piM3pBSXVX?=
 =?utf-8?B?SkpSM1hJbS9TN0xydHo2dm5qMVkxNnpHc0VhSDNUNUVLZ0psb1BaQTdUS2p2?=
 =?utf-8?B?Sit0L2s3WEVnbHQ4ay92b1ZsOVRBYlBwdkM3T2huaTUvdVUxcXZuN2FINnE0?=
 =?utf-8?B?ZlRaUkdUZWtrOWg1WWRITGYwSFRvNnFCQlJKTVZCT3RBVjA3aXdYZk9SZlFK?=
 =?utf-8?B?d3pHeDlFQ1Y0RWFFQU1lZVkwVGtxbnBOamhTUW1FY1Z3SjNWVE05dnJ5UEtp?=
 =?utf-8?B?R0tSQlZVOVVjbHJTbWdzSFNxMy9nclFhdlIxOWV4cnhQamFpdVUvdjZMR0lj?=
 =?utf-8?B?YU5BcUNOSS90MExSSERDUlZ6cW13VjRZRG4rZFd6dTgrc2VNakI1bUtSWllE?=
 =?utf-8?B?TDlaUEtOMUpMOG4wR3V1aklXd0hQSDJwbjZId2ExVmp0cEVXNDZRQ0lieTEx?=
 =?utf-8?B?MTI4MkZpVlpKUVZZRkJEVy9zWkVrOHJQZlJ1bWtUNE9mVk84TSs4M1VYYVl0?=
 =?utf-8?B?REk3SVl6T3htRlNETUUvRUErbUl5cjN3b2llZlVwR2xzYW9CNHBHTUhzVFFk?=
 =?utf-8?B?Sk16dWNSeXRZbFhwNmNtdmxNdmNyaUsyZmYrdEhseFNGMkdDN2dVOHVKR1Fy?=
 =?utf-8?B?Sy91MWZGUkttV0g3blh6VUlrMVZxd1JxdktKa2JibkRjNlJ2cFhkMEkyd2w1?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gWP91AYGBfWsyIOK6nzxgwJ8AugVHCxFTqADVkavn6YCig5VR6bjB80G7dN0dRZn7OKUBQpjFvPqqbRr2bVOheyNbPexxzSEUDnNy5EXm/yu2MWAKr+Iqrh6XlASF+Bv8VdFcNQNQcX469GuwtpWqL/yTUYfEuAP0dR7pIn2LGKujyf/qfy4T4sbbSWLwMuLlmbWCiNq9I5Fd23GiYOwtKL09SH76DvINVMeSh4VCedDW3ULtYG8Rtu4CqQhkDIUxLIX8WbvrLoWUJKg+RhmBLWNXtCONZlCoewpglcofdsLdttVwGWh/M1LiXz18z7zHCMfr1kThEf4gBmeAIVf9+epJ82HO/CGbcTKYEZJ6uQAOoShwk4ejeQy8p2XcLc/d5EgPQtOWZWjpFuOiqs2vB1/PAWFgTYCNDpx7A19X3dyqfJ7xAzcl8kg4BtWvZ2cIr42ZkkJ/py7PnqZKZ+phDDLVkD8SaUNi1Oei2GuGod6X+3Rj3BnlW0hz9p+/21iT/Kr1IHL9Jxpem85tf6N+WZklc9/wLD4lzCHmOPWmURs5lpnkb9GMAb2PWNdT2JK4giG4P+UwwPBFpTgIT3gfWuCWGeOSbnZUGuLdJr6kqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a38364a-d378-4fc0-fdcd-08dd707f5c55
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 18:10:47.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5SPwXCbpqNTg5fYfSLVd1lVMH6s81lCGSthFnt7p71vI3jcfTxXjUb8ZJ7MTxDP8aNabfLMM3BBbmtAcssZojEeY/Y/Cd8JjUvjFZEvNRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_08,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503310128
X-Proofpoint-GUID: Rcf75qywPz4pSLpH1QwpK0BGc6Q56pQL
X-Proofpoint-ORIG-GUID: Rcf75qywPz4pSLpH1QwpK0BGc6Q56pQL



On 31-03-2025 03:19, John Madieu wrote:
> The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block designed
> to monitor the chip's junction temperature. This sensor is connected to
> channel 1 of the APB port clock/reset and provides temperature measurements.
> 
> It also requires calibration values stored in the system controller registers
> for accurate temperature measurement. Add a driver for the Renesas RZ/G3E TSU.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> v1 -> v2: fixes IRQ names
> v2 -> v3: no changes
> v3 -> v4: no changes
> v5: removes curly braces arround single-line protected scoped guards
> 
>   MAINTAINERS                             |   7 +
>   drivers/thermal/renesas/Kconfig         |   7 +
>   drivers/thermal/renesas/Makefile        |   1 +
>   drivers/thermal/renesas/rzg3e_thermal.c | 443 ++++++++++++++++++++++++
>   4 files changed, 458 insertions(+)
>   create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9f7d2115b57..ba7c95146f01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20289,6 +20289,13 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
>   F:	drivers/iio/potentiometer/x9250.c
>   
> +RENESAS RZ/G3E THERMAL SENSOR UNIT DRIVER
> +M:	John Madieu <john.madieu.xa@bp.renesas.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> +F:	drivers/thermal/renesas/rzg3e_thermal.c
> +
>   RESET CONTROLLER FRAMEWORK
>   M:	Philipp Zabel <p.zabel@pengutronix.de>
>   S:	Maintained
> diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
> index dcf5fc5ae08e..10cf90fc4bfa 100644
> --- a/drivers/thermal/renesas/Kconfig
> +++ b/drivers/thermal/renesas/Kconfig
> @@ -26,3 +26,10 @@ config RZG2L_THERMAL
>   	help
>   	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
>   	  thermal framework.
> +
> +config RZG3E_THERMAL
> +	tristate "Renesas RZ/G3E thermal driver"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	help
> +	  Enable this to plug the RZ/G3E thermal sensor driver into the Linux
> +	  thermal framework.
> diff --git a/drivers/thermal/renesas/Makefile b/drivers/thermal/renesas/Makefile
> index bf9cb3cb94d6..5a3eba0dedd0 100644
> --- a/drivers/thermal/renesas/Makefile
> +++ b/drivers/thermal/renesas/Makefile
> @@ -3,3 +3,4 @@
>   obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
>   obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
>   obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
> +obj-$(CONFIG_RZG3E_THERMAL)	+= rzg3e_thermal.o
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
> new file mode 100644
> index 000000000000..fe50df057b74
> --- /dev/null
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -0,0 +1,443 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G3E TSU Temperature Sensor Unit
> + *
> + * Copyright (C) 2025 Renesas Electronics Corporation
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>
> +#include <linux/units.h>
> +
> +#include "../thermal_hwmon.h"
> +
> +/* SYS Trimming register offsets macro */
> +#define SYS_TSU_TRMVAL(x) (0x330 + (x) * 4)
> +
> +/* TSU Register offsets and bits */
> +#define TSU_SSUSR		0x00
> +#define TSU_SSUSR_EN_TS		BIT(0)
> +#define TSU_SSUSR_ADC_PD_TS	BIT(1)
> +#define TSU_SSUSR_SOC_TS_EN	BIT(2)
> +
> +#define TSU_STRGR		0x04
> +#define TSU_STRGR_ADST		BIT(0)
> +
> +#define TSU_SOSR1		0x08
> +#define TSU_SOSR1_ADCT_8	0x03
> +#define TSU_SOSR1_OUTSEL_AVERAGE	BIT(9)
> +
> +/* Sensor Code Read Register */
> +#define TSU_SCRR		0x10
> +#define TSU_SCRR_OUT12BIT_TS	GENMASK(11, 0)
> +
> +/* Sensor Status Register */
> +#define TSU_SSR			0x14
> +#define TSU_SSR_CONV_RUNNING	BIT(0)
> +
> +/* Compare Mode Setting Register */
> +#define TSU_CMSR		0x18
> +#define TSU_CMSR_CMPEN		BIT(0)
> +#define TSU_CMSR_CMPCOND	BIT(1)
> +
> +/* Lower Limit Setting Register */
> +#define TSU_LLSR		0x1C
> +#define TSU_LLSR_LIM		GENMASK(11, 0)
> +
> +/* Upper Limit Setting Register */
> +#define TSU_ULSR		0x20
> +#define TSU_ULSR_ULIM		GENMASK(11, 0)
> +
> +/* Interrupt Status Register */
> +#define TSU_SISR		0x30
> +#define TSU_SISR_ADF		BIT(0)
> +#define TSU_SISR_CMPF		BIT(1)
> +
> +/* Interrupt Enable Register */
> +#define TSU_SIER		0x34
> +#define TSU_SIER_ADIE		BIT(0)
> +#define TSU_SIER_CMPIE		BIT(1)
> +
> +/* Interrupt Clear Register */
> +#define TSU_SICR		0x38
> +#define TSU_SICR_ADCLR		BIT(0)
> +#define TSU_SICR_CMPCLR		BIT(1)
> +
> +/* Temperature calculation constants */
> +#define TSU_D		41
> +#define TSU_E		126
> +#define TSU_TRMVAL_MASK	GENMASK(11, 0)
> +
> +#define TSU_POLL_DELAY_US	50
> +#define TSU_TIMEOUT_US		10000
> +#define TSU_MIN_CLOCK_RATE	24000000
> +
> +/**
> + * struct rzg3e_thermal_priv - RZ/G3E thermal private data structure
> + * @base: TSU base address
> + * @dev: device pointer
> + * @syscon: regmap for calibration values
> + * @zone: thermal zone pointer
> + * @mode: current tzd mode
> + * @conv_complete: ADC conversion completion
> + * @reg_lock: protect shared register access
> + * @cached_temp: last computed temperature (milliCelsius)
> + * @trmval: trim (calibration) values
> + */
> +struct rzg3e_thermal_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct regmap *syscon;
> +	struct thermal_zone_device *zone;
> +	enum thermal_device_mode mode;
> +	struct completion conv_complete;
> +	spinlock_t reg_lock;
> +	int cached_temp;
> +	u32 trmval[2];
> +};
> +
> +static void rzg3e_thermal_hw_disable(struct rzg3e_thermal_priv *priv)
> +{
> +	/* Disable all interrupts first */
> +	writel(0, priv->base + TSU_SIER);
> +	/* Clear any pending interrupts */
> +	writel(TSU_SICR_ADCLR | TSU_SICR_CMPCLR, priv->base + TSU_SICR);
> +	/* Put device in power down */
> +	writel(TSU_SSUSR_ADC_PD_TS, priv->base + TSU_SSUSR);
> +}
> +
> +static void rzg3e_thermal_hw_enable(struct rzg3e_thermal_priv *priv)
> +{
> +	/* First clear any pending status */
> +	writel(TSU_SICR_ADCLR | TSU_SICR_CMPCLR, priv->base + TSU_SICR);
> +	/* Disable all interrupts */
> +	writel(0, priv->base + TSU_SIER);
> +
> +	/* Enable thermal sensor */
> +	writel(TSU_SSUSR_SOC_TS_EN | TSU_SSUSR_EN_TS, priv->base + TSU_SSUSR);
> +	/* Setup for averaging mode with 8 samples */
> +	writel(TSU_SOSR1_OUTSEL_AVERAGE | TSU_SOSR1_ADCT_8, priv->base + TSU_SOSR1);
> +}
> +
> +static irqreturn_t rzg3e_thermal_cmp_irq(int irq, void *dev_id)
> +{
> +	struct rzg3e_thermal_priv *priv = dev_id;
> +	u32 status;
> +
> +	status = readl(priv->base + TSU_SISR);
> +	if (!(status & TSU_SISR_CMPF))
> +		return IRQ_NONE;
> +
> +	/* Clear the comparison interrupt flag */
> +	writel(TSU_SICR_CMPCLR, priv->base + TSU_SICR);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t rzg3e_thermal_cmp_threaded_irq(int irq, void *dev_id)
> +{
> +	struct rzg3e_thermal_priv *priv = dev_id;
> +
> +	thermal_zone_device_update(priv->zone, THERMAL_EVENT_UNSPECIFIED);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rzg3e_thermal_adc_irq(int irq, void *dev_id)
> +{
> +	struct rzg3e_thermal_priv *priv = dev_id;
> +	u32 status;
> +	u32 result;
> +
> +	/* Check if this is our interrupt */
> +	status = readl(priv->base + TSU_SISR);
> +	if (!(status & TSU_SISR_ADF))
> +		return IRQ_NONE;
> +
> +	/* Disable ADC interrupt */
> +	writel(0, priv->base + TSU_SIER);
what is difference b/w /* Disable all interrupts * / used in 
thermal_hw_enabl and Disable ADC interrupt ? The same comment can be 
used for better readability.
> +	/* Clear conversion complete interrupt */
> +	writel(TSU_SICR_ADCLR, priv->base + TSU_SICR);
> +
> +	/* Read ADC conversion result */
> +	result = readl(priv->base + TSU_SCRR) & TSU_SCRR_OUT12BIT_TS;
> +
> +	/*
> +	 * Calculate temperature using compensation formula
> +	 * Section 7.11.7.8 (Temperature Compensation Calculation)
> +	 *
> +	 * T(°C) = ((e - d) / (c -b)) * (a - b) + d
> +	 *
> +	 * a = 12 bits temperature code read from the sensor
> +	 * b = SYS trmval[0]
> +	 * c = SYS trmval[1]
> +	 * d = -41
> +	 * e = 126
> +	 */
> +	s64 temp_val = div_s64(((TSU_E + TSU_D) * (s64)(result - priv->trmval[0])),
> +				priv->trmval[1] - priv->trmval[0]) - TSU_D;
> +	int new_temp = temp_val * MILLIDEGREE_PER_DEGREE;
> +
> +	scoped_guard(spinlock_irqsave, &priv->reg_lock)
> +		priv->cached_temp = new_temp;
> +
> +	complete(&priv->conv_complete);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rzg3e_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
> +{
> +	struct rzg3e_thermal_priv *priv = thermal_zone_device_priv(zone);
> +	u32 val;
> +	int ret;
> +
> +	if (priv->mode == THERMAL_DEVICE_DISABLED)
> +		return -EBUSY;
> +
> +	reinit_completion(&priv->conv_complete);
> +
> +	/* Enable ADC interrupt */
> +	writel(TSU_SIER_ADIE, priv->base + TSU_SIER);
> +
> +	/* Verify no ongoing conversion */
> +	ret = readl_poll_timeout_atomic(priv->base + TSU_SSR, val,
> +					!(val & TSU_SSR_CONV_RUNNING),
> +					TSU_POLL_DELAY_US, TSU_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(priv->dev, "ADC conversion timed out\n");
> +		return ret;
> +	}
> +
> +	/* Start conversion */
> +	writel(TSU_STRGR_ADST, priv->base + TSU_STRGR);
> +
> +	if (!wait_for_completion_timeout(&priv->conv_complete,
> +					 msecs_to_jiffies(100))) {
> +		dev_err(priv->dev, "ADC conversion completion timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	scoped_guard(spinlock_irqsave, &priv->reg_lock)
> +		*temp = priv->cached_temp;
> +
> +	return 0;
> +}
> +
> +/* Convert temperature in milliCelsius to raw sensor code */
> +static int rzg3e_temp_to_raw(struct rzg3e_thermal_priv *priv, int temp_mc)
> +{
> +	s64 raw = div_s64(((temp_mc / 1000) - TSU_D) *
> +			  (priv->trmval[1] - priv->trmval[0]),
> +			  (TSU_E - TSU_D));
> +	return clamp_val(raw, 0, 0xFFF);
> +}
> +
> +static int rzg3e_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
> +{
> +	struct rzg3e_thermal_priv *priv = thermal_zone_device_priv(tz);
> +	int ret;
> +	int val;
> +
> +	if (low >= high)
> +		return -EINVAL;
> +
> +	if (priv->mode == THERMAL_DEVICE_DISABLED)
> +		return -EBUSY;
> +
> +	/* Set up comparison interrupt */
> +	writel(0, priv->base + TSU_SIER);
> +	writel(TSU_SICR_ADCLR | TSU_SICR_CMPCLR, priv->base + TSU_SICR);
> +
> +	/* Set thresholds */
> +	writel(rzg3e_temp_to_raw(priv, low), priv->base + TSU_LLSR);
> +	writel(rzg3e_temp_to_raw(priv, high), priv->base + TSU_ULSR);
> +
> +	/* Configure comparison:
> +	 * - Enable comparison function (CMPEN = 1)
> +	 * - Set comparison condition (CMPCOND = 0 for out of range)
> +	 */
> +	writel(TSU_CMSR_CMPEN, priv->base + TSU_CMSR);
> +
> +	/* Enable comparison irq */
> +	writel(TSU_SIER_CMPIE, priv->base + TSU_SIER);
> +
> +	/* Verify no ongoing conversion */
> +	ret = readl_poll_timeout_atomic(priv->base + TSU_SSR, val,
> +					!(val & TSU_SSR_CONV_RUNNING),
> +					TSU_POLL_DELAY_US, TSU_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(priv->dev, "ADC conversion timed out\n");
> +		return ret;
> +	}
> +
> +	/* Start a conversion to trigger comparison */
> +	writel(TSU_STRGR_ADST, priv->base + TSU_STRGR);
> +
> +	return 0;
> +}
> +
> +static int rzg3e_thermal_get_trimming(struct rzg3e_thermal_priv *priv)
> +{
> +	int ret;
> +
> +	ret = regmap_read(priv->syscon, SYS_TSU_TRMVAL(0), &priv->trmval[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->syscon, SYS_TSU_TRMVAL(1), &priv->trmval[1]);
> +	if (ret)
> +		return ret;
> +
> +	priv->trmval[0] &= TSU_TRMVAL_MASK;
> +	priv->trmval[1] &= TSU_TRMVAL_MASK;
> +
> +	if (!priv->trmval[0] || !priv->trmval[1])
> +		return dev_err_probe(priv->dev, -EINVAL, "invalid trimming values");
> +
> +	return 0;
> +}
> +
> +static int rzg3e_thermal_change_mode(struct thermal_zone_device *tz,
> +				     enum thermal_device_mode mode)
> +{
> +	struct rzg3e_thermal_priv *priv = thermal_zone_device_priv(tz);
> +
> +	if (mode == THERMAL_DEVICE_DISABLED)
> +		rzg3e_thermal_hw_disable(priv);
> +	else
> +		rzg3e_thermal_hw_enable(priv);
> +
> +	priv->mode = mode;
> +	return 0;
> +}
> +
always return 0 here ? what, if (!priv) return -EINVAL; ?

> +static const struct thermal_zone_device_ops rzg3e_tz_ops = {
> +	.get_temp = rzg3e_thermal_get_temp,
> +	.set_trips = rzg3e_thermal_set_trips,
> +	.change_mode = rzg3e_thermal_change_mode,
> +};
other renesas driver defined as rzg2l_tz_of_ops, can be used similar one 
rzg3e_tz_of_ops for consistency!
> +
> +static int rzg3e_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rzg3e_thermal_priv *priv;
> +	struct reset_control *rstc;
> +	char *adc_name, *cmp_name;
> +	int adc_irq, cmp_irq;
> +	struct clk *clk;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return dev_err_probe(dev, PTR_ERR(priv->base),
> +				"Failed to map I/O memory");
> +
> +	priv->syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						       "renesas,tsu-calibration-sys");
> +	if (IS_ERR(priv->syscon))
> +		return dev_err_probe(dev, PTR_ERR(priv->syscon),
> +				"Failed to get calibration syscon");
> +
> +	adc_irq = platform_get_irq_byname(pdev, "adi");
> +	if (adc_irq < 0)
> +		return adc_irq;
> +
> +	cmp_irq = platform_get_irq_byname(pdev, "adcmpi");
> +	if (cmp_irq < 0)
> +		return cmp_irq;
> +
> +	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc),
> +				     "Failed to acquire deasserted reset");
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	spin_lock_init(&priv->reg_lock);
> +	init_completion(&priv->conv_complete);
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Failed to get and enable clock");
> +
> +	if (clk_get_rate(clk) < TSU_MIN_CLOCK_RATE)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Clock rate too low (minimum %d Hz required)",
> +				     TSU_MIN_CLOCK_RATE);
> +
> +	ret = rzg3e_thermal_get_trimming(priv);
> +	if (ret)
> +		return ret;
> +
> +	adc_name = devm_kasprintf(dev, GFP_KERNEL, "%s-adc", dev_name(dev));
> +	if (!adc_name)
> +		return -ENOMEM;
> +
> +	cmp_name = devm_kasprintf(dev, GFP_KERNEL, "%s-cmp", dev_name(dev));
> +	if (!cmp_name)
> +		return -ENOMEM;
> +
> +	/* Unit in a known disabled mode */
> +	rzg3e_thermal_hw_disable(priv);
> +
> +	ret = devm_request_irq(dev, adc_irq, rzg3e_thermal_adc_irq,
> +			       IRQF_TRIGGER_RISING, adc_name, priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request ADC IRQ");
> +
> +	ret = devm_request_threaded_irq(dev, cmp_irq, rzg3e_thermal_cmp_irq,
> +					rzg3e_thermal_cmp_threaded_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					cmp_name, priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request comparison IRQ");
> +
> +	/* Register Thermal Zone */
> +	priv->zone = devm_thermal_of_zone_register(dev, 0, priv, &rzg3e_tz_ops);
> +	if (IS_ERR(priv->zone))
> +		return dev_err_probe(dev, PTR_ERR(priv->zone),
> +				"Failed to register thermal zone");
> +
> +	ret = devm_thermal_add_hwmon_sysfs(dev, priv->zone);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add hwmon sysfs");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rzg3e_thermal_dt_ids[] = {
> +	{ .compatible = "renesas,r9a09g047-tsu" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg3e_thermal_dt_ids);
> +
> +static struct platform_driver rzg3e_thermal_driver = {
> +	.driver = {
> +		.name	= "rzg3e_thermal",
> +		.of_match_table = rzg3e_thermal_dt_ids,
> +	},
> +	.probe = rzg3e_thermal_probe,
> +};
> +module_platform_driver(rzg3e_thermal_driver);
> +
> +MODULE_DESCRIPTION("Renesas RZ/G3E TSU Thermal Sensor Driver");
> +MODULE_AUTHOR("John Madieu <john.madieu.xa@bp.renesas.com>");
> +MODULE_LICENSE("GPL");


Thanks,
Alok

