Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04436FD75
	for <lists+linux-pm@lfdr.de>; Fri, 30 Apr 2021 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhD3PPb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Apr 2021 11:15:31 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43740 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3PPb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Apr 2021 11:15:31 -0400
Received: by mail-ot1-f48.google.com with SMTP id g7-20020a9d5f870000b02902a5831ad705so1497433oti.10;
        Fri, 30 Apr 2021 08:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bA+0wXYd5n62CVpjXh163QzxzPQitWk+KG3sz2AcuGk=;
        b=d2/gMBmfDJYXC6dF6bgCO7cCFU9A2ps1Y9HULSHqOQYO77oJhqj8OzAZhPUD58cIbs
         nNqAPL032bEZK6bD7HPwIAN0N4un1tJ7+2u4be85Tjs99mKnMQss9ussLVFwviaVwnsl
         mACKEYnQ0xXDj3+mO8Lczm4nXVYTaRDLuMuRBb44lX4maJhGkRBn5Mbvn/XSo8CgXmw8
         J3Dq8w8wAMnQi4Jb/hFNO42qkYddnZoTuq0CNQko5zP8IgxuJhs0Q2Ea1KAqx+7p5nq6
         73NWYPnvCgSEMswtjQeJ5wLsCJnQBrPEpVMpuqp9V/pNpXaiPKEMRLstaGESTmrL/TCq
         YVKw==
X-Gm-Message-State: AOAM532weE/UvTV8YeBiXo3ibTeeW7ftabyYx01w8jpuL+juNVUze9OU
        ZlzL1kqZTuPoWNs5cuqa9w==
X-Google-Smtp-Source: ABdhPJz7mv+WLnYokc1iKTOjYu+Sps0+GW+VV4HnXfSL+BcYqE0Bmak8+kqq5/xMCkcLRGKywhN9FA==
X-Received: by 2002:a9d:6007:: with SMTP id h7mr4179722otj.200.1619795682500;
        Fri, 30 Apr 2021 08:14:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y11sm846063oiv.19.2021.04.30.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:14:41 -0700 (PDT)
Received: (nullmailer pid 3337579 invoked by uid 1000);
        Fri, 30 Apr 2021 15:14:40 -0000
Date:   Fri, 30 Apr 2021 10:14:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3568
 SoC compatible
Message-ID: <20210430151440.GA3323801@robh.at.kernel.org>
References: <20210421200445.32977-1-ezequiel@collabora.com>
 <557ae27c-1d62-69e0-7ae6-921571059f9f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <557ae27c-1d62-69e0-7ae6-921571059f9f@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 21, 2021 at 10:46:37PM +0200, Johan Jonker wrote:
> On 4/21/21 10:04 PM, Ezequiel Garcia wrote:
> > Add a new compatible for the thermal sensor device on RK3568 SoCs.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > index 7f94669e9ebe..346e466c2006 100644
> > --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > @@ -9,6 +9,7 @@ Required properties:
> >     "rockchip,rk3328-tsadc": found on RK3328 SoCs
> >     "rockchip,rk3368-tsadc": found on RK3368 SoCs
> >     "rockchip,rk3399-tsadc": found on RK3399 SoCs
> 
> > +   "rockchip,rk3568-tsadc": found on RK3568 SoCs
> 
> This is still a text document.
> rob+dt has now scripts that check for undocumented compatibility
> strings, so first convert rockchip-thermal.txt to YAML and then add this
> in a separated patch.

Thanks for pushing on this, but for now at least, simple compatible 
additions are fine. If changes would complicate the conversion to 
schema, then we should convert it first. For example, if the new 
compatible was accompanied with differing clocks, irqs, resets, etc., 
then we should convert (or consider a separate schema).

In parallel though, we do want to get platforms to 0 undocumented (by 
schema) compatibles. And then 0 warnings after that...

Rob
