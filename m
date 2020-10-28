Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2929E068
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 02:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgJ1WE4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgJ1WBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:01:06 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218AC0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 15:01:06 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j7so1133710oie.12
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UGEvSBlqCbH7r/XeVff2EFEE3W3a/89hWK9X3Eu9+ZI=;
        b=tDhfRl8lL7XqVAS0dE9ih0wEOsD381IONb26mPbYM6z+rGn3WyK0u5UobSFx7JnaJT
         XBxkLh/aTXCuPOrd7R97cbmTf3tBsvopShAd2rhYZVXnChpr0BI5840zNyBN3+RksuCv
         pDU4pHD57XdjIyBKgMPioHw8IHfFmPeggSBXDtwvCpUknpq2/vgQMKI9wFUuDJXxiV22
         GFf3nPBaqPXtmOFOjvQwcAHA9seK3iyBvXpDe0eYwVTe3j9aHrT2Rc4iPo5dj5bgSRGH
         y45as3KX9exbNHVC+AAWPGZ2Wl+1ns0HTwvas/0qQwB9Yn2ub3tqD0bDWEaOD9Ozj6z1
         zXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UGEvSBlqCbH7r/XeVff2EFEE3W3a/89hWK9X3Eu9+ZI=;
        b=l9Lh0UDmkPNqOgm6shw9fwR4De6w1Dn38MOwTuf2gfxN7wSm2tsEZ8l/hwjbmSvHbo
         g8PaS11SfivaFaw0M21mBMx7h8O1yniJACPotX5/AHfXN/V19Jv1/h6KSecV1ja1Zwm/
         w3Q1fdjq1vZQIzWvUH1JtAW2hQzidoQvLe3u/dmmEsPhi3tRH19Mffqd+IDEzM9GzjBh
         4oEgZqu6YkVZywdB9TwScHHREXcKH3WEDoEVLnYV03D1JEMdVwh0RpREMvEJpgLAThGd
         D5am+Kkz3hYwJxFmB1HEVBNB8eP5woPDCGlpE88q0KnS6Xd0QhOyOQjyftaD+zrQgpuq
         2kdg==
X-Gm-Message-State: AOAM5300oul7nrOM7XreN7hRH7HAEtfrxKQqvDVHus6R+2eYiVgkGuQH
        yPsmrDtxrpoPb4uMClPzGEpc/c2CrEvPbQ==
X-Google-Smtp-Source: ABdhPJwr2K1NnepE5uXMHDTSc5jfBqdvp6zG1zCPfe5GimQyYat9Pv1/3IU0ouG58kOUTa/MpOy4Gw==
X-Received: by 2002:a17:90a:ab8b:: with SMTP id n11mr5453925pjq.162.1603864873109;
        Tue, 27 Oct 2020 23:01:13 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id ei4sm3821960pjb.4.2020.10.27.23.01.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:01:12 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:31:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        rjw@rjwysocki.net, jcrouse@codeaurora.org, eric@anholt.net,
        tiny.windzz@gmail.com, kholk11@gmail.com,
        emil.velikov@collabora.com, gustavoars@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/msm: Convert to devm_pm_opp_set_supported_hw
Message-ID: <20201028060109.qlggrsza5jjfno4y@vireshk-i7>
References: <20201012135517.19468-1-frank@allwinnertech.com>
 <20201012135517.19468-4-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012135517.19468-4-frank@allwinnertech.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-20, 21:55, Frank Lee wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
> 
> Use the devm_pm_opp_set_supported_hw() to avoid memory leaks in some cases.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 91726da82ed6..8d88f119a59f 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1487,7 +1487,7 @@ static void check_speed_bin(struct device *dev)
>  		nvmem_cell_put(cell);
>  	}
>  
> -	dev_pm_opp_set_supported_hw(dev, &val, 1);
> +	devm_pm_opp_set_supported_hw(dev, &val, 1);
>  }
>  
>  struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)

Rob: Can I have your Ack to pick this patch up please ?

-- 
viresh
