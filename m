Return-Path: <linux-pm+bounces-10753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60495929E34
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5199C1C21D0C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D238FB0;
	Mon,  8 Jul 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ZiVLrDub"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11C29CE8;
	Mon,  8 Jul 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426941; cv=fail; b=pyF6IXMOzVH3SR8rWaKEpAVd7jKlfeu3IDwGbKuLW7AOkgo4UOXGDQo4e2UuEh1RzHva3Qw0UvTivvYcAyY2nt6un3nN+FOFFyDM7rByPXmre2/xj0K5rkNSX5sI/iAkwbAw0XejmwgIbf1PdzWl647kA1OVW6Y2Y2vSvuquYOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426941; c=relaxed/simple;
	bh=YTOV367x83TZ3+ranjMVOmrDgrrLah7N6ltzGt9fZuc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kO9iUIEoiW5lTu7fu3mrHmwIpV23EVvjOCeMSzGW47s/DJnTFpx/Vq/pN5PKhYZ3qRjo8hx0jWTtQ2KtKfJswKEtGXC8f/5j/i2RYNoF318r2c8uchBnrU6NzKlIuRD6fn6KXAFNMkodPVSyXMBirVPRmvkF5aRcskeFhVMKFsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ZiVLrDub; arc=fail smtp.client-ip=40.107.215.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0+njE9q9nnM5EWiL2hji3qWNXscnhAipSlWWUnKcfA3C74+Ry9sPOllGCfo1aFAe4zZ4+Xf3EpLRWD+GS6a2waGl2MOvSt4y7pQmFXKKBROjzUIKBz/hskatDp6txkpn5nsM/FNKlZk3l1K3zkIYxLAghYfmfvyWBtrrtczL/ymNhKWcvEOIo2MKlkd0RuGKC+uKLzuRY7iROheOC45ahDutmxkO4wtrgKMJTU+2CdGFSR0dx28ZUHZITxg1lyOtCtVqgFkvJCHYVdnNS0KsNWKFdTL1xMJjm+cFuVntcjvcMWxuccv/1MOyyPH7tn/KcwZg0LAsO99QlLNpJgKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9mML/VcoKWdD+iFTP96dRX77+RoiMxIC/1IUzQiei0=;
 b=XOy5/EsGFFr4LspZzci70zzFEr+kfMg8DdZBQOLT4wIk1iAnNCwQn0c1q8lfqr85UoPdr6jaKIjvZGq0N8JfwPDN4QCv8xBLIN00TCZPk3fjX6LeveM30Pt+Dn0MFmwJftcOySbj6ngXFnkrXONpMRJXLvMHChKHUSr3OKbXzKdNbjKaaRdDWXvllf8yWV3SZ9czw2TOVv63VCD+rM79GgVNXHm1smCOsRET3wqJaLjvP15J12CrENZN63i2RQb3SPPcoftabN9Md1q+jfiGKuSWq/oQy62USpdyyZM85fWm96xBYYfpe+mJM4yBlikDyIx0N1fiEvbH9QwS31jWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9mML/VcoKWdD+iFTP96dRX77+RoiMxIC/1IUzQiei0=;
 b=ZiVLrDubjAwqBDSxcI9R734IOODYh+jvU25+L+jyuhqS7AdjuYuYpZGXOjhSSICvQw+2kmzsB7P6VBZyMd7KyAzEgV2TbDGQqjQd9d3GFBTdWzeUNRkY9nGvGlPXTlSjnXibCve53v0Q7VRVKd974wTXOT738EIJDjv+ycee9r0LB6u1ZueqxpEXRrOBFE6MBEcXnVOhKoAjAFSGfsfm+QsQ0dsPtcmXCyoysPBU6oiQas9bo76dBICnUqNOxTU4FNhwCYipv6nWs2A1l/GbgA5N018Xn/iXRLUUOG74QxnISSYnVQhqy6oI/gEluta3HOG9LlBbX5XtIZ7ijj7xxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB8307.apcprd03.prod.outlook.com (2603:1096:820:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:22:17 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 08:22:16 +0000
Message-ID: <2c51fff5-bc63-4f30-bb6d-f5fe91854d6d@amlogic.com>
Date: Mon, 8 Jul 2024 16:21:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power sequence for Amloigc
 WCN chips
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
 <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
 <a4d08999-55ea-4674-bb0f-6d618b7bdea7@kernel.org>
 <9c550278-2205-4663-917c-c303c65726ad@amlogic.com>
 <726a0561-b3fc-46bb-a834-3ed8b0e993e1@kernel.org>
 <91e42fbc-712e-44b4-8200-23aaf1fade43@amlogic.com>
 <7d109ab0-ebd0-4739-a15e-958e82552a7d@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <7d109ab0-ebd0-4739-a15e-958e82552a7d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: d0370031-f6d3-4a31-4f40-08dc9f2713a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1lZbmJScXJ1dWJtU1IrditZeEdXbFIxTzFqZGxnV1pGRnFweGpHN0ZIV3JQ?=
 =?utf-8?B?OXVzY015QnJVeDU5Yi9XcWY4V1RRMGxybWg0cURqS1lZTTdUV3lqUG0xSW03?=
 =?utf-8?B?dkhHNmtFQ0E3bUZlN2F2bXBFSmhIckJqQjZ1elE3Zm9Lc2p2em1VdnBlNFV1?=
 =?utf-8?B?VE1vSWFQS3VSZVdGTzByT09SbFREYWo3VnZlRTRhaUVueFlrbkxzeU9OOGt6?=
 =?utf-8?B?ZEh4MjAvOG5xWHhNWHdGemNtRklsVHRFbExBU2tUSlphekl3aVZXeEI2OFZn?=
 =?utf-8?B?NGEySHIvdlJPNlRlZlBuOGcxNVQ1S2Y2K2pQV0pDM0I1WTJNZ1dMbk92UFVv?=
 =?utf-8?B?UkZlUlBMZTR1QmwvQXJwN2FpeExuK2ZiTWNZWVVwQ1AwZVMwZ1R6VlJQalZr?=
 =?utf-8?B?bkJCcm9VSVVvYmVnODZaT213Z2lKeWoyRUVqbEgzVFZxTWFpeCsvL0s5SEJo?=
 =?utf-8?B?RHFVNENpWldpalQ5K0JnN016U2NOdjlBTXEvVHR1Qm5hMGgzV0JUK1dZOUhY?=
 =?utf-8?B?UW5iL1YzODRUdDQ1c3hKdnl2ekJWeklvMnBUanBOWUZJVk5RKzRSOHNhZVc0?=
 =?utf-8?B?ZkhPL2NKVGJ5WDR2WWxUOFFxK0pPOUpJM2lxenRGTHdSekRsbmt4clBlMkhO?=
 =?utf-8?B?KzdzWThDT0JaMlJhbEVTeG1XUlliQmJMYU5uS3ZKcHRqTG5wNHlmM3hFb2Fi?=
 =?utf-8?B?SUJXbDk1czZOZUw5a3dBU0UzVEkxZThGVGZKWEhHN01NMWNMRXRMVHk1SWFr?=
 =?utf-8?B?cEcwcjJHVkhxc0FBb0RoNXJoR0FYaFpRZnozZWlBQy9tUVkzYWxuMDFHdzVK?=
 =?utf-8?B?d1Q4eS8wQ3dqeU51VFJadGNja2FONTI5UEtuOUIySlFuWCsvSkNMUm14eVkr?=
 =?utf-8?B?N2NNTnMvNnhCZXhMZllWSWhsb0dEei93SUViMTFHTHZjS2YrQzBEUUtLWnF1?=
 =?utf-8?B?enFyWmh4T1VXaUwwWCtxWEFqb0duL0hZYmVjL21QbXowVS9oLzJSQU5QaTNE?=
 =?utf-8?B?dm50dksyQzhpMkpPdXUxRm1SOTdNWTB3dVJVeXVhYUlDY0NJZzJoRHBrN3Ja?=
 =?utf-8?B?Nlk4ZlN2YSs5a0d1NE9pdDZuc2JCaXpzK0RTQ09TUjNrbmpDSTVUdHhLWEIw?=
 =?utf-8?B?alJQSlBhMy9tckxxV25JWGVHS2wyc3FiMngvZ2dmUSttV3gvZlVKSU9scUNh?=
 =?utf-8?B?OFFhd0hZa1VZczd2bUVjMkl6THd1K0ZwNjgxMjY4eHI3ZXhBR1hxRDlGQVFz?=
 =?utf-8?B?am81Y0hNckJVM29IZFNxR1kzazF1MWt0b1RWSzdURjFaWDJ1QitYQ1hhSjVJ?=
 =?utf-8?B?VURvcVl6aTVEcGlmTHVJaXprNGhXcGVNZGd0dFNCQ2NhMk9LSzBwT0p6cUhu?=
 =?utf-8?B?M1RvTXpBbjZnaHJxL2s0TnBVUW1JaHdJcGZTL1BuN1RvOHFzVU9NbElJZW5k?=
 =?utf-8?B?ZlcvUVhUVDhySmYwQnVlWHBVeXpDRnlqNEg3ejM5L2p3SkVBaE9sTnd0NjlF?=
 =?utf-8?B?aDIzY1pNTGxZa1ZhT0ZRZFJsWHYzb3NIMlg4amh6QnlMZDFDQmV5ZTBNYjBh?=
 =?utf-8?B?QmNISzNlcWU3ajg3cG54Rmd0UVRKcEtzM1NDZ0t3ZVFvNXJuZUdoUURva1B5?=
 =?utf-8?B?NGZsSmpvaDByM1ZXSFRzSW1QYng1MzNtdUxzT0k4cHhSZnpiZi9RVmpYRXFJ?=
 =?utf-8?B?V0dqcW9SZXNoSWdTd2tyWEU2eGZsUlR4QzExYXR3RlJFLzc1eWFEY2pZajZM?=
 =?utf-8?B?RW1EbXpPa0ZJRHRRMkhMU0hPTUZJWDVzWVNGVFlQVWNhWnZrUGVwRHlMYjV0?=
 =?utf-8?B?L2NteHhzL0IyZHVFdkdxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGFJMTFaUUgzZVEzU2tneWZRUzdxTXN4SXJrVzh3RERHVzd6eG5Db0FPQW5M?=
 =?utf-8?B?bkk1TjliWnM1VXhLejN0Q0pySmdHRythamVLdHd6c2l1U0JtSTBLRFluNTdr?=
 =?utf-8?B?d2NSYXFVTkJkNUhSTHlyb3gvYnh3cEo0TkwvcmV1WDcyNE9ycW5FU29SNHNZ?=
 =?utf-8?B?Mm41NTFWOGNReTlEb2RkcmMvOGVEYmFDTFpzWThQRk9yK1FNdHpZT2J4ZUtJ?=
 =?utf-8?B?TDRIblFPRlBJQUZMeFFvc0gzSm40LzE5VUdicGhKL3VCS1BYNUk3a3p4RGdE?=
 =?utf-8?B?UXZBdHRyOEw4Y1VTREZVMXFxZjU4YkF2S0trNkJrZlM2YmNScFppSmVVbUpu?=
 =?utf-8?B?UGsyYjJTbEFSQzJkNUxsWnN1ZFBnS01YbDBZUzI3RDV1MkczM1JpQmRCV21C?=
 =?utf-8?B?dm9CUVFZZnRkKzNSU0hlWmZDZFZrQUlRb2p5WXlxTHQ5WlZad1lDSGlpcFpU?=
 =?utf-8?B?K3U3UUZvUkk5bHpVVWd6eUsvZlJpR1RyODJNcDBBbEx5Rmc1WmYwMllLalFK?=
 =?utf-8?B?NVVLQ3VFTWJqLytTTEpoaHAwaEVUc2pZWUg0K1J2cmdBcWNVWFBVczB6MXBs?=
 =?utf-8?B?a3lmRGxLMUJxaG9JVTArM3YrUHJYNVplTWRMQnRrWnZGVG8wZVVkRDVoZTNp?=
 =?utf-8?B?bHFSOC91ZE1pUnRkd0lNRVVJaG5xRXk1YklLWDgwWExXQzdKSG1tTG1ZdUNl?=
 =?utf-8?B?RDNCVmxJVmI1djZRR2hmWVRKMnBYaUZOeEFuVlgyaUtBakM5b3dLTk9XeWZM?=
 =?utf-8?B?U0Z4YURwd2Y4WGtIejNKTUxYcGNsdTV1Q05obCtUbHBMay9oZUhvdXp5MjFK?=
 =?utf-8?B?SFhJU3FuOGZVUSthYzBlbS81cHpSWFhIVVJNaFE4S1k4SkJqOG9xZHZHUFJM?=
 =?utf-8?B?OVRWWkNIZ20vNTZKM0FxKzlNU2N2eXk3VzlhcXBVdFVYRm1DdXdjU3lNNGg2?=
 =?utf-8?B?VDQvd2QvTEJjZDF2bERUbzRsSHp4TGNLdDhqeGtDNzZVT3N5djhlbVU3TjN2?=
 =?utf-8?B?ak9UUkFIYUFJTFFEMXUvb0VONlVyTVZrL21Qajh4bHNIVnBKLzI1eENIRzN4?=
 =?utf-8?B?aW5HN1p2ZzNWZG91R0krUWhEOE81WGREdWJjbnJmMjV6bjVjK1dQMjB3WGNh?=
 =?utf-8?B?amk2L3BWQUNvYU9tZEhVUFFOS1IvRmpOTUFBZTRDdGxKbzcxMUNSa2s3NU8x?=
 =?utf-8?B?b2xXSzRkUlVEL1V6WXhYRWhLd1BsbFNXN3JEd2kxSkdJK1RzRS9NTmFDUFR3?=
 =?utf-8?B?MHpjSG1ZUExBdlM1eU51NXk2c2JTZm5EMzdUUXVGcVJqVG1DZEprb1BnbVpP?=
 =?utf-8?B?bFEwbktXYjlGS2IyN21SWFhBZGVNdmdUUUc5R1JuYnBUaTNhdWhZMzNyYkhL?=
 =?utf-8?B?alM3cnpRc2JYU1VHYll6dFVmSHlIQkhJWG9wb3ozZjJCMnkyNkVZWWhvaGFx?=
 =?utf-8?B?S2RSUHdoaUVZYUFzNHE5OFZGTzJXTTVhRS9jNEY3WkVHT3kwQ2JBOGxOWVdN?=
 =?utf-8?B?V2pZZE5TZ1FWRk5KZlRiVXpVWmZGNEVHY3J1cnFWT3JMYnNqSTlZc2k2SWhp?=
 =?utf-8?B?cEdmeEtHRUhZWGF2amlTa3ZMNi80T2RYNmp0N3ZnRmRWR2s0bEE2UEZkendB?=
 =?utf-8?B?RDlHcDJZQXFkUDhSUUYzRk5yUGdjRVZoUmJEODhoTUcvNkhqNHh2dXJBUGY0?=
 =?utf-8?B?SjcxeHN0a2htREJJSkNybzc1eUFOK2JNQjNmR2Juc012UFk5WEt6aGs3WXZT?=
 =?utf-8?B?QXJJbXRsQ0lLT1F0eVZLUlVFNmFVM0dFS1NBalJvOG94b1pIR0U5R3p1Rmkz?=
 =?utf-8?B?aEFaOHQ5TlQvcGNWYmhBeElQeHVEREpSeVJWTWJucVM0ZlNRYVg0RGRGZnl5?=
 =?utf-8?B?QjhIVTN1bmJzWWQ3TDVDTUd1OVB0bFRXMzlwUlBhZmJxVmpoYUNQeDREWnFQ?=
 =?utf-8?B?WWZwaHRUSDR2NHRRYVhITmc2M0ZsTWorRlh2cElZdk9qaWEwVDdKWUZJQ3JB?=
 =?utf-8?B?c0Zia3BEekgxajZpL2tXMXlydzhySXBhT1dOSDZTYm5kSjBSeGJkNEkweEhJ?=
 =?utf-8?B?M3RvZVhFVG50aGYrYUNrVXM1em1uUE5iaVRzOFdjSEdockJoT01KOGlpNXJL?=
 =?utf-8?Q?1qs3IsI4Ru5SrGsdWJAc/UTnm?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0370031-f6d3-4a31-4f40-08dc9f2713a8
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:22:16.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8hoGg0uYIY0k5VFQbmutz28cWZqH+ZmE87BqPlKZLEyxxZdUEqZy8468lLw1xN1y1vyK1oBmpVuZHwP/7H1GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8307


On 2024/7/8 15:32, Krzysztof Kozlowski wrote:
> On 08/07/2024 08:32, Yang Li wrote:
>> 在 2024/7/8 14:11, Krzysztof Kozlowski wrote:
>>> On 08/07/2024 08:04, Yang Li wrote:
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - clocks
>>>>>> +  - clock-names
>>>>>> +  - amlogic,chip-enable-gpios
>>>>>> +  - amlogic,bt-enable-gpios
>>>>>> +
>>>>>> +additionalProperties: false
>>>>>> +
>>>>>> +examples:
>>>>>> +  - |
>>>>>> +    #include <dt-bindings/gpio/gpio.h>
>>>>>> +    wcn_pwrseq {
>>>>> No underscores in node names, generic node names.
>>>>>
>>>>> There is no device as "pwrseq". I also do not get what "wcn" means here.
>>>> Yes, I understand.
>>>>
>>>> Can I change "wcn_pwrseq" to "pmu", and do I need to change the binding
>>> What is pmu for your device? What is this device in the first place you
>>> are documenting? Where is the datasheet?
>> ^_^ Well, You are right, the "pmu" wasn't really fit in here.
>>
>> I'd like to explain the current usage first, and could you please give
>> me a suggestion?
>>
>> This module(pwrseq) used to power on Bluetooth & Wi-Fi combo chip, both
>> Bluetooth and
>>
>> Wi-Fi driver need to control "chip-en-gpios" pins, so we introduced the
>> power sequence module.
>>
>> What should we call it in this case?
> Sorry, you describe driver, not a device.
>
> That would be a no-go for entire binding. Please describe the hardware,
> not what you want to achieve in Linux drivers.
W155s2 is a Bluetooth and WiFi combination chip. Bluetooth requires the 
bt-en pin to be pulled up, the chip-en pin to be pulled up, and the 
32.768KHz clock. WiFi requires the chip-en pin to be pulled up, and the 
32.768KHz clock. It can be seen that Bluetooth and WiFi are coupled to 
the chip-en pin and the 32.768KHz clock. When Bluetooth and WiFi are 
working at the same time, no matter which one is turned off, it will 
affect the other device. Therefore, a pwrseq device is now abstracted to 
manage the chip-en pin, bt-en pin, and the 32.768KHz clock.

There is currently no matching device name for the pwrseq composite device.

Could you please give me some advice?

>
> Best regards,
> Krzysztof
>

