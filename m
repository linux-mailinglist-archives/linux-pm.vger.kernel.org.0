Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966D73D6BF8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 04:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhG0Bv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 21:51:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:40987 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233727AbhG0Bv6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Jul 2021 21:51:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="191948498"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="191948498"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 19:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="664926195"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2021 19:32:25 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 19:32:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 26 Jul 2021 19:32:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 26 Jul 2021 19:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8d84Pmnb5a+jXnPjwUzd98uaaqht+XsMdrGZBy5BsvoqLWReNSXy9hBG42J6kc9gOcqQt6zs34Pjrlan4QOfW1nnAF+GQ+tHWHOtwZmnapRl5BTBSMEo1Vg+Gm7E0xKWuMO36C2yyy21X+giMr+0k7vtoVk2ZUjGwqqBIUEAg01gu8K6kb7/itXm3CqSHl9LNXVaQNN/VnNGF5WqLxKytvn2IYm/iixrnl/0z4MnRreUnN4bEYFErLpsxH7jlh0Hw2V9xERiofMP/RkZxr0Zvm7nIv22Mf1AgSYcRXlSS8NekXLwDzRfGeVeRF5Qhl4EfJHEwmVqflLFINlFOpA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S132wtmGUHy2eIvXdR7casVPl7yQSVdQuXwG3B8YPU8=;
 b=ZJEGDTP/41FakLVEuUTtvGHayGf7RlG0kcTMI+1req0QxGJLksh/32NE9HlBeT5EvcI6C7ilLBv2E8aqZTKep8XcY0YcelrJIPsKUVs5lqQM1kD/ZqlYXDdZYQ1hNzURO0P8J5fb+W9rsjpIQCXZmAZDyhLSIsGWPt9IiCT4wWgFinQpNxQgUh0PE8mzA10e8JgpanvjSAtntSsegrjnfKx2xZtH3Cw/nmQh/GDpRXBO/fZqMGWOH/uh8PVGtUD048hGyrPruwXWdAnLbbhLJPpYzAukYzIAeZjHnJwuP6kbAhZFICXIEWejMHlqN+RmcupQKOEZGMpusxjAHbwo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S132wtmGUHy2eIvXdR7casVPl7yQSVdQuXwG3B8YPU8=;
 b=evzvv6CwhF9/NbOGZjA1X1wn2Kw62hG6PNJdX19ZRL+FTelCD7nDkpz4tTXXYD8wmbw0sm5D66rg5pc04SgG9bUfcUbyiB3U9GvZ9TzYYbdThXWeKyo55l/ilmMl9G8fzhIuJ4/zOAIGNqqIy2qMgh7nQOnngj0Aub/4UNQYd24=
Received: from CH0PR11MB5313.namprd11.prod.outlook.com (2603:10b6:610:bc::15)
 by CH2PR11MB4487.namprd11.prod.outlook.com (2603:10b6:610:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 02:32:23 +0000
Received: from CH0PR11MB5313.namprd11.prod.outlook.com
 ([fe80::b1a0:65a1:5842:2a34]) by CH0PR11MB5313.namprd11.prod.outlook.com
 ([fe80::b1a0:65a1:5842:2a34%6]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 02:32:23 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] thermal: int340x: Use IMOK independently
Thread-Topic: [PATCH] thermal: int340x: Use IMOK independently
Thread-Index: AQHXemD9/VzaPQBMK0OesWFuMqLQxKtWKJCg
Date:   Tue, 27 Jul 2021 02:32:23 +0000
Message-ID: <CH0PR11MB5313739D44B3F79388183DDEF5E99@CH0PR11MB5313.namprd11.prod.outlook.com>
References: <20210716163946.3142-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20210716163946.3142-1-sumeet.r.pawnikar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eec99034-3270-405b-1842-08d950a6c3fe
x-ms-traffictypediagnostic: CH2PR11MB4487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR11MB4487CF054C283FE1B27BE6FBF5E99@CH2PR11MB4487.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5MCWfCEmQbrC9w3qPB3PI5AkHExuZ6QuHX3nB8tX7XTY5J7AJYvuu8+AfiRkz9qUQtOUhDX8FKZYk/nC+MIxejdhvUPE5khOaoRQz7+42naeisQjFmhIE0bSGQ6R/nYOEyYzwSNEx3V30ej8EDf9dzx+Wp3knJZ+dgtDBh8SNDIfykPmTNBEDv1wOzmEqL/xb963mFGs35aR2DLbwKaZynx/ldelABQ5y3+X8GlzAhnNwwIavimzGIchxlI4gkthFqs6V+rBcn+LrOQl3x7vY9Tvbf0UtvL7Apr6T1Z593uJXVCsdQ+puuTrFyfJpGTy8smzSocQ13DPGRmig1CRjZWX3DlDbkJWEPvifWtO1BS/aHfCZ9pZQAdDTMOfl980/tqn7Na+y8LWKk+A+D3g5nFiSTYE00XqBDTjNJA85GN1l/gULzNxcuq6nX247SsiDzU0htkPhI2n1L/U4wh1AQN+Bh+WuucInpjtbhDvnx3/0/sT3ouMfVSwySzrXkMl9gFRvuPlMg0lzwEBn86VhRxfnQI6o8m4ycdBgZHMasX9F0ntMHinKBX8WV8Jl3SDafpXIz7uPK5NniH6AK1AcrDJnDhrqpfYOyjD7a+U53FaRwFcYqQK7jOuPvt0uHBGCRlYmeg6OIuCPvW7sMHPMISJP57gXK5GRRST2mwitz8fsB+C+u4L72I/HHi8O74jg1zKJZjXX0FGVIyhFM3Zbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(86362001)(186003)(55016002)(8676002)(9686003)(83380400001)(8936002)(71200400001)(38100700002)(122000001)(52536014)(33656002)(478600001)(5660300002)(2906002)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(7696005)(6506007)(53546011)(110136005)(316002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6WWhQEEkoLB56/6pYh8KVlinXdGTYplByqZjwUawzKrbkCGqZgeaiIerJcQT?=
 =?us-ascii?Q?HdZ+i6LoO3jxq1uA6nq0zBsAVpjmZN+iPDVjG6UVaHMBr1oGhUdt6W9hMP8j?=
 =?us-ascii?Q?dGNdh7OaBYCvQdBXoY8BiQBr/DmCM+3BgNc3qOHJ1aFRD+fiZz97ngXHZ4IA?=
 =?us-ascii?Q?hjDuf2Zq3AP0KuGUvs/aujP0VfawALqbyHD90wX78J5nlSMQhCbwyI5dxc66?=
 =?us-ascii?Q?Kti8JRukqhDlMuj3QyzXQghT4RoEqbSv4s6gcSYOhK8VhDPTa/rEKKsLQ21n?=
 =?us-ascii?Q?CSO6/IL8gKvfRb0sE6feh6R8juguUG1474xYKmOdHy3TxylZBmn1sw6V7jKo?=
 =?us-ascii?Q?DM4abTKTpZsz6sBjfgTm00dHLwgtYJfUnznLxSetW+v29vQ2x8B03dnZkxpP?=
 =?us-ascii?Q?QRKrJI02SwYct+fPadNTDaSGaMfw3b0qYAmAOXz/lIugRqLEejSJaJB5SdF4?=
 =?us-ascii?Q?MwFBg9uZPxMbZnHSVPfm3wvJ3WirKJ1mu2WT+ggRvsee0x6Z+d/VktXGVd8f?=
 =?us-ascii?Q?+aMA1Z2PA7hsWHqaIgkfTpIUeMv9B39SI7H/TVOyU7Xfibo4ej1L6b+1Zltq?=
 =?us-ascii?Q?E2x8wKxVjT8tekMDmZNNDBPirMp4mSsCAJg4SNjQ92mtffyED1fdvjfwbqEH?=
 =?us-ascii?Q?A1cFgAlT9iVln3KJWCYIGblD+kbioqDjau9njQMoDrYtypnUY+b8DDDQ2mWC?=
 =?us-ascii?Q?i2br+JJ/ZmpytrWWSRTf1bxCw01ZPedJNmh5gOCtICztuqKi07UswAI+wHYC?=
 =?us-ascii?Q?9ehA9beCYm+/XejfsH627OaZR7TZEFEfo81mbOiiDpdxxne3hCIepBQdqrei?=
 =?us-ascii?Q?lfCsV8KKSp23IAWi5KBqNmGtre2I5ngoKL5KawBUKWW+VQcwqKGPqUHt9E3v?=
 =?us-ascii?Q?1YRpsxKxjHlyLCvUnGa9P/dpJwFxtjzG+GkB6IZ2PPmHkUgcxA4/lcz3iPjJ?=
 =?us-ascii?Q?3N/pf32m4+NRW08x/EgwwS/vnd/1jdiTYBhP/lPn9bC6Bqh/oA96N4aKE4c1?=
 =?us-ascii?Q?vv488rRH/WsvKu03hZeBrrbntlME+9hIlobeIu/+SVxb0TTBbz3tFCA6dS8X?=
 =?us-ascii?Q?JbKKM4JdESse98rndbeFPQw0VeCKjUH/wYIfUvMrppjtc3MdcNrcdXwf+Rxk?=
 =?us-ascii?Q?DEIqTg64bzmaCI8ExgyFFIwxen3OXeIk9qsRX/WY/W6BccQEnQo6YbYQ5Vuy?=
 =?us-ascii?Q?Nt0qHlYd0mzhMegR2lV3L1i5eGKowngibOgIWHidm8KZmNlbo3BwYAQy3bWH?=
 =?us-ascii?Q?oehZpsUcgOGREGJFzbRslLouPUFHHPbqfZH/K9W+OtunZRZifo+jIxKuABdp?=
 =?us-ascii?Q?gYDdmxC6puM2yucKyo9SOpes8Y66g43Q+3wNXtEsGvheza6sRgosOwLsWHRA?=
 =?us-ascii?Q?3DpdCNUFg6xlQUeq68H52Adzf5bf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec99034-3270-405b-1842-08d950a6c3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 02:32:23.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WlUgLGJYD9DvNSXa/K4/kd4PV2jjnafO/K3PhpM9Zov8iQ/4KPejTnGLr13sgE16E8OMmhHY+oXJyPM3YfV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4487
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Pawnikar, Sumeet R <sumeet.r.pawnikar@intel.com>
> Sent: Saturday, July 17, 2021 12:40 AM
> To: Zhang, Rui <rui.zhang@intel.com>; srinivas.pandruvada@linux.intel.com=
;
> daniel.lezcano@linaro.org; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Pawnikar, Sumeet R <sumeet.r.pawnikar@intel.com>
> Subject: [PATCH] thermal: int340x: Use IMOK independently
> Importance: High
>=20
> Some chrome platform requires IMOK method in coreboot. But these
> platforms don't use GDDV data vault in coreboot. As per current code flow=
,
> to enable and use IMOK only, we need to have GDDV support as well in
> coreboot. This patch removes the dependency for IMOK from GDDV to
> enable and use IMOK independently.
>=20
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

Thanks,
Rui

> ---
>  .../intel/int340x_thermal/int3400_thermal.c        | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 823354a1a91a..19926beeb3b7 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -108,9 +108,12 @@ static struct attribute *imok_attr[] =3D {
>  	NULL
>  };
>=20
> +static const struct attribute_group imok_attribute_group =3D {
> +	.attrs =3D imok_attr,
> +};
> +
>  static const struct attribute_group data_attribute_group =3D {
>  	.bin_attrs =3D data_attributes,
> -	.attrs =3D imok_attr,
>  };
>=20
>  static ssize_t available_uuids_show(struct device *dev, @@ -522,6 +525,1=
2
> @@ static int int3400_thermal_probe(struct platform_device *pdev)
>  	if (result)
>  		goto free_rel_misc;
>=20
> +	if (acpi_has_method(priv->adev->handle, "IMOK")) {
> +		result =3D sysfs_create_group(&pdev->dev.kobj,
> &imok_attribute_group);
> +		if (result)
> +			goto free_imok;
> +	}
> +
>  	if (priv->data_vault) {
>  		result =3D sysfs_create_group(&pdev->dev.kobj,
>  					    &data_attribute_group);
> @@ -545,6 +554,8 @@ static int int3400_thermal_probe(struct
> platform_device *pdev)
>  	}
>  free_uuid:
>  	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
> +free_imok:
> +	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
>  free_rel_misc:
>  	if (!priv->rel_misc_dev_res)
>  		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
> @@ -573,6 +584,7 @@ static int int3400_thermal_remove(struct
> platform_device *pdev)
>  	if (priv->data_vault)
>  		sysfs_remove_group(&pdev->dev.kobj,
> &data_attribute_group);
>  	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
> +	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
>  	thermal_zone_device_unregister(priv->thermal);
>  	kfree(priv->data_vault);
>  	kfree(priv->trts);
> --
> 2.17.1

