Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3979D6D3C50
	for <lists+linux-pm@lfdr.de>; Mon,  3 Apr 2023 06:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjDCELe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 00:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDCELd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 00:11:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61683F7
        for <linux-pm@vger.kernel.org>; Sun,  2 Apr 2023 21:11:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so29109928pjl.4
        for <linux-pm@vger.kernel.org>; Sun, 02 Apr 2023 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680495091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27R2g+sDxLnJbDwWfWYA6YvPE6yIAlipgv7jbis7U+s=;
        b=dNAh6oWQL1OjTONlMSwNjlJYn5Yxg6cmRBJz7nMigaC37SGOPa4dri4N42TbSBj5e8
         WgGlczwduegU8rOxnWef/451vnzJKtJ/Tk5p8A/zkNHvDrXaxeqzmO25QDKQkNlPJkOo
         XHhJPHQxiosq4A1PgMQrG7boSS8gJ+1gy4QVqe0SFjuLh0xVSRJVYatYXtU56hD1xi+9
         wKbIkFT/fcYH/ReXKBuO6uD3PamO1Mjqn9z1XbyhZ19/EYlW5UOGeEcyVZpE9Osz1c9f
         68of/mLTZZZZNtDVdNZcnxxbMd56OSNnLp7iwilVNqJdPG17CavxgfvUXD5h6EyNwVoI
         2klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680495091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27R2g+sDxLnJbDwWfWYA6YvPE6yIAlipgv7jbis7U+s=;
        b=RrqKbhp7WQ36bKtPikS4NOU8W3OM7oWZ6sauM4alsCU/+ouj775C36sSJGuWUjDXSD
         gxqdKTjKgTFwaessqyfqzKCJuxeuFgNVEpyt4MARNMODr8OGDFOSKkQx/YUOkR02kseB
         qmYuDhdC1pxpQaiGl7vx+r8ibc3kdWYyJ/25iZVapreaHckOzR5b1bRgCgeOcmt1xLuI
         TQ1+j4pEYPmGyxtjMoCL/m4FGi/Usl5jtnE/yVYvwjbEWe9sHD9ynzg6ySVbO4nBkc77
         ccPu25/z2tjRwG+a45jLDiuy2AnAcBiq8NAFTCO2hr0S6PzUxnV7BsSQbpgIZWqLbvOq
         Kr1g==
X-Gm-Message-State: AAQBX9dxOZcqOBpNezysYyAdxyIzD3BK2yIadL+B+RlWYBz7U623M9wr
        ooam6NJxTCr78Dx0y0dwzqvSug==
X-Google-Smtp-Source: AKy350YwzuzyRj+w5kp3XyurszaZueCAoASG5JZZVqH5GPU/gaGxYBiQGJR9NQvs2wur6RTAeo2u+Q==
X-Received: by 2002:a17:90b:3a83:b0:23b:569d:fe41 with SMTP id om3-20020a17090b3a8300b0023b569dfe41mr39572506pjb.7.1680495091198;
        Sun, 02 Apr 2023 21:11:31 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b0019edc1b9eb2sm5475303pld.238.2023.04.02.21.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:11:30 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:41:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix policy->freq_table is NULL in
 __cpufreq_driver_target()
Message-ID: <20230403041128.jrsvbm4ddxdyhddg@vireshk-i7>
References: <20230329133600.908723-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329133600.908723-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-03-23, 21:36, Yajun Deng wrote:
> __resolve_freq() may be return target_freq if policy->freq_table is
> NULL. In this case, it should return -EINVAL before __target_index().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c0e5be0fe2d6..308a3df1a940 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2299,7 +2299,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>  		return cpufreq_driver->target(policy, target_freq, relation);
>  	}
>  
> -	if (!cpufreq_driver->target_index)
> +	if (!cpufreq_driver->target_index || !policy->freq_table)
>  		return -EINVAL;

Hi,

I have sent an alternate patch [1] for this, please try it.

-- 
viresh

[1] https://lore.kernel.org/all/53d4ed4e5b18a59a48790434f8146fb207e11c49.1680494945.git.viresh.kumar@linaro.org/
