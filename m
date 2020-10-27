Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E622129C91C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830349AbgJ0Tjg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 27 Oct 2020 15:39:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37830 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504405AbgJ0Tjf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:39:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id o18so2697061edq.4;
        Tue, 27 Oct 2020 12:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=prGqBiI5JimrXFF/vzXUDQaJ2EGlRDSeqqtNy7sjrCk=;
        b=eeR7ZZa3mX1J7wzslIN5qYkm+IQGhYbwJeOmzoTdhUPcL86D23ES7Jl5HoyCXGruDH
         KTLluNLroz3oyiWpKcmD4dzPWoGbfnHGdbbhXlBwN+9m1/dDEacXhT9P97iQ0CLzb0Sc
         fVzvHsbz+8fRmGrr/XFkCXGdFvEaA0N74CbVK+qmZQXBFh9krF5qDFV2PsPhRU6mZrR8
         9ldQtTdh7mhiFABYLipfG6XGZxdK/PbDwlF7mYu6ANQIlgQSWeIl+vBFDvfFIcNtCXhG
         7TkJD2+HMG50DA1gbOBxIVkSJTtEHoOpele95FXOm1rvC86K8M+1675sqGa+zdawEufW
         JWiQ==
X-Gm-Message-State: AOAM531T+qFshkMml7G943NSB/MjydGTj0s1rC7pkm4WIbrnXzhxi6hE
        SnCkcDpDho/Da1wTAEM5lDc=
X-Google-Smtp-Source: ABdhPJx/SLYaSJuvkdADGSTZROEQyUbm34KcNB5Cvm3aHaUVFHZ7v9Fg+sHR2VzYjZ1cuP6eGnu2Ow==
X-Received: by 2002:a50:d0d0:: with SMTP id g16mr3879489edf.18.1603827573664;
        Tue, 27 Oct 2020 12:39:33 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id n22sm1534573edr.11.2020.10.27.12.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:39:32 -0700 (PDT)
Date:   Tue, 27 Oct 2020 20:39:30 +0100
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
Subject: Re: [PATCH v6 09/52] dt-bindings: memory: tegra30: mc: Document new
 interconnect property
Message-ID: <20201027193930.GC140636@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-10-digetx@gmail.com>
 <20201027090550.GI4244@kozik-lap>
 <7770b89e-f30b-3bfd-1e21-8ebbe905efcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <7770b89e-f30b-3bfd-1e21-8ebbe905efcd@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 10:18:35PM +0300, Dmitry Osipenko wrote:
> 27.10.2020 12:05, Krzysztof Kozlowski пишет:
> > On Mon, Oct 26, 2020 at 01:16:52AM +0300, Dmitry Osipenko wrote:
> >> Memory controller is interconnected with memory clients and with the
> >> External Memory Controller. Document new interconnect property which
> >> turns memory controller into interconnect provider.
> >>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
> >> index 84fd57bcf0dc..5436e6d420bc 100644
> >> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
> >> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
> >> @@ -57,6 +57,9 @@ properties:
> >>    "#iommu-cells":
> >>      const: 1
> >>  
> >> +  "#interconnect-cells":
> >> +    const: 1
> >> +
> >>  patternProperties:
> >>    "^emc-timings-[0-9]+$":
> >>      type: object
> >> @@ -120,6 +123,7 @@ required:
> >>    - clock-names
> >>    - "#reset-cells"
> >>    - "#iommu-cells"
> >> +  - "#interconnect-cells"
> > 
> > Rob,
> > 
> > You were fine with adding a new required property which breaks all
> > existing DTBs?
> 
> This is a required property for the new bindings and optional for the
> older. Does it really need to be made optional in the binding?

Mhmm... that's an interesting point. I assumed that the bindings should
reflect current status of the ABI, but I could imagine that you update
the bindings while keeping the driver working with older DTBs.

How do you actually track then the ABI? If incompatible change can be
added to the bindings, later anyone anytime can also update the driver
to enforce the bindings. To require such property.

Best regards,
Krzysztof


> 
> > Were these bindings marked as unstable? The patchset does not even
> > say/scream that it breaks the ABI, so this might be quite a surprise for
> > someone...
> 
> Please see tegra_mc_interconnect_setup() in "memory: tegra-mc: Add
> interconnect framework" patch, which check presence of the new ICC DT
> property.
