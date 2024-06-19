Return-Path: <linux-pm+bounces-9536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815BF90E20D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00BD284DE0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A890C1E4A8;
	Wed, 19 Jun 2024 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="etANVwwJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8822139D3;
	Wed, 19 Jun 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768805; cv=fail; b=cWDST6axYBPKKdJj50Udw8QYnZP+jtmm194Tm2jxpS/k93phOUmRF92PXAXFCiAbEoxfbFGgU5FKfwB2XRwOQHZoKpkDApoF241FXDG+938JaQRKSOuOw5jjSj2QMt62Q4gKVHe+zlxVfHfmU7Yb2tDOhadHCMe0SiYPDsbYp/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768805; c=relaxed/simple;
	bh=zyLD8Pyw8q5fRLHLfRYkJ3Q7/FN1bdGjvpwQ2AtTPD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j0rg3iv2Lm0fqaH7ujbuCuCblqmBSsp1NKETvcvkKgjRe5CGYdVEG+yOr2gWSBJwv4mA12NF8qt4FU9oxzoex6Dm9KC6x3BbWNB/Xf7efv0Iv/rI2q5VMQh1NOE61O8eXDKjx+3KVEIJsYkhPVwuWL4Il08eTC4aG7R+qrGdk0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=etANVwwJ; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDWUDds9oX6H/Vu0FiV7VHsScNSJVm6toVZtFOJhlynz+qRZKrr3kleBwN7ir/QqOpm6uxMpqoA8iT4wvpHdRwiaTCDQ+S9ONWA1NzpgvHYG4CKjA2F1KB9eLyAbksRuWeN+m0ci1XsQTwM0KLTAU42AR9t2gs7O2S3zqVj+pfMgQ/mW1qyIhteHSMq7E47MGMoMj5TVsiSnyOR6pqEDvj4fuqGbxr9rY+iqRMRgBAZSDZbWQC9OePPDJ1i+F2gPWlSIH3GgURd2LC0HO+eC8XhnfKoAOkQ1B9saHR9ibx3AVi5VK+9xxRo6IQinJN9yVB6ADVgs1aUNSJSCWTfCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyLD8Pyw8q5fRLHLfRYkJ3Q7/FN1bdGjvpwQ2AtTPD8=;
 b=hMhWrMvmjwQO8LsEr4GTTrpHPEwxq+z801c4bfXhTphu/3+nklsq8OaWmVXwTnwAMD2mFEd0x5Pc0mOquKvzD59aVg0NjmIVLWww8QSfNU/FYCE7bCbEU6isEL+VkfClpyBOBGc6vYgxM9gSZ5pGkQMv5F7HX8RDeLGCWFOdHIWMSEQcy3OLo3jEaO/y2s1Dg0y7ln/M6VsUX5gB5wDh/WhpNH2i4ACfIY+mCu0ePJh+w6aGvX0ki8olbyq6e4pDVxa1AwpvCprh9vhUJDZ2BQHL1sSduYl9HIelE/zr0veoNC0/6Fk1EE9fFnLPnKq89BOHWgdcZpWZ/fwohn8NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyLD8Pyw8q5fRLHLfRYkJ3Q7/FN1bdGjvpwQ2AtTPD8=;
 b=etANVwwJDMbhpL+iNvhw09viQJuyU+vjLNavmQirA9mJn9gby8fnsCjIznJwdeeWTq9uw/hu358vUh7BwKHO7FYOJ4c+wlBc3Suq3M0WgRP9CA10BO+dKGtBbtzmecx8ZYfllBofNQwpahQtkJy5ZPVFiYIJJlDjIfw8nooq+lc=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 03:46:39 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 03:46:38 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yuan, Perry"
	<Perry.Yuan@amd.com>
Subject: RE: [PATCH v11 3/9] cpufreq: introduce init_boost callback to
 initialize boost state for pstate drivers
Thread-Topic: [PATCH v11 3/9] cpufreq: introduce init_boost callback to
 initialize boost state for pstate drivers
Thread-Index: AQHavWMB1NG+IowdL06z3LsAsb7zDrHF+vAAgACRwFCAB+2KIA==
Date: Wed, 19 Jun 2024 03:46:38 +0000
Message-ID:
 <CYYPR12MB86559CB690A186BD0F87B7739CCF2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
 <688d8e1ce875655c344ac3b29876da5dc0456739.1718262992.git.perry.yuan@amd.com>
 <cc26e5fd-ee67-4720-bc58-322fa1ed0329@amd.com>
 <CYYPR12MB8655F6EF9F01A71A8A1288669CC22@CYYPR12MB8655.namprd12.prod.outlook.com>
In-Reply-To:
 <CYYPR12MB8655F6EF9F01A71A8A1288669CC22@CYYPR12MB8655.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=90386fa3-240b-4a4d-8960-dd7789883b6c;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-19T03:41:11Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH7PR12MB5902:EE_
x-ms-office365-filtering-correlation-id: 33b3cad6-0ee8-48b7-ebff-08dc90126ca7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXd1RGJrNDdUWk9QdDlyaDZETXlUR0xUT3kvUS96dStpdlIxeGY4d2JFc1c2?=
 =?utf-8?B?K3p6eHVOeEJKVkV5NWFnT3ovYzArb0pFeWJnOG54a2N4NE1tNjJ0eE9jeTgy?=
 =?utf-8?B?RUF6Q2Y0MU4wejhWYnNzQm9LRnQxRSthYmZQU2IrU0w4WEZ3eHVzU2xsOHJt?=
 =?utf-8?B?Ym93enkzZGFSakRKQzZ6NzJrR3V1emd0Y3p0b29RWnl0bTY3UjZWMTNOR1Ex?=
 =?utf-8?B?b2dYc0dlbkdpdnFlN2xBd0RDRVFaZzZRTTFUWVFwUWZVVG9MZGV2YnpMV2g4?=
 =?utf-8?B?Zm5DeHZxM2JBNXRiUUxEcWpHcVBFR1NsNEc0b1pHWVdQbDZ3eXNDSDk5aHg1?=
 =?utf-8?B?UzNrcnF6d1pYNWVtaXdaSmVmU3VWVk15cFd5aWE0NndqUTNXbkdqaGp3RlJu?=
 =?utf-8?B?SkdQemJGbzhNYjFpaWNQbldVTWhhOHJBcUl5amNmWWx4MkFSMWpjS1ZaSkpC?=
 =?utf-8?B?SFJzcUVLYWprUllodzNrM3FjcTRoTlJJajRoOC9XRy9ZTUthOTV0azJzTVpK?=
 =?utf-8?B?TlVYY3Q0TVM2OWplV0d0bjZ2RjF3N1BaQnpKb0oxVk1iVTRzdWJNRE4yMTVH?=
 =?utf-8?B?UktkYndkLzk2bytyWkNUUHdvcGdpVk0vYVBxdUdKNTJrb1VoS2hmdmtmSjQw?=
 =?utf-8?B?WXZRNDkwSytHZHUyeUNSK0NpMXNxaVhzSXBCMDc5Y3I2K2ExSUppNmF4TkZ5?=
 =?utf-8?B?cmt2QXJ2aG1ubWpiOU5qRXZXS2VTSExzMGFQUTdML1NQWThxZEpaSVBPSCt5?=
 =?utf-8?B?TEg4NGwyTEM4aEc2ZHAzYitNdDNhZkVPSk1rcVJMejgzekdRVXAxY2hkUWpG?=
 =?utf-8?B?eWxsTW02UnQ3em94VDVZZEYvL0RsMVJkR1FwOGt2UnlkMTZheCtrLzNGU0cr?=
 =?utf-8?B?QUNrZGcvYmkzQkk3YWR6akNZZjVFTGZNYjBsTGNFYk02N1hYbG9JeTRyd3ZW?=
 =?utf-8?B?SEtPQVZvamVxeGc4R3pLYzVLVEhseUNsa0FoQUxQanR2eFhOSGZnVEhudTI4?=
 =?utf-8?B?eTgzTFp5RFBXZm90Y2R3My94RHAwWDczZy9SMFB2N3NHajFEVEM2d2xXNXc0?=
 =?utf-8?B?eHd0NWJybzNaYkh5Y1psQ3JvWHZTZmxyMGVIMU85SnRNSGYwcUVHc2R0V2ov?=
 =?utf-8?B?Y0dKQWIwb2JZNkMxU1Z6OUp2bHljeTZaSkUySUs2TWluOHlsbFBkNlZGeVR2?=
 =?utf-8?B?QVB5L2JTUzNTdURpSktmTGlldHdhbFdGRHhPN3VQU0grRW1KdUhhTmlMNTlZ?=
 =?utf-8?B?c2dlTVRaVUxib0xQRVNJeGtqbW8wTjN6UkwrY0c5NTlsc0EvVW5ERjRIRWdI?=
 =?utf-8?B?UzRSQmJyV3hHZEg1ZWVlaFBRYVNRbGVYeGFpMUh5emlRWTMwaWYxYlpVWlFJ?=
 =?utf-8?B?REFxU2dtUDM5dnVIc3hXK2w3SkV4cHIzMnVxVlpxcGplRkhzL01ZeVhidUJT?=
 =?utf-8?B?b0cwWXVaVE9wZEJ3Zks4OEw4L0JFUU45NzZ6SHFkY0hhUUJZeGlZM3gyektm?=
 =?utf-8?B?akd3b3p6Z1Z1cUpIck1tZHNNTWl2R2VZNmJURzA4RFFoQWFJSXAvNEIvN01t?=
 =?utf-8?B?bU5YMEpCWlloa2FpTXdJY2dTV05SVUE2TlMxWTVSb3JlRTcxK09YRUd1dGVR?=
 =?utf-8?B?b3B3TTlqOVBKdlVRVWx2RUsxRFNlMDAyWjIxUFk0VUtFV0w3NmpXUHVyUmtp?=
 =?utf-8?B?OEVJbFdNbUlPQlVsN0hzaTNHeUlkYUhqemdNMXRsajhad1F4L0E0cEUvemRV?=
 =?utf-8?B?cmYzdXFldjlrMkFNcFVQQmJERTFNZ1cyWVpKQkZVSkNGOGFvdTZXdjFuVnlS?=
 =?utf-8?Q?qdg6RgCTIYdJN6ioNK4g9mLUBc4AQBUNaEIhM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkRpTFREeC9GdzgrMU80NkJKMTA5aldNeEw0QjdBRUN0eVR0ZUJlZU9sR3Bm?=
 =?utf-8?B?QzZESUc1WkNPVHE5YS9IbHJXZDYveWlxT3hjUmtEODBOSExiYUF0S0tTT3Bl?=
 =?utf-8?B?emJKN0dsUy95c2IrOVdpa3M4aS9FTnNOWEhPUC9kbXZFd2QzMzZDU1h0Sjlh?=
 =?utf-8?B?Y1JQWk1SUzZMK0w4S2xUSThFcHpMTnlmeVVZTzBOZEtzQUI3MTYyWE0vUmtN?=
 =?utf-8?B?bk1uTTF2dFFrZ0VUb3VDaWd6dUQ3NnNBbFRXeHloeHF0QkxoRTlhb0M5UEkw?=
 =?utf-8?B?bks0M25mbGs1ei9NNi9YZTQ3dVRCUlViMmhZNGtyeTdRWFBZWWpLTk5NU1RG?=
 =?utf-8?B?b0wvMGcxaURrOE02Z2FKdVFCOEFpS2MxaEtVU1JSeGRlMW5wWHBJUWdZVHdQ?=
 =?utf-8?B?T0JrNkVrai81RjRtSW41UXFjWnJoZWhIWGQ0cHFCcTJLMC8yOEp5OGFndFds?=
 =?utf-8?B?aWNNbE8rUnlheEppU1FXT3paRExWUTRPb3g3UGVSbkh5Skh1dkpsVVhZQXp2?=
 =?utf-8?B?QURnZEVZV01UcWNnUlFFSDZqWndMSFd0R1Vwb2NBY1NjOFl1STJ1VVdwUEQ4?=
 =?utf-8?B?c05obGE1UW5YcHRMNUlka2VXSnozOW01cDhmYUlhcWNtUEw4S0RQa1BjNmpr?=
 =?utf-8?B?aG1GVFpjV1AraFBGY09DWEZtRDZOU1lCMzdFcEkvWG9teWdHYnNmaDhyb2R3?=
 =?utf-8?B?akJwa3NEaklpYzdXNjVobVdveWZTNFliY216eHRNM1RSSUlOTEhOMXVIVFlD?=
 =?utf-8?B?RE9zTkF0QXZMV2NSMkhqZ2FBaE5XNmpDOGR5eDdJSndzUXRIK1poTzJUSXdp?=
 =?utf-8?B?cXRscUFxbFA3U016c2dKYTNSQjZFOU92ZFZGeXYxa0UvWjUwZGg5U1JIclc5?=
 =?utf-8?B?SUh4dW5WQTN5TnNrUVpvMEcwcTlpYzMzWXk3N1ZvSlBCbGovTmdBVFBHc201?=
 =?utf-8?B?UXd4TXk0c21ZL0tHeVRpZkttUFhML2crNnpwMFBCY2xLSEVrSzZwZGJML3l4?=
 =?utf-8?B?VmtSc0tIeGs2dHJLaHQzVCs1T3BjUzZ5ZU5IOGpqaW9ESzdEejh6NE40c0Jk?=
 =?utf-8?B?RDJveGphOWJvalBhV3IvUk5vZmdKK1A1SVBHeTZ0Y01sT21LcjZpMjBLUVBk?=
 =?utf-8?B?RHVBV1lXVDMzYWFja3NwVmVyd0JsM1JRQ2JEZHpJQTF6Q0wwV1RuT3ZSdWlQ?=
 =?utf-8?B?cEtyL3lGbjltb3VxWmNqU2Z2THQ2SUVZRGJoWTNHVnV0UFRNMjRpUXB5Nlg5?=
 =?utf-8?B?VEtLVkZ0bnpKRjZzM2Q5SUpYVWJQUS9BWFJyMmZWeTlSNG1Id1NSL2RwUkd1?=
 =?utf-8?B?ZVpHZlBwMkh1bGwrWHdhaHo0TGRIRlFQSGE0emlHZGxTVzFyY3FDcE9NbC9J?=
 =?utf-8?B?K01TdEtZZ1hJeXRLb3lKbGgyVGI1b0lLNmhFUlpaSnVmL3pVeGl5VU5Dc2RT?=
 =?utf-8?B?WWhYZU5JOUV1ZzlKS3ZTZFNQaGxicTFqN1hKNWN1a2ZQdWVvNnh6eTh2SHYz?=
 =?utf-8?B?QmZsRFVoSVY2L2pEZHM5MzBab1J2ckVlOERVOCtqdHU1T1BNbmtLZlFOWDR0?=
 =?utf-8?B?TGVhTGFTR2FEckZqQWVWYW5aRDRsZjRrZEtoT1dmVk15WkFCVERxWlh5dTVy?=
 =?utf-8?B?MzMzejBKZnUyVGppYzRyMDFBb0tTZG91V3UwanphRzFWSXl4ZHVKMEI2Q3VH?=
 =?utf-8?B?VHNqRCtLcENPMGZtMlBPZG9ZcE9LOUJXSURVUHVzZjJRYU9kWjZ0NU5uNVNk?=
 =?utf-8?B?dDhTakFCMlBLODduc09WTVRiSXRkTWhKampkQ1dXQlMzME11VCt0MTVNV0xU?=
 =?utf-8?B?L0NhNHdhOFZIbVFJVkd3djdpbURFQmx6L0NXT0QyZ0ZJdzFRRXlFaFc0M1NP?=
 =?utf-8?B?Tm1EN002SmdSTDMwb001OHM5VlIzQVdPMzFQMjkxYWlHY09KNmo5ckJ1MUhq?=
 =?utf-8?B?bExRZ2NMR29zVWhyWjlOakM2bjVuT0hJSGZEMS9WekFHbkQyYTZEeEVuQ3Ji?=
 =?utf-8?B?dHB1aURWSmRBK25HZ21CRWpWR1pBZVJlQjEvYmJ2bFpONFhLcitYUDJnSFhF?=
 =?utf-8?B?ckJHRDVLaEdzMjFVa09oQTM2TXdmY0pPSWNlM3BIOFhTeDBiRUdENkxpdVFk?=
 =?utf-8?Q?AhRY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b3cad6-0ee8-48b7-ebff-08dc90126ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:46:38.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAZsOtr4FKnlLNrbSsN8BtRTRqf9nPDFupQYIg48qawDK7A/7yIVAvmfubrDfk5tHYUxEAWq5Dd8KhR7oLHO/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902

W1B1YmxpY10NCg0KSGkgUmFmYWVsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBK
dW5lIDE0LCAyMDI0IDEwOjQzIEFNDQo+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxp
bW9uY2llbGxvQGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0NCj4gUmFuamFsIDxnYXV0aGFtLnNo
ZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNsYXYuUGV0a292QGFtZC5j
b20+DQo+IENjOiByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsgdmlyZXNoLmt1bWFyQGxpbmFy
by5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4g
PFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFt
ZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjExIDMvOV0gY3B1ZnJlcTogaW50cm9k
dWNlIGluaXRfYm9vc3QgY2FsbGJhY2sgdG8NCj4gaW5pdGlhbGl6ZSBib29zdCBzdGF0ZSBmb3Ig
cHN0YXRlIGRyaXZlcnMNCj4NCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5h
bCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJ
bnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1k
LmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIEp1bmUgMTQsIDIwMjQgMTo1NSBBTQ0KPiA+IFRvOiBZ
dWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgU2hlbm95LCBHYXV0aGFtIFJhbmphbA0K
PiA+IDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNs
YXYuUGV0a292QGFtZC5jb20+DQo+ID4gQ2M6IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgRGV1Y2hlciwNCj4gPiBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA+IDxTaGltbWVyLkh1YW5nQGFt
ZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+Ow0KPiBNZW5nLCBMaQ0K
PiA+IChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjExIDMvOV0gY3B1ZnJlcTogaW50cm9kdWNlIGluaXRfYm9vc3QgY2FsbGJhY2sgdG8N
Cj4gPiBpbml0aWFsaXplIGJvb3N0IHN0YXRlIGZvciBwc3RhdGUgZHJpdmVycw0KPiA+DQo+ID4g
T24gNi8xMy8yMDI0IDAyOjI1LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+ID4gSW50cm9kdWNlIGEg
bmV3IGluaXRfYm9vc3QgY2FsbGJhY2sgaW4gY3B1ZnJlcSB0byBpbml0aWFsaXplIHRoZQ0KPiA+
ID4gYm9vc3Qgc3RhdGUgZm9yIHNwZWNpZmljIHBzdGF0ZSBkcml2ZXJzLiBUaGlzIGluaXRpYWxp
emF0aW9uIGlzDQo+ID4gPiByZXF1aXJlZCBiZWZvcmUgY2FsbGluZyB0aGUgc2V0X2Jvb3N0IGlu
dGVyZmFjZSBmb3IgZWFjaCBDUFUuDQo+ID4gPg0KPiA+ID4gVGhlIGluaXRfYm9vc3QgY2FsbGJh
Y2sgd2lsbCBzZXQgdXAgYW5kIHN5bmNocm9uaXplIGVhY2ggQ1BVJ3MNCj4gPiA+IGN1cnJlbnQg
Ym9vc3Qgc3RhdGUgYmVmb3JlIGludm9raW5nIHRoZSBzZXRfYm9vc3QgZnVuY3Rpb24uIFdpdGhv
dXQNCj4gPiA+IHRoaXMgc3RlcCwgdGhlIGJvb3N0IHN0YXRlIG1heSBiZSBpbmNvbnNpc3RlbnQg
YWNyb3NzIENQVXMuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVy
cnkueXVhbkBhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9jcHVm
cmVxLmMgfCAxMiArKysrKysrKysrLS0NCj4gPiA+ICAgaW5jbHVkZS9saW51eC9jcHVmcmVxLmgg
ICB8ICAyICsrDQo+ID4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2Nw
dWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMNCj4gPiA+IGluZGV4IDFmZGFiYjY2
MDIzMS4uZTFhNDczMGY0ZjhjIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2Nw
dWZyZXEuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYw0KPiA+ID4gQEAg
LTE0MjksOCArMTQyOSwxNiBAQCBzdGF0aWMgaW50IGNwdWZyZXFfb25saW5lKHVuc2lnbmVkIGlu
dCBjcHUpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X2ZyZWVfcG9saWN5Ow0K
PiA+ID4gICAgICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+IC0gICAgICAgICAgIC8qIExldCB0aGUg
cGVyLXBvbGljeSBib29zdCBmbGFnIG1pcnJvciB0aGUgY3B1ZnJlcV9kcml2ZXINCj4gPiBib29z
dCBkdXJpbmcgaW5pdCAqLw0KPiA+ID4gLSAgICAgICAgICAgcG9saWN5LT5ib29zdF9lbmFibGVk
ID0gY3B1ZnJlcV9ib29zdF9lbmFibGVkKCkgJiYNCj4gPiBwb2xpY3lfaGFzX2Jvb3N0X2ZyZXEo
cG9saWN5KTsNCj4gPiA+ICsgICAgICAgICAgIC8qIGluaXQgYm9vc3Qgc3RhdGUgdG8gcHJlcGFy
ZSBzZXRfYm9vc3QgY2FsbGJhY2sgZm9yDQo+ID4gPiArIGVhY2ggQ1BVDQo+ID4gKi8NCj4gPiA+
ICsgICAgICAgICAgIGlmIChjcHVmcmVxX2RyaXZlci0+aW5pdF9ib29zdCkgew0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICByZXQgPSBjcHVmcmVxX2RyaXZlci0+aW5pdF9ib29zdChwb2xpY3kp
Ow0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHByX2RlYnVnKCIlczogJWQ6IGluaXRpYWxpemF0aW9uIGJvb3N0DQo+
ID4gZmFpbGVkXG4iLCBfX2Z1bmNfXywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fTElORV9fKTsNCj4gPg0KPiA+IFRoZSBtZXNzYWdlIHNob3VsZCBoYXZlIHRo
ZSBzdWJqZWN0IGF0IHRoZSBiZWdpbm5pbmcuICBJRToNCj4gPg0KPiA+ICJib29zdCBpbml0aWFs
aXphdGlvbiBmYWlsZWRcbiINCj4gPg0KPiA+IEFsc28sIGlzbid0IHRoaXMgZmF0YWwgaWYgaW5p
dCBmYWlsZWQ/ICBJRSBzaG91bGRuJ3QgZmFpbGluZyBoYXZlIGE6DQo+DQo+DQo+IEZpcnN0bHks
IEkgYWxzbyBhZGQgdGhlICIgZ290byBvdXRfZnJlZV9wb2xpY3kiLCBhbmQgcmVtb3ZlZCBsYXRl
ciwgIGJlY2F1c2UgSQ0KPiB0aGluayBpdCBpcyBhIGxpdHRsZSByaXNreSB0byBmYWlsIHRoZSB3
aG9sZSBvbmxpbmUgcHJvY2VzcyBpZiBkcml2ZXIgaW5pdCBib29zdA0KPiBjYWxsYmFjayBmYWls
ZWQuDQo+IElmIGRyaXZlciBpbml0IGJvb3N0IGZhaWxlZCwgaXQganVzdCBsZXQgYm9vc3QgY29u
dHJvbCBmdW5jdGlvbiBsb3N0LCBidXQgb25saW5lDQo+IGluaXRpYWxpemUgZmFpbGVkIGFuZCBn
byB0byBmcmVlIHRoZSBwb2xpY3ksICBpdCBpcyBhIGJpZyBwcm9ibGVtLg0KPiBJIGFtIG9rIHRv
IGFkZCB0aGUgZXJyb3IgaGFuZGxpbmcgaWYgbWFpbnRhaW5lciBhZ3JlZSB0byBzZWUgdGhlIHBv
dGVudGlhbA0KPiBvbmxpbmUgZnVuY3Rpb24gYWJvcnRpbmcuIPCfmIoNCj4NCj4gUGVycnkuDQo+
DQo+ID4NCj4gPiAgICAgICBnb3RvIG91dF9mcmVlX3BvbGljeTsNCj4gPg0KPiA+ID4gKyAgICAg
ICAgICAgfSBlbHNlIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgLyogTGV0IHRoZSBwZXIt
cG9saWN5IGJvb3N0IGZsYWcgbWlycm9yIHRoZQ0KPiA+IGNwdWZyZXFfZHJpdmVyIGJvb3N0IGR1
cmluZyBpbml0ICovDQo+ID4gPiArICAgICAgICAgICAgICAgICAgIHBvbGljeS0+Ym9vc3RfZW5h
YmxlZCA9IGNwdWZyZXFfYm9vc3RfZW5hYmxlZCgpDQo+ID4gJiYgcG9saWN5X2hhc19ib29zdF9m
cmVxKHBvbGljeSk7DQo+ID4gPiArICAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgICAg
ICAgLyoNCj4gPiA+ICAgICAgICAgICAgICAqIFRoZSBpbml0aWFsaXphdGlvbiBoYXMgc3VjY2Vl
ZGVkIGFuZCB0aGUgcG9saWN5IGlzIG9ubGluZS4NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2NwdWZyZXEuaCBiL2luY2x1ZGUvbGludXgvY3B1ZnJlcS5oIGluZGV4DQo+ID4gPiAy
MGY3ZTk4ZWU4YWYuLjA2OThjMDI5MmQ4ZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvY3B1ZnJlcS5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2NwdWZyZXEuaA0KPiA+ID4g
QEAgLTQwOSw2ICs0MDksOCBAQCBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgew0KPiA+ID4gICAgIGJv
b2wgICAgICAgICAgICBib29zdF9lbmFibGVkOw0KPiA+ID4gICAgIGludCAgICAgICAgICAgICAo
KnNldF9ib29zdCkoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksIGludCBzdGF0ZSk7DQo+
ID4gPg0KPiA+ID4gKyAgIC8qIGluaXRpYWxpemUgYm9vc3Qgc3RhdGUgdG8gYmUgY29uc2lzdGVu
dCBiZWZvcmUgY2FsbGluZyBzZXRfYm9vc3QgKi8NCj4gPiA+ICsgICBpbnQgICAgICAgICAgICAg
KCppbml0X2Jvb3N0KShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSk7DQo+ID4gPiAgICAg
LyoNCj4gPiA+ICAgICAgKiBTZXQgYnkgZHJpdmVycyB0aGF0IHdhbnQgdG8gcmVnaXN0ZXIgd2l0
aCB0aGUgZW5lcmd5IG1vZGVsIGFmdGVyIHRoZQ0KPiA+ID4gICAgICAqIHBvbGljeSBpcyBwcm9w
ZXJseSBpbml0aWFsaXplZCwgYnV0IGJlZm9yZSB0aGUgZ292ZXJub3IgaXMgc3RhcnRlZC4NCg0K
Q291bGQgeW91IHBsZWFzZSBoZWxwIHRvIHJldmlldyB0aGlzIGNwdWZyZXEgY2hhbmdlIHRvIGFk
ZCBpbml0X2Jvb3N0IGNhbGxiYWNrIGZvciB0aGUgcHN0YXRlIGRyaXZlcj8NCldlIG5lZWQgdG8g
YWRkIHRoaXMgdG8gaW5pdGlhbGl6ZSBib29zdF9zdXBwb3J0ZWQgYW5kIGJvb3N0X3N0YXRlIGFj
Y29yZGluZyB0byBTQklPUyAsIHRoZW4gdXNlciBjb3VsZCBjaGFuZ2UgdGhlIGJvb3N0IHNldHRp
bmcgYXMgcHJlZmVyZW5jZS4NCg0KUGVycnkuDQo=

