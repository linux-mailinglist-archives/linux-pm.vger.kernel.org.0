Return-Path: <linux-pm+bounces-9137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED95490819A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 04:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C1F28405A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D77145332;
	Fri, 14 Jun 2024 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cS04hLUw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77F127E0F;
	Fri, 14 Jun 2024 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332106; cv=fail; b=BC9jIDMo8rqen5uu0IduhxOqCAXUXu9ZTNkovvjcqOenOz+rdTfUhsN+aKDl+vahShwr8pnEsP9J3PowQoAdgQhAYYnTG74NksDdSItZWTL32wj0AFYEQ0VckS5C2cOB6J7bh7JQj3wpLxCI6Act8LBbksCHTvtrPrX0YJbyZ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332106; c=relaxed/simple;
	bh=keX7w7ZfF0hTyLMwXE1Mk2Yl6vP4LqZ8eyizS05XwUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkclvvlFXivOqCzncyPjYAUD2xD2q8qpTg6W7rDWD612tykSe6FRgHOkwK7JS81twKsWp6KkGTJNS1B5Ado2mgcYsnXf1tqhYhHzr3kpth2j2EAHkHYoZR1+a5T+X1wdP8V5JQsuW9Bt0WSGXuhIpuIiaaMWXBJI3hApqBKYzzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cS04hLUw; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iywaVhrqQ/uuOip+x6ncy14K9/I872wwZFqyoBGUA1rwGLkYwZ7bu3g4gnQPbduIB+Sxxb+OZCsRTIy+PyhfMaYZueEzHWvaWIyBfN1yGBWMGcMOIcIl9+T/kH0BSWcLJbf35iGV9635bOkIaCqTSCX1DVhEi/4zp/N1abC68Sm2R8K2nTiGy0OBGLQfKUdNlHbnsyzpZ3B0sqNsVtbR6BSkTJERETgyF//q988DEu16jXrPtQ8VXricEmGTkf8rQsis501owGa/5iogmmOOmvTSiSL/SbG8Uc/4mNUkqDzrH3Gh9j5nNURUdx7ZDEJ7TSGS0Rc2/c/likEoWPNJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keX7w7ZfF0hTyLMwXE1Mk2Yl6vP4LqZ8eyizS05XwUE=;
 b=OZbqi9zWXMiP9cfA8VgX32fxweDOQKxQyVcquXeowpq//WXEfZKK0q2YdizbhQBsaam3kxTdgvGNWU6Z3k+5fQNjWwMMT8WGR1a820BfyLlRhWZ7L5ckaAxxmZm6du2DCH0B2rejMDSXSCiQdyVBfauISVWM7KoY/5+QGEtnfyWj88Bq8HF0iMl07xOtQ8tAc/hVeOFag8Co8VO5N8XwXNKF9sGv7w/tSnbpnXzCBUvuQWoPVltjo3UFdK65OUL2zYWmYrkzsrc0rXEkA2uTx35fQX3r0yrMomI4XVvo23yli6gteWOMsGPCvdL1oTFcaSBoEGVlGlYxU3IjkMVgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keX7w7ZfF0hTyLMwXE1Mk2Yl6vP4LqZ8eyizS05XwUE=;
 b=cS04hLUwFs4NwapDs8k28ozg72IFqlRajXepUbbOHzZdZzQA7woheWF94a2Fa9tgUfuKUobhUYfPrQfqqlzOaF4LQ0FJnNuvU95YjLcJRbF5/kxZT2JpgtNwapNnEXHc3ugvu/UzRW1SAWnPyQe11w0tkKgIiu/J3x9ySdD6+Pg=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 02:28:20 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:28:20 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>
Subject: RE: [PATCH v11 6/9] cpufreq: amd-pstate: Add set_boost callback for
 active mode
Thread-Topic: [PATCH v11 6/9] cpufreq: amd-pstate: Add set_boost callback for
 active mode
Thread-Index: AQHavWMfeL8SCg2MhEWhfGu3QttbLrHF+icAgACPGqA=
Date: Fri, 14 Jun 2024 02:28:19 +0000
Message-ID:
 <CYYPR12MB8655157AF67F1A508CCAC00B9CC22@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
 <c46eb6d79bd8e7068955cf993ffc6b726d86eb92.1718262992.git.perry.yuan@amd.com>
 <aa2f473c-38e3-44a6-a039-99b42d9a51d0@amd.com>
In-Reply-To: <aa2f473c-38e3-44a6-a039-99b42d9a51d0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bdbfc7e3-3369-4862-ad14-0569ba4e1585;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-14T02:24:42Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB8755:EE_
x-ms-office365-filtering-correlation-id: 985a7707-1b80-4361-9cd1-08dc8c19a7f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rnh2QTlNYXhROERORjdiWW1UcmFlOVNLR1MxK1k2T1h0VmpLdmpXdTFhczZC?=
 =?utf-8?B?RXNnV2FLMTJFMFBHbW5hOFBWd1U5QURXZHBrTzBsNHp6eUVUY1YwSng0VE1M?=
 =?utf-8?B?VHNUNTBTUnAvdHhlelE4elpWa3NJSzd2eGdTb09UeHFrbXloWXp6VmozWENY?=
 =?utf-8?B?ZDNiTTNHU0pZamx0QWdOSnVjeTNpc0EwTit1Qlduak9LWG1GN1FLNzl0OVlF?=
 =?utf-8?B?aU5uL0ZJbmczTklla2UvaktvMk5BKzd2cTZuVk94NEc5QTVISXhqNnZ0TVI4?=
 =?utf-8?B?YUZUWWNJL01WWjhsd1ppL0xpeEtYcUxCTUE0QklzOUtVRStkNEpMVDFIQWJj?=
 =?utf-8?B?OU16ZWVYKzUwNVNXejVSWXlCM1NoNE0zSHZBNWZJTHR0NEJZZzJkUHBZMklZ?=
 =?utf-8?B?TjJEakMzblpJWURaVWE4YVo0R1BDdEFOaWRTa3FYemlVdmRTZFY3Um5idmY0?=
 =?utf-8?B?WDUzVmlnWm00YTFWOGNtOFlnb1owRzNtOE9kcEpoY3VOMFRlWnUrSFdSQXg4?=
 =?utf-8?B?M0UwTHpRQSszZGhJSVh4NXZTT3NxRUxlTUF0VWVWYmltMGRYYWNpdzZIazRp?=
 =?utf-8?B?THBnS3FGQXB2TnhmVWdQWGR3OTlvYjZBWHFOQXhOWFcycVFXeVlOOWhhcFlO?=
 =?utf-8?B?RHdiRThxWnJPUnlQMVJ4eXZxZklQTDlMOWNDckQ0RlNoQlhoUnZzaVQwVkdZ?=
 =?utf-8?B?TWZlUnBubGFkUm9xT0FZN3FoQjBycVJPbjdjcktYTjN1UGp1OTdpVXhaT1FG?=
 =?utf-8?B?NHEvbFJCeGJ0a3MwSks2MWZRYTJxRFRHWlhRZmtTeWxpS2tDTE1mYk5LdUdp?=
 =?utf-8?B?RDhpR055aWJrR2pyNHg5UTZySkxpS3FwMlJ1VmdhV3Ewc0plVUFsQ3U1Q3FB?=
 =?utf-8?B?dmhmMDVYK1Zxc2NyMFpQb1VvZ1N5b0YybG9yK3NBY0NsWGlaOEYrdzN2citi?=
 =?utf-8?B?SThVd0xxa09ERlhWVkRTZklGbktlY1c3UURFOWZBWk9JQjZMWnNaTzEwYWRZ?=
 =?utf-8?B?c3BkeGNtY1hjQVJPOWZvSmhiOFdrSk51SmVSR2MzMDVlcU9NblFUN0NManZq?=
 =?utf-8?B?ZGVFYVdYejMrU2hjZkwvNU1RWkluTmRRM0ZEcFk2eUFjZ1J6aDJndXJqYlEv?=
 =?utf-8?B?TEM1d1g5TEJYL2xSaWxIN1BLT01OT2JEcmttUXBKUDAwSkF1eXVLdnRaYmdu?=
 =?utf-8?B?Q1pWUGQxblFFekM2cHNkOFZZSVBmN2lqVzh5SyswUmZ4dDVUTzFtd3EzL3NI?=
 =?utf-8?B?MmIxU0REQlhKd2UxKzNyZjZrZE40SmpiOHI5eHBhYjR2ZUV3OGF3QjJabS9i?=
 =?utf-8?B?U2V4QURiS0tMZitQWUMxSmhXVlZuNGlQUjJMTGdYdVVsbEpKdHAwRmVCS0NI?=
 =?utf-8?B?SlJ4cytMcGF4L25md2VsY0s2NkJLVnVhTCtJR1ZWVlBwL1NMUG1pbWx5bzZP?=
 =?utf-8?B?SUw2cExSYTdjZFB5aGxOOWx1QXYvMXNRMzlRbnFJcHJvaUNOTDA1MDFKYVdU?=
 =?utf-8?B?SG0xTk55VVJNVVRQNitKbFo5K0U0THU5RjM2d1FMUTBhcUtnSWlWd3hobDVO?=
 =?utf-8?B?a2p2NjJpV29KZldwWEFIV0FKQ2J5cGtxTTFtWGtwSGZMa3lVWWxWc0lNSVJl?=
 =?utf-8?B?cDlKVThBZ0dzYWh3dFM0eEU4SlZmWXlZRW1SRWNNUkZ0YXpjUWYxUVJQdG9M?=
 =?utf-8?B?QUFiM29jZ3A0NHpnSGgzUjVZNU9uYXNqbFJqOXA1Qk5ZbmUyM1VyQkdZZXdX?=
 =?utf-8?B?bCtGeTRIbUZkZjBCY0dqUzZPN2tsUEdwbEQweEFvdjJGTnV0RUNPNG1sbSs3?=
 =?utf-8?Q?I5Pu14X0PCzwxNknJCYF4dRTPb5BB6wzNenq8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVJkamd4N0RPbTF1bkdBaE8zVGtSdTV4bjU4ZlBZZUNLN2w2WmJwU0EvZy9O?=
 =?utf-8?B?ZFV2eW5vMk1qLzY3bnMxVGVudENRR3JKRWE3TnE4MEg1UE5mekJqZ2hxaDd1?=
 =?utf-8?B?L2lrS1lEMWswcmhoK2VaWEREQ1RRbG9adndpQjFwVzFPZTNaMU1TSkVBZXBj?=
 =?utf-8?B?SUUranFPYjlQWFhidlRRcmhteTJvTnZXZHZiV2s0NisxU0hKSGtJRDY3Z3Rk?=
 =?utf-8?B?bGQ0WWRHOG4rZENQYXdnajNHWFpQdUdPVUl1Z0g3VTlzOUhwa2dZVVBJZm9y?=
 =?utf-8?B?SlFTRDNpSUxKUGRHWmVVbFFGMmIxVzNCYklDUmtXWi9rRW9TNkJ1Q0plYlpz?=
 =?utf-8?B?R2tIU0hZeC9idjJuNEVuSmFJVWM5MGZwSjNUaVd4eVdDbks4WEM3RDBqUlpw?=
 =?utf-8?B?VG11ZTgyTmNnc09OUHRvNkpRK3MvTnZvU0Q5Z3J4bXJSZndiMDFyUjZ3VEZ4?=
 =?utf-8?B?VWowWUhFOUIzcnlOOE5sQzJoMkp0NHBtSGMvTHBod1BiTDViMmlaZEgrd08w?=
 =?utf-8?B?M2Z0eUljLy9hVW5adjQ5Y253czZaSEVZSDhGOUxQK1d2ZWFoTWxDN2lHVTVv?=
 =?utf-8?B?Q29uR1F5UkN1eVI2dFlvU0I3RWZWb3lMZG1WeUduNTJ0OUF1aHREVHBqL04z?=
 =?utf-8?B?ZjVwb2gvR3c4eUdFWEhmOThxd21xTy9jWnhyVHcvMXZvaUxXSS9HU1lFN1E4?=
 =?utf-8?B?K0g4UnhqWGczcE9XbXNUaXAvU2RyMnZ3b0dacWJHdzlIZTV3d2JYR0VTUnNt?=
 =?utf-8?B?Kzg1aW9XOHhGd3JVbDRnUTFZWTlVMGFyRUNqWnlaQlR5aEVjbkx2amdMUkFV?=
 =?utf-8?B?N1lTekNZMm5FY0dTdW9qZjRHSXV3M05FTTNhNGVnWS8wVUZSbXE0UXM3b3cr?=
 =?utf-8?B?aWlOQno3VWhlTEFSTDJXY2tMeVQ3dUJDVUp2YllPV3NSY2N5UWNTdDJNUmFI?=
 =?utf-8?B?SXU4dGcxdE9MNzNLZ3NlczlMRzFobFRnZzNMTHZFLzByMUZVRDBJRlRBVFh2?=
 =?utf-8?B?SXQrZmVyWGFZRmRSMHNxclNNVG8wQ2Y4eXo1MHF1Mnh3VHplRmVSWTQ5K09y?=
 =?utf-8?B?ejdBZHBwV3JiQlE4amNYRFp6dVpJL0syVGo5SS8wTC9UNnZDQ2gwODhQUTRF?=
 =?utf-8?B?VHFWbU53b1FSaGxIZUxlKzNMdjBFWUQxdzlaM2NxRVpvN0FlRjRRY2E2dTM2?=
 =?utf-8?B?UWlyQ2YwMk9xUFJlbDNuM3NxdGhBMjJOUGNyblF3R0lwamltMDZMTjMzckw5?=
 =?utf-8?B?V0tGWE1wMTR1SkNYaVllSkQxSGVaaTJpWlEvcW9GSVgzV2ozT2NJbWNaMjhB?=
 =?utf-8?B?Z3hhS3BqdmtFMllWc3BuL3g4OGlzN01hUzJzUmxBTkZUZGt0MDZkdUhpNkh0?=
 =?utf-8?B?VXEvdG8vUmVMSU9UUjBNajE1WmhMRTI5THAwR3hTVDdGQW1JclFpakpXUlBS?=
 =?utf-8?B?UEJKdW9DN0JoMTZzLytBTkx2dEQ4bW5ROUxSWVhYcmc0ZC9VSnBXbnhVODdQ?=
 =?utf-8?B?M2MzNjFrL3o1SXJZMFBlSEVzVm01VkZYa3lDR0xuUGl6TGI2TEFvUkdYVVBD?=
 =?utf-8?B?RFJXQU9aaVQ3T3BOZ3F0eEVFOFpxQTEyY1hFUUlMangxZy9EQlZZRXJkMkpX?=
 =?utf-8?B?T1F5M2s1RDJvVTNSY1VtVlBPanZaM3dzdCthbHR6MTBzSnZhSXA5RGhEYXNC?=
 =?utf-8?B?dkM0bnBwQzJoazlBL0lLV1B1SHp0TUpBWGw2bnBjaFpQOUV4cXZ3WHYyckZD?=
 =?utf-8?B?V3prZjEvNEd4cmFmdXdjNms3YXJuR0ZkQ0J4QXdiTVQ4cDMrc2dmRU0xYWZI?=
 =?utf-8?B?VFNwU2lNSUFyRmczTS95bER2eFhYa0tzSE4vZ05KdzJVSjVkTld3RkJiK2Ur?=
 =?utf-8?B?elo1a0tpNUZBam44dUR2ZTB0Zjg5amdLSlRtZEZkaUxzR0loM0xBNWttMlhE?=
 =?utf-8?B?N0hlak9SNmdETXpXcmt6ZjU2Y3d3OVFiMUpXVnhQYjZQQ3JsKzBtRkVnMmlV?=
 =?utf-8?B?Z2RwaXNvR054aGJnb2kzTEIxMHBQb04xVEM0MTBaKzBMRG5xTkhReERGdTdH?=
 =?utf-8?B?b2pRQU0zaEdrcHhNVEs0RUVQNUlua3NPSFZLYzFhaFV6MjZKNTFBczRhdWZJ?=
 =?utf-8?Q?GYVY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 985a7707-1b80-4361-9cd1-08dc8c19a7f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 02:28:19.9077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kl4qbq7Hg8WJzWZugOC+J+SyNut5t3a4xlwVmp+PhjvJWZoSKltQQij3KieTfsjHU6htrprwtRjb8ERTQ5N37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFy
aW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxNCwg
MjAyNCAxOjUzIEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgU2hl
bm95LCBHYXV0aGFtIFJhbmphbA0KPiA8Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT47IFBldGtvdiwg
Qm9yaXNsYXYgPEJvcmlzbGF2LlBldGtvdkBhbWQuY29tPg0KPiBDYzogcmFmYWVsLmoud3lzb2Nr
aUBpbnRlbC5jb207IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1l
ci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVu
ZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxMSA2LzldIGNwdWZyZXE6IGFtZC1wc3RhdGU6IEFkZCBzZXRfYm9vc3QgY2FsbGJh
Y2sgZm9yDQo+IGFjdGl2ZSBtb2RlDQo+DQo+IE9uIDYvMTMvMjAyNCAwMjoyNSwgUGVycnkgWXVh
biB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIHNldF9ib29zdCBjYWxsYmFjayBpbiB0
aGUgYWN0aXZlIG1vZGUgZHJpdmVyIHRvDQo+ID4gZW5hYmxlIGJvb3N0IGNvbnRyb2wgdmlhIHRo
ZSBjcHVmcmVxIGNvcmUuIFRoaXMgZW5zdXJlcyBhIGNvbnNpc3RlbnQNCj4gPiBib29zdCBjb250
cm9sIGludGVyZmFjZSBhY3Jvc3MgYWxsIHBzdGF0ZSBtb2RlcywgaW5jbHVkaW5nIHBhc3NpdmUN
Cj4gPiBtb2RlLCBndWlkZWQgbW9kZSwgYW5kIGFjdGl2ZSBtb2RlLg0KPiA+DQo+ID4gV2l0aCB0
aGlzIGFkZGl0aW9uLCBhbGwgdGhyZWUgcHN0YXRlIG1vZGVzIGNhbiBzdXBwb3J0IHRoZSBzYW1l
IGJvb3N0DQo+ID4gY29udHJvbCBpbnRlcmZhY2Ugd2l0aCB1bmlxdWUgaW50ZXJmYWNlIGFuZCBn
bG9iYWwgQ1BCIGNvbnRyb2wuIEVhY2gNCj4gPiBDUFUgYWxzbyBzdXBwb3J0cyBpbmRpdmlkdWFs
IGJvb3N0IGNvbnRyb2wsIGFsbG93aW5nIGdsb2JhbCBDUEIgdG8NCj4gPiBjaGFuZ2UgYWxsIGNv
cmVzJyBib29zdCBzdGF0ZXMgc2ltdWx0YW5lb3VzbHkuIFNwZWNpZmljIENQVXMgY2FuDQo+ID4g
dXBkYXRlIHRoZWlyIGJvb3N0IHN0YXRlcyBzZXBhcmF0ZWx5LCBlbnN1cmluZyBhbGwgY29yZXMn
IGJvb3N0IHN0YXRlcw0KPiA+IGFyZSBzeW5jaHJvbml6ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2
ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIHwgMTggKysrKystLS0tLS0tLS0tLS0tDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJz
L2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IGZlN2M5ZDM1NjJjNS4uZDA3ZjA5ZGQ3ZWFiDQo+
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTcwMSwyMCArNzAxLDExIEBA
IHN0YXRpYyBpbnQgYW1kX3BzdGF0ZV9zZXRfYm9vc3Qoc3RydWN0DQo+IGNwdWZyZXFfcG9saWN5
ICpwb2xpY3ksIGludCBzdGF0ZSkNCj4gPiAgICAgICAgICAgICBwcl9lcnIoIkJvb3N0IG1vZGUg
aXMgbm90IHN1cHBvcnRlZCBieSB0aGlzIHByb2Nlc3NvciBvcg0KPiBTQklPU1xuIik7DQo+ID4g
ICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCj4gPiAgICAgfQ0KPiA+ICsgICBtdXRleF9s
b2NrKCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPiArICAgcmV0ID0gYW1kX3BzdGF0ZV9j
cHVfYm9vc3QocG9saWN5LT5jcHUsIHN0YXRlKTsNCj4gPiArICAgbXV0ZXhfdW5sb2NrKCZhbWRf
cHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPg0KPiA+IC0gICBpZiAoc3RhdGUpDQo+ID4gLSAgICAg
ICAgICAgcG9saWN5LT5jcHVpbmZvLm1heF9mcmVxID0gY3B1ZGF0YS0+bWF4X2ZyZXE7DQo+ID4g
LSAgIGVsc2UNCj4gPiAtICAgICAgICAgICBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEgPSBjcHVk
YXRhLT5ub21pbmFsX2ZyZXEgKiAxMDAwOw0KPiA+IC0NCj4gPiAtICAgcG9saWN5LT5tYXggPSBw
b2xpY3ktPmNwdWluZm8ubWF4X2ZyZXE7DQo+ID4gLQ0KPiA+IC0gICByZXQgPSBmcmVxX3Fvc191
cGRhdGVfcmVxdWVzdCgmY3B1ZGF0YS0+cmVxWzFdLA0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEpOw0KPiA+IC0gICBpZiAocmV0
IDwgMCkNCj4gPiAtICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IC0NCj4gPiAtICAgcmV0dXJu
IDA7DQo+ID4gKyAgIHJldHVybiByZXQgPCAwID8gcmV0IDogMDsNCj4NCj4gV2hhdCdzIHdyb25n
IHdpdGgganVzdCBkb2luZyB0aGlzIGluc3RlYWQ6DQo+DQo+IHJldHVybiByZXQ7DQoNCi8qKg0K
ICogZnJlcV9xb3NfdXBkYXRlX3JlcXVlc3QgLSBNb2RpZnkgZXhpc3RpbmcgZnJlcXVlbmN5IFFv
UyByZXF1ZXN0Lg0KICogQHJlcTogUmVxdWVzdCB0byBtb2RpZnkuDQogKiBAbmV3X3ZhbHVlOiBO
ZXcgcmVxdWVzdCB2YWx1ZS4NCiAqDQogKiBVcGRhdGUgYW4gZXhpc3RpbmcgZnJlcXVlbmN5IFFv
UyByZXF1ZXN0IGFsb25nIHdpdGggdGhlIGVmZmVjdGl2ZSBjb25zdHJhaW50DQogKiB2YWx1ZSBm
b3IgdGhlIGxpc3Qgb2YgcmVxdWVzdHMgaXQgYmVsb25ncyB0by4NCiAqDQogKiBSZXR1cm4gMSBp
ZiB0aGUgZWZmZWN0aXZlIGNvbnN0cmFpbnQgdmFsdWUgaGFzIGNoYW5nZWQsIDAgaWYgdGhlIGVm
ZmVjdGl2ZQ0KICogY29uc3RyYWludCB2YWx1ZSBoYXMgbm90IGNoYW5nZWQsIG9yIGEgbmVnYXRp
dmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlcy4NCiAqLw0KaW50IGZyZXFfcW9zX3VwZGF0ZV9yZXF1
ZXN0KHN0cnVjdCBmcmVxX3Fvc19yZXF1ZXN0ICpyZXEsIHMzMiBuZXdfdmFsdWUpDQoNCg0KVGhl
IGVmZmVjdGl2ZSByZXR1cm4gdmFsdWUgZnJvbSBmcmVxX3Fvc191cGRhdGVfcmVxdWVzdCB3aWxs
IGJlICIxIiwgICB3ZSBleHBlY3QgdGhlIHJldHVybiB2YWx1ZSB0byBiZSAtMSBvciAwIGluIHRo
ZSBjb2RlIHBhdGgsDQowIGlzIHRoZSBzdWNjZXNzZnVsIHJldHVybiB2YWx1ZSBwYXNzZWQgdG8g
Y2FsbGVyLg0KDQpQZXJyeS4NCg0KPg0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50IGFt
ZF9wc3RhdGVfYm9vc3Rfc2V0KHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkgQEANCj4gPiAt
MTg3NSw2ICsxODY2LDcgQEAgc3RhdGljIHN0cnVjdCBjcHVmcmVxX2RyaXZlciBhbWRfcHN0YXRl
X2VwcF9kcml2ZXIgPQ0KPiB7DQo+ID4gICAgIC5yZXN1bWUgICAgICAgICA9IGFtZF9wc3RhdGVf
ZXBwX3Jlc3VtZSwNCj4gPiAgICAgLnVwZGF0ZV9saW1pdHMgID0gYW1kX3BzdGF0ZV91cGRhdGVf
bGltaXRzLA0KPiA+ICAgICAuaW5pdF9ib29zdCAgICAgPSBhbWRfcHN0YXRlX2luaXRfYm9vc3Qs
DQo+ID4gKyAgIC5zZXRfYm9vc3QgICAgICA9IGFtZF9wc3RhdGVfc2V0X2Jvb3N0LA0KPiA+ICAg
ICAubmFtZSAgICAgICAgICAgPSAiYW1kLXBzdGF0ZS1lcHAiLA0KPiA+ICAgICAuYXR0ciAgICAg
ICAgICAgPSBhbWRfcHN0YXRlX2VwcF9hdHRyLA0KPiA+ICAgfTsNCg0K

