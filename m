Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F322D2C82
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 15:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgLHOCo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 09:02:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:54621 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbgLHOCn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 09:02:43 -0500
IronPort-SDR: QuaIip0xiEYwjsoi+SnL8hE4Yj0v67MI9i59h7iQxGm7rtvEPbFvOMbcbIcNznf0c4l3z2fyuP
 cddWCIdTUesQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153128527"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="153128527"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 06:01:41 -0800
IronPort-SDR: G5iEflhY7QRXpNLwRFBz03AsVdtOe/wu20eN+De2TXz82CH6MQPH5aQWHw4vUe4cPstVJ/C9UV
 ahOsJrRZNdPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="370391673"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2020 06:01:40 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 06:01:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Dec 2020 06:01:40 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Dec 2020 06:01:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naGluxbjrdsCxyhbMyyqtLQpOSnMVrorD4yARuhJ/0hfAsYngAUqbTOLrsUdgVjJjSjJwEPd5u702DeynSQpa5l2tBZEVorDWv5Hc95+nMRyL3+9W1OKlH9fJ+6yexkF735HkFSe4TUl6WS5QMrejzkdYMM48YaJkhPZ/QI9iecowfCIP/Z1HfaZ3D0MFO9J9biFiF+sqinckuG7z49yhBNZRVD1QBxm6GWsg4aoNn+Som5BcqM+gzhu1aNAegX8XrwP6/OYHEIaUDmCG1mtFTHlrUCfRzfngPpTh+MuHGoTUznp0I/Dfloe/fShCDeJ3+s9MIiC0lNJx4WVbUrvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3X//t0boOcCs6t1aZ85q05HekHNhHNNyHV3Zas+MUM=;
 b=i9wkgDgD+qc52d42rkNvTC46aMVUSH65x6V29VNX7TpPgAbigglonkFvbYhHe+7Y9AasR7tdtoOWbeiCOzYypFFiBxzoYpOopPkGeDEUGiEpeHzHOEgduQ90RtJm5HJ6qDNXTXn/fBkAHyxwQZZlmdjwJOtjxRVYq3NHYViYy20uGs+4nEtQxdXxgKL/a4LCQYCbZmVJLAHVPQHMj5b/nWRZJu2OWfFKyi1ds7HFQqZEEHnLzIQE/JdvxZx3IUV1sfF4iFTPpM1Zdu6AVCZJ4fLbS0x0PP5WAEafgH7HTW5aw65uwUVQu8VvlecoUUzb8jeT8a6dZHmExPT2iSZLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3X//t0boOcCs6t1aZ85q05HekHNhHNNyHV3Zas+MUM=;
 b=FtNpwftQbsTTTjguytBv/Zd5zhrOCAd2tQqrPbH6XmNSR1S/yh0sW4hEuNfoR8SMbmwcqSEO7H1teKM9Dw2yiiqvDgp5RmFIuHlfsQzqF1pff3u9X2ypdXqVdayaaC+6DsgXMcoU9LdiP62Xf9/QWv/hq6P3DFRv4fwVkKUU4b4=
Received: from BL0PR11MB3363.namprd11.prod.outlook.com (2603:10b6:208:6f::20)
 by MN2PR11MB4568.namprd11.prod.outlook.com (2603:10b6:208:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 14:01:37 +0000
Received: from BL0PR11MB3363.namprd11.prod.outlook.com
 ([fe80::7531:8870:2397:5597]) by BL0PR11MB3363.namprd11.prod.outlook.com
 ([fe80::7531:8870:2397:5597%6]) with mapi id 15.20.3632.017; Tue, 8 Dec 2020
 14:01:37 +0000
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH -next] thermal: intel_pch_thermal: fix build for ACPI not
 enabled
Thread-Topic: [PATCH -next] thermal: intel_pch_thermal: fix build for ACPI not
 enabled
Thread-Index: AQHWvIrAhqtHiGZqUk+LhiXFqRUHtqntT9NQ
Date:   Tue, 8 Dec 2020 14:01:14 +0000
Message-ID: <BL0PR11MB3363B2218DE16B56C50BAF5CBBCD0@BL0PR11MB3363.namprd11.prod.outlook.com>
References: <20201117023807.8266-1-rdunlap@infradead.org>
In-Reply-To: <20201117023807.8266-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [223.226.103.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc6d479f-0a40-4b24-1059-08d89b81c7b3
x-ms-traffictypediagnostic: MN2PR11MB4568:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4568CBCFDE9A63CB94238776BBCD0@MN2PR11MB4568.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7YTnRWQ6WsWiQdg5bIW9qTycRLzTh+LeKckS+LtLoAY/pVdA7F9/yAUph5S5RKeP71IZ2aJXQFHUET+A0hWKywno0SMyw1YlLmbbCkJlOQPQTNfDDm9ACvOPSG8PgselWVXvWyDDfmwgRfuN4TqbBcrmZB412nZZHKzBO3zhLWNPFQBqfksLvMyz23Ieh2boPXr38vmsCV1ldz8tWoqMRnFrp3lKPEby4RSF4U3Jjsv1xk0TaOPZqDr3NBksb5sq7ZFzHjx6CLAjWHBI6/9ba+ZEYwe5YZ689dfCNo8/5mk2B9uPYaVYP8R95idA+1i120V9eCqzx0mx4ZerHoV5Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(7696005)(33656002)(9686003)(5660300002)(83380400001)(54906003)(8936002)(26005)(2906002)(186003)(66446008)(52536014)(55236004)(110136005)(86362001)(498600001)(6506007)(53546011)(64756008)(6666004)(76116006)(66476007)(71200400001)(8676002)(4326008)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gnB6wiNjluPFg0cnnqvxadKjhuAo7QdibVhWduMiESFrrA7qeVlFhhKVepTV?=
 =?us-ascii?Q?3Cy0M2mWbI4ff4G1kNniysgBZWYTlMlcuzxPrLyN4NI65rpQSEpY0nrtv2Dx?=
 =?us-ascii?Q?Di4fH/NKKVcSXh7M3Elgbr36pwmEzU1r+Ahouz4iW9HLWCjCpHAIJJ63rsSh?=
 =?us-ascii?Q?hz07WFOx9jV65NxE0MvjiRlzaqUy80LW703dD2utj9bONMhwvr2suU1O7mBW?=
 =?us-ascii?Q?4SSD1MH7QQoxJap0u9YPpi/hd7hNWhQKgvr67f3rQ8PBQ0X5z/AdiejUJ372?=
 =?us-ascii?Q?dpOTBkAg9PGj4bEWkjN5JaDUs5yISpookdP+cczs3tICBErrCc8s97vSYzrs?=
 =?us-ascii?Q?OLGbYLW7KXKI6qxogx4xun6r9el8KHBGbr9dHBVjx682w6zTNCTt7WzPuPIW?=
 =?us-ascii?Q?xpOzb3EcGrSPF1gox6VZyKQEEd55vujGivu2ccLlzw764tkRDMvLmRGmlQBo?=
 =?us-ascii?Q?ttDHdYxq4+b+turdwz99g3unZfVJlKhwf4CrPg7mQhfCFNa132SJOsm2aP8i?=
 =?us-ascii?Q?+rV8hEVuSKU6c22ioSo2Vlg78B3TpIJkzUVss32mLZo4XOXbO44wnau8v+Or?=
 =?us-ascii?Q?4pgeLbECiCacbhSzfnBHBkifGEQSZC1spY2wgrkfC5btjGPgB2UcIrqPvOJH?=
 =?us-ascii?Q?MaWsb3tK+gSe8jTc4WgxNabUeypah87OdetXoTpP+5HDk9N4G5bvkyReOswV?=
 =?us-ascii?Q?HWFEhSm6L+TCVQV8cBWIJiv6CFNAskJ7dHElnAuskdF1kAWN2KJWA5/ivXej?=
 =?us-ascii?Q?qQ5TY4x1OxDF/7BeOwM7uOZ78I44Gsm47MF1e+zTXUOVuH/yed+1hAJmWndt?=
 =?us-ascii?Q?uZL49bV8dET71TIMZDNWYtJuv1X/1l+ewBY+GVg2ZWeOAg/2ttDoDJGlNEg9?=
 =?us-ascii?Q?3ebifCi1dbI3mfh41MscCpzGkcBLorBdCqQxlDSeIYW9rxTG2nzcGQ3GrrtT?=
 =?us-ascii?Q?vLFBCfzyOFrsj62Tc4y6A09ERjr1tjcbhe1QLj38oyk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6d479f-0a40-4b24-1059-08d89b81c7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 14:01:14.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pn8K8j8UWcWSWp6557Hd5LYfM0vdZ6mk02r83aF1Anc8o/Vfc8wpdNNObII79ojtSpa8LS2taJJ3d6Jf1Y0GUupjznAnXhx31kFnZbRolqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4568
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Tuesday, November 17, 2020 8:08 AM
> To: linux-kernel@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>; Pawnikar, Sumeet R
> <sumeet.r.pawnikar@intel.com>; Daniel Lezcano <daniel.lezcano@linaro.org>=
;
> Zhang, Rui <rui.zhang@intel.com>; Amit Kucheria <amitk@kernel.org>; linux=
-
> pm@vger.kernel.org
> Subject: [PATCH -next] thermal: intel_pch_thermal: fix build for ACPI not
> enabled
>=20
> The reference to acpi_gbl_FADT causes a build error when ACPI is not enab=
led.
> Fix by making that conditional on CONFIG_ACPI.
>=20

Thanks for finding this issue and fixing it.=20

Acked-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>=20


> ../drivers/thermal/intel/intel_pch_thermal.c: In function 'pch_wpt_suspen=
d':
> ../drivers/thermal/intel/intel_pch_thermal.c:217:8: error: 'acpi_gbl_FADT=
'
> undeclared (first use in this function); did you mean 'acpi_get_type'?
>   if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
>         ^~~~~~~~~~~~~
>=20
> Fixes: ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
> temperature above threshold")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/thermal/intel/intel_pch_thermal.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> --- linux-next-20201116.orig/drivers/thermal/intel/intel_pch_thermal.c
> +++ linux-next-20201116/drivers/thermal/intel/intel_pch_thermal.c
> @@ -214,8 +214,12 @@ static int pch_wpt_suspend(struct pch_th
>  	}
>=20
>  	/* Do not check temperature if it is not a S0ix capable platform */
> +#ifdef CONFIG_ACPI
>  	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
>  		return 0;
> +#else
> +	return 0;
> +#endif
>=20
>  	/* Do not check temperature if it is not s2idle */
>  	if (pm_suspend_via_firmware())
