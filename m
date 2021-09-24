Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6436417765
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347052AbhIXPU4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhIXPUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 11:20:55 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9743EC06161E
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 08:19:22 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso13519218otb.11
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FPuGLXyf4GhSufJtTJPE2zMV0i7GqU53SMkQ5L/me9Q=;
        b=f/iKq4FEp3LEXigAZZ11zXCgcDuCmdMdOyDEgV6ybsY5fbnKvDWEZsgf/jeXsl0fcJ
         ESsqyytRG+8Yzcbx8ws72ASSAZu+x4U1Q+4faH4oMc0XAMOQR5sG4JjEyMCZhOObOg5u
         eNCzhqERrT5pRMc7PGNHr8RTiQr80VjVp/2vhfsGfZslJDQMvlezmCHYUNzL/jKAqG9H
         AukSJFJi/UQRixGLRygUevm4Y8k+IfecrNwl0ZDwd/ixhHZGWwm2XL/b1VF/HnYd+x8V
         r/s9DPuXpSTRRMK+dCtOAU92kPIqlLANQRqXVDvxQGbMsFNAHuJouRzexUadSbu8cfGR
         GSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPuGLXyf4GhSufJtTJPE2zMV0i7GqU53SMkQ5L/me9Q=;
        b=SiosLh5JCySVIQQ3nGhI1G7Eh2Zj/Alco/wpuFL57upvJaQmh0El1i/tN/ZmsF4/4l
         /lckRX9mdpedUXOyZuHVqjFyFnLBFNzO/sAjG1vxm2FmFHd8GGtiWQ9uxTIwcuJqWrvK
         ZtLMWWUKu8md/9tfIarOsMWl+kEyk/gNgYLXVNjrs+DCBbDjgQc/fOa3+lIulpuP2nGE
         zofi3r/Z+/oYQx1BodF5/Vp8Rs9Jqv9mxSYINgy9Y1XdzFvvM/VLbdtUAe7xxz3n2CT1
         Qm5ddM3aMNBDzavLpOxeeOyRYbAN76e5nfezuoD1fiMJc5uNabcUYCLS1Lh/ko9mhY+M
         9N+g==
X-Gm-Message-State: AOAM532iKyMNYJFqH7uzF6NqKqwKUq3Nl/I+0gISqS525P3xGtFrBlWW
        W3m4AnyfKf+th2laZJhs5UzklQ==
X-Google-Smtp-Source: ABdhPJwppbzTnd5V1quAynG3XkKUBXIK0hPAtxhhdSVQJJOEo57BZuYRHSwufDJQKlS6onACToGjxQ==
X-Received: by 2002:a9d:6206:: with SMTP id g6mr4588442otj.62.1632496761890;
        Fri, 24 Sep 2021 08:19:21 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e2sm1815335ooa.20.2021.09.24.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:19:21 -0700 (PDT)
Date:   Fri, 24 Sep 2021 08:20:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] interconnect: qcom: sdm660: Add missing a2noc qos
 clocks
Message-ID: <YU3soCSg7nbywpGw@ripper>
References: <20210824043435.23190-1-shawn.guo@linaro.org>
 <20210824043435.23190-3-shawn.guo@linaro.org>
 <YU3hoXHap5DsjTOm@builder.lan>
 <9b660924-1f07-8723-b66c-182ca06629d2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b660924-1f07-8723-b66c-182ca06629d2@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 24 Sep 07:58 PDT 2021, Georgi Djakov wrote:

> On 24.09.21 17:33, Bjorn Andersson wrote:
> > On Mon 23 Aug 23:34 CDT 2021, Shawn Guo wrote:
> > 
> > > It adds the missing a2noc clocks required for QoS registers programming
> > > per downstream kernel[1].  Otherwise, qcom_icc_noc_set_qos_priority()
> > > call on mas_ufs or mas_usb_hs node will simply result in a hardware hang
> > > on SDM660 SoC.
> > > 
> > > [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Georgi, do you intend to pull this patch in for v5.15-rc?
> > 
> > I.e. should I pick up the dts change for v5.15 as well.
> 
> Yes, i have just sent a pull request with this included, so please
> pull the dts change as a fix for v5.15-rc. Sorry for not mentioning
> it explicitly.
> I assume that not all bootloaders are leaving the qos clocks enabled,
> so if this is fixing a hardware hang, should we also backport it into
> stable? This is probably more of a question to the people actively
> using this board?
> 

Devices that needed this change wouldn't boot on that older kernel
anyways, so I think it's safe to assume that we don't have any users on
an old kernel that would benefit from this change.

So v5.15 is probably sufficient.

Regards,
Bjorn

> Thanks,
> Georgi
> 
> > Regards,
> > Bjorn
> > 
> > > ---
> > >   drivers/interconnect/qcom/sdm660.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> > > index c89c991a80a0..661eb3635d21 100644
> > > --- a/drivers/interconnect/qcom/sdm660.c
> > > +++ b/drivers/interconnect/qcom/sdm660.c
> > > @@ -174,6 +174,16 @@ static const struct clk_bulk_data bus_mm_clocks[] = {
> > >   	{ .id = "iface" },
> > >   };
> > > +static const struct clk_bulk_data bus_a2noc_clocks[] = {
> > > +	{ .id = "bus" },
> > > +	{ .id = "bus_a" },
> > > +	{ .id = "ipa" },
> > > +	{ .id = "ufs_axi" },
> > > +	{ .id = "aggre2_ufs_axi" },
> > > +	{ .id = "aggre2_usb3_axi" },
> > > +	{ .id = "cfg_noc_usb2_axi" },
> > > +};
> > > +
> > >   /**
> > >    * struct qcom_icc_provider - Qualcomm specific interconnect provider
> > >    * @provider: generic interconnect provider
> > > @@ -811,6 +821,10 @@ static int qnoc_probe(struct platform_device *pdev)
> > >   		qp->bus_clks = devm_kmemdup(dev, bus_mm_clocks,
> > >   					    sizeof(bus_mm_clocks), GFP_KERNEL);
> > >   		qp->num_clks = ARRAY_SIZE(bus_mm_clocks);
> > > +	} else if (of_device_is_compatible(dev->of_node, "qcom,sdm660-a2noc")) {
> > > +		qp->bus_clks = devm_kmemdup(dev, bus_a2noc_clocks,
> > > +					    sizeof(bus_a2noc_clocks), GFP_KERNEL);
> > > +		qp->num_clks = ARRAY_SIZE(bus_a2noc_clocks);
> > >   	} else {
> > >   		if (of_device_is_compatible(dev->of_node, "qcom,sdm660-bimc"))
> > >   			qp->is_bimc_node = true;
> > > -- 
> > > 2.17.1
> > > 
> 
