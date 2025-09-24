Return-Path: <linux-pm+bounces-35276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F157B999F2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 13:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02F74A5991
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277A52FE04A;
	Wed, 24 Sep 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kGzEPrYd"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F32E1EE0;
	Wed, 24 Sep 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714079; cv=fail; b=VVznDO26rxIXOWn8RvVP6kt6M95iZu11xnb9qjt3KyFB+v2/W5+oqIeGOwfr+FrKGHTYRMLlHfri4meaw8k0ozKAHW2e8wkAUaYZbxj7BbJFI+t7afXfCeU81elvG49d7NLnwX/msQ1IRkonTM/3TQe5ocQCsljR1xADAM9xDtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714079; c=relaxed/simple;
	bh=fQ1jAcQUJaVsUVN3yxICupe/RgGQIPjGcNe5w1L+NiQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HdFjQfZo41bGuljUzxv5PkyYM2qrnv10yVuXCVAKNFMMRUQjE4lmHqH6CMgxQ5MqjFCeuthU0rvBu04LKl4EvimRNJ/x26tWDerOf1WByAHJTpECqiZZJnB57a7xAsuDQuhO/C48NsilkFiAX/5Tnmihjc6LqwoHNo962Zc4Vsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kGzEPrYd; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwgfFE4NoBRi8sbIxDmY9ZbNYt4BE0nQ6dlGyF19PEEFu4pfkLsgW64uL22mTFyzXzBOzUFhQExCD9kqVw/x1EkoFT5nbwQYE01Z810aqawvRu1aSxJ5sU6GxjsoRk3uIw3GV2OtlSAeV+UcFEV4YeL3Q9XcXxx42oWSZPnr6NLnIUjdPnBNpuSt51682P85dJ0EyzKRKhcYImeblnlHesCTFpFzmoJOga8XXR1QvG1uenkk1TyjLBBIwYaFss1ipFXb703OjbiS3/Urg+DaprltYpIGUaFpuh2t/MKbJKelQXxSt20xF835KMOjtaKxlwA/i6eaBehNF4Twk+YsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD2TZg8LYAmC2ujG2oMSMQJLHfdVoKKvVZfXQDj4nF4=;
 b=wil1QUOze/7+dr3j417Mrq6M2FaJbLZTW3DZXh7FjsHbRSokyzIQ7Ut2I/vX147zlTOUWiVj4PEF1+ZUFrJg6z7yLECH+Z4eglf+oYxUOP+/NDeJIe38loMGChFR1W7QMe05Jpr0XPo/VfDVO+Da2Rl3cjxyK1ClTYsGszuM4bWJk3DINJxQ21anxmHzuGcpZDr6pYdP7vcUrkZJmnD755vwccw52n16+zJn6ED8yy5DfXgaCXPJqtPt1SJI8iS9RESK/5JXX5rI2Vsfmg6E4CvWoBa0+FRj3Q1t/lut430wowqzZgzHVcAEUE9Aly8zCc3ZEpTXpf+saQQnWqhDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD2TZg8LYAmC2ujG2oMSMQJLHfdVoKKvVZfXQDj4nF4=;
 b=kGzEPrYdUQD91dvRuKm9Xa1hLfIyZKFb3/hVVmZTwR6YdO6kDr8WkAP6SsqVWd88xVNbOWQsQbRaOaWTZ9uOL/tfimvP3WF5xr9Vpc0W7mREkda0/iCnqh0S70HLHkC0JxCBSjJuRG7WfZmhWvbv5I3H60CW//dBAKreYrtUWtDh7nSIUPms/O5Xth2DSSQmsEaGq3tRaFGUq60ItlCDVcAgarGrTDXdaI+dqUdri9KeSMyCYGkTbWpb+PEUZ+u9GgOdXad+IgomQNB6r3ezw8Vm/trsbSAHRi2w45+PxFU4b94hpwB76Y+pKaeg/mJlSfWUbFdI6fnDnO5H8j59VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 11:41:10 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 11:41:10 +0000
Message-ID: <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
Date: Wed, 24 Sep 2025 12:40:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
From: Jon Hunter <jonathanh@nvidia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-21-ulf.hansson@linaro.org>
 <4478f28b-47f8-4049-bf17-b7fc95cfac65@nvidia.com>
 <CAPDyKFqSyP3e=JRFYEuFefWVN5SYJWULU8SKzXmrThvyiVGXgg@mail.gmail.com>
 <a904d953-acb2-44f6-81bd-118f7abd22da@nvidia.com>
Content-Language: en-US
In-Reply-To: <a904d953-acb2-44f6-81bd-118f7abd22da@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a729aec-1a48-41f1-3071-08ddfb5f4197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVcycVh0amtwUlQxQnlhekxPWFZFNDZuNjVBTmVFQnZ0SlhTejBBMDhReEIx?=
 =?utf-8?B?dy9vWFk1SjZIQTNvTFE5dnBXSXIxYm5tTVlseWorT0g1Q1RESlJsd1JlRTB1?=
 =?utf-8?B?NnVtNkVIc1kwQ2ZGQjgvSkErMDJNMm5MTXhFTmtkb2tXOXNTcFl1aWYvTVdn?=
 =?utf-8?B?Y0V2ZlljRHdIWDVuT0oxaWdxcVBXU3NKTTFPSDZlSmsrUVJGWGgvd2tqVWJs?=
 =?utf-8?B?WXJKRTZsQnExVHhsSnhKYVlFZDZHZVdIY0F5bWVMZitKQUJnTE1vVy9CdVFP?=
 =?utf-8?B?QytNd0J0V21ud1JxWHJoVTBCd3lxRGhmUGp6aERUaHVoZ0lyY2xwQzZyai9F?=
 =?utf-8?B?WlFjTnB3cTMyUmpFdER4NVNCN2FmOVBsK0REYmNCSU1vMUltZFkrN2p5KzA0?=
 =?utf-8?B?T1FjWS95TnJCUjN2WDlNNmRmb2NXV3J1UEpVaTFnbDlhVXFKTnRVaFVMekZC?=
 =?utf-8?B?MUVjZk9aSGViLyt0RjVYeElEbldSYnJrSFljdG9sNDJOSi9EclUrZVJhWmNY?=
 =?utf-8?B?QVNJNzVJOWEyMWJ5Q0tpcTNwaWVpb2U4Q3hjR005WVVtS1hPd1NJTmMrUElF?=
 =?utf-8?B?cVhtUnZ3VkJwUmlOQVUwZHliVXFjTll2em45T3czY0ZOalpuaTA0aGpVbE96?=
 =?utf-8?B?SGhET0xQeU5tc1BWeFZ1dXBCb0Z2dVJxeGdneEk0RlB1c2djTUpsQUgrbExO?=
 =?utf-8?B?ZUJYRmx3QU8zU21sVUVvQ0F0cUlrbm9YQ2pjckY4cEJRRlh3OGpVaHkyc1l3?=
 =?utf-8?B?R2hMS0VWUEZHSDNIeGRrZk94bHBMcDNtTTlkclVDOFdxUFp4MllReU5rdkU3?=
 =?utf-8?B?c3NoRmNiTG4vUnloSmhVdXd0dTIzcy9oQ0hDSEl2S1IzVVFrVGxuRXRreGox?=
 =?utf-8?B?aGgrcWVib215a3FRU2ZUZ0MrdXdmL0hDVlIvT0RCQS9VNGZWb21MN2cyNU53?=
 =?utf-8?B?T3NIeDZyVlJOUmdaQTIvK2V2TXhEWmU5SndWR2lRRFA2OXpYUnlBdmRJWUZF?=
 =?utf-8?B?c1MydGczMHBqaUtkbmhXd0hLUzdSelFHY2ZBNXFZSFRLRjVZZzZPc1dwWkVK?=
 =?utf-8?B?ZHhteUZaQkx6bVcyRURPYlFkaUVNM3psbW41Qlp5OUhVUHhaZ21LUHJqTnA4?=
 =?utf-8?B?a0lYMWl0QmVpbVk2b05kbnM4MmdvM3h6T2c5ZDViNklpS2FYdVFSWEt1VEMr?=
 =?utf-8?B?OG8vdGpyNFk2VjNYRFArS0p1RFhjZS9RMXRVclJLY0JaL2dUT2RtZk5EbFd0?=
 =?utf-8?B?SGNsa0Y4d2xpcG1EUTlvZUtkU1dGVWJDamJ6VHorSEltR0x4V3c3a2toQTJK?=
 =?utf-8?B?c2FLUG9lQkdIVnY3UmZ3V1B6MjkrYlpFZEJNbm4ramppWFF6MlM0Wm1tOS9h?=
 =?utf-8?B?eFNwNlRRWFpqMmxuOUVKR2hBY0NuSGh6QlE5dDZHRHEzcjNnZUVIQ2FINVFx?=
 =?utf-8?B?VTZQUjk3STk0bnBtNTErcE01RUs0bGlKTDMxb1NpdjdqN0QySVBKQzR3Y0My?=
 =?utf-8?B?bUw5cG0yTi9wSzA0em9XUWFGT1l1NTlyVDdaZktoeUJFU2l3Q0lnMndhYmFT?=
 =?utf-8?B?QS9ycG96Zi90ZDJlL1lyUjlUVjJpQk9kdG04aW01TW14UlpzZXUxMGp1M1RG?=
 =?utf-8?B?V3hwVmhsWmVNNCtWQWlLWVNLcllSeDV2VnlCTlpBZUNpYklWNkZuZmQ5Q2lN?=
 =?utf-8?B?Qm00bXU1QXJsMWpwanJ0TUppdUlGd0pvakRISm5mSkhzNWRnSjRSSUMzNFo0?=
 =?utf-8?B?WHdYSjBWSGpKRVM4cjVOVFh0T3Z0eEVGVkVyTUl5N3gzbjlHMk01WlJPSWpz?=
 =?utf-8?B?NVYzZFpDRFdXcEVYcktxUURsdVYyWTFPdTlDSXR0U2ZqdUtMa1Z3T2pUbFdi?=
 =?utf-8?B?QmQ5VCt3NE1VNHBLTDh6VEhLVDJzV0NCTFdKdDZ6MDcvRCtpWjdUMHJGZkE4?=
 =?utf-8?Q?RwYZASXG1kI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWpiSVdYTmdla3Byc20raWExaVJITlJQQjlQazl3WEw2dWhacHBJNnJWQjBF?=
 =?utf-8?B?djBrL05WSnhwSVZrdXcyUW5pejJPWElRVmM1Rng5RktmenFxZ1lHb0ppdU85?=
 =?utf-8?B?V1Z1UUV3VlF1Q0t3WDR0UHlQMFJjOGR2NjRodXdRaUgzZjc1NnpHa0l5LzVX?=
 =?utf-8?B?RzlBR3hib3Z3Y2crKzQrOFV3L3dmVnRyUkJNaWljUHVRWmd1NTB1RCthakh1?=
 =?utf-8?B?c1RrL0dyZXR2NVA4L1VtVjg1WWllUjdDWTZQSHdtMGhRZFpvYmZOZFFGUVlm?=
 =?utf-8?B?TVUzNHlJRUNaNENXL0ZJc3I5WGRNTlJpbm5rOVVrUkdmM2dDUml3MHdSVkk3?=
 =?utf-8?B?OUlJSnBTcERmbzlvUklyWXAvU0UvL2p3aGJXZ0R4NUhlQW1ML3JPTFlnN3pH?=
 =?utf-8?B?QXFQZkI2cDZwRjZKcGsrVU0rQ1NnamRMWUgweGZ2d1lUNC94S2xZSlJDWG9K?=
 =?utf-8?B?eFhPaCs4YUtXdVFjbFZMNTRvcFY3YjB3bnRtZ0ZCaXo0MVhNUDdNVmM3Mjhu?=
 =?utf-8?B?bGFycXJMWGlpOFFFQjA0K0xxZjdOMmFzbE9jbWtTOTdpTXNORnZZTytqTExT?=
 =?utf-8?B?TjdyN04zY256REQ2V09WZXp1NGJpV3FwaExXSGdHc1FKN1NZWDlmRkJDZ04v?=
 =?utf-8?B?N1VVUThTdU9mOENYY21WUGxhTWxkZmlZc2lJSythWGp5Q0pNNzVpSENTTERF?=
 =?utf-8?B?MGpOaWdoRlIyaEdqUGpJYkg1ak1ldE5lZXFuOVQwZmFHbjhkWHpzcEdSb1J5?=
 =?utf-8?B?VGN0N1BNUXVnaWJxaFkxU21aaWVMTU1MRVhaSXI0c2xTZjdKQ2VhclQ4THEy?=
 =?utf-8?B?R0RIVjI4WXZnaEFENFlCblYzYVZoaUc0MVVLZkVTd2R6UU1adHp0UkxCNUQ0?=
 =?utf-8?B?dm1HSXlQa25BMldUdm5nWVZ2ZTdaRHBGRjhuOTdUZ3pKRm5iWW1mc1hRRkxG?=
 =?utf-8?B?SUZubkZJOGZnVUJJeGJtSDJZMFk3dWxrdy9wamg3dHd0eWZ6V3pCckh3UHRU?=
 =?utf-8?B?WFpNTUxzdVZiTlJ6SzQ5V1VhQnNjNUNIRHlCRks5MjAxSU9HWnAvSVFLTTdP?=
 =?utf-8?B?MkpHblZqb2l0WndPcUkrUDd3YVh3dXJ0Q3pkai9rNjg0Uk5vWnZFZnRXWFpt?=
 =?utf-8?B?WVlqNE1hMFpxa3lJa3NaUHFjVlZpd2FpUVFVcFRhWFZIV2JOQlkwS0UzQ21s?=
 =?utf-8?B?WTRCc0pZN3V2SmpVdDRsL0pxY2dpVzZIMFdLaENIVXpETWF0UExMdUdYYkZZ?=
 =?utf-8?B?aG1Jc2ZWck0yOC9nZm5KcVRLWXlwVVBPTkFMYVk3WnJ3QmthUFBQN0l5dTgz?=
 =?utf-8?B?cEVGQlprWUczYVgydEwxYnJ2eTlldGlvWVNBRWRIK0l5eWRIdkhWUjJIaWNu?=
 =?utf-8?B?U3BOWjFBbXE4RXptYnVLNmNhdzBhZGJta1oyVDNZemRWSmx6ODVyT0VzcmlT?=
 =?utf-8?B?cytkTGxMQ0UybmhiV0Zmd1pLWkRRMWZPdmRnQ2kwdis2ODQzN2lPbS92TXVs?=
 =?utf-8?B?bjFsVnFmK1l0bnFuM1kwbFpsVUh0UGw4VkY5OUN4aE9uTG9ONDVKUG9CdXh0?=
 =?utf-8?B?VXFaK2RLVDB4aHBFblNkY0YxWmtNTG1qSWFITWpNK2Zkd2MzRGZOOUxNbnRa?=
 =?utf-8?B?b3JFZE40YjlOV1dINEZyMjFKVzkvT3k5bUZsaHVOTFoyNmgvOXhZVFI4dnVU?=
 =?utf-8?B?OTJHRlQvQXFPbFlTSU5tRzFTYytKL09RaE1Vb2hnSnlyTEpNVk9SV2VETFNI?=
 =?utf-8?B?WXN5Q1NMdnU2UGM5Y1VzbitqWXo0cFRZQzNjZEcyNFM1d1ZLVzFVRWdtdFBh?=
 =?utf-8?B?NE9vSHdUbmkrY1FGOWtJN2pOVzZWNGNKYTVMRStzYTJ0OGhLOGJXRDJ2Y3J2?=
 =?utf-8?B?TWlqL0VUMW9MOG9jcmxYc09HZDB4Rm00Mmt2dGQzLzh6Q1dsTkV3a2NUbDFz?=
 =?utf-8?B?TzJtcytXV3J5SW1PUVNKTklWeHkyT2QzODA3QmVFNlZwK3hUYkxkMko2WTkw?=
 =?utf-8?B?UjBCNWx0L1NjNlZ5bU56S3lnR0pEUFN6NFJqWW9iVHVNYjdnd040LzFlanpW?=
 =?utf-8?B?aTgwandoSStuUWN6OTVTOTRKL0l2bUJsY2xid2tYL3FrUERudHI2cy9yOGZ1?=
 =?utf-8?B?eXk0SkEyTGpEcE5NNVFCaWx4Y1h1aGU0QXJsS1pzRTlSdURNSk83RkdURFBR?=
 =?utf-8?Q?klTBd2QAcFOycpHVbww8QP+MrA0hoaEyuvHRgQ9FlLXx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a729aec-1a48-41f1-3071-08ddfb5f4197
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:41:10.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tf9UDIoJCq+2gO186abCaPYRQP2q7Bk5ObI+iVn7Cu0muk0HxaBMu3jIUAmR2vTNHAUBwJMvcu2cOwY4K6Q//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845

Hi Ulf,

On 03/09/2025 13:33, Jon Hunter wrote:

...

>>> Following this change I am seeing the following warning on our Tegra194
>>> devices ...
>>>
>>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 
>>> 17000000.gpu
>>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 3960000.cec
>>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 
>>> 15380000.nvjpg
>>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 
>>> 154c0000.nvenc
>>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 
>>> 15a80000.nvenc
>>>
>>> Per your change [0], the 'GENPD_FLAG_NO_SYNC_STATE' is set for Tegra
>>> and so should Tegra be using of_genpd_sync_state() by default?
>>
>> This is a different power-domain provider (bpmp) in
>> drivers/firmware/tegra/bpmp.c and
>> drivers/pmdomain/tegra/powergate-bpmp.c.
>>
>> For the bpmp we don't need GENPD_FLAG_NO_SYNC_STATE, as the
>> power-domain provider is described along with the
>> "nvidia,tegra186-bpmp" compatible string. In the other case
>> (drivers/soc/tegra/pmc.c) the "core-domain" and "powergates" are
>> described through child-nodes, while ->sync_state() is managed by the
>> parent-device-node.
>>
>> In the bpmp case there is no ->sync_state() callback assigned, which
>> means genpd decides to assign a default one.
>>
>> The reason for the warnings above is because we are still waiting for
>> those devices to be probed, hence the ->sync_state() callback is still
>> waiting to be invoked. Enforcing ->sync_state() callback to be invoked
>> can be done via user-space if that is needed.
>>
>> Did that make sense?
> 
> Sorry for the delay, I was on vacation. Yes makes sense and drivers for 
> some of the above drivers are not yet upstreamed to mainline and so this 
> would be expected for now.


I have been doing more testing and do see a lot of "tegra-bpmp bpmp: 
sync_state() pending due to" on our platforms for basically are driver 
that is built as a module. It seems a bit noisy given that these do 
eventually probe OK. I am wondering if this should be more of a 
dev_info() or dev_dbg() print?

Cheers
Jon

-- 
nvpublic


