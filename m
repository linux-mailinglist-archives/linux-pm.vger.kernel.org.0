Return-Path: <linux-pm+bounces-12283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54377953FDF
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485251C221F4
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3577655898;
	Fri, 16 Aug 2024 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBk8YVkm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC73BBF0;
	Fri, 16 Aug 2024 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777168; cv=fail; b=XwC33HDsnvEqKuMQyqlSHJYrFPGdz2VTC/yrS5dlGnoUVlhwvjRhtTs4JLoTJaHYRMdO4mMB9DUYzzuqfGzG8WgQ/IlaA8iyasKOvFlgwemweTXwF7eivoEqZtP7R2lOD9x5QhPpQRz5sJA08Jlvt9vIqbJ6mQujfZqkILiRdfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777168; c=relaxed/simple;
	bh=BoMUYbKLsgozJBdz2KqyS9150Ral4+q7ACpQuiosrOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pjp0s3Tjabkv4t3HwJWxsBVInXv3OfagBQ5uJYVEVRd90IYWzxq6N9pdVx+gAPh1MRZWV2kipb5oq4edHPVgu+X7y5F2YoRrUa6SUc6QgUgG21SfcxQKs2GzJx5ITvgodCeJjMoPXwTdJ/GacoL3if5wdzVg3Us3/CVF/cr3+E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBk8YVkm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723777167; x=1755313167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BoMUYbKLsgozJBdz2KqyS9150Ral4+q7ACpQuiosrOU=;
  b=FBk8YVkm7jf9oOVZYOM6lHtVTNbCDBNt0HYJF86M5ijHq6zfyVr4hzPK
   cJ7sGyBkaqkxB02EYrnPswS15BMs/U1h9ug1msHJ8S0LwiwUsEtsc+l+B
   zN5kYTT7cDOXapYPFBD/JfTlb3ZQ9mmNG9IbkbJ8RTNJd8kN7Gfk+Yp20
   N8tBVBv8C4EVvwxzVBQMF9/74GRACkY4pG3ijEKcb+LcaDJnGBly9Qx6n
   BA51ESfkDs8cKEcoCBRUTDxMAUgRsn0BqyUYicJI/5w6+fVvGz1sbU+iL
   vYgGP3kGLHypElCCS6DHkQNPJBiSkR3aCyZ34Vf7umlviGKSxTdvF7bFe
   w==;
X-CSE-ConnectionGUID: FRJ+YgmhTEifYmafFoerKg==
X-CSE-MsgGUID: E5w98T/ZT6OBvkzJQV8jgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22032739"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22032739"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:59:25 -0700
X-CSE-ConnectionGUID: 3Ejp+g1YTCWJMgEeeK9Diw==
X-CSE-MsgGUID: FSc09/Z0QIOgybXJp0l6fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64434998"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 19:59:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:59:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:59:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 19:59:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 19:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDK5SX1S2paj/szfqnPiaSodH8Pi1zGvDyyP8KNLbTRd4Y2Lk1GVxJa5lrnVG0AvsRtC0/4+ULB9EiG/d/d9ANe2E7cQDpX+6vyqI5saaqXFoc+o9GBGOpFKeGdAF04Tk5+WJdEKoGWgT/zF0yLDecKrJ+Hlg8svHxG5q8LKkjoWEuAzc8z/VYQUkNI2mZhcSYkoRYhyl+lgLF+5Iy5DvVj8jceTu5D9nhT5h5H2zIjAe68YdJs3vTAJH0YC//Hrl+TvYU6QEmlLHKQKGpw/VprVvSJl1xWs4MkEMjJDRJp60dwYYhS4NDiCJty9FlS4Hfbpq9gSJIcm62ZEJ6jnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoMUYbKLsgozJBdz2KqyS9150Ral4+q7ACpQuiosrOU=;
 b=HKTC6RkP6/5f4A/2TchQLCK0vu1DSG7dUHEI8264RaZlrOwF0hHEjXC39oG1CB+84lYyJOdqBjLZwezBXSfhmG/UY3td1iAhfC0A2RFOyFSu9E8Wkbddovcs65S69VhxfvP+uLSwNFdnPk27IKrBFqFQ88i+9okLcDwLOpGOLY1naMsyMYe+/EKh+iAPgBq8vtw/Wr//uPvXk+pfT+lI+DV5f3dh2a5hCYzxohpeFsLnbTLlJ+8HUbCXexsuKqfNbXHBwmCE3+OOyYZFcE5EMxRtffVlF4R+myTez7Oh8p4k/f3OJLiKwskV0U77mpEGf8i/UZy/dQ+dxlWq3g6+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 02:59:20 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 02:59:20 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"peter@piie.net" <peter@piie.net>
Subject: Re: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
Thread-Topic: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
Thread-Index: AQHa7Y0/nb0hc/COjUmHmsGZ2tMf8bImRdwAgAC9OACAAKeXAIAAmWYAgADxZgA=
Date: Fri, 16 Aug 2024 02:59:20 +0000
Message-ID: <ba0d605b90ca91f36697f86f15e09e229ac82465.camel@intel.com>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
	 <2285575.iZASKD2KPV@rjwysocki.net>
	 <2f16fd5a59d6655ec9339473d516ac49c89e43f8.camel@intel.com>
	 <CAJZ5v0icxkRyd_1T53JmX3XDQOC6_Ak9nOD65Yx-rhZbDa4Y_w@mail.gmail.com>
	 <6f3c94464ae9c2fd4e4d3c75f7f837aa073517ee.camel@intel.com>
	 <CAJZ5v0jZvOiJMGEt8FwOztQfjfBTGqdrt8_oWug+GeZ4DR6EBw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jZvOiJMGEt8FwOztQfjfBTGqdrt8_oWug+GeZ4DR6EBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB8500:EE_
x-ms-office365-filtering-correlation-id: 0e6cb35f-8547-4706-7db5-08dcbd9f6ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c3FPeWNxVEZMT1RrdTBCbWx2V1BQbTRZU0h3UTJUWjJ4bXphUzdERldqMGpC?=
 =?utf-8?B?ZXpWcnhNQUxsZ0pmMGcrZkNzTVJWcDZ5dCtVZTFvelNQdURIYzdEVWQ0TVpa?=
 =?utf-8?B?aWVnVXovNEg0dXFqOEZIRTZ2bXNaa0RlZ29pS2NJL0VocnF2U0VtbHJwRnZq?=
 =?utf-8?B?dUh0U2pvSXpKcU94YmU3TmMwaDFxVWZWRENWL013eUxITlNSQlpVVHVkTGk4?=
 =?utf-8?B?eWRGYWdlNDZiSjV2L3BQWjk4Z1R4L0pzKy9ZVll4dHVzWmJnOS9LMUdHcEJa?=
 =?utf-8?B?T2lTdzEzd01nNC9UUzM1LzlIU1ZHU1pMbmx2aDM3MS9zbnFFYVVTZFhkUzVv?=
 =?utf-8?B?RTVENEZha1NCM09xUUUxWGlOcjJzMzZSQ0dHYW5TWFFqUzRLbkdWb0trMVQ1?=
 =?utf-8?B?VGZTVGd6QVRNTjZXdWZmVmszV283ZFQwQ1dMUU16WHhQTXBvZTVoZWFSTjZo?=
 =?utf-8?B?OU8va05GWlpnTUVwd3EzeDUzaWxQRE5YRjVYQWNZbllKc1ZHVHFyU3J4UHN5?=
 =?utf-8?B?NWJmbHNiOEowMDdNYjJUczVYRVJ0OGtWbzJGa0U5WWR3Rks2TzB4aTM4MXdT?=
 =?utf-8?B?aTZSTWIzSVpRcHY0NjVPRWtjWTNIOVNiZS9QeHRFZUYvd3dzUDZta3NJSGE3?=
 =?utf-8?B?cnNzbVNHazhDaGw5MjNXVVFvbG9WRndncEtzaGdBY2JIeDBKbzFiS2RCanNG?=
 =?utf-8?B?TEVCU240ZG5GZStkaTRYb2MvU1JLUFFZUXNTMkp2TnVja0xqRE5NUEZvOEVq?=
 =?utf-8?B?U2g5T1RJQkx5SnNxMHN0aHI4T3F3bGpXTklnM3lHZGNSVW13RS9vMnRGaWYw?=
 =?utf-8?B?SWlFUXlXZTEwUW5VTXNHQk4rSDJxZThzeFZPbWZFSlRLZ3RNK3FEUVVqaFd5?=
 =?utf-8?B?dFlkTWRYcG9TQysrWWJDYS8zRk9KV3Y0YkY1MzdTR0gvSksrMXJkTkRrQlEy?=
 =?utf-8?B?dGRkRjhNWFFLTXBIQnEycFc4c0t3b0w4YXJHTHRsc3lURkV2M2NLOWRiV0wz?=
 =?utf-8?B?MUtydE5BUmZKRlovMGxhb2p3RFR3ZWFUYU8xZ3paVHoxb0JvRzlsN3o4a2Qv?=
 =?utf-8?B?ZTk3anllaDhmWFFsU1YrQXFrZ0ZWanJtdER6YXUzMDFnZHdTMExkcFZpV3V3?=
 =?utf-8?B?d2o5Z04xSVFzeXR1Zit5QXhrMTEybDM0WlNvRnNVdXBCWndaUmFUbmdMOTFh?=
 =?utf-8?B?ZkFpaXN6Z005b1JjZU8vMktJSFM0aXNSVmFwRGh3QXd1cUdoY3VoY09uZ0V5?=
 =?utf-8?B?Vk5uR3FLa0g1YzJVd1JGRE9DZ21sZ251MkJsbzFkV0VDUThxRFRWUG80UzhJ?=
 =?utf-8?B?SFlDWnlLNkIxeFBDSjVvaW1RT3BveFRYMTM2MVlwc21iTDdmRUxEWVBVams5?=
 =?utf-8?B?dDZra1FzcXRIcGFEZXE0ZklkUDlMZ1pLY3hEZlpFdmwwUUNWcmsxVVJTZUV4?=
 =?utf-8?B?L3o3R0JMeE1NR2t1VjRWcjlzRHpSTDVpb05aT0k2cFk5NjZ5KzFjSVpOQ0Rp?=
 =?utf-8?B?SmJsV0hJR1VNdHpzNnpONXYwWWdLOU1HcHArekpPakJPajNyb0pxOEpLaTQv?=
 =?utf-8?B?WlEwaXhZSGo1Q0NNWTh0ZkJTLzMzWWZMNC9DTDcwWXc2ODZyeXozTkxCbWVH?=
 =?utf-8?B?cEFXTjF4b1pEYVAxb2dUeGQ4VG1RT0tadTVUWWt1VFFPYUxON1cwbTczSWhB?=
 =?utf-8?B?eVRwcWMyR3NmSzVVUkxLam15VjBPaEU5RnRQUHVJYk9VaVdEcGJzZklEL3Fi?=
 =?utf-8?B?Qjc5bnNSZEZUdTlraGVpc1FkVUpjMzhJL3J2Um5abzFtQWhIM3BoczkyTXZ2?=
 =?utf-8?Q?rqHf+6dsOXEq5sgOtM+JWqVsOvv4CdurQ/BMk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWcvU1lRWG8weTFNM2QyWFc1UitqdDN2NjJ5RjBza3N3d0hNUVFIa3hXZHRW?=
 =?utf-8?B?WEZlMTZwb1RBdWx5QllXdERNcndzc2Q5emo0cVBpa3lyUHA1ZkhadWlGdHdq?=
 =?utf-8?B?cjJHWnoza0xuWjM1dlVuN3BLdXk5NlAxUnYzdTdzUS9rSGhyMGh2MlhML2JN?=
 =?utf-8?B?cExaNVAvajAvNHErK3MwZGZIUkp3Q2lseFo2MGVrRWFVbnIzM3RNZmNtckNP?=
 =?utf-8?B?LzZvb0V1aDdHcElUTlI0UkFRS0swSnE1RVkvSXpMaWtyYWJrSStwRG0xMVk4?=
 =?utf-8?B?NlRKS2hqbDMvQWlEaEh4WTFUeTBSYTlCNmtVNXJDWVk2WEZTNTgzQ0tEOCts?=
 =?utf-8?B?Y1dkRjhYTzNGV1grTmxGWS9nSHljRmN5UjJYSTBBQkRzd0t5bk1GcTJTcVNi?=
 =?utf-8?B?Njd2V2lBelE1RW4vYm9NSWxUblRia1dUOEtQMmx3Y0wwMThjT3g2ZWFVV01B?=
 =?utf-8?B?blZpdFNKNXpsWE9tMUN1TjRqcTVXcklmbHp4bm4yUFVEZFMwSUo3WTJxcXZP?=
 =?utf-8?B?UXJjU29DTVc0WVZSTHlTNW9YTlE2WmdXSnlTZ3NIQVFpVmkreU14NEJmR3VP?=
 =?utf-8?B?VUFib1pHNklZaWNLOUo2d3FpcFlmT1YrVHlBejVISFd5cWJ5MG1Ka01KR0sz?=
 =?utf-8?B?R25BaFZHU0xxRldOQ09RcnNxQ2dINWwvOURGTGdQMXZtSzkrcjBvcjlmaXJi?=
 =?utf-8?B?cndObm45cC8yZ3QzRkFCa0xwWXdpRm9mbmk0T0NrY0ZLNTVCVnZyRDA4a3dZ?=
 =?utf-8?B?djQ5TkJQVzBMR0Z6QVhrOFdYeHU0aVQyUzkvL094dFVlMUpVYklWQVgrZExF?=
 =?utf-8?B?bDV5djdENExJQXlGSTNidnJHNFJ6eEZPS2prS0VOcnlPNlNmOFpZT21ud3dK?=
 =?utf-8?B?RUFnUjIrcEJBUm5aN2lmNXY2R3kvYTFWcCtOMmZuaTJwbVpTYnpMeXNKSlEv?=
 =?utf-8?B?dWxsTTBGRnMyWGN2SStKOEp4NmdBYjJ5WE11MGFHZGJSQU5wSmZqaHY5N1FP?=
 =?utf-8?B?TFJEUWlYOFFYQ1FuZXVJMGlBSm8xMWw3bGJoc1FCTlJKWGRKZnIvZC83bC8y?=
 =?utf-8?B?WjVGamh1eUE1MG9ycXhTMC9Oa2xjS1NwQUozeUlLdE9XNVhLeTdxRmNpVUNy?=
 =?utf-8?B?MExtNjBqUHlFN0VQRi95cERBY0xuejBqeEFhanVLOVN3cUhuRmdTTllFODk4?=
 =?utf-8?B?Y2pWTFdDQmcrM3AxWUphbG9PeUd6U0JkMCtjUnVLS2lpMW1MalRjNkVxdEZs?=
 =?utf-8?B?amlBcnVYdSsyaHVDTVcrTHlFSG1ocGNrSEY1cytvQUEvRmZLTkxJMFZzU2tN?=
 =?utf-8?B?YURkM0Q2U0RuQTU1YzhCOU1QM25tbjdHVTZmMzlLZmRvWHlSU3hpNEdQVElR?=
 =?utf-8?B?RU03SWNscEpZbmlwSTRsYWthS0tEV2xOTzlnZDAyMXhCU0RGYlhIMHhabms1?=
 =?utf-8?B?SENLVmR1dmZtVDU4Tk1ZS3NqakRkME5XaWhyZm1IaFFqNkFSY25mVjluY1VG?=
 =?utf-8?B?NGlJVXo4MVZhM2R6Z1FuNE43b0FjTE56VWNWVFJ3UnJ2akJHMTR4eENZTUhm?=
 =?utf-8?B?T2YybnpwWDdRZ0tjVW5ERmEyRm1TalgwT0ttZkVaUG9FV1JvRkxGcHJGNzdh?=
 =?utf-8?B?ZXJ2cGZaeDB3Wmx5b3REK09ESWJpRjYreVV0MlJybHgzRXBmNFQwc09nS1pW?=
 =?utf-8?B?d21Kd3JhbktxSnAyU2FBZHJSS2loOEl5UUd4TVpMckt0YXNuSFRlUkRCVHh3?=
 =?utf-8?B?MzNrMFV6cFdjTU0rSE96cVZJblNQSlcwd2xxWitzSXFoay9pRXBDQnBIMlZi?=
 =?utf-8?B?YU96UTVITFBYSHZ2TUJxaFd3a3JiL3JPS21RZksyM3N0aENScDNZT090ZGFo?=
 =?utf-8?B?RjF4WHpJWnBMalVLRTFYbHNNeUlUYW5GSCsyWmkrMWd1UFZrK0NOQ1lJclpi?=
 =?utf-8?B?Z1p0Mzl2cnloT1dGYUpsdzk4dTNpVllKS2dVWk53TWhla2hLcEJrRGo1ZitC?=
 =?utf-8?B?RkpzeGFBVzVhdjFyZTVIQVdIeFRkNW5MbVBxbko0TFBDYTQySXFwUkNSRXZt?=
 =?utf-8?B?RzBlelpvdUFiejJTNXN6bTVIT3lxSWxYMGd3cUk0S21kY1UyQjNYM3NVeVNm?=
 =?utf-8?B?SzRjVTMxYSthcFlCTEZhZ2xCZ1kzaldqL1RFTDRvMHdEYXc1WllmME5HRmwy?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C42E6E5ED05CAF488B2B32B65792350A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6cb35f-8547-4706-7db5-08dcbd9f6ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 02:59:20.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cscbwEvHiQFpchK91TZIQw0o6PZFbYSXLk6p/WFV/X6xXz7RWYkq/ab8AtfwUcTXAAQsMZ2Nrt0pRChExc++OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTE1IGF0IDE0OjM1ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBBdWcgMTUsIDIwMjQgYXQgNToyNuKAr0FNIFpoYW5nLCBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNC0wOC0xNCBh
dCAxOToyNiArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEF1
ZyAxNCwgMjAyNCBhdCA4OjA54oCvQU0gWmhhbmcsIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4N
Cj4gPiA+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gVHVlLCAyMDI0LTA4LTEzIGF0IDE2
OjI5ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBSYWZh
ZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gQWZ0ZXIgcnVubmluZyBvbmNlLCB0aGUgZm9yX2VhY2hfdHJpcF9kZXNjKCkgbG9v
cCBpbg0KPiA+ID4gPiA+IGJhbmdfYmFuZ19tYW5hZ2UoKSBpcyBwdXJlIG5lZWRsZXNzIG92ZXJo
ZWFkIGJlY2F1c2UgaXQgaXMNCj4gPiA+ID4gPiBub3QNCj4gPiA+ID4gPiBnb2luZw0KPiA+ID4g
PiA+IHRvDQo+ID4gPiA+ID4gbWFrZSBhbnkgY2hhbmdlcyB1bmxlc3MgYSBuZXcgY29vbGluZyBk
ZXZpY2UgaGFzIGJlZW4gYm91bmQNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IG9uZSBvZg0KPiA+
ID4gPiA+IHRoZSB0cmlwcyBpbiB0aGUgdGhlcm1hbCB6b25lIG9yIHRoZSBzeXN0ZW0gaXMgcmVz
dW1pbmcgZnJvbQ0KPiA+ID4gPiA+IHNsZWVwLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZvciB0
aGlzIHJlYXNvbiwgbWFrZSBiYW5nX2JhbmdfbWFuYWdlKCkgc2V0IGdvdmVybm9yX2RhdGENCj4g
PiA+ID4gPiBmb3INCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiB0aGVybWFsIHpvbmUgYW5kIGNo
ZWNrIGl0IHVwZnJvbnQgdG8gZGVjaWRlIHdoZXRoZXIgb3Igbm90IGl0DQo+ID4gPiA+ID4gbmVl
ZHMNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IGRvIGFueXRoaW5nLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IEhvd2V2ZXIsIGdvdmVybm9yX2RhdGEgbmVlZHMgdG8gYmUgcmVzZXQgaW4gc29tZSBj
YXNlcyB0byBsZXQNCj4gPiA+ID4gPiBiYW5nX2JhbmdfbWFuYWdlKCkga25vdyB0aGF0IGl0IHNo
b3VsZCB3YWxrIHRoZSB0cmlwcyBhZ2FpbiwNCj4gPiA+ID4gPiBzbw0KPiA+ID4gPiA+IGFkZA0K
PiA+ID4gPiA+IGFuDQo+ID4gPiA+ID4gLnVwZGF0ZV90eigpIGNhbGxiYWNrIHRvIHRoZSBnb3Zl
cm5vciBhbmQgbWFrZSB0aGUgY29yZQ0KPiA+ID4gPiA+IGFkZGl0aW9uYWxseQ0KPiA+ID4gPiA+
IGludm9rZSBpdCBkdXJpbmcgc3lzdGVtIHJlc3VtZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBU
byBhdm9pZCBhZmZlY3RpbmcgdGhlIG90aGVyIHVzZXJzIG9mIHRoYXQgY2FsbGJhY2sNCj4gPiA+
ID4gPiB1bm5lY2Vzc2FyaWx5LA0KPiA+ID4gPiA+IGFkZA0KPiA+ID4gPiA+IGEgc3BlY2lhbCBu
b3RpZmljYXRpb24gcmVhc29uIGZvciBzeXN0ZW0gcmVzdW1lLA0KPiA+ID4gPiA+IFRIRVJNQUxf
VFpfUkVTVU1FLA0KPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IGFsc28gcGFzcyBpdCB0byBfX3Ro
ZXJtYWxfem9uZV9kZXZpY2VfdXBkYXRlKCkgY2FsbGVkIGR1cmluZw0KPiA+ID4gPiA+IHN5c3Rl
bQ0KPiA+ID4gPiA+IHJlc3VtZSBmb3IgY29uc2lzdGVuY3kuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50
ZWwuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IMKgZHJpdmVycy90aGVybWFsL2dvdl9i
YW5nX2JhbmcuYyB8wqDCoCAxOCArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiDCoGRyaXZl
cnMvdGhlcm1hbC90aGVybWFsX2NvcmUuY8KgIHzCoMKgwqAgMyArKy0NCj4gPiA+ID4gPiDCoGlu
Y2x1ZGUvbGludXgvdGhlcm1hbC5owqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgKw0KPiA+ID4g
PiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC9nb3Zf
YmFuZ19iYW5nLmMNCj4gPiA+ID4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPiA+ID4gPT09PQ0KPiA+ID4gPiA+ID09
DQo+ID4gPiA+ID4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy90aGVybWFsL2dvdl9iYW5nX2Jh
bmcuYw0KPiA+ID4gPiA+ICsrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvZ292X2JhbmdfYmFu
Zy5jDQo+ID4gPiA+ID4gQEAgLTg2LDYgKzg2LDEwIEBAIHN0YXRpYyB2b2lkIGJhbmdfYmFuZ19t
YW5hZ2Uoc3RydWN0IHRoZXINCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3Qg
dGhlcm1hbF90cmlwX2Rlc2MgKnRkOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0
aGVybWFsX2luc3RhbmNlICppbnN0YW5jZTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgIC8qIElmIHRoZSBjb2RlIGJlbG93IGhhcyBydW4gYWxyZWFkeSwgbm90aGluZyBuZWVk
cw0KPiA+ID4gPiA+IHRvIGJlDQo+ID4gPiA+ID4gZG9uZS4gKi8NCj4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgIGlmICh0ei0+Z292ZXJub3JfZGF0YSkNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgIGZvcl9lYWNoX3RyaXBfZGVzYyh0eiwgdGQpIHsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHRoZXJtYWxfdHJpcCAqdHJpcCA9ICZ0ZC0+
dHJpcDsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBAQCAtMTA3LDExICsxMTEsMjUgQEAgc3RhdGlj
IHZvaWQgYmFuZ19iYW5nX21hbmFnZShzdHJ1Y3QNCj4gPiA+ID4gPiB0aGVyDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gYmFuZ19iYW5nX3NldF9pbnN0YW5jZV90YXJnZXQoaW5zdGFuYw0KPiA+ID4g
PiA+IGUsIDApOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgIHR6LT5nb3Zlcm5vcl9kYXRhID0gKHZvaWQgKil0cnVlOw0KPiA+ID4gPiA+ICt9DQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBiYW5nX2JhbmdfdXBkYXRlX3R6KHN0
cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlDQo+ID4gPiA+ID4gKnR6LA0KPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZW51bSB0aGVybWFsX25vdGlmeV9ldmVudA0KPiA+ID4gPiA+IHJlYXNvbikNCj4gPiA+ID4gPiAr
ew0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgLyoNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAg
KiBMZXQgYmFuZ19iYW5nX21hbmFnZSgpIGtub3cgdGhhdCBpdCBuZWVkcyB0byB3YWxrDQo+ID4g
PiA+ID4gdHJpcHMNCj4gPiA+ID4gPiBhZnRlciBiaW5kaW5nDQo+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgICogYSBuZXcgY2RldiBhbmQgYWZ0ZXIgc3lzdGVtIHJlc3VtZS4NCj4gPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqAgKi8NCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChyZWFzb24gPT0g
VEhFUk1BTF9UWl9CSU5EX0NERVYgfHwgcmVhc29uID09DQo+ID4gPiA+ID4gVEhFUk1BTF9UWl9S
RVNVTUUpDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHotPmdvdmVy
bm9yX2RhdGEgPSBOVUxMOw0KPiA+ID4gPiA+IMKgfQ0KPiA+ID4gPiANCj4gPiA+ID4gY2FuIHdl
IGRvIHRoZSBjZGV2IGluaXRpYWxpemF0aW9uIGZvciBCSU5EX0NERVYgYW5kIFJFU1VNRQ0KPiA+
ID4gPiBub3RpZmljYXRpb24NCj4gPiA+ID4gaW4gLnVwZGF0ZV90eigpIGRpcmVjdGx5Pw0KPiA+
ID4gDQo+ID4gPiBUaGF0IHdvdWxkIGJlIHZpYWJsZSBpZiB0aGUgem9uZSB0ZW1wZXJhdHVyZSB3
YXMga25vd24gYXQgdGhlDQo+ID4gPiB0aW1lDQo+ID4gPiAudXBkYXRlX3R6KCkgcnVucywgYnV0
IGl0IGlzbid0LsKgIFNlZSB0aGlzIG1lc3NhZ2U6DQo+ID4gPiANCj4gPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXBtL0NBSlo1djBqaV83Wi0yNGlDT19YeHU0Wm00amdWRm1SOWpW
cDhRTmlDT3h6VjlncVNuQUBtYWlsLmdtYWlsLmNvbS8NCj4gPiA+IA0KPiA+ID4gQXMgbG9uZyBh
cyB0aGUgem9uZSB0ZW1wZXJhdHVyZSBpcyBub3Qga25vd24sIGl0IGlzIG5vdCBjbGVhcg0KPiA+
ID4gd2hpY2gNCj4gPiA+IHdheSB0byBpbml0aWFsaXplIHRoZSBjb29saW5nIGRldmljZXMuDQo+
ID4gDQo+ID4gcmlnaHQuIFRoZW4gdGhlIHBhdGNoIExHVE0uDQo+IA0KPiBHcmVhdCENCj4gDQo+
ID4gQlRXLCB3aGF0IGRvIHlvdSB0aGluayBpZiB3ZSBhZGQgaGFuZGxpbmcgZm9yIGZpcnN0IHRl
bXBlcmF0dXJlDQo+ID4gcmVhZCBpbg0KPiA+IGhhbmRsZV90aGVybWFsX3RyaXAoKSwgc2F5LCBz
b21lIGRyYWZ0IGNvZGUgbGlrZSBiZWxvdywNCj4gPiANCj4gPiBpZiAodHotPmxhc3RfdGVtcGVy
YXR1cmUgPT0gVEhFUk1BTF9URU1QX0lOSVQpIHsNCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAodHot
PnRlbXBlcmF0dXJlIDwgdHJpcC0+dGVtcGVyYXR1cmUpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGxpc3RfYWRkKCZ0ZC0+bm90aWZ5X2xpc3Rfbm9kZSwgd2F5X2Rvd25fbGlz
dCk7DQo+ID4gwqDCoMKgwqDCoMKgwqAgZWxzZQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBsaXN0X2FkZF90YWlsKCZ0ZC0+bm90aWZ5X2xpc3Rfbm9kZSwgd2F5X3VwX2xpc3Qp
Ow0KPiA+IH0NCj4gPiANCj4gPiBUaGlzIHNob3VsZCBoYW5kbGUgYm90aCB0aGUgaW5pdCBhbmQg
dGhlIHJlc3VtZSBjYXNlLg0KPiANCj4gSSBoYXZlIGNvbnNpZGVyZWQgZG9pbmcgc29tZXRoaW5n
IHNpbWlsYXIsIGJ1dCB0aGVyZSBhcmUgcXVpdGUgYSBmZXcNCj4gYXJndW1lbnRzIGFnYWluc3Qg
aXQuDQo+IA0KPiBGaXJzdCwgaXQgd291bGQgY2F1c2Ugc3B1cmlvdXMgbm90aWZpY2F0aW9ucyB0
byBiZSBzZW50IHRvIHVzZXINCj4gc3BhY2UuDQo+IFNlY29uZCwgdGhlIGRlYnVnIGNvZGUgd291
bGQgbmVlZCB0byBiZSBtb2RpZmllZCB0byB0YWtlIHRoaXMgY2FzZQ0KPiBpbnRvIGFjY291bnQg
ZXhwbGljaXRseS7CoCBNb3Jlb3ZlciwgdGhpcyB3b3VsZCBiZSBleHRyYSBvdmVyaGVhZCBmb3IN
Cj4gdGhlIG90aGVyIGdvdmVybm9ycy4NCj4gDQo+IElNViBpdCdzIGJldHRlciB0byBsaW1pdCB0
aGUgaW1wYWN0IHRvIHRoZSBCYW5nLWJhbmcgZ292ZXJub3Igd2hlcmUNCj4gdGhlIHByb2JsZW0g
aXMuDQoNCkFncmVlZC4NCg0KUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVs
LmNvbT4NCg0KdGhhbmtzLA0KcnVpDQo=

