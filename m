Return-Path: <linux-pm+bounces-38794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF33C8E0C5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A95A834F097
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EE632AACC;
	Thu, 27 Nov 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Yc8D2y15"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012015.outbound.protection.outlook.com [52.101.126.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6A325735;
	Thu, 27 Nov 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242980; cv=fail; b=NMpgbv3ta1a7hLjrnSTKfPKfkdl9AD3UAs0ckqzXjawX8xOl7Cx16P8zVVo6RGrj6C7Kso4TGiVlPbLwozgi+VZU/YL3mj7Zsd6w+z3ya2IAJ2bLAAfdXuJiK/C7suqQSO/mNipSxgqP0brVggZRhK1EwXpM99b4vvO+Exw2XWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242980; c=relaxed/simple;
	bh=RJZH1B6/1q0Yv+871qsBLGGnKcvW/5THGden5BgtnBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZjZzzXW76NELCq4touoX4H9aL80KSD3X7Fhnul1isamhqvAJVcGX1+nQUQouwGnj7WdYV6U2FM7LyjAFIjWM3xa/SkGfUKsy9OTF8Ux5wEtLzyO9qcUKRf1q7gl8OdPpMi+9+R4XTrBb2HYwR4HR0JSyFgSD+dDaELbnBBsvl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Yc8D2y15; arc=fail smtp.client-ip=52.101.126.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSxTzqjvgYlchOmxTmtsxIHkXa2G3VJcta9anzTtnSpUbePJUFOxd9Y24uMkB9z74Sc6ZOMFOGddqW8UxPkimYZ49sWmJz9tHLShHwAq1xrDiGsAhCU8IqiFEdIGeggKirbfABtAknSx2Z+VvDehLf4+G5NDTASLSZRf+prB2g0vc1pIqaniBQu/tF2BerLaYQGpriXwwhG2/j+9Z3PYn6+V8NvRSiCtebyv4C4DpzuIUh9tyKwGKZnIyzejN5fd9w3dhwI4Apli/TPw79OVK9Qw4sxQbYLrwH+CZozJWEPQEbF+9/t3lPMpROOZV3BSWLUFwZbrlrAyXGt7K9E+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWTiNR8EsTUumRlsu/gyYxv+RFLSNq4wAdg5IuGlreM=;
 b=lHOyjmHkqLiW3M1c6BcEE2g/R5r8sGAi6sz6ZKb2OKbvEvfdspV8rVjulXXgm038vgraHJ17T4WAxZgGOqNGk8jw234vOO9ZsVNg5NDCSI0/5/ZZTalXbtTLp1+S6MyyEhMLcyYZ6JuJ8R0qH8kOvbavBCsLbOeaHr94tx4xD26rl72P8JqT9Ztn3PJwjP8dYJXZFxw/YvYSrey6a/ewncd2T7Sij5A2vdNyqr0BELtydfIJZgSJKb2dgtk8U5jnVqAexMUK4Tq6jKP3KCW8j5uRT74B86Sp4tV+Mom26Mww9/egiVOqdhREfZ3l9ZPhIcAky9/aSuezLDnolGZLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWTiNR8EsTUumRlsu/gyYxv+RFLSNq4wAdg5IuGlreM=;
 b=Yc8D2y15Vqg9MM6uiC0PklGXLB7QscyHi43UwsAQ63HSxiuY9TAmqvYU7gZ/ewFMOfHCN5j5psI/CyrSmWenSHhBSB0PEVorcdBIoHdpY+heAFnnkFH0wdaOVGux05codoh0xosmTSIAs4wCwrVF5lC9/FokPV83k1In0UB6Uz41o3lNsye6GXTCTst/6hG8VnuKT2ruS01Q2ppbKYTDiq331zg76rJ9IedAP+urOm5UeE5xQF1BJauycs35P86HjnqmMHtB9Kh0fYPjnshUVAJp1oNgETHP07fyevzeflaaS/TfRwPhsdV6nKx2wMlxGXERnLp937XKMEIaj5P1ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB4998.apcprd06.prod.outlook.com (2603:1096:101:4b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Thu, 27 Nov
 2025 11:29:35 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 11:29:35 +0000
Message-ID: <4f4dea0a-21b1-438c-94ae-9a785ad42569@vivo.com>
Date: Thu, 27 Nov 2025 19:29:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
 <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com>
 <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
 <9b6e7d55-6a1f-490e-98c7-3c04f85f7444@acm.org>
 <CAJZ5v0hJw0WdHpqgUc5bz5qCSUNNKHg7i5-sNYeZcDYwRj21qw@mail.gmail.com>
 <6df79ec0-f5b3-4d75-95b1-03e488d45e7f@acm.org>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <6df79ec0-f5b3-4d75-95b1-03e488d45e7f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: fd161e03-f508-4cc4-b6d3-08de2da83ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1FPNkJ1SnV6ck1PV3R1MHZFMjJON3I3WklmYzAwZjRONGhJbU40ZlVHT1or?=
 =?utf-8?B?V2xRUmNoeVhWSitpOGtXcnVQOG1KM2ZYcXlpdDc2Q2txalVaVzFrcGREL1ha?=
 =?utf-8?B?WXdZQmpFdk1pQ2dLZVp4R3d4cGx3N2htczZsbXBudGN3bHF3VXVjMTJuMWxT?=
 =?utf-8?B?bThzOTBvOWJBT2dteTQwQTVCUWFiMytqWG1hUGVFZjdadVJwdE4xNDBpdmNK?=
 =?utf-8?B?RFAySUs3U2pTdmh2djVKUFl6RFdNWG1wUlRINkhoZmdsVVQ5SkdhckZVeENK?=
 =?utf-8?B?Mkp6K1g3V3JBZWpDd2xRV2wrRC9UVjVzZ3BxZHo1dDI5M3IrcmIyWFRTVkI2?=
 =?utf-8?B?UlMrOFQ4NVp3RVZVOTBaaTl1M3ltdnFpZGl5bk1jRGJBY2s3Q3o3dWtpY1Bt?=
 =?utf-8?B?c1lpSUdqb3UwYnNyRWhxdHJuWTZ4dkh2RDl0eUt3d1NYSFZyL0VpTi84dm83?=
 =?utf-8?B?YmlwYnEzb2xqV3E0cTZLanRwNDJIeUNSQWN2RjZiS1JVdWZycVFnYW41c2Vl?=
 =?utf-8?B?dS9LdGEzRk1obk93aHNGTEpKN0I3RzhYZENDUmNjMmpJOSs5Kzc0K3NDcmJw?=
 =?utf-8?B?Zm9oeWZ5dFB0eE9JOFNDbk9vbmJtM0xRM3FSM0RkNS9QZldOcmRPU1d4OVpy?=
 =?utf-8?B?OGV4QlVyR2Z2QkJXT0M0cHgwTVhhai9vVy8rOVFkbytPVlVxWmN6VVd4VlhJ?=
 =?utf-8?B?cW95QUo1dVllVithZjdrYTd2UkRwWEIwNHFHMVVWQlJ4c2FMc1hNbWk0ellS?=
 =?utf-8?B?QkRDbG5UOHp2dnRYUU1LTXI2YktEc0o0OVhLdmxhWGJlNlRaUFROTzhLN3FH?=
 =?utf-8?B?cmZxSVJ1OXJyNDVrSnFXY1BwNldia1NFcHJtcTRBSzI2YVZHUnEvUGJSNFI0?=
 =?utf-8?B?bkpXanFvQjhwMjhOd0ZWVkVxQTRaeXNTb3hqdmVHb0dQNW01dWpVdTNiYmx5?=
 =?utf-8?B?M3FaRjc3cVdFeFpra0NYb3NTeVIybGtDQ0VFN082YnZLVi9JRlBLTVhudXhr?=
 =?utf-8?B?MVhrOXhWQUdpZ0gwTVhOMkRsQjF6dC9XUk0raXI0L0QxZEcxdkEraVJDUlJI?=
 =?utf-8?B?dm4rNGJqbTc2cUR5WWFnR0Y5QmI3anJIMERQbXg1K0ZMRnA2NENwZHpod01J?=
 =?utf-8?B?aEJrb3BwaTRGbk5NNzBTT0ExYmVXTE1VTW9LYnk1bHY4ajhxRWo5WXI5Unlz?=
 =?utf-8?B?QlJtVk51VGNBOHlwdlV2ZGpScWhqSjNLVjFqaVZ0N3p4aHJlTDdQQUN6eVYx?=
 =?utf-8?B?SThuZVpGeWdGd1NGdjFhKzMwS3hPSVloUGlVVEpzY3Y1TVQwTnIwOTlmaEM5?=
 =?utf-8?B?TlpnMHI3MWlUR2kwMHpQM21mQjRnMElqZXpWNFZBVVpJSmI2K05SMEJrN0xn?=
 =?utf-8?B?R0h5K2NkT2NGUXpwRkFtN2ZXUnpwUVFXajR0MlM4MzkzU1RqYlNteGJNMWxS?=
 =?utf-8?B?M2JXN3VVSWw3WHRTS2dLdFFreGVxTjBGMDZpdUtmTnJpVE01ZXNJVDYwaUhI?=
 =?utf-8?B?NEhFL0ppalBhMW1Eczc0Z0hzMXBiUE9ZaU5oSUEzMnUxM210V1cwZngwakVF?=
 =?utf-8?B?T3g5WDQ4QXpBZ0VyRFpueXJ0OEYwNkZHZWxJWjZWOGE3UmJKSXgxRUJ5dGVE?=
 =?utf-8?B?UjIrZVhPeGRJdUMzNTBRQ0VmLzZKOTFCQzRVMkhWcnFmOS92YmJsSjJPNXhL?=
 =?utf-8?B?T0pkUHVOUUtlWGo0UXV1alVNT1pVbDRXVlYrMUFKQ0dpZ1JzOGtRU1F3MGdq?=
 =?utf-8?B?QmdTdkZYQnNEcEtRT2MyN2NVc3Y0NDJINnBXWFd3eEtvT2FTL0FSdERjWWpo?=
 =?utf-8?B?bldUYTRkOStIMmYyM2xmVitYMUplaGZHYXpFRHQ3VG90RDFkVXdFVVM4Q2Qv?=
 =?utf-8?B?VGpMNzlJSTUyUDJLZHU4bk5WdHoxUytrVm92RmNOOWpiV2ovVnkyQ1VxZ2Nt?=
 =?utf-8?Q?Qzoape/07fSgpVjTaYrn7Sxj+rUv1SCr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0R4dGlpM2ZiVExOZHQ2ZDZTK2N0NGwvZDAzd2xGRmlFZVZvQlhxV0VocDZx?=
 =?utf-8?B?c3FSbERlUEVNMXFicGppQVVXc0xvbmVGbTZWUTB5OFpyUjlVSlJjaEZmVzRw?=
 =?utf-8?B?Qjk4Z0E1cVJyVTZJWHF1QWYxdUxReXhWRERBa2hwOG1sM3dUZmFOWXpCTE1V?=
 =?utf-8?B?T3R2VmZwQWNMaHZtVmxIQ041NGttcVVrQ3prZ2pTTzNQUFdLSG5Qajc4VGps?=
 =?utf-8?B?cGJvemxicGJ1V3FTUjVUY0xXVEFMemROZGlNNFdEdGg1cFQvRDh5N1ZoRXN6?=
 =?utf-8?B?V05DZmZHam9lZ1pVMXBOazBWc29RU3JiS1ZXeHkvdFA3eUdZVFBwTUMxUE9z?=
 =?utf-8?B?aVcxZzV3SFBWZlo5K2V2cmFHbDJ6cDVpaFRJU0tGRUM0bklNMXhVTHVXMEQx?=
 =?utf-8?B?MnFWNE1WMytzS3I5MjhGMStRbm5GZ0ZrbWk5SEhWS0s2RmdBdkYwNDFmQVhp?=
 =?utf-8?B?Zm54bUpFQzFSR0NZcW5IbVJyYklQNkFzTVZ5SG55NEFqRGJITHpralp3bWEw?=
 =?utf-8?B?M1liR1F4QWUwM2xYOFlBOU1MajNwWTFPVUpyWEwvZDdmTnZtZGU5L25YdGNH?=
 =?utf-8?B?eW1SR1JxRHcxUFJnUWVMbTJqNEk4d09pc3JWQjB5dk5oVU5oTTVFT3NvZWhp?=
 =?utf-8?B?N1h1VzZSeXlSYW1VSDgvTk0zdFlERjYrK05mRFZjYnBnSFAvZEJ4MVE1NWd4?=
 =?utf-8?B?OTVmU0tMaGNveG9hYzhnMEpyMG9oTEN3L2dJdXlYOU5KK0tuUDFzdERoNis3?=
 =?utf-8?B?RGNNN2ZFVEQvd05SdmZaU2xyYzZUSUFlYU5USzMzTWhUMVRIbTV0UkU3c1Va?=
 =?utf-8?B?R1lBeXA3emxVT2J2b2ZkVTdrVitxMzZVd1dCbnVrVUs0c0N3Z2g0RDFCQk1F?=
 =?utf-8?B?bEZPWU9VUnM3MXNZNnFQc2J5YkdDNXp1ZTJuQm53UmI3Tm1CT3lLak5UcHFs?=
 =?utf-8?B?WHFPc1h5cG5COUN5am4rSWdqVlB2TzVpQi9lUit4eE1TUWY5c2lreHpOU0Jq?=
 =?utf-8?B?OXdpODd3MlZlbW8xbUxyYUM0WWIvenNPaGhvNE1tYTNpejlmS1dNNWVMbHJu?=
 =?utf-8?B?MWI1bHVYdkRGRHNCQi9ZTXJmcTl6VjVBZVgrbWJmK0VDRmlWY3BCeVBMQjEx?=
 =?utf-8?B?WGF0UGtFc1lwSGNURmQ4cmJmc1FvM2R0ekFtMFVzcnRGRWNneXU5Q241TUJV?=
 =?utf-8?B?NHh0dEphU2FKQ1gyMVhjZEZNZmEzTHFVWWx6VWRlOThLc2wwb051RlNkSVZY?=
 =?utf-8?B?dEl0N0dGVHZuWXIyK3k0Y01xYVdPQjhQMk5QVEMwV3ZkVU5tcHp6N3VzTHlm?=
 =?utf-8?B?clRCeWsrZlVqbVhkUE9EYm5vRHBQQlE0b0lwSjNod0hlbzU0cUVwcjI1ZEhn?=
 =?utf-8?B?WHBOT2RhRDJSRHlEKzdnSG5JVFlWdWJlNWgrTGIvbksvUVFKcVdyM3hNTWlI?=
 =?utf-8?B?TVNETVo0R1VCWC9oaTRTNDFucUs2RnV4V1plVVhjZ0Z1cDZJdnMzTzBKZTgv?=
 =?utf-8?B?a0RmSW81WWNZSHpxKzZyYm10Z3ZHYmc3QlF6Nm9VMk5Ha25neXNCZ0kxV0F4?=
 =?utf-8?B?VVU4azZ6UWpzL3E5Q3dqb1RMRmZiRzZzSXFtdjVva2FBR3U1N3Q0VnF0WmVP?=
 =?utf-8?B?blF5N2U1TWluN2NtQm1GZ2pVd0tXMU9ibEJNRzlmeEdnRlgwRDR1R3VHODNo?=
 =?utf-8?B?ZzBWbnJGWWZqOExJVWhVcWtITlU1aVJURkVyc0xJT1dpZHBkdDZlQlR2VjhP?=
 =?utf-8?B?OTlmV2trK2ZXMVU2R3ZqanpldFlQVlB5ckY3a01CaE01YXVjTGRWTzJMYkhu?=
 =?utf-8?B?c2kxUVc1YkJNYmJ1MDFPV0hIUkswNmpsdDBPTHQ1Z3hEbFVTUVFCTW1qZGg4?=
 =?utf-8?B?UmUrZWZUOGpLMElmR3NMSnJTbVFPNXdSd291SlVjc2VQeTZ3R0I4NExEdnpW?=
 =?utf-8?B?SWxidG1EVGtBdTQvRU9zaW1jWUhTdGtEQkU3c3M1SzlGUFI3MGNuUWpMaFp2?=
 =?utf-8?B?QU5mZVVIYS9RRENDcU1ZUlFTY0ZKRUFiUytvVzFBbi95OHhFcWhvMnljWFVI?=
 =?utf-8?B?MWV3T1JBZTZDdkhjUHJHUlVoc3RtY0ZhdFdldkROd1lxbzdVUWZLU2M5Um5n?=
 =?utf-8?Q?QgkCPK+44GGyg+oDb6Iiyv4lB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd161e03-f508-4cc4-b6d3-08de2da83ddc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 11:29:35.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M28tGNXGKUkpw+4tW36tRty/m3Snmtc5b0YuiReo9mfBBw/AVwYl/2PZMjYH8BoqGbwCYHsJF3HAic2KIl2Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB4998

On 2025/11/27 2:40, Bart Van Assche wrote:
> On 11/26/25 7:41 AM, Rafael J. Wysocki wrote:
>> As it stands, you have a basic problem with respect to system
>> suspend/hibernation.  As I said before, the PM workqueue is frozen
>> during system suspend/hibernation transitions, so waiting for an async
>> resume request to complete then is pointless.
> 
> Agreed. I noticed that any attempt to call request_firmware() from
> driver system resume callback functions causes a deadlock if these
> calls happen before the block device has been resumed.
> 
> Thanks,
> 
> Bart.

Does this patch look reasonable to you? It hasn't been fully tested 
yet, but the resume is now performed synchronously.

diff --git a/block/blk-core.c b/block/blk-core.c
index 66fb2071d..041d29ba4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -323,12 +323,15 @@ int blk_queue_enter(struct request_queue *q, 
blk_mq_req_flags_t flags)
                  * reordered.
                  */
                 smp_rmb();
-               wait_event(q->mq_freeze_wq,
-                          (!q->mq_freeze_depth &&
-                           blk_pm_resume_queue(pm, q)) ||
-                          blk_queue_dying(q));
+check:
+               wait_event(q->mq_freeze_wq, !q->mq_freeze_depth);
+
                 if (blk_queue_dying(q))
                         return -ENODEV;
+               if (!blk_pm_resume_queue(pm, q)) {
+                       pm_runtime_resume(q->dev);
+                       goto check;
+               }
         }

         rwsem_acquire_read(&q->q_lockdep_map, 0, 0, _RET_IP_);
@@ -356,12 +359,15 @@ int __bio_queue_enter(struct request_queue *q, 
struct bio *bio)
                  * reordered.
                  */
                 smp_rmb();
-               wait_event(q->mq_freeze_wq,
-                          (!q->mq_freeze_depth &&
-                           blk_pm_resume_queue(false, q)) ||
-                          test_bit(GD_DEAD, &disk->state));
+check:
+               wait_event(q->mq_freeze_wq, !q->mq_freeze_depth);
+
                 if (test_bit(GD_DEAD, &disk->state))
                         goto dead;
+               if (!blk_pm_resume_queue(false, q)) {
+                       pm_runtime_resume(q->dev);
+                       goto check;
+               }
         }

         rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
diff --git a/block/blk-pm.h b/block/blk-pm.h
index 8a5a0d4b3..c28fad105 100644
--- a/block/blk-pm.h
+++ b/block/blk-pm.h
@@ -12,7 +12,6 @@ static inline int blk_pm_resume_queue(const bool pm, 
struct request_queue *q)
                 return 1;       /* Nothing to do */
         if (pm && q->rpm_status != RPM_SUSPENDED)
                 return 1;       /* Request allowed */
-       pm_request_resume(q->dev);
         return 0;
  }


