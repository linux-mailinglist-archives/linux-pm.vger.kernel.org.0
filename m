Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E176312AEAC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 22:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLZVBW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 16:01:22 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42283 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVBW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Dec 2019 16:01:22 -0500
Received: by mail-io1-f68.google.com with SMTP id n11so17453191iom.9;
        Thu, 26 Dec 2019 13:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHX15Yzi2L1Jns7nLa3IWC/ZCGyo3mc3Ea/j0HJyq2E=;
        b=K7aqgShWKtUBqWQ8XfkSGtFFxq1X0rRqekcJbhloEOFdp+z6w0nGfq8E+VzPHF9r/e
         p9fmEsqa95cgulHZoMNarzmL5AmbzYwYNlWdjsiWuOEi1egbOSuVJrWDFuce27diBBtn
         mCMwpilF3mt9BDmsyZt4DYBQ1AMWAnW7iAB1bO7egebY8hg+Jnh0d4f5f7r5fyBOmGsv
         g+0LA0InSffSeMyFXDGBRPB9Re0V+qjQr4dux3AmGTWBmCDD/H9BdS8AKSx1cR2V1+lP
         okOyHPbRo+4wkBhE5nHRalxYRC7DHDc2wjBI2T/7aCnW8jfmrzZWVbXVagdVg6zUgG7Q
         wk1w==
X-Gm-Message-State: APjAAAWGE4YujUZEY8wsT/NXkCF4kLIRPITv8UdyzCZbNMN9tViSaOev
        RCV3s1w5jfn+un/jZ96Ptg==
X-Google-Smtp-Source: APXvYqw2id01ES8madxnhVdw39D50+loE9hLiO8Ni0cKSbMkVMhJOMUu2liajePavZinypZuxSHHsQ==
X-Received: by 2002:a6b:b211:: with SMTP id b17mr33988040iof.138.1577394081439;
        Thu, 26 Dec 2019 13:01:21 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i83sm12570632ilf.65.2019.12.26.13.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:01:20 -0800 (PST)
Date:   Thu, 26 Dec 2019 14:01:19 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     krzk@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/9] PM / devfreq: exynos-bus: Replace deprecated
 'devfreq' property
Message-ID: <20191226210119.GA8706@bogus>
References: <20191217055738.28445-1-cw00.choi@samsung.com>
 <CGME20191217055106epcas1p11f2bc81d6bb2db3fc4bc257d78c337b9@epcas1p1.samsung.com>
 <20191217055738.28445-5-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217055738.28445-5-cw00.choi@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 17, 2019 at 02:57:33PM +0900, Chanwoo Choi wrote:
> In order to remove the deprecated 'devfreq' property, replace with
> new 'exynos,parent-bus' property in order to get the parent devfreq device
> in devicetree file instead of 'devfreq' property. But, to guarantee the
> backward-compatibility, keep the support 'devfreq' property.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../bindings/devfreq/exynos-bus.txt           | 16 +++++++--------
>  drivers/devfreq/exynos-bus.c                  | 20 ++++++++++++-------
>  2 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> index e71f752cc18f..c948cee01124 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -45,7 +45,7 @@ Required properties only for parent bus device:
>    of buses.
>  
>  Required properties only for passive bus device:
> -- devfreq: the parent bus device.
> +- exynos,parent-bus: the parent bus device.

If you are going to do something new, why not use the interconnect 
binding here?

Rob
