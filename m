Return-Path: <linux-pm+bounces-9991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE79176EF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FEA1C2165C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AFE374D9;
	Wed, 26 Jun 2024 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GI52TTzs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00529410
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719373608; cv=fail; b=k7EZ3p39EhkV33BBpwskVIrti9B5az+HwM+XYXZXycQCAy33x1qsgd11s2qGbPknjl+SKYuBL2uYwQBiiD/of8h13soanFH+vsqAfzssxxg/3LjoPqyL3Wvhqjg6ajAa6QAE7aaCcL8CxZuVx1AZx2M04xN/edGp95Or5T5AxOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719373608; c=relaxed/simple;
	bh=H5ivKC4ayafDLYFBRY9GESa0eSWabDWkRpcb3Q1gWSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p59b067Vi7j1/BlpiyzRM9PcUG3yTC+j8IhtGXSsUY0MvsyNRuLLJpE9EU6r+8A5222ZDev5oqF6z3bkzKHi4nzlzEDsOcHB7r92iirdDNpm1mhvsTov2RcZoH8AyUOdXK7UqNkoMXARZ8cWaFNhBVQozNUbad+kXe2j6LGgHwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GI52TTzs; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pai4702joUGr5BR6oWa5cdNUUEa4Epst8pd6/+KDnuI4Uee3BjvUcFfg2HNrQ2vMzNquJnZB38DAdlOPTCKYM6liPY1yOvqa6GhBaQ945OUsw3Z+oHvS4XgedPBrXTrR07hRVISDzGtk8AzGJ1aoZhLI8PPfgf5UsGywuhqePsIVUnWMV3jXaiNNo9pIEc0UKMRjb1CVJ2CSMhD1d1nE46ZMwccFkR9a53LBiUAzAj1dRA5UDrC/vx4y90bVS6RNvtTpT1v2R9U2edcFSoLYPhO29zlED/DOy6tDq3pK7Ou2t90lYh3dknqnB3m7L+d/dwCo4GeV9sA25N4FI9Ifpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=povqmAnrUEMYzF7FxuJcxmCuSMjyb0QI8/s1hNk7bOk=;
 b=RvCtGEU62amtAvsecVOQKHaqEo7zeBih8HwAK038L9NhUuPRfT0LMxK16cp7d5phXnhsPsn2l0y6A7KI00g8cBQPdxqiYKvPmSnRjgNJJ0FkfArb9znThIDPzszA1ZJe5dJl3g+jLuymxsgFl6wbcmlpZlLUC2yu2TKLTtXiE9TseV+Hd4+zdASDsLV1K9xSPTkUCyDQw52GiaanFxh79WxkmIptxziaj320r+mEhICfJ+oimc6jkIE31c0CKFLkW1Kvv/Fnj22ddWQGI0UTGlt1O5qUKyu1wSJ/FiFAt4L58+vqtuLC4rcFmjJWLAS+axkrrt2PjIqbqhMSevyxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=povqmAnrUEMYzF7FxuJcxmCuSMjyb0QI8/s1hNk7bOk=;
 b=GI52TTzsPyxFb1zJ/eSyXudkeNE+YbgSBYi4ajzCLM1cI2CBs9wFpJ3FMPVR4vQwTj4bX6p9AshR/UoF6Mc1QtIaCu+eDcN5jV6rcXNUhCDhg564WC27c6ucWr8cf61zIeocISG4VamCHYOGHQql/TtuksPyjzVY1fi3CST5hf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 03:46:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 03:46:44 +0000
Message-ID: <4c41c67b-0400-441a-b04a-28be732ee64f@amd.com>
Date: Tue, 25 Jun 2024 22:46:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
 Linux PM <linux-pm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>,
 Yipeng Zou <zouyipeng@huawei.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
 <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
 <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>
 <20240626031753.dti6ixxi2jlykjqn@vireshk-i7>
 <e8275758-e0f7-46c9-8131-094abe363292@amd.com>
 <20240626032557.5vsjmzyzmtkbzom6@vireshk-i7>
 <20240626032702.fai3hlybfe6czmjd@vireshk-i7>
 <31730330-c0d0-41a0-88e9-6ce2909b6c41@amd.com>
 <20240626034402.vb6d6fkl2mkzadok@vireshk-i7>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626034402.vb6d6fkl2mkzadok@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:802:20::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0cc560-0819-4f04-6ee3-08dc959298db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGJuTVM3Q1FqZ3VPUTc3NUJkZ0VqcEZ0QUFLWUJRaXBaZWNFY2J4elNaT01u?=
 =?utf-8?B?bkx6SXNNRytXV2pPRjR6OTQ1WENWeFd0OGI3ejZEUjlLenpsbHR3YkVTdzdW?=
 =?utf-8?B?bDV4SGl4bDJEc3VjWTgrRndCSDJHOEExRjNsU2F5b3hBZk11SGg0cUQvTkZT?=
 =?utf-8?B?Yk9MdnluSHphVjJnMFp6RTcxRkFxb1ZUOEZrRTUvelpwYnlrcUtHK3NJL2V0?=
 =?utf-8?B?SCtjMkpSOXZUTmlaUFlobDRTOVBkS0NEbHBGZi9PRXQyNUIyVzkrRXBKODZi?=
 =?utf-8?B?d3FwMVlkc0NCMmRQZmlmdGlaQ0JIUVZTU2VaS1gvWmV1WTkxZXowTEtwejg0?=
 =?utf-8?B?c3hSc0h5VVpFNEtQaEQ2ZVA4dEhCb2JsZnEwTVdjMFl6V2laOGJFR2dBMmN4?=
 =?utf-8?B?Q2IrMVhuMW1yMzFZWnNteGdSdjg2emNrL0ViRWlDZHRmTld2bTk5RG4zZUx6?=
 =?utf-8?B?VFhWVGRhNVZSUHd1cWgxeE9Nb3RWTVFZU0VqQ2x3cC8xUFZtdVNwcXB4SFRv?=
 =?utf-8?B?M01rSjY4ZkROKy9TeU9wdmp5UVI5RVEyb3VSQTVLa21XK3M0cTAyZ0lmK3hJ?=
 =?utf-8?B?cUdVbWtPbGdXK05UQzdnMURKWFdpS1cxcldSL0pBeWhhYzF0SWlwMjRTKzNY?=
 =?utf-8?B?aXhON1BBN2FOcnZQcjBQd3JGRHFOSStEcEMwS0dMRmp2ZmlWcTlQVnh0Zms5?=
 =?utf-8?B?dXdxdUgzWU15WFRHcW9LTXgrRnZIWVhBaTRJVW1DdHVjb2J5SEdkRC9qdlhO?=
 =?utf-8?B?K04vNXlXcDR4OEZNSTJlR1RFWWM5TEFTYk5ibklZSFR4QUsydHFJQjVJZjN6?=
 =?utf-8?B?U0dKbm9XdFRlWGJCa0Z5aVpHMjlyRUdTYjZaVERLL3preWhwZnhhbk5mdHVS?=
 =?utf-8?B?eUdTRElRZzUzZk5ER1JaMS9RTG1CcEN0cVZQVmt2R3JRTHJVUVNFRjlnaGoz?=
 =?utf-8?B?VEdKRTc2bVF6R2pIcXYvbDMyYnN1K2xMSjB6Q05NQUxMZHNpUjhoeC82aGZH?=
 =?utf-8?B?clBoR0tqRzZsYkttUTFyeHlBS214aTByZmVCOFBCMGpGUCtMemlQb3UzeCtF?=
 =?utf-8?B?N0RnZzZmOFJaaXBIOWdTZGVFQ2tXZnVTTU5MYjJWakdOYzNQMDlRSjhBT1BF?=
 =?utf-8?B?bHo3TFp1SzRKbU5heFhLV291d2gwdnF2dWhDTkhrOFZMbHBXZGxCcnYwSEsz?=
 =?utf-8?B?dDEySXNIVlNVUEtkb212UFZKMkpDbWpidXQ3dXB4UjQ1c3hCWHE0OWRwS3JK?=
 =?utf-8?B?b21peUt6bnNTTWRTNG1UWjRRSWJUKzg3c3pQNXZ2V1ZlSDF4am5nSjh1NCtn?=
 =?utf-8?B?NEdsaEFpRWNKNFRjTE9LLzU2emZNYVdBbFdqbUJuL1l1dnY4a3c1M0pUSjNl?=
 =?utf-8?B?blVVOVdtTTlCMnlnc2sra24wYzMvUDN5dXdKZ2dQMFpZTVdpM0wwOHYyVUtj?=
 =?utf-8?B?STI0Um44WThKVlhUZXZ5b2ptamZkZ1JVZ0RmQ2JGTWdkZHdzendmd2ttVnJm?=
 =?utf-8?B?YmM0dE9xZUVZODhpWjhNZVRDV0I3NGZMam1EMTUzU1BSVnNLdE1FSnFlKy9k?=
 =?utf-8?B?VUZwNGQyNWp3WEtQNEhIQkFBZG9uZEhreGNiNXRYZk13bFNPc0o3ak1ZUStw?=
 =?utf-8?B?Mks1ZEY1Y2RsdG9mSkxpN0p6QXNOR0Fid3JpaVA4TjNPOGh2Z2grY1JVY3Vp?=
 =?utf-8?B?TkgxUHpyTldicFhOM3VyTkFXQXdkYWhQYm11Yk5ObEx6dHIxbVhGdGdnU3Nj?=
 =?utf-8?B?aTF4Q2gwbE9KRk9yeGNUbGZsK1d3VUNTQlBlWE15a3RhbVVaSld1TElTelBF?=
 =?utf-8?B?clE0OG9yMUZNK3FIdE1NZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NSs0cFZWZHllbUZaY1NEL050RUNONDlaZTI3R043OUxXOHk0ZzlsdVBkRTVr?=
 =?utf-8?B?aVdJZlY5aWlWTFVQMU9XZWlXQ2paYnZ1RUNZNVFER3VrcXJGMjlBY3lFWEtv?=
 =?utf-8?B?YnFTY1BOenllKzQ2WmNWWjNVa0xkdzI5ODJ3ZGV4OWJFbGJ5K2ZSaGJWK21B?=
 =?utf-8?B?YjJjRjNyWVhlSVQyWktGOE9LUkU3NG1ocnUyY3JMTDNEZGR1VDFsWkozOFhs?=
 =?utf-8?B?MnhhNXN4SkhZblc0UjE4azFHbUdiL0ZwVWFSUmF1dUJkL0tYZ3NzcU9hTG9Y?=
 =?utf-8?B?NCtKd3k5YXh2aHFnbXFFMzZWdkwxQzJyVTNSSlppM1BwQmhJakRzZkh5ZWt2?=
 =?utf-8?B?SGZvK0dxanNtd2dsTjFJaGxXWEhpMjF1ZEdlZWgrSDhUcSsyaXZaL0drb2hB?=
 =?utf-8?B?MlhOdUU3SE5qdU1pYmhOQlUzK3Z5aC83YjlwTzRhZjBtWVFxeDdxS0ZQZ1h4?=
 =?utf-8?B?eUxmbGw2cmVHSktkYjNxUjhnQ04wTXkzdFdqYmM0VFVsZ2NCSm1udzluZlVh?=
 =?utf-8?B?T052RUp1cm5haFVlUzQwaWVLdzY3VUhzWmFQTkoraG9oVzFHM1crYWtRU1Y0?=
 =?utf-8?B?NmZrVUNXOGNYRS9DRnlGVDI5SWkyMGFLWThpRG9YVXJZT3lKakpDUXgyVTRN?=
 =?utf-8?B?NlhWcTRqRXNqYVE3dkVhMGkwZ0ZFSnlOcmpXQTQ1Z3hXaDFxK3YwRDBOUjlo?=
 =?utf-8?B?K0RkcGhQNjdSK0J2OXFGem1oMnRua3cwSU51K2ZkVGF4REQxeXhCUlA3RXlT?=
 =?utf-8?B?ZG9JVk5QdHZBd21QMSs1dFpHcTg1MjdrWHV3Z2cyVDNRMHhsVjhXNkJiZ2lT?=
 =?utf-8?B?bnlZa0l5ZWNxWllhWDBncnhjc29vTHJrbzVUeWI0U2dLZzdka1o5NHFBYk9R?=
 =?utf-8?B?Zm5zSEo2VXZ0MFhoWnZXTTdERHN5ZDFGalp4NSt0aUp4ck11K3kxS0E1TTR0?=
 =?utf-8?B?NUV2Mm1hLzExZHBRdytWcHV3bVhBUTl5N1BMai9XTnkzTUxYMG5iR1gvWjBl?=
 =?utf-8?B?YTgvVnVXTWlNcXRuMGpQS2I0ZktJRUdwbHBpWkhodEFsSGdnL1lvb3g4M2Mx?=
 =?utf-8?B?VXhpZXNkMjhjSVA2RDc2TEZObkt2NDY1d0g2ZWZ3WHo3MVZmRzVPWlJhZjcr?=
 =?utf-8?B?NVRvMkllbXI5NUFqcjhiUElSQTludlhOQUV6NzhJZHdkMDErZm5NRmo1cDZz?=
 =?utf-8?B?aGJEKzl4aVdjc3BQbWIxWjNEbXRVTUNrM0NVMnluR1RmcEg1KzFDSmw4bU9B?=
 =?utf-8?B?ejMyTFhKZWpPKzlxeUlod1FSaFliWTR6QkJWMk1iSXpLcXNTNW9oK01XWE8w?=
 =?utf-8?B?TmFGODdpaUhMcG5VWHQrRW1ZdFpleXJyWmNLc3BleWNPWE5LMzNoZDZhUGgy?=
 =?utf-8?B?Q3pLOVFmYng5cUExVHNxdTJTR0tlSFVVOXAxVzRyclg2Nk54TkpQNVlocjB0?=
 =?utf-8?B?TU9PaW9McW04VGd0bElYVkhkOVFmQWpvbk51QkNlbFJYeURlVVJvYWhJQlBs?=
 =?utf-8?B?RHN3c0RFQzY4V3RuelRuUHNOVmZ0cjlWbGEra20wd1AzMDlEZjhtUnpFZU9v?=
 =?utf-8?B?ZVZ1M2FUS3ZvMDRSR3FTeUZid25uaUtWUWZsUG5uMVlPNEMyQk85ZnlSdVlX?=
 =?utf-8?B?VkVTTU1VZyszMG5sTENaaytaMUFHZ3VTZk9ac21NQVZzMG94cVkwRGhMaTZ2?=
 =?utf-8?B?anVPQ1BRNVArb1Q3QmF0SUJJcmE3b2N1a3BHNklxdldlVU5DUUNxOFpyeUMz?=
 =?utf-8?B?NXc4dFM1Uk1WQS8zTlZtZTNqVitLT0F1WEsvenpaZmo4SzZxa1lIb08xSmNq?=
 =?utf-8?B?VzZ6WjhwK3g4ZjB2M3hrY05QWjBPL0l2djQ3ZUlCdWRhdmZvRDhtQU51RXRk?=
 =?utf-8?B?NzFkdWpOQVkxdGdEMDE5SmQ3K3RIS0Q0U0pwalc5cktjaTdseWdrNWlrUGNl?=
 =?utf-8?B?Zi9tcnNCTjVXbUhyaE4xQjM1VUVoRVorN21wNVZIenVSTksxeXFCOXU2ZkNh?=
 =?utf-8?B?eTlSR1ZYL21meTlXdGJ2c2p6bHRPVVhONUZKK3RrNE5MOHR6WU5QeW5SWU1K?=
 =?utf-8?B?aTdGWGwxdWpMVnoxbWtQZVdvOUhRTjlneTcrZ1p6bkdUOW83dnpQTHhDVmdV?=
 =?utf-8?Q?h2/w9bkPN1nSdT+nFRBmocLAK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0cc560-0819-4f04-6ee3-08dc959298db
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 03:46:44.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5D6Z1THNJFEWmTiyeRR96mDeZYKlaqI+ZRoiaHeWv5cAtNAYRThgGxXQJaxj/j/lkKGrLVhV06aavZT3t48VVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

On 6/25/2024 22:44, Viresh Kumar wrote:
> On 25-06-24, 22:33, Mario Limonciello wrote:
>> I can take it all through the amd-pstate tree.
> 
> Unless there is a dependency, we try to take the patches through the
> PM tree itself as there can be conflicting patches there otherwise.

Right; but amd-pstate merges to the PM tree.

> 
>> I'll put it at the front of the series.
>> I think as long as we can get it merged before ~rc6 it should be fine for
>> the 6.11 merge window.
> 
> Since this is a fix, it may get into 6.10 itself.
> 

Good point.  I'll do some testing with your suggestion and send those 
two as 6.10 material and then the rest of this series at v15 for 6.11 
remaining material if we get it done in time.

