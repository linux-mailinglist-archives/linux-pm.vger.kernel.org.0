Return-Path: <linux-pm+bounces-37052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB03CC1BE62
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 17:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7C86E4B7F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C9F338906;
	Wed, 29 Oct 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/QDO5d1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA425C96
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752540; cv=fail; b=JPqnnMWT2dYqTl3L+1oOSM3vUiJIIKcBEHNnXJwsWcoDKECBivFEqB6AYBwOgXdqkr2q2IuUwDPIQnbu5Ts9LKni/yGUGeZPaDj2ykDMfvZKwZEqDU3cG+KxWU+uoI9OygYdYCtJo7vs6daiDIlnqUbY5YJNpF2zMdKFQkKEoqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752540; c=relaxed/simple;
	bh=kgwC5Hwzh6tNuicLR37u2j6mPhZTPG3fUkrycGzojnk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8QQPSEWbp/mCA35/IJcxqoLuwQEuSfQhvMGfjYP3+AwVVjbp6XeCMWBv00T3kvm9+iFF4ycoraz/Hu2wwgGgl9twAoJ+J30FYAN6oJlojiitplGJelffQtOIrE2w7mXYj+GI6PTAAiA3wRJhwpiaaxqWPhUzqmprNXQlyPugXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/QDO5d1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761752538; x=1793288538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kgwC5Hwzh6tNuicLR37u2j6mPhZTPG3fUkrycGzojnk=;
  b=N/QDO5d1d9HlezWyuZWoxuDkDaQWjGB7ziAMqc29bKdZVEhv+5jMNIiu
   mw6t82CZQlFH2ily8heaYqEswXbIWuN6yjWubmvt9+XRF/F+rqZGy9N1L
   cyOdCc46iuRmu62BApawBQxW7GjNPOQMvkedN8y8++tD4T+43jJb9Zyji
   J68t2J8LjnQzClxU3vN1t9hkofYvo5SPfq/BsiwbK1jlMjvhDGOUa00Gx
   cf4LbO185qBXKVpO+z6uJVsCyXPhMbiztuYGVfbbO8zcjcATzuzn7+5bX
   JI4I60243A7wYFFC3bhkMGSuTaP1tgI38P7JLk45V6JJcAgxWP/zOUwIU
   Q==;
X-CSE-ConnectionGUID: 9ecT3YFAQDqK3Zak3bZJgg==
X-CSE-MsgGUID: UXUX5IqHQKC7p4refT1d5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63084880"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="63084880"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:42:17 -0700
X-CSE-ConnectionGUID: qenRgHTrTOGt1dAO+zUOhQ==
X-CSE-MsgGUID: RealNdr2RFWmUdec/E82EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="209292710"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:42:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:42:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 08:42:15 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCDhOWHHfN/s7WBR/0bFLIj11boZQQ/Co5+Umr8S6Wy8H1P6JICcM+yvoxA54MAtUqfmZkTovvR4klK/Ip9a4WApQP4y0zssRUQIXjZWu7QpyPRk8KF6ELLkuBDI9b5EXprTUsnTmOedLKO7MtnTf0S8wkJqZdLTyGeBKtlkci/YdI4LPWLe5IafJH5eOFcTO1nJcQQqkw4bsxdIx6BOrFM91OJJRhthkGQj2BSft6wT2/scgoDsU/ar28GgvWSB+swTLYYUIncZk3cyAM/fF5cT7ea2YQ3bmmQQ6+OIM50RB/ikiLdTsWokSNVaduILw+ImmfMHoiZ6cnENHpmQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ry7y4lPy7b5anBq9ronw4BtXDMdOEetncoho47+BKw=;
 b=ylJFIRGb4aj1gEIbs20KZbokuU+j4TgR843hfEwHPNEtzJbn/RX7Eo7QFmjOAfROZVAqxMSWkzRyEXCb6HmCrbR1WZAQMnYUxqPVZFq0hcyC/efBvE1LfExmmZ292PmOp/xDN4zyM5xD6TfF0oY9//dQpSp6a6ApKoTYBCboFL2ZzNeOVs3y/LXPqsI03BiTdIDAKJZXPyAXx7e/Rxq4F3vdpmfeInAQ/hs7ZN6fhldtNEtwCxfqzttFA9EVXPaoVbHniLJHE9gwLKXYeuLYh/F4D5/6MUp1NDGvYLWxO4MxoWnImuA5r67QZx1vG+JkEEw0jFdrmKwCcvbksizwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DM3PPF733C3E759.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 15:42:13 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:42:13 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2] ACPI: mrrm: Fix memory leaks and improve error
 handling
Thread-Topic: [PATCH v2] ACPI: mrrm: Fix memory leaks and improve error
 handling
Thread-Index: AQHcSOf2LXicDx3BIEOA3NManEyl87TZQy+w
Date: Wed, 29 Oct 2025 15:42:13 +0000
Message-ID: <LV3PR11MB8768C23270CD0926037ECAAEF5FAA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251029091013.3682552-1-kaushlendra.kumar@intel.com>
 <aQIxYyNx65UQYTh3@agluck-desk3>
In-Reply-To: <aQIxYyNx65UQYTh3@agluck-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DM3PPF733C3E759:EE_
x-ms-office365-filtering-correlation-id: 0dae1947-6cff-4dc9-fde6-08de1701bb1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?eSISEV5mkIfJmFzCVbFeSHqYHkHPgCByFIAJjgjWArQTVWYIbz7ZDh+8KTKz?=
 =?us-ascii?Q?xfo+8mgtlfepcxhVzqp10SZm1Vr6MOn1z0noDQN/b3xSm5Nc27040m9OvmTG?=
 =?us-ascii?Q?ZmC3V0OsZMLxOHOv2z4A/5l7CNzwkdDN9jnUyPNfW6BEi58fz5AqTdfNWyH7?=
 =?us-ascii?Q?Pv0VA7q2WdUVFJghUvdmgYSKdcjdTP3WPG6mkowP6gx080sW2944qhug7dn6?=
 =?us-ascii?Q?EaguWxe4ASautP8LalQOf1chpUvoRXApazpjabGpFUubZZd//AGSV11fS+9x?=
 =?us-ascii?Q?O1h3tZSSW/TBbCQe71ylHrRg/83cUHZ68r+jB/GLryZpgnnfxyDcJhIzOXqo?=
 =?us-ascii?Q?qYjeKc1Jq3WFWtfHiFTTwXRKVuySyI87LOqJxdCCaS5BqewNMEGObmd7t73w?=
 =?us-ascii?Q?5vzJbxHXNs8uedKBXLtl+nXtXZff9Ci6vucTXyTf2Ti50ZwaDpd3IiUREajI?=
 =?us-ascii?Q?HGnlXk150vCq8vP/vqwhHSYBdzctWQjWKDDWJ2Vnm17DlurC0q+nh3O5NYCW?=
 =?us-ascii?Q?yMhr+eXSp/5iWS9GdQlfgydtskVavN0eK/SsS9uIMjzPYG6GZO4fGppkPbUH?=
 =?us-ascii?Q?f0Wpw4JgQ8ztMss2eVzfkEKxhcYHPvY4mZvwnnM0DWYpbOzWBkQLK+DEzowx?=
 =?us-ascii?Q?QZj7FKg4NrpKk3oZoOEVkt9amk1I1yqpO+TyNlld+T2avKjXoSWmRSkWTz7x?=
 =?us-ascii?Q?0sApvxJS8iPvQob7ch5pxHQEM1Ovzpj/k5nFVtXfbGuR6d1iJl2yl0Q/kMQK?=
 =?us-ascii?Q?GbB/2Wx7fJooTwgaQpKBhroVnd79c+TvkUAUGhFcx28QIqF8UlYnTw2yHLpI?=
 =?us-ascii?Q?HqZ5u2E4Y8jPWmA0MpY3nCs8IgIkh5CHBp2dCWvoVc4MB4gh2EIjN3mfAjlM?=
 =?us-ascii?Q?TN5ZrZya5qkOMmlpluHuX3EObRM7JiVzdGpm0N0rS0F1UGdI+flrSQZdHShC?=
 =?us-ascii?Q?gaMzdqdVstp4qOXCMpaNZokvQnTxBVmiHscTV2ewm3iMF2Gii03ePBQCN+mP?=
 =?us-ascii?Q?WjjNlv+vsSaLC2wb8EQjthGciLlwThakXE9qwrQhfDfHZzJp5vnzNvyYgS9X?=
 =?us-ascii?Q?PU6GDlUJlDqMLuQ+0/Lp3xGhaTda+IyBsB9hOYa0W7jkL+Ls9YS+z2xuRquj?=
 =?us-ascii?Q?fuPId7nqBamL6fB/t9TdWyn4vLaii8KuzK1laqNxF4WYfyCGOIzlItUwbp/5?=
 =?us-ascii?Q?h9Ybi848IDE/o5SAcZAgAckOo773nHPxib1Gkp/Nt+6elsVw0+ai6IMx9ITz?=
 =?us-ascii?Q?giOfLkz/RN6IR1g1tEUWlJkHK1jQMYjZvkfcOC7MTJdpX+tzs6aaPPHXwLnd?=
 =?us-ascii?Q?S3Gk8Vg+mNjvVXCIfIo0lxC045So0jRQFqAI43pGcWdlJDYa0obV5bUW3Ftw?=
 =?us-ascii?Q?mlzfAoSyO6BspNjJHvk+VM3mSoak8SZOMGSseYoxsZQynnEeJQh+LL4VhnIp?=
 =?us-ascii?Q?ubYcu0fqihuVilXb9xjYmsnRRAIPaDKL5SqZSMsOaM9aMcxLzYQO89qmFPrI?=
 =?us-ascii?Q?NALJGEiaATwNc7ZlzwQkUZCGuIlRD47HRCCN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pinq9xHViZQEg1T7jfbI+3ET68lwbf+2JSwOGtSgGVGHgoFTuD0t8LeLWvZV?=
 =?us-ascii?Q?ULAAAXheMtlXwkn3NVURHqVMEwBta4NyxjXZkRebsHv0IUheBDqGad33OIB7?=
 =?us-ascii?Q?EtKaugZjYTno9LBuZbvkPUKcQai2xbyvUUFWa2BEERu2JR9HWeBEmxZxjJE+?=
 =?us-ascii?Q?3kwFXQnjzCCkxKG8+jPargoCP0jmQZA2dNAZr8tWOHAuMfPB0YzT3TuJUfjH?=
 =?us-ascii?Q?jHfmyVBZrH+YpVY9QSY01e4ylVrAWA2wi4dDpZjR8B3rt5yx9LK6p7PNYqJe?=
 =?us-ascii?Q?q//68paSfStikT67vCegV9zMwt17IfpJo9L77/JB37MCj2/fYJSSoAUH3S+M?=
 =?us-ascii?Q?KZv9rREDXkQ/CGeNVqiveGFVfKyyjF7kHvM1shQzPyh6KnJz5vK8WW73hsKO?=
 =?us-ascii?Q?mS1NkB6sux+uHxaIcnBwEO3Cx59N8oFB7Md46DsGdAkw+H6YioeIfuBMFi3o?=
 =?us-ascii?Q?u260SZ2xvlil3EXvEtJ6zFFh8Sydxp/i+dIJsR3Zl67jaCgFXNXatptCaq9Y?=
 =?us-ascii?Q?cN47Vn85b+GqXR1BbEAZCmdivIIB1y+eKCagAJfYj+AaBKrPoXDbeIVQpiUX?=
 =?us-ascii?Q?JNQ0CU0hup778/jYE1u8TaGSMTGR5evaKq7+ZAD2U6pQmhovSdMRYd7CqEm8?=
 =?us-ascii?Q?ItOy+DXUq8yb7snTaMTnSyjlGqW/KTcgN4hSX5055o3HHBOfjvoTP0nx26H/?=
 =?us-ascii?Q?nXgI91JVaTHlpBrPyKAPJiwdIq1DHhatQedjDqHSXx3MA6P6Il8gZAGAFSGa?=
 =?us-ascii?Q?p9tjapv2ygdvvMOIKgTVreCF70ImVgJb+R6jIISSiIWXc1mLkHI93Mb3PISM?=
 =?us-ascii?Q?mfvmGVg4b8kKw8+7C6DVCE4padcN3QvlaDH5H7sAOV5N5lZJqkhbeM0MTZcI?=
 =?us-ascii?Q?PGsYbg0v8ca3kR5dv4xRVXSDKKvrQUm6PnbyDvsBpHBPef55w/S5ymxv/oUG?=
 =?us-ascii?Q?FkgTp/H89ahDVdQr/BWjNAE5rcPPeEH1/S1yftAJ7ilMTDgcWZesm41fzx9g?=
 =?us-ascii?Q?EePYR3uMUlDdyexc2n4Q2uBwHbWvuauFEsDToGP2IZWu174zYF5qFwkwAaLj?=
 =?us-ascii?Q?Bd5Ikmf0YVTzyFtwiMPtn5D2kxTxX0NUbY1Yn9+CHDuClaEm3RJc55FBWLwm?=
 =?us-ascii?Q?gLAycnIBeZCeaPWJxprbaqogq6it/E0NrtNpg8CnrjLV2YwxBthYpvZ5rr5P?=
 =?us-ascii?Q?QxEIho27eFNqqP5P1w3onfe9VJB20mWXcq4qgoZSX7j/VtUFDIWprZAkFR4w?=
 =?us-ascii?Q?Gyy1/7JelpRzEgMjhER7J3EOEPafHxHSuWGOOi+NHW6IC1CPIrReMQEMrp9Q?=
 =?us-ascii?Q?XTiz78v5aCHLbxZmgajdywOPXeNBPr8uzbp7mrA16M83lulbK6iwnnOVFW+0?=
 =?us-ascii?Q?VbAAolP2B9d17M4l2YVGbds3//GUOUKZh4SFBlpvVUzqZkbOITbTBwNTas6R?=
 =?us-ascii?Q?cku5RY0I+iRMkI6Mwgj6Fx79qGsALcl6hOQOPHpQi3IMb2szhGGCyLfDX2vb?=
 =?us-ascii?Q?CddPh7rxUmlK5axkAjN+PshRJjUc/Oii9Cpo1mkQrllR+IRRxf36LO8vsZ8F?=
 =?us-ascii?Q?OrKdAvcgVYPINIvYhF6WgamlXKVdrPY3nPhFWy4J2YIjExvjn7Lm/cmstkFu?=
 =?us-ascii?Q?wUIQSyOPUcezA3Cme/bBw9s3pekd0CDimle9nLeybeQoFuCXLHssspWORlYS?=
 =?us-ascii?Q?NZn5jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dae1947-6cff-4dc9-fde6-08de1701bb1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 15:42:13.4557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkiQbVK+AZHa5pdONVsUP6LtbUqmg6FIOcI3rnI9tty+WI9N6I4CKD8HzJj2I4iy1iuEZejzh+8lL9UWCbvboK0wsqvu9AFY3TjVL3YNH28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF733C3E759
X-OriginatorOrg: intel.com

On Wed, Oct 29, 2025 at 02:40:13PM +0530, Tony Luck wrote:
> Need to
> 	kfree(kobjs);
> here.

You're right! I missed freeing the kobjs array in the success=20
path. I'll add the kfree(kobjs) before return 0 and send v3 patch.

Thanks for catching this!

Kaushlendra

