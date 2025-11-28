Return-Path: <linux-pm+bounces-38856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2DC9099B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB44E1ADD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BDD295511;
	Fri, 28 Nov 2025 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GXtedSbh"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25996288C22;
	Fri, 28 Nov 2025 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295941; cv=fail; b=BkfhS13kmflIyqH8L9NrFjgndxSg0im1NgrUbIMmBOQGv6dLN8RKXCG0HC+FQpsUE1hy2NiBVo0XBjnRkEM/uY2EGMW+ic+sJ0oyjGtcaTn/K4CbvCp4KR0h0jUyRcDabMWhd6XPCqRGca5tliKLmF1iicY2p3m7XipuRPrgiSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295941; c=relaxed/simple;
	bh=zehF8VCpzf3Iqux5VaRwCklmOI+AgJpuK2LSFVLa6HI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=szeyKWEWWmWORXgxvjVOurHq+GLxpW/O796rvpYHKxZZMZifYsSxC2gFB9hoWKmrPoKuzDCjN5hxTNTwQ887RdD1RHYmLfg/lnrDA5HBrYzsyTGvNelPCe2I1ESsBRQYED+qw2sgiO86HczsxYzyf3rt1qt1H3J4uJc2C0TS2FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GXtedSbh; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb0XhLHxlnqPz006CxIB6OAajDaYtzWub6MRQ6i03+nMsSlj+WaelpM09tlmnnAO/e1C66IlqE8/QtbPUFCK8koRzqBe+2FIlp/8JzFhNvRstfwWVCESUJOCUbDuKMHVjXNF543lyrIAK5fEXD9PH6fTqwzmp8TLqLC6AGz7CA24mjPbSLGnF037sMjp1HnAJk4MCdPi94JmvcNcNJz6taLHkD2Dy9k70/D9y5TqxkYcez0Vs2Tts1HqzVVENnHOSaZ9v63tyCdRc9L8bdWKnqrVYSyEzaCuQ0aL4QXVvJLKWhkJGKTzRtYXnj4swCBCyctQOKFZFCgiueeM5E4JmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9muJdHVxe7Yozouz4JFkjmrgdh/pzFJFa75Jenn2hY8=;
 b=Lo4pRP2HPw5vTVyvdXv3FTBU7c8AvrFWshHp34Z1uiQaGBjsEOHYIed4c59Fc5rDQKnuwYK03gbmj7PbHsHE+B80hgzCyG6XxUomBmuKZTEg6I4mGg1mwC8nzarTYqb30xCwCf3MFA196Opxt9Pfjxda5UdJ5tG9K2ezWTT0yOv3pcXb3vmeNZXXc1GQLTe+QEx6sHXEWjItowjp11uLPOwHN0aeCIxYnODi2wEbxo5L7H9MfhBb/j5Mw/D8gE7L8NtwWjfT8gvUzLYQ6A5/eCuNrU6U4Q7tFTppLcKZGg0LcaT3eXaSQxWl/+cnpH3I6/y3lfJIkWltdI+PEK3v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9muJdHVxe7Yozouz4JFkjmrgdh/pzFJFa75Jenn2hY8=;
 b=GXtedSbhmsup1P9WCTlmCIcunCukgs+ZzAyL6PwYdwJC9aSUVBXQCIV8MT2ZlNxt4i7fbNeR0rk0fcPaGSZ71xDpjiaxrz1/q0wEZpk19UjxOKttsUS8WK0YO9Q1pFEucqVQMWJ4funCusxI2six5NaC8rsHogvZVPoXQctrnqoI3KROvVItJ/v8HaXwDiQ1KQowYaX0PeIEJ04s9nGUrGg5TVXT+VjlPgBqOygtIKUPXn7xziAD68yVtNjQpvzFKw/HO1Q8Jmmd3OryOC2Kz/jKx6E3/hp6+GKZUk7DwJhaenvKLs1enhXVy+U2l0555UN0U1IxWXgQMceinnM+oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:12:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:12:16 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Nov 2025 11:11:43 +0900
Subject: [PATCH v2 7/7] rust: num: bounded: add missing comment for always
 inlined function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-io-build-assert-v2-7-a9ea9ce7d45d@nvidia.com>
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
In-Reply-To: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: e4edaa59-1896-4a9a-daf6-08de2e238d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE9OSXRiSERneTZXMElYM3l2VjMvcWFvd0poSk5QcThTQkxiWUlsdnYrNktr?=
 =?utf-8?B?T05Ba3hQS2krUC9jeVFIUU1Ta1RLR3o0SUNPOXJkZkFwV2JSYkdRWE5jTERF?=
 =?utf-8?B?KzA1dGlEcTFiVmRJai9mQkNkWmpqT2FSSDhNUDZPMStvUFlQRGNVK1RHK3Nw?=
 =?utf-8?B?endUYmhBbk9zWlF6MTZOVklDb0YwTW50RjhuVVJlUmtvdUgxNzBVSGJuWXZx?=
 =?utf-8?B?dUJhRHpvMmJMc1hvU3RCcyt1OGRmSWdHK2hZemEydkJRZWw4dGNDSUdYQk5Z?=
 =?utf-8?B?eXU1am0yRXRZak0xRlJwZlVJaVRDdTJYMWhVZ2VQN0o3eUtVamRoREdlYlVM?=
 =?utf-8?B?MXVKRk5aV0ZkZUxrdVl5bWlKa2FkREtUUjQ3T2NLVnVvTlg3V1k3MWxwNWha?=
 =?utf-8?B?OW9XWGFYT0RPV0JaM2RSS0JIYTJnY2dEamlxWFpkanVWenJJTXZZZG5ZdGM0?=
 =?utf-8?B?MUxqa1VOaEZvakZtS29TSlhLT3lGZXBWR1Z0K0Y2OGphMzg5Sy8zWlJzQ2dv?=
 =?utf-8?B?dlBTVWZtSjVSWWdTV3hTUHFQVldlK2pROFlpcDdBTzY5ZytuTnVuaWpxVXpt?=
 =?utf-8?B?ZklEK1ArV2RCY3d2cVd1WGZUTnpoRjJtMVpoYzdQdkN3U1VCbzlBVnhzVG5y?=
 =?utf-8?B?aHBvVUdDRUVoWUFVY1BpWjVXd2cra0NjbmRHMUVEN3JQL1lzeTJHaXdYRWc5?=
 =?utf-8?B?Y1NlenhrUTJQRU1EM1d5eGhxTUVUTFh2emt5WG5vVkl3WjdNcjNkRlZVQkNl?=
 =?utf-8?B?RGJ4N3plSTNJQm9TenVBTE5FYk8wTFlXN1d5cVFGTCtuT01DTEdiclVhaG5s?=
 =?utf-8?B?Q3Q3ZDYrbC9rMStIR1hYUUhIb3ZYcXdFYWFESWkwVDMrY29SODVhZGRXYldt?=
 =?utf-8?B?eVZyYnhlcXgvaGl3ZlhMTFNpTzhwQzduVXplQ0NNOStIY1c5MHpHVDlQbS8w?=
 =?utf-8?B?T2x2NSs2RnU4NDNXRVNabU85eS9wR0N0b3dMOG1SMHhocFEzaVFTMnNRcHVV?=
 =?utf-8?B?bVkyL2hqL3MwYzljVkFxZnNNNnZ4QTA2Nzc2Nko5OWh0Q0lDR2oya2c4TTBh?=
 =?utf-8?B?d1Y3Umw0c2xRU01HcXB4WndvZkIzVUZ5YVdEOTkycFJ3WG5weTBpSmlXZHQ0?=
 =?utf-8?B?WU1BYUpMaDdEbmNJZWt3ODVsbVczRFE3NVROQzllZDZkVDdCNmJsRnRET0lh?=
 =?utf-8?B?MkZRd3kwdHN4Q2k1RklhVFRRN2g1c1UxUDlVbW16S3ZTZkNJd2hvZVJ5MGhN?=
 =?utf-8?B?R3cvV0xhcWFDSXFNN01td2dPZDB0NW5TN0VBcXVjZWhBUFRncDNRa0tXVUZQ?=
 =?utf-8?B?S1lnN3JxR3N3KzhubkJMbit0T1pmQzJ0WW1tRTFScWVLek13dXNBNTYvU2tt?=
 =?utf-8?B?cUs4aWIwT2YyTjFVV1NkbU54azZHa2RtdzZPMzFjb3JvRFk5TENMZDNxSHAv?=
 =?utf-8?B?aytwQnc1a0VjeFJmMkEvTktpMnVvekxKN3QvKzIxYTc0RXpybUNIMFk2ZCtQ?=
 =?utf-8?B?VGFNNGluVWVpR3YrRE9YZjF0SEs1N1FsR0JEQVp0c24wWFFFWUdrdFR0TzBE?=
 =?utf-8?B?OEVzdFAxKzFjNUczSjZKNTlVMnpDT3dmWG5scDFtbUYwT0N1RlI0aUtadVlK?=
 =?utf-8?B?TTQ5S1doR3MxVmZMUGN5WXByeFdGL2cxdGdpbnM2bXdlSVFXQVh3ek5Ud3VH?=
 =?utf-8?B?dThrdzlzVHVISng3dGVURE5RWHZiUytwR05rcUtYOGhOVFZtTzJjb1VYcllI?=
 =?utf-8?B?WS8weXBCa2dhRzl3OFFDRHNDaExuRjN6eEdYVmxaN3NtbEJlYVBEWGdYRXIw?=
 =?utf-8?B?UFh3bk1YNU5nSVJrWHlySFlYbmt4eWpnUXdNY3NEdWtwNENnR0Z1dlBZY3B4?=
 =?utf-8?B?LzMwUVp3Zlpwb0loOXNRTTJqQUUwbFdCT2ExRlBjL1BGZUpqLzFGZXFRU25i?=
 =?utf-8?B?R2swTVpPOEdBbk1kcnVMdHBSTmVFK0ZMTXNLYWliZGdPN2cvMVF3ZnFUSWxW?=
 =?utf-8?Q?9CuBrbWZxStI+BQG+fc6fZORRq0tx0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjYremtXNFRaQUlOb3o0ZzVFR2EzWDc0cHR2NGtaRVBhVFc2aVpIZW1zUXEx?=
 =?utf-8?B?Uk8wV25rbmNuWEJBcFljOXY5OVVWUW9EbnhsSEJnRUI4SGV1ZEJPWHBEL0tI?=
 =?utf-8?B?QWZuODRKTElxT1R1ZTdTZUE1VXQ4VjB4eEdGcXYydVVtZ25oMGQ0WGd0cHhq?=
 =?utf-8?B?aWpQQlZaamNTR0k2eUdlY3hrVTdrN01YbkpkaTY1azhRMmxZTzA4K2djTXM3?=
 =?utf-8?B?OGdTMzFHcVRKeWJhWFFLdGxSMWdrdm5EZmtJYnJCODdPbmdHcHUzZGJNYzhB?=
 =?utf-8?B?WlF5YWc1aGhMaVpwUnA0T0NnMkNvYmliaWswemdwY3VOWGdNY3QvdEhEN1Y0?=
 =?utf-8?B?a1QxQjVnZ05aWmJTWENGNFlTTE1QMkcyQ0d6TmZvRkFnQlNmQVVZQSs0bXlO?=
 =?utf-8?B?QWZpMG1iQUpqMlY0bjhtRTZONnJsSy9TWDdhajBSYmtscGhrbGdJc1NHalhE?=
 =?utf-8?B?clFHT1pWSFJYRVlDdG12RGFCQlE1SFpNOEcwZGQrME1PdlNpcUF3aWlTdUQ5?=
 =?utf-8?B?dE15SVpHYktBQU5Vc3BTVER3aUJMNVNycmF4WjNhWDdaSVd3cmNzdkx4Q0dN?=
 =?utf-8?B?Yms0Y1RIZkFrUXdZRGRObEFDM1hxejlCWjZFVkQ0a0hJcmhlM2UxeVZKWEFW?=
 =?utf-8?B?M0NYSU1vOWhOMnpkKzFTNkpCZC9FaGJrYnJoblZUbnpwN3lqUzU0eUo5Nzg2?=
 =?utf-8?B?S2RweUZTZmlLdWozaGpHNXowaGRvcnFWN2QrZHE3VTNZS1FaR1EzVDVyYVkz?=
 =?utf-8?B?TWZxQktWdlYwRFJmR1hzOVRGTXByaEUzRVpSZFJKRHRVM1FzeWF6OGdXVEFZ?=
 =?utf-8?B?WFB1a1lvbjZ3QUY1M1J3M1ZWZ0FNL0U4S2d3KzJQUktGTzUzdzRCRVo5ZVh4?=
 =?utf-8?B?VThOUkIzU1lsWElNa25pK2NKMmNLZERVR3YwL0k0N24wN2YwdnFROVc3TnFJ?=
 =?utf-8?B?MDFOb2h2a1d0ZUx4RmY3UUtOTWNFU0NZbG9YbTMwVmNsbTlicUhNcDFDREhH?=
 =?utf-8?B?SGhwTm9iWG15ZmdlUEhWT0lBSE5ZRjhSM1l3MUtRanBMTVFYSlo3VURjVWs2?=
 =?utf-8?B?Q0k5Rmh4VThaZWVUcHZtWmFRaUw3K0cwSHdWQVdwMUIycGx3YUNQdGt0OFlO?=
 =?utf-8?B?cVJVZjhRSW9VUkRGTlNmSWhGS2huUW1uNUhQUFVTeFdSd295Rnp6MGVPWFpX?=
 =?utf-8?B?VEtZUEgyR3duVGtPQnJ2L1EvNDZLbUpEYk9NQ2NUMWEwUEV1bGVYTktKcjNn?=
 =?utf-8?B?ZzJ4blFhdFU5QnY3OFByTHRRaUoyaXdkZkk1NnhkUUFDT2NkSXJsTTRpZjBB?=
 =?utf-8?B?RGhROU1TRUdhdU0xRjBoSHFhQk1pMk5LQnpkOHM1VDlXMHZjUVhrL04yd3BH?=
 =?utf-8?B?dEpudDlpU0NrZENUWWRoMDBZWUpacjMzL2ZQZzBTV0tsbnBZdXExb2gyYXdD?=
 =?utf-8?B?a1BKOFAxUTZwc3NGSlRhSG1VSkhxVmMwZXpoOXAvZ3p1TWxtSGlqUzJ5NUUr?=
 =?utf-8?B?K29WajZjd2o5MkM4REJVSUhaVkVSZm40MXdRQVZzS3lpR2F4UWROWGpvODNk?=
 =?utf-8?B?VWRJbU1tZXZYYzh5MENUbElCaUhYVHFBZnliK01JVG0zU1NUalBtV1l6SXhB?=
 =?utf-8?B?OElNQVVpdnNPb2lQTjM0TjhqTlNlL1pDRlF4ZWp4UmFGeWFmb3JhTVJKbUh2?=
 =?utf-8?B?Z3J6SnFDeG14UHJRWk1jTVRtcGVYQVlNVFYxMElpcEwxM3k3b20rVGZweTFY?=
 =?utf-8?B?bUZlMVRDYjk3Qm5MdytBRE5paGUrd0EveGRuajNZVG04K1V4OGZZcytyNCs1?=
 =?utf-8?B?aDM4U0srbko1Sm1YaXAxbWtxaFZSWkJtT2thYlhaK2N6OCtONEE2SDlmZ3Zo?=
 =?utf-8?B?bmdPcXZPWEhaQzV6Q3pySkhKaXNOR0U1bzNPV3ZOVnRuVXdNQnc4eGtsNHJ3?=
 =?utf-8?B?alpHZEJvWUdQRDIxa0dvM2NzYnhBZ0pxN2FabHpjSnc2OE81Y3ZUZ2dqV05L?=
 =?utf-8?B?RUNBRm1USzhJaE9LRFh5WCtBYm5lVDNWM3M5UmF5dVNmRnkyU21jenlETTgv?=
 =?utf-8?B?S3BVN2VhMmxpSUVCMlFyMmQvNnJObGFLTnluNGxKN0JuRC9DNmk1VkpPdGI0?=
 =?utf-8?B?eGFEc1luaVp1VUV2cnVQNndVamRvTTkwS2JIOTd0dElTYTZ0djFqOWxiY2dk?=
 =?utf-8?Q?I14uyJVknZaZam8gkDNpbezNJa/PJF/XDYUYCuyG7wYq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4edaa59-1896-4a9a-daf6-08de2e238d51
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:12:16.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwldoXcFCp8LFKEOpb3en/qSKSvNG9BpU+3SgsKVC1FyD9Bd3zErpxRUMejUDsJfZrweqYLkxfOQUcKu9Wk0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

This code is always inlined to avoid a build error if the error path of
`build_assert` cannot be optimized out. Add a comment justifying the
`#[inline(always)]` property to avoid it being taken away by mistake.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/num/bounded.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index f870080af8ac..6dfcf9c1a55a 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -363,6 +363,7 @@ pub fn try_new(value: T) -> Option<Self> {
     /// assert_eq!(Bounded::<u8, 1>::from_expr(1).get(), 1);
     /// assert_eq!(Bounded::<u16, 8>::from_expr(0xff).get(), 0xff);
     /// ```
+    // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     pub fn from_expr(expr: T) -> Self {
         crate::build_assert!(

-- 
2.52.0


