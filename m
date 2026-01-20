Return-Path: <linux-pm+bounces-41153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F7BD3C078
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 08:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A768A4FA6AE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387E3904E9;
	Tue, 20 Jan 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mgp6SN63"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9137F74B;
	Tue, 20 Jan 2026 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893372; cv=fail; b=bR1xsrVepr2TpqrS+U0AvH5tglO+RwVydu6urOclEwMaBh8tfqB/pzxCouPya1vdDjjSQW0ya8Akd7hpUOLbmasOuFpRRXMz0+NnY2gFyrPu7s71b5jFcH+O2NFzo4LDOy2k011K6+EfPcmugAm9wUMdXCeWrh+6bRRoGCzErI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893372; c=relaxed/simple;
	bh=udBA0nXRtIx9bBngDrI70VY/UkoYuJHSiMl5nNJq3rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LK3UXxCODLnrI1oMWTso+W1BZBqQx5qbXm41kmkFSyOfP+NW/6B6BRF2w+RlIAYQ+sL3IxCv/D9yAfxC+qq6jY6nVf/OoSpvjRTd/4xuPkDmphuYdhYRTzPFYmUBgUQ64Fi3JDre69/SiAgiPt8rFYmnpv2e4k9mD9DFUU/xUmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mgp6SN63; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMSNYcNmjaoZU7jpQmS8mYALg2HW1jLLXUyet6KBdQ8k73k7LCNBI1neopSC7Sgnfs3QoPFQOKTk7BO0S0FtSHXNdHlZoBFPptqKLsAPuJak1PYQhbYckcs6cUi8teEQKpiY/+74I8kYIqJx/ecOJGmZYzWw+rmOoTOVnxL7h8T/WypCmeCo2jurBuNmCygCa4ZDkvCzj3KNjI2AUicZlvknWKFqVk42qquRxVC6LyBhJwDHwhX3XhusZghGchQrJMkTvjrZ8ZCFG1VlPOLXxTGxn7XJFu3Drl3vD0S9qmuFoM3OaIZltN5sQzuRvgNI+FZCDRTD/PA38YzpQmSSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLRFfCVqa/cRw3P8/0UL9mnd0maf1lofPQBCUjlBmag=;
 b=TLmhaCpGIoj28YqeXqSwoz7TM/jNNhGBWtR9jDAYo2XenUwQ7CKuP+6DXPqOqkdzYycnh3vrzBTh/CUGiZvpP+yfu8U7lGrseWeFx92sQu7IapH+sBq0g2XlwH529xpZeiIGbYEaSLxxjcPm/uSRhgP7xf+Ib1xqs0nLiOtjT421pu2wyFFwDIpU92P7tCKTR3cM0C6uTU+o0Wo+Qyy6KTnqN5FiwqDs7Md3JQtTmWX3Kbgl/GfP3OpNnB0mRtNkFZoe/HEKCM/Amr4kn2OngW1R299rq3BePDQLv/TpS7CClPBThHftCB9L9tyQulwxvp+tX4TRGwnhtEVgbirw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLRFfCVqa/cRw3P8/0UL9mnd0maf1lofPQBCUjlBmag=;
 b=mgp6SN63zCjG+TMPBPGCIQzNoygCkOBVx4KFJeLGltMr+3wsuvQYrksKyBRI9rjhrrVvB0FUscoRvMLcWZ1sPWv9zB2gDMb/+LRJ4EaUHqw7Tcy3wGoG6C/r5hm4JECshvFq5yMv2Hv5ikKg0XkYLzO00ZUAtLf65RGskbsp+cx7547vUidZdomuSpnRWIoexsdB8A5hUwrUhSh+DKQHq/2HJBVMB93G4/EFeUyH3DGa8IgJtKRfyD4HO3XV7U0cyhhqiyhJUvDmPNvYfdct0sV00vPi0JvYabob/iUH35+AwYyYagwrsawEXhM3xnqtboiLlVFeNGBH2hN+72iJ9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:15:51 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9499.002; Tue, 20 Jan 2026
 07:15:51 +0000
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
 Re: [PATCH v4 10/12] ARM: tegra: Add External Memory Controller node on
 Tegra114
Date: Tue, 20 Jan 2026 16:15:47 +0900
Message-ID: <2775048.taCxCBeP46@senjougahara>
In-Reply-To: <20251125120559.158860-11-clamor95@gmail.com>
References:
 <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-11-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: eda67d16-cd0d-4566-c209-08de57f3be19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1NtMXBQTjhuNU5wTVh1Z2U1NTdHeHl3OXdoZjJNWEFkOE9JVVkrbDlRVTYr?=
 =?utf-8?B?WGwwZEN4VjduZ2puaFNWUnF0QkljZllueHUyUmZmYlQrTU1ZQVU5WklUc2Vn?=
 =?utf-8?B?Y1VyajkvOTMvdTc2OG5YRVNzRm54c0ZvSjhDejU3SUpOMnBPMDVzbk9NcGtT?=
 =?utf-8?B?MTBhR3lia1FNODNoK3o4dVlzZXJsOStNZ0dGeHFoTEU0TXU5bW1YZ3hjeldD?=
 =?utf-8?B?aGRGcEROQlhZS0ViM3Vadi9INzBRbjZ4NXBtbzZyOXlCOE9TTnBEdVdqRDkz?=
 =?utf-8?B?cGUxcTJ2VnJ0THVrRWZmY05yUzE5R3RkcFhVS0NWaUNOekxaZC9Ta1lFRlZs?=
 =?utf-8?B?K2p0UG9tbnJ4V2FWVGtxdGFEbWE4RDE1UHVwV29NN1hCTHExTXRhdW94K3FW?=
 =?utf-8?B?SWtuOTdRN3dZTDlLOVRiWmNkaU5QRjBtRlFiS3JGa2d6U1JuMlNMUWtSZFl4?=
 =?utf-8?B?bHVLTDJqaHBsWW1lTTZ5ejBUOFhZVFhLTjIwb0x3Tlo4eTRudndrWWthR04v?=
 =?utf-8?B?RDFLMmhzTkcwRkhwSEdlcmdoaldhZXMraUZiUWtjdVR5Q0dJeGpnaVpNdDhQ?=
 =?utf-8?B?ZjB4Y2JCaXJhL2V1SWJsTlpWUWQ2Y0U1VU8wL1Z1OE5ON2l3RGdGR3JuaW9P?=
 =?utf-8?B?b3BuNjFXejMwRVRESXVzM25EaVJvS3h3U01tVmlWeGs2LzExNW5uNFB4YU96?=
 =?utf-8?B?UWtMSHhqUnNOdVh4V01zY0hNdExaaFNENVc4aU5WQWtOZ1RiWXFDbG1kUWNo?=
 =?utf-8?B?MkN3SkZRdTNJTWhCU0wxTlVPVDM0ZmlCNHQ1Rmg0MXZ2aTJ5SVJJZWZZazVw?=
 =?utf-8?B?VEtjU0VBNEZMNktXVkh2djZ2OWY2aXZyK1hPRnVJaVhJT0pvUHc0aWlmR01Z?=
 =?utf-8?B?MGl6bjNhdXFKWXBTTDJ6cFE4RGVPK3hreTZtWlZQTHAvY1RYQ0kyUGtqTTVv?=
 =?utf-8?B?Z0NDRXg2NXBNT0NHZVo0aUh1TjEzbzBpYWF2UnV6bW9rYmxHOUxib1Q3TWFO?=
 =?utf-8?B?S3NSWjlRRTBnR25uZ0JlRktINGdoT2liMWRsckQwK01DcWlyeGtpWVdXVlph?=
 =?utf-8?B?MHdoMmNoZVJQaHgzV1NYdHp5ZExrdENvblk5VUpMOWNXcTkzMHNLMHhjWElG?=
 =?utf-8?B?WDdmQzJQM1RJVXdRMklJYWpqd3QrUndaVzZROUpxNTVHUFlJblhueDVqNzV0?=
 =?utf-8?B?MkQ0SXV4TzFzSWRqQjBYd2RUZnArUHNWMmFrQ3VPSXgzVHlaSm13a0VUZmZG?=
 =?utf-8?B?NElESjBTdUF1blNyL0IwZVNEZWtBeGlPM000aEJvd2lSTkpJaXZHWkUrbnYr?=
 =?utf-8?B?YmNzZzMrdHIzSGlGK0t3MzFXeDMzMFNYdE5oMk4vU0dURVpQYzF2S0Y2OFN3?=
 =?utf-8?B?VGU2bzBnbkFVU3FlNjhWcXJJYTJoalBUa2JsRm1RbklkWXI5RlorWitvNGpo?=
 =?utf-8?B?bkNnMWRhbFFjRWZIQnhTa1MvTEt5bGhvWlp3Q3p4aDV5eXM4amMvcmhKLy9G?=
 =?utf-8?B?WS9mVHpZSWpQSVVjVmFOeHFkRXZETnpOdktJSnFSb0Q0TDd0TXBpZVpYTTd4?=
 =?utf-8?B?Q2VJVkZ6SG9pWlBXVlBIb2V5Z0V5NHdTbzNEZXhPZmJWWFoyY3E2RkV6c3ZJ?=
 =?utf-8?B?TS9jNDYzd05YR044NWVGa2dmVTdIWmFnUVRNVXc2VU5jTWhHVDMwSDBoQWRX?=
 =?utf-8?B?YmppNEhYNmRxQVdWTEtseWwyQUhXQk5IOVM2SGI0RnhJMEwya3pCMElPS21Y?=
 =?utf-8?B?V3djYTUxUnVjSGgxY0N2UFJuUm85ZUl3enhkZ29iR2VxdzNKQXhTSC9DQmor?=
 =?utf-8?B?b1R5Rm1iaWM4QU1aZkNKb0RXV2NrV3VONjcwdmtIOWZiTEU5ZTJ2bVlIeGR6?=
 =?utf-8?B?NVdqR0dMVzlVVXQ1cWlLaHlZK0tNeDI1Ykp6UWF4QWdKdm96S2JxWnBkclFo?=
 =?utf-8?B?RGs3OCt2a0VlbU0vWERENGZBSk1tTW1LMEF2Tm0vTUg5bXh3ekdzeHRwV2ky?=
 =?utf-8?B?Uy94Rjl6LzYvWFNMSEJXWThVbkJqZEFnbnhKQjFEaG1CVFFRT2NFbGdjbHNR?=
 =?utf-8?B?MFlQT2ZEbXUzMXZPU2k1K0VlVHN2b3ovNWd0czZEYlVaSHIxdnJ4LzExbm1E?=
 =?utf-8?B?dkZBdWprU0RuMVJNRkVhYTEzQnpWbi84d2QrTTF4cEk3dlJ6cEMzYUlhZmYw?=
 =?utf-8?B?SlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU1TbXN1bWh0bm1yTjVrb1BZb2JpUTVKNEMycWtGWWtLSUtMRWxHT1dLYjdp?=
 =?utf-8?B?bE5UUWxTV1I1MllTdXBSSWpYY3J3NEsxTG1vNk4zYVpYOGQ2U3l4SVArWS9v?=
 =?utf-8?B?S1FTby9lYWdGcTZJZGtLL1lNRDNPWm5CNDlhdFkyK0ZhTkVvUTlta3BWNG9p?=
 =?utf-8?B?V3hJRHhvWGxrQ2U0S2ZJMzhFWksra2U1bjVPQ3VDWlBiV2VwUGxvRTgvZlgw?=
 =?utf-8?B?WkR0ak4xTTRHU2NDOXdRcFZTZEQyMFhNODJYekljcFJkWHE4TlNtZGdhNFk5?=
 =?utf-8?B?dGFOSTJPMVU0WERuOEx4VUlBU1J4NitRWVJJMWxjZloycjkwRWNLZDNLMkVv?=
 =?utf-8?B?eE8rTHNwTWVMTHVJT0pvR0hNemhUTHFTM2ZlamtqMDNSS1E1R1krVUxHejRV?=
 =?utf-8?B?NXp4bXpoVjIxT1lYODYwczZYVlNRNVVxU2dOdTFDMUd3Zzc5bTkrSldQYnhG?=
 =?utf-8?B?Qmk4SFlWTDMvTDI4MklUajVaVjdJK0tVckxVbnBsMC9aM0JNRktSK3VZQVNw?=
 =?utf-8?B?djVOaVYwbjVCOEFnei9lcVFKdU5nOGxIK1llYm55cTNxMVVrMmFkdThOR0pC?=
 =?utf-8?B?RFpTUWxnOTE1MnpUb2wyQS9vVXFUV2pwZXpaUzhsSUM5M1BPa28xcVViNFYv?=
 =?utf-8?B?Uy9NejNjK1Y2WnduZTBESkg2S2orN2xaekQ0NTZmUjk4VmxhV0hjbE1odXIr?=
 =?utf-8?B?K1dNaHNOUno4Z0FPK29yMlljaXYrTXhhejhJOWEwT1U1aEdlakZLN0JDMGll?=
 =?utf-8?B?aUpzUlhFVXlqcHB1S0Q1UUh5K244SXZnMlB3U0VpT3NNTHVsSkc3ZVlrM0FL?=
 =?utf-8?B?c0ZSNzgxcmdHYUZaK1ByWk5YKzFuc1Q5Vk9EZlRwVnVFSHdtaHY0NEtsc2pP?=
 =?utf-8?B?R09vaVRpT0JXSlpRc0ZwQ00wRVdrcWtaOUM5RWd0RHNySWVhTS9jaUhRV3pF?=
 =?utf-8?B?UVNqcDJhNUdzZ2hOdS9kRmpUZXpnWDZtcldvUUhJcDQ0WUpuUlYzcmx6djdZ?=
 =?utf-8?B?c2NGdzlRM053bmVaMEtpSS9RRFl2cXBYejRneGVGbWtqUmFUYStzS0xTSGQ2?=
 =?utf-8?B?S0tleGZ5SDduaCtmNXlOM0xsdnQrbDY2ZWNqeWo3eWF1K0JjaUhDODAvbklN?=
 =?utf-8?B?SzVhVjluWDVFNG5xdjJjZTNnZjByVG1GU3QxL3R4ODQ0MVZ4RndiZityTWxi?=
 =?utf-8?B?NEpqeUszZ2gwWUVoeVQ4Y1pKdDdEOUg4Zk5CS3QxWUR1ZkZCSHdFVFg2SHlH?=
 =?utf-8?B?eFRONlAySkpuTkNkZnFmLzdkSEYwYkRETHY5TU5ZY0k0YlE2cWlNSEl4c3BD?=
 =?utf-8?B?YUd4blBrR3JON04rTVJxR1FOandzdXhERXN6YjJHVXM4ZXdic21pQ2d1UGE5?=
 =?utf-8?B?T3ZDdUJiZlV0RXczLzlQOTk4QmxjSGtuYTllcmtaaFBEaHZTV04ySHlOdm5w?=
 =?utf-8?B?ams5dlZ6SjZsMmloMXI3N3YrU0NLQThaeTRDbTRqOWVDL0dBNlNnQ0wxczlD?=
 =?utf-8?B?bDhvckpXbFVraUdKMWd2bE94RnR1R0YxMFVOM0tnT200eURvdFhlbjI3STZL?=
 =?utf-8?B?RFFMQkN2eGg2OVdZcnFlM2V0eVVqMGEyTWtsbkdXVVp4ZEN4V2U2VDU4T2V1?=
 =?utf-8?B?RDA1MjdMSEtBZW1NWW9DV09lczJ5ZWJEWDhpMUZGY2JEaG1EZGRIdDFndHRo?=
 =?utf-8?B?T25JN0dUU0M5dERXQkNvUGZPemFpTzBkeWxWRjRxQmFqR0svbzFmMWVhTDIv?=
 =?utf-8?B?TTJyTU5wYVNoR1AzaEw0RGZaTUV0WVVIblFPV1ptSDhBN0p5REVHMFF1R0lx?=
 =?utf-8?B?Y0JIditncjh2eHdBWFVtK1hNQVNUaUlxa1UySWovM3BsUXpobGhnMmNyQnpR?=
 =?utf-8?B?aW9yQmFFaHZuVVBxSzFEU0ZiWXNONU5lOTluc2RjRGEvN0hEcnlicTdSRVUy?=
 =?utf-8?B?WnJvSXdFQ2FGMVp2ZkE1aEc3RXFlM2RKd2lxR01Zb3ZiaGY3UDQyQWtUZklD?=
 =?utf-8?B?MDhoZzlDV1dGT2M5Sy9iOWN4YXNLU2hlVWp3cEtnVzlsM1E0NmxVODZOV1ZZ?=
 =?utf-8?B?b0M2d2NHM3VqcU1oQzlNUExCcmpSWFJ2R0pQVjdoOXVNdmNPVTlheW9TcDJG?=
 =?utf-8?B?bm1sTU9aVVdrb0h4VGpSMGgyRzFudTJ4QXlHZVNqditLd1Yva3k2OHhxK3Nt?=
 =?utf-8?B?amZVcTJvZU9DaCtVV3RxVUh0N0FCa0Z0TE0zb3BBa2hoNjdIZUhwOERPdVNH?=
 =?utf-8?B?Y2JXTTE5b1RJWlBXUHBmTnh3eVRPN01XQmJTWStDTG9CcU90MThrUi9QV0ty?=
 =?utf-8?B?ZXVEbTh5MmlOWGgwZHJuc2o1Nlp4UERRaHFTY0NjeG56cnVkVWJLVzVwL2RO?=
 =?utf-8?Q?FlqaeNh/KjNEtlaYu/Yo+pV08YYEi+GnfHAnXnpS8ObQ9?=
X-MS-Exchange-AntiSpam-MessageData-1: sTe/0mg+ThlemA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda67d16-cd0d-4566-c209-08de57f3be19
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:15:51.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JUMhuUmRJUvX+cdyzLqHG61OeWaQnkmN9r9TcEazM6OVstf61MQoq7Ka2e6vTw83Wl4zfoMAGP9LHKAFh4i3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add External Memory Controller node to the device-tree.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/nvidia/tegra114.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/n=
vidia/tegra114.dtsi
> index ef0618e9eec1..a920ad041c14 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> @@ -259,6 +259,8 @@ tegra_car: clock@60006000 {
>  		reg =3D <0x60006000 0x1000>;
>  		#clock-cells =3D <1>;
>  		#reset-cells =3D <1>;
> +
> +		nvidia,external-memory-controller =3D <&emc>;
>  	};
> =20
>  	flow-controller@60007000 {
> @@ -655,6 +657,16 @@ mc: memory-controller@70019000 {
>  		#iommu-cells =3D <1>;
>  	};
> =20
> +	emc: external-memory-controller@7001b000 {
> +		compatible =3D "nvidia,tegra114-emc";
> +		reg =3D <0x7001b000 0x1000>;

The TRM says that the aperture is 2K in size. Otherwise LGTM.

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

> +		interrupts =3D <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&tegra_car TEGRA114_CLK_EMC>;
> +		clock-names =3D "emc";
> +
> +		nvidia,memory-controller =3D <&mc>;
> +	};
> +
>  	hda@70030000 {
>  		compatible =3D "nvidia,tegra114-hda", "nvidia,tegra30-hda";
>  		reg =3D <0x70030000 0x10000>;
>=20





