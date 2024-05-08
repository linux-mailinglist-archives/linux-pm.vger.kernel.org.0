Return-Path: <linux-pm+bounces-7622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544C88BF54F
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 06:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DA1283677
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 04:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F106710A13;
	Wed,  8 May 2024 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNmJ806/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654F17597;
	Wed,  8 May 2024 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715143623; cv=fail; b=RkOjFh1fK9yUNonAUgH19q2i4b9+TUT9CeUUPKHMK58CXwf74WFp0ga7xiI6JRRrP2rmnNnpFLM11YDrHWmKBYsGcPE3JcjuC/Pwqe7KEyx/bgk8QgEDgvxc2/pPR8AtC/KoGbqqO0xddAvxMvZn+JcqSY8HNYggDYLR+SCCStQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715143623; c=relaxed/simple;
	bh=wnn6Jb3vdhyfRs8l1JOWWi5TxVIWvqH6f6O3cIVVDv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KftwV2nF5lCcluPBi3/cHUWjZK61pOVoNSSPrZ4woJ4OPWsE1cYKyAQc4zPu/nGDGecJm5ejxtsAOyMqG4pXZCF9aJbY2+CSvK+hIQ3eXNe2XOLj/0hhknd6IOxmF3H/Db6zdlrnbOpDM861CA/91sKuM1UW/Rmf7Qok+frHP5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNmJ806/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715143622; x=1746679622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wnn6Jb3vdhyfRs8l1JOWWi5TxVIWvqH6f6O3cIVVDv0=;
  b=UNmJ806/4zK2NI6I7fAVjAUcxKG1bLAmaN9k+ps12ye0h5xw9qZUPoCe
   bukeaUgKNG9R0dzhiiS/qEJcENo3prpsQhbx23Um7rm7eJBU4Wy5DSDQu
   y2ni2+1SRVSH4UgqNW3V9YMWnayMTUFL4QTqC+NsDeFaQORcuOnyVSL/A
   VUSiXfo9mCdd1i7Qk0nN+idENmMMudEws4BgA3kDZxPtYfGU+QGrQdr/+
   nC+xhqmqQuH6MWit7zjDd6rbHxR5bytCYupglOdJleQyDidAZQOetiwYV
   D6d9DWNFgPWIF6qOisbTsQEAny9DpIwRaO39cAO7/kabdnDw9OKbSpNMO
   A==;
X-CSE-ConnectionGUID: ggaoMHGzSg+cSeOOQIoFwg==
X-CSE-MsgGUID: wmpkSanITSaoiiXbLeThUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21540911"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="21540911"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 21:46:57 -0700
X-CSE-ConnectionGUID: WftLcmzzQ2GcnJ/EblLjNg==
X-CSE-MsgGUID: vUpbVeufSZKmKXKYeAgoVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33273196"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 21:46:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 21:46:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 21:46:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 21:46:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:46:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOJnDdr9VjQLVJZBcZBm7GD97qv0JPwNorhCNA7lBRZyA45S8hMtLPh3rCrwXUzA1bcbz3VaoUxHev3JHH/7D2rhQadUaZz/Qp0OAnIEbzFDCFGsrfKxjbMCx00K1mpHLzJw1FWHkB7NZUNXe/ATm/l0UBJPesC2BmMXVcr6uZzZgQ9fWWF3wLLolDGHaIE8XVSlNM9RDF3FhI6JcctwZymdmUUDq9JHW17ypjX15Gjr2WLkrgg1+G2vz5P2D4bs6OoRD7nnODcOqhQaBdiMuYgqABq/O6XNuR2aL2A9xRfwR5KKYrCdf631gH3XDW6/KjeqV2byUsN2XnOQ2aRv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnn6Jb3vdhyfRs8l1JOWWi5TxVIWvqH6f6O3cIVVDv0=;
 b=CvEI6v71jii7ENg7nmPBwUGhiGobgatNmxpzdJ+rMO36k89fP1z7vKdNryqLMFrJX30SOvtA5PBwm9lR9S6kKkFnuXMykU6Mk6u91v0h/axHLoKS34bB4ge8P5JShscAxwQJV03GZexLZpxj0HV8L3ug9w3CDI1pZsz78yEC1DYUR8mf9kXMzDz8cRRcTRpb0XrAiwh9MydjPu2Qd0DOzQM28Pi3MghY2AIQhf4Pxp46/dCkDugxsKx//a9mDhBXMXLLyZKgQfSgkAB92QgrQ3ATfG74lQuFg8JRnG4AaPuGDD0MkY4KTNIV28aJ9SxF2oZFOcyFg1rfqkJHzMnsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 04:46:49 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e620:6fe3:711c:a6bb]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e620:6fe3:711c:a6bb%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 04:46:49 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Brown, Len" <len.brown@intel.com>,
	"stanislaw.gruszka@linux.intel.com" <stanislaw.gruszka@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Neri,
 Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH v2 3/4] thermal: intel: hfi: Rename
 HFI_MAX_THERM_NOTIFY_COUNT
Thread-Topic: [PATCH v2 3/4] thermal: intel: hfi: Rename
 HFI_MAX_THERM_NOTIFY_COUNT
Thread-Index: AQHaoPj8pohdi/S2yE6f3eW1Gfn2PbGMw4WA
Date: Wed, 8 May 2024 04:46:49 +0000
Message-ID: <971f68f994de1842fff0569a49e87356e835e03b.camel@intel.com>
References: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
	 <20240508034352.18414-4-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240508034352.18414-4-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB4944:EE_
x-ms-office365-filtering-correlation-id: 4580009f-e38e-48be-9c17-08dc6f19df54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WWpmSWZySWVUSktkWGRzNmlOSERGbURhOFVNRGxET2JXeDlPUHk3VGxtUVFX?=
 =?utf-8?B?MG5yWkFzc0kvaUlybHBzWi9NdjVEZkFINjJCT3FFSm8wM05XcTFMRUkyd25z?=
 =?utf-8?B?RnpsanlMSXoxMCt1UmFEVUhyZUZXZUpybzY0QVVxQ2xPdEhYNGxLM29tc1F3?=
 =?utf-8?B?NWNxbmdLSDhpYWIxNy84emE3RWxwK1J0Wkt0MzJYazdPWUpLN21acVNObnZt?=
 =?utf-8?B?OGVrZ25IVTI1R3k0NCsxNXFtRy9DME51dE1zOXB2L2lFa3FmWTZHcFFhUC9U?=
 =?utf-8?B?RnIwdnp3UlhuYVplM1JkK256ZHR6M3JuOFVQTnBDMDYwL2czL2E2RDlUaEdy?=
 =?utf-8?B?SGZlRHJ1UUFKRHFkdTRpOThSWjBEMmdyU2YzcUsvc2d1V0MwVEcvOXM5Rnp0?=
 =?utf-8?B?czR4UGw1alJsTlhrM2YySndIUUQzSGhEbDRqaUtkRkE3dlNzZzFiY1pONkE2?=
 =?utf-8?B?TkdVMHhmTEYyV1BGVzdIVXg2VjJ5UVZtVXphS1ViTVM5L0lMUGc1ZFVlRXo0?=
 =?utf-8?B?VUprcjJvUW1qVkpnRmdjK0YzcEhjbjloVE1jWkFmWGlOSWJDZVN3R2NKbm4x?=
 =?utf-8?B?Zmd2QnFSczNxRTJzRFA5dWd1VExvS2Z3ajdQWS9NNUhYVFVTMExSS2JRNDQr?=
 =?utf-8?B?UzZXV3dBSWNIY29NWSt5RkVUVjZoTHRweFFVdHFuUnY5eVJEc0FHdFU0R2JN?=
 =?utf-8?B?MllWbi9MSURKOFF1bHd4OFFweHo2UW1iZUpsSVNYd3pQbkxzVnVKWXU0ZmZT?=
 =?utf-8?B?QjN5WlhDQUx4Q1BXOTVtMmZYMVhiL29sQy92bklvSkxXUEZJaDBIWlU2U21E?=
 =?utf-8?B?Ty85bGFJRExiRERIdjhBcTJ6MW1OaXhhaVgybXhWS253aUpwdXYrenZ5N0Zm?=
 =?utf-8?B?ZDBPR2prV0hyZWw4TUlWN1UxQ2tVRXJjdU5hR05LUHkzN0p2U2ZPM3V0TURr?=
 =?utf-8?B?THVJaURkOVpWc2tWRkRXM0JHS3czR1BRdkJnMHdoa3ova2VNQWhoa3l6eDlD?=
 =?utf-8?B?anJJMlBxbWlZOEs3T3NBQXRNUWxOeTlVNHVqTUlteXFsNFNFcnVOczhlZURo?=
 =?utf-8?B?SWNDUnVUY2NiUDNZdHg3Skhqak9KTmtuZTlDT3cyUm5QaDgzU1NWdy81aDJI?=
 =?utf-8?B?ZmVFNmIvdUh2dWVPbkpzaXBoQTc4Y08zNjZzYlp5MmNZZDNrZzkxeVMxS0NG?=
 =?utf-8?B?U0w3VXoyLzBHQmVwdCtqME5ndzgxZGdqMGtMclo3SXJyM2x2bWNGcWRWL1Ix?=
 =?utf-8?B?MmxMU05CSHpxMUFkQVcrQmJHQ0NLc3VRTWNkdjlmeC9iM0F2TENYbUl4SktJ?=
 =?utf-8?B?L0NMT3p4emg5RnZJRHZ3UkNwSE43cm43aXRnR0xJK1R0dUlNWkxnTG4rQXAz?=
 =?utf-8?B?Y3V0WFlyTU1NVGtLRWd0T1dOTi9GUWFjR3Fra29GeU5iVHpkcmd0aktSeE9Y?=
 =?utf-8?B?cTRqRmk2c1hYQjB6MUpuYTY1d0Z5VHQvd2thSlVTcVNDZmMxbEUrdldyK21r?=
 =?utf-8?B?ZDlSUHYwcUZFRGRWZW9vUjJHYUV2bXh6MmpqWnB6SzZkVm9QRktKMXVuNHJo?=
 =?utf-8?B?UnphMitzYmVESHlycWJJbkdMRjJXZFZyZW1tVUVGUk5Sd0Z0YzlVNzJLdFdl?=
 =?utf-8?B?bm1ubmVENmUvWUZnbkNXNUFzbzFQdWIwbDErU1FjbS9wUW9OZFR0VVp4dXQ5?=
 =?utf-8?B?VEozOGY1NlJ4VmsrQzlVSWdYMVJXLzhMcU1NM0JIUzFtaWVOMUdtalluTDQ1?=
 =?utf-8?B?aXVlWUF3d0lkRUY5TFhaZTRWTjUySzR1cjhocVVBbHBWbkIyQUlydHBVT0w3?=
 =?utf-8?B?d2xadExJM2IrSmhoeHl1UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3lPYnlxZDFSeXlQM3NQSUN3cWFhQjA4SFZ6NE82SVFwRDdycnVCSEpkNXRn?=
 =?utf-8?B?d1RQNmVpRUlBYVdkeTZTNmNPWjJpQnRDZ0NvVlJzNnpjUkJYcjkzMjJZVWN5?=
 =?utf-8?B?c1hweERGV0llWVUzRm9NV0w0eFQvZFg5SW5HQzA0YmRGMEQyMzcwU2dpWEp3?=
 =?utf-8?B?c2xicVNzaU5kZTBQdGE2UzFBVDM3OUFEOSt5bnVRZTU0UzFsbjU2ektzd2ts?=
 =?utf-8?B?ajgrTUxiUFhhK0VjV1RDdXhxaDJNeTRNQ0lpRHoxclZvMU5wdy9GYWQ1THRD?=
 =?utf-8?B?bHBUd3NxczBhM2UvOGRzRzdxdnIycUpTaFZOVmlLbEkwb1FxMFVqOW41aE5M?=
 =?utf-8?B?ckpwNER2NzdSd0ppVFptTDRtS1p1U2xYSGY0Z2piamZ4Mk4vVkx2VmlwRHdE?=
 =?utf-8?B?cm5seVRzU3lYZ2dQVkFvWG5XdVdEMFp0cXdwWitZS0cwdEsyVEtIMWYwRUgy?=
 =?utf-8?B?NDEyRHAwZFBJVDc1SEZIY1F1SkZzUlFMZEdKMERhNDNRc3ovelNNVXFPLzAz?=
 =?utf-8?B?akxpWVZWS0JVZFVVMmp0OTBJK3pNWjkzTTcwNDFZZXFmeitYamVEN2VaM2hy?=
 =?utf-8?B?cnRkSnZ5SVlGZ3JIa2RLQjdWUzVGRUtpRDVraUowelpCTzRwYUM5UDIrekdV?=
 =?utf-8?B?Sm0yWlVhanBIRmdwSVVwaFAybUpQaEJXMStwcWNUSVU4alE0SCtHeXZBMEU1?=
 =?utf-8?B?N0RFUkFTMVBMTjRxc1dnTWJ6aFArTzVOaXk3TGdtU3pxMjgweTZ4U0poSmpj?=
 =?utf-8?B?cGpIREFlcm84bmpTa1ZlRndpZUZWUUM5Z3hNaTU0a3FySWhsZU1JNDhmcXBa?=
 =?utf-8?B?K0x1TG42TmhUVllXTTBxdFl6UHZEM2pTd01EejhzUUNWT3FMTUNrQXg2TUFE?=
 =?utf-8?B?RitjQ0o5ZXVHR2REMzJ1c0Z4QkY0NWhhMUNHdGlwZjV0NG1IV0tNNjl2eVg1?=
 =?utf-8?B?S2dRMU1oTDJNZ3pHSkpHSkV2RVRLSVJGM3FJRnQ4YzFuZGQ4cHo2WlhvVGor?=
 =?utf-8?B?ZGJZbXl4cllCSE55MHlJY29IT0tPc1JqUDdYbE91UGpIVCtyVnRYdllYa1Br?=
 =?utf-8?B?OE5nblQzS2tFVVVKakROVkhrZmtqL2xvMW5zUGJZcmFKVFF6ckkzWk9DQWRp?=
 =?utf-8?B?QWtqWGE0cWNDaHNHcDFUdG9tVmRPZHdCZklPUEt6TGJhZ2ZYZ0RYYnlIVDVx?=
 =?utf-8?B?OWQvUS9mbS8vWlZ0bGtXM1VTSnMzaGxqY0g3TDNzYzhNYmJ4MlpZbTg2RG9r?=
 =?utf-8?B?Ym0yM01LS0w5c0YzOUlobzZXL3lsUzVHTE1YZFVGUGhXVFY1dnp4NE5nV3pH?=
 =?utf-8?B?L3hXaUhQb2h4RFlHN3Y5K3Z1a2piZmd1eDVqSjRCTzZHUS95TE1XMEZkcGxi?=
 =?utf-8?B?c3VOMkhmTWV6Q3pzL000K0h0QlY0RUgwdnlmeU00WlliaCtpUFJ1dFo2am5W?=
 =?utf-8?B?bU9uL2JTVlgwemlOaG5XYzU0azUxeWxxNUVwSzh6UEgxSzZWTG16ZGRTTDJp?=
 =?utf-8?B?RW9DV0Zya2lwQkswV2hoSFhpNmlJZ0NLN3R2U3FvaUdESUs2OXI3MzZ5UkNl?=
 =?utf-8?B?M1J1VnRNbEYrcytrRktTcWxWMGJydzVSZXRJeU5nT3VxODZkR2tUbWI4aHpH?=
 =?utf-8?B?bUxiL1RkclhHdjNwVHYxbzZVcWRJaG9xdFEwaXgwRlIrcEJ0K1hkcU5pRlVv?=
 =?utf-8?B?bUdYckRoU3ZzWEx4T05TVWRCMGc3WnloNlNrbnZjc0pvMXRVNkJhR1BhMnVO?=
 =?utf-8?B?UGVFWHR1VmZZOVlUZFZ2QUd1VXR6T0hObDlMVURKd0RVQUtxdVNRSThVRUVU?=
 =?utf-8?B?WWxnN1dzUXgzdFEyNHdBbmNUVnpVd0dXWW1LdjFtUjNyVjJuR2pyQmgyOE5s?=
 =?utf-8?B?UTVQNDNaTE11VUFsSytONVQ2SWhqOEtScThaMjFmZXk1UHoyYXowQXdFNmhD?=
 =?utf-8?B?RFdyaVZvVEQyWVFHQU0waDE2bjBQc0NWMWFMNEVJSjBnb2JGQStSRk9RRjBJ?=
 =?utf-8?B?WHl3Z2xKN3cvcGZNdlB1UFIxTXJpRDJUNUxyK2NzVmkrRkcrY3E0bVVrVldJ?=
 =?utf-8?B?UVFGWVZJQzB4QU51YlBPa2IxVDZqWDAwVTdaYXZaUi9ySDFvWC9DZm1CT1M3?=
 =?utf-8?B?bFRWQ3pSQ2VHMkx0aTVrWnEwblhralR5UHJHZ3FBUW10S2hyTlJaemdHR2RB?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08C5AAC7A9492643A4954ADEE2F35FFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4580009f-e38e-48be-9c17-08dc6f19df54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 04:46:49.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQdyz/NOBxvzN7Axwi7DhumnOWPKddLtRVYWsqoAW0C64mxLJV7lVK9pYZiikVyKFE8HNYd9//kK/FZfe7ro5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA1LTA3IGF0IDIwOjQzIC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6Cj4g
V2hlbiBwcm9jZXNzaW5nIGEgaGFyZHdhcmUgdXBkYXRlLCBIRkkgZ2VuZXJhdGVzIGFzIG1hbnkg
dGhlcm1hbAo+IG5ldGxpbmsKPiBldmVudHMgYXMgbmVlZGVkIHRvIHJlbGF5IGFsbCB0aGUgdXBk
YXRlZCBDUFUgY2FwYWJpbGl0aWVzIHRvIHVzZXIKPiBzcGFjZS4KPiBUaGUgY29uc3RhbnQgSEZJ
X01BWF9USEVSTV9OT1RJRllfQ09VTlQgaXMgdGhlIG51bWJlciBvZiBDUFUKPiBjYXBhYmlsaXRp
ZXMKPiB1cGRhdGVkIHBlciBlYWNoIG9mIHRob3NlIGV2ZW50cy4KPiAKPiBHaXZlIHRoaXMgY29u
c3RhbnQgYSBtb3JlIGRlc2NyaXB0aXZlIG5hbWUuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmljYXJk
byBOZXJpIDxyaWNhcmRvLm5lcmktY2FsZGVyb25AbGludXguaW50ZWwuY29tPgoKQWNrZWQtYnk6
IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KCi1ydWkKPiAtLS0KPiBDYzogTGVuIEJy
b3duIDxsZW4uYnJvd25AaW50ZWwuY29tPgo+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmlu
aXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4KPiBDYzogU3RhbmlzbGF3IEdydXN6a2Eg
PHN0YW5pc2xhdy5ncnVzemthQGxpbnV4LmludGVsLmNvbT4KPiBDYzogWmhhbmcgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPgo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IC0tLQo+IENoYW5nZXMgc2luY2UgdjE6Cj4gwqAq
IE5vbmUKPiAtLS0KPiDCoGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9oZmkuYyB8IDEyICsr
KysrKy0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX2hmaS5j
Cj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZpLmMKPiBpbmRleCBkODJiODc4OGIw
ZjguLmM2NjU4ZjhjNWNjYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50
ZWxfaGZpLmMKPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZpLmMKPiBAQCAt
MTY3LDcgKzE2Nyw3IEBAIHN0YXRpYyBERUZJTkVfTVVURVgoaGZpX2luc3RhbmNlX2xvY2spOwo+
IMKgCj4gwqBzdGF0aWMgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmhmaV91cGRhdGVzX3dxOwo+
IMKgI2RlZmluZSBIRklfVVBEQVRFX0RFTEFZX01TwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTAw
Cj4gLSNkZWZpbmUgSEZJX01BWF9USEVSTV9OT1RJRllfQ09VTlTCoMKgwqDCoMKgMTYKPiArI2Rl
ZmluZSBIRklfVEhFUk1OTF9DQVBTX1BFUl9FVkVOVMKgwqDCoMKgwqAxNgo+IMKgCj4gwqBzdGF0
aWMgdm9pZCBnZXRfaGZpX2NhcHMoc3RydWN0IGhmaV9pbnN0YW5jZSAqaGZpX2luc3RhbmNlLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
dGhlcm1hbF9nZW5sX2NwdV9jYXBzICpjcHVfY2FwcykKPiBAQCAtMjE4LDE0ICsyMTgsMTQgQEAg
c3RhdGljIHZvaWQgdXBkYXRlX2NhcGFiaWxpdGllcyhzdHJ1Y3QKPiBoZmlfaW5zdGFuY2UgKmhm
aV9pbnN0YW5jZSkKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBnZXRfaGZpX2NhcHMoaGZpX2luc3Rh
bmNlLCBjcHVfY2Fwcyk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBpZiAoY3B1X2NvdW50IDwgSEZJ
X01BWF9USEVSTV9OT1RJRllfQ09VTlQpCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGNwdV9jb3VudCA8
IEhGSV9USEVSTU5MX0NBUFNfUEVSX0VWRU5UKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ290byBsYXN0X2NtZDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoC8qIFByb2Nlc3MgY29t
cGxldGUgY2h1bmtzIG9mIEhGSV9NQVhfVEhFUk1fTk9USUZZX0NPVU5UCj4gY2FwYWJpbGl0aWVz
LiAqLwo+ICvCoMKgwqDCoMKgwqDCoC8qIFByb2Nlc3MgY29tcGxldGUgY2h1bmtzIG9mIEhGSV9U
SEVSTU5MX0NBUFNfUEVSX0VWRU5UCj4gY2FwYWJpbGl0aWVzLiAqLwo+IMKgwqDCoMKgwqDCoMKg
wqBmb3IgKGkgPSAwOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChpICsgSEZJX01BWF9USEVS
TV9OT1RJRllfQ09VTlQpIDw9IGNwdV9jb3VudDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ICs9IEhGSV9NQVhfVEhFUk1fTk9USUZZX0NPVU5UKQo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB0aGVybWFsX2dlbmxfY3B1X2NhcGFiaWxpdHlfZXZlbnQoSEZJX01BWF9USEVS
TV9OT1RJRllfCj4gQ09VTlQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGkgKyBIRklfVEhF
Uk1OTF9DQVBTX1BFUl9FVkVOVCkgPD0gY3B1X2NvdW50Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGkgKz0gSEZJX1RIRVJNTkxfQ0FQU19QRVJfRVZFTlQpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHRoZXJtYWxfZ2VubF9jcHVfY2FwYWJpbGl0eV9ldmVudChIRklfVEhFUk1O
TF9DQVBTX1BFCj4gUl9FVkVOVCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAmY3B1X2NhcHNbaV0pOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGNwdV9jb3VudCA9
IGNwdV9jb3VudCAtIGk7Cgo=

