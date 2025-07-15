Return-Path: <linux-pm+bounces-30855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C92B057C6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D8D3B30C6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016892D8361;
	Tue, 15 Jul 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WqX+3PJX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827A21C9F5;
	Tue, 15 Jul 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575309; cv=fail; b=PxHJ+VErm/wFIkFyaoFVCqDZBgsPS/DHv3g3vk3rgpma8TjZTcUvf792XQuOh7ZHv3TMumU20qhjA6flCIV9OmgcokNyIUPKs/ErWaXa9Pt86JIiM3za98FhApKWQq4w0+ZkxzlnOev1G149mI+HnjAX9kHwzURvT5toGsooarg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575309; c=relaxed/simple;
	bh=RtuHgWzPl1QQBxkCpsb0rUG2WJfiyXDHC4rpB+gYhJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qqt2eaeOyyTXzkxsw53MPSsYFBH8rLsJgXB5A+lZUF3cnZumR5mwdK/ggS3anxjqDvyTcwbtfiTO0H30xm9bJOdTvRy/GvIfYgDJmuSmo3qRWXUFgne1Pu8/5xFf0Dt5LpKGIdXZS7ymlC//SclIZibjWAVRi1tIxeq3oMVuqWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WqX+3PJX; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuaiZUkhKF1uy0eZgI4A6bOzWp+thUrrT5ulEipbDDmxCekUGEVWx73uaGLDFxOvOkEQXifYGNQ59vvbzuPqzhiOW96EZLkr+Xo8Iql4C0l9usdyRfbiagmvctOtcVc7iXEOuovvwSSxs0c0S3u+A0EodhAT7blojJt3Qf6ShRQvGoWC/pygy8OmnYtZ3cm1FYHdXbRioG9iA1X8ffUV6/vaWEWfPr5X2bZ/Oe9ghn0lSy0tXcZd1n4C2x7qe730mnrouaS4BEjPSTliFmlqFw0jw39QAOG9ivkKZeO7Sc8rjrieQlN5aar26DfWanyB51KbuTJrSfaJoy7nLIgYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWz4R8iSuHFRVjyKsSHbqjnSI+CEjUmAespE36or4yg=;
 b=MXDgNgz/MtXj9YCqTWtUKFr0NY30/Gcyk7fuw/Huu1DJOxAhtEmlF/T/jivLsCgXHRhZ544qOQ82n6hAK0Nyrth603gZYIEa91VfGqb2aWt2S/cFwV/pri4XZS32TubKVETe1RnmIu8F4xjtRd6fdW29iB77tsAPuMOhEXmLWmisqaKNHvTxcaseRTDOJSZDC5nWuRUWm+d+BXDme+VDzxjRfpDuTxgi5tayaWk7RAe71uTuF8wBsEVBAygmU8EDwKrXJNTC7JMpJOemygBcLPw73i1Hktxhk8dvEe5AOr9vOyOCBlxFgWeU0cnYU5AzMbAoAWn15kOEjtKy68MS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWz4R8iSuHFRVjyKsSHbqjnSI+CEjUmAespE36or4yg=;
 b=WqX+3PJX1hnYh+voXlA8R/4nYcbt2tIjHv7yGwAoGTe2RFIpFBJ0ys9lLpf3gKZjIO6kBeCGAOdpmCT974x3aLPrZs4stlb4D2Arz8gQU5XZVadR8B83F7GfJbgvE8R9AtLQTuet6X+XT553iHWQHPgGqVmXv5R7yZaY0wI0CTFi9dT/enIoCH5jrb6npVAXcKnHl4vH8wlVakngh1PYFhJoizj+78UPSG5pew8o96SxN/DL4yBm/4WAv6RF0ibj47KTDyKkzAebwZ7v0WauWxCOVmeSYvk2h2N6wknY+vomeeVmf56+6SmPqGrBIF6eIrRnDM+5auIpxAVyxvratA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 10:28:25 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 10:28:24 +0000
Message-ID: <01646690-8964-49c8-bbed-556380844b14@nvidia.com>
Date: Tue, 15 Jul 2025 11:28:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] pmdomain: core: Leave powered-on genpds on until
 late_initcall_sync
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
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
 <CGME20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae@eucas1p2.samsung.com>
 <20250701114733.636510-22-ulf.hansson@linaro.org>
 <212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com>
 <CAPDyKFrPOgWW_=ehCjtqAUR97HoLKmgFNO3bRT50-w6A1LgGFw@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAPDyKFrPOgWW_=ehCjtqAUR97HoLKmgFNO3bRT50-w6A1LgGFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a522ba-e208-411a-c2e7-08ddc38a540a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2lFUlI3MFlWeStCcUZnVmNRcTRPOTl2akNMS2p3VllQMTJoS08vYlk1d081?=
 =?utf-8?B?QXprYWd6RTNtUkk3YUdncG0vaE1BWGFIVXlndDIvczlwaHVFK1NsVXQxZ1k2?=
 =?utf-8?B?blVlcG1GdDFRWjl3bk56ZUJXbzU3TzFvd004Mkwxb3NDLyt4K2hKdUVOakU5?=
 =?utf-8?B?QTVYODQ2Rk5xMUhXSlY0RXFiem15dGdIYnRlejlpVmcwTnFoKzJQRFJOL2hL?=
 =?utf-8?B?cG05NFVldUh3SDlmTjJ3bW9ndC9aNlNjQk42OE94UUpzaHlZQ2J1N1BMdTBn?=
 =?utf-8?B?M3JEbmtNblpxRGZVQXhoenp4eXhQYUY5ZnA1NS85bVpDb1Eva3hTSEZYVXhW?=
 =?utf-8?B?b21oRkRCeWhBU1p4dkRDdnQ4YVZka2FXeXRCb1E3blhGZE5rbXNldEJaRTJP?=
 =?utf-8?B?bTVXdHN3ZWFNdHZQNFJWeGk1ZnFNYVQrd1IraFEvK090RHpDNS9tQVk4SjBF?=
 =?utf-8?B?WlNGTjZLcUpudzkxWFVaVGJvTkJlc2lsZ0NjTTArVHJFaGI4cDB5T2dyQUhM?=
 =?utf-8?B?V3Awc0xSVmtTRnNnQnBpb3hkQzYxMGpwRnVKMGJ4eFJ6MFlDTkFvYTBrMFdD?=
 =?utf-8?B?TENucFhZaGFWR09Dc0lCOXJtSWNybWhzZHpJWEtUUWYybXJscHZjQXljSlEy?=
 =?utf-8?B?TmFldmw3U3AyVWZPOW40SHFsV09EeVNGMDVGTkpsU3JvMFJpdWxkQlFiUHhK?=
 =?utf-8?B?NzhweDUyVE1sajgrSXBUdFphUUZOblNOT2R2SDM2RlZZSjNzK3kxOHVFK21t?=
 =?utf-8?B?dHN4Nm1MZFc1TEhjK2w4THdmNXNCKzdNTFd1NWdPR0FtOXNRRkFHRzB1Z05W?=
 =?utf-8?B?cGk2dWFmZWFpdWhIMVJNd2ltMkNEb1dSZ1ZNL3pCU2NFMnYzVHh3aUUvRUNp?=
 =?utf-8?B?WUZFdHZhZ29FcEN5QndQN2VNR3ZNK0RUMXdMakhXVW5Ib3JMU2l4a3h3Tjg0?=
 =?utf-8?B?VnZ6Ti9qNEVYSDF0NXJRVWc3MWZxS3dLdWpKazFPL1F0Y2tudDczZVVXblNE?=
 =?utf-8?B?ZVFoNjIwTmlUVlpMZFZVSnB4SHcxTktGamFseERSa0YrQjNLd1o2eDVJTjJa?=
 =?utf-8?B?L25FczJ1N1JUMDhFOTVQQTlYOTNaZ1RDTEU5RW5pcGxwSjVkZ0ZYWnZiMXNI?=
 =?utf-8?B?OWluYU5CVGJjRC9yWmZFRDNSVFdpTFZEczJ2N0NUeWhhMmprRUpXeEZEK3Zw?=
 =?utf-8?B?a2RObVNjdC9vbWplSzI2Q3R1NGJiVmtBbVBhOGo0Ty9uM1ViNnFVdkt0RG9L?=
 =?utf-8?B?d0dTK1VLZ2pacEtnckNtb1RESDQ1bmFnbEluQm9ma1dVNVBnTmp6VTQ5QjRq?=
 =?utf-8?B?bHBLTjJnT281SHE2YXFCakIyRVVkbEtEaWlyOWdmaHFTdm5abWZLSys2enJm?=
 =?utf-8?B?RjdTZFo4YlZEdDJDL2M2VUpKQUU2U3BuYlhpRng5ZmNIdEpvZG9KSGRYbTFx?=
 =?utf-8?B?cGZYYWErb1NVWGE2L0p4Vk5yazNlUXVVTzZzbTlJTGdYbmpQS3p4RG9VOUxD?=
 =?utf-8?B?dk1tNmJqdkwyOGtlZTFta2N5cXVhMFQyRVhaRGtqNm9zcTIzbE1adHdMK3ZH?=
 =?utf-8?B?Z2drY0xweWtCeVNwQzhwbm84OGZIaS9abFptNFJKQnJpSTZuN1lZakZ1K0wv?=
 =?utf-8?B?QnpWbFZRMDAyQ0YwUjVaNnpTQ1IxVjBwOTdLN3FzUmdTT1FHa0EwaFVscGMv?=
 =?utf-8?B?NHdIY1pCWjVLMVRQZU4rR3hjRjFtTGFGNUNzaXQ2Um1WcEZ5YWNXTFlZQWZj?=
 =?utf-8?B?TWlhaTdRMmlMMjBoMk93WjExUFZYbW41bjFGNDRVL0JrMnJFaVR6WWdHUVM2?=
 =?utf-8?B?NnJLUWppYWVKUXhFT1l0ZGJyWHJHVEhMUm5GNzNuR3BoQmxQMHJ0Z3dScDd1?=
 =?utf-8?B?aTFscjAwQnZuR3c5emEwUnZuem5hMUlTckllTmJ0Q2JDWnlrTEIrK3BWRzJr?=
 =?utf-8?Q?xiDHX17dtrg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZklFT1h2alpTYVA2WWxEV3phYjJxOVhvODlqMzFERytWWGZjKzJmdUlKamtL?=
 =?utf-8?B?alZteE5WSXZ1SS9peEsrQXFJTU0ySlVPbWJOUXpWSWxlTWJCQ29PTDZaNlNN?=
 =?utf-8?B?U2hxSjlQSnBlUHJGVk1veCtMWVJOMWFCV3RrcHdhcG9jWHRBa1RsTit1VzA1?=
 =?utf-8?B?aFVjVzNZQ2Y0d0V0bEc2Ujd3cWczcjBNSUwyY2lDNDB6Q1o0R2N6dW1wTzZW?=
 =?utf-8?B?VTNCajErVWpsSmhqaHgvRTlweDNtb01ibW9nQzUzWXFjRjZja1hxeExWbmp2?=
 =?utf-8?B?bXk0Z2JDWTRvRG4xNkZ4ZlF5bWQ5N2oybXB0VC8rY0NPbW5PU3VtYVJFdUw3?=
 =?utf-8?B?QndFVnlKOXJJRmllakErSGhsbjN4QnEwV1pRZXFMY3BKZllyWHhza1ZkUDhz?=
 =?utf-8?B?dW8xeE1qSGllc1l3eFE0L1JKdW03Q2Frd01CV29adVZCNENqWmtaY0tZRmhO?=
 =?utf-8?B?d1F1YUROVUVacDRvQ2dGcGRzZTMyaDVNQXZvTkhUdk5QQXZaaGdFWWJibmh5?=
 =?utf-8?B?ZkJlNkhsYTVRc1l2a3JJVVJvN09mVEdEMG1NTDlIRkJKdUkwSldCQk9ESlZZ?=
 =?utf-8?B?MGRsbGQwdmtHdkc0L3RjbzZYZnJFdWRGaHBKSm1TeEpMRDhYbmZUUEJYWGgr?=
 =?utf-8?B?S1dNZS9jVnVodnlWU203R29YUTZ0MFhBUnM3dTV4YTZMWllzd24vSGFxRTVS?=
 =?utf-8?B?VjFJODUyUVBHOEtXZWV0K3hDOHM1WTVXOTEzNVYzY3ZWNnZDdnNUSWR0TzFl?=
 =?utf-8?B?NDRuUUM5MUVFS21JSGNKYi82ZkpwaUlMWUlySXRTZExzNENvYlJkdEhPZEVr?=
 =?utf-8?B?UWFkY2pZQWhHeDRpZXBhcDVwUE11WDVQcVBnWVJTSTNwZEQybUpRU2cvc3hj?=
 =?utf-8?B?bnpKUEh6dGZ3bmtsbTBPVXpjaXlsYnFDNWRxeHJ6dm1UdkpuTTU4TEZhYjBM?=
 =?utf-8?B?Y3JmQVJ3VjBVczR2eXN1NVBCNUF2NHRrL0RybFJZQkVFNW95WU1VdSt0Rmdl?=
 =?utf-8?B?UEExQnY1VzQyNTczemdsZGxtc0RHblduTks3aldHc3RVR2JXQXE4RXhnT2Jy?=
 =?utf-8?B?SG9mcWdCOXRYN2VEdVE5REZKcEkzc0JqVUIzbUttek85aGwrbU5lc3ZHZFlK?=
 =?utf-8?B?bE9FQkdjbHNXMmpxS0FPR09sSWtGYUdTOXU3dEdNZVF5Qm5iYnh0Z3dzd1pO?=
 =?utf-8?B?YmtPUFZqN2ZZbWptNU5odHRlNDBsR0tWWFI4OVNER3JzU0ZHYzVBTXJZTWoy?=
 =?utf-8?B?WmFGYlVZK1lOamNVQ1JFTzJIS2FFY05namNlRVVmSDhGQWVIeStlMGR4WE5B?=
 =?utf-8?B?ekpyMUxpT0JhUi9QT2d5TDk3KzYwRTgxNEdiUFllZlNJZmZIUDBlWG8weFVz?=
 =?utf-8?B?Sk9VQjFSRXNFOFRuVlNUQmVZM1VtWG5Vb0c1bVBTUVQ4aFRzSFBNN0ZwaEpu?=
 =?utf-8?B?OEMrZHhpc2tuZnFrTFZUSldXWUIyU003ZTc1bS9YMWpRdXFRamtpVC9nd2pG?=
 =?utf-8?B?T1hsdnkvUGdBVzV3bnppTitva1Rtd2VpRmV3enRlSi9OSm1DdzFQNXIzUk9G?=
 =?utf-8?B?eWdsZU1LUDhIRFk4cm5UbHNVL3E1LzJtZWQ0WTZCaytIUzJzdlhPekNETlZL?=
 =?utf-8?B?U01EMk1OZmJ0RE1KVVBRWTROMXdkcXlBSWNXckhIS1Irc3dhNkNGeVZmNk5y?=
 =?utf-8?B?MGNJMmtzVUdpdTNISGxNT1ZCZXZTY1RjR3pNWE1QbFIrcjMrVDIraUIrUTNj?=
 =?utf-8?B?SkZlbXpxZHc1S3ExY0FMdUIrMkVzU3ZERWFYSXpaQ2VTclRoTTdzWnVCNG5n?=
 =?utf-8?B?THExb2FwRFRsVXBnYUgzNXQ1RXArMmlJNzR5UE9wQlVYWis3VG1rQzc2NlFw?=
 =?utf-8?B?eWhMMDdBanZFWkVYT25zK1p6V1h6b1Nid2ZWeXFBbHc2MEdYbUtqMVN6Nng1?=
 =?utf-8?B?Yk1vTzBnOERGOUMrUlRhdHRZOHpOYlBYV0RJemsxVjV0YU1CU2Y5YmtpVHFs?=
 =?utf-8?B?UmMvMGwzMDY4K0o3dU1ZaUh0MUtKQ0MzdzJIY1dtNVVLaDFBMW1UQWxsRjFh?=
 =?utf-8?B?eGs2eFZaZnNKYitMWFVSdWJsL0g5MjBaN0ZPQUlLNitNNnpVbUNXei9UeDFh?=
 =?utf-8?Q?4H/TJOOaPFABhsPd9Z1Rkv9wp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a522ba-e208-411a-c2e7-08ddc38a540a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:28:24.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+vG6mkNRrYFZoHiv4fUzqUHna3jvJfiNCf6JcEHCeUnvh+ijP7CviRbDwG/XTrEt6gqpCs70OM6Pj6c8rd0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Hi Ulf,

On 10/07/2025 15:54, Ulf Hansson wrote:
> On Thu, 10 Jul 2025 at 14:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>> On 01.07.2025 13:47, Ulf Hansson wrote:
>>> Powering-off a genpd that was on during boot, before all of its consumer
>>> devices have been probed, is certainly prone to problems.
>>>
>>> As a step to improve this situation, let's prevent these genpds from being
>>> powered-off until genpd_power_off_unused() gets called, which is a
>>> late_initcall_sync().
>>>
>>> Note that, this still doesn't guarantee that all the consumer devices has
>>> been probed before we allow to power-off the genpds. Yet, this should be a
>>> step in the right direction.
>>>
>>> Suggested-by: Saravana Kannan <saravanak@google.com>
>>> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
>>> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> This change has a side effect on some Exynos based boards, which have
>> display and bootloader is configured to setup a splash screen on it.
>> Since today's linux-next, those boards fails to boot, because of the
>> IOMMU page fault.
> 
> Thanks for reporting, let's try to fix this as soon as possible then.
> 
>>
>> This happens because the display controller is enabled and configured to
>> perform the scanout from the spash-screen buffer until the respective
>> driver will reset it in driver probe() function. This however doesn't
>> work with IOMMU, which is being probed earlier than the display
>> controller driver, what in turn causes IOMMU page fault once the IOMMU
>> driver gets attached. This worked before applying this patch, because
>> the power domain of display controller was simply turned off early
>> effectively reseting the display controller.
> 
> I can certainly try to help to find a solution, but I believe I need
> some more details of what is happening.
> 
> Perhaps you can point me to some relevant DTS file to start with?
> 
>>
>> This has been discussed a bit recently:
>> https://lore.kernel.org/all/544ad69cba52a9b87447e3ac1c7fa8c3@disroot.org/
>> and I can add a workaround for this issue in the bootloaders of those
>> boards, but this is something that has to be somehow addressed in a
>> generic way.
> 
> It kind of sounds like there is a missing power-domain not being
> described in DT for the IOMMU, but I might have understood the whole
> thing wrong.
> 
> Let's see if we can work something out in the next few days, otherwise
> we need to find another way to let some genpds for these platforms to
> opt out from this new behaviour.

Have you found any resolution for this? I have also noticed a boot 
regression on one of our Tegra210 boards and bisect is pointing to this 
commit. I don't see any particular crash, but a hang on boot.

If there is any debug we can enable to see which pmdomain is the problem 
let me know.

Thanks!
Jon

-- 
nvpublic


