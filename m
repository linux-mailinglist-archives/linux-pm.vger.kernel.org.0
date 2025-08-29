Return-Path: <linux-pm+bounces-33345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EA8B3AF02
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADE71C2597F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 00:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5657374EA;
	Fri, 29 Aug 2025 00:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ul4C10b+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE451FDA;
	Fri, 29 Aug 2025 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426713; cv=fail; b=iY/r5/RmQq0eLGCI2KA1t/kU9igiU/zH/MyZ3Efpa3oB8dcssa0PUkxugNzeg03s1QnTdl65hd/cF5LdTxXgR3vpMOXHSWJRtgtVjmeJ8UGQVASysZXtFCh7zIHPd90PrziMpEd8BRZgDUW0uP2JXSk8dxShwpw2lZmWq9y8aRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426713; c=relaxed/simple;
	bh=ThiL1ApHskWeZSb2YyrwcmuCXsVXDq0h9au4rz29/Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHe4KPd9awKbvsvs/yXnp8eeKQDmC2+NOHYR7MKJt+lEecJCZLNomjihRCnvAGOS47ix1Et2sMKgHzNXQk5+N0/MLE70qxRNFiR3BaLwg0J+G0Ui+qiw0SOtjsKsYWEG488chnjKaQvzgAhD4Io3jxUiHe7htyzydLC7Djy4YVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ul4C10b+; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9xTUdcf5vaCSppBkDypSFKIGUhFb6wQiIzvVNncMkn6F1XVQkmtN93mmUCrIjT2jkBAoInESEx+f8g5gi2LOuXTsA1w0rlyWzCnRLnY/lpALxHQWJ8S7+JaWhtPB/zV0vu6EYyJxBS+O7d6kkW7H0y6HOSmwbwEZ4snYsrYht3/6XuGp3s2auHH/2BM+VuAQo8/gkexezaFMNgHKBv0IPzsulNhldY0Z2pbD7TzymDnPrAmVpMLpZKLgyo3Wtc0L29RFwzAz+gddn3EX5lvUifluATJeAfJjK9yn0K14EBG3HJyEgxNw9K31Hp9Bi8t5Zg0XohtBq+qlRTrdOehlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0j6lVRcH8lOwQpJ+OFUjBL/XHuXQHPRNl8HsxKv6MI=;
 b=m6zMcUBVelF69hKb9h39ostj2C8cv/GD+Lnb1m+OPCv7oD1Wfs3KOlQMUEBqVLtjhyQjRhorQZlUXtIb/9if+Fuv2YK9M4Oznd0PXhN/erGJ+XUrXITfOYwAFPLp204+PrlJltxxyNRiQvMYgvTZxohkWUm/gjxW8MmPwmpcw46FMucYHqjtIuBFYuZ5FimZvHkfn+0BAVjzkNhvdTWu7Es7ec3W4C38r/HGFZQGbr6zroobqHrnRlIhUSP57213vvqLK8nNW/ywwkoF2+MhAZCpbl3Ez6UJuSVgLaZRaGGxlrt7irmR2J6nvCO7w8HLLy4mjVkrxTXOEIxdaolWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0j6lVRcH8lOwQpJ+OFUjBL/XHuXQHPRNl8HsxKv6MI=;
 b=ul4C10b+P14W6jnSUCir2HDolIfbntItDcFCs7dfHgEVvKneXEuxVFvGSysoayiPz3vn/brnN/ZmDcrfWue8i/6lEZOttlCqzWunb2GtL8rqPnaLQNt1pbM5E+gM01wqgp4e5akeFngKZCSmfnLVLXMeYizWwju771oKoOTzW7OM/2tGq6qWj/+a5llYilqNNvvXAOQfOLEBbz6kPK14bzp/AdSoiBdTewLdlCKvREGOE2gp109HS3AAmG1tBx9kAgoziOc+Idji1d3xpS/IVHrVN97rebG8kkjgk0ZtALAvBioqZWiEfP62uZrPpO0eoKp3fp7nl94AVuF8Xzi1mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.24; Fri, 29 Aug 2025 00:18:29 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 00:18:28 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>,
 Sumit Gupta <sumitg@nvidia.com>, webgeek1234@gmail.com
Cc: Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Kling <webgeek1234@gmail.com>
Subject:
 Re: [PATCH v2 2/2] cpufreq: tegra186: Initialize all cores to max frequencies
Date: Fri, 29 Aug 2025 09:18:22 +0900
Message-ID: <2606828.Sgy9Pd6rRy@senjougahara>
In-Reply-To: <20250828-tegra186-cpufreq-fixes-v2-2-fcffe4de1e15@gmail.com>
References:
 <20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com>
 <20250828-tegra186-cpufreq-fixes-v2-2-fcffe4de1e15@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::11) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 375c5224-0b14-4040-7a15-08dde691941c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dktrMk1tY0JwVjZNYktCSEdNOUVoNVEyeFR5dFZhSHRES0hiNUNCTmJ2NG9K?=
 =?utf-8?B?UVdGNjh5cXhQTGhHQU54ZW5BMXFYL1hpWGpFbGxLMmloTEN3eUtGbmhPbnlX?=
 =?utf-8?B?cjZNbnNocmVCaHVwKzNCMCtyalhNbE9XeEpTSlRNdEQxODk2dlNMNmRtdkd2?=
 =?utf-8?B?SFdaQjNiOVZYU2hDS1RPb0lhQjM5K3c1RHpYMmRMa2RhUmhUcjIvQ3dSRW9s?=
 =?utf-8?B?bnU2V3A1Mlo2K1YxRU5QVUZINU9QRlNRcWpPQXBpckF4N0ptSXNNS3NJSFFU?=
 =?utf-8?B?VG1YWWhYRmdDenpvZk1XT3RRNnZXc2hlc2RLVitWeTNNU3E4Z2tIVVhoNFdG?=
 =?utf-8?B?REVpZWgzUTFGd3YrWCtZTDFRN3VGZWdTRjE1TEl4OWNNMXdJdEpPc3JhKzdH?=
 =?utf-8?B?R1loKzhvdzRsTUl2ZXBZNjhLbHF6MHdFR1pGcHRlb1o1NmJNdkR4Wk5tYm9v?=
 =?utf-8?B?Y0JQQTNkYlRsT1VOdUErdFM0U3RaRDZBRmN0VDFnVnNuY0IxQmZWRGZIZVRt?=
 =?utf-8?B?M0ZDVGtIYmZ0bURwZDBGVjYxQ3BLdjRVcnJQWWZDTWdkSEFpT3k3NUhJenNF?=
 =?utf-8?B?eVZtTWQ5amFKNHB1UGt3cHVGMTZCWmNPc2toRDV5elQ1RFZvSWpvMjkzNWhL?=
 =?utf-8?B?UXdvK0dDdWFYT2wzbXJ6Wnp4S0ZFeGFrdWNxN0NDOGVUMUc1RkpFRDA5cy9U?=
 =?utf-8?B?MHpIK2krSUkxQ2xxZDRIRDBQMVdERG9IRkZsTnFKczFRVVZKYWg4Q2N6TnJk?=
 =?utf-8?B?Uy9XTUczNUdMWmt1emp5eGV5S05yTzhjbldKOUI4aTI4c0RLZFdUTUpMckM3?=
 =?utf-8?B?ZGlISC95TlNyejh1UFNLdjVuUnJFK0V0bVZFZk5GNWI5a1hmNDd5bWY1WjVu?=
 =?utf-8?B?dTNDZit3cnRXbmNkbWNZVDZEQ1RKLzQ2TzlnZmhvSlZVUnhsUEQ4eHpGWUVD?=
 =?utf-8?B?MWJMZlNUc1U1a0tqb1N1c3FJNlhIWm1INGptc05KNEppSnJaZmc5WVE3SU5X?=
 =?utf-8?B?Um91TG9lMHJmbjFJSFQrQmNacDliRUhnaHgva3lRQ3pLdWM0enV1NEgxUFoz?=
 =?utf-8?B?RlZEeHNhYVM1ellydjJpaWx3S3BTWDZFRnoxTEQrL0g4ZjJ1U1A4SS9HSDN5?=
 =?utf-8?B?Vjd2TFhpMXplMTYvYjZ6UVpucWQvNDZNOUJrU0V1RjlaTUk1cU1TekpFVzVm?=
 =?utf-8?B?ME5UTDBBbEtlN2E0NDRMWmJ6NDRsZEdWL3FUdHRURnZFbk9Tcml2UVgrY2oz?=
 =?utf-8?B?eDhmd0gwNjlsYi9SV2l5RVZaTnZqbTJzVThxUFE4a2ZtVCtKblkrWFNGcXAz?=
 =?utf-8?B?WGVHYzA1bXFmL3JNTEhoTXd0Y1lKVE5RZUdFMGE3Zkl1Z0d1UUNYY2xPUUox?=
 =?utf-8?B?Tk1mQnYvTFJwOTl0S2FHajNxdlhSRFdlWllDazROcTFmbGJhbVh0bG5nRHND?=
 =?utf-8?B?bnFDTjk4d3AzWmtpQmJBR1lCSzVIdTNYNXZndjZUM0FkVWo2QUgrQ3FJaUdj?=
 =?utf-8?B?ZHZ5QXBRT3pnT2VQbnhtUDR0QzhPSDIyM3E1NkQ4WnFoMmhpSnlCZHVEL290?=
 =?utf-8?B?cG9tRnQ5dHc3SDEvUktnaytFQ0F0djdHUVRBbzhQczhSRnMza29YeC80aStN?=
 =?utf-8?B?VUFuSGJxMk5Wb3pDOVdaTW5hMzRaZVRmRXgySmxVLzZ4VHhWcWJoZG80ckZh?=
 =?utf-8?B?czJkU3dQMEtLd3MwaURhTkh5eENvSUU0K2pKaUIweFN0V0U5aDlXYXlqTWoy?=
 =?utf-8?B?R1lta0paemlzc2w1Q29OY1M1N0xtcDJlRXoyTDhLeGhXbTRDaG9QRUxKTjE0?=
 =?utf-8?B?YVdhU2tIOEg2RUhGd2Q3MFZTRUV2cmd3MStmL3Z4a3IraUdXYURHMFkwNUlD?=
 =?utf-8?B?cktVMUlKSmdJSEFnUElwQ2I0QWNPVzQvbVJjWlVQazIwOStqV0FjdnZjOEJs?=
 =?utf-8?Q?Fu+QXY3VMcI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUFmOXFJdUU4UXhqVVN0bHFwd0ptaC9BYXBoUXQxUXU1R1VpYlBvWVZ1YXky?=
 =?utf-8?B?VjlTZnBlR2I3K2tqZU9tS3pHYStFdUx5dTZvTjJuMFd1SWpPNXFtUDE2dnpM?=
 =?utf-8?B?dk1BM2pjQTFsVWVnMzdhZXg1MHR3cjJSTThvMlBQOFZlcVFOZGpyamxCaFRT?=
 =?utf-8?B?b2Z6TkVhaEZyNW1rU3ltaVBjL2UxeTlWSUxGcE9JVjUrVFAzbE5qZlFXWENw?=
 =?utf-8?B?b3F6MnROcnVXaFgwV2dLWDRkK3BVNWdGVFJJL0RvcjFyT3hKNTJTZjBmNWlI?=
 =?utf-8?B?VHY4b05DNUE5b2J4ald4M2N0SlZkZEg5cVVVZno5SisrM05kQXZaWExqM1dm?=
 =?utf-8?B?REY3cDRjSmU4dklLa01Ua2NTM2prQVYxdHdoa0MzbkY0MUE5NGRmaUdGSE9B?=
 =?utf-8?B?dzlaa2VkVlI5NDJHdlluRVZGcE1CRHZaOHlwM2xJVXE0RkpsQnpDL3duTmNq?=
 =?utf-8?B?RFk2Z2QvNVEvZ2ZCSHcrTWRlOC9BWHVmd0xGRDdMZFg4QjZObHNJUGU0TkVD?=
 =?utf-8?B?bE9sUVdhcDB4MWllY1BMaTRxSUtkaGlHYjh5dDZIbkVjWTVFY0NFS0ttdW5j?=
 =?utf-8?B?WFNBYzRXZy8wZk95djFmcnVQSW5HQW1vL0NmaGdkaFJKZUw3V1BSTGtwUXJn?=
 =?utf-8?B?Q2JnT3RXUEpjSmhoQ2R6WXUrdThoNHUvdkZ4RzZLUEx4NkdBN3JYTEdKZTIz?=
 =?utf-8?B?VWdlTng0SnNlWDNSdlR3L25ySmt5R0FvSmRCdlJnbVNtcnU3NlNGcVdaTlgz?=
 =?utf-8?B?TWZuUDdXVFNRVVdyTTlRVTB6dnpEVWgzUGg4emw3alh1QzJ2T2hnME5vMCtr?=
 =?utf-8?B?MXJTa3ZKWHNKMTkwNUVRU3JXcHM1Unl4OVVYVGZGRXNsaENTcXFLTE9wOFZY?=
 =?utf-8?B?N1BUYkFHWTFDU2t6MkI0cVNwbEdkN0hMWWtEOGpBcWVNVzAyTUJkNlY2TDdi?=
 =?utf-8?B?S0hnN01zMXZqZHpLcnB3R08ydERaWHNHZGEvb2t5WlRZc2huOENvNUpLNEFE?=
 =?utf-8?B?MWQyKzJDQzZ3OFlFaXMwK3JldEdzL2xMck13VTcybWE4ZFRjSmhUeERWQVhY?=
 =?utf-8?B?bnk4ekJUN0VpNEUrQmZoUERwYmJ0N29KdzhqYmhVY3Yyald0ZlFXRE9CYVVn?=
 =?utf-8?B?ME1VbFNwZHphUzlEbzd5dmhiZXVIMXFmYWhsTEVyVE90dnBxbHNTWVJZSCtW?=
 =?utf-8?B?SXROdEtvTDJmcDU0OGJ4RWQ2aytlZmtGQlZuZlVIVlJjZFR0VVFxMUFVaCtY?=
 =?utf-8?B?NXpuemJ2OXRqL0JYMEhRdXJxY2czZ1hzZ1RxcXViM2Vnd1dUNkhDb2s5S1Vz?=
 =?utf-8?B?c3VUdXlRZTNyY2RoNnc3K0RIR1F1eGF6VEhKbWE5Mk5pOFJpdjN3MUpJQW5y?=
 =?utf-8?B?UGI3clhOWWUwNXQzYXM2SFZPa1A3czd6Ynh0dk5VWE1rUWhObHVVSmNBWVlC?=
 =?utf-8?B?VGdjZGhrNW5DNFN5NzNvTTdyVE5KTFdGbkllRjh1SVlZZUpLa0NHblVTaEt2?=
 =?utf-8?B?QTFOaTNKZ1ZoU3Vzc09qVzd4eDAzai9lSVFjZUc2cjNxbzRzY1liSnJBTWVT?=
 =?utf-8?B?WDdSOFZOY1VKRFZPSWsyRTBBanBRSld2bXVMcmVZR2pZL3Q0ZndOZDErM2V0?=
 =?utf-8?B?dUo4MU1xcmtIQlR6NVlVWXY1UjVyTm1PQkdCSndoRlRTZ3pKcCthV0poeHVX?=
 =?utf-8?B?ZDYvZCtrdGlEUkhoQWxrYnhDZnRRaDNac0FMOVEwNDVNQ0dONEtYTWplYzJQ?=
 =?utf-8?B?NThiY1BWK21wUnBxSFluSHlaT1I1RWtUY3QvdHM4cVBtWUpZd05CbE52OHpN?=
 =?utf-8?B?ditPN1dvODdMMlFieVlBTGpOZlA2b3h4a3dZUStRYkRlNWVqOWZOQk5WUGdT?=
 =?utf-8?B?YkNXUFlpaUowVG15YXcwWDFjbVBJQW52NCtWTXF0U29MZnh4Q0FjVzNJS1Nq?=
 =?utf-8?B?a0FZOUdSQmZkTXBSVS9jUk1IZGNvTkx4Sjk1cGxSb0FsbEdEL3N4L01xNHB3?=
 =?utf-8?B?R0YzNTBrOHo3U2J0Zk1rOXhGak1GYmR3bUlTRVkzMkh3Qkk5KzZRN2lZcGZs?=
 =?utf-8?B?dE1yZFdpY09CV2NWZ2Y3RGdmenJaTGF1bEVHeE42MFRxQjJLYkthdkY2NHdH?=
 =?utf-8?Q?jpelCT37sdklnfMx09fAs2ahm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375c5224-0b14-4040-7a15-08dde691941c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 00:18:28.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJV+MiIPneBMRJUX2Pa+M6wkh5pdEw4jowIjxjSHraNsFIXqaJgTpoduFokhYZkmiUsoBUKGXwg1OGfXAScbPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634

On Friday, August 29, 2025 1:57=E2=80=AFAM Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> During initialization, the EDVD_COREx_VOLT_FREQ registers for some cores
> are still at reset values and not reflecting the actual frequency. This
> causes get calls to fail. Set all cores to their respective max
> frequency during probe to initialize the registers to working values.
>=20
> Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c
> b/drivers/cpufreq/tegra186-cpufreq.c index
> 6c394b429b6182faffabf222e5af501393dbbba9..3cd42db955c1c705f9774879e34b71a=
e1
> 24e86d2 100644 --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -138,7 +138,8 @@ static struct cpufreq_driver tegra186_cpufreq_driver =
=3D {
>=20
>  static struct cpufreq_frequency_table *init_vhint_table(
>  	struct platform_device *pdev, struct tegra_bpmp *bpmp,
> -	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id)
> +	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id,
> +	int *max_rate)

'max_rate' sounds like it's the rate itself and not the index. Perhaps have=
=20
init_vhint_table output num_rates and calculate in probe? We should also=20
handle the possibility of num_rates being 0. Otherwise looks good to me.

Thanks!
Mikko

>  {
>  	struct cpufreq_frequency_table *table;
>  	struct mrq_cpu_vhint_request req;
> @@ -218,6 +219,7 @@ static struct cpufreq_frequency_table *init_vhint_tab=
le(
> }
>=20
>  	table[j].frequency =3D CPUFREQ_TABLE_END;
> +	*max_rate =3D num_rates - 1;
>=20
>  free:
>  	dma_free_coherent(bpmp->dev, sizeof(*data), virt, phys);
> @@ -229,7 +231,9 @@ static int tegra186_cpufreq_probe(struct platform_dev=
ice
> *pdev) {
>  	struct tegra186_cpufreq_data *data;
>  	struct tegra_bpmp *bpmp;
> -	unsigned int i =3D 0, err;
> +	unsigned int i =3D 0, err, edvd_offset;
> +	int max_rate =3D 0;
> +	u32 edvd_val, cpu;
>=20
>  	data =3D devm_kzalloc(&pdev->dev,
>  			    struct_size(data, clusters,=20
TEGRA186_NUM_CLUSTERS),
> @@ -252,11 +256,19 @@ static int tegra186_cpufreq_probe(struct
> platform_device *pdev) for (i =3D 0; i < TEGRA186_NUM_CLUSTERS; i++) {
>  		struct tegra186_cpufreq_cluster *cluster =3D &data-
>clusters[i];
>=20
> -		cluster->table =3D init_vhint_table(pdev, bpmp, cluster, i);
> +		cluster->table =3D init_vhint_table(pdev, bpmp, cluster, i,=20
&max_rate);
>  		if (IS_ERR(cluster->table)) {
>  			err =3D PTR_ERR(cluster->table);
>  			goto put_bpmp;
>  		}
> +
> +		for (cpu =3D 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
> +			if (data->cpus[cpu].bpmp_cluster_id =3D=3D i) {
> +				edvd_val =3D cluster-
>table[max_rate].driver_data;
> +				edvd_offset =3D data->cpus[cpu].edvd_offset;
> +				writel(edvd_val, data->regs +=20
edvd_offset);
> +			}
> +		}
>  	}
>=20
>  	tegra186_cpufreq_driver.driver_data =3D data;





