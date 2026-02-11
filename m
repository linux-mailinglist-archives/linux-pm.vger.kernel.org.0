Return-Path: <linux-pm+bounces-42478-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 63bZNI/Ni2mLbQAAu9opvQ
	(envelope-from <linux-pm+bounces-42478-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 01:30:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E354120509
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 01:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23D83304A23E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE91F91F6;
	Wed, 11 Feb 2026 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hK46hl/E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zsKoFgCH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7321D5146;
	Wed, 11 Feb 2026 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770769803; cv=fail; b=VdP9n2xU6UMKzimOapeutj8ByuUkA6UCzajiiCgsTtlSgInKVE0zKMe8YvrdvaFovG6XqNBGZwWS7eoEJpsqjwZ0BkGxu8Nc/vuIAp4uqtYw2C29MxC79SzZkk4DfPieOFsWa6I2rArR8P+486/+VkK9ush+9jDZjVzQvzpNvKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770769803; c=relaxed/simple;
	bh=amN8bUgEmrarfPWEs+xTCMmPUgfmGNvhOxT4T5VFy+0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=I2tyr25cw4LoedFn/AbtaHQ85Ekl77L4xNFfY7hHcw8vqNuTKt105X96oa02q7oynVOjMW88AyLLSwpjeOyDLjUHTzbHBuM9toOiokRswasjx154ijPuwD83L6ueyFK5/0+qdp5G6hrh4yVnxHLOvvOvPcrvGTg1DxRiY5DbPOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hK46hl/E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zsKoFgCH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AIgfZY3998387;
	Wed, 11 Feb 2026 00:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d7qUjzibAohKfAl1HF+uw5VSxje5VieOfFWjBea6TLs=; b=
	hK46hl/E6AtM/b29yLAvolqEp7bE0BcQ8Xu/UqxZOdAeaWmjEoacNHXOxQ8opz6Y
	x/kWZLUCHYBUgGp0KBZa8eCWqPGZnWCEyzaCtFh/WuxtYUnto8ygUAE+6x5sM/Xb
	/MVolmCp5m0g5TinTzxQYAKmlbfqNY+49dRhgEJbilBLlpAYQv5QW8Md1GVZGErE
	VI8S3v/ikUwrsmC0rqtpgaPRS/O00ZWb634TY3R+wqXGMDzlcLvEzh0ycR4I0PTg
	F5nGae6Kh6msZ9/4ixGMq76j0edPj9XHsQ3RnMkCGR03w2FNtVpIqy3uE0q/uXTG
	3L2oslv9ckFdEEtBtX5sxw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xfp55wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 00:29:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61ANtpLE033832;
	Wed, 11 Feb 2026 00:29:26 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c8245m1ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 00:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gh6wBkzL/K7Jgbl+DjMGGhnVNgiwbII/GxBSy+b2qoe3HQqOxL+Y08EZBYgF78BsSxghduDwnJBoYKrR/jyQm89Bodlz5kOM4FMdi2j5isFiyVVY10e1iAq0lQVH82TFsKNiO38UybAE8duHiNlCAXBQHAnJwof9NokLzZgP5lmgINg45f5qGbKzdnKPhDVRqSk2DtNPDztqHQO4h9/bCH09qNP97LYDs6XOIhMlv4nHscxF5cQyoaXowAQKRd1EsFZ7fGz3o27VXMuJAXh80h+2rkdQlx0p2PGPM0RNAvATvxA9ObjxAMks/Xl2QRQDO9UxzBE2zvM2E4lksFtlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7qUjzibAohKfAl1HF+uw5VSxje5VieOfFWjBea6TLs=;
 b=WnkjEPjt+279lPpAdLVkUg3sNW48Io0OufEDtonuTmKdg0zewGNNbwjOsg+1SMyYp+Xy36Qdl0vQMdxvyvI/ZwgkDA0FHQt1T6hKjCeh0Kta03+gviUg0K13WjCimqmIkBNEcsr/LLaPm9bfOjXxxR2BvcgZrNMZMQlo9syU4T/HEheQ8U5e/lt1rsqIJlhRc4brS9+FcZtEU5PVMdgRhAHFXKK9HbT8XJFAWB6ueoa6DIGpG1WNitw1tL2/OthKTEYuUw57kmfgckaK/lQenzzPb64EFBaO7ksAmrpvV11HeO+y80OUjDfXpVvRLUuCXnAoxdxnc44AAYsPvO8rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7qUjzibAohKfAl1HF+uw5VSxje5VieOfFWjBea6TLs=;
 b=zsKoFgCHhDHfIcwHwmJxvL0BHek2b4RU7TjFcnurhjptwqAfQdL9/OCc+X+wvd6eJa3q/JUGd+K7ZKVx6LH90tQiAvxnZJ30DC0ng/YkFT1RB8StA8GxzYLscGOIRewuuIawxu05GfC36WxoPKykNq0vR6AkaLo7H4JR5XHwOzY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Wed, 11 Feb
 2026 00:29:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 00:29:22 +0000
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-13-ankur.a.arora@oracle.com>
 <CAJZ5v0j_iXcbsOpkEFN=Qy0UMpa73eVfLLM42mNpx2E6JD1zHw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v9 12/12] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
In-reply-to: <CAJZ5v0j_iXcbsOpkEFN=Qy0UMpa73eVfLLM42mNpx2E6JD1zHw@mail.gmail.com>
Date: Tue, 10 Feb 2026 16:29:21 -0800
Message-ID: <87tsvo9l7i.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 382420e2-0140-462b-adb8-08de69049a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2tkcTJsVUJ1anZlYW1YcnlLdGhPd3JEV3lYRmJpY21EQm5NaGNUVTJQTS9z?=
 =?utf-8?B?YzdXbUNIeDhhVzU3TUp4RGxWaWVvNWJMOWp6K01MaU1CUE9FdEtZR0lxdWNh?=
 =?utf-8?B?K1Z2c0Z2UEw0bEIvWG1mY09YU1NvR3VOU3phdDNzTXhYVzA3WmhJaEIzL1d2?=
 =?utf-8?B?MEJwMHRFYWluUXZwTEg4WmxxQThWdHVjL3R0M0l1MExFT3ZRdlFIM1o0Zlpw?=
 =?utf-8?B?L0F6a3dLOTNRS2FFazFtanJGazh3VHpDUmtZVGtIb2l3OWVDZDJLd0R1M3Az?=
 =?utf-8?B?RzIvWEtxNTBieEc3UzFBa3J1RHNQQmRGaWR1OWl4S3JrMFBPNW5OcmUxYTNW?=
 =?utf-8?B?TFhFc29kWExqVWRMREdMOUdheitVY3laYTgzcTNIWFR5UTVoaDhSWVZ0VGNs?=
 =?utf-8?B?QUllSzFaOGh2TkFaQ0IrdEtCL3N3Y0lwcjk0NUlHcmVTK2tLanhacEgvYllx?=
 =?utf-8?B?YURJd2J5UjZqT1lhL012cXF0bnBzREp4SEZETnh3YU5UTi9Ncnc1YllDRDJN?=
 =?utf-8?B?Q2hXNWl3QnQwTjFQWVQ2K1JJOE5xTkRSZTlKajR6MHNBTnJIOXQwNjNPTWd0?=
 =?utf-8?B?OFdLb1Rid2pZYTJsZlZZekF0TUk2THFQa1FQUnlEU0pza2EzVTY4ZG9Zc011?=
 =?utf-8?B?dlhVLzZwdlFpSG5JVmNJY3MrNm5oNE94UEVnalB0bW1LMzk0VVFKYWRsY0VY?=
 =?utf-8?B?VGZnbFk5ei9oODVHdXAzSjB5SS9uaUlQZy9WRXNyQ2FvbEJrTmdQY1ZTbDAv?=
 =?utf-8?B?N05PdHNUVGkzV0U2Vis4YjgvaVBHVDJPZDIzRkxxaVE4Ti9wQWdqWmM0eUxz?=
 =?utf-8?B?Qm9rN3RCK3R1LzB6aVJKaWhBN3RCTkRGaHQ3NjBqQ2t0QVNUb3g4cXpzc21w?=
 =?utf-8?B?L3FFb3d0NHZNcjhNdldrMGE4VjZhOUc2cWduaURRdWUrZU1WMUEyVktJWVVY?=
 =?utf-8?B?Y1J4bVZGRDM2bkJZdkVCQk5Kd2tidjFIM0dmS1J6WGNIbW5iNWthUEF2Wmx2?=
 =?utf-8?B?UmU4dnFTZkIwQ0lCQmhRankzdkhMR09uMVF2MFdXbUJHOE4vb2RNbkFVMnd1?=
 =?utf-8?B?VWFubUpaSHJVSDVwT2RZZ1M5RnZnaEF1MXI2RFloSUJmZTZRVkZUZ2xBeGRY?=
 =?utf-8?B?dVNaczRubWVUMTRNYkxoYnJzY0NwWnR1TVBtYVJwazdROEp6WURvOGNvNDZJ?=
 =?utf-8?B?WUpqTTluQlRRbFdKYi93eDhlKzNoMkVlaE51OTRWVXQ0M3UrQ1FpZERLQkZu?=
 =?utf-8?B?ZDVLRm4yb3ZmYXdUR0tRV0J1VzZsWENSaTl3a2N5WEZzb0phQUtlV2pRa0FP?=
 =?utf-8?B?Y1F6MWhWZGdvWHNBaFNpRHpCL1BqU3VmV0E3ZXZlR2tRWVhWclhIaDBiT0cw?=
 =?utf-8?B?eEpoMGhXSjRDbnNYc1VUNjZkMnBCa2RJYnBzUmxNYTgwcmduZG9HSWp1aWZO?=
 =?utf-8?B?SjhHL3d6Q09uVG4zR3VQYmdiR1dlek9rKzRrc0k2VTRwbWRNZkVkZ1hsVTFC?=
 =?utf-8?B?NUdmZHdDazRPSlNaZ256V21mbHo3SkdEcnBKYXpkWEN1WDRzM3MxZ1lrK1d5?=
 =?utf-8?B?WXAvZjVDYkswSW1kVUdmV0hReEJDOXI2Z3lZdDdTZFgrRzRiL055S2x3K05p?=
 =?utf-8?B?ZThJWW5ia0dWa25BYXYwd25hUUZnL0hHcmVnbHRBQkJjWndLdkdZSmo1a2hY?=
 =?utf-8?B?Zk9PUEozZ1JzYkZqY0owNVVscWJkbXZmK1E3RmwyQTgrL2N5VkVQTHVlNVl0?=
 =?utf-8?B?anZUZTZIeEJtU1NEdXZTSFZVeVF2N2xuSmkwVmJUN2JZRXl4cE9RcmhPazVx?=
 =?utf-8?B?YTloQ1JGYVFwbS8wRDZ0Z2wyRUtRZE5YbWNuYVdtSGNnOVRoR0JXWFY5Rk1w?=
 =?utf-8?B?VUJRWUIxTzNkQWFoMjE5aVNpRGZ6R3VwYURNTnhQcERxOFZsUTJreldNNk1h?=
 =?utf-8?B?elExdzd6YVIwMTdDK2FJUzlFTlV1akw0WnBTK3p5SUJ0Si9TZ3JmRCtMQ1hR?=
 =?utf-8?B?ZTdKQU52WW1IV3U2UzZPTEZsMnYxeU5Yd3NEc01KZnBYaGtybUN5MWJObmZQ?=
 =?utf-8?B?MDBCRUZzVEo5cXFuQ1JTakRldzBEK0dGQWlkT0xyZExrZmxabXlENFY5TkEw?=
 =?utf-8?Q?yTtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm55S2tTYk9iUTUwQWxpamJaS2tKQjFReVVzbnp2eFBuOWEybFRkMjIzSGtH?=
 =?utf-8?B?aTRuakpwUSt2RmFhZ2JsbXg4aUNCcWVnd0dES3dXVUFvRG1RR1JGOVd4c3Uw?=
 =?utf-8?B?WWsvVDF2dWxQOXRwNkx3QkRFbjhQYzVzbUdub0pjdjJKZm5qbm5xdVNsMXVt?=
 =?utf-8?B?eFprSEZVOStzbjNuMkRGc29OU0tueU9hNjVVRnNZVzBGRjdZVkFFOEJ6NWM5?=
 =?utf-8?B?RDZsUlJWV3B2THRRWGJsWWU1M1NVZFdmcW9IRmVhckhIVmR6V25EOStqNUZH?=
 =?utf-8?B?YjNPTWZ2UkFBL0ZoSng3Qk5wQkZzbG9hM3JPME1YVEhyTHcyRGxtS2hoUUFh?=
 =?utf-8?B?NUxtenN3UHBNK0xDbFJ4WUU3K1c5V2t1cm9iQkh6ODFRcElTWC91djJKdVdD?=
 =?utf-8?B?dWxkSGhwUWtTQmwxM3liUDVjV2Z4ekh5UWlTUDAvclV1cWs0Z0JKNkRGeVdu?=
 =?utf-8?B?V1U5NnBOODJWNVNHSm13RldLZlNuQlN2VUVVUTIyRXdlUDJCQzlreEVucyts?=
 =?utf-8?B?MldORDJmbzRMK0l3K3BuVEsrQ04xTzRZUEdsRjhySytMNG1URmlhbHI5VlJC?=
 =?utf-8?B?am10K1hBS0tQMWZHY080ai8xVEswRGNweUJiK3RpOFBnbXVhYy9va25ySlkv?=
 =?utf-8?B?SnA5dldIZEgxK2VxSThYZERuWlpSOUR1aWRHcVJqeGhCaGJYU2NpRDB5ampN?=
 =?utf-8?B?a2pISEp0bEhwZ1NqbUk2Wk9LcDRGUTM2VTRkSEIvSXdFc2xkajkwNlRXbkRn?=
 =?utf-8?B?TkxISkxRVFRaczM3RGxpMnZPclh0T2NsWDhzQjRka0xDNnNSNi9jUXRYcHFw?=
 =?utf-8?B?TlhHcFBuMlNFUXM2RWtrRXNkZUpYbktQWDd6MGZmRjB0NCtyZGJyQWJBRmR3?=
 =?utf-8?B?WjhmL0t2NVJtTGhHY2ZrcW5FQ3hhTzVpSmlmU2l1eXM5aXRQTmxGd3hiWTRL?=
 =?utf-8?B?K0hSelBVbVJQc0Y2ZXJPMTBaY3Rqd1huR0VwS3FGWnJEYkxaRTVSbkpOVWZU?=
 =?utf-8?B?ZkNCOE01Tzl2a3NVU1lWZVBUK1hBR004dW10dW5oTEJhY1FicFVndkZ5bmNM?=
 =?utf-8?B?Vmh5Qitna0k4WTVScjVVd2JaWWtEUEh6a3ZQYnR1cU8zeWRRcStrOFVmbG9P?=
 =?utf-8?B?Y2hHalZrSnY1R2ZLYWJEejZBTzQ4aXV5QVhqTmExd3BSWmo5MDNTM1ZrR0NI?=
 =?utf-8?B?ZUFYZysyQ0dQR0w4SGJkSTFseERFUTQ3V1N1U0FBR2VudWV4VnNoMlFGZ1dE?=
 =?utf-8?B?UmVUZ1BPTVhLbFJwaWkzQUxGRytuejROU2xxT2lnV2J4dUhFZC91Wm9lM2Vv?=
 =?utf-8?B?TXhYcUJqZnVSVGRuT2l3UE1YVjdRTmZCRVh0RXJEYzdOTTZpb2JUR3Blc2V1?=
 =?utf-8?B?WmpuZ1Y5YWx1dmZobmNidlJ0M3FxNGtLSmlQVWsrNC9BVDhENUdNU3RLZ3Qx?=
 =?utf-8?B?cE9WL0hZODlWNFRpTWhZMkVkVFBHZDVMWHBObHAvcUs1djg4Z2VtUnV0OVg4?=
 =?utf-8?B?di90MUJ2TzBwc1FvM3VxSWROeTFHTmwrbnFsNTErY0RVQW82SzVzR1dXTGpF?=
 =?utf-8?B?aW5aYldJT2JicFpLcnRMemo5S0pNY0NaU2YrVDlMRjFrUFdGRURENnBFWThy?=
 =?utf-8?B?VUhlOFVWTC8xS0taalVibHBlc2oyOW5ISnpOamVpcFlCODVxeGIrZjJOeERF?=
 =?utf-8?B?S2U1MmtRZTNHVTJnOHo3M3dTRlllNGRQblpwZmxGTGRSQWJSVUZ4N09kQTM0?=
 =?utf-8?B?eUlMVGVUTk9RUm5NdzVJdkY5dEhDWlBLT3pxZEsxK0VVRHdkRGYvTHUyQTVQ?=
 =?utf-8?B?YWpCa3BuYXFrZjlCTkd5OXozN09MbDZmZmlOVklobTNLTndmbUE5bS9MUnpv?=
 =?utf-8?B?UlJvd0Zsc2dYZWM4ME5zVUZhTHl4R2QveHlvU21LVTJzZXFFNG0ydGJFWVND?=
 =?utf-8?B?a0srUFNUM0FzQUlwODBPeGpITGcyRk11eFMxVEtIbmJTcFRQcUFQZUxuY2Iv?=
 =?utf-8?B?QjBabldsUlhDZ2krRGIvcXBTeXBBRktKY2RhWE9vZnVUNnJEUEpzVnR6RGh5?=
 =?utf-8?B?SG9JbktFeWk5MlFPd3Bodk5qTEF5TmRXYzdoYkVJZDdOTWZ3Z0V2M0piMzdC?=
 =?utf-8?B?b0lzaUVZdDNPNWFUei9Pekg4Zkx4dXMvM2xnVG5DbXpMbkRYR29sZkk4bndk?=
 =?utf-8?B?bmVPUm56RXJDZCsxTFcrVXFQV1ZzenVXYjN5QUY1a25rV0svKzl6bWl6Y2JU?=
 =?utf-8?B?OHVNNDVZQm1oWFdibERwZHNuL2hNaGI3UWtqRGdISkxkV296SmNuOTVkNWVa?=
 =?utf-8?B?Tlc5TjR3Y3AvRkVZNEJLcHdkV1pKcm1yVDRVSU5FczU5UEM1UkNsTW5yVzlk?=
 =?utf-8?Q?vDvYRICgO1+9LgJc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	llbrpJq9/dDKUGtFJPDxiRavNqExCvV6nWLl65x7/X6utdoHy4+Xe8ZQVY95rIKoZgPFv2WbtC/PD6Z+poCjtars2CpoWIcoPdIDls1OgSgqRlUN/5njTWNw99SpRYjQiD83HO+BEuvCaTXU+N2V0Lx7gkiDrd+WsRQxzCHknMEVKyN/FrF1J5tll1G8GIjkZm7zg3kmX5scUee5KzP8IvdL6ScPSJNGz8TuSWzya/6knYrwb7gajGaD933s3VAWRv0WYrgeE0Th3URwh/t341zSdL6bNL+dRTBRwSFwTguKAUISENlEpXxr9yshfErkBv96ZwdicApI8kKq8cWqu8iiY9IXj1jJAQAsx/TQFH0wMvJqCBmDea0wb6xfbjnJZhlwWIswWnPXvUwbCwho5MT2lpgw5HZKoN8j+dTjktDx1GeG7+hJrz3jGKZvP2OjkhPhimLDRTO9Y/zpl6DoFBPSjbxHE1k+9FtaFgM++cdbiQws8EdiuBipDkc9CA9893/7qRkC5M2loGDknhzngpPURfGzgFTqWITC8CSoPzwlCYEOULBmSgWB5SJDyZqtCo3oBPV6P7fAOSnAjvofgOla3UC6m5z58Dg4D8sjyxk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382420e2-0140-462b-adb8-08de69049a7a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 00:29:22.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SFeYpSZKNQe1H6xaylLr9eseHtfKX8PQx7Vb5kmt4RKb+ZnB9hwK3+zCXFe6WR9JZRcqI4AB2u19vf1VK/64Q2hEnsPgqv4NoIKRQepDHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602110002
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDAwMiBTYWx0ZWRfX2bS11HOVzhL4
 Yw1yK+yUFDGLnGPluq8jnHuHmCGXMOcE5ENJPBzfIB8xklobMremBlNQgt69yqzqAdabLXcdNa6
 t0+g0wq9xPUuz++xl45ylR45noQxo03ri4/zxII9RXBXc+FJ0+CKGXAbzIuXQorzroRAQwtt9uL
 YApdlwajI9JP7TXwgZsb6h+sKX9sapxqUji0RTYfIC3xUosAhwvbksMA5JZ/w3KHi66vlFh2TZV
 R5rhhcSVlqOhsncvpOyfAsforeLQbbhol7ke9pbJUXuPhbfiqYPmPOP073IC+j2y1SWnxZbE1ON
 T5Pe4KIZEFepuLW/9oRtyQtw90eUZwOrw42tOa9NduZbzauGY9EkSjFgMuO32lq2eScM6mBYPSz
 PfdX8ZzOgLf5sBl3M8wzXyyCLV4qIzTt7WDQ/BmqsuH/EbMlt6KCBHc/KUWrtLUS3tA1ImfXcag
 Nr2lXuMrJby88FVQO0Q==
X-Proofpoint-GUID: cEVOE2nT5ahYA3QyrgF_OAkB-uMKYba8
X-Authority-Analysis: v=2.4 cv=V8xwEOni c=1 sm=1 tr=0 ts=698bcd68 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=WsHKUha7AAAA:8 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=1XqOqngrLJJGFVTj8BQA:9
 a=QEXdDO2ut3YA:10 a=H4LAKuo8djmI0KOkngUh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cEVOE2nT5ahYA3QyrgF_OAkB-uMKYba8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42478-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.infradead.org,arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6E354120509
X-Rspamd-Action: no action


Hi Peter,

Could you look tif_need_resched_relaxed_wait() and see if the interface
(and the implementation via smp_cond_load_relaxed_timeout() -- patch-11
in this series, with smp_cond_load_relaxed_timeout() itself being the
patch-1 in the series) seems okay to you.

And just a little bit of history on the interface. You had suggested using
smp_cond_load_relaxed() way back
(https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kic=
ks-ass.net/)
when we were trying to use poll_idle() on arm64. That eventually became
smp_cond_load_relaxed_timeout() and then Rafael suggested this interface
abstracting out all the non idle related details.

Rafael J. Wysocki <rafael@kernel.org> writes:

> On Mon, Feb 9, 2026 at 3:43=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle.=
com> wrote:
>>
>> The inner loop in poll_idle() polls over the thread_info flags,
>> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
>> exits once the condition is met, or if the poll time limit has
>> been exceeded.
>>
>> To minimize the number of instructions executed in each iteration,
>> the time check is rate-limited. In addition, each loop iteration
>> executes cpu_relax() which on certain platforms provides a hint to
>> the pipeline that the loop busy-waits, allowing the processor to
>> reduce power consumption.
>>
>> Switch over to tif_need_resched_relaxed_wait() instead, since that
>> provides exactly that.
>>
>> However, since we want to minimize power consumption in idle, building
>> of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
>> as that serves as an indicator that the platform supports an optimized
>> version of tif_need_resched_relaxed_wait() (via
>> smp_cond_load_acquire_timeout()).
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> This is generally fine with me, of course depending on how
> tif_need_resched_relaxed_wait() will work, so conditional on reaching
> an agreement with the arch and scheduler folks feel free to add
>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Excellent. Thanks Rafael.


Ankur

> to this one.
>
>> ---
>> Notes:
>>   - get rid of unnecessary variable assignments, casts etc
>>
>>  drivers/cpuidle/poll_state.c | 21 +--------------------
>>  1 file changed, 1 insertion(+), 20 deletions(-)
>>
>> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
>> index c7524e4c522a..7443b3e971ba 100644
>> --- a/drivers/cpuidle/poll_state.c
>> +++ b/drivers/cpuidle/poll_state.c
>> @@ -6,41 +6,22 @@
>>  #include <linux/cpuidle.h>
>>  #include <linux/export.h>
>>  #include <linux/irqflags.h>
>> -#include <linux/sched.h>
>> -#include <linux/sched/clock.h>
>>  #include <linux/sched/idle.h>
>>  #include <linux/sprintf.h>
>>  #include <linux/types.h>
>>
>> -#define POLL_IDLE_RELAX_COUNT  200
>> -
>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>                                struct cpuidle_driver *drv, int index)
>>  {
>> -       u64 time_start;
>> -
>> -       time_start =3D local_clock_noinstr();
>> -
>>         dev->poll_time_limit =3D false;
>>
>>         raw_local_irq_enable();
>>         if (!current_set_polling_and_test()) {
>> -               unsigned int loop_count =3D 0;
>>                 u64 limit;
>>
>>                 limit =3D cpuidle_poll_time(drv, dev);
>>
>> -               while (!need_resched()) {
>> -                       cpu_relax();
>> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
>> -                               continue;
>> -
>> -                       loop_count =3D 0;
>> -                       if (local_clock_noinstr() - time_start > limit) =
{
>> -                               dev->poll_time_limit =3D true;
>> -                               break;
>> -                       }
>> -               }
>> +               dev->poll_time_limit =3D !tif_need_resched_relaxed_wait(=
limit);
>>         }
>>         raw_local_irq_disable();
>>
>> --


--
ankur

