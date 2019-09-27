Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF1EC0188
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfI0IyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 04:54:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfI0IyP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 04:54:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so1774019wrj.6;
        Fri, 27 Sep 2019 01:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YW69Gs/nZumApetQocA64F9f6OkcL5o8Z3LcVdigjvc=;
        b=rCJ9PS1DXGNWZMIOYIPNeGsw2OIqoxdHgSWa3nN1Y4lHXBpaPz7aljO3XtKFfklxXs
         UZTjfzAuW/jOqBoHZy0PlPHbemU3Zmaj2nprs0Wi80JMsxC/9PREHW50naRMJq3lWj99
         mdsjwKaFXgFhPD/9OjjzMTQHmqKsvUPWahRmbgHSui3jS0YW0pYqg+E+hLLTuMpetxNZ
         MIy7liK2yISmzbNtVkaXZzPIqP8b4qPA3p92h11FZmY/iHzR7wlX4H7ZeQypsrGN0MjV
         DmPudK47p+cD448LfyxzALCLkrGvbl9sZfZaIpQDRnSmqdL45sHVzZnAg/cKB1gEcQdz
         o3IA==
X-Gm-Message-State: APjAAAU+d2F1lTU3wYIpA7FHsjpmo7tjX8JOeDWlSVPWuK0cgvh0Abjc
        /0GhZ4JuH8TdKDNCulOH3sQ=
X-Google-Smtp-Source: APXvYqw32zeeQTuvXuVsep+HUirogNC0QVZEqwyQa06udnJ+HOwPMSz7jgPC+e9bId+phk4DAB4dwg==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr2169788wrp.143.1569574452936;
        Fri, 27 Sep 2019 01:54:12 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id l6sm4346315wmg.2.2019.09.27.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:54:12 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:53:59 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH 1/3] ARM: dts: exynos: Add interrupt to DMC controller in
 Exynos5422
Message-ID: <20190927085359.GA19131@pi3>
References: <20190925161813.21117-1-l.luba@partner.samsung.com>
 <CGME20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f@eucas1p2.samsung.com>
 <20190925161813.21117-2-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925161813.21117-2-l.luba@partner.samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 25, 2019 at 06:18:11PM +0200, Lukasz Luba wrote:
> Add interrupt to Dynamic Memory Controller in Exynos5422 and Odroid
> XU3-family boards. It will be used instead of devfreq polling mode
> governor. The interrupt is connected to performance counters private
> for DMC, which might track utilisation of the memory channels.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index ac49373baae7..72738e620d11 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -240,6 +240,8 @@
>  		dmc: memory-controller@10c20000 {
>  			compatible = "samsung,exynos5422-dmc";
>  			reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
> +			interrupt-parent = <&combiner>;
> +			interrupts = <16 0>;

You register DMC for DREX0 and DREX1 but take only DREX0 interrupt. Why
skipping second?

Best regards,
Krzysztof


>  			clocks = <&clock CLK_FOUT_SPLL>,
>  				 <&clock CLK_MOUT_SCLK_SPLL>,
>  				 <&clock CLK_FF_DOUT_SPLL2>,
> -- 
> 2.17.1
> 
