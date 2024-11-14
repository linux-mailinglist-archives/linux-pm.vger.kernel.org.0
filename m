Return-Path: <linux-pm+bounces-17530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BE9C824C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 06:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3CB2834F0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 05:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336FC1E47B3;
	Thu, 14 Nov 2024 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="riMKWdRF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F01632FE;
	Thu, 14 Nov 2024 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731560781; cv=fail; b=nhDbE6vZAP4wW/wMKcJkNdN/XU6KsPkOGA8lPNwZBUgzwGL1yDnoz9+Vtp8HWtaQzf56U+GSiMEDSfO3Fzn9ixxbeym1fmkpQS9HioSMcyLBiCbk5K7xfAm3xxlnES5z1WtazuEkIURDSQZs2aTskWJAGLvW08KW4XefEx230+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731560781; c=relaxed/simple;
	bh=2FO7UpDHtL5rr0Jw1XCvyN5BJ+rQiL+EQPBy7NlW0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e0MTREyn+yGOkILaGm4nYtXmS1DzTz6gaJz1vKH7F68OCD93qRPoYzBMszH1MwLKPzjk4OqgIoFPj10dc0AtdkilXC1R40xgTu9PpfJ9PppXqKs1m4vSG3VSk7S5AGmdGo/sQj9Xh4D3hqYNB3TEIMluvqwobwvUkn8dqVgOjlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=riMKWdRF; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jcl5N23NsWoXnpy9GcPHaqMeXabdFx2WHDwMw7I8lwl1OyI+w3EtXUm8X7fXMOlSyWHAST6YCB82+no2m/zBWJyKiTP1fEy3Lq1xOUcRDfKSSj5ZV6nFbvjIgrQviUhVDyi0M0lipJJdSOsCgNlgqVQXjB5jtl6CVRLN8d/ipYjklEThX2WC+kZCrRRCaNcWoAbORuTOEjuhYD88RB9ET3KSXyOkDjAw92gqqglzma0cMea1dkqv4nDF4Wzh4kp3bgfNdU/leWocGp9fXu5wR2b2/DMFGfaLvsfnPH1g/gLhGweRDINw3vwbDU0aDaVdLIMguIns6CX3Md9KsV976Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk6xKRlWH6fFuVQ+msZOsRtffpbm5CCb+umSM7wONj0=;
 b=pvRXpm1ru0VHkBbk2RPuXW7m622qS/qXKssz7J9dzjDdD1/dT4COzyyN8CzplOYfrD3XuRHHLHensQXngiGHN9r6o/pewcRHexwC4vn3aFxp4tv3dVKsjiWqYwSM1lCH6LpYmTp6yqElwb5xGzxMbl1C9qaAtX80N0BA6fqeQu3K2dHjyEPtcKnNdJGvkVAMgVBilRTIAFlQTykiuPxm3NQOKbkj/zMq87hyUCIrXAx/VyllVqZ8wQHuE0GtnqqI9pSS2ik96EUJAfymfD10YDGtlXG9hAznCJQYUNx58WMoa+C5unUzo80+ZQMh1gxWq45DZcvAfeqK5ItcPWXnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk6xKRlWH6fFuVQ+msZOsRtffpbm5CCb+umSM7wONj0=;
 b=riMKWdRFv7eeuApSWDV6bwS9ZewEKo93s0djF3iYOmR5O2gBGLDajY684UZm+qqOTVlXP74+bP3yYbrDVliemZGR9eBJVQwdZVBypjIrbdMRb8Xo5FvWFS3K3HbDI9Q0XTuKO9ZNjOqFrUdW/ATN7t9DB/uuZvcmhv+sWplWdx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.18; Thu, 14 Nov 2024 05:06:16 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 05:06:16 +0000
Date: Thu, 14 Nov 2024 10:36:07 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <ZzWFP74YTGj5m6il@BLRRASHENOY1.amd.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <d45e316a-aabd-4d09-9006-d89bbc8fbc3c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d45e316a-aabd-4d09-9006-d89bbc8fbc3c@intel.com>
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ba886d-a236-4c7a-244d-08dd046a1174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1C9NsRgJj9Gszqw8pLN1mi9AodJltYpDhDgE6Ewl2oaJaVe5yfspFdvHFF28?=
 =?us-ascii?Q?PPltjQsqeuzANiHfB00eMTY0zCIQrUTht6QNPvhs1S+3Hs7dqmCVSj5E2uqY?=
 =?us-ascii?Q?BfInfIP/4jUoPJ6ioNba8dcz1C093vzNySu+paWi5UarEjuLISl0nLusORdq?=
 =?us-ascii?Q?Z4dvCTpBRyi4hx9FpmTU/i3R41eRnG6J/wXRErRwSbuxPxoEUJ/TJwSMI/YN?=
 =?us-ascii?Q?P4FNZKQhP/bmmlGqzVbrEOceabrO4BGjLK5Ng9hIaUMh3cvQF+/STIjqRZHX?=
 =?us-ascii?Q?OpZoUTLvXWuTl+LgVAGeldvQHvtRq3ZFWsX8sOF6IxFdA7UXS3YygIng2XAb?=
 =?us-ascii?Q?vPPIQepfmt9n9lTqSUOIqrIOZvxMpkOckVOJEJMdowjoa4iwrLhF/CkxEUOR?=
 =?us-ascii?Q?gNdNr26kXr86DHupWSs8+LxWL+K2N+B3nsPX5kwXxwo0oC3b6wBxaDpUCOcW?=
 =?us-ascii?Q?uvUqFokLf/9N5ifAjS38labIQcBXGYDwPA2tgqz3/chWHCHYxDcHi+BpQW9U?=
 =?us-ascii?Q?xylkyCJC+Ril42YCEAh3nkJBt631jjId3Hvxp1y3AxdbeGvMuJdmFMAWP1Pb?=
 =?us-ascii?Q?ulJwTwOFTrgMrhz75QW3IgqZZoZXnib4FgydcmDuv27MPyOKTt8GG/gWZw4K?=
 =?us-ascii?Q?8LLwkz5p2Iy2OoEalE0xF3TCPz8VQEHrXrl2ovNmFnlJy727EkbWTqqoYZNJ?=
 =?us-ascii?Q?UeQlc3HjAUaDggMhSwT6cLHOHlEf2U96ks3rRIW1wKC6ZAlaxG2sAz46T4rS?=
 =?us-ascii?Q?cgk6e4zk33mQFiNN5y9+Jb/ERnpNZM625mDT1J28PtwXyRT4I0Hme9vvgQ2Z?=
 =?us-ascii?Q?W6hbh3m+13dGjFHAnr4r0u302pkBFoZNRNu+bwZa8ZYT0eNO1G/2F40qW4Pg?=
 =?us-ascii?Q?PvkzYVVb0m9mofnUT7sB6vPOtXujRbMZtrOb6Ac4u9Q9BYS39UNxiTi/0WYz?=
 =?us-ascii?Q?q4FNAkw67aFaNLwj/KKkRfdUgHd0P3yXlHyUxQc1DIB51DNZQbmJaeuoapwu?=
 =?us-ascii?Q?zJLN1RDjddABnB5fwxmyyeFI2z1+E9ZNw0Qu4mL4AoMDcqHFZ+DHlFUpw8mv?=
 =?us-ascii?Q?hPC7JoPggfHzma38bEb/P0uGk9Vffeegf0GQthJMPyDas8JYTWmc87m6kaSJ?=
 =?us-ascii?Q?dTbIiNKA/8jD/hAB0sGSVNueDIv3OTd2C5RHQoKBqBo2btAs7953hnM/hR5E?=
 =?us-ascii?Q?xt0QVekuHURlFakJeSXceSWZ5T+aKZyE0UOiysLM2t/Nr9500Z4ByamJdSjv?=
 =?us-ascii?Q?U0kmYrYkDNlnKxRJurvkx2I0R/XLAu/iuJKxhY/uwz3A2G4R87XYJR4u4Fq6?=
 =?us-ascii?Q?hLs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TF0FEHZQBP6/gwnII9YQVHqEmlqRGj/mHWMb8WuIRrBeE3SLXhO02lC6C5RJ?=
 =?us-ascii?Q?x/a1xBJiAMqurUBTA8OSEKfJdvXZ7mzSmS8glDUF1DLwn0u9THnjNNZ/ZKX5?=
 =?us-ascii?Q?1JUau6vVqWe14iJQvEomzcf8gvRd7NDKX58lHcXV9mlWoSgjzECSkEVlnyjf?=
 =?us-ascii?Q?4fAMRDu6K7WC9UCZEn68uVS8NniLgsnjOWvMdpsLYQSwzxEhzzUyYzRhCx/X?=
 =?us-ascii?Q?Kz5UL3cFl3Zu3uUSpxLOW83lGLmCHjs1l8FCqnOpUiDwacnqj7xj3XX6RerZ?=
 =?us-ascii?Q?2PFHkT/HWXq73vlL2OVyMPpfHLOhMgTb6yMlHwaxZmDx4d2q+ysfu0wsolUi?=
 =?us-ascii?Q?5Au6pnrDlJKAP9wu9akhUA4q0Uy50YYsFrpDiBK7BrY+2VpL4lFirQiqre0q?=
 =?us-ascii?Q?APARyc62UYMeJY6dnmFucN7yPrKZ7W1aO4bEHX+LqSXZfMLALH/nazw3gl40?=
 =?us-ascii?Q?TAjVt13vOFgXTdaNjFzzl7cZ2jwcBnJXE/F8nl7z+//TYJ5my6CtkJgE2suD?=
 =?us-ascii?Q?fqCS2gren05ISLdXG+M5tl7EuWzG/AuaIj1CE6qRAaarRNmTqkVD5zaPNarL?=
 =?us-ascii?Q?iT98SP42YOFLkkRikEeRgUz4yGD1xEqQYYwMw/j8eyRxXvPRDgU1iklN+gNG?=
 =?us-ascii?Q?dyDxCPX4RrMO52cUR1Is13P/z3tr2SVuY4lxJiFw5yyOY6Pxzs7V/8czCqsj?=
 =?us-ascii?Q?pFyt8JTbQY6Lh+6GCKGu6CjiNgayAViZ0rBYWjaLfdig5BKYoyNFohOxGHqw?=
 =?us-ascii?Q?d6ksclp5r7HVZSmDHHMx4/2g5KZcAs6UwCxoGZG8mrMoAQ6HEw68Orsi+Jkm?=
 =?us-ascii?Q?Ik1TfPHGAXn6KEruHYYGy8INaI9PGZ/mbAd4lc6UZ+s7ojiNy99JxBmSCzTm?=
 =?us-ascii?Q?MYHcfQAq18J3FMu9lynH8DTNWUOUYr+IYD9ZUxIuZzCBiRi0aty4NBALBy96?=
 =?us-ascii?Q?8lNmg4us5hf3q+3qpJO1dZpKRPleqDXnIMUaxf8p4QIZ+UYTsR1x6IAdU7Kk?=
 =?us-ascii?Q?YFaGIR59JxPdhMAZTpwfsY+G5/moUbtCJg8oEAHBTwd+NkSF0Mqm6KEoQpWX?=
 =?us-ascii?Q?eGOPiSYjJcP1C5GX+8mbEuqgvCxGYvBSAM9beUldbGZhoe6Zk8Jw32HXU17X?=
 =?us-ascii?Q?p9Q7iCnmkBv+v8Ijp9C5uKL8sPVBI3npT4egjnsnGlaeTBJUuhZcPjvAH2bO?=
 =?us-ascii?Q?xwYQfn6whA7n2lpJYTLmxi3h1zb+8rpc3xSQkvpM1IeTocCWBJ3kb0IDbRVs?=
 =?us-ascii?Q?ntnM0iebeHKpWuchDQJ0peE1vLTbgRsCtFwR61WXVw66F738vbI6gwaVCXmK?=
 =?us-ascii?Q?L0m/ddCY2at7R6EShrEwDPsZFBZ74OaIcJGdfcqKRBMw9R83gyqY+oJO7Fim?=
 =?us-ascii?Q?3rIZADSl8zYvVqvrO2KYR79hXnjmGxe6nVPyUuREp2/XcqL59//uIW+UtH8R?=
 =?us-ascii?Q?cVF4QPgargPO2bOYk/S+vlg0KT9dcoMnrmBi0vYjKwH47GHfobpBt8olqKFx?=
 =?us-ascii?Q?AyQNUYCFDgmtjqcgfEUq6rNEIP9l62oLzK2aEfckyOmHSdBkyJqsND7qRbnc?=
 =?us-ascii?Q?J0znciuG22cZ338waoYTuwz6uveth37rE8h+8X11?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ba886d-a236-4c7a-244d-08dd046a1174
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 05:06:16.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5g+oidGaX8UCjWsdABK0k/HHrZAjie+JS4zjexz4aplRrV8zdgBZMWMlHLOgOfoutACdoymaZz2knOrItkXsAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

Hello Dave,
On Wed, Nov 13, 2024 at 08:14:08AM -0800, Dave Hansen wrote:
> On 11/13/24 03:41, Gautham R. Shenoy wrote:
> > +       /*
> > +        * This is ugly. But AMD processors don't prefer MWAIT based
> > +        * C-states when processors are offlined.
> > +        */
> > +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> > +           boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> > +               return -ENODEV;
> 
> Can we get an X86_FEATURE for this, please?  Either a positive one:
> 
> 	X86_FEATURE_MWAIT_OK_FOR_OFFLINE
> 
> or a negative one:
> 
> 	X86_FEATURE_MWAIT_BUSTED_FOR_OFFLINE
>

Sure. That makes sense.

> ... with better names.
> 
> Or even a helper.  Because if you add this AMD||HYGON check, it'll be at
> _least_ the second one of these for the same logical reason.

Fair enough. Will add that.

--
Thanks and Regards
gautham.

