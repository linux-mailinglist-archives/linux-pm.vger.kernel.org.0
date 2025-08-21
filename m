Return-Path: <linux-pm+bounces-32778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E614B2EFFE
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C4A3A2FFB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236F280CFA;
	Thu, 21 Aug 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i4AWYWL3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EDF24DCF9;
	Thu, 21 Aug 2025 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762163; cv=fail; b=r/+wtPEIL6u/J6ZzaEfHapNoldhSx+NVhIb3k4My1gCplqFY3lgdVBJagopchTGiGKQGFu1RbwRt78wV7W5iX3wcFB9xb7PIRoSq5daMWKIlAUO5uF2Og75uXxsy+jNgl5W0Fs5gNiFv+CN3uoY8UrhllD7LNWqsVgus6dhv2j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762163; c=relaxed/simple;
	bh=d+9rG8PVoFXLxok4JUE7eKueXe5J16zRVIKHgmMbWlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElXvRbthQi98zYs/S4VN4PJ+3KWN7OLmDXMYWaTQSNyWCzDcWOe5ENWhk66NWvXVXhJEaYgMwdBFr1LjuIt21Qg7kDf602yid81e1o5EttYfTz3Ql1slj2Xx9Hdf15s26Lkj5x3ovzIiFQghIASML0swGLWkhwUS0IVGylUjIx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i4AWYWL3; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt6yHO867xZDzCwD5l7ZuUS0hFard4V2MKd+EzYzcjzu/q+DVanCxjIBVIOsO6MgChu4n9KGRpioadk6wWnSm7t5/g2+nZNZVrpLuMQnjY80J+Yg+1GQcTXffdSwVTCbkcBxs51hUIJBSkfCzifWq+1TVe0AWCgydBWRD/jR4C2m5kvYvyLbJIkfEfZFGaZbb8OObOMlt6JPG5aYifMz1U6TEPLsUiB7aePsZp8JNbaifFUKw3XE27p/EOi/zv1FGF64lLwNJSOYBGyDSPsPiVm42Yd6I+887wMmntyD4RMKNjT6+SNIk6xI81bRmFkU1kcWW7rO766X3K5c1qId2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXTnV2bHD78bdhNHuSIkA+TtQ0Mm0AUpiVi2o1Bj6ms=;
 b=wJPhIrY99lwhXy8ZtgO4Q5+ZlEf6ZMaBvx1K16OIpyoIny618YtVa+PST4/Aygopyvnbj/PY1dV9EisWptBfO+sQ8iTr7DwFSpsXN/6nAc17r+IpaRH+FDmHNZSKQJeDGiB1ZT0/af6zf1Jyxt4ELNNGNdGR4YjW5GNjDFCZSNyLMqThf8BomZ/8pyCPCp/G+oxk3szdC2VJmLDw/ExLG69pm5v/kPLeilRSAZD6LzlSftM1bnm8ryyOAHTmqN8c7NADjpo6G/GQn19qga8RPs53xEyPdBVPmxK5IyUBXrvwaaoIdNCGTyLAWulR6M0saP1zlmXYx6ILvUYgZZigMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXTnV2bHD78bdhNHuSIkA+TtQ0Mm0AUpiVi2o1Bj6ms=;
 b=i4AWYWL3AiqglaNzUaqkwcD6ZLf3f+6n4apBr7qDTzNhs0zrpAv+3U2ZdKtUQpxADHlDga4n8fZX1qzv1xwGT0JMymDiwWxC1ZSq/0/SZNbHuo3nFAxqO1Ga2Q71EZN3zMHaIrCze1oEyLSjd9048noqsegAtyHEiN6SV2VBxj9G6QvBqhj4eSetNs4cjG/vjcb8CkxL/utp863mT0r8ktwFc8DNZ02HZE6SHOCBcdBC7RJFiTV/+TPhgYaC/pJc1vh+i6d5AYkApzmmeV7DTrZyF+Qpgu833Xdvydw0dCTLuioNZNOhLmHTCW/tfcrC6FkZ9zrQ+54Mf/nSfHjEjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 07:42:38 +0000
Received: from IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6]) by IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6%7]) with mapi id 15.20.9009.017; Thu, 21 Aug 2025
 07:42:32 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 3/6] thermal: tegra: soctherm-fuse: prepare calibration for
 Tegra114 support
Date: Thu, 21 Aug 2025 16:42:29 +0900
Message-ID: <22816196.EfDdHjke4D@senjougahara>
In-Reply-To: <20250820114231.150441-4-clamor95@gmail.com>
References:
 <20250820114231.150441-1-clamor95@gmail.com>
 <20250820114231.150441-4-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::19) To IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6484:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f1f577-a639-4b8c-79ff-08dde08649e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUJMcXhGL3JzckVTbjk0d1JWdGU5T2FRMHNMWHBPTmI2a1dsR3cySVBENk1F?=
 =?utf-8?B?aS9LWkFvMXhyd0k1MkMwYWcwbHlzQVRBQlQ2aWxqMXpNQ0dnZUdLVmNYOXRk?=
 =?utf-8?B?MENMWXdZdEVrRWxLa0szdVRFY0o3dndxM0xDUXJKQVQvN2JQd1p3UUdpS01Z?=
 =?utf-8?B?ZVZDeGVYMjhiUWR2SHpVeG5rMndvTUx1emNaYnA1VitRYnNYWVErQk5tKzV3?=
 =?utf-8?B?UTJVNUFEZ2NNUzN0SHUxcGJFdm9LOVlrNnJ2Vk9lWEhqeTdsdE56TDdabndO?=
 =?utf-8?B?N1IzK3hDMUxUUExnbXpNTklubFIxT0psZlNLWmJwbGpiRXFHbHJndjNGdHJM?=
 =?utf-8?B?V1plSDlTMWJCeFRKbUowNGhHeG5BWXgweUhWVWJtVzBHSm8rOE43Ymh0T2h4?=
 =?utf-8?B?TGg5TWZ2aTNBVDRuR2E4Kzg3Y0l1RzJaNGNjaUNBWTh2d1RVYXJsRS9yaDdZ?=
 =?utf-8?B?Q3hSZHJpVVNzQjFZZktTVUozZ1Z4UlBKanRyUXh0UGFKV2hxUlFnclNnT2cr?=
 =?utf-8?B?THk5TVpZWHR0Vk5IVFIvQkF0RHFSbE01WlNCTUljd1J2M01wbkM3OFAwa3Fn?=
 =?utf-8?B?d2RUa0svc0dQQ3RMVjNIS3UrZ1BkZWxLcWN1Qy96OWQ3WVVHTVRKRi9QbnZu?=
 =?utf-8?B?NXd4ZDVBZGVIcVo4Tk1vN2ppRFV5RklCWWJjN1Y2SFZrQy8yNTBqQXRlU2R1?=
 =?utf-8?B?UU4zdjc0Yjhxczl4RXNTMWV0b2hvbTM5QjVWMmJVc0lSVWxJVzhTSTVnWWUy?=
 =?utf-8?B?aFlGVjdsaE1Bb2VDckIyU1BjV0hCSzFVZkIrU1NqeFhTeHo0WXo5SHlrdzdm?=
 =?utf-8?B?R1drL0E5UExhRDFKQWRzZnA4Y1BydGJqNkxWbWNCVEk4YW90U2tsaVBEV0Jq?=
 =?utf-8?B?dE5wZHJpYVdSUXpvWmhDUDl1dFAyeUw1NU1VUlJyeGQyeEVVcmNHY3Boc29h?=
 =?utf-8?B?aEx4T2tpRUtEQkowMU9MUHhrNHl2aWlpZGJtVmFXZGNMNGU0SGg0MzBJb0xh?=
 =?utf-8?B?eTQ5VjRWNGltUWcyc0UyQXRHZ0psMVVVWUZydllIUWlsT2VJQmd1RStLckNj?=
 =?utf-8?B?MHVaSXNZaFpPSG9GSkZ5S2FQb2d1VWJjRXNFbCsrL0c1alEyeW1ETUplQWI0?=
 =?utf-8?B?WU1WZlR1cU5oNndRV1IxSW9TbC9yU2owNlRmanlPVWJ6Uml2VldIOWtyWTZv?=
 =?utf-8?B?TC9RU0tTcTVsaXpORS84bTF0Q3J0ZUtHOUpoTUd4Z0R4T0N3YTB4TFFaVFFh?=
 =?utf-8?B?R0xUeXhXZm9qdmhjV2hYY2hkTDJ3TVJpWkhtMHdqcGRoN0VRY0kwcW1KdFR6?=
 =?utf-8?B?a0pzTGMweU9IUDFUMlZZUWNxTERDelRRRHpnUWl4UldlVElRRk5taDJOUSth?=
 =?utf-8?B?cU8rakxzT3dGUWFnMnlSN2ErZC96SEdyKzJxZmlSdXFIT0V3RkFDMi85eTIy?=
 =?utf-8?B?YUhPUGk2MjBHMzdWQ0ZtWXJxQ0FBVFVoU1hOYWVoczNVMVdjUVcxanF4cVlD?=
 =?utf-8?B?T0RkS1lwWVo3UnMwZ0djRmFlMlJLVEdhNmlVOXlaaWt4VE9JL3ZwVWRmaExj?=
 =?utf-8?B?R2ZEdy9qbXJpa1FxNU1CcnFGWS9MSHRDRVlFRGVEZGJ5Z0ppMjcvaEg3RmNR?=
 =?utf-8?B?OEVvSDNvekg4enJ4bmNHbDJjd1MzL1l5a1lJSXoveW8vM0RFZFZyTDVEdnRW?=
 =?utf-8?B?TFZiaVl3ZDVDY1llUW5uNnpqWlgwaUdoQ2lFUTJHbXBhbEJ4QVU5Vy9OK0JQ?=
 =?utf-8?B?aGpuekdLM0tnMXM4YU0yeCtwN0U0a3NZRXZhQVpWS3NvODZoNC8ycVJBbUhR?=
 =?utf-8?B?QjlkUWFJQ1ZYZzAxRm9xMjdINElDbDNNdVZQQnhrR0hMb0pqNHkxTXplRDhn?=
 =?utf-8?B?djliSGtZU3c0b1RoRDF0dlp5dzB2MTJrcGhjTEg4Wkxycnowb0Z2V0xLSGpN?=
 =?utf-8?B?c2pVV0U4aS92bGFqd2VFUVhFWStxODhZVDhIV3BkTHJueitXMEdGUnh5VkFk?=
 =?utf-8?B?QVB6UDhxenBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6484.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUtGM0h1NVdWaldhcUpMand1MlRZOS9KV1JRWDVDMThLWEQ2clNYVThZSEtZ?=
 =?utf-8?B?aVU1ZncxMmJDc2p5aWtsZXJ0YU1zcnArc0srR09XUUZBNWFvU0FzcGVWODBm?=
 =?utf-8?B?K2FQYUY3bUJ6aUFJdXRXcEk0ZjRLZHd5emsxV1dkOXduNVRtcDhXbjhRUjZ6?=
 =?utf-8?B?VDBDdmI0dWlxRlIwNFBBY2JVZm1acnlSdldnVDV1RXdCeWxZK2ZEQm5UTnJV?=
 =?utf-8?B?bzhmRWZRbDYvQkpEWmtOTGJQYk5XRXdaeXFiYkpsWk9LU0RTWVAzK0pYejZu?=
 =?utf-8?B?OTJCMnpSUWpGY0Ixd1F6UG5NVXY5cWFMWmFEQVkvTXJjaW5USkZMSzcvY3Zt?=
 =?utf-8?B?VHFVUkNMWTNGb3RQOVdYV0lEaWlkblVNVDRuTWlOa3hwcjJYOVRML2Ntd0M5?=
 =?utf-8?B?TG5UR2FmemlaeE9FdWFtcGdVU1F2UGxQd1BUeGM0cHJ6VTRJdzJ2blVFbGhV?=
 =?utf-8?B?USthdmthNmdYYkNqTm5PM0ErNTZOZmdQOUl0UjV1enZaNlA2YUljcFV5KzJa?=
 =?utf-8?B?YkZSSlU3VGZvNHU4R3VvMFphUGRQSDhUSUNiUzFQNThyVUl2MTF5ZDRJM3Qx?=
 =?utf-8?B?eDdybDZ1Mm96RXM0Q2xpODNBQitGTWtSTWE1K09LUllNTjU4a1VNK3VpeUVx?=
 =?utf-8?B?VU9ZSEw4K1JuRitBL3V6aEJ4MWVSbE1CaVRXb0p6amthUGRlaEhrNzk1Ymhj?=
 =?utf-8?B?clNBYmFkUlllMGYzeHp1eU80VkNkN1h6VXB3WmZEK2tPSVNtY0MwUUdXSjBT?=
 =?utf-8?B?RGx6Q25ndUM5azdxLy92RGZqemdXYkpRd3RYTFVkTUE1MkMrU09pZGZBMWIr?=
 =?utf-8?B?ZkxCMUxWdEZmRW9jV1NIZm9sSmJBMldDTURGSytkRHF1T2Y2azVWdXhMZTNQ?=
 =?utf-8?B?dlZYVUFOK3RyZEZDWlF4SWxaamFrTVU0NHBwTW0zT1hSaVFDMDZJdVdaOE1a?=
 =?utf-8?B?VkM4YWgvTmNIQTY3Uzd1aENDU1pBNjBJdnNXVHNiVVczb0UwQmxKbk1hM1JE?=
 =?utf-8?B?RHM0OEpXYjF6NWI2OStKR0ZPbkI1L2t6eHhkMkdOK1Y0ODJYdy82QmkxTmFi?=
 =?utf-8?B?YTU4RmpkRE9PZTIvN0xuR1Y3b2YwZE00c3pOREdmS1Nid0tHTStuZzMvQUlF?=
 =?utf-8?B?akMvN1JwcW1vNzBBV1dUbzR6RFBrOVh4bnpnR09YcHJmUzluSXRGWHZaZFhK?=
 =?utf-8?B?dzNQZ01TL0hVRnVqc0Z0ZHNDTWxxR2xkM0tUTWtlaFd3d1VNNlpGSi9BRnI0?=
 =?utf-8?B?YjRveWlEUFJ1SW8rejcrR1pCK1V0Z01sNFEvUEE3YTVEMTh6N0cvTCtOOUlE?=
 =?utf-8?B?SmlRejVsYkNHUS85YWx0REpvM082R0pkdDlQZzFkVzBkT2VxOUxXdDdxR0l4?=
 =?utf-8?B?VndkbXZKQnJpRkhCZkdmU0dHcUNwNWVnRzlzTTU2WmlhcTZNMWxxL0d1OENk?=
 =?utf-8?B?eE5YNHNHVGl0SjMrV0lrTHpGVHRlWG1kQVNaV21xSWkzcnJyQ1NJRUlxZlBN?=
 =?utf-8?B?UGJOSCtaQjYyQ2FXS09JTktLeVdDZ1BQclBDcDNyVXpSTUVlUHZic3lEY2Y5?=
 =?utf-8?B?OEhRQlJVbE1EeDFsSnY5QlQyY0pUTityWVpjdTBxY3lrWGx6VGc5dmNPZzdN?=
 =?utf-8?B?QmJwQjZpZ2FWNE5wV054V1NJeXRXajlPMWkzZVdnUlEwUXV4bUx4eldKN1Zv?=
 =?utf-8?B?d2xkcDFYcGh0eGZCMlVCYkQvaDhLdVA0ejgwcVhiSnZBdm1tc1Vna2VlVXJT?=
 =?utf-8?B?RFdSZStmQzZKSm1XSEhORXB6NWxjUDE1UkhaaFdlRnM3UW9xd2lxc1F4T0pU?=
 =?utf-8?B?ZnB2aDVKcVNoK1o1djJOdEFTeUt5c2VPTG9iVDdKMWJlcWMzb092eGEzekJ6?=
 =?utf-8?B?b3BKdVRmWmdZSUNmWG1STGNrSHFTTUVoMFJjamVLSWppYzBTV2dZZVNMM2R3?=
 =?utf-8?B?bmVkdWRFZitMcU1jdGl4N3Y1NVZrVUNMUXdJR094SWZRWWFSNnMzaWFSTVQ1?=
 =?utf-8?B?Y1gybmo2ZTJNWHArRElUSWQ4NFNnWkcxbm81czFDVnhsdjNTdVMvM1pVb1d0?=
 =?utf-8?B?T085cklUZER3UHlUQjR6YVZ0YWlRM2twN0p3U0RBaElzTkVHUkFWRTJIdG9n?=
 =?utf-8?B?WmxmZG1KRkN3dlVTMEhpd1NDdldGVll0Yk16b3R0dVlXNzd1cDdtMW8zNUlv?=
 =?utf-8?B?VWprblFDSGtyUlIyWGF3MFFOZjBEa3lJQlBOT1FWU0c3UzZZejRUbXRpa1dU?=
 =?utf-8?B?eVVmOHNTclNQME5EeXlPejY5RnJBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f1f577-a639-4b8c-79ff-08dde08649e3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 07:42:32.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqRTt596qub3z+z+bcHJ83GbPFivowbkak2QAowgZQhZh3S59mXyNsNdirRm9GqNYUyyH0q6hyiTYqUvgUFVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

On Wednesday, August 20, 2025 8:42=E2=80=AFPM Svyatoslav Ryhel wrote:
> The Tegra114 has a different fuse calibration register layout and address
> compared to other Tegra SoCs, requiring SOCTHERM shift, mask, register
> address, and nominal calibration values to be configurable.
>=20
> Additionally, a use_lower_precision option was implemented to account for
> the Tegra114's 0.5C thermal data output, which differs from the 1C
> precision of newer SoCs.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/thermal/tegra/soctherm-fuse.c     | 31 ++++++++++++++++-------
>  drivers/thermal/tegra/soctherm.h          |  8 +++++-
>  drivers/thermal/tegra/tegra124-soctherm.c |  6 +++++
>  drivers/thermal/tegra/tegra132-soctherm.c |  6 +++++
>  drivers/thermal/tegra/tegra210-soctherm.c |  6 +++++
>  5 files changed, 47 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm-fuse.c
> b/drivers/thermal/tegra/soctherm-fuse.c index 190f95280e0b..d27876dd9b2a
> 100644
> --- a/drivers/thermal/tegra/soctherm-fuse.c
> +++ b/drivers/thermal/tegra/soctherm-fuse.c
> @@ -9,15 +9,10 @@
>=20
>  #include "soctherm.h"
>=20
> -#define NOMINAL_CALIB_FT			105
> -#define NOMINAL_CALIB_CP			25
> -
>  #define FUSE_TSENSOR_CALIB_CP_TS_BASE_MASK	0x1fff
>  #define FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK	(0x1fff << 13)
>  #define FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT	13
>=20
> -#define FUSE_TSENSOR_COMMON			0x180
> -
>  /*
>   * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
>   *    3                   2                   1                   0
> @@ -26,7 +21,7 @@
>   * |       BASE_FT       |      BASE_CP      | SHFT_FT | SHIFT_CP  |
>   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>   *
> - * Tegra12x, etc:
> + * Tegra124:
>   * In chips prior to Tegra210, this fuse was incorrectly sized as 26 bit=
s,
>   * and didn't hold SHIFT_CP in [31:26]. Therefore these missing six bits
>   * were obtained via the FUSE_SPARE_REALIGNMENT_REG register [5:0].
> @@ -44,6 +39,13 @@
>   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>   * |---------------------------------------------------| SHIFT_CP  |
>   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + *
> + * Tegra114: Layout of bits in FUSE_TSENSOR_COMMON aka FUSE_VSENSOR_CALI=
B:
> + *    3                   2                   1                   0
> + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + * | SHFT_FT |       BASE_FT       | SHIFT_CP  |      BASE_CP      |
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>   */
>=20
>  #define CALIB_COEFFICIENT 1000000LL
> @@ -77,7 +79,7 @@ int tegra_calc_shared_calib(const struct
> tegra_soctherm_fuse *tfuse, s32 shifted_cp, shifted_ft;
>  	int err;
>=20
> -	err =3D tegra_fuse_readl(FUSE_TSENSOR_COMMON, &val);
> +	err =3D tegra_fuse_readl(tfuse->fuse_common_reg, &val);
>  	if (err)
>  		return err;
>=20
> @@ -96,10 +98,21 @@ int tegra_calc_shared_calib(const struct
> tegra_soctherm_fuse *tfuse, return err;
>  	}
>=20
> +	shifted_cp =3D (val & tfuse->fuse_shift_cp_mask) >>
> +		     tfuse->fuse_shift_cp_shift;
>  	shifted_cp =3D sign_extend32(val, 5);
>=20
> -	shared->actual_temp_cp =3D 2 * NOMINAL_CALIB_CP + shifted_cp;
> -	shared->actual_temp_ft =3D 2 * NOMINAL_CALIB_FT + shifted_ft;
> +	shared->actual_temp_cp =3D 2 * tfuse->nominal_calib_cp + shifted_cp;
> +	shared->actual_temp_ft =3D 2 * tfuse->nominal_calib_ft + shifted_ft;
> +
> +	/*
> +	 * Tegra114 provides fuse thermal corrections in 0.5C while newer
> +	 * SoCs provide data in 1C
> +	 */

I've been looking a bit into these fuses, and from what I can tell the=20
precision for these fuses should be in 0.5C units for all of Tegra114, 124,=
=20
and 210. The documented nominal CP (cold) and FT (hot) temperatures for=20
Tegra114 should be 25C and 90C respectively.

The reason for the code '2 * NOMINAL_CALIB_XX + shifted_xx' then is that th=
e=20
value of 'actual_temp_xx' is in 0.5C units -- NOMINAL_CALIB_XX being in 1C=
=20
units and being multiplied by 2 to match the units of the shifted_xx values=
=20
coming from fuses.

If you're getting correct values with your code, clearly there's more hijin=
ks=20
going on.

> +	if (tfuse->use_lower_precision) {
> +		shared->actual_temp_cp /=3D 2;
> +		shared->actual_temp_ft /=3D 2;
> +	}
>=20
>  	return 0;
>  }
> diff --git a/drivers/thermal/tegra/soctherm.h
> b/drivers/thermal/tegra/soctherm.h index 70501e73d586..f8d76ae716fe 10064=
4
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -56,6 +56,9 @@
>  #define SENSOR_TEMP2_MEM_TEMP_MASK		(0xffff << 16)
>  #define SENSOR_TEMP2_PLLX_TEMP_MASK		0xffff
>=20
> +#define FUSE_VSENSOR_CALIB			0x08c
> +#define FUSE_TSENSOR_COMMON			0x180
> +
>  /**
>   * struct tegra_tsensor_group - SOC_THERM sensor group data
>   * @name: short name of the temperature sensor group
> @@ -109,9 +112,12 @@ struct tsensor_group_thermtrips {
>=20
>  struct tegra_soctherm_fuse {
>  	u32 fuse_base_cp_mask, fuse_base_cp_shift;
> +	u32 fuse_shift_cp_mask, fuse_shift_cp_shift;
>  	u32 fuse_base_ft_mask, fuse_base_ft_shift;
>  	u32 fuse_shift_ft_mask, fuse_shift_ft_shift;
> -	u32 fuse_spare_realignment;
> +	u32 fuse_common_reg, fuse_spare_realignment;
> +	u32 nominal_calib_cp, nominal_calib_ft;
> +	bool use_lower_precision;
>  };
>=20
>  struct tsensor_shared_calib {
> diff --git a/drivers/thermal/tegra/tegra124-soctherm.c
> b/drivers/thermal/tegra/tegra124-soctherm.c index
> 20ad27f4d1a1..e0a40ca2a6ac 100644
> --- a/drivers/thermal/tegra/tegra124-soctherm.c
> +++ b/drivers/thermal/tegra/tegra124-soctherm.c
> @@ -200,11 +200,17 @@ static const struct tegra_tsensor tegra124_tsensors=
[]
> =3D { static const struct tegra_soctherm_fuse tegra124_soctherm_fuse =3D =
{
> .fuse_base_cp_mask =3D 0x3ff,
>  	.fuse_base_cp_shift =3D 0,
> +	.fuse_shift_cp_mask =3D 0x1f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 10,
>  	.fuse_base_ft_shift =3D 10,
>  	.fuse_shift_ft_mask =3D 0x1f << 21,
>  	.fuse_shift_ft_shift =3D 21,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0x1fc,
> +	.nominal_calib_cp =3D 25,
> +	.nominal_calib_ft =3D 105,
> +	.use_lower_precision =3D false,
>  };
>=20
>  const struct tegra_soctherm_soc tegra124_soctherm =3D {
> diff --git a/drivers/thermal/tegra/tegra132-soctherm.c
> b/drivers/thermal/tegra/tegra132-soctherm.c index
> b76308fdad9e..138d76c67114 100644
> --- a/drivers/thermal/tegra/tegra132-soctherm.c
> +++ b/drivers/thermal/tegra/tegra132-soctherm.c
> @@ -200,11 +200,17 @@ static struct tegra_tsensor tegra132_tsensors[] =3D=
 {
>  static const struct tegra_soctherm_fuse tegra132_soctherm_fuse =3D {
>  	.fuse_base_cp_mask =3D 0x3ff,
>  	.fuse_base_cp_shift =3D 0,
> +	.fuse_shift_cp_mask =3D 0x1f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 10,
>  	.fuse_base_ft_shift =3D 10,
>  	.fuse_shift_ft_mask =3D 0x1f << 21,
>  	.fuse_shift_ft_shift =3D 21,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0x1fc,
> +	.nominal_calib_cp =3D 25,
> +	.nominal_calib_ft =3D 105,
> +	.use_lower_precision =3D false,
>  };
>=20
>  const struct tegra_soctherm_soc tegra132_soctherm =3D {
> diff --git a/drivers/thermal/tegra/tegra210-soctherm.c
> b/drivers/thermal/tegra/tegra210-soctherm.c index
> d0ff793f18c5..1127b4d28087 100644
> --- a/drivers/thermal/tegra/tegra210-soctherm.c
> +++ b/drivers/thermal/tegra/tegra210-soctherm.c
> @@ -201,11 +201,17 @@ static const struct tegra_tsensor tegra210_tsensors=
[]
> =3D { static const struct tegra_soctherm_fuse tegra210_soctherm_fuse =3D =
{
> .fuse_base_cp_mask =3D 0x3ff << 11,
>  	.fuse_base_cp_shift =3D 11,
> +	.fuse_shift_cp_mask =3D 0x1f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 21,
>  	.fuse_base_ft_shift =3D 21,
>  	.fuse_shift_ft_mask =3D 0x1f << 6,
>  	.fuse_shift_ft_shift =3D 6,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0,
> +	.nominal_calib_cp =3D 25,
> +	.nominal_calib_ft =3D 105,
> +	.use_lower_precision =3D false,
>  };
>=20
>  static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] =3D=
 {





