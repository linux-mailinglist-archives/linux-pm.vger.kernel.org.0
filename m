Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD67929DA4F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgJ1XS6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 28 Oct 2020 19:18:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34090 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgJ1XRk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 19:17:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id y16so1110040ljk.1;
        Wed, 28 Oct 2020 16:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tOzGuUmz353raLqizP2rvx4LkjDP5IM9PyiPt5zQsck=;
        b=jJtONSraL9jOMQSXwzrVOBF8qBnjdokxiP0xkykvx0UoBzDRKwhb5PZqWjHWdDVB9C
         YuS00hM/NBYa8WzAtn5OmO97bw0/3sFsEbDxz5/QGPv3wLuq3iURn1cNiVxpELI3VZAP
         YJI1EU4LjrnssbayFL/hxOJ+NVDcjw2xHqE+AoH4CTMD4DjdSuzqyg4D2Ism4/FNzOb1
         Ysauw1RtbTsqvGr3A2WMa/RM8Zmjysq5rVe8PkZuwJBAbirBZ7OFTqA90gnd3v+PAQBe
         xsw9XdSsX2ldssGidVfijOHBhKlCvW6Um/lAJVrnPtzro6bfxFb0BTEbBMWnemBA1VUx
         LejA==
X-Gm-Message-State: AOAM531j2wsgBjkMEHbaK601HeE2rQSGG2m6PHbxm6D1SGdzcMFoOvoV
        Ag4t4w6bV2DyA6UbXxZExyW/PPOxq+Crdg==
X-Google-Smtp-Source: ABdhPJx7uTojdx8c4uChsolOHCfdvqUlE8lbp5QLK2dcQNvxdYAlOS/eER5VjqNvSaVQADiGzYDahA==
X-Received: by 2002:a17:906:52d5:: with SMTP id w21mr8600918ejn.501.1603899329605;
        Wed, 28 Oct 2020 08:35:29 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id e2sm3163675edn.30.2020.10.28.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:35:27 -0700 (PDT)
Date:   Wed, 28 Oct 2020 16:35:25 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
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
Subject: Re: [PATCH v6 04/52] dt-bindings: memory: tegra20: emc: Document
 nvidia,memory-controller property
Message-ID: <20201028153525.GA133954@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-5-digetx@gmail.com>
 <20201027085417.GD4244@kozik-lap>
 <54191034-dcb9-7cab-333b-5bb2553f0ed1@gmail.com>
 <20201027193039.GA140636@kozik-lap>
 <20201028152303.GA4041470@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201028152303.GA4041470@bogus>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 28, 2020 at 10:23:03AM -0500, Rob Herring wrote:
> On Tue, Oct 27, 2020 at 08:30:39PM +0100, Krzysztof Kozlowski wrote:
> > On Tue, Oct 27, 2020 at 10:17:19PM +0300, Dmitry Osipenko wrote:
> > > 27.10.2020 11:54, Krzysztof Kozlowski пишет:
> > > > On Mon, Oct 26, 2020 at 01:16:47AM +0300, Dmitry Osipenko wrote:
> > > >> Tegra20 External Memory Controller talks to DRAM chips and it needs to be
> > > >> reprogrammed when memory frequency changes. Tegra Memory Controller sits
> > > >> behind EMC and these controllers are tightly coupled. This patch adds the
> > > >> new phandle property which allows to properly express connection of EMC
> > > >> and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
> > > >> par with Tegra30+ EMC bindings, which is handy to have.
> > > >>
> > > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > >> ---
> > > >>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
> > > >>  1 file changed, 2 insertions(+)
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> > > >> index 567cffd37f3f..1b0d4417aad8 100644
> > > >> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> > > >> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> > > >> @@ -12,6 +12,7 @@ Properties:
> > > >>    irrespective of ram-code configuration.
> > > >>  - interrupts : Should contain EMC General interrupt.
> > > >>  - clocks : Should contain EMC clock.
> > > >> +- nvidia,memory-controller : Phandle of the Memory Controller node.
> > > > 
> > > > It looks like you adding a required property which is an ABI break.
> > > The T20 EMC driver is unused so far in upstream and it will become used
> > > only once this series is applied. Hence it's fine to change the ABI.
> > 
> > The ABI is not about upstream, but downstream. 
> 
> "If it's not upstream, it doesn't exist."
> 
> Though we do have to account for out of tree users where the DT is not 
> in tree, but upstream drivers are used. Downstream as in vendor kernels 
> typically has loads of other crap.

That's the case I am referring to. Maybe not in case of Tegra, but
multiple other designs are quite popular in industrial uses and their
DTSes were not upstreamed.

This is anyway different case, as Dmitry explained - nothing got broken
because not much was working before around this.

> 
> > There are no other
> > upstreams using this ABI. Unless you have in mind that existing T20 EMC
> > driver was a noop, doing absolutely nothing, therefore there is no
> > breakage of any other users?
> 
> ABI breaks are ultimately up to the platform maintainers to decide.

Cool! That reshapes significantly my existing point of view, especially
about discussions on Exynos bindings (long time ago). Thanks for
clarification.

Best regards,
Krzysztof

