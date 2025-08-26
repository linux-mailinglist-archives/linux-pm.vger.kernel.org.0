Return-Path: <linux-pm+bounces-33059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D98CB35118
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 03:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C464205F21
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 01:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631DE1F131A;
	Tue, 26 Aug 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i/ONjgo/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9918C332;
	Tue, 26 Aug 2025 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172610; cv=fail; b=bKkWjH56YB+5Kag0vkkhYtZ9NlfSr6VKbek6NCkXhUFDdCwyoWUZ3oWHcPO+wYwVpTTm+ZZCuB9SjkXVGy+vEErX+HVRhpYoilQEq/YLbb/O2GSo+Vu2gm+9U0fwKapQMcGYAPzcI8dPhXCyKozJ/33rN1Q/clIGjPhHJ+KdTfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172610; c=relaxed/simple;
	bh=h41pP+uuG/BuOo7N9cZO1zDVjp9cINMat1tFWqIHLms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQN3lgvG+coqutO833zmiErJxjpAnmzMfrO9sGi2lGaLOCzUtPaKj0xge74GyjYZsK9d2uFrSRMQ1ZeN2qNzZaf+KK1T4YCJIva3oA9LEWYCQtLpNY43iRWRyrHYjuR5lSZ4CJ06vgxyJL9NXYMuom28yN4UkOVfnLOpBoRdyQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i/ONjgo/; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4/xEcxEExzG3/EgAUcbSTsw+k6MSudlQfRQ4rUfSOYpaYKe0esvQxKXScMFxcbRQOUg+pAr+v9B798hS9lSovBEy4MWAAYtwGgec1JMPIy+S8HY7JSAhVXKlWUYoDtCa6L4GcE5VcKzC/fTV0sTSHsz9A4GcX0ivFmtEs2bGYSiNxipwpONGWS93WT+vxfq8M3qHYVG8I+hYwxWkTwK8auLAT5AbdfS+7ABXpFRLNw5/pJTxqeYUMWv6t2+3zPbINh6AiEUsNDfMYVWEanG+Vh8HLMLOiuDeGUSKIKWZDjxfu2QKUWIsMwEYIf94B+s1GB/t0R2uCBldvzFzyr9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vE4toHaZHYUuO8QVbNRaJ6bJVBh7fAJymeHVog4+1w=;
 b=F9DeDGJCwauBGKfHr5MyurLFYaZDQtcHPl9BVvo1Xz2Sq4wOPAPmCn+OWPrMDyP8WkLwkSt+ETcTiEI+QKFddzi9NQt6k3wB6r7AQ8HhxGddH72PS0X52FMAqB9xyDRpsnUpN4JEhHybNASTdTRUJAKOhvw2kVLxGkl6mR4alqNNlGisKE/d6I12neloia70Ec2c+F9dFteqlQmX02pdcXAvc124TrA4IIJgibE6UJf2ipNTdFHPtGbRQF7SoAyd9TFHw7a45DLuEU7SwjOe4zwiqJoKZa90B/GRKJ3rG/QcJ5+8++OhykPTYUExDuBwkbVa81Mdx8MUqxb9B2pb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vE4toHaZHYUuO8QVbNRaJ6bJVBh7fAJymeHVog4+1w=;
 b=i/ONjgo/9cCU17ohj1tfqL9d6tVuYCMGXgLqNics/aVxxaHPcBKU9HKIk6CbzDOBTJBACOsDXvvmoOvfuPHsa3rjqMneCfN4WKszfNHcZ9joiSelC5XBQOPzR6SE4PGV5VuHJq1dMK2K2P1vP325/aYa+9bw6oInW14wJmHLs9tgRHeN9ywE5IZ89VgbrhXgm5faHMAcCsBNPD06b9CahfE3/mR7uDQ9Kk4Klg2pgZlcTTdpOmMZIfDVyT6AGj6k5JNCZsP+rEmfzZ5u0EKyUQtqfenvRAMyDu9L1uY9xsbWqCdStyRKDz82K8UYE789VThq/XtSeLk7m7NBPTURxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 01:43:25 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 01:43:25 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] ARM: tegra: Add DFLL clock support on Tegra 4
Date: Tue, 26 Aug 2025 10:42:04 +0900
Message-ID: <12734451.O9o76ZdvQC@senjougahara>
In-Reply-To: <9139A302-ADF6-4E2C-917E-0E0E1D6CBA0A@gmail.com>
References:
 <20250321095556.91425-1-clamor95@gmail.com> <2480891.iZASKD2KPV@senjougahara>
 <9139A302-ADF6-4E2C-917E-0E0E1D6CBA0A@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PS2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:300:41::13) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 20235ecd-d163-4ebf-a61a-08dde441f25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGlyUVIwZkZqRFJ2R1VyNnVTTnZZYVlWdDhqMHJJcGM2azM1RWUxL2dSYnFD?=
 =?utf-8?B?QXlzUzBRT21BeVRGOFp4QVdsWjRJc1ZtenloZlVxUUdYNXJTV1ZKbDVLRVNO?=
 =?utf-8?B?bUp2eE10YmpEeUlYUy9YdmNvK1llVXF4V0k2RW1Jc1dMSzd0bGE1dDVLQnpF?=
 =?utf-8?B?U0ltMC9Ud3FReUpqY0Rkd1dqUmdFdTNmZ3B3SThxK2V3WVRJRVV0R3d5MWc4?=
 =?utf-8?B?ampVWWkrOXUwL3g1WTJGcmNtZ2xSR0piak9nb1ArQlZzOFByMFFDN29PL3ZP?=
 =?utf-8?B?emcrcTRFRVFRaFNmdU55K3VNTXlMRzRMTzE5S0oxZHFCcTgwZUd4MW9vTk1l?=
 =?utf-8?B?QWk4dzcwb3NGKytkU0syWlMvOWxhOXNSSWkvb3hFckFSbDQzQ2xmZlJ6ZnlS?=
 =?utf-8?B?N2RmVWZDaWh4Q3ZjcEJGdHRtQzRSVUYvaTFxNzU0TW5sVGVKakFyQndKcDFE?=
 =?utf-8?B?Z3EwRlVNdCs4TGpLOUpMTXRna1hCRi9pZm8yeFV0RUY2QTRpZGNTcDNFS0Rh?=
 =?utf-8?B?VFVRUGlWU0YvQS8wTlQrV25HNjNvNEJPVWRwWUUvNmprWDFkb0hzREtVNTl4?=
 =?utf-8?B?UDhVakRyL0FEcitBQW5NdTgxSzdFRlhCNEFyRDNtM1VkSlR3TXRhOU0xSDY0?=
 =?utf-8?B?LzBCVHg2cU93ZCtKQXZkUzhLRldKN1ZtL21FUlBLYkJxWnp3ajJidHU3eitS?=
 =?utf-8?B?bFZSb3ZSZzJkZTV2QmwwZWkyak9DbzlYKytkMzlVdE5OSzkraUd6QmIvVm0v?=
 =?utf-8?B?SHNtMmhocTg2aXBFNjNHUXdrSkM4VUtCS2ZCL0JBYU00WDYwN2NVSFdFZG9C?=
 =?utf-8?B?eGtDdDVjdmVPK0NWOXJ3RGpOZm1OalhkbGpzdC9SbzZTRFE0QUZmNFl4MUdn?=
 =?utf-8?B?a2NOaE11T2JFVnFmbFg2aFNzY0NEWCs0a1JLbEY5Y2V5Sy9LcjFCQVNYcjg1?=
 =?utf-8?B?Y2t4MllMMTNkcnpjWEtLNERFRmpta0EzK1FtQ0hTVElMakhCazhnVGt5Mjk3?=
 =?utf-8?B?a2RJb2lRZDgxb0Vrako1bnVldXdlYVcxZE5GMi84bVZ1bE1SU2g3U0FnVWNn?=
 =?utf-8?B?K0xQeGZsSm1OaThMWlZLRHFYUW1iekI0NktRbDlDOEdlalpGcWFFTFZ2bVVz?=
 =?utf-8?B?LzVnQXdIbGY2eUZvQjlBN0cvVTljeVFPZkpScFc5bjBGbnExUk1telJpY1dP?=
 =?utf-8?B?VW53ZTN2amZNQlNqc1M0UFpGR2kydzBSUFROVE5FOWpQQm1CcUxEWldIaDBn?=
 =?utf-8?B?clNPR25JbGxoTnBZamU4VG9IYWd1RjBITUpaTHhzYjI4TDFDUVhWVmdDZFpi?=
 =?utf-8?B?UzBqdEJuK2RwNVJGbTM3WnFLaElxcUdpTlNZTUxrdHJDb3N3SGpaNVhUSHZ3?=
 =?utf-8?B?Z2EzSzFnMGQvcUhJQ01wbGFBRE4rb1AxZEVNMHVKdGwwbFZiVXVIZS9tbSta?=
 =?utf-8?B?bHpHVFlFdG5MYWdiTFh1dkNzSUZiK1NYY0VmR0NacTB4aDNtOFRCd3kyN0Jo?=
 =?utf-8?B?UUVtc20wSGc3MnVoank3M0Y2WEZiY3h5bGFWNTE2c243ckc4dUdYcU5zSHFj?=
 =?utf-8?B?VTI3ZHlHVENRandPTnlCYWNEYUpYMDVGK0JKa2VMWUNoQ0xkN3pyeEF6V3Er?=
 =?utf-8?B?RVh6MWpCS2RUYmI1OXpFb0NLRjMwSjAxR3pIV210Nk1nWDRVNlhEdTNEQ2JM?=
 =?utf-8?B?Qkt0akNHcEIzZGF1TUVvWE00ajAySjZOVUc0VGp3cHRnc3hONkV6ZDNIMWdL?=
 =?utf-8?B?OW1VOGZtSDdvVHVXZ1hhVnk1VWgwU3N2MFRkMVRCRTJOSGlKN2tCZUFMbzZs?=
 =?utf-8?B?K1MrQUtjcm8yWFFlaVBMaXUvSHNVTEkxelhVdW1WNzNEL0FKQXlnM01IUVFl?=
 =?utf-8?B?dW53M3RmZllnd1MxTGNCbEdabDZkTklLcWhRS253UUp1bVo0OXpXVjFEWW9K?=
 =?utf-8?Q?UKglji3xt4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVlvK3NZL0ZUWVV1ZGc3alRmTXJzT0RwSTROMWFHKzFqNGY2ZHNTbGxZa3Z0?=
 =?utf-8?B?Y0RNNUR5a3NqeWFNVzhFa1RnV2dJcjBBdVhVTWMrUlRhei9MYmtCS01uSHkv?=
 =?utf-8?B?cVdUeTNsNDk0MzdpYlU2MTYyRk0zVDNYVWRiV1BTMTNBdXY3MW9vYWE5eERZ?=
 =?utf-8?B?RFpzY1FjaUpCUEo1RmdyQ1lERG9WS3BpczNJNmtxaHFRdmR2Q2o2NStoWXVH?=
 =?utf-8?B?R3NheVdHVXlLcFptbzJ0TVNvTmtFT0R4ZTM3eCsvNXZMUHlodlFWWTNQdWxV?=
 =?utf-8?B?UDByM0FUWDVQakJHejBpb3p2b1JCOFJESHlqRlRSUW5EbzBwT0UwMHIyVVhv?=
 =?utf-8?B?bDRNNWlibk0xaDZHOXJvdzY5cFJKNFNLK3RBQzNrUGxHK3BORmtaNUsvVXFs?=
 =?utf-8?B?b2tSbjFNeG1kQnkrMUU4THQ0Z2pUZi9pRmhoWVRMRDlVaDc0QkptaEFqOFVX?=
 =?utf-8?B?UXZYVnYxcldyN0dHZmZlU2Q2OFgvOWFiQnovRWV4L1FTU2NNTjRJejU2eWEr?=
 =?utf-8?B?bkEwWVdoVko5c1JCOVpidGRjQzlZQ0wxVWt6SEdiSFBmVnc1bXpqVG1aWWJj?=
 =?utf-8?B?NlhaV0YrR3BGM3JldHBQOGtDaGtNZDNoTlF6Wk1uWWZOTmdCbE51aGZnTGp6?=
 =?utf-8?B?bTBlWHplakpjaHNibENDZ3FEYmF1cWVXQnNxR1luOW5sc0svMjFSVFMyeEd2?=
 =?utf-8?B?b0VSR1RTYXcwdWtoSzJzTjVrSzhGb0FyVFh3Z0FtcTJwZlozN285ZjJPNEZJ?=
 =?utf-8?B?YVpwV3NFRlUwREFLa0E3NVY3R0tjVWtiQVpzaTJrdEt4NHlLZDVtSnNHMzhi?=
 =?utf-8?B?NElBbTdZd2N2T0JpTlBBSm93RU9QQ0lKdkswc01tdnMvOGhXS2grTXF4VnlQ?=
 =?utf-8?B?WlU0NjNWSk1iWjVZdXFoNWY5QktOWVlMVVcrUC8rU1loaG9ma1h0L2xJRytY?=
 =?utf-8?B?dUE1cUVBdWNRdEgydTFVNllkWEt0N3FWNG1FMysyREtrREFUb1ViT0pQek51?=
 =?utf-8?B?MnM5TEJpaXBpQXRhWW5HVFBFOG5KNXA4eHZIOFZ6TGVtdnp2cVBOVThhUnpD?=
 =?utf-8?B?SDhQaXBnTjJxRnRMbyt3T0ZZdHRvY0JXTjRJM3NEemNUZXJ0Ly9iSzczdFdU?=
 =?utf-8?B?dTJwT2VVNG9CNWI3SGZ6TitaZitvbHQ3NkNndWVmZjhEMEFkSzgzWVVKNEt5?=
 =?utf-8?B?SEdoSTE2RjIzTGJFdFZuTTFGWFA0dktwRGYvb1VsendLNmhjL0xKaW5iY0lL?=
 =?utf-8?B?bTRhSjNuUEdTQnQvKy9ubzVleGxvR0tVNVVMRFZEZmN6eW80RWRZRFk3ME1h?=
 =?utf-8?B?UnNCM0ZWTTNnUE9OQzZQRXB5Mm8zc3hEdzhMYitXdXhwVnROcjJTa2gwVWkr?=
 =?utf-8?B?cUNzK3k5TjlHRmpHZUZDZWR6dHNZRnlJaFJqTVM1QkQ5WElraFc5ZDJyTE94?=
 =?utf-8?B?YXpVTnZvblZ3SVF3VjBWUDBmUjJYUGZnVG5wZnJnQXhLUlo4TjZSVHUxVXIx?=
 =?utf-8?B?N3BxVUNpTDh4R016cjVqU3c0dVFhZlJyZDZSeGJTdytWb1ViK0xxZURGVllp?=
 =?utf-8?B?SmRQMkRjWHcwVnl2QzVXQ1I4b2liU2VOYlNTajhJT2xoQ25PenFhVzJkQmZI?=
 =?utf-8?B?bGhVQS9kVWRyeWFDemFNTmpkZUxwUmg4cEhMeWZPdkdDQmRFWXFZUlM1dVB1?=
 =?utf-8?B?bmtDZGhOZkl5UVRzNmd1YzArMUFIOVZFc0xOd1AxMzRPUWNjQnlyRXRURlhJ?=
 =?utf-8?B?U3F1VEFzajJNcXd6dUdFV1A1S05JVjBCNy94SUVKeGVTV0QrcnNUbTc3SFhv?=
 =?utf-8?B?MlM5cXV3eE5oTG9jYkRkaEJEK09paVZTZ1hGdkxDN2FjMVBQUEg4Tzk2WGpI?=
 =?utf-8?B?YlF3Mll2Lzlob1RTdEZxZW9wZ0ZEWmZOT2RzRk5sNkd4M1g5ZmVQcGxSKy9V?=
 =?utf-8?B?Y1FKRHgrSlp1b25FZWJ4di9HUGRFbkpsbEh0S2lFNnZuWStsVXpEUUFhblY1?=
 =?utf-8?B?bDRBU1Z6eTBSdkZmOFRyNGFTTlExLy8vTFZEeXdPMGlvbWN5SkJqMFlLZVBq?=
 =?utf-8?B?TG12a3B3UTcwbjdnQ2E3U1pYSVh4UnFHQjVnQkZvZ3pad29TL2o1WVh1SjBh?=
 =?utf-8?B?dmNRWTVYYXQzRlVtYm42QVY0NnFud1oxb1YwSjdvTEpLNyttWTJreTR0Ykpt?=
 =?utf-8?B?RDREeVdlUVVvQ0t4WmZsN3lUcUVsREM1L2lzTlhXK2FGM0pPMlUzU3NlNW1F?=
 =?utf-8?B?WU1FZTE4WkVYK3p0VGFwRXkxc1ZnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20235ecd-d163-4ebf-a61a-08dde441f25f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:43:25.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2kqcRxm4a/Gqa86dPnn9c7WyfJYVIaWuL1c+88UjV4x0dyj0kgbGw0tpLVDM9fm+QlYln6kv6z7RBEx+B8f8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931

On Monday, August 25, 2025 1:26=E2=80=AFPM Svyatoslav wrote:
> 25 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2025=E2=80=AF=D1=80. 07:20:10 GMT=
+03:00, Mikko Perttunen=20
<mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >On Friday, August 22, 2025 2:19=E2=80=AFPM Svyatoslav Ryhel wrote:
> >> =D0=BF=D1=82, 22 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE=
 06:05 Mikko Perttunen <mperttunen@nvidia.com>=20
=D0=BF=D0=B8=D1=88=D0=B5:
> >> > On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
> >> > > Add DFLL clock node to common Tegra114 device tree along with cloc=
ks
> >> > > property to cpu node.
> >> > >=20
> >> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> > > ---
> >> > >=20
> >> > >  arch/arm/boot/dts/nvidia/tegra114.dtsi | 34
> >> > >  ++++++++++++++++++++++++++
> >> > >  1 file changed, 34 insertions(+)
> >> > >=20
> >> > > diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> >> > > b/arch/arm/boot/dts/nvidia/tegra114.dtsi index
> >> > > 341ec0962460..25d063a47ca5
> >> > > 100644
> >> > > --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> >> > > +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> >> > > @@ -4,6 +4,7 @@
> >> > >=20
> >> > >  #include <dt-bindings/memory/tegra114-mc.h>
> >> > >  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> >> > >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> > >=20
> >> > > +#include <dt-bindings/reset/tegra114-car.h>
> >> > >=20
> >> > >  #include <dt-bindings/soc/tegra-pmc.h>
> >> > > =20
> >> > >  #include "tegra114-peripherals-opp.dtsi"
> >> > >=20
> >> > > @@ -710,6 +711,30 @@ mipi: mipi@700e3000 {
> >> > >=20
> >> > >               #nvidia,mipi-calibrate-cells =3D <1>;
> >> > >      =20
> >> > >       };
> >> > >=20
> >> > > +     dfll: clock@70110000 {
> >> > > +             compatible =3D "nvidia,tegra114-dfll";
> >> > > +             reg =3D <0x70110000 0x100>, /* DFLL control */
> >> > > +                   <0x70110000 0x100>, /* I2C output control */
> >> > > +                   <0x70110100 0x100>, /* Integrated I2C controll=
er
> >> > > */
> >> > > +                   <0x70110200 0x100>; /* Look-up table RAM */
> >> > > +             interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> >> > > +             clocks =3D <&tegra_car TEGRA114_CLK_DFLL_SOC>,
> >> > > +                      <&tegra_car TEGRA114_CLK_DFLL_REF>,
> >> > > +                      <&tegra_car TEGRA114_CLK_I2C5>;
> >> > > +             clock-names =3D "soc", "ref", "i2c";
> >> > > +             resets =3D <&tegra_car TEGRA114_RST_DFLL_DVCO>;
> >> > > +             reset-names =3D "dvco";
> >> > > +             #clock-cells =3D <0>;
> >> > > +             clock-output-names =3D "dfllCPU_out";
> >> > > +             nvidia,sample-rate =3D <11500>;
> >> >=20
> >> > Should this be 12500? That would match Tegra124 and a downstream ker=
nel
> >> > for
> >> > Tegra114 I have.
> >>=20
> >> I referred to tegratab and macallan boards in 3.4 kernel which give
> >> 11500, maybe sample-rate was changed to 12500 later with tegra124
> >> addition?
> >
> >That's interesting. I was looking at the public roth (Shield Portable)
> >kernel, which does not support Tegra124. I checked the L4T r17 release
> >now, and it seems it's a newer version, where the sample rate has been
> >changed to 11500 on some boards due to a voltage undershoot issue with
> >vdd_cpu on macallan/ tegratab [1].
> >
> >So on macallan/tegratab, the vdd_cpu (smps123) ramp rate should be set t=
o
> >2.5mV/us and sample-rate to 11500, while on other boards it can be 5mV/u=
s
> >with 12500 for faster ramping.
> >
> >[1] https://nv-tegra.nvidia.com/r/plugins/gitiles/linux-2.6/+/
> >b92cab2d4cb6379aeded80adc4c5d0708c3f038e%5E%21/#F0
> >
> >Cheers,
> >Mikko
>=20
> So should I stick with 11500 as a safer, acceptable for every t114 option=
?

I think it'd make sense to just put it in each board file separately. T124 =
DTs=20
already seem to be doing that in addition to the main file.

>=20
> >> > > +             nvidia,droop-ctrl =3D <0x00000f00>;
> >> > > +             nvidia,force-mode =3D <1>;
> >> > > +             nvidia,cf =3D <10>;
> >> > > +             nvidia,ci =3D <0>;
> >> > > +             nvidia,cg =3D <2>;
> >> > > +             status =3D "disabled";
> >> > > +     };
> >> > > +
> >> > >=20
> >> > >       mmc@78000000 {
> >> > >      =20
> >> > >               compatible =3D "nvidia,tegra114-sdhci";
> >> > >               reg =3D <0x78000000 0x200>;
> >> > >=20
> >> > > @@ -841,6 +866,15 @@ cpu@0 {
> >> > >=20
> >> > >                       device_type =3D "cpu";
> >> > >                       compatible =3D "arm,cortex-a15";
> >> > >                       reg =3D <0>;
> >> > >=20
> >> > > +
> >> > > +                     clocks =3D <&tegra_car TEGRA114_CLK_CCLK_G>,
> >> > > +                              <&tegra_car TEGRA114_CLK_CCLK_LP>,
> >> > > +                              <&tegra_car TEGRA114_CLK_PLL_X>,
> >> > > +                              <&tegra_car TEGRA114_CLK_PLL_P>,
> >> > > +                              <&dfll>;
> >> > > +                     clock-names =3D "cpu_g", "cpu_lp", "pll_x",
> >> > > "pll_p",
> >> >=20
> >> > "dfll";
> >> >=20
> >> > > +                     /* FIXME: what's the actual transition time?=
 */
> >> > > +                     clock-latency =3D <300000>;
> >> > >=20
> >> > >               };
> >> > >              =20
> >> > >               cpu@1 {





