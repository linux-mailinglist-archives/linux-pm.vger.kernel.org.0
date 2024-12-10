Return-Path: <linux-pm+bounces-18892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D79EAA51
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 09:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F3281FC3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07A522CBE9;
	Tue, 10 Dec 2024 08:11:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021134.outbound.protection.outlook.com [40.107.51.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61B172BD5;
	Tue, 10 Dec 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818278; cv=fail; b=f+iEU9aJpj4IFRBpFiKZhmAjq6c3VhvkFh037xK8OPqAUnndPTRz8sF/Jkoug7K747GXx3Y9eddDSfxV6+0FAKi5OCvbswkAFiwSjplbMvdSymlaTMW1bOBtPF/iRss+axyp9oWlZ2LX69XZuB+HxW+uqrRkwZVTJ2NbEQSQOZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818278; c=relaxed/simple;
	bh=uA/JNnIfkJuRvIkGtgQRRHavOh+A2L1KsNGn5JjoFIY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lrqZWF+kad4pSNgukV02MkjS+yn2L7QYFs30uHqFw8c4jHGVtJz3kCsq+sdX1bG0csMaWgztzibRmiSj8BHhNKHgSrnefIcVv31KGZ+bbEyRBK8pG8vpsHySo4vB3qOnZKY66FdBAat92EfgbvtyU62bTS/AUI0LxqIVyXNw4Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJQRCtGkIiQ2xwjE+gkWG0p59ATn8SmXuZQMwCsnNrgPMhhdVDK1YpbHtxynYHKvRGmOdeiT2VzyVNipsSVUGjYwtPxZIJY3ZV9LBgesxTj7Ul58u+2jn8y9VOewl3JvMuD1uC102pZyRnK5TArjhpgsvlF4S1dim+aq7Sz9v6ec8Z+OofCDIH9DwSI25NBTS7GJr3KBVaJABFjjHfpmRkkCCpI5RonAVw8EnXcqebLMb2PHosIbiUh3zL8wbkl49E74brRind1o9QTKSAmO5iQ48Vh+lumpz0fVZ1vN9ohLBj4h94MfzKKifDgosj1k1scdt00CiBEFEDypb4MWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvYEJFOhTZyp+/PE2t9vs949K1+gwEVhvViEPR8WKZk=;
 b=vGToVspSzY9AU7F105sPd2zXmyGi6d/1ej6Gzifm0Zv2idCE98njqSdo6YzhXXgGol9EyNH5XJfzF2QUCZrUfl5CTY+dAgpTrm3pS+RCD7O8pWGW9dUz/T7CUxrg3Ld6GFa52C8kFFFJv55wKnxsMHFRPdf0kBqNRQok9Lz0xylnqJbOp3xdZF1hTkoh9ye4feeUj6rlUpa55EX1fIX9bcqi5+mNAkKCWFGRWQf6M2NwO7AN9G6uJvcba4VdugEBC71oBYroEVglb3sBDgsQq9w6qP9F1W41vSiGwxIl+QIpgHiplH1z6oB8E5ALScwcwoZR/kEpDECLNBcX6e+NeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by MA0P287MB1195.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 08:11:09 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 08:11:09 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/2] power: supply: Add STC3117 Fuel Gauge
Date: Tue, 10 Dec 2024 13:39:44 +0530
Message-Id: <20241210080954.5067-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::20) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|MA0P287MB1195:EE_
X-MS-Office365-Filtering-Correlation-Id: 396f7b60-6d86-41e3-fbe9-08dd18f23432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUt1a2VGSmR0WkZRd1R4WHk0YmlTSkdWcTZvN3BYb1VnOWRsTy9NMElNQUti?=
 =?utf-8?B?ems0b1B2b1BvYWI5bCswdHd0cjl2Q2V6elBHZURhZ1R5aTU4LzFOenJBelhE?=
 =?utf-8?B?dEdDRDQ5WmYrdEkreXpmL1BXVG1nL3hudmpIRmtUUUxVMHNtS1RRMUhtM1o5?=
 =?utf-8?B?MHVqZFpVeVhEU2sxUk0zQUxsZTFBa0lvdG1ibG1Ja3BJK1FxZVFNMXJMVzJB?=
 =?utf-8?B?aHZFWit5ek1xdnB3TVhjdWRoOVlNcmFiS25MdVlPcldOQmE5eFFrTGJmVGZ2?=
 =?utf-8?B?ZjZRb08rclQwWVpKM2V2ei9MVCtnd0h0dGcrV3JXRTRuclZCMEhpM1lSbExB?=
 =?utf-8?B?OVZLbTJ6Qi9CZUpmZzNyazBSTlQ0SDFmeTM4MmJ3cklSVkJ4aW1CMFZ1bUho?=
 =?utf-8?B?ajVJQ04xODdlOEFkQjNkc1dFeGZMNm83MkFjZUd6RmxjYy85M1I3MUtsQmJB?=
 =?utf-8?B?Mkh6aGkxOTczbzFyL0E4T1h5VEdzSkZiQW9JWmFuTEtMZ0w0SEQyeFlHc0xQ?=
 =?utf-8?B?YkxPUE1kYkhvcTVVZDNsdFhjcVFRSEJIU2MwOFJ2bGc4blNHYThvWEZsTkN4?=
 =?utf-8?B?VURFSGx3LzFzdnJ0Zll5Zm54WThiQ2o4WlZwekxFNENvZGN0S1J3TkpSNWRp?=
 =?utf-8?B?MXNLUzdUYUtOWENOVzQ2c3J4UHUvdGkwVWpKN3dDQ3VISkR6bDVIR3VjWGdH?=
 =?utf-8?B?c3l2ZWUzT1lidVFTNzNBYnhlcGJaL0NyOXN3NTlhL21XZDVNUmQ2K283cmp2?=
 =?utf-8?B?N3ZFNlBhc3BhUjZ6TnppV1M5Z3N2QUo3UlFaby9FQVNZNWdaWHlnd1RLaGQ1?=
 =?utf-8?B?ZEJheWZ1bThtVVBjL3p0NGJJb3pZUDRMRExUQ051ektzMzdBQmJZSWZQQ2Vy?=
 =?utf-8?B?SW9ZWFNhM1EvZ3BmMzdNbFRnUzZDeGxlTW1Bam1NaTF1RWFDSXpRa0R3UXFX?=
 =?utf-8?B?NHZWQk5zS3hnYVh3SWlQL3h3b3dsSUYxVTZGYVlHS3BEWnBxU1FENXp0SEta?=
 =?utf-8?B?TnVuTmptVW52SGhpSmlVblROaCtoUjgwV3J5c0Z0R2Nncml0SVcwTlVVT3Jz?=
 =?utf-8?B?L2ZoUUxiRmRaLzA3RzB5WTl5bGNlRnZiWTIzbjZBbkhhTmxnc2o2TGFOdGxJ?=
 =?utf-8?B?WWw4MlJvb01RYmJPMU51V3Y3N3VyUi90b3Q5VUVlWXI4MThDUjBsLzMvd3Ry?=
 =?utf-8?B?Ykx3NlR2ZThBR09VdWVzL1hXTUdqS1VGS1MraHpUYnoxWHFoNzZaVXMxSW9x?=
 =?utf-8?B?WGxQcjkrNmRmb1RFdDFvSlA0eW5pUU9mcGd5Sk1wV3k4M0ZVNkFKVU5PeTha?=
 =?utf-8?B?cVRLMUNhY3BXaldlaXZMbTR0NWZCbm94bTRNMk1PcThIcWlYSE9KVEdtcnUz?=
 =?utf-8?B?dFhVbGVrWFlvSmV5SWIwUGdGNW92R0Z2R1ZPeHNpWWxLTVNTc21oRHhJakF1?=
 =?utf-8?B?dzhVY1lLcDNCMzJHWC9ZOUVkMDBFNmxhQitHcUx5NUNrUThCSjlUMk5vMXc0?=
 =?utf-8?B?THV5Ykd5RjhvK1RtR1paKzdMMzZuK09tQnh1OGtPMk5oMkJ0QTZQMllPM3ln?=
 =?utf-8?B?TEhtbXpLbld5Y3ZBSWNvN2wwUkhsNWdxTmFrTDc1VzF5SmJJLzJRVWlJYkFj?=
 =?utf-8?B?bkFBa005V2N1Q1puOWl1Sm5Sdk9IMHNHOFh1RkJUblNUZjJxL2owelVHVUkr?=
 =?utf-8?B?ZzVITUR5NjdSd3RwYkNXVlZ3cDJwVmVudCtWb1lJTjlJWkMveElhTG1xdnRs?=
 =?utf-8?B?dHI1VW5aeldLWWpVMmVmandLWkloK1F1R0d2RDJUaU41NXJKVXVPTmhzSHRL?=
 =?utf-8?Q?Emi9HtzUoMlcrBQ0G3SmoXdY/q3frUQ8gcxYA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnBiM1B0YWpUV2d1TG13OGwxeE5nNXNZM3EyOTJMUWlyL0Q3akRaeGw4OTVG?=
 =?utf-8?B?cEdzTFhlOWx2UzhaSk15UWNYZm9kSjliTDhxUWNlcnErMERwWUtWaE9DanFH?=
 =?utf-8?B?aUhOKzRybFpsZDF3YnR3L296dXJscFVzWWpKcVBNOGhXZUt3a2JobDl0V2ZZ?=
 =?utf-8?B?NFczTkQ3ZG5jQjZZR3M0REV4RU4yeGZNeVZtdGdaY3Z4cEMxbE5odFVBV242?=
 =?utf-8?B?YXhCOU9IeThZb2FXckxnMmpheWw3T2c0eFhrWVN2WE1tenZSOGdPblJkWXh2?=
 =?utf-8?B?dXppdXBBR2JWZEZtZDg4Nit1bUFWUzlLcGFERHNleGhRcmJYUHZVN2R3VWlz?=
 =?utf-8?B?a1EvWGZwOTBDelIwaHhHZWtKRGZDN1Awc0YveGN4Q2pwc1dGeHJYR3Fmc3c3?=
 =?utf-8?B?ODdMakdiZTFGa2hVNjdwZ1AvbGU3dTdRTzBhSFpSOUd1SFpCVlFGR0hTNUp0?=
 =?utf-8?B?MWt2dXVCQ2taMW5BeEtrOTRIM2h2bDlGVFpaY2MwRFladHNRYlhXQjN5VVJ1?=
 =?utf-8?B?NGh6bUdadmtNSjdWTVJCdnY5dThyQkJhN0NwYkI2allKMHlhem5WVjJjbzFr?=
 =?utf-8?B?dWZ5LzdpVHVhN200Qi9XUktIQXRTR1gxT0tWaUFCNHhuZ293Y3p4ODBzV3pK?=
 =?utf-8?B?WTBxcDFvbW9vNy9XaHdraEIxTWtkelM4OEloNlZwY2IzalB6Ly85ZGFPd2pa?=
 =?utf-8?B?YlBEUXBTbEtrYlVwbFFNYW1SSEx3NTJCU1pnYUVwYWxocWtzQnNpdkhIZVZh?=
 =?utf-8?B?ampwTnZhSmpuVnZneG5aNGt5cVoxZi8vVUQxcDJkRjkySzBhc2taR0JXSHZ6?=
 =?utf-8?B?aTJpVmtxaEZGWWNzVHB4TGhjeWE4ZEhOWmNRY3c0MXJYUmpxZWVYU3FlN1c5?=
 =?utf-8?B?bFJIYk9rREQwSEt5QzhNVHBhZGlNTFdWOU5HM2JqL0FQWEc4Q1N1b1F5eHdm?=
 =?utf-8?B?L3NkL3VlbmNXRzJPKzB6dWorei9NbENpcEltYzcyTWxjaGNwTzllOU9yVWF0?=
 =?utf-8?B?UXRVcXlxc1oxdjV1V1R0dE80SkxjbnJpd2VsNllONDllTjVxdjI4dWs0dDBi?=
 =?utf-8?B?L25pMldlaWpxWEpNSlcycGM0SEJndkpqWU1tRXdOMTFzSHhUd3NVNXR5ZzA3?=
 =?utf-8?B?alNmWDZEMXZSdFF5UFdUcW9zL1VCNml2NkYzMVBZbnJVcGVSOUpIQTgvWmxy?=
 =?utf-8?B?Z3gvbkRVdUtFaTJKMFZGOXd3UnFJY21KLzhvZUI3MFZLcVIxUVZ6Qzlmd1p2?=
 =?utf-8?B?eVprWlJsczJGNDUwcVJ2RGozZkVKbklYL21WSW9paDNSNVdxU2t4MDBxb2Fq?=
 =?utf-8?B?bmdRRURCSjZrVEtRYWJpUlhTOFJJeFdnWXVSaHoyamRTVTNFMEtDUG1oNWo5?=
 =?utf-8?B?QkZEZXRQTTJUcmJ1SjZyK2xLQ0U1YnVyc1lvdS9hSEFHSTV5ZGV5KzF3ZG1n?=
 =?utf-8?B?ZXdFNjhRZ2FzakNQa3c1ZHhiZGlYbUY1aGhHVDhWZTJqbWtsK2FCZ1JmSlFZ?=
 =?utf-8?B?QjAxOVMveDh0M2lGMjM0NkVJZTBYWXZYZHlZU0hBNTRPcWwxbW5MbnBkY1pO?=
 =?utf-8?B?YlFmeUdZT1lCRjU5cmhsdVlVNENhTUtKZDArSkh3Vm9Zcm5kUGFBSkpTNS9U?=
 =?utf-8?B?SVZ3ODI2RUZMSHBzdVB5RTh6K3NmTWtzMGhUQmpMSGdRZXcwb1pRa2N1U0RU?=
 =?utf-8?B?dXRHRTZMS1pOMUF4Z3JyKzdrNDFLNk5ZSnhYcDVxS3k5eTlqenZieDJnTlVU?=
 =?utf-8?B?SVBnRzZ3VnkvR05nczFwV3VqMVJOdDFxQ3A5YTJRVkdBV1BMbEwvd0pvbHNr?=
 =?utf-8?B?UkNkM1lFckxDckpMMXBHT29pVXVya2lCZFNtQy92cmdNdGNiRTZYNUxtY25F?=
 =?utf-8?B?RjhvTkZDdVpQdS9QQTVubmZ1ZzNaTWtNNTkzU0ViVUovNHNIZjRua21GSjhh?=
 =?utf-8?B?ZVBtNGx0UWJ0SDF4TUd3c0xHa0s5M0hUZ0U3MytJcVdSL2xDTU5wK0VDSDc3?=
 =?utf-8?B?TU01aXRoZTZHQWU4aUZqVE5ndmFhd1owbmdVb1J1aGhKL2xTaG5mdnMveENw?=
 =?utf-8?B?YWZkK0FmeU9WNGYwcUdzbTYvM3l2RnFkQ1Z2SGw1UVZtYnlLZ3ZlS2o5dGpj?=
 =?utf-8?B?a0VBWkFIQnFwM1NCTExJZStjM0ZKazZSRVlZSUpOUEUvdm1HamZ0WDBscitW?=
 =?utf-8?Q?uMj5Lk+jN+3DtfXt+K9QnYw=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 396f7b60-6d86-41e3-fbe9-08dd18f23432
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:11:09.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPQzHXhE8VlHjZ2mR8xszWF1mGQGzVLSEURtrc/48CosF2TFO97A0vOdZGIa3mTmaYozbjgNhzuJiaUFIwLGjddVmVZ6Du/BKplIv3oB/9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1195

Adds initial support for the STC3117 fuel gauge.

v7 -> v8

- Add output of test_power_supply_properties.sh script.
- Change 0X to 0x in macros.
- Fix typos and Specify units in property comments.
- Remove stc3117_update_battery_status function.
- Convert voltage and current from mV/mA to uV/uA.
- Represent temperature in tenths of a degree Celsius (1/10 °C).
- Export average current and open-circuit voltage (OCV).
- Use devm_delayed_work_autocancel.

Link for V7: https://lore.kernel.org/linux-pm/20241202094328.14395-1-bhavin.sharma@siliconsignals.io/T/#t

v6 -> v7

- Removes extra spaces.
- Fixes error handling.
- Fixes the logic for checking battery status.
- Fixes typos.
- Removes unnecessary commas.

Link for v6: https://lore.kernel.org/linux-pm/20241130094531.14885-2-bhavin.sharma@siliconsignals.io/T/#t

v5 -> v6

- Use shunt-resistor-micro-ohms property instead of sense-resistor.
- Remove the battery node from the binding examples.
- Add interrupt bindings to the example.
- Correct the Signed-off-by (SoB) order in the commit.

Link for v5: https://lore.kernel.org/linux-pm/20241129114200.13351-1-bhavin.sharma@siliconsignals.io/T/#t 
                                                                                
v4 -> v5                                                                        
                                                                                
- Fix variable names                                                            
- Limit code line length to 80 columns                                          
- Add interrupt and monitor-battery properties to bindings                      
- Correct error handling with return dev_err_probe()                            
                                                                                
Link for v4: https://lore.kernel.org/linux-pm/21c08a45-34f1-443c-97d4-6baf9fa01b67@kernel.org/T/#t
                                                                                
v3 -> v4                                                                        
                                                                                
- Added support for current, soc, temp, and status properties.                  
- Addressed comments and feedback provided by Krzysztof and Sebastian.          
                                                                                
Link for v3: https://lore.kernel.org/linux-pm/20240205051321.4079933-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v2 -> v3                                                                        
                                                                                
- Resolved DTC warnings and errors                                              
- Formatted the changelogs                                                      
- Added monitored battery properties                                            
- Replaced 'additionalProperties' with 'unevaluatedProperties'                  
- Replaced '&i2c6' with 'i2c'                                                   
                                                                                
Link for v2: https://lore.kernel.org/linux-pm/202401080530.0hMWnrIg-lkp@intel.com/T/#t
                                                                                
v1 -> v2                                                                        
                                                                                
- String value is redundantly quoted with any quotes (quoted-strings)           
- Found character '\t' that cannot start any token                              
                                                                                
Link for v1: https://lore.kernel.org/linux-pm/46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr/T/#t
                                                                                
Hardevsinh Palaniya(1):                                                         
  dt-bindings: power: supply: Add STC3117 Fuel Gauge                            

Bhavin Sharma (2):
  power: supply: Add STC3117 fuel gauge unit driver

 .../bindings/power/supply/st,stc3117.yaml     |  74 +++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 608 ++++++++++++++++++
 5 files changed, 698 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.34.1


