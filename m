Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9CBA8045
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 12:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfIDKUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 06:20:44 -0400
Received: from onstation.org ([52.200.56.107]:60992 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfIDKUo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Sep 2019 06:20:44 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 480EE3E941;
        Wed,  4 Sep 2019 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1567592443;
        bh=Sfwij6Ng9IHqC2d6RyNy275EE/PaAvekn8zkt+QGOsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dayeu+VwkGnpXYrJrLtmeDrxRJuYBbCtODSXinIHhl3Zssi/lPiDeRPYrUhxrDK1j
         4tXWMfepOT6UWy17g9VAzjmlTEPOj47Th+iEX7MDgiXOjrTZPGS7O+XeYW2vvN7QSa
         vr+tuGmZndKFK5xGfpxAnQw2IpPlSFug1I2RBmG4=
Date:   Wed, 4 Sep 2019 06:20:42 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: interconnect: qcom: add msm8974
 bindings
Message-ID: <20190904102042.GA14484@onstation.org>
References: <20190902211925.27169-1-masneyb@onstation.org>
 <20190902211925.27169-2-masneyb@onstation.org>
 <20190904050103.GE3081@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904050103.GE3081@tuxbook-pro>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 03, 2019 at 10:01:03PM -0700, Bjorn Andersson wrote:
> On Mon 02 Sep 14:19 PDT 2019, Brian Masney wrote:
> > +      mmssnoc: interconnect@fc478000 {
> > +              reg = <0xfc478000 0x4000>;
> > +              compatible = "qcom,msm8974-mmssnoc";
> > +              #interconnect-cells = <1>;
> > +              clock-names = "bus", "bus_a";
> > +              clocks = <&rpmcc RPM_SMD_MMSSNOC_AHB_CLK>,
> > +                       <&rpmcc RPM_SMD_MMSSNOC_AHB_A_CLK>;
> 
> Isn't MMSS_S0_AXI_CLK the bus clock of the mmssnoc (which somehow seems
> to depend on mmssnoc_ahb_clk)?

I'll give that a try. Do you know which clock I should use for bus_a
here? On the mmcc, I see the following mmss clocks available:

MMSS_AHB_CLK_SRC
MMSS_AXI_CLK_SRC
MMSS_RBCPR_CLK_SRC
MMSS_MISC_AHB_CLK
MMSS_MMSSNOC_AHB_CLK
MMSS_MMSSNOC_BTO_AHB_CLK
MMSS_MMSSNOC_AXI_CLK
MMSS_S0_AXI_CLK

I'm also unsure of what's going on at the hardware level that the second
clock (bus_a) is needed.

> > +      mdss: mdss@fd900000 {
> 
> I think you can omit the client, as this adheres to the standard binding
> for interconnect clients. And you don't need to have an example that
> covers all compatibles either...

OK, I'll drop some of these.

> > diff --git a/include/dt-bindings/interconnect/qcom,msm8974.h b/include/dt-bindings/interconnect/qcom,msm8974.h
> > new file mode 100644
> > index 000000000000..58acf7196410
> > --- /dev/null
> > +++ b/include/dt-bindings/interconnect/qcom,msm8974.h
> > @@ -0,0 +1,146 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Would you mind dual licensing this part as well?

Sure, that was an oversight on my part.

> Apart from that, I think this binding looks good.

Thanks,

Brian
