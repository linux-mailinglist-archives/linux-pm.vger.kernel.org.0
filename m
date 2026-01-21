Return-Path: <linux-pm+bounces-41216-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNbzMq2GcGkEYQAAu9opvQ
	(envelope-from <linux-pm+bounces-41216-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:56:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73185531F2
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6C114684CE
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977F4657E8;
	Wed, 21 Jan 2026 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nt1HxKfS"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B30410D26;
	Wed, 21 Jan 2026 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982167; cv=fail; b=lRT2YiZDN33oD8Wq/2hL6YXlNU/Pz+/u9Zn7nMFday57CGHXkvAsYFJTAi2Yt2pnG5yVsa1R4m4oKFfCmudwHGcvihp8TzH6YiVFPCC3SolOx6bNNLRGdlZGRXC9HtEfcFdkTKgn5MdjGL7qLnPla16c5t/XR6qoj19mliqztQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982167; c=relaxed/simple;
	bh=MzgMnBc38mh8QvvBRLwuch1GXT0ojXm88MbFPcxajOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7gd16CoobBuvjenWoWpslbRYvt15d7/ybGwzePu27d4TeiyhVqnszIbIQ6fjemoEH2g22s/R2FZu9vwiC3Ai/q7+wNS1QmYJFz7DEJ73DnFtYXZR6jhu08s/pVc8KeFp6WPjseFUof1gurmUt9K1Dk6Win/41ZcmLVEbWYna8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nt1HxKfS; arc=fail smtp.client-ip=52.101.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjScGTzOHgwSN2roSu26MIrQgS7APDZuUtkwKOP2BlWRwy8agbBadlWAaS5X34AVWee7aCDr9TfzhZTYiCEbK1y/6/Q22X39WddcdLbPpwRDMwY/5pDc9PpEcrhaBrfVdrt9bp2z+9gHnu8yChhb9N1uLxxAMBkjACMV1QZUYiQi1fMrPTRp4hOiVLEza21jDckGzrhUT1L/6ZGbFgXqOnrehqZq7QAMwwBiLiIdM1kqVDvL4OzyaP9GUORZLy1LwIyKNz+AUuEKG1v3z0u/OEhvz8c7jPDZD2AglZWsu3bCTgX0aNQql6/zf2p4cTeh4qPc2Wfw01McaQ68Ff6hdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP4GmfZHOq6QDF3kz2Tr10aEJB1BOhDhmU6FB0yf/3c=;
 b=VRl5pVpiqjv/E0qZ/+KCqUD0rrCHOiBq/1nXf0ojigxdLTGbU/og88phCpsgXp+ep4dgPcE89WHumUALeQY80iGvsoXon5oITVvsd+tqEZzpJBs7BXI2yuUk9dsK6n3rk6NNv6nmFSwrqb6+fNDn0Ca1BvMHPoanfme4jWkloIbxiytfBGofCIdCiHQNHDsrOt2mZ+eIPupfErhsXBXmC6uWRZreh0xTi230el05wcRfsnXrcqrSNNeUwrY/yjVVQucRPcrphf9KkyGWHX3j+EWhcmxbiNYxKQSjTfi5ZeJNTviZEPU1ARdnBlCqMjgBgyRvexBR1IAauftRYGmDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP4GmfZHOq6QDF3kz2Tr10aEJB1BOhDhmU6FB0yf/3c=;
 b=nt1HxKfSi1sDccgYd9jqeSQ01AbU5tFa4ff0goeMXb43I0NrQ9/jPfz9ApQ6KVWXVI4mHcVrWL47giJbmBAch29Wozn19uFzEnYfUCszxlCef7qoG/nfWGvFDUMP7xgLsnWraqqS3eKNvf0bNHyHPSyUVG+aoCjbJExF3WczYw4Zl4EZ4JquJn7MYY8wJ73T/oLv8S2VsF1dy1vzuQmR65R/hswAe7H+fwoj/PPkPNz610Sm3AlGWGfy4wj7ScrPi7x5ic+GacEcqjTn5Ab09uSgjRWvzeVOLBpMfTAaro0Io0XLpR8G+6INiqVhS3BQS9M3R9MkPht1dFxl9ekf1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 07:55:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9499.002; Wed, 21 Jan 2026
 07:55:59 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v4 11/12] ARM: tegra: Add EMC OPP and ICC properties to Tegra114
 EMC and ACTMON device-tree nodes
Date: Wed, 21 Jan 2026 16:55:53 +0900
Message-ID: <4370037.mvXUDI8C0e@senjougahara>
In-Reply-To: <20251125120559.158860-12-clamor95@gmail.com>
References:
 <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-12-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: da7d2700-762d-4f93-ea72-08de58c283a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cys1TjYrRkp5T1JuTmlqOHlmdzU1TVdwTkMvZzhQWmd4ZVM0djloRUtPQ2FW?=
 =?utf-8?B?Mmp3R1UrTlFESTFTVFlBbWpraVFESFVJMy9jTXlheVpYcUREM3Y1d1NuRlYy?=
 =?utf-8?B?VEN0Y243VXMrNy9RVzR3bHBEanpvZm5xdG02bUpRSlU3SE9ib2l6VmoxR3lk?=
 =?utf-8?B?TlhST0x2UFN5QWk2RXdjMG4vSGw5QWlxeWNGaXdqYWpsQW5qMTcwRGoyVnQ1?=
 =?utf-8?B?MXdpWktoOUVSS0t2aG9TTTV0SXZoMEM4QjhvaVhJTUZQTml0ck1lTzVDcTVo?=
 =?utf-8?B?VEE0ZjlTbE02Y3pJZlErdTRyaDdQMTNHUGtvY2o2UTRUMVNxVlpJcHpISnNI?=
 =?utf-8?B?RXltaVNiQjRNWG02S1I2VEhST0FZR1hkSjJaNjdBR1NJS2t1Vm5Za1N6RnBU?=
 =?utf-8?B?elgyNU55N2U3OVVpakN0QVhvbnpIaWVBODV1Z0pSdzVuRDBkZG11WkNUQ0M0?=
 =?utf-8?B?MVB5TVVsMGovdkdCbzBKZ0t5Q1hvWjZ2d0oza1dNSVppanlSQ2dKa3NkZG9j?=
 =?utf-8?B?MmEyUkZtTG41V2dkYld0SDIrU1NXeE1leXNhdmdYZU0wRHMrbnM3b3ZmZXdy?=
 =?utf-8?B?cFZrbGZvam1BZ2xyaHlGNVg3QkxIa0xmcEFUazg3L3BPUHpoMzRTWUR6TWVq?=
 =?utf-8?B?cTRIYWhNSVkyWXVXdG1qM1V4LzlaMVAwNXVMZ1NDcWtuOEVRbzB5aVVsR3Bv?=
 =?utf-8?B?ODl6V2h1cWxRaStibHhRMC9KMnhuc1hOZmdnNkxHU1pVUE8wVlRCZnhFQ1lQ?=
 =?utf-8?B?SnhtQUk5OUM4aG9DU1RtZUhyRlNFczVOTlhOczh0ZGhaOFR1SklGZ1FlTGV6?=
 =?utf-8?B?S05TbjBiQlJ1K0orbEdpU05ncGRDUFV3UlU2cWZkWjBTQTZPZHFJa0tRQzFv?=
 =?utf-8?B?OWVqZXRvWjBaUlM0UGo3dGN2cnQ1cUIxS2haODhqQWNFQ3J4SGdZcGcwVVF1?=
 =?utf-8?B?YytpOWpXOXNrK3dTWUg5ejhhWUkxeUhCY3FyQnhsamtha1lnejROQkNFVGZV?=
 =?utf-8?B?a3ErR3JWWTkwand6UllmL3FoWURUSUtNcXpYUVFvSHlHNmNkbjF2Y0ZkV3VO?=
 =?utf-8?B?YkVwc2hvYitud3dYeTRZeGZsZ0tWTlNuWHNFaVlrSDlJWGhUc2NQemFHN1dl?=
 =?utf-8?B?THJPazZTY1lXYjJNa1A5YkFyMVFnYk1VdkF0NjFnemZyR3p5cmFBMExOdGVG?=
 =?utf-8?B?N1pUTURqRFREMjNZWnhkQ2hHSGh5M0YyTWJiYjh3NG5EdXhuNGJNT0s3ZG0z?=
 =?utf-8?B?TXV0Y0NHVTNGUjBJSHk5Tmh2SklWQ3dOQ29od1h0elU5TkVmWEQ5N3h2Qmt5?=
 =?utf-8?B?WFhVTW5JdVVmUU1wMk84ZzJ6a3dyVjRYcjhNSlNxUkl6eEQzcC9IbHk5aytQ?=
 =?utf-8?B?QXZjUDBsZXM5cEcxNHNCMk80aEJJajJSZHFlb0FQYjhyM1FVRGs2V242YmhU?=
 =?utf-8?B?bklxeVVFL0dNN2crL1lCTzVGN1lGZFd5djVBb2g5dHFCbDdQUG9tSEZvZ0My?=
 =?utf-8?B?QStmeGJGSlVpbzBrcGdrSkk0dW9ZOUF3WkRxdjkyZGwwekprTGt5QkRHQnN6?=
 =?utf-8?B?TTA1Q1gwSWhlL3pJbWZLMTQyUUZqM1lEVWxRM1hiZmg0QmJmMHBBMHFiWTcr?=
 =?utf-8?B?OCtaZUpzN1VYR2UweFNMVVBkMXhodlp3N3cyaS9LczQ5WGJPNUlyZ0ErSm94?=
 =?utf-8?B?TUNQZHBaeHVkTzBBVFpGblcwMlhiR1dTaEhjN2VZMDdVazNVTkcyczdKOVh3?=
 =?utf-8?B?MGlLNko4SVdHbDlwNWVZWTdMbzlrcVlNSGtPc21nRTdQS2w2YWovdm4rNTQ1?=
 =?utf-8?B?OTZtM1hPeDUxNUp4aitjMWluUTl5NnF4LzNXNHJQYzhnZTNxS3FOczlHOFVT?=
 =?utf-8?B?TXRsU1BpYW5rVldTc3FCWFhlNktFSGR5ZWczemt5OElYMlJRajNiaGJSMmI1?=
 =?utf-8?B?bVNnRlczSlRtemZSa3FpWTlyMXh6Z0VxR3gxU3BCSHl1VC9XTzJnN28yQS9N?=
 =?utf-8?B?TlJJZzBneFlLWnIxT0lPNEtKRW5hSitwREk1TkY2WXNpZzVXWGJReDNjaFpx?=
 =?utf-8?B?NUhJeGVaZ0QvWXhaOC9LMmU3WGdJMEZEN01NTTlIODZrOUtVenZkNXN6SlRO?=
 =?utf-8?B?b0Zvajc1M0hKL0YwTTRPbmxUVzJiYkFUMlU5dTQwckx4OFBwSVdpQmlrM29T?=
 =?utf-8?B?d0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1Y3ZjJVYTlnbHY1ZWhCR0pHem9xWktTc3pQOExZc1BTVjFrcHYvK25RdVUx?=
 =?utf-8?B?NWdWbndTZHJVVDBsUUdKV1haR1BwYXBHVndqUkFHUzVSKzc1LzRQT2VUNDNN?=
 =?utf-8?B?cnExYUJ4aUJVcHQzbTNnYU4rbU01Y3BkdjdHQlN4Q25GTVpkTVI0bEdjbmE2?=
 =?utf-8?B?eTZodDROUjlVR3VOQTFzL1BqT3U5UHlxNG9ZSnBIVEJGeEpnK210aXJ1QmRM?=
 =?utf-8?B?a2MvNmJOMWNRV1ovYVkzbGlGRVZTd3F0R1o0U0hra2tLWlRrZWFRWHNtZjNi?=
 =?utf-8?B?Q1BjRGVtay9vK2hZN0ZwOUJuV2pvcTdqQWxzZVB6S2Q0WUg4ejhzc0VSKzRG?=
 =?utf-8?B?eGxiTlRUam9VR2QxU3JMR3J4M0JJVTA2S3RpMUkyY093bVdlQlEwMFhoeWFz?=
 =?utf-8?B?aExlKzc0RW1LTmsrSzdjZW9xMFBBdEwwZUdpQ3QrdWwweExIUHNCYUN1Y0hW?=
 =?utf-8?B?YlVLY1FOMVZYVU1ObWVydnFXTjZhY0UvQStRbHJDbGo3UlN0eG9pNW5nTXZM?=
 =?utf-8?B?SFJ5K2lRdGRiRzc2cFAzUUhkM2ZxcGgycURKOUZXQmVOYWtGMkdJL2pzODlO?=
 =?utf-8?B?T25qUHNOV3RTWWpaOHNBT1lpeVRTSkRvMXo5d2dhSDV0cjlXWlFRZU9KZ1Vu?=
 =?utf-8?B?ei9UdERDWDlhVm1iUFpHZXp2Ym9xRXhKb0JZR1ExWTA1Z29Zb29YVjRvaE5M?=
 =?utf-8?B?V2hMS1ZzQTJLNndtVzV5dWpBZzJIajA3ek1NZktXR2IwRmVTOFZ6bHJ0VXhD?=
 =?utf-8?B?bW1udDZkWXh1d1YyL3FQZlNQR3c3Wjk4Smh6b0FOUmlPa0JqTmZTOVVsTzg1?=
 =?utf-8?B?TmEvaEVJMVdvc2xKb1l0eVh0NE15bjY0NVhPQzNoT2t4bXRTM1FVc04wTjZG?=
 =?utf-8?B?aDRXUllRRFczMzkwREw4ZUh3R2lwZUpHelAxTjR1NG4xWXAwdThuaGlweVR3?=
 =?utf-8?B?YUxaM090dlVJVGhmM3RNOUJNenY5U1lWTUlxTEN2SVdOaVhqWWhNM3ZnOXp3?=
 =?utf-8?B?M2VJUEczVVlOOUtlSFNDNGFQYWVSWHU2VUpxMllmd0tYeVRsQzhRcW9NNnZy?=
 =?utf-8?B?bGFIbzhTaGg3THB2a29QOHBJaGlRY3FBMGhJcTlWOVkveEtSN1h0NHoyV0hK?=
 =?utf-8?B?S0w2UFpoRERLNDdDdDZ5NVMvVkgveE5zVExISm1od2pPVHB1aXhMeXNoUCtE?=
 =?utf-8?B?R3hRdDdiRkUyZGFmVU5tMkpGZVJGV0oxa1VkVmV1Qnloc0JITnZvMTNsRW1o?=
 =?utf-8?B?ajYvUHZYS2x6Q3ZhWlFoSjJzc1l2bmxBa1N1L2tHOUtURlp0Wko2WjdkNGJ4?=
 =?utf-8?B?eVk5V0Q5YlNtWjE1L0U5Nyt0UkdLMGRaL3ZIRjVLbldYZUd0NFVWcmFWUWZq?=
 =?utf-8?B?dng4Z2hlaE9IS3RRWXhTM25TcGJId1dTNTU5Ukh6dkRxaGxVL0crdzNlT1pj?=
 =?utf-8?B?NmQydkdjOXFRblhTU1lNMGhMcjVIV0E5UmV6ZVpWekM1T2h1M3ZOVTNqK0Rw?=
 =?utf-8?B?N1ZPVjdEaWYyc3NxOWpMV1RJY21XZVBTTXlSNVFOZ0s5MWhtdUZZTExSRnNt?=
 =?utf-8?B?SHRpNE5YR1ZqdG1FNVNHWGVsejBPb1lsREc3OWJ5ZDRwODl4bU5BNFJDL2RI?=
 =?utf-8?B?TXBJajdOWC9Nbm5IVkFuMmFmUG1zeXM0OFV1dkZpUC9FakpjaFpWQTNpYmxs?=
 =?utf-8?B?bFhVRFFuMHlmMXViSTFpQlhkYjRHQ1QyTys4UmpqQVl6NHMvVG5nNkI0WjRV?=
 =?utf-8?B?anpMM21hRUM0NXBmeXpuOG9VOVZYOXV2UFplSWE0azdYRzB4bkxqTHdvNDF2?=
 =?utf-8?B?SW1IR3RnYzRNL0RiTFRRNjNKRFhIOGxKS1hKWFhaME5CcFJvUmI5UmZ3dFlh?=
 =?utf-8?B?dmdsbmtucTRkSjVsMFhWVDBPV2JLQTA0bnFNczErZGdXeW54VTl6clFtZVhn?=
 =?utf-8?B?RCs0Tk1ldTVIR3NDRGp4SWtFY1M0S1p6M0ZJbWgyMHZRTXF0WWhEOFBOMDR6?=
 =?utf-8?B?TVNXWmZJY1NQU0JsdG1jVktyei9SMGt0ZVhMT3V1ZFpFUDRKRFV1SnZZTVBw?=
 =?utf-8?B?TFlscjVYdWdKeVNPVlN6cHJpcVQwbEpPMG1jb2NIbElxeFdYMWxiRjU2T1l1?=
 =?utf-8?B?NWUvaTlseUd5YUdLOW5hSUQ5VGdoN0FpdFJyNXBEeHNhU0dYeS9xSnd6QUpx?=
 =?utf-8?B?Y2hvZnROSEthTmZkL1JsWnlRcEE0Z3NhN09nd1B1OUcyS3JYTGYwZ2x1QXov?=
 =?utf-8?B?VDBYR1ZucFFCc0xyQ1BUY3gybmkzZUlBU3drVFZURkplMkVFOHZwY1FwNUh5?=
 =?utf-8?B?d0hsS0NaWjlzOUVyaTErSDd4MU9SS3MwaG90UHNhR0FnMWxoSjc1MG5pUVNr?=
 =?utf-8?Q?L4krZBBWzZeRXJq++kskFCs6qb6IeEKbo5PKEdSz0C6Yp?=
X-MS-Exchange-AntiSpam-MessageData-1: 5auXecqdUxtImA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7d2700-762d-4f93-ea72-08de58c283a5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 07:55:59.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2PXCqE6UnvgXPKoAfo7mvZDDzq+nMFZQdyYCP0+7JNrZ7f9fQbiRTH0V/zCXIzJVTj68yge1k/LdvKLvmrnmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41216-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nvidia.com,gmail.com,baylibre.com,samsung.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_PROHIBIT(0.00)[4.44.103.184:email,4.44.146.176:email];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 73185531F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add EMC OPP tables and interconnect paths that will be used for
> dynamic memory bandwidth scaling based on memory utilization statistics.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../dts/nvidia/tegra114-peripherals-opp.dtsi  | 151 ++++++++++++++++++
>  arch/arm/boot/dts/nvidia/tegra114.dtsi        |   9 ++
>  2 files changed, 160 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dts=
i
>=20
> diff --git a/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi b/arc=
h/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
> new file mode 100644
> index 000000000000..1a0e68f22039
> --- /dev/null
> +++ b/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	emc_icc_dvfs_opp_table: opp-table-emc {
> +		compatible =3D "operating-points-v2";
> +
> +		opp-12750000-900 {
> +			opp-microvolt =3D <900000 900000 1390000>;
> +			opp-hz =3D /bits/ 64 <12750000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};

What's the source of the opp data?

Cheers,
Mikko

> +
> +		opp-20400000-900 {
> +			opp-microvolt =3D <900000 900000 1390000>;
> +			opp-hz =3D /bits/ 64 <20400000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};
> +
> +		opp-40800000-900 {
> +			opp-microvolt =3D <900000 900000 1390000>;
> +			opp-hz =3D /bits/ 64 <40800000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};
> +
> +		opp-68000000-900 {
> +			opp-microvolt =3D <900000 900000 1390000>;
> +			opp-hz =3D /bits/ 64 <68000000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};
> +
> +		opp-102000000-900 {
> +			opp-microvolt =3D <900000 900000 1390000>;
> +			opp-hz =3D /bits/ 64 <102000000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};
> +
> +		opp-204000000-900 {
> +			opp-microvolt =3D <900000 900000 1390000>;
> +			opp-hz =3D /bits/ 64 <204000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-suspend;
> +		};
> +
> +		opp-312000000-1000 {
> +			opp-microvolt =3D <1000000 1000000 1390000>;
> +			opp-hz =3D /bits/ 64 <312000000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};
> +
> +		opp-408000000-1000 {
> +			opp-microvolt =3D <1000000 1000000 1390000>;
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};
> +
> +		opp-528000000-1050 {
> +			opp-microvolt =3D <1050000 1050000 1390000>;
> +			opp-hz =3D /bits/ 64 <528000000>;
> +			opp-supported-hw =3D <0x000E>;
> +		};
> +
> +		opp-528000000-1100 {
> +			opp-microvolt =3D <1100000 1100000 1390000>;
> +			opp-hz =3D /bits/ 64 <528000000>;
> +			opp-supported-hw =3D <0x0001>;
> +		};
> +
> +		opp-624000000-1100 {
> +			opp-microvolt =3D <1100000 1100000 1390000>;
> +			opp-hz =3D /bits/ 64 <624000000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};
> +
> +		opp-792000000-1100 {
> +			opp-microvolt =3D <1100000 1100000 1390000>;
> +			opp-hz =3D /bits/ 64 <792000000>;
> +			opp-supported-hw =3D <0x000F>;
> +		};
> +	};
> +
> +	emc_bw_dfs_opp_table: opp-table-actmon {
> +		compatible =3D "operating-points-v2";
> +
> +		opp-12750000 {
> +			opp-hz =3D /bits/ 64 <12750000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <204000>;
> +		};
> +
> +		opp-20400000 {
> +			opp-hz =3D /bits/ 64 <20400000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <326400>;
> +		};
> +
> +		opp-40800000 {
> +			opp-hz =3D /bits/ 64 <40800000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <652800>;
> +		};
> +
> +		opp-68000000 {
> +			opp-hz =3D /bits/ 64 <68000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <1088000>;
> +		};
> +
> +		opp-102000000 {
> +			opp-hz =3D /bits/ 64 <102000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <1632000>;
> +		};
> +
> +		opp-204000000 {
> +			opp-hz =3D /bits/ 64 <204000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <3264000>;
> +			opp-suspend;
> +		};
> +
> +		opp-312000000 {
> +			opp-hz =3D /bits/ 64 <312000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <4992000>;
> +		};
> +
> +		opp-408000000 {
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <6528000>;
> +		};
> +
> +		opp-528000000 {
> +			opp-hz =3D /bits/ 64 <528000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <8448000>;
> +		};
> +
> +		opp-624000000 {
> +			opp-hz =3D /bits/ 64 <624000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <9984000>;
> +		};
> +
> +		opp-792000000 {
> +			opp-hz =3D /bits/ 64 <792000000>;
> +			opp-supported-hw =3D <0x000F>;
> +			opp-peak-kBps =3D <12672000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/n=
vidia/tegra114.dtsi
> index a920ad041c14..6221423b81d1 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> @@ -8,6 +8,8 @@
>  #include <dt-bindings/soc/tegra-pmc.h>
>  #include <dt-bindings/thermal/tegra114-soctherm.h>
> =20
> +#include "tegra114-peripherals-opp.dtsi"
> +
>  / {
>  	compatible =3D "nvidia,tegra114";
>  	interrupt-parent =3D <&lic>;
> @@ -323,6 +325,9 @@ actmon: actmon@6000c800 {
>  		clock-names =3D "actmon", "emc";
>  		resets =3D <&tegra_car TEGRA114_CLK_ACTMON>;
>  		reset-names =3D "actmon";
> +		operating-points-v2 =3D <&emc_bw_dfs_opp_table>;
> +		interconnects =3D <&mc TEGRA114_MC_MPCORER &emc>;
> +		interconnect-names =3D "cpu-read";
>  		#cooling-cells =3D <2>;
>  	};
> =20
> @@ -655,6 +660,7 @@ mc: memory-controller@70019000 {
> =20
>  		#reset-cells =3D <1>;
>  		#iommu-cells =3D <1>;
> +		#interconnect-cells =3D <1>;
>  	};
> =20
>  	emc: external-memory-controller@7001b000 {
> @@ -665,6 +671,9 @@ emc: external-memory-controller@7001b000 {
>  		clock-names =3D "emc";
> =20
>  		nvidia,memory-controller =3D <&mc>;
> +		operating-points-v2 =3D <&emc_icc_dvfs_opp_table>;
> +
> +		#interconnect-cells =3D <0>;
>  	};
> =20
>  	hda@70030000 {
>=20





