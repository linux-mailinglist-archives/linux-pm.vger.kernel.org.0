Return-Path: <linux-pm+bounces-10737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4AD929BE3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 08:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD10BB20B02
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 06:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736A1171D;
	Mon,  8 Jul 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Sz6518re"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71011717;
	Mon,  8 Jul 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418712; cv=fail; b=SwaHdwp27gyoPdBhfQPqQe7WpJRPexs0+HVWXk8U2dqttTEjzYvt6KvCvSHWMyaPtQ1hsENm4HnXVgb1gLAAr+FTJKsCQ4p+daBHvGo5Rh7Qe1sVHykNKPu5xBfhdimRyLamAABGJbU3lPCUMylfC1/TSjIR7U0R3XB4CgBiS7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418712; c=relaxed/simple;
	bh=cgk/K79vS1DtZbcxBBxE6C0ebXcat1DDlR3raDlLg/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGWbeXVqCPikZHtjYoyizI4mfNT1kc1d/dvbCQ/TmWidG/zQmCza+XBpFkAs8/zNaKC8l7P8w+nty1XCjNoDjnka5gw/st9Gynp8tz3vKVgdrKCTtRpYsIRzcuR2En345c/MvnSPIPf0gTK9oNUvI5j6QMXfd5jTaGZdoiThzIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Sz6518re; arc=fail smtp.client-ip=40.107.117.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjIR5fDkKc1f4BSqmn8/NfVnq9FeyGFY/l/TTGkGfWHKy7dTn96LnmSi2LPnJE/KZ5yGC3A1UyYIhovyxnhEeDj/xldyJO0DRJXAAbPZm61rtgK4s35Etaz8HRDeE3mJ5XzUu6Il3wxSjGW3ImICIzJiXnP5S64WfkFU9CkVuatSkWgYyc38EIH1hKPsDqmzJbAonBiIPrS/vxDruncwKbujsfAk0CuS1mTTAVg7nhwpxW4er8CxUCtCiq/cNVI5hkFv6k9NM7vOblM5q554daheVdSW0P0pOIid+s//2LBekJvqx/oLbimKhqXMkBeSLFD0IAVDVsJdn7ILvF6W6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwQJHo1mnEeNrAiOJo3VB7YT3cKWMZ2AhKqMbWi0ojs=;
 b=lLnEEDZLzaKtYwjPtP2YhnYjp/2a2xujpCRD+lkT53gsTwcjxgm+n7iYA7tkkv2TVYQoNWRWtbCw8uWB+syffAjLQ3Gxnj8KLu01WNW06TWka+hhmCy1NVqN7xUHYAGZKSCh2d7p/ZtzkXw5jcceqnOOGUffOdFOV8mlEZYjXbtomGnmwpbtcY/UaZWZ+ofelQR9a3KDxTS936KBySM7ZdIL82am41lV/WRyUT+z1oY8p0L5bxnV+MZmAduZDnwC8CKHrhrAB+TjvvUPUSBOHJnCxuve0B8XDBInQUJzU33sqMJfNdTSZo1o94HfJ+JFshHyfCz86UhxAAw4PRSvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwQJHo1mnEeNrAiOJo3VB7YT3cKWMZ2AhKqMbWi0ojs=;
 b=Sz6518res7z8iqgZZfTnd66zLqTxH4hqEJjRGZG8qiN4eExVZMT0dYAjTc7hNb8Eos9vUC4v9OY81pDI1LcC8sY6CoH17126wZL4iA4fneuYN/M/YhYcMqyCFZvbVt0tG/Ye81d4JMeMmTgU4JJAjHRFc6abE/L6XJLmXO6b8TEp/+Pz/oBj5spMa6CBEozfzs0AKCg/+yY5aKOxRonz/leSV506ER+dt4LZPGYfzvoYxAOhv7RrIGcGR0Jtsup6VqMwl+RARC7x0RGSWHD14QE9x5CixlKOM6anrtSA1XHL3Znl2trjgD43SfstNoGjRiFsJYjwe4nxwpqziOUSwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by JH0PR03MB8022.apcprd03.prod.outlook.com (2603:1096:990:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 06:05:07 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:05:07 +0000
Message-ID: <9c550278-2205-4663-917c-c303c65726ad@amlogic.com>
Date: Mon, 8 Jul 2024 14:04:44 +0800
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
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <a4d08999-55ea-4674-bb0f-6d618b7bdea7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|JH0PR03MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: cf08dc00-ddf4-4a55-1e14-08dc9f13eaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjZDMlZIS2JkbEQ4Q0tnZmVKYlRUQlovLzF1ZWVaVWtpdlk1QXpRbldEVVIv?=
 =?utf-8?B?eDR3cmEzYUVwTjFwQUV1bjRzYkFvczZwWW5XNTQwRjM4UVU5dW1nQWd5SEFO?=
 =?utf-8?B?NTMwNEluOG5ESkxLMk8wRUNXVW01WlFDU1NydUUxQmk1SllpRFhPLzlRb0Fj?=
 =?utf-8?B?YmVFUUVzV2IrOWsza0RFTUorSEFIajRYQnR1Y0JQV3V6ZjVFOHpJUitBbmpw?=
 =?utf-8?B?aU5qWUJRNWxUVjZ1RzVpUFRCWmh5dko3VFNROFVVckVtbjhiMTdhRGVKcDE1?=
 =?utf-8?B?K3g0akt4N2o3SWxPSTVhWlk4aUFDUnkyYnF1Y2QrZlNQTjFscS84QU8xRUQ0?=
 =?utf-8?B?d2srWS9DNm5CS3dXZE1udnpMU1BpRlVxd2laamFjQ1gzaWZ4cGxBQ09obXBw?=
 =?utf-8?B?YVNzUndYdXRPck4wWXZDZUVJY0JJUDdXcDhrbjI2WEFsSGxUUTczRWtpeEVq?=
 =?utf-8?B?UGl0VFRVQzhyVFU1dVBSeVpCK256enZ0TVByV1VsaWMwTjBXb1ZNRjRNNmdp?=
 =?utf-8?B?d2FCYlhrQitxTFBVVFZSWU9TTjNURkhrREloT0hWMmxZMDZhSHZXVVZGT2Mx?=
 =?utf-8?B?UlR1YVdVRDZqUEFyU3B4MS9IMlY5UjNRbnZWa2dta3B3T3Q2WVpPUlJOUkRw?=
 =?utf-8?B?TGdyd3U4cTh1dVdSRXowV1d1eHN6MGlmazh0dzJKTEtZN2RsbEg2ZGxZcG9K?=
 =?utf-8?B?WE9DQ0JOeWwyeXA5cEl5SXhONUJOMUpuYUd5M3FqTzhSUE4zM3QxaFl5akxo?=
 =?utf-8?B?R2R2cGdRbEZDQ3JrWWdyWGdRb1BJSTg3N0w5MVJPNnRHZG5CK01qOGxpS0dr?=
 =?utf-8?B?bHUyS25kZER0ODYydElqU0JZYi9UbVZpbmNvWFFXWVUzUDM3Q05UU3hwVDhE?=
 =?utf-8?B?TXNnLyt3Znd6akJxbmoyRHkvYjc0bDd6SURpYVlReWRSa05SYVozd24vR1lI?=
 =?utf-8?B?a2JWY2JLNVdIQU5uYTU3T2NpbGR2cEgrTVhuenZxYlVuTzhLU0pWV3F3ZW9W?=
 =?utf-8?B?U29GQWtCMjQzMm9FWE5RYkpEZGYveGF4dSsxY0xwMGdZUXphZUlJejBMNlVZ?=
 =?utf-8?B?UlNnZTVaMm5hdE5BOTBNZ01MVnYySUE1ZHFNbVlRUEtSQVlvb1hlU25NRGhw?=
 =?utf-8?B?NVo0SE4zbGlEQW5tMzY2N24ycE16UVMxOUt1eU1NSEZ2N2tQdFpsRnkrU1Js?=
 =?utf-8?B?ZFEzcmhVK09zYzFpdlVTSXZkckM1YzB5UjlNWlY4emtXelhYRHNRM1Q5SnA1?=
 =?utf-8?B?QzhId2pTS0NGNlBmUGdsWG1UWGRVdGFxclBRV3pmVkxQM1BITWlaeGNnQ0hO?=
 =?utf-8?B?UlJ0V1h4bnZWYktwR3FnN0NDZkxhNnE3RzQzYzkyZlpPN29IOTEybTBON0wy?=
 =?utf-8?B?WnZLUEZSL0N1ZEtSN1hHTUdBYzM3K3VsVGhQSm0zTklVaXEyRXFsUUNweUpS?=
 =?utf-8?B?NHVzV0M1V24yVWV6cnN3alB3YWJYVjkxdW9VdUpNK2FDNFFNdU0xVnpMN2xN?=
 =?utf-8?B?QXVOSUREOTRDV3lqTDhmQm9pVlZWK1htS0VHdkd0R3FwUytHOWk4QktwU3p0?=
 =?utf-8?B?MEVyMGRsVEE3UnZwQnAwYm5veWtpL1JKN2VINkRMaGRXTjQrMDhuYnpQR0Y3?=
 =?utf-8?B?bTJNM0dKL1BTK0lETzhKc1IxbE55bGllaURDZHFjRmRkZzhsQmtrdk1MbG5X?=
 =?utf-8?B?bnU5NGlsbGQvemJrcElIVlluRmpSQ29Vc1ZZNkJYTWcxUXpaUXFINWdVdXVi?=
 =?utf-8?Q?wfCZg0iSuPdsQp8rhI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVN5aVNRNzJTc2NZS1VwaXN3dy9LdzNBY0JoZ3oyQmtiUWY3d2VYVm9aZFVp?=
 =?utf-8?B?cGd2emRQRGN1ZTJibHdHQlkyVy80MG9za2VpTU5CTkVTS205eU1uSitPVkx2?=
 =?utf-8?B?NnA3WXE0RVJkQ2JlTTIyaTNVd1BzNFNLMEFVNU13R08xQkZmRGRrOFVZZlpx?=
 =?utf-8?B?cm4zaGFVMi9OMWhWaElnTDVibUNJcUkvbTh0ckJVZEFLMndJSWZCZnVVT3c5?=
 =?utf-8?B?TGxPWS9qVkZGYWZwWE03L3drQmFMcnNCV0MvYkZURWJTZFJaN3FLMUdZUTRr?=
 =?utf-8?B?RzdHczRheDB5MGZiaHFkbjY2dWhORWdEUkhmNzJVZTI0ZmxQa1dPbGhkdmVU?=
 =?utf-8?B?K1haaUxaYkVjb2pvbXg3Z204S0VEVGhnajVuTWJ6aHZUS0xRVUVQZVUzdkox?=
 =?utf-8?B?a0V0SEVKcnpBeGxERmJhNnpRNjEvNVN4ZEd2TUR0VWpnM2dqRHA4UVdwU1F5?=
 =?utf-8?B?R0UwS0RkSWlLSnZ5T0FxeTZMc1NtQ29nZWNmakpLaWVkYytGMUY1aEV2U3Zl?=
 =?utf-8?B?NFoxSXFZL0dreDRaMVhoT1hXOGJqYnBoUG40ditEcjB4WDI1VHFnRVE2eDZW?=
 =?utf-8?B?b1ZEejBhbURWN3VhZXQzZDVzRVVLcW16dzlDb1QrUENLd3F5TFdBc003cys1?=
 =?utf-8?B?VUFZNjk3NXZYSUdqRzBITG4xKzBrL1B6ckI3WHBlQ2w3SnVDRUc4eDZIb1Bt?=
 =?utf-8?B?TzAxVDBrcmljM3VsNnJhbjd2MklYN2w1Yi8vekNGd0VQckdyUWpoMFZUc3JH?=
 =?utf-8?B?K1ZQSUIyQm5rRGg4MmdRMnh5T3VhbjZ6L3ZCVzZ3SmNTbnpSZEk5TGw5TjdY?=
 =?utf-8?B?bjBKMmVuMnJ1S2h4Z2VVcERlN09FOFVybkQzY3YrcUs5UUV1NGFJRWhQSEYy?=
 =?utf-8?B?L1B4dEZQZEc1TGhZTitCSHR2VTArVDBCeXZ3bkJjL2U4RlVIeUluK1V1VWpJ?=
 =?utf-8?B?WXBNYWNhR2ZkWmpCYnV1ZHA5QWhJVGphTE05UFZ3aEdNajA2RFNmK0RxWnJ3?=
 =?utf-8?B?OUxZNW9tY1EyaVRmU0txZC9xUDAwa2Ura1RlNlVEb1Bzd2M3dC9mWEVicXRW?=
 =?utf-8?B?UmhiSFBPSHl6RGxJQmN3TUVWcXpKNUVYcGx3WnJzcDd2ODcvWWJ3ME5EMDFt?=
 =?utf-8?B?TGhJSTNydEtHUzg1c3lXNUdkYitJeU9QaEVRYWp0WlZMRHNEaUp0QXkzQ1dh?=
 =?utf-8?B?LytEUjVNMVluRDBRb0RYbGdOeXhVeHoxeWVTV2hBWGJxTlN6YmZZY2RpU25w?=
 =?utf-8?B?Ky9helhpR2NMSFZsMXJFeCtGSjNPWS9GdWRGQ3VVU0NPeHI5Y3hTTncwb0gr?=
 =?utf-8?B?ckFmdStqeFo5S2JtNm15bEd0TjJQS0JTQmZQTndsbGN6OWVTQ0NTdlNHVVI3?=
 =?utf-8?B?eXo1aVptUldYKzBYeHAweUJ6UnlNbGtHY0pCclFES2h1ZDhTYmp6bXVONTFC?=
 =?utf-8?B?aERKL3RHWFFvSW9zZ1ZJd1RLdmwzYmRIQzgwYWovbDZkZExZNEo0ZGV2b1li?=
 =?utf-8?B?QlFpQXFEb203SW0zcitTMTltM1ZZUlFDTk95cmlJUXBCelFteG1Pa2VJSFg0?=
 =?utf-8?B?ZkM0bk1oZ0ttYVV5aDF6YU5pRGlmWnIxVTJnNkJucjJmSXhFbDNMRjE1T05C?=
 =?utf-8?B?Vk0rakNoc004VWRPYTg3OEw3TjEyM0dSU0FRUnkrbS9oeXpoT1dKc2t0a1l6?=
 =?utf-8?B?ZndOVU44ZTJWZ2M1MXpzYWw0QVVqMmh1RHNRbnpuMXhRM1RqRGJmWU51WEhB?=
 =?utf-8?B?RUIyS0hybDFwb29YOXptaEJrTG03KzcwYWcxc3ltNXUrTENUTktvemM3Z0RR?=
 =?utf-8?B?TlB2a2c1MUg3cFRDZzNVaTJ5R0thT0x6d2M5bG8yYVFWNXAxd2RsUXpaaVFC?=
 =?utf-8?B?RFBwamE1ZkFLdXpDU281UExyNER3MTBvSzBFeUZvaVJBdytwVUUwQ25YdXpR?=
 =?utf-8?B?c0RDVW1kcGlObEdYdXNUYldReC8rSUFjeERUU0xIWjZGbUg0VXVYMXVqZ1Fw?=
 =?utf-8?B?Kys4cEN5R2NablRHM3lFcVAvYmdGaUs0bzJCWG5HWVZsWm1hNFh4ZHY2dzVV?=
 =?utf-8?B?dWw3a1pqMUc2WVozdzFqTlBYV25ydFlFbE9CMjE5ZDJYSXJPSVpNOFZ3bTl1?=
 =?utf-8?Q?3ZAk39d8ZJJytg2PojIrQz964?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf08dc00-ddf4-4a55-1e14-08dc9f13eaae
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 06:05:07.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTRukHcyCQsFI2yKPI1fAEgnoes1f2HRXIG1dR9xQC9GVQ52HKPJJQ+gNyMglHxlGDok0NPj29QZW26NfUYLzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8022

Dear Krzysztof

Thanks for your immediate recovery and careful guidance.

> On 05/07/2024 13:13, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add binding document to introduce power sequence of
>> Amlogic WCN chips.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   .../bindings/power/amlogic,w155s2-pwrseq.yaml      | 62 ++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
>> new file mode 100644
>> index 000000000000..f99a775fcf9b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/amlogic,w155s2-pwrseq.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic power sequence for WCN chips
>> +
>> +maintainers:
>> +  - Yang Li <yang.li@amlogic.com>
>> +
>> +description:
>> +  The Amlogic WCN chip contains discrete modules for WLAN and Bluetooth. Power on
>> +  Bluetooth and Wi-Fi respectively, including chip_en pull-up and bt_en pull-up,
>> +  and generation of the 32.768KHz clock.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: amlogic,w155s2-pwrseq
>> +      - items:
>> +          - enum:
>> +              - amlogic,w265s1-pwrseq
>> +              - amlogic,w265p1-pwrseq
>> +              - amlogic,w265s2-pwrseq
>> +          - const: amlogic,w155s2-pwrseq
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: clock provided to the controller (32.768KHz)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ext_clock
> Drop _clock... or actually drop entire clock-names, not much helpful.
Got it~ will do.
>
>> +
>> +  amlogic,chip-enable-gpios:
>> +    maxItems: 1
>> +    description: gpio specifier used to enable chipset
> For entire chipset? Then enable-gpios
Yes, I will change "amlogic,chip-enable-gpios" to "enable-gpio"
>> +
>> +  amlogic,bt-enable-gpios:
>> +    maxItems: 1
>> +    description: gpio specifier used to enable BT
> Follow existing bindings for Qualcomm as example.

Okay, I will change "amlogic,bt-enable-gpios"to "bt-enable-gpios" follow

Qualcomm's example.

>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - amlogic,chip-enable-gpios
>> +  - amlogic,bt-enable-gpios
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    wcn_pwrseq {
> No underscores in node names, generic node names.
>
> There is no device as "pwrseq". I also do not get what "wcn" means here.

Yes, I understand.

Can I change "wcn_pwrseq" to "pmu", and do I need to change the binding 
file name to "amlogic,w155s2-pmu"

> Best regards,
> Krzysztof
>

