Return-Path: <linux-pm+bounces-10901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5B892C8CC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 05:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0FBB21DEB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 03:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD233986;
	Wed, 10 Jul 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="VLeZE1kO"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2102.outbound.protection.outlook.com [40.107.117.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8072E414;
	Wed, 10 Jul 2024 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580445; cv=fail; b=jt7ZV0HBB9FtYvR4IpLlTp61cXOl159JCQ0f5MXvA82v/XuHsQu6rVF39pqzL0imh4u87VPvdZPrWNNTbp4pjSWyapcTkOw+lyP3hMB5TzGoIzs2NJjdmyhMcufajcJm9cM4kCSgnK7kTfzJvFuYNnem9JIWSxxuU1DOD2VLjU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580445; c=relaxed/simple;
	bh=cCBPQYRD2ZE81qEf/7ialNxlWLkms2gWMHMdEsAorsE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+ae1+ulBovynbhUDBRUlx5eX8w2QYJOT+l4uRIUd6o1jSIQRC/7QznsVUE5VGeLGfOlq2XSDEE29rIgDgjKmdc6V8sL+qki9rYvRI9oqS8K/4u8Kj5HKwAvBtKmqO33+iuSy9nuOOJaQ+IKLQylVQ54cmXlcgQyW810O+QIRHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=VLeZE1kO; arc=fail smtp.client-ip=40.107.117.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UB1McHwktOeDalWHBtLP0e99Wou0J/qelfTTjZzifA6JBPZCDAckh1qwWabK/jUDVCpStON9+3xH2KH4HkCzeLXT5xn/vJxZwX3QJ5HOm4OgbNroDoLsQ1JtbcwR7dVMUJCjyJAtDKHg+cRorQ1/EJoz8kdW/eC8F4+4Ku5GCzKgjYf7UwEt4UUt5kz99iD/MVug5lNQsdSiytGq/I/tWsl6K8KL4RQcDj0mjlRS4W9BS4o8wRQ5aGKNQ/D8VpPGiXmVADSu3p3SBPFP96phkbxxl9OiChUcd2ampOMdveNyDSccrAEkRfYyy/bwX8jucsOGNaaieCrDDJ6s9XisGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X/mO+T/3ER5nxQenRXaEXU+72EdmYLRzNSZ3FUIR+8=;
 b=EBlFG6f1hjDrciEOl4cULr70DzdkY3nthWtVRt+SxXVXjhMK/ZLK+X7r+Y7bv//j8CLa3Mjg90RQu6ivTQu69caKNEN+E2BemK9uU2N53dUwfb/WgtegCEuUgIUvY7XAVyJp7hPIyuriKBNDw1uDWiVv9n4sLvNtj2ih7vtnJs2RKdDK1YBcxoj9GsAuGI9bo/I6cOUxCqCQ6HUIWEB4oo2LV0Q5lXsmKbwFsFwwE7Sm2IuEbQkDIM3NT/p3SwWO/lLkCSUqrqtPiWY+Z3YnDp0h4oIu2FMLs+mw9rx9Jihx6Bs21TSrxZp/drIZ5oD4y6/kz9/d8aa3m4CgSfszZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X/mO+T/3ER5nxQenRXaEXU+72EdmYLRzNSZ3FUIR+8=;
 b=VLeZE1kOPy3Y14UnMSquX/6GC1EFvy58xvWwSP16ugARCACCSaslcKUtMkZmv90ki2ueRQWc0kmYqMK8LcPaBxK+88RTDXyL0EwbK7lan1L++GWtApfzKrZw4mChAuZ6h33bvFmw50X4Rcjsk99Cxf7xdB6zcw8CBIho18HEV9BWaAprssBvyVuNOfqwerHAe61vaewOtqGSoEDHfnYFEvPx4+v9t4kkUjqCZKseerFa/0eTha53lBX94FdWNGqx21kFbMzfr7SBUmDza7NdsR16uagMfRg+YvfYieN/Yzxf4KGULkENa26FQNyQbuDGVQz95oY4GvLKpBFefU7THw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB8824.apcprd03.prod.outlook.com (2603:1096:820:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 03:00:40 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 03:00:38 +0000
Message-ID: <fbc089d4-8be9-4ebf-b84d-04fbd3d5a253@amlogic.com>
Date: Wed, 10 Jul 2024 11:00:13 +0800
User-Agent: Mozilla Thunderbird
From: Yang Li <yang.li@amlogic.com>
Subject: Re: [PATCH 2/3] power: sequenceing: Add power sequence for Amlogic
 WCN chips
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
 <20240705-pwrseq-v1-2-31829b47fc72@amlogic.com>
 <CAMRc=MeZvHV-iOSTcaki=+8_j2Uqm_qpY3b1V15o9K0zefy+hw@mail.gmail.com>
In-Reply-To: <CAMRc=MeZvHV-iOSTcaki=+8_j2Uqm_qpY3b1V15o9K0zefy+hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR0101CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::19) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cadb034-1d2d-409f-ada4-08dca08c79d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THhxMk9CanUycUQvS0tCUFBvb1ZnZ0JJak9yZmpvdk4zTGNlaW9kMUxGSzJK?=
 =?utf-8?B?cHVkTXMxYXlTTUdFV3lUb1dXWWdweDZpMVMwMU1vZzR5bkVNVHMxRjM1ZEpV?=
 =?utf-8?B?VUxsK0t1WmdlczVXeml1eHJxTnkwdFNzRHdXVUp3bnZBejBJNWRGcWdNeGNV?=
 =?utf-8?B?L1FxR3ZlNzlYVldlMGhoUDhUZThsaFduaTJDRkJEbUtvZHEzeFdDTXlxYVMw?=
 =?utf-8?B?dnE3bnhHaXV0aGZjTWViTjBFdGRabExiTzhuUURrVS9Oam0yVUNIa3ZhUDhW?=
 =?utf-8?B?dU1QUGVxd2VFTStNclZJOHpNbDhabUdSeTE5Z0tQMUJYaUttQ01IR1BwRzJR?=
 =?utf-8?B?Z1hUZTRCczNFeXhYT215eGY4eVdXWEY5bHQvaUpURlBXamE0U0NFeXF2N2dJ?=
 =?utf-8?B?Q084YU5DWFVMWEhuRHdkQWJkamt2V3M5UktuVnA3VEN4M1hITWV6NDQ4ZXgz?=
 =?utf-8?B?WllPMS9LNFpWZEdqT3hGUk5VakVCRE5zQUp0SmNDSk4ybWdYRWd3L3RNdjhy?=
 =?utf-8?B?THJxVnVJOG9JYmFJbnpuNmJrZGZaajQ3RU9vVDFLMVVUUHU4UUIxY1l4S09B?=
 =?utf-8?B?Nm1kMzVZckZPUUdPNytLeUhsRWRRVEJpUmZRWXhodzNuYmJqZlpvWEE1K1Bq?=
 =?utf-8?B?bmZRelVKTTRXWStpQ3JOUXhNZHdmK2NIY1Z3REYxdGVKaFhnUGVvOVQzcjdj?=
 =?utf-8?B?TXZJNHE4dkI1Y1IwMUtjU280QWNRYUhKbkttQ29IQU8wcE5VQzBuQjVad1V3?=
 =?utf-8?B?NGU3TVVGdFpaNzVROTJNbGNjS2ZEUTF0dTg5cHlNUjV0d3R5K01zQUlpYWk1?=
 =?utf-8?B?ejNvazg2Y25ST29ya0RGNVFHeC9oekdqL1dPRmNuOStRalFTdVU3TytsZWl0?=
 =?utf-8?B?ZGxTSzYwcmZ6REMwNENNdmllQmgxMXpIeGhsRS9SeTJzUEZnMXVEdmtNSXJ3?=
 =?utf-8?B?RXNXdXRxQzU1R0hGbzdSdjF5bnA3U0tTN3ZDai9qRFM5QzFmbC9Kb3p6SStE?=
 =?utf-8?B?U1o1amR4MHBWdDI0SkIxYVpaOE4zL1gzY0k5dE50eTFuUThMbVhzQzcwdXYw?=
 =?utf-8?B?bDREYzl2RnB6ZEJBalVDVmVuT0FsYmZ4Rzd4VW05UXFUY1loMWlRUUJPS1Zj?=
 =?utf-8?B?eGZJVFhtb2x5WWdMZU8xelNaTTY1MEdVdE9GREQ4MlgyY01YWGFkREl3OGZy?=
 =?utf-8?B?YmhndTRIOFpqUW5HcVpsbkxwNUt2YXhvSFQ3bFpoVTZuL05ob0JtRnNVa1pv?=
 =?utf-8?B?VlJCNm1JVExuWG9lYStvVGtTenMrRmYzSUtxZWlmbTgvK2pHT1JaRFhjOGJF?=
 =?utf-8?B?VkVxM0d2dmxhVUZsYnd0c1l6bCt3NWxDQWpLWlFBWlBTbHJzaSs1ZVNVL1FM?=
 =?utf-8?B?dVF0Y2VEZ0I3YUF2b3hqR3lKcnY3TjN6WEZMbDlab3p6aE5xTmVBKzdQU3Zx?=
 =?utf-8?B?ZHhKQ1BWWnhHYTVwZTl1cStJUENFSDNkMTVrS3pxRndGcTZyeXI1OVhDczVj?=
 =?utf-8?B?NmhiYlNQWEM4aVp2ajlYNDBON05ZNGwwMCtFT1BFUVdLT05FSUJDQy9lTGM3?=
 =?utf-8?B?cE5HMkZBTWgybWladlVnR3lyQmRKL2xVSGdFSEx1TUR5d1I4T04rS1J2REhS?=
 =?utf-8?B?b2dEbFlwRDVDNUhpYVN1akl5ZHVvYUwvU2xIclhoOFJhZUdUT1BOekk3SExH?=
 =?utf-8?B?OHc4SXBhL01VOHdjUVV1cnhJTUs5bW1EYmRmK3Z2VWdEL29jZGdSblp6QVY3?=
 =?utf-8?B?QXNrUHBuVlhCRTQwOEZNTHF6QThPWnVLN2JFQmZZcnF0eEx6L1B1SmZzQ1ZX?=
 =?utf-8?B?Z3UrRW13SzVaTzJIWlNwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWlxNDVwTDFObTVGUFVORUZ5NGVIeTZIc1JXZ2ZCS3htTmNqdm1JVXViUk5S?=
 =?utf-8?B?NjhBOGJJeGhXdE1XNlQ4RW5yb2k2eFVLcm11cUJtVnZlSElMZnNsS0VVdWpY?=
 =?utf-8?B?dlA4ZnF3cFhkWElldktkMElwcUpLZTd2MmZuSnBxVHZ3T3loYlhVeUtyckN1?=
 =?utf-8?B?V012LzZ3YXZ2aXREc2p3b2o0bnAvRWhiTTgvdUI3L1oveEorZlBBT01MdFlZ?=
 =?utf-8?B?Q1J5YnZxZXUwc0tDdFZGeUZlZWJiTi85M2FZQmErVEdtV0ZFaDZJV1JGK0to?=
 =?utf-8?B?d0ZaR0ljWlNtQW1SUnJOdWdIaWNlbmJ5bHYrTE15SFVVcHBJeUt0ZzYvVlZw?=
 =?utf-8?B?VHFrdno3eE1mZjRCUkVlWjNiZFRNekYwMTBHNGl1bUFnUUY3bDZIY2VvelF5?=
 =?utf-8?B?R1FYcVp5U1BzdDVsNUl5T3RSTmVLTXFKZ3hmUjc3ckFaWU5NWUpWdGpXUkJN?=
 =?utf-8?B?VDB5Vmx0UHF2L1pqeWE2MXNNVWgyNVVWdW1LTW1HSi9PT1JPZjBqQ0dTdUVT?=
 =?utf-8?B?bFpqVkplZnphVG5MNml2TzNxUUJWb21ONmNuVGVKZkNsR2ZmZjArWjQ2U0pn?=
 =?utf-8?B?WnRndW5xcjVHam1wOW52VXZ4TStQeHJubVF0SmFJUFZQRGRpYXEyUlNGTVQ3?=
 =?utf-8?B?VlJhKzBuVDh2SG9wR01Ea3dGUDdjeXdIejJtVW4wYW43SlpHcHBYVFZtYWVo?=
 =?utf-8?B?VVlGRVpVVm5OV09uZ0tJZU5BVE5ncUFFU2JUaGNMT0ZDc2RzL1hjOFY3TDlu?=
 =?utf-8?B?cVppUTJZbEhvT3NIejMyMUEwMzF0ejBRZms2QVFyRVFDeFUybmovaDBVcmNL?=
 =?utf-8?B?c3N2WEhrdXVlK0RBNko2U0tPQkxrcFFSdnFjZVFBK3RFbXdFYk1yL3YwcmFq?=
 =?utf-8?B?YVRCQlBwVlV2bms3U2VOb0J0MHBEOEhaYjVrVWlXOUxpZTBWLzN5WGZtYWp4?=
 =?utf-8?B?M21JRkh1MDlmZ3M2WXE5aUNTdUp0Ump6WHhoSjhjOWZsYUlsT0NXWDNmV3dU?=
 =?utf-8?B?N044R1JBb2FtQXdTM1VCdnljc0VHT2RzMzVZL2Q1U1NCSnpjT2dhaWNIcktl?=
 =?utf-8?B?T2h2L0F3ajNpV1VHNkNGZisxSkE2bnl2U01rbCtIYU0zMmNIN2NHTFFwWWF3?=
 =?utf-8?B?czBNNTdzczJSTGpmVUp3U3AzNUN1SVY2dGpaNUQzaEJaYkFpVU05V0lyQmF5?=
 =?utf-8?B?NG9XTVNiSk5KZ0dKWm04cWZvTXN5RU82SHZ6bWI1d2JvSGpHYmQ1YVZ0Q0lR?=
 =?utf-8?B?WjAzMmtnT0hqRUtTOUEwWFVpTlNOdlNWWWljVlAxV3Qxai9ma2hPa3UxK0RT?=
 =?utf-8?B?cGNPWVJrNTZNa01kM3RNTWhIYXdCMUZUWTNPNUtQelZ4eUtGUEIrZjZuNU8v?=
 =?utf-8?B?NXdqZkFmekF5Mktkd3pQRnA1bkJEZUxQVGxtTzBuNXFUSXNkcnkxWndUM2lF?=
 =?utf-8?B?bHhobjhpUHBzMWVudEVKOEpIQTJPZXNKWXlhMXZWODVESDg3OW9IbllCekFt?=
 =?utf-8?B?c3B2RHpSL1p0bkpnVmN5SXhzZWZxbENXZzU5cERybVpNUkxXZUlNc0o5V2sx?=
 =?utf-8?B?QzFSSEdzQkZoLzAyL3RPTE0rRFkzMCtraDFBK0pLeVAvZEpjeGRudHhVZFZX?=
 =?utf-8?B?MmlYa1dzZXBtaFVscjJNOWltd2FyVi83SDZ0K3hjU2dWeTdWam9vUm5lSWpB?=
 =?utf-8?B?dnZINW9wSGZxdFNaR3J4SkVzMVUycGpDcC9vZGU3UlhQek1yVGlucnpnaTZp?=
 =?utf-8?B?SUN5dU5HZFFrWUo2SFR6bHBVYVAxQ2VYZXVrTUZsN2V5bER5VEh6VzJ0VTlF?=
 =?utf-8?B?RVpIbmJDWWo0MWdNMTVLamZrMjJoNklxalA3Q1pabzdJa3kzUFdrYkNWMXVU?=
 =?utf-8?B?SzNYQTNLeEp4N1cwRlBoaE4yNUNmS2FlTjZmSDNyRU9TZVZPQVZaZnpFNW0w?=
 =?utf-8?B?S2hlaFU1eUdON1YwT0p5dTZMa05OZzhsemh2NldaR2xraGwwT0xaRWo0Qktw?=
 =?utf-8?B?Sy9xQzNiRWoveGpXVmdlbk5iSkZtbUxwMllwZ1prcllSY3FJdnY1bUFpOXZh?=
 =?utf-8?B?bVB5bnhzVW16Tmprait4QlV4Z3lkZmllbjVIaHlvRGtGREtaVzgycjl6MC9y?=
 =?utf-8?Q?bsTOWHJoypTMazB0RdsSvE4qN?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cadb034-1d2d-409f-ada4-08dca08c79d9
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 03:00:38.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67gjxApNjxvaNJIHFn2uwACgbjVo8Z9O1uV+jPLeWA1cHWr+sjj1VKpwnVOm3KjO0dD695hyDj5BpmZZ1F9KrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8824


On 2024/7/5 21:46, Bartosz Golaszewski wrote:
> On Fri, Jul 5, 2024 at 1:13 PM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org>  wrote:
>> From: Yang Li<yang.li@amlogic.com>
>>
>> Add power sequence for Bluetooth and Wi-Fi respectively, including chip_en
>> pull-up and bt_en pull-up, and generation of the 32.768 clock.
>>
>> Signed-off-by: Yang Li<yang.li@amlogic.com>
>> ---
>>   drivers/power/sequencing/Kconfig          |   7 +
>>   drivers/power/sequencing/Makefile         |   1 +
>>   drivers/power/sequencing/pwrseq-aml-wcn.c | 209 ++++++++++++++++++++++++++++++
>>   3 files changed, 217 insertions(+)
>>
>> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
>> index c9f1cdb66524..65d3b2c20bfb 100644
>> --- a/drivers/power/sequencing/Kconfig
>> +++ b/drivers/power/sequencing/Kconfig
>> @@ -26,4 +26,11 @@ config POWER_SEQUENCING_QCOM_WCN
>>            this driver is needed for correct power control or else we'd risk not
>>            respecting the required delays between enabling Bluetooth and WLAN.
>>
>> +config POWER_SEQUENCING_AML_WCN
>> +       tristate "Amlogic WCN family PMU driver"
>> +       default m if ARCH_MESON
>> +       help
>> +         Say Y here to enable the power sequencing driver for Amlogic
>> +         WCN Bluetooth/WLAN chipsets.
>> +
>>   endif
>> diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
>> index 2eec2df7912d..32706daf8f0f 100644
>> --- a/drivers/power/sequencing/Makefile
>> +++ b/drivers/power/sequencing/Makefile
>> @@ -4,3 +4,4 @@ obj-$(CONFIG_POWER_SEQUENCING)          += pwrseq-core.o
>>   pwrseq-core-y                          := core.o
>>
>>   obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)        += pwrseq-qcom-wcn.o
>> +obj-$(CONFIG_POWER_SEQUENCING_AML_WCN) += pwrseq-aml-wcn.o
>> diff --git a/drivers/power/sequencing/pwrseq-aml-wcn.c b/drivers/power/sequencing/pwrseq-aml-wcn.c
>> new file mode 100644
>> index 000000000000..6f5bfcf60b9c
>> --- /dev/null
>> +++ b/drivers/power/sequencing/pwrseq-aml-wcn.c
>> @@ -0,0 +1,209 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +/*
>> + * Copyright (C) 2024 Amlogic, Inc. All rights reserved
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/gpio.h>
> Please see line 5 in this file.
I got it, I will remove this line, and include linux/gpio/consumer.h.
>> +#include <linux/of_gpio.h>
> You don't need this either.
Yes, I will remove it.
>> +#include <linux/platform_device.h>
>> +#include <linux/pwrseq/provider.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +
>> +struct pwrseq_aml_wcn_ctx {
>> +       struct pwrseq_device *pwrseq;
>> +       int bt_enable_gpio;
>> +       int chip_enable_gpio;
>> +       struct clk *lpo_clk;
>> +       unsigned int pwr_count;
>> +};
>> +
>> +static DEFINE_MUTEX(pwrseq_lock);
>> +
> Why is this global?
Okay, I will add it to structure of pwrseq_aml_wcn_ctx .
>> +static int pwrseq_aml_wcn_chip_enable(struct pwrseq_device *pwrseq)
>> +{
>> +       struct pwrseq_aml_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
>> +       int err;
>> +
>> +       mutex_lock(&pwrseq_lock);
> Please use guard() from linux/cleanup.h.
Well, I will use guard(mutex)(&pwrse_lock) to replace 
mutex_lock(&pwrseq_lock).
>> +       if (ctx->pwr_count == 0) {
>> +               gpio_request(ctx->chip_enable_gpio, "chip-enable-gpios");
>> +               gpio_direction_output(ctx->chip_enable_gpio, 1);
>> +               gpio_free(ctx->chip_enable_gpio);
> Not only are these legacy APIs but they are also used wrong. You
> almost never want to release the GPIO after setting the direction as
> someone else may grab it and use it.
Okay, I will use consumer API of devm_gpiod_get() to replace them.
>> +
>> +               if (!IS_ERR(ctx->lpo_clk)) {
>> +                       err = clk_prepare_enable(ctx->lpo_clk);
>> +                       if (err) {
>> +                               mutex_unlock(&pwrseq_lock);
>> +                               return err;
>> +                       }
>> +               }
>> +       }
>> +
>> +       ctx->pwr_count++;
>> +       mutex_unlock(&pwrseq_lock);
>> +       return 0;
>> +}
>> +
>> +static int pwrseq_aml_wcn_chip_disable(struct pwrseq_device *pwrseq)
>> +{
>> +       struct pwrseq_aml_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
>> +
>> +       mutex_lock(&pwrseq_lock);
>> +       if (--ctx->pwr_count == 0) {
>> +               gpio_request(ctx->chip_enable_gpio, "chip-enable-gpios");
>> +               gpio_direction_output(ctx->chip_enable_gpio, 0);
>> +               gpio_free(ctx->chip_enable_gpio);
>> +
>> +               if (!IS_ERR(ctx->lpo_clk))
>> +                       clk_disable_unprepare(ctx->lpo_clk);
>> +       }
>> +
>> +       mutex_unlock(&pwrseq_lock);
>> +       return 0;
>> +}
>> +
>> +static const struct pwrseq_unit_data pwrseq_aml_wcn_chip_power_unit_data = {
>> +       .name = "chip-enable",
>> +       .enable = pwrseq_aml_wcn_chip_enable,
>> +       .disable = pwrseq_aml_wcn_chip_disable,
>> +};
>> +
>> +static const struct pwrseq_unit_data *pwrseq_aml_wcn_unit_deps[] = {
>> +       &pwrseq_aml_wcn_chip_power_unit_data,
>> +       NULL
>> +};
>> +
>> +static int pwrseq_aml_wcn_bt_enable(struct pwrseq_device *pwrseq)
>> +{
>> +       struct pwrseq_aml_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
>> +
>> +       gpio_request(ctx->bt_enable_gpio, "bt-enable-gpios");
>> +       gpio_direction_output(ctx->bt_enable_gpio, 1);
>> +       gpio_free(ctx->bt_enable_gpio);
>> +
>> +       /* wait 100ms for bluetooth controller power on  */
>> +       msleep(100);
>> +
>> +       return 0;
>> +}
>> +
>> +static int pwrseq_aml_wcn_bt_disable(struct pwrseq_device *pwrseq)
>> +{
>> +       struct pwrseq_aml_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
>> +
>> +       gpio_request(ctx->bt_enable_gpio, "bt-enable-gpios");
>> +       gpio_direction_output(ctx->bt_enable_gpio, 0);
>> +       gpio_free(ctx->bt_enable_gpio);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct pwrseq_unit_data pwrseq_aml_wcn_bt_unit_data = {
>> +       .name = "bluetooth-enable",
>> +       .deps = pwrseq_aml_wcn_unit_deps,
>> +       .enable = pwrseq_aml_wcn_bt_enable,
>> +       .disable = pwrseq_aml_wcn_bt_disable,
>> +};
>> +
>> +static const struct pwrseq_unit_data pwrseq_aml_wcn_wlan_unit_data = {
>> +       .name = "wlan-enable",
>> +       .deps = pwrseq_aml_wcn_unit_deps,
>> +};
>> +
>> +static const struct pwrseq_target_data pwrseq_aml_wcn_bt_target_data = {
>> +       .name = "bluetooth",
>> +       .unit = &pwrseq_aml_wcn_bt_unit_data,
>> +};
>> +
>> +static const struct pwrseq_target_data pwrseq_aml_wcn_wlan_target_data = {
>> +       .name = "wlan",
>> +       .unit = &pwrseq_aml_wcn_wlan_unit_data,
>> +};
>> +
>> +static const struct pwrseq_target_data *pwrseq_aml_wcn_targets[] = {
>> +       &pwrseq_aml_wcn_bt_target_data,
>> +       &pwrseq_aml_wcn_wlan_target_data,
>> +       NULL
>> +};
>> +
>> +static int pwrseq_aml_wcn_match(struct pwrseq_device *pwrseq,
>> +                                struct device *dev)
>> +{
>> +       struct device_node *dev_node = dev->of_node;
>> +
>> +       if (!of_property_present(dev_node, "amlogic,wcn-pwrseq"))
>> +               return 0;
>> +
> You must never reference the notion of power sequencing in the DT.
> Please take a look at the pwrseq-qcom-wcn driver where we model the
> PMU with its regulators and then parse them in match() to figure out
> if we have the right thing or not.

There is some different between pwrseq-aml-wcn and pwrseq-qcom-wcn, 
pwrseq-aml-wcn device is abstracted to manage the chip-en pin, bt-en 
pin, and 32.768KHz clock. The drivers/power/sequence/core.c requirements 
need to be defined match () function is used to determine whether a 
potential consumers actually related to the sequencer. So, I need to add 
a meaningless node "amlogic,wcn-pwrseq" to both the consumer dt-binding 
and the provider dt-binding.

Right now, I add "amlogic,wcn-pwrseq" in binding file of 
"amlogic,w155s2-bt.yaml" only, may I need to add this properties 
("amlogic,wcn-pwrseq") in the binding file of "amlogic,w155s2-pwrseq.yaml"?

Or there are any others way to fixed this issue please let me know.

>> +       return 1;
>> +}
>> +
>> +static int pwrseq_aml_wcn_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct pwrseq_aml_wcn_ctx *ctx;
>> +       struct pwrseq_config config;
>> +
>> +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +       if (!ctx)
>> +               return -ENOMEM;
>> +
>> +       ctx->bt_enable_gpio = of_get_named_gpio(dev->of_node,
>> +                                              "amlogic,bt-enable-gpios", 0);
>> +       if (!gpio_is_valid(ctx->bt_enable_gpio))
>> +               return dev_err_probe(dev, ctx->bt_enable_gpio,
>> +                               "Failed to get the bt enable GPIO");
>> +
>> +       ctx->chip_enable_gpio = of_get_named_gpio(dev->of_node,
>> +                                              "amlogic,chip-enable-gpios", 0);
> You don't need the OF variant. Use the regular devm_gpiod_get(). You
> also forgot to release it but the devres variant will take care of it.
Well, I will do it.
>
>> +       if (!gpio_is_valid(ctx->chip_enable_gpio))
>> +               return dev_err_probe(dev, ctx->bt_enable_gpio,
>> +                                       "Failed to get the chip enable GPIO");
> Wat
I got it, and I will fix it.
>
>> +
>> +       ctx->lpo_clk = devm_clk_get_optional(dev, NULL);
>> +       if (IS_ERR(ctx->lpo_clk))
>> +               return dev_err_probe(dev, PTR_ERR(ctx->lpo_clk),
>> +                               "Failed to get the clock source");
>> +
>> +       memset(&config, 0, sizeof(config));
>> +
>> +       config.parent = dev;
>> +       config.owner = THIS_MODULE;
>> +       config.drvdata = ctx;
>> +       config.match = pwrseq_aml_wcn_match;
>> +       config.targets = pwrseq_aml_wcn_targets;
>> +
>> +       ctx->pwr_count = 0;
>> +       ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
>> +       if (IS_ERR(ctx->pwrseq))
>> +               return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
>> +                                    "Failed to register the power sequencer\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id pwrseq_aml_wcn_of_match[] = {
>> +       { .compatible = "amlogic,w155s2-pwrseq" },
>> +       { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, pwrseq_aml_wcn_of_match);
>> +
>> +static struct platform_driver pwrseq_aml_wcn_driver = {
>> +       .driver = {
>> +               .name = "pwrseq-aml_wcn",
>> +               .of_match_table = pwrseq_aml_wcn_of_match,
>> +       },
>> +       .probe = pwrseq_aml_wcn_probe,
>> +};
>> +module_platform_driver(pwrseq_aml_wcn_driver);
>> +
>> +MODULE_AUTHOR("Yang Li<yang.li@amlogic.com>");
>> +MODULE_DESCRIPTION("Amlogic WCN PMU power sequencing driver");
>> +MODULE_LICENSE("GPL");
>>
>> --
>> 2.42.0
>>
>>
> Bart

