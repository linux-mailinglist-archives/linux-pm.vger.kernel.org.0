Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9791A3BB53A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 04:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhGECoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 22:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhGECoP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 22:44:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A5C061764
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 19:41:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s13so6370683plg.12
        for <linux-pm@vger.kernel.org>; Sun, 04 Jul 2021 19:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZT0IB8PyrcyI+vUYYRnvizBup5kvPBJopYhabL46eW0=;
        b=HsqdB6Dr2Qmyfa5EL9QagjexZu2IN3zjWhuuzWNl+wYfQoEf4kt/aIIdavVAj5mdJZ
         W8pBrRrkuGO9MjhjeZ5ii7Zt9Wsm4lz2hQI7tASA2vplDbEnwAxBRm+EDSXYSSv9gPqA
         fN00PGRpUtRh+3rVSiPqvIZT16BrHNPpVvTWUr1Gx1uEmg8MlKZTczztGJZXrmmZDtfE
         QgWjz7jN/UjtSVDxVy+3lZXbVROrL/ol9xK1Wbp2qWfk5sBbwftwoSU9IWRztm5pzxHG
         LVRpqxdw4QYwtVgzUNouFWTcIlegLq8gxdZYqsMSkqeILZ6tdyzgeRH6z/PVJhchVcnf
         Up4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZT0IB8PyrcyI+vUYYRnvizBup5kvPBJopYhabL46eW0=;
        b=uONBaJ8bq2RdH+y+bLQ9kxN8CzP4/PqEPgIJu4qwV1afnjTFdBw/Pu0DYR7/s0dDYq
         859eaSkK5KmmynKvKwba+c4Oll7fEDlhO8L2FDDp51id2DBnhHb84Le7DOTF4Tx6Ue5o
         bTdNi4umdOXxygDD2evKBUYwmjw9lqkkOfAMq1WpIxBwtYZkGwyLEDzpWbwzdVdUrNtJ
         2At5ADdXKeY33FhFrELBNiCmyHlUBmoAvN8bX/1W1yJSGzPBsvC7x3LYcXLWH6od2c2/
         77ckXSJpcXo3slsam/cOF1G/WIV2PqmWqXFeXl0gOO/fHzU+xFLaMVccWRoRtt2Dxnn3
         pCcA==
X-Gm-Message-State: AOAM532gcs34B3ZlCW3QZF9NCv/5OTTNTksMsOvA9psBpqY3hGo37bc8
        q9dDtphJvVzberzsAFz3/Whd5A==
X-Google-Smtp-Source: ABdhPJzMwaTQxAZ9Dn3kW0FiUmmtsMbC4+rUjnuVjCNTUn3YLgucj8hV6v2sehtjPRupj4KReojNTg==
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id s8-20020a170902b188b029011b1549da31mr10351820plr.7.1625452898407;
        Sun, 04 Jul 2021 19:41:38 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g12sm3079949pjk.25.2021.07.04.19.41.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Jul 2021 19:41:37 -0700 (PDT)
Date:   Mon, 5 Jul 2021 10:41:32 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: qcom,pon: Add 'qcom,mode-in-imem'
 support
Message-ID: <20210705024131.GA11342@dragon>
References: <20210704074045.21643-1-shawn.guo@linaro.org>
 <20210704074045.21643-3-shawn.guo@linaro.org>
 <YOGArXunEf2O58gL@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOGArXunEf2O58gL@gerhold.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jul 04, 2021 at 11:36:41AM +0200, Stephan Gerhold wrote:
> On Sun, Jul 04, 2021 at 03:40:44PM +0800, Shawn Guo wrote:
> > It's not always the case that reboot mode value gets stored in PON
> > register.  For example, Sony Xperia M4 Aqua phone (MSM8939) uses a
> > different set of mode value and stores them in IMEM.  Add property
> > 'qcom,mode-in-imem' to distinguish this mechanism from the existing one.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../bindings/power/reset/qcom,pon.yaml        | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > index 7764c804af1d..a6270e39b7a2 100644
> > --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > @@ -23,6 +23,10 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  qcom,mode-in-imem:
> > +    description: Reboot mode is stored in IMEM rather than PON register
> > +    type: boolean
> > +
> >  patternProperties:
> >    "^mode-.+":
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > @@ -35,6 +39,7 @@ required:
> >  additionalProperties: false
> >  
> >  examples:
> > +  # Example 1: Reboot mode is stored in PON register
> >    - |
> >      pmic {
> >          #address-cells = <1>;
> > @@ -47,3 +52,17 @@ examples:
> >              mode-recovery = <0x1>;
> >          };
> >      };
> > +  # Example 2: Reboot mode is stored in IMEM
> > +  - |
> > +    pmic {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        pon@800 {
> > +            compatible = "qcom,pm8916-pon";
> > +            reg = <0x860065c>;
> 
> This is quite strange. pon@800 is a node of the PM8916 PMIC,
> so the reg should refer to the address inside the PMIC, not some memory
> address of the SoC. dtc will probably warn about this too since the unit
> address (@800) should match the first reg. (At least on W=1.)

Fair point.

> Actually we already have some devices using IMEM for the reboot mode,
> like this (qcom-msm8974.dtsi plus qcom-msm8974-fairphone-fp2.dts):
> 
> 	imem@fe805000 {
> 		compatible = "syscon", "simple-mfd";
> 		reg = <0xfe805000 0x1000>;
> 
> 		reboot-mode {
> 			compatible = "syscon-reboot-mode";
> 			offset = <0x65c>;
> 			mode-normal	= <0x77665501>;
> 			mode-bootloader	= <0x77665500>;
> 			mode-recovery	= <0x77665502>;
> 		};
> 	};
> 
> Perhaps it would be cleaner to add a property to disable the reboot mode
> functionality of pm8916-pon and then set it up like this?

Ah, yes, this is sensible.  Thanks for the msm8974 example!

Shawn
