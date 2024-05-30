Return-Path: <linux-pm+bounces-8430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E798F8D4EED
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AEA1F2611D
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E29187553;
	Thu, 30 May 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3nE4TFH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A7187545
	for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082441; cv=fail; b=HI4StnNSXooQZErFSey1qjshsM4gSJM/g/BeJNgr00guB2zc4a4VMI7PJalfn5UzTmE3BpFcdrb9IPloBZSEPw/dIBia0D0gUw9JpSzLiC3Jclxa6O+2U7LhUeXcKcfB9bZtWtGAN6eyU8p4bQKtygVqaF8/6+vVeKGmziGh9/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082441; c=relaxed/simple;
	bh=czYeXGVLIhSLqHfCYVmzUHk5rp0sW+cDQsyMrkzceX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvV2ys7pTCX/N+/ZTkjvMo9eYGrUL48GtVS9EaHnXfXcijjKWouNNjTqcZNQCPbs9s4BTNAsjQWhvKBFU1kNB3TPJEXT76vD4jnGn+sBA0x2kwlIBpCvU2rDNfC+hQHn9Kt4FtSXR3x/bbkEX0ca4KU1PUeDaC4LanZ7XE6rDog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3nE4TFH; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717082440; x=1748618440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=czYeXGVLIhSLqHfCYVmzUHk5rp0sW+cDQsyMrkzceX4=;
  b=M3nE4TFHSfHJ051hhPWJY/sE/VXj72uh6isFtwCoa52ZFZM6VEoHeIWP
   AfpeHKTx4FqMXAqS6AZWGqARwIFgybjwEW+MvBTqCYmT55bE5SxdNQ9iP
   T1m+60qDTrKw5o8h/uCwxCAUNgh2KgSL7XPBZMifruNyjFFQL4eaZq6mP
   4omWJMtaOQcmXkHYbT6a8O0t88N+5kfjwk7W5OxwW28EuWLlRX+Uw0DKM
   XDKIVKxeoR0itWARvdIrSOLZIDzy8m2LrP1WVsIsBVPgKtT/QxxH+sIXN
   LzNuoB+bCHiBEzjn9GStg1PZceQgnWLyS/VAaPexAYjdsk8B5O3I3Nq3t
   w==;
X-CSE-ConnectionGUID: My/IT8L8SJaLNIXkSXXBZg==
X-CSE-MsgGUID: a/J0EJnvTBiNSPIfJDjlDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="38965134"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="38965134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:20:36 -0700
X-CSE-ConnectionGUID: 1xqIGtl8R82Y5+D5/uTKtg==
X-CSE-MsgGUID: 9L/9G4mXR9ybeBaNEsbUBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="59022167"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 08:20:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 08:20:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 08:20:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 08:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efoELeGjBpEuEjEr051qNwre5YkUQVFInA+vdGh0M9EFOb3Mqg959pyV58AV+35rCj1qIMijBSD/Zwfan4MByzzkbPsWC5AktcCaXf26yFVZA7bXHbeFHOcFhW9ZzK+OCbkXbWSXyKXKApOa8zvXWg9VJEMOEYuxgzeL5r+G3qmzFA+GYS3hdeJ23AD/VratilWuu5AG4KkDK6mlsRC/rCmCZZPgMOhFhfBPdkxO7Xr06lAQrPKojzaRgwT4MLlmOKQE7/mETKaLjewdqaX/OMakyYrZO4HLE6HuT0yXfFy0ZkpT1gSbxZl0hjqMQxSCjhG8r8kKuaAAtT0j/5t3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czYeXGVLIhSLqHfCYVmzUHk5rp0sW+cDQsyMrkzceX4=;
 b=We+azvuPUt6xDhSRJTfjNtZ+xctVLjPHRWXfRG82ImGqgH0u++PJnxtlmfdBGYucKGp4Pdc7om20wJQt+FLy+E7YzvthXUq2T/LFB8iWPPtCMSYZfok2jpz7irlTif5GjdJTzlsg5cPIuDUv4UooauU2FsReShIPS9+r1L4HOvW/dX5bD2dT2+QHw75JIRQaYrRKAX2VdqtWHnAzh+linHRw36jcT5BsS+Fvsmt0/6e6XcqcPoCwbX4gYrb+zhCEP90vsvEIXqhKM78mS0JsMyB0VWZhoqMhuvJZvjAH4IgI8RsBZRzkSBwNruAX0Zn3S6jnMilsfEPvtx7ziBDGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 15:20:30 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 15:20:30 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC: "hdegoede@redhat.com" <hdegoede@redhat.com>, "Brown, Len"
	<len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "mike@mjones.io"
	<mike@mjones.io>
Subject: Re: Dell XPS 13 9360 (Kaby Lake): Power button LED stays sporadically
 trying to S0ix suspend
Thread-Topic: Dell XPS 13 9360 (Kaby Lake): Power button LED stays
 sporadically trying to S0ix suspend
Thread-Index: AQHasa6KFS/oR0IvNEK/HUE4c2Jg37GuVGgAgAEhkICAAHB4AA==
Date: Thu, 30 May 2024 15:20:30 +0000
Message-ID: <efbfa293a8b80b13b1e431feb4a97ea5931bccca.camel@intel.com>
References: <83326c68-e1f9-43b3-8cc4-6cf88cfbdbfa@molgen.mpg.de>
	 <2c0eae5ed4c60289d4fa09ec5a8251d0d7314256.camel@intel.com>
	 <4c7418aa-5527-4283-9e6c-c8e9ea519e57@molgen.mpg.de>
In-Reply-To: <4c7418aa-5527-4283-9e6c-c8e9ea519e57@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH0PR11MB5300:EE_
x-ms-office365-filtering-correlation-id: 731786d5-3326-4e20-f168-08dc80bc0aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a0N1YUZ5OEdEazJWcGx0ekVKMm14dmhISm4vOVNjVWJnQklsdDdsd3hJT1hC?=
 =?utf-8?B?MGd4NDM3STFUd1JmZTFHWVBHc3N3YjdrVE1rbE94cVZTcEpKdU5uV0hsb21F?=
 =?utf-8?B?UGRJNkpFYVk4S0o5UHhpUDU3R3hDMUx3dklmWHpEQlZUdjlQdzJWQ2Fqa2V3?=
 =?utf-8?B?SnpPcGpwd080KzZTemhobDB3S3E3dXRuaXNMVVVUcUM4RXQ3SjBEbmFtdW8v?=
 =?utf-8?B?dmtNMmRiQ3ZxVkdpWWJtcEdVdUF5ckt2YURXV01vbkpmeVFBaSs2TGpwbHFE?=
 =?utf-8?B?K2duTWNyamU3bDVvZ3l3aTJkZHZ3b09CVTE5R2tVL1RDd3ZaOWpEUDlHOUho?=
 =?utf-8?B?bDRzRGxYWGZlakhaajJteW55ZS9oY1JmazdOWWNrRlhBNE01NWYxaW55bVha?=
 =?utf-8?B?MU0zMzNNWkl2RDd3OG9EeUlSaS90dGRtcnMyTkFVRmFXc0hDOHFsYWxiQkEx?=
 =?utf-8?B?aG9hOE5kUXAwWFp5Kyt4b3hILzhZdWplY0tHdVVlTHpTeSsxZHZDQXhPRng1?=
 =?utf-8?B?YWliYmlQOG1LanBiNERXYkZsQ3Q5VXFLTWptZ1VsMnpxNElSbHYrNDBIakVO?=
 =?utf-8?B?TXNUYStXRk5iNWxGL0Qxei93aW1JNXpkWkh4cFRKMzVtcmVWRjlFVXlyM3RB?=
 =?utf-8?B?OTkwREY0VW9XNG9rU2dxRm5hWWtVdkJ4TVpwSFF3YU9yQ2RocGprbUl3eVFo?=
 =?utf-8?B?ellDVjhhWUtOaXJna2NaZ0FZUnFGQW10UFhHN0lHTUlQRXBqdWdRS2JxMlRa?=
 =?utf-8?B?anFXSVFaK1pOcnNUL203L2lHVUtocFdkTVI0VGlzL2RmcWNyTDlRMlZxVEcx?=
 =?utf-8?B?bzRoU1BRbVBnRHpRRzl3Z1dJSC95WTZOT0t1VW1uK2pNS0N0Sk13MzI4N2FM?=
 =?utf-8?B?cFhmbExDRFJxYm1VbnNMYk9YM0l3TmJIdFFwVGluTDlvb2pOTU9DdEd5Vmlv?=
 =?utf-8?B?VFdwbytETWQyNHVsZndOeEpVU2t1VUpudDV5VkkvZkpLbTUrTXlQRWVqb1JQ?=
 =?utf-8?B?azhpbytBYU1TVlpqbEdhSWt5bUNFTkJSSVBGVVlZVGZXSzNTTzRoaW1jVEJV?=
 =?utf-8?B?R0h0dk03YURaQ1FTcndWdFdJbkxZM3k4RzdNWXlMR2JRVzJFVTdRM2RQOHB3?=
 =?utf-8?B?ZkkzcmtNeVkyajdiNHJ6TDA5Y09xVEZQZmpyRHZUb3d1MTlOTzlFZENXWEkv?=
 =?utf-8?B?QWNSK3lkUTBYMlIrTE4wQytqN1IvYXdZK0VFalJiQXdCaU1UUXplSDAxejd6?=
 =?utf-8?B?QW0vcXNTM09IeExxQWN0NUMzNWxSRVpDWEIrNXRkNTg1bGVvVmM5Qmt2ZG90?=
 =?utf-8?B?YkhoTUQrcmtEU1I3ZEJGcU44eHZHSVpCcnFyTEZFaVpFSGpuaGF0Y1plMmxI?=
 =?utf-8?B?eHl6OGdQNC9KcDBtYVg2UUFuSmhwbmRpT25iQVJKditrRkt6cTUzSzA1bnVR?=
 =?utf-8?B?cjZyZHpVdTVIODRhbmREYkdJOGFNVUNTaFlCa09RNU5YMEhKanN3bTJOeHFq?=
 =?utf-8?B?L25qdzU3YUtUN1puM3pxc3J3VDdUZjNJMlZVM1gxZkNHZFNkNlgzc3A2TDA0?=
 =?utf-8?B?SkVuRW9DWXNOMmxrMGI4cHNsU0g2NEpuTlBqSk9XM3lHY0lvdTdFR2MyMFdr?=
 =?utf-8?B?Ti94TEFjYlE5RW1TaEN2eUxFZjF4YkFkZ0wyNVVINFozYVBoWldiWW9qMjJJ?=
 =?utf-8?B?VGUvaUNsYnNWUy9DVklCYUl1KzBLZWZ2ZXlGU25KQTZBdU5SY0l6QWtnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWxNREJhbUh4RmJ6c1RGS1ptbE9LNUZjMThRaWc2QU1zQ0U5UWlUTUdGQk1h?=
 =?utf-8?B?SjhZV0ZXbUJhM2dEVnZuUzdPUG9yb29yVjVVRjU2djcyUUZjSTdmMXNkeEk0?=
 =?utf-8?B?aEx2WDZRWldmbDJVdDhjMVd1bWdxVVBzUHJvL2tWZnYwZ0tFdG1XeS9rS0ly?=
 =?utf-8?B?NFNrR3BYYjMxWFFDRGRYaWF2TDZWdlZjejRKTjBmeTdyay9JN1ZERW9QMFBU?=
 =?utf-8?B?VDMyd1picFVUa29XTWZWbzd4ekVaeTM2YmlLM2tYcSsxUWpERmkvRUpoaWl5?=
 =?utf-8?B?M0dyNmx3aFpaRDBwMHlKbEl1THBzY3hLaTZTR0xJQzl3ZVBmZzJWQklCVTd6?=
 =?utf-8?B?bGY1RGF5NThncWZ0aG80T1BUdVQ5VHpxTllhWHZwVElzWlRDaGlHNXRGOWQr?=
 =?utf-8?B?ZjYxZlJCMHlYdmpHQkN4dW92M0dWWkFDZ0c0T2EvZERXa1JHMVBHblh3dnVJ?=
 =?utf-8?B?Tzd2Vi9nekJMUnVEazh2UnVyRHZFQk9DSm5WWGlBUE9mSXFZR2Z2c2poZFhi?=
 =?utf-8?B?ZHp4RTdjaUxwUHBMcEN6S2IyUGt3TWRPd0VmWGN2TTdKQ3BhMFFscUpTQlNn?=
 =?utf-8?B?ZVdiTnFyV1Azd1lKVEt2enlidDIySXZPM3BaNVE3dnpMV1dTd0ZqVjlTT2VH?=
 =?utf-8?B?ZVFFcVVnL1EwVUlDWThRM2N3NGxWSVcyMmVHczdYZDcwNXF0UGRjMlZKc3BR?=
 =?utf-8?B?d1VYeUlWZ0JhY0VNbk1qS3RkTk00QkVLUUxUR2lhMU9kcmxqWWExUnZSSG1O?=
 =?utf-8?B?NC9aRFpLdzc2dEd1VklpVFdKUlRsditoNFRLTXRTckt4R3ArUjNEcWoydC9w?=
 =?utf-8?B?RWp2cHc4ZllNVkFBRUlHQ1BhN29lelRySXBveWJxb3NOOHdydFhwWGptamtz?=
 =?utf-8?B?cEliKzJUSWIySExrRzZncmJPWjFxa2hDUm56aTFzdnY0bzY3UXBRbUlLUDk0?=
 =?utf-8?B?OTZrY0NnVnUzcGVVTU1LSDFubDB1cGlVZFExdmFaYkpvYVVPNUZFMjVPR1pU?=
 =?utf-8?B?elhXUm94OGNaREJXL3JWclUxdDc5UmdlNzdSeGFIeWxtbk5uQldFZlJ6aWdn?=
 =?utf-8?B?bEg4NlIyWTdvTFhEM0J4WE5jeHdkTktZMVF6YWdzTDdrck0weGtEbVVjbGpn?=
 =?utf-8?B?SjUyQ2ZJdHhKeDVib1g0NWtaNk5zQnVMSjZKZFEvTFlsYS9COERpMnlLSkoz?=
 =?utf-8?B?R0h3NnhHblYrV1FYYk9McFdDeU5YZkpueE1aSHVGUzV5MFoyaGk1VDArOU1D?=
 =?utf-8?B?aFJITWJJTFNDaFluMmRwSitiMWMvTnRCY2JsSWJNVTM1bTBWNkxoa3phTmp0?=
 =?utf-8?B?K1I4anh1UGU4cDNkYnZKWXRqNkk2SlBPTW94eGpxRXVkb1hWTE5pejVpVlo4?=
 =?utf-8?B?MGdJNzE3TjVRcWtmenM1cnhxSytRM2RYaXJnUnpoYjcrbkUvWExNNGEvc0F3?=
 =?utf-8?B?SVlhRTZwRXN5aWhtVjU4Sk9pMlN3MjRNMDJUM1lmQVNTcEhWUXpydGIva1hM?=
 =?utf-8?B?bDZvd1FXWHBOY0l3VDVLRmZxNEt5cXE5cnBZSkUwdlBJSFBBMjRCK3dOT3Vh?=
 =?utf-8?B?UjQvaGl0VVFkeHNLVVVDeWEybGJOb3VERklaM0t6WWM4SGw0RzBhMDFFTjUy?=
 =?utf-8?B?WmdtNGlmdmFxSUxqekhvUnB6ZGgweXF3Smpibks2YjBtRXNBSVArSmVBQ2lF?=
 =?utf-8?B?SVo3aVVlb2x4dzgrb1lHeTcvd3pxMDJ5TjhzcHd3ampCOXJ5emNESXBlbHV2?=
 =?utf-8?B?ZXBsVkNMRjk0UVR4WDBad1c1M2FRS2IvWHloN1hGVXFKQmNMS1lZSFkvVlJq?=
 =?utf-8?B?YnRGVENXOExXL1pvcVhmVi94ZHVXcXl1WVROOTU2V0QxMDlSWFFGZEdoRTdL?=
 =?utf-8?B?VjFjR0szK2ZVc3dWbEM3YUFPV3VWQThtNTVnV2hUcXQyWWk2b2hYNUtwbmMz?=
 =?utf-8?B?b2NPd21qT1Q4Y2lucnVBZW00THVsRWlNKzlXeGxKeDBGTloySHVrd1ZhRURG?=
 =?utf-8?B?NFIvZTJzcnlRODJEbmNzaUxsN01JSE1NZTdtV0t5WFh5T21aTk9ydWROUWpG?=
 =?utf-8?B?WkpWOEloQiszNDNGNzlTYlc1dyt3azBzcU05Wm5vL0ZLejljakMyR3l2WUdt?=
 =?utf-8?Q?8K6+byf7yubYA5HN6aCZwFnz7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DFDC4084A486E418E1FC760F16D3F9D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731786d5-3326-4e20-f168-08dc80bc0aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 15:20:30.0500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gujA9O39pa/XBIqIGJafZhyQ0Vf8+fZBW2UL1M7mbK71kMaOu01nOXThGMQko5CN8eJA3Ph8mBUFou/0EL/6mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDEwOjM3ICswMjAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4g
RGVhciBSdWksDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIGluc3RhbnQgcmVwbHksIGFu
ZCBldmVuIHN1Z2dlc3RpbmcgYSBwYXRjaC4NCj4gDQo+IEFtIDI5LjA1LjI0IHVtIDE3OjIxIHNj
aHJpZWIgWmhhbmcsIFJ1aToNCj4gDQo+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCwgdGhlIHN5c3Rl
bSBtYXkgZmFpbCB0byBlbnRlciBTMGl4IGlmIGl0IGlzDQo+ID4gc3VzcGVuZGVkIHdpdGggaGln
aCB0ZW1wZXJhdHVyZS4NCj4gDQo+IFRoYW5rIHlvdS4gQ2FuIHRoZSB0ZW1wZXJhdHVyZSB0aHJl
c2hvbGQgYmUgY2hlY2tlZD8gSSBndWVzcyBpdOKAmXMgDQo+IHNvbWV3aGVyZSBpbiB0aGUgc3lz
dGVtIGZpcm13YXJlLg0KDQp5ZXMuDQoNCj4gDQo+IEkgd291bGQgYWxzbyBhZGQgdGhlIHRlbXBl
cmF0dXJlIHRocmVzaG9sZCB0byB0aGUgbG9nIG1lc3NhZ2VzLCBhbmQNCj4gdXNlIA0KPiBsb2cg
bGV2ZWwgd2FybmluZyBhcyBpdCBwcmV2ZW50cyBTMGl4IGZyb20gd29ya2luZy4NCj4gDQoNCmFn
cmVlLg0KUmVmcmVzaGVkIHBhdGNoIGlzIGF2YWlsYWJsZSBhdA0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjQwNTMwMTUxNzA0LjI4MjQ1My0xLXJ1aS56aGFuZ0BpbnRlbC5jb20vDQoN
CnRoYW5rcywNCnJ1aQ0K

