Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 849EFDEAC2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfJULYB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 07:24:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33454 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfJULYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 07:24:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id c4so9725449edl.0;
        Mon, 21 Oct 2019 04:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BVlXhkUOcHB+M6im4W80bsAnmThctBDhzXi/Z0FpqPM=;
        b=S0V90N+JCrqNnp2dnTE9DRbdC6LfHTIezwPuiDSdPk9RbPLwEEUOEbiFij3ksnRY2a
         swl+mXCUjqpoKfnsWigLH9jUEeSsPrT0lCqz8jCv7zNaIXiaLang8ux+zBMrAa3Qs4Nt
         kp31ZpRZo4UKtPx0fVtYp3aNoAIrKXrponiD8ZcvD69VEoPoR8sE8pN07ncfgT4X193B
         zQdaTLgcfzuQAxb/kLKTBR0mxJQ16NlSI/9qI0886GSxDDd3X+TN78j0NdMyECFn3C1I
         Sy6gBcvIXCu0v4KWHD4rzxzC3jDfVqGvfeyCv70vGmPk2mQfJegvcJJ5KhiquzID1jfo
         g2Bw==
X-Gm-Message-State: APjAAAXrbCYpLnbKDqwO1D4j1d9hml48eaRfvQmKs39b65Ew0Ee9QVHv
        bOc1/7IME92xRvKKsm1DwEM=
X-Google-Smtp-Source: APXvYqwff/GiwAwp/7TONncf6a2J4jtHzGlSJbceQ9C74FUOcOXZ54eJ4FoTQ+a8fgD2rHnjfyIlmQ==
X-Received: by 2002:a17:906:5292:: with SMTP id c18mr21356043ejm.129.1571657037596;
        Mon, 21 Oct 2019 04:23:57 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id w16sm579189edd.93.2019.10.21.04.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 04:23:56 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:23:54 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, roger.lu@mediatek.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 1/4] PM / OPP: Support adjusting OPP voltages at
 runtime
Message-ID: <20191021112354.GA2262@pi3>
References: <20191016145756.16004-1-s.nawrocki@samsung.com>
 <CGME20191016145810eucas1p1b31400c9b2e7f30cdf6deeb4ccee2788@eucas1p1.samsung.com>
 <20191016145756.16004-2-s.nawrocki@samsung.com>
 <20191017064258.yfbh7iz3pbzfhdvr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017064258.yfbh7iz3pbzfhdvr@vireshk-i7>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 12:12:58PM +0530, Viresh Kumar wrote:
> On 16-10-19, 16:57, Sylwester Nawrocki wrote:
> > From: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > On some SoCs the Adaptive Voltage Scaling (AVS) technique is
> > employed to optimize the operating voltage of a device. At a
> > given frequency, the hardware monitors dynamic factors and either
> > makes a suggestion for how much to adjust a voltage for the
> > current frequency, or it automatically adjusts the voltage
> > without software intervention. Add an API to the OPP library for
> > the former case, so that AVS type devices can update the voltages
> > for an OPP when the hardware determines the voltage should
> > change. The assumption is that drivers like CPUfreq or devfreq
> > will register for the OPP notifiers and adjust the voltage
> > according to suggestions that AVS makes.
> > 
> > This patch is derived from [1] submitted by Stephen.
> > [1] https://lore.kernel.org/patchwork/patch/599279/
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > [s.nawrocki@samsung.com: added handling of OPP min/max voltage]
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > ---
> >  drivers/opp/core.c     | 69 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h | 13 ++++++++
> >  2 files changed, 82 insertions(+)
> 
> Applied. Thanks.

Hi Viresh,

Can you provide a stable tag with this patch so I can take soc/samsung
driver?

Best regards,
Krzysztof

