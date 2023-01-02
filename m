Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E5D65AD3B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jan 2023 06:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjABFbt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 00:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjABFbt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 00:31:49 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68036FFE
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 21:31:48 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f3so17765489pgc.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 21:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj1eRwiW3Luhk2olg1H80fmvw6kHRyQCGbcnUBAjq5s=;
        b=g4bXeQwxN5mMVsI2X+G18WOkbZmATRlYlNyd6kJaZ9WYyf9U5AVB9XdGN5PXVOVu/M
         Yvd3Nk836pUXnl11RX225WgRxCE/gBxpdnVx0caJrvz2xsBTZj0s8EZHFbC0aJIdSPZp
         Z74RTen5oDbhPhNmD8GCvxqIa3xpbyy5aJPPPHsroHjRraoALnSSb9eU0gzva4LYHQAj
         mMU16uCB1hkvXhsbEND5dqeFNp4Y5zmomH1mjxxuJb4V7MGYbMG2KwiZNHtmVKScZt/g
         hTo3ISRGr6kVj4UwHxqcMmqZ42XT/Ad5O+HwRUzcXkfffIPT3+BXPcWidMuYztah4qZe
         G+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj1eRwiW3Luhk2olg1H80fmvw6kHRyQCGbcnUBAjq5s=;
        b=Py2osIKHYPsJI4bVbAu6GdcLZ9nfbboO1tPsadSP8aq9FTFD7B8MO33SaAZFZWSSbD
         c0XLJTahQ8OtwHZaKaJklZ/mD4hERoUsanU1gjiU/RIAfDC7fCSLINyEJSPATNN52lIK
         TOpoEJ6C3+mhm4riZVlzMzi5gv95gcKiF1F3Jmy+JZXd65ydfWgT0T0giSwuFOj7YKyI
         RG9YtCotTM1EFBaY2QVvCs4Tax5yVKpz72S9P0+CRHnFMb3dBKf9kzRW2DSw6EycCaEj
         PBqWUhVUvWtYRIGdgJAWUU2a8EYHOZzrUjbcHBTCvhbaqU6HwGh+yfzogN59EKNlh8/m
         tZsQ==
X-Gm-Message-State: AFqh2kq3AVYXHWtDjpYLSEXL3nQ3+fC6fbiBFmGa0SXU7GwT2NIytJE7
        o7RtZ4bWvAr4FgMFfd6tAagVJg==
X-Google-Smtp-Source: AMrXdXuUp/VVzt8AbNCnNl47R6a7a9Yqr6deA+chS0zEonZgCgnpH1L+Ki31VdWnWk0xt+pzrQP2gg==
X-Received: by 2002:a62:1c84:0:b0:576:e4c7:97bf with SMTP id c126-20020a621c84000000b00576e4c797bfmr39984638pfc.15.1672637507842;
        Sun, 01 Jan 2023 21:31:47 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id l190-20020a6225c7000000b005771d583893sm17957478pfl.96.2023.01.01.21.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 21:31:46 -0800 (PST)
Date:   Mon, 2 Jan 2023 11:01:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] thermal/core: fix potential unbalanced put_device during
 register
Message-ID: <20230102053144.eheohvixllp3mtnd@vireshk-i7>
References: <20221231210301.6968-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231210301.6968-1-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-12-22, 21:03, Caleb Connolly wrote:
> Commit c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> causes device_put() to be called if the get_max_state() callback fails
> during __thermal_cooling_device_register().
> 
> Fix the cleanup ordering to only call device_put() if initialization
> fails after the matching device_register() call.
> 
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..2c6995b5dcb0 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -920,7 +920,7 @@ __thermal_cooling_device_register(struct device_node *np,
>  	}
>  	ret = device_register(&cdev->device);
>  	if (ret)
> -		goto out_kfree_type;
> +		goto out_put_device;
>  
>  	/* Add 'this' new cdev to the global cdev list */
>  	mutex_lock(&thermal_list_lock);
> @@ -939,10 +939,11 @@ __thermal_cooling_device_register(struct device_node *np,
>  
>  	return cdev;
>  
> +out_put_device:
> +	put_device(&cdev->device);
>  out_kfree_type:
>  	thermal_cooling_device_destroy_sysfs(cdev);

What about this one ? This shouldn't be called in case get_max_state() fails,
right ?

>  	kfree(cdev->type);
> -	put_device(&cdev->device);
>  	cdev = NULL;
>  out_ida_remove:
>  	ida_free(&thermal_cdev_ida, id);

-- 
viresh
