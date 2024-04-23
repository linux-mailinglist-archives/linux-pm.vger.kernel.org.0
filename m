Return-Path: <linux-pm+bounces-6877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6730B8ADC5B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 05:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12016283936
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 03:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D80B18E1D;
	Tue, 23 Apr 2024 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEo1Th1i"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703915E89
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843735; cv=fail; b=BRyVbOrPvLE6C4uPwDIO+4f+1SrXT1d4hBVYSD2BebqQZtOG1lz8pcI7pIwB8mb4qiD/VtDY1go0uttT5pHDgSOWu/gcuAPxZWjl06vc8SjhSv83p8kyZCVpQpGF9AyYkp4Wr69PfvgWoMMlFftxFm9f+KzDji+6af/QOPJNIbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843735; c=relaxed/simple;
	bh=3XVz0ztvurikUf7/alq2FCdYZnmICYnx4FQEzywcCYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ce1BnHrYrfUNaYD9Yo25wLESEH9j7O+R6/Zq9fk4o0JWh1MBZms8L+q10NMmzTrR9ZZJQjlOEl8PV4ZG6nYj+BitLiQyELw+ScKU6Jb3eGrwlkwzg9kMY7Aj03Qmw49vQquWeSodDl8MLQTjXVz8tVB3Hu150PK9i4r5y8JJVBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEo1Th1i; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMmqczDMc76E43ovlGV2WDTmj1i/qUMezjmPYUPnCkmcA1EwDguf2vsAYmi0GnBzuASFhjo4LfPUl262MmepbyvLQh0TZvMoINH3ocN/OD0oYOzZaIEus2DXdRVj+ra9PCq1bkhgYIK9btr3B0TiHGD1D/SnElKwT7PuKfspO7g6VyPDTlTNCaDuQeHiJDbKM9dope70KNuFc1hmJ0H+s8W6pVPiCdde0Ehn5oWVGTHlnjRfNjNZjPq4c4Ho5hCL2k3AiXsBI5z8huzFKVkCYvTNd64eXSahqgxRRPNXRpIajsifvREfJO9Z1cOlVguGDPW06iZq7uDlRj4qokpnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdH8V301xRBkUmeHUaA4Iv7yuD3dcUh4IzfQ72mrUYY=;
 b=LBJFeraDjr1W+WE12sk2zVBbnevdSmP6DkzQ7CQXY/djtWFlDnqHyUpVChWcf5WQEiC1sXE4n4sfmuFSOUI4AgDJnLuJRfiLxUUEk3MSQGw67YvdQGXNleJhG2tuC8EB1XcbG4Q7POL0jSHRK9/J1AcauHV/cXpdCNW4lFabrxHRm+LHhLLrAgtOI3jDuDy5W6i4nAcEe5kkqZv3rtKpOjsaZFkS1YYgZPrNynKsNTOlWiMJQiFe5EpWAvGaO1EB7mERtDjJ0ir6mYsukon/ft4WT5w5TSOLkS901T7z2ZxML/ifiVoLYKoL/iwUACQK2B+pUmUlad/UTdqd+N/Fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdH8V301xRBkUmeHUaA4Iv7yuD3dcUh4IzfQ72mrUYY=;
 b=CEo1Th1ic3/EHfRcINbE+88wRQHqhEEmIR6+mZBqKU4iZn4lAxKBMG7PjK6B7hWQiscZUmrR1O4k8/smYXv1th6PhZQg+O2s6Z0Wrzojnc8zc8oeT1L7qnQE7fLEnUbMmZHupfla9eRDjx5W6MwnYA11E1MdVhOvrWBfajr3Sak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:42:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 03:42:10 +0000
Message-ID: <5250ce9b-c2d4-4b68-98f6-02b017f29cf2@amd.com>
Date: Mon, 22 Apr 2024 22:42:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: xiongxin <xiongxin@kylinos.cn>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
 <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
 <2888cd41-65d9-4832-a913-399a074de7a9@amd.com>
 <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
 <7b739eb8-573e-4479-9225-be3d2f4adbff@amd.com>
 <CAJZ5v0itOXsVCvU0kXgZA8v6OX5yy=RZn1d9FTe-fo1tqVy90w@mail.gmail.com>
 <cf3a8d4c-846e-4d7c-ba6e-b774dff420d8@amd.com>
 <CAJZ5v0jp2ici368ebaHyBjhdsEPbgkdNg4FLCfS6kAfNZjd7mA@mail.gmail.com>
 <4cf0d1cb-34df-4be3-926a-8fc645ff8f17@kylinos.cn>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4cf0d1cb-34df-4be3-926a-8fc645ff8f17@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:5:177::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: c95521fe-7719-48ad-20bf-08dc63475b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0gwdGlQeTBiaG5UZGpSc09tZEJzbnRmenlaeU9mZEtMaG0rLzhjbVBpQkRC?=
 =?utf-8?B?UXVocndIc0twOEpJdVE2bzBleE5EQ21zYjZXdWRaNXJ1ZU4wMlE0cTdWVUc1?=
 =?utf-8?B?Y2ZmVGw3QmFCYm5sanMzTHVnaktUT0hZVVVQS2Q2QnhMeU5vWUVKZ2JONHor?=
 =?utf-8?B?V2g5QVB0cFRaZnhiZjdvNVNKRE9VYkt4Q1pzZnBPdEljOXkvaEF5Rktid0lZ?=
 =?utf-8?B?bEthVlJSVFZvalV5dHBONlV0UHVHbkNRWmR2ajc4TkFVdFNvWi9JMklIcVZX?=
 =?utf-8?B?OGsvYnZhMWdpeVovdVhVcnFldVpPY1I5YTFDbnJhQnNpRmI1eHpKSnlGd0lt?=
 =?utf-8?B?cnpEMmUvQ0g3WFB0UGxuMTRiVVVVLzJZekQ3eUVaanJTK0loMnRXdjRub2ti?=
 =?utf-8?B?dnl4andhZmVMK0ZKMW9tNlVNTWtKcDJvemhUdlNSUzZlb1g2U2szRHlIcGNu?=
 =?utf-8?B?U0Z4bE5RNVB0TjJSckNjQ3pLSzZGWDBFOVF2T3pDV0JGM2JSTG9lZlhrVFJV?=
 =?utf-8?B?QVN3T0Q0enJ5Mm1sK1pSOXpic3pFcUJZSHpnRXlXanlYbkViN2d3SXVoRWU4?=
 =?utf-8?B?TnZ3aDN6d0Y5eFV0MjcyK2ZyeFhHd1U1Q0NUOXZUM08veVo3ZDcvR1JJeTNN?=
 =?utf-8?B?UEtoam5kT0lMc0s3YzVyZ0ZpU0o5KzhVZGJMU1BDKzlpRXdvdDM1anhTMHQv?=
 =?utf-8?B?SmV3ZFBxdVBqcmY1UlVkdHAvc1g4RE1MZXZIbGJZQmliWHVBMTA3ZTA5enBj?=
 =?utf-8?B?S21pRzRKOFFhVm1rZWdSMFEzTC9ZY2R3YngxbGpMY1dqK3FiTlJoNUYxT1N0?=
 =?utf-8?B?Y0RpOVlPR0pZeEREaWc3VzNWVHV3ZFNsNWtLbUpJMFZqSG9TTnFYMmVwamFp?=
 =?utf-8?B?NWoyUHM2RXRjODZHRWpRTVRkaWdYV0dEaXV1ZGhra1M5Y3dWdVkzVnRjWWFK?=
 =?utf-8?B?WFNWa0F6bDZZR0ROZEI3Zlo4d0dyaDBhL3NiMDlaSzYyMmJkd1ROZy93OEZh?=
 =?utf-8?B?bFliZmJmbld6c1djTXEwMGJKaEpoemJlaFlIbDN2L0k4L2ZVM201emgwWEtU?=
 =?utf-8?B?T0haLzJZNUtkSFFXTjNtc2ZOQ20vRlRlbi9qQ3BSOVV1ZGtja3Baa0ZCbzJH?=
 =?utf-8?B?QXo3WnhoWjRYSTczbmxtSVFXL0szTjl4VWpJSXdTY1M4NG9OUlZNVkxhY2FB?=
 =?utf-8?B?L1Q3R3JSaEpXeDZaWGlnTm4zcFlsUWZUeEEyb2xBa25NMjFKVXRnL2plTThj?=
 =?utf-8?B?QmpKRnZkZnRjeUl5TXFYS0tMZDVxQ1F6T0VJWGVibzFVZC96SXhWdzdSakgz?=
 =?utf-8?B?RXcyam5PK2NhaFNTN1BabFRUM1lqVldldVVTZWhlV2VNN1IzSCtaQ0ttZ05U?=
 =?utf-8?B?b29GUVd0bFBYTlNMWFhrVUMyQ1hKTmRGcVFEZDZWc3RmclZaYTZJWHhpTUFr?=
 =?utf-8?B?c0gzWU9JUXQ3MTRtYlp6cWl5b1Zva2daMGJJZGdsc2JlUXh5Z3lWeXg2VVlK?=
 =?utf-8?B?T3A1NEtub1BhenpiMm5CMFA1UjNITUdKaTFyNDZjOFQvQU1EUkN5VUN6S0Jo?=
 =?utf-8?B?dGo1RVlZTEVUNFkrWmlxOFUxSnEzSm9mRDFxQUJkbjc4VXZ4djR3TURRM1Nt?=
 =?utf-8?B?ekU2ckpuSk50R0Q2ZHNUWDFTN1RYdy9LeXJIZlpWU1A0cFBTV21MV3BVeGVX?=
 =?utf-8?B?VktSQUYxbmEwekNRNmlMZUpWektLNzF0TSt2MDRjOGRYNURQbjFRUE5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2xiTGg5TVZrM1BTbWNmbVhuRUZLYXlHRytyUCtDbFVhaUQ2OTdpaHc4dWYx?=
 =?utf-8?B?TGZNdEZjc2puaEV5aExzZytiUEdhSHhqMXpFZUxlM0pSY2RpL3ljdGhVdUJS?=
 =?utf-8?B?YUhHR2g4L2JLY3FiWDdLTjl6cDI5ZkNmY2lHRkM3QXBsK3BYU3B0d2hIOU9l?=
 =?utf-8?B?djc0amNtQXFZNi83b1ByUTJIU3UzMFlOMkVBMUl6MXNVa05Rd2t1ZmxlbExY?=
 =?utf-8?B?K3J2SWN3dmk4cUhTeUVsTlhmcXJta1lmV3BRNWRLcldid0NuT1VDOHdLRFhT?=
 =?utf-8?B?M0dGWm1pNHcrUUtwMzJzZE1BSHB5VS9QUm1OczN2VzJOT2VGOTBEWnRGV3ow?=
 =?utf-8?B?YTlpTHMrT0p1RFBNd1RlNjJjcVJobFhLN012eVhqeVI3SExIRmt1MXpnZHl2?=
 =?utf-8?B?OHpUdktJanhuaGFNZE9EV1BkZTlySit1L2pDakwxRUllYWo2WU8wYzR5WWV3?=
 =?utf-8?B?YnU0bmlXTmNZTHYrb3MvTEowL3Zzd08zS2lIRjBJUk9tOVpVa3lMZWYvaHlq?=
 =?utf-8?B?UGtzMnRXSjRwVVFaMmpJdCtTbFRVS3hjQnlXQ0hNZ2ZDb0lFSElwaGhaNmRT?=
 =?utf-8?B?bDJMSFZSbGZTRUNpZ29OeVNnZFBHZVJTdys5NGRnNzRVTmJoNG5lWVl6dHY5?=
 =?utf-8?B?cDJjU2g0Wk51cDFXMHVrV015SmNnVGw5SVFQdnUrb2hBNEQycUhGZzZFa3Nj?=
 =?utf-8?B?d2QzWjhMWkRqU0xvc2V3Z0JTSzdVNEJnVlpGbnBOSDUyb0dPQkZaNlltZG1i?=
 =?utf-8?B?T2FBOGFJWVRuSHBYV3p2RzVPOUhMVzV1R01VUEx0L2FqTUN4QUlWaTdIMkpq?=
 =?utf-8?B?dXJmaTkyaHpmb0QzbngrczJyK2ZnTjQxbTAxTHh0TzJNeVFyWjV2QmIzM0Rl?=
 =?utf-8?B?OXRKaTdMdGtWTHhFOGlyVjFKL2tlQkNDeGM0aG5WS1ozdXNBOUhZSk9HcVQz?=
 =?utf-8?B?RWg0MVFkTFR6aEhWWFNkdzhnbW96K0RHSFdQNk9YcDVqVlJDVFlxWWN3Q1Az?=
 =?utf-8?B?R3lWODQwTnBFWmRyNjNNaklTaDRIOFZxMWlkd2dmeXJmWXlJNHRrZW52SkJP?=
 =?utf-8?B?Nll0dWFRTmFBSS9LY1J4RHB0cU5RaER3a0didkQyZ2MrTjRuMUdodWczRXB2?=
 =?utf-8?B?VjY2aGJ1TjNDZ3JKVmtWRDRaRGU2QVB4eDNrUXhPNjl6OUJydjMrSjNzMy9B?=
 =?utf-8?B?cFkwZGx3bVZvZzdpdXE0WUZRbHkzbEFHSnpKaWd5a2Z0UjJUR0tYd0JvZzNX?=
 =?utf-8?B?dGFCWHU4OFNyWDhIY1dNSkkwUDZzSmEzS1ZkMFRZQzNzUU1QYVdJMGR0VWNM?=
 =?utf-8?B?cytTcEFlaGVTSWQwNzNDZzdhcG5QV2hIRkZPdFg2QUExblFhV25pYjduSGdE?=
 =?utf-8?B?SG9sWmZWY0lZakhsZDlqVEtWOHowaDBlbnQydS83ZVJKMWIrd3FUcUd3cXhN?=
 =?utf-8?B?Tm1ZREU4ZHh6K043YUxnSlRwemwrRUNwNFRiWnJoL3JUVWFLYTEwZmlPaWto?=
 =?utf-8?B?dXRISDFQOWpEU3kyTmdIeENwOGZTeVoyTGVjaUpTOXlOQjk3MEw0TzdHZDNh?=
 =?utf-8?B?WHgvaWZpNGw2YU95dGtnWTBYRDRtTWdvOU54UmpJQmZaeGJ3MUw3YjBkdzEz?=
 =?utf-8?B?ZHZkcFVxbDREek9UcU1FaXgyVG1IWUFwYTVnODN4Y09IeklDN3dReDkyWXNj?=
 =?utf-8?B?Njg0N0ViR29nejRtK2JsckFnVnZyYVNEd3pjL2tVYnd4NWd1cjR3U0xaU3o0?=
 =?utf-8?B?YUFXZnVjOURxUzlRWlNpelllS0s0N29OM2Nka2NIS1RzenRESkxLQWlKM0Ja?=
 =?utf-8?B?L1VIWDlHa1ZudzVDdmF2RGNkTmMxK1hzMEJJc1JCN00remtxbnZNZ1hsT2Rh?=
 =?utf-8?B?U1Q5bmVpT1VURWUzeDBEZDI1MlBIUEkzcmJ0dEIrUmxmQklaSnhRdWhOT2Nl?=
 =?utf-8?B?UVViK3prbE9XMFh6NC9sMHFid0hIa1NsM01naXBDY21IVzZPSlU3N09FM2pj?=
 =?utf-8?B?VndUSGxpdEF0QzI1cmlHTUV1ZS92RVhSSGRDanBXcUY1eFpwOWpxVS9NZjcv?=
 =?utf-8?B?dVBneXRCUTB0YkcrRVdKSit3Z3owblhvQklYRVQ1K1NPTWNDWHBTcDFhUmpn?=
 =?utf-8?Q?dmeGcFsJhpSlTiTWE7V6lWYId?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95521fe-7719-48ad-20bf-08dc63475b73
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:42:10.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ul1tdD6AmJqjXi/lPlVbuDo9zvx2801WjPKnccAQBGcUqVLhxiyWjaLVKbWfHDvrUkUxIEyQIQ3yyOncjJT4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854

On 4/22/2024 19:59, xiongxin wrote:
> 在 2024/4/23 00:04, Rafael J. Wysocki 写道:
>> On Mon, Apr 22, 2024 at 5:54 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>> On 4/22/2024 10:43, Rafael J. Wysocki wrote:
>>>> On Mon, Apr 22, 2024 at 5:25 PM Mario Limonciello
>>>> <mario.limonciello@amd.com> wrote:
>>>>> On 4/22/2024 10:18, Rafael J. Wysocki wrote:
>>>>>> On Mon, Apr 22, 2024 at 5:02 PM Mario Limonciello
>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>> On 4/22/2024 09:45, Rafael J. Wysocki wrote:
>>>>>>>> On Mon, Apr 22, 2024 at 4:33 PM Mario Limonciello
>>>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>>>> On 4/22/2024 04:36, xiongxin wrote:
>>>>>>>>>> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
>>>>>>>>>>
>>>>>>>>>> In the suspend process, pm_pr_dbg() is called before setting
>>>>>>>>>> pm_suspend_target_state. As a result, this part of the log 
>>>>>>>>>> cannot be
>>>>>>>>>> output.
>>>>>>>>>>
>>>>>>>>>> pm_pr_dbg() also outputs debug logs for hibernate, but
>>>>>>>>>> pm_suspend_target_state is not set, resulting in hibernate 
>>>>>>>>>> debug logs
>>>>>>>>>> can only be output through dynamic debug, which is very 
>>>>>>>>>> inconvenient.
>>>>>>>>> As an alternative, how about exporting and renaming the variable
>>>>>>>>> in_suspend in kernel/power/hibernate.c and considering that to 
>>>>>>>>> tell if
>>>>>>>>> the hibernate process is going on?
>>>>>>>>>
>>>>>>>>> Then it should work just the same as it does at suspend.
>>>>>>>> Well, this is not the only part that stopped working AFAICS.  I'll
>>>>>>>> queue up the revert.
>>>>>>> I just tested the revert to see what happens to other drivers but 
>>>>>>> it's
>>>>>>> going to have more collateral damage.
>>>>>>>
>>>>>>> ERROR: modpost: "pm_debug_messages_on"
>>>>>>> [drivers/platform/x86/amd/pmc/amd-pmc.ko] undefined!
> 
> The revert has simply removed the pm_debug_messages_should_print() func, 
> there is no reference to
> 
> this function anywhere else in the source code, and 
> drivers/platform/x86/amd/pmc/ path does not
> 
> reference pm_debug_messages_on or this function.

amd_pmc_idlemask_read() uses the pm_pr_dbg() macro which uses the 
__pm_pr_dbg() macro.

In your revert the pm_debug_messages_on variable is not exported like 
pm_debug_messages_should_print() was in the original commit.
As amd-pmc is compiled as a module it won't be able to access that variable.

> 
>>>>>> What about removing the "pm_suspend_target_state != PM_SUSPEND_ON"
>>>>>> part from pm_debug_messages_should_print()?
>>>>>>
>>>>>> This should be as good as the revert from the POV of restoring the
>>>>>> previous functionality.
>>>>> That would probably help this reported issue but it's going to be 
>>>>> REALLY
>>>>> noisy for the pinctrl-amd driver for anyone that sets
>>>>> /sys/power/pm_debug_messages.
>>>>>
>>>>> There is a message in that driver that is emitted whenever a GPIO is
>>>>> active and pm_debug_messages is set.
>>>>>
>>>>> It's a really useful message for tracking down which GPIO woke the
>>>>> system up as the IRQ that is active is the GPIO controller master IRQ
>>>>> not an IRQ for the GPIO.
>>>>>
>>>>> But if that change is made anyone who sets 
>>>>> /sys/power/pm_debug_messages
>>>>> is going to see their kernel ring buffer flooded with every since
>>>>> interrupt associated with an I2C touchpad attention pin (for example).
>>>>>
>>>>> So if the desire really is to back all this out, I think we need to 
>>>>> also
>>>>> back out other users of pm_pr_dbg() too.
>>>> OK, so it needs to check hibernate_atomic in addition to
>>>> pm_suspend_target_state.
>>> Yeah, that sounds great to me.
>> OK
>>
>>> Tangentially related to the discussion; how would you feel about a
>>> /sys/power/pm_wakeup_gpio?  Or /sys/power/pm_wakeup_gpios?
>>>
>>> If we did the plural and used a comma separated list we could probably
>>> axe the message I mentioned above from pinctrl-amd all together.
>> That would be too specific IMV.
>>
>> The whole idea with pm_debug_messages is to switch them all on or off 
>> in one go.
> 
> 


