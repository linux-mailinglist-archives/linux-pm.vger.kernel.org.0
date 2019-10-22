Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FC3E0BA5
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbfJVSnk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 14:43:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45307 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbfJVSnj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 14:43:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id y7so6178643edo.12;
        Tue, 22 Oct 2019 11:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MaK9HZRo2yPA34xjdPj8WIVzo4X/HVsTE3eZR+WBcic=;
        b=WwR/XSHAiRFFo4wQcTon1ii+X3ISus9Wr4wAOV/uyQ+9FSt1qE7BnhiGxqzpT64GMB
         jqnE0EyrABOUaGJvlhcTtxHjLgocZHgUUAXcXvMh5Q1vTv6iMLsNyW81orK9ZZKiMuE4
         2fhDnvEhwE6tH361dkh/mNC+HravKWxWo+o4aVMf/PpmRRTPBKRoRIyiv5SYQJ5QsI2d
         Cxs19hGfqWcJgkKXXtsu0eaBa/vOzvAdpnlil3kqRxNTp8XngV7WplTQDb/LeQgtx4fp
         5CXoMUqCxiy1LbvSjTVMk8O8BjJjEISnyQS0WOFv49sTR1+zNUStZ8UlptZTaXLD5uyU
         KOxg==
X-Gm-Message-State: APjAAAUsFFaGYTjjgFtVTCMv82Ag8RVcRYJrO4AQnvhwfC+iQTdxmxIC
        0ZfLbs5CR2DRbE2Ff+A7e8s=
X-Google-Smtp-Source: APXvYqwaza4IQ48vd2aWTDDcq9RRblSoEI8imxQjQ2w9B33BxUNL8U7MIIpmrU+/Ly8hAxGL9ziPmQ==
X-Received: by 2002:a17:906:69cc:: with SMTP id g12mr28731760ejs.235.1571769817645;
        Tue, 22 Oct 2019 11:43:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id w19sm123844ejo.3.2019.10.22.11.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 11:43:36 -0700 (PDT)
Date:   Tue, 22 Oct 2019 20:43:34 +0200
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
Message-ID: <20191022184334.GA8305@kozik-lap>
References: <20191016145756.16004-1-s.nawrocki@samsung.com>
 <CGME20191016145810eucas1p1b31400c9b2e7f30cdf6deeb4ccee2788@eucas1p1.samsung.com>
 <20191016145756.16004-2-s.nawrocki@samsung.com>
 <20191017064258.yfbh7iz3pbzfhdvr@vireshk-i7>
 <20191021112354.GA2262@pi3>
 <20191022022341.yd6ykeszsuprmop2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191022022341.yd6ykeszsuprmop2@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 22, 2019 at 07:53:41AM +0530, Viresh Kumar wrote:
> On 21-10-19, 13:23, Krzysztof Kozlowski wrote:
> > On Thu, Oct 17, 2019 at 12:12:58PM +0530, Viresh Kumar wrote:
> > > On 16-10-19, 16:57, Sylwester Nawrocki wrote:
> > > > From: Stephen Boyd <sboyd@codeaurora.org>
> > > > 
> > > > On some SoCs the Adaptive Voltage Scaling (AVS) technique is
> > > > employed to optimize the operating voltage of a device. At a
> > > > given frequency, the hardware monitors dynamic factors and either
> > > > makes a suggestion for how much to adjust a voltage for the
> > > > current frequency, or it automatically adjusts the voltage
> > > > without software intervention. Add an API to the OPP library for
> > > > the former case, so that AVS type devices can update the voltages
> > > > for an OPP when the hardware determines the voltage should
> > > > change. The assumption is that drivers like CPUfreq or devfreq
> > > > will register for the OPP notifiers and adjust the voltage
> > > > according to suggestions that AVS makes.
> > > > 
> > > > This patch is derived from [1] submitted by Stephen.
> > > > [1] https://lore.kernel.org/patchwork/patch/599279/
> > > > 
> > > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > > > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > > > [s.nawrocki@samsung.com: added handling of OPP min/max voltage]
> > > > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > > > ---
> > > >  drivers/opp/core.c     | 69 ++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pm_opp.h | 13 ++++++++
> > > >  2 files changed, 82 insertions(+)
> > > 
> > > Applied. Thanks.
> > 
> > Hi Viresh,
> > 
> > Can you provide a stable tag with this patch so I can take soc/samsung
> > driver?
> 
> opp-5.4-support-adjust-voltages

Thanks, merged.

Best regards,
Krzysztof

