Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0D343B61
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 09:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCVIMd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVIM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 04:12:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D13C061574
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 01:12:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l123so10423332pfl.8
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1at2wekG11ckJI+kF6W9c22DB5Srtr8tNzl5ZeN6iRA=;
        b=mB9v1EBhBgbLNdy1kTiKSpkB5FFCLIfqiUBGUIw/hcrkAna0h1arh8FESs8fJ8wGlH
         UGbGdP3GA5+TUVdusMeBMw93bUkmPLR7csYUOBVoy70zlGzCWnq26VvPva9OZADPfsrD
         0viW+8EvLjWwdr1WRzGjZb9hGTcnfzfb4Dyqog2hQ/07ECme9mx72p3DVFMrnOBBM2fT
         5p5BRnM7uSrxCjK+lm0mADRR4TRpwvZjdExi1c6JOlPvmGZh6cgBAnqra+wfQ0wB8lWl
         kPiEMZwYNYRf2vyMd6fLdecIUgTjXJtmuEsTF1R3gcSNVg/s5GlkMeM0/q1JmkIS/Xhe
         4DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1at2wekG11ckJI+kF6W9c22DB5Srtr8tNzl5ZeN6iRA=;
        b=seG5nIST79Nc6u7OYKBsHf7eqn3HIiZO/vo1+38V7+JIp6uXaXSKnZZOaCE5khUMhM
         nwEm5HObPqKw02sdf9UCOFbFiCnqJfOc11t4uoTGRMhViZ1iISEXZvBHIOPgzPLf65cu
         CYDtKoX9c3RzvsFaxTw6jgV5ciO713w9zKfAJIIOhHClA9SCFIIR9NUVHyMpfuOiM9Yc
         A2yUGMN5vLwv9KIxplmRy/dpgZ99LRpxuWbnx6wKJLwkzyRgjeXig/AUdVBrpgs9sEeC
         ddFouDq2KSC3+zfWnVZehii/eRTAWDUxXdpcE2tVDbM5fZBlUp/noUKURxegNsitLQoU
         uM+A==
X-Gm-Message-State: AOAM532ooz091JF5lx4e6kurjufEouBOUPVaorgokzNIO++TrgqFkcX3
        EtXxQhTfWhLnJG2F1jCEVIaM6w==
X-Google-Smtp-Source: ABdhPJzWQxLVtvHAprQg/aA6ZN+eldTHLqGUHxYy0Qri6rRhNB0Yf9/6DHCd+k4LORg3AClQwO7Q9Q==
X-Received: by 2002:a63:3189:: with SMTP id x131mr8356333pgx.430.1616400748930;
        Mon, 22 Mar 2021 01:12:28 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id ft22sm12549444pjb.8.2021.03.22.01.12.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:12:28 -0700 (PDT)
Date:   Mon, 22 Mar 2021 13:42:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Fix use after error
Message-ID: <20210322081226.gpxo3l4litmogcex@vireshk-i7>
References: <YFMpUDNGIiLOzr0/@mwanda>
 <20210319202522.891061-1-daniel.lezcano@linaro.org>
 <20210322032946.jstyrnc6dctq4fzj@vireshk-i7>
 <dcbf21e2-e2da-7e0d-66bb-ae7f4dc28858@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbf21e2-e2da-7e0d-66bb-ae7f4dc28858@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-03-21, 09:08, Daniel Lezcano wrote:
> On 22/03/2021 04:29, Viresh Kumar wrote:
> > On 19-03-21, 21:25, Daniel Lezcano wrote:
> >> When the function successfully finishes it logs an information about
> >> the registration of the cooling device and use its name to build the
> >> message. Unfortunately it was freed right before:
> >>
> >> drivers/thermal/cpuidle_cooling.c:218 __cpuidle_cooling_register()
> >> 	warn: 'name' was already freed.
> >>
> >> Fix this by freeing after the message happened.
> >>
> >> Fixes: 6fd1b186d900 ("thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering")
> > 
> > Why not merge this with the Fixes patch itself since it isn't there in Linus's
> > tree yet ?
> > 
> > Or is your branch strictly immutable ?
> 
> Hi Viresh;
> 
> The changes follow the path:
> 
> testing -> linux-next -> next
> 
> The branch next is never rebased. The patch above reached it. This is
> notified by the thermal-bot [1].

Ahh, I see.

Here you go :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
