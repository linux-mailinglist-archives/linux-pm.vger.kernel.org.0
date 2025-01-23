Return-Path: <linux-pm+bounces-20828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD3A19D6F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 04:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0645B7A4FCF
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 03:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF9612C7FD;
	Thu, 23 Jan 2025 03:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wo3SkpYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17519BBC;
	Thu, 23 Jan 2025 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737604546; cv=fail; b=bVd5/6vlF4m+GVmKZzD41PJYkPErjnWPCtS2w5eSLPSVEWOA6P9JU893t/Y1MV4NJLEw7wqeMHTRYbEyLo2ZuADa59/cjlKzXNf0q40Xp5KC/AUBQy8nbASmHfLo+4TvODeT0xiax4AFHmmplrp/wssmPQjpoYMtNa/KWXKCXBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737604546; c=relaxed/simple;
	bh=7kLgpBWyoXsIdPe9o2s9uuxrn45JESy4gHV0zK3K+Sc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oh2AuwnoH8UYTAIjE1BM3MzFTmVQkqeO+KMQfu3wXaYeyeyVZTPUWc9KeTkUPcuDQnO1DNgcjDosE6SskR5bURGVG7i6WAwiegwIIt+b/jRl0zD/TFg7Eg2wEUUsiKF6UkSQE4bmpkzHu4jBdpV77qOKtTTuMs8JNPdwbP+bj+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wo3SkpYA; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737604545; x=1769140545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kLgpBWyoXsIdPe9o2s9uuxrn45JESy4gHV0zK3K+Sc=;
  b=Wo3SkpYAXJpHIXqDQMeoPRyP8IL282r/fCSHniXrV3OlN0Q6WwASzSVe
   +n7d+NDmYnuz0E0JCD+hmu7gcivh7Y39qohNBVxfVui08fzzuOQa82x4y
   QLyreWv83kOtWLNYT20jEhPTb5VTxCUIHaoMHyUMA9Y6dUUZlqwyUjnh6
   FkNdwJeegVyM3jEX4xHmCfUtbq16CNcIQ+b5MzStUAXp6N5Ve8LrfJyiz
   s3SJhQ4qevz54U5C4ZOGNMsBLVTUEXRi1cSxxfJqI1qxkXmcT2d8wLjAb
   3uyyt2rPcGV7cv7/+21CM5hiqnq8N/oKz6kf0A+SIJbpuKw+m56NatyN2
   A==;
X-CSE-ConnectionGUID: faQzQlJxQMmRe4XXlHYBGA==
X-CSE-MsgGUID: VGSmJ9n/RRuE7cZGiJyemA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38192492"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38192492"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 19:55:43 -0800
X-CSE-ConnectionGUID: dMRPxN61QReDMY39HJIVaQ==
X-CSE-MsgGUID: WeQk7vlFRCO7rK6T+/Kslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="107333172"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 19:55:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 19:55:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 19:55:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 19:55:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+avWOCMnuvORcD9m30RTkSUdftKp9RbAb3fDb0QLzzIEakOtR1/hlYHi/aqzp93ybOYO5EJ2eMN3gS5N5k50IWuSY2xcXswDxussYpW7jtozWLSiX1f22l3ASrVMpN+cBadkm3OCqo+BA8VXUknTtfZXh/s6VxxlGgf6uJ5KFy1av/EvErAi2XuGRKguAYAZ9+VQVG/AwNAzwaAkThe10Kvs8ILLV1pcYmaTNvLMTeqY0FNypKbr8v8+unvx3n8vBmRBUCELXGnepaK2iIBt2StqiFrVP46Z8T3hFA9mMVzogsMyybxMQHjaxsFU/mYgP7h1eHdyqr9e3eq9r8hrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcPfD63CyV+5QDRQkzsVCXEMedfepFyTywHRzw8gMcw=;
 b=egVLaTvwrlk4KOouKMbE8dgfnEBhExKgumL0BU4PVkXCf7VXgraAlYgabl5ZXxTsE9IZ8jEhOcyh4eqS2rY88NBMlTbd7uKvcC3W8j38k04lv1bfDh/k4QOfUJOjbIXkONx1QB+JJQ6y4in22eDrzCvtG/H+PEkLM+lFw55s4x0bQCyp0/OUJapU4TPLgReb+UTFrcOkQeta4UEi9UKKbEWi780zteDFhwv2m009W1HnHMN264y7Z1eFxVyhkDNKJrDlp6Li1fek5z7bIg/Jzd0aW5hyqgDUyCDnmrWreH01jFZ4zwfwMp+lwjYFKHv+LkSHwOd5ZZKUOSpBFtbZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SA1PR11MB5924.namprd11.prod.outlook.com (2603:10b6:806:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 03:55:38 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3%4]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 03:55:38 +0000
From: "Cao, Bingbu" <bingbu.cao@intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Media
	<linux-media@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Block Devices
	<linux-block@vger.kernel.org>, Linux Documentation
	<linux-doc@vger.kernel.org>, Linux Power Management
	<linux-pm@vger.kernel.org>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>, "Qiu, Tian Shu"
	<tian.shu.qiu@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Ming
 Lei" <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, Jonathan Corbet
	<corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len"
	<len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rajmohan Mani
	<rajmohan.mani@intel.com>
Subject: RE: [PATCH 1/3] media: ipu3.rst: Prune unreferenced footnotes
Thread-Topic: [PATCH 1/3] media: ipu3.rst: Prune unreferenced footnotes
Thread-Index: AQHbbNraFM3IN60onUyHv+AZ/ZAC+7MjutcQ
Date: Thu, 23 Jan 2025 03:55:38 +0000
Message-ID: <DM8PR11MB56534969F9891ECC31C4681799E02@DM8PR11MB5653.namprd11.prod.outlook.com>
References: <20250122143456.68867-1-bagasdotme@gmail.com>
 <20250122143456.68867-2-bagasdotme@gmail.com>
In-Reply-To: <20250122143456.68867-2-bagasdotme@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5653:EE_|SA1PR11MB5924:EE_
x-ms-office365-filtering-correlation-id: a66c2035-2f4d-4bf9-0ac2-08dd3b61cc46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sf9KSQ3jYpy8PhJqh5LowCisP4CVH1jBaTFZcbMeGczGT8euOMyPtXzr7bkJ?=
 =?us-ascii?Q?chDoV51TVwtbfrK11xCih5aG6OZypnA/dehE2r05xvURlSds+0I62E2oQbFD?=
 =?us-ascii?Q?b32yLsfsm1JiW6KhnzsZ6BMgM9f3edWgNIJOPo4cqz9O08zO8nE8sq7jYVac?=
 =?us-ascii?Q?x+qQo5CB9F0pb6FaQM8VxUKvFWu5iBs3T/UiPg5bNJIghaQwqIAMzTG/D2Ky?=
 =?us-ascii?Q?S4FV3Der8KbFluduNmJufmY2TSP/eB0FpaEddrf0LVmL9qTp/WP4d+xvjrFl?=
 =?us-ascii?Q?t9Os3qARqRSUEU2OWrmbrSWQywQ+KYO7hXyMMzKLYRv1vL5DrG2GF6/Biaw7?=
 =?us-ascii?Q?yRWuE75x72ibdgQT+WUshJMzpNIcxWzHgWogiT3ISkt3KZGNEi1jkMqWKapt?=
 =?us-ascii?Q?OT6JqTlPhpwvSTBMdljigJV5x6SiA5BRtYHCkvx6n9hah2QjL09YIYLTAdVo?=
 =?us-ascii?Q?4lfRgNeoZUIaSIjFfSBaQyfoiN/LW4+/GFOWKFADGcYKvWzUeRs0wHS+JkuR?=
 =?us-ascii?Q?iHXkNp6kO5ymyd6VSsaT4qGXS2d9uYa6ZhWp7Xb5gHokC5DVrqpPpMHw8w/N?=
 =?us-ascii?Q?sGCl7exPpyZK38/FVO3Oc0nxv9cfyTUI1iRNVVSy3UzqnBKOTrFVhg7JvdtF?=
 =?us-ascii?Q?8kXo71TnPk6LZlyhFdgijH/R7VCNE4gLkMt5JV+bg+/Jgr8fO2/iiZqKf6oM?=
 =?us-ascii?Q?uAbS6FKmW0b1PqEnMbu1ErWOE/i0R0zI4bO9Kx7RXc83hF+JQw+T0LihZkvB?=
 =?us-ascii?Q?peu2E2x0HQOa+wih+h0rnoGr1UOQTKbz3R59OhL0m05r0TEaNx2iJ9XRuC1v?=
 =?us-ascii?Q?UCRYPMUp2hVVGRHO3Ni6URF3wcfi/9Ya4+Ll6vCnT8HpIaPzibYO07Lxxk5D?=
 =?us-ascii?Q?1dz8j82g1geJqz6sCkTeBHSYXZ+flOXHz2acCp20sOpR89Bj+TyOcHQ0p7W4?=
 =?us-ascii?Q?QaeBbujUk/JVEzYsReVzw8hEVtOam6hF8CjffTYINjd/73Tqb21jdWuD0pAH?=
 =?us-ascii?Q?OvXEl7pMZpPvVCTghXbxcpnubW879ePbqkpPiGJERl3//9vvo1vBrgoonFBV?=
 =?us-ascii?Q?o4oj3J2/7gQfoOyT0NiDXQFuvZZcMo9PUbg/Jq9qgnza9Z4zbiKpiFmMEOd3?=
 =?us-ascii?Q?b4bTfF62IHtC4yk9eS6BEi6mQPYmLn+5vHoiZIyVh6edGqWaogAX4gGRcBME?=
 =?us-ascii?Q?zwF3JrfvOGHdjyDyrmExvOXWueAdwZcAASU4mCZaHCmhAmsboJiSwtFJZFj5?=
 =?us-ascii?Q?cGx58KnyVJnDyab1E/4SC2kr7BIMSINOjjybt0Se9KEAiguA3zXXvhFnRzMM?=
 =?us-ascii?Q?my9aSTXLSECjenpIrH8jbvNxcw5Dosw64MFtIc1QZ/1igOI+zaf47t65RFzP?=
 =?us-ascii?Q?2n3c3pTDnBMgfwXT/3yHIJxat/SAPZW03xJWKu9GtqZ7MX+6iA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5653.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k0q6q4GKXpbTUNRschOqJj9/ArZ3ZLa7KIjBHpTlpv0rXcSWIbfkwNMPMmmd?=
 =?us-ascii?Q?jzgLP73jE1BmdNm7VOs/MMoec8RuUevnf5QAV3zhq58Fh1eDbjLEnjc9hw+T?=
 =?us-ascii?Q?mwjvZrA23eUTc3WQXTAGzwsSYnFhCzCWNU//MqdQp1k1RW+qe7TPZAJaawti?=
 =?us-ascii?Q?nvnbMdxMZkignP0x6XRo8+1aLsPIFkiM+MQB5nunYycFh+87TjAMgxW8o5jo?=
 =?us-ascii?Q?3KWY9jc68jNY28Ce0SaDXBFJWhKywCYh+uPlvhNystnTPHx1aRhzFLNQ4ClI?=
 =?us-ascii?Q?LFkJ3B+aHLT4KYAcrdrnnT7/ToytoYXb+Bd100wa9aabvB4JcbvRLiHn34B/?=
 =?us-ascii?Q?LZWWqDnkMQRSSaHr7nMIhj6JSvab8/Zq07fWS229A4eTMScISkYCPRzI7vKc?=
 =?us-ascii?Q?hFP1fKyl1BOFqUSqqiW4TI+LJ55horihXQhQ6AsnqDq1AV7z6FAnlwVzHnbd?=
 =?us-ascii?Q?a7iZGuOut6+bj1S0DN6K43N3Y6Ikct7AuhwKsFD8mqpLekIzLW6bF6pyxCWC?=
 =?us-ascii?Q?ZshU/66EnV7c7U213iXIhyG6bxeim7GrYZluTCljGdMhv0AuSPl0Z4vl72NQ?=
 =?us-ascii?Q?SWvZXXGQJ/avfU0RIsWuL36R2AsU2gcX2WHRWipePhaNKNXZ94RTzLVLpMJB?=
 =?us-ascii?Q?BxIJDwf5a9nNx735gOsW1tQyLcg3PlaHPamt+Km4vViWH6kbB6qzU2+wJ45s?=
 =?us-ascii?Q?yMsmh2i6tnUVzmBcoGjk0tEx/VMqLoNQToju76NdGNF3VEgVst969cZw+987?=
 =?us-ascii?Q?b2kKgyfEqM/L9wtnDDlCsMOzf0vvEn1mjV7a38ihTaEOGSjM2Wp3Pyhh133o?=
 =?us-ascii?Q?QAkGnae0GUcDIQZrU9r1N5LRp+9wwkoZSCV9kQ/58KciXmkUfhm/M3y6iN7r?=
 =?us-ascii?Q?y5QvmNTVBG7Le1ewPXIpAp6UxUHB8yPydMsaXt7Gdmd6hEq2mu2IywIDLvZ3?=
 =?us-ascii?Q?JQCN+zPzUvSCFEqnddZqIMBa+zbxoyTCF+7cElL33M0HWd/N1zAenPL1l5lV?=
 =?us-ascii?Q?GgdNRU8yDlvToC+rGBR6E9/y2nNw/hT2ie4m/RWwBhQgjTSLvbMYm0ZTDNzE?=
 =?us-ascii?Q?dW1MwyR2GIG8o0o/MjVpHGwRiW/FYyMbgFRJvMzUnk4hS26ndPpZYzfqDXbm?=
 =?us-ascii?Q?YXT/8wvFAHl0ryFdG4l+O2ys2in9fKGkpPxKtX7dkrNmAijX7+F1jYNOryu7?=
 =?us-ascii?Q?DzLej7oLQ3S2D0KxSlIuep6tqX5kerlzeBiN1HC7s/9BFHWQ/ut9vwtJ8wLv?=
 =?us-ascii?Q?j6kKqQw3ElpLFgbEbKED6/qRKw7EfgNVEhhhE6qm3DerS5MHZ0bxk5N6UzoM?=
 =?us-ascii?Q?912FNfBuRsQ5yMUsg8F1dgE2XdcA4gvIY9UBxTCrH4A+ZUTUDXu5UWNni9kf?=
 =?us-ascii?Q?hb9qKQhk+UFblcE5MZZHB/K1FADgEMyVAf/+N4uIhc4hroPrTabkVGbU2/vA?=
 =?us-ascii?Q?n4Ys2WVAAvw4gwdN37UMdutFhtphTdn4k4O9RS0wc6EfINXMbDub/jQCpW9c?=
 =?us-ascii?Q?gDnv6tvDWK0I689ooz+z6DvD7XYJKNzRCfN4SYBUkPx7J9n0AHio/Tx4GPJY?=
 =?us-ascii?Q?0ltR8TMkzfLHWWTIfN5XZ6nMVEMYVGLtL5VlJkHe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66c2035-2f4d-4bf9-0ac2-08dd3b61cc46
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 03:55:38.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/1iyzOoNIaqcfbM6Ml3UR2v/caodMm4MNdoho2Zi1/cQSv11dr/GRso1BlbqsIm/W/+hIX5q77Q1V7y9mTJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5924
X-OriginatorOrg: intel.com

Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

>-----Original Message-----
>From: Bagas Sanjaya <bagasdotme@gmail.com>
>Sent: Wednesday, January 22, 2025 10:35 PM
>To: Linux Media <linux-media@vger.kernel.org>; Linux Kernel Mailing
>List <linux-kernel@vger.kernel.org>; Linux Block Devices <linux-
>block@vger.kernel.org>; Linux Documentation <linux-doc@vger.kernel.org>;
>Linux Power Management <linux-pm@vger.kernel.org>
>Cc: Sakari Ailus <sakari.ailus@linux.intel.com>; Cao, Bingbu
><bingbu.cao@intel.com>; Qiu, Tian Shu <tian.shu.qiu@intel.com>; Mauro
>Carvalho Chehab <mchehab@kernel.org>; Ming Lei <ming.lei@redhat.com>;
>Jens Axboe <axboe@kernel.dk>; Jonathan Corbet <corbet@lwn.net>; Rafael
>J. Wysocki <rafael@kernel.org>; Brown, Len <len.brown@intel.com>; Pavel
>Machek <pavel@ucw.cz>; Bagas Sanjaya <bagasdotme@gmail.com>; Rajmohan
>Mani <rajmohan.mani@intel.com>
>Subject: [PATCH 1/3] media: ipu3.rst: Prune unreferenced footnotes
>
>Sphinx reports unreferenced footnotes warning on ipu3 docs:
>
>Documentation/admin-guide/media/ipu3.rst:592: WARNING: Footnote [#] is
>not referenced. [ref.footnote]
>Documentation/admin-guide/media/ipu3.rst:598: WARNING: Footnote [#] is
>not referenced. [ref.footnote]
>
>Fix above warnings by pruning unreferenced footnote to intel_ipu3.h
>UAPI header (already referenced in its full path in "Running mode and
>firmware binary selection") and by directly link to v4l-utils repo in
>ov5670 configuration example with media-ctl (since the example is in
>literal code block).
>
>Footnote numbers are unchanged.
>
>Cc: Rajmohan Mani <rajmohan.mani@intel.com>
>Fixes: dc794d3d2424 ("media: staging: ipu3-imgu: Move the UAPI header
>from include under include/uapi")
>Fixes: 34fc0e1bf892 ("media: doc-rst: Add Intel IPU3 documentation")
>Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>---
> Documentation/admin-guide/media/ipu3.rst | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/admin-guide/media/ipu3.rst
>b/Documentation/admin-guide/media/ipu3.rst
>index 83b3cd03b35c36..3a8c3d46304b7d 100644
>--- a/Documentation/admin-guide/media/ipu3.rst
>+++ b/Documentation/admin-guide/media/ipu3.rst
>@@ -98,7 +98,8 @@ frames in packed raw Bayer format to IPU3 CSI2
>receiver.
>     # and that ov5670 sensor is connected to i2c bus 10 with address
>0x36
>     export SDEV=3D$(media-ctl -d $MDEV -e "ov5670 10-0036")
>
>-    # Establish the link for the media devices using media-ctl [#f3]_
>+    # Establish the link for the media devices using media-ctl
>+    # (from https://git.linuxtv.org/v4l-utils.git)
>     media-ctl -d $MDEV -l "ov5670:0 -> ipu3-csi2 0:0[1]"
>
>     # Set the format for the media devices @@ -589,12 +590,8 @@
>preserved.
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>-.. [#f5] drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
>-
> .. [#f1] https://github.com/intel/nvt
>
> .. [#f2] http://git.ideasonboard.org/yavta.git
>
>-.. [#f3] http://git.ideasonboard.org/?p=3Dmedia-ctl.git;a=3Dsummary
>-
> .. [#f4] ImgU limitation requires an additional 16x16 for all input
>resolutions
>--
>An old man doll... just what I always wanted! - Clara


