Return-Path: <linux-pm+bounces-26045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441AFA98CA8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 16:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83175A3241
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91F27CB31;
	Wed, 23 Apr 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="amj2iUj4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7601991B8;
	Wed, 23 Apr 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417975; cv=fail; b=MTbvoc8x9GMVCvY2vsldz2yDuSgPupLsHE8ASiiPjObB6RxJf9O9052wbiF/jGZJkVw1pYDzsqmqqQsgiVbeFPjtd3k8wL4ppaP5pv0xXaeM+nEBbGgg0VUHoGe9uPrzbNoaom7rnx5MbbBzJ85NZhCccLITkp4eJ2jvD+0F0es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417975; c=relaxed/simple;
	bh=7a8dmVqLBqncFKwbt39tR9zSJA0QCPpYFhjpVL226HQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JZlDH5+Sa1q06GQyvzesRs7YCD8MLlLK3kSZHusFRjIPtfBlP48PdWhc8dHR9E1tDa0S6gLLCFgQpHbMM7zyKv5UJOhd52bz5Acc7r9VyLKWLU6OKV2osbVYu5lf75Eu+Dk8Twjn5QILLg/2z51cEUiU5wPer/sHnziLYH2SFOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=amj2iUj4; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7yS/xYeyuyStmcuDNX3UApRXpkKP0eZW5dax5EQq53bUBvVZyHAC88xAVxlDq6HpdvJzEdNsyKye9eAPHL1SeQFgCtLGOdlFCoMmTLHV/XxeihjWjRa0G+Uyno0SBTWwRb/VgZxUlhnUiy4mJX0dkJv1dgjj8G787rgzDJe1gFt0fOPpyV8yt0REim19ixGQ/mssG9lQakp6x3SR+4mljor11vUNPmY/6HMDolGC6wS4t+hw0Xlcq91ppHDsJT7cn9iSaIdr7xtiQ3/X+QFUp6UHkd2xlCrojTmFke18rdpKnR/I9f367B/GGMElr+fIPMUU/JiLSkLYnVs4ZNI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVfHToQkcp9BwcA4xT6HM7ODDbCUGmq6lYlK6DLD9J8=;
 b=c2v5SDowdD1Px7/VZaDCI+wPZlHGpuipgG0epNqr08v2yu4PMwQl1jDmGKrtEgRUjMZYxo+uX6aj9AOlyv9ckljPmQFFyoYXT83XOEJst89mx+jqe+/rMfN1sz6w7eg7FJvrRGyl/CImmD9L0uwSzJBYlUE0hzOQvWxyUrF9qfVxx3Ee+yqniMrvSZcdnUQ5i2ddvtnwfvqFHm2t64FDxPQLsisRC5DucX+F7zmk0wTSI11mIUOdODlzsKycvn8YPYEzMzDxC7CokIN7rkij/3jjaz02C+rgzf8VLyw5C6q3iE6fILcXNKj63LZvmd6O10rHS5aBns8aBk1X2WWupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVfHToQkcp9BwcA4xT6HM7ODDbCUGmq6lYlK6DLD9J8=;
 b=amj2iUj4kj+b5xz6ERNwOu2Tl5dPeOU6EtBIL9W2+0z4xv20RNQaHeWG7LxZPmfiUEFgpCBubbp7yNHuQZBvrCaOWhKXN4eBSpjB9iqPnXT7ijQFOaOegkPiOnORdKvm9HXl9igAb+colfWYjy6lrRlKlypOj4d+xgu0gaJGJVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 14:19:31 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 14:19:31 +0000
Message-ID: <346158ff-688b-4fa1-830d-807eb1a30448@amd.com>
Date: Wed, 23 Apr 2025 19:49:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Add support for the "Requested
 CPU Min frequency" BIOS option
To: Mario Limonciello <mario.limonciello@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
 <20250421080444.707538-3-dhananjay.ugwekar@amd.com>
 <eedfe953-7468-4b4c-934c-4589de601fa2@amd.com>
 <5b4b11d7-197e-41ec-82b6-8279125a95bd@amd.com>
 <0f784d8d-7141-4e35-9a61-e8875d0a8f11@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <0f784d8d-7141-4e35-9a61-e8875d0a8f11@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::13) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2ea86b-254e-4bba-8ad7-08dd8271dce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a05mSEI3VlpEN2dXaDN4M0Ridzc3Z2lhek5vM29ENjNUSlRIWTM5Z1FxU3Bp?=
 =?utf-8?B?UXB3QVFxb3ltb1ovbHhzKzJCTlplUnFWY1huN2lHdVdUZDJ5MUVITnA3cGxr?=
 =?utf-8?B?b2luM3RiTUtQbVcrNnREdDlvckRZVGlqNDJ0NG1lUHZMRVhYUW9yVFp1TFVC?=
 =?utf-8?B?VzI4UGh3amNxTXRDYW82WmNFa3Fac2hVMHhoOFN2eUoxK2ZJSGxSc1RmcDNt?=
 =?utf-8?B?cjVSQ1VnSVhLam9FNFJIUWMycFMyY0oveDZJR0pjamllZlkrTVVkNFhRaGFr?=
 =?utf-8?B?S3ZaZGhUQ2tWNnlJRW9sVzF0TE9OcDZzNjlPTEhhcHBzemlQY0dFVjQ0TkZk?=
 =?utf-8?B?MDFJR1pWSHpPQ2J2azE2MkVmcldvOTd4Mnc3QVlZUklKVWtKWG9TNGFrTUR5?=
 =?utf-8?B?UGxhS3YzZEZaU2tXbG9YZEZTQ0hGbWNEa0ZpeVJJRVZWcjVGRGxiRVljZ05B?=
 =?utf-8?B?Q0U1WHllYzNGa3drd1BzMm5BZHhJbDhuZ3JpWjkzemhQaUFDc1dJU3dNN2pS?=
 =?utf-8?B?Z2hEMG95MDdYU2FLU29TRTJFSksrOUltZ1J1b1dHdTZGMmcya0lOUHluQm9p?=
 =?utf-8?B?ckRPbTZvVjFyTVFpd3Q4SThJSjJVOEJmZG9hZHlGUUszdVlLdVpkcEM5cjh0?=
 =?utf-8?B?VW1vV1puNXlZbWhSeE81d01ydnBNaW1IZEIxQ1h1QXFHRG5xVmxHcm9JVUdS?=
 =?utf-8?B?c0xBbU1WMDRSQU4zOFpZM29Od1Blb0ZaMTlURVdERDlCc2RxaldSNDVrbFNG?=
 =?utf-8?B?WXJqa3cvQkRjbUNmamRKcHlkejRtT3ZYTmVySkxNRmk2ZU9KVHpzUjdQb2Zl?=
 =?utf-8?B?cUVseVN6d1R5UmdUVzFTTGVLSEVxdlc5SVROVlRPNlEveU0vSGw1ZG1yVzlF?=
 =?utf-8?B?WGcvZzBuK0ZFZzJUWXNubWhUWWF2UVBkYmd2UWZPakNxcmUvbEUzS1ZxRUt5?=
 =?utf-8?B?OHpZUS9rU1NNS21VajVtRS8zby9LMks2NU9oTXBWUUlobER2dEkwcEJmU3Uz?=
 =?utf-8?B?K2YweWQ4d0c2SWE2ZDVWbmdpeVdYN0pSSXVQcC9BY1pIYlFUS1VVWjdRUmkr?=
 =?utf-8?B?QmFsL1lJUG54WlU3U1I3ZXYrUWg4dTZyOVRlSlZZeUMycjFiRHBBR3dFSENX?=
 =?utf-8?B?S0RwNWZxUnNJTkJ1RkF1bFBRZnFJVGM3elA2dHZZMEIwemREdkptQ3JpTFZS?=
 =?utf-8?B?V0d4NFhCNzVKTUJwUjdHbldudEl6aWM3elQxcUxkMDFCMi9XTXBjR0g0YWR3?=
 =?utf-8?B?TW1QbUFUN0FmSkNVTHRPYitjNHpXd29ZRHZCZEl5WDQwSEdCdC9WaTk3VkJl?=
 =?utf-8?B?eE00d2Y3YTRINTl4cUJMZFh6ZnUwR24rcHBJakdwRmZrM0hQZzhHY1ZlbzNa?=
 =?utf-8?B?R0dqanBlUUxpSXFFbjBFTk5ZMkJ6Q1B0L3ozNGZOcGg3Wnd3YUNiZittVzRk?=
 =?utf-8?B?NGYyREZFMXRXRHdjbTZmZStUdDhvQ24wZUpoWW5zREU3OXVYUzd5MEk4Mk9h?=
 =?utf-8?B?QkdPWTM1TGhJbDB4aUVPRGswQTFUakYxMDZKTmcxZDhtb0hGL05RajhvM1ZT?=
 =?utf-8?B?L2F0M2NpZ3c5Y3U2b0UweGZrRjRDZ1hqM1BTanMvZXh2dVNlTTgwZ01XcWZw?=
 =?utf-8?B?ZHFJc2JOL0RiWTZueHlEMzVENGZKQlFXNStaazlhTXpiU0NYcXpyYnFHTXEz?=
 =?utf-8?B?TUdqY0FxMEpOUFFjMkJNS2tYZnUvNXB5ZjdMcGcyQ2hHTnR3NXZHQUIreXVj?=
 =?utf-8?B?bXRMUGNiajVpYS81S3BFcmJFL3ladHRPOTUxa2k5K2U3Q3dLVW8wdG9JZGlO?=
 =?utf-8?B?TlU4cUZDZ3dxYjFPVnNYdURxTTExOG1yOHU2c2xtTEt0MWRMV2xzWVpaMThF?=
 =?utf-8?B?VjZMQ0hNSVNIQ2I4M1R1aVI5WHB1YTZVNmd6d2IydnJtUTA3SGRlSzRiODNT?=
 =?utf-8?Q?taAZbptl+zI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnhMejA5WVY0eEprMHVaU3lFNUJGZkNBa0YrZzZKY2lXSzIyUUlBcXEreWdK?=
 =?utf-8?B?U3ZGNDJpVjlGelFDRmI4RHJFZE1zanFMWWxEdytJbjdzcGVkNTg5WDM5M1Jv?=
 =?utf-8?B?RlZPbzRUTHl1bjV3ZEY2YjB0dFJMdkl2Yk51K2Q3dDh0bWEvMFpLSFRQdHVH?=
 =?utf-8?B?blZ2QjJ2c2lPRVpQak5HVlUyMHVxVzY0M3pxckIzMWl4dCt5OEd0eVVXUUox?=
 =?utf-8?B?MFZPR1FSZ2d0ajdubSs0Ujk0RnZhYUZMcHN3bVNQWnovRnM3MCtSSTZsUTc5?=
 =?utf-8?B?TVp2dnErQ3MvbFBFWmEyUi9VakcwK3o4R3l3eXVwOHZXR2xMRDVycy94UGsr?=
 =?utf-8?B?emRoUXA1ZEdwLzc3WjN2TERPZmdFVWlxTkMyV1JjQ0Zxc1JLblBQdFdFWEhw?=
 =?utf-8?B?VnlOUXhDRjVvTEdZR1hhQjFxYi80aGlIOE9yZjluaGdYSGVXYUhvSVo1UHdU?=
 =?utf-8?B?Tkw5MWFHNkF6L3VoY0V3OFdOM0xxTGswSE9wNnpHVWhFL2ErUFpzdjBIYVpR?=
 =?utf-8?B?NnJUMFh3ODFvQnc0Y3d3YWhmU0RidzlxNFE2T2dRZWROSXhRUG1hZCsxaWFy?=
 =?utf-8?B?RGN2U0ZaWUhmQVVmd1phRjh1TUdJaHkzUFFBeGxmU2RDREJIUHhleWNDYmxT?=
 =?utf-8?B?MzBiODdTM3hyNmpvRHJIL3p6STNvQ3llTTY4QWY1Mnh5ZEcxdGE0ZEJ3cE5z?=
 =?utf-8?B?TXorS210ZUx4SVl6dGZkOGEzNnRNZmJPVG93UGxmWW1rWExEak5rUHVjTGh2?=
 =?utf-8?B?dDM4Rk0wVVFaQ2VGSHgyUXBaQTFpSGJpWHREdUVJRjIrTHBBTmhOQWdFWmox?=
 =?utf-8?B?WkhzdXJncXdoc0tWNG5VQzY3ZFk4Tk8rVkM5TnhESnJoTlZiNFZhRVlnMDVS?=
 =?utf-8?B?T0dFa2ViV3FMay9seXhnSmRKY0F2UG5vU2dGMVY5YnV4YTFFNEpMSStHMEJk?=
 =?utf-8?B?cWphbXJYYWQrQlVXQ01OdVJiZ012SjZLL2JUbkt6bVI4bEcyOWFmVXNHb3JK?=
 =?utf-8?B?TXdDK3p6Y2E4UmsvRVE0d0ZoTDY4MnZBUEdCNXlEaVlqVzF5b2ZyVmlQaE9o?=
 =?utf-8?B?ZDJYejluUlpvcXgyaVE0eFpuUzY0N0RPS3NxeXV5WEY1MDAwV3NZUG5sMXF0?=
 =?utf-8?B?UG53R3FLbUhWZGFLNTh1YjAxWi90VE5NNWtmMVM1Mnl1dmtkUnJUL2hscE5N?=
 =?utf-8?B?ZUY1aTFxaThXY09xY1NOMGtHTWUrbXRtbGRUQ2c0SVg1d2RpWFg3cEFNRVlz?=
 =?utf-8?B?NnJpWThDSk5Cc0RZZURndHRkbkhVOWh1R0NYNzhEUkdpaXlWemo2M1NXSmp1?=
 =?utf-8?B?Si94UGxsbnpZaWwwZWV6MENGTyt6YjZ1VUpITEZDcmlJd2V5QzVNMFUzSGh4?=
 =?utf-8?B?dXJKVjJydXdkbTdsOEtzTmk3MUt5L2ZHQStQbFpaejhFbjRpaGs4WlNtdnNQ?=
 =?utf-8?B?R0tEWkFRT2poeFNCSS9lTnBuZm5hR1pRcEVmR0hPTW1xWG9QdG9mUkRQSVY5?=
 =?utf-8?B?bU01eXFXak1tNzV1U0JnNERZN204UU9KMm5GMzFkcVZqRTZWWUNtTE10T0h6?=
 =?utf-8?B?TXN2bllaVTRwUlFrM0tSZGV6K0FEMXBrL2NJRU9yR1JrUlN5eG1QbnlEQXdD?=
 =?utf-8?B?dXlVdFBaRWNsTEJrK1NIWThueFFPUURtK0FEMDQxak5FUHNpZUFQSWxhampX?=
 =?utf-8?B?UWt5Z3RRTVBjN0ttcTR3ZURGRDlUNWE1d1U0Q3pqdm91OUlRRDVxSlNUQnJi?=
 =?utf-8?B?aGFEaStSWHdhYWVMQ3RvZWxaRzZSaG1zeVNxTE1HalJoUHBkS2tIUExYTnln?=
 =?utf-8?B?aE45bHJkaVRiUlRGNWhDZGJ2V09mMVhidWlOaHl2ZHdzRmhzNlFlU0hWVW11?=
 =?utf-8?B?WGZNQXdXUEVTU0J3QytFYXZKWDNLUU02MHFVR0RDdDJrZEp1VkpINWFVYTZN?=
 =?utf-8?B?MVVDTHZURGoxS2ZIc2lrU2cvUDhkVHFpZ0VYVHhMTm9uZDBrUVgwZ1lVeExT?=
 =?utf-8?B?cUxwM0l3d1paWEY2N2Z6TzdRQ2dCamFtV1lEbzdQbmo1OFg3TnpzaHpURTdx?=
 =?utf-8?B?TVhSNFNUSWhiSDdsK3NKZVBRL2tjYkMvY0I1T0FTc1NndkRoUExuTm5PZndQ?=
 =?utf-8?Q?TG7OqTbfAiataZ1Z+h7lDo0QM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2ea86b-254e-4bba-8ad7-08dd8271dce7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:19:30.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2Hkwt4a1rC8w6Jc/8fDjSgjrdQ3Uj1BZJ95ArVWQLmd1FhbGvPQ0CNgKxT3JMb7UF5/kwa52mO/1fr6YXEJNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447

On 4/23/2025 7:35 PM, Mario Limonciello wrote:
> On 4/21/2025 11:02 PM, Dhananjay Ugwekar wrote:
>>
>>
>> On 4/21/2025 10:23 PM, Mario Limonciello wrote:
>>> On 4/21/2025 3:04 AM, Dhananjay Ugwekar wrote:
>>>> Initialize lower frequency limit to the "Requested CPU Min frequency"
>>>> BIOS option (if it is set) value as part of the driver->init()
>>>> callback. The BIOS specified value is passed by the PMFW as min_perf in
>>>> CPPC_REQ MSR.
>>>>
>>>> To ensure that we don't mistake a stale min_perf value in CPPC_REQ
>>>> value as the "Requested CPU Min frequency" during a kexec wakeup, reset
>>>> the CPPC_REQ.min_perf value back to the BIOS specified one in the offline,
>>>> exit and suspend callbacks. amd_pstate_target() and
>>>> amd_pstate_epp_update_limit() which are invoked as part of the resume()
>>>> and online() callbacks will take care of restoring the CPPC_REQ back to
>>>> the latest sane values.
>>>>
>>>> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
>>>> ---
>>>> Changes in v2:
>>>> * Modify the condition in msr_init_perf to initialize perf.bios_min_perf
>>>>     to 0 by default
>>>> * Use READ_ONCE to read cpudata->perf in exit, suspend and offline
>>>>     callbacks
>>>> ---
>>>>    drivers/cpufreq/amd-pstate.c | 67 +++++++++++++++++++++++++++++-------
>>>>    drivers/cpufreq/amd-pstate.h |  2 ++
>>>>    2 files changed, 56 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index 02de51001eba..407fdd31fb0b 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -389,7 +389,8 @@ static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>>>>    static int msr_init_perf(struct amd_cpudata *cpudata)
>>>>    {
>>>>        union perf_cached perf = READ_ONCE(cpudata->perf);
>>>> -    u64 cap1, numerator;
>>>> +    u64 cap1, numerator, cppc_req;
>>>> +    u8 min_perf;
>>>>          int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>>>>                         &cap1);
>>>> @@ -400,6 +401,22 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>>>>        if (ret)
>>>>            return ret;
>>>>    +    ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
>>>> +    min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
>>>> +
>>>> +    /*
>>>> +     * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
>>>> +     * indication that the min_perf value is the one specified through the BIOS option
>>>> +     */
>>>> +    cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
>>>> +
>>>> +    if (!cppc_req)
>>>> +        perf.bios_min_perf = min_perf;
>>>> +
>>>>        perf.highest_perf = numerator;
>>>>        perf.max_limit_perf = numerator;
>>>>        perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>>>> @@ -580,20 +597,26 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>>>    {
>>>>        /*
>>>>         * Initialize lower frequency limit (i.e.policy->min) with
>>>> -     * lowest_nonlinear_frequency which is the most energy efficient
>>>> -     * frequency. Override the initial value set by cpufreq core and
>>>> -     * amd-pstate qos_requests.
>>>> +     * lowest_nonlinear_frequency or the min frequency (if) specified in BIOS,
>>>> +     * Override the initial value set by cpufreq core and amd-pstate qos_requests.
>>>>         */
>>>>        if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>>>            struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>>>                              cpufreq_cpu_get(policy_data->cpu);
>>>>            struct amd_cpudata *cpudata;
>>>> +        union perf_cached perf;
>>>>              if (!policy)
>>>>                return -EINVAL;
>>>>              cpudata = policy->driver_data;
>>>> -        policy_data->min = cpudata->lowest_nonlinear_freq;
>>>> +        perf = READ_ONCE(cpudata->perf);
>>>> +
>>>> +        if (perf.bios_min_perf)
>>>> +            policy_data->min = perf_to_freq(perf, cpudata->nominal_freq,
>>>> +                            perf.bios_min_perf);
>>>> +        else
>>>> +            policy_data->min = cpudata->lowest_nonlinear_freq;
>>>>        }
>>>>          cpufreq_verify_within_cpu_limits(policy_data);
>>>> @@ -1040,6 +1063,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>>>    static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>>>>    {
>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>>>> +
>>>> +    /* Reset CPPC_REQ MSR to the BIOS value */
>>>> +    amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>>>          freq_qos_remove_request(&cpudata->req[1]);
>>>>        freq_qos_remove_request(&cpudata->req[0]);
>>>> @@ -1428,7 +1455,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>>>        struct amd_cpudata *cpudata;
>>>>        union perf_cached perf;
>>>>        struct device *dev;
>>>> -    u64 value;
>>>>        int ret;
>>>>          /*
>>>> @@ -1493,12 +1519,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>>>            cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>>>>        }
>>>>    -    if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>>>> -        ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>>>> -        if (ret)
>>>> -            return ret;
>>>> -        WRITE_ONCE(cpudata->cppc_req_cached, value);
>>>> -    }
>>>>        ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>>>>        if (ret)
>>>>            return ret;
>>>> @@ -1518,6 +1538,11 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>>          if (cpudata) {
>>>> +        union perf_cached perf = READ_ONCE(cpudata->perf);
>>>> +
>>>> +        /* Reset CPPC_REQ MSR to the BIOS value */
>>>> +        amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>>> +
>>>>            kfree(cpudata);
>>>>            policy->driver_data = NULL;
>>>>        }
>>>> @@ -1575,12 +1600,28 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>>>>      static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>>>>    {
>>>> -    return 0;
>>>> +    struct amd_cpudata *cpudata = policy->driver_data;
>>>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>>>> +
>>>> +    /*
>>>> +     * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>>>> +     * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
>>>> +     * limits, epp and desired perf will get reset to the cached values in cpudata struct
>>>> +     */
>>>> +    return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>>>    }
>>>>      static int amd_pstate_suspend(struct cpufreq_policy *policy)
>>>>    {
>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>>>> +
>>>> +    /*
>>>> +     * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>>>> +     * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
>>>> +     * the limits, epp and desired perf will get reset to the cached values in cpudata struct
>>>> +     */
>>>> +    amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>>
>>> In EPP mode this appears it would be OK because the perf value should get reset in the resume for amd_pstate_epp_update_limit() but in passive mode won't this never get reset on resume from suspend?
>>
>> In passive mode, on resume, amd_pstate_target gets invoked through the code flow mentioned below,
>>
>> Cpufreq_resume()->cpufreq_start_governor->(cpufreq_driver->start()&&cpufreq_driver->limits())->amd_pstate_target() [this is for _target() based governors]
>> For schedutil, start_governor will register the update_util hook and it will be called at every util change, which eventually calls adjust_perf()
>>
>> I tested these scenarios using "sudo rtcwake -m mem -s 10" (suspend to mem for 10 seconds) on a server system, within 1-2 mins of the wakeup the CPPC_REQ MSR
>> values of all CPUs get updated to sane ones. It would be helpful if you could test for such scenarios on the client systems as well.
>>
>> That said, there might be a small window between the resume and governor trigger, where the value in CPPC_REQ MSR would be invalid. Are we okay with that ?
> 
> For server systems it's probably not much of a big deal since servers aren't frequently suspended, bu this window of time seems untenable for a client machine.  As a user that would mean effectively they have wrong limits programmed after wakeup for 1-2 minutes and could potentially have performance gimped as a result.
> 
> I'd say let's just flush the right value immediately after resume and then the write 1-2 minutes later becomes a no-op.  With the checks we have in the driver now I expect that they don't even turn into MSR writes.

Makes sense, I'll add this and post v3

> 
>>
>>>
>>>>          /* invalidate to ensure it's rewritten during resume */
>>>>        cpudata->cppc_req_cached = 0;
>>>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>>>> index fbe1c08d3f06..2f7ae364d331 100644
>>>> --- a/drivers/cpufreq/amd-pstate.h
>>>> +++ b/drivers/cpufreq/amd-pstate.h
>>>> @@ -30,6 +30,7 @@
>>>>     * @lowest_perf: the absolute lowest performance level of the processor
>>>>     * @min_limit_perf: Cached value of the performance corresponding to policy->min
>>>>     * @max_limit_perf: Cached value of the performance corresponding to policy->max
>>>> + * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
>>>>     */
>>>>    union perf_cached {
>>>>        struct {
>>>> @@ -39,6 +40,7 @@ union perf_cached {
>>>>            u8    lowest_perf;
>>>>            u8    min_limit_perf;
>>>>            u8    max_limit_perf;
>>>> +        u8    bios_min_perf;
>>>>        };
>>>>        u64    val;
>>>>    };
>>>
>>
> 


