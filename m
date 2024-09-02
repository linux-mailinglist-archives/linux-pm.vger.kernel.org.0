Return-Path: <linux-pm+bounces-13330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F113C968320
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92382846E6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521301C2DB0;
	Mon,  2 Sep 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2FCHNvsc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC61C2DB3;
	Mon,  2 Sep 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269063; cv=fail; b=QD9NAGLB7NvDmvxISbKZApHB1REUoXTNx3E4QuToaS6I5dkP2LuYPTVr6NIvel0CMt+qTo52yn5nYG5/15Het9p6MPFsqsmLThN8FbdMzCB9/ArYPulJhDETOZD/zLxA6EthMGykjk8LBujlKDE0B+Mb3VpLVt9KHlRuClQt86A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269063; c=relaxed/simple;
	bh=aaRNd4Pu/zHRHUA9SqbY4xSpfiznSDml2OUFUyFIGMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r6RnbYj9eqQRqNmEX5VoaPP/vlo9TCB5uKWYRROLU6GiHbgo1CMrKr3JrBOkc9VXXqarDTXx23aVidWYch4T4eFzyBgPyQ9FE0E0e7fIltMbIalYsVfe35nD45uAfo0CkIlHmWQKdR+PN39ZHY7BZq00aJ1a5rZTdbWs2n//Tj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2FCHNvsc; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmaxZNcjmSEDVW7dufYLV2jbbiTwJH9avpCYup9jSuw7TgMdpgtkOW8MD9eLCfoDXsHnoQxTTtV03B7v/vRndeReGVqisDiyIc2+SO/b6zYE/E204HkGOtz8F4ytaclIp/HTOczV3X8MalJCCavecFaD7dt95/iK2ft8rpPXvF09XgnDuUjeG0/yfEoo8TXprWA8XAGWRLoHvguOZv1Jw0BH8CvIusbkq9Z2s/dgdNtbYJnAVl4vqYKE7s8eXMLSwBrgsgkqwRRhPJCKEcH5c1MlBHJIYBUQGP2AwNBBDftwLGUAcx7xMnTXatrI1kdUgqhe9cOOE+mrLDpEyX3bNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHLdMn3mGSSNRCV6JY0+Nfrrffgya1LHYNxE7xS9piI=;
 b=Kd/iTj9yJOfeOtROjDJQgihltkKpxI/yKvYB6Zc7xHKQ8C5YVmX70YF478hi9q+8W92HhTph/AARHf9JNBsvgQ3yBhx1xqjhtzBdjlLD/pnTTT289IIzL9wF9fhK0P1UidJhCmtNGub+0qPxn/+w2Jr5c5g+4VnSMU2i+LDNPzCPTbI0rIHLFrSkmU8X9As2Ur0DJ6kLa1E603GKmYZSIL43tG5YtH+yOmD+anyFNcVkTKfWbsLsFpuxJWJrDaCQ1chLkPUh9mRt+apOVKj1lMoGFVI9s3Vny6ifywkj21A0D3RCitdDf/mhyAZdvaLgFKwwEK8N8hTwOpbcLjmFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHLdMn3mGSSNRCV6JY0+Nfrrffgya1LHYNxE7xS9piI=;
 b=2FCHNvsclgmik4K1eNX/5Hfhd9Z9t+Llbq2WqC8mb9O+wqA8eWBwDF28BiCDJfHxcAA4/wWifVQ5D9clHEZtnYeSGGbUC3QXSSHlKTe2fTMrul0rX8E3aMELEXJuHEkJOisYWso+xVmhNFB7e63koFkWPdIP5D67C3n7biQAQes=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 09:24:19 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 09:24:19 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Mario Limonciello <superm1@kernel.org>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK"
	<linux-pm@vger.kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 2/2] cpufreq/amd-pstate: Catch failures for
 amd_pstate_epp_update_limit()
Thread-Topic: [PATCH 2/2] cpufreq/amd-pstate: Catch failures for
 amd_pstate_epp_update_limit()
Thread-Index: AQHa/CvwQCpdnl1znEaCMrnb99CFmrJEOyEw
Date: Mon, 2 Sep 2024 09:24:19 +0000
Message-ID:
 <CYYPR12MB8655C8DC989CE48DD9E143B49C922@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240901050035.1739935-1-superm1@kernel.org>
 <20240901050035.1739935-3-superm1@kernel.org>
In-Reply-To: <20240901050035.1739935-3-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2b1fb035-44ba-4821-9e82-784e73310b71;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-02T09:23:14Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SN7PR12MB6983:EE_
x-ms-office365-filtering-correlation-id: 2828fc51-5248-41d6-692b-08dccb3105f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j5IECQEzBffoS1/ENWSKe63VIO+VpEDRpN9MoOOnWdl9CegmT36xVCqCzKnl?=
 =?us-ascii?Q?5siwYPZzkiBZjJ/0v0Vq6ZVYBP37khgghGaC0a2X8WHEnrbfdrFjRuzNGqqq?=
 =?us-ascii?Q?lCXA/kHMg9V/qnmhpcPLmvSyLI3mHbdUdXjUKSsTVG6DnP8Cq7SfDJR3Vgsw?=
 =?us-ascii?Q?7laP5LmoCqqYZTgSkw123KBEaaH5JbVD3g71AyC8jm9IE+KxLNCdH56o/UOg?=
 =?us-ascii?Q?Qk5XFuCqb/9Ema86ts5Za8UcJuaKC72yQP0gLqcun64riYqXqg8YR12LYffq?=
 =?us-ascii?Q?xE7LI9ielywdrW/WZsTQd4VYBZdN7jMfRN5YLjv70/SMBFEuR6awLI4UN6bo?=
 =?us-ascii?Q?xkhS54Jcu+B8Hi8lNTabNjS2ZRsgEhbAJHDtjGJJ8S7HWFUaZKaNByvwTFvr?=
 =?us-ascii?Q?GZzfNQAyHlXp0q01a0Xy6r04/NFwCSx6BdzeQH2WphtzevyEAJSeRhIlBnBL?=
 =?us-ascii?Q?9Ehe+lou/ipBNEf5HOFWz5lpKu0Ks8NZORM7Yxd3lNqMeFLjtzaIrUGHoT+g?=
 =?us-ascii?Q?1tFvFRSREd6VOpETJamSciT/LVgIOqcJgN/L4sfHvz8MVo0ND3D90oRTr+aC?=
 =?us-ascii?Q?/x5zxTqK3H4GDaUzM7+sa+iBeZ74NmwDOlOJbs2pVkr4JP9zUhe352IuOQ7L?=
 =?us-ascii?Q?RVCjYNIOQ6FCCJjWfbTtFxtknXJceKkphtW+iWLCMqmtgoh2xYksCqungDUh?=
 =?us-ascii?Q?+s2KG5KduEDnio4mOY0XGErWh92esDDTZVDaCvdjCBuFimXfwf1uA3GFQUAP?=
 =?us-ascii?Q?5lPxg+68p/0HXnO+uvCYAUTtAitqm7qRuApHLF0n1GVoPgswZjLC7nQo7KC+?=
 =?us-ascii?Q?rwZy7dd50mJmF4wVBA2rVPq0ge/lcyqJeVbM4VQa2wAZzAMgUwlMN/e9LrvP?=
 =?us-ascii?Q?h3bNc/spY88vr84tpOTh95aWKyreLlfAOOSau0E2g82KgqVAkxTBKHAJDvaZ?=
 =?us-ascii?Q?LW25XCrDds6FXOMWFgYtuhT0tySrUGDo2MQ6b9HXKw8CPR5Rjs08bIpHj60g?=
 =?us-ascii?Q?sRjN6eqNpH96buwcU4K8pBzxKRLiB+cOh6YmrXlFvHdyuh9eUbDtCfzzRSwW?=
 =?us-ascii?Q?lGvwEQioVbzBzOs2Iyfdi5qSzjUSpU+2ZgFPSmxs38LPd4rR3AXa1EZdpD6Y?=
 =?us-ascii?Q?6lwnxgXTJ6ylZKSUQI5V554K1GIbZ1FnfIgASunjhKVAnwHmGfTzG/9StbJM?=
 =?us-ascii?Q?IVAjdjSHfvjfj5aDGc1PlFswEtsPeL5GsTaQVwSsFlni0DcryjNqktoRufcX?=
 =?us-ascii?Q?nPyLDFa4UPG8ovRG8SB6ugUWlIo+QA3Ma++b2zqxoxmGi+QJ8/rLs2t4sxI5?=
 =?us-ascii?Q?g/OVPxySO6VxA14ykoput3J4LyqKPMijyPnfl2aH/PU9fvKTjg7j3Ph5e8Gk?=
 =?us-ascii?Q?kPOVZd4X/8ANpuqRBhjxRNkwhCuJo8TxNwctu4SoQVAvaSwDPA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P94hzOKCiQidjmGZEsiNxqJ9PG4g4zbln2FASWOBACmS+Y1uR9iuSlue6PwG?=
 =?us-ascii?Q?XcOM4cCaHClzUAZa9fcxzkB/ms4v7lHm6daBHYQI1j6ZP+GFDx5jhxLT4rjb?=
 =?us-ascii?Q?yrR2fgNXStoAnmC+RSNqvMmZ3FaYc34WapOYoQfa0CXhngn5DuJT9xzfTQzN?=
 =?us-ascii?Q?88YEdYxgo/yb9+LyvPLM9L2+XB4NrWaHPwNvNVIMIeYqw1UufciXagqVL28P?=
 =?us-ascii?Q?9fFa8EqNxkUEQAU/STsV5n3C7E4nFjdWIEx5MKTotXlBkmymHTwbv6gLM/9x?=
 =?us-ascii?Q?oG03NH4505iveF//qUE08Rz8Q0cBTpeJKV1yl/abtjuCatLsFOl4EvJtGRGA?=
 =?us-ascii?Q?AF0qsk0CLWWUPfBKFPcWcVyomw76f3oMqWusgfRiWJQG8Eovk6yyfs1sdGcW?=
 =?us-ascii?Q?tFi7vJ6i+wkim/SqdkBQgoT3e6vMHAcNBr8S4ccoSB1+2+bYeYThBxkMqtxj?=
 =?us-ascii?Q?Ru+Yt6e7LGIUKTqVXB59+0JiAoH8Asg3Nh2vC1V9zV4wDduqZWy9gVZB4K8B?=
 =?us-ascii?Q?R1f9RtH+xaub7mkD5btw9km9/61uvNAFzlF6SaiYraDe8bkoaf4QZP0zDYnh?=
 =?us-ascii?Q?lVO8ZuBY4/zeWAPJ349qXQH5q9tdrE4nlZ6h/16isA/Pw9fRQtK4xm6YjQQz?=
 =?us-ascii?Q?x4E5s9KQaMV5QRGStLGjbxvCFxNBZbWjCXlnzMddGcF71E02UkDEqhMbOZLb?=
 =?us-ascii?Q?GO3b5hvsvVGsuKYy3/i0AD9O07O8xVfunb3f0Kk0AOnbEN5lNy35bp4ZHLSu?=
 =?us-ascii?Q?79uzju4bZKQ+AlGDuvSLsBC1mKvVZ4SjSZWNNg1f7d89ksctRdpkRS6teAY7?=
 =?us-ascii?Q?U+pF7ohAjikG7zQKWEL56oAnYYU/qPauJbpkBMF7UNX9Tj5UbZaWgfOd0WPp?=
 =?us-ascii?Q?P0zrTZV3tcQ5Y7rmtE3ix2Ba9o8sPq5e+CErxZctPCX/G1xYyLfNJKzErvzo?=
 =?us-ascii?Q?D1cyH/7KSWhTGtTgHu9EPyeUVFMlHjm1z1d413F/gGEGIQzAaaeH7LcSo33B?=
 =?us-ascii?Q?5bg0eP1cXK2nO1QBdvOvF9vSCu7hhDe6GTquTKPTh8MabTkNXjwi0DlgSilp?=
 =?us-ascii?Q?0iQLURGkCmnR2JrttobTZfjeyz7nincwje9I0Dr4qfa8Nr1jilCy8oDlDmvB?=
 =?us-ascii?Q?Ssxv5QNEb9cPC/PZ1m/on8rTIxq8vb2W2+MBBmNBF8+6sSXXcSeIHG73QXbx?=
 =?us-ascii?Q?NIT7GnLrHyKzomPs+CbeXrM2cCVsUB1C3y+w/moK6NqtU/Cm+8BYflCXb54i?=
 =?us-ascii?Q?UVO9liurGBg13XRKhbuVZ3Q5yxs6vJBTdWfg2EkvkjYFlF6OJj9NOAsEESg9?=
 =?us-ascii?Q?PwUwVlL9l0PDQV3A6oeIyt5elZO87cn8r9aKVfzG0rW4DAtDd1dD3+HrPxlM?=
 =?us-ascii?Q?XYLLaBm7bv1N75CZkIB3B3w3M7rzgfsSL29n/K181aQOqCXRRcxw7Kc1EHoK?=
 =?us-ascii?Q?l3cCp82OFfLdKdmHR/iVjfJgIEI/Cy6lKF5TJuA9nq9R2zDz1Ci0PQ3Ab074?=
 =?us-ascii?Q?+AJfsUTFP1Mq4P/jfp1xShDrPmT/N6cGCodirUjcaWD9muYDSlI1DzKox/cn?=
 =?us-ascii?Q?+kX5rDC/djGp8frnOhU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2828fc51-5248-41d6-692b-08dccb3105f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:24:19.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaQpy24+u+vJmVQf1906wHAMjcU0aNrsApzIlOAeFVdejTdzOXvNQfmnBYGxnjclawWiItRi6TSRZSnNxUackw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Mario Limonciello <superm1@kernel.org>
> Sent: Sunday, September 1, 2024 1:01 PM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Yuan, Perry
> <Perry.Yuan@amd.com>
> Cc: open list:X86 ARCHITECTURE (32-BIT AND 64-BIT) <linux-
> kernel@vger.kernel.org>; open list:CPU FREQUENCY SCALING FRAMEWORK
> <linux-pm@vger.kernel.org>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/2] cpufreq/amd-pstate: Catch failures for
> amd_pstate_epp_update_limit()
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> amd_pstate_set_epp() calls cppc_set_epp_perf() which can fail for a varie=
ty of
> reasons but this is ignored.  Change the return flow to allow failures.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

LGTM,

Reviewed-by: Perry Yuan <perry.yuan@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 89438a3654002..b07be4d945e4d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1556,7 +1556,7 @@ static void amd_pstate_epp_cpu_exit(struct
> cpufreq_policy *policy)
>       pr_debug("CPU %d exiting\n", policy->cpu);  }
>
> -static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
> +static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>       struct amd_cpudata *cpudata =3D policy->driver_data;
>       u32 max_perf, min_perf, min_limit_perf, max_limit_perf; @@ -1606,7
> +1606,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy
> *policy)
>                * This return value can only be negative for shared_memory
>                * systems where EPP register read/write not supported.
>                */
> -             return;
> +             return epp;
>       }
>
>       if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) @@ -
> 1619,12 +1619,13 @@ static void amd_pstate_epp_update_limit(struct
> cpufreq_policy *policy)
>       }
>
>       WRITE_ONCE(cpudata->cppc_req_cached, value);
> -     amd_pstate_set_epp(cpudata, epp);
> +     return amd_pstate_set_epp(cpudata, epp);
>  }
>
>  static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)  {
>       struct amd_cpudata *cpudata =3D policy->driver_data;
> +     int ret;
>
>       if (!policy->cpuinfo.max_freq)
>               return -ENODEV;
> @@ -1634,7 +1635,9 @@ static int amd_pstate_epp_set_policy(struct
> cpufreq_policy *policy)
>
>       cpudata->policy =3D policy->policy;
>
> -     amd_pstate_epp_update_limit(policy);
> +     ret =3D amd_pstate_epp_update_limit(policy);
> +     if (ret)
> +             return ret;
>
>       /*
>        * policy->cur is never updated with the amd_pstate_epp driver, but=
 it
> --
> 2.43.0





