Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD03F4EBD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhHWQw2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHWQw1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 12:52:27 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC23FC061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 09:51:44 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l24so14340458qtj.4
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDE00UpxBXJH5bTVnGFJxhddPj7ZtpRhyqPmw4zr1UM=;
        b=B0vOREiJZtFnTO/Vh7DSrYvQiGJ4g03NJ22FSHXJFkKcsF9da79RkAKvDZ7ooixGfH
         dWc0ETkCsHbOwAyq40IQWQWEQjzTXbHCb1+kKNRKG7rSCDonc6XWILyjf2QsEqOgkaPf
         J7kJuvkjG0VniLqg7UxaveAY3JeIhEJPLhxQdm7zYJROxpVZL+A/PBhC7QLAC3H/VMdq
         I6b0r8KxN2N9El20NcJz77cA1V5jWsDM8MuP64FkBVx4dhhVW2pRKmFJtZ0+xi3Cu+by
         t2ZrfJup/swSmOC0ma43Fpu5zR29UB5HLZaNHHhIlmwnern9ml6ojE+QfCzjbw4k8Ua/
         jV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDE00UpxBXJH5bTVnGFJxhddPj7ZtpRhyqPmw4zr1UM=;
        b=WPH+gxrvfVMmUctfx5J4BK8me1NUDEO9ehBVQaPczUxbOzP9M7fmP9SOTx9QuO27iL
         Mow24uDDGEkhx9wCmxz67N/IwPvZB0l4PxA/xgbpetwIdzeMR04SFFpTqjvAv+a62sB5
         h5Meae6V+kTLdocm7vIM7dDvrr6hBswWZeyslkJL5ELY3CTqScM1S11io+w+ftOA2cs0
         xhkAZr+d9wec/9SIBllZywuApCnB53vRWIfNMauvA31446uJN5PnTIe6YiFmMuNL7fjE
         plYzD5b/Qzbm09lnGVBBopNMeaI4VDrby5FwYcKYk6R7UZ5LbWfDiMueNfU/zKQgWOUC
         6Y6g==
X-Gm-Message-State: AOAM5316sYB36wCWi+fzUCCCiL8MBOT2UjX2NBQxjtqfUvOI20XjBlOD
        +7LLGOsWsOg/iNmpwFq/bNbSQOXL8mUGGqrywi5gMw==
X-Google-Smtp-Source: ABdhPJyF8KHJlq3bUVej5HJNFAYVBOfrTJxlhvyhbtsZxt4r2kfgv67lAOdMh11Ms6SFs2NRUW+WMe/9qtEO65suJaI=
X-Received: by 2002:ac8:66da:: with SMTP id m26mr30101290qtp.273.1629737504103;
 Mon, 23 Aug 2021 09:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210823095603.5538-1-shawn.guo@linaro.org> <20210823095603.5538-4-shawn.guo@linaro.org>
In-Reply-To: <20210823095603.5538-4-shawn.guo@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 23 Aug 2021 19:51:32 +0300
Message-ID: <CAA8EJpqPMMvtDL5NqUJTDfVEAqX9VD9Y_TWmXxh8DpS8hwDuJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm630: Add missing a2noc qos clocks
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 23 Aug 2021 at 12:56, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> It adds the missing a2noc clocks required for QoS registers programming
> per downstream kernel[1].
>
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 9153e6616ba4..b3a7f3bf1560 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -652,11 +652,22 @@
>
>                 a2noc: interconnect@1704000 {
>                         compatible = "qcom,sdm660-a2noc";
> -                       reg = <0x01704000 0xc100>;
> +                       reg = <0x01704000 0x1c000>;

Shawn, as you are at it, do we want to keep these nocs shifted
compared to the downstream dtsi (so that the offset of QoS registers
is 0) or we'd better introduce QoS register offset and move noc start
address to the same address as in downstream?

>                         #interconnect-cells = <1>;
> -                       clock-names = "bus", "bus_a";
> +                       clock-names = "bus",
> +                                     "bus_a",
> +                                     "ipa",
> +                                     "ufs_axi",
> +                                     "aggre2_ufs_axi",
> +                                     "aggre2_usb3_axi",
> +                                     "cfg_noc_usb2_axi";
>                         clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
> -                                <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
> +                                <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
> +                                <&rpmcc RPM_SMD_IPA_CLK>,
> +                                <&gcc GCC_UFS_AXI_CLK>,
> +                                <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
> +                                <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
> +                                <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
>                 };
>
>                 mnoc: interconnect@1745000 {
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
