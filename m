Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183C629C938
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830529AbgJ0Tsk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 27 Oct 2020 15:48:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40162 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830518AbgJ0Tsj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:48:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id p93so2704752edd.7;
        Tue, 27 Oct 2020 12:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DCnp21W838z3J54dqoT+LPZURnglQ0VUhiX4g0DgzEM=;
        b=t6BUAd/p6xwdy6r6cAW1AjllXbBOFhn/BnO5pUxZ1kEnSTJAXkJVU61whMB6qBxRTD
         yITiHFXnaHwSqcymOJxNywv1YJ5JcEV/aAp5XhHogrnNmKGxqQNIB6qihPPoCX8PRsOI
         OAxPvJFr5bDMqqU+hJobkc8Dzb1HhxIzWbgyrd51kHv2HR2u05EwPl+bi3tPH7ThU4oj
         rWrhyrVYrQvEyE9OMTP0ovTp3ZUQhZ4DOev8Dkxb2i3fHhJeXXRpKKV6M6KowJZIg28W
         Jgm9C/lzpfcrGWwSBnIrzt/PnWA18NdIy8QSL9vn9acEGQqu5mH7+pbWEyVYf7PrUazx
         w01Q==
X-Gm-Message-State: AOAM5336xRqrJxnkNPctZ40cCDUM0KTCxuB0IrsFRVRRLhobPOCZxwB5
        N2i+EcWzoVpC57auddFu7n0=
X-Google-Smtp-Source: ABdhPJyGc94tfyRFl9VLzlaneyVsIYgUVM3YkjJxfOPWRF2V8kbYt5rWKEKhzQ7H5M62+MCIviirCw==
X-Received: by 2002:a50:e447:: with SMTP id e7mr4040757edm.263.1603828117108;
        Tue, 27 Oct 2020 12:48:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id ss7sm1615086ejb.28.2020.10.27.12.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:48:35 -0700 (PDT)
Date:   Tue, 27 Oct 2020 20:48:33 +0100
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
Message-ID: <20201027194833.GE140636@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-14-digetx@gmail.com>
 <20201027102506.GB17089@kozik-lap>
 <f38984b6-d53f-a43d-0387-e787b3c1924d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f38984b6-d53f-a43d-0387-e787b3c1924d@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 10:19:28PM +0300, Dmitry Osipenko wrote:
> 27.10.2020 13:25, Krzysztof Kozlowski пишет:
> > On Mon, Oct 26, 2020 at 01:16:56AM +0300, Dmitry Osipenko wrote:
> >> External memory controller is interconnected with memory controller and
> >> with external memory. Document new interconnect property which turns
> >> External Memory Controller into interconnect provider.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml   | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> >> index 278549f9e051..ac00832ceac1 100644
> >> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> >> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> >> @@ -29,6 +29,9 @@ properties:
> >>      items:
> >>        - const: emc
> >>  
> >> +  "#interconnect-cells":
> >> +    const: 0
> >> +
> >>    nvidia,memory-controller:
> >>      $ref: /schemas/types.yaml#/definitions/phandle
> >>      description:
> >> @@ -327,6 +330,7 @@ required:
> >>    - clocks
> >>    - clock-names
> >>    - nvidia,memory-controller
> >> +  - "#interconnect-cells"
> > 
> > Another required property, what about all existing users of this binding?
> 
> EMC/devfreq drivers check presence of the new properties and ask users
> to upgrade the DT. The kernel will continue to work fine using older
> DTBs, but devfreq driver won't load.

If the devfreq was working fine before (with these older DTBs and older
kernel) then you break the feature.

If devfreq was not working or was not stable enough, then nothing is
broken so such change is accepted.

Which one is then?

> 
> >>  additionalProperties: false
> >>  
> >> @@ -345,6 +349,7 @@ examples:
> >>  
> >>          #iommu-cells = <1>;
> >>          #reset-cells = <1>;
> >> +        #interconnect-cells = <1>;
> > 
> > You meant '0'?
> 
> '1' is for the "mc" node in the example (not "emc" node).
> 
> Anyways, I'll move this hunk to the previous patch in order to fix the
> kernel bot warning.

Right, thanks.

Best regards,
Krzysztof

