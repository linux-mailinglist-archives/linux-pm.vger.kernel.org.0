Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC7D4176D1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbhIXOeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 10:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346670AbhIXOel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 10:34:41 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B01C061613
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 07:33:08 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y201so14725846oie.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVKtmk5fBSvxocw/4c3PneyHCHQ/Ke8LwLjraEOfCgE=;
        b=r8shDB5kcdH2mWfYFNTBoTNsLl9VHom16IuYb+VWwDkq95RrO1UIgYQiZivyR2ebzH
         S5re1C1mziTAbSSkIbyQxWYjdjIA9T78kC5MJoYxAV9LSgTmicGYHwAJHREjqYrwl0qM
         njFf+zhkzlkaCaZirh6SlGzySPBmNy0CIFOd85PyoliyBDteCGRdEWb8JbEhwouzgpfV
         s0PvHy/Sx4ikuNQldkdoDdAwXl3JlOnbuzSYSs8wZPbo13wlVZ1lpAiEP+EnjVwMP3oK
         PJezQXP4rAgUvr0P0Qy2wSbGmA79tiAFq8jW57aUdyXoPkOov4A/piRW3XWPU/ZQzMhr
         h/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVKtmk5fBSvxocw/4c3PneyHCHQ/Ke8LwLjraEOfCgE=;
        b=WN0+kUGmDbNzIy5ifDvrW/+n91OLHbFU4VaaThpIu40QYSx7E+iZp5Sm/B9AtThfBq
         oQJNLBL9dsipNgvhK95kseL032FWglMm1z7Ntzpa9/YGalmGNoMDuMlf089Jg864JAyc
         89/VES+CVdQww3+s9yy4AxPVIiwuY6rmkI37udlB4ME+CDCyTXoHCFMhYzH8OFNeLrJd
         k2UZcKdO7y9hi7Q7W6hbI184bH9g+21sIcel5/TT/uimHfeDu0S1ggeicKY6Fc2FHsvA
         GLIlFymoxE5tuORdYmYGNorKjn6LdGdvV1VoXLu+nysHRKHcqytH9UWvdmpInSJ8hxqt
         tlUw==
X-Gm-Message-State: AOAM5301xTEi+mr5vRyiH8j3gRpQ2pl/Os3l3MuKKTvv6zKdr+Tx8K2w
        NvNSqIJZ6WvWDH7Wgy5vxuvOlg==
X-Google-Smtp-Source: ABdhPJxsTh42uysxhsqrNLxBtGLV9qZL0XsTEjgFCxY2DowoZ4U4bS+G356YSkUPhSK0MQpjHoCyfw==
X-Received: by 2002:a54:4d8f:: with SMTP id y15mr1690580oix.122.1632493987643;
        Fri, 24 Sep 2021 07:33:07 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y9sm2177902ooe.10.2021.09.24.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:33:07 -0700 (PDT)
Date:   Fri, 24 Sep 2021 09:33:05 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>, Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] interconnect: qcom: sdm660: Add missing a2noc qos
 clocks
Message-ID: <YU3hoXHap5DsjTOm@builder.lan>
References: <20210824043435.23190-1-shawn.guo@linaro.org>
 <20210824043435.23190-3-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824043435.23190-3-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 23 Aug 23:34 CDT 2021, Shawn Guo wrote:

> It adds the missing a2noc clocks required for QoS registers programming
> per downstream kernel[1].  Otherwise, qcom_icc_noc_set_qos_priority()
> call on mas_ufs or mas_usb_hs node will simply result in a hardware hang
> on SDM660 SoC.
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Georgi, do you intend to pull this patch in for v5.15-rc?

I.e. should I pick up the dts change for v5.15 as well.

Regards,
Bjorn

> ---
>  drivers/interconnect/qcom/sdm660.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index c89c991a80a0..661eb3635d21 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -174,6 +174,16 @@ static const struct clk_bulk_data bus_mm_clocks[] = {
>  	{ .id = "iface" },
>  };
>  
> +static const struct clk_bulk_data bus_a2noc_clocks[] = {
> +	{ .id = "bus" },
> +	{ .id = "bus_a" },
> +	{ .id = "ipa" },
> +	{ .id = "ufs_axi" },
> +	{ .id = "aggre2_ufs_axi" },
> +	{ .id = "aggre2_usb3_axi" },
> +	{ .id = "cfg_noc_usb2_axi" },
> +};
> +
>  /**
>   * struct qcom_icc_provider - Qualcomm specific interconnect provider
>   * @provider: generic interconnect provider
> @@ -811,6 +821,10 @@ static int qnoc_probe(struct platform_device *pdev)
>  		qp->bus_clks = devm_kmemdup(dev, bus_mm_clocks,
>  					    sizeof(bus_mm_clocks), GFP_KERNEL);
>  		qp->num_clks = ARRAY_SIZE(bus_mm_clocks);
> +	} else if (of_device_is_compatible(dev->of_node, "qcom,sdm660-a2noc")) {
> +		qp->bus_clks = devm_kmemdup(dev, bus_a2noc_clocks,
> +					    sizeof(bus_a2noc_clocks), GFP_KERNEL);
> +		qp->num_clks = ARRAY_SIZE(bus_a2noc_clocks);
>  	} else {
>  		if (of_device_is_compatible(dev->of_node, "qcom,sdm660-bimc"))
>  			qp->is_bimc_node = true;
> -- 
> 2.17.1
> 
