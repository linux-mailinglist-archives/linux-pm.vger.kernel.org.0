Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E419A2FE0D4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 05:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbhAUEhh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 23:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbhAUEGF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 23:06:05 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41AEC0613CF
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 20:05:15 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u4so757126pjn.4
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 20:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fvYm9s8KKtqxpGWVnETTEpvuaLditNYFEaGSLA8ZGRI=;
        b=oZkLOcQvlVOO3euYo9voMSY5pW7P8rwsobNz/ox/VTkUhlBsitTclHx3TJkFrcYR92
         0QnsgHJCgbAOUoMBblKWIQ1a+DHuAWEEiILqfYWxkWYoFBvNMAZng1U0loYJgV5/PKc+
         tNgSVfB9RGCJKrxQVpW+4HHDge4/bFLvuGzalOpt3P32NYftV3RSeBe2xHmpeMqadtIQ
         2mlTttZ9vnWbaivNj46schRegq5v+frchYA5HJ4gGaei/+y+EB0CnDh9FiU4n6GsIj3R
         ILKiip2vYpnLMBctKeoQkGg+scdpwYsMFX91Q0D9MkGHjV9bnoz/aRpAFgIyen4V8hQY
         H+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvYm9s8KKtqxpGWVnETTEpvuaLditNYFEaGSLA8ZGRI=;
        b=fEFMDlOeEqxUl6YgvjMD/DjqurgQLUk/JJk0ijHgt7F7y6WAGd8dhhZqOd6Ch8aMis
         XIKfJZghGX0XzpYslQSyYkxitFcDQjElR86xBwO79BlI44Rjb2/GkMl+KR5ieGf+jdLU
         yvABVUnSepuVSC37G9K6wH8bUxosgc8KxtlthwJ8I5VY19ay2MELqU/Zt6YQYwHS4gsu
         MnPe1+kojRLG57Y2UvMXAC8e5eFNnGW0waA9OYZ6uCkII9hCYKL3keReJn2hJuAnVRil
         bpjPtVZV+VIjvZsdGL6HmLIe4hNYhfH3nHkkCBbdDeeaDZPHWiVCuXVOsBddPqdXkd1J
         gk+w==
X-Gm-Message-State: AOAM530gPaapMEAqhGP7e1Xy8Z7seOAY1LmWwJ6iIrkNyDNL0i6RJOR1
        6HL5jgm6I+TWkeIv7yfPJgctmw==
X-Google-Smtp-Source: ABdhPJxUt04znGBAtDNsElWCyoOyFAKpAJD3XhZplRtlm6ODiesa+eoPz6UgTurjg/6Dwmc082xOTg==
X-Received: by 2002:a17:90a:e396:: with SMTP id b22mr9346207pjz.155.1611201915269;
        Wed, 20 Jan 2021 20:05:15 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 141sm3782733pfa.65.2021.01.20.20.05.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:05:14 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:35:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: remove tango driver
Message-ID: <20210121040512.kmkphnktiwylvo3n@vireshk-i7>
References: <20210120131709.1996711-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120131709.1996711-1-arnd@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-21, 14:16, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The tango platform is getting removed, so the driver is no
> longer needed.
> 
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm     |  5 -----
>  drivers/cpufreq/Makefile        |  1 -
>  drivers/cpufreq/tango-cpufreq.c | 38 ---------------------------------
>  3 files changed, 44 deletions(-)
>  delete mode 100644 drivers/cpufreq/tango-cpufreq.c

Applied with below diff. Thanks.

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bd2db0188cbb..3ba2f716fe97 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -141,8 +141,6 @@ static const struct of_device_id blacklist[] __initconst = {
        { .compatible = "st,stih410", },
        { .compatible = "st,stih418", },
 
-       { .compatible = "sigma,tango4", },
-
        { .compatible = "ti,am33xx", },
        { .compatible = "ti,am43", },
        { .compatible = "ti,dra7", },

-- 
viresh
