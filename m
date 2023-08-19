Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B30781D80
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 12:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjHTKxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Aug 2023 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjHTKx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2023 06:53:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7DF351742
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 12:05:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so19352295e9.2
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692471947; x=1693076747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trFaQ1MmMfStgpCB/p3Yn8RIH87psb6mJSLUb1/AQTo=;
        b=HRh4DQVXXRG518N2ue9H8MNnberIftcKYu2q9/f2B0/rL0ManezfXiJluyjy7qPl2N
         ZyCLCct79XgOHvehPM1faMI7j8doWqi6Y5i/Fn99mPV0+GrDtlOIgEUobS5yrPFMDaVF
         +76lrANs3b4RR0H8kTUevgYlF4/0QBAZ+VLTkU+cK2T/MBzJsY+qBryiFZn09GL2jbRv
         gu2SS0mINDiLdjE0MgHsfG1Ce/7D/It1TiDb0Bk2dxO12EHAGGNIQ+EN08tdRWE1XlXQ
         fe60NI+SnQFA0YJxl+eAgKqvgR3oF9a/P6G3nt/7a3/Hi059RScsyEDtDXWu0vsFZXxN
         1OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692471947; x=1693076747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trFaQ1MmMfStgpCB/p3Yn8RIH87psb6mJSLUb1/AQTo=;
        b=BpX4BE2IhgRO3L5U/GhAKLB8Dm8dDyGC5escxI4kzUtEELwKvMXhSd+ZD3EEhHsa7S
         wqJvR5zVwwqnWjOBPvHWi+0ZgYpx3fMPRI0VPlkUNYId+NYIsllo9ipBtu7bmt/dtcJg
         KDV554PH/9v3ZEshf9Ll69r6G5NH6YW/7fJ9TIY9fR0KUoUTqGM92sduhh69KGW+7AW9
         h5MeAmq1f1y9iibwb7z8R3vfdMYKYIUgEYXza4gFYtZURPWvHdRIr5MX3bWOvCrEF8Ob
         I5SbGMhXCucJeRfp/+/0b2Fps+CxY7urA5JpggURCKvyDtTI88yQ6eHBTipr/Q+TaMBe
         8Xvg==
X-Gm-Message-State: AOJu0YxPFiwmyq3mCq8Z1wg1fQyKJ544qJZK7e6PmAunlMts4+FfK4Fs
        HUItaOi8SZlk3Advdjv30CXUGP7TJrET+45aloE=
X-Google-Smtp-Source: AGHT+IG1z0qNY5Y3AbdQZOxfo5gLaJUlK0AVnYmT/DyMt6SAjsDS7IkLmAzWQ9T3jh0aIIJ27fSACA==
X-Received: by 2002:a1c:f204:0:b0:3fe:d1e9:e6b8 with SMTP id s4-20020a1cf204000000b003fed1e9e6b8mr1882855wmc.12.1692471947005;
        Sat, 19 Aug 2023 12:05:47 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c040c00b003fe2397c17fsm10403886wmb.17.2023.08.19.12.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 12:05:46 -0700 (PDT)
Date:   Sat, 19 Aug 2023 20:05:44 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        guohua.yan@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: QOS: Always use "kstrtos32_from_user()" in
 cpu_latency_qos_write()
Message-ID: <20230819190544.kvf6rr4yhukpktle@airbuntu>
References: <20230807062345.490-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807062345.490-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/07/23 14:23, Xuewen Yan wrote:
> In cpu_latency_qos_write, there is a judgment on whether the count
> value is equal to sizeof(s32). This means that when user write 100~999,
> it would get error value because it would call the "copy_from_user()"
> instead of "kstrtos32".
> Just like:
> 
>  # echo 500 > /dev/cpu_dma_latency
> [T4893] write: qos value=170930229
> [T4893] write: count value=4
> 
> [T4893] write: qos value=170930226
> [T4893] write: count value=4
> 
> To prevent this happening, delete the "copy_from_user()" and
> always use "kstrtos32_from_user()".
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/power/qos.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 782d3b41c1f3..21a2f873e921 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -379,17 +379,11 @@ static ssize_t cpu_latency_qos_write(struct file *filp, const char __user *buf,
>  				     size_t count, loff_t *f_pos)
>  {
>  	s32 value;
> +	int ret;
>  
> -	if (count == sizeof(s32)) {
> -		if (copy_from_user(&value, buf, sizeof(s32)))
> -			return -EFAULT;

In your test you use `echo` which produces a string. But from C, someone can
write a program where buf contains s32 and not a string, and this will break
those programs. If this expectations is no longer valid, then it's fine to
remove it.

Maybe we can change the order to call kstrtos32() first, but this is not bullet
proof though..


Cheers

--
Qais Yousef

> -	} else {
> -		int ret;
> -
> -		ret = kstrtos32_from_user(buf, count, 16, &value);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = kstrtos32_from_user(buf, count, 16, &value);
> +	if (ret)
> +		return ret;
>  
>  	cpu_latency_qos_update_request(filp->private_data, value);
>  
> -- 
> 2.25.1
> 
