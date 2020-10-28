Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D32A29D8F5
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbgJ1WkZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:40:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37475 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388994AbgJ1Wjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:39:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id m22so659757ots.4;
        Wed, 28 Oct 2020 15:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o6EwXQBfcMS/8hppO1O8Dg2kVJUq26B2UJyAmaDjbzk=;
        b=sRd22aRNw6zB6w/gluvROBwovTKpgYdsfCTCx/XJI8t+aLYXKHUchELoq+O5iqicEx
         B3lmmug5j/oQmHOgyR+4/EAJjkhmfhdIMsHp/6Qi3oLmGBh0ojWzA3YKviFFAP1a04v/
         7rcLJC8RsnISJzeCghZWLhB6iAzqprh88lNEBiTyxQ2chWIZJgVP/zpT1eeDuZ70wxVQ
         PtqDbYH8RcPaka8eqeLXYF2b5q6k6q/KDgAlJa7nG5dZClgq8jO33lxe7JJmwdRG3wnr
         A+t4Rfe1J9ufjzfYulrUN6Af1R28k+a4OKB8df/QWV20Bgjgov+LG6Y7+nZGdt9cPqOU
         P5+g==
X-Gm-Message-State: AOAM533DGIIz9S5G7j0mqgcBQf66m5C+K1SShYVUAgq+UgoRMcEWrQj8
        1GVLhzFl7nEc44X3mom8m36PEMobvw==
X-Google-Smtp-Source: ABdhPJwj/TyDdKmqYTN4xYvs7B9zlCOZD1OUjrbHekbCo/ATjXWibtj5dLIGJwVVW7gCH9am8fXsDQ==
X-Received: by 2002:a4a:ea4b:: with SMTP id j11mr6145795ooe.56.1603898585153;
        Wed, 28 Oct 2020 08:23:05 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c20sm2076568otm.49.2020.10.28.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:23:04 -0700 (PDT)
Received: (nullmailer pid 4050074 invoked by uid 1000);
        Wed, 28 Oct 2020 15:23:03 -0000
Date:   Wed, 28 Oct 2020 10:23:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
Message-ID: <20201028152303.GA4041470@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-5-digetx@gmail.com>
 <20201027085417.GD4244@kozik-lap>
 <54191034-dcb9-7cab-333b-5bb2553f0ed1@gmail.com>
 <20201027193039.GA140636@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201027193039.GA140636@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 08:30:39PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Oct 27, 2020 at 10:17:19PM +0300, Dmitry Osipenko wrote:
> > 27.10.2020 11:54, Krzysztof Kozlowski пишет:
> > > On Mon, Oct 26, 2020 at 01:16:47AM +0300, Dmitry Osipenko wrote:
> > >> Tegra20 External Memory Controller talks to DRAM chips and it needs to be
> > >> reprogrammed when memory frequency changes. Tegra Memory Controller sits
> > >> behind EMC and these controllers are tightly coupled. This patch adds the
> > >> new phandle property which allows to properly express connection of EMC
> > >> and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
> > >> par with Tegra30+ EMC bindings, which is handy to have.
> > >>
> > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > >> ---
> > >>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> > >> index 567cffd37f3f..1b0d4417aad8 100644
> > >> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> > >> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> > >> @@ -12,6 +12,7 @@ Properties:
> > >>    irrespective of ram-code configuration.
> > >>  - interrupts : Should contain EMC General interrupt.
> > >>  - clocks : Should contain EMC clock.
> > >> +- nvidia,memory-controller : Phandle of the Memory Controller node.
> > > 
> > > It looks like you adding a required property which is an ABI break.
> > The T20 EMC driver is unused so far in upstream and it will become used
> > only once this series is applied. Hence it's fine to change the ABI.
> 
> The ABI is not about upstream, but downstream. 

"If it's not upstream, it doesn't exist."

Though we do have to account for out of tree users where the DT is not 
in tree, but upstream drivers are used. Downstream as in vendor kernels 
typically has loads of other crap.

> There are no other
> upstreams using this ABI. Unless you have in mind that existing T20 EMC
> driver was a noop, doing absolutely nothing, therefore there is no
> breakage of any other users?

ABI breaks are ultimately up to the platform maintainers to decide.

Rob
