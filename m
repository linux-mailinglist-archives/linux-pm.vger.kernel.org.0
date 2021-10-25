Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1343A55C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 22:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhJYVB7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 17:01:59 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:57827
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231451AbhJYVBw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Oct 2021 17:01:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5sw3eTKFfYmq+HEh8qZe6ufdCWNzAdDFbzMKNXsG9sAPLJXL4xNAlbmXFnhXEUJe6JNqrGZv03D57Evg6knQpyjwY2pj80+yX1QxlVP7NkNXPA3vUYhe7WoqCl5bIfrCW/wZqzUDMdMtaNLoybdNBS11yrMc6zfpdPkE0dR3Bvk9nXcFWeC+7EcprKStAcPcG3ZrLsN+BjpFtFrTSiWh1bEPSO4g02EgZxsBQ87te5UyJIZnVvYXEzyY4ZDb802I/3pf4lAa7XHALN+z4wCon7hkkaq46clf5HyVr2eUrHd9gx+P7cZizXP8OtGIPbYevirMLT2+XJkjCoTZAUiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcg5hJslj6TSiCUclBdMKEz6kbkLoxkbEWrqJDsu+9Q=;
 b=gngbwnfABbTGM0VdK59C7uwo3Tg1QXO3fjnRLfZwAP4uj0NeEw/OMEFr2S7DCJBT8c4myPfaS68Tw5o/hr3hoFBPBCr/PXAgxROn3MRE6ZxLVE4hxC9kIPl3WI/LzInrulMQ5eDXy8J+b+TShxOoJZYL0j16jGuXoktgbaTC3WQjbMDqxFqXStFJIlHNpViealYC8xff9AW3txsDGyCb6ZZ5NNtw3dF+miJJicumLRK48K4Yu8nLLpVIPHH43fK+PpQ78V13rnlcLOo1XmfAl+vTnnCVIfwe9fVV982NUTfUiPEu1j1AS5uCXTddvQUetXORFiDy0PCP9PEBugfbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcg5hJslj6TSiCUclBdMKEz6kbkLoxkbEWrqJDsu+9Q=;
 b=A8YVIS0WIsNnLsqJQjf8QQxDaWofJ0OdNGStoNt3BxRTOnuo87ZiLDkdKIj/zy6jJUxAq6yu+pHkc5xpYqU1bnwNuLCF+Eoim5Q1vYi6HJGU8rJ5N/MPs24hV9YLnE1cVruP8DVR9ixEClEFzRNu/ZVCrQNkVD1DcuzG5DA04H8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB2800.eurprd04.prod.outlook.com (2603:10a6:800:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 20:59:21 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::885c:ddee:c614:9787]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::885c:ddee:c614:9787%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 20:59:21 +0000
Date:   Mon, 25 Oct 2021 23:59:19 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 06/19] devfreq: imx8m-ddrc: Add late system sleep PM ops
Message-ID: <YXcapw5rxzkSZ0i3@ryzen>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
 <1631554694-9599-7-git-send-email-abel.vesa@nxp.com>
 <dbb4f5a5-e303-7df2-9d42-819a4abac98b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbb4f5a5-e303-7df2-9d42-819a4abac98b@gmail.com>
X-ClientProxiedBy: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (188.26.41.202) by VI1PR09CA0116.eurprd09.prod.outlook.com (2603:10a6:803:78::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 20:59:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9735d69b-2e03-4471-1966-08d997fa5114
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2800:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB28009176DB349130975B425EF6839@VI1PR0402MB2800.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJYxzA1TMGRWgjYE+rZIt1pC34gRSOqej8z3trpUpki92xo3FdOWCt5vARIKnbXWTpsyFAuSST8+L/gTLoqygDtwIQixDgtPG0Damg08Ku3HVG1gOZwn+OTk5wnXz5QOwrtqW5Aybp125mcfEgsmh5eudhqxmSkQlVYlUduRo+hNLK6Et+rSpYvSw09S62BKDZKU9Wt6Cj7cQ3NlW1wEirYNuIMNba4i3RZ0iwrF+07udUH1/KAv6xw+Vei/c2ZB2kO/brCpLQNym9cWDx7VnnmDDGyCeKWRHpOyLoLPoaR293w1F4aegvCCn8stSvnvHnnJeYYpu3Uy8tAaaEtG/HHwIkJ4bgwOJjYI4FmRZ8WADT5xskLZ7aY923nvk5yjKV4FJl959KPa7y7XPy1qxuU2KFw/MeBreX1r7vJW8dRZqsSAJXOfh6tIl940Y9gG7gjtFDxRHTlJP7x0IRFHGDfNtSX5RqKahfN/6zskitkI7Pm5vey90Pxyfn3oi16dT6djBuhce1J6uI2GETa6624Gl/0/6t9ylXAxlkZG4TsEn8HG0s2wtlG0IteibcOCGnSKhaze8mZ7rFOUk8hTDz1jaMQJ5anjuMKETgGypcKhJJvwD9ynK8WQYSTamALAP99sI8wdx/nGCiID+EG+xTo8VxH6TzXe8JOOLpg8qgyc2jyAm6LvjTu0kz1KMlMH2gcGfGpkA2dIW4mEWMb6IOwMvBzupDJfVexutKYSrCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9576002)(6916009)(4326008)(54906003)(52116002)(86362001)(38350700002)(38100700002)(956004)(9686003)(55016002)(26005)(316002)(66946007)(53546011)(7416002)(8676002)(44832011)(33716001)(186003)(508600001)(66476007)(66556008)(6496006)(2906002)(83380400001)(5660300002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdoRmMrcjMrYmNpUCsrOHdUMkNVaDBncUhCTzVVbzdBQkpOS21xVEVzZzF4?=
 =?utf-8?B?dGUyaHNOVjlYRFJnTDF5M1h3MjNtUExMbGU4VDI4RjNRSVpwd1dOOHR2YnlX?=
 =?utf-8?B?QnpIblcxNVVxalM3SXhQNmdkZzF4VCsvVjUvbWJkWHhkNU5vbGlHRzM0aDJS?=
 =?utf-8?B?bS9BZkF6U1Z4TzZYb1FOMUhIUzBrQkNZL2dQSldNa092U1ZFMzUxRjNvM1N2?=
 =?utf-8?B?emx2OUtTek9KZUlLK2QrSlJCV0RiTXA3SmxZclRYc3loSjZaOWwzcUxBRVRv?=
 =?utf-8?B?QWd1UWJGNTdHUFB1Rmo2NkEzWDN6c0thaHFDVWkveEduOUs4RUtzczdCTW1M?=
 =?utf-8?B?Y1lpV2lhKytFZENIMmJXK0owcjF5dmF3ck9mZHJmcFI5N3ZtWGhWdVlFTWZx?=
 =?utf-8?B?OHJ2SGlmaDdNclBrTzBYTXdRbW4xaFkyNENmRHoyalJ1QXo0Wno0MGZjdmNn?=
 =?utf-8?B?NWF5Um5DMjVDaGpIWlVRK0NjTmVCYTZocHJ1ZU5hWVFKY1V1QmY3ZFk3ODdN?=
 =?utf-8?B?U0gzQUdOTjRDLzl5eGx4RXV6SE9RSWg5bXRmZi95eDd4MWN1RDZudUZIQnJr?=
 =?utf-8?B?V2RYTWZrM2ZvcDcrWGVERGk2SUlLZllkQzg3TzZibDV3d0J2WFlMeU1kcEY4?=
 =?utf-8?B?Mm9ES1NRTGloT3VMTVQ4dEt4bllGandrS0FpU3ovVFEwWDZocGsrRVBTMHlx?=
 =?utf-8?B?L0FpczBnMlBvWXhwZGkzZk00cE1EYXhHeXhtK3QwUTAvTWY3cmFZMTB6Vkpi?=
 =?utf-8?B?SHZ2WldsanIxYzZBODNvU2duU1k5TUJhbVVkMTR1UUdBa1lqa2dYL0pUSUNk?=
 =?utf-8?B?aW1hdURSdmtRcmhRRGRUWXdHdzNTd1MrcG9pdjhzblhONnVVZXZlRXF2OVFv?=
 =?utf-8?B?clIyVjBqN1NHQlhDVXNqODZXMnF3cDR0WXF2Z1M4Y0MrU2ZLM24xTHQvWjdw?=
 =?utf-8?B?S2thMVMxSEs1Y1JFMy85SHM4N0lTbWJuYTFoaVh4Tm9abE55NDFIdEpWWjVt?=
 =?utf-8?B?V0svSWgyYlRnUnVMTG9YSHFJVWY5QzRtNmlsbmxqQjBJdnRtMkxYYklraWZ1?=
 =?utf-8?B?b1FNZzB4bnphOTFzSEMyb0JreXI2UkEzRXdxVkgxN2pkVTNONTByUUdWbU9O?=
 =?utf-8?B?TGUwMlJCRFFIemdmdi9vdTlmMVRNa2hiRXJQU3B4emlrMS9rYXluWldqSDhC?=
 =?utf-8?B?d0RwR0hNTlB1UWNxRytmZjE2UE5JOWZIa2JrdWhnMXg3bUllSVhVUjU2Q0p5?=
 =?utf-8?B?dTQ5VzZOYlF2aEdtZ0wxcDJldUpCVDJrOFhORmdGdzNqaE5kbEZmTVRuOVZr?=
 =?utf-8?B?cjNaUjMvNGZ1aFE2SnhSeDRUNTc2bmxRK3hjWVZDaWV2MDRCTStFeXNhNlBB?=
 =?utf-8?B?YWhRdFV1YVlGaElaWWZxMU5KWm53dXhnRlM2RVpJMEZIejlGNXBLZERVTlVE?=
 =?utf-8?B?eEFsZWVIUnFacnhscktIRlBVZEdXM2JIRzJGdGV6RFNUOVAzSm5BTTJxZks5?=
 =?utf-8?B?b3hMVkZHbndzMDNrdnc0TTZkWFNvVmhUeU9yZmoyS1JuT0tRTE5zMnEzQWtF?=
 =?utf-8?B?VTF2Z0MxVlFBTURKemd2eEVmOCtQVUNzakdRc2RzZU80Z2JKRVZYN1JZVmJK?=
 =?utf-8?B?amtQamgzK1ZwVzM3eEZCdzV2ZTErSkNtVnlld20zcjRmNzRYOFpZbDdxeGVH?=
 =?utf-8?B?UTM3Q3VtVHNObEFpdWZMOGNCNXR0OVlyY1lETndLTmY1SXdOQXozZmNIRzlx?=
 =?utf-8?B?aFhPTmYycFY3M1lCaVBLNDFyYjFiSUZPQ0xzaVFicUVZTVk1dkxnRXNpVFpj?=
 =?utf-8?B?YkZ4Q2hsWFF2bzluNzRSRGtWMjllclYvZUZvNVM2U1liMzRTMzAvMzlLbm5B?=
 =?utf-8?B?SXBsYzFOK0tFTE9Qc0ZQZittNE1GTU5KVWNGMGxtK3I4c0lWNHVTL0RBanZL?=
 =?utf-8?B?a09LcTlHMVhvNVQ0ODBRMmNPTk5aUEtuR2cvR25idTFyUENKTUtWMXk4eUFY?=
 =?utf-8?B?MG9jTkdEWnczTVU3VEZHaUZONmZXZUhxK1EzVGhxMDVuc0JSWU1LaDk3Qy9t?=
 =?utf-8?B?eWt3a1B2YnVScEJzZUNqbkJ5ZlhxcnRJTDZxRlhvc3UxWk0vQXRURkhEcWpq?=
 =?utf-8?B?WHVCNFF3aU1IM0pVMlRrM0VKanExNEd6TEUvdkdiT2k2NW1GaTMyT3NvZ1NO?=
 =?utf-8?Q?8FhytehftxB2z1rFk6gJC1I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9735d69b-2e03-4471-1966-08d997fa5114
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 20:59:20.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSRU2Mr2PWb+mC8Y715AL5JQo3PIopmuClcZfD63S0uGM1QEA3GhGoCdcPDR4vyd3Tpw9wudQOfgDYDJJjEULw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2800
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-09-15 12:37:45, Chanwoo Choi wrote:
> Hi,
> 
> As I commented on patch5, you keep the OPP list on devicetree file
> and then you better to use the 'suspend_opp' property
> for setting the highest frequency during suspend/resume.
> 

Hi,

I think there is no mechanism in place to ensure that the suspend opp
will be set only after all the icc users have suspended. I only tested
briefly, but I can tell you that there are cases where some icc user
asks for a different opp right after the suspend opp was set. This leads
to suspending with a different rate than the one from suspend opp.
So I guess I still need the late system sleep pm opps to circumvent such
situations.

> On 21. 9. 14. 오전 2:38, Abel Vesa wrote:
> > Seems that, in order to be able to resume from suspend, the dram rate
> > needs to be the highest one available. Therefore, add the late system
> > suspend/resume PM ops which set the highest rate on suspend and the
> > latest one used before suspending on resume.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >   drivers/devfreq/imx8m-ddrc.c | 28 +++++++++++++++++++++++++++-
> >   1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> > index f18a5c3c1c03..f39741b4a0b0 100644
> > --- a/drivers/devfreq/imx8m-ddrc.c
> > +++ b/drivers/devfreq/imx8m-ddrc.c
> > @@ -72,6 +72,8 @@ struct imx8m_ddrc {
> >   	struct clk *dram_alt;
> >   	struct clk *dram_apb;
> > +	unsigned long suspend_rate;
> > +	unsigned long resume_rate;
> >   	int freq_count;
> >   	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
> >   };
> > @@ -271,6 +273,22 @@ static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
> >   	return ret;
> >   }
> > +static int imx8m_ddrc_suspend(struct device *dev)
> > +{
> > +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> > +
> > +	priv->resume_rate = clk_get_rate(priv->dram_core);
> > +
> > +	return imx8m_ddrc_target(dev, &priv->suspend_rate, 0);
> > +}
> > +
> > +static int imx8m_ddrc_resume(struct device *dev)
> > +{
> > +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> > +
> > +	return imx8m_ddrc_target(dev, &priv->resume_rate, 0);
> > +}
> > +
> >   static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
> >   {
> >   	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> > @@ -324,6 +342,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
> >   		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
> >   			return -ENODEV;
> > +
> > +		if (index ==  0)
> > +			priv->suspend_rate = freq->rate * 250000;
> >   	}
> >   	return 0;
> > @@ -399,11 +420,16 @@ static const struct of_device_id imx8m_ddrc_of_match[] = {
> >   };
> >   MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
> > +static const struct dev_pm_ops imx8m_ddrc_pm_ops = {
> > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx8m_ddrc_suspend, imx8m_ddrc_resume)
> > +};
> > +
> >   static struct platform_driver imx8m_ddrc_platdrv = {
> >   	.probe		= imx8m_ddrc_probe,
> >   	.driver = {
> >   		.name	= "imx8m-ddrc-devfreq",
> > -		.of_match_table = imx8m_ddrc_of_match,
> > +		.pm = &imx8m_ddrc_pm_ops,
> > +		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
> >   	},
> >   };
> >   module_platform_driver(imx8m_ddrc_platdrv);
> > 
> 
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
