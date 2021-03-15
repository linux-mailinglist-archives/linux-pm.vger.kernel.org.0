Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8538533A9E6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 04:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCODSq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 23:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCODSe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 23:18:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B4C061574
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 20:18:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a188so5710964pfb.4
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 20:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NspATENrOmFGj2RGWYRZs8AOESm5x2Ll245LWQboYD4=;
        b=vVSbOGEZM6+lY89PH6AD/+r2vwev4+GrGPJfaucmL+CKQhZSC/Z+xSD6fwceLgvA+z
         o5rxrsiTjvDHAoscewztuD+bs43QCWBp8jrQ1aJ7lCBlAYWnKaVWwiy+jjzfPRHJGM3c
         iTYujaPmjpQGup+Zb26+jzkwzzMCwztBezg4gW6c3BYZw+SuO10KLX45P/0+v8DJXIbo
         g2PnPuB2SkAJGf1bQ3pl/4SrkoAtB51yyJutpDNLrn2yLTwGaKb3dLi8pujlR/Ixm0Gt
         oRzeFYTow/eJGG4iT3zYd2fhNvn4n+m49RpdatilunQrSp2djJBZjLjzjil1q++1WYqY
         ejNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NspATENrOmFGj2RGWYRZs8AOESm5x2Ll245LWQboYD4=;
        b=hkwxc9AFq4k8ML5BFqPYyl2icn0kCKpf9EKFq5S4PC1zK6AieD2QdgfE5NfKdQFDsW
         PvR/d7E/q/fjGV5DfF3PGEHl6PBNIA8GN248t9Qsi65FebBsgeAOHqC1YIMgeRgmCT/6
         rVLNCUlz9Wd0fcT7W75jLt/2utIG7ZnyObOuHd8eaqVbsPlI6PbhN8ekK5z61/gWnJMS
         nCTcYWmUtDYRKaAm3MWNhlAqBbMmnAxiC7B9nAH3ww3pCMrYujXNyHNnZNrV1jfeNs2D
         YK0xZGGv7gxbWqO15IbTN+Ufp+cPT6SsZgrESZbrbsqcWWCHa+Hre9U+uObdEDZOc7yz
         h6zw==
X-Gm-Message-State: AOAM532ogYRw3sSKRLBlI5JPfOu0HjMtQQQQycq0bjyiVUBJpq7oA76A
        +9enXcp8mB61IaH8UXW/U9Okgw==
X-Google-Smtp-Source: ABdhPJzf+pPBkSh435zuJv+zfo4KPBtQGNpvnEArBnO2YbupAuH29+18xHUwb3Vljye/UwziHjJpuA==
X-Received: by 2002:a63:ee4b:: with SMTP id n11mr21505433pgk.265.1615778314002;
        Sun, 14 Mar 2021 20:18:34 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id k3sm11092692pgq.21.2021.03.14.20.18.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 20:18:33 -0700 (PDT)
Date:   Mon, 15 Mar 2021 08:48:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     rjw@rjwysocki.net, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V3] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
Message-ID: <20210315031831.h7oojymaexfigxxw@vireshk-i7>
References: <20210313034951.13269-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313034951.13269-1-unixbhaskar@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-03-21, 09:19, Bhaskar Chowdhury wrote:
> 
> Trivial spelling fixes throughout the file.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Changes from V2:
>   Incoporated the findings of Tom Saeger <tom.saeger@oracle.com>
> 
>  drivers/cpufreq/s5pv210-cpufreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied with this change.

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 73110b005716..ad7d4f272ddc 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -91,7 +91,7 @@ static DEFINE_MUTEX(set_freq_lock);
 /* Use 800MHz when entering sleep mode */
 #define SLEEP_FREQ     (800 * 1000)
 
-/* Tracks if cpu frequency can be updated anymore */
+/* Tracks if CPU frequency can be updated anymore */
 static bool no_cpufreq_access;
 
 /*
@@ -439,8 +439,8 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
        }
 
        /*
-        * L4 level needs to change memory bus speed, hence onedram clock divider
-        * and memory refresh parameter should be changed
+        * L4 level needs to change memory bus speed, hence ONEDRAM clock
+        * divider and memory refresh parameter should be changed
         */
        if (bus_speed_changing) {
                reg = readl_relaxed(S5P_CLK_DIV6);

-- 
viresh
