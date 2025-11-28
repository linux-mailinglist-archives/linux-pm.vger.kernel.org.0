Return-Path: <linux-pm+bounces-38853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDF5C90989
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9464D34348B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C927FD54;
	Fri, 28 Nov 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IIBuLek0"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C227B4E1;
	Fri, 28 Nov 2025 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295929; cv=fail; b=uooHaG/fsmZdGq0E4da9ssoQfazKK5t8KYrjDxtjj3usluljo5bL+y8pFnkBiYWbjc2+ABsXTubCHtDCNrYSR9k9qc+cOW0bvt3Ja3mJP07E8wyxaf5SAGVK/w80iWc7643YWjzSsSP81kD4E++I2Hf4G2RA2vnCKzZ7/+Wdpf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295929; c=relaxed/simple;
	bh=LqnDyUwRyE59XZ0gnX3DXLwKYZEqUHZoil6JKBqyzI8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SkKV4C/61SIY8pJ+RWE3Szyp5WYBQHi8PIdYb6Ggo6Mh2rf5SzQtmgZGmhfLTQWZKTrazxeQGVTRVckD+xiD6mxZ83t5hbD0bXhn01CMgo2zUcfvTi0l2ObYkvuHzx13ee6FKhv6T4sZLx/GzSRgtqs0i7uax/BQwR/6zuM7UeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIBuLek0; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YovREMAE6/lM/nW62iT81YeAoGM54lTr2vbrhHPjPAp+XKdhL77PFuSCVuL5rDTilEMaXaP7fpV6gLKO9Rv+XhCEQAYgYSqLQPiu3NKaMDy+nCnx48xLzQZIHlzIT0nAurzPn+uP1EBjLbeYwxZH1UCEL35OTgUZ9iR7d+0dhRr9beFGF8Zj/Q+5bTD7hKxQIITUqEv/LFOb2oNsI8ez+mGqOsm9p4vD7TJdeE/hBlX0KO/yiV8KsgbGRjB9qsUrvkGWw6+yWbTGFXRMNyrTy8zaaKzKQeZEqlv8OGrKxZjUJsiKfCPkG9K3LXov4E88ZtgPAmZpnb7t/AWQdKjmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQlCJ0J2DCrdj5qMzeWx4FxqBPyHQBqbG9rONOnNDRo=;
 b=h4NxjvOq1p1Gb9QvkTf3q/+pCVIIhKDkdmkaaJs/pRSwU1gpMpRKcojjIrva4Zt2jcWnGCT/K/+mQNMd+EjeiLUbPSvSG4YmZk0EsD8IcANTgRTM8Aq9s3tqJ5JjONjkv9wjGcw+CwssBn9OZQKpSnB1L9J37eYOJhq6A7DU+zger315+O7X/v/5WJyrGVKojyWW61P5Qy9LoeHhNe7lJThbgib9wuFQGMlMRNxNuEcWdNfh6Kmsk4HNn52xD6uLh0iNbQgKlBceDhHjw9XJlyqyjd01EL2xPBRLoMdR7ggMmLAhGUg5Qzal+YNk0Ej5/gRjDFKbVq0asQkov9bP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQlCJ0J2DCrdj5qMzeWx4FxqBPyHQBqbG9rONOnNDRo=;
 b=IIBuLek0TLSGpB0W5cJKu7iIp3ohRgA2kU36LiUDsGV1alrgSbjsgnmgPY16oIdI2FBHLgfJL4e692vavP++jM3rZQsQQMLzKt2LrYUXqDsHlGx3vUfTGBz9NvHof+PltE4i/qAQTwyyo0ofz6lFh6c/IgQfTAXVBU74RFFgE8ACx5ImhTuYE8H4BLuVRQLNvD5xOUdqDLOyx20HoCU+ih8g6wrxefa0Dep59+6nnxIpmCBIwD4TCeYpdku3Tk5HDkZQ782GzFJAkTDptYgmELtJddRYFqo9IrU2+k5BiLRRe7jypWwep538OPivDdhHOreNP7IcbusPh7pFuHGoRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:12:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:12:05 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Nov 2025 11:11:40 +0900
Subject: [PATCH v2 4/7] rust: bits: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-io-build-assert-v2-4-a9ea9ce7d45d@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: d4590ae1-61b5-4477-49ab-08de2e2386f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmI3MDM2T291bWxJUW9vQkpIdTFjZGVJNkhvdjVobWhiREhPNy8za1BTN2Ez?=
 =?utf-8?B?Q1piZlVITHl2dEdndTRTUWhsYnhUL1FzdmNlVjMxUDROS0tYc0xsaTYwZnox?=
 =?utf-8?B?VGRZS21xTU1ITk1vMTd0R1pma2VjL3VuVjJuZ1VBY2txQ1lCVk1xQzRhQmNS?=
 =?utf-8?B?UGdHQVpwVnB5Vzk4cFc2clg1YU5idFRUWHFIK0hOWTlaQjhMTUsxTmF2NlFL?=
 =?utf-8?B?VkVBRjFWMVdRMlFJVEdZaGZ0eTFLTFJ0bW9sMWppNngrTGxsRFowYi9JUlNp?=
 =?utf-8?B?cVB3RVVxRThHVnphTmlkRmp6QWJxeGRtRDFyRXJMNEZRR2F0eVlmR2pYTEc1?=
 =?utf-8?B?NjhJU1VXTUtPeTRjTXkrRVBXRW5IK010YzdpZmpRejkzMDAvckt5cFk5cHRO?=
 =?utf-8?B?Ymk0QlY5d28zYTRqNUhpcjZxMXIvYStFLzZMa0dSZGluWlNxeWVTRm94bklR?=
 =?utf-8?B?UUZYdnFCR3p0MUxad2pnOExLNGtJazZGNFRMUFBSS0xQWWFRMFlCQXNsNklI?=
 =?utf-8?B?N3VXaklMZGhEd3QzUERtTkdITVdlaEZGZnlaRHhYUkZ6Q3E3MVhsdmh2SDhU?=
 =?utf-8?B?bVVONjJRU0hDNEdkdFA0eEk3MjlMSkZWTjY2a0twSUJIYWxLMnpTd3Rhd0RS?=
 =?utf-8?B?TXpwZmRRZHdVemJVSGdHOU13T05TOXpaZ0lrcHpURXVHUW5UQm9HQWlYcW1X?=
 =?utf-8?B?UjlNNnhzZ252Slgzekw2Q2Rhbnk4cUlrUnRQRzRUTzJ4QmNLdUpHZGg4cyt1?=
 =?utf-8?B?bG1tOW1kbCtqdFhrM1lCb0tRVVZvVWhvVStWeDZkSlY0enkzV3pUQzV1enpU?=
 =?utf-8?B?NlRLNVdRYXIyVVVoZzRVZXJPM1NMaWduUHJVbUVKS2RwU28zcnQwMVBLQ0pT?=
 =?utf-8?B?aVEyVS9pL3NNTW9ha0JKck04OWdTRXp5bElyaE1PUzd2S0pXdEhwaVpoKzlQ?=
 =?utf-8?B?ck1xZG9JNUpCUzRSZ3J3MWN1Z2w1WEZ1V0R0WTVSdWxMTW9YaDVEbzBaUE0z?=
 =?utf-8?B?d3UyZ0RSVEtQZXFuRUVQeFN0eWxNVkc1dlR6RnVlRHdPRi9xdTNqTVZQaGk1?=
 =?utf-8?B?aG81bUM4L3B1dkUrcjNjc0RXSU0zMEViOGlONEFsblY2TDdKSzdqcXMybE9l?=
 =?utf-8?B?SkVHdEdEa3lzQnl6Y2tzYUx3OThRU0pwTTFSaVl6QnBsMDNuN2ZObVhtcDUx?=
 =?utf-8?B?ZHBIc1gxUFo4RmNFSlZhRU15ZnUvcVVaMk04aGFlRjlqRGJTcXVXbXFOR2pL?=
 =?utf-8?B?WnNEVDFuMlhlU2J3czlURkFKVGpWMUtxOXlyS0VzK0ZSaHlVeDZXUnhOMjVx?=
 =?utf-8?B?K2EydE9GQ28yN1A4NWR1bWlINEk5K2FXYkVzaEljQkNGN0lmMk9VV1FMNnR4?=
 =?utf-8?B?eUxSN3E3SGlFdkJXaEY0ZmMvSFJCbUYrMnFSQlJ4dXg1RTE1UWJ0M21sdzVz?=
 =?utf-8?B?bnpPaWUxODhuZzc1ai9jSnhBZHlEVFR6VmpXbVhZditva2h4RjhkVzBBRStV?=
 =?utf-8?B?RGs1YTBLRUovdm5yYVEzQlc1VDVXOVM0dG50RFo3Yi92RzBiRWY4cXAxUTh1?=
 =?utf-8?B?a2FoMGpxQ2orbUFJMUdTZmFJQTAyTTFnaDgybFJjOXl0Z3NLdGU5K28wUEhB?=
 =?utf-8?B?SHBtS1FiNXJKa3l0b2d5aHd1eDM4ajZGa2I5dlQxaHBuaGtFalVvV3M3RjlX?=
 =?utf-8?B?NTJsMGt5RHdHTnNMR3FtUHpXNkFETWpKSEo3WGZhdCtablQyOStwbFJ4cGQv?=
 =?utf-8?B?TWdhbm1MSVptdFBvVkwzS1NPUUFSdGk0OFU4ZUZlZGl5ZVpHUHIwV2ZQSFo4?=
 =?utf-8?B?ZGVFMCsrNFZ6UG1XQkFYOEFyNUpwMDZEeEdQRjQ5enZocnlYUWdzZlAyaHp0?=
 =?utf-8?B?anFsUGFVSXhiSjdnZUdITlBMbDFaMWhZU2wya3QvdEc5SXQrYXljandmcDMw?=
 =?utf-8?B?VkFiQmpGdklGd09tRHc2R3loUXNwaEdSZUg5ejVibjhCOEwzSUNHTEdlWnFH?=
 =?utf-8?Q?+SyNaNyV3P58eV8G6GsEvS6yZ/brxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlVwQXdOWXZaaWkzb2RCbUw0NmxYVU5Dc1NScXBRY0wzMytpSlZPM2hkaUl2?=
 =?utf-8?B?YnQ0Vk52cEJQbVlZd1BTYXJac3IzQnA4Ry9GdDFwUjBvKzNPN3lIQkE3NzdT?=
 =?utf-8?B?MFhjZmtNNU43WU5KVktwSXBOMktnZ0pMbWtya1NZZExwTnpaRktXS3lNaDRo?=
 =?utf-8?B?QnE5ZlNzbVlCTW1CWHIxNXdFVWxQbTFjcTdyb3lqaHNYN2dNSzdKYjNZdDVl?=
 =?utf-8?B?KzdCMktHOE1oQzBLOHQwRHFxWUVRRDZoWWtXZjJONEpTc3kyeDM1TmpUYVdB?=
 =?utf-8?B?WmN0VWFvSnJnZzg3RmRTRHE0b3lxQStmRGFoc2krUkFkeEZtL01QOG5NdDlh?=
 =?utf-8?B?NVliM2p1YXlFb1VxOGlNS2s2WWROM3ZZb2lvTVlVbGUzczFBbUowbjJFcEtq?=
 =?utf-8?B?T0pOejlwc3kzS2kwZkV1ZnFOTm5wVXdLd0QxTWgvWWwzeWVmK054Y1hnbk1t?=
 =?utf-8?B?S3gwZ1U1NGJEYUlEWHZERmxDOUFmaVpqTXZ3MlptaTRleHJweTNiR09kbUll?=
 =?utf-8?B?ZFB3bHdDVnhiUHRxSHMrRDZWenR1U1ZkWmpxVC9XbFVQNHZ5dXpReDRnUkNh?=
 =?utf-8?B?aTlZYzNlTWJIVW4xdS9HTVllaGt3emp3U2FXbmxXZFYzTExjRFQ2OFZmY0pB?=
 =?utf-8?B?VURJdUdSRENHSjRFKzRTalpTd2pON0NIN2dNUFZYZnhBKzVMVVlxbkdzU2pa?=
 =?utf-8?B?ZkFobkpwcjU1Vkhtcmg5SWZvSmdiSmxvaERGbVVUKys5RFhmZllwV3ZHZFVW?=
 =?utf-8?B?RlRVeFRRSTNVc1NyN1Jud0IvOXpIQVdGQ05MWldEWU9UQlhTSzFXdFFidVVZ?=
 =?utf-8?B?cDlaMG9nYnJuZDgzOUZyTm4ya01iRkg1RzdGV29kS3ZURjNuOHBJSnBrT0dT?=
 =?utf-8?B?NHdrcU5MY2VFaVVUSS9OTlQvdDRscHpaeHVQdmhPREo0MUZDVm9JcTZCdHJQ?=
 =?utf-8?B?cE1SSUd5WGJGZHZNU3VaanI5dTg3eU9JTkd5N0l3QjVsUmZxWksyTDZaVWZk?=
 =?utf-8?B?U25XUUNkWDNJdjlXWlhpVWFoek9PNk1ML3ZHb2J4THNyUzdYZWtMUWtGdlA0?=
 =?utf-8?B?ZEJvRnV3SUx5NHFZdVp3c3MzRGZBdThNWDhTcE1pcVZ2Y1IyMEdDYllTM0ZF?=
 =?utf-8?B?bk1vR2J1aWZpTmt1UGNGTXlMRmxCSm50bUFNRDVydWRmcmFYZVdwM0hTUTF2?=
 =?utf-8?B?OW05ck91RWRvbm80TXVMa0ExZkt0OWl4dFJ1NkJ2TnV2VVpPMDBtMU9JNHFr?=
 =?utf-8?B?SUtZeUpjMG1VcmtCUkYzT1NTQ2RWclM3TncxVk5QUUQzUmx3MUxIcG51NkdW?=
 =?utf-8?B?NktOUE5wOXRFZGVrMFBnZmJxWUpsaXpQcmE3MkR1T0trSnZJMGlLY1hZNmhz?=
 =?utf-8?B?UDBxQzNuMlpjaWtZYkZRVDZ0dGJlQ2lVWlIzUGRNbXlUOEVxU0dsV0w1M2t1?=
 =?utf-8?B?b0c3QzUrTGdPYlBnVjdlWDJsZks4blJJS0pYRlE4T1FsRTF3SjBKdzdLWUFp?=
 =?utf-8?B?SmdtQStKVUptY3VrTXNDUk9QMjRMNlh6UWNzL2N0WS82NHhDOTkxQjJJRmhN?=
 =?utf-8?B?clgya1dQbzNkK2d3RGZSTEd0d1AvU0JndEhWWUI2WFRjN2hZdFFadmRXUnBH?=
 =?utf-8?B?YzRxdk9vMk8vQ055aHhiV3JEYmVBNVpQUC9WaldYSVArbkJaQnlBR3pDQStC?=
 =?utf-8?B?NlhsTklDTkp4RGJMMWRrZmcyWUp4cE9lbjZKNDFWVWM5bklrOW5Sdk52MFQz?=
 =?utf-8?B?V0tiYXhra01ZU2hjZVUxSjZRaXFQaTBtTGlCVmZsbFlDQkRKN0x2OHptNFhv?=
 =?utf-8?B?ZmFWUW9jTFRkT3dOSEVna28zd1BBdnZ6THBYNytwMDUzbWhYWGNWY3c3bEU1?=
 =?utf-8?B?U2dKUVY4TkxjaDZXbmpWTTU3NUViMG95K0Y0dC91SXNGS1pNWGJmTTgvbHVI?=
 =?utf-8?B?OERmSGtIZm1lR2g0eW9JLzZ0T3FmaHVsMHBldWw1bE45QkdWZ3dJUW9qTmI4?=
 =?utf-8?B?T1E3ZHRLeUt4Z3BObXJVaFRCQnY0LzVmbzBUdytTN1Q3N1pVZ2JMYzhTQ2N2?=
 =?utf-8?B?TFRPdzBVM0IySDV2K0FtdlNEQ3dsSnQ3MFJKNDBUcTVsNGFpS0hIRjk5TnJS?=
 =?utf-8?B?QzdVbTZtQzRXd0I2V3F4Y2pKWVdFb1Z2UGZpRFdNV1l0VXpzY0pZcS9kZ0Ft?=
 =?utf-8?Q?cT0B7zKjKC6X8kWGgY3LW6g+5UFIeJcF1A/sYkPazFBu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4590ae1-61b5-4477-49ab-08de2e2386f4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:12:05.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP+MzWUAzMdSPueQZS3mKYoLcjTo0rXZ3gkD5SQJ/Dadj4yYe+oWvn9RzfGPmXpxqhov/uKELFQ7f8VvYifrKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/bits.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
index 553d50265883..2daead125626 100644
--- a/rust/kernel/bits.rs
+++ b/rust/kernel/bits.rs
@@ -27,7 +27,8 @@ pub fn [<checked_bit_ $ty>](n: u32) -> Option<$ty> {
             ///
             /// This version is the default and should be used if `n` is known at
             /// compile time.
-            #[inline]
+            // Always inline to optimize out error path of `build_assert`.
+            #[inline(always)]
             pub const fn [<bit_ $ty>](n: u32) -> $ty {
                 build_assert!(n < <$ty>::BITS);
                 (1 as $ty) << n
@@ -75,7 +76,8 @@ pub fn [<genmask_checked_ $ty>](range: RangeInclusive<u32>) -> Option<$ty> {
             /// This version is the default and should be used if the range is known
             /// at compile time.
             $(#[$genmask_ex])*
-            #[inline]
+            // Always inline to optimize out error path of `build_assert`.
+            #[inline(always)]
             pub const fn [<genmask_ $ty>](range: RangeInclusive<u32>) -> $ty {
                 let start = *range.start();
                 let end = *range.end();

-- 
2.52.0


