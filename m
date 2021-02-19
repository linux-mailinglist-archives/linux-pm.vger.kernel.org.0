Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B662E31F88C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBSLqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 06:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhBSLp7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 06:45:59 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A2AC061574;
        Fri, 19 Feb 2021 03:45:18 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id a4so3912379pgc.11;
        Fri, 19 Feb 2021 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbICSE48sPQjuRB7ng4DF/fEklSNJC/m6zyIx2m/MMI=;
        b=O09bctQjXyt54+aBzkFFgV558cKUXMsLMDm3XjAWmWB/UC4U1J3hpLu16aSJ7ORlE7
         KNoKq4KNTtxGsu5C1o2IpWzRs/Wu5ibQh8cOvkbbGVJSDzUIr003TnfWWgb/gXk0oLX0
         V5vFdAmjzvGTyKogv//XXANQIfX3AvNATGY7bDNUwOllCjJPTcY/2ZYQb7A3yAIu42Sc
         eKutlZMYOnmxcG2Trd5AIfSJorj34hYKtgd8YD+yZLh+FPG7Vqu5luKWVUczv6u60LOD
         HZk/wOvexCA9QbwcNFuMf10+Hgbq7olTRK4r3JIy64AzvPjpPHE5f75uTUtD22kjAQqa
         ZfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbICSE48sPQjuRB7ng4DF/fEklSNJC/m6zyIx2m/MMI=;
        b=AMo4UtE49pI6clM0ej7goHNgqELYS0OwrZVZn6nQskxFCt/kamZB3H0XCKTNMAfjxT
         oLMMAQsw6wMKRsNO4aOOdJaL04fah1ZaZH8Qlh8bJmADHH6lM7rZNhjTx+ITufVJNwGd
         nCZKNmNdMzxrY+W9dTzkzcLnuK5b03RRnGh1v39O9M/IPMSlHaF/Nc7EEMPOEAqgfbfv
         Cj3IBSjsb0NJuspulQ6Q9DkBDUZAkJGKKjajQzrDqgvA8ZGgVwprYhyJj2INdxP63b1j
         iKhlIt2Hque2gBfilGNa3bqLzygdGlt/AglyvuDjCy0tji4HQt0y3FJ4IS3HAAPLXCEl
         KX0w==
X-Gm-Message-State: AOAM5337mTBNM3GzLDGSiVY8pmsbHdyJVPZ4kaCvbAyI7X+mk79ooBu7
        k0JFBD2WqU/O0SgPP7vELcs=
X-Google-Smtp-Source: ABdhPJwUdPnv+WFeT01RzSRREYQbyJOj27EkjQCdiKIONwZRFuhrGpDpFet1lcod3TJyUKmx+ttfEA==
X-Received: by 2002:a62:7f51:0:b029:1ec:dbe2:2c76 with SMTP id a78-20020a627f510000b02901ecdbe22c76mr8968620pfd.75.1613735118532;
        Fri, 19 Feb 2021 03:45:18 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id c18sm3804231pfd.0.2021.02.19.03.45.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Feb 2021 03:45:18 -0800 (PST)
Date:   Fri, 19 Feb 2021 19:45:09 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210219194509.00005884.zbestahu@gmail.com>
In-Reply-To: <20210219093551.bykqhjk6xvs4kszi@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
        <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
        <20210219113804.00004a7e.zbestahu@gmail.com>
        <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
        <20210219144140.00004de9.zbestahu@gmail.com>
        <20210219074249.2hcwcnakihor343h@vireshk-i7>
        <20210219162026.00002e2b.zbestahu@gmail.com>
        <20210219093551.bykqhjk6xvs4kszi@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 19 Feb 2021 15:05:51 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 19-02-21, 16:20, Yue Hu wrote:
> > However, we will skip the update if need_freq_update is not set.  
> 
> Not really, we will update freq periodically nevertheless, around
> every 10ms or something..
> 
> > And do the update if need_freq_update is set.  
> 
> Yeah, that breaks the periodic cycle to attend to some urgent request.
> 
> > Note that there are unnecessary fast switch check and spin
> > lock/unlock operations in freq skip path.  
> 
> Maybe, I am not sure. We are all up for optimizations if there are
> any.

We will set next_f to next_freq(previous freq) if next_f is
reduced for busy CPU. Then the next sugov_update_next_freq() will check
if next_freq matches next_f if need_freq_update is not set.
Obviously, we will do nothing for the case. And The related check to
fast_switch_enabled and raw_spin_{lock,unlock} operations are
unnecessary.

> 
> > If we consider unnecessary behaviors above, then we should return
> > right away rather than continue to execute following code.  
> 
> As I said earlier, we may end up updating the frequency even if
> need_freq_update is unset.
> 

