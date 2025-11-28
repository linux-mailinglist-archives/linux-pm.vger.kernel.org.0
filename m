Return-Path: <linux-pm+bounces-38849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B7C90974
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17843A1CB4
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE912512FF;
	Fri, 28 Nov 2025 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjtuBgZN"
X-Original-To: linux-pm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C91D9346;
	Fri, 28 Nov 2025 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295914; cv=fail; b=r2X6ZC6N0QcAFZ+lLir3x/OYoKdizlkp01zYZoEGAC5Zt76GxTgSU+FRWZ8Rt7KFv80bCICnMjDZM+tQjQYyIkD5yUrfc1lJMIj0nfRupJCQ5KuIt+GiTlx4Vw/BYAtm+o4L7fq4xKqdu2e5hb2KSz4v/hbgfbtKg7yl/9WUM24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295914; c=relaxed/simple;
	bh=BVkGqkXeVqazzyZ7eapdbzieaaya6FAPSzxuolcufQE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ICrh6nnuD68dMbNRteQYUhow1sVt62jn+Z4phgFSIo36Lu8g1kRlfYpL0YXB+Bx6DHO2Y8osbxhN6xjGfo+uOaLvbh/Ebo5fWHWJHgC/RAg7WPNpgrWX2oqHsuC82rwDZzlKf/Dy8UD893+QL5SxP2712Zvw2HGwbPi3sYwqHZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjtuBgZN; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8buwYKflFwGtP/0GGhrDgdOiwDKfyoUXRUH4NBfn7ObOTY/v1QjhqDM3Mk+y90jKOw8PE9JZD6KsVQSBgRmdM6fTAW6lUFPVCw9buioShm4vQ5dp1cqUayVjAXVRELv3Fgry0qn5hNr7WitY0TWEP5DZU4IAJWFiAydlpdPlUlUT0wsfUhZMcd3QPJUGYOreY7CQFZyzsw/S+AFURz7EzENh7RyR6n4Nf3FjAqiRyKuhcn/UAqCUdq86wqfRfbzL7vyRtntcoO9XsYJgYdnQPh6jUkmr736050prUcZ8FRZVIbxUTYYaML0t7lecFt4QurO+MKmmTunEbkaru9F7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpeTBY0T2vEsWJN/UwXjS6DvqOEghU4Yp8mXm6+QPiU=;
 b=pMnF4T50wfvcSC+won5XylOlCQwkXsg/Kacxy/vBj766znEVA1v6WxYZ6aU8hDIpsSUuDZvYfB4DQdFqP/5Qk/62w4C2sxLc3zmLfIpLr9HahQLYB7gntZHiydERPlicnVhI9NEUT0KeNp2e2aIXP+lnLa9flxD8c/tM4Z1vx7Y21SoFnGdNzpu10shrkn1ODn+sHAH4Gl5qLFW90NKmCuTKJaDUv346rc+AMBf/ZgDVokmJhs6xoiO58iDLrLBC4XWGluHSqRgT74hEo8y0lrXr5O5/m6hy1CfEZWzboGiVpMoUdkmj1LLqi8aMzvtP+FZLmbsHH0RgK6eWXo6jfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpeTBY0T2vEsWJN/UwXjS6DvqOEghU4Yp8mXm6+QPiU=;
 b=RjtuBgZNuu+b0cas5tCtA5siL/fRJZ9KAIC9GPhINsoMOrWi7JhyTISOdHFh9JU2Lx+2P5fTGk6taGuzOeU0eyjxBFDJXEQCMJ0ABqxpNbqY4V22+ZMXQ6JGCpWyuHXs9tVZNP/52DgLcmLKDu5onn6MqLKTGtO0VdR/I6or779XCQH/4oxWZL4SM6wcUr1FR3u4wVQrMtdkzPVac3jaPNABOSCTu5uVu4nMDpYwxOiGCmY03Z5PEHELfvBvq5JRE1KhORi74aTx0faCSTQoVyy0nU25NLt13OIsvGbylyUb8zMy1K3YfLr/rP3QOETGdXAsBZ+6TIUa9DGiRr92pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:11:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:11:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/7] rust: build_assert: document and fix use with
 function arguments
Date: Fri, 28 Nov 2025 11:11:36 +0900
Message-Id: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgEKWkC/3WNywrCMBBFf6XM2pEkNaS68j+kizztgDYlqUEp+
 Xdj9y7PhXPuBtkn8hku3QbJF8oU5wbi0IGd9Hz3SK4xCCYk50IhRTQvejjUuakr9lKdtTTBDNx
 Cs5bkA7334m1sPFFeY/rsB4X/1v+twpEjO4leBeHlINl1LuRIH218wlhr/QLyG/y3rwAAAA==
X-Change-ID: 20251127-io-build-assert-3579a5bfb81c
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0194.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4854c208-4500-486a-6877-08de2e237d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk9zemRGQUU0dlZVeXRZb003Uyt0Q2dLOUtxNWN3YitGZEpDdVpwN1NPc0dJ?=
 =?utf-8?B?L3poZCt1Z2lJTVp4bGNhdU0xSkd3N1JXK0c4RkxzaWtEZzhhWDJjS3ZpNm01?=
 =?utf-8?B?M3JtZXp5aVpLNnlaUy9VZ2YxU1B2MjJpOUFmbTh2eDFuOTNKbWtkTlEyK2ww?=
 =?utf-8?B?aTdvenQyOEFoUXc1R2xySzVoYmlKUDNuYlZ4R0dka2FUVDRMMmZEZC90WHB2?=
 =?utf-8?B?b3UxZW1ucjRTS05ORFlCazF4cGRTQW1Pck9PZkxBZlluV0M2cGhsd0QvRU9s?=
 =?utf-8?B?WnlZU0FRODBQNkZlUktsUEJOVi8zZUFCK09lL3I3enlKVmtrUGVHUWdqMUwr?=
 =?utf-8?B?akU1Qmw1N0JZWWFrRk4zMTFEV3F5b1U1eDFuVFhTRThoQWVuSnZuNWFib3lX?=
 =?utf-8?B?SmJ0UitLZ1djYStsTDJab1M3b3U2NjVsUGVRR1dHSnhpcDljNVRKQWcxQ0VP?=
 =?utf-8?B?UG9WL3NEM0YwQmZ4WmFjTUFFQkkyVE93Q0o1Z3pYOHdPOHBNNVFQYnhLeUlW?=
 =?utf-8?B?R1Bxb3lCS2tRcWVkRmM5V291eDFaYy9TUXVCOGVoUFhxWUtlSkpkbWxBL0hE?=
 =?utf-8?B?L0hDWlFOMnhoU0FWa28zZ205bU5keTM0WlUxNWl2bm5HbFg4U1BMM2w4aGs5?=
 =?utf-8?B?bEpJRXRRODZCalp6SXhUTzQzcFZuN0NQMHFwKzBFQk12d29paGRpN0JJVG8z?=
 =?utf-8?B?TWdpR3ZjbWJ5ZDRZbXRZZzNmNE1FWU96YlZFUlZnYXprVUM4MXBJaERQWGYv?=
 =?utf-8?B?NHkzdFQvc2dpa2ZQNHhlSzZoY2VCSVRjd1RLY0xlMGZKSVlqUWtHdFNiMVRk?=
 =?utf-8?B?K25UdURMZ01maFY3K1hGL3k2UVlZNlMzRlQ0eW9iSFJraE13R1ZUdnNZNkkr?=
 =?utf-8?B?YThoanRmTmw5Ull4aHdzRUxaZVVBK0JxYmR2T2hCSGFRaFZ2QXg2L1JlaEoy?=
 =?utf-8?B?OW5zVjVTWGtKYTRXeGNzYXkrY2tabTV3REZEaXZZLysza2o0ZFhTQUhkbE16?=
 =?utf-8?B?SnkydlB1amdROE0vR0hndUR5Si8rUU9aNmd5UXk3UitlLzVMTUdMbzBMeVpz?=
 =?utf-8?B?M0dYNG1FSUM5b0p6Mmh3SmVUZk5wNnFMU3lTcUpRdytkOXQrbGxMUEFwZENN?=
 =?utf-8?B?MmRtcWRJNU5DR0YzSkg4bGZUQXRTRVRTcEFVL2ZkdFl0eE0yMDhYaFA5MHFD?=
 =?utf-8?B?SnEzcDdjNFFCQ21ad1NhVU9LdDM2MmRyNjlzSXJsU05XU0hLNkNyTUlkSk1I?=
 =?utf-8?B?bVpnL214WTFjcVp6VThyOUdRNkhmdzF3bnhYMHRkc3JGUzVlZTAzV3ZWMXdW?=
 =?utf-8?B?QWVpY3RtcGZSK0tKTVFQempEVGE0WTA4bWMvNnZya2pkTWh5cmp5bDNYM0s0?=
 =?utf-8?B?MWxiYm9iZkVkTzkwbGhEcmdleGxMcDd1WDZ0U3hzdFc1UWxoN2ZkcmFJWlN6?=
 =?utf-8?B?QzJycnBUQTU1aWN0V0F0V2dtWnVKS1FPRGJ4ZzFCL0trR1dEWGxGcVhEdjVt?=
 =?utf-8?B?aEhDazNGZytGNHc0cm53RkNPN1VETTcrT2laNmVPNS9QcHVvNFFyMGVoU1Fh?=
 =?utf-8?B?VEN5R1c4SWJLUkdDZ1hmemN5Um1sNWNGS2t6bHJXRFZyMkx6VHIyN0c1RWJh?=
 =?utf-8?B?UFY1bmpSakJiTmY4UnhTQ29ONkFLZVVVRkRyU1p1NVdidGtqRkswNmhRUlZW?=
 =?utf-8?B?RjQrckxiYzYzeDE1bEFwSTUzdm9yRExJaHdhMm92V1B0MjJlbis5N0ZRQjRI?=
 =?utf-8?B?TjhDd0txS0RjV1QxbzNPN3ZuTE9BdS9ZZGVpZDBlVkt4eXFxNG9WMk5iN08x?=
 =?utf-8?B?NjdMczJzMENjMEVsLzZQWFJlM0VwSGZXNjF3cStZdi9qazJ1V2hUbnNUMUNs?=
 =?utf-8?B?d0YzdVZYZS9NaWlTQU5VTnFZZmxWSERYeitWcng1Z0dQWC9JV1lZdVBzUlFC?=
 =?utf-8?B?UEJIMTMwYloxcldwT0JLT2psdWxyTHJpZGtmU2pkTmpNUWYyckJ0K0xscU5l?=
 =?utf-8?B?R2tuNTR0MXphQ1FGRXBMZWgrYkVPUGFjbXFrS1lma1BjTkE1OUxwTHV0Y0NR?=
 =?utf-8?Q?+scbSQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEliWTFtSkJBdHI5THpWNGhoWlI0VFhYNDhXTU8wMm8yWmFreHB5NG5xOC9j?=
 =?utf-8?B?WlRpajdWTndJL3kyeUUvVGNLYm92S0pDOUJyYStOKzlwSDBOSjlkZWp5SExE?=
 =?utf-8?B?Njl1SGt5ODhTd0dMY29WYXZnKytMRnNOSitGdWl4TTJyb2I0SzFESkkxZnFE?=
 =?utf-8?B?UGYvQ0U3N25EZXNLVXplTWhzTDFSUUpsRHJjWUpraGQyMUsrT2w3MDBrWDN4?=
 =?utf-8?B?cENpQ0VUeVpXdmZZb0ZtZ0JnSW5RRTNWdWxRSkVxOTlyZVlvQTFwenF5WE1U?=
 =?utf-8?B?UElIamJ6SHpEeGdpWGR1SXNhQWJJY2JvYzl5RFhFUGMvcHRvMzRub1cwak04?=
 =?utf-8?B?ZVppSTZKTUduUStnVXNGdy8vU0t3QUh0Rkc2SHQzREF1aHp3Ukg3clA4cy9y?=
 =?utf-8?B?dlNhSHZVTnlsZ3VualFkL1lpS3o1Z3RYdU5YZmdtVGZUK2pVMkNtQjlDUnJM?=
 =?utf-8?B?eEI4NkdYclhjVTFVU3cxZUY5cWdrb2kwZ1Yvd3VPM2M0RjVaVmNrblBaeURt?=
 =?utf-8?B?bWpzVmhvSnQ1YW9ZR1I1R3R6TEcrTUZpdXgrbkR4K0tEdVgrK0FiYlNQUVcy?=
 =?utf-8?B?WjVmS29rSGVuM20xQWRPT2VBbXR3OHFWMEQzSlhNTkQwaG9YYllQYzhwSC9n?=
 =?utf-8?B?S1hlbSt1YmNBWW01c09wc2hoTjFzaTg3Ri92T2lja1NQaFpZSUQ5STM3RXcx?=
 =?utf-8?B?ZVNoNy9DM2tWTDlPTmFEb2VGWXVmZHFKQzAyWHpYd3M2ZUJST3RCZjBQaHdN?=
 =?utf-8?B?YmlkYU96RDZTU1BiUVhReVBxcnVPdnJDaFZpcS9NUEw0SkJlU0xyY1BzUTNI?=
 =?utf-8?B?bnlhaG9zblBUVEdRekVlOEozNFd4OVJURy9TQkkzbjNJaUttcWJqbE5qZW9K?=
 =?utf-8?B?ak53UlBBUTdlOHRNME1PbGU4VDA2K0NUSFJsTkUrUG00Y1dNQ01wWGU3eGNO?=
 =?utf-8?B?aU9PN1VYUzNpUDlvQlNSOTgzRk8zdnMwdlRYaGVwRUVrN2RpL1NZS2NsaVVv?=
 =?utf-8?B?MVh2RkE4TFgxdS9ZUEJvKzhtbDZKdER0VnJuazdCbWxGR2FRd3VNR1RKc2Fw?=
 =?utf-8?B?cCtZMkVZdDMyZ0NIc1pIaGxUUk5CMncwM3RoaTVRTUV0RGwxejd3QUtqaG1Y?=
 =?utf-8?B?dlZWSW5HK2hrSjdDYTdFb2ZzN3FTUzdlOTNXa1U5bTZFVkdkL25QcFhDWkwr?=
 =?utf-8?B?eGU5NmFzdEJMZTBFNW5Sd3ZkTzEvNUZmTURRRVRGUHhTSWdLN3didzBtMjJI?=
 =?utf-8?B?VHhteHFTcU84Z2V1ZDRGM3VjNUxqWHdsRUI5TmNVRldYVTZ5UXVrT3FZbDB0?=
 =?utf-8?B?Ly9yLzA1bUNLWVBLTzlkeDB0L1p0b1R0SVBkRWRzeHhGOXBSN2RHa2pTWjFC?=
 =?utf-8?B?MXRVQWxYWHZIMzk5RVFLbFlRVTVzR0VaR2JHUlhOWHJrYXdqK1BZRSswSGhs?=
 =?utf-8?B?NVRCNjdGTkJWUnRyZHk5NTdVL1MxSFd5YStaQkgzNEQwUmovM1NHUWZZY055?=
 =?utf-8?B?bFpSaW1OYlJaQk84VGNXUVpKQ1RseUxvSWRadmlFdk9UQ3h3ZzVsRGFacXQv?=
 =?utf-8?B?V1J1bEhHUGpKNDNDWEhVUGpkcGVydmdzQXF1R0U3Z1M0MmJxd1ViKzhmdVE5?=
 =?utf-8?B?cVRkMHM2TEdoMGNJclNNTGhhbis4SWMydHRFQ01qTDRqL3NaSnNscWZNdlY3?=
 =?utf-8?B?cFVHWlEzdHJxejVQdTVCQ0xFOHp5bENqZ3U3a0xxSTY4ZjVnTnZTVnNla21Y?=
 =?utf-8?B?Vi9ieFlDT1BubFVRbEN4R21nUENCY0w1ZEtQNkhPZTZramwxYXQvZUdxNHUw?=
 =?utf-8?B?c0lMRFk2SFNSemw4RVNDb2JDcWthMmt5WkxkbGcvLzdxdlRXTnlSbEhJc2dR?=
 =?utf-8?B?bGVYMGNFT0M2K1dESFlXK3RZaVBVdUNTZGJOL3htRFl2eDZOSUQ5azllRDlz?=
 =?utf-8?B?citaalFWTDcrTFhZNFVpQ0NFTUVxd0VKK1RpMXMraVlpS29tQklxNGtWSkJR?=
 =?utf-8?B?dXZCbW1jK29LU1F5bndpd2hlcGVNYXBJaXl4bnRtVzk1UktnWHgzMm9UQjhs?=
 =?utf-8?B?NGVUTXpnaDRXSmlZN1BOa1hwRi8rWk5LazJYb2JuZ1MrT3Q3aXNIMGs1Mk9t?=
 =?utf-8?B?RC9vQjJ4WnZqWEtzeDJDelpRc0d4RmYxV0hybkZORk5UemZrNm8zUVpUNGJP?=
 =?utf-8?Q?cUVKxpEEhKvTnSF/Qo8Ez0qRT/qWOkV8q6m44Nhd+cwu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4854c208-4500-486a-6877-08de2e237d1f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:11:49.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCulZvC+0gJ7u6C9PblnxgeVBB8F9/MlClN/irusDDY+vkqlQGwtqwJ9PkhFsaT+vlqCsiHFg9PObzhUMTBUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

`build_assert` relies on the compiler to optimize out its error path,
lest build fails with the dreaded error:

    ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!

It has been observed that very trivial code performing I/O accesses
(sometimes even using an immediate value) would seemingly randomly fail
with this error whenever `CLIPPY=1` was set. The same behavior was also
observed until different, very similar conditions [1][2].

The cause, as pointed out by Gary Guo [3], appears to be that the
failing function is eventually using `build_assert` with its argument,
but is only annotated with `#[inline]`. This gives the compiler freedom
to not inline the function, which it notably did when Clippy was active,
triggering the error.

The fix is to annotate functions passing their argument to
`build_assert` with `#[inline(always)]`, telling the compiler to be as
aggressive as possible with their inlining. This is also the correct
behavior as inlining is mandatory for correct behavior in these cases.

This series fixes all possible points of failure in the kernel crate,
and adds documentation to `build_assert` explaining how to properly
inline functions for which this behavior may arise.

[1] https://lore.kernel.org/all/DEEUYUOAEZU3.1J1HM2YQ10EX1@nvidia.com/
[2] https://lore.kernel.org/all/A1A280D4-836E-4D75-863E-30B1C276C80C@collabora.com/
[3] https://lore.kernel.org/all/20251121143008.2f5acc33.gary@garyguo.net/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Turn into a series and address other similar cases in the kernel crate.
- Link to v1: https://patch.msgid.link/20251127-io-build-assert-v1-1-04237f2e5850@nvidia.com

---
Alexandre Courbot (7):
      rust: build_assert: add instructions for use with function arguments
      rust: io: always inline functions using build_assert with arguments
      rust: cpufreq: always inline functions using build_assert with arguments
      rust: bits: always inline functions using build_assert with arguments
      rust: sync: refcount: always inline functions using build_assert with arguments
      rust: irq: always inline functions using build_assert with arguments
      rust: num: bounded: add missing comment for always inlined function

 rust/kernel/bits.rs          | 6 ++++--
 rust/kernel/build_assert.rs  | 7 ++++++-
 rust/kernel/cpufreq.rs       | 2 ++
 rust/kernel/io.rs            | 9 ++++++---
 rust/kernel/io/resource.rs   | 2 ++
 rust/kernel/irq/flags.rs     | 2 ++
 rust/kernel/num/bounded.rs   | 1 +
 rust/kernel/sync/refcount.rs | 3 ++-
 8 files changed, 25 insertions(+), 7 deletions(-)
---
base-commit: 54e3eae855629702c566bd2e130d9f40e7f35bde
change-id: 20251127-io-build-assert-3579a5bfb81c

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


