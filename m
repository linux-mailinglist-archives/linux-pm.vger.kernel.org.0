Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3CB1FAD2E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFPJyq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgFPJyo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 05:54:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07469C08C5C3
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:54:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so9243679pfv.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l9/ZHQGipIrOoq5y2llLzfpy6Wx+X9yAE1JveALeHdc=;
        b=Zrq7TkrI6b0M48sbi6PdxOk9kKcWNUY6JdnA8vPenSSWIPTbMtZR0/46Legu3j0OSS
         YnNL9TXbRkwz90ASeUFJ6Uy1a4XavE1gdm2FtW15G/G328pINz2Am0oyj5axkrSTRAzV
         CON0wC5CK0nBtf8rUhP312tL2EXZV3Ze9RMRnQElpd58mF3TRmP+gswR92sxlHiwTN5H
         FYagGbwhvYogIZNVRlEqC9d8FW1J5hgO6aJM3Abq5kv87hOPHE6xH4/eO3r61lFWPsR2
         7Ke6S337xpp6SvcjG/U6yAKTFsyO9n6DBvlwyzLCHtdYI40slRlewewgdBy9st5wq7Zy
         zcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9/ZHQGipIrOoq5y2llLzfpy6Wx+X9yAE1JveALeHdc=;
        b=fKDqWpFiiMxEX3E1zN6tTGWc8jVMrETKMD4OUUvaIx5w8FgbMgtQKUGjy/VcxJOkXj
         sP3/0C3gnly7wrgQQ1kmm0+v4ZgLe5y3MKTm9GGlNM2oaiSCtiOUaSoi0dbHuuSRJNp7
         RfZ4cyi+T/vFL5i16/4/Yud4J+47iL6Bg3TxOciBiAwKvGelgWxuMqwxFTg2ACo2J6nz
         u8MZX2T0dcdDkQJezUvA9x3iHgzQwfN/3qPYO6t5j+mF9fvI5OS4SfFXIdVXYEegxxvC
         lV3SnhqPD/rQSv46NrjWd30kuIFgqciEPu6GDUsrqPeR60siKnVdfbqxMj15XB9iv5lA
         qWSA==
X-Gm-Message-State: AOAM533gMUk15OH1K+Kzqw4o1M6o/d9YpaFai1YL76HKV5u5BRJMdpel
        NC45qpCeaoREMmvQBiW3UWsXzg==
X-Google-Smtp-Source: ABdhPJwcFpKI9llvV/hiCbHlmggb6SvTCk47o//zCCLLDejPSv7SyKqdnPffI6cRjZSvsO7NBRr5Cg==
X-Received: by 2002:a62:1704:: with SMTP id 4mr1358860pfx.290.1592301281329;
        Tue, 16 Jun 2020 02:54:41 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id z186sm14155351pgb.93.2020.06.16.02.54.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 02:54:40 -0700 (PDT)
Date:   Tue, 16 Jun 2020 15:24:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616095438.v7wywhfq5ealvyih@vireshk-i7>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
 <20200616083107.GA122049@google.com>
 <20200616092759.rjnk3lef4tedfust@vireshk-i7>
 <20200616094802.GA139416@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616094802.GA139416@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-20, 10:48, Quentin Perret wrote:
> ---8<---
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0f05caedc320..a9219404e07f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2340,6 +2340,11 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
>  		list_add(&governor->governor_list, &cpufreq_governor_list);
>  	}
>  
> +	if (!strncasecmp(cpufreq_param_governor, governor->name, CPUFREQ_NAME_LEN))
> +		default_governor = governor;
> +	else if (!default_governor && cpufreq_default_governor() == governor)
> +		default_governor = cpufreq_default_governor();

Instead of the else part here, maybe just do this from
cpufreq_core_init() only once, and so we will always have
default_governor set.

> +
>  	mutex_unlock(&cpufreq_governor_mutex);
>  	return err;
>  }
> @@ -2368,6 +2373,8 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>  
>  	mutex_lock(&cpufreq_governor_mutex);
>  	list_del(&governor->governor_list);
> +	if (governor == default_governor)
> +		default_governor = cpufreq_default_governor();
>  	mutex_unlock(&cpufreq_governor_mutex);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
> --->8---
> 
> should do the trick. That removes the unnecessary reference count, and
> feels like a good place to hook things -- that is how cpuidle does it
> too IIRC.
> 
> I'll double check the locking/synchronization, but that shouldn't be too
> bad (famous last words).
> 
> Cheers,
> Quentin

-- 
viresh
