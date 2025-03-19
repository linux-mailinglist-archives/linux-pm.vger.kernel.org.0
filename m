Return-Path: <linux-pm+bounces-24270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5B9A683DB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 04:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F116B176D7E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 03:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202D624E007;
	Wed, 19 Mar 2025 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iGCbmW/L"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB35186E2D;
	Wed, 19 Mar 2025 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355817; cv=fail; b=guflCuSRJeBoJ1OwLtI3WWHs2pQmr5+Z3ilqA/BDA4Kp2A/o2Z5CRdJdgcA8UJavsnHxlX51w3ffEhn8oiokwxE9OxZHBVrdQBAJI+K9+ddZJD8lioBSwfa2UN+vlWontj9jpIGTK941jJsJnmpgE2QSUZLjgc5n8CdUD9xFJ/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355817; c=relaxed/simple;
	bh=gR+PWDOmtJY3XPCyhQa8aWgjg0jFckidc2BgF9b/5Cc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IWGFjbht3fEqRURRMzwLx1QEYKMBGc64YG15GfWBMIn08u1JqNqyFNiKmrEwu4buG3rnCRKeLfUawM+INh59ZDBIF1t+5pL3y6qEjPiODifDE/AHtXpJxSUDt5919hJvBZKz1MZ2+OVbgIrHTy605vc7ZvBEvrTy9Mqay9GfFqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iGCbmW/L; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXwgOauZHW9s7s5XtXbr8BI4fPNQIiNP1u32d0TZGo39IaWn3TCQrqi0HCVvV4HyctzT0L8WTOjwYdgcv1Bf/QpIpkMTPV0xCwKszhIfnSmB01jtRuT3yYz7ejW74BsQAMQlXL7+daa0WW/VlXeyeJ27Ulpr6hzTxVTR6xquvr63t/Mdt2TK4Ee5h4vvGFLPni9yJt8448jZBeJZcfun/6JrG0ABH79PLQfi+NQaFXZBQYRuP9/6rzLG3aIiuk6fYJT4LPI4rjuRcEen3PCDIdHISlmTQaoIDEk+YO0FJNxAzkBoaSqsmUJlCcqwcDyh2ow8V+sHHu4Vsrw35D8ppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY+hojWXd20dwfE6U0uhA1Ip08op7qVFH1MCmPsC6p8=;
 b=fR8dK6+PZNxViVhn6Q98L9lv0o/LJTwyxd3mBu4WocFYD0lbSGJcEyaoytZZF76D5+rrH7M5chA0a2Ww/EtGqRZwQPQ5B1NVxlhDqV5siZQWr9Hzh8fXkeINh+gRwuZFobMAQdzDuIX/7CyPewR2VsYu96kqbXZcpRvGrAzjUEhp5jGdMCUBIvdwgEMKAGmxuCb+vzWvpxc89yIr8Fz2UsPK5yGdIs1yAs8jbN4AYxq9u5qi2X52j22gHy0Ktc1lC1kwg8pZiS5idpTHtI9GS+q6Fk4CSmBh47ZH+wj8QnofM4PJ5rVbvPHypCpTsE0Ghxk+4Mkom/uc8og2dbpJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY+hojWXd20dwfE6U0uhA1Ip08op7qVFH1MCmPsC6p8=;
 b=iGCbmW/L0lEr27Jplm6m+MbxYFyP3LqGDczS0yavTX54na+xeOQ17SjvVleZEbH0BmhOo2wPnNrN7uAjwPhWzS3yMJymp0nIPemc3wcVLmy6PPp1EV5b+vgUq494tO/CCYznaw3giyUsYgVC3vOokBOBKT3z3GxSnDtpxuzF/+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 03:43:31 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 03:43:31 +0000
Message-ID: <5eb7d32e-d251-4536-a4e8-61670aa34869@amd.com>
Date: Wed, 19 Mar 2025 09:13:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-2-superm1@kernel.org>
 <8e87fa8c-5254-46d5-a853-46e8c31cbe0e@amd.com>
 <4e0ab8ce-908e-49a1-8445-14129a41afda@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <4e0ab8ce-908e-49a1-8445-14129a41afda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: e67e7a68-f8cd-4c11-a8be-08dd669837a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVUxcmNTK2Z3MmpJNGpJTlJ2OWtGay9HZTJtdHIrVWJ4bEdvSTVyNkRQQmZx?=
 =?utf-8?B?eDNDS0VrSXpMSjgrZlR0WEF4QlVpcTRGMUxIUHdZajg2VTJCTUlxV0NVcVNo?=
 =?utf-8?B?aGluL3pycEI5ZVo1eGMzb3RBNFNLZ0M0TURYR1NZeVE0cFEyNmNYa0s0VmdL?=
 =?utf-8?B?aVk3ZGNCc254RjFxaVJXOVE1Nk5jT0ViVkFIaHBaYjErRE5xaXFndk9RbmNH?=
 =?utf-8?B?ODJpZXlPdWFuS0dMOFNhcXJyenU5dGFtS1Q4MzE4Tk9RMk5JcndMcFJybjJU?=
 =?utf-8?B?Vm9tTEUydVJxeHZNMi95ZTZHQUw5N01xS1g5YitaQU1qOWVndzFUZnpNVm9V?=
 =?utf-8?B?MDNaalRQZTRuQWVuZExKTWtOVnFLRGloTjRtd0tyUGppVVFSeUNSRzRUSEdx?=
 =?utf-8?B?R0VLTjZLTmloTVUrUkZTd2RNNU5pVm5Gc2tsb0FIcFdiaU1abDhVQkNSdjVm?=
 =?utf-8?B?Rm5WUjZiYlN3WWllREhwbTI3NXVLVXcrNURGOGVYdmNoc3ZzU1VkNTZqdTd5?=
 =?utf-8?B?NHE4M0RnUVh1cjR0U3Y3MDZGMVR4dmlZUWVJVW5UZWxaSWk3bnk3dE91MGVX?=
 =?utf-8?B?cFMrUVRPSThPbU1oYytJNHh1ejgwVGExTEFkaHpTMlg2UUcrTWVJLzBuS0V4?=
 =?utf-8?B?eHRkQ0J1ZjJyaUNoaXpFdEhlUUp1SHNFLzdVQ1pJdXkydjc2cm04M3p6Y1RT?=
 =?utf-8?B?aExwSkV4cHZYMFIydTdibUo0ZjJ4V1orLzB2ZER2Sk9nU1djeGRrMG5KUTNP?=
 =?utf-8?B?RWpLL2grUnpBN2F5Mm40YlV4dWl6blFQdHVOUVZhdENwRTNQWWJ1OFljaW1R?=
 =?utf-8?B?M2RaMTQweTUraWVYL3N5eGZibWRyNGhpU0lDeUk5MHJlNmFIMjhQUDJMdE1F?=
 =?utf-8?B?V0lsTDdQZnlJbktKZk9FZDNvOGl4dGNKdmhSdENYQ1FsWlJtZWxtUWRLbG9E?=
 =?utf-8?B?UVFmelBWby9TRE9IYkVKSTJxc3VTM0hyeEMzakJOeFhoaFVtckxuRUtiY0lh?=
 =?utf-8?B?TERudGlRRlE0MWdCaXZPdWh0STg2bDNpZ2I5cHEycWdTbGZvMTlDV3RnSTRJ?=
 =?utf-8?B?anlGQTFDN2ZTenc3Zm1XMm1oNTRVNkVKOXNsa0VlU0pkdDhRRXhoUFVlLzRt?=
 =?utf-8?B?SXh1U3craSt0eGNEeW9lWlVrYUluYWpEOUF6cHpyR2tsNlNjbEpqeXFTVEcy?=
 =?utf-8?B?MWRiYUk2R3RPNU5Ia0wzWFhlL2lqVTQwYWNRVS9sZ0U3a0JtWEFVMkNkclBs?=
 =?utf-8?B?RXNhM0lhRlY1WUtYNGgxcW9JT1h6clIzN1IrRUs2RjlwNmhsUjVKZDFOTXNE?=
 =?utf-8?B?L0k2Z0xkc2ZYZDhSd2tIamgwbVNDVG5yc1EzQVllSitlNWExNWJreFEydm9C?=
 =?utf-8?B?Z0l2Y1h3WUVmekxRaVhRdlNKL3EvUEpOZUlUeFN1LzRjRm5LNkUyVFRYbHdv?=
 =?utf-8?B?R1BBWjFGRlJSS3d6VmRDTUtNNWFUa1ZsdCt4MkNpQlVBREZIYnRwU3QwQzBJ?=
 =?utf-8?B?YnJVbTY4VDdYdDRZYUZzTmowbGlMc3V6SjBRVVViTXI1c01weC8rVURnSldE?=
 =?utf-8?B?b3JaMzJxV1crUXowOVp1d1JndFY3Mk1oWm1heHozT1FhZUMvWU1aVDlscTNU?=
 =?utf-8?B?QkIxZ0N5eUFqakdJb1hSVWIzbFRqMEp5bnhGUUx0M0VIcDZtZGNJNU12NzVy?=
 =?utf-8?B?NDQ1VHZhYjk2dFd5UDdSUExOVTVlU3RYNHF4RldWNTJzZWFMR1ljMU1xMm5Q?=
 =?utf-8?B?NjF1Rm5Id2pOZjdXTENRbzZIdVFubzM0aXR6MXhLWkNRczR0bklsU21HODZq?=
 =?utf-8?B?azU2WHZ6WXFmOWFSd1NvaDBjcURwRTRsMngxSWdwTmF3RjVKQXRidjdiV3NP?=
 =?utf-8?Q?qIYuCbH01XaTv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEtBY2MrVkVaa1p2eVNROGZ1cXFqUTlZYnpqRW03d0lPVTRtbDYyVFRhcURP?=
 =?utf-8?B?cG9oQzNVOE8yekNFMXgxWDBSUEJ5a3AxbzNmTHMyZzdvMFh3bkhXSzZ1dEZE?=
 =?utf-8?B?RnowOTNERURUWkVFN3VRaE9HbjBTS3dMMXR1cGN4YXFPSXBOSXdSQ2U2SW9F?=
 =?utf-8?B?dWErS2M4bE1Mb052aUZ2U1pHamdpTjJVVnVMZWtvMUJtSUFObEJ4WitnaEli?=
 =?utf-8?B?bVFuZXN0UlpOSXJpMFI4SC94cWFBY0lJTTkrRFNzWUZJbHdnZzlYT29LblFS?=
 =?utf-8?B?bFA3SHhBVHBZU3pYa0VBSVJZOXdweUd3Tm5jWnI3ZHp3REl4bFRxOVk2clNM?=
 =?utf-8?B?c3JPOTRiRXYvMERHK3FGQkJORXVvdFRBMFJncVFNQ0VpQWFUM01nUXIrT3pX?=
 =?utf-8?B?Z2N4YWpibTU4eTFqaDBWOWVYQkQzMnlPeTYwbkV0V2NwVmxYLzBabWt2VkZR?=
 =?utf-8?B?WHBQWk53R3ZsMXo4OXkwcFNsa0dSWXBMbHBLWHpLSWxsaEs3R1pWUEt2anNy?=
 =?utf-8?B?bC9DZGI4TG5SdTFDTE5ET1lOUVdEWG0wK3JqVWlnZUZIS1JwTUZ1MGpsc3F0?=
 =?utf-8?B?S0RvaCt5K1hNaVJ2NlhvalVrVEVnTG03MGhMdHJHK0M3dGVydjBpdzVydDIy?=
 =?utf-8?B?Y25BNThBOE9YK0JxZ0t6Q1AwVXNROFZjYWdwZkxQQ3VJYzB3YWR0UmhtVHdI?=
 =?utf-8?B?Z3l1RjNSZ1NPNk4xang3MzFUcjZueUVuS3A0QmRqUmVBMFRxYXNlK20wZm5F?=
 =?utf-8?B?MkVobzlIbjE3dW5Ob1NIZ0NEUUY1VFBzOTZhMVZOdVExNXEwZnJlTWVCejQr?=
 =?utf-8?B?eFdNSENDK1dxRkdENGVQNTE4NUZOZzN0NUxvL0xpRURsc3lBc0xvWXZKUkRQ?=
 =?utf-8?B?MnpOU0dtMWhUTzkrTVNZMGhOTEtRYXQwdjJCZ25KeEpBN2NiYUZqSTU2WXEw?=
 =?utf-8?B?UnRMVFdNR2RDTVJvNWlJRG10Q3lwRjBQK1JHdjZ4UnJoZncreXJGNVByMUxX?=
 =?utf-8?B?Ly9GRGVPSXNZWk9YWDdJVnEwc2Uzc3Y2RWtJQ3Mrak4yd3BTMEE3K1NFUEhr?=
 =?utf-8?B?VDUrSGhpVnV2TkFGT2dUNGt0dVdiZUhST1JCeXEwQmRaSFhVdlpWVnQ2NnlY?=
 =?utf-8?B?Znc3cU1UYTZmMUF1ZjVWNThveEtuNGJSZG1xMmt1YkhkOEFVMUdTZ0M1QUNX?=
 =?utf-8?B?MDUydW04V2d1ZDdTM0lFT2xoQUR2ZTVjbms0VFRmcU1vYVJSVVBiN3BOZkJ0?=
 =?utf-8?B?eVhQb3lUZ1pjVmFTUURETnhMdjVndndNREpEUVNwNDN6cWdGVFVOck1kM2gr?=
 =?utf-8?B?OWpUZlp6bGdWbWhJS210Ym4vWDRsbW5RU2t2cVNkMFd6WHZKMjBtRTdCQlhr?=
 =?utf-8?B?cXlVeGpCUXEvYmp4TzBYU1Uzd1owWkVuUmNVTFI1NHVudWpLNU5SZnR0SE1t?=
 =?utf-8?B?RkZZSm5hVmUyV1NwK1RLTDJ1RjNwMURMQWEwVm5rdDdxd3l3ZDQ1aUZkbWJv?=
 =?utf-8?B?QkY0akU3K3k4c3IwTkgvYVBBVXBBYldGbm1DVkd4WWlaQXRiZkU1a0RoN2ln?=
 =?utf-8?B?UTNGQUU3NFJoQ2tOeEpaNWpyY09UVVJUS09aV1VMYWdxWjB5dUM1K2lRb0Y2?=
 =?utf-8?B?RkFhSlJNbFlHQk05M04yckc2UkZESnRlL1dzM0RXUFRhcmozMGhWQkkxNVl5?=
 =?utf-8?B?YnZaSXp4WWJJUW1WaVlhWDlkdkhvSFU4U0xrUTZHd1diNzVqdGFhU0tiZTNj?=
 =?utf-8?B?eGYyOXNIekMyakJlK0dhdkJ3WHQ3SnRaMXpHS2RaUWxiaUR0ejFWclFJTnNC?=
 =?utf-8?B?eExBazlGeHNWK29vYS9qNHBIWk9VZXNDNEJZRWduVFprcXViM1liSUR0NS8x?=
 =?utf-8?B?bTkwQkhESkhmUTlJTllNQVBWdEs1MmxqVEZZS05xb1hVK2h1UnFML3kzSnkr?=
 =?utf-8?B?NHhVNlhpL2hoaHNxV3ZKVENISHpXWENZbGFhK2ZmVjNTRUp1T05QZmp6YW4y?=
 =?utf-8?B?THA0QWdUUlUwKzllQTNBVHRIdDVPWGV0aS9Fc2ZDUW9ncXFiZERyVmppKzUx?=
 =?utf-8?B?YkVRL1hGVkZTdUlOaWZhazNHUXRVTWx3dTBQSGd6K0hwdkpNWEJwL3hBVmhR?=
 =?utf-8?Q?FrlRnEl1KfkTPwtBl/E2nLn6k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67e7a68-f8cd-4c11-a8be-08dd669837a8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 03:43:31.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNWFJb93Yu5hnSDcLKNrzJ5ok92jar4uIsXtMgMo/l6SVe98j2l3XtH16AJiRHlFD5P0faXNPo2cTDCsxE+p/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113

On 3/19/2025 1:06 AM, Mario Limonciello wrote:
> On 3/12/2025 07:16, Dhananjay Ugwekar wrote:
>> On 3/4/2025 8:53 PM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Dynamic energy performance preference will change the EPP profile
>>> based on whether the machine is running on AC or DC power.
>>>
>>> A notification chain from the power supply core is used to adjust
>>> EPP values on plug in or plug out events.
>>>
>>> For non-server systems:
>>>      * the default EPP for AC mode is `performance`.
>>>      * the default EPP for DC mode is `balance_performance`.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v1->v2:
>>>   * Change defaults to performance (AC) and balance_performance (DC)
>>>   * Default Kconfig to disabled for now
>>>   * Rebase on latest branch
>>> ---
>>>   Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>>>   drivers/cpufreq/Kconfig.x86                 |  12 ++
>>>   drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++++++--
>>>   drivers/cpufreq/amd-pstate.h                |   5 +-
>>>   4 files changed, 155 insertions(+), 9 deletions(-)
>>>
>> [Snip]
>>> @@ -1556,6 +1667,10 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>>       if (!policy->cpuinfo.max_freq)
>>>           return -ENODEV;
>>>   +    /* policy can't be changed to performance policy while dynamic epp is enabled */
>>> +    if (policy->policy == CPUFREQ_POLICY_PERFORMANCE && cpudata->dynamic_epp)
>>> +        return -EBUSY;
>>
>> We might need to tweak this condition, because if we enable "CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP" in config
>> and boot with "amd_pstate=active" it lands here (cpufreq_online()->amd_pstate_epp_set_policy()) driver init fails
>> as the default governor is performance.
>>
> 
> The check is important to make sure that you can't go to performance mode after init.
> 
> I think this is the way I would want to solve it.
> Set policy to powersave before enabling dynamic epp for amd_pstate_epp_cpu_init().
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 824756ac0010e..4a0f561d0e2d1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1729,8 +1729,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>                 WRITE_ONCE(cpudata->cppc_req_cached, value);
>         }
> 
> -       if (dynamic_epp)
> +       if (dynamic_epp) {
> +               policy->policy = CPUFREQ_POLICY_POWERSAVE;
>                 ret = amd_pstate_set_dynamic_epp(policy);
> +       }
>         else
>                 ret = amd_pstate_set_epp(policy, amd_pstate_get_balanced_epp(policy));
			^^^^^^^^^^^^ (mentioned below)
>         if (ret)
> 
> Thoughts?

Yes, this looks good, because anyway there is no point in having performance governor and dynamic 
epp set at the same time.

I found one related quirk though, we are setting performance governor for server platforms in 
amd_pstate_epp_cpu_init() and then setting epp at the line highlighted above. We dont have a 
check in *_set_epp() functions for performance governor. This could alter the performance governor 
behavior if we set a "balanced" epp for it. I haven't tested this part yet. 

Thanks,
Dhananjay

> 
>>> +
>>>       cpudata->policy = policy->policy;
>>>         ret = amd_pstate_epp_update_limit(policy);
>>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>>> index fbe1c08d3f061..6882876f895de 100644
>>> --- a/drivers/cpufreq/amd-pstate.h
>>> +++ b/drivers/cpufreq/amd-pstate.h
>>> @@ -104,7 +104,10 @@ struct amd_cpudata {
>>>       /* EPP feature related attributes*/
>>>       u32    policy;
>>>       bool    suspended;
>>> -    u8    epp_default;
>>> +    u8    epp_default_ac;
>>> +    u8    epp_default_dc;
>>> +    bool    dynamic_epp;
>>> +    struct notifier_block power_nb;
>>>   };
>>>     /*
>>
> 


