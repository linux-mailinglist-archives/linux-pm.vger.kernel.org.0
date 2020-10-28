Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF45A29DC7A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 01:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbgJ1WdU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 28 Oct 2020 18:33:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39519 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbgJ1WdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:33:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id y12so734421wrp.6;
        Wed, 28 Oct 2020 15:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9qMkACaxgBFGgp14/y74BYPbOoZe+yAscejmhiaaiHI=;
        b=ToJRGbqWsOr5Tp0L0JDERd4/O/4KaV7gpvowMalTqutn+Bl3QeJ+jhBEUCj+LLX4mr
         o+9MsOQjVNEg8bjb3mjmtVi8oNoODDyWg1j9QrlRJ/wlYdJpLzm/6h6Ki0R8XkqaIEK5
         POxWy7Alag9mk20LJQRniaaJMfEWf2PwxaOEY/mdxe4COvcR0cYfRnp8MQRlQ4+3uBCZ
         LfIcLmFUmIkhX6k9v7GHsdNn6wrPnskjbaabj1Ag0iJhLq7UB588yhqqWiSDBflG+46g
         KWygY9/3GJwrxQMuFPFq+BrFgWSCFHCLqzZIfe3Y6Dya6M1AnOwMbM7PQpY9koYA0JOz
         K4Iw==
X-Gm-Message-State: AOAM531s2Bx6kOk3O7V0ebu9O1rxbrtdhouUSSYezSUQvzs5KNCwMIMy
        4QPlg2QV2jHE/FZMijIzJhgPQTBjpimaSg==
X-Google-Smtp-Source: ABdhPJzFsqaQeMhmEXSs9UrGO3Kmxrx9OhwqKP85Emfcv2bhHljDeQGLFfXI3feKDEwi+e1eh+cN1w==
X-Received: by 2002:a50:d987:: with SMTP id w7mr441293edj.113.1603913252990;
        Wed, 28 Oct 2020 12:27:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id y14sm205006edo.69.2020.10.28.12.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 12:27:31 -0700 (PDT)
Date:   Wed, 28 Oct 2020 20:27:29 +0100
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
Subject: Re: [PATCH v6 13/52] dt-bindings: memory: tegra124: emc: Document
 new interconnect property
Message-ID: <20201028192729.GA170285@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-14-digetx@gmail.com>
 <20201027102506.GB17089@kozik-lap>
 <f38984b6-d53f-a43d-0387-e787b3c1924d@gmail.com>
 <20201027194833.GE140636@kozik-lap>
 <0a7aeebf-c5ab-13ea-3927-fa39512afd87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0a7aeebf-c5ab-13ea-3927-fa39512afd87@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 11:16:29PM +0300, Dmitry Osipenko wrote:
> 27.10.2020 22:48, Krzysztof Kozlowski пишет:
> > On Tue, Oct 27, 2020 at 10:19:28PM +0300, Dmitry Osipenko wrote:
> >> 27.10.2020 13:25, Krzysztof Kozlowski пишет:
> >>> On Mon, Oct 26, 2020 at 01:16:56AM +0300, Dmitry Osipenko wrote:
> >>>> External memory controller is interconnected with memory controller and
> >>>> with external memory. Document new interconnect property which turns
> >>>> External Memory Controller into interconnect provider.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml   | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> >>>> index 278549f9e051..ac00832ceac1 100644
> >>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> >>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> >>>> @@ -29,6 +29,9 @@ properties:
> >>>>      items:
> >>>>        - const: emc
> >>>>  
> >>>> +  "#interconnect-cells":
> >>>> +    const: 0
> >>>> +
> >>>>    nvidia,memory-controller:
> >>>>      $ref: /schemas/types.yaml#/definitions/phandle
> >>>>      description:
> >>>> @@ -327,6 +330,7 @@ required:
> >>>>    - clocks
> >>>>    - clock-names
> >>>>    - nvidia,memory-controller
> >>>> +  - "#interconnect-cells"
> >>>
> >>> Another required property, what about all existing users of this binding?
> >>
> >> EMC/devfreq drivers check presence of the new properties and ask users
> >> to upgrade the DT. The kernel will continue to work fine using older
> >> DTBs, but devfreq driver won't load.
> > 
> > If the devfreq was working fine before (with these older DTBs and older
> > kernel) then you break the feature.
> > 
> > If devfreq was not working or was not stable enough, then nothing is
> > broken so such change is accepted.
> > 
> > Which one is then?
> 
> Definitely the latter. The current devfreq works okay'ish, but we rely
> on hardware to recover from temporal FIFO underflows and it's a
> user-visible problem which this series addresses.

I understand. Fine with me, thanks for explanation.

Best regards,
Krzysztof

