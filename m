Return-Path: <linux-pm+bounces-12528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9E957EF9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077CB28462E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E61741DC;
	Tue, 20 Aug 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UnPYSqVh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F718E34A;
	Tue, 20 Aug 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137579; cv=fail; b=YYxyOmljYjsFlpLHw5YknIwqtAokK40MAed4YNJsnESIcjvAyml6QnE5zfGUEtqNDBBsHG4x1pfqAwB8YpUWAqH6qwZ9aEOy41i4AAH98IMPRa1nr7Bs8HvMNckBkQQCGd7Ph1jOQMK8qNkkDnz4L8xSdi8QcJmKupLGePrmV80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137579; c=relaxed/simple;
	bh=Ic0GfPxIxDO2J5fwycUjXvFra81eOeQGQvr5rnzg5vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oKv5jkyHDZQADQsjUpWQnEVKWeVHfdYQbyVoFJVQeH8wJo7IRiLkzCE+Pihv18vMCMdJAJd8Hlg72IM2OsQBOTmpQ7zK2fe9wdcPdNty9OIeqQ93EUD0j2o09RRzMQ6nnumMC3IdxFL4Xu9weAfRFv6Z+PrRWBxqbh4YZ8bq3Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UnPYSqVh; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137577; x=1755673577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ic0GfPxIxDO2J5fwycUjXvFra81eOeQGQvr5rnzg5vI=;
  b=UnPYSqVh6yK9+QcapfQVQ2Mif60cuxM8xZmT+Kp5cA633FiS5ZhMKV09
   jWh5uitCOAR7OAlQW2wUQ4AJFLXrSGKuV5y80hg29U0vDqRtokKUhTq2+
   +zZ6O0zGSy9TBV8+YHDt5jdfa2u5Oar7AB2yYPuFplmR++z6KS4AKOCDh
   TU7SsthvRToESDgFnO66udmhpD3QbtT9AjV+TsnmSVO+TARnFLLSGYwBi
   0FbNk5ApnwTKpj3CUSPmA0pcr3MRIsEwfcSA9I6bx75FHBQPcDmPAVioy
   NgKYquaI/029G/T4ufGLP3eE6Z13ZGwPTAk+SVpxS4W9c7YCqYhbOCzZP
   w==;
X-CSE-ConnectionGUID: Xop6IropRjqfs/VGmXEZsQ==
X-CSE-MsgGUID: FNw/J5i0QXSRb0SLTHOvNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26215859"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26215859"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:06:17 -0700
X-CSE-ConnectionGUID: /H1x1iF7S7KanNkjrZKYDg==
X-CSE-MsgGUID: C712rfAkRk297Y2tm8I7Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65453406"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:06:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:06:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:06:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:06:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:06:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLJ66UoN/c3qIZAXZjGNfiUx5Kd6BOEcMwQx3Dp9AB6oXotO2bG3/5J/0PEvsfo35u0foNUFdgnBEJOWZbyiv8Ej6+wPIlgsJYkmlgUchfIuRdj8DNDbJrCmeIKetWr7OKQ/Pl7bOP7mtjob2FCVFBt7UYlgqlXKaz2JEYHf7CY+D1k2AMMoM/ZJXZQIGxYgiknXgjfemLqU+Vw9vtyDoE4WLo4p4Oek/F7555sBP2fAZ3VIph+d6KTzKpKHCGkE8n2JXvwhHjN53+0lKVyTfUQ4qpC38vbu5L2iLloGwsep8WTLwER59DU5cwunzgq1vBUlTpmfQzGM4nBrwyaLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic0GfPxIxDO2J5fwycUjXvFra81eOeQGQvr5rnzg5vI=;
 b=LWofTiiezAWDkXt3WA8a5rPKN6DMnNKDuF7S9+ZckmTZhmbNO6bZfYBTY3ph66JO53iSrE2fdIvIfH2HGXLo7Q/Xy3kK3LYyBTDihH83lZdjsPOxONwDuhqtBi09mcj5XFpTqoulEB/CNAZCCZmzwwRz4Q6joI0tzGkSgvsHzu8PqlBgrVQZUbOex7iAWAqVMtzzAQnCqQDg2frk2NxKeep7o69MeugA+ZRuYFDa+yn+s9PatCJKY1pmWhxXuZbZI/WUUpfIjHl2JZjo4yvCPJkoDSO037xcIRelGHpxgkpuI1aSiUXGCkMalJTr9Kr7z9EPIiQBC6HtNsyQqm3pFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:06:15 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:06:15 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 07/14] thermal: ACPI: Use the .should_bind() thermal
 zone callback
Thread-Topic: [PATCH v3 07/14] thermal: ACPI: Use the .should_bind() thermal
 zone callback
Thread-Index: AQHa8lKtRRxmWGn0WE2duqwopOIU9rIvujyA
Date: Tue, 20 Aug 2024 07:06:15 +0000
Message-ID: <f835ae6d2e19d532f7bbb507a950c5c536a3b453.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <1812827.VLH7GnMWUR@rjwysocki.net>
In-Reply-To: <1812827.VLH7GnMWUR@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: 6591e4d5-f7b7-42c4-ee9d-08dcc0e694c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aStibUJuWWJZT0RkUi9xdm83OE9UTDMxRVpPckhSMnZiSHlVZ2dqaGdjcUhK?=
 =?utf-8?B?Tk8yWmJuY0dQQWpuUDNtUFo5dVk0TktsakUwaE50U1Z4dStud2c1NEtLTGZi?=
 =?utf-8?B?dWd1RE5LcEdRa1RzV1JvRlVubFhJaHZ4YVRkTUFlL2toRURXNkNucUFtTW9F?=
 =?utf-8?B?N04rOFZ5aXJaVXV1NENWQzB5RFh3YVVmRGNaVGFseStrUWcvZnh4OHN2bllL?=
 =?utf-8?B?azd0Y1NuYXhnKzZpVGZ1T2hqcmNSa2FWNDdkYVlSS3IyMVBjRnlGOHFidFFi?=
 =?utf-8?B?VnJ6bjBhVlF6cHlXU1ozU0x6bkdtZTdtK1dtbVlVOGQxc3Zsa2VVN3Jvc3Ey?=
 =?utf-8?B?UkdQa0F2ekJxRkpYU3Nyd0dGdWVSdkFxTnl6TzVVZUFieE5vclhQZU11UnZN?=
 =?utf-8?B?NXVoQUJXbnduSEpncWpFZXB5a2ZmWE5TeEFTYXJMSGtLeWhDQkJBZEZZYlBu?=
 =?utf-8?B?S1ViMlpKek5PTi9Nc1Z0K1hJbm5qcGhoclZGUHRCS2d4Vk54WklMbkNOMmxF?=
 =?utf-8?B?aTRLVmYvYnlqdU9JL2dvekdRMHJuQm5JcVFxWnFIemY4ZWxDeGt4VjQ1Ykcz?=
 =?utf-8?B?VFBLSUU4RFM5QjExaDlBT2VoU0NLZ2IwWVNtRERHclZzcGRRc1JtMWhrTDBD?=
 =?utf-8?B?ZHR2VTZBNmkybkJ0UjV0eEh0R3Q2VG11WERzUVRtUW1lSGxnbTcxamJDSEt2?=
 =?utf-8?B?NU1oanRiSGREbGFNenlsdG50REhTNk02S2x2SDZ6Umx0MUpqTWN6c0NpMnht?=
 =?utf-8?B?RzU5cFoxOGJucHQzY1AzTGY4b01INXY2N29XYnN1TTQ0VGZ5TDJ0dk9TSFRL?=
 =?utf-8?B?c29sL1E4ODMxL0Q3TWxmTmk1WTR1eVlRdHo4b2E3QjNOR0JhRzNveWZ2SFJz?=
 =?utf-8?B?TFEya0VzWE11czJoQTdwNGt5MEZndlBpaU1HUHdRMFZLcXNCOXExYlNQZ2JQ?=
 =?utf-8?B?M3J2eW1Ud1NHc3EwZnZsalVxeFZLSGwvZGEvRlByZGJrdUFwZk5TU3dCTEMw?=
 =?utf-8?B?NGtSTkM3R0Mzay92NXJ3VkR6MHFxbmRmWElJUDluc2xBeHRsbmphb3dUelpG?=
 =?utf-8?B?Wk9wR1hBQStGQlhpWHhOQTdIVDJZMnMxOXI0KzdFc1REQitFVjljY2J2dkhO?=
 =?utf-8?B?bEYwVzNyWm4vM1NoUm4yYlJTY0J3Q05YYUxVWUtKbTZsWkppZlJLa0RkTjFk?=
 =?utf-8?B?aG14YTRmQWdLQ0Z5ZU5ZSXpKOGZsNkY4SkRSNGxHTVByeDlFVDVNME0wK3VE?=
 =?utf-8?B?em0zUG5jbVRZV1d6RlNQYkllelp4UEJZaVN0NG5nMkk5VlRhYTNrUmFURUZy?=
 =?utf-8?B?VWExbFdoRXdLcXByd243R3NpZi91T2JlOTRwRFd2VDNvY0NKTkowQ2tYSThy?=
 =?utf-8?B?Y2k4NEVTVWNzWmI3ZkI0OWFQNEtXTmc2NjZwVEoxU3JUUGpCNmtjZ0hlaENQ?=
 =?utf-8?B?YnQvalRVRFhGMENuVSswOE1rVWI2dkJXSVY1OVpvY1RvakFLeFNkWkQ3Vjht?=
 =?utf-8?B?VWtmenprU1J6T0NQcVcvRlVNSmJUcXBHZnl1VVFUN3h6WTBrTUI1aHFQY3Bx?=
 =?utf-8?B?dzZKNjYrd1VITHNxT3pkMFA5VWdGN3YvKzM4cW5hMWc1cDNlMWhNTkhTcFNh?=
 =?utf-8?B?SzJjVkQ4S2xyb1QxV2JjRDI0OVBYVVVIZEtFMnQ5T1ZzQ2JZZzBoOFBtTTVL?=
 =?utf-8?B?K3g4M0pFcXJlT243MDIydk1LcmI4cGtLMjBEUWc5eXdISkVpdnFnS2tDbHVa?=
 =?utf-8?B?djREVm56VzFsamgzbEpnRDQ3V3ZIYjBZcnJ3eW9wNHpSLzdqTlRXeUR5T3Bo?=
 =?utf-8?Q?6d5nl9r/GFFaJlngPtOpc3Mzvl06eTMqP1KU4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1VEQ3hNb0JiSHBxVGVNZThzNDNyRGlHUW51WWhlNVU3VTdhbXRzQ3BXcWkz?=
 =?utf-8?B?Y09LTGg1b3dacTZZUkJoZFhkelRxMlhRM2MyYlA2eVFQc0pGRE5BV2Npd0NM?=
 =?utf-8?B?WHVqemhkMWtNaHZGeElxL1FkQXFJeC8rNnY1YTB3eFB3YnFGcEg3b2piQnI2?=
 =?utf-8?B?R2hQRmJ2aGNBS0hqbU1qK3RPV2ZxMXRKMmpZbEt6dXVjS2Nzd3JKbURSbGkx?=
 =?utf-8?B?VjIrck04SlRUc3h3V1lHT0dQeDRNY2hSTFFwOC9HVzNHdTg0THFJY3BKV1pI?=
 =?utf-8?B?OEd6c2ZJUU8zRnJwZ3A1NjBMSHEvZG5sbUtvdVdMTW83YjZVVDJVeThTYyt2?=
 =?utf-8?B?UmxhU01EMTVzQ3ZLUUV5b1cwUkRsVmlBT3JTQU1QQjkrNlEvRWxQQXhzZjhI?=
 =?utf-8?B?WlVTMlBRemNLd0FBMzBERHJoUzdWSDhwdnBKOUs1WTR6MEtIMFR6MWg3ZEVY?=
 =?utf-8?B?d0h0QVZ5MENuZlE2QUd1QWdRS1lMNzhkY2Z0SmNSTllUNHIvWVg0STZ2YjBO?=
 =?utf-8?B?YnRuQjZnL2RsbHZMRFBVcDJGTG84ODJ0ZjJLVCtiRXFmQWdoSkVNTUlrZG16?=
 =?utf-8?B?R2RyTnBuckwyM1loWERxZEJzYXNIdEF5MVJqZXhFejc4OFR1ZTlLYi9tN21X?=
 =?utf-8?B?TTdZNXl4TlZ4MXlIWTdKL0JvL2JEYldlRDNSd1J4S0kvQzVhS1ZENGJXTHUz?=
 =?utf-8?B?bS9jL2hVTmg3S25SN3p1eWNaLzFwOWNLek9mQjNoLzBDcklqRjlIMzhNU0Uy?=
 =?utf-8?B?aFlXUGZBY0ljN1p6TFNNaElDU2xhNlc2aUQ0RDFVRjhDYVpuaE1NR05IZG4y?=
 =?utf-8?B?WDcrZWp1aWJnc3dXMkNVYXY4UlJ2cmFsVEdQMTZOUk82ajFhNDd0VEovSmhB?=
 =?utf-8?B?QWVPRElxVnY5ZlpJQlVzakgyL3Jzd1cySmh2d1loS2dtdnFKTjhlaEhSR3dD?=
 =?utf-8?B?MmIxZ3pDZnlwZFcvWjVFT2RDVDJmMHFLaFhuMzFDZ1B5Rzdjczk4YmdDTHlF?=
 =?utf-8?B?UE5UbHBCWUFOSHEwL1d2NHBiK1dkQnFrRWIrOUluRW1wY1ZhYVFKalJLSTBP?=
 =?utf-8?B?Uy9iRjFKNnVLTnRQMHpmNk1aSVlqOFhTYW1HcUs2OTJDZmY2N1NHcXdUY1Zu?=
 =?utf-8?B?QnZuY3dEYmExU3U3REQrTXVlcGJIUHlQTzVKaTVRTUc4NDl0ZXZyNGtGa2lH?=
 =?utf-8?B?dmxpK1pUSWZzbjkxc01XRHRnRll1bVdVU3czeDJnVE1wZCs1a0dEWktncjlB?=
 =?utf-8?B?SjNtMEQvTlp5ZVphYW9pM2xUenhrMHR3NU82R0hIT1hPemNUVEFlYmtFeUU5?=
 =?utf-8?B?T2J5T2JNR2JUODMvL05pb2dIeXhnRithUk11Mm0xRWt4N1ZYK3VVV2gwbmF0?=
 =?utf-8?B?SjJNVHRWMSttcktKNHVWVTNXYThVQ0h2cmZiZGFmdndxYisxS01GRnk2Zm40?=
 =?utf-8?B?RStvRlRvRm9FOTMreitLaVR1ODBycmp4UFZnN21UZ3o1Z2I2bFBqMm0zU0hm?=
 =?utf-8?B?VkFiSUJzRXJ0bEhPT0dueWJQWTFlaWxldkxDeFlqOFFKems4dCtlNC9IYjZL?=
 =?utf-8?B?SUxOYVIrNFo5QUpFWGo0Z0ZLY2lIUitKaTZRaGpuQThTcjFIRkt2dEg4UFlD?=
 =?utf-8?B?RGdvclJLcEh4SEZhZldFRENLWjA2bHBQekVPN1R2akFOaUVieUg2eFNJYzZB?=
 =?utf-8?B?QSt5MXZZSFJqNk1aSzZLT2dBTjhXdnhRSzBRYVdVWWo0ZWZFQnBlYWpyWnZ3?=
 =?utf-8?B?eHp2MCtNNlZKYUdrMUxzZ1hXUC9oRVo4Z0RZM041Rm0rYS9jY0NEL3c5WUMv?=
 =?utf-8?B?MGNVM21reDRkeXFsdDlHbllIUkFvM0c3Qlp4Q3lIZVlGakVLOVhyZy9kSlFN?=
 =?utf-8?B?V1VmNmNFdWU4b3lwUUpNR1RhZno0SHZzQ0dWTTdieUt0N04wU2xINlVRRG5V?=
 =?utf-8?B?cVluTEZxc0QyQ01jc0JjQWphU0l2bEJaV3B3RUd1UEgyZHhkcW9neDU2TFll?=
 =?utf-8?B?OTJrWW9jZ3QxWjUyZlB6V2d3dkYzQjlFVzFtYUJtbzlKQmxjMVRmZEZ4ckJm?=
 =?utf-8?B?RVdteHNiSjBrUVBBeUMzWllZSVFnRkIyY2g4azBNZEE4WCtEZXVZZmJZeFU0?=
 =?utf-8?B?OFVjdzFHWjVyRXRWdE4velVDajd5VVQxK2ZsKy9HUG9rWnloNko4d3IreEtS?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AE8174A9B96A34C83CAB98936485509@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6591e4d5-f7b7-42c4-ee9d-08dcc0e694c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:06:15.0496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HL739wJod3zlqy7sH9Ky0xE0fael/uRBeycrZ/U8mxdImi3T/k49tJaG3C4MjEM+IL/Qn0Kh19lh8TCpQ8/L8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE4OjAyICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gTWFrZSB0aGUgQUNQSSB0aGVybWFsIHpvbmUgZHJpdmVyIHVzZSB0aGUgLnNob3VsZF9i
aW5kKCkgdGhlcm1hbCB6b25lCj4gY2FsbGJhY2sgdG8gcHJvdmlkZSB0aGUgdGhlcm1hbCBjb3Jl
IHdpdGggdGhlIGluZm9ybWF0aW9uIG9uIHdoZXRoZXIKPiBvcgo+IG5vdCB0byBiaW5kIHRoZSBn
aXZlbiBjb29saW5nIGRldmljZSB0byB0aGUgZ2l2ZW4gdHJpcCBwb2ludCBpbiB0aGUKPiBnaXZl
biB0aGVybWFsIHpvbmUuwqAgSWYgaXQgcmV0dXJucyAndHJ1ZScsIHRoZSB0aGVybWFsIGNvcmUg
d2lsbCBiaW5kCj4gdGhlIGNvb2xpbmcgZGV2aWNlIHRvIHRoZSB0cmlwIGFuZCB0aGUgY29ycmVz
cG9uZGluZyB1bmJpbmRpbmcgd2lsbAo+IGJlCj4gdGFrZW4gY2FyZSBvZiBhdXRvbWF0aWNhbGx5
IGJ5IHRoZSBjb3JlIG9uIHRoZSByZW1vdmFsIG9mIHRoZQo+IGludm9sdmVkCj4gdGhlcm1hbCB6
b25lIG9yIGNvb2xpbmcgZGV2aWNlLgo+IAo+IFRoaXMgcmVwbGFjZXMgdGhlIC5iaW5kKCkgYW5k
IC51bmJpbmQoKSB0aGVybWFsIHpvbmUgY2FsbGJhY2tzIHdoaWNoCj4gYWxsb3dzIHRoZSBjb2Rl
IHRvIGJlIHNpbXBsaWZpZWQgcXVpdGUgc2lnbmlmaWNhbnRseSB3aGlsZSBwcm92aWRpbmcKPiB0
aGUgc2FtZSBmdW5jdGlvbmFsaXR5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNv
Y2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4KClJldmlld2VkLWJ5OiBaaGFuZyBSdWkg
PHJ1aS56aGFuZ0BpbnRlbC5jb20+Cgp0aGFua3MsCnJ1aQo+IC0tLQo+IAo+IHYxIC0+IHYzOiBO
byBjaGFuZ2VzIChwcmV2aW91c2x5IFswOS8xN10pCj4gCj4gVGhpcyBwYXRjaCBvbmx5IGRlcGVu
ZHMgb24gdGhlIHByZXZpb3VzIG9uZSBpbnRyb2R1Y2luZyB0aGUKPiAuc2hvdWxkX2JpbmQoKQo+
IHRoZXJtYWwgem9uZSBjYWxsYmFjay4KPiAKPiAtLS0KPiDCoGRyaXZlcnMvYWNwaS90aGVybWFs
LmMgfMKgwqAgNjQgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAtLS0t
LS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNTUgZGVsZXRpb25z
KC0pCj4gCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS90aGVybWFsLmMKPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Cj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL3RoZXJtYWwuYwo+ICsrKyBsaW51
eC1wbS9kcml2ZXJzL2FjcGkvdGhlcm1hbC5jCj4gQEAgLTU1OCw3NyArNTU4LDMxIEBAIHN0YXRp
YyB2b2lkIGFjcGlfdGhlcm1hbF96b25lX2RldmljZV9jcmkKPiDCoMKgwqDCoMKgwqDCoMKgdGhl
cm1hbF96b25lX2RldmljZV9jcml0aWNhbCh0aGVybWFsKTsKPiDCoH0KPiDCoAo+IC1zdHJ1Y3Qg
YWNwaV90aGVybWFsX2JpbmRfZGF0YSB7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHRoZXJtYWxf
em9uZV9kZXZpY2UgKnRoZXJtYWw7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHRoZXJtYWxfY29v
bGluZ19kZXZpY2UgKmNkZXY7Cj4gLcKgwqDCoMKgwqDCoMKgYm9vbCBiaW5kOwo+IC19Owo+IC0K
PiAtc3RhdGljIGludCBiaW5kX3VuYmluZF9jZGV2X2NiKHN0cnVjdCB0aGVybWFsX3RyaXAgKnRy
aXAsIHZvaWQgKmFyZykKPiArc3RhdGljIGJvb2wgYWNwaV90aGVybWFsX3Nob3VsZF9iaW5kX2Nk
ZXYoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UKPiAqdGhlcm1hbCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHRoZXJtYWxfdHJpcAo+ICp0cmlwLAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QKPiB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2LAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgY29vbGluZ19zcGVjICpjKQo+IMKgewo+
IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWNwaV90aGVybWFsX3RyaXAgKmFjcGlfdHJpcCA9IHRy
aXAtPnByaXY7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGFjcGlfdGhlcm1hbF9iaW5kX2RhdGEg
KmJkID0gYXJnOwo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0
aGVybWFsID0gYmQtPnRoZXJtYWw7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHRoZXJtYWxfY29v
bGluZ19kZXZpY2UgKmNkZXYgPSBiZC0+Y2RldjsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGFj
cGlfZGV2aWNlICpjZGV2X2FkZXYgPSBjZGV2LT5kZXZkYXRhOwo+IMKgwqDCoMKgwqDCoMKgwqBp
bnQgaTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBTa2lwIGNyaXRpY2FsIGFuZCBob3QgdHJp
cHMuICovCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghYWNwaV90cmlwKQo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIGZhbHNlOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBh
Y3BpX3RyaXAtPmRldmljZXMuY291bnQ7IGkrKykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgYWNwaV9oYW5kbGUgaGFuZGxlID0gYWNwaV90cmlwLT5kZXZpY2VzLmhhbmRsZXNb
aV07Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBhY3BpX2RldmljZSAq
YWRldiA9Cj4gYWNwaV9mZXRjaF9hY3BpX2RldihoYW5kbGUpOwo+IC0KPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKGFkZXYgIT0gY2Rldl9hZGV2KQo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gwqAKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGJkLT5iaW5kKSB7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+IC0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHRoZXJtYWxfYmluZF9j
ZGV2X3RvX3RyaXAodGhlcm1hbCwKPiB0cmlwLCBjZGV2LAo+IC0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFRIRVJNQUxfTk9fTElNSQo+IFQs
Cj4gLQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgVEhFUk1BTF9OT19MSU1JCj4gVCwKPiAtCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBUSEVSTUFMX1dFSUdIVF8KPiBERUZBVUxUKTsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIHJldDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNl
IHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoZXJt
YWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwKHRoZXJtYWwsIHRyaXAsCj4gY2Rldik7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKGFjcGlfZmV0Y2hfYWNwaV9kZXYoaGFuZGxlKSA9PSBjZGV2X2FkZXYpCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJ1ZTsKPiDC
oMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gLX0KPiAt
Cj4gLXN0YXRpYyBpbnQgYWNwaV90aGVybWFsX2JpbmRfdW5iaW5kX2NkZXYoc3RydWN0IHRoZXJt
YWxfem9uZV9kZXZpY2UKPiAqdGhlcm1hbCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dAo+IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXYsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBib29sIGJpbmQpCj4gLXsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWNwaV90aGVybWFsX2Jp
bmRfZGF0YSBiZCA9IHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnRoZXJtYWwg
PSB0aGVybWFsLCAuY2RldiA9IGNkZXYsIC5iaW5kID0gYmluZAo+IC3CoMKgwqDCoMKgwqDCoH07
Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiB0aGVybWFsX3pvbmVfZm9yX2VhY2hfdHJpcCh0
aGVybWFsLAo+IGJpbmRfdW5iaW5kX2NkZXZfY2IsICZiZCk7Cj4gLX0KPiAtCj4gLXN0YXRpYyBp
bnQKPiAtYWNwaV90aGVybWFsX2JpbmRfY29vbGluZ19kZXZpY2Uoc3RydWN0IHRoZXJtYWxfem9u
ZV9kZXZpY2UKPiAqdGhlcm1hbCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZp
Y2UgKmNkZXYpCj4gLXsKPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gYWNwaV90aGVybWFsX2JpbmRf
dW5iaW5kX2NkZXYodGhlcm1hbCwgY2RldiwgdHJ1ZSk7Cj4gLX0KPiAtCj4gLXN0YXRpYyBpbnQK
PiAtYWNwaV90aGVybWFsX3VuYmluZF9jb29saW5nX2RldmljZShzdHJ1Y3QgdGhlcm1hbF96b25l
X2RldmljZQo+ICp0aGVybWFsLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRoZXJtYWxfY29vbGluZ19k
ZXZpY2UKPiAqY2RldikKPiAtewo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBhY3BpX3RoZXJtYWxf
YmluZF91bmJpbmRfY2Rldih0aGVybWFsLCBjZGV2LCBmYWxzZSk7Cj4gK8KgwqDCoMKgwqDCoMKg
cmV0dXJuIGZhbHNlOwo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IHRoZXJtYWxf
em9uZV9kZXZpY2Vfb3BzIGFjcGlfdGhlcm1hbF96b25lX29wcyA9Cj4gewo+IC3CoMKgwqDCoMKg
wqDCoC5iaW5kID0gYWNwaV90aGVybWFsX2JpbmRfY29vbGluZ19kZXZpY2UsCj4gLcKgwqDCoMKg
wqDCoMKgLnVuYmluZMKgPSBhY3BpX3RoZXJtYWxfdW5iaW5kX2Nvb2xpbmdfZGV2aWNlLAo+ICvC
oMKgwqDCoMKgwqDCoC5zaG91bGRfYmluZCA9IGFjcGlfdGhlcm1hbF9zaG91bGRfYmluZF9jZGV2
LAo+IMKgwqDCoMKgwqDCoMKgwqAuZ2V0X3RlbXAgPSB0aGVybWFsX2dldF90ZW1wLAo+IMKgwqDC
oMKgwqDCoMKgwqAuZ2V0X3RyZW5kID0gdGhlcm1hbF9nZXRfdHJlbmQsCj4gwqDCoMKgwqDCoMKg
wqDCoC5ob3QgPSBhY3BpX3RoZXJtYWxfem9uZV9kZXZpY2VfaG90LAo+IAo+IAo+IAoK

