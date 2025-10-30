Return-Path: <linux-pm+bounces-37116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9EC20ED7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C0F422FBC
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8054036337A;
	Thu, 30 Oct 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAGcrpop"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B79223DC6
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838117; cv=fail; b=owfv6nS75+HXn+vnksD244uZG3XxQGu1toeNsqzPdTe0MZaPto7HOnzXoV3BVM6npinyaXIJoIm5FEZpeElADXnM6ywUWRJtptIHqTUgjqwqfBekhSf4hxSyAqu+CH4g4sJNegzBDgbXebTS8m7svPT0DJEliRTxLGjM2BcMqF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838117; c=relaxed/simple;
	bh=d3vvBf3JSclrl8vO3nJ0SWm+2nZ6yIRpe4XDql2Rg0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aynvAPaFj1MxXDMmRqEsrJAunHaoyzAY9NCDjPbc/2rI6BTXJR+Fs8BGlDQ0y4g+muyzzTiqAO3fs05nVV0MnM/O0uK8K2Fu07dXQ2LU1I8ETLWHxGlOCqWKb0ZTe8H+uf1Y4Xg+9/u7HwbT+l7Ss4QVU0dy45LNF91ZQIMT89Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAGcrpop; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761838117; x=1793374117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3vvBf3JSclrl8vO3nJ0SWm+2nZ6yIRpe4XDql2Rg0o=;
  b=CAGcrpopdDhUSdsXDibrCDS9YIEHptP+HJmync/mVLOUDf5AsqoTRDIW
   MEWtfeKjUZBLxH8FsipDpKypfeAEEu+BsYQda+n9o5tCekkncVHfg1uIY
   WVc4F+Q5nRuKYnOuEv0dwn6tayiDN/97LvImrkG9+xm8zkfy34FvUSnnw
   3OajmqO66SFStU4ZirSpZZ5uB5fjvHezWgbGojGYIEQ3/bMXe222wo5NQ
   jq3rhD/TgHZI9o5IdwkJZwUs2dNbNG7uT4AP+SKgkWF3cZ67FbeBwIgYP
   jGkxdEnZkNuAUP/b9F7PMNI2SG21SROFcouu2jnDXPAsgZ3uvpPK67ur3
   w==;
X-CSE-ConnectionGUID: gddxQPi0TTe1s8LNAm+kvQ==
X-CSE-MsgGUID: oFx3O8VzREepE27Yjbcgtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63912052"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63912052"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 08:28:36 -0700
X-CSE-ConnectionGUID: rHnyxZTMSu6S8OY9XzFDOw==
X-CSE-MsgGUID: 48X6puVCRsaP/3kyCO7hKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185187143"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 08:28:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 08:28:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 08:28:35 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 08:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w56Qub4WrzhYhEKUal5IQxZX4sj/WEeqsVxM0qeoWhR3VTKBo+QgXV1wyB+0+05qJjjd3gExUs40QiO6Gtl0g3OfyTYtkB1w0M4xf9lFjHR8d0Baq/Fg6YPac0fP4ghzWoLqPFLN+V9XCEmwWJZt/FTtL2L6m6b1M8WQvsTdjwM9PMkAr25AgfecJGhHveIjBx6wQrwxWvWwa5ZYHuDjVGuIjRscsxJ/kdYgvqAIMe4OQzObgaNtR3iKc3/AfI97bvfWy3d8Ag2jo0/mELH8/VF0EBMqN3BNMKw4UYqTnrEU6ErZmqcObsGhS2N9S0An1tk6lAUGMBQQWqxNRDVY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3vvBf3JSclrl8vO3nJ0SWm+2nZ6yIRpe4XDql2Rg0o=;
 b=gZTKXbIoY7lgYOqxhJqP3+hZuQUt9Goox/8upqSccvRLTHOmP/O/08TgwMOndkddaZhSGIYkPAxsUIXT5e3RChwXcXiNoplVNGXeAi8nZJaFZBIQJDhgwx/Idz9YPnMc/rgRQHCJW0epBsIZTDBeX8Tp4AAHrXV9aJK7dIZ1hbfxd/cVyPXC4AIQSfnb+GlW7oSWnuoQcQQURLtJYj4Nmatexz5cTk1PFtgWFJSl7OkgYu335fkQXjRKfp3iBuUNrdMM+XE7AfzZaSSlVrhT4fmHRunu+IorcLCh13dbcHHlbTjQwfZD2k4gryLG04BRQBlWDvd7a05C+jMDhxGtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Thu, 30 Oct
 2025 15:28:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:28:33 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v4] ACPI: mrrm: Fix memory leaks and improve error
 handling
Thread-Topic: [PATCH v4] ACPI: mrrm: Fix memory leaks and improve error
 handling
Thread-Index: AQHcSUW/1zSrJBJUc0+Wqc382qaatbTa0MHQ
Date: Thu, 30 Oct 2025 15:28:33 +0000
Message-ID: <SJ1PR11MB608336094D9FA095D1EE2EAFFCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251030023228.3956296-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251030023228.3956296-1-kaushlendra.kumar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6956:EE_
x-ms-office365-filtering-correlation-id: efaa1ebd-1f1d-4dc5-e89c-08de17c8fcb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?tt/qmb/CClc4v+QwQ8zbPZW3K1JsvhLJLwv1Pca73hOE7yz2/DmxzeFkpujV?=
 =?us-ascii?Q?V94MS1Ua2dDDbpUsW9g+S5Sy1TLn4Lf9cazxZaRcvc3BvYCXVyMDafrdAQsT?=
 =?us-ascii?Q?R5O3XatqMwEhV0itrG+qkBw08PjYVkkHXTaRw1IkhbQkpphjbkzgl7LplJME?=
 =?us-ascii?Q?L83bARZfbqcXiq68Gn+VjVYx+CgcGeaaFad4g1sf64Imeo9AC86IpidPN4TH?=
 =?us-ascii?Q?NFORyFHbmhbicu4Hm7Ixi5qDhpPm4cKGubLAFk3b+HPVXyJwfQsZs5eQb/Gf?=
 =?us-ascii?Q?+gb4pA4GLCcoHJBDQPaNqlEQCq6qss6NON+UfjNl6UL+TjwSg8dOk6Z1SCSF?=
 =?us-ascii?Q?ydQBXYkL1Mm7HQr2r6G/o1m6w0uI58VPLjg4AWjIGUxIsK0/hrAB9rUwJdbw?=
 =?us-ascii?Q?xsotyIC5AE16jBSbh8cOqmb48hwazobIrwmJwDvISWdaEugz5JQ4VoRa3DQT?=
 =?us-ascii?Q?b3nsCF6JDLNnH5kiK89z7K8rsryIZDTjoqXRwXbzFZW8sdO6j7aPK93R7FM+?=
 =?us-ascii?Q?nGSy2bXGADKZj9q6EsQHaW4OXBs4+Sj3Fb5akwwCrGyVpfuUg9k8+2+OWxHK?=
 =?us-ascii?Q?P3VbKvi23WEe7DMlNz+yzjdB/zdlCUIuy0Bfro1G0afouI7xVfjKUL88RUId?=
 =?us-ascii?Q?++GTPo7TRhtHuTVjXoAIHMToZlnHty2fkcmA+aZaqR5FUbUh/WbWx2mSawmw?=
 =?us-ascii?Q?N3iT3qbXYuv2vrNa4mJqcRLYfN5+840dg9jcBRPNcE6ydORmISxUjudooDCI?=
 =?us-ascii?Q?WvIfWmeaw5bzBs60F/OnnmqJfJdhXoViwL6Eq/fFgXFN/GAcHTzIOnoCtkd4?=
 =?us-ascii?Q?EpE4S41bOj2zrYbvymiL7oACry/3FQ3ecpE2ME2E4Qgeayxs3lPpakgHG7QC?=
 =?us-ascii?Q?7LnCXdAQTWgdMgDu2krVE7M362IeVbgb5103+d9KhohpucO/NLxFO43vcJ9m?=
 =?us-ascii?Q?61m2XjYLhiWpObKHe/v8eb1w1lqcrZm5vycdXaYYCZAkjH5DK06nkmTPZIZL?=
 =?us-ascii?Q?nOtUAukHIybZQBOlWkZ1kWAH5XufJdLQbfvOkM5kUm30HRKKD0nXK4W5w838?=
 =?us-ascii?Q?lyJbsChc9tLCOxpnxIRek8uMLA9hHnx66qph0EBl248gJpDhBJvj0KsBsD12?=
 =?us-ascii?Q?WuhU7/USqxA93vZG59m0jMpvtEJw/jFM7u/11xqPbJhSrvXiNEz6dTGzqrPT?=
 =?us-ascii?Q?GrxKl+kfRCDE6q+QnnjZgUYRCoPTH++eqnb+LNs2b1GlVi+aQc2N18f6DkZ9?=
 =?us-ascii?Q?pZLuBMPie+xp/YvwqDgpzi1dIeRt7Mke8W26k2ADs5vWy+iDLlnN4dHEFSLU?=
 =?us-ascii?Q?9GpJ7s6fogB+9P7ezDI8bPJDcagIRzDyLKXmEqcyDXOOFQ5wWiFwkFjHUSWn?=
 =?us-ascii?Q?3hUdod+29WJVky4QLqFp67W9IJJSKvQgXYLaAZkvHLkjC0UvRfoCgpaufi1B?=
 =?us-ascii?Q?Y+ycGtNEJIPl06l4ZO6rt4gJKjJDOxUpdcZVGwt+IOW3xj6NUWx7lV0M1amG?=
 =?us-ascii?Q?c7lMwuy32gLqDil824oHi6nLKcydQYTkn2qk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rE7EeCbZvYmz82omwIZ/laOOGxv6uwPwEvjTIvvS8uG7LY6zNDDd73kdt4in?=
 =?us-ascii?Q?XBrrCGMgvw+1FR6PfPGJAT9hf5uH4X8ArGD0GaIcmQ3t6M4dSXW/DR3CJR/Y?=
 =?us-ascii?Q?3eYxH5iWlacdO688/hq9jyB8ewcoouMYRCZisP9TfxiThNNp003YxyI6ba2M?=
 =?us-ascii?Q?rwbqPryR7T8tOsx3SNCUuIHYaQ/J0e7C6rt8HTD38thS2Ch91Jq5tAd3VChX?=
 =?us-ascii?Q?Inckw2c1Bwerc2DAIddyqSaWLVvij8ijy+TWqjxhxBth1f85QmwDMwE/PzVU?=
 =?us-ascii?Q?1Chtlw/R2a3VoKL9UkEga4y5x0KMwgnwY/TYzMv3YDaDP32an/hKa5ZKYmbO?=
 =?us-ascii?Q?tHYZSavyb2g5oDtkfJ57FNrJwh7BjKk0/XC9wE4lPrr4riEkPpNwQXDXiq1Y?=
 =?us-ascii?Q?Jqw27aSSexDiy2lyYgDVT/nouZiAHn2scA0+ArjtZc9lY2qwtrKEy0KuCLtE?=
 =?us-ascii?Q?/lJ3fXgPC1flmjQlmjnjonOVzHux3LkY/zEOz0ReRZsW36aNxgTkadAH4RWz?=
 =?us-ascii?Q?uFDuQ40gBu2j8GEGrP2WpGklPkyh9joPSRJQSgEXJ/te6G5fNZ6RdURZ1d+m?=
 =?us-ascii?Q?fxZiDpukbaAkJq1dPH6d2qbJcurYXbikFmUM/17XJx5T1JV7AHA6a05l79Yg?=
 =?us-ascii?Q?eD+iUpK/GTKQKm/1Xg8lAtTruJe+M1CJaV7k4MrgPw0IZctBQVcju3KluIbf?=
 =?us-ascii?Q?rUaFw7fR5lXFSHf38Q4sTxtSvF4dqGvaaxNG4Udpz13RuYoR05An+aJs/pAP?=
 =?us-ascii?Q?FPFLN8ScsMG/obeRh73j5zhPdCGGZV2RNE2X0oGe2t1hzldNBKc25YiaU7J8?=
 =?us-ascii?Q?TzB8C8oG5SxoYoKcZ0I/tViJNCTPk1IBCsMxFOF7TrBDyg99uumvwYsuDVaV?=
 =?us-ascii?Q?wclwDTh9Imm5TTY8k6x+h038VoVjDSfanopq6dBq5jPTSIqJcIeZxR8EoMCF?=
 =?us-ascii?Q?DT7GY3qor99BAuLKGJjk+yuDvvDmC2FC4BhzwPW711qKe4O3IGGdvKgeLTq/?=
 =?us-ascii?Q?8cLtAIItzFbLqfuNzaipvoU+9fWefL0gGC0JOi6I3aLX1pGEFtuUhOdC9HFj?=
 =?us-ascii?Q?tTEXhrKEArnivX3GdYMWO9ZbGboR9TEPGTz7Tws4m7uMVNhyD+4G+F5JHsIE?=
 =?us-ascii?Q?xv3eP5v2qiAHBchAIgXoE9bNIVNP6rCLd+SjsygaTj77SVBYJWrjOdMdPHXa?=
 =?us-ascii?Q?SlSUFGpaS5mOLbZ0GKyLDhfouQSz5ERjwYinrlFJRkyfCge7nGrhzay1egtj?=
 =?us-ascii?Q?dTpvSGQGN7riz11qiFbe0W0zYsZQ5vjxT60mBKn6HlWP4f/vFCSIUVd5MH5b?=
 =?us-ascii?Q?WNrMUh9mtBOz30OavGaGbOr2gEBO8cXpKg6Ac77qwLaU3qQSsKL97pQnkevy?=
 =?us-ascii?Q?vVBDAOMUwI+7EBHq5yik1X9Wpt04D1nfuUlVncxpNgnOBgSWFWEP/WbAp1lW?=
 =?us-ascii?Q?HJ/SWao4b5ZaB3IsgHqzsZFISdCtfMb9f9+SwaRqczmjQ9OVYYgYrNIq0DDf?=
 =?us-ascii?Q?sGE+ZmVNPfEMSOuOOSBCq6MMn8EaAAYF44aoWRlG7K4HjAk7RXGREtPwWWpW?=
 =?us-ascii?Q?NdfyMB8VZVKQ1FZr6CiOsxzYRwUvArYLvMZUw5Ji?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efaa1ebd-1f1d-4dc5-e89c-08de17c8fcb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 15:28:33.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqEslUURGiHvQvgxou0AIz74S9MM1iK0vjZebaaGO55ScIqUhi6jkEbYElTjoD4xJC0Hj86tcnUOwTH7itZM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
X-OriginatorOrg: intel.com

> Add proper error handling and resource cleanup to prevent memory leaks
> in add_boot_memory_ranges(). The function now checks for NULL return
> from kobject_create_and_add(), uses local buffer for range names to
> avoid dynamic allocation, and implements a cleanup path that removes
> previously created sysfs groups and kobjects on failure.
>
> This prevents resource leaks when kobject creation or sysfs group
> creation fails during boot memory range initialization.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

