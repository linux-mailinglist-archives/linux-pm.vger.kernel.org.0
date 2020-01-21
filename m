Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2014365C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 05:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgAUEx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 23:53:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39744 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgAUEx7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 23:53:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so782540plp.6
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2020 20:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FuBqWeRB73Ywb0CqjLZNHQW61rt/7bRkbrHMarzTouM=;
        b=ljZo/t7976t63x/zFqHcdHdmrdhgP/z62fwtwuYSJcJaYn3NMSb3a3IHnPdYugnoTl
         y6qMFL4sRlm0bcClou0l1GPpudjIIBnAWvR6tdV6sPVpM9FjcCTQccasjL0pgCUqGACf
         Jy7KYce+x0xUI3zfUQR8usk0CD5auM4KesmV+hyCUxAZequCD+P0GbzCdScdK4jmyek4
         BOvRpDfktfsPFqT7/+YGr49OD4cZeYAsVwB5Z22aw0i/VFy0zAiJ6rKUVz/6tEp27ri/
         kN7TGil9zomPmFcVW7f3MqXGbawUBOb/J8Hw8DXM1ShCsk7PuBRMDeBYaw33LAFdIIp7
         uJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FuBqWeRB73Ywb0CqjLZNHQW61rt/7bRkbrHMarzTouM=;
        b=qaXnVEcBEHwU+qsxcYQDk90QCq/j8W3N9xfdgs8N5Tq0irOg2vI4xykBCvC/G9Ot3V
         C65/AHHvS5Mcj1i+DCc8A4I2IF53hVOBpdQMZyExEGR4lvBYxMU+9eQDPQ/KU2kaiSGN
         /1yLHtdtIqEkGFik5Kl6HXTpcf0ZQsnk7OwNyJq6S62dg7Zl6IyuI8y7FDnoIDxPywqe
         Ex5QeRLxpyCxBDdSsDGau2y00imynTY6GCUWEI1ZO3KAMrPEisHWIqmC5IzEnImT71WX
         aU5UdnccKdjxUMV1WbNETj8sbFjzDSlJ4X58jDJIlYIkKozn2dFnwSwqtYcOs57+wVds
         s2/A==
X-Gm-Message-State: APjAAAUwX0/mjysfGV30lMo5sIrPEEaSQqhzzsV1uVScJ+Jz5OZuxZdE
        ZwLsG6mzJJeSzEZhOHZq9hloOA==
X-Google-Smtp-Source: APXvYqyeohulqNe3WAQq3xrhh6sObeVsPU1mSmsVIBYRdOgPoC7t7mNwDaOqh1FFu9p7iXfxk2h/pg==
X-Received: by 2002:a17:902:8549:: with SMTP id d9mr3416931plo.153.1579582438303;
        Mon, 20 Jan 2020 20:53:58 -0800 (PST)
Received: from localhost ([122.167.18.14])
        by smtp.gmail.com with ESMTPSA id d4sm1181371pjz.12.2020.01.20.20.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 20:53:56 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:23:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Paul Burton <paulburton@kernel.org>
Cc:     Alexandre Oliva <lxoliva@fsfla.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, paul.burton@mips.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] [Loongson2F] adjust cpufreq uses of LOONGSON_CHIPCFG
Message-ID: <20200121045354.2ugc6u2p6j7k6kof@vireshk-i7>
References: <or5zh9l5ok.fsf@livre.home>
 <20200120180612.gurkikzbh77stk4v@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120180612.gurkikzbh77stk4v@pburton-laptop>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-20, 10:06, Paul Burton wrote:
> Hi Alexandre,
> 
> On Sat, Jan 18, 2020 at 02:00:43AM -0300, Alexandre Oliva wrote:
> > 
> > The post-fork cleanup of loongson2ef from loongson64 changed
> > LOONGSON_CHIPCFG from a single-argument functional macro to a
> > non-functional macro with an mmio address in loongson2ef, but
> > loongson2_cpufreq still uses the notation of a functional macro call
> > expecting it to be an lvalue.  Fixed based on loongson_suspend_enter.
> > 
> > Signed-off-by: Alexandre Oliva <lxoliva@fsfla.org>
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Cc: linux-mips@vger.kernel.org
> > Cc: paul.burton@mips.com
> 
> This patch looks good to me, but you need to copy the cpufreq
> maintainers:
> 
> $ ./scripts/get_maintainer.pl -f drivers/cpufreq/loongson2_cpufreq.c
> Jiaxun Yang <jiaxun.yang@flygoat.com> (maintainer:MIPS/LOONGSON2EF ARCHITECTURE)
> "Rafael J. Wysocki" <rjw@rjwysocki.net> (maintainer:CPU FREQUENCY SCALING FRAMEWORK)
> Viresh Kumar <viresh.kumar@linaro.org> (maintainer:CPU FREQUENCY SCALING FRAMEWORK)
> linux-mips@vger.kernel.org (open list:MIPS/LOONGSON2EF ARCHITECTURE)
> linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
> linux-kernel@vger.kernel.org (open list)
> 
> I've CC'd them now, but they might want the patch resending.
> 
> Thanks,
>     Paul
> 
> > ---
> >  drivers/cpufreq/loongson2_cpufreq.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> > index 84f0eee..ace2d46 100644
> > --- a/drivers/cpufreq/loongson2_cpufreq.c
> > +++ b/drivers/cpufreq/loongson2_cpufreq.c
> > @@ -144,9 +144,11 @@ static void loongson2_cpu_wait(void)
> >  	u32 cpu_freq;
> >  
> >  	spin_lock_irqsave(&loongson2_wait_lock, flags);
> > -	cpu_freq = LOONGSON_CHIPCFG(0);
> > -	LOONGSON_CHIPCFG(0) &= ~0x7;	/* Put CPU into wait mode */
> > -	LOONGSON_CHIPCFG(0) = cpu_freq;	/* Restore CPU state */
> > +	cpu_freq = readl(LOONGSON_CHIPCFG);
> > +	/* Put CPU into wait mode */
> > +	writel(readl(LOONGSON_CHIPCFG) & ~0x7, LOONGSON_CHIPCFG);
> > +	/* Restore CPU state */
> > +	writel(cpu_freq, LOONGSON_CHIPCFG);
> >  	spin_unlock_irqrestore(&loongson2_wait_lock, flags);
> >  	local_irq_enable();
> >  }

Please resend it and add my

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
