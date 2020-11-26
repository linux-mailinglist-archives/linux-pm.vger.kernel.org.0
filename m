Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9262C5B29
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404556AbgKZRzb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:55:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34706 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgKZRzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 12:55:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id k14so3057956wrn.1;
        Thu, 26 Nov 2020 09:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22A8008SF+j3m02WPixLhh5zA9H2rktS0Eax77xtEYc=;
        b=Er4pCjCiBuLIDquv5yo/TW6IHCamEcY+9IaVR4XuTho7NED46XLXlASwpr4A49MhLO
         jqA7BvEQUMmfixPp4Q3gjyaW3qmsfcdsDAiQh6Mrl6mi6wdp8YOYFNV1QaGsl4kU0gWs
         nxWkT3BUT+Fo7foGI902KLgNBXPheOCJWKUecRBIFbDvtF/1NaglKcU1NNtoXi8Yu8rW
         ZltSZ32Ba+n6WeVNnKH3nyrGJpQyYfuSOIRIaVk4ZjptYZ1y2PXxFMeitxXkv/eRcR+u
         ax21SUNN1k0MXpBzHUDz6hYrUzw3nCoXHAXOKO803OUSW208WbigEuu2captJYELWJwi
         zcPg==
X-Gm-Message-State: AOAM53149JiRZOFcP296uB6eghqHRf1hj09+CUeIFgWOTA90xywWb/rj
        8GUvaO5jB//s6ZqUBjQGKtU=
X-Google-Smtp-Source: ABdhPJwNUIHnG8LMlsBBMZ5FRqQJJ8L8r06hEZvqK5zRQlbvc8KsciA63I86UtCkk2Y6O7KWRU4KSA==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr5129682wru.279.1606413329031;
        Thu, 26 Nov 2020 09:55:29 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d16sm10977272wrw.17.2020.11.26.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:55:27 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:55:26 +0100
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 17/47] dt-bindings: memory: tegra20: Add memory client
 IDs
Message-ID: <20201126175526.GA17141@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-18-digetx@gmail.com>
 <X7/lLaZJNp+Vfczk@ulmo>
 <20201126173922.GA7048@kozik-lap>
 <CAJKOXPfbmvUi3uWmX=qiiBxpCK_2oTWPY1JVxiVMuiv=RtwdKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJKOXPfbmvUi3uWmX=qiiBxpCK_2oTWPY1JVxiVMuiv=RtwdKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 06:45:51PM +0100, Krzysztof Kozlowski wrote:
> On Thu, 26 Nov 2020 at 18:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
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
> 
> It seems I was wrong - these patches are not needed for the driver
> code. Neither in applied parts nor in upcoming Dmitry's work. In such
> case I could rework my branches and send a new pull request. The
> patches would stay only in your tree.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

