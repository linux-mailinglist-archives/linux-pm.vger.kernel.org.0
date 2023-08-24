Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E200787865
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjHXTOt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbjHXTOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 15:14:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60041BCE
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 12:14:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OJEAHm035062;
        Thu, 24 Aug 2023 14:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692904450;
        bh=TzebilgSJoLVmCl+iiQZoyioyn73XvvWtrvGPKBc/Tg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ffOrdocYqD6wliRraz9rJQayjEzEbkyBrf8+4aNKFcfBSTHa6LxDBDYo5Vm3FYaXN
         A7auC8RaPZA2Ba+iMceoEtNDcv6XjIC4FzVqtkzFQTLkOY10rQm/+P7dxghyGvJneD
         bz1dmPBbJG4trg1PJkwlSz/CDg4fVTDwNmEDa7tA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OJEAsb059792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 14:14:10 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 14:14:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 14:14:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OJEA5q011741;
        Thu, 24 Aug 2023 14:14:10 -0500
Date:   Thu, 24 Aug 2023 14:14:10 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Zhang Zekun <zhangzekun11@huawei.com>, <kristo@kernel.org>,
        <ssantosh@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: Use for_each_node_with_property() simplify code
 logic
Message-ID: <20230824191410.jylzj4x7p3sn2u4l@encounter>
References: <20230818070149.23103-1-zhangzekun11@huawei.com>
 <CAPDyKFrL86MdfUwYm9UWy4AZtWBq0j_6sP8rimF7fwEXh0XtRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrL86MdfUwYm9UWy4AZtWBq0j_6sP8rimF7fwEXh0XtRw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11:10-20230818, Ulf Hansson wrote:
> On Fri, 18 Aug 2023 at 09:10, Zhang Zekun <zhangzekun11@huawei.com> wrote:
> >
> > Introduct for_each_node_with_property() to iterate through the
> > nodes, this can simplify the code logic a bit, no functional
> > change here.
> 
> I would prefer if we can start using the prefix "genpd: ti*" for the
> commit message header.
> 
> >
> > Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> 
> This looks good to me and I can pick it up, but awaiting and ack from
> the soc maintainers too.

Acked-by: Nishanth Menon <nm@ti.com>

Did some sanity tests around it as well.. I didn't see any obvious
breakage that I related to this.

> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/genpd/ti/ti_sci_pm_domains.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/genpd/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
> > index a33ec7eaf23d..34645104fe45 100644
> > --- a/drivers/genpd/ti/ti_sci_pm_domains.c
> > +++ b/drivers/genpd/ti/ti_sci_pm_domains.c
> > @@ -119,7 +119,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct ti_sci_genpd_provider *pd_provider;
> >         struct ti_sci_pm_domain *pd;
> > -       struct device_node *np = NULL;
> > +       struct device_node *np;
> >         struct of_phandle_args args;
> >         int ret;
> >         u32 max_id = 0;
> > @@ -138,11 +138,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
> >         INIT_LIST_HEAD(&pd_provider->pd_list);
> >
> >         /* Find highest device ID used for power domains */
> > -       while (1) {
> > -               np = of_find_node_with_property(np, "power-domains");
> > -               if (!np)
> > -                       break;
> > -
> > +       for_each_node_with_property(np, "power-domains") {
> >                 index = 0;
> >
> >                 while (1) {
> > --
> > 2.17.1
> >

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
