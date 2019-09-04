Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90387A9228
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 21:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfIDTEG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 15:04:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44796 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732561AbfIDTEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 15:04:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so8806328pfn.11
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2019 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmoktrUsrRAX/D4sytItWL2rgYOOGje/KPRLW7QLU2g=;
        b=A0KTYkOgIyHzo9L3f04wY0gGoxEWXXUdQETF2gDIFnYoYkS/UXcKD1TwTTPRDGs/RN
         ECGCHjaeV/CeGMNx2VC0eTvEswu34MZ4XBvC+4st0YLL2/65/RXS3Se7+EU8RtCyZnUl
         C8QH+OpZxbe5rry8EpXvNeWYuHC30FPM4NlzbTx5IlpCt0QvMdHOJnosBKfJGD76cvcd
         QjZOQrMiKsmqCLYMki0M0i3xNVZSRL+w0IDWfw5N2XKlQF0yEFtTpsIgyyiK2HfniNRH
         s32N9l8VKqHOaYm501YGsFBgOTiMRDuCY6BXuqkLp2M/l1UaSqWvTeSw30nIClnvgwOU
         dkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmoktrUsrRAX/D4sytItWL2rgYOOGje/KPRLW7QLU2g=;
        b=ANz/NpZTUqczVm4WV18G3StWUXu452tl+iUETp88EVFth/kVLUlexIjsHmJSt41kDH
         2JgpCejDKdihRSCpUidAyKxOSvDLsZFcYOT/axw4nkLVD9oJmUg5DNIYui3cjl1Vk+ft
         iNZ+KIr7iejDUemCqpc2wM0/MMomFmCVkJXKE2bs4jSJqkOHkaJGFsAAETW6e9uiW4Ql
         KdOHVkVnKlk29tnrnyhsDSfLsKXUhcQvQkmSQkUDaEw8x2Yzd8990JmojREvm6KabZxO
         2fxBxoq89KpiXhMO7ky1oCS10HAsUqVpvQYiovsncGChPH+8YBM1beqh+QTbzBEW3foj
         4FXA==
X-Gm-Message-State: APjAAAXTDdyNUQgEee9Wsf7agDT5YLxxUs+hbGTUhE1xTf27w68CVwQc
        qsYojLzyxecZFPuX8jYPBBdYaw==
X-Google-Smtp-Source: APXvYqyLbdpj6NVEnHDBQfONCSx6oW2K/cCEUa552ZtfzTvAyHwrHE3OVT3AzSfVmlets6DTJe9AxQ==
X-Received: by 2002:a63:9245:: with SMTP id s5mr37182454pgn.123.1567623845637;
        Wed, 04 Sep 2019 12:04:05 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j128sm22473181pfg.51.2019.09.04.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:04:05 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:03:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: interconnect: qcom: add msm8974
 bindings
Message-ID: <20190904190357.GI574@tuxbook-pro>
References: <20190902211925.27169-1-masneyb@onstation.org>
 <20190902211925.27169-2-masneyb@onstation.org>
 <20190904050103.GE3081@tuxbook-pro>
 <20190904102042.GA14484@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904102042.GA14484@onstation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 04 Sep 03:20 PDT 2019, Brian Masney wrote:

> On Tue, Sep 03, 2019 at 10:01:03PM -0700, Bjorn Andersson wrote:
> > On Mon 02 Sep 14:19 PDT 2019, Brian Masney wrote:
> > > +      mmssnoc: interconnect@fc478000 {
> > > +              reg = <0xfc478000 0x4000>;
> > > +              compatible = "qcom,msm8974-mmssnoc";
> > > +              #interconnect-cells = <1>;
> > > +              clock-names = "bus", "bus_a";
> > > +              clocks = <&rpmcc RPM_SMD_MMSSNOC_AHB_CLK>,
> > > +                       <&rpmcc RPM_SMD_MMSSNOC_AHB_A_CLK>;
> > 
> > Isn't MMSS_S0_AXI_CLK the bus clock of the mmssnoc (which somehow seems
> > to depend on mmssnoc_ahb_clk)?
> 
> I'll give that a try. Do you know which clock I should use for bus_a
> here? On the mmcc, I see the following mmss clocks available:
> 
> MMSS_AHB_CLK_SRC
> MMSS_AXI_CLK_SRC
> MMSS_RBCPR_CLK_SRC
> MMSS_MISC_AHB_CLK
> MMSS_MMSSNOC_AHB_CLK
> MMSS_MMSSNOC_BTO_AHB_CLK
> MMSS_MMSSNOC_AXI_CLK
> MMSS_S0_AXI_CLK
> 
> I'm also unsure of what's going on at the hardware level that the second
> clock (bus_a) is needed.
> 

In msm-3.4 clock-8974.c both bus and bus_a is defined as
mmss_s0_axi_clk. But iirc I also needed mmssnoc_axi_clk to get DSI
working on my devices, which is listed as .depends of the s0_axi clock.

So that probably needs some more investigation...But easiest would
probably be to just have the mmss_noc use them both listed as bus
clocks?

Regards,
Bjorn

> > > +      mdss: mdss@fd900000 {
> > 
> > I think you can omit the client, as this adheres to the standard binding
> > for interconnect clients. And you don't need to have an example that
> > covers all compatibles either...
> 
> OK, I'll drop some of these.
> 
> > > diff --git a/include/dt-bindings/interconnect/qcom,msm8974.h b/include/dt-bindings/interconnect/qcom,msm8974.h
> > > new file mode 100644
> > > index 000000000000..58acf7196410
> > > --- /dev/null
> > > +++ b/include/dt-bindings/interconnect/qcom,msm8974.h
> > > @@ -0,0 +1,146 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > 
> > Would you mind dual licensing this part as well?
> 
> Sure, that was an oversight on my part.
> 
> > Apart from that, I think this binding looks good.
> 
> Thanks,
> 
> Brian
