Return-Path: <linux-pm+bounces-9730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0D6911AB7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F69283996
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 05:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CA13BC05;
	Fri, 21 Jun 2024 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FuVefI8h"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5583207;
	Fri, 21 Jun 2024 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949400; cv=fail; b=jXuyc++MhcLDp/k6YzaVo6ScnyAYwNhbNDyc+Dg2UxxyQLH/oNX3oJtIKkO+vYSlA3lKTAEsqMb5ZTqC92sIt6y31YVuSz18Rc03h72z3W2G5tcQwVkEUUgfcANjdgV7/ZFvHyM7ZiQYyuUHCRwwg26k6xDNWxW8O39tXkXlrV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949400; c=relaxed/simple;
	bh=Yq9XXyOdT88p57LlSfP7A22Ta5aQWFapuKqQpZOvUVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UT5/2rCCsKRRc3+8aP4fT67HXZLXkts45QgyYq/JbjAhjM5qs4Wd+6Mwx0fEfAzVU+cDlJdlh+7cg9lGOhSdB+TjqBt/mRlvSL7PAdjmIwwaOi8yiYFPme/0IafkRER+kGZ/wO3QR6QpgGhepVOf/5iJfcxoTIV5gQ8VqaTsUDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FuVefI8h; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLfeHCZvw2TxhPK0YIOGBqE6AeATGAePoe5dIj7qTf+q4+ORb2Fqe/JB96Z7LnhCAsfzO0Kttf4kQW6Ke/A3OuzETw2Bmw5Je6BnhsWHqVE7qA1NGJgoQtYu8OpvR4lglSQ9s+yrxDKiiZXS+TpK3vfiq4U6ZTEbz646nnV3SHWW5GHYLoV598snXOLPNtIwV/BEzhgdFS3YuVYwAzrTLj7ISW85WGT5VNJBTV1LJmvroaFA8f+i2/vNVtMLy4V5iRIlDlF/OAkp3ZC5vBfCCqSt8WH6CfN++36XFBFGBQicBTgCSElbGDKaqzRoLieDkwZBLBhYv+Wv2yiB4/qqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjsfbJClj784Ozzm5XjyAicemulKTdT9qmFNXHM3rHU=;
 b=H8pZn1A8/rAIAXW8h0xmvkU/A/Vzup9eDGF/WjEKQYWHKjfPduNEtYuJ3qkMoQ3p2G9oB40pIZcNOZBMzbbhd+QiQTp3MIRpCG+Vppn14dJa5FDimXPDjheg0y5J1q5P+f/VXmPpUmmWH4BarKPArIe5oHj3c6H3MWj4DcDKfvnjelZBbwOfRiPdGcAIUCH0VjLRY757eNXOfcni4kUEL0aUBSylKqZMfeyFKjicQomyPkATPDesdLZS33s9dftdEIEDGNvBtxKsz+r/VATfKgOqPppm1Inkum+kqiWuDm42Nf7/bemtgyYCsdgqL+oitddoRHwKYf8RKR6FhTCe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjsfbJClj784Ozzm5XjyAicemulKTdT9qmFNXHM3rHU=;
 b=FuVefI8hRu4VBP3BRlcqfJ8csxIetmol2l4L647n+40QyjAiF3OhXmK9biRondnEn03AhSttlkZcfzFV+rynopUnt6ExsUAkeCrGGcugR9JnolXMes8UScGD4y7t6vGZDep1q3hrqJl8E0Ra4oAaUNZUjAWH+cI5Xksd9R5aAcY=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.35; Fri, 21 Jun
 2024 05:56:36 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:56:36 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>
CC: "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v12 7/9] cpufreq: amd-pstate: fix the MSR highest perf
 will be reset issue while cpb boost off
Thread-Topic: [PATCH v12 7/9] cpufreq: amd-pstate: fix the MSR highest perf
 will be reset issue while cpb boost off
Thread-Index: AQHawinFJKy8xLHsH0GzR6KN4XQ2MbHRuGAAgAACZwA=
Date: Fri, 21 Jun 2024 05:56:36 +0000
Message-ID:
 <CYYPR12MB865528D2F3F3281FBECA69489CC92@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
 <df44ee42774efd7d1c656ed43ff3b35988e22e60.1718787627.git.perry.yuan@amd.com>
 <87frt6voen.fsf@BLR-5CG11610CF.amd.com>
In-Reply-To: <87frt6voen.fsf@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=76655b9c-1736-45fe-8de8-ea0bda0f06a7;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T05:55:00Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB7503:EE_
x-ms-office365-filtering-correlation-id: 4770f350-b8ed-4846-305d-08dc91b6e959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uw1j1HWPkNMj1AaKHtK1XoPSYmbkCzoNHCeyNWfVC21LDIsK7/gVsWSlEQ4S?=
 =?us-ascii?Q?V9YDa17YnqH8rjXiSmega25WK5o9kQDw60awmvwO4mozJqNVStED3EyD1ATP?=
 =?us-ascii?Q?uXpGeWQdv+3sTcRw8KGHbFJYwj/osRfAduwO2g5kPo7g8RFSeAXGrSc8nQWB?=
 =?us-ascii?Q?iB0vYandrF26HDn/VRxNUqH93a/gyeLhtAVcCXHxtzM1TDNkbguXrgTad2+9?=
 =?us-ascii?Q?+k8pqRaPWN/68nH5/k1Pq7pOPnYKHIWm2n5CyPDdxpimSI1gFCdpFhWqvmv2?=
 =?us-ascii?Q?wRUd3JwghJaWJn70+eZEaVgFrf37hpnQF8T1sLU1Iydd8n1GpFtVxxIHNWjj?=
 =?us-ascii?Q?UF4E4kH8DYdGCITk6uFI5XzFzblgZ1VF8pVlzSYYSg5a/DoBNvP+wZoV1Axr?=
 =?us-ascii?Q?UbAn81JmPfruVYWLdazCTfnpxiOVFjx6uQ7osPjDiMV5MjgE7PXVaWIM9d9y?=
 =?us-ascii?Q?k/ri7s1AsfXZBfcvHXIKY/jOUANhYJdEwjB8awC1glzowYoiokHjqboc3jCE?=
 =?us-ascii?Q?PF7BesD0GZofjt4kWEfmDKwLysJOOZgAJD3VGinlADOfEz0S0Ds5Sf2ReVno?=
 =?us-ascii?Q?u2qn61YORmYWTgSQOBMJueI9i9IJG2Cstxb3zQksOmqnrQgbZB0Qu3TKnZZ+?=
 =?us-ascii?Q?gzyqRg2WAlKzzRXtexswSR0pRJ/RmC0rx1Emf0Dy3y7K9CTMufPRnvbn8W1/?=
 =?us-ascii?Q?odmXTxezMJLbVVu52ALumuVlwrG2EgCS5fNfciXCh6sMbTXq5AQyehJKc9Ol?=
 =?us-ascii?Q?CJXhrUJE3tR+vPbBIuGOedGNuBDekrySVXvXLs+xVyIeUDW5raFMNbdk15nU?=
 =?us-ascii?Q?BaxCn++HZa0mq589jx2RsM4GunVh9beOhXWKpkuV44145qkO4/dWu2K7+yaX?=
 =?us-ascii?Q?04Yi78lTuSe6pwBOpoZ5+scDgQ96seTP0XnQXGg7muFiiCkaus56yXuIP2qm?=
 =?us-ascii?Q?5PkhEAhuPoePMHwzkKDJ1yFun/99kszh4UBlXrn+2Z21f0wCk1Av+GJTG+ta?=
 =?us-ascii?Q?M20V/iCgCiUXo5xpoF50Zv5A7dQJGsJgCZLiOx3BQZLFi3d2SxVhdWzUNA4X?=
 =?us-ascii?Q?iX/Hm1daYm66ogXX9ZX5yQXjQ6fsCeDo78wG68/MmdL0ybM7vk/pWgktKOsD?=
 =?us-ascii?Q?ZGyRU3PY3npjSC5NJkZKGDgqlMVwWmm/dDlDDd+jNfuVGI9ZrWqi7hl4SEUP?=
 =?us-ascii?Q?jaysz4gYDRWY1gRXAFs+/Fjx/nKjJh5BrZeDD8wkFkxaQwM3Uqy+u96xJVHl?=
 =?us-ascii?Q?iyfrVajd6t3b6yVQiulQ+l7Z8ugZ46c6W9eCb2nIYlhAqShuOBckFlfKKLAP?=
 =?us-ascii?Q?MX0a7odCVZDLgdqM3+hXsvArQFUaedIanR/Y/cJHy78RdbZeu8sPsoFuqo1s?=
 =?us-ascii?Q?O7k8Nok=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8+cGZkdngbNGXLw6yWwnZJQiSiWgyVq+wxbN2BikXR/5WHHmIqiPrEvD65s+?=
 =?us-ascii?Q?Qx3EpzDD+vP1GM4GkhCHs3pwO0gP5bzcSGAuFMJP0R4NB4J3i93ICD5wS7xZ?=
 =?us-ascii?Q?aavdNxGxewNWfwJ8LrUVmy+8VnZNxyTWCKSifjpGo/O5ALbjlic/fSadeCtm?=
 =?us-ascii?Q?+e+55nZGQecp5LN5yyQZsJFUJxylQ6+zWUbgYsLirxBiBgtzY/ywqV6TEsA2?=
 =?us-ascii?Q?QuX7C7xfGA8CCjtgftSdUqBKzzF44dkxnCMs+5pQsycIH47A1L9ON5dW1s9Z?=
 =?us-ascii?Q?mA1TQdqOTWgpZSN53MOMvckdWl82AmNjDz+ZZhIxyR3ykDSop2+1L+zDUQ7g?=
 =?us-ascii?Q?Peb+AiBd7QLnQ/3klvJfO9XhETNY75lEwe9WYvghCkgmXw+K2D57IWCMhTOw?=
 =?us-ascii?Q?lcl50tNRd9Vwn5HH4/M5czzGrMxALpvJP13JqHAhrH/5POwQG8rFRSZRkwLh?=
 =?us-ascii?Q?8qFliJVvaHVjap3Ld/4yckh22niSAbKyMV3rP02De4bYZGKJ1Ff+RJ5xw31u?=
 =?us-ascii?Q?drp7yNGs0NnTGNY6lzLHzljBFUiqomkYkOCTgCH6a5Hwoz7eOCrhJFRmWDcC?=
 =?us-ascii?Q?Q9+c0QNmmbX/7LxebvcnoNUwoFu+HrysD/UMRtqX4dCx/giATmKLvaxqFFvc?=
 =?us-ascii?Q?tRuQ3YmUfA7ggqvEK1L80BNjePi1R2kLckGeU9Pg5yjhKgqrz9nkayLhS+hA?=
 =?us-ascii?Q?Kp727TLgZBOV3FvQcpEsIt8lLjDeUwWVG+vGtXp45GRF1JgnuHy4c1CfEylZ?=
 =?us-ascii?Q?ojC0h3PGnI2kYjxIihF/sZEC0K4ahdTbRAJfvQWQ8AwbutKIw4drqTqAYMz4?=
 =?us-ascii?Q?PuZIKdcE55jYdW+bxOIa8lNSE/HN6VvgThTJ06Pk5ndDBjp0QXsJtjdpJkh/?=
 =?us-ascii?Q?f+6NYZMWzCQghWvfLgKx3in3PSIBfgNlTcwfrFg7aOMlxNyOIYHZ4rNcnOqA?=
 =?us-ascii?Q?q2+10RYwM0h1H6U3NslF+XDpE0vPCqp9uZP3RJk+a1xXFjDBXishAbLtJnU7?=
 =?us-ascii?Q?6bug1x6o3K1wzjq0P3znZnpPUYM0rQNdrbP+uQCJMkbRDXVXsGEueAmKxqgj?=
 =?us-ascii?Q?D6QSOVss1l8/EedIedTOGougIBFf232fHlDwRd64A/97tOSJukgutzw5wzM0?=
 =?us-ascii?Q?sIPrP+KPCXz1bGZ61rYnz9/b14r/YbWEbwm+DAylYSIdiGaw0C2wn+WinBWA?=
 =?us-ascii?Q?c5ut7O+quWiZvvMkzf5q2+1nYS+qvf/HjXK+BRqF1SOwuYJUgfpQrFkZFFFA?=
 =?us-ascii?Q?vs5QCWcBIispOAAxz/aw65wnp12JZqFn90fykm+B/AolKKSSnnDGQ2ZE57+S?=
 =?us-ascii?Q?wE1QoToVx1zuvBIrHS1zfU6MwCo9gvDNpS4comAOwwBcOgk1HS5utkT/47e2?=
 =?us-ascii?Q?TCu53xYI2iz9vJxiKdXMBlQIfPagi8fIUfv6f/p6AjlFc9oIKPODysNVVBDm?=
 =?us-ascii?Q?juV73Foq4icvG/egrJi9oc8xiqiYTMqhWS4ls6HUipvjtrGTryLk6OUP56PT?=
 =?us-ascii?Q?vHtPdR4kqChEmLPMAEsIVn73A2dTHLH9YH0Q//eWKuxVEF68k4Em2Q+TL/Y9?=
 =?us-ascii?Q?aqbxU8od/0dDvFq9nCo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4770f350-b8ed-4846-305d-08dc91b6e959
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 05:56:36.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jhu1NVyCFz5Wbpi02R7vHP4dbZbFn4CyrY3NsYG5867CWSvy2oaMJbXIuaZDQe2mxXXSJNjk53f8D9J4XYYjeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Friday, June 21, 2024 1:46 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com;
> Limonciello, Mario <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org
> Cc: Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v12 7/9] cpufreq: amd-pstate: fix the MSR highest per=
f
> will be reset issue while cpb boost off
>
> Perry Yuan <perry.yuan@amd.com> writes:
>
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > Select the min perf to fix the highest perf value while update pstate
> > CPPC request MSR register, here it needs to limit the max perf value
> > when CPU boost is disabled in case of that highest perf value in the
> > MSR will be reset to original highest perf value which cause the BOOST
> > control failed.
>
> Perhaps we could rephrase this as
>
> "When Core Performance Boost is disabled by the user, the
> CPPC_REQ.max_perf should not exceed the nominal_perf since by definition
> the frequencies between nominal_perf and the highest_perf are in the boos=
t
> range. Fix this in amd_pstate_update()"
>
> Also change the subject to
>
> "cpufreq:amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is off"

Sure, will update the tile in v13,  will send out the V13 today to catch th=
e merge window.
Thanks for the review.

Perry.

>
> ?
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Other than that,
>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 299e52d4b17e..f2ccef089acc 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -524,6 +524,7 @@ static void amd_pstate_update(struct amd_cpudata
> *cpudata, u32 min_perf,
> >                           u32 des_perf, u32 max_perf, bool fast_switch,=
 int
> gov_flags)
> > {
> >     u64 prev =3D READ_ONCE(cpudata->cppc_req_cached);
> > +   u32 nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> >     u64 value =3D prev;
> >
> >     min_perf =3D clamp_t(unsigned long, min_perf, cpudata-
> >min_limit_perf,
> > @@ -543,6 +544,10 @@ static void amd_pstate_update(struct
> amd_cpudata *cpudata, u32 min_perf,
> >     value &=3D ~AMD_CPPC_DES_PERF(~0L);
> >     value |=3D AMD_CPPC_DES_PERF(des_perf);
> >
> > +   /* limit the max perf when core performance boost feature is
> disabled */
> > +   if (!amd_pstate_global_params.cpb_boost)
> > +           max_perf =3D min_t(unsigned long, nominal_perf, max_perf);
> > +
> >     value &=3D ~AMD_CPPC_MAX_PERF(~0L);
> >     value |=3D AMD_CPPC_MAX_PERF(max_perf);
> >
> > --
> > 2.34.1
>
> --
> Thanks and Regards
> gautham.

