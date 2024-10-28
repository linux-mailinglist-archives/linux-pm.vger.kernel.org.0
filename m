Return-Path: <linux-pm+bounces-16554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1759B23DA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 05:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBD21C20B20
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 04:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC39C186607;
	Mon, 28 Oct 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fybZ7emZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7987A59;
	Mon, 28 Oct 2024 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730089648; cv=fail; b=Ey8GlzT6Y7XOlXeamncIC9tOnEWcbP7xE+NdwRQbE4oMkapZ+gMLOrNptX8UckrsiTn8TSMWLS7Lox+Jyna1QVVHf2T5oiTVML+o/ow42qMy9pRh4I06MGjbguI0gIWNDBPQM2biNcCCO7Bq9ggvdaC8twNh2ZpdXTe56oT5cc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730089648; c=relaxed/simple;
	bh=4pNcnHDPkm9SlDSbwpn8ul9tl/9X1BVu/F6ietCuAJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlTmspBWEsKpC/xf8jxF1l61ubroF9WrcP/aYRVKX8KO9l6K5t3mFXhftTPaLyjdi2g334ykPQF8TZFZGIdBZu0L0iv26F62SGUCegHaQKB44KKyC8IzH7J4rD4hapj/G4eDxq/8oygihnQt3am6VBcEtkPsiSGfYr2FkwRg68U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fybZ7emZ; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFgId//6KHEhsso5m/lnkO6ubzWANwOrkL2ttj2bbDJkq9AT32rpJvdksN4UTZTfIEyqPlJmIxtL0+KTubM6auJ5/QCTgwIGkjDzp11T/Grb1FU73VVQfEZeegdGC5vJtZUuMeVXt4HAj7jx50NQJYp+OshigJZW10jV98a9gj+F1BmDgBGvV0WpaBdW/gDz0xUHBYz2WzFQk3f66IJNKRnH+xS6VrR0B8btH87Vrt2SGWE1sIeep7PEizUzyG+7ZcVA1D1AH+HUuxDjBhGSJ4CwBuzbwRenMMS+n+neuMLshwMuc8TochZYrylSwVdyVyKpj1K8Po8Xmh+EhdQnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UUsRfazb7iAzZOkSii/W0MaE+ErwQVWQq0N/55lOmg=;
 b=zAUg6ymDq3fPbbJWVfsYMvf6Juu2d1m9GJWXSY5e5snTcunwJh5k7foIKCHiXTJ4DMUz5yTwnkh+roO/ZEtStw0xuTLmun18aZDuSB22mFe+SxTHWhjSlNcDWaiEP+e84uFMYJDtftIi5HKoNKzKW/eENcggUMYiXtkHUmc9phnc/BZ/KlHuilK0Y+TrMh15UmEM8JD0+DAKgCgBQqnyneT+cGs82kewf6mYXjcBNIh86gLuftuq6Tt2v5hgeYWGd28DRGBWGSE2KcA7ggpECHF9oju3PQRW8gsjkCoeB3L4vF7NLOb0naACwBqAklKPgNjCVAW5wure3/6Z6hihbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UUsRfazb7iAzZOkSii/W0MaE+ErwQVWQq0N/55lOmg=;
 b=fybZ7emZCdcYOAymQtfDrCrsmnLExI2TlTUIPmSlkevc3VhIIj7nfErq3BxUxqsucNWXCkInFJqNVMJrSE4MRP9uXqjc4k6dI+fHsgdrbGfb0rvKeh9JFCn1gCp2lpJ9Sb67N0d40M6ITN+hNW5ZYESFyPtModL9eTuH58zi3tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 04:27:24 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Mon, 28 Oct 2024
 04:27:24 +0000
Message-ID: <145ac73d-000e-46c2-818b-d0d5deefd37a@amd.com>
Date: Mon, 28 Oct 2024 09:57:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: Register driver after static call
 update
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Klara Modin <klarasmodin@gmail.com>
References: <20241027122612.749674-1-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241027122612.749674-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::23) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: c945ead4-216c-4d6b-e83f-08dcf708d22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE0vOERpL1QvdUN0T0lDYXJycnh0dU12RHl1UDdEbmJ4M0FYV2RhamRYMGM4?=
 =?utf-8?B?SzNxRXV6MWtuQlowa2d1NWthS09PbFMzUnhBa0NrOTJDTnVBUE1MVk1QanZC?=
 =?utf-8?B?dHFZWG9meTJkTndVTXhwWWljekhVZGU3VDdLK3ZBK2swamd0bklBbURtS0VJ?=
 =?utf-8?B?NzVaVERMZ3J4TUdzUjBFMVBicmZaUDZoL1FHdTREOG96cTZIZTZ0MFZLaHpv?=
 =?utf-8?B?a2pKUGFMRFRJb3hqaWhmanBxQUJKMXd2Q2pQOUVubi9uRkFGOHlJeC8yOFJR?=
 =?utf-8?B?R2NlYzMvMWQwMzVxMG9jUUN3NStvSXpKcDVraERHdUR4RytYY01KK1gxYlhQ?=
 =?utf-8?B?UVplVkxvdENCLysvVGFRSDJlSHk1dkxicWNzNjIyUmdZeFNocVZHbng1Y3RQ?=
 =?utf-8?B?S21ONzZEOXlhYWYzdmRiVmxFcWJvbkFXOTF2eHIrV3VnSFVXVENVWjRlYi9v?=
 =?utf-8?B?RUxvaEdIcTlXY2htK05lUzFKL1M3bUViZk5oN2tYU3owT25pNG9zOHhSOVUv?=
 =?utf-8?B?Y1ZBcndrbVhhNjNpUzQySVNEMkNWaW12U0FpdnI0MGowSU44S2NzUnlKZDd6?=
 =?utf-8?B?QThXaG1STjA5VEpXUjVKbXZNWXJvYWVUSjRTODNPV3UwbHo0ZEFqaWQ1QU9M?=
 =?utf-8?B?ZWRIMm43Y3dsd1prTmNaOVZrcVYrdVd4Y1UyUzJoV1gvZzNTZXc5RGhVYTU3?=
 =?utf-8?B?Yy9pMVFTaFpRUnMxeERBdE5EVFVxSzlTTXg2T014bzUwcWVWKzRTS3JKa29k?=
 =?utf-8?B?RWNZeHZTTU5sb0hwZVVFRlZmWkQyWWtvZngyOGtEb1pzc0txT0h0aU1kbDJX?=
 =?utf-8?B?REdReDlQZlZNQTlWT1lrRFNUR2hTU1VrQUlaVGlaSFErRjR0WHZxajdUVU5U?=
 =?utf-8?B?ZkZFNGthME9RR3dMWCtReFlDNDhkUDVJU1loNTZkc0lpbExJU2dldzU4Q094?=
 =?utf-8?B?M3FNSDJ6TVBEQmtMNnFUajBaSDYwOGxWVFVjVzFWMkFBallMVjBSTERGdFph?=
 =?utf-8?B?ZG1NUmd5R3V4T1dYajlaM2hrTEdRNmxPRGxrcTdZakQzeU11OTJIbEloTmtP?=
 =?utf-8?B?WXJaVitJT1IyS3BHRjYyMTNVVDZ6VExUNkdweHUxWU9ybzdpdXRpOEl5WG81?=
 =?utf-8?B?NnhudThUOTJEeDN6M2xJSHM2RVNxOXI1blYybGZpcGFqd2FCc1h6TGdHL2gr?=
 =?utf-8?B?RVI1eWdQdjR3ZlJuUDZlRGlPNTFNVGNpRUEzNHp4cmdqbUY4a2xiajIrQ3hl?=
 =?utf-8?B?cEIyL1NiZDl3V3pualE4bFBkUHhQM0RQMkd0Z3ZERk9xZTJMNGNHUlRaeFB1?=
 =?utf-8?B?WGxkOXMyQ1dCcGFHYVJYaGtzVjR4TlpMTUpkZHIwbmlOdC90dXNqUDgwUnhM?=
 =?utf-8?B?SG5USGxTMHZlc081S015b0NsQzhxcEM0WDN4MWRIOUdnMk9DSVU0VUFJdHJi?=
 =?utf-8?B?TkkxZ05jN2loK1RJdHZUa0FpYTZaSmw5Z2plVnVjNkh3UFVLUWJIVm1VT3NC?=
 =?utf-8?B?NnJZSHFFd3lkQXZhK3c3N2JKOWkvVFYwdDZ3S3pxd1dQM2M3dnlTZjltN2pF?=
 =?utf-8?B?YnNvMlNCdFhnQW10VVd5akZveHVJcTJEWTVoSG5qazFGK2xHN3hIU1RmY2Vi?=
 =?utf-8?B?RlBQOTFQd2xHazJCeERwVHpJVnZxcFdsQkd4b1lNcVJNL0haU0FCdlowN3dS?=
 =?utf-8?B?SmVSMU9vRm9LbU5NTGVoM1EwWXVPcGptaVl0ZGpRWC9CcDFob0xMOXRVU3Ju?=
 =?utf-8?Q?D3/43CDkcFm8UZ0yOvwclqrl0dXUTuTlEFESkKA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ditiVDdhUnVrK3NyTytQd1JsK0ttcnlkWlBkTzVTcXFBSEw3K0N5RzZkRGtH?=
 =?utf-8?B?N2hCMFZBSUVxSndndDI4MnhMVDBjOEJ4cVRITXlUWmtXOGhlTFJsSEpZYVRx?=
 =?utf-8?B?NFMzc0Qvd01PcGNaQXFsZHlaVE9wWXE0RWlONjJ4VlhVUkNpZjdKNk5IaU5K?=
 =?utf-8?B?WHpmNVRDaXhZZ2tWSTlGRFhBWnBxeXZNZXYvZnpXYkEyVHM2Rlcxa1I1YUJy?=
 =?utf-8?B?NXIwMitzamF6SVFwZjlHajdaQXBoWGVMMnN5M0dMbW8yN0F0SjFQQmJ6QjdO?=
 =?utf-8?B?Q3BjcWVvR2hSeGJVRi95MXFoK2RLSDFJVUNpOUF2ekFQSFhJSW5zTWVZNlYr?=
 =?utf-8?B?WDhQYmpRemExMWZvWjhXUCs5d1J6aTE4OEprd01jQmtsMG84ajJwQXFGaE1l?=
 =?utf-8?B?NkQ4YmNGblJqVFRraDZJRUh4cEFFcUZRMHBLNFRXem1nYWVsQlRYcmFzMnZX?=
 =?utf-8?B?c1R0c3l0Zm9USXFhL2pENkxVM2xSeVA4aXZ2T1gzbWtHS3VCazVmckEvTFl0?=
 =?utf-8?B?QUxkNlRmRmFIOXFzU0N6UzEvZ3RubUNuZjlOT3lDb2ROYWN3dC9mUExPL0x1?=
 =?utf-8?B?MU1Vd09VYXJBSVJpaVZiQVNjYzBPdU1jNHJqd1hITVJKT2Q0Q3lvTi9PS0Fr?=
 =?utf-8?B?cUl1dmNZd01oaDRnMWhHeEQrTnV1aVZqL3hBSXh6NVM3Sm9MT2kvc09RZEls?=
 =?utf-8?B?dUFISWNHWVFLeC9OZCtla2ttREFvcEREblJSYWRzRDZsclUyL3NXTUdOUExE?=
 =?utf-8?B?bDJscTRjcFpiOW1mdElBL0laajNtRE9WRTl3N0NCQVNmWU5LSG5FNmdZUnVj?=
 =?utf-8?B?cEFQZjIxNmlycnduMHFZcnUwb2hiRk1HUDY1UzV2YXg5M1k1RDJHblQ5S0xT?=
 =?utf-8?B?ZEI3dTIzbEJXVmFwR0EzWUpXTHB5MmRISHdUalBIcEJmNHBVQlNocjB5clBE?=
 =?utf-8?B?L2FtT1lyNENUV05qb3JUa0pEdGJjMTg3OFNSYkUxNC9KYmp0NmFUVFI1aUtt?=
 =?utf-8?B?bVlmdUJaUXR3M05SU3ZJK0JDaURJcjBjZS9DQWxzSTlEMU9VcjdHckdFN20r?=
 =?utf-8?B?L1BZcFk4RVVhUGVZd1VURWZPNWtId3lVbWEvZkRSN25waSt5L2I3N2lqVDNG?=
 =?utf-8?B?VHowaDYwcml6SDUwc1hISXY4VU5zalJvdStNV1dTbDUyaVdFd0FPUlR1VUs2?=
 =?utf-8?B?MkpBWEVkWHRpRFZmL29lUTdLOXFGWVNFOXBhWVYwTUtBdmZENmVrY2V4bXN1?=
 =?utf-8?B?Umpzc21ycEY2TTdUNU9kdmI2b3lBUk1TaE5UdWlMaytCVUdrNXBPb0ZRczht?=
 =?utf-8?B?bTdFd3lON1FnempKNllvMkdWTXQ1RmV3YjJySEdKUFF6R01kRDFiQXJabFhE?=
 =?utf-8?B?cEJuUkdEWEJoWnNsbTFielQ3MEJtZ0l1N254Z1BSbjdZdWROSW1xZy9QNHlC?=
 =?utf-8?B?TWxhWTBxL1A2L2FINk1Sb0xzc3ppQVJPaG1KaXFhL2p3QWQxazdmeElNZnM3?=
 =?utf-8?B?NlpVcEFhay8ybHIwVGJhUyt6V3prSEdteThjU3l3T3pJNTVFZjRqVXF6azcy?=
 =?utf-8?B?OE5UcnV4eUJqVUl5WjdjeUNBMUJvendnaXlERkN4WTZKcEJubTNmUmNlcjZw?=
 =?utf-8?B?bmhma2dNNDVLZEZNMm03VXhLT2kzRkRZK3hMTUhlbkFrQnNWbUxKdjJVUnVE?=
 =?utf-8?B?Ymd1Sll5TkFRcmVNZHZuaVpRSUpJOTNXZ3lsdW81MWJudjRaZDlkNG9hL3BO?=
 =?utf-8?B?N2M0V1FISnlDbElNVHhDQlFadzUvMVFwTEVuSmV0QWtSaXV3VGhvNmFMNEI5?=
 =?utf-8?B?NERWWTNCc0l1T21oOEM3NlQ5M2VUbGlNZFNBdzdhb2pnSU1WYnBmL0N1blVl?=
 =?utf-8?B?SFNnSDZlUTkrS1pXYnFhcE9BQlh4WjdNOUJ6cnlrUW1jcjEwaWk4VjA5TWJM?=
 =?utf-8?B?YkwwUytCT2JpOEpDcDRrWS9UekpROEFiY0pBZ1M0ZHJFbUk0NUJJaDJIVnNZ?=
 =?utf-8?B?TGlxbHRXNUJFaE9jRGE0dEdHMXNPeFkzOTAwYmpMY29mUzVGMkNmUHhNM1dU?=
 =?utf-8?B?TCtVTnpmejdIVTF6eHNnOE4wdGlBdHJUbTEvWDFjMEhnK25nUUgxbElKcGNF?=
 =?utf-8?Q?XM1W06Pfrfe7A51QJ57pMheaR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c945ead4-216c-4d6b-e83f-08dcf708d22f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 04:27:24.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1LbjpPVIMu+tyuSdyQmTL+ACiO1TteYHkuzoBaLU1yo47sdYBpP/P4UudBymDWJpaq3Lj5icUBvH1z/dVPX7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123

Hello Mario,

On 10/27/2024 5:56 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The driver must be registered specifically after the static call
> update.
> 
> Fixes: e238968a2087 ("cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call")
> Reported-and-tested-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/linux-pm/cf9c146d-bacf-444e-92e2-15ebf513af96@gmail.com/#t
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 206725219d8c9..2f0e29b05963d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1857,12 +1857,6 @@ static int __init amd_pstate_init(void)
>  		return -ENODEV;
>  	}
>  
> -	ret = amd_pstate_register_driver(cppc_state);
> -	if (ret) {
> -		pr_err("failed to register with return %d\n", ret);
> -		return ret;
> -	}
> -
>  	/* capability check */
>  	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
1865                 if (cppc_state != AMD_PSTATE_ACTIVE)
1866                         current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;

If we move the "amd_pstate_register_driver()" call to the below point, wont the above dereference (current_pstate_driver->) 
cause a null pointer error in MSR based systems with amd_pstate=passive/guided boot param. As we initialize 
"current_pstate_driver" in amd_pstate_register_driver().

We probably need to break up the if-else condition and handle the MSR based "if" part after the register call and "else" 
part before the "amd_pstate_register_driver()" call.

Something like,
		
	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
                 pr_debug("AMD CPPC shared memory based functionality is supported\n");
                 static_call_update(amd_pstate_enable, shmem_enable);
                 static_call_update(amd_pstate_init_perf, shmem_init_perf);
                 static_call_update(amd_pstate_update_perf, shmem_update_perf);  	<---- static call updates done
    	}
	
	ret = amd_pstate_register_driver(cppc_state);					<---- Initializes "current_pstate_driver"
	if (ret) {
		pr_err("failed to register with return %d\n", ret);
		return ret;
	}
	
	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
		pr_debug("AMD CPPC MSR based functionality is supported\n");
                if (cppc_state != AMD_PSTATE_ACTIVE)
                         current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;	<---- Now we dereference "current_pstate_driver"
	}
	

What do you think?

Thanks,
Dhananjay

> @@ -1881,6 +1875,12 @@ static int __init amd_pstate_init(void)
>  			return ret;
>  	}
>  
> +	ret = amd_pstate_register_driver(cppc_state);
> +	if (ret) {
> +		pr_err("failed to register with return %d\n", ret);
> +		return ret;
> +	}
> +
>  	dev_root = bus_get_dev_root(&cpu_subsys);
>  	if (dev_root) {
>  		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);

