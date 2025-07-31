Return-Path: <linux-pm+bounces-31699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474EB173C1
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2E61C25732
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBDE1BE238;
	Thu, 31 Jul 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="THrNkQQr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E011ADFE4;
	Thu, 31 Jul 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974456; cv=fail; b=pfTMx6KIH0E2qmq6tp+T1MwL5oSv2Qkw+GTDCarU+1tSmSE6UuVR4wniEC3DtC7XPkUaQBFiorVn78GHWtD7ixkaP8Sn4l/+buoWb/gTicJEwnp3c+syG8tgYarxTP2RPealGkihfDkxAoRUos1MWmQtHIIrDH9B+2q5C1SR21I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974456; c=relaxed/simple;
	bh=9RUM0DJposOve+2vRGLcNujGmmPeH1SzuRVBZFkS/YY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xo57lHaPzdjY7KWrUKNSd3ww50z7Li1wOWzYwRfDrBXu0VfiIfoKQJ/jcZryXwaNxtZiZUh3rMyrUAX3UqcOsl9Bp3j6480Qi0I6r4gI4LeKgrEJkrVXLaaWR+tJkQyLiOpQAH14Z6ZywXQQuqw8Ri2Zj5Vp2lqatoPCyhDE35Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=THrNkQQr; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkPiJOUiYCaFWM/JWCaKg5L2T7l7HBV+jLFKi7TUGTH/+bRe5eud/dpFLURczkZERtfVmSfFH9Fa8Cry9mwbtEobzJUrQY6u+Z1FJ2hFXaCg9HuyLMdMNgc3Gefl9H9YB7CbluOSzDFC2iOHQmjNB4oukNCla939agQQWtrz4wwoKbHTMjeG4JRED7e2LE0YZniFm7m6QW9FUOo0sU21IEI6V/+SVggCshdO1wVF/FmJRcm8wo1so26uiX7mtuTpb7pZdkJEhsWk4C835axj4HMLENLM2aIxfCDHiG6c8iDgN7dEaSD2FB1imgzzgw1C2zF+QgfjvnhFXaF8prNhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlNfEy6/WyiJ3l431H1ekDwy1/YArH5TVXP13TSFxew=;
 b=iIzmIqSe1RhCOE29WJKKG653nGas/isR9gdvq9KhWyg4yq4eDt8vXWkCxNSmy824RxXrKPqCEyaVf4K79VQINlbolIFxPMC9fgwJi7QlaYmiLcK8d/VN9yA37iWSrf3xwzH4Y4DeGfqMZ4cjIKcovwz12W44GoV+aKNdwUQTe8MFrXVfiuv2kZ2YTkE//ihL7WoeWEnXUsIptjU6i8v4tNvg0m0OocG62p1bTBBpBUZb8wiv7cLOfNdO0B05m2zbD2VFceoGqfj0AaLEGYXbRTO1GGHQxSjQ4gzJU2eQTfVdtzi9QqN1LB0xTDNBiTzGf78ayyvPCudfwqdS294odg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlNfEy6/WyiJ3l431H1ekDwy1/YArH5TVXP13TSFxew=;
 b=THrNkQQrlx0Gd10oPT8vzmGZBqVIlKEmNrS2BVJfALzoXNPRnXkmUV5gS2KFxCp9NeZdDBBJKbAOg7FU50KWTU1bt1lT1I2ux2Z7qkKjBGlaJEviyeIRUb1dQofJLnL2cQ/jOh4XkJGalZVuOOmPr7i/2zDvsXsyqHYzoA/XMzlBS8+1wMCzRV9Qifj4AgJDjZJVIbAHqoHKHXUsP6FH3AGKK1yZ+EkFiIfnO4d/+pEHRFO3Gw2/ep7OboF51BEMMP5RBHWrFK5TdY5pg86sQuPh9Yv67OiBv/+ulWmJjNC1zEJabfgR025SYu9+66Ir1vlbbHSfbsDKpipqh4zVPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 15:07:30 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%2]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 15:07:30 +0000
Message-ID: <4478f28b-47f8-4049-bf17-b7fc95cfac65@nvidia.com>
Date: Thu, 31 Jul 2025 16:07:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-21-ulf.hansson@linaro.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250701114733.636510-21-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0615.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::17) To PH0PR12MB8773.namprd12.prod.outlook.com
 (2603:10b6:510:28d::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8773:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 0181a428-ca69-4adc-83e9-08ddd043f7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHpxbVI5SWQ2bEtNUUtya1ZOR1ZUSTJFT0FxVGlNTGhsSFdFaCsyeC9zSkc5?=
 =?utf-8?B?WUJUR3RDRkZzY0tUUXhRVHpmMFRkMnVxNnhxNlUwT0lhTEFKRjFTV21weXE1?=
 =?utf-8?B?aDJTMCtOZFpGdENjRXJzS21uODJLaGZmWWJrbFNYYWxVajhidjFOb0JzTWtT?=
 =?utf-8?B?NUxteGlkcVp0SWNIWnF2NElVQTAyMWhBMy80dmtTaUJTQitEKzI3VEszSnhq?=
 =?utf-8?B?WGhWdE5QYXdVeTZKSXIxcUM5d3g0Vlk5UXo4TkVBNEcxaGdQb3ltV2VJRmdO?=
 =?utf-8?B?a2VtRUpVQlpOT2J4a2VCc25OY1hTMml4RU9OWHJnbFIwR210K1pOSXR3Sy9U?=
 =?utf-8?B?SzA4elh0ZFJzN01wUm9zMi8xUjJZUFNEYjBtRVVvQmExRmUvWnRkR09IY3BE?=
 =?utf-8?B?QUMzYVg4S2xjdTBsWDM2QWFvenNDOGZaaXpLZzRQUDJ3S3dZaGkvc0dWaDUy?=
 =?utf-8?B?all6Mk5IaEFDNVJ1Y09SSzdqaEliUjg4RG01dFFnSHNVWFMxNGNTcUxPVnRx?=
 =?utf-8?B?dTd4UU9oN0FxRnQ1V1NNcGRjRFZ2bjZiRTlITzg5WlhZOGppQXZET0JDK05s?=
 =?utf-8?B?U2IvcTZIU21JMWpWUE1ndG52NElocWFub2xHeVY1TVVhR2t1TE1xNVlVVWdV?=
 =?utf-8?B?N3REVkJramdFVnZrQzZDSGlJNU4zdkFjNC9xdEpnQlBzbDMyaEFzVjVkNDdQ?=
 =?utf-8?B?cWRCQlJvTXc2WjZCRkVETzIraW5nMVVNYzRNR2hmRWFlZ2E5L0Y5cTdxNTBz?=
 =?utf-8?B?QVRzWkJhSm03VW5weXcva2FFejNuamtsRlU2ZWk4ci9yZWZEOUd2L2tlM05q?=
 =?utf-8?B?UUtoUTNzd1A4Q2RjNVl4aDNLdWw5L3JtL2gvMU9IVTRQQldMUTdaQjZvRTFm?=
 =?utf-8?B?WlVYL2hCdXI1dWU1YlU1VHUwRDNKWVpHU1hjcVdQS0p6Z243K3AwMWVEUU5Y?=
 =?utf-8?B?SzBNZXEzT2RIT1p2dlhNaStYNWRINWxEUXdVa2lHRWM0SllHYWJYcWNYRm9H?=
 =?utf-8?B?WFlYR0RiTlNxYlJMYzcrakZqTjlQUHRmRzVoYnJ5OXpWSDFQaDFHWHphczR3?=
 =?utf-8?B?WkdOa3VwNXJtTC9DeVNvWGw4QVVUOVg3ZU1odStWZUY4dDNNUUxrdys4VDZm?=
 =?utf-8?B?aWd6dHlEUDk5bS9FZmtIZVdMNzRJQVhpS2ZCNUwzN3R2YmZCRnpXV0xkTmJZ?=
 =?utf-8?B?QlowanhTaGFmbkpGVWVxTkd2T1N2ZGtPdUJJNnQ5Nk1FM2xvdDZVOSt4Z0ds?=
 =?utf-8?B?SThzbWFmaFJvRjJUZmlHbWgvZ1NUc1oyYVFXMXZDN1dRNlNwZmdraENQQjFD?=
 =?utf-8?B?Rlo1WHVBa21ycnF6azZ6ZnRTZWh0cGNmRnoycmcvSlRySmJIRkJIQWxJQ3pi?=
 =?utf-8?B?U0d3U1VCY2FDNGRJL3l6L2tSeStWQ2ZCQXlrRE45Z1lnTk0xMWg2VnZ3bjFY?=
 =?utf-8?B?SXE1ejVZSG9WTllsTzBSV2ZoV0dFWFJFQ2d2M3QrbEZBV1haK3FOZGM5dWNt?=
 =?utf-8?B?VS9CUW1RSmNYLzE3QnptN2UxRTVOZ09mamJGbW56RDQ4Y0d5N2VzWEQ3TEdB?=
 =?utf-8?B?b3NLZ3JRd0Z2WVRpTDlUZm1CaUJzTit3WC9ZVS8xeTZBeTBvS1lZYXhRL3Nz?=
 =?utf-8?B?OVRUZ0VjVmd0RnNTSnF4NVJENkNNeGJ3M1FSeHlVYVYwQ0V0ZkNNZzJRNmZG?=
 =?utf-8?B?bHVPRDZZMTFXL241b2JHUmpPNmxaaGZXRkh4Mi9NTExSL3UzZWY2MXE2YjBk?=
 =?utf-8?B?YXlkUmYzZXFjR1hLN2d4NUduRHBPOWtsbGp1dmNrQWhETHlucld3bUdSSTEz?=
 =?utf-8?B?WlBiZWpKeHBod3FvWnhmSFBydFhXZjZXR3R3NUE0TkpZTnVQeDJ5MjV3T2p2?=
 =?utf-8?B?MkdBa1RzTE5kZlFITmtTaUNQNVFvM0F2UFU3RnN5b1YvSXUxQk4yZUJFd0hT?=
 =?utf-8?Q?fHfjU67q8Cw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjJMbEtJbDdRVFlpS0pZUmlGVHFIOXl4VjMveThWL0h2QS9nUUxhQmpvVGdj?=
 =?utf-8?B?T2orSUQ0N09nK29JTktGWUVreEpOZkpmc2J2c1I3YVhIaEJxSmlkOGxLZlpq?=
 =?utf-8?B?eFdtNlBoUUYrYm9MNnhWM2haWWo3a3RxaW5pdkprVGk0N0ZxMWdBZFpCMzRS?=
 =?utf-8?B?Vi9ubkkxN3ByemN5U0NVTXdKZExJVE9mNG8zeXY3ZWtuVitWK2ZvcTY2b2NY?=
 =?utf-8?B?K2ZMaVRINjIrd3VlcHA2dVMySCtqV3VWOXNqTSswWFVOeEhoSmdEUGtWNGZW?=
 =?utf-8?B?YW9NNWNjQU4rU0ZwYUFuSk85a25sdkphTlFEbzFlM1VOeGRwQjdzMjRKYjhZ?=
 =?utf-8?B?c3kyY21CcjFOTnErM1ZOQUJqSHlya2lEVlVmZU9qUkdwL0lyZkVTbUdrVzA1?=
 =?utf-8?B?cmx3c3JOM1dWS3lSWXBKYmxJbEl6dHUyUnpSY01acFZ4RG55dEM5dy9vbU9H?=
 =?utf-8?B?a0JvM2NITWZ1dnJrbm1WYml3eHkzcFVodllSY1g4djFJd01PeGRMUkt1czJL?=
 =?utf-8?B?TjRhOFp2VzI0bzluZlg1ZVZHdndFZGZFM0dha2pMOHV1Ny9qa0V0SzRxdXNW?=
 =?utf-8?B?dFB3RHMvWUNOd3BYQ3ZaTGFLWjU1NVVDOGRXUzR3OXlweFhUb053VFhxejhx?=
 =?utf-8?B?RVRBM2xFVVUxL2dOUlpxWkFPWFcvS2l3cXl0RkVORmpNY3o0Z3liazM0RTZK?=
 =?utf-8?B?K1NLbU9tT1VWNk5qdjFJbWF6ODhXcE96RktxSGptRUdlWGhEeDVhUzA1Q0s1?=
 =?utf-8?B?Q1Y1WmxBdjA1OHozRXEzQnB2S1NDZnB4cTFyZ3ZQWjNJbUc4NDlwQmUvZTg5?=
 =?utf-8?B?NjhHdE1jQWxMcVZFczVMY250MnZkNngwM3hSdTFMdHc2RjhDODVzWkFoeE1w?=
 =?utf-8?B?ZjJPQlo2K0Iyc2Y2MDBZeVFXRjE1aCthSTlLVlhKQThPbCtOYjF0VHdNODc0?=
 =?utf-8?B?d2hiNnJhYzJPbk1lbjlTZ2pPemptYjBzWVlNWk93c2daMnR5cmZqOW1OL0w0?=
 =?utf-8?B?ZmovOUJuMUpyZnAzNVFEbWJCSVV6dVlLTEdhay9iY3c2eDV5azFlNmRONXZG?=
 =?utf-8?B?N0RvRHRDNnhZdTJQM056a2J1RzRFdG54NUdyUjhzdUhNUjByaWhxWlZNaEoy?=
 =?utf-8?B?VDJmc2MvVHV2Tjd6ZjIyZWJFa3VlVG5QSTlaSWs0aC9IemZ0a1kwTEV3RXU4?=
 =?utf-8?B?UU1Kck5admh6UlJLbGpnbnVOQmdUcDd4R2lMaS9pTm0yR2pSV3M5VkVTTm94?=
 =?utf-8?B?WGVwUXlqdlJGOTd5bTkrZFlsWld5bzBlQm81SFM2RXIvY3pldzExbjlKMkdl?=
 =?utf-8?B?dlJBL2IyRzJpRDVaZXRtY0VoNzljNTUwUjMvOXNPTlRBNVVJYVNScEpoNmR5?=
 =?utf-8?B?TWhrVXJzOXp5ZThxNGRjNUhlaFJNS2Jwc1VsdUh4OXlCamoxRENPUXN1SHV4?=
 =?utf-8?B?dFc1UC9VVmtVNXVUclViQ2x1TUpRb3A1eHV5UE9ubVBqQ2kxUnhJMTlwM212?=
 =?utf-8?B?eVdXb044clYvVEtaM3Zra01ML0tJMTNrVFNTaFRSQkY3b0Q3SVlWZW9VVnZq?=
 =?utf-8?B?enVPM1NONDVsRWRWRDB3aW50dndBK1l2KzVUSlJyTys2YXpyZk55TU54ejBs?=
 =?utf-8?B?WWR0MGVWa05EbTNzNHFPUXFwNEcxY2hPeDE0U3JDOERGcEdBcXJTL3A4aXM3?=
 =?utf-8?B?OU5OWEFFMUdhdGRXRFd4NFJEOHRBSlcvVjdLNCtnUVBLajl0NUp5M0pJTlZn?=
 =?utf-8?B?SGFBSGxxTFRKS2gyVUNhVFI2NjBtTmsxRXloay9uc1IvQTlxRzltYStZamgx?=
 =?utf-8?B?STRkeHVUMXNHUU9xMm1Cb3R2b2ZQWVhOMkZYZVhIbTNBOFhSdUN1clRnZnlQ?=
 =?utf-8?B?L0U2eG1uaWt1VWZSWmdyaTN6WmttYTZJV3Fmd0hieVVUMFJTbDVuWkp5L0xL?=
 =?utf-8?B?QUtsQ2VtT2o2UDRNMFcxN2tFVzBiY215NmJGK241SmVqM20vampBUGJTRE9Y?=
 =?utf-8?B?N3R4QmNxMVh6bWp1amx6YjM2VkJMd3BXVUVoUnUzZnB2R3FJT1NYdFhNcjlS?=
 =?utf-8?B?RitqSlZkK1N6dHZtZlZqenFaTm8xMXl1Z0NVNmk3L1laSENKbkdlUnE5TVFy?=
 =?utf-8?Q?3QIb6xptrynorumQcem6JBdA/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0181a428-ca69-4adc-83e9-08ddd043f7bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 15:07:29.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyjAKIpxkHNsqYwSSvuuj29upL7Hsu94nByqx/9jMZKmGquPPJ6IWIRkBo0AfSnX7jWX9jMEQ77DWZzBwlpgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475

Hi Ulf,

On 01/07/2025 12:47, Ulf Hansson wrote:
> Unless the typical platform driver that act as genpd provider, has its own
> ->sync_state() callback implemented let's default to use
> of_genpd_sync_state().
> 
> More precisely, while adding a genpd OF provider let's assign the
> ->sync_state() callback, in case the fwnode has a device and its driver
> doesn't have the ->sync_state() set already. In this way the typical
> platform driver doesn't need to assign ->sync_state(), unless it has some
> additional things to manage beyond genpds.
> 
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/pmdomain/core.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index ca47f91b9e91..5cef6de60c72 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2600,6 +2600,11 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
>   	return ret;
>   }
>   
> +static void genpd_sync_state(struct device *dev)
> +{
> +	return of_genpd_sync_state(dev->of_node);
> +}
> +
>   /**
>    * of_genpd_add_provider_simple() - Register a simple PM domain provider
>    * @np: Device node pointer associated with the PM domain provider.
> @@ -2628,6 +2633,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
>   	if (!dev && !genpd_is_no_sync_state(genpd)) {
>   		genpd->sync_state = GENPD_SYNC_STATE_SIMPLE;
>   		device_set_node(&genpd->dev, fwnode);
> +	} else {
> +		dev_set_drv_sync_state(dev, genpd_sync_state);
>   	}
>   
>   	put_device(dev);
> @@ -2700,6 +2707,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>   	dev = get_dev_from_fwnode(fwnode);
>   	if (!dev)
>   		sync_state = true;
> +	else
> +		dev_set_drv_sync_state(dev, genpd_sync_state);
>   
>   	put_device(dev);
>   

Following this change I am seeing the following warning on our Tegra194
devices ...

  WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 17000000.gpu
  WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 3960000.cec
  WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 15380000.nvjpg
  WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 154c0000.nvenc
  WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 15a80000.nvenc

Per your change [0], the 'GENPD_FLAG_NO_SYNC_STATE' is set for Tegra
and so should Tegra be using of_genpd_sync_state() by default?

Thanks
Jon

[0] https://lore.kernel.org/all/20250701114733.636510-10-ulf.hansson@linaro.org/
-- 
nvpublic


