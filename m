Return-Path: <linux-pm+bounces-7892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88B8C72D2
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 10:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823FE283EF7
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCDD134742;
	Thu, 16 May 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tAlw/lTu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F08135A6E;
	Thu, 16 May 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848090; cv=fail; b=GtOVDqvgSdOXoNTiBU/FnTlKehklaIqMtqEPHgxJI5RkHyIGAZCWWx+rQNXCXHN8sCORdBFi+zkjfwGKthaljc5EJhQkvGem5M+FzN/tgNuV17iynyjLgexwSlfWY//Bippa6JcRWTUYewwhinZnfuWfiHtqanFWXoiTVNISMgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848090; c=relaxed/simple;
	bh=NyO7wvFC2EU1hQxK7+1Bk3YUdGd/WlTiVE6ggAnojFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=il4CnE/3gDoSviwb8a5ynVZWIiu/domo6lAH7LVnqGs4Uf3qW9gEn7elvKqoYBqIjs+dDZ8CDAgJ/UPuGf7iOJbCSOOrM5LFplTCnEaJ5OdC+r7g/viX8N74YwS3Q9UP7mvs9ajhEsw9//1hdw/fOW9QKRUBc5dWnnIjQRheUm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tAlw/lTu; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmGtpaKrJmVirgPlZSZnSrXw6eZWe1NvKIegMW+AacGdiauMaMJm7sC/RfpHNU7U56MFVnVA0mxMg2jzQamG/uiBR5+tjBKsZrwPHQNCk9r5aE/2Yqrocp9R8D3Z4WDhVzEVf6ltqWpi5QCxx43Y/Cv+/Vr6meM5y6pmxx0toqCHaB06698bWmpJV8QpGzrMLJWwjQZ6LTZM+/0nWis8+U7dOt16ucuSx3PfwmEdiukwKW8QKJfoG0ZVUVq+WkY2sthp1BlTYTOlTN1FHR+p8G5jMEn5uBpwRHh/E5p/JiQ7vu9M/qiWx/569yVp20E+85aaX101b8mtrNsT+2L0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7Fu+tU5Pt9PnhwDSVrKMUpY5OTWe+nRtuogto8/wOo=;
 b=GFEwNNpy98UTMf3fT+h9YB6czPPcALj6RGzdB5HyrB37SMDL4u2X/dJPRWhcXlh2vayUAJ6fK9NPtvXIGWnsvwhQ48phQC1j/AmQsikrA97Q7ZgCVhEHbGqC/FZ3XOifyf3SC4pEemw5Zt3ZXKJk7LTW2NWw21t8FHTxKtLeugtTmD83VO+hXlRnHDDIdprQ+1U9gY4icCG5HXU1LGCz/xYL+fMYbi7IHiOqYFo18JOA8GWG9srK+eX2s1isZwxxGH4nsjoCoMQInt2j5oWt1CQeF65GFF38uUGNttYNCdcZ2eM7wTmwCK1nMsmHt0fJ4QQTD6BLy/5tRjCCr4QypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7Fu+tU5Pt9PnhwDSVrKMUpY5OTWe+nRtuogto8/wOo=;
 b=tAlw/lTu0pVhL1aPiuKofbyX6f1Cj1asUlZ7hgRRZdgTpp5eHEpgGfd12OgItF3Mqeo1r6ce0D/pFL74QMHDsDjo3g64L7dwd9XgDqx+qfsWYoz6JKo2vdYdc/QknW4BdbQ44Q6R6yWjWNlJJBXTR69jcS8aTKVuiw85+2dVJvg=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 08:28:06 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 08:28:06 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "zhida312@outlook.com" <zhida312@outlook.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: Peng Ma <andypma@tencent.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] cpufreq: amd-pstate: fix the memory to free after epp
 exist
Thread-Topic: [PATCH v4] cpufreq: amd-pstate: fix the memory to free after epp
 exist
Thread-Index: AQHap1qvGXuCaEUBIUasGUJvhQIt37GZhtuw
Date: Thu, 16 May 2024 08:28:06 +0000
Message-ID:
 <CYYPR12MB86551771F1670A5F9EAC47859CED2@CYYPR12MB8655.namprd12.prod.outlook.com>
References:
 <PUZPR01MB5120A03DFF0EA1CE70E7334E92ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <PUZPR01MB5120A03DFF0EA1CE70E7334E92ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b373d80b-64e5-4a0a-8ea3-79a498f9ee7c;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-16T08:26:42Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SN7PR12MB7936:EE_
x-ms-office365-filtering-correlation-id: 9fb43a62-2411-4ffe-c968-08dc75821c9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YP6WZMw2XaSs3hdsukfYhYhwySpiJG1gboWSAbfyRJuXi/dDPXqnJZqxjNEp?=
 =?us-ascii?Q?bTby1oJ31PcWVEchNxdWJv8Rt2uePGQrGBt2MX2VaJN4FBe4AACSfYl9iUra?=
 =?us-ascii?Q?hfaW9wHwsk0WlA1IH2OD4b2ukeS/x0Bm9TLyaiX6idhFkmVjWZjNNCVvvcjv?=
 =?us-ascii?Q?syiB2I4gcSlxtyxVjSzCkM6CXslL+UL//APC24jmscpcPX+K8lE9HJR5S9Mm?=
 =?us-ascii?Q?zExrk4jGNIsC2wZPF+Jenm1P5pIJaGT6hTn4gWtgPCZhn59VjrlM3i4IlkUx?=
 =?us-ascii?Q?TrsnGDzj6BQhtDf7ka+BUzfwN52nKu0LHo7qcvr97zjzSpXT2YGMxwxmYaaK?=
 =?us-ascii?Q?TYOyMl0Vac5zcSej37oukC53mnwFk4OZJn7tQDhgjBubCG8MT5F/MIhr0B7B?=
 =?us-ascii?Q?XheRIpJ2tAtyg0OckDv6zHDF8VHoSov9OvN1imHKLMP9vF719RFUaa71xI7G?=
 =?us-ascii?Q?Gdj4wiyhVyKD+2aAA4KRBrBUCyNY766Q5N4iSMylJELyl0lWyxLlxMk+9fJu?=
 =?us-ascii?Q?8WdhgscObyJPgOXjXbnDCWz+ofP0fdTSiwTGhmbkjQtTTJnPmxsY+Mkt2bIx?=
 =?us-ascii?Q?2SNrjHfegNIgc/d8L1uRklul7fp8a0qj2i3KS/9RPFG09L/MqO0U/pR160PJ?=
 =?us-ascii?Q?asGxyeOiDgwrW4Z2hleWu50/TiZPSHU71SjC7NCsN/QiyVrjZYgUdoRYNLh/?=
 =?us-ascii?Q?d194I4D2nwPBslsrXb4GCiubLY+ZTuuRY7UKcsWG20CHdoxjeWQ093jauUlk?=
 =?us-ascii?Q?VMh3LjljUN3kQBhR315IkMX/L609aYvLTU7PvPiE8M5JyN4fbEbRW0YoM+1r?=
 =?us-ascii?Q?tzrAvpli5rcS7IfzmuY6vEFr0HnXp92igkJgNEAqSDcEDKGkuTJtD0uZY+ur?=
 =?us-ascii?Q?Eig9Kdn1tgBPh0JCdjuGMNoNjzfxoN6+TO24NrSQ9/pKyNUKHzR0dN2LznhG?=
 =?us-ascii?Q?g/I77+nZISTj4y8zAWZZROXAk3LBESpddboiiYprgSGugFXwq5PMtCi0GXd+?=
 =?us-ascii?Q?3Xs1bwPL75hYaJoEszgPWlvXWG1IaYHWSufD82ICWc++6M0Cz/TdLoEUQxbL?=
 =?us-ascii?Q?L4Kvrp8PMnN6I7EifU4IiUdcdyH9rf/sVSZrzEQB0f/WPmtEKHtfA/oHiB5L?=
 =?us-ascii?Q?rAcwr7/CfcEjRu5DmIfcnkBpqpgi8vI20WtnXhix4dJycEpztw+0EDLOUWSo?=
 =?us-ascii?Q?I0uElz0gIJD3gucgOE37a/uMPRWnmrPugN0+KbkHkf2CT+MtwK/ec4wFQH6T?=
 =?us-ascii?Q?xM9R1/W12RhDm4lPv3ONjU8x6Hz9aoOe0hgcUcLIY+gzGaYmZMh72dd8IDT9?=
 =?us-ascii?Q?4Hu8bkFbJnYlISB4g++Ke1el6PrYBB2GC2uPrHgsQvwkJg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bpi9rJwIYQxiE+fHvD5pX/ep4UGZGHi/SxsUu1VUuMi+gliOBC6Kw17GYaV7?=
 =?us-ascii?Q?GyDqS3EgKXGF0TUGKYrFQC9SBtQ/E1Hh+tPQP7Lw6WUW5Slf/rVx4FraEeNq?=
 =?us-ascii?Q?tLRQGCri/cbLdJcFcfKHBHV+XHN5aFijcgA/djRdgzEzxRiz8Rx/E0mVPZIK?=
 =?us-ascii?Q?0c07cmHju4RCCtPQ/LxVbVD0htqz4PIais2Ksy+wmbb82poUPKgzZdI59yz5?=
 =?us-ascii?Q?13p6N+MmoxmS14u/hzKR9egKninmhuyE2dEQBbs8gngJlrtGfjjnvAWulmsO?=
 =?us-ascii?Q?7R6wpUGm9F1cHIuJKWmF/zryewB5YNCBt/SOofsgmfg2hHUaUbLukVbViHS9?=
 =?us-ascii?Q?nsVAYxAIRDGRa03EBiYu9BrIlQa1FB4QP4XNfyoYs0grtpRSPd9AaA9xCsVx?=
 =?us-ascii?Q?rUq6MnKL6dCMCJMy5r0iwaT06uW5OW8+0299gyKWpUKAjqPeDjqwVghLD93V?=
 =?us-ascii?Q?wBKJ9KzPv3TB9uJKin+uuOBMbNDUqJopVtVKyg/VmbxTIiEsTajNBDJ6CAZf?=
 =?us-ascii?Q?seQ951a6Dt/DprBR4NaQARMwnL7XFO7jPBnfK1d5ihHxzRnuhRt76qpJd8XV?=
 =?us-ascii?Q?ViWl68xndGwj+HBHO4pcQo66SRZ2c53pjwgATwM8QZ3XrNUk0NiqRX/qfYtq?=
 =?us-ascii?Q?N1/75PRPoJZ7ZMa+/qbYKI9kbaRHqnTMX6mEg2YrWYML//azdhFywjJYEenc?=
 =?us-ascii?Q?SFHfNFU/frFLXEzmf8ljbpe7hZy0Oly6sc/KZbn07gGWiLseYbbGUjYa5+zC?=
 =?us-ascii?Q?TlFVqlA9apIQtcA6PzW7Helvu4jz3r58PvKqz2iYkFyp/RJ4HFk6a+m0P9mZ?=
 =?us-ascii?Q?1QU3PznZxPaZlsAcHGezAaXFL6ULt5KUeBVooENRCX0BEvG7yWN3sgdYvIiZ?=
 =?us-ascii?Q?SKBvFEGnnrqXJRQbsHzhh0M6cUqBGEz9Yy8w7xsQQGvDP8w68rZWAoVqHbwP?=
 =?us-ascii?Q?d4WUe16/zgH/4iVZrzjri9whUqcrAsp2lufhmJ3m35tm19oRZDakn/ZKS9pw?=
 =?us-ascii?Q?19ETFEBD9w1bfiORCzZdRbrOAwucx9NbO92HrsU5UoKVrHFoZJvmIaGFs6Rt?=
 =?us-ascii?Q?Y3yR7HDd5Xdoxm+8OVrGj+Nl3HFX3Lfkh9g1ri8NwS4vji2JeZZex74n3AKb?=
 =?us-ascii?Q?58CFuuGFLS2SX+hSHW8RXRhUTah31/MTdJVPwGdYt2fZRnG43QhRCx2NIETE?=
 =?us-ascii?Q?9TJNwjnuCGlRViaSODmto9bPRRfe31wam2fZwvUHU3ngbanuk4Az4SpgnAFm?=
 =?us-ascii?Q?uA6I7CbVXeWXuCz+VMJGR5xUUmrqDZEtch/18PXVrsCr6wZEAe9YlKnFAzHM?=
 =?us-ascii?Q?+pXfP8guhPI7CP4aqUOWW8aON3s2nBy72ycJZTyXyttpPkrvVE6KF+dFYG8H?=
 =?us-ascii?Q?LlfetgHWPW8f2HJ66HYPQ3BUPcEnJ7zenja/uustCTcjs1dgTJpUUo2zuJAn?=
 =?us-ascii?Q?8IyZBTf2oWkmgDs6tXjYzWj1Xr7mn/rfPQz/4zqA2wCJa4Xgz1wW7evb9Wzw?=
 =?us-ascii?Q?7NBG1lOIjqQ43b0v6tHich110wkgKCDYtwEGKW4YMrzXxktzB2e6nIOL8olI?=
 =?us-ascii?Q?WoJ7oJGq+uAEqeGxjd4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb43a62-2411-4ffe-c968-08dc75821c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 08:28:06.5752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JYgam9pVE2UzAHIO6+sMioI+b/bnNyRTjHmNbYs3pscZu6Rpq09507qY+uebY/B/X8DyJicvMoLkjzbqc8pLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: zhida312@outlook.com <zhida312@outlook.com>
> Sent: Thursday, May 16, 2024 2:31 PM
> To: rafael@kernel.org; viresh.kumar@linaro.org
> Cc: Peng Ma <andypma@tencent.com>; Huang, Ray <Ray.Huang@amd.com>;
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v4] cpufreq: amd-pstate: fix the memory to free after epp
> exist
>
> From: andypma <andypma.tencent.com>
>
> the cpudata memory from kzmalloc in epp init function is not free after e=
pp
> exist, so we should free it.
>
> Signed-off-by: Peng Ma <andypma@tencent.com>
>
> Changes from v3 to v4:
>       update subject used git command "git format-patch -1 -v x"
>
> Changes from v2 to v3:
>       update Signed-off-by to Peng Ma <andypma@tencent.com>.
>       set a space between if and "(".
>
> Changes from v1 to v2:
>       check whether it is empty before releasing
>       set driver_data is NULL after free
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6a342b0c0140..1b7e82a0ad2e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>
>  static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)  {
> +     struct amd_cpudata *cpudata =3D policy->driver_data;
> +
> +     if (cpudata) {
> +             kfree(cpudata);
> +             policy->driver_data =3D NULL;
> +     }
> +
>       pr_debug("CPU %d exiting\n", policy->cpu);
>       return 0;
>  }
> --
> 2.41.0

Looks good now

Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>

Thanks

Regards.
Perry

