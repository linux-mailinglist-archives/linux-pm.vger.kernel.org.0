Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7729D289
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 22:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJ1VdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:33:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45043 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJ1Vc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:32:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id k27so1065435oij.11
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SdMtIh6m3CPohLaBsBlGBYKPlgAi1W6DyOgvXJZhzMU=;
        b=xnb04EZPpX6G54mO7w7FupCTkvaCxHoQB8mxnSIWYLc6Cg93rO1jBFgA/AKkcVhuyR
         EijXz+Cpu/v9RhvhCmUeeJ4e5x7SBiP5KiJEW+5MHg24LpglY45yKM8zpieMRUR3BKOq
         D7MyfOxzRg59xZyCBxwrYL3pQ66/xY/V+Ze6KfpnwtYhkMPdPmdj6FOkno0zGRL9eWWR
         hISIUQ/mlyHwpHSEoIvS9ht1Y2JCFaGIXVSLMJISNLG96nhvqJaV6rt276o9KOAPZGMn
         PMJFJA7HruAT9MaaamucqSriiN39whA4T9To16MNp3gGK4DqiGubieyptZ5cpS/l7l2t
         doIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdMtIh6m3CPohLaBsBlGBYKPlgAi1W6DyOgvXJZhzMU=;
        b=FFWK8hwzvF28oXMLvKd6nfjaJ1ADLynSqHIeCICf+OPyU3AyvZncUap4ze3RvP7muf
         /pj4O9csGW2wPolaFcMfXyMsZnS0gsdrwtSUcSIbqhSies/NhnLJigowb5KDjQjKlafD
         j/0k3dRV/fXH79/n+/tq4byYfW1ct6VTvVoIK3YgjfDCi8/sYXyQnleTzEwtCOAfE9rj
         F5IjYf3OaCk2buh0wrHYW0+fOUhZpnjfb4HTuVl31k576D0Eqz5U7wU6CrR1PemBJ8rI
         Ue2qQVpyAbAraLe8G+D4dJPBoV5YJVU6REcw9ycstiWDdhLASfJcG8Y+d5PMMJsmhES2
         0OFA==
X-Gm-Message-State: AOAM532iOQ9Zbb03unysBFyun9nnuiG17o7DRs+sSnCeQLfOf0mMP3U9
        VCBb8kVcSw0umSZhBknkai3jF0zr3zqnqQ==
X-Google-Smtp-Source: ABdhPJzUUX+6vWbqYBd45oSIWVDQZ8BeFms3ZKoZFfD5wR0iWQ0TifogkDp7ZLDYIf2oRDKWPpj2yg==
X-Received: by 2002:a17:90a:3486:: with SMTP id p6mr5132996pjb.23.1603857644960;
        Tue, 27 Oct 2020 21:00:44 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id w63sm4226441pfw.0.2020.10.27.21.00.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 21:00:43 -0700 (PDT)
Date:   Wed, 28 Oct 2020 09:30:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     trix@redhat.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: speedstep: remove unneeded semicolon
Message-ID: <20201028040040.leuai2cuuvrijnol@vireshk-i7>
References: <20201027185934.1586984-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027185934.1586984-1-trix@redhat.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-10-20, 11:59, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/cpufreq/speedstep-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
> index a13a2d1e444e..0b66df4ed513 100644
> --- a/drivers/cpufreq/speedstep-lib.c
> +++ b/drivers/cpufreq/speedstep-lib.c
> @@ -240,7 +240,7 @@ unsigned int speedstep_get_frequency(enum speedstep_processor processor)
>  		return pentium3_get_frequency(processor);
>  	default:
>  		return 0;
> -	};
> +	}
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(speedstep_get_frequency);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
