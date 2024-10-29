Return-Path: <linux-pm+bounces-16635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36639B417E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 05:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E28280C3E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 04:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923311D54D3;
	Tue, 29 Oct 2024 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iVDh51mL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FDFC0B;
	Tue, 29 Oct 2024 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730174961; cv=fail; b=gxDy7G3u7ucRiA4rI+SXtVKXlaY/8s7sZjTpYGRKhqlKNZWi5eFoNHcjs0/dBfokm1jw2X10ZCM80CG6F9QNPvaFtkBGGyfIZDuVthsOC149rmp6TuG93fkIwLloGRKTf2BR6EajS+NFwLL8Ub9bNMcHkmeEHDOHvBngtUiFvdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730174961; c=relaxed/simple;
	bh=dRrm0PGuEFtNeK3JpM0KOW3Uuzc4FCru0lD5CHi24FM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nK4SPaNfgQWWPJfidjxIttW9yfAvRcxjKMaXyT1194tDCHFDlio4v7VIsgO6yyBKaHsctLv8F0xmIKTmsMyQyOIiIYvuBZstQ+rp9GbkW3wY7FGgY8JOoqnBvnEmnQ/Y9U114Fv6Nbl3IdNRKD24+Wc56ywSXSQ9qgEZutE1hKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iVDh51mL; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5RDYsdRg7ykHvOTBKnY5edXy4bvfQz7pKuFQDvysJqNUklkxIxCI7+YRjV6i67SV7aU0Afwj1NqA+RbAvorGHHcsmXcGPpL7YhmsmErdsmM4GCxoj/fC/Q7KrNpaWojBJl7TywnFJN5Gb+bp/6cO70P2SSHY5Tz2eAGw+nufaOiRVWNt8v8ScLZ3OJK+Jkf1RKBNJqDojiX5YQHW3Nqn4Jp4WdxQzx6G/U+oVOjHTJKexk2/IQ/rBtpYf79u6jeIGezPPxEE7Aa51FvB0rJfQhb8uzJSrjWha8+M4xSdzczbonvuheiBcI9hY92NuPtO+W5/Nx9q80rZuNxvfliFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSDX3V21jTYQleIrjQKqbzd7jqDKqKupHBwjOCI2u50=;
 b=lxJkXjW15yV4zZN6M9GkKjQy6DseBhZDKpCXfeLNbM3/QtluMXisI9lzmSc8WPT7PoxJZyD5zZgE4T2kQMYrz6eogwlUyOkyxeExMCNMpzAnbUk22XqyZRtX09nwbX5VxKuNSij6o3VRUjKtlhO7n6xg/QI7IgWQGr73Hg+gRdaMiFoBli2qJdBQ3Xs684AJtoxupBlFrcGS30iQNfEnguH2FwAwZ+uarnh3K+TrXysRCta8k7C8GIYVcA/tyqHPzw3s69YaPsPfA+J7nwqw61a9de+uKlCkZMTTo1jGqAiv0piwdjujETioSZyU31sLOVLhzgB9S32cufp0S16YVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSDX3V21jTYQleIrjQKqbzd7jqDKqKupHBwjOCI2u50=;
 b=iVDh51mLEoDJB5NB107YB88njY6dNtQvkR3IfxlYk/ceQyVFRAFmqn7hwoNGDhgbtynYfJ/qsHlW9OgS1lyZLe1HzRWjzDeKnNyg3BgvC6YAvfEEeGRZosCsYZKG5HVgmK+TUJYOm4EAraQswfolV4+ggaxk2XOTZs3k/HO03PA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 04:09:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 04:09:15 +0000
Message-ID: <b950b73e-fe40-4172-a95e-a7902179c5b7@amd.com>
Date: Mon, 28 Oct 2024 23:09:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost in
 passive and guided modes
To: "Nabil S. Alramli" <dev@nalramli.com>
Cc: "nalramli@fastly.com" <nalramli@fastly.com>,
 "jdamato@fastly.com" <jdamato@fastly.com>,
 "khubert@fastly.com" <khubert@fastly.com>, "Yuan, Perry"
 <Perry.Yuan@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Huang, Ray" <Ray.Huang@amd.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
 <20241025010527.491605-1-dev@nalramli.com>
 <CYYPR12MB8655545294DAB1B0D174B2AC9C4F2@CYYPR12MB8655.namprd12.prod.outlook.com>
 <3a4596ba-1a83-4cd2-ba17-5132861eac00@amd.com>
 <894de4c2-ce04-4cc1-97d8-fc7c860e943d@nalramli.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <894de4c2-ce04-4cc1-97d8-fc7c860e943d@nalramli.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:130::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 84018eb0-4202-47ba-1bd8-08dcf7cf73c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUlmRm1xK3F3V2VMQTJtby8yRHg3d3h1ZjhYMVBmVzFTR1d0cWdCRU1XL2Ey?=
 =?utf-8?B?SjFGaWd0SHBzdnZHQlo0cmpPdk8wMDlWWFVwSmFlWktMUVo2MWpoSVM1RFpp?=
 =?utf-8?B?K3l1ekx2NHNPcEFVS29ET043NGhxS05sTWkxZ0pnZU03TVhGTmlvTWdaRVJX?=
 =?utf-8?B?TjFSV1N2NGxBVmM1cHlMZEZ0Vk5KQ1liSnc1SE51NlNHVWZCSTNaTnBZZ1dI?=
 =?utf-8?B?c1pnSXFucmdxaFpQS1ZjZlJpMTlTelFmNmkzUnY3MjZ3QTB5MmtDNlZsdnRO?=
 =?utf-8?B?NWMxQ01sWUtuOHZvUUpCZG1KaTk2VUEwNXc1em1MZDhvMlFOOFRwM0NjWks5?=
 =?utf-8?B?UURyejRZT0tveFFxR3NhbzdacWE2bERZYkVoOWVPcmRrT0RJZ3puSU5KSkcy?=
 =?utf-8?B?TUhoejJ2Qk4ySnVUd1R6QmQ1VElpakFTSGJENjNIWlYrNWtjdHJGTno5RzlU?=
 =?utf-8?B?blpzU3BJa01ESS9kdi90czRvRERraFZJMHFtb21NYmlHSEpkUUNVYXg0bUJF?=
 =?utf-8?B?Nk9ockRuNENsd1Z1SkdaWXNpNEtWdFk1NDR3ZlRma2ZDc0hlVmFQK1hOV2pO?=
 =?utf-8?B?clg1djIyd0V1aXRNamcxZEVjcjZnM05jR0pXV1NaYkxaNDc3ZXQ3QU5ZMERs?=
 =?utf-8?B?VmluSTFWaXFJN0xLc1ZtMzJqVmtnd0llRm5jWHVKUWRPQTlBV2NWL2U5M1BC?=
 =?utf-8?B?STFrOUpuM01EQ0p4OGxzeVYyNzRNdU1lQllwVUlxVTVoRGJWOElnalZidEJt?=
 =?utf-8?B?UmFmWm0zWUhWcXVWa2xSOHhEUmxMZlBOU3B1S3RnMEMwT1pnV1c4V2VTUEJs?=
 =?utf-8?B?enJRSmVpQVIydGZsT1JwUlpkU1hFWW5JQTNlUVY1bjBhNFVad3pmSWxrSWlq?=
 =?utf-8?B?clFzQlF0SWNSZFJYdGkrUit4VnVwVlR4c01pTGRvRVFBZmdmY3o2M3hUa3ZK?=
 =?utf-8?B?cFJQb20rbGxqODlicDlHRkJPNVZNUDhDenFqSTBtY21IMm9pQ2VGZ3ZjeXlr?=
 =?utf-8?B?WDFuenZ2MXpNUFFGYWNUV0ozME9PT2NUS2pqWXZHZXZMZWllcDh3cksvMERP?=
 =?utf-8?B?Q1pvR1RKRkk3WVdmakRUMmtMYlVEY2dqdEhydDZmYWU1RURqUSszc2FOTmRu?=
 =?utf-8?B?Z0t4L1k4Z1k1RkJzaHNpUVhOQk1FNUdrTlAwcUhZRlg1TkJFUllYMTNFb3hH?=
 =?utf-8?B?ZGUzNTVOMGxmQS8reG50Ui9qdHIzdHRqMHQ5UTFwenRXUjVPNXExVWFiR25J?=
 =?utf-8?B?U0ZkSFRNQUQ5eFJpMEJJRGcyQjgwNlhwM2NUWS9wdEhwalVScVowbTlaQ25G?=
 =?utf-8?B?d3RVOFJKOU5jNVp1My83em00OStlZzdESENxbEVsaVd6dnlPUVRRU0RQQkIr?=
 =?utf-8?B?bkhmektoSXpmZjBwRVFPV05XL1JIUUoxZlV5VElUYzZFbXQ3MTBFNVhLQmRp?=
 =?utf-8?B?N3U3dmRZcEM2VW5tTGdUdmxBc3JxbE53RE9GUkF5QVZSWm5URDg1cEVmamIx?=
 =?utf-8?B?amlOakFYeHdOMG5iVEJUbjhWdDlKMDg5RjlXckZPSzJaS0taektnRkR2dXg3?=
 =?utf-8?B?cEdMd3lxa2hBQWdpRWdCa2VyUnIrSDBZVnpVYjVRQVZmS3V5d0tmTWpHYTV4?=
 =?utf-8?B?Rk1naTBTa255QUxFd0R5M2t6Q2ZQNHl1dlRpWUw2bjUxd25kRUhqTEJqZVlJ?=
 =?utf-8?B?UW5rV05BL0RrbUpXTzBlRTRZVmZOL1hkb1lsNVd1RzVwMU9IUU1Rdjc0VklD?=
 =?utf-8?Q?QP9nXYO6iBEB0mpwaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVlTUVBvTmZ3ZmtYMVhGUEZiM2IvcFd3bkdtSWFPRzRzNVdVc3RoNlROUytS?=
 =?utf-8?B?M0Q2TDJ5ZTN4bGp3TXNoRHJXZmdEb1BFLzFyNHhCblRKY0ZvanRZTEl3N3ZW?=
 =?utf-8?B?YXJCb1dKRXJqVE5YRnUrK0JyYTVaN1NhdnE4QzBNRElhVlpJbGhhWDlrUTZ0?=
 =?utf-8?B?c2VBb1pjU1dSU3l3WWRKMjdya1NITjlXYnJrQVY2aDcyMW43OEpweTJNUzhL?=
 =?utf-8?B?RGFkTkY0N0kxY3NJbVZtUUQzeE1LZUFjcTI5cm1jeExQdVVBa3I0ZHBMWlJv?=
 =?utf-8?B?UmVjYUY3NkdudVU2dlVLazFMTStMcTV4dlNmVVpOM1VKTW1kbWN4WGduZ3dU?=
 =?utf-8?B?d2hxQkQwcEZLM20vTVczejc2RGtaUVNKYzh6Z3lUT0ZMQi8wbUIrcHFwL21s?=
 =?utf-8?B?SCtvYUlJZzNObk9DS1VNa3dRdWd2WThHSUFjbnFnL2FSTTB3OUY0RWhCVjhy?=
 =?utf-8?B?aFVCMWhRc0dzN1FDNFFlRkNWdzMwUTJSQVhlRWZBTUdOd2NMc1JpTUs3L09r?=
 =?utf-8?B?TUVSQ2JQajdqbjEzdnBNRlIwbmRwRVhVZEdrTzVkQUpRdzhDUTF3VmhRR0Vw?=
 =?utf-8?B?c0Y0ekVwdUxQVnJyNldrOHBPbCsxSW4zTGhNeEt6WHZjWW1JbmRSQXhiVGRU?=
 =?utf-8?B?bjhqUGFuZFpkb1RpeCtnNWxUWithcDQ0Zjc5MHk2SFluUSsycGRyVTlXcnN6?=
 =?utf-8?B?WjFCbXM4QUdBYlBBYXdDMU9lZ2N3Q1lwNlFWTXpKTEhtcHBnWVV5OE1sU0hm?=
 =?utf-8?B?cmMycVBNSElqMGNOWEZvWkZOOGdyWENJb3NSUk05bk0yWE16LzNKRVBaaFhk?=
 =?utf-8?B?MnVpdzBSN3g4aEdTMm9yWi9abS9uekE4aUZOeVl4blFja29DQnZzdXc1cTFt?=
 =?utf-8?B?UFRibFU5cy8xYngyY0NSR0FNRWFtZ2NVVVJsNWFSdWlrK3dCM0tpMVkxM3or?=
 =?utf-8?B?U2N3ZlZFVWxNUVFRTkdtb25nclBhSXBsTDF3emNmaXFqdjZEYXNjUXM2bTVF?=
 =?utf-8?B?UlY1RytkZkloREhyYzZXNVRZZ0R4Mnk1VW5hYkoveHY0QnRCcFpGNm5XNnVL?=
 =?utf-8?B?SUZILzdUMTVwWjJ6SkZ1c0hGWUJRcGJnaUhTMFNQMEkxNTU1NkozVHk0cDBv?=
 =?utf-8?B?MUI4WVpIdnZia1pmTUlGLzl6TmNVMjI5TzRFY3ZpclJzdmpkUFQzWU5YNTNo?=
 =?utf-8?B?enZieUMzdDJ4OHFucjBUMTJJRE9GVGFzK2pjdVFPdFlaL0JUbnNVSjYxOUtU?=
 =?utf-8?B?OWFMZmo3RC9nM04wblV0T0xpQzNOQkl1YzRpdkdTWWFJcUJLcVNJcjkxK2VL?=
 =?utf-8?B?dStKb2t2OWFXamZFQW84aXUzeDhTeW5CUXRNRzlwejlHanc5STFjK29lMnZH?=
 =?utf-8?B?Q1JLZWxGenFLaGV2OFNZQ2g2N3VzR0VpbFRURmtld1lNYzE5SVlvNDF1R0Qw?=
 =?utf-8?B?TGlQLzVFbnRjTFNMaEo1amZndmxPSmpJNFJHek1OOTY4UlUvTWNHR0ViTE8x?=
 =?utf-8?B?VWs5MXBxOExoc3pIQUZsNHhrMjg2SjduOE4vdC9EL1RpS0cycmZqZi9TQzFq?=
 =?utf-8?B?NUlmcW9MR253Q054QW9wbEd5Tmp5NFFsZEpBU2pFSUZuV3o0YjJVNlI5RUgw?=
 =?utf-8?B?aUZwaDdZTlVuclQyYnpnTDlkVWN1ak1YWDE5azl5U00vRk9pRnRkaGd0R1ZP?=
 =?utf-8?B?NS9YSjZQTktTUFhaS3pMbjhjcTRtNkJHNFAybmplUy9Ld1ZBK0ZNNVNxbUhP?=
 =?utf-8?B?a21OMFJlUnRYWG9LMlUvOWVGcVZHbTNSTU1zV2M1Q3poT3BsQy9lWW9QZzVr?=
 =?utf-8?B?ZWRUclN4dU9jd2MzeVdKMlFMNmxiRnl1VjRDNWZpajVvcUdKZlJxVGkrbE1U?=
 =?utf-8?B?YVRnaGMxbkQ4ZFJSMmdoU0lCREgvN2QrMVpRaGovR2QrZjVjY2I0cjdJbWJx?=
 =?utf-8?B?VmdhWjRYWHFvcnFIbUx4RXZsOEtrRmoxYStKZ3hEWkc2ZFhhVnQyWWd1dWxQ?=
 =?utf-8?B?U1FTNGpDZ3ZQM3orMFVtTEFXVGs4c0VGd3UzUzN4TExYSWljMjBEcG50V1pI?=
 =?utf-8?B?RU1jNXlDVUlrRmR5UktJVDh2bzhnem1sazFpSklLbEQ3Q1Z0blJvbGh0emdt?=
 =?utf-8?Q?q0M/DWBqtBe+FfOIIodPFBA6T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84018eb0-4202-47ba-1bd8-08dcf7cf73c7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 04:09:15.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wxb5l+wofHpJOaeCLP1zGPIdjBB5QYhSOdQobl9XpNH71tjFFda755mN0w0uY4HGFGNxZIni8O+POjP5VdmWbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096

On 10/28/2024 16:33, Nabil S. Alramli wrote:
> Hi Mario,
> 
> Thank you for taking a look at my patch.
> 
> What do you think about the following for the commit message in the next
> revision of the PATCH, and omitting the cover letter since most of it is
> incorporated here?
> 
> ***********************************************************************
> 
> cpufreq: amd-pstate: Enable CPU boost in passive and guided modes
> 
> The CPU frequency cannot be boosted when using the amd_pstate driver in
> passive or guided mode. This is fixed here.

No need to say things like "I did this" or "this patch does that".
Just drop last sentence.

> 
> For example, on a host that has AMD EPYC 7662 64-Core processor without
> this patch running at full CPU load:
"On a host that has an AMD EPYC 7662 processor while running with 
amd-pstate configured for passive mode on full CPU load the processor 
only reaches 2.0 GHz."

> 
> $ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); \
>    do ni=$(echo "scale=1; $i/1000000" | bc -l); echo "$ni GHz"; done | \
>    sort | uniq -c
> 
>      128 2.0 GHz
> 
> And with this patch:

On later kernels the CPU can reach 3.3GHz.

> 
> $ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); \
>    do ni=$(echo "scale=1; $i/1000000" | bc -l); echo "$ni GHz"; done | \
>    sort | uniq -c
> 
>      128 3.3 GHz
> 
> The CPU frequency is dependent on a setting called highest_perf which is
> the multiplier used to compute it. The highest_perf value comes from
> cppc_init_perf when the driver is built-in and from pstate_init_perf when
> it is a loaded module. Both of these calls have the following condition:
> 
>          highest_perf = amd_get_highest_perf();
>          if (highest_perf > __cppc_highest_perf_)
>                  highest_perf = __cppc_highest_perf;
> 
> Where again __cppc_highest_perf is either the return from
> cppc_get_perf_caps in the built-in case or AMD_CPPC_HIGHEST_PERF in the
> module case. Both of these functions actually return the nominal value,
> Whereas the call to amd_get_highest_perf returns the correct boost
> value, so the condition tests true and highest_perf always ends up being
> the nominal value, therefore never having the ability to boost CPU
> frequency.
> 
> Since amd_get_highest_perf already returns the boost value we should
> just eliminate this check.
> 
> The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
> amd-pstate: Fix initial highest_perf value"), and exists in stable kernels

"In stable 6.1" kernels.

> 
> In v6.6.51, a large change, commit 1ec40a175a48 ("cpufreq: amd-pstate:
> Enable amd-pstate preferred core support"), was introduced which
> significantly refactored the code. This commit cannot be ported back on
> its own, and would require reviewing and cherry picking at least a few
> dozen of commits in cpufreq, amd-pstate, ACPI, CPPC.
> 
I'd just say "this has been fixed in 6.6.y and newer but due to 
refactoring that change isn't feasible to bring back to 6.1.y"

> This means kernels v6.1 up until v6.6.51 are affected by this
> significant performance issue, and cannot be easily remediated. This
> patch simplifies the fix to a single commit.

Again no need to say "this patch".

> 
> ***********************************************************************
> 
> On 10/28/2024 4:07 PM, Mario Limonciello wrote:
>> On 10/24/2024 22:23, Yuan, Perry wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Nabil S. Alramli <dev@nalramli.com>
>>>> Sent: Friday, October 25, 2024 9:05 AM
>>>> To: stable@vger.kernel.org
>>>> Cc: nalramli@fastly.com; jdamato@fastly.com; khubert@fastly.com;
>>>> Yuan, Perry
>>>> <Perry.Yuan@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>; rafael@kernel.org; viresh.kumar@linaro.org; linux-
>>>> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Nabil S. Alramli
>>>> <dev@nalramli.com>
>>>> Subject: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost
>>>> in passive
>>>> and guided modes
>>>>
>>>> Greetings,
>>>>
>>>> This is a RFC for a maintenance patch to an issue in the amd_pstate
>>>> driver where
>>>> CPU frequency cannot be boosted in passive or guided modes. Without
>>>> this patch,
>>>> AMD machines using stable kernels are unable to get their CPU
>>>> frequency boosted,
>>>> which is a significant performance issue.
>>>>
>>>> For example, on a host that has AMD EPYC 7662 64-Core processor
>>>> without this
>>>> patch running at full CPU load:
>>>>
>>>> $ for i in $(cat
>>>> /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); \
>>>>     do ni=$(echo "scale=1; $i/1000000" | bc -l); echo "$ni GHz"; done | \
>>>>     sort | uniq -c
>>>>
>>>>       128 2.0 GHz
>>>>
>>>> And with this patch:
>>>>
>>>> $ for i in $(cat
>>>> /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); \
>>>>     do ni=$(echo "scale=1; $i/1000000" | bc -l); echo "$ni GHz"; done | \
>>>>     sort | uniq -c
>>>>
>>>>       128 3.3 GHz
>>>>
>>>> I am not sure what the correct process is for submitting patches
>>>> which affect only
>>>> stable trees but not the current code base, and do not apply to the
>>>> current tree. As
>>>> such, I am submitting this directly to stable@, but please let me
>>>> know if I should be
>>>> submitting this elsewhere.
>>>>
>>>> The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
>>>> amd-pstate: Fix initial highest_perf value"), and exists in stable
>>>> kernels up until
>>>> v6.6.51.
>>>>
>>>> In v6.6.51, a large change, commit 1ec40a175a48 ("cpufreq: amd-pstate:
>>>> Enable amd-pstate preferred core support"), was introduced which
>>>> significantly
>>>> refactored the code. This commit cannot be ported back on its own,
>>>> and would
>>>> require reviewing and cherry picking at least a few dozen of commits
>>>> in cpufreq,
>>>> amd-pstate, ACPI, CPPC.
>>>>
>>>> This means kernels v6.1 up until v6.6.51 are affected by this
>>>> significant
>>>> performance issue, and cannot be easily remediated.
>>>>
>>>> Thank you for your attention and I look forward to your response in
>>>> regards to what
>>>> the best way to proceed is for getting this important performance fix
>>>> merged.
>>>>
>>>> Best Regards,
>>>>
>>>> Nabil S. Alramli (1):
>>>>     cpufreq: amd-pstate: Enable CPU boost in passive and guided modes
>>>>
>>>>    drivers/cpufreq/amd-pstate.c | 8 ++------
>>>>    1 file changed, 2 insertions(+), 6 deletions(-)
>>>>
>>>> -- 
>>>> 2.35.1
>>>
>>> Add Mario and Gautham for any help.
>>>
>>> Perry.
>>>
>>
>> If doing a patch that is only for 6.1.y then I think that some more of
>> this information from the cover letter needs to push into the patch itself.
>>
>> But looking over the patch and considering how much we've changed this
>> in the newer kernels I think it is a sensible localized change for 6.1.y.
>>
>> As this is fixed in 6.6.51 via a more complete backport patch please
>> only tag 6.1 in your "Cc: stable@vger.kernel.org" from the patch.
>>


