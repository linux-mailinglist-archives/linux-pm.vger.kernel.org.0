Return-Path: <linux-pm+bounces-18673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7535F9E6699
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4837E1672B8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 05:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB8193078;
	Fri,  6 Dec 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="js7IAl73"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D052C17991;
	Fri,  6 Dec 2024 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733461543; cv=fail; b=Acwn323yqkem2AtRnsfXWnCjdkF4irylULfkAd0C9p3WwBMv13Z+n+MngKqLwHW+xmD9NA8ys9OUqOFUmXaxMK6/D+z81i79q90xa1I/WNpiEg1Va4fmlZ1QdVvlc1vzgn/HttCpyj/eqr1gipaw/MVhXObFCPnAlDFBw3hr/YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733461543; c=relaxed/simple;
	bh=fdhBH87PyP8IfhEbfB9cfRdxXovmrw5ZMVsNSfJkAd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ri98+ic99oIJd5EdXbCrcafOuId5y6AqQ4tNw4I4EU7JvKxygYGtYkNRqMR9lNOCt1LfjgqILrtgTejsH6sye75Y4U6hYLdyNHbwX+My0Kb5R5/69LV74qfBExKmtodjnAStSCDcH65QlHcGifxZQAHuaPQfW986ElIYIwoRDsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=js7IAl73; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9JlXNnRyoqmlv6C4ED5DKCzJtKfsf8tjtca/EGPdSZAtigVUpsYNm34Y14q/YezKt2aoFJVnCXYYomn69/oCNdy000DRjd/cAUg9HAFSV10y3oF/qxOL+spra5isfpQKWFWt1lnvl8L9uVZd5O4w9Hr9w8qY+9ADFZAYqrx4zJQv0yFLCdISKE1wimtdY5ZpAa7rWIZDzn+8XenIzgC5GjbCU8BG0vdv4OxiZFvPqYI256OHwvmYBn4J/H4kkalToAvOYiq9KTJUOsYbytf9kMRwk8iXJS39stsBOBecc7Sb2BKlb/k4QqGbdSRuNy/ILwNMdEpxIVk9C0PCpN2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGSs5sBDbxZqIgtZXJYK1uvdvrd28vzDeUB796uBrSc=;
 b=F46bsz+dT25puHHnOOA48gdFTzMROxdNkCwN9tJfXyUtSpGmVSydbgCgwkVOx8zhKKmJEkUBLGWG4SVnpo0xhde7mDLEP3JX4CidOBO47ZOWUecvG8crzSD7JKLe7tbgDmpcstwP8kEjnt5qX535ISkWxM1NRDfZruTzOkWIQwpzQ0QI4P1Rjlbq2TIGxhJvxLS9+oMcBSzttoh/78e9Hp9eKX0wZ4rXuMqbx70+7rLvnVFawryuTpWQfH88CQaorfrzJB2YWeADWNYIYguZuxeOTc4r+4WKsZYGxHUe6RH1QfjJILc+Ga3r4zQDk4Jaqrj2L+Q6FhylcOMH5FpJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGSs5sBDbxZqIgtZXJYK1uvdvrd28vzDeUB796uBrSc=;
 b=js7IAl731+kxJ7Lj/3vXJ/jqa2zvYBvHgJoA8cDogNRQtDGT8zrbRPdKRkfNO2+QLvYvEJwnTSe5YMm1oRY1vfPgD1iiFlgkl7zH8JhQcl1cK50YsXR5VLEv5+NDzKqmjco6+ntHwEr3rlpl34ymRLcvR2mYVZdiL5B1olhMUf0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 05:05:38 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.8207.014; Fri, 6 Dec 2024
 05:05:38 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>
Subject: RE: [PATCH 01/15] cpufreq/amd-pstate: Add trace event for EPP perf
 updates
Thread-Topic: [PATCH 01/15] cpufreq/amd-pstate: Add trace event for EPP perf
 updates
Thread-Index: AQHbR2UYMqO9DiI+H0uHJI4iq0FzhrLYqScg
Date: Fri, 6 Dec 2024 05:05:38 +0000
Message-ID:
 <CYYPR12MB8655972F2F9698BA604F869E9C312@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-2-mario.limonciello@amd.com>
In-Reply-To: <20241205222847.7889-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0239ce26-61dd-48f3-9033-4ee48da73436;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-06T05:01:55Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB9121:EE_
x-ms-office365-filtering-correlation-id: 5363918e-6c5b-485d-b1f1-08dd15b39fe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tA3cHQ4C4HBlYj1KB8Wk/59J4dfnoBeom35nNvT8N4v6iAp7J6gJdawFc5AA?=
 =?us-ascii?Q?r0aLgEP4LGT3nhB/d9YDOqFkh+eWzScZhzZ9lOnV57WjcfC1YWpWmQoUpAmY?=
 =?us-ascii?Q?iyGg5oOIGdiGlPAr5GTaJ9mU8hZ4S0z2BxKZPLUR8/n4XKncYa/ZrB7ueTXv?=
 =?us-ascii?Q?quXzPo4m8ry32fI+D0d7gDXhRc5YwW0Tb47S8YKQ3xfX3mmj3VXg7SeXbwC1?=
 =?us-ascii?Q?Id07g1QYnVa9DziBPdWxFDyhLLLs1qBDQi11Nkpfy04+bptBpon4Rt4W+aWq?=
 =?us-ascii?Q?PM2Mg/zUMeZhwug+R2ABV7Felxw+DyfU4AInfiwkstnodwg8EsIyBIDCnIdk?=
 =?us-ascii?Q?G0tujvJFD8Nmt/79sesHZIiYMA87jP70TPVxclyJtx3GHau3iP/4awRKKEYG?=
 =?us-ascii?Q?LVW1+i6j2T6ZP3+sff6i0SPKcSwNFl2ku9h0mJwFeBr+XRfqnP25quQygMnd?=
 =?us-ascii?Q?344+eUzZAPbo/WNfHBqtze32dm1HlqE4+Qyvzz9EAc5Z6foqXxu2oCwZ5d23?=
 =?us-ascii?Q?hMNNsUDhTyG9NpieZ6AhDNLS1JUFhKHOy0HXxeqPHiFZzhIelOn6iWuYMhJ5?=
 =?us-ascii?Q?1pQxCTdTEtbA9M2GCTQRvllPyvYaYLXaNgFUBzHVnVRLmfyvvLDROkZnMWFZ?=
 =?us-ascii?Q?SLhYPZZyvT4xcjakIy8iyYBeRgEUYfQwJdFMP2PWnKuCjuqBUurT1xN52rv0?=
 =?us-ascii?Q?beLA/MgyNRJ89lgTOaG/NzEGEO6Y2Xgi8PsMEa2/QfU0Anpw4ZSyQcOMyt8H?=
 =?us-ascii?Q?FJwZhJBNMo5zCudnn0kI4C0x65N8rQxnUybaFYJ+dmZgu4WQrmvFoOYcdxhM?=
 =?us-ascii?Q?2o80qXwmCimD30zzwj/GVKku7W7bkl/7vohwq+Dyi0i0oySSSGzTS4zHisEd?=
 =?us-ascii?Q?ZnftX83REFWXNjAyBbOpA0rCoIa5t4oZPdL9exQiOcM3gszvSoWBYVYpBMnH?=
 =?us-ascii?Q?VCxtKoNyszk3Lz4Q1z4hO1THEw5bfzfmw9x2K1XEqy7Cor3vxZ+Appp/7GAS?=
 =?us-ascii?Q?25lmgXoMdLsYPa8pp3l18mNNukY7uIPbx2IKBkk5oQioF3ULMGVSUWKl+W1K?=
 =?us-ascii?Q?2TSzjxpu6d/CJSw0EqSNIRJqG5lHY2q7gnxkCyXHYPG7rTZdeVrxz/zuZ1xY?=
 =?us-ascii?Q?uO6539wQMvwRcAfMTPL/zPbCVtgY+p1d93me4gpebMymvz7VmLdpjCI+OH5w?=
 =?us-ascii?Q?Du5MlebySWOIOTc59XHMA8U/7XES5aYAicMDaFT3hSI8HAa5GsxlGEttTiw8?=
 =?us-ascii?Q?COepEFzgTKkGXfQ2+ip+Q7rBwybnZQfLcVykKUR3OHzyQKppSCt/4RWHGdAP?=
 =?us-ascii?Q?OfjQT1crOT9awX8xz40LbAgDxP+qX26tuiZU0Y5t0FEOPNmZGJ0Mw231zi68?=
 =?us-ascii?Q?wG+hZtKXwTd+JNyy0VqOC8bsCjdTJT5E/BN6+SKIVb7VmYC7MQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c3tCG0HU+gTp0BXpF0rg0OFRsPD1Fs2u2jOTZLVhhr7/8D9VNmaigorRTEUW?=
 =?us-ascii?Q?neG/vB632UbeFxwArSi3Dg2hVcvlEGiEYAMk92aKLbrUWCIj1JOrSTWU9WP/?=
 =?us-ascii?Q?Y686vhuH1UFhbQbTvQ1kcWIbWg2hdIz40uRJp4r6briAucGz85GQl0YIWnjO?=
 =?us-ascii?Q?5AVytHQFj+oaa4KP/P8XzdBCAl64TqEqoYjvWXnK8o7JfuO2rvD5KjZIELwW?=
 =?us-ascii?Q?JlGB9BfCaDyYkWB+/zHZ3hqkRar3rhonwbiCxqOllLdmJI72ksnkDRikWS5B?=
 =?us-ascii?Q?mepWB+C83gK5ulQDs7znO5qm9/bNP56Oakv4zuqxS/2D4Su9FpiU4PqDHRaD?=
 =?us-ascii?Q?YyARRuyVQgH63H5a9llqouQeThJddePadTkhSkdedX8cOQ8RJSy1AKIagG6/?=
 =?us-ascii?Q?fwXP6hmduc1RT9G9oSXBNoK7NpLOfVwuQDIy/qiabVi73motPfcUcU3g+yod?=
 =?us-ascii?Q?q1eH+6/yo16xwXAJwiBxzIRXG1afTRkAZPy5hPrADSR8PRQbZvy3+6MeHfqj?=
 =?us-ascii?Q?CpmefUnCl8b5bmhquGwD9nNlHgzM1yWdyenNbVEEhkbS02UTqfPPp/1I7hk/?=
 =?us-ascii?Q?y/ZmxATSk/tDog4/LmK6Y6SxSgF57GW5E/N16Yn0p1MdFIvOwGTNLCHumbvB?=
 =?us-ascii?Q?R6oHvpExjXdmtajQecDBT3HBLD/NfwODUKRV+fAdv4zSmsAX0gbziFoyAdgh?=
 =?us-ascii?Q?uN4Sowqci/L1sqku/I4VwxWpVzGV1UldRv3H5igWj/PlYakssm3eE9M1G4Ln?=
 =?us-ascii?Q?iS1c+Gdmgh4/nxFeQ0DMJO1wscg7RsBPbXYWUkhUWU0hPrrnyCaE509yi/ee?=
 =?us-ascii?Q?mGfXWvF3TWMV+3RkF9vH3Av8dGarJ3kz45M/qMQSoI6f9D0XK1SJXBgtoEuJ?=
 =?us-ascii?Q?APUjAreBJanVocQ7VsWi+NNqD9hvAmY+K6ezoz9JFilxT07OK13qSKAe0XDp?=
 =?us-ascii?Q?KiTdUCoX1d4UoMxszPfkwqtaPMSOLnf0CbvGagczk665+x6ztrX09N7DTBwR?=
 =?us-ascii?Q?PhJ25A8PrwzS19IzeUCbZVrlu+8YDei4q2zHxF98JyAcPDQ2Gg8FK8Nsi7R2?=
 =?us-ascii?Q?cGTWjS4OjSY2XX8c5Gdi1n2srEpfDnDj9Xkymz71RiIfwFcOtLdSDuKbhkaW?=
 =?us-ascii?Q?cyv+cWt57rNsdo4quw+EIadUB/mKCf9NAEJyOh5lcLPV7zXBCG6c/zIFUdy2?=
 =?us-ascii?Q?9tL5apaeKJ4nP4daRq2+I6ApgZ7or8KoTPPzB9V4FiFJ0qJhr7Z1E3go49s1?=
 =?us-ascii?Q?IO/93y3X1MWq3deM2/0rZu511VE+kBz1HBrTNrGcuptLp3PQ5bJWTTUgRDYe?=
 =?us-ascii?Q?28wucYOWenbiA7L087xSw4l2JZFQNYS3EfWkT25WnpJOwoBuh3Xoex6GSFCQ?=
 =?us-ascii?Q?tqCv+CWHM/quEosU9M+4bQLeDuwnP+d34eCFLTPfX60RI3hV/qXxHk1QT6ZF?=
 =?us-ascii?Q?w157ZNkILdk2wKW70A0LNT8yb2NaLflokhn3hB9bX1S3WVqNFFc3nJkkmJOs?=
 =?us-ascii?Q?DDgQzvHXqqnqb3NL1wTQq/Dip/UwvBF3HY66Ncgvd8p6JGr6Nc7Zc20rn7Aw?=
 =?us-ascii?Q?T2fOlKtq2V7n9oTKrBg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5363918e-6c5b-485d-b1f1-08dd15b39fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 05:05:38.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZC7+HKQe1qaSsRhRQ2r0H/HK0nW6Qo5dw3CeN86mZ13yM+3HCszZB0AmDY5/8uG7WU/a2bHDm2gkNQ+Mp1Pw8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, December 6, 2024 6:29 AM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; linux-kernel@vger.kernel.org; linux=
-
> pm@vger.kernel.org; Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 01/15] cpufreq/amd-pstate: Add trace event for EPP perf u=
pdates
>
> In "active" mode the most important thing for debugging whether an issue =
is
> hardware or software based is to look at what was the last thing written =
to the CPPC
> request MSR or shared memory region.
>
> The 'amd_pstate_epp_perf' trace event shows the values being written for =
all CPUs.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-trace.h | 45 ++++++++++++++++++++++++++++++
>  drivers/cpufreq/amd-pstate.c       | 28 +++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pst=
ate-trace.h
> index 35f38ae67fb13..e2221a4b6901c 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -88,6 +88,51 @@ TRACE_EVENT(amd_pstate_perf,
>                )
>  );
>
> +TRACE_EVENT(amd_pstate_epp_perf,
> +
> +     TP_PROTO(unsigned int cpu_id,
> +              unsigned int highest_perf,
> +              unsigned int epp,
> +              unsigned int min_perf,
> +              unsigned int max_perf,
> +              bool boost
> +              ),
> +
> +     TP_ARGS(cpu_id,
> +             highest_perf,
> +             epp,
> +             min_perf,
> +             max_perf,
> +             boost),
> +
> +     TP_STRUCT__entry(
> +             __field(unsigned int, cpu_id)
> +             __field(unsigned int, highest_perf)
> +             __field(unsigned int, epp)
> +             __field(unsigned int, min_perf)
> +             __field(unsigned int, max_perf)
> +             __field(bool, boost)
> +             ),
> +
> +     TP_fast_assign(
> +             __entry->cpu_id =3D cpu_id;
> +             __entry->highest_perf =3D highest_perf;
> +             __entry->epp =3D epp;
> +             __entry->min_perf =3D min_perf;
> +             __entry->max_perf =3D max_perf;
> +             __entry->boost =3D boost;
> +             ),
> +
> +     TP_printk("cpu%u: [%u<->%u]/%u, epp=3D%u, boost=3D%u",
> +               (unsigned int)__entry->cpu_id,
> +               (unsigned int)__entry->min_perf,
> +               (unsigned int)__entry->max_perf,
> +               (unsigned int)__entry->highest_perf,
> +               (unsigned int)__entry->epp,
> +               (bool)__entry->boost
> +              )
> +);
> +
>  #endif /* _AMD_PSTATE_TRACE_H */
>
>  /* This part must be outside protection */ diff --git a/drivers/cpufreq/=
amd-pstate.c
> b/drivers/cpufreq/amd-pstate.c index 66fb7aee95d24..4d1da49d345ec 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -324,6 +324,14 @@ static int amd_pstate_set_energy_pref_index(struct
> amd_cpudata *cpudata,
>               return -EBUSY;
>       }
>
> +     if (trace_amd_pstate_epp_perf_enabled()) {
> +             trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_pe=
rf,
> +                                       epp,
> +                                       AMD_CPPC_MIN_PERF(cpudata-
> >cppc_req_cached),
> +                                       AMD_CPPC_MAX_PERF(cpudata-
> >cppc_req_cached),
> +                                       cpudata->boost_state);
> +     }
> +
>       ret =3D amd_pstate_set_epp(cpudata, epp);
>
>       return ret;
> @@ -1596,6 +1604,13 @@ static int amd_pstate_epp_update_limit(struct
> cpufreq_policy *policy)
>
>       WRITE_ONCE(cpudata->cppc_req_cached, value);
>
> +     if (trace_amd_pstate_epp_perf_enabled()) {
> +             trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_pe=
rf,
> epp,
> +                                       cpudata->min_limit_perf,
> +                                       cpudata->max_limit_perf,
> +                                       cpudata->boost_state);
> +     }
> +
>       amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>                              cpudata->max_limit_perf, false);
>
> @@ -1639,6 +1654,13 @@ static void amd_pstate_epp_reenable(struct
> amd_cpudata *cpudata)
>
>       max_perf =3D READ_ONCE(cpudata->highest_perf);
>
> +     if (trace_amd_pstate_epp_perf_enabled()) {
> +             trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_pe=
rf,
> +                                       cpudata->epp_cached,
> +                                       AMD_CPPC_MIN_PERF(cpudata-
> >cppc_req_cached),
> +                                       max_perf, cpudata->boost_state);
> +     }
> +
>       amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
>       amd_pstate_set_epp(cpudata, cpudata->epp_cached);  } @@ -1667,6
> +1689,12 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *=
policy)
>
>       mutex_lock(&amd_pstate_limits_lock);
>
> +     if (trace_amd_pstate_epp_perf_enabled()) {
> +             trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_pe=
rf,
> +
> AMD_CPPC_EPP_BALANCE_POWERSAVE,
> +                                       min_perf, min_perf, cpudata->boos=
t_state);
> +     }
> +
>       amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
>       amd_pstate_set_epp(cpudata,
> AMD_CPPC_EPP_BALANCE_POWERSAVE);
>
> --
> 2.43.0

LGTM

Reviewed-by: Perry Yuan <perry.yuan@amd.com>

