Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD42DFB91
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 04:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfJVCXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 22:23:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44584 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbfJVCXt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 22:23:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so8969482pgd.11
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 19:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AT7Vp+yACQ0gxVA6T92L6+q4sc2TtEu5B2tW7M476fE=;
        b=wAGpi/i7ToUnIHcgrBtOEeq9mKLemYp/7q8F4wQ/P1xghZ3Y/qiLVkjGKKUF2gZX2Q
         pJoV0/cyU1QmMb5z1/vwfhE/rUxstwDIpHLgS/6MU8e/4artDj0yGxvvhCoRZbyLjbqh
         uQ46+srG8EwwfpDLEILPDreo9TJu4K7WQmN+rDN5NoS1TRv10eQ/1WkenUw9cXcZLKVM
         ayb82Zy28qa7/4Gyptku1v1M9M71FlhQzs7Vx2tWtcKicL+gR6y5AMRX9rMHLKLTHRT3
         0Flf5YUfHgKm3tRu00ElqgxLV7OZW8AEPfCf/kFOXYdAZYRcHxTWNBK/nQKKYYyse3Jv
         KQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AT7Vp+yACQ0gxVA6T92L6+q4sc2TtEu5B2tW7M476fE=;
        b=L+96KMyXVSY1QJVIN/pkbkkCVbQvluDM5+XVLc4HdSmlubKEQkE6Xjzppk18y0p2CF
         rAUWUDbWxG55Q6u+SMe4VsddIqkpN6bFZmEblDtTGDYKbG6KcM7694hXpIUW3rUlr3sE
         RNeQ/MS/afMT3PuBnsYuixbx59KM4x34n4CxU6nIvHUoe9MCQJKhmlaAzr4X8nQxrorH
         1LN+YaT/zxdUnfb5Q7uadg1+fw/5244zfOYPrOAjYUV7+s1ubV5JZxbKxTbZywp+vCsc
         aR6lA0bAwlG/+dbfsEyG4sVsiAk2IR/I1DqRgPLoPmWsjDj0gmmhwyFC7XdCXryhPWqj
         5gWA==
X-Gm-Message-State: APjAAAWuqKEmF8KtczdKkFrdcsnqL8x4nK4ZvUHI+vX0LWd4uwrrqEVy
        DO9IIiX72LA/iEd6g5uFX7PfBw==
X-Google-Smtp-Source: APXvYqwD3LLESW9dtqRG9tRzGlNIUWLCdXMmmkM+V9LqAW0lYd0ou/d6RHGdRS4wqzKpk402x4m9pQ==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr1165736pgs.64.1571711027447;
        Mon, 21 Oct 2019 19:23:47 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 62sm16643422pfg.164.2019.10.21.19.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 19:23:45 -0700 (PDT)
Date:   Tue, 22 Oct 2019 07:53:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, roger.lu@mediatek.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 1/4] PM / OPP: Support adjusting OPP voltages at
 runtime
Message-ID: <20191022022341.yd6ykeszsuprmop2@vireshk-i7>
References: <20191016145756.16004-1-s.nawrocki@samsung.com>
 <CGME20191016145810eucas1p1b31400c9b2e7f30cdf6deeb4ccee2788@eucas1p1.samsung.com>
 <20191016145756.16004-2-s.nawrocki@samsung.com>
 <20191017064258.yfbh7iz3pbzfhdvr@vireshk-i7>
 <20191021112354.GA2262@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021112354.GA2262@pi3>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-10-19, 13:23, Krzysztof Kozlowski wrote:
> On Thu, Oct 17, 2019 at 12:12:58PM +0530, Viresh Kumar wrote:
> > On 16-10-19, 16:57, Sylwester Nawrocki wrote:
> > > From: Stephen Boyd <sboyd@codeaurora.org>
> > > 
> > > On some SoCs the Adaptive Voltage Scaling (AVS) technique is
> > > employed to optimize the operating voltage of a device. At a
> > > given frequency, the hardware monitors dynamic factors and either
> > > makes a suggestion for how much to adjust a voltage for the
> > > current frequency, or it automatically adjusts the voltage
> > > without software intervention. Add an API to the OPP library for
> > > the former case, so that AVS type devices can update the voltages
> > > for an OPP when the hardware determines the voltage should
> > > change. The assumption is that drivers like CPUfreq or devfreq
> > > will register for the OPP notifiers and adjust the voltage
> > > according to suggestions that AVS makes.
> > > 
> > > This patch is derived from [1] submitted by Stephen.
> > > [1] https://lore.kernel.org/patchwork/patch/599279/
> > > 
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > > [s.nawrocki@samsung.com: added handling of OPP min/max voltage]
> > > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > > ---
> > >  drivers/opp/core.c     | 69 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pm_opp.h | 13 ++++++++
> > >  2 files changed, 82 insertions(+)
> > 
> > Applied. Thanks.
> 
> Hi Viresh,
> 
> Can you provide a stable tag with this patch so I can take soc/samsung
> driver?

opp-5.4-support-adjust-voltages

-- 
viresh
