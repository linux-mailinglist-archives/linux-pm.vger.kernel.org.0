Return-Path: <linux-pm+bounces-9821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2989F9137CD
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 07:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C510E28280D
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D583DF60;
	Sun, 23 Jun 2024 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MavmcS82"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BB64D
	for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2024 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719120294; cv=fail; b=oy4P3zH+RJX99CnyRPx2aVOrrYBXlZ2tKrVTaTwDwPbXAlViAk/MWH5dG8hHUO+AOgAH33ffs/Zvvswzer3McOZTg4bJyuLoVjr6/GJQF6NvqdhkKCdw06fTxWQvNUUoRl0seaYwLg/mW+XZf4qE0NddO6PO8wvSHv0foDTf4Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719120294; c=relaxed/simple;
	bh=a7Zux1w+jW1taccEkFtDbm7X4Tb35+85D5jXvHdfrq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnkvM1ZDi7ieIu2Ol1Wuqrtm5D2I/Lrj5vKrlyQnF4yK6YDqISc8DIhZJk0Xl3lC5VMvQGyDijYNgOh+zsWh8BWWHV/Qs1n0J5RAJUFVrH/PTq1O2PU0dPSgZNgj/ueD6z0YNOtNkk2Sei9oLBjEY1WmF8XdMgWFM6nwgEvkle8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MavmcS82; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibKX8ZJfFWtoCViZfAbQZ2uRBDr3Q8cBXt9mjMNfCyPU2aac8iAbH6WeohrZbLIoM1L9kqTRJbMbie9duC9TDVv+eCDskqx27X2M+bMhznkV9ayUoM3qtDAna4samdoXwr2cSW2XXfuJa8gsMVTyjC56vXfx3lNEpf5CzTGac+GfCWpAjM+wtbR/xvyy++uvcqVzyOX4SEcw60YjilHbXXIj/DwtI5OmB4Xt4hoAG4B53XMrKT+VVNN9jHy5S0ZXuzzOSVhHKjxwZBJXyp6qSaAREbv98I0om8UD1DI4Bv/FYLPsvxgsXuR2ChkTzgTYfFz5HO8X2uSoF3f4ABlFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j/1aPWwi9PPBtS5KaCaPjmeVtCEN9XuLo18aJ6Dq0k=;
 b=KYRIacnFSyKago6MwROntVeClm4a3oSjR7+aGpT3y4gwjvEIj/16GR96VixhEzAX3M3nFG0VeQIw6uE9/PqgdCImPHdNx5COYxadHq3hWDO9BeBS0JgruM8MjtNfd7nkqRlA0mooytmjn3zNaHbqJ93/nKTZUK0nyX0WvQmhv4eo8oQ4ZQYQEvr1Lum2kUA/wuFQAuTragExoX0UI4TYD8bb7QDhZwILKP+KQj4TslJjo2lnGIDRPJnfjR/k4hWUd3zjOuJsdCQLlYtijULEJkK531eACmHDM7yYHK046PFnf00yygMJw7F6+sZ8CGJz2jw3bk7WzG4OcGO5oFdyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j/1aPWwi9PPBtS5KaCaPjmeVtCEN9XuLo18aJ6Dq0k=;
 b=MavmcS82GvfueL58wIaC0pNYKoJ1mPgQdh+KaV+hB7h9dsQDbE7lXJfa6dXiZfiyXnIKB+fxHRNVxfdYsOaiaX8vp5rX6CyxI4wlC5X0bvgiw8qecF9p2hxUP1SjAtIgkW2ao70QXFbW6WieayDaSf0CR1d/jI/StimPbZmTxAA=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Sun, 23 Jun
 2024 05:24:46 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7698.020; Sun, 23 Jun 2024
 05:24:46 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] cpufreq: amd-pstate: Make amd-pstate unit tests depend on
 amd-pstate
Thread-Topic: [PATCH] cpufreq: amd-pstate: Make amd-pstate unit tests depend
 on amd-pstate
Thread-Index: AQHaxO58q/EmsfmnWkmrhb4+4KVgGrHU0QdA
Date: Sun, 23 Jun 2024 05:24:46 +0000
Message-ID:
 <CYYPR12MB865539540050EF90CFABE8DD9CCB2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240622215219.47911-1-mario.limonciello@amd.com>
In-Reply-To: <20240622215219.47911-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=17bcc8e4-e482-480b-9595-c0fc7c9c0726;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-23T05:23:24Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH7PR12MB6417:EE_
x-ms-office365-filtering-correlation-id: 6de83290-49a4-4baf-6e42-08dc9344cbd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RBP715xJiZ4moXG8BGuE2qAXgrM2xl5POw1rrRQezeaTA4R08ZeHBfyjKYV9?=
 =?us-ascii?Q?Ie3Pm9Cp8cRknYVem0v0HkqU4WnlT2TjOuQEVBMAoLUO0t5dHViMIKslOVCa?=
 =?us-ascii?Q?zOvIVC141qyan+Ac5JOvSEx/t2RuDtWlZFAxba4ANHcS7Wr4x9O+TOCkkto8?=
 =?us-ascii?Q?PEGQ0BkAMGV/PdSGlQ+bF1DvyQySlMy6Ef5zL4EQxWHo/I1TLNtBrozhFpBl?=
 =?us-ascii?Q?6IWrsSuXRtkcMrpQyERt0ZrXo9j9Q1tB0Tn6ICtmC1B3DAiRQKRf+t6x0vDo?=
 =?us-ascii?Q?cMjGqg4vKOIb85GdonA2rfxZ5xE1wsDog/if//EnGYrXxthzx2svhvCEGVes?=
 =?us-ascii?Q?Lt8vVGNEBiDIZUsTEea113+DtZfpigio2ucQpUr7sdN4V+rO8T0xhp676M3I?=
 =?us-ascii?Q?JkyAhCWGkQIW+ZtmhBeCtBQT/wOYoQpfVEtq0iUJ6bvEX8o8Nn4OT7EArKqU?=
 =?us-ascii?Q?vMpEpg8vP+o+Jjqy4tUn6OIOaFPtyehQoP6p5vgwTn+rVy5Q+VXCT//3LaEI?=
 =?us-ascii?Q?/31TKCf6SfZlMXumaeMENZ+GeRC+UcAw+AF+xUyUrHSSCtMgYnlxZzRUdBXe?=
 =?us-ascii?Q?EWAuRepxXCo+IvKa9va2f4mxhetaadRSbelMDUFidGZ0v5ip4foC9PcFNpUT?=
 =?us-ascii?Q?FCjSCmylsGEVVxAdSvEdGKs5NbgkUNywGwMADCw0Lz6MIUWtLyOlhNDdag3W?=
 =?us-ascii?Q?XFgF9oV+GJOx572p/5P7WJh+GHrwlTGQhmEqJKNofbGpYw1/YKsDydpOLoZp?=
 =?us-ascii?Q?N8ElRcLU08DhlklJzMku4TqB6ri6sFrXC71HKr9KUGzz+LLkCoobueOjfLxD?=
 =?us-ascii?Q?u+cHrOpUrhfYrHLdXCEiSB82MeMm//WRdTqPiFoe4Pb/WSlmIy9XJKegDUwm?=
 =?us-ascii?Q?ySSqDjwai9EpYwXo4NuB5QWO0JG/5ikLrU/fof04r6WIE0NgDrvBwBJHWvy2?=
 =?us-ascii?Q?ZwvxnpH1MMLVPGPdBXdoP3wz0bCEVcJczUbPkxRWytSEEFUeQbOnsv7AYjS/?=
 =?us-ascii?Q?fIxfzw6uOgo7pWJBDZKM3zzKY1hX9AWbUyKtA65q6Pkve97oQCk5liLdSFqa?=
 =?us-ascii?Q?q63A441zQZo36yofMoUuoTiyES6KwBkMrRoKHB2sVzol741q5RSNvSDnhZkV?=
 =?us-ascii?Q?rknKDuKpne0cDIl1ImtLzicbJgUmNWkCAppny6HeTOuhmZDvhuKD6Bl6wFcN?=
 =?us-ascii?Q?kpcZbdmigtCdccqhAQ2Dtlv0o9IabqYheI1V5vrYvR8gUgSiPPB0HR5H8ZCn?=
 =?us-ascii?Q?kTbAEcU6MkGkxC3WT3KPw5mj1ypiyxkzfyV7wamaxWYEj3aitf1WMcJW13Cw?=
 =?us-ascii?Q?P7zSk2S5RotIT17xp4anwAne?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iAJFcvTdhIgnQspWO4jnehbzYf4QVfTME/+4haFxzYRS3F2eBNaQJvVdZ8cF?=
 =?us-ascii?Q?aZKtRFqkPDe94bzF9EIURsug0dCgFukC84XXF7Z8j/NW3NritXUq1OLOD8hY?=
 =?us-ascii?Q?keqJNl8z0lvuVBlVg105MmRpFavH+mNzuS5DylumJ8fcTpzg9hrIsKvdyrEi?=
 =?us-ascii?Q?aL03uSdfo7nC1pAfvUy1BUyj3nNz7A5rdLA4szMX4ecXNQw1tQAWWZ+S/uPX?=
 =?us-ascii?Q?i78ABroOn6ePdDc/LZoD+QwMl0JCj++/utuC2SnITLZAzVLcIN70CUaWz0bv?=
 =?us-ascii?Q?jPs55wrvyYuNDsDvArMxyk/MvaDLv8Ykaxp4fEP2GxrElTMQmw+2uR6tF/iG?=
 =?us-ascii?Q?HB/JaVJboQtzPpN5MZo/S84RWHifc+oECY/kkYXZ4xcHgzU0QCc28U3kE0Ui?=
 =?us-ascii?Q?RTZbcw1PDw8HBAQe630qLllRlrCbOXG2acWP1ahw3wZYFTDYqKiPWbXZmIVl?=
 =?us-ascii?Q?6XFkg5tpSKKSPzhNizasf/CeYhWUAQQbmruJRptsufF/T0EERUtNsUg8qnC9?=
 =?us-ascii?Q?BCn0lSOwB9Bi+0xgDs4fxGbPel6VCDVYDKwtZBP+QIGUBzYKj8VvYMSd28CX?=
 =?us-ascii?Q?62J5EImIMGAW96q8vKQ95ThTRODLygfsn1vptcBt4Pmvx00iJLK61nIkQsnO?=
 =?us-ascii?Q?c9e1BdxwlndeKwoIiwdCJqkbG0zY0WTn6LALemDgHLlTpJzpvYgljJj8Q5Wu?=
 =?us-ascii?Q?GDYZSmk15bUxqtYWc+K41kY8Py6mmsGF3LAAx7MXQS0YGJiNBxzu2s5+LJSj?=
 =?us-ascii?Q?2NffRo0tPDNVzGQWNHrWe3RLVzUW+GgNUA60PMhw4oF9kXYfWVmZ2N5wg+SD?=
 =?us-ascii?Q?mwskQQsreANcyQiargKaM7lWvnh4yULgsQgt42MymnAnIqgpdGQxt1nfjeQI?=
 =?us-ascii?Q?LN8QWkwCSkUaEZ1h0OYo0/viMUlXLXAW774bpouoyw2Gl3KwmrJvmYvGOuF6?=
 =?us-ascii?Q?hbnPvCv1Xm0oI74upnYnp8409yOBdlH6+y2OzLzEJppp7IS/5kEpmqIX73HQ?=
 =?us-ascii?Q?iLe66H9InQebSbhp1XYO4y3I4tJN/l4SXKIL4hvzvyNhLxm+66AI97GFrf17?=
 =?us-ascii?Q?m7LHV5jhjG3VYNtyA80TVwdnCNr5nolLXCeZKo6js+sswNwc/m43A2t0ddcr?=
 =?us-ascii?Q?yMpjc3ZPlvvXrXxXsAZpPe4ovTx2r1lxfluSNHz4ft3ATAizQsjAEOZeWFGO?=
 =?us-ascii?Q?0u6HjBZ3LvXhmxmUniP1zBZZgKx4vAhFuydOWz/5RLPFWK92RIyvsphmBn1m?=
 =?us-ascii?Q?fB17qDHj4ORondlKCLI71NDxXFkLJCpa68iPi/L4DFObRdsab+s5Jkg8INCJ?=
 =?us-ascii?Q?ZnQzcYlN2gxWwMLODCeEjpxM0CfHlL6ylZFkX+aE44jZDIlpFq0vBwiV6kxk?=
 =?us-ascii?Q?HVmMdSjtyDSlntmigwCFxHLBqUyxKqbf49o48NekqvxDwbkgCgv9sD0DKRrQ?=
 =?us-ascii?Q?+5MgayO9/DWIUyFvhPgu1jX6ZcL+8vOeeQZKl54iNMb0tUI8ha9LS/gpir9l?=
 =?us-ascii?Q?9q27xotGPE4lHwcE70hSih74M57gujBKIu83Y7h8UUseqT8o9d2LnLIYBFpm?=
 =?us-ascii?Q?voDM7N9gUADwq/j1m9k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de83290-49a4-4baf-6e42-08dc9344cbd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2024 05:24:46.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVn33Mr06mYIXVynfASJ2PyzMwsXSuKZTu1ave/Glna3xxPbPxB3FRzaQ5HCO/nYr+EykKC+Kq073dVcI0ZwYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

[Public]

 Hi Mario,

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Sunday, June 23, 2024 5:52 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>
> Cc: Linux PM <linux-pm@vger.kernel.org>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; kernel test robot <lkp@intel.com>
> Subject: [PATCH] cpufreq: amd-pstate: Make amd-pstate unit tests depend
> on amd-pstate
>
> As the unit tests use a symbol from the driver an explicit dependency is
> required.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406222016.R4A2TMs8-
> lkp@intel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/Kconfig.x86 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86 in=
dex
> 438c9e75a04d..97c2d4f15d76 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -71,6 +71,7 @@ config X86_AMD_PSTATE_DEFAULT_MODE  config
> X86_AMD_PSTATE_UT
>       tristate "selftest for AMD Processor P-State driver"
>       depends on X86 && ACPI_PROCESSOR
> +     depends on X86_AMD_PSTATE
>       default n
>       help
>         This kernel module is used for testing. It's safe to say M here.
> --
> 2.43.0

LGTM, thanks for the quick fix.

Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>


