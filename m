Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6702E0268
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 23:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgLUWU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 17:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLUWU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 17:20:58 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82877C0613D3;
        Mon, 21 Dec 2020 14:20:18 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id f26so8662928qka.0;
        Mon, 21 Dec 2020 14:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=apJ8Ig/EiKTD7cW9gZsBxbwVR+J1NM8sWspkdwWpVME=;
        b=gftRiDT3yzeIi4Gl/Kndu1LUNA4OoW213qnuk3+GoictPCHq/B9jdsS5bULo9h3LF+
         btloMxMklOVxdYm8IkYfyQm1cX8Ma3aFFhMV+SHf+4zFQUbR8PpgVOoKoUNLhPKea7SP
         mAxU5tDi/ARpy5gOC5VoD8SszibkZFXTzqkQVSDWZp40+P5BbLrX80IyiIz1VhucMSl0
         Qmx3gnsUYsl81YvKJwoEfF5eOHa4ubMMwkqbNIz89uY5tDppnpk+o2tnRDMMrJuFVJEO
         eWtIkdxEd+HqImWiel4MaK/SOUMysjQMSOYXA/numGQ+tifXpKxRNv8v8wYPxc4Btbes
         i2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=apJ8Ig/EiKTD7cW9gZsBxbwVR+J1NM8sWspkdwWpVME=;
        b=Cth604JRJMaL6HEn7gke438idGIK3O2zTwBVzIQ2VfSqwRLx9KAI5peuXJuMJuhSR7
         MQEuF6ZYH8hWwSptQ+lxHtLoe/Qi3sLij+C19Q1sMoCA1xelrR4TS2DwvPqhwNTSXlMN
         4zbjmJWFbVOGaSrT53Q+aTZi7yfVt34m991NjUaCoyjgxOHzzunqh/0ER2cSTwRUktnL
         TFZCn6gYiEFEZYdE5dEww6MRTMLOlhvWMQN5GP3xYtQDOYXPzRAWxMb4EF3m57u9JRjP
         s8mV5bZ41tkzf5X0BP2ss5J7QgavBamWnLm/46/+sU7XN8SRN9JYXCenqtmE6d0gcusk
         /IdQ==
X-Gm-Message-State: AOAM530QXX9kDLymd6F7b6GdoUnxE9A1nlyzDIbyWCCk77qEOcq4OSIX
        /L/ulMTs73sBqftDuBN985w=
X-Google-Smtp-Source: ABdhPJyMi9/vp62EjHvUhhdx/C+hORaQVWkPmoX/YydeAqZetj+hzR5vQRnlL8Tpd34IIv5gnOvo0Q==
X-Received: by 2002:a37:7143:: with SMTP id m64mr19249783qkc.280.1608589217535;
        Mon, 21 Dec 2020 14:20:17 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r127sm12014204qkf.75.2020.12.21.14.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 14:20:16 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:20:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: remove obsolete functions
Message-ID: <20201221222015.GA3389117@ubuntu-m3-large-x86>
References: <20201221051320.18391-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221051320.18391-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 06:13:20AM +0100, Lukas Bulwahn wrote:
> percent_fp() was used in intel_pstate_pid_reset(), which was removed in
> commit 9d0ef7af1f2d ("cpufreq: intel_pstate: Do not use PID-based P-state
> selection") and hence, percent_fp() is unused since then.
> 
> percent_ext_fp() was last used in intel_pstate_update_perf_limits(), which
> was refactored in commit 1a4fe38add8b ("cpufreq: intel_pstate: Remove
> max/min fractions to limit performance"), and hence, percent_ext_fp() is
> unused since then.
> 
> make CC=clang W=1 points us those unused functions:
> 
> drivers/cpufreq/intel_pstate.c:79:23: warning: unused function 'percent_fp' [-Wunused-function]
> static inline int32_t percent_fp(int percent)
>                       ^
> 
> drivers/cpufreq/intel_pstate.c:94:23: warning: unused function 'percent_ext_fp' [-Wunused-function]
> static inline int32_t percent_ext_fp(int percent)
>                       ^
> 
> Remove those obsolete functions.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201221
> 
> Srinivas, Len, Rafael, Viresh, please pick this minor non-urgent cleanup patch.
> 
>  drivers/cpufreq/intel_pstate.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2a4db856222f..0e35dd247986 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -76,11 +76,6 @@ static inline int ceiling_fp(int32_t x)
>  	return ret;
>  }
>  
> -static inline int32_t percent_fp(int percent)
> -{
> -	return div_fp(percent, 100);
> -}
> -
>  static inline u64 mul_ext_fp(u64 x, u64 y)
>  {
>  	return (x * y) >> EXT_FRAC_BITS;
> @@ -91,11 +86,6 @@ static inline u64 div_ext_fp(u64 x, u64 y)
>  	return div64_u64(x << EXT_FRAC_BITS, y);
>  }
>  
> -static inline int32_t percent_ext_fp(int percent)
> -{
> -	return div_ext_fp(percent, 100);
> -}
> -
>  /**
>   * struct sample -	Store performance sample
>   * @core_avg_perf:	Ratio of APERF/MPERF which is the actual average
> -- 
> 2.17.1
> 
