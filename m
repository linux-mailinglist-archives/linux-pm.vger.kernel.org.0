Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59D9367449
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 22:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245682AbhDUUrR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245680AbhDUUrQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 16:47:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73493C06174A;
        Wed, 21 Apr 2021 13:46:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r20so15674683ejo.11;
        Wed, 21 Apr 2021 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mwA7U89lJEzuVYY4NBj5/0Sac5QuTUrv3frbg9+Ss50=;
        b=OBdZKXQhp6amdUxwDMrxUdDnZ7bFWYnCq2bMTS6vayg38qNR1gjv8QT6w8R/PTcJt7
         5NoFXo74BTSXQ/HVO+54leZVuZY5JT634Kct3cFcm7REIQ9zjDZO4PcNIerT1rqn4nLr
         r4kmaGe54BKlwGItBnrNLAoloTr1kAMy8vRgeiOHrMMWJHouwQ5gw4361lgONTEMPPRt
         Kw6XbuMuFH1Nje755UDVxxmTVqwTzaYyFh3PEHsTsGFtVIp+jn9ah7OY4HpRf4DJ0+Gy
         IIvMoljLhMLuc69Ns6ga4Jyteu5UtwKWk50JL6EsFM3LuGJ+4eEpjIvTKWkMr+3tsKi8
         e70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mwA7U89lJEzuVYY4NBj5/0Sac5QuTUrv3frbg9+Ss50=;
        b=jFP52NwJeVLUlkgYfvSWlC3Iv040dWSv0w5PWNknUUYb/vyXARXyYS4SFPtgbEQ0zr
         Vfhpo0LjLGVznx1va2UuO98E/SMF+nb5w+rIC6PUuH8c8GEBH6TzIAwX61l8Hph+z8Jj
         GtCtycYyp0CBhai2pNlNDokOAY5z0n9J+b4MKMs5OnFAf3mMRF7PzgApaFylMGF7zJjy
         LGvZpv0xmSM871jD96o4agvUBiw259n3kzdJjUHzlhmt7aJ+PzTsr5ywGmR/w1e1Xh7w
         k/Ip6/uOE0KpE4COxWqT4k2aWaslPyhAeZFFcfQopFj5lLrpULzF72p2JYzSSOog/m0N
         bDhQ==
X-Gm-Message-State: AOAM533n3ra1IQ6t8cc+xtNbz8hLctwYeZK5LG0HUwuDyc/hdeMlnESK
        +96zCtjeOHTaa6OnYxmJpNk=
X-Google-Smtp-Source: ABdhPJxBFLPcjQTNrrm43tdjwZtx7hu0uaeW/3GTquaWi1R+THhzYJKKVuAn5Ie/9hGb9gUTWfgY/w==
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr35008439ejk.338.1619038001132;
        Wed, 21 Apr 2021 13:46:41 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ck29sm397680edb.47.2021.04.21.13.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 13:46:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3568 SoC
 compatible
To:     Ezequiel Garcia <ezequiel@collabora.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
References: <20210421200445.32977-1-ezequiel@collabora.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <557ae27c-1d62-69e0-7ae6-921571059f9f@gmail.com>
Date:   Wed, 21 Apr 2021 22:46:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210421200445.32977-1-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/21/21 10:04 PM, Ezequiel Garcia wrote:
> Add a new compatible for the thermal sensor device on RK3568 SoCs.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index 7f94669e9ebe..346e466c2006 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -9,6 +9,7 @@ Required properties:
>     "rockchip,rk3328-tsadc": found on RK3328 SoCs
>     "rockchip,rk3368-tsadc": found on RK3368 SoCs
>     "rockchip,rk3399-tsadc": found on RK3399 SoCs

> +   "rockchip,rk3568-tsadc": found on RK3568 SoCs

This is still a text document.
rob+dt has now scripts that check for undocumented compatibility
strings, so first convert rockchip-thermal.txt to YAML and then add this
in a separated patch.

Johan

>  - reg : physical base address of the controller and length of memory mapped
>  	region.
>  - interrupts : The interrupt number to the cpu. The interrupt specifier format
> 

