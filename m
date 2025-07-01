Return-Path: <linux-pm+bounces-29873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12FDAEEF54
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 09:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C44188A342
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3A31CBEAA;
	Tue,  1 Jul 2025 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKKuavE9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FA158DAC;
	Tue,  1 Jul 2025 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353327; cv=fail; b=CZd/KPyzV2yN28P9Qyb1MLES6LcWPWKOipSGrOiichAZNnHKQBGqUMicQrPHUc+9ud1Zu4TCNG5r7RFXTAw0ZPJKtgCmpFPyyVlBsKKKzwVSIcEpijWGIwaWwq4BX2TU7hpRPdCg5+PC8RL74XUKX+6dAboidLL3pop4VEtoc0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353327; c=relaxed/simple;
	bh=0KeHdn2FO96+y9JG6Q9nf0fI9Y3kPUTVkUZaK3q/+wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ngvzia+9PK2nPmZtxhzpwCH59h4F1y5Em66HLhr0GsIXnwp8AbCwd3UibGPQ97CTTi6+vpBDK4LJOc0G5Rsn9HTFhTlCaSF5d/j+na2owcG/iRgXymVC1yAclvETJXf5fj7BsSb1oGna3m61IZ8pnHncQhV1L4oK5g99OUbfZC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKKuavE9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751353326; x=1782889326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0KeHdn2FO96+y9JG6Q9nf0fI9Y3kPUTVkUZaK3q/+wY=;
  b=WKKuavE9uec5Xbz8SSpYsq6/X33w14r8UzsxLjhXsZ3WeCxJWOWBjhVd
   +L5t6KDJI8+VE2i6p9nJv7WmbEvMxO9Xb9iKUPQzhxkmTVVEIy85hVWYz
   ++kECGEATYo0FkXMx4N4hjI43ZNjGX6LkiqeD5mH96tFt/AMHwB/tTVAO
   Pemwv9yVCGv564qGfszZACj091J+X5H0QGzejguabXJhQlPehe/LeBGWI
   baqE1ljUsrWOewR9gUQjaBItyBVH2Z+LUplS4InJ3mMLTi4aqbhkzphsk
   siB81qtSCu+Bjw4I5jfoCEi5F44AtDMaxojnBzNp4dQlNt1R7sUOO34o9
   A==;
X-CSE-ConnectionGUID: rFgtsAhIScyuYWtHYMANqQ==
X-CSE-MsgGUID: 83Ra7mvySx+R//y4GC3t3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="76143871"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="76143871"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 00:02:04 -0700
X-CSE-ConnectionGUID: oHBlxZRXRDq9vZopw+cH3A==
X-CSE-MsgGUID: CDalcmZHTjC9HkSjJkX1vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153436721"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 00:02:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 00:02:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 00:02:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 00:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBmy/vpzhEYpfdGi9glLhizkUC+pFMC5fT4KpGy0qsanP1VNMoVJnatGRecldbJ1C3FaMuWdm73jYHxs3sMs2hQd4o4BQeZ1NwEZkl/jaPPRVpq0ArV+t3RhCd+1aoVy11UecOVhZEgEp0qJrZRsoJpBw6UpvBwaVWxMghojoUbgktej8BnjP9Zfip/Y2V5pPny3nQBelvVpzh2B8d6rItu+w0XObdf7zpjpoDnzz4/mrY5bjHFpIS712kBjAOIBfhjJ+RxALSdOxOnSSEMNFsLJjosrKhz0zmC10UA+lpwycVnj6iYsNVUFerBKjjC3CbHKuVRA4PojJov0019YZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KeHdn2FO96+y9JG6Q9nf0fI9Y3kPUTVkUZaK3q/+wY=;
 b=hVui+C8MkUCXTzdBQx6/quq6OoDxZevUDhq1ekq705+oHSYzLDrOsPsmtdD5toaHf5/DgpNYJietuLbRhKOkJrHcpye6FHqqJIKtaK1fiT6s0BC+YJV3tDQd4ThVGzTVIpYSLOEkX9bOu1cru7L5SYZqPbm/IvxDRJM0udqBnq1lmMTZiDQScvF8dW1tUZ0BcDC/rEOjIaJ4KFgIuj6eu/Ibe2HjkvUJQOOVkdXKDZK5ySUkYeHW5+FeIHpgHY1npuiwavyGazPwA1wI8eBo2qTyTc0tDB3mhx0a5UtSLR1saVwHM6s2RZU8A7r3oJgQekqGu2pOBDa9jU4lf1Orkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by DM4PR11MB7256.namprd11.prod.outlook.com (2603:10b6:8:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 07:01:59 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 07:01:59 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "benjamin@benis.se" <benjamin@benis.se>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Thread-Topic: HP Omnibook Ultra Flip 14 - power profiles
Thread-Index: AQHb54aI/x4TucNMjkG3sTXjdCBKkbQa6rUAgADA7YCAAAm5gIABJ6oA
Date: Tue, 1 Jul 2025 07:01:59 +0000
Message-ID: <65f3a229f70279ab0da7efa878b863c7798d4427.camel@intel.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se>
	 <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de>
	 <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se>
	 <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de>
	 <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se>
	 <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de>
	 <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
	 <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
	 <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com>
	 <rFJU7KbF6iq0CxJtSjPu4vLVjWata5hY1Kl-wOv253p0C2W7egJQQrkUnkSqmr1vXDXeTwwtwp0u5ZnQU6pZmPuJ7TnNBVgudMG-q5MRHyM=@benis.se>
	 <c6Eep72y6E7gc-wUMdcIS9JfNN1_OBjlwGUrd4yGvp2R-PW2-OOoQngQt5H5kiZIccxFAPswaN9G6wVpHuewtoEvUkT52UCzHPibVJh7iYY=@benis.se>
In-Reply-To: <c6Eep72y6E7gc-wUMdcIS9JfNN1_OBjlwGUrd4yGvp2R-PW2-OOoQngQt5H5kiZIccxFAPswaN9G6wVpHuewtoEvUkT52UCzHPibVJh7iYY=@benis.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|DM4PR11MB7256:EE_
x-ms-office365-filtering-correlation-id: 6a3ad0be-5e56-4417-d0c2-08ddb86d2c80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WFBkci9vNklNa2E0SFlrL1ZSZ1M4bUhoR2V4RlZHS3ZHaXR3Q2xienNUVGFW?=
 =?utf-8?B?U3AzS0piWnJYQmN4bmxpYnl1RUhXd2psVlBIN0x4cHhkU2tqSlFiUTQxbHN2?=
 =?utf-8?B?K1VuRlNuUGxNZGFadm41MU9KRHBkZmFnc3daRzFRb0RaRlhWaWd4Tk5sVzJJ?=
 =?utf-8?B?WjlnOUFLbzFnZU53Q3lkeEVTdGxINnk2Q2dRb2tXVVBYbnM0eHAxbGx6OVJB?=
 =?utf-8?B?OWcwNWl0Sm1Ka1N0TFZwbmFsaUdiSXZIbTRzTmJUNmJYdEVGbTJlS0R1bys4?=
 =?utf-8?B?aFJOajBMUkxYdUZ4YTkrUGFhMGdXOEZUSlcxMGZSdGNCNklPeHJrUU1RcnJk?=
 =?utf-8?B?VDFVclhVR0RDbTZoQjhwTVNETkdUanZ5ZUFvK3ArTFhxWXlwanJvc0hiY1Jj?=
 =?utf-8?B?b1o0ajBlVnljZEo2ZXJuamI2TXgwNUtPUzBGSXB6bG5WbUlmYjBqSVlZTGt4?=
 =?utf-8?B?b3dFNTlybkR5L1hzNWlPNGhGNEQxaE53eEpadmp1Ni9uMFQ4aG5PL2tPVkZQ?=
 =?utf-8?B?U0drQ1hkTmtuaEh0dTQxZUpoMXpObHBTYXZVQVBIMTNSUDlrcXZJb1NSMkdw?=
 =?utf-8?B?NEgxVEJDT2g3NUZMeW1wMzUzTzY2ZWJJT1ptZCtER2pYK3NUK0dwcmJFcmZh?=
 =?utf-8?B?N2xhdkhrZUNxaHgyQUpBMlQ1alV5aWhIcVZGY0lxRXNMdWl0ZHBoR25rcUFa?=
 =?utf-8?B?bTFibTVieW84SlpLZE02OS9vNDc2UDJtZmY3bUpqTnpqVy9BN3YvcGIxWE1M?=
 =?utf-8?B?cUw4aFVwVDlnSE5YdnRWdlRkWnE3UXBRd1prUkJoaXFBeDNiSWhycklKM2Rq?=
 =?utf-8?B?dzFsSmtEYkVxT3FWY3IyNHlETjVQdndKWnVONm80azg4eE9lemYyeitlSFdG?=
 =?utf-8?B?RUFnR01LZm9BM0dkVmF4a1ZSNTg4aVVCVnNJcnNheDU5Ynk3YWpadll5Rk5v?=
 =?utf-8?B?ZU5SVFh4ZkNuWkx1Y0dHdzlVWHBRc1IzT0Z0dkxkZi8xcmRFOXJmTktaRjd0?=
 =?utf-8?B?anJyWFBKbDQ5ZnRzbVhkaUxNNzVYcjNabHZIdU1FTmhUU2JJazdHaFhVYVlZ?=
 =?utf-8?B?dHQrYi83V3pDSGRwZzJaYk1UUE1pWnBtVW5nS3hGQ1B0MlY3T0QveTFMQkEy?=
 =?utf-8?B?djl5TXYxYmdBeVlNUkJWWDloS2xpaEVzMWpWSnIzZ3d5c0Y0TklHQXNoV1Fi?=
 =?utf-8?B?ak5jN3dMQjRDUlhlWDlWa2hHSUdLdkovVlkrSlpxblozK0N3VlQvMEJ3MDlR?=
 =?utf-8?B?K1hLeFFER2t4NWZONnNDSEVUZVQ1ZTVLaGZZYkphRUMwanBFQVppRmR4M1Bk?=
 =?utf-8?B?blQybTBkK0p1Y0p6NUZ2NlZUdHE3RmVYRlhyMXF4ZUw3dEdYb2xsRFllbS9K?=
 =?utf-8?B?ejh6c3poVkJVL3dtL1pEWXFDU2ZNTkxzUVB6Rm9vMmwvQWJMVUNwZmNyWmxU?=
 =?utf-8?B?MmJ5dzFRTktVZEk5R2pCUW9YeXEreTZHazlGK3R6eUc4NmFtcjcyc3NWZ0F5?=
 =?utf-8?B?L2J5SitxVDdJN0ViRmxEQUZXWDd2enNkSXpGK2s1TnAxZXh3ek1aWHEzR2Jp?=
 =?utf-8?B?UzNXcnNtaG5lSlBZNFl2SVdKV1hKdElMVHl1NXJhWGs2TmxCODNxZWlrWHNo?=
 =?utf-8?B?Tm5xait5dWVvWHliWThIQVBRTGJqWUVVbFlEakQ2TkRCQUUrR25XVXNKYTJL?=
 =?utf-8?B?dWxKNE9OTGE0dEpMWGd6MCt3TWJwSXJ5R01vaXVDdmc1VGJhRWpnNUlTcnN2?=
 =?utf-8?B?SE8xQ0pxeHlKYlhBSCtoMXAzWU5uZlhiOWJDOVp0Ri9VR2w5U1dLTHdEcVho?=
 =?utf-8?B?aDJJNGxNK2tvamV0QmVtZ1hUUmM3eE90R01VY3JoZUZUbkxHNjY1V3Bnc2tV?=
 =?utf-8?B?VW1UdnRrRVFhdUZuTm1BTzlqNmxub1Fzd2RwK3gyQ0ZmZmR4WHBORjd4UWZm?=
 =?utf-8?Q?wffqRqWcthA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTFXSzdYcm9lWXUzQVBHV0JVSGx3aTh3LzNDQjF6NlNidFZqZnhNZXJ0MGcv?=
 =?utf-8?B?RXpid09NSS9kME9WY2U4SHZ5UW83NnFkcFJteVdwd3JGZlFSZkgvM2VNenNo?=
 =?utf-8?B?Z1BrSGFzKzhTK2NWUjV2dk1Tb0tJMUllRW1jR3oxb1ZCRnFnYmlOM0doT1RO?=
 =?utf-8?B?SjY2eS9CRFVqaFdEUW9EYkQ1dHgrZDNTNEFvUmNDWERIb3JnTWlYUWZEZVhw?=
 =?utf-8?B?YWQ2dzRObWNqczFqTDRRV0F0d3poV0xhckZjQVY5c2Q4N3RxUTRheWdOVWlO?=
 =?utf-8?B?dWg0NWgveVovTmgzdDhlUk9ZY3BjZDNzc0ZUSjlabTV5YkpmQ0Fyekp1RDRK?=
 =?utf-8?B?Z2s2Y1JrSUdxMVFWUTdkSDNLVThQbnRubTh4VVNpNjZxRzRmY245dktrMjVv?=
 =?utf-8?B?ZHIvdEFEME1CQ1dET0daeStCMExVZkdwYVZCaENFZUgxWjdrTjR1YU9uVzdv?=
 =?utf-8?B?L3M3bHIrTndieHV6Um13UDVlQW1BTG9CN1Q4SXpwbjdIbUVlNi9EUGNIVkZq?=
 =?utf-8?B?RFlwRWdvU0VSb2hEUU9HUDlCZEtTZjdrTDRYdzZJbzZINGRaTWpiN0ZlYXJH?=
 =?utf-8?B?QkwyNjIyeThBNFM1RG5xMThyam1HSzdPT2tmZm1Dck1rY1RTYnJPWjRwYTFY?=
 =?utf-8?B?U2Vqc2U2TnByVmNyamtCalV5Umczb0ErMExIVFVGTFNOWHJqU1B4QnFna0th?=
 =?utf-8?B?REU0RXFwNzRxY0dKaW13ZXZIZ3A3eWdTQkRwekJqRU5xdEhPVHMrdnY5ODhu?=
 =?utf-8?B?NzJqVFlURGRrNDBnb3NUdElxblp3dDRXbll3UVlwVFY0VEE0LzVLVGhBd0ZP?=
 =?utf-8?B?NTFvQnh5R3NnZXRobnh4SWNoV2E2Nk55SytWM0ZaZXkzNE95eVdCWHk1Y2JV?=
 =?utf-8?B?MEhYczk5V3dPcTJ3UzJGS240SzhIOWp6Q0oyNWtNT2JOdWRJMEFZbFFyczJZ?=
 =?utf-8?B?RytOeVdsUzIzbEFPc25ObDVaYU4zeFlpY21rNTdsNUJiNkZFTm8xbVZCalVY?=
 =?utf-8?B?SXFQekQzMVdxRTBreEgrUG45S2hwaE0rLzRkT3BEY2tmNEt1RUcrVFd6TUFR?=
 =?utf-8?B?UldMZ3RJOXNYVzVvdStiWVBvbkF5cDR4S2tQZUJ0MlRGYzU2K2dwUVU2RG5a?=
 =?utf-8?B?S3kzbFFLbFhDdiszZk9jMjRDTDU5ZHg1U0xVLzRrRVh2YzNIYmU3MkVPLytP?=
 =?utf-8?B?cHRxaDhtbkZJYWJJOGRNbDRyTUN0Qkt2a09acEpPU3E3bUlRaFJOK051Si95?=
 =?utf-8?B?M2pjZTNHMU1vRTVvVnRmcDNFNlZCcHBaVmJvNXZPeXNoWUw1N1JmOVFZbzNL?=
 =?utf-8?B?NXNzUzlmRG5jQk1oc1BGMGN2RXcvZUxOZWRWUUthc0QweW5DUE9YRUw1eG5Q?=
 =?utf-8?B?TTUzU0pZVVJGS0ZTRTRDd2ZlRHBjMU81MkE4dzlzOGlmeFRXMEc1cURjR0dW?=
 =?utf-8?B?bWNrZFB2QWxSWENnWHdZRWFIZVl4STVXVll3RU5GbWhXQWMyaE14bHZtUjB3?=
 =?utf-8?B?eHlOOURBU1VwdHhKNUFHQ01mNG94UzRSMkpjRC8vRUJyYjd1S1RGcXlraWkv?=
 =?utf-8?B?azBDS3I0bCt3QWZDdG5aRDFVVDZRTlFMOVUwY1BUZzNkTG14b0VzcWtBVzB2?=
 =?utf-8?B?YkFHZEg3d29DLzA2dzFxcEJVdDdrdmNvczJFOUgwdGdqVWgxYkhCbE5vWmRw?=
 =?utf-8?B?dmFYMWdtdkFUV2w2NGswWlU5QjJzS21YZm0yYmMvUkcrcDA0MXdGOTlQOEpm?=
 =?utf-8?B?bUJlZ2hTcVUzUnZrcnFaTm56KzJjczVSWm5hNWFla3MycU5aSFYwZWhYMzRK?=
 =?utf-8?B?OVdrckw0ZERjYnVJRHdjckhGeGxQYTY0MC9OQ1ZXLzhXTlpLZ0x3MGlmRXFQ?=
 =?utf-8?B?VnYybXVIOGJZR3BWUGVrbXZ0ek5PUHV6Zit4WDExOUtEVlNvTzRxc29pZkRX?=
 =?utf-8?B?QzQvTTdiMTNFWGd2RGlFakdMQnhYYXRlSTk5bUQxdmh3Z2NtUGpXbThpQXh1?=
 =?utf-8?B?a3ljTFpEWFVtUVJ4c0Z0WWc5NUx6SlErRGhTR2E1VWRNV3NERjVRalZRVzhF?=
 =?utf-8?B?aG5aTWJVQm0vbnRXdndHZHozVmsrNEFhV3c4Um9ZOUVxRzNIM2hTYUx2NjZC?=
 =?utf-8?B?U01BSmM5U2t6SXhsSnY3VHRZa3pBdGNCL3BhK3FNY2dzK1JIeDVhQktLN1BB?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BC8FA07B9283742AD11107512603578@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3ad0be-5e56-4417-d0c2-08ddb86d2c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 07:01:59.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhagMH6E265vTRXJ2nVjguQtdWqdy/EkwTpVGJ+dXHQDQhLO0JwNWSGJLVj84sDL/CNimWPtW8vreJSX4ca4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7256
X-OriginatorOrg: intel.com

PiA+ID4gDQo+ID4gPiBob3cgZG8geW91IHN1c3BlbmQgdGhlIHN5c3RlbT8gYW5kIGNhbiB5b3Ug
YXR0YWNoIHRoZSBkbWVzZyBvdXRwdXQNCj4gPiA+IGFmdGVyDQo+ID4gPiBzeXN0ZW0gInN1c3Bl
bmRlZCIgYW5kIHJlc3VtZWQ/DQo+ID4gDQo+ID4gDQo+ID4gV2lsbCB0ZXN0IGxhdGVyIQ0KPiAN
Cj4gaHR0cHM6Ly9kcml2ZS5iZW5pcy5zZS9zL3NCWlNGR0Fza3A3WVp5OA0KPiANCj4gSSBob3Bl
IHRoaXMgaXMgY29ycmVjdC4NCj4gDQo+IA0KWWVhaCwgdGhlIGxvZyBzaG93cyB0aGUgc3lzdGVt
IGluZGVlZCByYW4gYSBzMmlkbGUgY3ljbGUuDQpCdXQgdGhlcmUgaXMgbm90aGluZyBzdXNwaWNp
b3VzIGluIHRoZSBsb2cuIFRoZSBBQ1BJIGVycm9ycyBzaG91bGQgYWx3YXlzDQpiZSB0aGVyZSBu
byBtYXR0ZXIgaWYgdGhlcm1hbGQgaXMgYWN0aXZhdGVkIG9yIG5vdC4NCg0KY2FuIHlvdSBwbGVh
c2UgZG8gdGhlIGZvbGxvd2luZyB0ZXN0Pw0KMS4gbWFrZSBzdXJlIHRoZXJtYWxkIGlzIG5vdCBh
Y3RpdmF0ZWQNCjIuIGRvIGEgczJpZGxlIGN5Y2xlIGFuZCBtYWtlIHN1cmUgdGhhdCB0aGVyZSBp
cyBubyBmYW4gc3Bpbm5pbmcNCjMuIGxhdW5jaCB0aGVybWFsZCB3aXRoIC0tbG9nbGV2ZWw9ZGVi
dWcNCjQuIGRvIGEgczJpZGxlIGN5Y2xlIGFuZCBtYWtlIHN1cmUgdGhhdCB0aGUgZmFuIGlzIGlu
ZGVlZCBzcGlubmluZw0KNS4gYXR0YWNoIHRoZSBkbWVzZyBvdXRwdXQgYW5kIHRoZSBvdXRwdXQg
b2YgImpvdXJuYWxjdGwgLS1zaW5jZT0tMWggfA0KZ3JlcCB0aGVybWFsIiBhbmQgbGV0J3Mgc2Vl
IHdoYXQgY2hhbmdlcyB0aGVybWFsZCBoYXMgbWFkZS4NCg0KdGhhbmtzLA0KcnVpDQoNCg==

