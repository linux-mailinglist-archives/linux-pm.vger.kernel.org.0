Return-Path: <linux-pm+bounces-22197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C35CA3815F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62621168139
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F9217661;
	Mon, 17 Feb 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qf/ScGsP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19F215F5F;
	Mon, 17 Feb 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790564; cv=fail; b=o0IU0l4fGbPJ+KN8njzjjuEkcDKUhL8xIS+wzs7CGPCi1ZWwKZQKdOSvGy2GEWbgz5sW83FG1sggUMM7OKDS/S4U3EMxqE9GecE2o3czb+vyzA387hORJu1oXspeTN/XK2FyxldnvxP7JWc3WVt3UAHgSc4LCp2fkxFZvtrCjLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790564; c=relaxed/simple;
	bh=0k04KPrkBn/rK6tuNzzNcp8uvbI1CBk/FF5WzsfVdHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6wV7QcQattkuT3oabbSvBkUf+6uhtx1ONR165YA+DAXgXT0rYCxR2W1ZoBGZlTGQ0k1KC8dMECk+CxJ/6L04MUiNOf3xYPWGm0iRpSmU00wUWOj17tCs6PWakZKs5CqMxOl0X6JyNjD8zd3UFJtcGgU7cVFG395gTqp6yh6cfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qf/ScGsP; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyFx0ZIw1KAkRqQMmNKVPGPaRyv+I9Pc+3mlpCwMDciidHZIfK1GoAX0DETL0tOOSyKh1Q52vL+ou0XEQrRmjcjatfSIMhwoEz2whUSNefFmGtIHRT59vcDo0sIOqdRUeiyTaaDxHCA0hlzpYaJyECyYiSchdip0S1wlWFmYiPuqv6i1tepzInAtdYMhaiqC8DN78TWHWHWcCUHru8vxfiKAUPdNl1/WG5jyHhyYdRJYlT0xI/gH7SNOn0Y3eHrLZ8A5Ttzzkw98ZRsGM3PGMYvBdvhHzMOU0RrS6hylyPJSx6xGL8H3cqPzz+15eAWeQtE1gAXV4J4b54xhzP+Vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z73OiST/bMwt95Q6vBYk4afIzZ01/mOEJjItkHdC1rE=;
 b=VBS8AF6+i6GJlld7RMOhCL0aRdVaKmvM/mepT9FkCG43Vow5kito8Nnf6HCF+vmmpB6NKmeM8DCe6n5uFLsVT0//MvZxr+WaDcKA8rEKF4no+A2v6cCgwPe+IoNcr0rCexxbflaoJTW7FpPcTTE6A8Dmkj7k5WtmtmZEIwuLRWwM3arneWNkZwvvTxy0ZIG+4FaOz/rl8hlOsQW/tsqkikKoRlF6PWfxLlBPlS5AsWlAL0NIDcgxzzre8iIKjkUegvRgPb0krlK3UKispHeeA5uEp0zMdmWFR2WpOn3iXrZQqh2A/kdt4yUvVYz5JFK3ksLq4KIHef3SLNoKirsvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z73OiST/bMwt95Q6vBYk4afIzZ01/mOEJjItkHdC1rE=;
 b=qf/ScGsP4X0FN2cdzK1ocN6dBZHjgoirnCDntY/m9D40u44tIALa0UaTFCQlfqrep+9gAcZfJJ7MgqIiDjhYfLobBQfoulheNEgwQiAZL/XInvW4Q8HSB0/dwD3dV3DiAxscEE5jWSDW9wmXk5OaMjrrjgrLAWGLjx12BtDRZrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 11:09:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 11:09:19 +0000
Message-ID: <01b80c04-1d64-4850-bd75-bcf73d42dd67@amd.com>
Date: Mon, 17 Feb 2025 12:09:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: power: reset: xilinx: Make "interrupts"
 property optional
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: git@amd.com
References: <20250217095226.12606-1-shubhrajyoti.datta@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250217095226.12606-1-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa84636-bbd0-4377-902b-08dd4f438630
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDlRdW90OVNsN3h2U0ZULzNpOC8vVVpjanRiZlNpVUplc3dhQ0JtYmNEdlFR?=
 =?utf-8?B?ZVU2dWUzUkQzS2pHbGZPZ3FmNHhhTk5JNFFPenZnYkNzYmZwN3g4VGo0RkJN?=
 =?utf-8?B?dEllM0xKaHNCNTFJRGhrRW83aklOZUF3WmZVWElucEVEbTkvVldKc3FzNlo0?=
 =?utf-8?B?NFFISkNVSTZrK1VvRm51ZWtGTnpFd1NUUFc3YnFOK2cwNm9LaGpIdGIwdG1F?=
 =?utf-8?B?WmZLTU9CcEwxc0FNVnNqd09QMzZwcDZTQmVlamQ5L3d0NTZ4VGFoOWVvK2wz?=
 =?utf-8?B?NHdua1oyaDhUZ3psbGNOZFZpRFIrNWx2aWh1YjZNRVRUV1RWVlh4Nys3UzRx?=
 =?utf-8?B?K0JteFRPTFRtRzE5aXVsS1F6eFd4by9rU3ZoejBtTEZzNGw1MmRxdkpXUUh1?=
 =?utf-8?B?KzM1S2FFR2xSaGZjSEcxOWNJb0l1VGE3M1JEWTh6dHowYmV4blcxSUFRU0V1?=
 =?utf-8?B?eHlPcjVxdE4xRkFDZU5ZZjc3MmxLUjNsNGVuSysvNG9MUGIzY3A0MmMyZGlI?=
 =?utf-8?B?UU52cW1qcDdGbWRyMC9yYlZ3a09tazc5WGppL1pVYk1EMWxLcDcxMXo2YWJX?=
 =?utf-8?B?WWR2WThIT3VnbENOTXpieGNPWmptdVJKSXlHeVJEcHNTM251NmdwNGhnV3d3?=
 =?utf-8?B?OEFqTjE2ZlQzbzVXVE5PWEZMNDZWRUtvL3kzcGx2WkFlbG04Z1RUQW9YUE5n?=
 =?utf-8?B?NzhaMVo3dDRDakpIYUZFYkh4RUtrNmJhSzQ3TUl0UVkvbVI1Z1hxTXZhZHN4?=
 =?utf-8?B?R3YyTlg5OHBneG9XREN3K0xheGZnTW5QejVNbll4OXFnUndkS0ZRZThCWnJ4?=
 =?utf-8?B?bGhva0tPbTVqT0FFdFlCWkNicGRKVXVwbmlTbVlITlhwa29mL2o0WTRUdXNX?=
 =?utf-8?B?YitPUzdWNkppamNDMkhEZTdaalYra2RLSkRBalF1a0g2VHJkc1JzZVF1cTJq?=
 =?utf-8?B?ZmdITnpvTlVvdXlaSDJJb0dNTWVRR3Y0RlpuY1hoaEJVV3QxVS92Q21yS3lC?=
 =?utf-8?B?RCtOemJ3OE1YczZBbkdhUmpTR0hkMStIU29BOUdQRFVrUGkxQmpmTGNJUGps?=
 =?utf-8?B?WGYzeGowYm5LRWx4c2N3RWcrNkdYeERsN2tTYlpYOVRyakk0QlZIR3lMeWR2?=
 =?utf-8?B?OFVQRnZzZXF3NzZ5aXJyazRKbWJpOEJDK0R1ZW1seU9TcTEwSXh1YzRXcVZx?=
 =?utf-8?B?Y3Y2MjEzWnc0TkZUNyt3QTMxcXhhaWpCUWZHUnZleVJxaHI5b3pTUVF5clIv?=
 =?utf-8?B?eE9FK0U2ZnJNbnpFV21oNjJtVVA5VHlMaEpQTHlFajlBVWFHOFc4SHk3TEh5?=
 =?utf-8?B?bmptZXJ0bzlHTlhzS253czQzWDR1eFRNbVdweXgyc3BaUDg4cEQ2eUVSendG?=
 =?utf-8?B?bkQyS0JQQWVmN3ZTZ2hwNks1TDNCckVxMkVoRDZhc2JsMzdXNFRGZG9yRitX?=
 =?utf-8?B?MnNCRnlZSXIxUW1UQTh2Y01hMFduSG5acmpyOG5SalhLaE02VFpseEpMNG91?=
 =?utf-8?B?YklxOHpkbE5xdXh6SE1RVHJibXlNdmZtMFplREQvTmdjYkZLYTVudkY2djI4?=
 =?utf-8?B?OVNNZjBYb1FHak0rb1cyV3hpK1k0ZWtMMExiZmcvVDcyQjZqeDRwN3BNc281?=
 =?utf-8?B?T3BrVmpYWW1BckE0QnMzOHBtVVlGYkV1K3QrWXlaNzFyTk02QjBSdXowRmUz?=
 =?utf-8?B?UkFmVXJZaWNQMEpnRU5xK0tHYkQ3dGVUMytHaVlBVnNMMW1oZjB5cnZDaU9q?=
 =?utf-8?B?TkhocjBTLzkxSXYybjYxNW9OaGwyZ2tMeFdnQ0wvUEJHekZDUVJVWitUdFVV?=
 =?utf-8?B?eGdydkFJZytQb1BtTlRaa1RmVFFVZjVMTitJYTZTMlkwcW1ZSHdKYnh2VWdH?=
 =?utf-8?Q?s7Xsk59kUQIOe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZoSTI3S3BiTEwwV1prNXJjaE5kQWY5ZHVXd2FVL0I4SVNRalpMMUNzeWJD?=
 =?utf-8?B?UDA4TnVveGVvKy9VVEdWRDFxUWx6UzhNVkdXTzRaa211OU1UdTNQM2VZVTJz?=
 =?utf-8?B?ekZKY3JzeDFQVk5RNXBqaGNDUCt4RHJKam1zZ0EwdFhrU2tybmh6V2dMaDdT?=
 =?utf-8?B?aHpHM0VNMGdwOSt5amJYKzlTMW5lblpwaFJVbStFcEU0MnZJZE9HZFZmU1Nu?=
 =?utf-8?B?VHExRVhWcllxUWJpK1pTYWt5TGl1Z0ErWGxtblZGelB0cmluaytXaWhxdGRv?=
 =?utf-8?B?NElpMXBIa0ZjWklCNkIzc3lMYitmV3U5OTE1YkNJRE9nRGxoWk9QWm9GUEJQ?=
 =?utf-8?B?TGdSUVNvZzNmb2E2WFRNekpxRm5RVXN1QjA2TllnNFhZQW1iS3lrZGx3T0w1?=
 =?utf-8?B?d3l3TldLZ3k5Mm1WRlg5d2w0TjBUdHc3c3E3N0dLOFh0RjRGN2I3cW9BSERm?=
 =?utf-8?B?MXVRRG9iV1I4STdscHZIVThXNm5Ya0hBTjdWR21yQVQ4eS9SUVhZaWh5akdB?=
 =?utf-8?B?QTY5R1NmNkVkS1hyMy8vbzIwaWdhZVVnU2VLS2xMd3htZWZXRys2d0JQYXo5?=
 =?utf-8?B?Y2oyMC9uNThqaEt4UnFKMzJpZEh5YmtuTVYzS2pIZnRpNC9LM2dYU2FHaTd0?=
 =?utf-8?B?MkpwQVVNUUdEaFFMdmlXSmJ5WW90cVpSdlpmUnc5YzQxZTF6R3hXSnRYQnlP?=
 =?utf-8?B?d3VlbXQxWHlRS2pYMzE0NnlXcEV3SE1mZkNUV09UQzhsZW5wNmphRHFwb2Ux?=
 =?utf-8?B?eVhVNnAzSDA3WXNYQXB0V2M2YUJoTXdnMHFSV2gwVktMbG04SmV3UnhMRHJE?=
 =?utf-8?B?Znl4NUhvazJ4RVNsUFBzcjlvK2piczJmaXBLYjdoVlU4Z2EwMUpzdWhLRlFj?=
 =?utf-8?B?VFZuZFFsc0VTdzlKUzdiTGdMbDZmRHFXZnQ3QnpaL2pScHlYbUNlUFZkSjNh?=
 =?utf-8?B?Y0pCRHFaNHZLWlFhZ015UzBDUU5RdFNBN2RnMkgyQ2d4RmJidFhQcHZhL29l?=
 =?utf-8?B?cXUrQTFVVy9FWXdaUkRBWDE5Sm1UMHFXZVlURVhib1d5OVlXeStTelVWT2lk?=
 =?utf-8?B?VHUxVllGY3QzZU1GMmFIWGxzeTBPL0trNEJpYnlOMlJDNUozVCtsbVpOVFlp?=
 =?utf-8?B?RDhBM1ltbUFJSmFDdnlCOVg0SEtBS2psR1hEc29rY1dhdVVtdUxGc3R4eW9Z?=
 =?utf-8?B?WG0xaGQrS0d0QnVSb2hRN1VUbm51N3pXS21rendxOXFKQWtJYkIwU0ZDdWQ2?=
 =?utf-8?B?a2dZQUsxYzNJN01QQVkzalBrNFlyT1BLOUdPMnNhR2g3RHFsWk1LMlJxQ0lG?=
 =?utf-8?B?T01xMThsMS9NVk5aTk53Uk1LQ1dLZ3phdmFCYkd2aHR3ZGtKVG1aVzRkYkx4?=
 =?utf-8?B?WVpqVTc1RXFGVnlWOE9HOGpIby9WK3kwcTRhRmQ5KzJSbkk5Z202VWl5ODVD?=
 =?utf-8?B?WUIwczlXT01HdGxXMVpMYnhEcXRUUTdvdVoxTUZMNWZzbWFNN1dmN2hzeHMx?=
 =?utf-8?B?VUltRDd4NVlVUnFITE0xZzZmdGhvL3pXRW16QTh1Undlay9BSis3T0NIc2Nz?=
 =?utf-8?B?VE1iK2RLV2xRc0lCTWZMb2xDUGxKQUY2bVVwQXBteUtXSFVsdk1jN0xyOUdS?=
 =?utf-8?B?YnVpTXVGNlFISXpiNmNsQWtBRmVmQVBsQ1pkSWdZQTBuc21MR0VRbGdZVHRX?=
 =?utf-8?B?a0ExMGJPclRFZ2VrT25jRitmblp3bG5SUVlzSU5KTGpIOGxYK3kyOWRwVU0y?=
 =?utf-8?B?MjltY0dBZnBQdHJJWCtXT0tpTnozWGplZGRmRTJheVo1Wk8vSEovUlRqKzBR?=
 =?utf-8?B?SExwSnJyTXV5Z1pXZHFYZDhET09pSUIyZ1JpU29uZUxyWm5heTFXMUFJcnJm?=
 =?utf-8?B?VUxNNmlWZ0xIOElqalpKMER6Y2ZUZldCNitmMzJLVi9zRDZPYXFyTkdFaFVn?=
 =?utf-8?B?NnhMTUJKL0V1bVdDOUl5QkUreFhxNEtBcHVhdTJMc2dQbWRmVHJjTElEUVB0?=
 =?utf-8?B?bldiRFdScDhpcld3cjcyLzRBM0MwdkNVRmdsSTFXNzFrUlhzT2g3Q1B4clQ1?=
 =?utf-8?B?Q0Eyb3B1cWJsWWxOeGJtWE5YcGxVZWJwVEltT1o0WXFKSm5ZQTlySnpNNzhV?=
 =?utf-8?Q?SNu/duT01LMmwmDVqL5jCskRP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa84636-bbd0-4377-902b-08dd4f438630
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:09:19.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WC+rr5k7SKjL3KymltitaBLZuxep2JzTdjyPfM8DDM6g6GjipwGAUXQ0uH79ggOn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003



On 2/17/25 10:52, Shubhrajyoti Datta wrote:
> The "interrupts" property in the ZynqMP power/reset binding was previously
> marked as required. However, there are multiple mechanisms for
> handling power/reset events, including:
> -Event management registration,
> -Mailbox (mboxes),
> -Interrupts (interrupts).
> 
> When event management support is available (default on Versal SoC), the
> "interrupts" property is not used hence not required.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>   .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml       | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
> index 799831636194..079ad977b907 100644
> --- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
> @@ -46,7 +46,6 @@ properties:
>   
>   required:
>     - compatible
> -  - interrupts
>   
>   additionalProperties: false
>   

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

