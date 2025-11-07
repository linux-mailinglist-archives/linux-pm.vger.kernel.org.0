Return-Path: <linux-pm+bounces-37613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E8C3F8F9
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 11:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A85F3B4A0B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F2309EE8;
	Fri,  7 Nov 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8lS7TSg"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF212F7ACB;
	Fri,  7 Nov 2025 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512166; cv=fail; b=CHZ3eYDzBvRmN0zIukV704Y+iDZLawsOnfLoD7gvgGMtffWRTG5a8ElZ6fx2UhUMXURGuh04fT1CZ68mEyOsmAFpWNfqUPj1E2PqZgScS8R7QI4sQlqkpTq5Ewza7z9CzDrlKqRxzf3DcvkEYWPV2I2hhyWz4xCJSEPYtsHwjdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512166; c=relaxed/simple;
	bh=M8lV+sLZgXEHOu3oSFKKTN9PcMkLHOgJhylbgIHN1fk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YjxxtjPFcT0Pv7I3LaSP5AoTFlU+27j23kEnFTeAQ4WBikNzQCAYNhTfyWQtbLQBhaBlAnBO8lP8KiaXoYsm+/kVGTHSUWcI3PNIb8sPKrt59xc0sQzWZYybEJh6Mg6z2eiirB+3gf0B5Y7jp+MuhLXtvSaLTUtxIfSJd2omevg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e8lS7TSg; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYmbyKHfizggFWID3C3VqFDu77Z+rZklj/24w0Rh3/kNHpi8ZHiTyAxGna3Njib/ojZGeUzMU/hW+O8hjvKPulTCEpSbatCpus1d4iPWyVsy1I8Bf/I2PMu0mA0ANUVVDyRqjmuAa5Nxo+kfuPb8lR58HcPJkYqiFiyDYowiokaiMlCaMwMmJdwtsktUnmuFRQmufdt8cWkI14pJ179VJd+oPgyJBK4ad8djEoBaLh4qyEwWVgydexE/cYV9EvxFWJY2uopEu4+bhJYg/eGbxqFxK5on9oZgiokjXIeK5TuFcbbIzGnzM1Wz6MCbL0m8kLbiBw2QSbJOkJOwnPs3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWEJj8S2gFidF5AkZI8EogrgNXuKX9P3ObB+HlyzvVI=;
 b=AR6fqD02JgN1LLxqxks695aUVC8JwBEDNVNcrkDdAPtG0GpC2UtYn0Fkdo+RzGLY7pZLp7PQ/4GqvPneILXaO8TW32XydgMpv0zG3QSzZ8JikgESqDYKczv2sE29tExh5R8qwTDh6kBNAVYNAqDNAxQYHstZch9lSZnU0hUK+FGiogVH7VYzk8PQOp9IqdB0tCPsQJMyj0HwwSoeT2AllL8AdQx6sEQNGS+qhS05QXwHI0als1aKOaZhofCB3GMORpBK6fdEftB4VUKPg6jwE08vUgXf/gTC8qGvCwLl7l4O4mOmIFdtCMr9I9ZxKTOLDAr1knp3sOLc/w34V7hjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWEJj8S2gFidF5AkZI8EogrgNXuKX9P3ObB+HlyzvVI=;
 b=e8lS7TSgMJagiBMRiKWz426Pbrzt99H5NsJLuoIb77omFLeeqgLhLQMv71ocL6NrRtAkEezZOAegJ2Nw1T73Bh6rc/uBN6EaruprtDTNy3iadrt1lMeNlYdSLH8ew840YAOKSYZbBIR4iobGKEZYmCoRQZvNCQkVDI753dXsuYadvRSuybVHBvzaFTFei3uQsaKi6Z+WOwbEIBg3XfyTWt1RX90NxWodJ0n/WKnTPD7adr8kZtiYT6Z3bk7aiJymzLq4QJMLW9EF7aKFnx2OudieOGmnWx0icxw62o9FlFncwp0Kz7BLWgKonbyvP/Wf92+3QPfeKKKgzbvlxS69Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:42:41 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 10:42:41 +0000
Message-ID: <58ec9a04-8f1f-4367-84b7-698348690df0@nvidia.com>
Date: Fri, 7 Nov 2025 10:41:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] soc: tegra: Simplify with of_machine_device_match()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-13-d780ea1780c2@linaro.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-13-d780ea1780c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0100.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8773:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: ba89b9e3-6493-4138-ab48-08de1dea4f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHd2UmtoMWJWc29TSkVPUTd2MjB3SC8xNWtTdTNiY3Bhd0YyblVpMmRZNVZl?=
 =?utf-8?B?SVlFbzJUNXRlNTJ1Z0s3NmJVcWR4ZXhGOWx2UjhzMlU4aDhOaEdiUk14NUYv?=
 =?utf-8?B?M1FzOTlKckd3Y1hkOHlNbDBrMDJMM1M5NHhMZUhGMWU5MkpCNk5VWElpaU96?=
 =?utf-8?B?RFJRMEFsQ1BaY2Qwc3d3UHJNWUxWMk9jbDl5VXZ4bWVwT3RrZklhdzhxRnZj?=
 =?utf-8?B?Tm9mMEYrcmtEb2tkN1lsbi9NYzVhZFMzQzQ0NlE1eXd0SnppTGtRdzZ0YUVx?=
 =?utf-8?B?RTYwbTlJUWt0Zk8zSjJ1eWZHbFdsTkIrVGVVMDgzYmxUTHRrNGZpQjhQUFBt?=
 =?utf-8?B?Y1hhMWg2R3BiRTdPb2dIQWpJNUJtdjFHK1owV3pWeFRESHowRmwvVE9mcEwv?=
 =?utf-8?B?WHFMNE5OVkZPd1VKQXlCaXBrV2VnUTBjeFFvRDNtdDZHdjcreFMrTjd6ZjNY?=
 =?utf-8?B?QnVqUjBtWDEraXcrb0VwZVBUUDZxZmlPb0pNTU9PaVVSeXdDVjIvYlV1YlNj?=
 =?utf-8?B?OVErMEdXZzc3QmpNMFVxNVNjbnRVU0xLTFp3MlpTR3BGck9VSGpwd1hLOUti?=
 =?utf-8?B?ck1QUHV3OHpLbWxOYTM3djAxSTNJNnAxWk1UZ0RPODZtSUx1Z2Y2Y1JzVmdl?=
 =?utf-8?B?UzhKWjVKT0ZMTFQxMDFISzBPV01SaTdhT0JHOXU0Q1U5UURJWjJTSFpkYXpS?=
 =?utf-8?B?dTRnekFYS3B1Y1UrbWVNWnpkbjd0Q1dJaTJGOGQ5RlJKbzdrYmEwQ01tbUlp?=
 =?utf-8?B?NURJU3ZnblRnaStwS01VNE9acU1uRGRlbnJvd21udUg3ejd2N3JLVDEvSVhE?=
 =?utf-8?B?MzI3YVU0NUE0bkFXRzRXeVYyMmpTdmEwV0l0cU1QN2NkeVZQWERsbmE2SkVS?=
 =?utf-8?B?MDg0RVlxVnVoUWwwbmp1TDdIRjVlZ3B5NkM4MFZFR3ZNay9SQ2loM2RscE1m?=
 =?utf-8?B?c0hNRFI2cjlCZXF6VlJPUWhaMTFjRjBScGlQRVVUS0x4aXJOaEV4MVh1NTUv?=
 =?utf-8?B?RE1qcjJod3FPdU9JdDBUMWZ4Yk1rS0lkMVd1MVhKN1htNENrdE5wOFNxc1dH?=
 =?utf-8?B?NEpGSEZlZ0RzdEVwUHo3ajIrek51eGhGMjVLSU8vNzN3aXlMdnJvRkVUbnho?=
 =?utf-8?B?bjdFZ0NlR2wwOUhyWCs1alBlNHVPOGNXT3BVNFpkYWZja2p4MDhuN1NIWVBj?=
 =?utf-8?B?S0c3bG4yUWJ1bUphOWdFQlNYYUF4dWhZMFk0VEZCWXl4TUsxeDhEdUlRbTE2?=
 =?utf-8?B?ZnRyTUVwb082TkhrQnp4aXYvMlFqVVJRdXpYL0xPY3lNTlJkNFptSys5Rmg2?=
 =?utf-8?B?V1ZEOXJoYUFrUE1GdFVYbTcxdXV1L3hPY1NYNEV1c09xVStKYk1kUGQ0VGxM?=
 =?utf-8?B?Q3k2TXZnM09tVzBpVjZxdVowUFhVUW1HZm1BOVhhSXdoemR6Q1ZiU1ZwR0tS?=
 =?utf-8?B?aGk0VGxXVVNKZ2hIVEFzbTRUb2VXcDlKSjVvZTl1aUpXZzJWWWxvamIydmUw?=
 =?utf-8?B?SXBVNVViVXZzZEVBOXBabEZoa2JQN2d2amRUMGtqK1ozeFhwWHk1K2NUaUFM?=
 =?utf-8?B?NlBRS25RZHltYWFFWHZNMEFLaHU4aThudFNMRTZrRXNFbHZudzVORmxhdHpZ?=
 =?utf-8?B?ajMrQ0FuR0N4aGw2dW1qdktqdVF0UzVCdVJaV1VzWGRhSzhHN1YvUUVKOFpk?=
 =?utf-8?B?WmZWQW1FWWNNKy9obEMrU09PZHJTd0VlU1pZZEdWNWlXOWNuYzkzNEVLNmt5?=
 =?utf-8?B?cnh6SDVZWkk4dTRvNXhjZG1zY1BOOStMTFB1L1JVYi96NHdxRWtRekdWZ0s0?=
 =?utf-8?B?bUxSZFY5RUdkeGV5cXJtdEVWR2xXTGwwYmQzMTlEc0J0aGk4U2lWVmFhMTVP?=
 =?utf-8?B?bElQVUZTNnp3T1pPUEN0RVl5cjc0VFpkR2hqOFd5aGdiRU9VTDV4MEM4aklj?=
 =?utf-8?B?ZlNGZFBNNjdUM0tIRGt4RXRQNE0xVlcrdTBYZnVOWjFUdGRkbVdaRXowL1RB?=
 =?utf-8?Q?RMTM65PWe/Q0zAgk9ro0B0zmfZg/g4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFNPM1F5aXNDYjUxMm5YVUVZQ0VqeVNDOFJ0dUZuWm9OSXlmYVJJVk44SXlH?=
 =?utf-8?B?a3M0Y1prcjcvL29FdG1jcW9kT0lpK1ljc2V1MUFMMkxVVVVUR2JBUWpQTXRF?=
 =?utf-8?B?eHJwc2xsZHZGOFg5M1JBSC91aTV4RmdFUUN6NlY3RXFnc2NSRlo0SnE5NUE0?=
 =?utf-8?B?cHpHOFQ0aXdxTGpSSDZ5djNQTFBTQlBTdVJ0eTl6N25zajliTWhEMjFTQlFM?=
 =?utf-8?B?R0lqR0UzQWNqRE9FU2pQdm5UQkFYNGVDTWo2eUQrdUx5ZExmTm1oSzJ0UGNJ?=
 =?utf-8?B?SkpNa3hOVFFTN0dSTldXWGNiUG9Pc2VSOUVVc3pXWDRTOERiRDJrMFhTNnJO?=
 =?utf-8?B?K0pjK2EwWTRvR090M29uYkk0OTZlM3RLcjlOVlFLTjNudEw2RlhWOHYyT0pW?=
 =?utf-8?B?RHk3a2pYRHV2L3lMV1VUeVM5R09wdlBucUZHdE15eTdtbnZHMUIyZm9zRVVj?=
 =?utf-8?B?eXBaWG9vYVI3RjQra2dHMUZaZHdSdENrcEYzRnRuL2FOTVRUN011VTVLTERC?=
 =?utf-8?B?UERKOXdPOFBhdDdBRDF1S0ZYZGVIdkJVWjRIaVpQTHZFM0dmYVprSUNTdTYy?=
 =?utf-8?B?amdjaVpKNFV4OVNreGdncW5PSGR1Zk5yVDZKbjdhemlMUkwvM1JIYVhHMjV2?=
 =?utf-8?B?MHJHeW0wZUpIelp2UXYvNk5qd2hZVkZodXhjVnFESHZhRFVnZ1Ixa3l6Rm1n?=
 =?utf-8?B?SEdMSGczRElKR2lpL20wTHNxMXZmTXFqTUw4Y3lQaDd2clMwS3BGbWdoLzd1?=
 =?utf-8?B?bjJLQUFiRndZc1NQbXhQWW42Y1c1c1NMYXVHbTM2dDhST3dQWlZ1VUhUcmsr?=
 =?utf-8?B?SUNPYmxXWTFiNUY3VjVwQzRmdEtxWEFpRE5NZ08yamFGN1JMOWtsc0tXcFFy?=
 =?utf-8?B?YmIxd2d6TVFKV0NvM0tScEhhb0ZEZVUySTVEU2JYTnpXQ1M0VkxqMXNXVFVY?=
 =?utf-8?B?UmdnODMwS29NeXE4NTNxUUw4MXRScUJDRDJ3UWYvNGF1dmk1c05mbitZcExB?=
 =?utf-8?B?RWN0dzRYdE0xMFRidVdFSDlmVUxmNmFFZzlYeDBlakJzK1NUd0x0ZlBsTWhu?=
 =?utf-8?B?THQ2aFBkd2xEWTVmODFnUFN5OWVDbDMwYitvQXRIMURxZ2EvZ1Y2aTl5bUtp?=
 =?utf-8?B?YlJRMldQK1BLRVVFb2MrNlN4ZE9YVm80QUpmQ0hpL2VrMjRSejEzc2w4cUgx?=
 =?utf-8?B?SU1pVjJIZ1JoMi8yYk1TbzR3S2VMczhlNWg3R05JUm13ZXpQTVNMbWRTSEd1?=
 =?utf-8?B?SDRnTkdNYkI1SWZpNzZ0bHBVT1RjV3VZSFNBSVllWnVUeklUUVdGT3l1Wm9K?=
 =?utf-8?B?U3VidGYrMG5jZ0NIL0pWUUpuQUpqSHVPSVhWa0R3RkN4YVdTQzQ3OUNpME50?=
 =?utf-8?B?Mzg4ZGhLOFFNY0N6dnZ4MGE3YnJ1NlRPQjZ5V2FIUXdMTDFSSG1nZVNidTZp?=
 =?utf-8?B?SFQrODRWUUZtWUREcDV6Vkx6MENPa3VNR3h0SUNtYU0vMExVMTJLUU91NGc0?=
 =?utf-8?B?SHFqNnlLQ1U2SmdoUnFtZ2ErN1BmcXpONWlnRzM3NXZlTVZsRFQ2T0l0YWl0?=
 =?utf-8?B?bHBaZ0habkRWQXV5SGt1bkNYZDRzSFZTOEcxWmZlbmIyN1I5dElRNGtmaTVw?=
 =?utf-8?B?NnJpbkFhTVZwSlo5MmNSQkM4NUt4VElKZFlsNDBSMkphQlB6emU2OElySUxa?=
 =?utf-8?B?elFIT3ZYYlN5bVFBTVc0YTBPUElQR1Q5VFc5UEpsNXUvY2FOOE15NWJsK0kw?=
 =?utf-8?B?NUYwTkNTNStHUDc3TFBETWxBOVp1RktPMHlENVZLL0Y2Vy93Nk5ldHIwM1NV?=
 =?utf-8?B?MGE3LytRYlNqeHREZDRYdXp5VFdxbWdYSkdyUWN5V283VUxrcnVwS2lJaVJE?=
 =?utf-8?B?cW9xOVA1OVRsMWRTblEyREI3RjgxWitVaERFUFpiejBaOElEaytqVHkyVEkv?=
 =?utf-8?B?MTVUb2czQUdtU2N4b1hoNE4vRlJtZEpOcjlnR083bExNblFwRnIzUWQycHE1?=
 =?utf-8?B?Mmd0WVRKeVVMdnd4TDZtRmF2S08xb3FaUUt5VTdsbWZhNVVPVFU5bmJXZHYr?=
 =?utf-8?B?YndNN0JGQjBFaEs1RFBMc3dpZHNWaHFyQVJFd3cyL1AveGkzVCtQeDhBejRz?=
 =?utf-8?B?elpwSCtiNzJVTjZCNWZLNElHUVNmZUovQWErbkNzOVhCQ0FGWkpYNXZ1R0tt?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba89b9e3-6493-4138-ab48-08de1dea4f9e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:42:41.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZNdlADb+O0I1KKNx/sMxoX4sgrp1viWkdS2tDJzjRkQv2duMx6Q/r2ImkVsoERfwy8HSuMzRPdCzPWKLBE6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057


On 06/11/2025 19:07, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node and matching against it with
> new of_machine_device_match() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on the first OF patch.
> ---
>   drivers/soc/tegra/common.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index dff6d5ef4e46..d82b7670abb7 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -27,17 +27,7 @@ static const struct of_device_id tegra_machine_match[] = {
>   
>   bool soc_is_tegra(void)
>   {
> -	const struct of_device_id *match;
> -	struct device_node *root;
> -
> -	root = of_find_node_by_path("/");
> -	if (!root)
> -		return false;
> -
> -	match = of_match_node(tegra_machine_match, root);
> -	of_node_put(root);
> -
> -	return match != NULL;
> +	return of_machine_device_match(tegra_machine_match);
>   }
>   
>   static int tegra_core_dev_init_opp_state(struct device *dev)
> 

Looks good to me ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


