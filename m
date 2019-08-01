Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A447D4F9
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 07:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfHAFk7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 01:40:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41789 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHAFk6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 01:40:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so23108356pgg.8
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 22:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/o8YTbNsjxw2k6UgbsxYXXjTg0fvc1tjD9GHYk14MU=;
        b=TzLFx9yjS2cOaxig8Qru/VS6YDnRG6KdulTld7+Nu2jkuGuJIvdKq4dubYNb2h/bIT
         7CpZj8guUFYuqdB/x/nRLtbMOxHEU6ZiEk8yW4y+Mt5xL0FIkt6jiBjmS0g0qTdNlnSu
         lofI0X8paFqgVW1G1+a67lLfDVpkg+dGbKxbWEFC9WwM9r0hZS/0PooASt5Wezo7nuO+
         puyyuTBh2jKZM7SK3smdmRzK6AZWm5odBoIv0OAkV/ATL2lhoqvMS0U5If1MEGm9XfEc
         8CNmE4IbbnlG01j76SCXuyUs+aKf9LaRFX82Bp6zgHnVKnmgo/MN68OeHZuTMIqOOO2N
         MSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/o8YTbNsjxw2k6UgbsxYXXjTg0fvc1tjD9GHYk14MU=;
        b=O0jvTvm7kQeI7NDp9XSdaqbt1X8xtu4BcS38ngMEZF9fu2fzWgcRShxY67HJtPk1yo
         EvqFDCk1o5jCEqrKqKG9vRPaGqu51VTPBOJBBAFAAA/xL9qufpuCVnN8qLC7Om+qkpaW
         pM5VAoN0fQIL1y2sNVpyDNNRLFaW70mDwVWlGUc7BVxj8W408zT+2g6B62bjlFgona4r
         McfB4VCA7Gg3TtS92f6TsUCC3uf3oxl5QZ94KzJwdOOkFagEg24ao4/GqjD/ObnTzcBS
         /3xa45EFIHVR0QOQ9lyrwrjQ+9Lz5ad5Te/tT67GrhCrEqbcybz0gybtynFQQCbLSYcg
         nBYQ==
X-Gm-Message-State: APjAAAVuGnJn8PCLE9ctx3IQrGg+BURk/cw9Ve4Utq1PbscxGrd3VKw7
        uRnD+dsBDsOmWX1rE50mw9kD7Q==
X-Google-Smtp-Source: APXvYqzmiX/7OLzhXxCrID/iE/IWvU1lPO7qvH9ysJv1dJuRrPCk+zMaNF2FdZswGzAuBvGwID2I3w==
X-Received: by 2002:a63:124a:: with SMTP id 10mr116595500pgs.254.1564638057851;
        Wed, 31 Jul 2019 22:40:57 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id d15sm10245980pjc.8.2019.07.31.22.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 22:40:57 -0700 (PDT)
Date:   Thu, 1 Aug 2019 11:10:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        digetx@gmail.com, devicetree@vger.kernel.org, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 11/20] cpufreq: tegra124: Add suspend and resume
 support
Message-ID: <20190801054055.trmabmcaj3cpe4pc@vireshk-i7>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-12-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564607463-28802-12-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-07-19, 14:10, Sowjanya Komatineni wrote:
> This patch adds suspend and resume pm ops for cpufreq driver.
> 
> PLLP is the safe clock source for CPU during system suspend and
> resume as PLLP rate is below the CPU Fmax at Vmin.
> 
> CPUFreq driver suspend switches the CPU clock source to PLLP and
> disables the DFLL clock.
> 
> During system resume, warmboot code powers up the CPU with PLLP
> clock source. So CPUFreq driver resume enabled DFLL clock and
> switches CPU back to DFLL clock source.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 60 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

Is there any hard dependency of this patch on the rest of the patches?
Can I apply it alone to cpufreq tree ?

-- 
viresh
