Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8FE3F5572
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 03:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhHXBS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 21:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhHXBS2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 21:18:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2D7C06175F
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 18:17:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y190so16933288pfg.7
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hqn67LxL3lG3twDFl2dpaEiJy0jyMcHPR1Uu+GiQgVA=;
        b=v73Zr5Q8pN7sStTrMPxEY3ITjm7HbhS4Dw7jKdD4VGbGcZG72luOiHCDKRu5C5LuEW
         Tsyj2Ep9MJI3t/W2YLYwY8OaHQy8UbQQaHtNyjFw0yX6VO0sxXKFZ1O2ILzCnlgV0KjH
         XMTesil4WZ9dWMCZ+zJ74rwNJrr8yvWOblfMPlGNWN+TXqhsK+0rFyNLdNbfYpr7IamA
         zC7a4HOfxwsfSIEo/NZcuJ0zDADfBUAigPRiJwelVIGAGFTu/vVExDHk0ux1whKuDC5U
         SuOCk9R3Na1fwlB8v8FCd022NesV626edWrG5zGhHtfGjec5Io/CJNaU/BiwCFtmn83+
         p2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hqn67LxL3lG3twDFl2dpaEiJy0jyMcHPR1Uu+GiQgVA=;
        b=Cmi6SmZCK3OXnNFT1Cpgoy7C1qQaUwmKMYR67aCnvE17frqylEA01KgcPL1PEFqhZP
         sCvKWoGALy6RjXzhlrl/waYr13htOdMJ8WH8o6dh8DQY5DmtxQhz5h4u0hO/gKwtkmOS
         GGqXeevsG/9A7HhdrAXCGQIQul6ncm0+uv6zkEYhNPWZTFy1qy6geIwtocqToFPxhvAN
         WxpblcSAW/GucCQWSJvZ6yfWGXC3GCRWRn+yeu2tSJKBFuf+fY9tUXbnbMybSuqKcoOe
         7/8CLHj6OXP6ZPptiUHibOuOWRk+PQsnA7F7uudygVYbibDW3voFlkcrerfXpXvOwEFM
         ZCWQ==
X-Gm-Message-State: AOAM53323HIHVnr0Q576kHtbbRc+SiFO00X6KRjafN/CmE+Cgy1PhpgX
        r1P+Xwf/KCf4f9alx5P/9UxS+Q==
X-Google-Smtp-Source: ABdhPJzoptsMtsMBaGJ1f/2Nl5/lIr6SJerpLtnEjmXym1WbcktKQBRjUA2lqjy2dTRi9CQ/Qjs6pQ==
X-Received: by 2002:a05:6a00:134e:b0:3e1:1ed:80ff with SMTP id k14-20020a056a00134e00b003e101ed80ffmr36035307pfu.34.1629767865125;
        Mon, 23 Aug 2021 18:17:45 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c17sm416876pjq.16.2021.08.23.18.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Aug 2021 18:17:44 -0700 (PDT)
Date:   Tue, 24 Aug 2021 09:17:38 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm630: Add missing a2noc qos
 clocks
Message-ID: <20210824011737.GA22595@dragon>
References: <20210823095603.5538-1-shawn.guo@linaro.org>
 <20210823095603.5538-4-shawn.guo@linaro.org>
 <CAA8EJpqPMMvtDL5NqUJTDfVEAqX9VD9Y_TWmXxh8DpS8hwDuJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqPMMvtDL5NqUJTDfVEAqX9VD9Y_TWmXxh8DpS8hwDuJg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 23, 2021 at 07:51:32PM +0300, Dmitry Baryshkov wrote:
> On Mon, 23 Aug 2021 at 12:56, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > It adds the missing a2noc clocks required for QoS registers programming
> > per downstream kernel[1].
> >
> > [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm630.dtsi | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > index 9153e6616ba4..b3a7f3bf1560 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > @@ -652,11 +652,22 @@
> >
> >                 a2noc: interconnect@1704000 {
> >                         compatible = "qcom,sdm660-a2noc";
> > -                       reg = <0x01704000 0xc100>;
> > +                       reg = <0x01704000 0x1c000>;
> 
> Shawn, as you are at it, do we want to keep these nocs shifted
> compared to the downstream dtsi (so that the offset of QoS registers
> is 0) or we'd better introduce QoS register offset and move noc start
> address to the same address as in downstream?

Dmitry, thanks for spotting this!  This is really an unintended leftover
from debugging.  I will drop it in v2.  For address alignment with
downstream, I do not really have a strong opinion and I can live with
either of them :)

Shawn

> >                         #interconnect-cells = <1>;
> > -                       clock-names = "bus", "bus_a";
> > +                       clock-names = "bus",
> > +                                     "bus_a",
> > +                                     "ipa",
> > +                                     "ufs_axi",
> > +                                     "aggre2_ufs_axi",
> > +                                     "aggre2_usb3_axi",
> > +                                     "cfg_noc_usb2_axi";
> >                         clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
> > -                                <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
> > +                                <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
> > +                                <&rpmcc RPM_SMD_IPA_CLK>,
> > +                                <&gcc GCC_UFS_AXI_CLK>,
> > +                                <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
> > +                                <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
> > +                                <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
> >                 };
> >
> >                 mnoc: interconnect@1745000 {
> > --
> > 2.17.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry
