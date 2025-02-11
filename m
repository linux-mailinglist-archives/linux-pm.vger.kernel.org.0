Return-Path: <linux-pm+bounces-21793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48DEA306BF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 10:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81685161863
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350A1F0E36;
	Tue, 11 Feb 2025 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RgwiJ3Fs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394631EF0A9;
	Tue, 11 Feb 2025 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739265549; cv=fail; b=ONelSwV6J5YAUcBEC6zpwpRYPF0MWhKrV0C7BbpX+R3ap6YyfmJ928FLoQYkkVybLuECfHBEqyS3qIksJcEpLujJHybdHZA9TOONeurQSsL4ya2116fW21TUwzvJZ8uPlAEKR16uSDOdn1sSI2X3XAZgMQd3VS+1ktrKB2PChIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739265549; c=relaxed/simple;
	bh=hkB/VLhO2EvwaPPV1KP13zWaNqN6toQuod4NYvW9vVo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eqWSudbWPqfhXXixHrff5Cqj0vUiC6e6lNGgv7bVe+G7/IjHIfn//JyUjwZFjQoZCjHUMI0VEt0P2Ca38GUwb+ldCVWQYI6/JY+4ZbiJksxxxVNlhHyLR4VnqWMltoZzrliVS18IgrrD86z7RJNdyobz0gejZZInAU+yZGCOpGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RgwiJ3Fs; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EobCIqBFxHYKm+/EQYYtXNPS91AgvLnBbvsajlfCLXZyotc/lZSUE6AXwPM2kYEUfaMhwuIhL8ZgbRP08woGlqXXXnIzOP0051YufRvNfH8POjDmrHObPE2yJD1O3PwmjqBRF0Ny5vkPjHAlJyHM2YadSKQFjLov/DQCEwPptaRFJ+EUtiJwQ5kaS6ObFwCSxb8zFlTmD0JUilWcm4YxdabC/9HhFMclMrcef6BAtWwsgozSeKqmMYHL2xT1HDj8NW/UzXy2mfgCZwD7REmc/WbfgG2GXXL8hgVuSpWdLcFbIc+ebmasuQq97D2FSfBZ8S6SpWviDI+TcXM46KXvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P16kuQ89y8xRWYtUE/eiCPbcwesM9WmLCZcUPmevabM=;
 b=hu8nyBWqVJ5kgh2h+tqsKExbmloF4z5x4IoU+enRNhu/TuD+vzBYLYJHrrUMOmNxo05GwZh0zRLGeBbeAqUc73ZlJgeDOHKjTln0E084yY27FbKlof45HotEm++ewtcO5wRC46YVS5Obr/filQC2myjWb++ASvWHLojITXEhevGePzqhZV70lJzR8eo5fL+y4aSeLgz47xOVXTYJ9H+gBjd9+YzFrGDaPzhf8I86pZSiqvCk6hmLjXhD9CSwqrtr87YiyqC5uY+ZwyjGysmHZcKDIep+g6rec0Flwh7jfoi3iOag0m3Le3xpR2+W1ECF0DFUDAMsvccy0CLH4Q04tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P16kuQ89y8xRWYtUE/eiCPbcwesM9WmLCZcUPmevabM=;
 b=RgwiJ3FsMAt7aJlMuF7sxTpXvadGPjN6KAvO8hd/0JBNoY5WoFXPss+9UzHJZaVpU5jEc+Iul9i4bgDVtta2r8tHeuliGPbrG0eEHpfTnDLsPgx16b2gH0H8tZZd3AarSXwy12kXypz2UJIgsyTUvbsMi6vCiZsBGbUQsP0cTpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:19:05 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 09:19:04 +0000
Message-ID: <eb87c2ed-121e-407c-b1e5-f83150e5a69e@amd.com>
Date: Tue, 11 Feb 2025 14:48:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] cpufreq/amd-pstate: Cache CPPC request in shared
 mem case too
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-9-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-9-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f34d94f-d79a-4ffe-f42b-08dd4a7d2141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG9PZWxPSzQxWXJvd2xIekZLZ2l6endRbkNQQlB0YU5ZR0p0dkgzS1BMZXZ5?=
 =?utf-8?B?NHU4MC9ZUEJoYWtGSjVYZjE1cmJ1MkRJK2NNNVlBb2l5RG8xS1d2aFNRbDRR?=
 =?utf-8?B?di9WZ0UrOU5heWtQcmwwd0dwdUhpZFpjdUwzVDFYemV5bEI5aWV6R2MwWnpX?=
 =?utf-8?B?eHVFRjFFTU1BNnU0eDc3bXFIN0dldmZsUUNCcHl0NFk0NGppQTYrcjlSdytu?=
 =?utf-8?B?aWRtdWJzTGZEdGNNUE9ITzVsTDA1cVd6OGR1d3VodU5TbnkyQ0d2NkY4ekpQ?=
 =?utf-8?B?b1VGYUZmYjJrUTdaZUl2V2cwSHBWaHlIaHNMdzRvZ2IxdlNzUTVoU0Flb3Q5?=
 =?utf-8?B?UFlzcitaVktKYnZCZWtZa0czaTR3T2hicHhHZUxubmFnSlpkY1BjSjluU1ll?=
 =?utf-8?B?TTRDRGFVTGRyelIySGVNbDd0Z3JkSkR4aW5NU2tEZjI3Y1QyWkhHL1A2YkZt?=
 =?utf-8?B?Tmo5emFSM2VHeW1WZ1NGMUNwdVhISzNmUis3VXhmRVdvNkJYOVVIUE93WGhp?=
 =?utf-8?B?SmRVUzBNd0FDdkZaK0NWOUYrelNXU2hoTCsxeU9VbXFMVEJXV2lBSmdiTzdO?=
 =?utf-8?B?WGppdmx3c3VrbWJlWndkTG1QWW01b3NzYU4xdnhheXpWRTFrdlNtZUkrQ2Zk?=
 =?utf-8?B?bFBpbEd6VnNUNWxHUldMakJyeEhQdzgvRERnWVpnVU4zUHdsMmxvbGY3OEtl?=
 =?utf-8?B?Nnp3ODNsRGIzeWp6WldxU3d5VVpTYXVjdUNmTDd2Z2FIQy9tMGtZZGR4TW5E?=
 =?utf-8?B?MDhhQkU1ODhNTm5JdUZBdk16Wm1LcVQ1NE5rSE1oR0dkY2hZVUlmNFN0T2FK?=
 =?utf-8?B?NEh4eHg5NkJxREdKSG9hVStsbHRZb1ZSaS9oeE5KbFhZSnlFaVVUKzBoQmNQ?=
 =?utf-8?B?cStYL3ZDSXRUTS83OFpueVFqWHlpWWNFcXFJY0hCajJjTGtmZ1ZWVFAxZjVD?=
 =?utf-8?B?N3k5L0hLVnBVOU5HWmxHM2tYOExYZDVoZldXd2l4M3U2VzZRNnFib0V2TjNp?=
 =?utf-8?B?S3hTMmRGUWtKUERBLzFLeG83TkFlUHNPbjIxK2hWdFZrZlljTVlWK0U5MmZL?=
 =?utf-8?B?SVRhcHV6eSs2VE1oM2Y4SmlPVFRUMlBSbUk1ajVqS24xRmJzWm80eEpjY2FQ?=
 =?utf-8?B?MnJ6R0loUk5VL3U5MU54bXpmZnFLaUlPTHduQ1hiZmxiMG5YTkMrTTlSd2Yz?=
 =?utf-8?B?dTNLTm9QQllVcTg5R0pQZm9XZ2pDUURvRFZERG5NQm9HVElHVnR3eWZSTGdO?=
 =?utf-8?B?RXYzclR4ZWF1SVhEdGVBS3J2ZzJSbDc4MjBvdFFLdzFYczhwRzF1aXk4TExX?=
 =?utf-8?B?bGVTZStvTytXMitRMnJJenZ4eEhWbkxoS2NSaFJGTDFnM1RreUs5TUMvdHdR?=
 =?utf-8?B?cVlwTVhlVVhNa1RoWHNwSmJTV1E3MnRyYnJ3aU50NGNhV0kzL3J2Q1M4UFNB?=
 =?utf-8?B?MEduM2d6aXZPYkVwb1BJSU54WFdXRmVXRnRUWW9kczJDWFdITXFmTzA5cCtH?=
 =?utf-8?B?WGVEVFVMN3BialVlZVVja21QM2loUzFoQzR2MDlaRi9Ta29VTUdJSm4rK0I3?=
 =?utf-8?B?SjJXbWdkdTVWUUlzc0ZWOHJOSTZ2cEtVcE45c05tK3B5QVRaMmhRMmNmcHA3?=
 =?utf-8?B?UzZJY1J4YllmRFMzb0FyUUFCZTVOc1VGalBsU0ZPd3l2U2pkUUZPb1dsSEV3?=
 =?utf-8?B?Q2lXaTJCZS9ESVNnTFNFUWYzd3YzMUdiVHIrNkpzY1YrSW9VTkorWk5NUlNa?=
 =?utf-8?B?KzFWL09qcHRmR2VKS0l5MWxIaC9uNi9oLzZZNzRMZjRiNDM2aHlHMUE2RHZW?=
 =?utf-8?B?UjhoQXFhV1dwOWladzNxRXI5d1d5RzNSQmY5QWNaUDRpNUsvbzVPNmJHZkVI?=
 =?utf-8?Q?pSkkttN+mTGsG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1BGalJhdjA1NWNnWXVJSFF3NlhpMVh1STBsTDBudWZOWTB4ZjdOYURCM1RD?=
 =?utf-8?B?OXg1dlljMnJ4VVdVb3NvQzlERTNiY0RqeTRSOTFOenppbG9IMlp5azgxZ3hN?=
 =?utf-8?B?SUVycTQrYm9BWGVUN0cyajdOMXBDSkVkY3ZNOVErSWc1c1kxRWsvcUE5VDQy?=
 =?utf-8?B?ZVZxVERwQVk2aGhBczkyV2tjbDdHOUdoc1F4MUE3RHNyMW9sS3JBUndjQ2o1?=
 =?utf-8?B?REJGZ0NISXhRRjhXa2JBend2Tnd3STFvRThtNkVLZSt5Sm5RN0ptcnVETk5i?=
 =?utf-8?B?cUdWeElnd3VpaFI4WTlWNTloQ0pNWjBRS28wLzdBdkJySVBtdGpWY1R4YjNX?=
 =?utf-8?B?dFFHSk9IL2tIblZaOG5MRWRVWVFVeU5kRktVYUpVSy9rSmJuOEk1aFBqSGJR?=
 =?utf-8?B?bDNTK2QrbUI4SWV3M200WkZ6WjIvNHFWdTZpTmRYOHlqVUtNNGVCT2pFcm8r?=
 =?utf-8?B?bXM2MXA2M0ZUSGEwYkFGQ0hlT1RWU29tTnhoNnpsb0ZvdVMxRHdOYlhkTGVR?=
 =?utf-8?B?RFNQenQ2OUZkRXdCSFkxemYwOHlvemVLd1NJVzcycWwxREhaZkQzUldwSmhi?=
 =?utf-8?B?dC8xWW5WYXIyVjJlQ3BoVzZzN05qTEZSNXBtL2RYNVlvdWMveGN2aWRPK1l1?=
 =?utf-8?B?K2dlRzJwaU92MlNCZnViY0FYUlQ0ZmoraEdSRkllcUphTWZ2VmlzMHRNYStE?=
 =?utf-8?B?VytaWnc4bFo3M0lGZHhJR2l3anliT3ZuYmN3RGladkl5UUIrZFZQSjBkREF4?=
 =?utf-8?B?LytLeGtUbUlEOGJhajk4QjZDREEvT00zWnVMYkVBTWd6RGN2bUdsUUx0cDBY?=
 =?utf-8?B?Z2lnTlVNVXRicXFwbEo4ZS92V0lSbjZmNEpNMDhURkxkZVg0UXlYOEdmK3Jj?=
 =?utf-8?B?TlMzN3Zrd09DVDY5anFrRVhRMGNVQkxrTWVDYjJqc1J5MHJvNnJmOGxVUmR4?=
 =?utf-8?B?anMxTXlpcURCd1d4YXRjaisvZlBVTklBREtwSWVPS05tWEVkTFZFRW5FVFBh?=
 =?utf-8?B?anVLL0sxVjhUZlJGZzdKNGVQRWtFR3liYXFHL0JoTVFxa1BjV3N3Tm1xbVJ6?=
 =?utf-8?B?QmVEUW1ZZGlPcUx3NU5LdG54ZFdUeW5PZDdKZlBvU0RrYjVzSzFSNk9yUk9J?=
 =?utf-8?B?K3VwZWxCU2ZLV3lIZ2RBMXFTMVdGQ09jOEV1VmVGc1VvUEs0REl0VFMxeWtq?=
 =?utf-8?B?TVFSc3pjZU4yYjJKcUdXcHJweXFlNXNzQUY3eTkvNnIrRVpvZ2VNSkRQd2lk?=
 =?utf-8?B?MTNSU0h6R2Q3NkRtdjFmbTUzSXNXLzJJNFhHdk9Sby9BRWIwSHlDcEdYREoy?=
 =?utf-8?B?cUZTOVNXME1SZk9pelZPL0xaNGJvM2YrWnc3YmNCbXpTL1NibFNZaFdIZHpS?=
 =?utf-8?B?Z09Sekh0WEg3cy9sdTluRXVtanNCcW9lQlovZ21oWnZrR1hlbHBVVG9zZG1J?=
 =?utf-8?B?VXVmeGNWSlExenBhNjlVYnhLTWgySlpjRjRVcHM0enAwVkdvTktaVmViWW80?=
 =?utf-8?B?UVN2SmZsOHR4Sys5ODdsUnJ1TnFlSFZiY0xNVjE5aWhrVTVjdEsyck85RU1s?=
 =?utf-8?B?bEIxNmtRaWZYMGwvRVVZS2lteS9OWUgxRE9VVzZ4SkZJYkhRcTdqTzhCWEFx?=
 =?utf-8?B?QUM3R285QkozdmdTTHRxYXByc2tXWEJ0U242MVFJSjdsU2UwOTZQNThuZHJz?=
 =?utf-8?B?aklzNENaTk9CNjNDQkhRV1doK2s5TC9VcnJ4SHM1aE1rWTJtaUJteXMyeGs3?=
 =?utf-8?B?NE5lblVkT3hNM0hkdlhGb2ZRdmdReGY4V0x0WVBKU3owWjZvYUlPTGx2dzJw?=
 =?utf-8?B?bmV1NUUyeklCK210TGJxWWNxZFgwd2M0dHhlNEltL3UwZ0c5MmhhdUNvMDZY?=
 =?utf-8?B?aVBwcDhGSExwV2hrMVRJU3FIa0tSTUc2WUpRNjhRbDVtNTFwcHhiVWZtd2Er?=
 =?utf-8?B?ZXNBSDB1TmhISldoNFV2SlBxTnkrTW44N283M3J5SFJ6V1Z0ekM5Sm1aVVZQ?=
 =?utf-8?B?NmpRY1E5clVnbnhUUkJaKzAzUVBZUWQ1VUFINkZORjQwcEg2aEJ6MUM2V2h3?=
 =?utf-8?B?SDAzRUIvN3ltZjRtOTdRTERsTUFkZC9WVWwrOUU5TFFyLzZXZDZJTzZ3RlBQ?=
 =?utf-8?Q?Jk21Vp6eltFtSWyQA84KjlqOx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f34d94f-d79a-4ffe-f42b-08dd4a7d2141
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:19:04.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kshmB/RY3nwqyJMjzRArK7JyKavf3D83maq+GF9b377GQPQ0AuC0fIU255SwvQoBgrALiSsOOJ6+92s3mt2GrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> In order to prevent a potential write for shmem_update_perf()
> cache the request into the cppc_req_cached variable normally only
> used for the MSR case.

Looks good to me,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> This adds symmetry into the code and potentially avoids extra writes.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cd96443fc117f..2aa3d5be2efe5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -502,6 +502,8 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>  {
>  	struct cppc_perf_ctrls perf_ctrls;
> +	u64 value, prev;
> +	int ret;
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE) {
>  		int ret = shmem_set_epp(cpudata, epp);
> @@ -510,11 +512,29 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
>  			return ret;
>  	}
>  
> +	value = prev = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
> +		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
> +	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
> +	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
> +	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
> +	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
> +
> +	if (value == prev)
> +		return 0;
> +
>  	perf_ctrls.max_perf = max_perf;
>  	perf_ctrls.min_perf = min_perf;
>  	perf_ctrls.desired_perf = des_perf;
>  
> -	return cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +	return 0;
>  }
>  
>  static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)


