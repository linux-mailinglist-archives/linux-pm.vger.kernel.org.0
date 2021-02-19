Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4D31F537
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 07:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSGmb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 01:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSGma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 01:42:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40726C061574;
        Thu, 18 Feb 2021 22:41:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id f8so2826313plg.5;
        Thu, 18 Feb 2021 22:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irQ99fwvyT3B4IXadbKZ2UTqLLi0pPWPv3qC3rVkQS4=;
        b=KUWkEvGk2DoZBtwIH+TOaLF02h1TEf8NR2b33z6uu+BUZpu43B6bNPgZgymYZhQmOW
         v9X8FtgFDnUiv35ItVlfq10yNeNKA7gLk6GLdn2YVXnKjLeKsJOcUe/6vj67Pk2rJW6e
         vKVhvlEdLXIDSeDLBvGeypdwVfxZRR1eeYem8WkVaCVjQOpPOpQsioYvflVDzF1sBceX
         SfkoEeJrKjEtjzmg+lGOoJf/FJBD8HJF4gb35GRvastjZESIwidOAaYwZ8h/wOQJ9OR8
         020Vj7k7EEqYE4P8jTLPCZ9NvU3MfjZNtQwRqucJDP86Gf+dUqygguYP023+Zyjg9mRX
         E/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irQ99fwvyT3B4IXadbKZ2UTqLLi0pPWPv3qC3rVkQS4=;
        b=MiyapQl2Xhf2dp0FMow9wORh2ipJ8O7UBdcr2f1VbJ4qxoxD0uLwlOHNlZTiD/nO8m
         pr5JuqkCIsz9qdZ8OsupwBg9e7+CLiTQhQAwoMNWiYvwiCbCkc0TnN8D6s+lnX8enmdm
         uA4Z5V8K3SpEYOM11TiCO90McfvDJ0K9Zu0/Cg0ZeooYKIHFktd8nsPnk54GW0Zw3Qv6
         xxhswVH+UEuZuvYyeRrNMncwHj0pMUBwE+GvDXZlNpORXUL64yl9ASqz8br+OCYJKlo/
         fpH+ITMeiUp/npGyPXmBrSgbwFwdK/YUdHwausTZb0RE/onEYCMA5QCMQBJLsfPlAg/C
         sV/Q==
X-Gm-Message-State: AOAM532SDaWkU1CDzTOYjq0ifbko/qjqA4S6oZAG/5TW7HF+3rp6nCX6
        32pYZnQv7Ywye8owcRKL/Ew=
X-Google-Smtp-Source: ABdhPJxE1DBe94IXWhawvDRdgvIhjbUVDqMUhgvUVrgaVZxDygq6F/07BjsER0aL8AMyvAB7/Z4Tsw==
X-Received: by 2002:a17:90b:4c43:: with SMTP id np3mr5249398pjb.33.1613716909692;
        Thu, 18 Feb 2021 22:41:49 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id g19sm7371936pjv.43.2021.02.18.22.41.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Feb 2021 22:41:49 -0800 (PST)
Date:   Fri, 19 Feb 2021 14:41:40 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210219144140.00004de9.zbestahu@gmail.com>
In-Reply-To: <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
        <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
        <20210219113804.00004a7e.zbestahu@gmail.com>
        <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 19 Feb 2021 09:39:33 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 19-02-21, 11:38, Yue Hu wrote:
> > There's a possibility: we will use the previous freq to update if
> > next_f is reduced for busy CPU if need_freq_update is set in
> > sugov_update_next_freq().  
> 
> Right.
> 
> > This possibility would happen now? And this
> > update is what we want if it happens?  
> 
> This is exactly what we want here, don't reduce speed for busy CPU,

I understand it should not skip this update but set the same freq as
previous one again for the specail case if need_freq_update is set. Am
i rt?

> but we also need to make sure we are in the policy's valid range
> which cpufreq core will take care of.
> 
> > This is related to another possible patch ready to send.  
> 
> I am not sure what's there to send now.

I will send later after figure out the doubt above.

> 

