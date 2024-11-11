Return-Path: <linux-pm+bounces-17300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB629C37E1
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 06:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C901281116
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 05:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B7145B2E;
	Mon, 11 Nov 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NueZR9yb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA454738
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731303684; cv=fail; b=uGfeZV/DE7CWkrfsA8ski25Bte3LtazfjKsN/9CI1ZmqzjGV3IwPKaMmgPK11MHMAewh9S9v0wR1UcjPb9Hrhk85oBoFVbBWKrbpgxp1Bh7Yk4rmcAu2Rd1VAoz1+DSVGIGsR6Yi1Cnu0DLvPYzcYq5XLvIcAXyzVK58beCzusc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731303684; c=relaxed/simple;
	bh=QdL5o8JnimmZqG0XB2SCVlz2igmAdPf2ApClpSOxO5Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V0yqeBjibzB/xC2brfn928VFo6HV0wPSv4eDBiO1K9DMD5wCFQLeqReGQdS3ETNvT5+bukPrGINNdAB27VQPWokwmIhE+PgnXgOWwqdclnqTUGLoV0Guxbxaj9ipfOCIMIu66Z2vLZ8u2v0HhcjqOvnD+kw7PT7J3djrWtaNyco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NueZR9yb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731303682; x=1762839682;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=QdL5o8JnimmZqG0XB2SCVlz2igmAdPf2ApClpSOxO5Q=;
  b=NueZR9ybzVJdqjjdxU8IieGa5jZPvxiH8aYUiesaWFANh9JuUnPakXSq
   2myFABVq38VIArP245N5RqVyr0SgljqJXrmJHzWJz9L8t9NC07GVkolXt
   7k+nJl+N+wcb3SAKNGVlc9PuN6EyW1te81jdOS+GF5/LqbHFMDjIG1ry1
   C9nynlHLertFKl82f2Fbs7Wy0t2RD9bKYoilGgYF8W9L+EWMkwziXCHyg
   B9mMasJO+0et/6WK1QivMkdVVPAe8ne+w1+Urr8kNKaIk9/nDWCPB6Jw0
   NPy/Rr9xqtG4wC7KmrXL3B8GJAE0aY10k6WYzE685JvGZOlI4Irwv1Fmh
   A==;
X-CSE-ConnectionGUID: 87SJW3OISuaRjcCtUUp0Nw==
X-CSE-MsgGUID: xKAG2CT6R3GRI6GblxKfZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31205819"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="31205819"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 21:41:21 -0800
X-CSE-ConnectionGUID: HoDzfkL2SFeOBsJ1gbTsHg==
X-CSE-MsgGUID: L1XRgZfST8G57mHUunbErg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="124292833"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2024 21:41:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 21:41:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 10 Nov 2024 21:41:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 10 Nov 2024 21:41:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngOTrzEXzIxFBLSDFa/YxFug8KYPLfD+b39l5AhsDXxhUE9ZWZy69Wlc2o1oFSXDCezHoye8ASwhJR4hjqbrWo6cNWM+NbXMvJ6xTD3/FY5R2K1v0lFF2Hm3kUhU99e3YUPiPR/US3/1ZvOSi3lbcLqpEJpMzDsxkMI7frCbYTK39iFaNBLm+6+7ktRJXc0V+l54JXt0WcnWeUMtwrufIILIVq/xCvUXkqOef2ctP5SKjBBnv8+GmhE2tIxdpcYW6NwejtgbfP9brQhcORmRAC1A68YjRRscDN+11YIpM7/uxXP3+Cc1gXjPl2WgdSVfKnhr5qTWXphugprd5uiaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ+nQ5uN/Tap62atTpzSPaM8I/A/iz64IzJsqVYwcrs=;
 b=Wal4aq0Aa9SnUIGhmZsuAQkGoLE6kSZoM3glU8wRKOD3JYMm1J8egvaA6Gu9nRQv/6Whio+9P8A2igboLa0caTOR/nyZ2sErT6NM4IGBs2RxiBjSQnJGtKp1MnbU1huV+9vHakfBShs9aUuXBvSDHZh8CfDOU977BJ6ds/HwOYzxFfnRVTIgR5bnd79nmlfbW27THnrxBKbzOjv8wKG18PAJFQgX+oBLf4H4UgqRYfXoTAGL0YMCtzVByLRAfHNXz+4dcjuwMozlsrIbO/NKqv2BYyvApuFO/RuZvJ9RMcO0zTSk+5YgHmn9sa4ZIqm0YKhRBYXH5FuYLUsPvlfpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 05:41:17 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%2]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 05:41:17 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>
Subject: Regression on linux-next (next-20241106)
Thread-Topic: Regression on linux-next (next-20241106)
Thread-Index: Adsz/DAyCKYmfchHQFK/BeZG6nB2bg==
Date: Mon, 11 Nov 2024 05:41:17 +0000
Message-ID: <SJ1PR11MB6129EDBF22F8A90FC3A3EDC8B9582@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|SA1PR11MB8840:EE_
x-ms-office365-filtering-correlation-id: 18c332fa-2ed3-493f-d0b9-08dd02137676
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vwWqceVry/CA1ZRcq+SrEekmJHozhS0DulW0V4Ys2tuQ4DkzcapTBzviM4?=
 =?iso-8859-1?Q?fF++WO9FWmocYr4SbTabC2HpBTeM8uUFc7zSITn/IUdY4+rbYVQpo5WhmS?=
 =?iso-8859-1?Q?9SR2PiPU6mdrggguccAKzmjcHWGlPTAIdfvM2Ao+CAMsEKkvjumZy0DOrH?=
 =?iso-8859-1?Q?k3YSDyw1ajHJXqQWsxg98YCYqdKEWotgAfv7ZxtvUU6q2y0ZfATqN+ykVM?=
 =?iso-8859-1?Q?df15SUw+wvVirn9eKY4imEaAHgS23oTiQykqupPG/bC9//NTLdiRU/+CeJ?=
 =?iso-8859-1?Q?aqddLdJbu34/57o4K6VOZoLzSZZ6hsL86Xyu3cHYGbrtmXp9QxnHYZhp+S?=
 =?iso-8859-1?Q?Mirrjlch530ZHyPRMusMnkbPa3lLJ+qwAJJJs6ABiXvHGf+V0hIN2qMgcj?=
 =?iso-8859-1?Q?pa2EO18WJ4/3wDY/5umIVsVvW5T/mto8GMxn5fKv2/NcUbceBTcmLwaWoB?=
 =?iso-8859-1?Q?apF1CQm6WNXfGQanzeMj1KN5tfJL6I61zJ+9Mc3aJu062doncGipRrBRQv?=
 =?iso-8859-1?Q?eZJn/otatTiSJLgfDjcCkrzAPZF5t+LQkXjJWIWtsBS2176114eCdHO0nP?=
 =?iso-8859-1?Q?vqRahfd+bmoKlNHPLlG5On4v/fw7qJ1CbI52pfMKKRpKxBsuqU8kE0ywCy?=
 =?iso-8859-1?Q?77iqqDk7bpRd+P+VF7HzQtsXo2zZDdqRYPVJ59k2x7RLCsje3OsjuqDjFD?=
 =?iso-8859-1?Q?5ReDZ2MxEJLeE/gjD5qS9NxXLMAQuE8ybJkLQQF41IxCBTw2FARN4Q7xQI?=
 =?iso-8859-1?Q?HbCrggPG2Bnl18nPkj2Iw0Rlfkf6LPPUXbr/zAcCwJxbNYtPdAYEZJEwKO?=
 =?iso-8859-1?Q?IPIGtMIlBTaI0uKt+i7cEtn8nCVbE6bscZE/aqkt6kdJqiwOxLdbuRhpk3?=
 =?iso-8859-1?Q?ZKXanqz5QDWufVgSjpu1Da3cN+G6uI9ayTw6lfq60oxrua8oNVHHiWeH5x?=
 =?iso-8859-1?Q?10B5+NrMohCNGB7EfT9H2JAaOXVpbPAoFKcgIMOkbQb8UWquhyYX/g9u9S?=
 =?iso-8859-1?Q?tMzvYO3/EA/i2VZzOuOiQBWm1SQc6Xy/4k+Qj+kN0Yu3O1STrH6SOHl8iC?=
 =?iso-8859-1?Q?IGCLzQ4/t0qn39hcdfUIqDncHYcIL+pKww2yijWUPD2FYae0+1c5jxxJ9U?=
 =?iso-8859-1?Q?t2L+H/378ZBbeiiVVk4W+PvrRWkOFVs9lhoq2hJ/eAz9ErQTV8YXfkgasz?=
 =?iso-8859-1?Q?sGgm1yIZMmzI4XrBZuK3NHgDcPW1wsi3LvRG7mTeGFNTXyu/3cKQkutnYD?=
 =?iso-8859-1?Q?hWLiXdeUXsF4Q5Nj2Z3N38WtVbheH7PNjmQT2/b8Z8e8028inYPrB9MeQu?=
 =?iso-8859-1?Q?n9WJg0nj0K6aNbTwIz/n9x1XRi3a28/b1pGIVeBOcO0wPuJzljffQ+hq8k?=
 =?iso-8859-1?Q?M8PFuGzW93?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?roXwQd59q/inEv+jjEU5+wYENvtddR7EtGqOAVFUomXL4qpgJYRAdcQCcr?=
 =?iso-8859-1?Q?iocY6cypnsJTxT7npMVJvTaiBnW6ECQfU3iJfGlmPtwZoVq4SlyAFdDknI?=
 =?iso-8859-1?Q?dlPA27LgIwJqpeh1CDjkqO+HPKCFpsTa822PPo3xr+Wzy+1GL5lmvHKFSX?=
 =?iso-8859-1?Q?bsxTgTFeyxJKj1wXqUwo8IA2r68nzSYRXDXwxwntSfzkycB7uf0L4mHn0+?=
 =?iso-8859-1?Q?tfIEmxKi1DtYTOBmqVwTEiDWeIcNmARBwD37hS07S57vsOFXFqDL+ggF4x?=
 =?iso-8859-1?Q?J2hMqqu2OFyQoxLUIPN3eN9+Q0e7CHBu1hdigALQOFEcHQ2bOnU3URA6NE?=
 =?iso-8859-1?Q?RTwWp+PNZioTdClEpz2Qd+I0B/ttGEl7tzbxYmqCH2ef3plyDdJEiI4eGU?=
 =?iso-8859-1?Q?odvyo8K72Lc/ZgRknhziq59KNJIcfEZq8MkDupXtbxoXBMrgiPBjHC0lVp?=
 =?iso-8859-1?Q?DwPp8vfIH9+PKS+ZFKvOSoRH0hSOUMnqgvnAtxNFOoTmNxL0gfcc3txA3h?=
 =?iso-8859-1?Q?1PxseLD1xoDlbk/oUsQha0pFHkEoCW79bKazPpO7xLdKBiZscszfUOSRQD?=
 =?iso-8859-1?Q?8gPGW7Zdk3IwSJziZluRVx3E9JXnWBEFAwY1Y4yLddiZLLs+wc0lWZPArC?=
 =?iso-8859-1?Q?jT88PSqXLvCSzHLjhFlVZUcKEzmffd/jPx1PBKY5ydo/MRx2GjEoIC2Uhq?=
 =?iso-8859-1?Q?eu+7WiHjxgfu7u3kq6l9Fel+og1kFsaUqzMZe+YZONdnf2SK7a29KRuQT9?=
 =?iso-8859-1?Q?KTVTtg6kadZWCmpc4zhtVbTtZW1KfC2POfCLTVcbEUWq2URueXgFEjsnlz?=
 =?iso-8859-1?Q?J3dV08HF4aw9u0eWwNlXZztSCaq5foIe/vkXfbLsnP9SSTOWpQwlvGwj6w?=
 =?iso-8859-1?Q?DnoBpf7PpAAS1JRos7g5z2guKcNpHK41FnYjfLBXshWIroxK7RQ2pkMjt3?=
 =?iso-8859-1?Q?lXDI+Tv4zNN3qEFqx0L6B6/VXTCzitHBl4vMy9pOJ7JgVEFydq3E+w3b95?=
 =?iso-8859-1?Q?vnVYpSYIkseMdVMcX2CFcMeYkM13lEYI8/+TiB7PScf1SM19snBqou31i5?=
 =?iso-8859-1?Q?IhLDTSldlv9+HSQ8sg5LRkZvB+rEjOrqnFQ4lC9btc7WRA5J5oMjFAWcgM?=
 =?iso-8859-1?Q?B7p53cp/gFeASZ/M9LrI00rPrmiBjJmfRebO8dZs7wnItcyIgbFg5SfvUL?=
 =?iso-8859-1?Q?IoD6hwe6IzI2c0c+UKZupRzKSg7DMcJ7TGtpI/YWQy6D30Gu+BzskEZhmF?=
 =?iso-8859-1?Q?ann7qYoSgoGqUV6hgFInmSEZBwRHKTlEDWmZffvK4c5/eqV5n4GOeffeQk?=
 =?iso-8859-1?Q?nkPYTrXiksrY9ZENLQ6CcGh8A6p58Wh409k9F+HSSXUszVkrlRQlFHeMNZ?=
 =?iso-8859-1?Q?zoQ+rqUViGDHnHHj02b6+RENpbfeKJZfdt+2sSZJarr0wbtjQFbQC71dZJ?=
 =?iso-8859-1?Q?SkZFSG/rU4atd2bGZLZG0QLPAUgp4letaWNZkUy/KpuZG08xCBmHFLHO2q?=
 =?iso-8859-1?Q?0C4gLA9eP+qQ4vqm+JjL1ITxCJ6RIi5kKvypKx2GZIQjoJdx1cvbVEmk72?=
 =?iso-8859-1?Q?gx5Pwbzmv9JZKojbxCwrYKVMB/xwOhy9upWcFKUN4EJEXU4HBAessIJNLO?=
 =?iso-8859-1?Q?i1kMFZqOLq1rvV2XnpeU1HSbsTMgOixhsbVBh5BNQuoLlyuOF9zxDicA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c332fa-2ed3-493f-d0b9-08dd02137676
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 05:41:17.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqGsr1xb8XqkHtHpSgN9mMjG+okpiff4ATFqSYIbK0l0CRkTS1ZPoYtpkkAKyedmIF2I0rZCOnh/jgUf9uPkECp439aYZH7mSMZG1YRAHdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com

Hello Rafael,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.

This mail is regarding a regression we are seeing in our CI runs[1] on linu=
x-next repository.

Since the version next-20241106 [2], we are seeing the following regression

```````````````````````````````````````````````````````````````````````````=
``````
<4>[    7.246473] WARNING: possible circular locking dependency detected
<4>[    7.246476] 6.12.0-rc6-next-20241106-next-20241106-g5b913f5d7d7f+ #1 =
Not tainted
<4>[    7.246479] ------------------------------------------------------
<4>[    7.246481] swapper/0/1 is trying to acquire lock:
<4>[    7.246483] ffffffff8264aef0 (cpu_hotplug_lock){++++}-{0:0}, at: stat=
ic_key_enable+0xd/0x20
<4>[    7.246493]
                  but task is already holding lock:
<4>[    7.246495] ffffffff82832068 (hybrid_capacity_lock){+.+.}-{4:4}, at: =
intel_pstate_register_driver+0xd3/0x1c0
```````````````````````````````````````````````````````````````````````````=
``````
Details log can be found in [3].

After bisecting the tree, the following patch [4] seems to be the first "ba=
d"
commit

```````````````````````````````````````````````````````````````````````````=
``````````````````````````````
commit 92447aa5f6e7fbad9427a3fd1bb9e0679c403206
Author: Rafael J. Wysocki mailto:rafael.j.wysocki@intel.com
Date:   Mon Nov 4 19:53:53 2024 +0100

    cpufreq: intel_pstate: Update asym capacity for CPUs that were offline =
initially
```````````````````````````````````````````````````````````````````````````=
``````````````````````````````

We also verified that if we revert the patch the issue is not seen.

Could you please check why the patch causes this regression and provide a f=
ix if necessary?

Thank you.

Regards

Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20241106
[3] https://intel-gfx-ci.01.org/tree/linux-next/next-20241106/bat-arls-1/bo=
ot0.txt
[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20241106&id=3D92447aa5f6e7fbad9427a3fd1bb9e0679c403206

