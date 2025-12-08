Return-Path: <linux-pm+bounces-39281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977DACABDF4
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 03:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 510D5302B776
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 02:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E94629BD91;
	Mon,  8 Dec 2025 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="obpT2HMy"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71068262D0B;
	Mon,  8 Dec 2025 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162045; cv=fail; b=gu45CVUyC95CIfNgA/HRM263PQ42rVJgibMszb+3SM029oujoCWGw9HugbcUeGVsqIfayZ0dRo0Uv5lShfh6Ivhyx+H5RDaJvgkk66XMSPXYC4zAFzECCi+gen1X+PUGpopMxc5CS5ZrXg8F94BevWDvwA7pOir6FzTcdpel+50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162045; c=relaxed/simple;
	bh=XeZmKTwfYVDXDFcE+6MoD9FmBVLzUZwJq1HFastLWBI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aBtz8ffZP8A7rHMlZdee/96zMgqoPBOnAemXeUfL7zL90lgGJww2ldB1bbIGWX5oDrdT/KPe6skLcZplJVILGvHGoWC76+uFf/V96vEaWtyM68UCTsnafT0D+0+bW1G0uMt5QMkQnsQEBHo41TxMJNqBbVKhbA6c6L8iKsCn0A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=obpT2HMy; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHt8wt+X77hlSGjt3Kx5Bm2yrpr0ZARyBJ6qlBnxWMeFneLW54+6EODEG8Fr2lmEPcZBAFLrnd8fQZERn2Vmq+w3Xb5HOxkwbWY1tmeIHkrxlOEql5pm0IOW+nz93tVlmi3b4xh9ylu6PQuyOqanpd8NoZIXW2oC7u2qwZRqM2wHvraHr7gxVgFmE3Tt16pcSKFMfRVOsC+ccG9HPaQ6UyAheOf8GhtsWbkjTzbanvw3KXWNtJOO8FZdZC7bs/S7VQXZQi+VW6Y7hnglMg880vRBykCjE7LQbWmY0mFGwdnsVYzhwRChQMj/TAJIA8j0gl0GrHiDxGzno7EFJS4CEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bDjS3DsY7kFbzdS7/fbhoUXguH4pCc1JpDTebDNMVY=;
 b=IJTxYm8VvspgR2/ZAspPlmOJkCKCRK9VE+e/kiQ8DjILcbaW/dN5vP06dhMt1E8U6Fxt1gzXZhqxsj/y1CoRz0UhFTSoNmN/RwYTPmJt72E9TLq9vMBVTFuL5YklwR3j/1Fuw7m5JpUEhzYspzvd3o/e/ofxunhTk16x86v+SL9mwkkHA2u8Z16FqLnraZcx0+5u3LXdhIlaoklbOquS6ujjfBFuBuTlBAP+Cu8Gn8GYu1bqJ+iA24EbPWNmB/EDc+1T+tbbhlCaBBBAr/IQZcuZA072VYyjQ7svb4f55fbkMSOT/HTTTaEAW+1e6Y6dZa+srTE5hlcVEUUaEHMXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bDjS3DsY7kFbzdS7/fbhoUXguH4pCc1JpDTebDNMVY=;
 b=obpT2HMyLrIuVzwlPP3wstRLO/7VRLjZtmvAiHdVzNijglDnH3ETCuq8OvjqpfU7bEyrAfscR3ztqGBTF3zrQMCFjsrUelk6pBUSvaIik1zrZiqKcNA4jBY8DXzPhlKkyfxkmDqZaHOOJqymfhBEw5vkL9xbXFetoAX2z2R0w9eI+GQhwlpsvnbfHnJFRAoon/zlQfZJNtxcD2MzVQLR1HS1lT6otR3zE47IR49nwkWBch/06Sz35BW0iuk4XgbSXFmAHR1z0TV6MDb2KT3yxugFVy2/nbmJnHfusNVUU8WtdV8MUMo/ckIUwuCX7JqzFaJZb9sy2F1I6TLrM0ocYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 02:47:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Mon, 8 Dec 2025
 02:47:20 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 08 Dec 2025 11:47:00 +0900
Subject: [PATCH v3 2/7] rust: io: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-io-build-assert-v3-2-98aded02c1ea@nvidia.com>
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
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d41540-71a8-45ad-6672-08de36041b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzgwVExLS09MTzNwamg2Z09VUjBaelIwc0wxaHhDSldZaTgrbmM3ZTFzSjdL?=
 =?utf-8?B?MHB5azVvY1FMTnNDNWYrbTM0SHJIK2JEV3VkWU02Wjc0SGZUNy8zcG5obHgw?=
 =?utf-8?B?U002SlhrUThDdlg1bnBqdTJ2MmNoSGxzczBUL0E2SWp4Vmh3d0djc1pHbVFW?=
 =?utf-8?B?akhMcTY1OStQMUxxUmsybmk4OUs5OVA3OHh4citmZVRrdzRYcTAvYXY4RGhy?=
 =?utf-8?B?N2dLWkp2Y0V2Qm9jQ2w4WDNobkI3L3lMRm1vbkVIaFNxM1IrUGhGb0pmTTBF?=
 =?utf-8?B?Qm42L2taUkpxNEVSVkhpd25jVGhWblByM3NIMm5GMUtVcDB5NWZiNHVzVkUy?=
 =?utf-8?B?MXE5cDlDSkRrZG9ZSmwvRTFsRzhQWFl5aE56SDc4b1pwK2s0aWF0MENqMkQ3?=
 =?utf-8?B?S3Y2a3IyWmtCdGNCRTJMa1FBNjRJNTVWMkJyeFJxeVhzcW1yUnpXcDhneDBR?=
 =?utf-8?B?U1JlU0ZidmZPWHZSQ2I0MkI4QzNHaXpqdGw3YmhVMnBkSEpaVzgyczlhWkNU?=
 =?utf-8?B?amxmQ3FadWVOVnBJekxaUGxINTV5VzFCeklrR1JFaFdlaTRiTHM0MXpvVkkz?=
 =?utf-8?B?UlFETmdyYUsyUGdKTkFiT0U1UHh5ZG9zRnpnQVFYeDl6c3JzSThFaHVLRHpy?=
 =?utf-8?B?TFBkUll0dlFsREF5QnlaOExHckRoejMxRWhJR252OGx3T2txY2pNNStNNlR6?=
 =?utf-8?B?QkowQTY3VG1IQkVROGs1WWZQSEI5L3A5Y1FCcnUzWGhuSjF2Z0RIR25CdUlF?=
 =?utf-8?B?ZEMxWDRjeGtBUjN4QS9hQ0h0WDRGZFRkRjgxdFQ0eXVvOCttK0pMS2pPOTNz?=
 =?utf-8?B?dnNKajEybUhxcDlEdlc5b2VLc1JBTDJITDBwR1pXdElXRk40L3VLOWZXbzBI?=
 =?utf-8?B?eVlXM2NWOWJOcktOakZLUDdIYnF0ZVZiWUk2T0JUdHkzekJ6QitiY2c1NFB1?=
 =?utf-8?B?TVNQbkFnUko4LzZObVhRWFVkT1oxejh2S1l5Vk1Lak54RHR0VFBVa0J5U2dE?=
 =?utf-8?B?T3BncGljYlRIV1ZGcHUxZWlxUUU5a2NnV21rK2FkS290L3QyVzU4ZUJTU3cv?=
 =?utf-8?B?Y1BqZFlqbCt0TEorU3pjcU5ZVFRwOEwvTDZZc3BGdmVGVmNMY2NWN0RNWWVh?=
 =?utf-8?B?bmJKUCtoSFlhZkVKNVlxbHdadmZpTHczaC96eUpJNEF2bFNxOXJjbXlXSmRy?=
 =?utf-8?B?UGcrcUtSTlp0QnhZem1IYVEvY2lSV0Zwc3FjQ21CQU8yMkpkUitvL21Zalgz?=
 =?utf-8?B?UkpSZWM4UERldzViNnhObUwwWmpVeWRLeDc5cENMaUxqQkErMEpiWnVuMDEx?=
 =?utf-8?B?NC9xYjl0VHdIcmZiQmZFNGdSZzlMZW9LOUFlRHpaRzFDd09menoyVXpPcmRK?=
 =?utf-8?B?QnAxbHo3MFh0dkhIMXRPRjhxNEU0blM3YlFTVFl3cnNudU5xV2hYZldEUWV2?=
 =?utf-8?B?TWk0a1dBZ1dqcE1UczNkZlMwSmJmKzBNQmN3bnNlSWR0STMyYUxlMDZVL00r?=
 =?utf-8?B?RGpYYmdwTEpuZFVsZ2JrQ09kK3F4TVhXNm8xSUMxdDZiajlJUWFCY0x4Umdq?=
 =?utf-8?B?VDdSU3VmbCt1aVdIMEtpaHRQNGs5NytNM3FVUlBaMDY4aXh5WHIrVkNmbE9Q?=
 =?utf-8?B?L09Ea3ZsNmR0SmNvUmNvNEFVbHhKaWFyb05YQmR2bndpUktOamliZXQ0R0d3?=
 =?utf-8?B?ZTVvS2lrNkpvTWwwdjhxZUw2R2t1T3NhN0lFQ2dhR0J6ZTh1Q3Z3TWVNMTdp?=
 =?utf-8?B?Q1JUU0twNWNvenZjaU9sR2krTldWYjZubVJRVFE3T0V0a0w2T1Frb1BkRGJ2?=
 =?utf-8?B?RmRmbzBNQ1FTNVhMa2YvaUNEZWNXY0J1Y0pDSlhTelpQUUFDKzkwdW1VQnd0?=
 =?utf-8?B?MUhhQ0taazZiRTF6bUdQaHB2bWNQYlBWT3AzdDh6aWY1Z3dGVDQ5bFJwYnYx?=
 =?utf-8?B?ZVppN3RXVkVMZkVwZTltOVQ2Uzk5WjVUY1FnUjM0c1BQTjVLYnNZcmxQNGRQ?=
 =?utf-8?Q?YPTMt1ZwLcRtGFTxMzsB/ZB1XLXxtM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWR3N3BBcTV1ZUt6YlErTzVuY0hXUmNUUmpOVnk2R0poaGFkOTdhbWhYKzhZ?=
 =?utf-8?B?ZHFNWGRqeTErbkhlcml2UnV4M3B4d3lWcHRMZlJqTXNQT0RNd0ZBaldIWVox?=
 =?utf-8?B?eTYvTHFKL2poUUNBUWI0YXUydmlrYXdCNGFyVUJKK1BnK1NMS1dEd0VYVjNy?=
 =?utf-8?B?eGovMzhzQTBNcSs1R2dHajY2M2VvM0g1N01oTi9RYSswVWcxZG5SWXV0d1c2?=
 =?utf-8?B?M2dpYjJPUXRkaU80VHp4RjBiR3pIYlB2akMvd1pnQ3l1bDNxeGh3Vk1IWENZ?=
 =?utf-8?B?RWIzYjV2RTJmS3Y5WWIvbGhpL29HODNvbmRudFZJejdST3VtL0taaTBiU2Uy?=
 =?utf-8?B?U1QwQXgzR3BSNTNSTndzUEpjbG1CZ1lMSUZEdEtrOTZzdCtyMlBDdVBJL2RE?=
 =?utf-8?B?SXNnZHZwNVZQWTI2VEp1eHlWWXlMNFFpaDEwMkRMTlArc3l0OVJYRTVpVDNn?=
 =?utf-8?B?N0dtdzhVMVBYM0g0SGpGQ3QrM1ovbGo5bERaT1ppYUNncHhNQ2lVTmVuQVhT?=
 =?utf-8?B?bWs5cWpsMGRVdmRSMVNtaWcvcFRyNXVjRjQ5ekxzNEEvcEIxVWR1OWlRbFJo?=
 =?utf-8?B?RExPSSttK2pZVndEUWxqbmN0M0xYUlRISldVMUlNODdHeTlYenRwQUNkY2xv?=
 =?utf-8?B?RDk2SGk2TkptNkUvU1kxWklGcmwyRmRKTldqc00wbUREcXZzMHh5YXVyMDh5?=
 =?utf-8?B?TzEzK01iYlFRNm44SEZ6eEpMTTZjd2xjRWpXWTd5VDluKzN2UlVTQlVGYnZh?=
 =?utf-8?B?TXpPR0RHMHp3ZkR1bnF6WWs3OEh5OHg5SjNMMkdXTWdpenVjKzVsZnpjWnFz?=
 =?utf-8?B?cm5SUEsxd0owNmtwQWU5SnZ0bXV5RFBJRVlJWStJY21hbU02dmdBVWRGYVd2?=
 =?utf-8?B?ZjdkdlNsdHEyMmlyU05WbVFtUXFKVkJoaE0yWldIa1NGUE4weS8yN09QeFlz?=
 =?utf-8?B?bStiK3Z3eEdHQ0Y1bjBIKy8vSzZ2VlBTL3VzZ1BkNXdrV2l2Uk1sOHRGM2Nz?=
 =?utf-8?B?b3p3ZTRWNGhPc2loRW5vci84dlZvWDF0cnhzV2tjL3hsaThYWE8vSmhaL3FB?=
 =?utf-8?B?SXFDRTIxSHlLVWMyR3grU3VtWUlMd2JRK1Z1cDdtMDdtOXJjeUd1UzJWSXN4?=
 =?utf-8?B?SlJaYmVNMThaZXk0clpXMnpJWElwbStMdDcrZHdHS1MyRm5nR3JMamt0M3Ux?=
 =?utf-8?B?WkdzS3o5ekduYmJuSldyRkFndWRFODZUdFFPTGVVelR6KzRZbzlqTkIvZEQ2?=
 =?utf-8?B?UDZ5RFpXbEtPVlZZY1lsMVh0OXNvUit6R0loUGx1VFdVRGNxbEpXcWtzazJB?=
 =?utf-8?B?RXRKOVg4QklqcktPRldOUEg2WWlvODlkb1prTG8vTzVnZllMczZnRngvcnoz?=
 =?utf-8?B?Vk54U3dJcGticXpJaTJoWHM0VjFXclUydSt3VUVFRE9zVXpWOE50S002NVc0?=
 =?utf-8?B?dCt5ZS8zMTJMcjU1Q3ZPazlwQmtwc2Z5Q3haby8wRmdYMUFkZkJSYlB5UDhE?=
 =?utf-8?B?UWUyTkVQU2xQYzlUM2pOQmRqKzdoVUZINHQ1eVJVMGJlV2N0VERkbTU1S0ZX?=
 =?utf-8?B?S3hVR2x3aWJ1RFE2anhRYlU0WlVJd3JBMzdzZVBSdXFUUWZ1L0xHTUZ1cnlq?=
 =?utf-8?B?MnYzdUZ6V2dPUlpoaTVTWUE4SjNaK2UzQ2lXdnRsQkVIR3FXd1lHOVNtUTE5?=
 =?utf-8?B?TDcvMkpEZjhVM2dvWktOaFRHTmZMNXhOeW1BZURxeGpRbWQ1S0pqWFhKbjla?=
 =?utf-8?B?RlNZVjhhMUpsUE8raTdNV1NIL2MvY1U0d3JSMkY5M1dlS3FiOGxWVkJkcUxm?=
 =?utf-8?B?Q0VnV1VyalN3Z1prRVlmMldDNSt5bXNURGNUUjBpbnd4VEhOaW5saVowcmlu?=
 =?utf-8?B?NHN4OUl4bGNCVURNQTdob2xmRm9yN3d3Q0plV0hXMzFWMDJSV04rMVZ6bDRx?=
 =?utf-8?B?Z3JYZXlVdnlRM2czOGE4RDlRTUtDeEl5Wk5QS3pidlVJWGFnZEZweVVkc1FE?=
 =?utf-8?B?UVBSRkMrNWQwdUVvZThkVmRsQmgxc3BYYXlhRVNqOVIzV0p6R3FjM3VRV1c0?=
 =?utf-8?B?YTMzSVZRSm13ZXl3THk0Q1dObUxHUXVjNU1tc2FVaEkwWDdHejZjMHVhRGpY?=
 =?utf-8?B?OHFFR29JLzJhQ2trbzlaMDlWc2lSZUVubXBIZnZkRjhSamRXQ2Joc1AxQ3ZV?=
 =?utf-8?Q?BWzJp3VyNPS1YrVOdNVzi/E+4GoPfSo5BjIRwscfr7Ut?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d41540-71a8-45ad-6672-08de36041b80
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 02:47:20.3426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDeGZutillwiHgLh6qQgV8EnBDm0Nmuik6ySkvT24qdrtKXIWXsSbdAPqPULNt+iQB+xvD3zdexpLPQtUofQMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Cc: stable@vger.kernel.org
Fixes: ce30d94e6855 ("rust: add `io::{Io, IoRaw}` base types")
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs          | 9 ++++++---
 rust/kernel/io/resource.rs | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 98e8b84e68d1..b64b11f75a35 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -142,7 +142,8 @@ macro_rules! define_read {
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
-        #[inline]
+        // Always inline to optimize out error path of `io_addr_assert`.
+        #[inline(always)]
         pub fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
@@ -171,7 +172,8 @@ macro_rules! define_write {
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
-        #[inline]
+        // Always inline to optimize out error path of `io_addr_assert`.
+        #[inline(always)]
         pub fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
@@ -239,7 +241,8 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         self.addr().checked_add(offset).ok_or(EINVAL)
     }
 
-    #[inline]
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
         build_assert!(Self::offset_valid::<U>(offset, SIZE));
 
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index 56cfde97ce87..b7ac9faf141d 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -226,6 +226,8 @@ impl Flags {
     /// Resource represents a memory region that must be ioremaped using `ioremap_np`.
     pub const IORESOURCE_MEM_NONPOSTED: Flags = Flags::new(bindings::IORESOURCE_MEM_NONPOSTED);
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn new(value: u32) -> Self {
         crate::build_assert!(value as u64 <= c_ulong::MAX as u64);
         Flags(value as c_ulong)

-- 
2.52.0


