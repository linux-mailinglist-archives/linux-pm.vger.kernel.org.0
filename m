Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D4529E19C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 03:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgJ1Vsx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgJ1Vsm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:48:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CE9C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:48:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s7so1061002iol.12
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9EPUQ9ajfJzWj+hnvbYTUCoABm2jCaPKDMKTD4VLJ+o=;
        b=FXluIHWspusLqK/Kg/uNQGa3Bqh2HOqioMgW1IjaXnh/FVi2SHaED4wWlJqfymNCjv
         RCWtKoRJo73Ynh6NZ9t3K4I8FQPZpNfwelkrIsVMCGwuqw6GNB3hBI1+bqZB6jEcvlci
         0HQawnOCc1YGigoQk/GhqbQOqZxZ92Ktw9J7Cy55LUugsDre4quH3JYisIqgPn2iOL1E
         bjckKD+vobH+WAuFwQrfBYjXE/cVNAdPKcgxiR+EM2T4ROMHT7SXbmfqQmn2bMQ1/jrR
         oqhMtpoaH6wzA3odYkft7wgHgGBOlQNjbCkdKVz+0aa6JCZ0GmMyXiC/Khl65EWIPbpU
         CPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9EPUQ9ajfJzWj+hnvbYTUCoABm2jCaPKDMKTD4VLJ+o=;
        b=EVRTbPmjRNqV695Foaej9q8E7gqxWx4cBC5C95eg1TARq2zmvsVAN9ucWJW6mpqqw6
         XeCO6Ug6kKHi+EtMtyU7mvJeDx3j4l1QYxeG79Xpxb+fCMo/vqx+brotl9GJj3yIY/Qf
         Q/aZypvI1pa093J7uVloCRZcVyVABJ0md1AYHGFk9SVLTGwz2cec9f43GUKJ4V7Hn1nI
         PDGTBUoAuyuByDl2Ab+M9Oz0PXO/VqzE6PrpCIMa2zRM/hlZ24+Kzcio2rWQTvZJUa3I
         U6+BUCOxJ8iIa8XeerKRTAO3fb2bjWE7T0tQEsK76oiqfDo2lHkti3yLsOG1MQnnYDQL
         kIZw==
X-Gm-Message-State: AOAM531qq21mX9H7U7AzMiHzpTpfKHi4ws5w/QgPWHpFUyOf7ye7+Twf
        8cTwqxYV1GB4hD0aAcNdobXdzwcgHeATMQ==
X-Google-Smtp-Source: ABdhPJyab+BLUolrAaQS6Z5bkxxLTZ0qmvvT/57deuMD2GISr2XjIBTS9myTIcIcl7KRpP8uHevBhA==
X-Received: by 2002:a63:c851:: with SMTP id l17mr4887683pgi.31.1603865176097;
        Tue, 27 Oct 2020 23:06:16 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 23sm3988680pgr.53.2020.10.27.23.06.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:06:15 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:36:13 +0530
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
Subject: Re: [PATCH 0/3] Introduce devm_pm_opp_set_* API
Message-ID: <20201028060613.qva32sirae4dtj6x@vireshk-i7>
References: <20201012135517.19468-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012135517.19468-1-frank@allwinnertech.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-20, 21:55, Frank Lee wrote:
> Hi, this patchset introduce devm_pm_opp_set_prop_name() and
> devm_pm_opp_set_supported_hw().
> 
> Yangtao Li (3):
>   opp: Add devres wrapper for dev_pm_opp_set_supported_hw
>   opp: Add devres wrapper for dev_pm_opp_set_prop_name
>   drm/msm: Convert to devm_pm_opp_set_supported_hw
> 
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  2 +-
>  drivers/opp/core.c                    | 80 +++++++++++++++++++++++++++
>  include/linux/pm_opp.h                | 14 +++++
>  3 files changed, 95 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
