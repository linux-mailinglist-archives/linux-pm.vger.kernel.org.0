Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A282227B4F9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 21:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI1TFa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 15:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1TFa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 15:05:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4E7C061755;
        Mon, 28 Sep 2020 12:05:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ay8so2823294edb.8;
        Mon, 28 Sep 2020 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=hRTBwQSNskyyWTt7HoaboYk425+EVn9mSaFvm7gVvzI=;
        b=kFEqroD0yn0X0PdULijc1NU8Yf7u7hfECskpCWz8xWDN1nURcXG8azPKpLiY+2WNbi
         FnIPi7cgFD53pS4rdmIzMlW+jPP+14zucxYTDmCn+kXI8hFN1dNK4vvLchiH59Q7gLYj
         +fk+aFzFyspooNVybhD2qJhC2KPLrzw70qFkJv0na+dudpfjmZPr8zUVGX9eRa8/L9Fg
         NBLAGehzqlzq7I0X6pRgMg4UkjER7e2fo2oN+73TvgYYgfNdG3V5my6yhsMD/mm4I7Wv
         8ym7fzBwMghRp0GiNfc3B7ZRMfIFWpP6WyJCmvXbQPstb8DI2nuNnXDyxdRyoO9pbl06
         6dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=hRTBwQSNskyyWTt7HoaboYk425+EVn9mSaFvm7gVvzI=;
        b=XXnqN6LxcmDuOwvpBdvxogvbJ/1dbOkEuWho4mzHfpf03Kv1muC6lpI1K+b/2HvZIV
         Gt64RW1fIZiYT1sZHJKmZlnnWB5hAuGDRk/booJ2ozCK+1t+5nK9G5THrVcbZj/aXYdK
         K4lUFTHZYIRnos+D4+0hsuFqdEF8cbiuQSiAcWQqNiBbJvKE/QRjzVyuegse1XKVnPk2
         r6u+cQXx4iEypzPL59uyz3idpiRtFe+vEjMFHD12QIgLMMo8kumA3rGEjF5tq8B1u98m
         Su15pDbA2IFTpOW+bnWeZhrQtjgADjlUcdYQCaqXCSMc4uKolU1BYsQxouG1xRB2DDUs
         9IqA==
X-Gm-Message-State: AOAM532ICzpiepqbrbmVRy3zLwDgJM0/lZSqe21EcILgsfCo+MZ7t3np
        O3Z3b4SeEYZQKEEFq/57Xx6/S1ELj/W6sc8K
X-Google-Smtp-Source: ABdhPJyx1WFcLiVlf3JIRvX3dBSFpqSlvJxG8RGuzVpj4dxGjImJVhR7Jq4xn/oIqgvpaQK+KLO/MQ==
X-Received: by 2002:a50:e3c4:: with SMTP id c4mr3550332edm.90.1601319926893;
        Mon, 28 Sep 2020 12:05:26 -0700 (PDT)
Received: from AnsuelXPS (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.gmail.com with ESMTPSA id x12sm2832585edq.77.2020.09.28.12.05.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 12:05:26 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200927160515.6480-1-ansuelsmth@gmail.com> <20200927160515.6480-2-ansuelsmth@gmail.com> <20200928180839.GB2999374@bogus>
In-Reply-To: <20200928180839.GB2999374@bogus>
Subject: RE: [PATCH 2/2] dt-bindings: devfreq: Document L2 Krait CPU Cache devfreq driver
Date:   Mon, 28 Sep 2020 21:05:24 +0200
Message-ID: <002401d695ca$52c2f850$f848e8f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQKHJ8vfj37MLqL4um7J+At48GMuxQIRgZ/YAlxGVsun+dZE4A==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, September 28, 2020 8:09 PM
> To: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>; Kyungmin Park
> <kyungmin.park@samsung.com>; Chanwoo Choi
> <cw00.choi@samsung.com>; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] dt-bindings: devfreq: Document L2 Krait CPU
> Cache devfreq driver
> 
> On Sun, Sep 27, 2020 at 06:05:13PM +0200, Ansuel Smith wrote:
> > Document dedicated L2 Krait CPU Cache devfreq scaling driver.
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/devfreq/krait-cache-devfreq.yaml | 77
> +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/devfreq/krait-
> cache-devfreq.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/devfreq/krait-cache-
> devfreq.yaml b/Documentation/devicetree/bindings/devfreq/krait-cache-
> devfreq.yaml
> > new file mode 100644
> > index 000000000000..099ed978e022
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/krait-cache-
> devfreq.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cpufreq/krait-cache-devfreq.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DEVFREQ driver for Krait L2 Cpu Cache Frequency Scaling
> 
> Bindings are for h/w devices, not collections of properties for some
> driver. Define a binding for L2 cache and add on to it what you need.
> 

Should I still document it in the devfreq directory or somewhere else?

> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  This Scale the Krait CPU L2 Cache Frequency and optionally voltage
> > +  when the Cpu Frequency is changed (using the cpufreq notifier).
> > +
> > +  Cache is scaled with the max frequency across all core and the cache
> > +  frequency will scale based on the configured threshold in the dts.
> > +
> > +  The cache thresholds can be set to 3+ frequency bin, idle, nominal
and
> > +  high.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,krait-cache
> > +
> > +  clocks:
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> 
> 'clocks' already has a type defined. You just need how many and what
> each entry is.
> 
> > +    description: Phandle to the L2 CPU clock
> > +
> > +  clock-names:
> > +    const: "l2"
> > +
> > +  voltage-tolerance:
> > +    description: Same voltage tolerance of the Krait CPU
> 
> Needs a vendor prefix and unit suffix.
> 
> > +
> > +  l2-cpufreq:
> > +    description: |
> > +      Threshold used by the driver to scale the L2 cache.
> > +      If the max CPU Frequency is more than the set frequency,
> > +      the driver will transition to the next frequency bin.
> > +      Value is in kHz
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 3
> > +    items:
> > +      - description: idle
> > +      - description: nominal
> > +      - description: high
> > +
> > +  l2-supply:
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > +    description: Phandle to the L2 regulator supply.
> > +
> > +  opp-table: true
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - clock-names
> > +  - voltage-tolerance
> > +  - l2-cpufreq
> > +
> > +examples:
> > +  - |
> > +    qcom-krait-cache {
> > +      compatible = "qcom,krait-cache";
> > +      clocks = <&kraitcc 4>;
> > +      clock-names = "l2";
> > +      l2-cpufreq = <384000 600000 1200000>;
> > +      l2-supply = <&smb208_s1a>;
> > +
> > +      operating-points = <
> 
> Not documented and generally deprecated.
> 

Ok will change to v2.

> > +        /* kHz    uV */
> > +        384000  1100000
> > +        1000000  1100000
> > +        1200000  1150000
> > +      >;
> > +    };
> > --
> > 2.27.0
> >

