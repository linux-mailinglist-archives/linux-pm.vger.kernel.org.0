Return-Path: <linux-pm+bounces-25176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B8A84DE5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDB27B4631
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866BD204844;
	Thu, 10 Apr 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z6EepDQN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7419DF99;
	Thu, 10 Apr 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315677; cv=fail; b=k2hZv5GHB3OkKnrof+AB3lfbZvXjAzq6MedaJzCdGOkYYt96vL2L5b2eQYY5NDnTX7Cr1PjeaWh8fsvsVDJgfcp9jrAkrao42B/ourAa4JGhXNqFbQQhEqxR1TFnDtwPnusB4N+R2ayBSdGKsjqGT+fRoerKoIu2j8lYQ+cx8t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315677; c=relaxed/simple;
	bh=eInXo+mhmy/3Y8xZBjKsnyHtfea13N0A4o5qFRLHc0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=REGrM0gHzFGHqzZr9veeqnoIitWfcvzQG8hlu02cFLv3l/jk/DV9sRbZYqHcSgmfqk6uLRIwA1c9zKgA4//8NMe0jXiUonDvZWt3LzqgYeRqDF0bZ0GX8XFxX9x1SNNy6i+nmkxkfsni8W3nvW4nNXD+F137YcZ5d0vyISS29mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z6EepDQN; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pD/j8hqfQUi+VJLq6B5kI0yRmj2/N7JywsINQioeaxq9zDu6nRb36uSvU0serL9FIITIvhu7hpOZqiBqx0ubv0Q+RpQX1u7BRZ7SUO4NYoeWk1xqqgF5J/I+DUNU8pSFSq441Ups7Uv+bOSElisjBCqyZXtaalKrfzapeK269PTQRiUEby7S0XvYutaR7xdS8wvnsyRDy6f8W03KfRUi91zRgUN+NUf88ZWKaZJ+IXBeuTwa02YzCSYODuSQCEj2mNNo7eRc4Hg5ArU2ISAcHgEwoXKwPon3QvsgxRquSwrnYjx798eNxVZefArbdOid5+zvwGzJKOQyfa05bLV9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoC/3AOVulL7tw3l66r8kjWw6rH0wxKv1rjxnKnhZWk=;
 b=rMd26D2irqFXJxY82bV+VX9MpCsb33SmWjlHNM/IhyTPJTJtOf7FjnJSt3P4nugb6mVcTNz64UZiBFl8480jM6/CsH2vrmfYV3L6ZYyUPDLA30qPMj7QYc7BANAr/vejUJh0WMSwioga3EYWsPlfKdIonYjtfMyMLbM7/xHtLc7KVtIcDZWQ2qH6+ZN9n4ey4/JaIk0AAXVfBNxgJX1oC3WnP21cNkBO0lugNyxLQ0eK1LQdPhJm20l38/1V43PQT4p67nCMK7zZahlsee4hgPPuMvixt3VN0HYsxn53hbx8wOaiy7W/AbROmjAIKJzigYlu2BFEhdaCf/h0yP9LDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoC/3AOVulL7tw3l66r8kjWw6rH0wxKv1rjxnKnhZWk=;
 b=z6EepDQNWuCGkUWftZSQsmOcm2umK9Nqj3oUs4N4dtJ6mKBkP81A6rGr+oqwJpgkvFpgXlIRohqs06IPTbwCtP2ONDM7ftpr7Ppx/8QFCfj4zPt5OLzmQnz/5Q8zWpubs/taTkp7QD//g1JDa3fxQOXru+taeStJwSNmA4rMxBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 20:07:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 20:07:52 +0000
Message-ID: <95a4640b-6141-4a14-9804-a2a4c21e50cf@amd.com>
Date: Thu, 10 Apr 2025 15:07:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Enable ITMT support after
 initializing core rankings
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 Meng Li <li.meng@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250409030004.23008-1-kprateek.nayak@amd.com>
 <483e9fc0-28bb-4531-88bb-738cd9ce9eb3@amd.com>
 <f62e5ac5-313b-4668-a6ab-a683e5ddfcda@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f62e5ac5-313b-4668-a6ab-a683e5ddfcda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:806:20::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b5910a-5e7d-4c6b-961e-08dd786b600a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzdhZy9TZ2laUDF1MUFuMG85ZG1iMUFKRUtDYm1ocjRjU1pselIvaTZnbFBk?=
 =?utf-8?B?YmZVK1FDaUNzZmpyeFhOUkZuT0VyN1NpN3NKSE9HMmoxN2tIS0RHb0s4a2Er?=
 =?utf-8?B?a1lyMDA2UEV0TnVuLzFCNElxWEhqV1R3OEc2YWVCeHNtMEEwTW5sYWI2TFl3?=
 =?utf-8?B?WURsVVJSUXVMNzh1bUl5YitvdWl6d0lqWWRXVjVBL3ZldjJCK0hIam9KWGdB?=
 =?utf-8?B?SzRLbnZYK1crZ0JFMGQvaDBPSE5RbllyeDVmNDVLUFdYNSsxUWV3bHdEaC9Y?=
 =?utf-8?B?S0paaHg0RUpIZGRGQlhYNXQ1K0IyaGlYVTF3WE5pd0h3WFpQWDFGRlNMVXk0?=
 =?utf-8?B?bUV6Vjc3cThmY0M4Q1Z6ank3RkNvZHRqYVVvdEU3MUZhR0wyUndlcXErNGtZ?=
 =?utf-8?B?empZUjBZL2h5bzZjcWo0dTFEMldlbFpjbklJTWZtTzhOcnJNZjY4VUcvWFFp?=
 =?utf-8?B?MnNXV2NlMEJnaVZCZGMxRUNneHJUMmdGTzl2VUs5ODRpTUZhYzFWcEtYVGY2?=
 =?utf-8?B?bTN5aTZtVTBxdHcrQkNjYUg3N2VNTm43NldtYmg2bHY1R2RFVndLckZvSngy?=
 =?utf-8?B?aWl1ajR2dGNSQnc1T2kyMnJib3FuT090bFc1eUh1dFdISTR2T1B2cUd4YzVD?=
 =?utf-8?B?cGlqa1o0ekI2LytlT0Q1OW1lazBpSzhGUnM2TnlrajM1ZW4wekRNZ2JTM1VO?=
 =?utf-8?B?UG9CUForaENKYnNsY0JVL2JrMjZDWmV2LytMbGdpTFlpd1RpTG1MQUliZzVC?=
 =?utf-8?B?T1EyV0hNb1RHOUpNY3JKcEJEQTA0ZHRienBDVmhXdGpJeDkrcHZTL2ZtMDMx?=
 =?utf-8?B?VEZDRE9GWEc1R2JkNXR6Y2NHK253NXB6MW0ySVZrQzBNWmRKM1hxeUxrNkg5?=
 =?utf-8?B?a2JiOW9leGN2OGhHVTNxUEdFbWRTSHhFZWF0VDJVNzJFcStFMzhTUmRqNmY4?=
 =?utf-8?B?ZG1xUDRlTU50YXlWVWl0dHJBUGlEdzgzaUZ6dTExRkJsSFYzaFhZMWdXanBz?=
 =?utf-8?B?SEI5UVN3Z3pRU2JWcVo3ZS8wY0xGclRTWndWYWN2SHhra3VBMEhIRXUwWmoy?=
 =?utf-8?B?bzdEQ1Vqc1k5M2R4SEE2a2RiQUdITzg1c0hycFlnc0NwaS9lak0vaS95dlA4?=
 =?utf-8?B?OTRuUkR6dWxSS2VkbHdlMGVTVVpON1FGTlljdWRIVnlzYnBJMEFGUVExQWN5?=
 =?utf-8?B?Q0ptcEZvbHQ4b0M2VDJyOTZWNVNETENEdW10enFOb1krclNtSmtqdk0rczk1?=
 =?utf-8?B?ZkU4N3RNOVpiaFgweDg4a3JnTDZDNXkrQ3dWQWJBdmhmRDFDQ0JBd3BNRG4x?=
 =?utf-8?B?WkxlUnVqZWJkS1BSWWg2Q3lIN2xXZTNBaHl3S0ZzY2dqQVBtblNIYlFFaDVQ?=
 =?utf-8?B?d3lrbjlmbk14T01wWkxvb0Jwais5MUNQSjkwS2FJNkllcFE1TWdMS24vTmNY?=
 =?utf-8?B?ajJFQTF0cGF2clA3cThKbVVtaisrRlFxRTdpSnQxd1MxYXdUQnlEM1dHRU5Q?=
 =?utf-8?B?SkpBbzB4SzBPbVlhUVE4ZlBoRXZ6ZEYzMVBDbFZodHRrbmFMNUJ0b0cyaktx?=
 =?utf-8?B?UXZiQXRkTldTcWlURFdnVnRnRnVHNjhRQWNpanhHOTJhTFROY1Vod3N3eC9v?=
 =?utf-8?B?V3ZuUmljeWU0aTVlQ05LVUZod2tlVFBpSDNlU0JXNFVLRkhjaXpCZnAyYkFW?=
 =?utf-8?B?VnBlUmg4SGlnOFNlQWVPVkRGc1FYeVZQZVBGZTZNM3FDeUpxMnZVeVZPUDRa?=
 =?utf-8?B?alEzbGJFZE1sNTAzSmVBd1ZTR2ZNWlBQREk0Q250WE5ZQldpV0dyMFA1Y28v?=
 =?utf-8?B?Z1JkVzZ4ZWJqU0JqK2MrQjlxRXcxdE9uU3E5ejFMV0lzcDU1T2xBZFlqRkla?=
 =?utf-8?B?YXUzV2FrYzN6UXkvM1M5Z1B6eGhLYWxYaWR0eUR5VVptMklTdGNhUDdkbHNv?=
 =?utf-8?Q?0Xsa8BzDbZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUc1SWk3YzFHMlY5L0VJUmlMMGZ0SWl2UkhWWUdwTkg5ZUt1Y0ZXcG1qKzR3?=
 =?utf-8?B?cGZKbGxEazB6RVpnenptNC9DVVRaczBsZVlwSTlhMlRXeTZ6b2Q1SElIRmtt?=
 =?utf-8?B?SEJYOHlMdTNZQjRBTytlMUs2Tkd5OERVclE1eEJjcWVSNnE5ZVlvNCtXMjNu?=
 =?utf-8?B?SThMV2gyK2p1WkhvbHpCZmdQd1ZHQTBSem1yc2thdnlTakVlZEFDZnhma2RC?=
 =?utf-8?B?M0s5VTc0aGRjZ2hSNXV0NlhBNnZVVTFvcnVpRk9WOVEySTc1ZkxvcUwzaCtH?=
 =?utf-8?B?VTFXYXJmcEYvWk0vakM3eTRMS2RpNFlsdUVOVmJtcnhwRmRES2tXa1ZxU2p5?=
 =?utf-8?B?cVBPcE9lalpHY1VWZG5ySDVNYm4xdVJhY1lMMnlKQ3pUVUdVSWExeU1yOGsy?=
 =?utf-8?B?bjA5U1RzY1Y5ZVlVNjZ5MC9tVjVSQysyRzNWWDdzQk1iQkZsVU1ENVpDY1Fo?=
 =?utf-8?B?dEovMG9hdy9DVDMyTzF3OEdmS1hOOFcyYkNYUW9nZm5PSnFQRzJzdnhzaHFi?=
 =?utf-8?B?enU2S0ZQVktZeUo5WmVCb0FXckhhVTJMQm9CNzRnYlJQQUtrQ3VWY1laRElJ?=
 =?utf-8?B?Q25KdUlPckNtWFh4aitMR2tqbkhnY1J2Y3c4SVdzZTBwcEJqTnBxTlE2cFhE?=
 =?utf-8?B?eEJsWjdwSmJEMExzeVFPN295OE84cnBoMmprUVdFUThoejQzaHpTKzREN3JF?=
 =?utf-8?B?K0pFMlcycEZtNmRMT3B3enhXNFRvNmNmUlMvRm1Bb1dPL2gwaWJXQkN4eGxo?=
 =?utf-8?B?cHBVZ3huZEN4TDdzczNtYkJuM08xdVJEdW55MnlWdWhaSkRrZFVtWWJqaWx2?=
 =?utf-8?B?eElONnY3TTRrQmt1Q0JUKyt5TmNzRzQ5SXR6VStOTWJKems3TkJBOGoxakFj?=
 =?utf-8?B?aVV2eXI1TGlpc2Y0T2F2UFVUSDRkWFAzWlA1a2VyWUdpaktQUXZ3UDV2THhI?=
 =?utf-8?B?dEVTNVpjWTM5b2NEcE5aeG5ERkxRbUxxb1QwSlI5bXRDdGlTR3dPR0V1dWdh?=
 =?utf-8?B?Z2VjZ0Q3MzB4cVpYK1lGYVJEYXE5S1BiZnc5WVZiaWdReUZGU2R1OCsxZTlL?=
 =?utf-8?B?VjlYa2R5ZDZ3TW9vRW5nSExxbENrL1E0ZUlrUzNKNUxDK1gzV1lOK0laR2Vk?=
 =?utf-8?B?US8wT1JpTWFzUi96ZTE0K085RGYreGxoRkxlYTM5Y2FabVdRSlB0YVNFOXNk?=
 =?utf-8?B?cTZzd0JPaWpneUVaaElpRTRTQ1hsRlc3SytyNFEzMFNibmhCNktIV25rd0lm?=
 =?utf-8?B?TGVwM2NMZ28wa0lmNUh6WTdKMHNUZU1PUkRLVnliOGxXR3ZOOUMrT1lVTHpv?=
 =?utf-8?B?V0ttQWlodFNwZWZialZVNVVwRm1rMytUYXQ5U3JkcmVod3BTK0NEWXBnbEtE?=
 =?utf-8?B?WW9uMUhRakNlWXpBZVFkNU56ZkY3WEpaK0dUcU9UaGpnLzFFQklnWnNpUnNT?=
 =?utf-8?B?YXNyeGJtODArK3N1QVJlaFJNRGxteE1WSS9JN3ZKbGtkMVd1VTBwOVlqY2hQ?=
 =?utf-8?B?N2dUT2UxWTJ0dys0R0ZqdXBDUldtektnRWE1WDQ5MU9IbzlPRWVuU2JwKzM3?=
 =?utf-8?B?V3c1K3VCYWJyVldkQ0dnSG5VWXF2eHFDd3VpZ2ZvS3M2UUljYXJpcW9sbEc5?=
 =?utf-8?B?T0ZTTUFPd0ZHM21aTGhpdXU4SWpEOC90WWJXSzJ2RVdtY2dCVnRzRjdZZFdY?=
 =?utf-8?B?dWV3bnVHVVpoaWV4aW9BajZsajV1SDMyNGNWeHQwK09GZG42a0g1ZStleDZ1?=
 =?utf-8?B?eUtVcDdvV3dqVWNNcFRBNXRRU2FnaWNKYjM2Smc3bS9GbHh4aVUvUWI1YlJw?=
 =?utf-8?B?ekNSdVExKzFFa1NobitFUzZXZWxJTmFMMzZMbnRiZTJMdVBDRjRnYjlLZ2NQ?=
 =?utf-8?B?SWVCYU5TT1lLTTllZmJhaXlpbWhKRXdhUmNrZHJoZ0lMVFhLNGltNnEvRTRR?=
 =?utf-8?B?TjdOYVIzNzVhd3k3V2orVTg4eUdXRVc3VjdEdEUyVC9qd28wNEJBUzE0Slk5?=
 =?utf-8?B?Rzd5N1dhZGJLTlJWZk15OTFPQXZJOFVZc3dGQlV6eGNrVkJ6aTlTZDFUQ05v?=
 =?utf-8?B?N1RyNitKYy9QZ0dpUS9wRUhvelFiVFdDaURTUTJCYkZLTWtFTG5UU2orRitE?=
 =?utf-8?Q?Ox81RrdCpLZf2fs47BjOjKYFG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b5910a-5e7d-4c6b-961e-08dd786b600a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 20:07:52.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UapYT5xyUVI0iITPtGhOrE00/Lcx7ZuxQLrBbGbVroUd+av82TTQghajn12OCWgY/dRddlvc3YSg02CeXGNwrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466

On 4/9/2025 11:41 PM, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 4/10/2025 2:28 AM, Mario Limonciello wrote:
> 
> [..snip..]
> 
>>>   #define CPPC_MAX_PERF    U8_MAX
>>> -static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>>> +static void amd_pstate_init_asym_prio(struct amd_cpudata *cpudata)
>>
>> I think the previous function name was fine.
>>
>> 1) It still does set cpudata->hw_prefcore afterall and
>> 2) We still have an amd_detect_prefcore() that is used to determine 
>> whether amd_pstate_prefcore is set.
> 
> Ack. I'll change it back in v2.
> 
>>
>>>   {
>>>       /* user disabled or not detected */
>>>       if (!amd_pstate_prefcore)
>>> @@ -814,14 +804,8 @@ static void amd_pstate_init_prefcore(struct 
>>> amd_cpudata *cpudata)
>>>       cpudata->hw_prefcore = true;
>>> -    /*
>>> -     * The priorities can be set regardless of whether or not
>>> -     * sched_set_itmt_support(true) has been called and it is valid to
>>> -     * update them at any time after it has been called.
>>> -     */
>>> +    /* The priorities must be initialized before ITMT support can be 
>>> toggled on. */
>>>       sched_set_itmt_core_prio((int)READ_ONCE(cpudata- 
>>> >prefcore_ranking), cpudata->cpu);
>>> -
>>> -    schedule_work(&sched_prefcore_work);
>>>   }
>>>   static void amd_pstate_update_limits(unsigned int cpu)
>>> @@ -974,7 +958,7 @@ static int amd_pstate_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       if (ret)
>>>           goto free_cpudata1;
>>> -    amd_pstate_init_prefcore(cpudata);
>>> +    amd_pstate_init_asym_prio(cpudata);
>>>       ret = amd_pstate_init_freq(cpudata);
>>>       if (ret)
>>> @@ -1450,7 +1434,7 @@ static int amd_pstate_epp_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       if (ret)
>>>           goto free_cpudata1;
>>> -    amd_pstate_init_prefcore(cpudata);
>>> +    amd_pstate_init_asym_prio(cpudata);
>>>       ret = amd_pstate_init_freq(cpudata);
>>>       if (ret)
>>> @@ -1780,6 +1764,10 @@ static int __init amd_pstate_init(void)
>>>           }
>>>       }
>>> +    /* Enable ITMT support once all CPUs have initialized their asym 
>>> priorities. */
>>> +    if (amd_pstate_prefcore)
>>> +        sched_set_itmt_support();
>>> +
>>
>> Hmm, by moving it after the first registration that has the side 
>> effect that if you changed driver modes from active to passive (for 
>> example) ITMT priorities stay identical and aren't updated.
>> I guess that makes sense since the rankings /shouldn't/ change.
> 
> Currently, when amd-pstate unregisters during mode switch, ITMT remains
> enabled and if the rankings change before the new driver is registered,
> update_limits() is never called and that too can cause issues.
> 
> Based on discussion with Dhananjay, and the fact that one can mode
> switch to disable amd-pstate completely, What are your thoughts on this
> addition diff:
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 40d908188b78..320b9551947e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1177,6 +1177,9 @@ static ssize_t show_energy_performance_preference(
> 
>   static void amd_pstate_driver_cleanup(void)
>   {
> +    if (amd_pstate_prefcore)
> +        sched_clear_itmt_support();
> +
>       cppc_state = AMD_PSTATE_DISABLE;
>       current_pstate_driver = NULL;
>   }
> @@ -1219,6 +1222,10 @@ static int amd_pstate_register_driver(int mode)
>           return ret;
>       }
> 
> +    /* Enable ITMT support once all CPUs have initialized their asym 
> priorities. */
> +    if (amd_pstate_prefcore)
> +        sched_set_itmt_support();
> +
>       return 0;
>   }
> 
> @@ -1761,10 +1768,6 @@ static int __init amd_pstate_init(void)
>           }
>       }
> 
> -    /* Enable ITMT support once all CPUs have initialized their asym 
> priorities. */
> -    if (amd_pstate_prefcore)
> -        sched_set_itmt_support();
> -
>       return ret;
> 
>   global_attr_free:
> -- 
> 
> This way, when the new driver registers, it can repopulate the rankings
> and then the sched domain rebuild will get everything right. 

Yes; that's *exactly* what I was thinking is needed when I made my comment.

> The only
> concern is that disabling ITMT support during mode switch will cause the
> sched domains to be rebuilt twice but I'm assuming mode switch is a rare
> operation.

Yes; it's not something we expect people to be doing frequently. We 
expect most people like one mode for $REASONS and stick to it and tune 
the knobs 'in the mode' at runtime as they see fit.

So yeah roll that diff into v2 and we should be good.

