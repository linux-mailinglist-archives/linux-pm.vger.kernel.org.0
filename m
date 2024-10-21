Return-Path: <linux-pm+bounces-16114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6319A70BF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C61B1F21308
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2231EB9EE;
	Mon, 21 Oct 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQzZmnz8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7B1C330C;
	Mon, 21 Oct 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530828; cv=fail; b=NmxhxkJRZ9mu/HnzzfxzoUAoYxigtpnP1h9FEgpWoSCUL3Msot4ea+WkwE3Mwex2woEpk/XW88VDuYkMDMivyxtAIkzJj5h6wA4zs4xz9ag0kT9xlpIvxR5eQkZa5HVG/A/KomMBJN3ozuW6E5bQ6XGnbJ/OCvtdyaFIN0iAsn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530828; c=relaxed/simple;
	bh=QoQkNtFfhlz+ZRbBYuLPPEF3CSDnu5VUjnNROWZBzAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I2uRilMAq/tB5kWYTsmY10ik7WEevJ/O7z0Yl36z2xPTDNoxkpwJODPb+wLuc6Mwv08KEyXp6h14XUHHIQ5EvPpI/jc6Fm+HO3JK0HPXQy7AyhUujNO/6uj2c3elH6f/uoZs3PRG/IruCNHt1HFTKsHbDrYuPg56f63myfQ5zJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQzZmnz8; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729530827; x=1761066827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QoQkNtFfhlz+ZRbBYuLPPEF3CSDnu5VUjnNROWZBzAs=;
  b=MQzZmnz8Hq5w10sZ5X3C2/UHaxhELQ69Zu1gASX1pd2u5Qii8x7e4L9q
   riBqlMnQireyxyATGXPpWkzAEPWLaBQW3VxL482xdiSLH2vbwe5XXX3sX
   kc+jCdVY6rsfvOTgkef16FufRz9FlIUmsWqUkJyVE2POLNH5KDkQyf4vJ
   GsMh/LOopR9JDPDXfM7o4jDq302hUsUUo5jNaHL/KiJrCIWX+NWmuXSMB
   tzl0tM1R9ApP3Af4gik1cTwaaKPDRiqlTExtMGWC6wTftPi6w7GLDHsTB
   ayNPBmWhrCYBc8kQVh5+HYh9g3mdlj/rcWvGkWLGc9alqTW+8diUffEhY
   g==;
X-CSE-ConnectionGUID: Y4/E76A/RwOd1U6bu6yAWw==
X-CSE-MsgGUID: 6cpOW3aiTqqVryLwTFpAKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29190618"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29190618"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:13:46 -0700
X-CSE-ConnectionGUID: SL8nBlgVRjexMOuvRuDgtw==
X-CSE-MsgGUID: 2GUktJaaSN6VNxP8dSBmXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84375375"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 10:13:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 10:13:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 10:13:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 10:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifASm7asuSNdfV6AOR+WPHtr65zFm9Ra3jJdWBd8Ttvm1NOtVKQS12sgz49TeowtVRoHYnzMbOuvhkvrexzROKM2pxv6mNnAM3D+lOny/JMDJ15tmlj/uHhKCfzh8L20nLpnrsm+x87EE+dWmgvzdTIUZc7SDDhcbZbvc5rG7Q2ScdJbx+Cy8QzW4RCuschf1HwMVQ0X6hhQkL2mU2aJ7jvqbyBgnWD1tpxru6L4ljIrErJClvuCkr24Mjp4H6T+1P1cDbbRXY9O3ISVBboG6e2ftvxlvpsxe7ziT+goNfvif2S4xZYDPuNA75eo9XAoMTLQtjkgr7Dir/xO61lkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6WfiKsYTf/vgDsVqfbJ0L5FVWEiGuXPWqZ7VDsJ5tk=;
 b=PC0JTtzW3ffbE+COUxaAzJ4fbhDTQvXxSflTTkr5cbbKg3+IpbBpn1qFb86y1KPWfnnyD3ExDF6teivP1UytKfRRqbmR/5gJDrMGFkOPdbSiq5X6VpXaYofz8rwb1PJ2dW1oNbRATDozRVgfTz9QFv2f0FVX4mHWYHltqrXddZmXs3fVK6n/xMrvIbUv3JhnWtEUqsteOAUG6zXhrEZ1JXDH2NyMMgQVYJtLsTe06NRX46pJq4Z0wujItRz4WLNVOE7RXxrsw3yR/OBmpmP6oUpQa78js8VTqQuI8gI0K3ehHDhW8RJULpM63ACdtVzHVoOevZPOebwtBXp+5MXzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:13:41 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:13:41 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Borislav Petkov
	<bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, Brice Goglin <brice.goglin@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: RE: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Thread-Topic: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Thread-Index: AQHbE0e4PEbT+P6DKUeyDzQ1CdSMMbKMzJQAgABGHYCABEOqAIAAMfcAgAAI47A=
Date: Mon, 21 Oct 2024 17:13:41 +0000
Message-ID: <SJ1PR11MB6083A4F82CCC844D4C8C7D6AFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
 <20241018161956.GCZxKKrLeTg0VTdfWA@fat_crate.local>
 <20241018203053.2x6oyws3dkxfw6rm@desk>
 <9534B53F-7B91-4525-97DC-889EC3836658@alien8.de>
 <20241021163656.zyyugk4vyqyhzh3i@desk>
In-Reply-To: <20241021163656.zyyugk4vyqyhzh3i@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5294:EE_
x-ms-office365-filtering-correlation-id: ec474330-f90b-4f31-0f59-08dcf1f3b5f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KDq0uQGGJMBapyGLpWOPYlZZReL7MeH7sdoz+DlbW7BiUVuLaY3NvwNPpFcj?=
 =?us-ascii?Q?zrdVUpJRsCLSZoiE+cuTSgx8d6mcMa82mP7gGKciS8+TAagOG/h1BgWqCgXu?=
 =?us-ascii?Q?FJSEufYQv5w/MMHWYuJE54Sewj2P5RFzzzmA0iaiput9lMsPhM1oFzcuweFX?=
 =?us-ascii?Q?i1svUz5sYYbYYMCNKdjssN6R12NCR+UDMAraP+mZiS2xodCT5DoioKCLGf2X?=
 =?us-ascii?Q?MoHnkX/NA52yoREAGcdTtTksvrAnNLSL9u4NScqX7vi2lySuXKD6VSkZZiJa?=
 =?us-ascii?Q?DoqnxL+AMjDHwEajs/fhv4HXPk6FEApXsXZc5ILuxBzUi1EP9rT9EpGWW/qR?=
 =?us-ascii?Q?yIvBp/N/8+1BbJebsjqCx6VgS6JshWLH9tqszDNAKdCtih2Ag4GD0/G30BPD?=
 =?us-ascii?Q?qwTHYmFyjulXJGa7OvC7cvabP7DWqqLWhj3MiSRQb0wdB3ee+2ZCGUxG8KVT?=
 =?us-ascii?Q?xQhWxwUwE8ERdfONDwgSHbwtyVG/vnpdB5PF6es9n+ecET5BpoTv5M37dmrQ?=
 =?us-ascii?Q?OVsX+JX4VQq7OGJ1/h5IUSRIxbBlAAKji/ANOxKFEQtRY2jXnHT9jAOHDjRR?=
 =?us-ascii?Q?REd7rYvXpwEpcUCnLnK6KUPJglZLkFiNvXXUktKus3jeqnAr6ZQz4sbtk4wB?=
 =?us-ascii?Q?Gy7Sa3FenavTPoeWJe3lkLMKVhTEhK+bS4FAEaXFMLwcbeG4AZQtj9YWAvkV?=
 =?us-ascii?Q?1IdTAoyHN3saQUtpzox3JlxCjudmRU0QZXlv18ohYFWj+7Bdkh/0cBi+ZcYg?=
 =?us-ascii?Q?uVAhkxR4dlRGcX4TNLgPnxURQ3Y3M2oO2LL8d5mo72roxiP//LEp+2Wt6drJ?=
 =?us-ascii?Q?bV1/IO+Szi5dPnRHnN9kqzb0t8chjY2RbNSuAuJwB4uY1d3aeE2+EQsgd2Rw?=
 =?us-ascii?Q?kM8o8vZfecdbRNfowWpYHu6M6+X+ISmwNocV5opQ+y0d8Xxqw3QI1uiTT4h8?=
 =?us-ascii?Q?glYwjSq9TscslOskCF09Vc4sN2VN4y+v3E2rbBZspdA5ahCzF8onDZuuFkyY?=
 =?us-ascii?Q?sJxyilG6MEH3WF7WbplpY6orC0qMFLkdC47Zazw/0S4r4OkntC5j1v9gha20?=
 =?us-ascii?Q?eByhpdcQh5cSLe39N4f+k9yq5DJLAKNtyGDbEo3wbIUhmm4IAU/JJvHgoH/q?=
 =?us-ascii?Q?Hs0dE6s0fW0DtHLbQbweyBZhwQ3VjTBBqGik6RFOOM4i1CB8yT1Ca0ZClSri?=
 =?us-ascii?Q?a1g6U6olvCvsmZdbedwn02U+mGJWG6OFNj1zG5fFBZhBHmDLTILKbB9t0Bgj?=
 =?us-ascii?Q?OC+Uq/B1a0T3U8bMLYhW1p3XQTicxugZBKCE+WF7IWk3vrBsMvHvuCyPBGCU?=
 =?us-ascii?Q?dui7AzXDHQgjxKDwviLEztFEsPgtti7VdcHWmkGDj/LVuuTtWC9UAIjXJkYn?=
 =?us-ascii?Q?EIjJnZA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSVK7xKgRf/EGggzOu4emWCcwsMiUUt4L1HNOa8Ox8oSN8tEbyFujB99MHld?=
 =?us-ascii?Q?QPnE26Owb9bmEfyK807uqWTiS+wQcghja0Yu4mtPP+jltAz7+z9edmH53J/M?=
 =?us-ascii?Q?FvpUL/Fdd9waqJmqp+EMsNz041kGt1agZqWdSUUXMNFMiyCwJTWM/g2fl5c+?=
 =?us-ascii?Q?0avvcCl0AH4h2OlV6Fc7wP8jbeBIC+ux2QTN5F13Z3FHkl/Pom9KWdnvUIOs?=
 =?us-ascii?Q?5LyoKmDm36Zq7GgpOdJdeXmgvC9fS7tidMYCdr+XwlT4YCRF+OCkr5M5NZQx?=
 =?us-ascii?Q?Z6dxedaBi1IuThrPR883hUkEpW/3hV4L0ZqQiyEZboJYT4HcBzrWovx/stIa?=
 =?us-ascii?Q?j8rCjrdciTULnbM8+tKgkZOd5IxMfpEzvx1NSOUWrmHXNxIfp5vJo1fAlNFR?=
 =?us-ascii?Q?IzQfEecMGi2yZJAbqNSMtHmxdtzT2ToLewFwu0RQ4LsS8NXKox2mYOnlriCt?=
 =?us-ascii?Q?hxi257w+RR7/76xAm5JWQTWLB95Y1eriUjOyTtcsdnRK956nrbkaHNOLfJJg?=
 =?us-ascii?Q?ncTY4Tej3KXf/+c47/93gjZjIqJPZAeg5sqwmkJyiypPARZ67798lRDSyBQp?=
 =?us-ascii?Q?lX2UZcbUBxuP8W6H1kbnwEVG6Rs9JxSVEzb08rbrfmt0j++2o6jDzlNuEgcJ?=
 =?us-ascii?Q?oRUSip4ZyMEkkyyJ5McEZH+EhIFiMKDeXSfJaKNvTUoH133/nqmUzO8yrvCR?=
 =?us-ascii?Q?srEXzLlwhc2ol6Y+zyL9o00mFr98EPT5AM9kBmdop1fIJJl+Uh/9zW7EcGH/?=
 =?us-ascii?Q?rpnBRsJJPglhzGBIo1kuLx4XUHedRTP2vZIT2HjKNWMCRgDm4JZxTptc4oA/?=
 =?us-ascii?Q?Qo2yL6T+Nu/EqRo3Q3HGVusHliDUvGNn2A1TS5hVtz6jfY7VURw1qeCT/cq2?=
 =?us-ascii?Q?WY63h+qZ/Qy/qaw3oNOE0eSuyCwX8bjq6YgnUp5G1EKDnR+TDrFvyLSyIDUm?=
 =?us-ascii?Q?6I+VhwrVFzIVno3ea/HkntOaB/x19EBttfrhzVkOrJbu2OCvgvXNyl7dNG12?=
 =?us-ascii?Q?sZnGv1wOLgYLLnmxuKR5bBjRknl373jgbJRbM6jA3HC+u2NtvhYv58bRXOVF?=
 =?us-ascii?Q?LYm/UOIpHoTUjch+YYAEYzAMzKWa6XLPShTYG35BCuw0zm+Eb92UayGvdhPf?=
 =?us-ascii?Q?VXg67SbF3r7LEGxj8W32BE9Vx6sGr08LJLYRddymmRseZs+fpa0IGt73u4vz?=
 =?us-ascii?Q?JtYKhQHA8ZqdEKhQDAsrWWjG5YiKxSDta8Sw9iGz89IDBlU18uJVwFhRVtMo?=
 =?us-ascii?Q?WcyDPpJYYAsd1NxKrN7Bgx3UVPNJsh5XpQtYTSFuUZQdS+QRSybNZb0YvD/4?=
 =?us-ascii?Q?egIrW7IyWUkbSyqHeVT6hyuR7YYBVXnRUzHhNxSZ930L6nB1f+EOspMcVewg?=
 =?us-ascii?Q?nay9ihy4B08pWoc+GGjESdqHCzTaXtaZ8GZvZmk5W+HWsFISzXGiw0zKrt/U?=
 =?us-ascii?Q?lMVsd6SlcWi9w5lxCzuShslRQ5jghlmoBts0oNxta6Xj++YaWt0yq8oIliNt?=
 =?us-ascii?Q?Z+x3bMvJHWOZM8A4/SEoht88wyHqJHW3GNvu5rSfQ+yDvUMesDNIDUx75puZ?=
 =?us-ascii?Q?VF09ny1xaR5P6B9coLYNxgcvihR0qYUCyU/OJs3Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec474330-f90b-4f31-0f59-08dcf1f3b5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 17:13:41.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ws83TcUL74E4ETcHLqhs2w+iXEzeqLtiNuXHKsZ3GqQ1fo7FGuihSeHOl1qMjl1+g8xONd4D46taU4QhnbdzgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294
X-OriginatorOrg: intel.com

>> The core is born this way and then it changes... so this is its native
>> model ID? Weird...
>
> In a hybrid system the model number reported by CPUID could represent
> multiple core-types. As model number is same for all cores, it is
> insufficient to uniquely identify the microarchitecture of a core. I
> believe "native model ID" bridges that gap as it is specific to a core.

Example from <asm/intel-family.h>

#define INTEL_ALDERLAKE_L               IFM(6, 0x9A) /* Golden Cove / Grace=
mont */

#define INTEL_RAPTORLAKE                IFM(6, 0xB7) /* Raptor Cove / Enhan=
ced Gracemont */

The native model number could be helpful to tell what each of your P-cores =
and E-cores
are based on. Could be useful when the same base core is used in more than =
one SoC
generation.

-Tony

