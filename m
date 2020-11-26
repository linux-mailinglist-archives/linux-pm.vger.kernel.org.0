Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD92C5ACD
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391654AbgKZRj1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:39:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55219 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391424AbgKZRj0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 12:39:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id 3so433483wmj.4;
        Thu, 26 Nov 2020 09:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjXv/ScxbZ0BiPP6MPGhGSZjdPE+o5XCx97qivgu68s=;
        b=ZUmqDYUd4qc5nadvVZr+hly3unJwoiUnBPDzfhU0UqBHOgZ46atNpQQjYYaysf3u64
         sPcNUJDp4+QBQtiWcHilTuyHKrfwePG7tOv5s7ERIEXWXPrHd6RqsMILcVmr+GyCsfW/
         TNpW8G+3Wf1vRlis9aF3aVflxpmKgW72MzeKUezu4sAuhW4ailN8GE7BaYrJOYGwYXl+
         m6leN25+cfzJLyDUcOlfjcBoM+6add3gD26Sp/lBQE1LFdUKgCYHAawf7vlxj5wU1eNA
         GyL6wMHiTTQs2JwfXRTf2mPAZHkKDMo2dADhLslqKpMSzbpd/+mRZdQKaTY1/Wm6fIKr
         UXhA==
X-Gm-Message-State: AOAM533BzCom2XwD2a/SZYzt46RN7rTQV/6ioHtgOarZlv3LbW0ubYOZ
        2SZrXybVjSm/OEdnDtoI338=
X-Google-Smtp-Source: ABdhPJym9BuTs4VMvKws9pdTIceCeRsKsxs2y5eVHiwUU6Em5mTTgU03rlmfFANSNsZ3NxhF5CkhzQ==
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr4694548wmc.186.1606412364616;
        Thu, 26 Nov 2020 09:39:24 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w21sm9198231wmi.29.2020.11.26.09.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:39:23 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:39:22 +0100
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
Message-ID: <20201126173922.GA7048@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-18-digetx@gmail.com>
 <X7/lLaZJNp+Vfczk@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7/lLaZJNp+Vfczk@ulmo>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 06:26:05PM +0100, Thierry Reding wrote:
> On Wed, Nov 04, 2020 at 07:48:53PM +0300, Dmitry Osipenko wrote:
> > Each memory client has unique hardware ID, add these IDs.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> 
> Is there any chance you could drop these dt-bindings include patches
> (17, 18 and 19) so that I can pick them up into the Tegra tree? The
> device tree changes that I was going to pick up depend on this and
> fail to build if applied as-is.
> 
> I was looking at your linux-mem-ctrl tree and had initially thought I
> could just pull in one of the branches to get these dependencies, but it
> looks like the dt-bindings patches are on the for-v5.11/tegra-mc branch,
> which the ARM SoC maintainers wouldn't like to see me pull in for a
> dependency on device tree changes.

Partially you answered here. :) Since you should not pull my branch into
a DT branch, you also should not put these include/dt-bindings patches
there.  SoC guys will complain about this as well.

These patches are also needed for the driver, so if you take them, I
would need them back in a pull request. SoC folks could spot it as well
and point that such merge should not happen.

> If this is all fixed at this point, I'll just have to push back the
> device tree changes to v5.12, or perhaps see if the ARM SoC maintainers
> are willing to take a late pull request that's based on v5.11-rc1.

Yeah, that's a known problem. I asked about this Arnd and Olof in the
past and got reply with two solutions:
1. Apply current version of patch without defines, just hard-coded
   numbers. After merging to Linus, replace the numbers with defines.

2. Wait with DTS till dependencies reach Linus.

Best regards,
Krzysztof
