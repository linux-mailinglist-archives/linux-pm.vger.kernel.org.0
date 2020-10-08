Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8092875C1
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgJHOL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbgJHOL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 10:11:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF2C0613D3
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 07:11:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so4106824pfd.5
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ewlqa4YGSRfej2ERDe7UUyzDvvxiKmyd107uBj/fY5E=;
        b=fHZRsibpdKUAzFgiJ+a+61FvDU3WoCH3bGSUk3qiYz0kURPizsunM6p8R7GUL7N2Z5
         Z1IbeUaNncYLyzmQm85Y2SvDxd6EcEBGZGkeFHeTvuU/JApv3QR1KMOgvBmOOLjEVjzT
         mIQLjCfDdvf3MWKvWGtc+3IYgNa3YedAXEMZK3iWG99Q4InZsDfaeyLz2eYURaUlHEPE
         Q3UCHreRRqjz2uCMj85ywTh62UEF8TzvoLdM7KQv4It/ue4KLyWIEeX1FDu2D50qWMFT
         jg6zB9wq+DfsSgliYF2hTe+nEOchDkxflvyJJ+CXh/deob+gYbGMugCOut1sh/SeXqHG
         mXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ewlqa4YGSRfej2ERDe7UUyzDvvxiKmyd107uBj/fY5E=;
        b=YUrguxP6D/SDdw4nvRc816hf+isavRuBR3++iAZA25EWq+jg47kxaCPKkZKnh8Leej
         fznVyw2cIWdpWp//JxPmVwSmuPAY2npT/4IOGUarc+VXiJFcuFoUkBawxYXwgxfmsSZG
         JSNFgAr6CuW67AV9MMSjfFw2VQRBV6TQqSjDfO6Ms68J0OHc2T/KrOJEff9hKj6S0fOM
         B3fTODw8+PFw9XnxXO/yzP0XMHOgmgzS/C20qiNwBiuG3oWP6BOHaC6wFtzF/+eHL65j
         cDR6fsCZmtvpE7rclgcnPr0pJ2LnnnSuftGp+1H3x0CQMGBkZTom1Yd421T4rIpHcVx5
         caqg==
X-Gm-Message-State: AOAM532UBZT3fTC9dhom+Amu/OwJbapjHk8kEeNf8YCPQ3m/RXaUglcw
        G9OkJZBkmFCCuKNYVrtvuxQt
X-Google-Smtp-Source: ABdhPJy4b+RQNJCpBuKbqjGp0tS7Nqdx2Rvy8z0BUnRmK36T+BC0SofKw5b+zS0nWNSVkmuVuHUCfg==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr7520953pgb.444.1602166287414;
        Thu, 08 Oct 2020 07:11:27 -0700 (PDT)
Received: from linux ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id w23sm7225236pjh.49.2020.10.08.07.11.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 07:11:26 -0700 (PDT)
Date:   Thu, 8 Oct 2020 19:41:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML
 bindings
Message-ID: <20201008141120.GC23649@linux>
References: <20201006095047.30242-1-manivannan.sadhasivam@linaro.org>
 <20201007155352.GA285247@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007155352.GA285247@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 07, 2020 at 10:53:52AM -0500, Rob Herring wrote:
> On Tue, Oct 06, 2020 at 03:20:47PM +0530, Manivannan Sadhasivam wrote:
> > Convert Qualcomm cpufreq devicetree binding to YAML.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 --------------
> >  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 212 ++++++++++++++++++
> >  2 files changed, 212 insertions(+), 172 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> > new file mode 100644
> > index 000000000000..a11c69a29b5d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> > @@ -0,0 +1,212 @@

[...]

> > +
> > +  '#freq-domain-cells':
> > +    const: 1
> > +
> > +  qcom,freq-domain:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    maxItems: 1
> > +    description:
> > +      Devices supporting freq-domain must set their "qcom,freq-domain"
> > +      property with phandle to a cpufreq_hw followed by the Domain ID(0/1)
> > +      in the CPU DT node.
> 
> This doesn't belong here as it goes in cpu nodes. You're going to need 
> to define a QCom cpu schema that defines this.
> 

Okay. It was there in the original binding so I just kept it. Will remove it
in next iteration.

Thanks,
Mani

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - clock-names
> > +  - '#freq-domain-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> > +    #include <dt-bindings/clock/qcom,rpmh.h>
> > +
> > +    // Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster
> > +    // switch DCVS state together.
> > +    cpus {
> > +      #address-cells = <2>;
> > +      #size-cells = <0>;
> > +
> > +      CPU0: cpu@0 {
> > +        device_type = "cpu";
> > +        compatible = "qcom,kryo385";
> > +        reg = <0x0 0x0>;
> > +        enable-method = "psci";
> > +        next-level-cache = <&L2_0>;
> > +        qcom,freq-domain = <&cpufreq_hw 0>;
> > +        L2_0: l2-cache {
> > +          compatible = "cache";
> > +          next-level-cache = <&L3_0>;
> > +          L3_0: l3-cache {
> > +            compatible = "cache";
> > +          };
> > +        };
> > +      };
> > +
> > +      CPU1: cpu@100 {
> > +        device_type = "cpu";
> > +        compatible = "qcom,kryo385";
> > +        reg = <0x0 0x100>;
> > +        enable-method = "psci";
> > +        next-level-cache = <&L2_100>;
> > +        qcom,freq-domain = <&cpufreq_hw 0>;
> > +        L2_100: l2-cache {
> > +          compatible = "cache";
> > +          next-level-cache = <&L3_0>;
> > +        };
> > +      };
> > +
> > +      CPU2: cpu@200 {
> > +        device_type = "cpu";
> > +        compatible = "qcom,kryo385";
> > +        reg = <0x0 0x200>;
> > +        enable-method = "psci";
> > +        next-level-cache = <&L2_200>;
> > +        qcom,freq-domain = <&cpufreq_hw 0>;
> > +        L2_200: l2-cache {
> > +          compatible = "cache";
> > +          next-level-cache = <&L3_0>;
> > +        };
> > +      };
> > +
> > +      CPU3: cpu@300 {
> > +        device_type = "cpu";
> > +        compatible = "qcom,kryo385";
> > +        reg = <0x0 0x300>;
> > +        enable-method = "psci";
> > +        next-level-cache = <&L2_300>;
> > +        qcom,freq-domain = <&cpufreq_hw 0>;
> > +        L2_300: l2-cache {
> > +          compatible = "cache";
> > +          next-level-cache = <&L3_0>;
> > +        };
> > +      };
> > +
> > +      CPU4: cpu@400 {
> > +        device_type = "cpu";
> > +        compatible = "qcom,kryo385";
> > +        reg = <0x0 0x400>;
> > +        enable-method = "psci";
> > +        next-level-cache = <&L2_400>;
> > +        qcom,freq-domain = <&cpufreq_hw 1>;
> > +        L2_400: l2-cache {
> > +          compatible = "cache";
> > +          next-level-cache = <&L3_0>;
> > +        };
> > +      };
> > +
> > +      CPU5: cpu@500 {
> > +        device_type = "cpu";
> > +        compatible = "qcom,kryo385";
> > +        reg = <0x0 0x500>;
> > +        enable-method = "psci";
> > +        next-level-cache = <&L2_500>;
> > +        qcom,freq-domain = <&cpufreq_hw 1>;
> > +        L2_500: l2-cache {
> > +          compatible = "cache";
> > +          next-level-cache = <&L3_0>;
> > +        };
> > +      };
> > +
> > +      CPU6: cpu@600 {
> > +        device_type = "cpu";
> > +        compatible = "qcom,kryo385";
> > +        reg = <0x0 0x600>;
> > +        enable-method = "psci";
> > +        next-level-cache = <&L2_600>;
> > +        qcom,freq-domain = <&cpufreq_hw 1>;
> > +        L2_600: l2-cache {
> > +          compatible = "cache";
> > +          next-level-cache = <&L3_0>;
> > +        };
> > +      };
> > +
> > +      CPU7: cpu@700 {
> > +        device_type = "cpu";
> > +        compatible = "qcom,kryo385";
> > +        reg = <0x0 0x700>;
> > +        enable-method = "psci";
> > +        next-level-cache = <&L2_700>;
> > +        qcom,freq-domain = <&cpufreq_hw 1>;
> > +        L2_700: l2-cache {
> > +          compatible = "cache";
> > +          next-level-cache = <&L3_0>;
> > +        };
> > +      };
> > +    };
> > +
> > +    soc {
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> > +
> > +      cpufreq@17d43000 {
> > +        compatible = "qcom,cpufreq-hw";
> > +        reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> > +        reg-names = "freq-domain0", "freq-domain1";
> > +
> > +        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> > +        clock-names = "xo", "alternate";
> > +
> > +        #freq-domain-cells = <1>;
> > +      };
> > +    };
> > +...
> > -- 
> > 2.17.1
> > 
