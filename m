Return-Path: <linux-pm+bounces-22410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A61A3BC3D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327BC3A4A49
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73AB1DE896;
	Wed, 19 Feb 2025 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1G81ik0y"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63561DE4FA;
	Wed, 19 Feb 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962666; cv=fail; b=CMdH6t/bTgqfpSB/aniYP1AHBVdwpAHk3vBrJiRcNzr8SV33oPsGJ9RJx0OoMwG5al5DnZQVOUGh6NS+BEfUJ6+tihvJRTzwwNVXiLOIeDshrinP0hLOGbCq4ZoCu1piLMsmcNOqKHrNWcDiYNqhitUU+kYvjNL59e8WnTlPlH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962666; c=relaxed/simple;
	bh=1f2bTaqm7Jdflxl5J4acinlxLUsKfizqF5l1Qubk+YY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dTsRwyxsAorXaaG5Rr0EgJpQn+aV/FGVioAUjl1wkMn8CFMxMdPnOInhc9nTFVS1XfYPV4r6HWmxbV39S3m8Y+hl/0OQA2ZHNXPbmZMLBnlAeXPRkdgY3HZkvrXArTd7eimnxFRvrNiB3RBpeG0CEwbFUgfIMKVcwyznxgfVgDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1G81ik0y; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Cb2GEnw8QYmT5EW7UnMHtRvXZ/pz508Ka5qB7o/V90Ua2iouee2h5izhNfmonX4+vF5XcEl5ULVUUNX/AqG+AWv7qmCRCxXBnDWOvhaH+g7eIv3jjWVIY2+9nXFTZ49NtdmA7zq8CNO4o+SyhCVeOppRoDZs8f4g37KngeHrWh+7ak7oPKEg7RmFgYZkksHPkaV6fOTm1iDUgOj1z1c0EwiXvr7EMRQkdPfwCTRdv4F6fcoawLP0tBqKioFY0ZIZ1gYa9+x7CVHKHVQEw4Nd8ah7ZucM1+MKUxjcuTXPHodfLi6aDcxpswnu7kNUI3M9fW3VXJmICT6j9w5hS1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iXx91RMptBKxpuwvQnXkmoKsGuFwc6o7QooMwLheCk=;
 b=AdhANJCiNBBZoFS+HH3fYd3iSwdrEOdBrZF4Jxk7Z4JqgimtGvEAjp9DZ0mbfUEijqNtg+B/bVoMn0vW8t2CcwsmG/R4Isy2EJil4yRgMLhRCh0pb3SCozKIdDxFNAXn5e8HhWi4nVi7L02cmrJypMkkx0z4aHbpcXIwRYARlpZ0m50ri8B3twGpGDhKWdnfFvemvnWEFRE+xv6xWVMrdU2x5Smvvd3JPhsNH2sJfrP/caIzKFBnYEVnlEVVzHGLtxYg51V1l2DTP3G1eGI3pWxLWW4jSS1BegMuycjDFQ4WoUxtDAuFZnPrGw0hOluABiQ79oTcNA6XxBpq3w2fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iXx91RMptBKxpuwvQnXkmoKsGuFwc6o7QooMwLheCk=;
 b=1G81ik0yaEy/4W9pV2lYEpVzMUzGj55aoC2T/C3k1erOyHIR0+r3MjrYFTjnydXhPrstLliRVziK+fb1Ynx1STBJoFvl/rd1Js9m5b+QtfsPX/5FBaTz2LstZd3r7ZdtVd1GxltvlFYY1nPL9tBotVt2au6Dj2rp4ZzObmjYbAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 10:57:42 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 10:57:42 +0000
Message-ID: <ccac287d-5bde-4b0d-a1d6-b1e8b5f4e6cb@amd.com>
Date: Wed, 19 Feb 2025 16:27:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] cpufreq/amd-pstate: Move perf values into a
 union
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-5-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250217220707.1468365-5-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::17) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d31797-4319-47e2-a383-08dd50d43b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjdDV3Z6azd6cFppbWJLTDVBVFVKWTdxSFlXQlFuU05xZHgxTG1NLytJcjNy?=
 =?utf-8?B?N2hURVlCOHVFZzhhbTQ0RGlMMjQrbjdEMGZnSFg5YWJFVFdnblBKcWk3dUtV?=
 =?utf-8?B?dUU0Y1FNaVptc0tHNlVPM2tISWZTN2pFTGNTNGp3YVE4akN5ekl5Mk80RHp2?=
 =?utf-8?B?Nlc0M0orZWs3N25IVWY1Uk16WThqTlJyRzlheGNYNEpoT0F1NEUrc3JDeW9r?=
 =?utf-8?B?Y1BUMmMvUEpBZVlhWkYwNHdTZTNhMlljT0FVaC9YOXd2aGdWTGNpdGFJMlZQ?=
 =?utf-8?B?aUVqRnRCSFhWS3VzbzRYalpOdkI2YzM1NzRDV2N6aFlaQ0h3Z1o2N0xpQUkr?=
 =?utf-8?B?V2dBVlNLU3JPWHM2VzNOUTdNNGkrZG9vMEh4eGpPZkJYcTVhQU11QW5yRjhq?=
 =?utf-8?B?R1lZbUpSMHhZdlEyZjhpSVZKajFFbUxmOGxaRDRFZ2FqUXJONkI2UkM0TTVU?=
 =?utf-8?B?clNTU00zeTJOMW5vRXgrams5NVVWMUJsOVA5V2k0NnhiMXNiZ3RJR1l0UjEv?=
 =?utf-8?B?bkVqSnV6T1BqaEJsNnplR3h2TExETi8vSDZGbmVxbDAxV25RZkxkdkk2VGV3?=
 =?utf-8?B?ZEx0RXJDbE1YUVNzNmdWNDNZbXZPeHFpRkc5SFM3OTU0RGtFbGNZZ3F2c0NO?=
 =?utf-8?B?R3J0d2VkZnFITmdSTC9YMnFidEJWZFFLNHh5UTU0N1MxejN0Nkw2QlVZQnFr?=
 =?utf-8?B?R2cweDdWY0RNM0pPT2UzSVljUG00TXptSGgzMU90d0dWUVlqZHZ0d05PZXdB?=
 =?utf-8?B?aEE1alFCb1E2SVRzNUVveFl1RCt1akJuc2EvVlpGQ3dJdFZrc0FGU0EzTXFj?=
 =?utf-8?B?cDlJMnYyWGpJL3JkNTNoVGZJUWJVU3dYaDBnNUdpV1BGeVd3bHlKNm5QN0Vs?=
 =?utf-8?B?THE1bHpTNFZNWUtNNGxQTU9ha05VTkNXRHFLVWw1Tjl1eUhrdTJ4ZFk3ZVhz?=
 =?utf-8?B?TnJUcTF4MVVGeC9TQUJKTDlnOEc2VGV5RVVhMVRJQmF0ZGRZbHh1NGRBWThr?=
 =?utf-8?B?OC9wMkYxRHRLZVJnQS9OcHNjajB0bXdNRi9kL3FGREVZenhHTkNmWWJ5NUlD?=
 =?utf-8?B?enJaSnIwdUZLcnFwVWl0WWdFd3hNOTNud2gxeGpSamFKYzZIS3JxaWtGSE5L?=
 =?utf-8?B?SE1saWpHTVkwNm1QSk85Z0hDbFU4ekdhaVJsSFRWaVZrcTJIL0prYWFGdzFz?=
 =?utf-8?B?UktmT25tUlZzSi9XT1pmR21aOW9mbnNOZ0NQcHk3SEsraytoYXByQWlZUVlC?=
 =?utf-8?B?RVJ4d0s0NHNjM3EyNXNFN3pBRndXUUVnN3VBdUVsUklmYVh2VSs2TUVXNmV1?=
 =?utf-8?B?ZnNrRGcycmZEOUNTaXJzZlA4akpLTjNkdkxoNzlMb010UTFBNk1QZDlMV0Nq?=
 =?utf-8?B?TzhVdjFCMVBPc0xVQXdNaGNING02c2ZZS2ZYNk5uSkFJVGcydW9RSkdwK2Zp?=
 =?utf-8?B?MkRRb0NISEdxMkZOTWN6RlVidW9xMzJtWUs5QlpnN0Fwa3hrUmdpaDZVbHg3?=
 =?utf-8?B?RTN4c1pqbktYUm4xRXpZU2h4WjEwZmVVTHpNRkxyUzEzaUppMjlqb2d5bmhK?=
 =?utf-8?B?MkF6S1lwSHlaU1ZSTUtXL3YxbFg0NHovaUpQejBuRlIwa3ZMa3ZsbkRTR3ZL?=
 =?utf-8?B?Q1BmN3BSODVHQytwKzJqTjJOWjZRanRRSWI5Z1dtTzZYRlN5dGNIRkYyRFRT?=
 =?utf-8?B?SkdBTFBHTEpIWXhUeE9tNWhhTitwZENacVdyVnpWQjNiUkIvWjg1RUFScGlP?=
 =?utf-8?B?NUs4MVoySkhnbHBhZUFPMnhxOGtkOG5RQ1NPTEZBSlJkenNUb3V2ZW5xbGVV?=
 =?utf-8?B?WHlNQlF2cThsdUtucFpNbUlERmUxMzNPMTMvOVlCdnMyOGxPbm82b0tTN25u?=
 =?utf-8?Q?Qgc21hP/2tN21?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzZyNkJlY2ttSEVBd2ZIMUIwV1pKYzlpcG40MHc3UlFSK0xwa1AyMmtlVEZt?=
 =?utf-8?B?cnIxbUJBVHV0Z1dzbUl5YnVWeGt1cDdzRUswOTJTOUhYMUFzUFJ0Wksxd1hn?=
 =?utf-8?B?S3V3TmJkU3JqMWZ1cVR1Zy9HWXFWWXpvWFhpSldHSlJIczNkZ1plVUljQlB4?=
 =?utf-8?B?ZEFZa0hSQmtrMUFCRlZKeFNONjlpNExaVUIraStiR29uR3JZNlJRUDJaWWw1?=
 =?utf-8?B?dHVHMUpIZnordkZUNWZkRXhNcFJ1MjVvTGlFbUhyM1ExVGFQd1B2eFJvcDQr?=
 =?utf-8?B?bnBkMFpXRHRmbGJmU0FNc0czWlZCRit2Wk5uQ1dhb1hJRE81NjJBNVorb0Nm?=
 =?utf-8?B?Uk55ak4yRGd3eUpldWZuOHhSMGgzTVNTNmthOGlXTWE0Uk14Um1ZQ29PRzNr?=
 =?utf-8?B?UDlLcHJKR2N5ankxU0l3UFBTOENlODZLZDRTU1hkQ0FVOXFGdkMvY2hvQlVW?=
 =?utf-8?B?M29LZnY2dzVWb1N3b1RsYm1OdWJPUlluTEpFNDE3NjRzZVhGOVdlcS95NkRI?=
 =?utf-8?B?R1B0Zmc1eXdkVnVtS0FCMVcxeTROUlliRHZtNFhNdDBBcnV0RE4veXIyME90?=
 =?utf-8?B?ejBMb0xTWVRsSWdieWwrejlBUllYTTlQSzBvNW14WlZlVkg3RG9taE9CaEVt?=
 =?utf-8?B?dy9LZWpMZWkweWZ1UloyVkhpK2JPQ2tiUHdWOWJUbDJoYldwK0M3KzEwUXBV?=
 =?utf-8?B?Y2F3RkVoK292L0xUS2VnU1YxRXBXR0lmSEFwSXpRUFQvU0FnQUQydGpFZTRm?=
 =?utf-8?B?RFZKUGpyZTFoSnBqbUd6WVhHVCtpOGpLcHEvQkZFNUxPNEZ3N2xyajZpczFG?=
 =?utf-8?B?ODlvQ2lkRkI4TnkrWjRkaHVCTXFMWS9rUWxEK3NJL0srbm1KT3FtZi9vYmgz?=
 =?utf-8?B?a2VGVXh0Q3JjT0d0dlp6Y2tGbm1PMnBwYkJkMVZnV2hSdXRkMWMydVZHOU8x?=
 =?utf-8?B?N2JJcUJCVXJsNTFvV3cvaW9pRzdsL3NEdUJ5YVlFOC9OZ1lLeXhuOVM3R3Z3?=
 =?utf-8?B?Z2VuWGQ4ZDR1dlRzZHdNUFNVS0FmU291NFYyMXZoSXFFN0JQUVRrTUUyZkVi?=
 =?utf-8?B?R0V0bkFtVW9QcFRuTzY5RzBqSzdxOFRkbnhXSUg5TUdPSjhsY1VzSGZxZkJw?=
 =?utf-8?B?c21MaVpGTWQ3NTBDUHVQemNJakJtZ0llUmxybkZEUHd3NS9CTFV6UVBWVnVU?=
 =?utf-8?B?MTA2U2x6ZzdPaGZzeDhMcm83TjNqMGFYNno0UzVzak9wVUdQWWlnSEdUT2ls?=
 =?utf-8?B?L0RDQ0libllpSUVtQmVHVTVoajNTZXZWRjRqOEJzU2c5RDZ0QTdJcWZxN3F5?=
 =?utf-8?B?WVQ5a1J6c2hZQ2ZWMUZ6RFM4VzZvWEcwRlZrT0VWeEJQNk9qVWVENHl3ZTZU?=
 =?utf-8?B?WUhickZCTUFoOWhQaUY3bUpQQVBYODdZU0hEZjNPVGFuYkRleWxCdFFjazFx?=
 =?utf-8?B?czJnNFkyek8xNmJxOWtJMEUzWWltV3IrL3FRZElxQmdHY0hEa3lsRVh1SHRY?=
 =?utf-8?B?bTlsVnVqYWRtZVNjaFRTbTlZS0lrd1lTYW1sVlhhNWk1N1djNnRHYUJMd2t4?=
 =?utf-8?B?ckxsWDFNN25kK2QvTmJad1pCSDlzMnZlK1BwVldqVFVWZERLN1lZTDdvVWow?=
 =?utf-8?B?ODZNeXl3RGt4ODVLdlp4TEtqdFpabldEUG5SSTMzUFpyVloxTjdPSmgwMmJ2?=
 =?utf-8?B?em12bEY4ZkZBNm83Wlg4RkJkbXJ4YzNBNVpNQ0RtUTljZWcwOFBkR2tTK3FI?=
 =?utf-8?B?SEtsRjJVcGprazdYZGxGSHRhbHRJaVYvVU50MHB4bDlaRnV6RGtkUVlXc0VD?=
 =?utf-8?B?UnR3M0M4a0Z5dDhlTlFZNDlDZzFLTlVPSHNUcTBGVU9ZUndvWGtYTmI4R0x0?=
 =?utf-8?B?MEhKb1R3azIyVlcwOW43ZFVzTnQ4clo0UXBPR1ZBenpSTWxvVHhYVlFkMTBD?=
 =?utf-8?B?MWR3QlZ0bTMyMDJBMzVHYm5iNStwSDdHbXVFaXU3YW5JMmtBOUYyWldqOC90?=
 =?utf-8?B?dzZuTktXeWFRVmFHNmc5LzhVVGg2aXdtVVdQT1BST254VUhQeHE3VEpyQjFm?=
 =?utf-8?B?Q09iUVh1ZHgwSUV1SzlpdEtJU1BBa2VVMkl5ckgwbXF1amxFVDJ3TERkc284?=
 =?utf-8?Q?5LjhTollIK9h1B3uHG51mM7AB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d31797-4319-47e2-a383-08dd50d43b97
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:57:42.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qF2nanW8jjUUWUxep9jYqY0l3X61K7hz9FmC4uKFz3pYiq+jBoJ+Iy4JWJPkgIfR6LPuR0XpDUo/GUCEvPcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

On 2/18/2025 3:36 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> By storing perf values in a union all the writes and reads can
> be done atomically, removing the need for some concurrency protections.
> 
> While making this change, also drop the cached frequency values,
> using inline helpers to calculate them on demand from perf value.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Pick up tag
> v2:
>  * cache perf variable in unit tests
>  * Drop unnecessary check from amd_pstate_update_min_max_limit()
>  * Consistency with READ_ONCE()
>  * Drop unneeded policy checks
>  * add kdoc
> ---
>  drivers/cpufreq/amd-pstate-ut.c |  18 +--
>  drivers/cpufreq/amd-pstate.c    | 195 ++++++++++++++++++--------------
>  drivers/cpufreq/amd-pstate.h    |  49 +++++---
>  3 files changed, 151 insertions(+), 111 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 445278cf40b61..ba3e06f349c6d 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -129,6 +129,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  	struct cppc_perf_caps cppc_perf;
>  	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
> +	union perf_cached cur_perf;
>  
>  	for_each_possible_cpu(cpu) {
>  		policy = cpufreq_cpu_get(cpu);
> @@ -162,19 +163,20 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
>  		}
>  
> -		if (highest_perf != READ_ONCE(cpudata->highest_perf) && !cpudata->hw_prefcore) {
> +		cur_perf = READ_ONCE(cpudata->perf);
> +		if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
>  			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
> -				__func__, cpu, highest_perf, cpudata->highest_perf);
> +				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
						  Can we use cur_perf.highest_perf here ?

>  			goto skip_test;
>  		}
> -		if ((nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
> -			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
> -			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
> +		if (nominal_perf != cur_perf.nominal_perf ||
> +		   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
> +		   (lowest_perf != cur_perf.lowest_perf)) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
> -				__func__, cpu, nominal_perf, cpudata->nominal_perf,
> -				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
> -				lowest_perf, cpudata->lowest_perf);
> +				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
> +				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
> +				lowest_perf, cpudata->perf.lowest_perf);
			          Can we use cur_perf.(nominal/lowest_nonlinear/lowest)_perf here as well ?						

>  			goto skip_test;
>  		}
>
[Snip]
> @@ -888,25 +896,24 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>  }
>  
>  /*
> - * amd_pstate_init_freq: Initialize the max_freq, min_freq,
> - *                       nominal_freq and lowest_nonlinear_freq for
> - *                       the @cpudata object.
> + * amd_pstate_init_freq: Initialize the nominal_freq and lowest_nonlinear_freq
> + *			 for the @cpudata object.
>   *
> - *  Requires: highest_perf, lowest_perf, nominal_perf and
> - *            lowest_nonlinear_perf members of @cpudata to be
> - *            initialized.
> + * Requires: all perf members of @cpudata to be initialized.
>   *
> - *  Returns 0 on success, non-zero value on failure.
> + * Returns 0 on success, non-zero value on failure.
>   */
>  static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
> -	int ret;
>  	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
> +	union perf_cached perf;
> +	int ret;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
> +	perf = READ_ONCE(cpudata->perf);
>  
>  	if (quirks && quirks->nominal_freq)
>  		nominal_freq = quirks->nominal_freq;
> @@ -918,6 +925,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  	if (quirks && quirks->lowest_freq) {
>  		min_freq = quirks->lowest_freq;
> +		perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);

I think we forgot to write back this value to the cpudata->perf variable

>  	} else
>  		min_freq = cppc_perf.lowest_freq;
>  	min_freq *= 1000;
> @@ -934,7 +942,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  		return -EINVAL;
>  	}
>  
> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
> +	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>  
>  	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
[Snip]
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 0149933692458..8421c83c07919 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -13,6 +13,34 @@
>  /*********************************************************************
>   *                        AMD P-state INTERFACE                       *
>   *********************************************************************/
> +
> +/**
> + * union perf_cached - A union to cache performance-related data.
> + * @highest_perf: the maximum performance an individual processor may reach,
> + *		  assuming ideal conditions
> + *		  For platforms that do not support the preferred core feature, the
> + *		  highest_pef may be configured with 166 or 255, to avoid max frequency

s/highest_pef/highest_perf/

Also I think this statement is bit confusing, how about,

"For platforms that support the preferred core feature, the highest_perf value maybe 
configured to any value in the range 166-256 by the firmware (because the preferred 
core ranking is encoded in the highest_perf value). To maintain consistency across 
all platforms, we split the highest_perf and preferred core ranking values into 
cpudata->perf.highest_perf and cpudata->prefcore_ranking."

> + *		  calculated wrongly. we take the fixed value as the highest_perf.
> + * @nominal_perf: the maximum sustained performance level of the processor,
> + *		  assuming ideal operating conditions
> + * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
> + *			   savings are achieved
> + * @lowest_perf: the absolute lowest performance level of the processor
> + * @min_limit_perf: Cached value of the performance corresponding to policy->min
> + * @max_limit_perf: Cached value of the performance corresponding to policy->max
> + */
> +union perf_cached {
> +	struct {
> +		u8	highest_perf;
> +		u8	nominal_perf;
> +		u8	lowest_nonlinear_perf;
> +		u8	lowest_perf;
> +		u8	min_limit_perf;
> +		u8	max_limit_perf;

Just a thought, how about adding the "u8 desired_perf" (last requested) and "u8 prefcore_ranking"
in this. We can pursue it as a separate patch if you want.

I think there is value in adding desired_perf atleast, so that when we are caching the 
min, max limits in the perf_cached variable, desired perf level is also atomically 
updated into the shared cpudata structure.

Thanks,
Dhananjay

> +	};
> +	u64	val;
> +};
> +
>  /**
>   * struct  amd_aperf_mperf
>   * @aperf: actual performance frequency clock count
> @@ -30,20 +58,9 @@ struct amd_aperf_mperf {
>   * @cpu: CPU number
>   * @req: constraint request to apply
>   * @cppc_req_cached: cached performance request hints
> - * @highest_perf: the maximum performance an individual processor may reach,
> - *		  assuming ideal conditions
> - *		  For platforms that do not support the preferred core feature, the
> - *		  highest_pef may be configured with 166 or 255, to avoid max frequency
> - *		  calculated wrongly. we take the fixed value as the highest_perf.
> - * @nominal_perf: the maximum sustained performance level of the processor,
> - *		  assuming ideal operating conditions
> - * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
> - *			   savings are achieved
> - * @lowest_perf: the absolute lowest performance level of the processor
> + * @perf: cached performance-related data
>   * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
>   * 		  priority.
> - * @min_limit_perf: Cached value of the performance corresponding to policy->min
> - * @max_limit_perf: Cached value of the performance corresponding to policy->max
>   * @min_limit_freq: Cached value of policy->min (in khz)
>   * @max_limit_freq: Cached value of policy->max (in khz)
>   * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> @@ -68,13 +85,9 @@ struct amd_cpudata {
>  	struct	freq_qos_request req[2];
>  	u64	cppc_req_cached;
>  
> -	u8	highest_perf;
> -	u8	nominal_perf;
> -	u8	lowest_nonlinear_perf;
> -	u8	lowest_perf;
> +	union perf_cached perf;
> +
>  	u8	prefcore_ranking;
> -	u8	min_limit_perf;
> -	u8	max_limit_perf;
>  	u32	min_limit_freq;
>  	u32	max_limit_freq;
>  	u32	nominal_freq;


