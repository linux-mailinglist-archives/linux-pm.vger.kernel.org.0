Return-Path: <linux-pm+bounces-22766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD6A41521
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804EB16E200
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90171AAA1D;
	Mon, 24 Feb 2025 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4u3WeBa5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431411EB39;
	Mon, 24 Feb 2025 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377559; cv=fail; b=YtQja96DsENoOE9QaPwJZyNaCGN70h52B09hzTRHr/LqrJRBMKR3AL2Alcfw37oiI4wIirKj0nO9x4nd3dVTIKq4to2BJNaUhb5/HSYed/GhOvbdbWrOzY2y7YjQbo6VTAZMeZ5BxRZRzYBDSCCqbzRBv1XwSsgezV/KWZbj9mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377559; c=relaxed/simple;
	bh=ut8GltFENrpcqrBOLWBpCkEgNin3QQP7G99r1ulwACI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XW7NIe8ebEWs8WGLVycS/Wecc90hpuKyZ34mABitbn/LDZTCOG9BBmltTITkbdLrudHJLS3zDgxPiqa6DTvQZNCOhG7sKsVmKuLWkDhnyJYcJoiQLNW6LJ8cv6fuqFNHZr4FxfIJIVrFuDdkwUKZGTzSh+fzKRtzKgM15Fc2hmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4u3WeBa5; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSxssV9qDNMI5EnRY29zHhaBZ7AQvcfJuAKpb8kMZTezVgrnKPMr4mdLSQj9PIv7PM+r92MYhQ8zphH4P5m8eEBj0YLTDBF29rWwK7y/ux+x2PdSQnK/9ESH2LFaYd2VpK4rj6JiNJJGiEAYGBeQFS7loDexARA8u25Y5gjgPYGoPvhlVKTzzcqzCFV0GsrMs+T52KJdogJzCD+dXx747vorZI8Jqp+VdZxBJq1xdldHCzL2/pf0DC9LQk3fyczzDEFKMCa3FmtI1Ukyd6kuxqZx9a0AcncasevLC22aMUfd5l81WJhHhtLUzmAeai3bX9b1n58bN/Z8rxGhTXmNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyTVab6HeXo5H63hCe/y8InWasWDThcmUPzHsakbXiE=;
 b=PKCJcEyPvpk4PNMwi26vZiCrXEzf2WofdyB3XGblpkWcQrYp0gKiLp2El503ls5PeYrGjUeUqW/XNOLe3JsgeTicpRxnvdG+dhqwWu+lmYyZ8dTruX1FwkBOKbxOY2/gMRh6upfh2ppAcdQkgcwhdv+rbgTbaN1tXDc6FyrWagGQ79wM+yhg8IrTSU0a/cOln0mC/GyR0MBqiQfWyC/pM31g4s4bVVQiYWEQjQypLiymgQz2QZ/S2iyt62Lis+3q6UpcZ25N30K1ioyP95GZeaPIwsIy1dYb4t8+8hXxY0pvEx8FhSXfc6lfeQVGh3sItvzXVTb1JSp0eVwfjY+twg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyTVab6HeXo5H63hCe/y8InWasWDThcmUPzHsakbXiE=;
 b=4u3WeBa5GFdlDWveMTvVArXXXu86pthmYvZplaUEu0GmsWpdHouEHtWomV6XkvBYxMr2X7CwpT+t/m/rltyQPK+BhQiWUO1/5zVC8/4GlaF5dEfCuMr099BDn/YdCy+cVEQQH3awSDd1AmK16JaB5F1KQc7QK76yCOxUPSbADyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 06:12:32 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 06:12:32 +0000
Message-ID: <b824c4e5-2213-4858-8856-dc9c14e8f685@amd.com>
Date: Mon, 24 Feb 2025 11:42:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/18] cpufreq/amd-pstate-ut: Adjust variable scope for
 amd_pstate_ut_check_freq()
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-12-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250217220707.1468365-12-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c6f27e-6b85-4594-83ba-08dd549a394f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEhGbHZOV2w0dGpFL2RDMmtLQzZMZStqOEljRStKQStSNGxHbVpJZkZEVUJs?=
 =?utf-8?B?cXZiTDltNjRjdS9BSCtXTWY3akZJbGd1TG9pN28wNnYxL09yY3Nwck0wSWQ1?=
 =?utf-8?B?d3ZWUGZqekZ4UHdOMVQrVzFLNnJ4KzUrRXFlVXRNdExGTmxWSWNpTGwvdTdI?=
 =?utf-8?B?S3FBZGR0VUJJZ2g4STBtNGhMMHY0UGRGRENnemdLKzJHOVRqUGRkSXA4QURK?=
 =?utf-8?B?R3RJYnlCNFo5VFRPQnlHVUNjT2xEckkxaVNjRWxaZmU2cTFTL2t0MzRtYUR3?=
 =?utf-8?B?VE94TTdJWlpqQUZObDh6cFVqb2dyaWdzRW13TG5UNytkSk0yWjcvNUhvaERX?=
 =?utf-8?B?cWhaQ1JJQ2FyT3pZd2UrcGxzWldrY1YvbkdneWdJYkNSV1RCZDJOM0ppb0J0?=
 =?utf-8?B?Q3ZtUEtBQ2hOMlNqek93REhGV1RsSWpHNlRHNVd5aEVuMHRQMC95cW9VTFk3?=
 =?utf-8?B?OExLbURXZXpoSjRKSWtMS0FUWEcrQW15UEtGR2NwdFc2M3p2SU96NHlJZWla?=
 =?utf-8?B?L1pYMis4RE1hMUhaaFYxcUpxcG9OTXIweDlSUTBHWGVGOVRMY0t2TVlJa0tU?=
 =?utf-8?B?U2FITmdGakZnUWJNOEx2dEpGUktwUkJ4M1dkMTZzQkVaKzZrdjlBSFVORUFr?=
 =?utf-8?B?ekt1Ym8zMUJ4NW5pREZKMTJka3J4N2MxUGIwSmhvSVdHZVBQZmlCd3VCdEpV?=
 =?utf-8?B?bEtKSnJTVTJnaG1VNVFEVlhiMnJxSENFM2xDY0xpdkVZQkMzS25MMk1NRnV2?=
 =?utf-8?B?RkF4emQ1Q2Z1L1VOWFY0dWpTUTVJN2FYVUZuRXJPK1g4L1NRRGVoTyttcmRL?=
 =?utf-8?B?dUNJaDEyS2dHSTlzaVJVRi9lM1ptTHV6T1pzWUxIY3o1MktiN2xJQSsyWWF0?=
 =?utf-8?B?cnhUOGNpRmY1ZUVHUE8rWi9vWC9DQzFIaC8zNzAxNWFVczBzakc0bmcvb2s0?=
 =?utf-8?B?ZE1ZU2JNTDBzQXVtOE9SMkpnSmxNNTNERDE0RXMza3hkdFNmcTJUWnZuRFRN?=
 =?utf-8?B?ZWZmOE9TcG5NakhadUEwWUx3dFBPNmZ2V1ptN2lza0NBSkNEQVNXak1BL3VR?=
 =?utf-8?B?cmdVSnZZbHpOeWtLeDB6WFgyY2JvLzlCZ0JzWU5pQ09RVm5sSDRNVUJ0Y0M2?=
 =?utf-8?B?TFZhVC9LZTNJa3BHSitya2hkaU5Vb0hwckxTNmZaWTR0dnNkaVNjR1dHL3Js?=
 =?utf-8?B?T2Jpa1ZpVGhobFFuUEplUnFqYmRxYjl5TmZKQjIvTVRDTWxzQzQyOXpzVVFX?=
 =?utf-8?B?WFZrZWlrSk9vdXU2NHFaSzcva0hnUzN4b3ByMENaVWRmTndQNUVlRnZXZjRP?=
 =?utf-8?B?L0ZUR2FsNHQ0RitIcWhhNHhoN0NRcUlVUUF6VndPOE9LaUF1MnM4ZWdFckVE?=
 =?utf-8?B?K09yT0lKRmRyL1pVOG96RU1NbVNkZXlHNzhYT01OR1B3QXU1UmNmdHVIZHFa?=
 =?utf-8?B?bkNrQmJ5VTFzbXdPNFFrTFVETVNMTWJNL21XMGRvaG9mNCsvbFRXblRaK29K?=
 =?utf-8?B?QU5jRTZVb2FJLzB3clhMRVo5Q1hvUVJOQUNhNm1TUDBncWdzU24waFZjdjNO?=
 =?utf-8?B?VTEvZUE4V2lWbkdBeGVDM204eFVMcUUzZGlJZEY5SlZpR3NmTU1RZFpEMit3?=
 =?utf-8?B?RGIvOTNoenNPNU5RdWpnSWtmb0ZCQ0xBSWRXK09aRHhZZUpOZVd4RW0zU29V?=
 =?utf-8?B?ZC9HNGNodGpMN21NSVM2WW1VMkNDcmFBVEV5RGM4N2EvY3V1c0k5cUQyTDJB?=
 =?utf-8?B?cDlCRXFiVnFFMXE0MGFhNHZrTVVPVjVwS3N0djc2RlNOdnBuamNsWW9mTVNp?=
 =?utf-8?B?U2xMTnl1dFloaHM5M0RQRWlkenBzY1VqTk9IUmpaNGliRkh3OFVFM2F5WnlJ?=
 =?utf-8?Q?zzi122XBN1Htv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJCNExuclNzeGJqMTdFMXVEekRYOXJnU2ZvSWQ1ZkVYaDJPcmM3cFdJOENk?=
 =?utf-8?B?S1hkMWY4UzloNW9ISFp6Wm41K3hlWHh0dEJlQVFTdVYvNGhSRVJ1emlKZU1n?=
 =?utf-8?B?S0RUYUJBT2k4QzRWSERqUy9NMUZPZDNINHdBUkR5aTVQWGUrNExMeTlkeEJW?=
 =?utf-8?B?NzhhcENOSGNuT3lsdHVpSlZkUWJTdURia0JHdjY1RGJ0MkNoWDhnc0NRa1Fh?=
 =?utf-8?B?Y2tITGZCOTR4cnJNNXhtV0JtL3RlQ28xeWxBTzFYWkE1QXdERWxORmNJMG5D?=
 =?utf-8?B?VmhuQndpMncweElXRmkreGZ3QXEvdzdUeUsxUnJOMUxuMTYrVEVKNFlTVFIy?=
 =?utf-8?B?RS9BQkl0RlFLK0gwMHhCczJNMTBzRWlZOEwxZytmUW9OOEY0RzMxL3JpWXJB?=
 =?utf-8?B?UWgyVFRDVDJDNTZHOExrQVdKdmNSSS9mOXNGYnppUiszWFFNVzM5LytlaWRX?=
 =?utf-8?B?N2FoWElDNWo1eGpmbGZmN29sY2M4bEdaaFFvN1VtcEpGWXBMaSs5cHQrMjA0?=
 =?utf-8?B?N1ZKVFp2eFVRZGFPVmMxRENId0dvV2RRbE92NGZGMFp1Ti9DSUl4bDhCb3Z3?=
 =?utf-8?B?SjRVV1NFQzJrb1Z6V2luYXJneTRUbkNQbHA5V2Y3NkZ1SDNGaUJZNVZRUzBZ?=
 =?utf-8?B?RTY2ejFnQ1BPV0VtWU55ZVVBU21aZzJVaDNqSjFLU2lLYkVWSEFZQ3NRQlNq?=
 =?utf-8?B?VVhyNGkreVJjeXltV1d5anBqdWYzbFk1bUxZakJqbTRyUWpVeE03b3VJR3Nv?=
 =?utf-8?B?dzRQbnBCVUhpZUtGYWFVbkg5b0ZxUVAvZXE1dko0UTQrS2E2bVI0aDRYQWtN?=
 =?utf-8?B?ajRFdU83UzBMZE00N2tmdFFDU05kZFp5Nmx2THBwekYrK3BZTEJVL0RQUHh6?=
 =?utf-8?B?bTVIbWdqaWlHSTNHaG55N3g3UHhVUWpvaC9MYkx4ZzFIcnpMVmdDQlRXZVVw?=
 =?utf-8?B?dng1S3pMamVFdWlLc1d3RXlMbUdhaHIvZHg0NFJsWEFCOVZBazRwMHkycTFn?=
 =?utf-8?B?TUZrS1Q3dXNUdVR4WHdKaEpFYlc2bEsyWUFuVTJqYWpDcUl3RVdobWRROENP?=
 =?utf-8?B?ZzdwOTN5dVpxdjB0ZVNOTGtOUmRIOStwaGtPRTlucjlsdnBERk9kUDRpaC8w?=
 =?utf-8?B?U05kem5TZDc2aVdnSzFlNllrZlVBRlI3cEY3QVprbHRwRHpBREpwOHhFOGtk?=
 =?utf-8?B?di9hYU5Gbktqd1duWEV4NHQzRWE5VEFNVjhsUzYxUmNNYU5XUmthbnJNVHhR?=
 =?utf-8?B?UEdjTE1EazhUTS9zRk03a2hoYkJzMjEvZWtXUG1SalQ0dTU2L0lQeE5vbjdo?=
 =?utf-8?B?YVF4VUF5SXVVQXkvYjNIdTlNaUdXZUxrU1pRMWtrWVhyTjlVVnB5WHc2cnl2?=
 =?utf-8?B?NWs2UkVWb3pZT0tFNDFTRjIxYzZsQjE3T202N0doNkpnUUV1VFp4RjV0U1Zr?=
 =?utf-8?B?cVFyTjRqd0dYRDZhWnpWUmpjTjFuRnBqMTVMeld6cDQ1REU5MWJBVlkxWUti?=
 =?utf-8?B?VHE3NTlpbFhBWGtveHdrTzJxZVgrSkpUVjdHMVNNWkZLT3EvWVlUQWx5MDFy?=
 =?utf-8?B?S3hXOVgyaS9GQ2JINFhMeDNUM3RMMkt0THVrdzNDSTZUTTFxbFFUcFVtYTl2?=
 =?utf-8?B?ZDhOWnlBdmkxZUg4S1Rub1pObFN3Qld5THhFYWhzWUVOclorbU1FcDlxNE0w?=
 =?utf-8?B?eEtjdnVITGcrcU9ORS9yUXJDaXM1U2c5VXpwTlNGbjQ5UXZhdW56K3RyUmtX?=
 =?utf-8?B?c1BDaFJIdmw5UUJEZ0hJMXRMZ3hEdStBSkFPS0FLYUt1RFB0Uys1bjdpZ2F3?=
 =?utf-8?B?VVFneVExMWp5K0E1N1ZscExhNGJNZ0xHMXBtT2pvRG0vajFNQkQ0N2RyUjh6?=
 =?utf-8?B?SjBZdmJoWjdneGx1cUdlMUxDM0pxeFI3QTdBZDUwSDJZSm9tdk9mK1lFWGtO?=
 =?utf-8?B?TDBjMHZha1BldGl0TkUzcnByZ1JkZHFXMk1lNUhXYUlpZ3U5ZWhkdjUxbEdJ?=
 =?utf-8?B?UWhyZkJudVE4NlpNV21SZHF6ZjFwVE5sUnVwdXZLTWhUTFBiUUNoWEMzR0ZC?=
 =?utf-8?B?RFFyYzV0UG1SNGZLV2RRWTN2bDBFSVlKZnhqaWNNcEVDVXNXQ3NWaVcwK0JW?=
 =?utf-8?Q?ps+uWs0g3UWzwV6iLgaL6/4gE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c6f27e-6b85-4594-83ba-08dd549a394f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:12:32.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFdfW+w3nfEEHJ1s4CjXT5UKUXBmcbBWiWIV4+Q6rIYRcKqKYVLK08IdS+JNkcpmKde8uCKbOYx8E9BsGKGdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

On 2/18/2025 3:37 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The cpudata variable is only needed in the scope of the for loop. Move it
> there.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 3a541780f374f..6b04b5b54b3b5 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -186,10 +186,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>  static int amd_pstate_ut_check_freq(u32 index)
>  {
>  	int cpu = 0;
> -	struct amd_cpudata *cpudata = NULL;
>  
>  	for_each_online_cpu(cpu) {
>  		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +		struct amd_cpudata *cpudata;

I think we can do the same in "amd_pstate_ut_check_perf" as well,

With that taken care of,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)


