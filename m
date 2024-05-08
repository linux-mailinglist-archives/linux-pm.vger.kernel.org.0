Return-Path: <linux-pm+bounces-7644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073A8BFD04
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546C51C21E9B
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E31839FD;
	Wed,  8 May 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xgp3Fbar"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564637C097;
	Wed,  8 May 2024 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170786; cv=fail; b=aM1L5wH/fWt9fr0Pqax0cF3GY8BelKqwBDGQrOjKB6337CDe2L1VGnx1OR6QkyDKNyePYvyjJn1M16puzVbMocMS+Cp40D/bDejxObXTBTG3j+WwKDpjiUHmdpZMvkqMEB1aVksYsOXF8cehPhL0oGO2/W2Vm6k5hznl9ItatRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170786; c=relaxed/simple;
	bh=1y1RI7Sea5T7nuoQU0gKG2thDBVQmnhUhJmJUwabn/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K7JAjgfokeUsv5S9tbk8MsOyuxMx1SbZ3nVUvUMQSYnwrxBXHf8kAKP4MB508AMDjOHbrFOSCqpghC0L1Uqgssbp+yjYPlFFn0iJXJQ9EnZgSDjBfJ0VmP18sUGGyIggcgnujLLkSYlFNJjLFibdu50dS7IBt2m9Q4PYMiwu2AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xgp3Fbar; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S197EA6CSQ9t5eV9WTRuqVAFruodOzvTnxzcZnjk0Qcp7fU44u6JuknpQlwLHK+ysQPSRaA9Vqzdugz5Pt5Xn5IFIBCgjau2CSVFGEuFPlzmPDljgoc78N+y0yzTNEBON5PCtQ+Smljt/AQFJ3vboxipK8n2Lr8RoxEeEBqhq3CaX7U87GCWF4bkIPviiBtrH4JwmqNpBLzwX7tWXoX2y2kqaXiL91Vh1yc+UEIRwjy1ue8e6hYd4z9L7zNskQAhP8E8gOI4ig+c1G6/duoKz1Dx53INRoeFPtbucWOUmQ/hOdNPMyNrORIfxzOn41ZYXopkS1lqGToyDYTS6gOVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y1RI7Sea5T7nuoQU0gKG2thDBVQmnhUhJmJUwabn/c=;
 b=A1Eb33RpEND+JvJMVYca/VZRyaY06X3m/h0ehhQkrfkoC3R2FS4ecDQqTCooAtgrSgRNqyMVt1TdaPYC96EX4KtL7AY+NAnwIMnevl4e2WxSV0fc2AZnbzOg+iIzomJi3rVHEXXtQLrrOQaHKBaXnOWkvWj4Xp7CWrGGPE0wLYt8mcqgn0ciQiPt/zjbHsaWgy7SDBL6EsCotCSUYkr+JJ0DnHA/MgcZLzDgkddJ+gZdB8RCk/Z5OJhYh/HIBRvubno8sgn5Ofsx+kEdZQAd3ZoV/APjaLjoNTEPc9q+Vs9pYPkxSlkOxcwYrF/+ifCf4ftUbJO068ERO8cMXBv6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y1RI7Sea5T7nuoQU0gKG2thDBVQmnhUhJmJUwabn/c=;
 b=Xgp3Fbarln8x/llAvbJ7YA5RJMaItT5xCpIuy2dy+doQeulDUGwnNoXCUhgA4Skvw9KejrXPlnRsELmnpXCAbmTLAYWZWX3vi8kfttzmLTycXoB5XWSiYo+PTftCO5D0NmboZY4U47cGPvFiTclrmwCZPaimHYYUuz8JjYZ1ql0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 12:19:38 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 12:19:35 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: amd-pstate: fix the highest frequency issue
 which limit performance
Thread-Topic: [PATCH] cpufreq: amd-pstate: fix the highest frequency issue
 which limit performance
Thread-Index: AQHaoQs/992Uob0qukCVL8lM7bAS+LGNPB2AgAAFRdA=
Date: Wed, 8 May 2024 12:19:35 +0000
Message-ID:
 <CYYPR12MB86554D39473227E8C3F0446F9CE52@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240508054703.3728337-1-perry.yuan@amd.com>
 <CAJZ5v0iqEj0bx72Rqn--srv8Y+ievjZx6W8_kJksPzPVTLLqxQ@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0iqEj0bx72Rqn--srv8Y+ievjZx6W8_kJksPzPVTLLqxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c5015486-fc8b-4f9f-b894-4dff70e623b6;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-08T12:17:46Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|LV8PR12MB9109:EE_
x-ms-office365-filtering-correlation-id: 1e3cbba8-c35c-4488-1f34-08dc6f591fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlhNUDU4TzZoTlYxdUZMQTFNR2lUdytxc2VwVEl2SS8wWVJ4aEFLaU41V3py?=
 =?utf-8?B?dUp0TDYvK0RXaElVV3YvNXdaY1FCTGl0TkxXNS9zekRTQ2Y1R1laMEJMOVN2?=
 =?utf-8?B?Ny9VU0FYeG1XQmxaU0xOSUF2Qlpldm94VFhUQSsySmpnUzBlT2ZRSVdXUkcy?=
 =?utf-8?B?S3lTU3Y5YjloZU54b3FHSDBXaGwxSEs5dFFDb3VhVXVoVlpuNUVUSVY2elV0?=
 =?utf-8?B?M041MGFsaTNEb2pKMzRIbE55bGdKNVRXc2RNbGY0anJrWEVWQTl6bDNLUy94?=
 =?utf-8?B?Zy9UQmV2dkRvQTNXRTIraUxEbWpXNTIxaHBIUWRhazJ0U0pUeWFqTUhqZ2lR?=
 =?utf-8?B?eHkvb2FMbVJUci9xWCtrY0RpS25NTWFuUklOSjYxdG5BU1BxTmwxS0lSa09J?=
 =?utf-8?B?R3h3NDI3QmFVcmk1YTF4emYvYjUyY2xiSUNYeVpkTktQMERlTUhneVlCSTdk?=
 =?utf-8?B?Y2xFMkhrWDR4bndoUkpUL3pHOEcvMUQxdHpLcS91eFB2YU8wS0ZlWU5DaTF6?=
 =?utf-8?B?Q29EaEp0ZnlOakJjNkxKbDVsT0hOVmk1dlFHRnRoNXhBQVR6cHVZeWZpMzRM?=
 =?utf-8?B?blV3K0MxUUNUTWZJdk9RVmNWT1V4WU56bndWTXVtZ3VNemZSVXZnY2ZWc21I?=
 =?utf-8?B?Zm5BY0tIS3YyRDdTTEJSOGJJcFBScGphbHcwQktoOVFMUGpCOEREVXBwSlFH?=
 =?utf-8?B?QXpyUEYwSjlpL21CbVYzMmlzejNwajZUTndkVUpMUnVEZkxtYURwcTduUC9M?=
 =?utf-8?B?bkJySkNMTUIwbFF4L1UyaWVjQ2UvRUxyVEhiekVJdm9WdmdDNHJCMmVWZURH?=
 =?utf-8?B?M3RwdlVNNzRVQzRWMytrY1JSMmtpWkRGM1hNaWhUdTNhcDdmUWM5N0dKaitY?=
 =?utf-8?B?ZnFBL0Y2c1QwcGsvU0FuaHdqcW14MmhocGVRbUhTWHU5dnJXcHY1cnBabnE1?=
 =?utf-8?B?UENwNnlyYWlVR1kraU1DZjRLRDBFNmR4NS8vb2tTMFB1RlZBQjZYbTkwSlZu?=
 =?utf-8?B?ajB5UlNTbGdjTTN1MGRFWmtHNHZLK2Qyb1FYdDVkdGQ5cmc5RFYxeUZtVUth?=
 =?utf-8?B?cXBXQi9yUGtISDZrdy9yTkE0TTBaTzNuUlA1bDR1WlNiZlNVc1cvaWc4SDR5?=
 =?utf-8?B?akwrRTFKNGlSNGZQa2h6Q2JNOVhiR0J4dTMxNDQxZHFoWmhMZ1hvZGdjaHJR?=
 =?utf-8?B?UmozSDM3NzBtSWUvYUFzYmFuL1FpNEFBVHhSaHg5b1hpNUtxY3EreGFVeUlM?=
 =?utf-8?B?VFlUakVrVElvaUc3bzNPa0U2MEZXSnM2dzBySnNZVkRqWXRvcGd0YWVhL0xJ?=
 =?utf-8?B?aVplWDh6ZXJYSmljbVJ6ZVFRcWpvUFJEVWM1V2JyUUpUMnRxc05yTHF3d2hW?=
 =?utf-8?B?YkVkMTNEWlg1b0dGbkh0Smo0MGlFUXVlejM3QTZua2FuZ2hGL1pjKytPSXEy?=
 =?utf-8?B?TTRKRkQ2cFRhUkJRaGNBRkplTG1INkdDNURNdVU5VW1pQnN6M1JJRWNTbzdl?=
 =?utf-8?B?TTc0MTRBZTFPRnIxcjR6SDhTMHNaOEdlb05FckgrWkhMdE5NOGRZc0lBNUZl?=
 =?utf-8?B?Tys1alF3Y2duT0RuQUMvK2pGL1NWSE01UEVwYWMrd2k2ekxkNjF5T0tYNVBy?=
 =?utf-8?B?bUJrUXNsSU11UktwNDZlOWhSankrd0dMVk96NVpYa1h0dTFzU0hHVWFWYzlw?=
 =?utf-8?B?Y3VTN1dkVFRsTUpKK0QxZGZ5ZitFejA2c0hScVRlbk1GMEZmZ0JHSFBRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWVyTStQUGpaempEbG5JSDZGWHBxbTU2WXVXS0xvbm4vTmR1WklWRXBMMHVG?=
 =?utf-8?B?QngrSktIT204U21UMXV1Y0tnaFUzTVFNMVltYkpHaE0zb3JuV1hvUTl0VVJw?=
 =?utf-8?B?Y3NSQ3N4Smh5WXl3aUxUdmRHcVVyVWt0SXdhTlZiNWozcWVNcjFLVXFvTVdR?=
 =?utf-8?B?enY1Rm5WbG1ydmlsMzh2bTJxVDFRMW0vKzFpRTFDaFhSTmhlWGNjTFk0MWZp?=
 =?utf-8?B?M05MZnd1UjBkQXNNbmdQNDFqM21LS2RONkRrNHpQQm1mcitLa0xlWTR6UHpH?=
 =?utf-8?B?VU01WVpia3hzTjVpMHlicnNBT1o2K2tlYmRvLzh5TWx3TjllY2xMTlVNclln?=
 =?utf-8?B?bmV2ZnhaSVhXaFhBOFZOUUQxVWQ4azdaMjNqUEd2dVI3MmQ4aHd1ZXpEdVpP?=
 =?utf-8?B?dFFCNTBPUkl0anE5RXYwSWY2dzlMMGg0Y1BjTElENVc5NG9INE01Y2RaSkd3?=
 =?utf-8?B?Z09XTzlROFpsMUZqaGdNVUVjQmMwb2lCUlB6dE5KUTJ0aW8vd1FLNE9PdzVZ?=
 =?utf-8?B?RTh1TW5vQXVsc0ZYOVpJOURvK1RFOXNIa0gvU0cxamNpMXFoai8zdUZoc3Rs?=
 =?utf-8?B?NVJuQmgzeW84aVR0dEtSeUtOblJsM21iTXF2c1FLaUlRazBtZWdlSmxLbmRD?=
 =?utf-8?B?cEYxN2JzMk1wcW9yQ3F1TFhvL0wrb21lMEdoWDdXcnlsUmMwWXFPcnd2cjBP?=
 =?utf-8?B?V3JZNHZ0V0xvaklEUFhsSzIrWUlWbnF3aE1tYjF1YXZYaHpyc3dqekNIcjcr?=
 =?utf-8?B?TTh6aW5BNkRYcFloT0JuUjZFR3FUMm54RlNDYmlSVENGVlNMdU5xaDZTb21Z?=
 =?utf-8?B?bnNzcEFXb0U0RGYyWHhRM2N6ankwQWFYYzU2U0F1Um9RUG9kTWRkUCtISHNY?=
 =?utf-8?B?QnYzQ3VncENVbkNOaEkvQWV2d2QxK0FXQngvc28vZ1Brcm5xVWlTU3lDajJa?=
 =?utf-8?B?NVFpUnoySDVjQjVFRkZ6aXp5dnhBa1V4SGU4WXZRZFFrQ1JzbVRBVGtJVzFs?=
 =?utf-8?B?bkkrMjBmYXVJZzgwUzliNy9iY1Q4bWVOajY3bXBiU3F4WjRUU0wxajJPN2dV?=
 =?utf-8?B?T1dyVmxoWlRvRXNHdFJBeUhHOHp4SlFSR0ZZbmtKT1BCZ3J3SWE0ZWVjR2dD?=
 =?utf-8?B?RC9ra0ZVbm5vVEUwRWRMSlVuaXNudXY0Z2crd3VIaGJHRmZXMDExdGRPTjdk?=
 =?utf-8?B?bmJNaUJqYW4vclVvRjdpTEZyZ0pnNFlrdzdVVGtqSzQxZ240bDdUVlVKV3ht?=
 =?utf-8?B?T0hvUGUzMlRmR1VrMjRRM1V4M1lLa0RRUVl2aDJyTk90bFZhV0JiVE9yTHV5?=
 =?utf-8?B?UEhUZnpWRG9nUVd2MEhFdnorQTZEQ1JqZ2ptbUJvR1oyYnFDbTdvanYzTFFP?=
 =?utf-8?B?aVFNdzQvdFVUMDRmbW5WS3ZPVkIyUW9zRVlXZEs2MExQc0djNXJFdExmNlB0?=
 =?utf-8?B?S28vNWpHUThlaHN1S3RLV1p0RXVaUTdER3MzeXdpTHd2QjJzVlRpNyt5RExj?=
 =?utf-8?B?N0h0NUNUSGtJVEdTMVdDcUJmQnR1T1JPM0R2S0pzeHh2WURRdDhjbVl6MzI1?=
 =?utf-8?B?RGRlSi9HNDFheWIvZ0hyUnN3c0tURmFXSHZ2U2FtTkxnNVhWRFQvMzk1UC91?=
 =?utf-8?B?dDlsVm9odExaa0toaXhYeFZteTEvWDh5UGZVdzRtOFd0TG85UWsvV2ZPdW9Z?=
 =?utf-8?B?MHN5NTBsb1o5eVp1NkxCeFVVcWVjWnRUWlZwMFd0b2l2WDRrRTIxbWtRRG5Q?=
 =?utf-8?B?R0dwMXVhWTJCN2lYVVljMTM0VmhnQ1dXN1UrU1JISlB0VkQ2VmhrTWVxbjc0?=
 =?utf-8?B?cWxNSmY0aE9VYUxuck93a2VXNE1GZWVDY2pWeUREem40YWdIMnE3Rk9tbnJw?=
 =?utf-8?B?VmtWU3I3NFBWaTdSaS9sK21UZ0pMNnIrRDlPUVo5dUh3Y2NLazV4S2MzVE95?=
 =?utf-8?B?eFdMcnM2YVNpdnBSM01pL0JRYzM3Q3dzNDcwSHoxOWpCRDhHWElpOGQzMVlj?=
 =?utf-8?B?a3huWVpDM0N5QWxETndMVS9OUk9kZCtkajZlYnFMOWRNMnJzY0Voc2wyVEg1?=
 =?utf-8?B?SlpEcS9jREdNNXUwUEdRMUU3M3U2bUNlcTd5SUlpaC9oUXU3STNpVUFGVzBI?=
 =?utf-8?Q?MBJk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3cbba8-c35c-4488-1f34-08dc6f591fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 12:19:35.5177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMbloqb1gYY6v4AeosGA3F89w/ebuSJmC6G7la1WeGphjmPpbMSeQwv7fhq/h+sQExkNcJ/F8rGBG+uKJnsA8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxA
a2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgOCwgMjAyNCA3OjU5IFBNDQo+IFRv
OiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogcmFmYWVsLmoud3lzb2Nr
aUBpbnRlbC5jb207IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1k
LmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5DQo+IDxSYXkuSHVhbmdA
YW1kLmNvbT47IFNoZW5veSwgR2F1dGhhbSBSYW5qYWwNCj4gPGdhdXRoYW0uc2hlbm95QGFtZC5j
b20+OyBQZXRrb3YsIEJvcmlzbGF2DQo+IDxCb3Jpc2xhdi5QZXRrb3ZAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBTaGlt
bWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1
QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51
eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNwdWZyZXE6IGFtZC1wc3RhdGU6IGZpeCB0aGUgaGlnaGVz
dCBmcmVxdWVuY3kgaXNzdWUNCj4gd2hpY2ggbGltaXQgcGVyZm9ybWFuY2UNCj4NCj4gT24gV2Vk
LCBNYXkgOCwgMjAyNCBhdCA3OjQ34oCvQU0gUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29t
PiB3cm90ZToNCj4gPg0KPiA+IFRvIGFkZHJlc3MgdGhlIHBlcmZvcm1hbmNlIGRyb3AgaXNzdWUs
IGFuIG9wdGltaXphdGlvbiBoYXMgYmVlbg0KPiA+IGltcGxlbWVudGVkLiBUaGUgaW5jb3JyZWN0
IGhpZ2hlc3QgcGVyZm9ybWFuY2UgdmFsdWUgcHJldmlvdXNseSBzZXQgYnkNCj4gPiB0aGUgbG93
LWxldmVsIHBvd2VyIGZpcm13YXJlIGZvciBBTUQgQ1BVcyB3aXRoIEZhbWlseSBJRCAweDE5IGFu
ZA0KPiA+IE1vZGVsIElEIHJhbmdpbmcgZnJvbSAweDcwIHRvIDB4N0Ygc2VyaWVzIGhhcyBiZWVu
IGlkZW50aWZpZWQgYXMgdGhlIGNhdXNlLg0KPiA+DQo+ID4gVG8gcmVzb2x2ZSB0aGlzLCBhIGNo
ZWNrIGhhcyBiZWVuIGltcGxlbWVudGVkIHRvIGFjY3VyYXRlbHkgZGV0ZXJtaW5lDQo+ID4gdGhl
IENQVSBmYW1pbHkgYW5kIG1vZGVsIElELiBUaGUgY29ycmVjdCBoaWdoZXN0IHBlcmZvcm1hbmNl
IHZhbHVlIGlzDQo+ID4gbm93IHNldCBhbmQgdGhlIHBlcmZvcm1hbmNlIGRyb3AgY2F1c2VkIGJ5
IHRoZSBpbmNvcnJlY3QgaGlnaGVzdA0KPiA+IHBlcmZvcm1hbmNlIHZhbHVlIGFyZSBlbGltaW5h
dGVkLg0KPiA+DQo+ID4gQmVmb3JlIHRoZSBmaXgsIHRoZSBoaWdoZXN0IGZyZXF1ZW5jeSB3YXMg
c2V0IHRvIDQyMDBNSHosIG5vdyBpdCBpcw0KPiA+IHNldCB0byA0OTcxTUh6IHdoaWNoIGlzIGNv
cnJlY3QuDQo+ID4NCj4gPiBDUFUgTk9ERSBTT0NLRVQgQ09SRSBMMWQ6TDFpOkwyOkwzIE9OTElO
RSAgICBNQVhNSFogICBNSU5NSFoNCj4gTUhaDQo+ID4gICAwICAgIDAgICAgICAwICAgIDAgMDow
OjA6MCAgICAgICAgICB5ZXMgNDk3MS4wMDAwIDQwMC4wMDAwICA0MDAuMDAwMA0KPiA+ICAgMSAg
ICAwICAgICAgMCAgICAwIDA6MDowOjAgICAgICAgICAgeWVzIDQ5NzEuMDAwMCA0MDAuMDAwMCAg
NDAwLjAwMDANCj4gPiAgIDIgICAgMCAgICAgIDAgICAgMSAxOjE6MTowICAgICAgICAgIHllcyA0
OTcxLjAwMDAgNDAwLjAwMDAgNDg2NS44MTQwDQo+ID4gICAzICAgIDAgICAgICAwICAgIDEgMTox
OjE6MCAgICAgICAgICB5ZXMgNDk3MS4wMDAwIDQwMC4wMDAwICA0MDAuMDAwMA0KPiA+DQo+ID4g
djEtPnYyOg0KPiA+ICAqIGFkZCB0ZXN0IGJ5IGZsYWcgZnJvbSBHYWhhIEJhbmENCj4NCj4gVGhp
cyBzaG91bGQgZ28gaW50byB0aGUgc2VjdGlvbiBiZWxvdyB0aGUgdGFncy4NCj4NCj4gQW5kIGlm
IHlvdSBzZW5kIGEgdjIgb2YgYSBwYXRjaCwgcGxlYXNlIGluZGljYXRlIHRoYXQgdGhpcyBpcyBh
IHYyIGluIHRoZSBzdWJqZWN0Lg0KPg0KPiA+IEZpeGVzOiBmM2EwNTIzOTE4MjIgKCJjcHVmcmVx
OiBhbWQtcHN0YXRlOiBFbmFibGUgYW1kLXBzdGF0ZSBwcmVmZXJyZWQNCj4gPiBjb3JlIHN1cHBv
cnQiKQ0KPiA+IENsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNn
aT9pZD0yMTg3NTkNCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFt
ZC5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGlt
b25jaWVsbG9AYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8
bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEdhaGEgQmFuYSA8Z2Fo
YWJhbmFAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0
ZS5jIHwgMjIgKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0
ZS5jIGluZGV4IDJkYjA5NTg2N2QwMy4uNmEzNDJiMGMwMTQwDQo+IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEv
YW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTUwLDcgKzUwLDggQEANCj4gPg0KPiA+ICAjZGVmaW5lIEFN
RF9QU1RBVEVfVFJBTlNJVElPTl9MQVRFTkNZICAyMDAwMA0KPiA+ICAjZGVmaW5lIEFNRF9QU1RB
VEVfVFJBTlNJVElPTl9ERUxBWSAgICAxMDAwDQo+ID4gLSNkZWZpbmUgQU1EX1BTVEFURV9QUkVG
Q09SRV9USFJFU0hPTEQgIDE2Ng0KPiA+ICsjZGVmaW5lIENQUENfSElHSEVTVF9QRVJGX1BFUkZP
Uk1BTkNFICAxOTYNCj4gPiArI2RlZmluZSBDUFBDX0hJR0hFU1RfUEVSRl9ERUZBVUxUICAgICAg
MTY2DQo+ID4NCj4gPiAgLyoNCj4gPiAgICogVE9ETzogV2UgbmVlZCBtb3JlIHRpbWUgdG8gZmlu
ZSB0dW5lIHByb2Nlc3NvcnMgd2l0aCBzaGFyZWQgbWVtb3J5DQo+ID4gc29sdXRpb24gQEAgLTMy
Niw2ICszMjcsMjEgQEAgc3RhdGljIGlubGluZSBpbnQgYW1kX3BzdGF0ZV9lbmFibGUoYm9vbA0K
PiBlbmFibGUpDQo+ID4gICAgICAgICByZXR1cm4gc3RhdGljX2NhbGwoYW1kX3BzdGF0ZV9lbmFi
bGUpKGVuYWJsZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdTMyIGFtZF9wc3RhdGVfaGln
aGVzdF9wZXJmX3NldChzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpIHsNCj4gPiArICAgICAg
IHN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9ICZjcHVfZGF0YSgwKTsNCj4gPiArDQo+ID4gKyAgICAg
ICAvKg0KPiA+ICsgICAgICAgICogRm9yIEFNRCBDUFVzIHdpdGggRmFtaWx5IElEIDE5SCBhbmQg
TW9kZWwgSUQgcmFuZ2UgMHg3MCB0byAweDdmLA0KPiA+ICsgICAgICAgICogdGhlIGhpZ2hlc3Qg
cGVyZm9ybWFuY2UgbGV2ZWwgaXMgc2V0IHRvIDE5Ni4NCj4gPiArICAgICAgICAqIGh0dHBzOi8v
YnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE4NzU5DQo+ID4gKyAgICAgICAg
Ki8NCj4gPiArICAgICAgIGlmIChjLT54ODYgPT0gMHgxOSAmJiAoYy0+eDg2X21vZGVsID49IDB4
NzAgJiYgYy0+eDg2X21vZGVsIDw9DQo+IDB4N2YpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gQ1BQQ19ISUdIRVNUX1BFUkZfUEVSRk9STUFOQ0U7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0
dXJuIENQUENfSElHSEVTVF9QRVJGX0RFRkFVTFQ7IH0NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQg
cHN0YXRlX2luaXRfcGVyZihzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpICB7DQo+ID4gICAg
ICAgICB1NjQgY2FwMTsNCj4gPiBAQCAtMzQyLDcgKzM1OCw3IEBAIHN0YXRpYyBpbnQgcHN0YXRl
X2luaXRfcGVyZihzdHJ1Y3QgYW1kX2NwdWRhdGENCj4gKmNwdWRhdGEpDQo+ID4gICAgICAgICAg
KiB0aGUgZGVmYXVsdCBtYXggcGVyZi4NCj4gPiAgICAgICAgICAqLw0KPiA+ICAgICAgICAgaWYg
KGNwdWRhdGEtPmh3X3ByZWZjb3JlKQ0KPiA+IC0gICAgICAgICAgICAgICBoaWdoZXN0X3BlcmYg
PSBBTURfUFNUQVRFX1BSRUZDT1JFX1RIUkVTSE9MRDsNCj4gPiArICAgICAgICAgICAgICAgaGln
aGVzdF9wZXJmID0gYW1kX3BzdGF0ZV9oaWdoZXN0X3BlcmZfc2V0KGNwdWRhdGEpOw0KPiA+ICAg
ICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICBoaWdoZXN0X3BlcmYgPSBBTURfQ1BQQ19I
SUdIRVNUX1BFUkYoY2FwMSk7DQo+ID4NCj4gPiBAQCAtMzY2LDcgKzM4Miw3IEBAIHN0YXRpYyBp
bnQgY3BwY19pbml0X3BlcmYoc3RydWN0IGFtZF9jcHVkYXRhDQo+ICpjcHVkYXRhKQ0KPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gICAgICAgICBpZiAoY3B1ZGF0YS0+
aHdfcHJlZmNvcmUpDQo+ID4gLSAgICAgICAgICAgICAgIGhpZ2hlc3RfcGVyZiA9IEFNRF9QU1RB
VEVfUFJFRkNPUkVfVEhSRVNIT0xEOw0KPiA+ICsgICAgICAgICAgICAgICBoaWdoZXN0X3BlcmYg
PSBhbWRfcHN0YXRlX2hpZ2hlc3RfcGVyZl9zZXQoY3B1ZGF0YSk7DQo+ID4gICAgICAgICBlbHNl
DQo+ID4gICAgICAgICAgICAgICAgIGhpZ2hlc3RfcGVyZiA9IGNwcGNfcGVyZi5oaWdoZXN0X3Bl
cmY7DQo+ID4NCj4gPiAtLQ0KPg0KPiBBcHBsaWVkIGFzIDYuMTAgbWF0ZXJpYWwsIHRoYW5rcyEN
Cg0KVGhhbmsgeW91LCAgSSBmb3JnZXQgdG8gdXBkYXRlIHRoZSBwYXRjaCB2ZXJzaW9uLg0KDQoN
ClJlZ2FyZHMuDQpQZXJyeQ0K

