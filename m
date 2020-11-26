Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89EF2C5B90
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404488AbgKZSGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:06:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44466 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391576AbgKZSGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:06:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id 64so3045505wra.11;
        Thu, 26 Nov 2020 10:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1QLKFnMd0xMr/FuISvhLJSJ7sMuGt7dY11QW5pCEZlM=;
        b=t/JeBsIPKAQIbE5npPqhfKbrOsY3lY448eZ0DyltN66XMoagQ6K73CyE+vc/k3LIJd
         ezPlTXs6UJT9eWg1pt8GwaUzyT/rWaOHTLXMiL9X+fk35nBlFqV/SapWFU91naRUOZSZ
         9JoFolQ2kC4JV9DIn511e6xqiBDI/NH8yOUOX7fraVndXVfiQEjFXhXwmjeJjUq74JEM
         07ym/k9PVjVyLByDPNFxTgP6c66R0Ok3fDTtMtTlKSXF5D8axindYu9QTl0GxHdCPcb6
         xFkIxrtTHEhnHCm+vFcwtzFDy2R9ruQTqleba++ZSDHtrdWIYAFfO4hxqg7b6kFUo4dU
         UcuQ==
X-Gm-Message-State: AOAM5335sdaEkEWztE0trF8Z85hnmkShuvdHWuPBONFXlOM2fO7RS1dU
        eeSlOEUZvlCbAGMKfthdXNk=
X-Google-Smtp-Source: ABdhPJwJIzd4XnJQtTCHV2LiRu+9UIhtQQYRHVWoL0G78pv9E0vIbZE77Fy9quW92PvulxW+y/CkuQ==
X-Received: by 2002:adf:ec8a:: with SMTP id z10mr5467457wrn.113.1606414006586;
        Thu, 26 Nov 2020 10:06:46 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id o5sm9374179wmh.8.2020.11.26.10.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 10:06:45 -0800 (PST)
Date:   Thu, 26 Nov 2020 19:06:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 17/47] dt-bindings: memory: tegra20: Add memory client
 IDs
Message-ID: <20201126180643.GA18074@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-18-digetx@gmail.com>
 <X7/lLaZJNp+Vfczk@ulmo>
 <20201126173922.GA7048@kozik-lap>
 <X7/tz8KwCBEgA6vi@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7/tz8KwCBEgA6vi@ulmo>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 07:02:55PM +0100, Thierry Reding wrote:
> On Thu, Nov 26, 2020 at 06:39:22PM +0100, Krzysztof Kozlowski wrote:
> > On Thu, Nov 26, 2020 at 06:26:05PM +0100, Thierry Reding wrote:
> > > On Wed, Nov 04, 2020 at 07:48:53PM +0300, Dmitry Osipenko wrote:
> > > > Each memory client has unique hardware ID, add these IDs.
> > > > 
> > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > ---
> > > >  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++++
> > > >  1 file changed, 53 insertions(+)
> > > 
> > > Is there any chance you could drop these dt-bindings include patches
> > > (17, 18 and 19) so that I can pick them up into the Tegra tree? The
> > > device tree changes that I was going to pick up depend on this and
> > > fail to build if applied as-is.
> > > 
> > > I was looking at your linux-mem-ctrl tree and had initially thought I
> > > could just pull in one of the branches to get these dependencies, but it
> > > looks like the dt-bindings patches are on the for-v5.11/tegra-mc branch,
> > > which the ARM SoC maintainers wouldn't like to see me pull in for a
> > > dependency on device tree changes.
> > 
> > Partially you answered here. :) Since you should not pull my branch into
> > a DT branch, you also should not put these include/dt-bindings patches
> > there.  SoC guys will complain about this as well.
> > 
> > These patches are also needed for the driver, so if you take them, I
> > would need them back in a pull request. SoC folks could spot it as well
> > and point that such merge should not happen.
> > 
> > > If this is all fixed at this point, I'll just have to push back the
> > > device tree changes to v5.12, or perhaps see if the ARM SoC maintainers
> > > are willing to take a late pull request that's based on v5.11-rc1.
> > 
> > Yeah, that's a known problem. I asked about this Arnd and Olof in the
> > past and got reply with two solutions:
> > 1. Apply current version of patch without defines, just hard-coded
> >    numbers. After merging to Linus, replace the numbers with defines.
> > 
> > 2. Wait with DTS till dependencies reach Linus.
> 
> What I've done occasionally in the past was to put these kinds of
> patches into a separate "dt-bindings" branch that I could use to resolve
> dependencies from device tree files. The ARM SoC maintainers never had
> any issues with that approach.
> 
> I guess this is a bit of a special case, because the DT includes are
> ultimately really a part of the device tree, so mixing them both isn't
> problematic.

Indeed, that way could work... and no one would spot it. :) Many times
these headers were for clock symbols so if they go via SoC/DT tree,
merge back to clock tree could be accepted.

Best regards,
Krzysztof

