Return-Path: <linux-pm+bounces-37902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F11EBC55C15
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 06:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86D384E26B6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 05:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA3223DEF;
	Thu, 13 Nov 2025 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gSCfUDcn"
X-Original-To: linux-pm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644E35CBC3;
	Thu, 13 Nov 2025 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010328; cv=fail; b=qK+oLTLsnGJt9tya2vj04wFedln3/fIVPytFn0bjIvDXCsr1gwk+hqZ1HGZB1xFsDVaDdnzFnn3d0kjmBpijpoCEeJsvVAmsHHJiN7UO4sXIf8EWliNLt2w2DwvzESSXkzPfpdo+jziQzCCzqdjyUuPU7Xq556dRVEMExIPkB6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010328; c=relaxed/simple;
	bh=DQ0SuFa21exJVFVe8l+1CuA7S0xSE7otryqs8Xa1f5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sOlocUgLdD7nJXvM6yznOYozieWYE/eCSyak1iEteimsQkpZIoq/ifyD34gJV2h/GfHn+WJsWCCVcI9n+XgWrTwpi3p6xThI2uTGe8fa4hj4h+upVx20Mq0h/US/fikFadWQMPWdtJ1Q+3F3x2+e4RT5AbppSTvpAYIbFwetiSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gSCfUDcn; arc=fail smtp.client-ip=52.101.46.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjTEConIyR7/+3gxPgauIdyKvt1rTUbgX4BdZ08KevqrmdId53T9ejcE8HmuSSYjvZFU8ejW8xRXgukKC5v5vLBSecPkpdIH8hUpdoUcwqZockpmehTuci2BdBXrj1lynYMx5YCj8+4PPPCWaSfIyeec1d5VBUA9LsDB4JrFf4QbRMGpDxOja4aF3MKTshEV5c5U/G00JYNJ52sl9ofBRZD5VFwJsftoanxgAcLieOGSIVhaIC+kQDPljKGLIEgP0hUa9J2jeFymLikWhYubjCswORWmVds0SPBXjqi+MtZK6ePK5rZjaaxT12KmC55fLAAqQdzhUkimR0eYWWsneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfigttYfUV0Low99waBmevRWY/1LoxZavJtViP/dpAQ=;
 b=tGPudqLBB3k8WXMwN35wBS9EwOKzUr+2Vc6EqlI8EQTUQADScsM3vXmreOj3caM6zueQEUf/smlvi5gO97SJSZM4+Mnt4bPpX+Vbxt8GX9H76D0xlyJ3iH6UD18kjDWWOT+iBLg6cFVnZ2ghM+TaL6JKrBqykyxH0Mv0eU1pWG15DAfJnVBwPMMCjrypIQm+WqljG7ggAAq5giX4B0ud1oN3sOk2/N1GEYQ2NUq18CLmqPUqCCIW54/WM5MwdZ6GPwbQyuhc1a8RHFITxKH+9uc1mvsB2DgP/J6Atl8Fpyw4x3ukQcx9anhswLleHWl58N/V48tLuLF+9Dgl3+WTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfigttYfUV0Low99waBmevRWY/1LoxZavJtViP/dpAQ=;
 b=gSCfUDcnwT4jqodxv734LqDbKpVW4Pk9npXrqUo87nlzPzyalo6PQDG0sq3G0lVm1MN7Ndoq+V79i3r+ZJhuC08YLPs1A/luWLgvFEmj48/7q8Jw6rRgU2JfMkv5fSl37kyUid3ogjdfv3RNonzgh00Ogye9M6ckI2uZmJ8HNjSvMrPe2eP3/UmocljKEUZ9nhc9pQ8nPOPI3/Yiy2JflrJugektYMKYzlFsPbNMchNNI3Sq/afTS70MNicDu0HR/jCx6KtdlgL+3CDoDilPBAKYROMPDGqOgMk3DhjMfjbalmcwDj/GvqsjVpiFszB4573HmRfcna5WnwEa2IzuSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Thu, 13 Nov 2025 05:05:24 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 05:05:24 +0000
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
 Re: [PATCH v3 06/11] clk: tegra: remove EMC to MC clock mux in Tegra114
Date: Thu, 13 Nov 2025 14:05:21 +0900
Message-ID: <6112196.aeNJFYEL58@senjougahara>
In-Reply-To: <20250915080157.28195-7-clamor95@gmail.com>
References:
 <20250915080157.28195-1-clamor95@gmail.com>
 <20250915080157.28195-7-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0316.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::9) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: c9005c09-c588-45c8-f979-08de227240b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3UyVWRraDA3R2V4dE40QVozQVFaQ2xrcnphaEVWUVJnZjF3SkszTHp5cld4?=
 =?utf-8?B?THMzTTdHdldTWnJKazlrcDNLNUVMK094TTNyK1NpVnB6SGdldVk0S09SQVRo?=
 =?utf-8?B?bVRYM2p6RllvM3JESitTcTdOUUlkZStjWGpKcmErdUxhRkErdXc2Z1FjZU9U?=
 =?utf-8?B?QjFuUjRSRFFJTitPYmdqYXRWY3dteU1QNmVkelpqYi93STNwUDZPcEVXQUdv?=
 =?utf-8?B?aDhEUWs2RXpiSWpaUk0rK0prUTJKNFZiVXZDbzF5RjFRZ1JGeUZ6VzY5d1hL?=
 =?utf-8?B?UzlyVER5R2tuSGxpaFA1WHhtUW9uTWR4ODR2bFNBeEdDSzFGMVh1Mzg5Mm1x?=
 =?utf-8?B?dUFIbmtYOFhtREM5cjJFMnpFUHVDU0xHcHZoMWFNcmsrMkk5OXV5OXVsQ0VE?=
 =?utf-8?B?VHhHSXpCMGdmeHB0SFQyeHlnZ0NOcUxXbXJzekxkMkFicVdiOTl1ZHBOU3NV?=
 =?utf-8?B?VGNSUEV5QURpMXVpRFZRMjBkZ1BQZ2V4M2c5RE5WbnVZTE1kSS9LUGFWdmZ5?=
 =?utf-8?B?RjU3VDcyVmR3K3pZNGtDbHhIbkxUYVVUdWZaNTY2V3dkV2t5ZXFldkpEMUts?=
 =?utf-8?B?d1F1TlZwblpvbDZoemhON3ZvT3dxMHNkSjBqVmNCV0FDajRNVDhjb0dOTHJ3?=
 =?utf-8?B?aHR0YTE5b0hyK1VoaHhLRC9XdDUrQzNjV3VXYUtsOGEzTHZiZWoyQ1YvZmdV?=
 =?utf-8?B?QktjSWpPS1hrYWswb0tkcXd3SExGQzZxeWVna3V2MmkzU0hSemVLZnBnamh4?=
 =?utf-8?B?NUVBVXlPWjV6V0FOUUhhdWwzZHVSSjNoNlMvYW9WTFRySFdWV1ZvTWNqeTVw?=
 =?utf-8?B?bHV6NFRGWGk2dTdLdjdLK0JodmlUb2MyNVFTSFlIcEw2Um1ucEc1ZklqOGJG?=
 =?utf-8?B?blN1RGROeHE1WDZyWStlWWdGTHBBOWF0dUJTMG9pL1pYLzhZbFR2NTdDcm1E?=
 =?utf-8?B?NW9OU3V3bDJVZFh0QXhMZHJCUE52YkJoSkE3Q2lpcjI4Z0g0S0dJaXBLSW9w?=
 =?utf-8?B?aGZqcWsyNmpLYjhOWjhLOXlZZEdJcHZ4ZnRSeGNKR1VNK05kUC90VUtGV253?=
 =?utf-8?B?bXBoWGw0SEpjaUQyYmlQTlhnYllEUmZjL3JwUE02RTlNODRFbVU0Sms1cDM2?=
 =?utf-8?B?UlRDSHdZY2Nza0p5YmJkWGk1NEJyMTQvU2pKY2ZmUGZRY1VZZ3lyR1JUeFVv?=
 =?utf-8?B?S0s3eEE5WWg0ejgyMUVRRlhUQmhpTWQ3OEU2R0RMai9iTE1SSTZpQm96T25P?=
 =?utf-8?B?WktSenNoaTFaWXJmdnV2emNDNG11VFlOZHBhU3J3K1FxVDcyS1creUtjQ3ho?=
 =?utf-8?B?Q3NjRE1vYlo0d1pDRDN4TndkS2NiQTAvbW1Nb2dwTllGSytpNDMyb05TcmlP?=
 =?utf-8?B?RzJpcGE1SzhUNVlMRm9XR2VpKzZTM0N3WUtORWU5QVl0bmZQUVRsRGt2M3Uw?=
 =?utf-8?B?eldKTi9YVkRkdDB5RnFXUmQ5Ympid1B2TkhXN3h0LzJQbVZRZUczYVF0cGZB?=
 =?utf-8?B?Y2syYU5GM0ZoLzdDcCtFQmV5SzFOQTBZYVgzUVBEM0NhbnVPdGo4dVdWa3ZG?=
 =?utf-8?B?MDFCTFNROU9Pa2pjR1N3aWgrQTZ1UE5GS28weDFpOCt2VEtIMXpKcjNqb1gv?=
 =?utf-8?B?RmxlSldxQkcxOHpYY3lHNExxMW9aM1Zzckh3OWJBS3pRRjU1R2h1UGM3bnVv?=
 =?utf-8?B?dm5zWG8zTmU4TXJaYnFKaFh5SnJBbFZCbGg4Qm5VOUtzQ2x3WXh3dmlyMUk5?=
 =?utf-8?B?R2pPS3ZZblpXR28rUUJuSkFCdXRWeFVaSFA0Mk5SRnNNTkJRcEhPeUhZNlEr?=
 =?utf-8?B?VDErT0xjL3J6OWhXS2MrMlZQcml2bENXSDJ3UVRsZXY1ZHR3QTBwSEliakZk?=
 =?utf-8?B?SlVsSW5iZnZSUlAvOXVFK2h4ZUVNelV1OC95VHZlRE5aV1JXeTZiVnJzbmJh?=
 =?utf-8?B?RkphKy9uczNyR3R0am5sU1kvdnNCWVlUZTg3b21tRXZiNFVwTnFmVGJGL1N5?=
 =?utf-8?Q?m+JTAHlFV2DlFWljoh59dj3XfaqnFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1UrYmNlVmZFSlBTdmE3cjJEM0ZSMm1sN2N5emM4Q2c5YUcxblp6dWZHemxV?=
 =?utf-8?B?MTBxbjhLVUdSaVBoV0svOGxBSFcwcDV0dGs4MHZJSEt1cFFCTXd4dEo3TDRJ?=
 =?utf-8?B?L2c2WHNzMytqa0lOK3VuTnNaRytaVGNaeGo4OFFyRFc0Z3pBOUZ6bXc0RVEr?=
 =?utf-8?B?cGtJTUtXdjlscldlUEJrRE44by96Yms1WGFXeXdwR05JNSs3SjNSbFF1cE1X?=
 =?utf-8?B?Y3ZDVk15ZW1zSVNqUThBQzB5T2c5cVFxRStibFRyUWdnamFpVW54dDZEeFpt?=
 =?utf-8?B?Wi9HQkhHa0JQOEZaOXBUNFN6T2VhMHZVQ1VGd2FXVmF1YkhUczlSbkVnMDZk?=
 =?utf-8?B?MW12cUVoVU9JMW56QXN5S0lXL25ka1FoWjJqb2Rxcnc1dStEMEhoVndGV1R5?=
 =?utf-8?B?cVhIRklxcGhjVEpCd2pKWUhpOElHM0plemlrZ3RNeUxwRC9nOGtUSzBUS3Q3?=
 =?utf-8?B?YTJjSWdDWGJDSnVHdnNkL2lvT0FmaXpCTitnUkZ3ZjFDL3NOTjJxbFdWa2xj?=
 =?utf-8?B?ZHdEd0gzRklTaTNjL0FXN3pUbWx0aG43VVpOVUd4ZmYvSWhhK0ZScWZ5MCtF?=
 =?utf-8?B?T2FiVVpoMEkzeENLdHpiZzZWYWpuc2NKOEJmYVJ0d1lWa1Z6WEovc09nMmh1?=
 =?utf-8?B?ZFVQb3ROeWpEekh5NElDVzFoVytHUjZJUGpRZHI3Q295MGsrMzVPZ3YrRXZt?=
 =?utf-8?B?SnZSWjlLZjFDSWlFVHQ2QkxlOFB1VElOSjVUUlJwWTMxRjdtUHB4VHBKL0hr?=
 =?utf-8?B?bEh4RTNPNHpZSmlqKzRjdTI2VjZ1U24yOUNLUWlMdE5CeGZFb2RpeHZMZDJB?=
 =?utf-8?B?Y3I3MWpwRWg2TTVwWU1oaVlwTk13aWVWSDA2WmVtUDFQQlBiL3pFd1poUWE1?=
 =?utf-8?B?a2FrS01YMFRwS0NlNzluRmlLc2JXMnNERzJRMmtGd3NSOG13UENhQWUyQVNJ?=
 =?utf-8?B?RUV1RVJLK08wRjJ6WVNOQ1JkT2NHL3c0T3ZkTndRb0I5UkduY2M3RnZ5cE1C?=
 =?utf-8?B?cWl0YzltZkJHWnd5WEV5TTNJOG15Tml5WGJaQWlJMUFUOGx4cG1rdFJudnM0?=
 =?utf-8?B?eUpjdE1zbzJjRmNtYjc4VU1tU0FCTDNZQk1ZYzl6ci8zSzNlZkJVK1Y5Qkpq?=
 =?utf-8?B?eVQyS2lYcXdYK3FCYksyY3VkcDdaWnBoWFRKWGM5U1RSTjczQkp2aTU4V2pJ?=
 =?utf-8?B?dlg3eXkxUFhRYTBBTFdONy9DTFhqV1BxaUxiNnVuYW5jWDRxc0pXV2xxb3dP?=
 =?utf-8?B?NnRYSytTcjZ6a1lLazhLdndMTUtKYWQwVm5KbjlZZHhkdVoxaTYvaEFxMEN4?=
 =?utf-8?B?RVYyblBMOXJLcnE0OTYydUJHQzJMbVFjVzhWbVFYTnFFS2FRRlRFanVyemhT?=
 =?utf-8?B?NjBzVk5kZm0vaXRKakNhblBtU2FxZGgyRldJd3MwV2VJR3lIRnJyQnNST25J?=
 =?utf-8?B?eTEzMUhMdFVpbENvcW1sZHliVFdjY0RUejNhS1pjT0J6UXlzVXlFajRUVXFB?=
 =?utf-8?B?WDdzOGxGT21NSS9iM1ZpTnBqcUxSZkRzV0pJWnZoOXljamhSS2xQb1A5Wm5I?=
 =?utf-8?B?OTRHUkpGSlYyWHlSTDRaS2hacFNBTWJDTVhoV3ljYVJPVmR5Zlo3TlNZbFlx?=
 =?utf-8?B?ZDQrdHhzNThuQWJnem1wUkdhREI4YnRqb2hVRU4rZTBPMlNid0RzRzZINUYz?=
 =?utf-8?B?VjJZUDBjejR0VnhYbzM0VEVJb2UrSlFWOXZJOUp3WlMzMCtTbzlaOGtGbThT?=
 =?utf-8?B?NDR1Q1NHcDdYb1ppd2dvb01pODFVYm9QT203d0hzK3VGYy9CY042R0JkUzhE?=
 =?utf-8?B?SENaZTFndnp1WHA5V09jeWNheHUxUklQUDdJZGZMN2VKYnRiN1dRTGtpQngx?=
 =?utf-8?B?K3dzUjQ2RHJTZ0s5L1pPRS9vcFlwakc0cEhvRDlidHdnQ2J1QWEvNU5zOXdQ?=
 =?utf-8?B?ZlFmOHZ2L0dyUG4yMnVXNDhnRzEyQnZkV2ZFdEt1MW5jZlNWYUJtUjJCWGlU?=
 =?utf-8?B?R05GZFJmMUVQU05IL2s2by9Zc0ovOUxHMXZEZGN5V1BXS09ybnFtdkVhU1dZ?=
 =?utf-8?B?aHhINTUreTU5REV5K0s2VkJtME01QzF6S3pxZnliSmpQbjIxaDFxT05kUHBt?=
 =?utf-8?B?cjBSNXVZdTdtZFEyVi9mMGxtWkVLZXVSZ3Y4RHlDMUZ5dG82enZ1bnZLckNy?=
 =?utf-8?B?M2F1ZXN4MzVuQmhRUjduc09XOUthU3UvZFNGb3ZYNGIrYWVHazlKaVhpRkFr?=
 =?utf-8?B?TTBFTGFQNnIvR09Ic1ErMENWSW5BPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9005c09-c588-45c8-f979-08de227240b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:05:24.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unjMhUJO6SgN73XyeDmqzMvlE8GfbCy66uNEiQ2FKilVfiHLm6Ern6ySBfCa7193651EwsbvBAqAZTu0LtW+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831

On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrote:
> Configure EMC without mux for correct EMC driver support.

Rather than just 'removing EMC to MC clock mux in Tegra114', I would say th=
is patch removes current emc and emc_mux clocks and replaces them with the =
proper EMC clock implementation. I would edit the commit subject and commit=
 message along those lines.

>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra114.c | 48 ++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-teg=
ra114.c
> index 8bde72aa5e68..6b3a140772c2 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -622,10 +622,6 @@ static const char *mux_plld_out0_plld2_out0[] =3D {
>  };
>  #define mux_plld_out0_plld2_out0_idx NULL
> =20
> -static const char *mux_pllmcp_clkm[] =3D {
> -	"pll_m_out0", "pll_c_out0", "pll_p_out0", "clk_m", "pll_m_ud",
> -};
> -
>  static const struct clk_div_table pll_re_div_table[] =3D {
>  	{ .val =3D 0, .div =3D 1 },
>  	{ .val =3D 1, .div =3D 2 },
> @@ -672,7 +668,6 @@ static struct tegra_clk tegra114_clks[tegra_clk_max] =
__initdata =3D {
>  	[tegra_clk_csi] =3D { .dt_id =3D TEGRA114_CLK_CSI, .present =3D true },
>  	[tegra_clk_i2c2] =3D { .dt_id =3D TEGRA114_CLK_I2C2, .present =3D true =
},
>  	[tegra_clk_uartc] =3D { .dt_id =3D TEGRA114_CLK_UARTC, .present =3D tru=
e },
> -	[tegra_clk_emc] =3D { .dt_id =3D TEGRA114_CLK_EMC, .present =3D true },
>  	[tegra_clk_usb2] =3D { .dt_id =3D TEGRA114_CLK_USB2, .present =3D true =
},
>  	[tegra_clk_usb3] =3D { .dt_id =3D TEGRA114_CLK_USB3, .present =3D true =
},
>  	[tegra_clk_vde_8] =3D { .dt_id =3D TEGRA114_CLK_VDE, .present =3D true =
},
> @@ -1048,14 +1043,7 @@ static __init void tegra114_periph_clk_init(void _=
_iomem *clk_base,
>  					     0, 82, periph_clk_enb_refcnt);
>  	clks[TEGRA114_CLK_DSIB] =3D clk;
> =20
> -	/* emc mux */
> -	clk =3D clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
> -			       ARRAY_SIZE(mux_pllmcp_clkm),
> -			       CLK_SET_RATE_NO_REPARENT,
> -			       clk_base + CLK_SOURCE_EMC,
> -			       29, 3, 0, &emc_lock);
> -
> -	clk =3D tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EM=
C,
> +	clk =3D tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
>  				    &emc_lock);
>  	clks[TEGRA114_CLK_MC] =3D clk;
> =20
> @@ -1321,6 +1309,28 @@ static int tegra114_reset_deassert(unsigned long i=
d)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_TEGRA124_CLK_EMC
> +static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args *=
clkspec,
> +						void *data)
> +{
> +	struct clk_hw *hw;
> +	struct clk *clk;
> +
> +	clk =3D of_clk_src_onecell_get(clkspec, data);
> +	if (IS_ERR(clk))
> +		return clk;
> +
> +	hw =3D __clk_get_hw(clk);
> +
> +	if (clkspec->args[0] =3D=3D TEGRA114_CLK_EMC) {
> +		if (!tegra124_clk_emc_driver_available(hw))
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	return clk;
> +}
> +#endif
> +
>  static void __init tegra114_clock_init(struct device_node *np)
>  {
>  	struct device_node *node;
> @@ -1362,16 +1372,24 @@ static void __init tegra114_clock_init(struct dev=
ice_node *np)
>  	tegra_audio_clk_init(clk_base, pmc_base, tegra114_clks,
>  			     tegra114_audio_plls,
>  			     ARRAY_SIZE(tegra114_audio_plls), 24000000);
> +
> +	tegra_clk_apply_init_table =3D tegra114_clock_apply_init_table;
> +

Is there any particular reason for moving this here? If not, omitting the c=
hange would simplify the patch a bit.

>  	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
>  					&pll_x_params);
> =20
>  	tegra_init_special_resets(1, tegra114_reset_assert,
>  				  tegra114_reset_deassert);
> =20
> +#ifdef CONFIG_TEGRA124_CLK_EMC
> +	tegra_add_of_provider(np, tegra114_clk_src_onecell_get);
> +	clks[TEGRA114_CLK_EMC] =3D tegra124_clk_register_emc(clk_base, np,
> +							   &emc_lock);
> +#else
>  	tegra_add_of_provider(np, of_clk_src_onecell_get);
> -	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
> +#endif

tegra124_clk_register_emc and tegra124_clk_emc_driver_available have stub i=
mplementations when CONFIG_TEGRA124_CLK_EMC is not enabled, so it would be =
cleaner to just call them always.

> =20
> -	tegra_clk_apply_init_table =3D tegra114_clock_apply_init_table;
> +	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
> =20
>  	tegra_cpu_car_ops =3D &tegra114_cpu_car_ops;
>  }
>=20





