Return-Path: <linux-pm+bounces-18494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDFC9E2735
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 17:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05842891E0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856F1F8937;
	Tue,  3 Dec 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxkwH+cn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62D1AB6C9
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242979; cv=fail; b=CnMpNSWKVUjouOMLAwSVa9SHaAKpRXlG8tSLZAQoK1JVPOAP4UlXIjj6phaTi87oRZMtolP6wZEKk3eDQiceuw/r/m/mXan+8oPIK1IawwjIjmBkCkEZtlu9Axk1zgAIZYlAIm7z5gIlx0wSrKETnld5dMvWsYwDW697xRJUPA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242979; c=relaxed/simple;
	bh=HJVLHql7RPHa2e2pRSnIOFEXdePnlXC515TNf4MFDqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KLJTqyQ8Q/8cgqsxrU4aiy5G0vXqqJ5bUJ7CSd7P+kIZZa9neo96GC0MIQZz+3GCZ76CcfTXhvRMS5p2OJiRqZnZ+7nwbaI5eBWGsDxLBCVzIcgUf3a2gKbQLnFyhgcHtfyXdMzX7MZXTX53b9dsPRL3ljuk5o6weUktro7MD8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxkwH+cn; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733242978; x=1764778978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HJVLHql7RPHa2e2pRSnIOFEXdePnlXC515TNf4MFDqA=;
  b=HxkwH+cnnN+gcBW5NLzYX3RTGgwCzNidpRhwDqy15DggvwYBv0m1aTfz
   /jK1SXdjzKDAMOUQZUg2XyxSqMP2zi44SRDZr1F7UUUG3ZiovqKls2vtJ
   ttZtTxMHxGqkMEMoz2DBDElHjQcvyDUOunarv9w4fTgUjjyvWxRs2EyBM
   dCsC6eZ4jQ8IX2BhkHQAAAmfe4tLzOXdAVNuFfqzBjSCJRuutam1ruD01
   HZPfRysCb8/a7veB/pzKWokoY68xAMDKuuC28prkU1zmUA+W6+cYTyonn
   I2bSZHHZgUxsMdzJQA64xwhMsQxCaPHai0cOk4XZOzeSqtV8dwAWTGn+I
   g==;
X-CSE-ConnectionGUID: jkmaEBf2Qbqsx5UP8zRk5g==
X-CSE-MsgGUID: G3rR1JwnSveAn/DxduIHJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="55954523"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="55954523"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 08:22:57 -0800
X-CSE-ConnectionGUID: K14IEGCoSMKpiSm2ZcogbQ==
X-CSE-MsgGUID: mn2AFUsxRB6TohV52cZC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93835749"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 08:22:56 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 08:22:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 08:22:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 08:22:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y10dTxKjvNdlS6goPqvowzSv2onxKauDVj0a71C33/SHqgBlIvho5S+LUQtiItVb4jarNBAcon7MiI4Tzrm+x1Tmt3lsrNd/QqbuG9tUYtZUh8+GHB8i4u1/STiFVyVcQ7AVCWi1GtFYZAOKI8sP84Fy3IfZnoQhZfsTccNfChnY5ff8+U39cQmg45Xy7QzwcntdVVtyj6TW2Zw/GoKfzMHLyEUBSEhDVnyj0YPsEAgaJXUvHqoTz9M300qy/3MtrWt8QBaz5NWr8cDhoAsvnUQO657wOILXyfds9jmq/0H7zGRg2bf/8fR13EN/oOauJYbGBsHf4rnT1CNuHV8ZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJVLHql7RPHa2e2pRSnIOFEXdePnlXC515TNf4MFDqA=;
 b=gQgIRCBqnRTZbiJ0MqdUz8nuJUB+QBojJgpElimUJ1Z+xOhxFDLuembKovXEcvep0ewY8Zphb1ANarPVRM7hbDdMccOaJSQhMztg5UXfmH90GuT6rjiFxH3NF55DF/tvMgNVtWxwdp4xEDoeS02JOTKp9nqU/IeK18W1Qoh6RVlfmbWre06OdI2BWcQxNtEeYgA0Encn278+kDZJNkt1HEr1ivh1AkjbajEVTHtfpiB0b+dBLrUrN8bwcdvCnV0N2EcqSHyvJ5xz2Btpu3BxsZqn7/gNWQd3sqmkCMYVNEmWTr27rZZ1sFi801KEbs4L8ZSyZSgKMfg/pRy393Bx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Tue, 3 Dec 2024 16:22:52 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 16:22:52 +0000
From: "Saarinen, Jani" <jani.saarinen@intel.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Borah,
 Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, "Krogerus, Heikki"
	<heikki.krogerus@intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, "Kurmi, Suresh Kumar"
	<suresh.kumar.kurmi@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>,
	"Nikula, Jani" <jani.nikula@intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: RE: Regression on linux-next (next-20241120) and drm-tip
Thread-Topic: Regression on linux-next (next-20241120) and drm-tip
Thread-Index: AdtFPvBukA2w7biuRBKjE+4t+kPk7gAAkQcQAAOfroAACp3TAAAAUkEAAAU2ZoAAAJkJAAABhCTQAADR2IAAAF55gAAAfsPA
Date: Tue, 3 Dec 2024 16:22:52 +0000
Message-ID: <DM8PR11MB5655708BD0D1FAA569A3F010E0362@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
 <56d574c6-6eab-4388-8cb8-70cd615a8941@t-8ch.de>
 <CAJZ5v0gFwu+6Cm7ORs7+TAc5jzXZRBO1uGcttBTTvK4OqT3Q6g@mail.gmail.com>
 <2ad31476-3f37-43cb-96cf-379d50d7b799@t-8ch.de>
 <SJ1PR11MB61295BDE8405A1A5FFC1CB7FB9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <1ed0ba64-4e8d-416a-8718-34e7f045d443@t-8ch.de>
 <886084c8-2f5e-4f89-bd10-e9c2a24b0aea@t-8ch.de>
In-Reply-To: <886084c8-2f5e-4f89-bd10-e9c2a24b0aea@t-8ch.de>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: heikki.krogerus@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|DM4PR11MB7181:EE_
x-ms-office365-filtering-correlation-id: df07e9fb-1713-4b79-91e1-08dd13b6bc9d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHpsbVFLWDBIVDB3ZUIrN3FTSS9XNHhKem8zdVQ4NWFPUjFabHJTSHJaRzN3?=
 =?utf-8?B?TGZncm5kaERRZzZaaGJyMmdJc2dXeXYrU0xEZnV4QjhiWi9vdFlDb3lZWTVS?=
 =?utf-8?B?NkhjSlJ5UlRIL29JcjdBKzd1TzNTb0JObkpoTlF4UkpyZkRMbndNZWtpdWJh?=
 =?utf-8?B?TnlDZm01WXdaQkJtQkZFd04vSm9KVlVldzI3ekt6a3VTQVdtamlqcWVWbWtr?=
 =?utf-8?B?YWc1YlZSREFpNk1LQ1JCNmExVUpZVU9YSXZNSVhTSU5OZS9SeTgxMW41NFov?=
 =?utf-8?B?RWFvUDI3S3BhTktaSWw0RG1tTXJ6ZW0wZytUNmV1Q1UvWTlPUFJETTRDSDkw?=
 =?utf-8?B?V1M0Q2I3aXNaTU5XaEJoV1V3c2pSUEFIMmpjM21yeUNTcExUeGVYMjRZRzl3?=
 =?utf-8?B?Y1JSOUZrZGo3bXZiSzJVZlJ4RGJ5cEJ3R2MrV251a1kwckVET0hLZGppVUNB?=
 =?utf-8?B?dnovVEFCT3BFcjdxRFFFbVFmN2RKQlpsTjZBMlNhUDM5RnZsWk0vYWZYbTd6?=
 =?utf-8?B?QTRlazllM2xJMFl2YjRUak1ETnQvZVcwOSswRUEyQ3pjOFZDaWRKTU92c0po?=
 =?utf-8?B?T21WbkJodkNMckZtaHdJWURpTGRDZjU2R2g4RG5IQ3IzNHVkWFBtNXJ6dUx2?=
 =?utf-8?B?aktjWFlhbnNaQyszaWVnRmpMUFUrOHpTWWJ4ZTJwMUk1dytXcHdBbTNRTUlt?=
 =?utf-8?B?YTRlODRKWm1qQmk5OHk3OTFYSTFCaFNzajRoOGllTHMySzRvdkJtM0M3UkI3?=
 =?utf-8?B?d3lGUzJGeE9hYWh3MVRCRFhEd2txT0NrMW0vMjRERm9jSm1kNHVVTVVaRUxt?=
 =?utf-8?B?Ym5kZFR2SFppK0xPeXBBQ3E5VlUvOGhqYWMzb0xvR1dYNmw5WWRxbXRtdVAv?=
 =?utf-8?B?THRmbVBIK1V6UVM2NWFFMkd1cWlxZTNTVlUxY3BPR3hXWWtNZDBZb1A5SWt0?=
 =?utf-8?B?YW15SGNXWHdxeS9RUnRaVGhFTm12QTZVRGo0RTN6S3daVUNseEhsMTlGNDR4?=
 =?utf-8?B?d21ybWV4djcxN1RBUCtuNTNFRVk5YkEvTGVwYmw3Q2pPMnlEOEpWUDQ4SCs5?=
 =?utf-8?B?em9tdUxFSldlOHpqSU1MeGVhaHVDakxGcWg5RWwxQTVmOGVOY1d2LzNZYWta?=
 =?utf-8?B?aE9Ya2VYckhWWmZBV2hFa3JDWkVJbTRmR1hsemRudFF0T0lDK3A3WmJkNEky?=
 =?utf-8?B?Uk54SFJXV0g3SFdTTkFzWndQcm11UHNEaHhZSk0vRzBKTm95aEdSNFRZVXZV?=
 =?utf-8?B?ZnVjU0h4NXJYbzVtc0V3UGVkTXYvQ25tck0rdktBckxPcGpDNEZSSmpzMUtn?=
 =?utf-8?B?QnYxajkvRm5tTWlyMVdvMmlzckZFZXhySENVdVVTc1lzekdsd1A0dGJFZVdI?=
 =?utf-8?B?VXVXSG9vRklhZzNVVWM3STZvZ0F5d2RSM3dPZDZEYmY3S0xIZWpya2s3ejQ2?=
 =?utf-8?B?M2lGQW1iRGhqMjB6bHBqYzhKVDJvODVkOE56N040SCtKV2JLdm13NVo5ajl3?=
 =?utf-8?B?RkY2NCszdld4NU9hK0VZbVBjTEl6bUxYeHVPYmJ6b3BscTE4UGFNbk8xY3or?=
 =?utf-8?B?UmVLSHpjS0NiSllObXdjU2ZWOWZFcnlZWXlTdFpwWldaYlZ1bEJSMzVIMmlo?=
 =?utf-8?B?dzcwUTZOajdpVUt3VmlCVVZpRzRjTCt4Sk9KbkFsUDQ3Z1Z0STZOS003Y2hq?=
 =?utf-8?B?cE9mTUNYOGFYRlI0ZXNYOFVWamZEZkRIOHIrcFRXb3o0WnVEWVQ3QWFhY2JY?=
 =?utf-8?B?UldDMG1qWXE5R05CSEJOL0FnaXUySjFOUjlUc0JuVWhKaTh3c3B4T29QSkR5?=
 =?utf-8?Q?n0WFOOfx385UaDUcsuvk2fTXO10THmAN8BAps=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjlJb3Z2ODFKK2xSRzdKaGZIeC9vSmkvclhFSXJFQVdMS0VxcHhlbVdHSGQr?=
 =?utf-8?B?Nks3Sll4Tm5RWVRFcTFONnY1ZVBXTGVPUmc3VGExM294SVRwcWhlZXg4Wit5?=
 =?utf-8?B?a2VweFRYZC9LaDgrbXF2VGdwNzI0TnpZbjdkbkNvSTdGZHRmVVFDTytMeitJ?=
 =?utf-8?B?cUJOK256QWJpbEFxT21wblFOM0RHTEpqMXNGMjY1YUpXQ2FHZ1ZYbHRFR2lr?=
 =?utf-8?B?YjFRRGIwZUlLZDE2Q3RDejBDZ1djZnFRK0Njc3g0YUloTnIya0ZORVdpdkcr?=
 =?utf-8?B?eVRjWVFoeHpPZUVGRHFsS1NWTXA0ZTczTlR2STNReThidWt6cllhTm1vbkZD?=
 =?utf-8?B?RG1MYXZJZkxkZ2FwVXJJbUo1OVVreUtSY2p1b1I0YjFjM3A3eXRic3B1MlZY?=
 =?utf-8?B?TVB6NHRaemIzRDJtMlBENzk2eWp1b242c3NVN1JvbGs3Tnp2a0w2aTE5VSt4?=
 =?utf-8?B?cDluYnhrMEZuTkFNWEF6MmRDdnJKeWFYdkQ2VDRCL1dnSjk3V3VJNC8zMG0x?=
 =?utf-8?B?cThvUDFCWU90ajFUZkVwZitrc0JGVEFlSUcrZURvVHRrMVhGU0M5aE5wWmlS?=
 =?utf-8?B?bmV3OVBzdzlVdDl0emtmYWhzK2RvSk94a2xCSUZ3dG5NV0J3REZyVHpzalRX?=
 =?utf-8?B?a2kxY2w0ZjhHOHhlSEYvZkh4VitrcDBka1Blb1BIb1FRN2E0SjNXZlE2RkNx?=
 =?utf-8?B?MCtsSENMckMzamFHOWFZVXJ0T0ViMnlCTm42Vkx4ZGUrQllCNlB5QzEwaEcy?=
 =?utf-8?B?WWtyTVZObGgreEFyUW05WDFuMG50aTRlUU5BTnhzNGRod1Z5c0NkUDFsQjg1?=
 =?utf-8?B?NEhnR2VHVmZQQi9DV2FUbUFCNktudVVPWFp1ZTZWaGFrQ3B1dWU1dEpHZHlV?=
 =?utf-8?B?VFBIUG03eDFiY2pmaDY2bTRQRURoWkpTU20wNlJOMk9BM0lXUk0yMVcrRnRR?=
 =?utf-8?B?R2J1S21SUlhjQ3JEWjlTays4ZXBURXJhb3d4djFaVTlNRVRKSzg3cmU4MVZL?=
 =?utf-8?B?QUhIV0dsczlZdkJPeG1OU0ZkZ01lTSthZHdxcTVlWkJSaEVkdVBrdHhVVzVJ?=
 =?utf-8?B?cXp6aTZkN1NQWldUN0VqUmJJUDM1SGVDRHFKd1RuaHdTK2xpeVZ2K3pxcE5x?=
 =?utf-8?B?cWx1ZkdFN2x0THprV1pKdTI3TkJ6WndKamRJd05Pd1BDVGEyMzhTbFpFOXpX?=
 =?utf-8?B?RGNtTTlpanNDZ0lHWStFSnZHd1hLYkhmeDkxSU9jTytWY1g2UUtIYVZFWUdD?=
 =?utf-8?B?a0gydUJFU2VsSWJGYVJ1UXQrZG9TRWhLWXFaczR6Rm9IUWdlcCt6QVFscVYz?=
 =?utf-8?B?SE5QWnlRNVc1NG9CNnUwNjBES3ZQV2FoZlhXT3gzemVjR0Nqeituakh1bE5S?=
 =?utf-8?B?bkdHWXdHcmtwM0hIMXNsQUZBUGtqYmo5NE9qdnluWXpVYmRSOWQ5dktNNmJL?=
 =?utf-8?B?SlAxMlpjcmJmRnpkL28zbFVHalU4Z3ZqNWVuaXhOS3R0eUFUSFZBcXJaUDJM?=
 =?utf-8?B?YWpsa0dIck1rUFY0b09nRmdSdDV5MkpNTnU3WjlhckRONU1jMEJTUVNWQnhG?=
 =?utf-8?B?YnVvVlJUOThZZTdCU2crV2hnZy9rckdIeXAxOXFQSnVxZmRIbEc2VklkcjhD?=
 =?utf-8?B?YjRvMWhHY045U3RBcVFkSXJyMTE3RzQ5QTJsMFJoU1p1bnJpUlNDWDZNKzNO?=
 =?utf-8?B?eXVLVDU5RUhWSWJaOTJxWnFvUlFDT1JKblZ1d3FpVitjTkhoYys4cU4wTkJP?=
 =?utf-8?B?MVpNbWp1Ym5IK1Q1UVROUnRuY3pHeVhnZzgzUDRGZFhVOG9CL2hvdDFTajBE?=
 =?utf-8?B?WVR2Mi9XSWtQejJHWWZkUnRnY3JuNlFRMjBPbTkwMnlvY3VvZzhkaTZGd0Uv?=
 =?utf-8?B?T3FlSzlGMFUwYnpISzF6NVVqOTdhUFpIN29GNVNld2x1cXVUZHYyZ1JncDVG?=
 =?utf-8?B?WDJLbi9IMERpRHI5ZXNrSmdqTFZJV05WK0FWcVNiK2VRc2RZbURUWkxYQkd1?=
 =?utf-8?B?TzdRYU83ak5HdEpLcndwODZUY3pzVHdDL0x0dkJ6QSttdUFkWWltU0V1b09N?=
 =?utf-8?B?V1o2ZWF1UVFkQ0YxQ3d4dWhUUWNFczlFcVk0QU04b3RJR2tBWm9hd2ZieC9E?=
 =?utf-8?Q?/YfDH5fb25N3EPjIBc8pvX8fd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df07e9fb-1713-4b79-91e1-08dd13b6bc9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 16:22:52.5623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ihrWPDTHJ32YVFCKPGNsDL3rYL4SJl9/Bti2nLxUTxDkZi8dk0192ky1YvU0i181lETy+MErVOOtJIYYz5GDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7181
X-OriginatorOrg: intel.com

K0BLcm9nZXJ1cywgSGVpa2tpIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IFRob21hcyBXZWnDn3NjaHVoIDxsaW51eEB3ZWlzc3NjaHVoLm5ldD4NCj4gU2VudDogVHVl
c2RheSwgMyBEZWNlbWJlciAyMDI0IDE4LjA4DQo+IFRvOiBCb3JhaCwgQ2hhaXRhbnlhIEt1bWFy
IDxjaGFpdGFueWEua3VtYXIuYm9yYWhAaW50ZWwuY29tPg0KPiBDYzogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgS3VybWksIFN1cmVzaCBLdW1hcg0KPiA8c3VyZXNoLmt1
bWFyLmt1cm1pQGludGVsLmNvbT47IENvZWxobywgTHVjaWFubyA8bHVjaWFuby5jb2VsaG9AaW50
ZWwuY29tPjsNCj4gU2FhcmluZW4sIEphbmkgPGphbmkuc2FhcmluZW5AaW50ZWwuY29tPjsgTmlr
dWxhLCBKYW5pIDxqYW5pLm5pa3VsYUBpbnRlbC5jb20+Ow0KPiBEZSBNYXJjaGksIEx1Y2FzIDxs
dWNhcy5kZW1hcmNoaUBpbnRlbC5jb20+OyBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Ow0KPiBpbnRlbC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZzsgU2ViYXN0aWFuIFJlaWNoZWwNCj4gPHNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9yYS5j
b20+DQo+IFN1YmplY3Q6IFJlOiBSZWdyZXNzaW9uIG9uIGxpbnV4LW5leHQgKG5leHQtMjAyNDEx
MjApIGFuZCBkcm0tdGlwDQo+IA0KPiBPbiAyMDI0LTEyLTAzIDE2OjU3OjIxKzAxMDAsIFRob21h
cyBXZWnDn3NjaHVoIHdyb3RlOg0KPiA+IE9uIDIwMjQtMTItMDMgMTU6NDI6MjMrMDAwMCwgQm9y
YWgsIENoYWl0YW55YSBLdW1hciB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBUaG9tYXMgV2Vpw59zY2h1aCA8bGlu
dXhAd2Vpc3NzY2h1aC5uZXQ+DQo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDMsIDIw
MjQgODoyMCBQTQ0KPiA+ID4gPiBUbzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwu
b3JnPg0KPiA+ID4gPiBDYzogQm9yYWgsIENoYWl0YW55YSBLdW1hciA8Y2hhaXRhbnlhLmt1bWFy
LmJvcmFoQGludGVsLmNvbT47DQo+ID4gPiA+IEt1cm1pLCBTdXJlc2ggS3VtYXIgPHN1cmVzaC5r
dW1hci5rdXJtaUBpbnRlbC5jb20+OyBDb2VsaG8sDQo+ID4gPiA+IEx1Y2lhbm8gPGx1Y2lhbm8u
Y29lbGhvQGludGVsLmNvbT47IFNhYXJpbmVuLCBKYW5pDQo+ID4gPiA+IDxqYW5pLnNhYXJpbmVu
QGludGVsLmNvbT47IE5pa3VsYSwgSmFuaSA8amFuaS5uaWt1bGFAaW50ZWwuY29tPjsNCj4gPiA+
ID4gRGUgTWFyY2hpLCBMdWNhcyA8bHVjYXMuZGVtYXJjaGlAaW50ZWwuY29tPjsNCj4gPiA+ID4g
aW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtIHhlQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsNCj4gPiA+ID4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBTZWJhc3RpYW4gUmVp
Y2hlbA0KPiA+ID4gPiA8c2ViYXN0aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvbT4NCj4gPiA+ID4g
U3ViamVjdDogUmU6IFJlZ3Jlc3Npb24gb24gbGludXgtbmV4dCAobmV4dC0yMDI0MTEyMCkgYW5k
IGRybS10aXANCj4gPiA+ID4NCj4gPiA+ID4gT24gMjAyNC0xMi0wMyAxNTozMzoyMSswMTAwLCBS
YWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIERlYyAzLCAyMDI0IGF0
IDE6MDTigK9QTSBUaG9tYXMgV2Vpw59zY2h1aA0KPiA+ID4gPiA8bGludXhAd2Vpc3NzY2h1aC5u
ZXQ+IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uIDIwMjQtMTItMDMgMTI6NTQ6
NTQrMDEwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IE9uIFR1ZSwg
RGVjIDMsIDIwMjQgYXQgNzo1MeKAr0FNIFRob21hcyBXZWnDn3NjaHVoDQo+ID4gPiA+IDxsaW51
eEB3ZWlzc3NjaHVoLm5ldD4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
PiAoK0NjIFNlYmFzdGlhbikNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEhpIENo
YWl0YW55YSwNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IE9uIDIwMjQtMTItMDMg
MDU6MDc6NDcrMDAwMCwgQm9yYWgsIENoYWl0YW55YSBLdW1hciB3cm90ZToNCj4gPiA+ID4gPiA+
ID4gPiA+IEhvcGUgeW91IGFyZSBkb2luZyB3ZWxsLiBJIGFtIENoYWl0YW55YSBmcm9tIHRoZSBs
aW51eA0KPiA+ID4gPiA+ID4gPiA+ID4gZ3JhcGhpY3MgdGVhbQ0KPiA+ID4gPiBpbiBJbnRlbC4N
Cj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIG1haWwgaXMgcmVnYXJk
aW5nIGEgcmVncmVzc2lvbiB3ZSBhcmUgc2VlaW5nIGluIG91cg0KPiA+ID4gPiA+ID4gPiA+ID4g
Q0kgcnVuc1sxXSBvbg0KPiA+ID4gPiBsaW51eC1uZXh0IHJlcG9zaXRvcnkuDQo+ID4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBUaGFua3MgZm9yIHRoZSByZXBvcnQuDQo+ID4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IFNpbmNlIHRoZSB2ZXJzaW9uIG5leHQtMjAyNDExMjAg
WzJdLCB3ZSBhcmUgc2VlaW5nIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gZm9sbG93aW5nIHJlZ3Jl
c3Npb24NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGANCj4gPiA+ID4gPiA+ID4gPiA+IDw0PlsgICAxOS45OTA3NDNdIE9vcHM6IGdl
bmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5vbi0NCj4gPiA+ID4gY2Fub25p
Y2FsIGFkZHJlc3MgMHhiMTE2NzVlZjhkMWNjYmNlOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9Q
VEkNCj4gPiA+ID4gPiA+ID4gPiA+IDw0PlsgICAxOS45OTA3NjBdIENQVTogMjEgVUlEOiAxMTAg
UElEOiA4NjcgQ29tbTogcHJvbWV0aGV1cy0NCj4gPiA+ID4gbm9kZSBOb3QgdGFpbnRlZCA2LjEy
LjAtbmV4dC0yMDI0MTEyMC1uZXh0LTIwMjQxMTIwLWdhYzI0ZTI2YWEwOGYrDQo+ID4gPiA+ICMx
DQo+ID4gPiA+ID4gPiA+ID4gPiA8ND5bICAgMTkuOTkwNzcxXSBIYXJkd2FyZSBuYW1lOiBJbnRl
bCBDb3Jwb3JhdGlvbiBBcnJvdyBMYWtlDQo+ID4gPiA+IENsaWVudCBQbGF0Zm9ybS9NVEwtUyBV
RElNTSAyRFBDIEVWQ1JCLCBCSU9TDQo+ID4gPiA+IE1UTFNGV0kxLlIwMC40NDAwLkQ4NS4yNDEw
MTAwMDA3IDEwLzEwLzIwMjQNCj4gPiA+ID4gPiA+ID4gPiA+IDw0PlsgICAxOS45OTA3ODJdIFJJ
UDoNCj4gMDAxMDpwb3dlcl9zdXBwbHlfZ2V0X3Byb3BlcnR5KzB4M2UvMHhlMA0KPiA+ID4gPiA+
ID4gPiA+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGANCj4gPiA+ID4gPiA+ID4gPiA+IGBgYGBgYCBgYGBgYGBgYGBgYGBgYGBgYGBgIERl
dGFpbHMgbG9nIGNhbiBiZSBmb3VuZCBpbg0KPiA+ID4gPiA+ID4gPiA+ID4gWzNdLg0KPiA+ID4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IEFmdGVyIGJpc2VjdGluZyB0aGUgdHJlZSwg
dGhlIGZvbGxvd2luZyBwYXRjaCBbNF0gc2VlbXMNCj4gPiA+ID4gPiA+ID4gPiA+IHRvIGJlIHRo
ZSBmaXJzdA0KPiA+ID4gPiAiYmFkIg0KPiA+ID4gPiA+ID4gPiA+ID4gY29tbWl0DQo+ID4gPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPiA+ID4gPiA+ID4gPiA+IGBgYGBgYCBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgDQo+ID4gPiA+ID4gPiA+
ID4gPiBDb21taXQgNDkwMDBmZWU5ZTYzOWY2MmJhMWY5NjVlZDJhZTRjNWFkMThkMTllMg0KPiA+
ID4gPiA+ID4gPiA+ID4gQXV0aG9yOiAgICAgVGhvbWFzIFdlacOfc2NodWggPG1haWx0bzpsaW51
eEB3ZWlzc3NjaHVoLm5ldD4NCj4gPiA+ID4gPiA+ID4gPiA+IEF1dGhvckRhdGU6IFNhdCBPY3Qg
NSAxMjowNTowMyAyMDI0ICswMjAwDQo+ID4gPiA+ID4gPiA+ID4gPiBDb21taXQ6ICAgICBTZWJh
c3RpYW4gUmVpY2hlbA0KPiA+ID4gPiA8bWFpbHRvOnNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9y
YS5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiBDb21taXREYXRlOiBUdWUgT2N0IDE1IDIyOjIyOjIw
IDIwMjQgKzAyMDANCj4gPiA+ID4gPiA+ID4gPiA+ICAgICBwb3dlcjogc3VwcGx5OiBjb3JlOiBh
ZGQgd2FrZXVwIHNvdXJjZSBpbmhpYml0IGJ5DQo+ID4gPiA+ID4gPiA+ID4gPiBwb3dlcl9zdXBw
bHlfY29uZmlnDQo+ID4gPiA+ID4gPiA+ID4gPiBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYA0KPiA+ID4gPiA+ID4gPiA+ID4gYGBgYGBgIGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIG5vdyBzZWVuIGluIG91ciBkcm0tdGlwIHJ1
bnMgYXMgd2VsbC4gWzVdDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gQ291
bGQgeW91IHBsZWFzZSBjaGVjayB3aHkgdGhlIHBhdGNoIGNhdXNlcyB0aGlzDQo+ID4gPiA+ID4g
PiA+ID4gPiByZWdyZXNzaW9uIGFuZA0KPiA+ID4gPiBwcm92aWRlIGEgZml4IGlmIG5lY2Vzc2Fy
eT8NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3Qgc2VlIGhvdyB0aGlz
IHBhdGNoIGNhbiBsZWFkIHRvIHRoaXMgZXJyb3IuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+IEl0IGxvb2tzIGxpa2UgdGhlIGNmZy0+bm9fd2FrZXVwX3NvdXJjZSBhY2Nlc3MgcmVhY2hl
cw0KPiA+ID4gPiA+ID4gPiBiZXlvbmQgdGhlIHN0cnVjdCBib3VuZGFyeSBmb3Igc29tZSByZWFz
b24uDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQnV0IHRoZSBhY2Nlc3MgdG8gdGhpcyBmaWVs
ZCBpcyBvbmx5IGRvbmUgaW4gX19wb3dlcl9zdXBwbHlfcmVnaXN0ZXIoKS4NCj4gPiA+ID4gPiA+
IFRoZSBlcnJvciByZXBvcnRzIGhvd2V2ZXIgZG9uJ3Qgc2hvdyB0aGlzIGZ1bmN0aW9uIGF0IGFs
bCwNCj4gPiA+ID4gPiA+IHRoZXkgY29tZSBmcm9tIHBvd2VyX3N1cHBseV91ZXZlbnQoKSBhbmQN
Cj4gPiA+ID4gPiA+IHBvd2VyX3N1cHBseV9nZXRfcHJvcGVydHkoKSBieSB3aGljaCB0aW1lIHRo
ZSBjYWxsIHRvDQo+IF9fcG93ZXJfc3VwcGx5X3JlZ2lzdGVyKCkgaXMgbG9uZyBvdmVyLg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZXSVcgdGhlcmUgaXMgYW4gdW5pbml0aWFsaXplZCAnc3Ry
dWN0IHBvd2VyX3N1cHBseV9jb25maWcnIGluDQo+ID4gPiA+ID4gPiBkcml2ZXJzL2hpZC9oaWQt
Y29yc2Fpci12b2lkLmMuIEJ1dCBJIGhpZ2hseSBkb3VidCB0aGUgdGVzdA0KPiA+ID4gPiA+ID4g
bWFjaGluZXMgYXJlIHVzaW5nIHRoYXQuIChJJ2xsIHNlbmQgYSBwYXRjaCBsYXRlciBmb3IgaXQp
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTbyB0aGUgb25seSB3YXkgSSBjYW4gdGhpbmsgYWJvdXQg
aW4gd2hpY2ggdGhlIGNvbW1pdCBpbg0KPiA+ID4gPiA+IHF1ZXN0aW9uIG1heSBsZWFkIHRvIHRo
ZSByZXBvcnRlZCBpc3N1ZXMgaXMgdGhhdCBjaGFuZ2luZyB0aGUNCj4gPiA+ID4gPiBzaXplIG9m
IHN0cnVjdCBwb3dlcl9zdXBwbHlfY29uZmlnIG9yIGl0cyBhbGlnbm1lbnQgbWFrZXMgYW4NCj4g
PiA+ID4gPiB1bmV4cGVjdGVkIGZ1bmN0aW9uYWwgZGlmZmVyZW5jZSBzb21ld2hlcmUuDQo+ID4g
PiA+DQo+ID4gPiA+IEluZGVlZC4gSSdkIHJlYWxseSBsaWtlIHRvIHNlZSB0aGlzIGlzc3VlIHJl
cHJvZHVjZWQgd2l0aCBLQVNBTi4NCj4gPiA+ID4NCj4gPiA+ID4gPiBBRkFJQ1MsIHRoaXMgY29t
bWl0IGNhbm5vdCBiZSByZXZlcnRlZCBieSBpdHNlbGYsIHNvIHdoaWNoDQo+ID4gPiA+ID4gY29t
bWl0cyBvbiB0b3Agb2YgaXQgbmVlZCB0byBiZSByZXZlcnRlZCBpbiBvcmRlciB0byByZXZlcnQg
aXQgY2xlYW5seT8NCj4gPiA+ID4NCj4gPiA+ID4gQWxsIHRoZSBvdGhlciBwYXRjaGVzIGZyb20g
dGhpcyBzZXJpZXM6DQo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDEw
MDUtcG93ZXItc3VwcGx5LW5vLXdha2V1cC1zb3VyYw0KPiA+ID4gPiBlLXYxLQ0KPiA+ID4gPiAw
LTFkNjJiZjliY2IxZEB3ZWlzc3NjaHVoLm5ldC8NCj4gPiA+ID4NCj4gPiA+ID4gQ291bGQgeW91
IHBvaW50IG1lIHRvIHRoZSBmdWxsIGJvb3QgbG9nIGluIHRoZSBkcm0tdGlwIENJPw0KPiA+ID4N
Cj4gPiA+IEhlcmUgaXMgdGhlIGxvZyBmb3IgZHJtLXRpcCBDSQ0KPiA+ID4NCj4gPiA+IGh0dHBz
Oi8vaW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2RybS10aXAvSUdUXzgxMzYvYmF0LWFybHMtNS9i
b290MC50DQo+ID4gPiB4dA0KPiA+DQo+ID4gVGhhbmtzIQ0KPiA+DQo+ID4gPiBJIGNhcnJpZWQg
b3V0IGFub3RoZXIgYmlzZWN0IGFuZCBpdCBwb2ludHMgdG8gdGhlIGZvbGxvd2luZyBjb21taXQN
Cj4gPiA+DQo+ID4gPiBjb21taXQgMjI2ZmYyZTY4MWQwMDZlYWRhNTlhOTY5M2FhMTk3NmQ0YzE1
YTdkNA0KPiA+ID4gQXV0aG9yOiBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51
eC5pbnRlbC5jb20+DQo+ID4gPiBEYXRlOiAgIFdlZCBOb3YgNiAxNzowNjowNSAyMDI0ICswMjAw
DQo+ID4gPg0KPiA+ID4gICAgIHVzYjogdHlwZWM6IHVjc2k6IENvbnZlcnQgY29ubmVjdG9yIHNw
ZWNpZmljIGNvbW1hbmRzIHRvIGJpdG1hcHMNCj4gPiA+DQo+ID4gPiAgICAgVGhhdCBhbGxvd3Mg
dGhlIGZpZWxkcyBpbiB0aG9zZSBjb21tYW5kIGRhdGEgc3RydWN0dXJlcyB0bw0KPiA+ID4gICAg
IGJlIGVhc2lseSB2YWxpZGF0ZWQuIElmIGFuIHVuc3VwcG9ydGVkIGZpZWxkIGlzIGFjY2Vzc2Vk
LCBhDQo+ID4gPiAgICAgd2FybmluZyBpcyBnZW5lcmF0ZWQuDQo+ID4NCj4gPiBTdXNwaWNvdXM6
IFRoZSBiaXRtYXBzIGludHJvZHVjZWQgaW4gdGhpcyBjb21taXQgYXJlIHJpZ2h0IGJlZm9yZSB0
aGUNCj4gPiBwc3kgYW5kIHBzeV9kZXNjIG1lbWJlcnMgb2YgJ3N0cnVjdCB1Y3NpX2Nvbm5lY3Rv
cicuDQo+ID4gU28gYW55IG91dC1vZi1ib3VuZHMgd3JpdGVzIGludG8gdGhlc2UgbWVtYmVycyB3
b3VsZCBjb3JydXB0IHRob3NlDQo+ID4gZmllbGRzLg0KPiA+IEEgY29ycnVwdGVkIHBvd2VyX3N1
cHBseV9kZXNjIHdvdWxkIGZpdCBib3RoIHJlcG9ydGVkIHN0YWNrdHJhY2VzLg0KPiANCj4gc3Ry
dWN0IHVjc2lfY29ubmVjdG9yIHsNCj4gCS4uLg0KPiANCj4gICAgICAgICBzdHJ1Y3QgdHlwZWNf
Y2FwYWJpbGl0eSB0eXBlY19jYXA7DQo+IA0KPiAgICAgICAgLyogQ2FjaGVkIGNvbW1hbmQgcmVz
cG9uc2VzLiAqLw0KPiAgICAgICAgREVDTEFSRV9CSVRNQVAoY2FwLCBVQ1NJX0dFVF9DT05ORUNU
T1JfQ0FQQUJJTElUWV9TSVpFKTsNCj4gICAgICAgIERFQ0xBUkVfQklUTUFQKHN0YXR1cywgVUNT
SV9HRVRfQ09OTkVDVE9SX1NUQVRVU19TSVpFKTsNCj4gDQo+IERFQ0xBUkVfQklUTUFQKCkgdGFr
ZXMgdGhlIHNpemUgaW4gbnVtYmVyIG9mICpiaXRzKg0KPiANCj4gICAgICAgICBzdHJ1Y3QgcG93
ZXJfc3VwcGx5ICpwc3k7DQo+ICAgICAgICAgc3RydWN0IHBvd2VyX3N1cHBseV9kZXNjIHBzeV9k
ZXNjOw0KPiAgICAgICAgIHUzMiByZG87DQo+IA0KPiAJLi4uDQo+IH0NCj4gDQo+IHN0YXRpYyBp
bnQgdWNzaV9nZXRfY29ubmVjdG9yX3N0YXR1cyhzdHJ1Y3QgdWNzaV9jb25uZWN0b3IgKmNvbiwg
Ym9vbCBjb25uX2Fjaykgew0KPiAJdTY0IGNvbW1hbmQgPSBVQ1NJX0dFVF9DT05ORUNUT1JfU1RB
VFVTIHwNCj4gVUNTSV9DT05ORUNUT1JfTlVNQkVSKGNvbi0+bnVtKTsNCj4gCXNpemVfdCBzaXpl
ID0gbWluKFVDU0lfR0VUX0NPTk5FQ1RPUl9TVEFUVVNfU0laRSwNCj4gVUNTSV9NQVhfREFUQV9M
RU5HVEgoY29uLT51Y3NpKSk7DQo+IAlpbnQgcmV0Ow0KPiANCj4gCXJldCA9IHVjc2lfc2VuZF9j
b21tYW5kX2NvbW1vbihjb24tPnVjc2ksIGNvbW1hbmQsICZjb24tPnN0YXR1cywNCj4gc2l6ZSwg
Y29ubl9hY2spOw0KPiANCj4gdWNzaV9zZW5kX2NvbW1hbmRfY29tbW9uKCkgdGFrZXMgdGhlIHNp
emUgaW4gbnVtYmVyIG9mICpieXRlcyouDQo+IFRoaXMgY2FsbCBjb3JydXB0cyBwc3kgYW5kIHBz
eV9kZXNjIGluIGNvbi4NCj4gDQo+IAlyZXR1cm4gcmV0IDwgMCA/IHJldCA6IDA7DQo+IH0NCj4g
DQo+ID4NCj4gPiA+IFJldmVydGluZyBpdCBzZWVtcyB0byBoZWxwIGxvY2FsbHkuIEhvd2V2ZXIs
IHRvIGNvbmZpcm0gSSBoYXZlIHNlbnQgb3V0IGEgcGF0Y2gNCj4gdG8gb3VyICJ0cnktYm90Ig0K
PiA+ID4NCj4gPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvMTQy
MDQ5Lw0KPiA+ID4NCj4gPiA+IFdlIGNhbiB3YWl0IGZvciBpdHMgcmVzdWx0cy4NCj4gPiA+DQo+
ID4gPiBSZWdhcmRzDQo+ID4gPg0KPiA+ID4gQ2hhaXRhbnlhDQo+ID4gPg0K

