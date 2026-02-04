Return-Path: <linux-pm+bounces-42038-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPdlEHfagmnkcwMAu9opvQ
	(envelope-from <linux-pm+bounces-42038-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:34:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF445E200D
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E0030BD786
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 05:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEA4330B29;
	Wed,  4 Feb 2026 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glm8RXNj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC233066E
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182950; cv=fail; b=dGNwyDUHHhV80uClTFpRIktvSI9Byym2OAXk6AeB63+dMW1pbGAtw6uB6QLqzDNnbmIGhPWvSi34D8XsbHzzzQildS8QVkDsXELgoEUKIgri0e50kyOqTTWSeqa9b9K8I53X35aqYmYnPAn+oFrcLN43x04JxXDQ1rB26NGqI7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182950; c=relaxed/simple;
	bh=u4mNLXILOX1qb0wfYeC1LbthcMtoc+X49ee4WhBl5Jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nFA/nNIt+V9ePq6pygersJmKkA0WWLz4eWUniqtepztuK1U2hF3OhS3tS/gW2mmYLgwQlJUK/8++M3rDRy9eC0mbwIQ+ls0rFqfec6JZQ6dCdMq+3kl5zIDlnnPunNYOztwcgJwI13YyKI5NfEK+H6c2bxadbWnm0Bq5XjLrnjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glm8RXNj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770182950; x=1801718950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u4mNLXILOX1qb0wfYeC1LbthcMtoc+X49ee4WhBl5Jo=;
  b=glm8RXNjUA80cokcQnJ2ASvO8ZhbhWIqoafnlnZfADhVSHQ70UcQnast
   HW4Vjnn9UgYHWGJ+iTTAB9MfJYyjDgEcMXvXtAmoVHY4r8Try5EzZlHnt
   FfJPTVOuuTNZ1A5ApjrNREygitP4qhoQnQtV1q9D2XXeIK3YBw3pOIWtg
   pEPQNkLXqVIvN+SrZcc2YKFdZo2/vFrGNcGUMsRGKOdNqwmh/OMqUjxeo
   shGp4Uu010W/Z/JZ4sbHficrIwcmiZnNNVvkkyZWvDVI0zXzHb3qUTz0z
   juZ56S0xNguIy9+EXQEkaxWdTQTh/AFduEheL9G7fDYw7NOXpT4oGpuvd
   A==;
X-CSE-ConnectionGUID: NaqrQ53QTgGq5ajJGO+RLg==
X-CSE-MsgGUID: D0jQh3xQS+uRX8bsVgR+tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96818765"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="96818765"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:29:09 -0800
X-CSE-ConnectionGUID: AmWwnXSdQMK6xqj3OdEK6A==
X-CSE-MsgGUID: pLstd1otTIOPlQwc4edTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214605762"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:29:08 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:29:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 21:29:07 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:29:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgIen+IXxfLBF8vlBgiTCSdAMw1CyTUNXowolxLuoUa6TdTnhxn96nHH81eZU6py5IaAdfWvqcZmVrA5X3l1YpNOrw8KeZQT/Jg4F/jTpEcPMexk7S01x6mineRMyKqTqlefdw+2TgY+l23gfLbba+A5DQqeJYl8EP8Jybkzcjfw8V/iCQxm4uas4OTQACFEzKzkYWfKECMDa5+57jxkph8xU6wju2XfzTTNReqLKbDD/9EDsK30FPLasL1oL1C8G+8mQoORH1o4JEOk902oJ9IoiPiKmOOV1ljzTiVFxaqJmR3uEJnXNL71A92+nMcaCKkxyR9odjyUP/Kk/X1kuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrYOqpXinQPgyISIAHU+ho1wGYtiS5I5Ow+wDJhY0tE=;
 b=IUnGdoD4GNnSS/Vw4SRJRnJwx9LV5tqApuw7XPoZHhFC2reQtWIdohh/1j5joshSar/z1uVFYc/SC03TcWFk/D7l8NXk9jve0CfVp1CQBjBl0mFHf5J/v+/C0TekLCJjCS93KgvCOK+RkYo03TIMg29hw/NKIMmleIZIsOzJcYSGIgouJpmxovNiC9Czk1Lc66tfEEn/3xVCRK1A4+6jRafeXIk4LTaMDCRXQg5dBmqPiaTg6DXGeLDFAHIbcz4haQ7OnE1lnr/r09l4asesxTDeuMJi7eEnIjp92fPK12qnX6db0BoDjtnV2XdYct+T1fqMn3jeUKNQfWyDb6Wxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 05:29:05 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%7]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 05:29:05 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "shuah@kernel.org" <shuah@kernel.org>, "trenn@suse.com" <trenn@suse.com>,
	"jwyatt@redhat.com" <jwyatt@redhat.com>, "jkacur@redhat.com"
	<jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] tools/cpupower: Avoid out-of-bounds access on empty
 strings
Thread-Topic: [PATCH] tools/cpupower: Avoid out-of-bounds access on empty
 strings
Thread-Index: AQHclZakPaQQr/1Tjk+Y0yYoH2v0I7VyAu1w
Date: Wed, 4 Feb 2026 05:29:05 +0000
Message-ID: <LV3PR11MB8768F0EDF07C90E9198F0C65F598A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
 <20260204052143.3281063-5-kaushlendra.kumar@intel.com>
In-Reply-To: <20260204052143.3281063-5-kaushlendra.kumar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA0PR11MB7742:EE_
x-ms-office365-filtering-correlation-id: fa5b38ae-8942-4e01-2ab6-08de63ae503e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?NIzWRaFWfoqVIt3CYhhaxc7IbRnqTbXx5zUxnjFfrekOcUwkn/8IWYopWX9e?=
 =?us-ascii?Q?PETDrMz4PgpxZjdVXFT7y36Apcj/QHSJ0/UXHGHLbNokTgPRz/PXxDtwnmkM?=
 =?us-ascii?Q?/IU2uweUQBAaK1m+UWa6INyvZDdC3U+XkQLJxxapWacON7V85a3TkUB07GR3?=
 =?us-ascii?Q?u64g0aQoy9ueYARW4Wlxj9o0mcrqjleSKmNE+RH9XlV786RoAuSKcOmNDOR4?=
 =?us-ascii?Q?fWz6Ncx1tv06KNzSC+W+/BDDBiUTf7mHNCPIev6Qll1rBVhx1sZW+FQQ3/4e?=
 =?us-ascii?Q?EWnmFj4dDHNltbx8I8S28/iPpS7it/zJNa+SOdfJWUj6+e+kYl8mtbfQwkSI?=
 =?us-ascii?Q?tdKwwlrRCvUWsNZHJUxsMtLjsUl9ILJcYbo4JOyakU5d4L9vGdq1UhaO/169?=
 =?us-ascii?Q?VDJkZjm7efSek1LQVua6gordWwlFN7Qir+rO5FhuzgPrFOJrfe5EuugkglPk?=
 =?us-ascii?Q?Ay1wYVaXtHz5F+npju/7tSb1WlH68DJ6uyx28Rt5mORw7nN7mLJC3zX1PISQ?=
 =?us-ascii?Q?w6wiYP03jifX9ymuofJVyV18Z1UBRMYAydQDIFPxw7k4i0/LbFIMTlr4kM7B?=
 =?us-ascii?Q?h6PgXtzmsvfvuQ3S3Rfd2U7DXcthwBJFsCRTDP4/2DwxexTKusgXRL9n+8fR?=
 =?us-ascii?Q?c2fzzvzSfwvZwOazLyF/ak0D8Zxr/5rSQLH2OUPKbSd6ZGxXQZOSEEsSYpr2?=
 =?us-ascii?Q?Digv95qhKQgsn5eavO4/R6iA/uMpXt3CcyXKaxqafrFqloLhq88iGxIU8Hq4?=
 =?us-ascii?Q?hb+FUTwCO9xJTPXq6iXhpuuw95fmEtWpYOkfggtA3EJK1i8E+iOsdx7Ml5oY?=
 =?us-ascii?Q?fo4JbpzxjFIyxhWR/Fk2c5O1MukLZoKBh1toqUTO04TLr8uvAN3nWyXEee4w?=
 =?us-ascii?Q?TkdxphkjJvNNN3lxXJKrlSNM5qZobFisk58qO7vwq8JMn+9D9uBS1TuBTsPc?=
 =?us-ascii?Q?aCycYoZFW2zvjGr9Bys415yi6o/a+ZQ8nfpS3qQIOQDVqcm7vkN1NsWI/k8P?=
 =?us-ascii?Q?oJnbe+SzdhVTLpI9RCyZlsQ4d+XhMObOzShn8Zjq+8jMsQjAnjfUpOBJr8vp?=
 =?us-ascii?Q?a9PonZE4Jne54Ecae7JKhc0n8qwq7qjbFxAkDxX94/AIWCMTn1KREpW9YXEd?=
 =?us-ascii?Q?j1FIvd5k4Yl5Ct80K/vUKjhhMGfvXVJpECDuJLaU0ULcBboMl/9wMJqKnJPa?=
 =?us-ascii?Q?P1yMPoSRGNBOWrMLYIJPreDZ8w50RjXgmFzWveSkdy3tPX5VeQu59VjI6eeZ?=
 =?us-ascii?Q?EOhTEexRhPCFmGwPNlGne3qv707kn7XGL6ULKORwZ7V37Kl7p19k8A4Gmjos?=
 =?us-ascii?Q?hp7UTixxyEHCCe6Xbc4ho0/Iy83iMGo5dVlIr39s2Vz0KsSN1/PyjAW90nyx?=
 =?us-ascii?Q?TycUQ5HpCjCd9tZUd7zNBv1wHeg70VCKZ8lD+KEeRJ3WghbNeTOB0jCBalXc?=
 =?us-ascii?Q?QMxicpFPdASGkv3MWSMOo7iXPqxPZleRs+k4Jqif2UeG+HamHgxSy5yHN1WG?=
 =?us-ascii?Q?Fd2hon7vW2sXrHt6xnVQhcz3lfM2fF4P/SHk/TPnOHhZJ0QZ6oIB0sctyHvj?=
 =?us-ascii?Q?PxhQEz7Y6rtPzZ3dG2oyMiy7YTLYgFme5OseDp3k8EguPEuU9vpTMlTDth/S?=
 =?us-ascii?Q?D059irUkJTo9Rd+PojRdj9c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7iiR3EOl3VA2aCUtGW6Zxa8w4O9w1g4y6QS67gBGCBdKjCEACFsaMYylJFuG?=
 =?us-ascii?Q?En18SH4rxVo+jbJ0GesqXipnRkjIXP0y5Pikv5dInt/kHxny6E8nT8bfRWmc?=
 =?us-ascii?Q?IO8iJFAWFQuNnA5YexWnGzl3qTLb8W5RZnLfoMp/C8diRv/pK0quWg1wgIwx?=
 =?us-ascii?Q?dXvgwqa0+vvpyGZn1xuw21Fb1JjOLBCJiXHttOJuYcg/xZa9BDFzY8NR9BnQ?=
 =?us-ascii?Q?q3SK3ez3YinkYTvMPfvM5OjNkpp0HmXSQg9NA+AjCzAd6LRVv3mimnzOWmg6?=
 =?us-ascii?Q?Rs6jAdDNnkkMXmrrfWnou+QCjuuyJoIxBcXNC0T2IGeIUvAbBBp6UH4r/2wn?=
 =?us-ascii?Q?AZOTslbzipMMVl8+aYueh24CBzFrt2KFD9sSs82LjKs/8wtd1ZZFKg4o6EFu?=
 =?us-ascii?Q?N29dR7gJwJYzSBb8PwSQM6RvacdqVlu7lJDN7bkZcTUzZ0z1C5oe+EPuqQjG?=
 =?us-ascii?Q?uGOlQugId0u+FyGcAgCcWOYTbmUK0WkvaQ9CtkUfHS3e+JSntmntPQz8Mnht?=
 =?us-ascii?Q?+CgYDc5CHWA/fUs0jQwZNOIrKXH7IbxeZIjp8JVE8vFuNd+zZ27ej8kLMJSF?=
 =?us-ascii?Q?LPHYUVjJuBwPRsLvsM4DfDFuQds6NSwiNkGhwIoUU9Mu/rA17LC9u+oGEqsp?=
 =?us-ascii?Q?QeZry15B4YbAz7r5bQ8KUECoX5axDi/arh1T3JyxU9crRXnR/rsCNK+wjSJr?=
 =?us-ascii?Q?5YDE1nDDhZvTTGIFwXntBO8PXR/m0CT8hUWE/JWmFp5PbyY1skh07O5rc3kD?=
 =?us-ascii?Q?W6K/IWm4AjNiUXGRA2njtQD9IRknb0WDXuHscvOHqb/E6HMopdrXO2dZGSVM?=
 =?us-ascii?Q?CDj8Ik0i49XZ9n0KvDch4AvrXUjIDCWzMhncOM9KUq0ZYJ7aMzJH/ERMKpf0?=
 =?us-ascii?Q?ZB2iVNHwRcO3JdZY3FrvFzrWyBWqzkVnLcudcCq4TcXpA4Osy4ocVZi9GYx6?=
 =?us-ascii?Q?mSyhaWAcAO7kMD7j7uanxj6E8Is9Jk+7G/rDMG9w/VhQRLLQqADOra5HyH1z?=
 =?us-ascii?Q?IURkPRqoM3kDKUiVTdWfcUUEPjKy34g5aD8Jkqfsl1hWXzvzbwxHUJBm3WzY?=
 =?us-ascii?Q?c8gkS+K76FTKDGsuKcyBWI4nK5AgDX0EoqVBUyui3AjM6faWrj44FXEYxJDO?=
 =?us-ascii?Q?/0Ut9gEMmkiPUdtI7diZQ2YWzl6/aLwL4wOvYIxTDBkkd/F4FUSrVdy3ng1Z?=
 =?us-ascii?Q?eY3tPv5MGwcdF0VpVpgQL14tH9w9eXyNOgd69utrxxhe5pGevEICZM42mHYC?=
 =?us-ascii?Q?yy19v5V+l9RDaZkMmnuIhpRW9TIQy7VmVwaK8KuTCv93BbZe+rxAGNoCgI+Y?=
 =?us-ascii?Q?0N1z9pP9n8RBfA/Ge8Ibc2uhVhOvj3aQKaFxiJvnO+bJqT4/6yOrzgndpM7L?=
 =?us-ascii?Q?3U+ntKZXGbgQsCMvQEXSta0tt7DaUmIueffL578/p9SKqHqoeQ5H/2YmYUEY?=
 =?us-ascii?Q?wx2LxAjpNA6IxYf9yXrI+7lTc9hc2Y+eBMRD50JDRXMSBACPo9b0aIRUV0kU?=
 =?us-ascii?Q?OBke2xC/e3O4xfb7xW29lzsU19ZeG2UTRQ9HBJMJ4Y2cJWYvT7f2FP028gIp?=
 =?us-ascii?Q?qYgZ32SP11G8D7QYQTONeSrHltVkT0kNysMa6uoozkb1W61T3yEwqhg3TKid?=
 =?us-ascii?Q?vLi9vltlCXO2Gy3XBiFCi8/fSSlTO1mdFLzfIghwKiOM1bjHRwgbz54wgxLp?=
 =?us-ascii?Q?qvRv4vrGIR/DBn/CN/NCflqLfUTY8X9g3onA7i+Y7QRBCmWmsno9jD0QoeQZ?=
 =?us-ascii?Q?qRhmqKQqZA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5b38ae-8942-4e01-2ab6-08de63ae503e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 05:29:05.4555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0SScFN3QuDyuBRMMvBax66hFIE798d1xW7Fsi6GwMDetV13ovsci2/z9iJw1YO7pcw5UgqSevcMq+DYuOm7hh0JlMoumOJ/ZDLEY6vMXIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-42038-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AF445E200D
X-Rspamd-Action: no action

Please ignore this patch. It was sent by mistake.

Sorry for the noise.

BR,
Kaushlendra

-----Original Message-----
From: Kumar, Kaushlendra <kaushlendra.kumar@intel.com>=20
Sent: Wednesday, February 4, 2026 10:52 AM
To: shuah@kernel.org; trenn@suse.com; jwyatt@redhat.com; jkacur@redhat.com
Cc: linux-pm@vger.kernel.org; Kumar, Kaushlendra <kaushlendra.kumar@intel.c=
om>
Subject: [PATCH] tools/cpupower: Avoid out-of-bounds access on empty string=
s

If sysfs_get_idlestate_string() or sysfs_get_cpuidle_driver() returns an em=
pty string, accessing result[strlen(result) - 1] causes an out-of-bounds ac=
cess at result[-1].

Add length check before removing the trailing newline to prevent this.
Also avoid redundant strlen() calls by caching the length.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/lib/cpuidle.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/=
cpuidle.c
index f2c1139adf71..9b7a420a489c 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -193,8 +193,9 @@ static char *cpuidle_state_get_one_string(unsigned int =
cpu,
 	if (result =3D=3D NULL)
 		return NULL;
=20
-	if (result[strlen(result) - 1] =3D=3D '\n')
-		result[strlen(result) - 1] =3D '\0';
+	len =3D strlen(result);
+	if (len > 0 && result[len - 1] =3D=3D '\n')
+		result[len - 1] =3D '\0';
=20
 	return result;
 }
@@ -366,8 +367,9 @@ static char *sysfs_cpuidle_get_one_string(enum cpuidle_=
string which)
 	if (result =3D=3D NULL)
 		return NULL;
=20
-	if (result[strlen(result) - 1] =3D=3D '\n')
-		result[strlen(result) - 1] =3D '\0';
+	len =3D strlen(result);
+	if (len > 0 && result[len - 1] =3D=3D '\n')
+		result[len - 1] =3D '\0';
=20
 	return result;
 }
--
2.34.1


