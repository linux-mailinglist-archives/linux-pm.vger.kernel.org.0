Return-Path: <linux-pm+bounces-27129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D933BAB68D7
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 12:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AE43A4245
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12C2701B1;
	Wed, 14 May 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MOS1qpmh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1714136349;
	Wed, 14 May 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218674; cv=fail; b=TGMkLkEoccV/KwcQQyLD/v7b7dRyGLuXIbjxFq64qUOl8fHU4DiT/r1qMKzEKdg5/WWv+L3+uO0qjIomTAr20SlGS0GFbRlClaQMQLu4dbmYL9NHQ4HTPYa1OFiQlEf9JmCtnFODVQVdO4qB98KopWcpIAd/iCaDk3hbinSFDDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218674; c=relaxed/simple;
	bh=9yCPU8xjvCjZm954IR2YhFceLMDIKpPIgelcDCRUkew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W0KoO/xiSjVh3JT4LmlHTrlB5iWyuo5evKryp7tv6i1SGa0wFDLANgCR6K0Z1Qcc2Mm+etyhL/3VkelmEP0Qw6zjYMantKR1GyQrVr5kA2ipfIT9sghcrBTlXnsRAALFMyq7Dyl5Q1oHiv8sH2pTagE2UwypaSqIYJ9YfUwfVCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MOS1qpmh; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqIs+K6ZDdYymOiFrivTTgARR+d9I69oU1kqRkNt6XLtnF0+fwSk/iGrB7dz2pRmNimwFWXEOY/mtMhbeZQlva1NyWOj1/FDi2Sdvz9iystDfeF3CIHX13410vWft4sw7NH2tTUUqau6Z8HBcFzfEq4feAeNBrbi0nDZlNsIYeD+JfOeF1OptojAZS4p4ymCu26jkwXAfLc4/kuUsJbx/gF3mUQ2eeUDU1YY2uY7q0d6WLITJ3vc5OzO2vqlbICfFG6uvz/vRkRHnnMFrMA69VXL5yWzq5nnbPAKF59ZihCOLZi0jZCIeVEGiZdnEm2ZF4GiM/wNYlyjwFh2CXm98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA4zOAVjmT8zbBIQj18Uo1Wcn9ug8vPQHIxdan+J1As=;
 b=Z2X1e9pTzaLlLxbHhnV/e63UEOgcovqvMOI5CsZMf+PpAIcVNKPsDLY5zmDp1bU44MEesmrW5n7qAXNFImN/W2RkgGSpYhr3iUEyYS/lXE3orgS9UfFmQbrcwh/4r5ecrPq4dRM2Nn0kLTueCi+vVLlw/RWQBwrW+KFFDWPRi/PrT4q84TYYtqlMVJ1YvbtGQ0uMvfjq890mLIRkBcorVYeterLzsYSoqAhUApWheio3HAZ4p6LJyu0OkWgtLT2qdVVMiCR8bP0Y5zyNjhjmL7XAEt5AVvQprPEUTQn8D1IdXrVTgfU+ntvhqPlVJJjY44Hf4T8wqDEpOLZM0+nHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA4zOAVjmT8zbBIQj18Uo1Wcn9ug8vPQHIxdan+J1As=;
 b=MOS1qpmhgHqo5zM49XNUZyoPBBl0St+hTl5BgdXzPek3Ky1msZmpUyfVDeIwTQdVD91Um6T6KYO4JwHGStqXXPTHAoEp8uXsr9sf7tLm05kiC0oUh/IjvGBvbHnr3vYzKBDsJKZPH52famBv21RALQ4TWvPANd/9gCVo5pUv78SuYbTO4FsAPjZqhEtG0ft2ZIBvCAEc1cS8TdAyg5boTiIc2QjQYp76JWfMytIlmFCW9YEA8SRFGSGMHpMBZLq4C2r8F/FkO1F/YkgqBJlhw9x6H3sLXFAZhnFCD8AHK1ehS+/mFUlbctVut4qAR6Ux3CTLiin2n+ydwpO4IYWltw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 10:31:09 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 10:31:09 +0000
Message-ID: <2acf370d-a36f-463e-87dc-2198195cc81a@nvidia.com>
Date: Wed, 14 May 2025 11:31:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Aaron Kling <webgeek1234@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
 <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
 <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::20) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: de002051-8e2f-4fa3-a191-08dd92d270c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzR0QlVJN2RnSEpjU3pvRnR1alFrQ2hCYUpoOUNLcjFjTWRpMlI0ZXAxWlJT?=
 =?utf-8?B?WC8xdUJHakFqWXFDdzFhSlJQZVBMTS9LYzE0NUNDd3B2Y2prN1pGdmxXWnFu?=
 =?utf-8?B?cUpITnZmMWhMK3hQZjlJaXM4djVWaTdBYVlBK1poaThLSk9UbWNzd2kvbHhX?=
 =?utf-8?B?Q09tSkdDS2xqYVppOThORU5Nb0NXYjR5Q09aWTAvaE1kQVpodzJaYzNXNlpX?=
 =?utf-8?B?Um96Rzc1ZTA1M0pKb0VIaHBHY1V2VGgxVE1WNm8yYWU4d2Y1bVYvMVR6WWo1?=
 =?utf-8?B?Rzl0QUJkbUJUb3hlS09PZCtDNWpJSmQ3U1lPMDFNaXJTd0NMbmJHTk5Kbm5N?=
 =?utf-8?B?SG5KOEpWVUNQZUNBa21meU0vOWdHTUV3cEw3TGswczNUSmRDSUZDTkVDdCtR?=
 =?utf-8?B?bU1WSm5TcmgrU3JWTVllQWtHRmt1U0dzeFR3ZXIyUnVvWUx1NVIvSXpVRTFq?=
 =?utf-8?B?SzRSU2dsOUY3RWVIUGVJNjNKeEhhS1UyTXBkNFp4RjRvdWQ0OUxPR2RmUmxr?=
 =?utf-8?B?SHdSL29acXVhazhGeTBZd3lLSHVUa2F6K1FsRWV4RUhtbmpuL3YyRGs3bTR2?=
 =?utf-8?B?aDYzV25JNy95TXYzdjBCUm9EL1hzdU5ZazdqeUJESE4vRlovL2VsOStvSHky?=
 =?utf-8?B?NUhGZVlPVUxDN0t0M092NFdpQWc0ZC92N3NWV1pQWlhZTGpXM1RuMDgyMHI2?=
 =?utf-8?B?cTJwUUxNQ2JsWGtldHNjMWlCeTdpRkFYeDF0ZGl4ZHkyelluc1FUUWI2VHNW?=
 =?utf-8?B?TFVJVnNpK0NEelB0VXVLUXBzU1lNN0tSUXlqeUtodWJUci9wWE1HU2NmdTVt?=
 =?utf-8?B?N3hSdEdnVkRrZEZlbGtGU3VNYkdFdzMwMDRCTkd5d2lmWS80enV4NEQ3aWdR?=
 =?utf-8?B?NVp5bEFRWUdGVE5PcGdXNFFlallRZ2VqWTBoMUovZUJVRUtBQ1c1RytER05W?=
 =?utf-8?B?b0tObzl0dGtXSllVYm44Wlo0dXN6cWxJMFIxb0RKWGVsaHNKS1l0VnpNYkVh?=
 =?utf-8?B?MXl1L0lqdUp6SXZ1RytaL3JicDhsTGNoMVVXcitQNm5kQ3JKd2dtUGNJREp2?=
 =?utf-8?B?NnRBdW1GSmF2S3pFZDM1RHZVUS9ER2lXM2ZDS0lzQ3RsS1hZZDArWjdaVGpm?=
 =?utf-8?B?UU5ac3ZTVDNSZkt5TmVCbnZTUnN0cE5nbW91MC8xem5zVklNTGhzUWdLNUhC?=
 =?utf-8?B?NWdXRXBCUy9pK0pnNW1iKytWNWgrYmxpNm0zQTYraG1DNmx4Q1R3RWNGbVJz?=
 =?utf-8?B?cHNyR3YydWFXVFJuVVBzd241SjJDUEFhRXFXcU9zUjdmZVVWSmVCQ2MzUE5O?=
 =?utf-8?B?Z0RaZVpWSjdBMEIrK1I3cFRPWFlKWVlMQzdLWm15QlNDQm1mWS8waHVObHdH?=
 =?utf-8?B?UytkbGorZkYrNkdkTEhuQUhyOFBsSWdUdEZGVXIrL1NzYkFZdFI5K3pYdk9W?=
 =?utf-8?B?OVZoeW5FdHdUY0JhNERhc3V3dWNTMGVtNVM4aWs2dHVYR2tNZExwV2ZWUWtD?=
 =?utf-8?B?ZjdHazZYSGw0dXZNNFZ4VTRRVDh5Tm4vYlVZVDdvQmU3NHJJaGdTU1EyNEpn?=
 =?utf-8?B?eHZXM21SV0xKcFg5MHUwVERKcjM2bUdDZU1sMGpaby9QMDZSU1VJK3BzYkxX?=
 =?utf-8?B?b2lNb1VvNk1KcGthbE1LYU5vRmphaXRSQllQK1I2YXhwbGJUckdsdWxCQk1Y?=
 =?utf-8?B?WWtLTmMreFgzT01sRnJTWC9obmVUVTRheXNWZWt2L1dEUjlRRDBpLzdZN0xW?=
 =?utf-8?B?Sk42bHRRdEx5S1l2WE84NmlmVDBjcU1ML3ZLTVp0RkowdWVHRTAvdHVRaldU?=
 =?utf-8?B?eldPdzVWU0NCanBnMzkrNml1UEV1Y3AzNmowKzNIc3NGTkFob2g4ai92TnVV?=
 =?utf-8?B?Y08rNUowYUwwbDh4WjNaaVJuaDY1eXozRkFKV0t5KzVDUWdsTFhDNEg4Nytz?=
 =?utf-8?Q?IM/KhVfEXGc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUpGOEtLWVVpemZQa3JoeFAyZWtKeHdjbG1IKyt6clBPaWxqdHgyc1VmUVNN?=
 =?utf-8?B?OU5Qb1orcHhXZzVyeittQnI2RDJuT2ovTEhtWXU4REVTejJhbm1qL0YxSGU4?=
 =?utf-8?B?S1JXQ2JiMURSZStwS2ZxaE1JYURVdVJxKzR3NmpPV0NPYitNSjJld2svNXNJ?=
 =?utf-8?B?Qi84QjFLUnlvQks2anNnb2JwYXhTN0xaaDlRQmR1S0RIT3lYVWxWUkZpQmFp?=
 =?utf-8?B?M2I1Z25VcGFhamhjYnJHU1FpOThWeXB6a1h3K2duQkEzVUVRbno2YWpyVldP?=
 =?utf-8?B?S0J3TW1UUlNSSEc5MG02cTEzdUZwR0tsYmN1RE0yUW5jUDJWNXUwL2hiUmRR?=
 =?utf-8?B?OUxLNTIvQWJyTkpPK0JRYUNFRVpGK0J3UXFiUm9XaGZZNlZBT2cxSTQ5dUFJ?=
 =?utf-8?B?c0lWM3BvcFdUN3RhbGVNeG8zTUo1V09TRkQ1UktQMzU1T2xOb0dJUTBXVXR5?=
 =?utf-8?B?dVNPV2tQQU82dk0vSmNIQTRaWjFYTUVtV0xQM1dkSnhFWE5mbDNwVFpXVTVO?=
 =?utf-8?B?SVQzYnN3ZGtCZUtOa1NlTlB6a21KQkdqL28xWDRxTEovdENWT056cklwMU04?=
 =?utf-8?B?aFBTQTcwWnpGMzZwYlpIUTgxc2pzczB5Vi9RbGhxckIrQWpvanFtOEVVSjZR?=
 =?utf-8?B?UFZCRDlBRXhudHhoV2JUU29hbEZiZUQwZEZXTDhLdXpGSWR5QWJDK1ZVUVpY?=
 =?utf-8?B?WVgrUHFSdFUwMTRHSzRDS01XWUExOHNZMVZDcEE1ZTFRUDQxd0VUQWExUCsx?=
 =?utf-8?B?L2VyNEx4blRMR2plRk5NN0FOdFVJM1B4azRlYkNvYUMrV3BicE53RGZJRnlI?=
 =?utf-8?B?S3hGdmFRbkJ4a0lZTklndjlMWmhqL2loc1RORm0wL0JsL29tb0dBaFNtS1p4?=
 =?utf-8?B?d2lDakFzMm4vUzhLb04rYmRCYWl6U1NkNXBFZjRHSXB3ZTRjTEpMMFFXTTNY?=
 =?utf-8?B?NWk3bzkyZVFRNGF1MnBjYUkvMGNaZ2U2NkxOU1V1VEtac0NFUlJVcVJ2ZVdB?=
 =?utf-8?B?MnhwRE1TV2dwV1hoTkN2a0NhQ2RZT1FScUVWZUp3Q3JxM2Z3cDdsazc2RExU?=
 =?utf-8?B?TU1HWEZxWHlsWUhEQmo4OWpwbEJUdlI5Y2U1cUF2c1A2N2pXRUZXV293aUpU?=
 =?utf-8?B?aFlyMWFMRE9MVmRzQWlqQ3R1R0lKQWU0cDk4cmcyai9UTUJsV2c5MWRrbVo5?=
 =?utf-8?B?ck9XQStoQjBodmZHRENqRUttM1d1dHNWdGVvWStxYThlRkhud1FLTkNBOTEv?=
 =?utf-8?B?R3drS2lqQU5Nb0xlNEFsaHJFV0E2TlEzTUszTW9SRE9BUnBSa1Bkd1dzMFB5?=
 =?utf-8?B?WDNwY3N2M2t6ZnN0d0FQWkxFV1lWS21Hekdkc2w5NmhqMkk3bE53Um4wSE5M?=
 =?utf-8?B?dHFNS3FPK010cGFpbi92eVJjV3MyeEtGVnFRTjU1TWVncVdvU1E2QnZ1dEQy?=
 =?utf-8?B?UEcyQ01tSWtLbmVYdXFqSUp4bUExTlRJYm5hN0VvTmRMcjRtYVlyRG16aWJx?=
 =?utf-8?B?V0M3UE9RZkFLZ3Z2RlpTRXJadjQ1aEhOeTFjR3NKV3RQTWw1cXhxQVlyWHNx?=
 =?utf-8?B?dmlJSy9ncXJ6eStkSEF4SExjTGNLbzlodEZySFlOc1JwblR5eVB1enZiQVRp?=
 =?utf-8?B?a3REMFI2QXNIUlBNckhOY0tEVEVTY25YZ3FOSk5XUE5rR2IwbzR3TnFzcFcx?=
 =?utf-8?B?VWVPOWZoM25XVzQzOEpuTVc5QzJDQWxiYWY5eEcvakVrSjVoNUd3ZjdMK2tw?=
 =?utf-8?B?OWtqU0lnTjZpa2JHMjlWNkJpNGNpM3NLYXh3RktnVUw5V3RGY29Zd2I3TXRu?=
 =?utf-8?B?TytwbzdmZ1E2d01GTHRscmtkejczelhQZkZDQ25JS2xzazNuVlZFbVJuY3R4?=
 =?utf-8?B?SDNsVjFpSFV2MkhYam1ZN3IzeE1abFNRTFIrMStWdkZJd0JvMi9KaGt4NnJB?=
 =?utf-8?B?NVVPYWxxWCtQajlxQ1FEK0V0Y2R1SmVYdGpsQytHUHM1NGVBVDBzcE1iUTVI?=
 =?utf-8?B?OXMvSmxpM3dRRytpdXdZVXh5V2ZhZXFwaklJNXpMUTYwTDF0bUtlY1pnTnFR?=
 =?utf-8?B?RmtDRnFpakwzaEtSZEoxUDlnb2tiOHR2WlQwMGN4bGtzTGlXTHFhQkp6Wm40?=
 =?utf-8?B?N0U2MzZUTllHKzAyMVQ2aEhMZWxDWmVwVVhOb2VYaVVZVmIwM3ZpNG13S1or?=
 =?utf-8?Q?hd7J9Fl06i0borA8dvZrguc+kVvSW3vhDnMmtnSz1vw2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de002051-8e2f-4fa3-a191-08dd92d270c0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 10:31:09.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZGPDgWOLODyemo2UQNol+lfOmoRO2L2A9oJF0JVNjjMUu+bMzumupyL0tGjImrL0Hzt3eylUjVC9kDljSL1ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548


On 13/05/2025 05:26, Aaron Kling wrote:

...

>>> +static void __exit tegra_cpufreq_module_exit(void)
>>> +{
>>> +     if (platform_device && !IS_ERR(platform_device))
>>> +             platform_device_unregister(platform_device);
>>
>> The device is unregistered in the remove. Why do we need this?
> 
> These are separate things, aren't they? What's unregistered in the
> remove is the cpufreq-dt device. And what's unregistered here is the
> tegra124-cpufreq device. Not the same thing, unless I'm really missing
> something.


Thanks for the correction. OK, but I am still not sure about patch 1/2.

Jon

-- 
nvpublic


