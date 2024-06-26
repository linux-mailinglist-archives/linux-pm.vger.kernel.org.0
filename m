Return-Path: <linux-pm+bounces-9986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E269176BB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4899C1C21204
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B753E23;
	Wed, 26 Jun 2024 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QgbIiHIA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2C134C6
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372008; cv=fail; b=WqfcrVbLQqRvlK78SefjIjF8jrIp/irhYsqB+7i97HYz6fR6WkmT7Nwsd/Zrb4gcXr/xaFb+F4h2UzHiFxlkKsgL1Vots4PqCgWAxtT/slIsN38xZNEDt+XCStd2IRrMmo0lc+jk79QPPCF9RNePM5anJaemU1+oVEaZuNoMK+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372008; c=relaxed/simple;
	bh=HSvW9Cq1BLnJoC4dLmOZ6kpudMDOzrGv0SiIblO4l6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OxylI4m1wo2LGnDbq2TJ6GnQNftWOYWL+3v/WGkvpAkfi1KlYUu2CLNzukW13GQMHkkBQnb7o0Sec1498hKD54bd/Yww8XBoS1gPwrh+qDES8cThtputUGEA0YJbX9QVYEWTSytLz294BpcawhE9b58bTBNVf0uovP4klFd/3yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QgbIiHIA; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVsdY3SirLQT4N9XTjjSpQVO49O2ParfEsrDFZOBhLs5Hk+oU0bK80h6fNDjP60CRm11DjxFjeCO3/zN8d77TRf1sVj+uzQMHzlVeWo9CKxyiCpFoaYC8UwBIWAjbQqB7CUxmGf14BTAGIPrGrFV31TNS4bg81Q9wMJt0lLl8zy+ZVoyuhdHrhNRTXsjDjZTACosJkJnPl51RFM3A24d0SGUa3/jbYeo+/jGTCfi4LwipJxiLSngBZDol0UzIDv/sUlrpcM3GYWh1ealgUOL4AhKsMT6LaMP+WeJSGcaewbKlCM88DJ+zMyoYaXfxNLLFTWcnbObeKF1aTzVTma2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPPJpPqj6YjCjVeiDJqC4OK6wRg8OZyTHMumootgNgA=;
 b=iXPXtE6Zb2sHPLwNeyMo985nVUhO75h2YCcwXcp+XZYGunQ7xmonM9MKhy69DE1bn32rrUXGNQJYmNr+VYVHH5KAQLJmb4oOBk2Xqm3S3lg8HUor9g96z9ZnsF4KZh7P1fUiCapjCEsb6cm0gedOeJ4EZVOHftkh7k4VxVO0ipEdJPaKrNwlEqXXSAxkJIdtd2Xcc8JR5ZKXvZjrqYgafQNvjNXMjd5MQx6/izvTcxWm2seMppQwUAQJ0XJfKA5h1o98VuTXn5vO+Hx5eUxKq6iN2ggLki4EnX4ONgc5jaB/26uCzO+M6JWZ9XQnDVMfJcjHaoD6fQcaFXdo0MXM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPPJpPqj6YjCjVeiDJqC4OK6wRg8OZyTHMumootgNgA=;
 b=QgbIiHIAuUMzn6G8XuyIAc/5L01hlenPfxP+DrT/1UONouRnhNs/x9yjP14Arsbt8pXqN45BPWtDLp0uhBP0iY08df1BelXh6Kjj1O7/SjLXVEZWxltrZCP7FcAbpdNR2gh2umwOhRjoIvFu6vKHyEoGdtK8VgJ7R4voS86O0ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 03:20:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 03:20:03 +0000
Message-ID: <e8275758-e0f7-46c9-8131-094abe363292@amd.com>
Date: Tue, 25 Jun 2024 22:20:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
 Linux PM <linux-pm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>,
 Yipeng Zou <zouyipeng@huawei.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
 <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
 <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>
 <20240626031753.dti6ixxi2jlykjqn@vireshk-i7>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626031753.dti6ixxi2jlykjqn@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: c184e729-7891-47ba-a1c3-08dc958edea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzlsdlpsTm5XUHlDRTRLWXVGMWNtSkM3UENSODJxMDNKVWE4MVU5WStrMVY3?=
 =?utf-8?B?RVZVb21IbXB1UjUzQzVPN0owaU4vVmJIVEYzcDFja1hOWktVKzV3U3ZLbkJT?=
 =?utf-8?B?VC8zWDByNWhMKzVuL2N4Z3diMnBab05saDhaM0JLZ2oyb0JyVUJiblNXL1pE?=
 =?utf-8?B?R01VQ0xlN2tZN1E1SWd6UWtNbndFdE1adzYxT3hTRzJoeWt5dkhIVzMxQlFX?=
 =?utf-8?B?TWFxOGRjSGFQUUsrRkdEdUozRElzTy85OUJKR1lmdUQzNUtIMW8wNkU1OFE0?=
 =?utf-8?B?VitWUnpNUm1sZ2taYnV4LzFBZVU0QTJhVjdJYU1UUHB2SzdYZEp4Mmk5R2Fo?=
 =?utf-8?B?TDhLKy9GZS9JZVlkeUFaQnAyREd1WEpWYXFqRVU5VzNOMG9BWjZmUlhqeGxt?=
 =?utf-8?B?WGpyRllzc01VQlZxaUlCd0Z0Zm16L0RnMDd5OGdHVnFoMExlVTdFT05mZERt?=
 =?utf-8?B?VGdLcm5mUGNPeXpSam5LNCszRUhCVmM4NVFIUEVNdTEwMVp6ZjAwSkFiYUVa?=
 =?utf-8?B?Vnk3cEdXUjh5WktPcll3QlpVVUZFdG9mM2Z5T3FEQmxiM0pSdXpkT0hvT2hp?=
 =?utf-8?B?TE00eURpWkF4LzQ0anVpbWk5K0lQdXFjY1RTRkhsOEpsT0JxTVZDOEo3NDFq?=
 =?utf-8?B?REVmUHhuQTJIV2FyZ0tXRjE2cGYvcWJiOTE3RjlmY3NqNVdSQnE0dm02ckVX?=
 =?utf-8?B?YWtOU2E0OHpRQTROdUhvckc3T3FuZUVKbzhwQ1hXMFYyVTVHR05TQkdCN3RT?=
 =?utf-8?B?OGdKSnlwc25Jb0FpdjhLNGE1cUR5YnJpZFN0RlZ1R0J5RGhPSkVPdWN1QlAr?=
 =?utf-8?B?WFg0UjJSN1JFRDdsV1NrNGRHNTlZTHNGZy9GS28xWDQ5UkF6K01hQjR3V09q?=
 =?utf-8?B?cXB5cWN0bU9tZE1rNXZ1eVNYU2E1eEZVOVk1cEZXeWNvYi9TbFBmaGxJSXVR?=
 =?utf-8?B?cmpHT0JGMHdOYm9lekhGblY0cWUwTUhxZTJwK09ndHhTak1IQjYwTDFGYzg2?=
 =?utf-8?B?Ym5SeWF3NVRROXVGYkNyQXFjZTZDSDhpeWVFL0QwY2ZyWHR4VkJsYlFCRlJS?=
 =?utf-8?B?Uk5lak5xVzVEVnZCRWdDQU1ua202TEdwRmlxdGMxdEJwbFJGVUZTajYvWnBj?=
 =?utf-8?B?Wk5SdS85VThSYWkzKzY1Mkw3OGFnTVRrblhXUW9ZVndXTG1VUVh4WGpKRE0y?=
 =?utf-8?B?V0xBaExEUm9DZUtURmdyei9kUFZDSEtOaFF3WUE0QlZSV04wSExyODlRNlRo?=
 =?utf-8?B?Ym1qWExNOU1lTW1IK1FrN1Q5ZjlXdjV5R2dyUWRhTytWMHgvaDE4MC8zTXFR?=
 =?utf-8?B?RkFVNitTQ3BJZVZhQWlNWlNJcW5uNVJZVWNRUXJ4QUdEQzM5cGJ4MlYwMnBl?=
 =?utf-8?B?LzFBNlVRd2NwL1dCVTROY2o0ejRieml2b005cXhWbUpYQzg0RlZzTDdUVDRn?=
 =?utf-8?B?dHROZ2h5d3pEYmNJbnFuSGRTT0IyZ3pHY0R3TzdSOHdLVm5rbkNTRXlnZlVU?=
 =?utf-8?B?YnI0b1ZmZ0Z5eVdLMUUzcjd0TThJMDhsQlh5S3Jydm5LMUpVazUxalN1US9q?=
 =?utf-8?B?ZFVDQmswVnhFU1RNQ1ppTXBJY1RBZ3JZQlNnd1VxL1FRYkUrSlcyN1Z1ZmVv?=
 =?utf-8?B?N1ZjNFh3T1FPMEpCREFMb01QUEh5NEFqQnpDSzNOQklWSEtWaFhULzl3UXNr?=
 =?utf-8?B?R096a2t3TE9pRndJTnpWM3A0UnEvZklaSWw0QkdyRFMyZXdtUHlTNWRpdEty?=
 =?utf-8?B?aVRxWVloOWdGWThlQ0EyampRQXJNT2h2UmlkV2VTaGthcGc4VWY2RVFpcUU3?=
 =?utf-8?B?Qm9sM1NWK04vMzBtQko5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEFualVmVDk2cHBabTVGcnZsNWRDVXZoTUpQWUZCTTh1R05HdTFBSENFQWNa?=
 =?utf-8?B?dEJDTkErSlBrRURMVmdubFJvN0k5NGlENUIyTGFFQVp5UndTQVJWUTBUbEYz?=
 =?utf-8?B?azNFK2l6RWNFQTdNa1BXZFBzcjh3L2pRcHZWbmF6NWFJajFhRnlCQkZDMWxj?=
 =?utf-8?B?aE5FalpNN1FISml1THYxMXZDdFpoR1hGRVRpN29lUVVremFidVNoUDVCZXdE?=
 =?utf-8?B?K0NOY1ZIUlY2VER4MHQ3dTF2MkQ4TkRPOUdjaFc4SkpZQTJONGM0MGNrTzll?=
 =?utf-8?B?NHpEMTdEYUwxK0ZOSmV1NG1SRDY0YVJ2amx0d050SVFMZk1IM0NRc2F6T09O?=
 =?utf-8?B?RFlnTGJXdXFubW1rRmZUT1N2eXJoUDB4WXZGcDlNRUl2RmJ0aWdIS2laNXhi?=
 =?utf-8?B?NmJYbGZlVHBNWktSYWlrYmVNYktQcWtvQlQxOEYrUTdBV3lkYkxWVExWYTls?=
 =?utf-8?B?bjlheHhNQklkTzdGWDRmQ2hwTmNHN29DTjYzZkdNbm5LNUxZeEFBK08yUHcv?=
 =?utf-8?B?MEUvL1N4eVFEdGZSY0EyanRmRXRQL1JDUEYzRjU2S2VicXo1cHkrc0twaEN5?=
 =?utf-8?B?cDh3eUprU0k2a1FqNm5RQWVTYUlOVVVvdENjOGpiNnNNazRxL0JDbUZFNzR6?=
 =?utf-8?B?cG5vTEoxOGRPVDRocWVNT0pGQ3A0WUZQWWFZMzNxRmhKQXc3R0dlZlpYNkF5?=
 =?utf-8?B?VTVyeEEwS0hCR3luUHJJNE55cEdwblAvRnFpWWhKNWdqaWIycUZaSFVvOXZt?=
 =?utf-8?B?dVJzL3R6SjkwbjlQdEdmMFFGZ1JxTndaeFJMUGFvdi92KzhpTGJ1Z3lXQ1R2?=
 =?utf-8?B?S0NKMWdNL2l1c005NHNWdEVUR2pkaGRMQWxhNTBMMWhIZ3BEREZwSU1wKzBI?=
 =?utf-8?B?MGY0ZUl3NFRBSXV6S1lVYzBhVEdvYUQxZzViQzIwV2QwaitvRWJXYkdOaTNN?=
 =?utf-8?B?YUZwTldXQmtOM3ZGYVdYSTl4WGFsMXhWZkE2eHJPVGphNWR5R2FxMDRjb1Zz?=
 =?utf-8?B?OTdJSXR0Mm9RSnFFQ205N2FIaTdVeGpMaHNob08rQTFkYy90MEc3bUowNjVv?=
 =?utf-8?B?ejkvaHZST0FReWV3dWFlYmN3SWtCRjIzYnhLRHZocXpJci9EZXpIZUlCcW5Z?=
 =?utf-8?B?MHU5TnZlbFVieG9OODRQV2tJelJOTzBmb1g0K251c1JjSjROdnVFMnhXcG93?=
 =?utf-8?B?MWxUTHF5eG1lMkVmaWliNUJQR21HdWpidjNqM2xtOXJIbGNuQUVjZ1l2OGRj?=
 =?utf-8?B?ZjNHTWhoZURQZWZEYnN4bVhtTnFoaDduZ3lYUm5kdng0bE9YaW9MQVhkUjJz?=
 =?utf-8?B?MTJzK0dBN1VIR1gxTkxpQ1RjNnBPa21MSk93MXhxWXVaRng3NlhRN3Z1QTA5?=
 =?utf-8?B?VG9DUzJxb3lrVWkyUCtwd1Q4MHBMTU1oSkQ5T3Q4aGljeXVBUlpiYm9jR2Nr?=
 =?utf-8?B?aHZaNjh1bDBJbnVPYWFuckhtc0lEaklTQVVTeGNLR1RDK0dkK2JOTmUyUCt0?=
 =?utf-8?B?SEREMXRvWk1BV3JOWGlTa0ZFZVRNZ2VBMHVFUlFVdG1mNDhpeERNQy8vQ0hH?=
 =?utf-8?B?c2Y2bWRnSVlIY2tPdk42dXhkaktqWGZWcVNCd3BqS3BKQVhYQW5oVE5KTDVZ?=
 =?utf-8?B?b3Q3dmt5SzRzZHp1S0o1S21CaUx6SFFMS094L1BpRCtwZmtuM1p5Yk92cHF5?=
 =?utf-8?B?YlhjZndhcW5nL1dVRDczQjhsY0V5MjY1TnlRcWx4ZWg0MUJpZWpnbTI3NFR0?=
 =?utf-8?B?Rmx1eGZ2NDN5SURiTHIwdUlsR2RaYWxqZjNxYzAxaHhSd1BIQVRzaGZzUWNo?=
 =?utf-8?B?VGhIKy9wUmZsTzJaMkg2cmNldmozYVEwMC93MVdmMUd1bEN4bmlmcUtncmRG?=
 =?utf-8?B?dmNDWWZJNG5pMWdycjBEdlRlandycXB5Wnp3VU9QcTl6bmF4NVY5M2F1RUE0?=
 =?utf-8?B?Qm9lQWU4RmwxTDJXdnhqeDFaQ2s5a2pyeU4rV0VNZGVRTk1FS01mWFNIZEVX?=
 =?utf-8?B?RXRjMlRiV0VSTXdVcjl5alZ1WGk0U01qMVR1emN2RGZmT21iRlAydGwxYWVk?=
 =?utf-8?B?K2N0T09NRFNoZnhIay8rRHE3NElxYmdXUmU4T0xXQWZLaFVjK1hFZ3BDNXo5?=
 =?utf-8?Q?unsIUIGmrznIWN8T6TMaxBeot?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c184e729-7891-47ba-a1c3-08dc958edea6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 03:20:03.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rVIIcikAveMf82W8OPtxPODtqte6A4TgVyCI7zsMgbeJdI7V9+whn7MNGJezKTxhCSnO8JigNLTeLgffs3Zug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

On 6/25/2024 22:17, Viresh Kumar wrote:
> On 25-06-24, 22:14, Mario Limonciello wrote:
>> The earlier patches in this series do that with amd-pstate.  Gautham had
>> suggested a change to acpi-cpufreq for the same too.
> 
> Ahh, since I wasn't cc'd, I missed that obvious part :)
> 
> The right fix would be this then I guess:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a45aac17c20f..9e5060b27864 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1431,7 +1431,8 @@ static int cpufreq_online(unsigned int cpu)
>                  }
> 
>                  /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -               policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +               if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
> +                       policy->boost_enabled = true;
> 
>                  /*
>                   * The initialization has succeeded and the policy is online.
> 

Yeah; that's effectively the same result as Gautham's suggestion.  He 
had just said to change policy_has_boost_freq() for the same.

I'll test it with yours and reconcile the better one to submit back out 
for v15.

Thank you for your feedback.

