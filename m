Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838A72FFBCB
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 05:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbhAVEfv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 23:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhAVEft (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 23:35:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A1C06174A
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 20:35:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u4so3039773pjn.4
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 20:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yetUGqIq6nwDP/Z5XoMcv9Fbw9FD3H4M8DzhhGq80G4=;
        b=bcp+GOMzL9ijzDOWNP7XZsMTtd3/kiRN5ST2t1isOPSlwMc4uIda0EOzl9jSq2xcFT
         YExngj2Yc4a8PWDpqao1t61oNjSIhvSBEEBTXptB+Jdr6am3AOVnop1dLRf1oyw3w2Nq
         NIZpM2O/bW3PGC3rBHUfsrtjcXsaki+ah5uAgXdM2Y3E8XdtBkUxL4gT3pp85jVKoTgC
         FcAZedd0fshyrcDxcFMrSIaFdb0Ur4PfM0o7//yARqA1hoTS/8y6Vxwx5PF4TrUx5vhH
         UoX0EJTK3g13TUfaf4cbK6GCRPXpJcDpZWjaKfS2PRULah/HANv8IPloOf0SvXxtAsOT
         ir9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yetUGqIq6nwDP/Z5XoMcv9Fbw9FD3H4M8DzhhGq80G4=;
        b=NlQVsVW8nbtZeQox29gLdhwAHTO7qU4Vh03W6oJxCcmYY+/AGsEB7592zINH6gE0UT
         5zDNBgCmoU6pEIaZuy6sGtRtmCLRKcHW6zDZDEcPlMzMfIrzMqUF1SIqwvWo3m0TlaOa
         QN4nL6AFIHMN/z0VUkHF4rt+7NXLEAVagGGdJmSYrLXubP2wCSb4nqxPRgrHboQIEmJa
         MXbCHYseY8KB+a63JoHVWu+Jl/KFro8RC5+CE9FihxJv15Z6YlodmBGVNhWBowkiJ4Vt
         JjiZb58fvsknWK62a5zLvvABapa/PNi+DU51wy015oQ97PAcTBVtWVHw44wG84BkLvxJ
         VQkQ==
X-Gm-Message-State: AOAM533UgXIE+IbzTTnQcwCHronBKdk/s5VVaTbAFVlvtJeKBzAnspWu
        ssM7ofYI4Cwnc/zap+T8X7Zi+Llyh+KSOA==
X-Google-Smtp-Source: ABdhPJx1VRpZysMio5HKg8II4nInDm6FtWRYuxHyTtXWeliAjY/fbVa0zm+yb9pGb1PBCIDixdfUIA==
X-Received: by 2002:a17:90a:9918:: with SMTP id b24mr3155479pjp.108.1611290109187;
        Thu, 21 Jan 2021 20:35:09 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id o10sm7187231pfp.87.2021.01.21.20.35.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 20:35:08 -0800 (PST)
Date:   Fri, 22 Jan 2021 10:05:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 07/13] opp: Allow _generic_set_opp_clk_only() to work for
 non-freq devices
Message-ID: <20210122043506.lm6yiefzlyubq5my@vireshk-i7>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <1585f6c21ea8aee64fe4da0bf72b36ea4d74a779.1611227342.git.viresh.kumar@linaro.org>
 <9b2638e6-b842-8737-e5a0-aeeb84927fce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b2638e6-b842-8737-e5a0-aeeb84927fce@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-01-21, 23:26, Dmitry Osipenko wrote:
> 21.01.2021 14:17, Viresh Kumar пишет:
> > In order to avoid conditional statements at the caller site, this patch
> > updates _generic_set_opp_clk_only() to work for devices that don't
> > change frequency (like power domains, etc.). Return 0 if the clk pointer
> > passed to this routine is not valid.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> ...
> 
> Hello Viresh,
> 
> Thank you very much for yours effort! I gave a quick test to this series
> and instantly found one small issue in this patch.
> 
> > +	/* We may reach here for devices which don't change frequency */
> > +	if (unlikely(!clk))
> 
> I replaced dev_pm_opp_set_voltage() with dev_pm_opp_set_opp() in the
> Tegra PD driver and got a crash, which happens because the above line
> should be:
> 
> 	if (IS_ERR(clk))

Fixed, thanks.

-- 
viresh
