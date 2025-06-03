Return-Path: <linux-pm+bounces-27992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B398ACC11A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 09:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B1918873DE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EAF269806;
	Tue,  3 Jun 2025 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kXiH7u82"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC3269820;
	Tue,  3 Jun 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935066; cv=fail; b=hQyO8G0Seg4pUdc/FOik9BLpx0NomZeBvsqYBw7xOUQFHpCtn37aLHvSabvQncjPiUVnUwVeojlTiEijtbSRnDx604z8sq4wufSPxIIj6RSVgvWhsmv+UfpGYXOE68NLoDfin8kZWISsxb7KfJ21R6/90X55ot753lbRG6nBhHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935066; c=relaxed/simple;
	bh=QTk46uE0GRfgG7CeMOUVBe70mVQej5CxzTkyjvV+icM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNzf5LHy0IjNUZOgEiBN2eTC6fPkLjRgIRbSiWlTS2Q1hHYT0aiAN04XM6ozJ4g/KO3v/YmoKvTeAc1o4zD0jzX66D1LvrVtYMP+TeDCeVFjDISsTyWylS8Pft/Y5FFnP5k7xSP5LBkZwoNIjiEuzQw+ie4kmtliSTyJwfjyipw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kXiH7u82; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1748935063; x=1780471063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QTk46uE0GRfgG7CeMOUVBe70mVQej5CxzTkyjvV+icM=;
  b=kXiH7u82JChMtEtRO31Xh3+1ZrTxjNhCF1m5oz333/vpGfh5g+UyWXw3
   YpU2nz+4Eai/CBPgLG0TLvUvWV6vfluHCg1oxLp8tEyS10D3igp+AptAd
   7+jt907wK+yw/Q/JrQ1l0tVmSPcAzFCHu1nROPlBpNn+QIlr3yTXCvhtc
   Ufm6B+8Af3oBL11Zsgl4p13lxMyU/zvXKM8MsM3aiVlYq0pC/Hh4dHepD
   YkCwvHgzr0K3MT6h8GPMJW0N9oWQwPLYMro2Bw5OtwzQ5f6+Ec/u3/08j
   DdmFXGVUHAqeKbbPcKvSn5ArR65d4A06zu9KWPhn94pcNm6uezJ3pj+Iq
   A==;
X-CSE-ConnectionGUID: K87v2t/aThGO/l+J+nXhEg==
X-CSE-MsgGUID: FgJhBL6fTrqkGyMXN2+Yzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68480282"
X-IronPort-AV: E=Sophos;i="6.16,205,1744038000"; 
   d="scan'208";a="68480282"
Received: from mail-japanwestazon11010055.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 16:16:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYGX5NPBzRmQKzRCA/t8WESu7khLp0PbzNyoIbcWbepgjbEa+BPsgkDlvW2/TkHdWE6aIXxGMZErfcoqU8rWkPC6+JOcmjB3d3vcEa0X55Uzv9Z0lnVhOkHbwpzS2RpXGVn95fWiVBvqIYyZbPQEZEso4BkTlfsxwt3l0lQdRwg0Z9DLSC3OOn2f8I9JIU6Ti6aLggx17l0JKRMUK1OQH80uaohtWrFR6ydajctJRgAJiV2i4TQ0wtC34Zg0dGmFixAOOlPPWuENJdd3taYAV3N2jb7wAjpL/ogbkEcQ3B4JCIBh0VHzXDlvA7Tm0vhZOsEL4BZmXmpHE2M14qMDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTk46uE0GRfgG7CeMOUVBe70mVQej5CxzTkyjvV+icM=;
 b=lrtgtlNXt2887NsIIpbWM8wrZ+lj2qDhsMqhWcrW58nVs69TCi02lgLWRoy6WB6RI4ImszBvOnTvJpDgthtyHsJvKxUYwzR8yD2GBLkw7P8v/OKgwZYlBZrSxn5s7xFU6gawr397WVR6Pbj4pg/Es9dj3Aky4asPW200ILrQsaidB5ETkBlvAc0v8t9n3Rd65wLaENnaTFeMAuoeYAaYEmwuyYm4+I3pH6T+KUowtUcjihR7yaGT5S1tJZiVNcAb3F+Z0CctbjRdqT1FcWgIMBpeiBPPHaF5Jyi7Qht8CizHtDBVNkmkRI8/UsAq4bgrNYYl8lR7CinDPNFULBqriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS9PR01MB14003.jpnprd01.prod.outlook.com
 (2603:1096:604:361::13) by TYYPR01MB12981.jpnprd01.prod.outlook.com
 (2603:1096:405:1c6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 07:16:23 +0000
Received: from OS9PR01MB14003.jpnprd01.prod.outlook.com
 ([fe80::bf61:4fd9:7b06:2485]) by OS9PR01MB14003.jpnprd01.prod.outlook.com
 ([fe80::bf61:4fd9:7b06:2485%4]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 07:16:23 +0000
From: "Shinji Nomoto (Fujitsu)" <fj5851bi@fujitsu.com>
To: "'John B. Wyatt IV'" <jwyatt@redhat.com>
CC: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John
 Kacur <jkacur@redhat.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Shinji Nomoto (Fujitsu)"
	<fj5851bi@fujitsu.com>
Subject: RE: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
Thread-Topic: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
Thread-Index: AQHbyuBa+atM0fAVk0qKi5bwr9ll97PpiVOAgAeOYkA=
Date: Tue, 3 Jun 2025 07:16:23 +0000
Message-ID:
 <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
 <aDhJdTWzDihchywc@thinkpad2024>
In-Reply-To: <aDhJdTWzDihchywc@thinkpad2024>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a3fe2e6e-0aef-48cc-819b-359cdf063e9a;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-06-03T07:11:31Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB14003:EE_|TYYPR01MB12981:EE_
x-ms-office365-filtering-correlation-id: 632ab43e-341d-421d-28f7-08dda26e8c1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?aXIrZnJROWozU0ZDVVE4MUc1NC9BVGhQYTNFZFpsbUd5U0srYjVSUFhP?=
 =?iso-2022-jp?B?YWptWk1makxUckFJSDVSOTlVY21RZ0NUUmVTRG9kRG1Pd0I4YTlyZDlZ?=
 =?iso-2022-jp?B?WHhTeEhoUnNEZ1JOK3hxa1crQzl4VFUraFk4MWE2YklmTVNHMC9PS240?=
 =?iso-2022-jp?B?MjdDUlpNYklGNmQ1YzF6TnBIRWU3U2Y2elVCOFNtbERzNWY0TWU2TGhn?=
 =?iso-2022-jp?B?WnE0MHlrb2FVb3piZFhxOGY0VkErcEQ2Z3hTTHpxQ0Q5ZlNyZ2hoZm94?=
 =?iso-2022-jp?B?UEQ0dGtFVHIwWnllNTdLNVhoYWtHT05qMExUa2F1d2x1WjFuUDgyR1hj?=
 =?iso-2022-jp?B?NnhkbTg2dGpoRit6RjFjVVdxMW1FQ0hhREhQRURGSVN0YkdqaGdTVDBK?=
 =?iso-2022-jp?B?R25ZWXJBRTZIMERUbnRQWTN3Umw1ZGR1ZkxHaTlEbkpIUEFRV1QzNnVp?=
 =?iso-2022-jp?B?bkE1VUpuVFF2WDFxcGRFSllPb2drYTlzSHA5STZmQ2ZRSm5uRXFyWlhK?=
 =?iso-2022-jp?B?RXpqRk1lZVplZDZPNkxmZ0RURHYybGdMcVBua2tYWHhXQ2RCR3F4K2Jm?=
 =?iso-2022-jp?B?QnQzcmhUQ1phR0tEWlEva1B3U2RRSGNYcW16ZGdXMlFNRU1hVjZiMWZT?=
 =?iso-2022-jp?B?RU9LMG9qbzNGY2paZk16NVpwYVQ0VnZrTVdoMmFCTytWUWF3ZndLVDFm?=
 =?iso-2022-jp?B?NkNGU3VVMUNYTU90c2syemdIZ21XejVGUFQwazhLWDBMY0NFTFdWVjZK?=
 =?iso-2022-jp?B?ak5PNnhXd09QaHZNM0FOWXNlcnJHNFJJQXlGeDNCL1M4TUNZSjZUMXNW?=
 =?iso-2022-jp?B?UHRiUjAzYjdFeDV5SEtleGM5NzUvdnltdEpFQ2pyV01SUFV3ZWdMUzlQ?=
 =?iso-2022-jp?B?SUhsT1krSWRRTllKczEzUkVYZ01tVUo4MmlkVXUwV1UyTFlpK01TZFAr?=
 =?iso-2022-jp?B?MkUrbE01VFpXb3ZlRjRQTHRhcXdJTytYNWJ4T0VDR0ZhY3krOWxHMjA1?=
 =?iso-2022-jp?B?eTJDeGtwZ0NNS2hzcVB4M0ExZi81QzB3NXUvaHE1TTY3SlhodHpabUZ1?=
 =?iso-2022-jp?B?US96eGJGd1RKZDhJbGt5VE8vQzNnOHNwOWlGbExmMURwd09PWEFuU2FJ?=
 =?iso-2022-jp?B?eFdaQnAxQ01HeWVEU1lVaDNGb1hCa2F4VExGcmFmU3pYU2gyNVdralpN?=
 =?iso-2022-jp?B?VjhESndmZTJESVBxYXBnNmZ6OTJnSGtZYTZTVng5TWlua05rOVdibk8x?=
 =?iso-2022-jp?B?MG5xZGM5blVrbVpnbmlsTTlUQU5UTmI3QU5WN1d6RENXbTI4S1FXYjEv?=
 =?iso-2022-jp?B?ZVBCRG9iL28xWjQrclYvWjdqWHFBTEVYSEd1Q2pJR2cxOGVPVXdib1JB?=
 =?iso-2022-jp?B?UnFkakNWTlRHcVVsTDdGeWw5OTU0ZVNNSUJDMUp5RnBDb3dZZFJzVmFz?=
 =?iso-2022-jp?B?OHB3LzZMOTcrUEQyOTNSU3YwaWJVRWZjTWN1M3ZPYkVvWnJvN1YxSjhE?=
 =?iso-2022-jp?B?amR1dzI0eElscTFTWlNIV3NmUmI0ZXlEaWt3WmNqS3JibkFONnV3akhq?=
 =?iso-2022-jp?B?SzBldU1UYVowa0V6NG1oVXc2M1ZMVzJCNzROMVNpUjVZQlN1dGFMSllO?=
 =?iso-2022-jp?B?RHIzY09MM3VSRlJuSE1NdG5aU1g1Z1RLbkVkbW43ZktBVDcyWjROdnF3?=
 =?iso-2022-jp?B?c3Awamllc1dZZUtqRUdLUUl3Ym44bkxVT3ZOR2RWK1NoZVNDTFdNTHIx?=
 =?iso-2022-jp?B?aFkrbHAwTTBrRGo5a2N0R3JpVjkvM2VwdUVGVVd3cDBNVmFwZDlqYlhQ?=
 =?iso-2022-jp?B?LzZZcEZHcUlYdXpGLzFZSFpYUmFMRGlpendVTnN5eldrQmY5cmdiT2dU?=
 =?iso-2022-jp?B?QlhweVBiZm11ZjBUZ2JBVXZrdER6MllubGhLZnpaNTdsNUg3YlYvRmVY?=
 =?iso-2022-jp?B?akZvMGF4U1NlcWZTeEVlNGkyR0w5VW1kMklBUG1KUk1IOStQNHRwak9G?=
 =?iso-2022-jp?B?ekVXRnU1Z2xiZjNQZ0YyM3R4SUJaMG5PbjNOOGhoVzduVU5Ua1dRaGhZ?=
 =?iso-2022-jp?B?LzZEVEVrbW1hM3I3WW9hVnNxYlpxZFlBM0hEMi9hSmZZVHZZNlk5OE1U?=
 =?iso-2022-jp?B?WTByTDIrWkptWEVTalNqRHg0QVdyNHl4UWEzdEoxQ2xVSVVibDBDN2Nh?=
 =?iso-2022-jp?B?bFVkVVo0MTJ5MmhkSTArZ2tDcy9FbXh5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB14003.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?a1dPMWpkYUhiZ3ZuT1UzTFBtYXc1RG04RTJaOHQ0WFVnU09XSUl1U2hD?=
 =?iso-2022-jp?B?OUQraDJTNGMrbk1kbnFSMW1XODNMbVM5aDVtNlZmZWtwYWdRbE5FZ2Za?=
 =?iso-2022-jp?B?SHlycng2MVhuSms4cDhHZEtYSG04bFloZnZPWEF3K2FhUmJJUEt4U0dG?=
 =?iso-2022-jp?B?RHUyMXluOW95eDFWdmQrK3FSZ1I1QkF0VldHalJYZHlta0RFRFVUN2NN?=
 =?iso-2022-jp?B?cjducWFpR3dseVZXRmRTZ0w5dnYxUjh4MVc1WkZ6Qngwc3pOMTBHcGxK?=
 =?iso-2022-jp?B?QUZxMnE2TkVucTdrVWVSazdOK1RwOFBSd1BpNFN5OXlmbjhJMUtGK3Rv?=
 =?iso-2022-jp?B?dWtkVDd6bVk2VU8xYVJZbW1hdEcwVmkwdFpxNXhrWDNnOHRyaUN2UFNw?=
 =?iso-2022-jp?B?UnpQWVpVdERkSHNmeFlrOWxRS2Y2OVhNMHEwSVpwTHRDVE15L0ZGaTJ4?=
 =?iso-2022-jp?B?UGc5V0xkSTVZVm1xejRLaStlVXFQK1JQL1ZiWjI4TE81SlF4YTluMWRv?=
 =?iso-2022-jp?B?ZFlOcjV6SFdScEx0VURGZ0tNSXRqWTZiVlJ2WldNL2Y4ODE0M0ZGbVZk?=
 =?iso-2022-jp?B?aHJ5MzdGalhCdUc4K0pLNGt5dDF5SjVHbnVlcFJrejJXNVB5S1dEb2ky?=
 =?iso-2022-jp?B?SXVUaVBrZnN6L3IySERSUi9TR3BMSzRYRm9La2RnRmJ3ZTR5b0hPYlky?=
 =?iso-2022-jp?B?ZnpYV0k0U2NLNnBrdmhoSGlUenFjN3p0dk9Rc3ZWMWkySFNnT0poeXdP?=
 =?iso-2022-jp?B?QmlpSTNGdjQ0eTVrWFRtejJESHhGWGlMemFxT2JnamZyVzRMWG90YWVO?=
 =?iso-2022-jp?B?M1JScVlIOW9PQ25IRC8vUWtmeEQ1T0Jscmp0NGxTeTltQVJxNG9rWGtL?=
 =?iso-2022-jp?B?b2U1Tm1SdVFyTmFJbmp5VE9KM2lONmpKZE5ybWZEd2ttYzVWYlFJUGdD?=
 =?iso-2022-jp?B?eHAzSDhsOEpRNGZwV2ZBQnJZa1ZtLzRJTlRLemxyamlRR3BZdXQ0UDE0?=
 =?iso-2022-jp?B?Z3pXb0NJWXdKUmJDOXpqTkJGTCt4UmpuWFhvVVZYamhEYmExQzlNUytH?=
 =?iso-2022-jp?B?YWQwTHpFRnpuaXd5bHdJcGpyWUFmYkR2WURhTWhJMzFxTWtyYmJZbXJz?=
 =?iso-2022-jp?B?aFFCd1hUdGh4SCtjYXc2dkRuTUNXOExJU0d6eWNkdTBEanBGSzhhMm5W?=
 =?iso-2022-jp?B?bC9tUjBmOGwyNlhoK3BlNkRrcUtPN3Y4Q1RrQklEK0F4aWRNQ1MzM1FT?=
 =?iso-2022-jp?B?UW04UmswdkViZjNQR3RtL2VnRlp2VzZuTFJpS2lxWkZiaXpNWWJMR2w0?=
 =?iso-2022-jp?B?bWMyNXVOWWxnQ1MrbXhCZ1pJaGFUWDVtTFY4Nk5tSTdxZUFRLzYvS3ph?=
 =?iso-2022-jp?B?ZGZwSFVkYUFyTHUzTXBsbkxQZEVuSG1kWFJGU1FzMy9EWXZVeWhGbXZi?=
 =?iso-2022-jp?B?RE5nZlMwK3RvWVNYbTZCbnBOU05CYVhJMmxFMUdkTURxRUwwZCtPRTZG?=
 =?iso-2022-jp?B?bXh6TTBRSzFRUHczczNrQWc2L1lYWHlyM3RObndtMlJtcGZ0RXF5ajhv?=
 =?iso-2022-jp?B?K1oyNFI5MkRaY2xLemRBR21zOERyZHJ3b0M5MjRtTGFXRHU1ZzZMUTFE?=
 =?iso-2022-jp?B?WG9VdVl1eTc3ZHlVWUpsQVFDaWRZdXJUcmlpSGxyeXpmNDkxaXYvM3NO?=
 =?iso-2022-jp?B?Tit4SHF2a2RjRWRIbENOVDBlcmhWMTdpb21UZUNqcHlJOUZ6U1F6TlpQ?=
 =?iso-2022-jp?B?UHVmV2J6WUFkYmJGdHRPS0VsbE9ucUNvV2M1K0lPSUExcHFYMXVHVEVY?=
 =?iso-2022-jp?B?cUlvUUxwNG55UGpMWkVIZ1R6aGYvcUtRaGxmWkNCS21ROFlOeTJCdkxI?=
 =?iso-2022-jp?B?ZHFYY3oweGFqS3hNamkvZEN4NWc4ZmwyaXJZMjJCK3lZdnkzTzNRNHBm?=
 =?iso-2022-jp?B?dnJFNjk2dVZ0ZUVlTTZnQjVZQmY5VjB4TmVFd21Ydmpqc2FIckNCZFBr?=
 =?iso-2022-jp?B?UEJaQ0N3YTRjN2QrZ3ZFSVhGMlZxSS9INHNDUHRqQzJtMUE1MUJDUExx?=
 =?iso-2022-jp?B?SGdrd21qTU9CeVd5em1CU053Q2JnVDJiRkVrUlFYUUhtalY0eDlGS3Bp?=
 =?iso-2022-jp?B?UHh4ZzFBS3VRclJ5UjdkUlNyZ1Rzby9EOWNiMmEyOTZ1Z1dBTkRnbkxB?=
 =?iso-2022-jp?B?cWZxMCt0Tmk4TGk3UXNWRGhQRloxK0xDc0VkNG1POVRzT2l5MkZ1K2p2?=
 =?iso-2022-jp?B?dGhXQW1SUEI4M3E2SzVnMFN0OHlocUR0M2tJS0VCSWw3L2dFVkl2WTRR?=
 =?iso-2022-jp?B?cnluUGpmaGx4YlY4d0lBUVh0c0FWOElia1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/NVzrWZJ6E9soKBDq3/HTKoTkzteWfvkPNpNajV7NVqmMK1pri3TGal4i8+VnlQbrQ/LAwlaF/8ksfnfrItyjoti5RLDCp2bOXyqnVjaPOlR5Q++DPkYQhZgLeZf5IM17tjmWX9fqP4cbZ+rNZnCM6qEqiiKypYYdq7IrySobLUHeB/MVPCcISQL30wm/+bLrU7V6rXmajKzQc1Rc1wgL7ipLKX1kqV7o0du3/hIaAR+L6f2t1Y6GyQ0EEF0qmaFnktD09gTQYGdmNl9EmatYXcIwFCRyMn915SndamKTGNNcx5Seu3USTWohdhn0Rm/gqXIxCd8gyR5SVtyGX7UPZ2kQTbZx7tCRlw7FMSsLJVypsQf2zWN/xqDuceXmiauR7IKrdjNWSliI22s8o2CVLx5/Eq4A7K24H59mWhhWANaMT4K7Gd1CPW7HrU/tTqrYGQ+64S6hcTU2cGYd52CRTD8LcEC6rEtLs2ij5xjXUS7TmCu3TjWR18GsXT1SD1/4lbnebDMPWiTklz2seB6t9uT5mE4Zi28N0JtxJ4wmoFVxs2us25/DJaaJwp7F8mZEKw9zS2hISO7IeXdM65KInaBJRoHCh3JcIPLhOhlrqaHMzlwD/W8v3k4RfkRGFsb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB14003.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632ab43e-341d-421d-28f7-08dda26e8c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 07:16:23.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLTyhhN3GstzDDwFAeL/wnQaqSU+ghqewFhyciXnZJIasz5GNBCDhtn1QSzC6Pri0i/cZSohuE7AQvqSfdsTHtMIhIKEisOR/80UT86K4pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12981

John Wyatt wrote:
> Hello Shinji, ty for your patch.
>=20
> On Thu, May 22, 2025 at 03:10:57PM +0900, Shinji Nomoto wrote:
> > The cpufreq subsystem has a generic sysfs interface for controlling=20
> > boost (/sys/devices/system/cpu/cpufreq/boost).
> > The sysfs interface can be used to enable boost control from the=20
> > cpupower command on non-x86 platforms as well. So, allow boost=20
> > controlling on
> > non-x86 system if boost sysfs file exists.
>
> Did you test this on non-x86 systems? If so, would you please provide det=
ails on those architectures and systems?

Hello,

This patch has been tested on Arm-based systems.

* It was tested on our internal simulator based on QEMU which supports boos=
t.
* It was tested on the Nvidia grace system (which does not support boost).
* The cppc_cpufreq driver is working on both of the above systems.

We have also confirmed that it continues to work as expected on AMD systems=
.

Regards.
----
Shinji

