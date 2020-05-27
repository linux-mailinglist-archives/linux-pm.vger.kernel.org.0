Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7A1E45C3
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbgE0OZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389147AbgE0OZv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 10:25:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE1C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2020 07:25:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so10578197wrm.13
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2020 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fDQQL5F7NUmi63rPrswmsLUk/cVgqyfGJGxuaKIuerc=;
        b=ZCfDeGHgkwr9TFZB7Uml9rT03xtCxGugZtuvCoEluYZeBMY+Zqnsl0kcvlkhXRNGqz
         X/wqEce2QJwMvlOEWvyZCRr5ThtZLuPdaeJpQ4tRravGdAhTpNCG3RidS6TR6FEK7jQe
         xgbabj5Rbgy+aHWCIAeoT1EIhIud36GwUbMiLV8IenWT3D+J6P+7Nbh58l4sHwX8yxGm
         V5B4IbAZe2+mr28zJCRks0RPTruIX6rnWi8Hja7ozZyFnX1h37SiL5JvkzLoK0JQqoJA
         bfw8rb95Fk+XKZAV2iKSSfW5p/3nGTKi51epUNCGCmJHz4vMFfXRpzm8OUlTvTnI1CnB
         uClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fDQQL5F7NUmi63rPrswmsLUk/cVgqyfGJGxuaKIuerc=;
        b=DfPQCI/pVWtZCqUW0tBRcqA0/6+QCUmyjAraKNXnYZArEzsbmElQQVYfAbjxIMxWUX
         feQaD5mzuc7f/w1IrjG32oRGEwdeoYVnWjz4od9zny4Wwxl3rWlXD70EM9jHTyp3TVSZ
         Ncex+C4iyEQiC+uTZV5unp4IHlApbTWvA5eMXAuJO7YH2+t6gWkWtyXwrsunjVxnC25M
         HWPLTde7WxLYfFzn8w8VDe5u5HK3/rdHtGuLRrM8wj40dHqb31hdWsTHiLUBrpexLe+K
         dNv6MFcvqy4wJD/rtZHmnk4aHpfO5nKT0Zffi/qmHXEJHvHmTqTABbr/UTEga0U9yC6o
         0mMw==
X-Gm-Message-State: AOAM532ydv4R+KdqcktWQmo1xJvyZuT9EoH2q0J7eS6wKklIsu35gPjR
        CT88MIXD+gLVqMiWIEWURroNvg==
X-Google-Smtp-Source: ABdhPJxI0zSWLwdelkSKlMdMpkW7YNtk+9tKet+U4aBt7UDbNi/61LMkcogDnArtro33FkI4TMvLIw==
X-Received: by 2002:a5d:4488:: with SMTP id j8mr17764483wrq.242.1590589549429;
        Wed, 27 May 2020 07:25:49 -0700 (PDT)
Received: from macbook.local ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i21sm3110144wml.5.2020.05.27.07.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 07:25:48 -0700 (PDT)
Subject: Re: [PATCH] drm/msm/dpu: avoid open-coded 64-bit division
To:     Arnd Bergmann <arnd@arndb.de>, Rob Clark <robdclark@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200527133543.599948-1-arnd@arndb.de>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <9f910f55-1057-8c44-ceda-e0593fb13ffe@linaro.org>
Date:   Wed, 27 May 2020 17:25:46 +0300
MIME-Version: 1.0
In-Reply-To: <20200527133543.599948-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27.05.20 16:35, Arnd Bergmann wrote:
> 64-bit integer division is normally not allowed in the kernel
> because of the large overhead on 32-bit machines:
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.o: in function `_dpu_core_perf_crtc_update_bus':
> dpu_core_perf.c:(.text+0x810): undefined reference to `__aeabi_uldivmod'
> 
> The function already contains a call to do_div(), so I assume this
> is never called in a performance critical context, and we can
> use div_u64 for the second one as well.
> 
> Fixes: 04d9044f6c57 ("drm/msm/dpu: add support for clk and bw scaling for display")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks for the patch Arnd. I just noticed this in linux-next.

Rob, could you please take it into msm-next, as the patch which
triggers the issue is also there?

Thanks,
Georgi

> ---
>  include/linux/interconnect.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 3a63d98613fc..8279fe9b2082 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -11,7 +11,7 @@
>  #include <linux/types.h>
>  
>  /* macros for converting to icc units */
> -#define Bps_to_icc(x)	((x) / 1000)
> +#define Bps_to_icc(x)	div_u64((x), 1000)
>  #define kBps_to_icc(x)	(x)
>  #define MBps_to_icc(x)	((x) * 1000)
>  #define GBps_to_icc(x)	((x) * 1000 * 1000)
> 

