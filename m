Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94189290834
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409927AbgJPPTO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409907AbgJPPTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:19:14 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564DAC061755;
        Fri, 16 Oct 2020 08:19:14 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m17so4326885ioo.1;
        Fri, 16 Oct 2020 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uzY4OOb3UvbavqXm5V4tdWOcTYtU4wpNa2y2+cRQ1Q=;
        b=feSB78azhkmYkuXprBajgH9IAfvW6of4LLbtyKbIEBXPjZhZD97FbFws1y9lA1+6R7
         vvtkA7v9JBj/Q/E2JhQQY2POhqipHjBbwum1WJJ/2o/3QqfOZs2J1lCLvDWjcEvgLmjJ
         x/2qblr9lnxq9BPBSNR1x8mXMUx9zyWAQHONy5iSLLdB60jhhW5DjeyknzJ0nCROwTVp
         NrX00j6EhJFx3IY+T1Q7L0eEZkXxHBI1zekV20blcZODsYwG02jSKdWZaGSY/z6JREsh
         TXe9205Yruhs/zO5HEO9VUkkCuuU2+fnheAwIAhoHq7+z3cvnXEWdUsGQ1MKJoNQdo6w
         URMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uzY4OOb3UvbavqXm5V4tdWOcTYtU4wpNa2y2+cRQ1Q=;
        b=A6lonLf5iRhn7b1PPZF+Ia9T8fOO1VkPKSDH5Pk93m2noM3WVS9vjWWX72EVgEkKry
         Z7zaGldeco4XjxU7VhxKJm/OI1xs064jv4JFuFlqq5G0DiPBO1tgCrBO22W3s3NRhd6W
         qI/6BQHFRI70O7EvbsNXQ8UMjF+ilHY4q7sgTqhEj2RdZjCMwBQRmazwQdDpGi1vGWIg
         ReTPnXbtXPSXjBUudz/5slC39xdZoQYdka3cDvs6Rgl8HVV3EN4SgWCcf6ZzTyt0HqOL
         3QCiHcS017oETMVxI8rpp+YUELjUioyLpqzt6hQMAdCGWMVExPjFz3ZhnEhms58iTZW0
         wdUA==
X-Gm-Message-State: AOAM532b5AuoT4OGlqDYi7MKg2Co/YoLqXpUp5mGTWNIlHYe2bE3D1za
        lKlyJCgV6xLN5sUBfIS0CcYiZdrvw3cY3IgP8bsbuckntc8=
X-Google-Smtp-Source: ABdhPJwndVADzlpqImXEkf9NK79ppmutLLDJKDRairMA5GyxcR3JUoTxqMuzSuphacFTIveLPHgTZoMwDqiddLxTeO8=
X-Received: by 2002:a6b:6a18:: with SMTP id x24mr2703475iog.92.1602861552956;
 Fri, 16 Oct 2020 08:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200911123157.759379-1-aford173@gmail.com> <20200911123157.759379-2-aford173@gmail.com>
In-Reply-To: <20200911123157.759379-2-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 16 Oct 2020 10:19:01 -0500
Message-ID: <CAHCN7x+NxWbpaZ7j3=CTeVcvtLm5iMVymgTV=LWokZAx=wJA1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: omap2plus_defconfig: Enable OMAP3_THERMAL
To:     linux-pm@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 11, 2020 at 7:32 AM Adam Ford <aford173@gmail.com> wrote:
>
> With the additional power management options enabled,
> this patch enables OMAP3_THERMAL by default.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  No change
> V2:  No change

Tony,

Can you apply [2/2] to the OMAP branch?

It looks like 1/2 was applied to the linux-pm [1]

thanks,

adam
[1] - https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/linux-next&id=5093402e5b449b64f7bbaa09057ce40a8f3c1484



>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index fe383f5a92fb..efcc46305a47 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -303,6 +303,7 @@ CONFIG_THERMAL_GOV_FAIR_SHARE=y
>  CONFIG_THERMAL_GOV_USER_SPACE=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_TI_THERMAL=y
> +CONFIG_OMAP3_THERMAL=y
>  CONFIG_OMAP4_THERMAL=y
>  CONFIG_OMAP5_THERMAL=y
>  CONFIG_DRA752_THERMAL=y
> --
> 2.25.1
>
