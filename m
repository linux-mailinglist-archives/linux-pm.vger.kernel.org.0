Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB44128BD
	for <lists+linux-pm@lfdr.de>; Tue, 21 Sep 2021 00:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhITWUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 18:20:18 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:36811 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhITWSS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 18:18:18 -0400
Received: by mail-oi1-f180.google.com with SMTP id y201so12134803oie.3;
        Mon, 20 Sep 2021 15:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X6Dg2kZ+RuFpdfWPr4SKLTE5pZ2Koj+j45EvqYukxNI=;
        b=LlIkZydsGrGE+a2W3EFZQ62+q/QxfPEFG/EjSQAsWwOVBTS4ioALTzLX4oDqnXWjIF
         QcicJ2oo3QN4oZEj5qNkhP0KJ2jXQLGemfF4UwFxst9NHqk1pretvMJ29HjYkoaJX7cD
         FtIDk7u2e0xe640W7FeSjBcBmnFmRDdHobwkOqPVIaCxrQoi5H6IVMhDc1n+SwOQ/80p
         nHZ9gba65PSpRQotpneT2EFBW8iAC26F6JbBbhC9Iosc0m0nETBDRVMYTpvy0sRLwhc4
         B47M54jkVPq7OOdtf++lIDnXU8owewWEOOXI8QJN6FE46YpRdQSfcLGWRmZKVUwO4E4v
         OV6Q==
X-Gm-Message-State: AOAM530nRo2spWhSWnsO87KXQmNY9Yo641oYvaHXHyuzjEMJg3RKyjh6
        obyWFcvkhbGBEgAShGNhDA==
X-Google-Smtp-Source: ABdhPJxxFiHuSeI1aysQlkpw2QvPSQ4QYEo5fJgn4tNf5BzSTXiQZlB02XRSXSA6aiB06/+DKxkINA==
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr1052756ois.69.1632176210286;
        Mon, 20 Sep 2021 15:16:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p67sm260373oig.17.2021.09.20.15.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:16:49 -0700 (PDT)
Received: (nullmailer pid 892703 invoked by uid 1000);
        Mon, 20 Sep 2021 22:16:48 -0000
Date:   Mon, 20 Sep 2021 17:16:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] dt-bindings: thermal: allow more resets for
 tsadc node in rockchip-thermal.yaml
Message-ID: <YUkIUBs3FC4WKJ2M@robh.at.kernel.org>
References: <20210906120404.10005-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906120404.10005-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 06, 2021 at 02:04:01PM +0200, Johan Jonker wrote:
> The tsadc node in rk356x.dtsi has more resets defined then currently
> allowed by rockchip-thermal.yaml, so fix that in the documentation.
> The driver now uses the devm_reset_control_array_get() function,
> so reset-names is no longer required, but keep it for legacy reasons.

I don't think I'd deprecate it for that reason.

And removing it would break any kernel before the 
devm_reset_control_array_get change.

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/thermal/rockchip-thermal.yaml     | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> index b96ea277b..ee104e451 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> @@ -37,11 +37,16 @@ properties:
>        - const: apb_pclk
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
>  
>    reset-names:
> +    deprecated: true
> +    minItems: 1
>      items:
>        - const: tsadc-apb
> +      - const: tsadc
> +      - const: tsadc-phy
>  
>    "#thermal-sensor-cells":
>      const: 1
> @@ -71,7 +76,6 @@ required:
>    - clocks
>    - clock-names
>    - resets
> -  - reset-names
>    - "#thermal-sensor-cells"
>  
>  additionalProperties: false
> -- 
> 2.20.1
> 
> 
