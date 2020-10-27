Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D9029C8ED
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830010AbgJ0Tap convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 27 Oct 2020 15:30:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45100 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830015AbgJ0Tap (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:30:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id dg9so2643928edb.12;
        Tue, 27 Oct 2020 12:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RBb2W6vnvr8BZ3JPOSPoABcC6/USapoO19wplu4GSWk=;
        b=lul+G3Ugz0pTOYAfoBoiOXduTzTI2SRlj9Cfcgol4qrfvTyDWaJ7DI3iAJyyV8xzbu
         SbN2RdZgJZZkirLeVJehXfHS77Vh/4YG6bg5Y0EXRN5aTo549VgqpzpsKpYAwVWPfhqO
         hk3EIv1zVoOotaBiDVdnZIA2bUCNoAXiOUNW2iIlYqZUl1SzRnlFRlClaIYTZ/TDpJp3
         yR35hfxiqWwq/CBeeViDvgz3vcNUyfefZCZy6SfITwgYH6fjUYCiobhwiM63eT7DInNz
         BX8tqWwYAvigE8ZTnlBLp3hN0NZRhJq24D5Kck+J4f/75HNBuZxYEkN4FkmlmRYqehbX
         I1PQ==
X-Gm-Message-State: AOAM533aItwOF1wQcfBGXVPf3GJxpKJJ/PA3cIYnL3olqrthbe2gzZdP
        mrbvB1vuvvrYwCsvZybqVc/mn+Em1pV+vFI3
X-Google-Smtp-Source: ABdhPJyZ/rq/EC6GsN4s/PCybZFKTFwJikds6RvGuu7wY5AqoMWIc9Vxh43XdGRJGg8dsyUGVp5G3w==
X-Received: by 2002:a05:6402:1b1e:: with SMTP id by30mr3972107edb.369.1603827042919;
        Tue, 27 Oct 2020 12:30:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id s12sm1518324edu.28.2020.10.27.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:30:41 -0700 (PDT)
Date:   Tue, 27 Oct 2020 20:30:39 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
Subject: Re: [PATCH v6 04/52] dt-bindings: memory: tegra20: emc: Document
 nvidia,memory-controller property
Message-ID: <20201027193039.GA140636@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-5-digetx@gmail.com>
 <20201027085417.GD4244@kozik-lap>
 <54191034-dcb9-7cab-333b-5bb2553f0ed1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <54191034-dcb9-7cab-333b-5bb2553f0ed1@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 10:17:19PM +0300, Dmitry Osipenko wrote:
> 27.10.2020 11:54, Krzysztof Kozlowski пишет:
> > On Mon, Oct 26, 2020 at 01:16:47AM +0300, Dmitry Osipenko wrote:
> >> Tegra20 External Memory Controller talks to DRAM chips and it needs to be
> >> reprogrammed when memory frequency changes. Tegra Memory Controller sits
> >> behind EMC and these controllers are tightly coupled. This patch adds the
> >> new phandle property which allows to properly express connection of EMC
> >> and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
> >> par with Tegra30+ EMC bindings, which is handy to have.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> >> index 567cffd37f3f..1b0d4417aad8 100644
> >> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> >> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> >> @@ -12,6 +12,7 @@ Properties:
> >>    irrespective of ram-code configuration.
> >>  - interrupts : Should contain EMC General interrupt.
> >>  - clocks : Should contain EMC clock.
> >> +- nvidia,memory-controller : Phandle of the Memory Controller node.
> > 
> > It looks like you adding a required property which is an ABI break.
> The T20 EMC driver is unused so far in upstream and it will become used
> only once this series is applied. Hence it's fine to change the ABI.

The ABI is not about upstream, but downstream. There are no other
upstreams using this ABI. Unless you have in mind that existing T20 EMC
driver was a noop, doing absolutely nothing, therefore there is no
breakage of any other users?

Best regards,
Krzysztof

