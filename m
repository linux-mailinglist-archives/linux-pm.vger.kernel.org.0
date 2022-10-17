Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386EE60067C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Oct 2022 07:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJQF5k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Oct 2022 01:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJQF5j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2022 01:57:39 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE5E2E6AD
        for <linux-pm@vger.kernel.org>; Sun, 16 Oct 2022 22:57:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l6so9563955pgu.7
        for <linux-pm@vger.kernel.org>; Sun, 16 Oct 2022 22:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPsKnNF4HKgcvgFgYvEd5kR/Ms5Wc4EhuWCTrRLOtU4=;
        b=OE6cJdYF8jRSORbBeK/G8RenPqMGqZ4TqllrQrYf7Xz/AYa+EAL0MfYUzhZaBCHdkr
         UvIrCHJaCyIXd5y80GUg2z4uJcB7DWGfFftaKV9KmHBl3u/9JjcDCEbP8kSAW1SCIF/G
         AbyiKmSYmbyI3gHmoOleMCYVt+bhLzWgVeICtPxwzkltnmatX0ps4OobeKuCKawDinE7
         wsYXg6018kmHe+l/cvcAt2CBguVkagD2pGHzgXpDyZoNjtGSks+ZChQuugvTKphzRCc+
         SUf61qXY8J2EeCK8OlBKoUyt9DsWALz9RbQmQiffj3RosHjWU2XDgcYtnMdnecjfz17k
         1Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPsKnNF4HKgcvgFgYvEd5kR/Ms5Wc4EhuWCTrRLOtU4=;
        b=laxD3Jnu+MjO2EoPcuk8zeQoApcwb3vv5420Sp4cMBLkcRqxDZJtgv6XfD9Ur4g2OG
         dFFgwFBvs+k86d+vtjkRW1tpcMFWUclsy4BqQa+n6OyTvyBDw5rsK8ZlkxfLWKK3cNF4
         tV1hUwdMvjg02An9wh5PnUrFUuiL/otlU+5BFA9iLfA91C1ysvx0KnpEv3Vqp82ZWQsC
         W99lmhulohSDokeXSa98esgBomFM5aYK3/vwL5RBQhlTKkISfZJC+pOKSSf2EYhGJpP6
         oa8SR+BpqMj4iM2BKkx4UvVXeNuQfMjV1KPLl69BeEHKKPUM0EMMhaDgE2d0NHn9gXbe
         pwRw==
X-Gm-Message-State: ACrzQf2MvVioWkKM/u9S4BRe+9JUnybgW8TLYKaPK1FHlx85dkcLZsLH
        7qlQpzT19pPK4FRh1vtpaMrfX1Hhg+umgQ==
X-Google-Smtp-Source: AMsMyM6tSrX2gDRvkHmDDHDYZurlLY8MNu9YX0pqHifE5GBIl1YDCQFP7wYGPO+jEJpQpeG36hycgA==
X-Received: by 2002:a63:470b:0:b0:442:24d7:578 with SMTP id u11-20020a63470b000000b0044224d70578mr9415586pga.198.1665986257836;
        Sun, 16 Oct 2022 22:57:37 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id i3-20020aa796e3000000b005625ef68eecsm6044609pfq.31.2022.10.16.22.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 22:57:37 -0700 (PDT)
Date:   Mon, 17 Oct 2022 11:27:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] thermal: Add cooling device's statistics in sysfs
Message-ID: <20221017055735.is4by26po2woxzet@vireshk-i7>
References: <Y0ltRJRjO7AkawvE@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ltRJRjO7AkawvE@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-10-22, 17:08, Dan Carpenter wrote:
> Hello Viresh Kumar,
> 
> The patch 8ea229511e06: "thermal: Add cooling device's statistics in
> sysfs" from Apr 2, 2018, leads to the following Smatch static checker
> warning:
> 
> 	drivers/thermal/thermal_sysfs.c:656 thermal_cooling_device_stats_update()
> 	warn: potential integer overflow from user 'stats->state * stats->max_states + new_state'
> 
> drivers/thermal/thermal_sysfs.c
>     642 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>     643                                          unsigned long new_state)
>     644 {
>     645         struct cooling_dev_stats *stats = cdev->stats;
>     646 
>     647         if (!stats)
>     648                 return;
>     649 
>     650         spin_lock(&stats->lock);
>     651 
>     652         if (stats->state == new_state)
>     653                 goto unlock;
>     654 
>     655         update_time_in_state(stats);
> --> 656         stats->trans_table[stats->state * stats->max_states + new_state]++;
>                                                                       ^^^^^^^^^
> The new state value comes from the user via sysfs.  It is <= LONG_MAX
> but otherwise there is no limit on its value.

This routine gets called after cdev->ops->set_cur_state() has returned
successfully. That callback does the verification of this value, based
on what's the maximum value allowed and hence the size of the array
here.

I don't think we will have any issue here unless the cooling driver is
buggy and isn't checking the state properly.

> Presumably only the
> admin can write to this file so the security impact of this buffer
> overflow is not as bad as it could have been.

-- 
viresh
