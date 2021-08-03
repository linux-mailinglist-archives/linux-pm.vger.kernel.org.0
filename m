Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50A13DF546
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhHCTRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 15:17:46 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:34451 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbhHCTRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 15:17:45 -0400
Received: by mail-il1-f176.google.com with SMTP id a14so20505202ila.1;
        Tue, 03 Aug 2021 12:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X1PN+FXcllZposMsv/wBmiMU+F0yrr+LYFew9Nm0w9I=;
        b=NPd1w4M0XJy5rA/ePl01hqXUOMrEjvbDNKfwQ7TYtXsHKg5on1fKSEGOIPuOZCvVoc
         JbpSnlQehbxuvDBNVsQBNQNGMZLj9cs60NHaww4tjiKxSp0RWIi5noIeguNfpwbu9p9H
         DB1efoErKmBmcnZ1nSxJiZnyIeEKd3kXFTsn3DNLbzPJoa+HW8Wdw/Vh4UPQ5AbuHxXF
         Sm2aUQeeu21Kd/HhEecM6OPMnC3tWkNWd9wjsz5AN09f0PURzr8QPQJg3buGqxjOdCOB
         Rw3ObrSz1LeXDovsYBWwpej6NdRXtsYdXgW1d8KVock1BHVIijQO0tAJJWa44w9nZsAI
         0kBg==
X-Gm-Message-State: AOAM530GE+0IVIsfXK72vihZaVaKXxZX9qvEPcStmFPaKjYR2eBWV6eL
        RyvjlqkymbwNB2+DTnJSjg==
X-Google-Smtp-Source: ABdhPJzhu2esfDB7VNUpLzlnS6yiTNM/VUqJ7WfIVheAbGPrU6X0bxACS+OMP9w+D/qBxhD93aOWZQ==
X-Received: by 2002:a92:de07:: with SMTP id x7mr1911620ilm.293.1628018253359;
        Tue, 03 Aug 2021 12:17:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s195sm10469384ios.38.2021.08.03.12.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:17:32 -0700 (PDT)
Received: (nullmailer pid 3587156 invoked by uid 1000);
        Tue, 03 Aug 2021 19:17:30 -0000
Date:   Tue, 3 Aug 2021 13:17:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <YQmWSj0g9ZcZGHtg@robh.at.kernel.org>
References: <1627574891-26514-1-git-send-email-hector.yuan@mediatek.com>
 <1627574891-26514-2-git-send-email-hector.yuan@mediatek.com>
 <20210803050538.g6aj2zsep735ywqv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803050538.g6aj2zsep735ywqv@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 03, 2021 at 10:35:38AM +0530, Viresh Kumar wrote:
> On 30-07-21, 00:08, Hector Yuan wrote:
> > From: "Hector.Yuan" <hector.yuan@mediatek.com>
> > 
> > Add devicetree bindings for MediaTek HW driver.
> > 
> > Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> > ---
> >  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   70 ++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> > new file mode 100644
> > index 0000000..6bb2c97
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek-hw.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek's CPUFREQ Bindings
> > +
> > +maintainers:
> > +  - Hector Yuan <hector.yuan@mediatek.com>
> > +
> > +description:
> > +  CPUFREQ HW is a hardware engine used by MediaTek
> > +  SoCs to manage frequency in hardware. It is capable of controlling frequency
> > +  for multiple clusters.
> > +
> 
> Should this somewhere have a reference to
> Documentation/devicetree/bindings/dvfs/performance-domain.yaml ?
> 
> > +properties:
> > +  compatible:
> > +    const: mediatek,cpufreq-hw
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> > +      Addresses and sizes for the memory of the
> > +      HW bases in each frequency domain.
> > +
> > +  "#performance-domain-cells":
> > +    description:
> > +      Number of cells in a performance domain specifier. Typically 1 for nodes
> > +      providing multiple performance domains (e.g. performance controllers),
> > +      but can be any value as specified by device tree binding documentation
> > +      of particular provider.
> 
> You say this can have any value, 1 or more, but then ...
> 
> > +    const: 1
> 
> You fix it to 1 ?
> 
> Perhaps you should add a reference to the performance-domain.yaml here
> as well, and say const 1 here and describe how the parameter is going
> to be used. You should only explain it in respect to your SoC.

Correct in terms of what should be described, but no need to reference 
performance-domain.yaml.

Rob
