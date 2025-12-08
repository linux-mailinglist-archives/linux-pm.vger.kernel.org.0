Return-Path: <linux-pm+bounces-39286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2130CABE1E
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 03:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D898305FA93
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 02:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1A2C15A5;
	Mon,  8 Dec 2025 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKpXCJRm"
X-Original-To: linux-pm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E02BDC26;
	Mon,  8 Dec 2025 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162064; cv=fail; b=fv8RnfDIGS7cfbu8faejMhvn2NxyvqSK1r6gMPDLd8veVmSMHJxYxLIrfuGHtgjlleXZ0VJTXLaFuR7SuQYlHUiJYCjqtlLRRP6LjEHe74HRNCEdJwoXvNsKXF1oUi/5o+cPVlFMbe/BBReXkCX2hzZC2HvdgVGUeK8ywXlPhxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162064; c=relaxed/simple;
	bh=nMRKFKOuI17udMiZ4eve02WOwT6ZTQyRPpA+s7Vlti8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jHeh7DQmVmgw+kq09KcdbJWaJWFHye2nYtcIgghy5jnQw5Y03zvyMwvhRsshzU4w8nqX1TVSBfU4CBi4ChBbuXCDBzaNyvhMkf+cjLJaIot9Rkd3pTWDHyNMwh9x7pLWOnqd0HZIv5LkEztyDpPKR5/ugQaBIxy7RDZ1IQ3qxec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKpXCJRm; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrrRdqGK8+S45gHJW0oGbJGqAKFe8HFmDgHpokyF/1OACKNKzH/9Eelr3IYQuXtxm7yyMd4wdqUFYFT2bogsEDeI8XfKfVihUcvZBHEmuIf/ZJUMIGRxCbbGFcfqOY65oKFL78sMu3dSWsW7pxw5PIJaf2KpFTA3g2sGNth9+cPMqmvdBmE3zSlamRY1f2uheujuPTzpzSG5i3NnoM8ZhLt247qbk2sqZ1LaNEaOmZbyNN1d9rs6s3mDg4z7jV6fi6NKUMCyZga0lz8Epwj6KUOrz9owLqU0wwHB4A41B1EUEp8lWaIoEkoaOE/2rRTvTUkkpgBQ0Tjbj7m9rhyJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLyGfNF2UX+LaUULdXZsIzaT8HMWkuGYSoyqlxxkPwk=;
 b=HDYqmf7VuE8+ZEkxwJOwn0u0/8ZO074aPoLdFAoquDvtAwPPlGlEtDVcPTZPIhRWlO01JCbHT23wL6iHq8jdtRAsjHMHJ1LE5Nbc/U2m3142VFY5IFGvSyUvs3mp0BnN/wWuawwOPWrx5N6Qfw8zi9p2XTnmlhWXW0HpbzQmrYy4wjX+4V4eVd8NP8ChQHKBbcdcw2wQcoeIwQBtCR/iOFvM64qj4ow7cCYeVOeffXZZvGvl4Sy5JxByoWHnJ2TI9WaOpIwMFPTfBx63jKFwd2DTjlKYAAMhYLAfzUDd9vcCuMGNg6ZqyCwrzKSt2XKEv6QyZKA/cu2ScdJIxwpfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLyGfNF2UX+LaUULdXZsIzaT8HMWkuGYSoyqlxxkPwk=;
 b=SKpXCJRmMI4cOh3ZHrz53mMzd5Nr4vSFrm5AYtEAqrDo9+qaR0J+DF6FsjLhtYOAXtwOl1jX5djyU5eugwq4n+OhL3nojvJBgHRsnQ2iaaAUyRbeHTpD+HN/fLttboDjMCpeBysOdjFGe7MeK/LL/GpxoboGxT9DKFuO5uQP736UG42r/AijYlrt9NxmBAMUfBaKq+yiJiIVvK4fY7bFzsN0SMj0T27kh2qwkeesS7sGI5SJRT7KMtByovDtgFLoW8uCoo6A8J9E7RKzNWJmJdB8bg5Rzjzq+p2vQ1qUoBNv+VuBpkWBn31Wi5hxA+tvXWkeEe4FpJR44kJV5H5k2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 02:47:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Mon, 8 Dec 2025
 02:47:39 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 08 Dec 2025 11:47:05 +0900
Subject: [PATCH v3 7/7] rust: num: bounded: add missing comment for always
 inlined function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-io-build-assert-v3-7-98aded02c1ea@nvidia.com>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
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
X-ClientProxiedBy: OS3P286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a4::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6977d117-0f34-4a6d-000e-08de36042724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFBWQll5Vjd0WW54V3Roc0RPQlhxWmpITVlLN2JTT2tBbk8yTC9Kb2t4WHNv?=
 =?utf-8?B?akFGZzJaM0FaZ3h1cVJrVU9Vd1ZvUXlXajRxbEYzVEtrZzdQd1BBSjVDbU12?=
 =?utf-8?B?bGRiOGVmY3hISFJYREFMeklhM0YvVXoxckxqTTlvaGJxbU5xU0tJRXhxc1VC?=
 =?utf-8?B?cXdMZ25jRXk1eU5Xd0VKZzcyOTBKOUlIeHhER21nVEFZNjFVRTNaaTBKOVBQ?=
 =?utf-8?B?NGNTNnhTeld6WVJaV2JHdml0UEpBQUV0OSt2TldKUjhETFU3UW8vcUlJem5l?=
 =?utf-8?B?MHl2WlQvWkdkcDllOWhBR0tjRDhLc2J4ZVJoUWxFMW5XU1k2ZUJPR1dRRUFG?=
 =?utf-8?B?L0lhZ1JLai9MQlRBUGw1TDZDTXNMT2s1MWZJcHJUYjdvVEp6dVFpaXQxUThl?=
 =?utf-8?B?alBWZS9ZSlpPTUREbW4yQk4zdmwvNFNVdlVxam9YbmdpNVFVdWx2RGc4WFFS?=
 =?utf-8?B?K09yMFRiTnVGa01aZDhkWWlmclZFL3pDNlBLa01GZmJGSEZNQ0t4YmRWKzU4?=
 =?utf-8?B?aTdlem1scWZjMFpFQ0J4ODkybUVQN2JOdytqUE9tb3cySkVta29jaDBIaHRL?=
 =?utf-8?B?czlDUi9JdGU4b3NvZnBROEhWUlVJOUpTaWhjRE5GdHFZOU1saW9tWTB2Y3pt?=
 =?utf-8?B?bkZrSU1VWnpiaEM3NnJ5K1lNbThUdERZY3J6TzVDOEc3c0ExMXpwa2tlOXpp?=
 =?utf-8?B?dEg4QVFDbXN0NlJOQVVFTFY2ck9QYXp3TG9QT0xReENDRXIwRHl6SjFOM3RT?=
 =?utf-8?B?SFlpR21KNkd6NS83VUd0Mlo1Zy9lUlg5YTlsSmZQMmcwU3NQUE1DSEdvcGNC?=
 =?utf-8?B?WjNvNUYrc1VJdFB3eXQ5ZWRaVjJvQ09zc0s5RkVhQXJOZmd1K0FlZ0RUdlVS?=
 =?utf-8?B?MmJmR1dFRHl5VW1uc2NUMElCeGR1U0RjeTFSTGgyY2ppUDBCTmV5dG55dTRQ?=
 =?utf-8?B?c1g3TGVVTXRRM0xHVTEzRkIwWXBlS2Y4cU5nZ3hOTUsyZUFLOXBHNDVjR0sy?=
 =?utf-8?B?L3k5TzRKZlRGL3NnU3pkOWx3bzE3Tms5ZU4veW1KWEVwWmFRbXdpMmlId2xO?=
 =?utf-8?B?OTJHUndONHcyeDkyZUlNa0gyTFU5YUVNSlVUVm9WK3lwMURDSzQvMmR6NGtW?=
 =?utf-8?B?SjU4ZGtrRlZWT0ZUWXlOT0FaN0dieFJsczdTUTE2c0k5TERIQ2FrTUZGY2RM?=
 =?utf-8?B?djh1aTNPMTJ0M3J3bERYSVNJSFVCR3BBVlptUEFUazVqRXFCZ0dCaDBoTHhX?=
 =?utf-8?B?S09MeGJmV0tma3BOdFdJTmZTUVAvUTg1c2JRbXZYdmtieWhPdGtKQm5EbkEw?=
 =?utf-8?B?ak9jdE1GZGI4Y3RVcGRJNlFwdjNMQjVzUGhndFF6cmJMTDdNMjVCbHJFckJy?=
 =?utf-8?B?SWdLM1dhcWpGbkRJY1VCNzVNVzE5TDNQcXVWRnZRWDFselpkQkQ1ZkYrR1Vq?=
 =?utf-8?B?QnpJS1NzUHZTblh0UHp6WnJVQS9jZWs2Mnd1MUcvamVteVRsMFFOVmlUQkh5?=
 =?utf-8?B?aTZLdzFpYjdhdm5hRWlTSzM3SzdtQlNzcVFYZ2FrRCt0eXlDK0N2dTRsSHFM?=
 =?utf-8?B?SUl5MEx4Z0xzWGpFdUZPTXJoUUpUQkRLc3d6VTE5a2MyZmRWd2RseGNicS8y?=
 =?utf-8?B?VGI4dklHN3NzOUQ4VUh4Y1VsWVl0ZnUzb1BKOVk0Z3BsMzR2YU9FNnBVU093?=
 =?utf-8?B?QUFGMnlGa2pYemdlWVRPWG1VdDdSL0twdVRGL3IzSk1OWDNkd1YrS2RWR3Zv?=
 =?utf-8?B?Q3hZb2RybFlqblpteXhoa2FxMlhmUWRDQ0duRXpvYk1FMEhwblMyTG1uVFJq?=
 =?utf-8?B?QnpSQnU2YVZrUU0zYjJUd1lrcnp3UEpqenIyZnV1bmRVK0dPNVZLNzVwMFRI?=
 =?utf-8?B?NVA0K0lkaCszc3JMVElIUWV3OWRnK1I5QzF3WHFJMVZiblBYWmVaOUhHOXd2?=
 =?utf-8?B?MEMweFI5ME0rR2FPZitNQVdTN3hFUUVIbUxiZ3Z4ekExT1RPWDJna2wrRHU2?=
 =?utf-8?Q?9D5ujZ/q6TZy69+rzbf+LGauGz2GWM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWlXais0anJNRlVwaW4raHp5VEpVTlRuT2x1ZVhUUmh3cEZmUFVLZVFoRlVT?=
 =?utf-8?B?SWNlclNCS1ZEaTZ0aFY1bHlSMU1abnhvYjh0SVZVb3lNSUpxd3ZOdHRXTXRC?=
 =?utf-8?B?ZWE0ODUwb0gxT0R0RnI5cXkvVjF5ek1JS00vaTVmckRYeDNvVjRQR2R6LzZH?=
 =?utf-8?B?TUFWY1kweFBocnVwNHFJM1J4U3F6dmdrem43VjRuZDR3bmNRbC9rcExBTXV5?=
 =?utf-8?B?OXIwUnVacmt4RnY1S1BoUmxzdHpHejZXUURGUitoU2R3TTVYS1Q0REV5ZGR2?=
 =?utf-8?B?cjBWVmR3VFBqVnZhSHJUZ1JvemJIUXlBNU50Z09RWWgwMkZlSDliL0RpSGVw?=
 =?utf-8?B?TDhndkNaRFRWdnZNY2d0RGpoOWxrWWVIWXFGQUdkaDkrQkRUc2s5VWdsOWV5?=
 =?utf-8?B?V1E2QzMzUHpwODBzTG1CbEFwNENzSWhHc01WTU82bFB5cUxYOW9PcldCVmVr?=
 =?utf-8?B?dXBKNEJxRjk4VytvZWdFR1JBdlVadUJZUkRwOHJ4NXMya1RrRWFCTi9Vcm1m?=
 =?utf-8?B?UlF0MnZnYkVFckc1Y0hhb3p6aG5MVG9OY3NJeGVCZGViWG9kYU5Nb1pJY09M?=
 =?utf-8?B?RE9qZXVzTWdLQ2dPOW9ERzlUN2tMOVNINnVjc1dMUExkY01iUzE3cDJhZEpi?=
 =?utf-8?B?R09hQTRNVGd3WmNpRlF5a05YZlo1YnYvWG5ZSkpuL3BoUkRGYVVnb2dzL1FB?=
 =?utf-8?B?Y2N3cVFENk4rakdabmd4cEExbFZjM0taeXdXRzIvUVVDTkQ1V3RNbENydGdE?=
 =?utf-8?B?cTFVZ0YyOUUwS1daaGp5RVRQd3dyTUZaYTRnNEpIeUUxZmM2VzNmWDY1bGhX?=
 =?utf-8?B?dkljM2JQbmdNUmx0UENVRTl6TVMvYXI5MnVkUjh4ZHg4Z24wdFh0VUtWaklQ?=
 =?utf-8?B?WHRCNUVOMWg5d3JSR2NOY203TnYzWkFBZWtYQlhDbXM5TjE3RzRuc3dRZXR3?=
 =?utf-8?B?elJNRUVadkw2a0tFRFQrdzBlUS9XaUZnK2JoK0VueGVKdXlXSnB2N0d4OHVM?=
 =?utf-8?B?SkRYQ3JhQ0dZSy9MZStLbTEwaUE1SnJPTGVQUWd5S1RvczFXNzErWXZ2RUR6?=
 =?utf-8?B?VlNleDI0YVA3bFdOcTBqeTFpZDdFS3ZISDljTjEvRmtHa3Bxb1JTRmpzQlVq?=
 =?utf-8?B?b0w2aVF3eFRrY0NmZ2tKTEJWdndvbURmclBHN1lNYUpMcEczTkFySHhEV1FE?=
 =?utf-8?B?VzVrRmYrVTlkOFdJS1l6K3IzUEVtcXY2TFpCWUZaNU9BSTk5VGNCTE9GNlFO?=
 =?utf-8?B?YUxZOVdGQjI1TStUL3dLZDduUHBGYW4yRkJDbXVWRWZJZ1lhdkoxU0Y3WENs?=
 =?utf-8?B?L29YT016WEdoNEI4WHh3NER4UytpUG52VEtheTIzNUJ0K3dPUXF4a2tLZjQv?=
 =?utf-8?B?eWJOeWMwT1Rxa2lVMFQ4eUN3cE1reVd0ZHVHZVlPNDd4aEZtdjVrTlp5OEJ2?=
 =?utf-8?B?TXFoSmx0SXlEZDdNMVo1cFFzN1F3VWdtWm5IUXROcnh3SGRMS3dOWkpKUXhD?=
 =?utf-8?B?S2QzQTVaN3N6WnN2VGQwYStjbnJxWklnemRQT0FQV0RnZEtCUnh6Q3N1Nk1l?=
 =?utf-8?B?ZVhKWVhXcGlpK1RmOWhQb3RkOW53QnQzc2lFMHJBaHBZU2draS8ySjhPZ2V2?=
 =?utf-8?B?OUdCeTR6VzVSNW5CRk1DSkl5VzFiVzFqYmdYc051a1RVRUF1bTBpaElHcnQ4?=
 =?utf-8?B?Z2d6WWFJenZwbjQ3aFhxcVJsaDZ4TmovbUtPWUJ6RGVSRXR6RE1pd09SUWdY?=
 =?utf-8?B?RlV3RHF0WGgxZ3l0RWZXL0hPWGVJUUxnbHBIeTZhZ3J5YnZYdUM0bXRHVTBY?=
 =?utf-8?B?ODlWNWgzV2RWNUtwWG8wdU5PTFZPNFBUWGVRbVNoamVMRlBvbS9nZldRSEc2?=
 =?utf-8?B?bjIvaTM2aFBWNUFQdTlYZ3RHbGJwZHhCbEEyYmF0UXlHQ3p5L0Mzem1qcXlL?=
 =?utf-8?B?MG9yVFp2Y1lpeC9NeHRHNU80ejRJUy9yYy9PbEdDOFJlRWY5ZjNVc2R2MnVR?=
 =?utf-8?B?dTJZcVhGNytMQ2xaWHFTQlMxZ25qSXk5d24wQ3JBSDRvdk9FcWNZYktxRkNR?=
 =?utf-8?B?bWVJM2kzcFp3Qm9vSUZrc1A4d3p2T3ROcmJVaXAxeEhFcVFwSDdhZkIyVHFU?=
 =?utf-8?B?RjRjMHY4WnJFRlBYMUdJNlhPeHhaRCsrZzFzS0JzRnpSeEI4L2kvZzRacWIv?=
 =?utf-8?Q?dMbe5IwpCI0oBfCIiH+VTV3AXO6QSwfjVIzTbJuMueTQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6977d117-0f34-4a6d-000e-08de36042724
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 02:47:39.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMTHJo4+hy6/wAxUmNaj3wGGP2c5OYrHmEQQy8kLbTPG0hAs+7EdTUJ3wiAqsoKTjgnewQ3FAMo4CtQjVYyLJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

This code is always inlined to avoid a build error if the error path of
`build_assert` cannot be optimized out. Add a comment justifying the
`#[inline(always)]` property to avoid it being taken away by mistake.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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


