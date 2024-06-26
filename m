Return-Path: <linux-pm+bounces-9981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D619175E4
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525EB1F21C33
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E3C12B87;
	Wed, 26 Jun 2024 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UbI821EE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB01C693;
	Wed, 26 Jun 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366604; cv=fail; b=MzKsH4D1pZoaLw8qUpgo3UHjt/fyhbxfIUgAlVoIWHMCaDoQMXR5dpTNcqJWcooBAh5iyfMtZsT37bwphXOBPsG1Ixp4PeAg1xRSgMngo/DRooPsL3m51AL5VTN5kXV8ra8BgF+0nX+PakIWe9QEF0EhAFtjfvd7uZXeJnCd1vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366604; c=relaxed/simple;
	bh=evBwzp/Kxfo6O65LqkxLAOh9Y1p3Y3phxb2I9vy6KDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUipKaX9al3TDZZr27YKLqXjRjiTcHhQ/2WyzLmy8+bxpDD/h4yn9JklijoEHzfmBYif+cKGPRNgOm1NUz0oK4ShgdfTybdtbdOFTarT/nmj+gDaS5sEjNmKI7ykukGdnM2+ylkzIwMg+jqSl46eYN5INB4pkElP+5RqiyLPK1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UbI821EE; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0LtoLhKoA0373LCWO0HYWvjSWfSgKld2QBxvvFmg+5oMn4Rf2LQIBWN/hgieuv/dAC79anEcvvfSn0Kmi09iG6PRWlyue32GlGr07r8mEwmTrBleIiAK9SA0qBsFEiUy9tSfC5unIQX8h5yHzo4Fbg2qo/l3ebx6vsk6RKZxUMmV+XRN1hfXVOMH8bRzPRu/Ud1IcLEhaxUf9ML7oUCSp5hIZUPaZ8Mgia3+aSwjl2aFaA7B3PjUdguFbvn8OyWY9eoQeR0Ax8in3gYlulkwVDcjS46XhhHLU5MyzzlEXVqR6CxyC0WroIuX8yWWai5o3pCtmvL+EWAYHcALYGVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evBwzp/Kxfo6O65LqkxLAOh9Y1p3Y3phxb2I9vy6KDE=;
 b=DG21M6qyLZHPe+me/sKSeqoSX3mSnZ0iq7VKbz/kW53u0d5L6H6crvgWYsLQf9EbSqG4UKhhDO2FpGVKgkSdVX4Zn+F3fyy5egufsSLHMlZJ12Ko9jeiCOwFpl3DLhafbrWc6fZbw0FHgV8n5C9EXhL0jo9aP60+iU3KQaXsXeD+PyxAl7uzUtnR6KV8fcxIa6m0XtBQ0q3/VlyKNYFV73kv1TbZnSLrFJUviTFl3+Airm0dP0bPrClkBCAf47aXTi2SmNnlX5RPxyxFVDT6V0aYNv/RYecqt84OldCc/donPILCcjTOZVSPeIlb2XEujkMrvm8xzWykCtAfmgDLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evBwzp/Kxfo6O65LqkxLAOh9Y1p3Y3phxb2I9vy6KDE=;
 b=UbI821EEUdnTeYIDC0+l7cq4IwdwXy4aKC+1c10InxMv/7TZ+doE93VnbwTrySV4rmd2kbx7oyPBvHuaA9jRTHMeX3kcARVkUA3rFUQ68isIpRewGGiqmjQ3eIHv9WuEHv+drec+Rj4BxuGTXbJygAmrCzEoG4cMAW6/mhFHV0o=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 01:49:59 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::ab38:296e:413e:1a3c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::ab38:296e:413e:1a3c%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:49:59 +0000
From: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To: "Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "Huang, Ray"
	<Ray.Huang@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
Thread-Topic: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency
Thread-Index: AQHaxwXxohz6IHYmFkKyTL/kaVbKT7HYf5kAgADHhDA=
Date: Wed, 26 Jun 2024 01:49:58 +0000
Message-ID:
 <DM4PR12MB6351BDC3C062E65F0B26F7F0F7D62@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
 <95bdfe3e-610f-43de-be2e-294cf2576fc8@amd.com>
In-Reply-To: <95bdfe3e-610f-43de-be2e-294cf2576fc8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ceefa275-28f0-43bb-8bed-96622bf80d48;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-26T01:45:53Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SA1PR12MB7037:EE_
x-ms-office365-filtering-correlation-id: 9662771a-2fbe-4e7b-f1ce-08dc95824966
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230038|366014|1800799022|376012|921018|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVJGYWZUUSsrNTNORnl6N1dtbGFHZzhyc2QvVXJGTTRibEdPVUhIZTArMU02?=
 =?utf-8?B?U1RNRzhVT3k1ZUc0MHhWZzY5RExRb2U3TGQvVGo5NTNmSGVoTUw1R1Z6REdx?=
 =?utf-8?B?empMWlFjKzNMenBka3l4UVp6NEUyK3FrcnVkbnpPZVJBNWdxWEVYZkRFZ2pJ?=
 =?utf-8?B?RUU0Z085ckpDMU8rU1RObDFsVjQ3amZpVGovdGliNXhybFFpZVVlcUtRYzB4?=
 =?utf-8?B?cjE1cktxZXRYZ2JtdjAremw1UGpaY1R3U3E3Rzk5dC9oNUZxM05qay9nTEM0?=
 =?utf-8?B?R2xsUmplT2ZkeldXRFU1LzdPU25oejdmSnJGTEFvTExzTUQ1b1Yyd1NNbVg5?=
 =?utf-8?B?S2VuemtXbWQ3bEhiT1cwaXRST3k2ZGNjbG1QekdiZ3hhTHlTUU9jM1RQMk1a?=
 =?utf-8?B?N1dmc2x4bXQ2ZHcyRXhqS2tZK1oxL3dxbVFpRUtwbWtRQUpjRmFZUmFEWHNP?=
 =?utf-8?B?bjZTZnZXTU9CNldaWnlId1lXSVE5dVY5TndIQXZLb3dabmcrUi9jK2plZUsy?=
 =?utf-8?B?SHBzVEc0THBpRno4eHMzUy9yMk1TdFd3RlM3cXVWVzAwcFRtUnZsWHl0bUp6?=
 =?utf-8?B?WnExR2trZlVyMG9RTnp2bDZGQ0tUajNweGIvYzFKZFZNQm16dkhrUElSSzFG?=
 =?utf-8?B?WHRyOWJDZVFKaHVkd1BKakN3cHFacC9Ub3UyRGtNdWhsTS9aQ24vanNHeFEy?=
 =?utf-8?B?WHdZQnVpZ0ZYZG0vcit6L25WbkRoSVppOW5PeGNienA1UzB5WFYwdXgzMmVG?=
 =?utf-8?B?cnVTOHVXVHBYVmFxakxaTHAySTQ1WUVjd3hOZVZNZDd1YUpCLzZ1emF3M1gr?=
 =?utf-8?B?eHhGYlk2eXBDSjBKSFpDR0R2d1JnbGduL1l4b0RLSXpxRDVXTENvb3RFOFBL?=
 =?utf-8?B?YkhxaDN6K0tKSDVRU21qS3RlSmVvZmdnOUhVTWdWbmFKNlpFdzFOOFR2VWty?=
 =?utf-8?B?NEMvZEZyb0NTVlVISWtKQkZSRVZ2SmdWemFnWkhBd05tMmExSVRFS2lkdlZz?=
 =?utf-8?B?dGRVelFyQkxnTFliK1dqc2w0b1dlNC9OTkMwOTlmZmVmVzJzaXA2QVZDMUgy?=
 =?utf-8?B?N2dmeHhhRGRqL3FpTWNwZ0p3emZ2Rk5ucjcyaTI1dkRjZWx3QmNsUThlZXNZ?=
 =?utf-8?B?SzhlYlluaHZ6VDFOUGhBMjhlSTREeG5HN3ovcEFzemwwRE9YUUFXVjRqN3Fk?=
 =?utf-8?B?RExidnFJS0ZjYlVubngzd2wxOVpQV3Z4VnhXRjJXamZ0WkNBZXRZdVpwa3E2?=
 =?utf-8?B?NFAvSUptUGZnZmpXOSswbE1PQTRpcDB1KzdqYlkzZkVyQlQ3NWRibUd1OUd6?=
 =?utf-8?B?R3k2ZzdXNlljdkNTMXhTZUVZQUpjM3FBMkxiUjFMVXZoNkxSTWtZTHEyRVVU?=
 =?utf-8?B?QXlHUHpBaDE0bEwreUVHSURTZy9sRG9SQUZmN1NLSEV1VGtmeGl0TGJDNnNj?=
 =?utf-8?B?YUNtRWF3R3RCVlg2dUtySlZXV1hpRTRQWm9XZnlFemtkUmFWZUcyZjhaSllj?=
 =?utf-8?B?bFJNWXdidmZlcEZlUEdCZ3NmSjFXMVBHN05qMHg2SGlIRGF5QityVFRLMS8v?=
 =?utf-8?B?VU5YWTdaUkIyanozV3ZDS3ZxNkVta29hWjg0M1JXZ2pZak1sOFA2dWRHTnlt?=
 =?utf-8?B?cEJDSDdnQmM5T3JHdVVrZmoxenZuaHprNTlrSENzWnl1UmRsby95bTdYejBy?=
 =?utf-8?B?UC93OEZDV0pZazI2ZHg1UTV2U2hkUHBGQkJrdm1xKzVtbDNzVDF6aDRuSURh?=
 =?utf-8?B?ZVpoaENSYWJEMit4blVzdUhodWJjRlp0K0w1YjlQNUZ5RUVnN3Z1dnNCbXJF?=
 =?utf-8?B?Z1A2dmRBR1BMdmtpWExVdUxMdDNvNzhXYTZoMHBXTGVMV2UrQWg5anVSa3Bu?=
 =?utf-8?Q?fz189Vffs4xBw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012)(921018)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUNFTWpKRG9uNm9iK29KRWJXQUlZVjl5MGFOdnN5QXBWa0dteldTbzBvYTc5?=
 =?utf-8?B?YUFGUks0ZmFYV3dGNDB6TVlVRWgyWnpqTzlQVGJxUEhtSEl4Q25kbDIyVXkr?=
 =?utf-8?B?MFBXM2k4Y0NJQlA4U2oxMmNPajNKSzAwblUyU1YvOTVRWnFsbWFEbGhQYklD?=
 =?utf-8?B?TUdXUnQ2N2dZaGZtSkNVb1dmVHpNbXB2Y0JEU1dTdktHV3h2aXNFbWUrMmdx?=
 =?utf-8?B?ei95SmhtSSt2ZnA0M3RtdWR6enVaWC9DcTBIMnF0TWtUVUplMmgrWnBPTHlM?=
 =?utf-8?B?RjFaMk1DY2J3OFVJMDZERlk3RE1pQjB0SkEyQk45aG5INGl6bkltRGNrTWUz?=
 =?utf-8?B?d1dvZDlDcG0vUjhrRi9vbWVYY1dpaFJJMHJMUkorcmhXbzRMUkJNTkcxOW8x?=
 =?utf-8?B?ckJjdW12MW9hQjZ0QzVCTm10eE9qNkZZbEdsWTdaQUNjclBHTmM1SDY1OVZ6?=
 =?utf-8?B?U2ltcjBiN09Rd1M3TnVvWTBleVZVMUg5eVpqYTN0RkxnK2dKdTg0dTdNeURy?=
 =?utf-8?B?RmxnSlhGYjkwRjUxSDN4d1piREhaaFlVQnNyZjgxd2tKaGZYQzhsNkVBUVND?=
 =?utf-8?B?NUc4Nm8zMWFpRDA1ZWJ4bzNzcUlrUlF5bDRYc25aU1dMU1FMTGdTWkt4SXNy?=
 =?utf-8?B?Z1FEaTJZYjJZMUo3UzQ3WnlTZVVudTBXeFQ3UFJSMzVRMG5JVFhnQUxPNFFs?=
 =?utf-8?B?TW5wNGZySlY4bmRtSE0vUmpQV2htTWdMbWNUMkthZStHYldJZDlvVGNrc3dT?=
 =?utf-8?B?elJUMlVSc1FNcWRoaExDSFhiQ0JqaFJ3MGlZRFo2ck55bHh6S042RWtjT2xW?=
 =?utf-8?B?cnlYOHB1MDJnM2dKT2JpNkVnUUJYdVJxNVBhVHJWOVE5TjNqMlhnSFVsTTll?=
 =?utf-8?B?OHNTcjRpWmdlS251aGZ3MVU3YmRoWXRibHBjS2VVeDNRRWdTOHRkN09rRG5w?=
 =?utf-8?B?U0twZDFFYW9WK1BkbS8vazJmRTRTcTBSbFlNLzBSQWM5RVVZSmNXWEU3ODUv?=
 =?utf-8?B?S3pHRUhxUXBEeWVFTUowbitiL2k3ci9VcVEwZWlzYmRjZ2dvSm4vaWhicnNt?=
 =?utf-8?B?YXhzRDJxRHM3YnZPbDlqUTErV25IY1JBd3RLaFF5dmNpNXM4Y1BvVXZsbWg1?=
 =?utf-8?B?Z0U3SmxTSDNJS1Yydi9WbFhSZDhQQXJoWitMNHJWSmdPcmVzQlBCK0RLZHIx?=
 =?utf-8?B?NnJ2aUw3WFpieVBaTDJDKzdwM3krMUNLbGlQWFQySnp5Kys5ZGxMdUtib2FV?=
 =?utf-8?B?NW5wUDI4MXVPbjFvV2xmMERNdHRubTdwOGRBRmJ6UHBvWThXS01JVlEzMWp3?=
 =?utf-8?B?dUI3enlqVEM2c1FlZlRXTzhGWWhkdzROUnZrMW9VNXRjODNsL3QwdWl3YTlV?=
 =?utf-8?B?SGdxNURFTlBRVFQ0MFVCVnBUbTd2ZGw2ZTRjVTkyOW8xdUdwenJIM2xRR1A3?=
 =?utf-8?B?RnhRTWtVUENXYUtBZ080L1ZPd2huaDV5NUNJRVk5anZDamV2cEp2dkRyOFVv?=
 =?utf-8?B?SW94a2pJN3g0QmYxZWxZRnJmMm5YVnhuTFJsWklvdlM2L0MvTlNoRUN4ZUxY?=
 =?utf-8?B?UG5GeWxEMnpJSUJac0ZPTnJHNHA4YUNLQlNVVmM5cVQ5d0dueHZUMzlwcXRz?=
 =?utf-8?B?enpsSlROTTdacEtrK0hDODB1ak5kOHFLeEJBQ1E5YmUzZGtXQ3lDKzVGUGNw?=
 =?utf-8?B?QUljQm9CZHhNUVJDSlZSYTNpeG9ES1ZSMDc0L2gvVVJPVkFYSkxhc05rbExj?=
 =?utf-8?B?b2RXT0dtSXdIZFErOG9raXNLdFNQeUpFVGQ4ZmYyTWxBOS9ZZEJjVXBWLzBS?=
 =?utf-8?B?MkFnNU50K0R3UGZ2bUJlejFzdG1tQlA5Mjl4Wmo5aHZ0eUtzcXIrU3VMRnZC?=
 =?utf-8?B?QkswTWo4bHEwMU9qRDd4aVJwaHFESThXTVpsR0xmUzJ0QjRIWmZkZmR3SVZq?=
 =?utf-8?B?bnNEWUlwZHVMaHFuWnRyM1dBMXRlVzdpcDd5VGtvNXpZQkwwNDhTRTVMWnc3?=
 =?utf-8?B?emVzblQzT2FuZEZuYmFncmFmY24vdDA0TVVJdmFZYWJWV3VUVHMzN1VzQVFu?=
 =?utf-8?B?UzJiRlkwWkFta09jV2N4bWYzd0RXbXFXYmRwTUN3OTVMTDVqeG9vbklFeVBa?=
 =?utf-8?Q?WuYY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9662771a-2fbe-4e7b-f1ce-08dc95824966
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 01:49:58.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJFi7egcCgbZnBKX62M8WedHL1Vx9jJxHq3EogTXk6RCMANtmoVgqozpYMDoMQgIffrXPRT4M0UF49DdT7HLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgRGhhbmFuamF5Og0KU29ycnkgZm9yIHRoZSBkZWxheS4NCg0KSSB0aGluayB0aGUgY29y
cmVjdGlvbiB0byB0aGlzIGlzc3VlIHNob3VsZCBiZSBpbiBmdW5jdGlvbiBhbWRfcHN0YWVfaW5p
dF9mcmVxKCkgb2YgZmlsZSBhbWQtcHN0YXRlLmMuDQpUaGUgdmFsdWUgb2Ygbm9ybWluYWxfZnJl
cSBzaG91bGQgYmUgY29uc2lzdGVudCB3aXRoIG90aGVyIHZhbHVlcyhtYXhfZnJlcSxtaW5fZnJl
cSBldGMuKS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVZ3dla2Fy
LCBEaGFuYW5qYXkgPERoYW5hbmpheS5VZ3dla2FyQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bmUgMjUsIDIwMjQgOTo1MiBQTQ0KPiBUbzogcmFmYWVsQGtlcm5lbC5vcmc7IHZpcmVzaC5r
dW1hckBsaW5hcm8ub3JnOyBTaGVub3ksIEdhdXRoYW0gUmFuamFsDQo+IDxnYXV0aGFtLnNoZW5v
eUBhbWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQu
Y29tPjsgWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47DQo+IHNraGFuQGxpbnV4Zm91
bmRhdGlvbi5vcmc7IE1lbmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47DQo+IEh1
YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPg0KPiBDYzogbGludXgtcG1Admdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8yXSBjcHVmcmVxL2FtZC1wc3RhdGUtdXQ6IEhhbmRsZSB0aGUgaW5jb25zaXN0ZW5jeQ0KPg0K
PiBNaW5vciBtb2RpZmljYXRpb24sIHRoZSBjb21taXQgc3ViamVjdCBpcyBzdXBwb3NlZCB0byBi
ZQ0KPiAiY3B1ZnJlcS9hbWQtcHN0YXRlLXV0OiBIYW5kbGUgdGhlIGluY29uc2lzdGVuY3kgYmV0
d2VlbiBub21pbmFsX2ZyZXENCj4gYW5kIG90aGVyICpfZnJlcSB1bml0cyINCj4NCj4gVGhlIHNl
Y29uZCBoYWxmIGRpc2FwcGVhcmVkIGR1ZSB0byB0aGUgd29yZCB3cmFwcGluZyBJIGd1ZXNzLg0K
Pg0KPiBSZWdhcmRzLA0KPiBEaGFuYW5qYXkNCj4NCj4gT24gNi8yNS8yMDI0IDc6MTEgUE0sIERo
YW5hbmpheSBVZ3dla2FyIHdyb3RlOg0KPiA+IGNwdWRhdGEtPm5vbWluYWxfZnJlcSBiZWluZyBp
biBNSHogd2hlcmVhcyBvdGhlciBmcmVxdWVuY2llcyBiZWluZyBpbg0KPiA+IEtIeiBicmVha3Mg
dGhlIGFtZC1wc3RhdGUtdXQgZnJlcXVlbmN5IHNhbml0eSBjaGVjay4gVGhpcyBmaXhlcyBpdC4N
Cj4gPg0KPiA+IEZpeGVzOiAxNGViMWM5NmUzYTMgKCJjcHVmcmVxOiBhbWQtcHN0YXRlOiBBZGQg
dGVzdCBtb2R1bGUgZm9yDQo+ID4gYW1kLXBzdGF0ZSBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IERoYW5hbmpheSBVZ3dla2FyIDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS11dC5jIHwgMTIgKysrKysrKy0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUtdXQuYw0KPiA+
IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUtdXQuYyBpbmRleCBmYzI3NWQ0MWQ1MWUuLjY2
YjczYzMwOGNlNg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0
YXRlLXV0LmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS11dC5jDQo+ID4g
QEAgLTIwMiw2ICsyMDIsNyBAQCBzdGF0aWMgdm9pZCBhbWRfcHN0YXRlX3V0X2NoZWNrX2ZyZXEo
dTMyIGluZGV4KQ0KPiA+ICAgICBpbnQgY3B1ID0gMDsNCj4gPiAgICAgc3RydWN0IGNwdWZyZXFf
cG9saWN5ICpwb2xpY3kgPSBOVUxMOw0KPiA+ICAgICBzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRh
dGEgPSBOVUxMOw0KPiA+ICsgICB1MzIgbm9taW5hbF9mcmVxX2toejsNCj4gPg0KPiA+ICAgICBm
b3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KSB7DQo+ID4gICAgICAgICAgICAgcG9saWN5ID0gY3B1
ZnJlcV9jcHVfZ2V0KGNwdSk7DQo+ID4gQEAgLTIwOSwxMyArMjEwLDE0IEBAIHN0YXRpYyB2b2lk
IGFtZF9wc3RhdGVfdXRfY2hlY2tfZnJlcSh1MzIgaW5kZXgpDQo+ID4gICAgICAgICAgICAgICAg
ICAgICBicmVhazsNCj4gPiAgICAgICAgICAgICBjcHVkYXRhID0gcG9saWN5LT5kcml2ZXJfZGF0
YTsNCj4gPg0KPiA+IC0gICAgICAgICAgIGlmICghKChjcHVkYXRhLT5tYXhfZnJlcSA+PSBjcHVk
YXRhLT5ub21pbmFsX2ZyZXEpICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgICAoY3B1ZGF0YS0+
bm9taW5hbF9mcmVxID4gY3B1ZGF0YS0NCj4gPmxvd2VzdF9ub25saW5lYXJfZnJlcSkgJiYNCj4g
PiArICAgICAgICAgICBub21pbmFsX2ZyZXFfa2h6ID0gY3B1ZGF0YS0+bm9taW5hbF9mcmVxKjEw
MDA7DQo+ID4gKyAgICAgICAgICAgaWYgKCEoKGNwdWRhdGEtPm1heF9mcmVxID49IG5vbWluYWxf
ZnJlcV9raHopICYmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAobm9taW5hbF9mcmVxX2toeiA+
IGNwdWRhdGEtDQo+ID5sb3dlc3Rfbm9ubGluZWFyX2ZyZXEpICYmDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAoY3B1ZGF0YS0+bG93ZXN0X25vbmxpbmVhcl9mcmVxID4gY3B1ZGF0YS0NCj4gPm1p
bl9mcmVxKSAmJg0KPiA+ICAgICAgICAgICAgICAgICAgICAgKGNwdWRhdGEtPm1pbl9mcmVxID4g
MCkpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICBhbWRfcHN0YXRlX3V0X2Nhc2VzW2luZGV4
XS5yZXN1bHQgPQ0KPiBBTURfUFNUQVRFX1VUX1JFU1VMVF9GQUlMOw0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgcHJfZXJyKCIlcyBjcHUlZCBtYXg9JWQgPj0gbm9taW5hbD0lZCA+DQo+IGxvd2Vz
dF9ub25saW5lYXI9JWQgPiBtaW49JWQgPiAwLCB0aGUgZm9ybXVsYSBpcyBpbmNvcnJlY3QhXG4i
LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgY3B1LCBjcHVkYXRh
LT5tYXhfZnJlcSwgY3B1ZGF0YS0NCj4gPm5vbWluYWxfZnJlcSwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgX19mdW5jX18sIGNwdSwgY3B1ZGF0YS0+bWF4X2ZyZXEsDQo+IG5vbWlu
YWxfZnJlcV9raHosDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdWRhdGEtPmxv
d2VzdF9ub25saW5lYXJfZnJlcSwgY3B1ZGF0YS0NCj4gPm1pbl9mcmVxKTsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgIGdvdG8gc2tpcF90ZXN0Ow0KPiA+ICAgICAgICAgICAgIH0NCj4gPiBAQCAt
MjI5LDEzICsyMzEsMTMgQEAgc3RhdGljIHZvaWQgYW1kX3BzdGF0ZV91dF9jaGVja19mcmVxKHUz
MiBpbmRleCkNCj4gPg0KPiA+ICAgICAgICAgICAgIGlmIChjcHVkYXRhLT5ib29zdF9zdXBwb3J0
ZWQpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgIGlmICgocG9saWN5LT5tYXggPT0gY3B1ZGF0
YS0+bWF4X2ZyZXEpIHx8DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KHBvbGljeS0+bWF4ID09IGNwdWRhdGEtDQo+ID5ub21pbmFsX2ZyZXEpKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIChwb2xpY3ktPm1heCA9PSBub21pbmFsX2ZyZXFf
a2h6KSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kX3BzdGF0ZV91dF9jYXNl
c1tpbmRleF0ucmVzdWx0ID0NCj4gQU1EX1BTVEFURV9VVF9SRVNVTFRfUEFTUzsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgIGVsc2Ugew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
bWRfcHN0YXRlX3V0X2Nhc2VzW2luZGV4XS5yZXN1bHQgPQ0KPiBBTURfUFNUQVRFX1VUX1JFU1VM
VF9GQUlMOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoIiVzIGNwdSVk
IHBvbGljeV9tYXg9JWQgc2hvdWxkIGJlDQo+IGVxdWFsIGNwdV9tYXg9JWQgb3IgY3B1X25vbWlu
YWw9JWQgIVxuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1
bmNfXywgY3B1LCBwb2xpY3ktPm1heCwgY3B1ZGF0YS0NCj4gPm1heF9mcmVxLA0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdWRhdGEtPm5vbWluYWxfZnJlcSk7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm9taW5hbF9mcmVxX2toeik7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gc2tpcF90ZXN0Ow0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgIH0gZWxzZSB7DQo=

