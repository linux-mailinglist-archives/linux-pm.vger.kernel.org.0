Return-Path: <linux-pm+bounces-26896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12684AAFB95
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 15:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB66B3BEA4B
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997084D13;
	Thu,  8 May 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pfu6602l"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAFD4B1E6D;
	Thu,  8 May 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711512; cv=fail; b=mHiPRFbG8PpvEFSVVM3efphy+VDEm3IizalAB5khPekWgmqFUH7VIYst0p27wPsDaO6OdVzVt9T61YVmjubOaKtw4p890TkkCWiah3IzjaUI+ZKwE1FD/f8TjNNBNQK9uHzkH7F7HizMRPPSuI23sataXlyLgCzLvzsLMIfE7Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711512; c=relaxed/simple;
	bh=4NcNOKh95NkjR8RaU+5LiKG4+eLYrrEUa1QPjg1Pa2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rpnS1/QbtZuzFPNWZyU1xJdp/I8MTbKM6LOYZKjP+YrQc8tDdv0cKIFhkz+cnbWMkeFWnyd4zMZ3UVR7/Til24qmCXUaYeKIXYzoszWDXzHM602iAF0fh5qRY+N2xrmhON/PaRoLSjE/RoUB6hSr7+JSQJgVgQZXBSvEz1K4TII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pfu6602l; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ/oL27nfrg3q9rHv5mF2LVLRyjUte4cbPpCpW0waBxCA+0cMN7IOvDNC7PfXYX3glZDX2o880wwSTlZUtRk2YQKm25JF2kKArEuUgKohIhGinR7rUz/nITDdE0EJJbOPTWUIDf8S33vByejlp8AccBuc31tVzWL4jk/KWhTCXbaV7362aNGgxsl50YlmBRgj++fKCnrYHdC9upnzLplJ8A9NDA8sKI4TVlCX7uHMy7Ged66Va2xM6TRDHt12i4WW9YhAloGBPhL7J++hvRg4BttHrqnIdZlYtkIOjSu6q6Ox0IK7VVmXRuxgWfdO191g0nK7l5kIY41DzmIv2Ejjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31UWiOayMA60xzuFOAs1UoZJYx3bFzyP4p8MWa6yPIk=;
 b=myYFnnV8lR6xR+tdLXR6ZVPGnHJRwnUcLiC8rtkisr7MQxkDaaV32zyYPL/2QhxaBZpgaB/hg/2xtJXcnJ4tNAC2q/RyhGVWfSlUKpbuR8D7iBBGPym+EbBtJo74V6samSzRuNjsKFK+XZBctJDQQ69IHjoqTGAgCVE9YTHrnxJjE1FbT94b3O3xFzo/yoSxSk0HAiEc9tIA5tBwkk9GYJJZkntu1gtibDGXBfZy6w4s4JdYRKJtCJNY5Ye4Jp929Kira6EK0ZUAGRbR6gsjCsxX5MEPa5BahwGYnGeHnjqRdNXSbSJap3NdPWIJiIwY1JBW4zHKmr40Z2mhWPHumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31UWiOayMA60xzuFOAs1UoZJYx3bFzyP4p8MWa6yPIk=;
 b=pfu6602lxDldy23oqT/qBmXBEAPlBS+6zDJ9AKZIJO9E5q3X4bSbWn0+vKM3c1wbjcGDCqAuQRzSH0r7Nu9YGg1aZ1knPfleV40eI7tSI0Dc6XykkpD3+qaeu97aC57f80g5yJencDvBMwmytsXam+jouuFx+D/QgAWNjVXq2fZWAiK5BllZvQ+y8bwe8NVFFyygPi7mmq+nPFaOeaffDXQ/LPDaOtHRWJSFmSEkXc8FOq5/mjc1XqilalhOCMHPUtwWj4nI4UA9HYC+39hi+r/+ONhXfAJjKa8eMAniM9FvBvs52Ps8d3relqqzic/AImVj5tQMTHU79Vvq9I7f1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 13:38:23 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 13:38:23 +0000
Message-ID: <0f7a3738-0b94-4361-a277-c3a90d87aebc@nvidia.com>
Date: Thu, 8 May 2025 14:38:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com>
 <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
 <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com>
 <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
 <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com>
 <563657c5-5529-45fd-96fa-bab68ca992a9@nvidia.com>
 <CAJZ5v0jVOG_u=F36aOVh=qu4Ef-5QFAmC+5-fmF_mU8NSr_LnA@mail.gmail.com>
 <b17469ee-0d8c-49ff-8fc8-a3c3cc9964dd@nvidia.com>
 <CAJZ5v0gMHU71drwOYatFhUcDFKXb9=vTo=JFFYfDabYBdrqWLg@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0gMHU71drwOYatFhUcDFKXb9=vTo=JFFYfDabYBdrqWLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ea6046-f1a8-4140-1139-08dd8e359a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1NWVDJKVkhWVlBiQ3V1eVVaL3pXQURFWlVQd3UwaEVSTnZobzYxQkNkeTQ3?=
 =?utf-8?B?Z2J2YzRibXVNV1BwYTBRS3hWOHhpVS9sMXNJSmcrOWxOT3AreU1Jd2dRNkky?=
 =?utf-8?B?Ym1weUhNNVlYQVkyN2FyeVUzeEY1Q3hpUWsxdGQvdjdTWGJ5V29IZDRWQjYv?=
 =?utf-8?B?SHFJVWpqc0pBZDNUQVFOdlNhSGRoK2E2SnhabkhuRnpyS2VVL0FtcC91QWh5?=
 =?utf-8?B?UHZGeDZzbUpIRmdzUk9ZWVpUMlk0eGhtQzBiSTF5a3h3TE5xbU1SZW8rcGxB?=
 =?utf-8?B?T2ZINkNGa0NFNWoxK0w4ektiRTQrR3RDbnJneGVmVk4yNzUvS0VYRmJzN2g2?=
 =?utf-8?B?S2swUW1nNnlQNUVWUVZyOGlSSDYrVmNoVTJ0UDh2dmpkMitCU3R3MXh4UXNW?=
 =?utf-8?B?TUZMemZJNDUxTDA4QVdvU3NXbHZCRy9yM3ZCbVhaN0hiNGpXc29RSS9xU1RY?=
 =?utf-8?B?Q3Nhdmp3UFZka3RxeFVza0FFYmpKT0VSZ3hRUXhrVWF4QlVOWkovWGlQU2o3?=
 =?utf-8?B?TERVWGJVbmxhZHBXbTVQTUtwWFVuK3UzTEZ5RjRraitocFFWcUl3aUcwYWlr?=
 =?utf-8?B?YTJST3Q0ZEVaQkFmNzR0U2ZIWDl2ZDMrZ25CbjJ6SXhjWkNxdmRoY3hZQ3Z3?=
 =?utf-8?B?Umo3MDNhaDhWZTRYWDhGVlRxenFxLzhQWUtIVlNtUU1vSFNxR3dmVWd5MllW?=
 =?utf-8?B?WmVuQkVqd3pJVldaOEdqeW1uejVpM3ZyUFJTcVl1NnRBM2ZzYUpIZzZMMjZX?=
 =?utf-8?B?bzlWRGdDUjJFZjk2ek04SlVLdlRlMjNjNTNEWTZhTWJsVTYvVi8zdXhqTGRm?=
 =?utf-8?B?Q0xjRmlTV3BxV25ZN2YrRUtGRHJaSjR4aWJMY2ZFZ2NhRXhaSG5BbndhR28r?=
 =?utf-8?B?ZE9QRWsrM21rdkxYNTN6ZlR6N3Vaak9QYmxaQVZjMm5DUCtDdHEydE5KaVkw?=
 =?utf-8?B?STYxaGtnOTdOR1ZxUFE4NEhhM25TK3NUajhCSXVkc0VKKzlzODlIOXFDTll5?=
 =?utf-8?B?T2dEamJtOU9ZV3JEUlphaUFDcVp4SExaaXlKb0h0eWpxbDVLaDEyeEY4SWU2?=
 =?utf-8?B?Vy9Bc200eER4UHoxZk5peTd1NlFFMG9uWUxHQVdIL0tkZENCZ0ZZSDAzMlQ2?=
 =?utf-8?B?cEtMNWlPZTBSOTN3ci85TFErVG54b2NHVzJrTWc4Sk5WVUZYNTBkZHErTmQw?=
 =?utf-8?B?M3RiRHJTZ0l0eC9kS2o3R3ZGZEtMaGQvNFNxaWh0WFZmWlc5VXhQbWgweXQy?=
 =?utf-8?B?b3BOcE9UalhKS1dYZllvWC9PaTdNNlVNNkwwMk1sRWhUWWR3VnJ4V3ZRazBX?=
 =?utf-8?B?OHVJUjFvQi9TdVc4MzBPbDVNZVJMVURMSitCTkZxY3JFcVhKQ3d5dDFHT2t5?=
 =?utf-8?B?UTlkUTVDUzZoR2RxMU9vTHRLVjF1TUlvQUJBaGhpSUdEVTFWSFpRT1NBbm0v?=
 =?utf-8?B?T0YrMm9LeFRQcUpkV092YVF4dWc5VGx1UmRUTzJVeUpqZnFKbmxpdFN6V0ZE?=
 =?utf-8?B?YnQ3VmY3ZkE4Y29VR01iaVNuNnd2KzR4eVJHV3RKbngvN2k5aEorSUpLVDBR?=
 =?utf-8?B?ajdjc3NNZkJudEo2OGlKYy8vZUN0emFMYTJBd2FLU1grMU1kT1U3eW5xSHBq?=
 =?utf-8?B?ZmVJelNHb0d3SGRTeWV6U1RLMWV1Q2srWUlrWlV3eE5XVHZrNXgxTFM1d2ZV?=
 =?utf-8?B?cFpqenBpOHg3VUdzczhzWEprTHNYaWZDbGovcEVaVk1PUVpSSmROYk4vdHJw?=
 =?utf-8?B?TU9NTmJjUTRzc0FicFR5aVNvTHFTL3pKQ3NKNFZLMksvRi9yTGtldHVSb05R?=
 =?utf-8?B?eXNZTG52S2lWaWs4aFJXVXFVeTJSM0FVTHRYS0lRdWVYZGRXZ0RTVFdUVFpN?=
 =?utf-8?B?T0JRMmNQRmdJeVVEKzVXeXpVcWVhT3Fxek1uaVgrV1lCSE9hbVZzM0JJKzBU?=
 =?utf-8?Q?tk34TIgGL9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S01JNGZEd2VLYXRjblh4Ukp3WTN2VHg5bWo2WmkyMGZpY2FkTFBJS1Z1K1VY?=
 =?utf-8?B?ZFk0dHNUa0JKWHNhMnZKZ2hFRjFvY3ZvL2thZ3VSbkpXZWFoZVN5VlJMNlRM?=
 =?utf-8?B?Q0MxWUR5RnZEeUhsK2pOa1dnNWY3RDFLeXBDTE5WSmhBY1ZCWnIwZVRaTDNU?=
 =?utf-8?B?N202NDhyaW93ZFgrMmF0d29JcFdnNTM1MWRnc05QdmR0NFQyZU5PV2hqTGdI?=
 =?utf-8?B?ZnVkdDFOYXZsUTEyalp1OExNTi9RZzBrU05YQ2VTa0JtKzBNY0trVVJEbVhu?=
 =?utf-8?B?cC8vdUpYYS9mcjFYclhBTG4vbFhKckdUdDNtRGM2aEVGK2QrNmJ6dUFMSkIr?=
 =?utf-8?B?b2dHdTF3eUMxODJrdVFmZm8xeXdXSGtUOTFacDFzVEoxOGozY3ZxWUIyTXFt?=
 =?utf-8?B?WDlCbTgxM3I5bGZueUtSVHJzb3lpSll0akVMcm1icC8wTnR5MHVSWndMVEwv?=
 =?utf-8?B?MjBrOFlreVVxVFdVNlVGU2lMZkQ5MVVwdmt6MEhkT2lyTjJNOTFHOXRLcTdV?=
 =?utf-8?B?YWV3N1ErNkYrOWJaSHZPNWZnOGtIamNOVlkzMU9rcmNHeGpEd25ISFpJSEFs?=
 =?utf-8?B?NU1naUJndjJhODVVdnc1MHpJT3pPcFpIVzREL2NLRHMxWkI1K3JKL1pEd0xp?=
 =?utf-8?B?MEVqQmFnUjFaVnVKUXFVZUU4ZFFxZXJHSDliOGROcStmMEt6RHhoTkV6aktX?=
 =?utf-8?B?a0UxUk81eUFVeDRkV29KMlNEWGFZWm9YWGY5djRhVFNPUU8vQVAvdEZhK3hW?=
 =?utf-8?B?VW1kRUE0NytQdUszRThudzRPM1Zpd1lMSVhqdTJmRSsyaXNRUzdFck43NG5v?=
 =?utf-8?B?YmJBY08yWjZQWFZiS0p4VEhtYklRN1FXY2FMOGdnQnV2OXVPSG0xd0JDeFFu?=
 =?utf-8?B?MUJxVWFFTGdiOXR3NmJLOE0yREIzblF6Sk5xYU5uYmJWcTd3emhlZHVhVEcr?=
 =?utf-8?B?b0JvN0tCcXNnLzZpNDJtZ1I0VCt1OEJBYWlYQWhsVUpkVUlOa0RPcHkwbzBs?=
 =?utf-8?B?NUxpckNrbklFazZ3VmQ0WWtSRmJDNFRWbk1LNW1UQ0l0NHEyM0tkQnQ3ZHhF?=
 =?utf-8?B?ZFZXWk9wOTAzUytvL2dHQ0IrQlhsQmZxVGhuZElRcnpJVG0vd1pZTjNtWGJ0?=
 =?utf-8?B?em8yWUgvcVUwQWRXNk9Da3ZZQzgzZDg3QjdqQ2JJT0grelVvVDVBNFp5R0x2?=
 =?utf-8?B?RHdJazhXRmtHRGpZYUQveFUvTVlaSElIWFBBaUVlQUJPOWN3YmJqZ0FDSjdp?=
 =?utf-8?B?ZjlYQjdsM3FSN1IrajFVRWt6NEszMEhsdWh3dzBxaUc4ZlBUNHFiNWFMSFhy?=
 =?utf-8?B?bmZDZW04dXV4dFlkd3lTM0pFZVJ1cHNEUW5rNTJpZlRMdHhKeEM2NG5IYVFs?=
 =?utf-8?B?RGkyeGNZWTZreFpwY0J4bUdhNVFib1EwNUF3NFIzRGZmODBsMmloZDVNeUVx?=
 =?utf-8?B?QUVMUGFydjZvTHVnbFEwelROMGhWWGJQMUdJcXM4anZKajBlb0hsblllUUxF?=
 =?utf-8?B?MnpJVGtGWHl2V3BpWGpMU1R3VkRCT0lwTkUwNS81TDArSWF6aUo0M3V4Tm9i?=
 =?utf-8?B?MlF1MVB3Z0hYd2RtZkRYZUhVdDB2bWJ0Nkg0M2dyZlFvQTZIQlJYcm05bEhV?=
 =?utf-8?B?dVpTUEU1Nm5WdzU2T09jMG9GWkNzNmVVTVA5Z1NHSHk3Q3k2azFid2VDZVJN?=
 =?utf-8?B?b2c1QmFiR0FBY3ozekxINnd1Q1ZQSXYrR3pPdVZ0ZlFOR0FNSTA3aWRiU1Rp?=
 =?utf-8?B?d08raEZ0TlViVlJlVWZOakhOU1JCRmcxZjFLUExkZ0YvOXVTRE52MmFtTTlq?=
 =?utf-8?B?aDRlZHlWNy9Ea3RjdkNFcFFsMnk0VTBXbjlzQy9DL3ZuSE1sU1owNXExMWx6?=
 =?utf-8?B?RkRHbjlTeWtKWHliYkY5Z1UrVXFURkdOazBxekZUWTdPZzA5V01EY3oxYmRW?=
 =?utf-8?B?NVdQODJnRUN6ZXNrVURMOUc1RlIyMlg5TzRqNUtrNm4zTlgvckhPSjFOVUpP?=
 =?utf-8?B?dlFkNEw3RmNOZUJYWUo4OU5hV1p1SFNVcEw0NHJZa3RPM0hNYnU3Rk9ZWVgx?=
 =?utf-8?B?UWNoS3lmbndnLzBYdGRXTjBoajJIWG5Nei9tT1dPNHJaZFZqckNRV0xuRzgr?=
 =?utf-8?B?L09zeVZFRWZLSW41UURpeTJTSjAwT3NKT25vRk5lbUMveWtRMW1JT1Rpd04y?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ea6046-f1a8-4140-1139-08dd8e359a92
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:38:23.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dv1weg06zHzhnRDbvX08zbQtocaqs0IApYiE9/E5ze5vDWRzAxqmHKj8utVPetnLkbgyd7oxRhNy8D1rZMRg9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564


On 07/05/2025 17:43, Rafael J. Wysocki wrote:

...

>> Setting all these to 'disabled' fixes the problem. However, also just
>> setting the 'cypd4226' device to 'sync' fixes the problem (the ina3221
>> devices seem to be fine being async). The 'cypd4226' device is
>> interesting, because this one is a USB Type-C controller and there is a
>> circular dependency between the Type-C and USB PHY (see
>> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts).
> 
> Circular dependencies are problematic for suspend/resume in general.
> I wonder if fw_devlink can resolve this?

I booted with fw_devlink=on, but this did not resolve the problem :-(

>> If I make the following change then this does fix it ...
>>
>> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c
>> b/drivers/usb/typec/ucsi/ucsi_ccg.c
>> index f01e4ef6619d..e9a9df1431af 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
>> @@ -1483,6 +1483,8 @@ static int ucsi_ccg_probe(struct i2c_client *client)
>>
>>           i2c_set_clientdata(client, uc);
>>
>> +       device_disable_async_suspend(uc->dev);
>> +
>>           pm_runtime_set_active(uc->dev);
>>           pm_runtime_enable(uc->dev);
>>           pm_runtime_use_autosuspend(uc->dev);
>>
>> Is this the right fix for this?
> 
> At least as a stop-gap, yes.
> 
> In order to enable async suspend for a device, one needs to at least
> assume with sufficiently high confidence that it will be safe to
> reorder it with respect to any other device in the system except for
> the devices having known dependencies on the device in question.
> Those known dependencies either are parent-child connections or they
> need to be represented by device links.
> 
> In this particular case, it is painfully clear that the suspend of the
> device in question cannot be reordered with respect to at least one
> other device where the dependency is not known in the above sense.
> 
> Thus the device in question should not be allowed to suspend asynchronously.
> 
> Would it be better to represent the dependency in question via a
> device link?  Yes, it would, but until that happens, disabling async
> suspend is the right thing to do IMV.

OK so it is not clear to me if the PM core should be handling this for 
us. Is that what you are implying/suggesting?

Thanks
Jon

-- 
nvpublic


