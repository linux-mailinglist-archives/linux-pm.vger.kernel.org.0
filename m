Return-Path: <linux-pm+bounces-9535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBE90E203
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1288C1C2244B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC053362;
	Wed, 19 Jun 2024 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TosN0g1H"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E32139C7;
	Wed, 19 Jun 2024 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768447; cv=fail; b=ASDmBUov8mpm57yTxzAJcck+cgjVyTR0FvS7yFsJ2WguL1FCXH1jsnY4jGbj68mz+iaU4+i0bBb6C//LfkNJJ9kiLeqlT/iEk5eWEShrk9XMe/JPJFZ++FoIZNOte/ICsIxCNZuohkQqvGQWd/DQ/Fg4LbmcW9EOejRABJgQzDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768447; c=relaxed/simple;
	bh=ggNWFFjYIo2ZQKn2x3Sjlnl4Cq6FGqeYYk07gYAQv9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u9JLMhZ/B7nizu+0nPHLX6KD2kXqwi+kOq6gmYgY76Sog7fKTxLWIqUGjLnqBZ/x+18RQ+xfL0ntYEpLFHkOwwOxDRWfXvd6XEod4B2J/U0mDxjtfPEODg7tOAwaidhJ7iLWNCdZ68DiLKJrTlUjX45U0OtTt2BfDnr+BF8/uTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TosN0g1H; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdUBsTpRa/oyElheUvgwFFF9snyDIQwYPgbC8UImtynFBv0F24JXUCGVQD0EFEVna60jck4SUdI3glssBGZR+jKHvWgETnN4YunaMbA4lhZtZvNfI9xeXjDmBR+qFEwJHqHM8QIqHoEFidapIu+ZUtWbVgasFGh7NrMpd3NKaUR1bIgTl2GGieQpz9ECbFImiw+n+AdFtf+3KwXMmJGFZeDgaTCNWlnCfe2z2RqKTziB+3fTrd6XmKPKdZ6/ValQjsIonm9VDuNhPVQP1OZ0nLoQEdfNnqL/BSynpbQv+q/bimzJpzvrkbajKwQRCfiqN7Uj290FOMxM5HPojCiLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggNWFFjYIo2ZQKn2x3Sjlnl4Cq6FGqeYYk07gYAQv9E=;
 b=KK5c0+9DJlM3XRcUXEwFMXTrG57BppAx00FclwHVmqnepbkr0Q1skSjpRpfKewcYIJLMuNX202vdC95oZiFKkNbgqkz53P9z8ISXX2JLXM+sUXrM3SUDLMTxtalHhyxdRPSLpIs9H4GL/hhwbRtmKaToF/sCeXosyv7T0Itt1OfyMRNNt7x3lA/MgD2yiFgv5ZdjQb/le+8eeC5kyJs832d3flf+AaDgFkd7Km806dUSzMMfMKn55ISQyuwzQqc3C+QMup/vof5njAVsLSBn0QS7JNA2SF4snB/2xdT2SBm6FN1deQJX3s4QQLyl+d+X3Auvg9RNJPS+FbizFsd/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggNWFFjYIo2ZQKn2x3Sjlnl4Cq6FGqeYYk07gYAQv9E=;
 b=TosN0g1HafcgZwBCnqB7ohTBwY3uUi9lH/Qd4+QXaypOaWY4o7uHXRg1XNYZloVCyGliWAv/1oBVzq3WKFz72RC8doabGkMYxGITmUgRGDJhcDy0Aqj8e1jfSqbGSHvS9Lh+eFjOwCaEGTjkjx8kebOlr48XeukHviutFLBkXhs=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Wed, 19 Jun
 2024 03:40:42 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 03:40:41 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 08/11] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Thread-Topic: [PATCH v4 08/11] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Thread-Index: AQHawIRo5KS01Fven06s+cavrEvZl7HLopMAgALNdXA=
Date: Wed, 19 Jun 2024 03:40:41 +0000
Message-ID:
 <CYYPR12MB86550DC34EE07D11736E6A719CCF2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
 <4416ff72ea5a33173b69561803f1578073baccae.1718606975.git.perry.yuan@amd.com>
 <20240617083902.GEZm_2JjnNvHaT0Knq@fat_crate.local>
In-Reply-To: <20240617083902.GEZm_2JjnNvHaT0Knq@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=edc2f60a-47bf-4c95-92fd-d240a9f989c4;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T03:26:54Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CY8PR12MB8297:EE_
x-ms-office365-filtering-correlation-id: 9428b590-4f8d-44e0-81a3-08dc9011980b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?THdHdStYaUpRdVhwenY5Mk9nYzczV0ljNlZEUjV5L1pXYTFybWFRTDA3WGF6?=
 =?utf-8?B?Ui9TWGtJRlNPNVYxOG8wQW9DMWd1OEUwTXZmV0ljbXM0SnhtTWxVQzJMeU1z?=
 =?utf-8?B?Mm9tNHRXRFkyczNrRjhocllUZWFEUEtBaUE2WmNQMWt6OUYzczRHRXdZb3dh?=
 =?utf-8?B?UDNneUFhR1ZxZW1Bb28zRzhnNjZGYkJIY0k3MGlPM01NNGlWWWt0Sk54Ynpl?=
 =?utf-8?B?WjNpb2xuSStkbVBaWE9BT3psdVhUbU1JUWxpaFVFVHdTS3F2TWFjYzRMWkRM?=
 =?utf-8?B?OW4wSG9mMzhLOThFSDNsOUt5Uy9KYlRJYldIcGxBbndiZGtVdHA3bEJOcmhU?=
 =?utf-8?B?K28xL1BDb0VJZGRZUzNPVFZDWUxnblA5LzZQQzQ3MFVOZTFRaUxtWVJlOFdx?=
 =?utf-8?B?TGFQRU1DSEpLSUh3SGc0b2RCci9kQ04wcXQvNkNiWUZPUWhuY3JrQ3k0eDhG?=
 =?utf-8?B?VGsrT25EY3ZxbDhtZThuSWtlUkpOSjh5Um5Fd21DQS82NFl3bzkzb05BaWhR?=
 =?utf-8?B?d0JTWE4wRGQ5Nk1uc2hRWm9abTZySTdXNExJSWFrbVNLUThUYjlNYi9wWHJJ?=
 =?utf-8?B?UDFFY2ZPZUgvbkh3TnNrTjNibjQyR3FPbkVjUFF5c1JCWndhZ254M2syeDBh?=
 =?utf-8?B?NUZCeHdyOXM4bHl6cXg0b1RhR3BCbFVQNE1vdWRodzg5QUxSN2U5MUl5R1pv?=
 =?utf-8?B?Y2hSWFlGYTNFb3p4NXJtckhFZlNHVGpzNW9QVmF6Nk1kU0pGdjVFSFVaTVFv?=
 =?utf-8?B?eE5mYlk3UHlGSEplYmpiWXlwQURzbzR5b2NEM29oU2FHek5rWmFTd1lJY1d4?=
 =?utf-8?B?SFJDdDdsc3ErY2oyUXJMNnF6N1Q4cnh6THprNzRnNUlCcUxVTCtUSFQzSUR3?=
 =?utf-8?B?MEl0dEtWZThBekFZTy9VY0pXTjUvcHFTZlJWMUVVRThTU2FqSXBvbkVCQTdF?=
 =?utf-8?B?Rnp1M0wrdEJKQmY1OFhsblAvMlU1MEtqdU90ZUNXcytKY2NLOElObEFiUEk2?=
 =?utf-8?B?aXZRUkVpQkJXd0JZMDhURGZPd3NTeVJLaWZQRzZyMFNkY0hjTTV0ZG1aRkJo?=
 =?utf-8?B?VWI1Mjd3VktGbi9LVVJhNFcvaUs5bEYwbVg4TU52ckpqVm9EMmF6aHI3N1kw?=
 =?utf-8?B?eGwyY1FVaEFlV0czam1DU1FMSHUxWTA5UnhRVW5tejM4R3NKWTlhZXBmcndJ?=
 =?utf-8?B?Wm4wcWpUbHpkMUpuQ25raVhSRTNnRVNiWDUrdmRuQ1FTbkFBQVZnbGtOcE0z?=
 =?utf-8?B?UmduODEyRE5YUE5NOGs1YUlIazNqdUZCUjd0OUNoZ1pnWTVmRXpjZmRpajZs?=
 =?utf-8?B?bXdqNGErdW85YTVZdnZjODZ6aTZLRUt5OTM2MXNtZmgvUVJ6VWZQbHFuaWZn?=
 =?utf-8?B?b2M5eGE1eUgxelJieE8vbHRpMmozeTlwazlSR2diSVhtZUpnU1pxcmtPZ0Ny?=
 =?utf-8?B?WjhnZktqSnorbVF6RnRhbXJpcktERWxCMWZrTlNJKzBkSitEQ2R2WkFrcEhp?=
 =?utf-8?B?ZG9xdVpZTnk2NXY2THQ3TlAyRUtDZkRkN1lObTlVZWlMRGhIZGJ1V0djeWEw?=
 =?utf-8?B?UUc0U0RaN1FBb2llNk5ONHRlY09qWTNCR3BtcFJ1YXBIZllFUzJrMTg1ZC9L?=
 =?utf-8?B?VVh1a2J6Yk5ueVdWSWoyUWthNVdxdW9SMVhUeXNLSGZCcTlQYk5MT0gwT2FY?=
 =?utf-8?B?d0g5TVVDSENUNzFvZ01OSjRtQkpBUFoyaGIvd2FGQ0hyUy8ydnpGVVkvaDhn?=
 =?utf-8?Q?uoFIvBaNdRVHuFMqWB78bQaakJZNGdlZDOZwQul?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWVYcVZvS2ZudUdwZ0RzdnBvSVF3V21rZmZiRVZCdDZPOW4xMzEzMzg3Y2pR?=
 =?utf-8?B?dHZETkxWRE1aVmc1VE4xQWRqVEtqRVQzVHVyT1RrRVN2WEMzSTk1N0lMdEFz?=
 =?utf-8?B?VEpWc2pwSHNWTmFCT1dRdjVmaHdDeG02cnFkQ0hOTmlNUUZ6NEkvWW5rbzAx?=
 =?utf-8?B?M2xYTmpLT2VSWFBuSnBlNmFBVU4veGR3bFpWNHFiUVJaeitqVDN5QVJ4emo3?=
 =?utf-8?B?TmRjaGtyTzlsTWNUSXZnMzZ4SVJBalJFY0tYUkpWTU43QktCMU5MaVlDWTVH?=
 =?utf-8?B?ZEx3bnBCczA2NTJyb29IYk1RRUNYVE9NakdpSmxMMFo1N0w3ckhDZHRITVZR?=
 =?utf-8?B?WDUwaTNORFBFM3ZBMndydXBUQWdIZlZTVUFMWHdzMXBDMUpqTStwYTdCSGJE?=
 =?utf-8?B?N3U5L1JNbXI0VHZvKzV5cGc2TE9XQVhBdUV1cnFHL3k1OGNOZ3ZvaUkwRHRp?=
 =?utf-8?B?NHRyeFlLTFVCdGUydm5lY2JlTHozQmRQTkpQdjhrRUlzdFVML29HMzdONkg5?=
 =?utf-8?B?UHFXdXgzcmZXRnM0ZnR2Smh1clpEZFAvV3d3S3laWWxncFBCMHpmaldnZmVN?=
 =?utf-8?B?UHN2TEdxejF4c3Z1bEdEWjhVQ3A1cTM5blZTTFRwb3VIMkVOTnVMZnpPcXpS?=
 =?utf-8?B?VnBaWGFSb3VDUXBRQUpmSDZSUTk2ekxRUnYzbDdteUlzaTh4a1F5NHVsdGFt?=
 =?utf-8?B?cU5oT0tQKy9wTGRHUm93KzBnTEMyejNYM05aZnZlbmptODM1eFpLdUptbGRM?=
 =?utf-8?B?MmhlY2w5NGw3Z2JUS1FpdjVDK2FYNWEvbVVyOHpZUVpDTkl6ZFRPeUhKUEMw?=
 =?utf-8?B?SmdwOVB6R1lrcVJmQXVFRmlNSFhRQkJXdmVIaTdSNXJOVzNEKzNQdkUzS0o3?=
 =?utf-8?B?R25FRU1YSHNiWm51Tmd2MFliSEF2RGowVzJXdEUvczVTNjdRTFlVdG9MQjF0?=
 =?utf-8?B?azBBb2g5dytpcFpvcGwyQ1A4OTBMTWc4Z2hOdDR1TUhpQTNsOXFRa3AwZEM0?=
 =?utf-8?B?YlpWQ1NyZ2dQbGhRNHJKcFpFcExKNU9ReVFLNFl6cUxNNDhxN0Y3ZDlMWGFI?=
 =?utf-8?B?ckhjZVBuZkhPdDdmaXUweTVQWXZLdUJVUnIvYlpkckhLQVkvMXBOeklxVmVT?=
 =?utf-8?B?OGFka3hKZVNuNHJqTCtiRGRwWTJIbzMzcWlkMEtRSndSdzhWU1dxcUVuWlgv?=
 =?utf-8?B?UkJ0NXhiNXFyUlZhTUtZZEpYYTF5eGJ5OEZrK2FsRTYxODZzZW9Rd0VCMXU2?=
 =?utf-8?B?RGVoWTR3cGxVblFOZEgvMTBBcVNCYzdoeUlIbmFYSlJBTEF2SzRGMG5VT0N2?=
 =?utf-8?B?VDQ4aVZHQm5DUk41ZmRFRmE2VjFwKzlkM2xrekQxODlDenY5T09nbmFpTTRy?=
 =?utf-8?B?WmFEUE1tTVQ4UUMvLzU1S3BZNWVtWFU3cnhYNlBWd3dPZ2NUYjh2bGFOdVE0?=
 =?utf-8?B?RWFNNWZvZERDckM1Wm9TOExiSWYvYXRBY0NXZjJMamJXSk9QY0pjRTkrQ1Rw?=
 =?utf-8?B?SnVvRVlRR0JEZUF6d29MV3gvWXU3ckVDcEhKVHRtOFhFLzlPNWpNZE00Q0Vq?=
 =?utf-8?B?Y2kxK3RXVnRhUXprTnhmaytxZVM1Z2tqN3hDK3dZOWVvR2dXTTBIU2lrbzUy?=
 =?utf-8?B?ZXJLV1pDN3REcE5BcGtoeFVoK08rOEYwZmYzenFKMGM3RXNvQUc0dUdPRmRh?=
 =?utf-8?B?OXg3MjBTNHV3SmFLcVJKZWNmeTRxQVB2SkYxcEg3SUJkSE1NKzh4U1ZOVGVt?=
 =?utf-8?B?cjV2MnRhRUFhOU5vNXlEbXRhOWpqN0RxSEdkTnpwQ0ZpUnJnL0xlYnE2WVFB?=
 =?utf-8?B?ZkhvNFc1OGQ3c3NUZFQzM1pHZWZXSE53ZWYyemVhMWdRWXlkVmg1VFVyUG9X?=
 =?utf-8?B?dHlTYkdUYWJPS0s4YWpUa2dhYVNaOEF5UmI3R1Vod0p6Wm1JR2s4OTBtdkpo?=
 =?utf-8?B?R3MrRU1FL3FDbTdQM3pRcjFPamN5cHRLZDhBZjMvK3ZpY0ZKeUdOR0tSSGcy?=
 =?utf-8?B?M3FVQVM3S3lZRlJpQkoxUFhaa0lQS2R2RXhBUzVicDBqajRiVk8rMXZmRGJz?=
 =?utf-8?B?U3pZR2pYR2w1RVpPdGVyVWJYR2dtR2owR1lUUmV1RFgvUjRWR2w1RkhKZ3Nh?=
 =?utf-8?Q?tWQk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9428b590-4f8d-44e0-81a3-08dc9011980b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:40:41.9243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnXgR9gEvuFEtqyBsVY6pcXV3k78FJ9TIFLyy2jVsTeTvaNKTA99TldtHX4pVLu4w0+ZHtR90BW964LKbzR55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDE3LCAyMDI0IDQ6MzkgUE0NCj4g
VG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+IENjOiByYWZhZWwuai53eXNv
Y2tpQGludGVsLmNvbTsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0Bh
bWQuY29tPjsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFu
Z0BhbWQuY29tPjsgU2hlbm95LCBHYXV0aGFtIFJhbmphbA0KPiA8Z2F1dGhhbS5zaGVub3lAYW1k
LmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4g
PFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFt
ZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDgvMTFdIHg4Ni9jcHVmZWF0dXJl
czogQWRkIGZlYXR1cmUgYml0cyBmb3IgQU1EDQo+IGhldGVyb2dlbmVvdXMgcHJvY2Vzc29yDQo+
DQo+IE9uIE1vbiwgSnVuIDE3LCAyMDI0IGF0IDAyOjU5OjEwUE0gKzA4MDAsIFBlcnJ5IFl1YW4g
d3JvdGU6DQo+ID4gQ1BVSUQgbGVhZiAweDgwMDAwMDI2IGFkdmVydGlzZXMgY29yZSB0eXBlcyB3
aXRoIGRpZmZlcmVudCBlZmZpY2llbmN5DQo+ID4gcmFua2luZ3MNCj4gPg0KPiA+IEJpdCAzMCBp
bmRpY2F0ZXMgdGhlIGhldGVyb2dlbmVvdXMgY29yZSB0b3BvbG9neSBmZWF0dXJlLCBpZiB0aGUg
Yml0DQo+ID4gc2V0LCBpdCBtZWFucyBub3QgYWxsIGluc3RhbmNlcyBhdCB0aGUgY3VycmVudCBo
aWVyYXJjaGljYWwgbGV2ZWwgaGF2ZQ0KPiA+IHRoZSBzYW1lIGNvcmUgdG9wb2xvZ3kuDQo+ID4N
Cj4gPiBGb3IgYmV0dGVyIHV0aWxpemF0aW9uIG9mIGZlYXR1cmUgd29yZHMgYW5kIGhlbHAgdG8g
aWRlbnRpZnkgY29yZQ0KPiA+IHR5cGUsIFg4Nl9GRUFUVVJFX0hFVEVST19DT1JFX1RPUE9MT0dZ
IGlzIGFkZGVkIGFzIGEgZmV3IHNjYXR0ZXJlZA0KPiBmZWF0dXJlIGJpdHMuDQo+ID4NCj4gPiBS
ZWZlcmVuY2U6DQo+ID4gU2VlIHRoZSBwYWdlIDExOSBvZiBQUFIgZm9yIEFNRCBGYW1pbHkgMTlo
IE1vZGVsIDYxaCBCMSwgZG9jSUQgNTY3MTMNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5
IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvaW5jbHVk
ZS9hc20vY3B1ZmVhdHVyZXMuaCB8IDEgKw0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NjYXR0
ZXJlZC5jICAgIHwgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0K
PiA+IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiA+IGluZGV4IDZjMTI4
ZDQ2M2ExNC4uZWNlYWEwZGYwMTM3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2NwdWZlYXR1cmVzLmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0
dXJlcy5oDQo+ID4gQEAgLTQ3MSw2ICs0NzEsNyBAQA0KPiA+ICAjZGVmaW5lIFg4Nl9GRUFUVVJF
X0NMRUFSX0JIQl9IVyAgICgyMSozMisgMykgLyogIiIgQkhJX0RJU19TDQo+IEhXIGNvbnRyb2wg
ZW5hYmxlZCAqLw0KPiA+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0NMRUFSX0JIQl9MT09QX09OX1ZN
RVhJVCAoMjEqMzIrIDQpIC8qICIiDQo+IENsZWFyIGJyYW5jaCBoaXN0b3J5IGF0IHZtZXhpdCB1
c2luZyBTVyBsb29wICovDQo+ID4gICNkZWZpbmUgWDg2X0ZFQVRVUkVfRkFTVF9DUFBDICAgICAg
ICAgICAgICAoMjEqMzIgKyA1KSAvKiAiIiBBTUQgRmFzdA0KPiBDUFBDICovDQo+ID4gKyNkZWZp
bmUgWDg2X0ZFQVRVUkVfSEVURVJPX0NPUkVfVE9QT0xPR1kgICAgICAgKDIxKjMyKyA2KSAvKiAi
Ig0KPiBIZXRlcm9nZW5lb3VzIENvcmUgVG9wb2xvZ3kgKi8NCj4gPg0KPiA+ICAvKg0KPiA+ICAg
KiBCVUcgd29yZChzKQ0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NjYXR0
ZXJlZC5jDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NjYXR0ZXJlZC5jIGluZGV4IGM4NGMz
MDE4OGZkZi4uNmIzNDc3NTAzZGQwDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL2NwdS9zY2F0dGVyZWQuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2NhdHRl
cmVkLmMNCj4gPiBAQCAtNTIsNiArNTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNwdWlkX2Jp
dCBjcHVpZF9iaXRzW10gPSB7DQo+ID4gICAgIHsgWDg2X0ZFQVRVUkVfUEVSRk1PTl9WMiwgICAg
ICAgQ1BVSURfRUFYLCAgMCwgMHg4MDAwMDAyMiwgMCB9LA0KPiA+ICAgICB7IFg4Nl9GRUFUVVJF
X0FNRF9MQlJfVjIsICAgICAgIENQVUlEX0VBWCwgIDEsIDB4ODAwMDAwMjIsIDAgfSwNCj4gPiAg
ICAgeyBYODZfRkVBVFVSRV9BTURfTEJSX1BNQ19GUkVFWkUsICAgICAgIENQVUlEX0VBWCwgIDIs
DQo+IDB4ODAwMDAwMjIsIDAgfSwNCj4gPiArICAgeyBYODZfRkVBVFVSRV9IRVRFUk9fQ09SRV9U
T1BPTE9HWSwgICAgIENQVUlEX0VBWCwgIDMwLA0KPiAweDgwMDAwMDI2LCAwIH0sDQo+ID4gICAg
IHsgMCwgMCwgMCwgMCwgMCB9DQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPg0KPiBOYWNrZWQtYnk6
IEJvcmlzbGF2IFBldGtvdiAoQU1EKSA8YnBAYWxpZW44LmRlPg0KPg0KPiBVbnRpbCBhbGwgcmV2
aWV3IGNvbW1lbnRzIGhhdmUgYmVlbiBhZGRyZXNzZWQ6DQo+DQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyNDA2MTExMDUyMTYuR0FabWdzWUMtDQo+IEpfeUxmZHVwRkBmYXRfY3JhdGUu
bG9jYWwNCj4NCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPg0KPiBodHRw
czovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KDQpCb3Jp
cywNCkkgSnVzdCBhY2NpZGVudGFsbHkgbWlzc2VkIHRoZSBvdGhlciBjb21tZW50cywgIHdpbGwg
YWRkcmVzcyBpdCBpbiB2NS4NClRoYW5rcyBmb3IgeW91ciByZXZpZXcgIH4NCg0K

