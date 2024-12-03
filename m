Return-Path: <linux-pm+bounces-18400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF49E12B7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 06:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F77F164DE8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 05:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7E51BBBDC;
	Tue,  3 Dec 2024 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMKNru5e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941051B5336
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202472; cv=fail; b=DX5MFcvSg5aiCaNNwJ0GDJsLVoFI2QN6thBt8by6JqirzEo7jLDIEDLFCzirD9EB8rACPEHj5wraWyWkMn2LOCyX9xw4DVxls/gmQ1a9hdZqbknuGwieC44npdHjoDWptXXdKZk+fIy8Q8Y6y1fwOdSRqmy8AdZ+VjFTM75mVgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202472; c=relaxed/simple;
	bh=yUVR815D+eBQqDUgBePQzE2zCmD1Q4QDe0TZOpm9WWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BrKSEgcWa2EJ/TY0wLD/SrGW4BsZ6ZCp8RkwBqb/VAzW3uQnN0oCmW4oKqd2DYmR+i7kWslOUp11t1OqayFUtE1lRlqHy8IcpCSoEosCBlbWqnCfYQHtdgYeJBm9TkCwRdTY19ihgguN4Lfjoa7qUvnzmod4tC6nZDjZR78WIpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMKNru5e; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733202471; x=1764738471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yUVR815D+eBQqDUgBePQzE2zCmD1Q4QDe0TZOpm9WWA=;
  b=OMKNru5e7ujwNZ83cHHgPGnF2RZTNFgjQbj9bCEhmfXL6EDo0EmqR/hN
   BxNvXekVD6tG0O3L96q3RvBNJxFqGsus1G3P7A5++gLySjb/+tba05xKx
   sCMHhzW/fO6wGfgIi+ej6Un//vYUuoW2DUr3kxXlcvZ/QqI5iY2DN0ary
   dXc0aTim4nrWfVykpMP4GCbxRzFUqArxhOz8WppPXVZb8oPHG+XBydzID
   W9Ev14VV2By3L0UC/iF5zm1STQ9W7qElbXD892wOCoErXy2TZBjQWTQs6
   H532Pv6N4tXng5vSogqCW+QM7HNyyLtSMV8ad+F7hKnEl8uJ3ty6KHh9H
   w==;
X-CSE-ConnectionGUID: DGaho+s4TI+I6lks8VEFAw==
X-CSE-MsgGUID: c5QU7XR4Qjqp2p8Zea9yHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="36252880"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="36252880"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 21:07:50 -0800
X-CSE-ConnectionGUID: e7G4AhxGS0KEKU+itdSgZA==
X-CSE-MsgGUID: iBb/bthgTdO8W3mvQe/TZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97752052"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 21:07:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 21:07:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 21:07:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 21:07:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pef3fYsvc8zvbm6ZSRzfLkLAZwAmnEoUSZ08P9bhU53xXnNQWMm4U6iudn5mbD9BvTv7QmshWrDXTJ4SiasS+Aj9/Lunt3TIhjiMPxqoRZ92ZVtUQITuETwOECeE8jDTrsFZbzxmpkMeXffht2AoGfUFYkgWuC5/KTkhLJQ1BF7V+fHJC5tzvom8BG7CSnbeipv6OUCkcHGaivGz+xhmlyc+K2loHh9h/WnZiZAnLSsTcFgOiYfAOD5rc/4wNF52udApA//C07RoionRpV+6q9z2zizjPW5pepGz0GU63i+/RwUy5JiwT/1ERmiCbJ7bWENEnv93JPXv04zwHYeIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUVR815D+eBQqDUgBePQzE2zCmD1Q4QDe0TZOpm9WWA=;
 b=X3kDFEW+gJBKFyoB/c8HNJfWtUZtqsCocU/InXEoYsjaDNGhUoRiBWoXJXe4zfP9G2s02k8MDnqZIWCNfCSUXcM8OCTIZKOJrk25yu6wekpO0BwzVzYb9yepTIbbBSnq2219aS+LShlhWoK1QoGFis0bDNhL9iNbHfllWyHF3XIecIE+PHh0nuYdCbX9cv6lYAc75UTe4bRN02J4xk1yWJTf5xkFpHslCLPt8lHVOjRNE9dKEcK5vixnRPAuzmQ7e1efVtx0+XC4dZpeh9b6LBaGA9M4ojeVbpwB64xrrGm3oDYohLDz8Em7YqxHjmgQKa7oHS7Tt8EzuQB3I2DtOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 05:07:47 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 05:07:47 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
CC: "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano"
	<luciano.coelho@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>,
	"Nikula, Jani" <jani.nikula@intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Regression on linux-next (next-20241120) and drm-tip
Thread-Topic: Regression on linux-next (next-20241120) and drm-tip
Thread-Index: AdtFPvBukA2w7biuRBKjE+4t+kPk7gAAkQcQ
Date: Tue, 3 Dec 2024 05:07:47 +0000
Message-ID: <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|SA1PR11MB8328:EE_
x-ms-office365-filtering-correlation-id: 043f610e-7aed-4277-31b7-08dd13586d75
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WTkYbcuKcussvW33v7osgZhRDdF/VfM7D82ItSjY7DhhwrdC4TEvBtiMcj?=
 =?iso-8859-1?Q?UDp1T++zmX9QnTO2hfxun9zo6TpD+3TOzpVFdpBmXWjOEbsO8AnWbNNj8k?=
 =?iso-8859-1?Q?iJVD4Hk3p8IiE95cXv77jd+t5Sw7ZrXqp5mp2jTY15yRXjF75D35L/anm1?=
 =?iso-8859-1?Q?kt5SenaeIR7KcSAAMO5Oku38lvtiZRPGLshFPOx69F2OtzFqWWqGTBiMpn?=
 =?iso-8859-1?Q?lCD8+7ROUeAONXogwCamGCpf/KUIFJ1mp+54Bvi5h20c5Bxya0beO7UZR2?=
 =?iso-8859-1?Q?XOOHMPo7tJo49k7/zFcvE4I3htlPJsqCye5Yhnj+nQ1HtBzYwqv5DTAd0F?=
 =?iso-8859-1?Q?TftAyDBNZcSBx51MFvDwWSHtSLWk3ABaY7r4TM2yCcBxeSBi5LN8T2aazz?=
 =?iso-8859-1?Q?rTvpG/t8S7p24Cnna0z76OvWER2rIIEZA+d7nsb5cEEO1C8HQ1JUmC7u/c?=
 =?iso-8859-1?Q?fDI3x7A9K5H1U/NeiStFNlF+KgIYvTPPJ2TS129f2CGrZujsIqpTBp+ycI?=
 =?iso-8859-1?Q?KKWFYSAjkpv1pbIsnxVtd28LdwTD20XQ/JctZuKOzh8y2/Dp0+c9YpktVV?=
 =?iso-8859-1?Q?GCph/XKwEl5MCRXe8h0Xqxy7Rmpb2rJMjzRwZ+Dog2RpH/7zBsYd6mDsUt?=
 =?iso-8859-1?Q?aadqlkDHvzeQKy6P+InYkuGWY2whi8Swdjpg0IezYalDv7xHm+3xrCP+EM?=
 =?iso-8859-1?Q?H7652KjOnq88DrpmXZEjaSMAZ6vF8hoWVBI87mQW3r8uj6UOMNsEkpzeph?=
 =?iso-8859-1?Q?lsXjYVxSNYAHsOeJE9q5oX1DTdprrEZA22Cl6K1ckYgyBMyeL2yGg+JP+q?=
 =?iso-8859-1?Q?Nb84gZc0U4CwMGT5YVX1vFQnRhQ9Pku+wOlVaj4s8ONdkyNc7jBfWrc+N+?=
 =?iso-8859-1?Q?R02eqeBVmV6STr7rX8TKia2EbdUeJ+zVuZYNVrpwYbYgHLT+o37WJE+Csw?=
 =?iso-8859-1?Q?O4QD/ZVz5j/4+jn6SVmaDH+V0S1btgDItNbnX8Nrs4IjBh5/+7jWWeFPXk?=
 =?iso-8859-1?Q?s9r/X6amKY6fFNN55hPA7t00A58h+l9Yd9jWR3Dw0dOi8Anz//lVeZvCzI?=
 =?iso-8859-1?Q?cW8Hmug+dfd91MPxKvUdFgf9MrY3ilJ1G7I3+4Vnt1AOjEcjl/QiHOQjFm?=
 =?iso-8859-1?Q?5UA4L0eVS3U5gaNOozUExlelHcJ0d6HSyYQ5LL3JkXvRJ/IZ2YTYzPW1Nz?=
 =?iso-8859-1?Q?Az5XKQy7GoSVjfW9p3kYD5ic5PNdZPA6ott0IZwbwJRJFWVb3W9oE4Qz05?=
 =?iso-8859-1?Q?AF+qgNI3rp4SMxnxZUohfWXTxMikgHjnOCcUwXujkttDEO3L1S1tS8xTZu?=
 =?iso-8859-1?Q?LD0bNkSlo7iPH40b7Mf6Cv+6InJLGF4etos8d3O682stJdgQtd4vhp8nwP?=
 =?iso-8859-1?Q?7yxSaW/2ZuWCIM6u2/8Yqna2JpMNyg/fY9/ktSGpy5VHVQlaQD4JQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c47zag522SLjlcE/MaRK4PWkfIsFkMuEb6LX3P1x1GSj0lRHmrYaszoEd+?=
 =?iso-8859-1?Q?mhuWcXQUS+erPe75ufqS1i2XM+rYxKpN5cfn+V3eC+pFIp4b74dNAHalpc?=
 =?iso-8859-1?Q?YxnTJ2qztC0MhgjcTlxtigD+ga4JeBPTG/a+LVo6qa0sybWxiXWspxKLPO?=
 =?iso-8859-1?Q?VWjjNMNdr2Ern8ZSbQ6LCmsffkGdjyUSmzuRqAdFDRLTgv+Evdc2kGpOmK?=
 =?iso-8859-1?Q?WUbeH3jxz3AX8EQyOM/rI+OZ9QrwQaQHZqUyrwF0njgvrusKzgXdueSKEd?=
 =?iso-8859-1?Q?GXOrGmW8zDqKHNSSYlT9wyZUTKusLxR+kjtt+ZkXIBqqS36mSLJAWzTE9P?=
 =?iso-8859-1?Q?WBE/bRKm1pizIOIRMkMesYVA73vw6NAvqaHRLA19t9VZTy4TlC9Iep4iZp?=
 =?iso-8859-1?Q?K2rzxrflA7RUXrfXwq1i7HWLF39z1AyBYNP+R33CWQKaeXn8RWhnhjIU++?=
 =?iso-8859-1?Q?WkiZJQ1H1ol58LzY8l28ndt6ro/0GguxxvQZlOQdP53+dzQmymUbYezsIq?=
 =?iso-8859-1?Q?hggeKV4zhLPO8rG4I7sHGz8Abqa7x9dct3Ct6o/GP4yMvUjI3Hu/c6wjtA?=
 =?iso-8859-1?Q?8vqP5977UuxDQ9U6+MZhU3Bmw30Gh6BHdTOhkqe7jMDksWRI4guNDtrv0S?=
 =?iso-8859-1?Q?JK1U2R0f/bavO2AtRHZtSrdi2shnQf1vq+iJQGdUyRuKuWEewfMeAgf5v9?=
 =?iso-8859-1?Q?LQVPCvFzDQwbh5KXLfO//WNbbUCJQcnpq8J5NIVXzxFUlFNCyp9Mt6juvs?=
 =?iso-8859-1?Q?ajq/6a57DnXaAdbl1dKxHbJdBy7otbGj4MxU1t2c/fe6vzC3EaJgMS902q?=
 =?iso-8859-1?Q?Eq3XddVgAYaBaXOhXb/tmRn7sEUC0AYJ+5a4J4iVcDpZ8BZgRZEhWdRNsw?=
 =?iso-8859-1?Q?Ll7uNweTqYLtEwv9i4JnQ/WUQGupa34ZOzzDS49IBYcS9NNBwn8ffpfIz3?=
 =?iso-8859-1?Q?Y67nHfiXAE0/MLyh2Gc0excdHI8OBsVZ1R60VSLZ5/OGMzn7oC4M1ylK5C?=
 =?iso-8859-1?Q?cqZ1vZCPOjgI7TXzk5HSDQcrcce6OeS1vLiZKd06FOARFVdq3rlpCefbqy?=
 =?iso-8859-1?Q?8buz8n8iIicYuvSzaCnGsBWvPxSVmw4tbpTMMKqkG/DffTlUmYi3PKIKcS?=
 =?iso-8859-1?Q?RIADFOzZz8xd3kMm3Nn/R4I0o9HQJ6XZGNMcQVnJv8Fd4jDd6hiFDkd9cS?=
 =?iso-8859-1?Q?/vV+a7MI4VGlp58DlzxcAjfYKPmSnF72Dp2nxGIRFYOxWTEpYAa/x1sYk6?=
 =?iso-8859-1?Q?q3OFs9OFGrycikTDRvlrmWjSCIm9q7WLSWXVV6EeilIlEbKVLbQPgT1l7v?=
 =?iso-8859-1?Q?RLAv2ZISYd/KK0edTlmPZXr8bzcHNxa+CPo0REl0aytdKzqexanmrR9FvZ?=
 =?iso-8859-1?Q?5IbRD9JydfH+inXDjLIwgRjba2Wlj3ghYNvu8YH6h43fIpUEDOVotXIneR?=
 =?iso-8859-1?Q?0vQ0uTXFVVbIQjPTP0mZFh1XYsViRxvS+7PUINl3mofvncMqGeCAVJRZU2?=
 =?iso-8859-1?Q?53kQWfMYYj8k8r0o39Tj5vwtMbwBKq6ivgW9X4+8IPdBtbT153OMxz03wM?=
 =?iso-8859-1?Q?x8eKJLuVWwITlXKRiUUS71p/lgTtjUeIVAXbl3MD5aheB86wEl/cSKdcGR?=
 =?iso-8859-1?Q?nw6nyFDRmrQbRtk6VGqMF9Soh5VCJaY8IT+G1iedafN7n7tCKCBuQpkg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043f610e-7aed-4277-31b7-08dd13586d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 05:07:47.0770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Roy7XiF/DiYK8PbnBMCPGv7ZpemK7zvQ6Ouz+qz6IWt4vSRAwFjv/7F5ImpCn59fOdNfSeDnD5Rs3Hr9L+IvUpvj31k1jTYIMGRVpcFwTkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

[Resend in Plain Text]

Hello Thomas,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.

This mail is regarding a regression we are seeing in our CI runs[1] on linu=
x-next repository.

Since the version next-20241120 [2], we are seeing the following regression

```````````````````````````````````````````````````````````````````````````=
``````
<4>[=A0=A0 19.990743] Oops: general protection fault, probably for non-cano=
nical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
<4>[=A0=A0 19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-node Not t=
ainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
<4>[=A0=A0 19.990771] Hardware name: Intel Corporation Arrow Lake Client Pl=
atform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/=
2024
<4>[=A0=A0 19.990782] RIP: 0010:power_supply_get_property+0x3e/0xe0
```````````````````````````````````````````````````````````````````````````=
``````
Details log can be found in [3].=20

After bisecting the tree, the following patch [4] seems to be the first "ba=
d"
commit

```````````````````````````````````````````````````````````````````````````=
``````````````````````````````
Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
Author: =A0 =A0 Thomas Wei=DFschuh <mailto:linux@weissschuh.net>
AuthorDate: Sat Oct 5 12:05:03 2024 +0200
Commit: =A0 =A0 Sebastian Reichel <mailto:sebastian.reichel@collabora.com>
CommitDate: Tue Oct 15 22:22:20 2024 +0200
=A0 =A0 power: supply: core: add wakeup source inhibit by power_supply_conf=
ig=A0 =A0=A0
```````````````````````````````````````````````````````````````````````````=
``````````````````````````````

This is now seen in our drm-tip runs as well. [5]

Could you please check why the patch causes this regression and provide a f=
ix if necessary?

Thank you.

Regards

Chaitanya


P.S. We could not revert the patch cleanly and therefore we are yet to veri=
fy the bisect but we are currently working on it.


[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/comm=
it/?h=3Dnext-20241120
[3] https://intel-gfx-ci.01.org/tree/linux-next/next-20241120/bat-arls-6/bo=
ot0.txt=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
[4] https://cgit.freedesktop.org/drm-tip/commit/?id=3D49000fee9e639f62ba1f9=
65ed2ae4c5ad18d19e2
[5] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?

