Return-Path: <linux-pm+bounces-21774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867AA3034B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 07:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC2B7A20BB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 06:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72041D5ADE;
	Tue, 11 Feb 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vmdOXl+l"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647926BD8B;
	Tue, 11 Feb 2025 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254581; cv=fail; b=YtJi2lDHGnx6LSaCg5hLRhjmiXWfUu0BZiouUg8Adq5xSK2VOL5iPqn4jZ1pKuL78uhhF5qWTyzm9CRddd/s6X5/TI6wk7KMtZb33w3HNq/sK0znBFYFNxcWew5puGfmxtrN0MLWEckVkkFCWZqHvQYIMTshSgjoLz7uNWehVDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254581; c=relaxed/simple;
	bh=GXULRMTi53KqnX/CRmsPZe9KKU/ytr5lbt/K2IVNu1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmzQ9xr9d6gZ2fFfa4jL6oCOMh99PnF5OESorRLMdfOue34hTn6PujxJzhXK02mYIy7ZVLwrbHb7B2MxmpxjkBQgem+wS1s/HvBTYHX0pjVh2hHNywCCd8oGUc/Z5OjX+L2WUrXM7g9nx6zEqxXkMnB5nRrZJzR7nz+Se60y9d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vmdOXl+l; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA2AmCAfUh2JqthDjE+xJrGXoXz8kd7UBen85Y4jEqr/yDiSIy3dYXjWO2j/X3Z7haus+RUIQI1tYuSmDl2o72GhY0R35yn8maXsEDKTMFxLy6N1+kTGBSfbafAwehaQEqpHJiNv/NMGMxKNhGdyvWqvs30qqgAUB8Zq6LDOPjCBfwhACZQX5/iOOe58ZzWh1J1MT/eUPcdbvSKPrpUjtLVRsdaUZ7LfXT2outkMoVyMMMpZdoZC4jP+wbMOLYPlSvEihp/aIzsKmb4A8exL2BWELk31d+14vh9b4MAcU8QjJVqJuOvwwnoLJ2bMxIsRJYR+BF4y2Kv+Hgf4Pk9GYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVw8xPFhia42Aj7rDgV7NNygCyFD3vc+al9TZewlgxg=;
 b=MLL0t/1DwMiVrNH8WiQRDqG5f3pexalh3iB5SoCmBFJ0QGqlNUI+pD0PXyheuPCY4O3WPbzmfxAtZMPdgEAHu6GMVvCNArsPDfLqjRrNzbH/Z+XAqhlbsh1eAbBVijR0zQnxQnGfnN/PULP8eVqW78GGVG7Xh+aFf3uOQ/1Z7i313b+H5upeKcRw1vStPQA9YLTxd8Y31L9j1kQKbpPQ4RxKkB1FKdJ/w9Whmuf0SxisN8M4DrM5Sn+qQ9D59cjjFlvIDTvM8t7OapuEns3dFW4ZainWg9hSnUstfmIK/dKh/3XElQuDm9rfjqLLNHRTf+0n3LTGLKx/YXwtPgFGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVw8xPFhia42Aj7rDgV7NNygCyFD3vc+al9TZewlgxg=;
 b=vmdOXl+lGOmcVvM9X3k0zlYmprcHYRfAa/Z4icYPIIOx/3gyQJuMR/HAr1nUXCr3h8z6qaajxu5TGGrdm5WVUpdIW7AHAMuEepGHx5HA5BgGjSDU7z2pagOXj3vA3nxgbGdAM5GeTEv020WQzDDSVBbQTPFlDU/pC850OWFCD24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 06:16:17 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 06:16:17 +0000
Message-ID: <21250cdb-e398-448c-be08-e9b3778b3771@amd.com>
Date: Tue, 11 Feb 2025 11:46:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] cpufreq/amd-pstate: Replace all AMD_CPPC_* macros
 with masks
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-8-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-8-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4a) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 550643e2-3404-47c9-c2ef-08dd4a639842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWpjVGNtclR0c0xOZXdiZ1RRY3hJY1hHbEt5N24vZTV2dkgwd2VNcFRRQXdz?=
 =?utf-8?B?bEU5MHZmWU1KRlNUemhWZHlQSUdtWVBQY0l2RG5xOWhiSjg4VzZrcU42cFpB?=
 =?utf-8?B?TWJnaWsySTJoSXZyUGxvYVpMdGozZjRScjZYeWxmSTNMMDlQOXJLcFNISGl1?=
 =?utf-8?B?YnprdzFSWHJIM0hBSjVSTm1adFlrQmVHMkpvSkVXZWdjN2JkTUJKTllxSDRX?=
 =?utf-8?B?b2JhTG16b1hwcUdHMlJkMC9RRmI1ZUpOc0pKZ2FpcUlvRzUyT2doeUVLU2lL?=
 =?utf-8?B?TEVPb0c2RlAwWXVKbUZDTCtLaml2UVREbWN1djhURCtZWXZhak05dStJY05Z?=
 =?utf-8?B?V1hyS0x5eHN3RjVMbGlGRGFwVW83bFhxc3p5Q1oraUtPUG03VE9pTlFEbnJD?=
 =?utf-8?B?NHRrTkJreFhaZWFGeGI0UEh2SjhRTk5FSjNOSi81TUNxVjVuREsvR2tzVE9W?=
 =?utf-8?B?ME5MRUw3MllGR2hSblJYVkk4eGtveTh2N1VVZkFyRDdkVnRNTlMyWjZHRlY0?=
 =?utf-8?B?MXFLUGlMZkFSTk5BdHBqellaQ0JER0lUWnBoSWVramlnWkhzc3NiY1dUeDEx?=
 =?utf-8?B?TzFXb0huUzhuWkMxM3ZSNUJvNXd3WFhGQmpodGVkZHc3VC9HWnJZOEJkcjA4?=
 =?utf-8?B?WUtoY1RWN0NZSVBVRnEvNDZQNFM0RkJlVGJsRG4wL05oV3hhejlZRHovSTZr?=
 =?utf-8?B?NDFVeEluUWcyWFZ0RWV6TlFjMzRtYTFuSlhHOVhvTmdMd2IwMnZGejR2T2pu?=
 =?utf-8?B?Z1hQeWxWZ2pBeWJudm9SeXFIMFNTWklmWjV6aHBOVmt5WWVTR1E2S3BaTTdk?=
 =?utf-8?B?cWxZMW9MMFNnS280VGxkUGFWS2grZUJ4eWl2Wkx3T2YyS2pTRFhHTi96SThv?=
 =?utf-8?B?NURXQ0NoWDg0ZDZFaHZkL1hsWXl0dG9sbFgrSjR6eU9zUGYwRCtob0lyTUpE?=
 =?utf-8?B?bXhrZE1TM2JmMWxqQnMxemZEaG43UnU1UWpPdnQwUFE3d3lzQkNoWW10TjNw?=
 =?utf-8?B?OEZSclVoOHpuRDBzaTJvYS9YQUhHbWVSY1FPK2pJRm9tZm9SR1p1L3VjdzBK?=
 =?utf-8?B?b1JnRTNENGhLU000ZU5Ca3kxa2tnaFljTVVSUDZuaWJkcmJMbkFiZXEvVmVE?=
 =?utf-8?B?Z3JqMjhkWDZQTCs1c2gvTjExbDg0Z1NXcEZyN2RNRE1HdGhMck0yOVBzOWoy?=
 =?utf-8?B?bVVFeXRLa1owOTAyTXlSSXp2azBaVU84UWM2MHU2M3B1U0xaa2VHQ0VkM1lE?=
 =?utf-8?B?N0NxeHRGQi84cE1PK2NYaWRLZkVJU2V1VjFYYnQrOWQwUnJaOTlCZ1E2SGg4?=
 =?utf-8?B?Q0V2T015cDZXVWV5OVdYQWppbzlXRXpUazNTQm5aR2ZGU1JUakxLYjJIVUEz?=
 =?utf-8?B?MVdhNkFZM25kSEpQbGp6UG1Ta1RXSGJac0xZWGxCK1BndUtIS05FSXJWRys5?=
 =?utf-8?B?Y1E4eUJDMGxDYUFtSEtBdnZuSkJQSzg3eHhORHZPNmlpZzdRZGV0eHhrZUpP?=
 =?utf-8?B?UWpVbXpVUnd6ZDlXY1RDLzNLbmlvTlZZUm5qV2krMVl2dVRrRlVJaHpBa3Jj?=
 =?utf-8?B?R1V2SG9qK1VnUU9rUDM1alhZb0M5UmorN25IVlZUUmhNTk43T25ncDNYeVVp?=
 =?utf-8?B?ZXMya05kalkyaXFLcVNKRmU2ZDJhSXhCcHNQbjBTT2k4RzUyendtRUZEWHBj?=
 =?utf-8?B?cUd3Y3hjcFhBc3lkV3Z0dDY0ZjhBZVVBRG9nT0VvYnAvVGhvUk92WUdoTFNn?=
 =?utf-8?B?T2JRZCtKbWU5dUhER3lTTm5sVStyL2poQVgzaThQZUt5Tys0a1FWYndBbkFR?=
 =?utf-8?B?eFdDRFZ1NmZDT2Zva2Q2MWVuU29BbTcwcy85OFY3ZXdkUlJsaHJvWE8wYWFM?=
 =?utf-8?Q?nX2SauxjXcbiI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2djOWNUSFRtU1AybmhKYkp0cmtLMjFVZzR4TkdGcUpQUVIzdmxUZFFJdDE0?=
 =?utf-8?B?MWtXN0p5dzJOOUFPR0N4R0IrblZUYUx3ZklyOXpNaUZIaTlmUlhyUGNpUGlw?=
 =?utf-8?B?WVBoMThXeFNuQzR5ZXlVYkdOb0p2bGtXUjFyR2VKTzNiOG9UUWNnMWlyN0JG?=
 =?utf-8?B?cDlMTjNJVWRsWWRURExsc0pFM2pqQUdYOTZGVFJ3YlFuaWlRUTFFMEtUek9T?=
 =?utf-8?B?VnZ1QzZoZWhidEhzVVpINThyRHNtQnhvM0ppV0tlNDRjb2RyTEY2RTE5WUhR?=
 =?utf-8?B?VEU1SThKTGxOR1VWT2hGajRiV0NFa0JHYW1HL1FRQ1ZWSDRLQVp0NUdBQWVR?=
 =?utf-8?B?cW1xOGJUK29RY2RZeTloUXVhWnlhMGRnUnlpUVNYdGJFb2JGblVoMXJaRzg0?=
 =?utf-8?B?WG9UeFVidTZiS0p6QThQTmVLWTNDRFRYUTF4eTNDNnc2WUNXdlVRbUIwMHR4?=
 =?utf-8?B?VWIxMlBuWVBXcG5EWUdYU0RybnJpYXVpd3U5MXBaN3BMaE5EeXlTSFlhZnBE?=
 =?utf-8?B?WVcvM2p4c3NnK3RLYUJIK2pJU1pNRHA3eFdlTlA0Rm9qSnBEWGt2TlkwTjYz?=
 =?utf-8?B?c3V6ZUY3MTNSVy9SSjFZNjV5VzdoQUF2UTlSZnJiQ3ZCSzg4M3B5OWhLaCsx?=
 =?utf-8?B?U1dpaFgxdExtRjhVVlhtVDVoanQ2THlTNGUzNy9BZWhVQ3haUWFmM0JyNnlj?=
 =?utf-8?B?VXUrYVlEZS90YXdSQ1BpUHQ2NzlVanJNeC9kOWNPcXJNTzZQcHV4SjN0T1hQ?=
 =?utf-8?B?eXp5SGE3aWtqUXpycEhOcC8vVHpaUCtPUG0zVUwxTFJaZFNBdDg4Q1dNcUho?=
 =?utf-8?B?ZE5qSlhBakNCa01GV3VQaXlKS0ZGUjJOdld4WG5HQzZjQ09VKzBtOWJ3RVFQ?=
 =?utf-8?B?emRFK3dHNzNWeStzTk5HWmRXMnpHTjVBRUF1YmEyTDBQYVVzbnlaRWhnN3lw?=
 =?utf-8?B?NTdaOFVabG42YlJML29wUEkyVTY5ajcwTDNQSFNYV1MzUlAzSng1d1hyWG13?=
 =?utf-8?B?SWFYM1FXaXhOdEpVWEtRdEVlNHlJaGtxaVFGcU9WYS9DNUwwdjNhNEY4Y3hJ?=
 =?utf-8?B?YnBFOUdGanlYTEdpZFNkU0dJYWRMb29yVVlkc2xDWk5ELzV3SGs0UGdiWVZP?=
 =?utf-8?B?UzJKWVhRc1ZSeVFNcWVsT0JIR0pjSnhYbHd5M2JLRk0yVUJQcjJIZlRWT2lE?=
 =?utf-8?B?OWtiMmVoaHp5eVdva1ZGU2s0VGloWFBRaVpJeEVWUVNmWnRUdWVlM0p6VW8w?=
 =?utf-8?B?bXJVNE9abktqQXNXNTYrZnAxa3ZwVGVJeFdlL1pWS2RIdzBYdWlTdzluSE9I?=
 =?utf-8?B?d1JRVmZEYVhOK2o5TWdENE9TandBcTJoT29VK3oyekNJdkZnM2lUSGJXZUtE?=
 =?utf-8?B?eGJaOWlYeERpRG83bTlZb3lsbGhSbUZkYVd0eTlOMXBTM1A1cUJ2WWovSVdD?=
 =?utf-8?B?VHhiQlJ4S1c5dDF5NTVSVmsxdlRkK3RjUTg1cVNFS0cxaWdKWDBVemQxTnAv?=
 =?utf-8?B?bENpdENYQnF2aFcxVkRxMGNrMGlPc3JoMEZCTTU5MS9lRzlraUh1UzZMdjBD?=
 =?utf-8?B?T3NwSzlLVTY1cHU2RUNLZis1NXBjaENlV1NNRThGcmFUckNpTG5ncExmeHlo?=
 =?utf-8?B?bVVvVk1EZncrOUlMWjZ2cWhWVEhXaDd0NHBqMlp1Zm9YWFlOU3JyWUJEZWpi?=
 =?utf-8?B?ZDE1VFRPcXEycEM4V0g2dG1FNEVtZEYrMzFuK04zamYvTWRGRVZER29hUDBv?=
 =?utf-8?B?K05ZRGlyTnRwSFYyRkpueEhITy9lcWZsRVEyVmsrRitLSWxGcWNINW16OU1v?=
 =?utf-8?B?cVd0TXJvcUtQMy80eVhqaHpsamhOeFA3TW4ySEx5MDN0ZU5rc2RKWjZCVEhZ?=
 =?utf-8?B?RndQdktXNFJ5N2RQT2VvZzR5c0prb0RlaGxzQk40VFd3cmpLNDA1U3dmN2M0?=
 =?utf-8?B?ajNrR3RGN1IrSVM2SFNUWlAzVER6ZUJQZmRIOHQ0ZVNJdXI3c1V3anhqRGhJ?=
 =?utf-8?B?dUdxTzcrVTlxSlA3MElPZko2dVMvSFpFTUp5UEd0SEsweHNFNjgzQXUxaUlB?=
 =?utf-8?B?ZGk5VWV2UEU0RzVLam4wS3RFclVkZnlrWlVXT1FHL0R5dDVKdmpsaitoR2J4?=
 =?utf-8?Q?6mgD5rEzcxAD2uZ7oAUN7GNn0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550643e2-3404-47c9-c2ef-08dd4a639842
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:16:17.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: py4/gwQKQzhg98SzQmXuXE/VSOLpLTQV4F1eQpEUt39MYag0o+rAou+tE7p8n479+Fj+/6lg2zEiezxEc0cngA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Bitfield masks are easier to follow and less error prone.

Looks good to me, just one suggestion below, apart from that,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h | 18 +++++++++---------
>  arch/x86/kernel/acpi/cppc.c      |  2 +-
>  drivers/cpufreq/amd-pstate-ut.c  |  8 ++++----
>  drivers/cpufreq/amd-pstate.c     | 16 ++++++----------
>  4 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3eadc4d5de837..f77335ebae981 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -700,15 +700,15 @@
>  #define MSR_AMD_CPPC_REQ		0xc00102b3
>  #define MSR_AMD_CPPC_STATUS		0xc00102b4
>  
> -#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> -#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> -#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
> -#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
> -
> -#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
> -#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> -#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> -#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> +#define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)

How about  AMD_CPPC_"CAP"_LOWEST_PERF_MASK and

> +#define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
> +#define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
> +#define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
> +
> +#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)

	   AMD_CPPC_"REQ"_MAX_PERF_MASK, just to indicate these fields 
belong to which register? But we can keep it as is, if you think it 
would be a mouthful, I'll leave it upto you.

Thanks,
Dhananjay

> +#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
> +#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
> +#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
>  
>  /* AMD Performance Counter Global Status and Control MSRs */
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index d745dd586303c..d68a4cb0168fa 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -149,7 +149,7 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>  		if (ret)
>  			goto out;
>  
> -		val = AMD_CPPC_HIGHEST_PERF(val);
> +		val = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, val);
>  	} else {
>  		ret = cppc_get_highest_perf(cpu, &val);
>  		if (ret)
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index adaa62fb2b04e..2595faa492bf1 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -158,10 +158,10 @@ static void amd_pstate_ut_check_perf(u32 index)
>  				return;
>  			}
>  
> -			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> -			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> -			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> -			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +			highest_perf = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1);
> +			nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
> +			lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
> +			lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>  		}
>  
>  		if (highest_perf != READ_ONCE(cpudata->perf.highest_perf) &&
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 71636bd9884c8..cd96443fc117f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -89,11 +89,6 @@ static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
>  static struct quirk_entry *quirks;
>  
> -#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
> -#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
> -#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
> -#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
> -
>  /*
>   * AMD Energy Preference Performance (EPP)
>   * The EPP is used in the CCLK DPM controller to drive
> @@ -445,12 +440,13 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>  
>  	perf.highest_perf = numerator;
>  	perf.max_limit_perf = numerator;
> -	perf.min_limit_perf = AMD_CPPC_LOWEST_PERF(cap1);
> -	perf.nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> -	perf.lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> -	perf.lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +	perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
> +	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
> +	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
> +	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>  	WRITE_ONCE(cpudata->perf, perf);
> -	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
> +	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
> +
>  	return 0;
>  }
>  


