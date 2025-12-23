Return-Path: <linux-pm+bounces-39825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3101DCD867F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 08:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96BDA3002170
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C92FC881;
	Tue, 23 Dec 2025 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1wQZIy3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC42673AA
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766475898; cv=fail; b=tFuXr76Qe9SKqPDuECxjgzEH8pWug0WUSEdc+pvN4tulNdZScQfKtkUgY6yjOh61b5Lefwd851ElmeBWartjFZ3kWzzydGs8JMIdJveowBl5mnfxXDYWZQ5f88DuIgCepwn2G1+kqmA/Pf/g0vGfrCbIVwOX9jEtly18H7NIe9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766475898; c=relaxed/simple;
	bh=s5uI5QhF+FL+NxDxsXbDqK44zUuuB35HLww2V0DY5y0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXfwwIwff9GG0A4wwiGoV99HWPR/wZw6NvUED+7svGTk5MIwJBecdheuJSbKjhBuu7wyVHdaAH4ZUdYk5ycpT7h63uqrqwRK66hR6qQ0NysesACSBhdnAqRoTSmByXshvwlVgGGyhgnmRsAEbkdAkXSgVvYGodF3U8q9LS3kzLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1wQZIy3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766475897; x=1798011897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s5uI5QhF+FL+NxDxsXbDqK44zUuuB35HLww2V0DY5y0=;
  b=k1wQZIy3ABlf6MUJcxFy12mu95idNCH+uDRU0MPs0ufD8BX6qIGJvTy7
   RzOEUdLNI6fn1xtHeQXpPtnVnXZRUWyVXKEkL6SgMbJN5zOWtvtqZiXIB
   pAbeGbG/CAG5uwOWtLpabL6tvLe+IcBAyIwJnHDyqCM5fxGtepxPVNUy2
   Bd8zDtRFv4UL/iFEvj1yr9n9623hWZczV+WCYepUEkqw8H2QMvZR0s9fO
   CN8u8PI8A52EdxriTQ2ziQBkdvU7BSVjGgUP8UPINlhnrSylUm4UfMrKF
   oBCIG5blFv3aU49Wg3Dsa34bFzsbOFnC6+dkHuGo1CiqtmCRgouInTfRi
   w==;
X-CSE-ConnectionGUID: 6Ny5vX+cTy2+OVJTKebo/Q==
X-CSE-MsgGUID: GDnlGkU4Qb6SAm4VlJs+wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79777801"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="79777801"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 23:44:56 -0800
X-CSE-ConnectionGUID: B5uOojs8TcmR+EsewHpnRQ==
X-CSE-MsgGUID: PfY8payESkK+bGA5UgVMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="204773078"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 23:44:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 23:44:55 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 22 Dec 2025 23:44:55 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 23:44:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1RoGCV7dqS+DureieJ1WtKp183Rzu6Q10am2BZq76w8camIomVOBj7+ip7tCHRYVAjbYHDM/SnyA2yrpCMxMb9u6QKPUzJ3mX4LxgGHbD1Waum+7kMmYA/gqqImLaCy7md0S0NSEcRVKZnCgRCRJQMtrY9nNzvg0qw2n4KRNLEH/VZWaBgy/SXB84w3yUUxiKOnyLUvc7QS5CRgn8kEzr/h25bMjS7i34DAthI+xqpBG7I0FmzBrwbbry4qThl0k7YulXY6rj/81zNvvHJ6T01mFBfEFoCGaUXSbwRraxOAJ8oyg53HTQL+r70hSrbeSsrWK8xMWZUNr13mS/89IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW7kHA30DozOr9FeBdIli1rDrC9+J8rzTVV8rnATbiQ=;
 b=ih+P+euV8rEHhRGvkWxX0+qhrsQTtmvgON88c8a1aZM1dkxgPnyTOA32cWpZa/zAGCnU4fVMQwo9Jb5Dv/ZtxDhGdnB2OwkRV9sBVy2uGDWglWTHwW50sjH9rJb0tSR1nuSTZ3SzWdRwg792gJp2tAif7YME84uHqqvNo1rgPjlGDRj79drcHEk/75TLjkaCgidjV16j8j4CvbEaYJBaDb1LkIRZsSqUZFxxDE9XSDlSThvo0phFfN/TeegY7N6uhvXDyKeUECM5ZIYNVYJWSS5r4BM9TRpqsINDIEgKtpYFP1sgqmA1g1siAPq+R/C81K4xegfz9sTEZDEqy8oXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 07:44:53 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 07:44:53 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "Zhang, Rui" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, srinivas pandruvada
	<srinivas.pandruvada@linux.intel.com>
Subject: [RESEND, Cc only] RE: [PATCH] thermal: int340x: Fix slider_balance
 param get returning wrong value
Thread-Topic: [RESEND, Cc only] RE: [PATCH] thermal: int340x: Fix
 slider_balance param get returning wrong value
Thread-Index: Adxz3vhMF+hFB3dnSDKyRv9f4Qr4eg==
Date: Tue, 23 Dec 2025 07:44:53 +0000
Message-ID: <LV3PR11MB876863C45EF9B76B52E16369F5B5A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251215063347.3521513-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251215063347.3521513-1-kaushlendra.kumar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|CH0PR11MB8189:EE_
x-ms-office365-filtering-correlation-id: 9664696e-4eb8-40c0-911e-08de41f728f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?qLErwHLvzAhDjrDA4/ofcbRwI1xSqh7dVzwEgLWFE8Qemzv0x2JrNplVfR5o?=
 =?us-ascii?Q?q3smLDxYU3LAkyLwlaJdkeIQAJPp66KxkPR5+bUeX8ErnL6YaDv+ElkzhbBn?=
 =?us-ascii?Q?50FnRj4iP71+jemb4ebjyy1fnhAxd5GU066AO9Yg82iXDVHlW6sSf9VTr7pM?=
 =?us-ascii?Q?qEpy+W7m3TAQHE6gI4RjVCKEtoyyDAVEDa149X7RmOnRBCW6eQGCggZdhOjl?=
 =?us-ascii?Q?m6Ipzc1lcgmrFeMBFr3rF/pONuX956E4hRglEAi9N0V/1nWuVIrXU6GEftLp?=
 =?us-ascii?Q?dtHxV7d5YjTVZ8+7uyFwsBxXF5K0BIMVTULchMB5wQy1PZSVNKeJ1Z7B8i+2?=
 =?us-ascii?Q?crNsixJWGAQe7/TrOMc61xXWRP19w/OzJJngp/CaZPphz4jYd9T2K7FE4rTc?=
 =?us-ascii?Q?oFJXBmy0FunqzCTx44dEbDdEf1qEHwj1cODqs58eZWTXqegXVgksWMm7DERs?=
 =?us-ascii?Q?o6tyO22OsCGgfOmCNiOqSnm6YzLEywutEOp1uTfksa5Yqh4aRbex+U9yLNi/?=
 =?us-ascii?Q?akYlqBqWPttSYy131ln1KIorgyitxou9cpwZDaag8cRpRCneO/6U0sHPz2RW?=
 =?us-ascii?Q?xRc0nVFb6uTkVFTy6egB113AGdLfU04H2uaCrTQL0SOhJ2wRiHJFj2WMU3qv?=
 =?us-ascii?Q?QoKsM6BIKkdXxsXX31svRSKXel5kcwfxHtIeHyf+w7J9ZeZc84sHagWBY+hB?=
 =?us-ascii?Q?2zwL73FupwGrAGe94njm/CEWoYgge9zkJbu0fG+h00zcz+SldPhzcgUaeIjU?=
 =?us-ascii?Q?szFvmrN202BIjOgHgeBhPVdWozrpuZuxZxJGgsLO+PLxvtyTY9RP5vEI2dcJ?=
 =?us-ascii?Q?ScufcTASmuDkVfxa9DbuBRE1cGTxKABc6h0kgQCpy9kkVI49fAxtYUp1iUND?=
 =?us-ascii?Q?TKH1jW7eCwaNrJgwg102+ldnB9bbcANtkPPOA012dMuCWIoizfg+iZ9mCLZV?=
 =?us-ascii?Q?k1KvW1maJXH8jxncB6Uv2cCX7MGKX7timGm+/2oMzQqFmiRPLe3I5rx8Jz4d?=
 =?us-ascii?Q?LzdpX3Smq5C6r4FF035hcNohcGbMEXGEJ5gPEBgnLFD5jO0A/Hatc52fRR7o?=
 =?us-ascii?Q?N4CCf/oZuo9r3pas2uglw/CmuvJRTb7M61b0MJ5vQnPAXE2l4MAKBsKWc1aB?=
 =?us-ascii?Q?Ihlw4L1fHKNDJv5DCwBxHKRbr/ET56BMUabe8LSbT54dhZQ+GDFMkNBhe9cj?=
 =?us-ascii?Q?1cNjYP52P8I/wfrJNd1b+54GBpQ8UyKsvQR9xPNHvLn+bCF+atg9KvOYrZYX?=
 =?us-ascii?Q?vC4syEi4tH+jlS63XhbGPS38rrv2VmgOBuUIvzXX8YlONhLMpjKuRFsIi/0Y?=
 =?us-ascii?Q?SNXxE4jESCcVQA9qXvCjKd2gicpKQjevXGz1Q94qtpeqb7p57SEQ9FY+jjJS?=
 =?us-ascii?Q?FrHLOo7Tgko1S0+NOXgwChgcZsmUT4LBKbei18k7e87uBcsz66PuPEvrcMTb?=
 =?us-ascii?Q?Lso/h/3dBA/86gGgd6YbBeorEzSufgu2SXTiVng4YNH3CWx1nJFVWsi9+GOx?=
 =?us-ascii?Q?hpKcECgvFogTkD0lYzH+w+ztLAfhUSnKTtwY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pZaoKNJf6IvFqDQ/CjeW5BmSO/IV0xv+/I19mkCiarPJgNXO4MIEgEDkq9ah?=
 =?us-ascii?Q?oqszqf+6er4vHzWmmBSNwKNysBQBPqB+z+amxEJNPciBjL6Sm3cwsogCchhv?=
 =?us-ascii?Q?RtP+0oN5ALq6xkm0RF99xoARCM+uU5VTUbIGxRAz9z7Wut1X967r+vCDK5wE?=
 =?us-ascii?Q?O+JJagTUNZrYZpDv87kz9+R3+nfAkhpL2hYO6y6FoIY2gBorVi7kXzbEJa5k?=
 =?us-ascii?Q?Xs8WsdcCbSOcs5/J9Lu2bKi2hiZxZvXF6hgMl98gzsgOCSpoK3u+uM8uw31r?=
 =?us-ascii?Q?GmAted+73hGr+wLuP/ayU2A5HCWOaY4RzYzqhW/b+bdEXbMB05hID1xx2q2/?=
 =?us-ascii?Q?D0PgS7jgEApaxu6zBez4JMaMAgAbeqLyX76A/FBJDmnq6RmDgI9hw3oqXuCv?=
 =?us-ascii?Q?/gUZifgxSfNOWlQRUGkhzet/bxSKlBWZw8fR7NOy3OzuQqPh05NQrhYFrVS6?=
 =?us-ascii?Q?4NKlEoNT2V3pdJIXyc+NzQHbqe2LacPh16TjVtKXdn9POtGz40Lm0+7yDlmw?=
 =?us-ascii?Q?nVTPUgCbQLnhyMjQzXZV+FC0cUF3d2Ek7kK4vMOeOuMVb26SYcnxtH2XM8Vq?=
 =?us-ascii?Q?sbcdNnFKDuxPT6gw6BU/9bVttAaBmuh9UlRNNV/qSCLLoIOuG/MyhP9gr2VS?=
 =?us-ascii?Q?13tFD0iVfP1yixb9oSzHstqbRCSUyrvQbZXlucRRnM+SN39Opbnfj93OCZGH?=
 =?us-ascii?Q?FPB71elwne2t0gwz/YCsAIxFruOmwd1q6E2swxfanQAa1phD8yIioaWYOWJK?=
 =?us-ascii?Q?nG982O6Ugoxyx9I+vPyB49NegJL19uMNMGv9TjSSzuKV60BhlHCDamsj/73h?=
 =?us-ascii?Q?2YQeonFHldx5L7r1+vd8SGWvJo2vzev9HfPS8oqLTn+V+XzdgGkgq1u95AZi?=
 =?us-ascii?Q?Ap86cA0cD/dhqFL3Vjzl8wgmdX4MwV/19SQ1twqnp1oWxox0GLvtqsnt0QUF?=
 =?us-ascii?Q?WbgocZwqV+CkJ7h7ST2y3z2GqzO9woQfhWj4Z7/OhTD2w7Ylz9CG+p3VT/r1?=
 =?us-ascii?Q?CugvyA5Fxoy9Oy4MSdNK7ak9pI5yVYYhnEs6uB/y/5LZynbsp/4b6R0pURcM?=
 =?us-ascii?Q?e+L8ZxIUkHLvPWX+3pIYaofuZv0C+uJEbnAthR4/M6VlHAsvtwZcJnlyfApL?=
 =?us-ascii?Q?O1Sq3oH1sA4zaEzl08kQIIv3Z1eAQDv0N0U7crtP37LN/h8d5fnZz/gEbbP+?=
 =?us-ascii?Q?gqyu6bgqYV/Tn42EFjTxkyVdBRsMgeEbJLfbdcxxNucXOPGLnuhDqUHWJpXo?=
 =?us-ascii?Q?RdjMlgIYaueUBeWK5JFv5MI7Zd3taPHGsv7yqEgn2ey8pG26tgQXgj/QDIZN?=
 =?us-ascii?Q?ajvSk77TMy398oyepnnQZGh0Q3XPBXjiMl1AGRWilqt0CA6K67sA/ZXF1fzS?=
 =?us-ascii?Q?Rvu1YtTNtIzuS/9Zh6oDdVEvPOStXpRy+H9NI4u4BsD1uz7ShvKu1VZfrcMG?=
 =?us-ascii?Q?G8lggBp3SZXJprYtERWSqZ61p2or1grKNa2v4lizglyX9dVGwJtVrNoEYwsP?=
 =?us-ascii?Q?iVTg0fA+c/nUrGJWWVpD3azf2oy+7/IFHSmbgSYZDLQdBlsR517cpDInhCwM?=
 =?us-ascii?Q?FtRFStb42X7TgTnx92EwibOKHCDTMkcJK/rIUgYdcGymy2QBgXanqaViaPOj?=
 =?us-ascii?Q?UuQh9tkyCMfywoFqPHVErlojJEJWRivc5rD5EYHmALzgYL+yxWkfXoLZtcbn?=
 =?us-ascii?Q?jrfFiC+vToOcn7uh1JbH/cq0pTSpBupDI2ccKhXHjio07rDUjKdYtOEb4wLO?=
 =?us-ascii?Q?wIpfl605JA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9664696e-4eb8-40c0-911e-08de41f728f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 07:44:53.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWTyo9pbw3Wz06OpJiiJ+MrDVcw6cwBlHCNUn3ff4MWdSOl/DEJYj/1Yj6Qo1REYPFKPKgdwEAxhE5I2VipyYMNOVAdd0pxhhFou5IJVhTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8189
X-OriginatorOrg: intel.com

Adding Cc: srinivas.pandruvada@linux.intel.com

No code changes.

Original patch: https://lore.kernel.org/all/20251215063347.3521513-1-kaushl=
endra.kumar@intel.com/

-----Original Message-----
From: Kumar, Kaushlendra <kaushlendra.kumar@intel.com>=20
Sent: Monday, December 15, 2025 12:04 PM
To: rafael@kernel.org; daniel.lezcano@linaro.org; Zhang, Rui <rui.zhang@int=
el.com>; lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org; Kumar, Kaushlendra <kaushlendra.kumar@intel.c=
om>
Subject: [PATCH] thermal: int340x: Fix slider_balance param get returning w=
rong value

The slider_def_balance_get() function returns the array value slider_values=
[SOC_POWER_SLIDER_BALANCE] instead of the actual module parameter slider_ba=
lanced_param. This means reading the slider_balance sysfs attribute always =
shows the default value
(0x03) rather than the user-configured value set via module parameter or sy=
sfs write.

Return slider_balanced_param to correctly reflect the current module parame=
ter value.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 .../intel/int340x_thermal/processor_thermal_soc_slider.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_sl=
ider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider=
.c
index 49ff3bae7271..96307dcb4812 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider
+++ .c
@@ -80,7 +80,7 @@ static int slider_def_balance_set(const char *arg, const =
struct kernel_param *kp  static int slider_def_balance_get(char *buf, const=
 struct kernel_param *kp)  {
 	guard(mutex)(&slider_param_lock);
-	return sysfs_emit(buf, "%02x\n", slider_values[SOC_POWER_SLIDER_BALANCE])=
;
+	return sysfs_emit(buf, "%02x\n", slider_balanced_param);
 }
=20
 static const struct kernel_param_ops slider_def_balance_ops =3D {
--
2.34.1


