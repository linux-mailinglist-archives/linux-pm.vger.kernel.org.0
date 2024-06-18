Return-Path: <linux-pm+bounces-9399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B779090C019
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 02:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368171F22040
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 00:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D22A3D;
	Tue, 18 Jun 2024 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+iRbwaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA736B;
	Tue, 18 Jun 2024 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669311; cv=fail; b=EID6RI6F2PWszhn4HEk/GNONsAM7XhVkejOG0wmoSMvmohl3Zxk/l3x05E6LBVrk2YPte+oaqTCBNxvzMRaoV0F4iUSqMQQhgMoU+XpGFjgxoKgtdeoq30vDDY1X95hDdBFwYJLc3PgcAK61wUG/4/lrITUucLp+NlSIuZbn3rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669311; c=relaxed/simple;
	bh=u+lMfy4tEqGzh8lUKh3xQKjs1fkg5Sk9nFP1GKZ1rdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9bhkxztOJg+5auXFdtkwNCC9A7ZWGp9q7czG2qxa/wv0IbBZRlmaB6zwyjM8QD7oYva7aYrso+Deah55/3ozTwgEZNuwCtU6BVhgvSmr+a1x+XOIbC+C51MIbr127tmCojed222ntkyMc8bZC9j3Ms/f0jXcBy0OhnPfudGkq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+iRbwaQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718669309; x=1750205309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u+lMfy4tEqGzh8lUKh3xQKjs1fkg5Sk9nFP1GKZ1rdg=;
  b=g+iRbwaQawtOQMrgqLHZ5trofSbqlCso4KH9UYxQVSmDKcTrJVETypH/
   Nut1RFq7kxsnVlz84rdzI1XeX5EcTcjhwgx1FyGdxhrNeFV3XtE2CXjgH
   LoBYZJhLJYd/JXLJluqzXgOo3yaR4MB1K74P8hi0qQbG2c9numx9Oa5L5
   qXe5a3dCsU65duJYV+ajUeTns3t45ITwhPValeiCxOeINgWWS++80T4xI
   90q+Mb5LmsaPZ6xH/WF6WfDqWHzrjM3RjFZLFKpmHIaDpQvK/0kyttTN1
   fjCfJtRRuX351DZMs1uN5cYGAAwBetsYPb5UF4LKPIDCFvLwegBjWA1yF
   g==;
X-CSE-ConnectionGUID: 3+UEFysoRqK1i0ssRAsLkA==
X-CSE-MsgGUID: /72GQ1xXQoSY+lfS/iNkJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15669764"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15669764"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 17:08:28 -0700
X-CSE-ConnectionGUID: 1YDZIwSpRD+hoRUjeAA38g==
X-CSE-MsgGUID: wr39FGAeSKyk/xXDe+h4DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="42042514"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 17:08:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 17:08:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 17:08:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 17:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFZ4JV1D7IBZdQm4ovSpKW6Il7cbbN9hBMNG//1vy77SmUew15o7DKPAW5d7Vl+uHYmmUIWJeM7lAU3ffLLwYF1b6rLobmp0eryEDK285Xxc5G7q3grzv0LyjEe2XjlOJjBeKteab9QpbNN5t58V3jka5mo0/rtne6Ol0Y85eJUkyuTMcDpD5YAq5RSJ6Gvi28zRqU/y2fS5bLnlcEdTPhBdeksQgpi3/RsJw6s+xsQIagdbwnZ1ilWBowfc8gACdGBfMatZab79h5nwuLSbBchMjH754IczeMAfAdF5DGPzPcZFnqaOb583OHA4Z22HESfxrvs25R7o8KTiSgOY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN0bzG791+rmzWZSIHUQr20wTTcKZEMF1MhRrYrvjQQ=;
 b=CxcIr6mKNV14trwZQfnWomps+ZKTtf7tBqO2Wve+6xhlVRvqK7cjH2tvp6EHhE9mP55ZEAx4cMzUSz25ToxhqoqYB+FO6MVIxaE/SYlOOtjvxgsN8VK0ReaaXz/Y+bMpk+UiIzCXKAHIvJRjWh/Cq2xh5hHaInVo3N7YbqIeYH1jxuD9GdCCE89pWIV4ubWyHhiiQSEsqf3sISlQjabV3odo21iwf/+L85TSIspmzb7FQMez60jaylkXazDn01bN+Sfrnk9vy2tNnuNhWhsFa8GZENz/cHSiK+yqACeF9KqfYJJAHPt2+WwbLxM9Yh95cJ15hnuMe/46Wqt7fgMANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7870.namprd11.prod.outlook.com (2603:10b6:208:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 00:08:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:08:18 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, "Liang, Kan"
	<kan.liang@linux.intel.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>
Subject: RE: [PATCH PATCH 8/9] x86/bugs: Declutter vulnerable CPU list
Thread-Topic: [PATCH PATCH 8/9] x86/bugs: Declutter vulnerable CPU list
Thread-Index: AQHawJaAKUTha4Y6kk+Wz79X9HXaorHL/9CAgAChxgCAAAOFMA==
Date: Tue, 18 Jun 2024 00:08:18 +0000
Message-ID: <SJ1PR11MB6083ECEC27A376E2CA898F93FCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-8-b88998c01e76@linux.intel.com>
 <fb789f0a-0c80-49f3-ab7e-d22fc2793a49@intel.com>
 <20240617235216.qqvfh2nvffuh7oot@desk>
In-Reply-To: <20240617235216.qqvfh2nvffuh7oot@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7870:EE_
x-ms-office365-filtering-correlation-id: bc751785-0baf-488f-c9be-08dc8f2ac1b7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZLBRuR+3CaKI8kZYfXfVsOnndFiibIJE5EkHuL/9DXd1iqDimjX93Oc8eFcf?=
 =?us-ascii?Q?i8hMFqNebgt/WOmJHEJGGjqaz9J/resMVfesZVaiyBtZ2gfQ+suVL1iw+y/z?=
 =?us-ascii?Q?ajQxP6rSSydRV9Vmv0b2QEDETvSvSuMGqqWule7vHf8vOQlD8RtJpuyTmrzh?=
 =?us-ascii?Q?5udKQBAzcPRh5USW2U7DtpzZd6PWqDmuoPUKogxMahoH4HfxC4C0QXaE1Uce?=
 =?us-ascii?Q?vLuC/cukkkFc2nwe9fDJAdrcugoYbuFMVGipifgpahb37flzFTbncq/QReFu?=
 =?us-ascii?Q?vv+1/J0537XmAf8b7BobWG3HCaKmVIjBJQ8VS8FjQReCZLSj2xf0hlQ+8L29?=
 =?us-ascii?Q?Kve9PzXHXQojdtATJxfpoFPRa0R3FuvgdGI1ji/VPNu3PgFSvI35vsHTSe3B?=
 =?us-ascii?Q?jdfTHRzadFAgefqk/FvEPvfnIEn/KC7RLwueEoZrnCmeqpqZ9t/LLuj/cajK?=
 =?us-ascii?Q?olYJj8TusibC+4TP/pBSDUFpd4yHef8gUrffUxqpf0hdekIXd3VcNXgLzs6h?=
 =?us-ascii?Q?iiu8NBZY/DqeQNL3UEFRHBAIFr2yjcWzyukyr2+Hexl1Hbqq3Si7HRtptRh1?=
 =?us-ascii?Q?9tvpoU/pZifgeSdtV6ose1x4kXP+fiFXKoqu1+fRPChpjDwFY1KnTap2ZlfK?=
 =?us-ascii?Q?/b8RlyoSO9exmAQ734HI8XwR2RUzOUytH60UJcN1m9W3jNxmA/N0j40PVBUY?=
 =?us-ascii?Q?P6f8S9yZ8YOh1xqeZr7GUSwvuRED2Y87W6ehjO7d7apODzwLoskzsfJ/rt3/?=
 =?us-ascii?Q?dGgn/4nS8wqgCiiJefKGM1xlWOL056Rt5+VhwTfui3w6CBarOT2lrQuG2GRl?=
 =?us-ascii?Q?ZSX6mjTjhxKnz4B/UHl8iVguKSoEJDJsxVREYR52eHCDSc6sXt6wS2BCgBxU?=
 =?us-ascii?Q?VLoaZz3WFZWhZ1LQSA96ClXbbreSosdXZ6pqgAxRnxle9vTazvXAey+Msdj+?=
 =?us-ascii?Q?1Jt0GIfwlpsMKTzZtvFan7CBOlhqVs2sCMfJvd6FHqTY5Fji/NkunAK7NJWL?=
 =?us-ascii?Q?gxFKWZviOxLIbnEhCcSm9RzNYN09r7rl21B5GUKMh8sH0059dlrY2geB9O8Y?=
 =?us-ascii?Q?teNLOoocXyQemhn/KdKXB46JuWpEHNdwRNCAvtisQQB4aWie1ISsdXSRusnh?=
 =?us-ascii?Q?h8192xmhD4iVk7efjeCeYLDXTUJomfkSD+lvAvgQztNxIcZPVlWejnGO4SWK?=
 =?us-ascii?Q?iTCFyfEX6Zirp9vYdSbUF92IOeaZu94oQzxzvr0Jbmn3bsUq5S2ddaes4l6R?=
 =?us-ascii?Q?nKAIECbCMqSaBWdDaf+BLoIRrkqIrPMrhh1xDkeu99F4KO9nikT+0PCObtqr?=
 =?us-ascii?Q?x4+AmSQUwh6NtBItOz/62AtTmOmNHqHjuJHUt4F0amcwT0q2bmE71pI6xhJT?=
 =?us-ascii?Q?H6yHZFc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ls5KOoFtsWu4jSnWjygYqqB7AKmdexhVkRB8gEAiGS7b5Mgu/qpnzcgZRcm?=
 =?us-ascii?Q?jiljy+z96tbkN9dE0hIpeI4bXp2kOOSnwa9kMVoncqbe1WujMfhI03cFZ3Qf?=
 =?us-ascii?Q?XhcDzGQGHfCGx8Rv/zPvWYC/00PBX/rK1Hpb66kq4opGQYduGP5uHX2NXwGq?=
 =?us-ascii?Q?3yiizTumgQlqNo+1/PjP1b5fLotJuW6SyfnnCWbjjtKnA02B8dV06VSD3uvh?=
 =?us-ascii?Q?qR1cpGDGprvKUshcSFREtyBC17hEIvfH2zvdriRta6ss7Crt7DSEonN+QxtV?=
 =?us-ascii?Q?9AZ0MYk5Nl1a+cLLHRMMHNCfV3I6gtTkN9J1QmPF/4lfQdp7dth4hDnexEfH?=
 =?us-ascii?Q?xhmp+G53UEmhuvWycEeNXsOsRWyMArodFS99bKiHzLLLK8vLwiQVxZszgfNu?=
 =?us-ascii?Q?9yuwSPuyEzhNNkGIrI2KicAFcScBt9p+M62mJUYPV80O0UUnvOZeX4WrKz4+?=
 =?us-ascii?Q?iWNP1DoMRwuBBt0jrGFrhSdGMYH5Aq4Nb89pHaYo5B9jCsI4jZKXJ32nuN3N?=
 =?us-ascii?Q?l26NhQRU6xou27Jv4NVyGdv/EPG+SQqAwFZx0wetrXQNuIRUfkG4dfnVAayt?=
 =?us-ascii?Q?rtTJl6CWP7BdhzTi7BTyoO1J29jkQFt69fnYrlKdZjVAWYz8i6yngc12/Akq?=
 =?us-ascii?Q?fyjhKnHI6H8q9t4Zn7sHGW7sdAuSq7e9rQvOgL8wvj4/7a4I1O9gKx9o1kG/?=
 =?us-ascii?Q?xTcjMDh/WV3M47Ck6GGpxoNaeU/yGFJHdnZArhmYGQZYM1ZumlY+PULlPcl7?=
 =?us-ascii?Q?mNCuvdgy4QyKqZqwbQu/jq+8ApJ1EAPqOJwtBBZ8NyrqfS3FKq67T3Q3r6K2?=
 =?us-ascii?Q?aXB2HzK7qI0z6aCxDzRLyJBnvxEjzqrHkrZduAJAxiCg/0J1PnaAV+bftTHK?=
 =?us-ascii?Q?fMJnJKZU9ec5jC/RrHJe/rdXqjokQxKqiA8hjyho3zv+oXoJ6n87SHh28hHr?=
 =?us-ascii?Q?p1/zE5P/t9k8ec/k0OiYoe5dJ7cGBMEO0Gt6MIg07TveVt+9NxYY7/+PZGxh?=
 =?us-ascii?Q?3yiwR1q7/jlTgjL6UyhP5kqmw4ZHaHZMprGgjVRVfDx8cOJKal1fTCX/64wi?=
 =?us-ascii?Q?m7iZ5Gdywbn5LHUG+JLATN+0dS7qINGYl/veAbeL7PXE5FVGUGqgErv4BtRQ?=
 =?us-ascii?Q?6SHERJgPrwFD+C3BS4XYGHY71kc2k0LO07vfbVKQjRYm/dR0z4y1uUewIocm?=
 =?us-ascii?Q?tQzhzzwG7E7uUAFf3poTF78VV3R27HmEsKmddrtBpKg7rNxccYDXqcPaBLYZ?=
 =?us-ascii?Q?VA6mCQ+Lj+jdee6QM9dspJAPlwrjMOuLfhsam3UM2MCWkle0LC1Y2z0Z8Yct?=
 =?us-ascii?Q?AEiPWEgtuWXyCaVJC7fhrQHFbNe/0WRelDNIqspX5ewd2r7UFgs6pIxrqOpN?=
 =?us-ascii?Q?P39TcMg2kHwqvpTn9dpJ+eyD2e4xmmakCRG0XvabmfxD18GFZ66qF2r7wcZi?=
 =?us-ascii?Q?H4SYDusTru+d//EGTPc67lWbz153FF5vIEFph1FW1GsSpRutJCKbvb7FaTDg?=
 =?us-ascii?Q?UkpBfdtBkXLvF1Zj33g43B5N69gf/KEgxiK78tom5ps0qYjI0i4g228rs9Pd?=
 =?us-ascii?Q?ddNYd4L6h7giMpKrUA/nIm63y3tMcR5VpdCG4TsD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc751785-0baf-488f-c9be-08dc8f2ac1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 00:08:18.0877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQduuQ+oS63m9VcKyc+4InAHQu2Cuvzrfg9nAWRIBBlpmfI++E0vhG6wMHZo/CBsHCIDvjbPrf99TX0AawjB4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
X-OriginatorOrg: intel.com

> $ size vmlinux.before vmlinux.after
> text		data		bss		dec		hex	filename
> 33128289        23039446        19767300        75935035        486ad3b v=
mlinux.before
> 33128289        23039446        19767300        75935035        486ad3b v=
mlinux.after

Same size !=3D same contents.

What if you:

$ cmp -l arch/x86/kernel/cpu/before-common.o arch/x86/kernel/cpu/after-comm=
on.o

Or

$ diff <(objdump -d arch/x86/kernel/cpu/before-common.o) <(objdump -d arch/=
x86/kernel/cpu/after-common.o)

-Tony

