Return-Path: <linux-pm+bounces-32849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6EB30C0D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 04:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B27A7AB12F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0E7222590;
	Fri, 22 Aug 2025 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QMYBA3zH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F864393DC6;
	Fri, 22 Aug 2025 02:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831197; cv=fail; b=PkV/I0yUd+VlK4rKYSzP3f/+9XIVR+vbDno+f25w7LrsO8U9jftpqubVOuz6zkmWJbT8GaJWUihJ07l8K99+MNPa00XXDpLU9M4oN5nu366JcY8Fla52xjKCW+C9/zPx0tsqCq269Bgn+C6vEXWLe3DDGXJUr/FYv54VhzV/NT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831197; c=relaxed/simple;
	bh=mFrTPFxRyLMAn/DsvSVPvhAFAiRCQqA5+U9pSDGLBRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk6XwBwY30AxoVlz0IjTRC//lxHKtSp+rmm4WYdMDcRiL7COcEr0EzGhss8SIGLJbzLdMK0OQnfp/CzcVMnXTxG625eJ9kBpfHkFq+P19R97jaClKRtHzrQCcyO2+ezis8XY5slXsYxjCj2sVjrkM90go2eV1dtP2ECVN1ElDkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QMYBA3zH; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7obkky8SIO5ZybsD5jBPOstGiTEA5WseO8jYDs0dzF8UP2LcUCdaMxqmkmJokoluk2QY2QnTwPc6jwdRDNeg9cq23dePXdUCk2FQyxfppUUGcNGINWv1dxpNONLaES/RNXKXqaYNv9P61Zwb2wgP/mXN/MpFJ8XWkNfGzlg6uDlGkczKwextEyw3TZr5MWczC8NpUx5B4fBrSWv61J2P+JO4O7FaXBa9mdtat0MOS0tmFXFStFkom5dB1m8pi5zsbbKOlzeEV0JP7UWs7HAkrZCh58Xno6B5fMpgC8wdvyAQbjYhXm7o4ubeoFARJNkPdpgBZccgoUCSCrP7Xyphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9BUKJd+P+0cKxhDDDZqsNrQuRKmc5IDV6fkL56Xwc8=;
 b=NdKh5AInX0aTiSqWf5iJlhPwBxTNjtki4XBoAl9ZX+IARA2RtpjRdSEtp+PVPhJqkxVZjgDOdIklwqhJXV3ZvkEbtcU6rEUe6f1CgTShW50/Hcx+f5scJoc/U4H8NGhIJe1lUupSoWxNJCZAM8EUSe5nmc1uYHnFbzeOsuzjg9TNY2fHP0VNEpd1p3Zk3fTOe0drU5/EWhP8up9DM2WgpnADZS1C9qqyQvIWT7iAPs0tX7Qh8oFtxOxc5pIWkjMUv21NiQVy6WR+faX4pKVzklHKHRpHfmj50NYPKjiyBY4eSoQpUPDYeghqyhK2sdGIUK8DkzDNt/HNxMMPHqRkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9BUKJd+P+0cKxhDDDZqsNrQuRKmc5IDV6fkL56Xwc8=;
 b=QMYBA3zHuuqD/4ET7vVSX4S9Acgj863/d5iHbqMGMO4+NfTA+53Mgf8z6kCdl5v9P6IjP7MxIsXh6HiPEYqphq/3FUSE1xFW0mec0OwL+qr7X8h8tbzKDbpH7k9d2KSCRkdU2YzB40neci9a2rMLVGBcx9R5CEOqxp724bZNc10BB/6Lm+6nyH/CFtDLO1rC2MZ1izzTlzBiM8862AgLH90Lefq1kHvsPYen8yaAczdXKqNhx7gUJlTdDhcYBdqTanXFojbBY3OlYGJQoIG/5gwuVjFqfxRq6+76J5zf22Io6J4/fKLirB91UXz3mp3kKdJJcuw3SdLqGV6/Sdx/5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) by
 SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.16; Fri, 22 Aug 2025 02:53:11 +0000
Received: from DM4PR12MB6496.namprd12.prod.outlook.com
 ([fe80::bede:bc2a:5e14:e393]) by DM4PR12MB6496.namprd12.prod.outlook.com
 ([fe80::bede:bc2a:5e14:e393%7]) with mapi id 15.20.9009.013; Fri, 22 Aug 2025
 02:53:11 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
Date: Fri, 22 Aug 2025 11:53:05 +0900
Message-ID: <2253671.Mh6RI2rZIc@senjougahara>
In-Reply-To: <20250321095556.91425-3-clamor95@gmail.com>
References:
 <20250321095556.91425-1-clamor95@gmail.com>
 <20250321095556.91425-3-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::15) To IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6496:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 143f6e49-2a3a-48ba-7ab6-08dde1270795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlMvOXhtMk0yYk5aMGs2UkVTeGIrbkl6QmV3Z294ZHhYeXJGNXU5ZzR4V0N4?=
 =?utf-8?B?MTNFNDg3cmtla2J1ZmxWWnBoQ2dIKytXczZmU0tWOXB6WU1HMjdTd2UyVXZl?=
 =?utf-8?B?QVNaN1VTOCtIdE9hcDdKK0l6c0FMSVZXU3BqOVFyenpJV3U5bmM0Zmo3dTRX?=
 =?utf-8?B?U3lzcmRHYjA0TTN2S1hURmhEUW84cTdhMWhqYUczNHF2d2poUEY3OVZzL2tn?=
 =?utf-8?B?ajBhVGJvakF4Y1B6aTFkUjRrbFZXamc1S2JQVkFNR3IrNjlsamErdm95aUxQ?=
 =?utf-8?B?TlFQcjJSREU0ajRTdjh4dWVFRmVZelRCazczU0F4SjhvdmJIM2Z6bXc3cnBZ?=
 =?utf-8?B?OE1ZZ094S09NKzU1MVdXaXNHbzVBa2JOZ2ZTT3M1akN4RGV4VFdVNC9PdnAx?=
 =?utf-8?B?MEg4SVhFdXFRbkl5ZEVZZ0J6M1REcmJ2Q3V3clZtVVNyRC9KUFdOcVNKUnYz?=
 =?utf-8?B?RzA1NWN4Zk5kTE5rS2lQTHB3ejMzNTNnbGhQNEF2V1djdUpNdG93dDRJQng3?=
 =?utf-8?B?OWdJK0gwK1BRek9FbnZMblVZaitQbFFhR0cvb294bGlBRTc1dWQ2eGRCcEd0?=
 =?utf-8?B?ZXhIcFI3SWZRbEZnTFRmOFVwN05tN3dlYXVuYWlNTHMyZiszRjVxWHpSeWRR?=
 =?utf-8?B?K0NjM0Yza08ySCtHVitPcjZsd1BkdDBLOVJTRkk3T3orb3ZGckxTaThkemxa?=
 =?utf-8?B?SUZPN3JLdmdxNzYyOHZOcm4vY01JeHhZVzRJQnl2M2Z3NVJkaWxKcmRSVUVo?=
 =?utf-8?B?Y3VrUmYraHMzeTAyeUxicndHZStQVkVQcktMVHZvRExnNVcrTDREMkFrQ3lB?=
 =?utf-8?B?VjdTOXA3VnVnajFjRUh0S2Z1VU9XWi9ndXNGR0RkdW5vTTBlQWJZVEljdFJC?=
 =?utf-8?B?RWhJdXVkenY3YnlrTFhWamVjRi9wNTVoMjM3c3BmdTVPL1VXWVV2SU5DMmlY?=
 =?utf-8?B?SGllajRCdXhPTTlUQVlHblU3amFMbmR1STJLM0JYMWJiMHRpRGRlOXIxTXI4?=
 =?utf-8?B?aStxWldFMFJyb01VSGVibE1TK3grZGdGMUc5OEhEc29XeElsVndyNjV6d2Qy?=
 =?utf-8?B?NDZuYzgvRGYvcm85K1Q1UVdzblpXUTE3TVdBQWlqdTFGcGFwRDg2WkVKbE92?=
 =?utf-8?B?TENmcVJTYWZad3ZKa3NtQktBcHlLMEhSZkJtYjNSSmpCMUlDZG9mRzdHQ0My?=
 =?utf-8?B?RC9jWXR2cGFLVWswQWkxbWw5MWRlbytKK2pRRUxzVmovdTBQN1BuSEMwbjRV?=
 =?utf-8?B?d3EzNHhNb2pGTkpONkNvR2o3Y3hLUGtYb0FtOXZseHhLQzNZa0lJdHZhcVFj?=
 =?utf-8?B?NzJLV0ZuL1hnVFgrQ2U3U1Y5anRKMW8rOEFKZEU5N1dYUnBSWGZhRUZrcGF5?=
 =?utf-8?B?RTBzWDM3ZWVoNFgyM2lqMU1MbjhSb3FFZVkyVmJOZEhiOGpwdlZ4TFhtK01n?=
 =?utf-8?B?ZExzYzdKcm94QStWM3kzRE9lcy9IQVdLRyt2cEV3a2tHQ2JhT0lwd1c3bEll?=
 =?utf-8?B?S09ub0V5SHVVdFVSb3pRYngxbHBBcTlOc3hEZ2JUd2VsYzM4czlmcjNldCtk?=
 =?utf-8?B?ZkdDQzdtcDB0L3NGVG0ybVJ4UjdwT3l0MkJncjA2NjFsaElXQm9La3M5dFhJ?=
 =?utf-8?B?NkszMENtb1oyTURFemhGYVBoOEUvVXVrZllMYUpjUXNHVExTYytpQ1RwM1dM?=
 =?utf-8?B?MWc2L1JuS0FqNXVGUVNRQjdTQVdaVnF5SnU2MTJZYW9BTXQrRllQaEVLNEsy?=
 =?utf-8?B?bk9tNWtQYUp3bHpZT2c1eXhQSkd6OXRVSlcxeUgwTStmWnpMc2o3QkVyWTFI?=
 =?utf-8?B?OGRDVUtCdGVJSHNNQW1XV0JCZ2tId1dVMzBBRjREU2F1dVlZWU40eThscll3?=
 =?utf-8?B?UDZ6V3BMWHpGN1BXMXBkWFExVGlWQ3Jtbjc3QWlNYU1lcTNXWldSUFE4eE4w?=
 =?utf-8?B?U3pka0hhT3dpWGtzcVdJNTNteUJaSnhoMzhpd2xUajdhcEZnemtCeGVHY1BM?=
 =?utf-8?B?d2JVcG9jUzZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlVadWl0cTBRdTdjZnNLUlpKUlZaN0sxak1RakljMW54SllZWXB1UGxlUnBh?=
 =?utf-8?B?TVdFdXhhZFFrb3Fpdmt4RkJXc3U0aDVFRE1pRGpoaGlLVGl2empaSzNyd1c1?=
 =?utf-8?B?QVcyMFJ4N2ExeTBrUXFESWd4QlJxdW1CUVRCeHpaS2J6WTV2OTk0ai9yalEy?=
 =?utf-8?B?REc5NEpDb1paU3p5L01kdDNYTmZTNWZwNEh1U2Ixc3BrQWxwd0Y1VE43dXBP?=
 =?utf-8?B?N3lQQm9LY3pCOXVkN045aEN2Y0V2WXpjencxc1ZEQjN4YlhwY0pSc09SVC9r?=
 =?utf-8?B?ZFVmNVNRMk9xSVBHeHRaTW9icTFPamlUcm5kdTI3YmtCQ2p0SWxBaDMwWEFq?=
 =?utf-8?B?V040ZDJhUjg0UmRWVnZlYnBKWGRVVENRdWFwZ2p3R2FzOWx3YWhmZ3RJaWdh?=
 =?utf-8?B?ZFpNZjZ4TklMVDZPRmVpZXNncDRaYThoQlRZVk50QlJzM0Q5VUpFeStGWjcw?=
 =?utf-8?B?MTVscnhPdnBUNjlBOU9MYmFOUmV2STIvWmZxUWVGdnNmZnF3VjFqNjhNT0Fj?=
 =?utf-8?B?dFlyTENPT1ZmQW1XODU3SlY3bEkvbUdJT3FXRFBGSVBSSHVXTXhYZmhGT0RW?=
 =?utf-8?B?ZEluaE1ZSzFHNm1RT2VIaWhhQnY1ekx0TTJtT0FwMUxLK0tXR2RsQi95QU9K?=
 =?utf-8?B?WHJCUW9YMkJhMkYwOTYxcVNOYkhiK05kTjcyMFpzWi8wWUtBdmNNbEhNck9a?=
 =?utf-8?B?OU9TaGt4eDZic0xWdjZmeXErMzhIdk1zQ1BoSjViOVZuMjdhV1J3VGZRRmc5?=
 =?utf-8?B?S3YyQm5GRU5xY1ZRL2V5TmI4NUlaN2JOOVlSMjF0azczNWE3ZWpObjY0ZTI4?=
 =?utf-8?B?cnlBdm5JK0s5SWl6cDBmZ2I4aC9tMm5CQ092OGxZdU1Ka01sbGJKVzVHQTJ6?=
 =?utf-8?B?WGo1NThvRHJlRng4NXZSVTIyNFZIMlhIOFRBcThFQkd1NHVSeFI5bTNoRzZI?=
 =?utf-8?B?ci93RDVncFVMRkpPSk5TbHpteUdVUHErUEsyaXdIVmQ5anFvR1ZQOEtzTTFV?=
 =?utf-8?B?dEFZUTNtUjR2c1RKdVY2TXhURWxqNWV0QXpuMUF6OFBUQ21nRG5pWlUrQkJK?=
 =?utf-8?B?R200RUZyS2Z3NEJic3VPVkNtdUVjcldrSTNIaGp6R3MyK2FsQytRMitjVHAv?=
 =?utf-8?B?Zng4bFJCWUhFeGxEZk5rck5pUkRrMkthVzU4SThEZWZSUGx3dUNDUDFFNnha?=
 =?utf-8?B?VHU0NkRRVTJYaWtTdzFQdDYvck1xTkd5OW9KOFVYTXNYVmg4dUxCdFFtSFpN?=
 =?utf-8?B?VTBsd1R4bDhhTFVpRnV6U2NaMzE5MkM3Y1dnVkhCd2RrT0dFS3orR1pnNUEv?=
 =?utf-8?B?WVhTWTg5VmNTcmtkYTR2QUlIeXdtWm9PNkNNTGcxdlc2bXR6QkRic3lDQ3kw?=
 =?utf-8?B?MHAyUW5GNVBzUk1NKy85N1hxSEdaMmg0SCtvcUNYTTJ1OW4xMHFNUHdZWnJz?=
 =?utf-8?B?UlhHTnVPckhvQkxTZVVvRHRhaTh1NVorTU9OOGFWNlJ1L3hSNzBVWlVtNkQ1?=
 =?utf-8?B?aUc4RUl3OFc2WFFzWUVVaFB5MVJvcGVmZ1Z6SjNqUE5VVUFnd1l6UWpDNFda?=
 =?utf-8?B?bDRMNGxsY05hMkt5UTNMWmxLLzdOOFp2U1FURGVkeFZjb2hDL29sRTlNdnA1?=
 =?utf-8?B?T1lBUityajA5SXIxWE1qQ2VRbFVkMjNHQWJUaXFvVFliVm8yQkZVdksxempy?=
 =?utf-8?B?NzV0RUZwb0h2MGVMU0Fudmk4Y296MUhNb2xaaW43M0RJclJSOVRxcWtIZGdn?=
 =?utf-8?B?QUFnWUFWOTFrb1pPNEJwUnB2OWltV2lSNjA2TE51azFFWEZibHRGTzBFeWFT?=
 =?utf-8?B?L2RFWWorRkF0Q3g4cEF3aWhxcWd1dUd6OS9MeWh1dEhJSHZ3MFNvV2Vqa3dH?=
 =?utf-8?B?N0RBWUtlMXBrUnJRZlZWWDFRY1JIU0UzSWJwSEVJNVgzdXRYR28rZjM4bUVM?=
 =?utf-8?B?VFBoU0VFTmVVMkxTeExVdzUxcjQ5VW1FSi8ySENTbHhhWVN1bC9iU1FZK2dx?=
 =?utf-8?B?MTZTeTdEc2NWOThNYXdVU3NMTVg3czNHV0VQVTNIdldkQlc4ZFZKYzAzZE15?=
 =?utf-8?B?MW1URm8rUUpHSUUzSUsrU0xLd2ovdXdYRHFPelRKTmJ1SWlrQW9IaCtRMEZl?=
 =?utf-8?B?a1N1and3SzVUbGZmTlVwWWw4V0tFVThyaklmd2JxZUZwUHNOSm5telhFYzBm?=
 =?utf-8?B?eEVGRjVPb243cDdyc0JkVHZuVHZZRU1iSkNDc0g1U0Z5ZlJ3c3lhVHNwWG92?=
 =?utf-8?B?eXFHdGc3MnV1bXpqZ3I2YmlRZXBRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143f6e49-2a3a-48ba-7ab6-08dde1270795
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:53:11.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko4ko/mjr85lMdjmKCYv3id3HUWfQpNjLBbyo5hFzvRBeHhUxvKsEu47NK1/THfLMql0Aesl26UfddZbGjgbig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
> Extend the Tegra124 driver to include DFLL configuration settings require=
d
> for Tegra114 compatibility.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/clk/tegra/Kconfig                  |   2 +-
>  drivers/clk/tegra/clk-tegra114.c           |  30 +++++-
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 104 +++++++++++++++++++++
>  drivers/clk/tegra/clk.h                    |   2 -
>  include/dt-bindings/reset/tegra114-car.h   |  13 +++
>  5 files changed, 144 insertions(+), 7 deletions(-)
>  create mode 100644 include/dt-bindings/reset/tegra114-car.h
>=20
> diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
> index 90df619dc087..62147a069606 100644
> --- a/drivers/clk/tegra/Kconfig
> +++ b/drivers/clk/tegra/Kconfig
> @@ -4,7 +4,7 @@ config CLK_TEGRA_BPMP
>  	depends on TEGRA_BPMP
>=20
>  config TEGRA_CLK_DFLL
> -	depends on ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
> +	depends on ARCH_TEGRA_114_SOC || ARCH_TEGRA_124_SOC ||=20
ARCH_TEGRA_210_SOC
>  	select PM_OPP
>  	def_bool y
>=20
> diff --git a/drivers/clk/tegra/clk-tegra114.c
> b/drivers/clk/tegra/clk-tegra114.c index b19dd4e6e17c..9b6794b951a2 10064=
4
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/clk/tegra.h>
>  #include <dt-bindings/clock/tegra114-car.h>
> +#include <dt-bindings/reset/tegra114-car.h>
>=20
>  #include "clk.h"
>  #include "clk-id.h"
> @@ -1260,7 +1261,7 @@ EXPORT_SYMBOL(tegra114_clock_tune_cpu_trimmers_init=
);
>   *
>   * Assert the reset line of the DFLL's DVCO.  No return value.
>   */
> -void tegra114_clock_assert_dfll_dvco_reset(void)
> +static void tegra114_clock_assert_dfll_dvco_reset(void)
>  {
>  	u32 v;
>=20
> @@ -1269,7 +1270,6 @@ void tegra114_clock_assert_dfll_dvco_reset(void)
>  	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
>  	tegra114_car_barrier();
>  }
> -EXPORT_SYMBOL(tegra114_clock_assert_dfll_dvco_reset);
>=20
>  /**
>   * tegra114_clock_deassert_dfll_dvco_reset - deassert the DFLL's DVCO re=
set
> @@ -1277,7 +1277,7 @@ EXPORT_SYMBOL(tegra114_clock_assert_dfll_dvco_reset=
);
> * Deassert the reset line of the DFLL's DVCO, allowing the DVCO to *
> operate.  No return value.
>   */
> -void tegra114_clock_deassert_dfll_dvco_reset(void)
> +static void tegra114_clock_deassert_dfll_dvco_reset(void)
>  {
>  	u32 v;
>=20
> @@ -1286,7 +1286,26 @@ void tegra114_clock_deassert_dfll_dvco_reset(void)
>  	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
>  	tegra114_car_barrier();
>  }
> -EXPORT_SYMBOL(tegra114_clock_deassert_dfll_dvco_reset);
> +
> +static int tegra114_reset_assert(unsigned long id)
> +{
> +	if (id =3D=3D TEGRA114_RST_DFLL_DVCO)
> +		tegra114_clock_assert_dfll_dvco_reset();
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int tegra114_reset_deassert(unsigned long id)
> +{
> +	if (id =3D=3D TEGRA114_RST_DFLL_DVCO)
> +		tegra114_clock_deassert_dfll_dvco_reset();
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
>=20
>  #ifdef CONFIG_TEGRA124_CLK_EMC
>  static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args
> *clkspec, @@ -1357,6 +1376,9 @@ static void __init
> tegra114_clock_init(struct device_node *np)
> tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
>  					&pll_x_params);
>=20
> +	tegra_init_special_resets(1, tegra114_reset_assert,
> +				  tegra114_reset_deassert);
> +
>  #ifdef CONFIG_TEGRA124_CLK_EMC
>  	tegra_add_of_provider(np, tegra114_clk_src_onecell_get);
>  	clks[TEGRA114_CLK_EMC] =3D tegra124_clk_register_emc(clk_base, np,

Could you split this up into separate patches for the reset portion and the=
=20
DFLL portion.

> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c index
> 0251618b82c8..7a43380ce519 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -28,6 +28,99 @@ struct dfll_fcpu_data {
>  	unsigned int cpu_cvb_tables_size;
>  };
>=20
> +/* Maximum CPU frequency, indexed by CPU speedo id */
> +static const unsigned long tegra114_cpu_max_freq_table[] =3D {
> +	[0] =3D 2040000000UL,
> +	[1] =3D 1810500000UL,
> +	[2] =3D 1912500000UL,
> +	[3] =3D 1810500000UL,
> +};
> +
> +#define T114_CPU_CVB_TABLE \
> +	.min_millivolts =3D 1000, \
> +	.max_millivolts =3D 1320, \
> +	.speedo_scale =3D 100,    \
> +	.voltage_scale =3D 1000,  \
> +	.entries =3D {            \
> +		{  306000000UL, { 2190643, -141851, 3576 } }, \
> +		{  408000000UL, { 2250968, -144331, 3576 } }, \
> +		{  510000000UL, { 2313333, -146811, 3576 } }, \
> +		{  612000000UL, { 2377738, -149291, 3576 } }, \
> +		{  714000000UL, { 2444183, -151771, 3576 } }, \
> +		{  816000000UL, { 2512669, -154251, 3576 } }, \
> +		{  918000000UL, { 2583194, -156731, 3576 } }, \
> +		{ 1020000000UL, { 2655759, -159211, 3576 } }, \
> +		{ 1122000000UL, { 2730365, -161691, 3576 } }, \
> +		{ 1224000000UL, { 2807010, -164171, 3576 } }, \
> +		{ 1326000000UL, { 2885696, -166651, 3576 } }, \
> +		{ 1428000000UL, { 2966422, -169131, 3576 } }, \
> +		{ 1530000000UL, { 3049183, -171601, 3576 } }, \
> +		{ 1606500000UL, { 3112179, -173451, 3576 } }, \
> +		{ 1708500000UL, { 3198504, -175931, 3576 } }, \
> +		{ 1810500000UL, { 3304747, -179126, 3576 } }, \
> +		{ 1912500000UL, { 3395401, -181606, 3576 } }, \
> +		{          0UL, {       0,       0,    0 } }, \
> +	}, \
> +	.cpu_dfll_data =3D {      \
> +		.tune0_low =3D 0x00b0039d,          \
> +		.tune0_high =3D 0x00b0009d,         \
> +		.tune1 =3D 0x0000001f,              \
> +		.tune_high_min_millivolts =3D 1050, \
> +	}
> +

Looks good -- could you add a T210_ prefix into the existing CVB table macr=
o=20
names to avoid any confusion later.

> +static const struct cvb_table tegra114_cpu_cvb_tables[] =3D {
> +	{
> +		.speedo_id =3D 0,
> +		.process_id =3D -1,
> +		.min_millivolts =3D 1000,
> +		.max_millivolts =3D 1250,
> +		.speedo_scale =3D 100,
> +		.voltage_scale =3D 100,
> +		.entries =3D {
> +			{  306000000UL, { 107330, -1569,   0 } },
> +			{  408000000UL, { 111250, -1666,   0 } },
> +			{  510000000UL, { 110000, -1460,   0 } },
> +			{  612000000UL, { 117290, -1745,   0 } },
> +			{  714000000UL, { 122700, -1910,   0 } },
> +			{  816000000UL, { 125620, -1945,   0 } },
> +			{  918000000UL, { 130560, -2076,   0 } },
> +			{ 1020000000UL, { 137280, -2303,   0 } },
> +			{ 1122000000UL, { 146440, -2660,   0 } },
> +			{ 1224000000UL, { 152190, -2825,   0 } },
> +			{ 1326000000UL, { 157520, -2953,   0 } },
> +			{ 1428000000UL, { 166100, -3261,   0 } },
> +			{ 1530000000UL, { 176410, -3647,   0 } },
> +			{ 1632000000UL, { 189620, -4186,   0 } },
> +			{ 1734000000UL, { 203190, -4725,   0 } },
> +			{ 1836000000UL, { 222670, -5573,   0 } },
> +			{ 1938000000UL, { 256210, -7165,   0 } },
> +			{ 2040000000UL, { 250050, -6544,   0 } },
> +			{          0UL, {      0,     0,   0 } },
> +		},
> +		.cpu_dfll_data =3D {
> +			.tune0_low =3D 0x00b0019d,
> +			.tune0_high =3D 0x00b0019d,
> +			.tune1 =3D 0x0000001f,
> +			.tune_high_min_millivolts =3D 1000,
> +		}
> +	},
> +	{
> +		.speedo_id =3D 1,
> +		.process_id =3D -1,
> +		T114_CPU_CVB_TABLE
> +	},
> +	{
> +		.speedo_id =3D 2,
> +		.process_id =3D -1,
> +		T114_CPU_CVB_TABLE
> +	},
> +	{
> +		.speedo_id =3D 3,
> +		.process_id =3D -1,
> +		T114_CPU_CVB_TABLE
> +	},
> +};
> +
>  /* Maximum CPU frequency, indexed by CPU speedo id */
>  static const unsigned long tegra124_cpu_max_freq_table[] =3D {
>  	[0] =3D 2014500000UL,
> @@ -494,6 +587,13 @@ static struct cvb_table tegra210_cpu_cvb_tables[] =
=3D {
>  	},
>  };
>=20
> +static const struct dfll_fcpu_data tegra114_dfll_fcpu_data =3D {
> +	.cpu_max_freq_table =3D tegra114_cpu_max_freq_table,
> +	.cpu_max_freq_table_size =3D ARRAY_SIZE(tegra114_cpu_max_freq_table),
> +	.cpu_cvb_tables =3D tegra114_cpu_cvb_tables,
> +	.cpu_cvb_tables_size =3D ARRAY_SIZE(tegra114_cpu_cvb_tables)
> +};
> +
>  static const struct dfll_fcpu_data tegra124_dfll_fcpu_data =3D {
>  	.cpu_max_freq_table =3D tegra124_cpu_max_freq_table,
>  	.cpu_max_freq_table_size =3D ARRAY_SIZE(tegra124_cpu_max_freq_table),
> @@ -509,6 +609,10 @@ static const struct dfll_fcpu_data
> tegra210_dfll_fcpu_data =3D { };
>=20
>  static const struct of_device_id tegra124_dfll_fcpu_of_match[] =3D {
> +	{
> +		.compatible =3D "nvidia,tegra114-dfll",
> +		.data =3D &tegra114_dfll_fcpu_data,
> +	},
>  	{
>  		.compatible =3D "nvidia,tegra124-dfll",
>  		.data =3D &tegra124_dfll_fcpu_data,
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index 5d80d8b79b8e..58e860b18e5e 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -898,8 +898,6 @@ static inline bool
> tegra124_clk_emc_driver_available(struct clk_hw *emc_hw) void
> tegra114_clock_tune_cpu_trimmers_high(void);
>  void tegra114_clock_tune_cpu_trimmers_low(void);
>  void tegra114_clock_tune_cpu_trimmers_init(void);
> -void tegra114_clock_assert_dfll_dvco_reset(void);
> -void tegra114_clock_deassert_dfll_dvco_reset(void);
>=20
>  typedef void (*tegra_clk_apply_init_table_func)(void);
>  extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
> diff --git a/include/dt-bindings/reset/tegra114-car.h
> b/include/dt-bindings/reset/tegra114-car.h new file mode 100644
> index 000000000000..d7908d810ddf
> --- /dev/null
> +++ b/include/dt-bindings/reset/tegra114-car.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * This header provides Tegra114-specific constants for binding
> + * nvidia,tegra114-car.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
> +#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
> +
> +#define TEGRA114_RESET(x)		(5 * 32 + (x))
> +#define TEGRA114_RST_DFLL_DVCO		TEGRA114_RESET(0)
> +
> +#endif	/* _DT_BINDINGS_RESET_TEGRA114_CAR_H */

Bindings look fine to me, they follow existing pattern used on other chips =
for=20
DFLL. Perhaps add a note to the commit message along the lines of 'Binding=
=20
values for special resets are placed starting from software-defined index 1=
60=20
in line with other chips.', for extra clarity.

Thanks,
Mikko



