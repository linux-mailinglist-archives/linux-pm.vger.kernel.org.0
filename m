Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1923716852B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 18:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgBURkk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 12:40:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39552 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBURkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 12:40:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so2956723wrt.6
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3V9d6h+w2Jn04j6QHprbTz1jBnUlayRXHk3bj59std0=;
        b=S1zv+eyvfvNLGritTRUO4O07zMDmH2GjJWPuiXIdVvT9rwyOC+uM4H0gOWvu+ZG7KC
         kOsSv3VIpoe9UPLxuvjnnDVkz4Dp8GU0MoTlYJlGUL5pWSc/rUBLrDMe/wAaNSM/BUnK
         Me8EM5xUyclfKueqfEGGeTUUgxgPkUZCr3eV4M0Gwi6DWnsPArzYVUKSuosGhHaIdJqm
         AFNgITQd7cNvZWvfkKidj38GQoZ5vIr+NFAT4ATDQWmJCWRnnxMv3Gxd8n8Al0+IZyQn
         oYDKiFRoJ3dxZzYmq1ebb22sbS69QYJAycY+JRDTaLK1YrfdlNMlMSNTqt0QUwsT3P+R
         12QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3V9d6h+w2Jn04j6QHprbTz1jBnUlayRXHk3bj59std0=;
        b=RJKdaC1NHbKJK4lengn5KGsexCUCgvH9o5C6JrOAWMaKnrY3AZiOdUC3dYa0JXzRJm
         yriT2xQ0tOiTv3se4qhmJ/HIJUz/34CnF0eCFhBi9XmuL6meUiX1CNRgYTfU555VczCK
         NLq9YVjwn9INVIBb7i0n6sV+4mYQ7C4xRFRHkz3e70/JMq8IdiSiJd+B0IqNZQPV6Cpp
         3JZG+BR33jDCgSU7mxTKMFysqwITDeEKKmdrVwS3rtXauCvynuWXNj1UevM8dfHiNiHf
         2ozUK5vNOvhi3CIBDZ28+gigA/UtRispSHYc0CkR+P+rx3DphP7VAIP5XRtzlcUETZAQ
         jLmA==
X-Gm-Message-State: APjAAAWDMTTSdj536zBlyBYS4OgpBWMBWyxOMHtXVAAv75Ru0g1T2rI6
        wlkGAzIZpebLdL3GKQVWVYcU6g==
X-Google-Smtp-Source: APXvYqyMv9sqLAcg9X7RL2yIUHrWh1u/L1U9ff6yIGnRxUO9BHWyghYULmWGNzjMlwA/tOgJhZrSmA==
X-Received: by 2002:adf:a19c:: with SMTP id u28mr49326009wru.221.1582306837974;
        Fri, 21 Feb 2020 09:40:37 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id f207sm4980688wme.9.2020.02.21.09.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 09:40:37 -0800 (PST)
Date:   Fri, 21 Feb 2020 18:40:33 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/17] ARM: tegra: Propagate error from
 tegra_idle_lp2_last()
Message-ID: <20200221174033.GV10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-6-digetx@gmail.com>
 <20200221151612.GJ10516@linaro.org>
 <1a8c81ab-6f6a-8221-6a4e-c080ba595836@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a8c81ab-6f6a-8221-6a4e-c080ba595836@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 08:21:41PM +0300, Dmitry Osipenko wrote:
> 21.02.2020 18:16, Daniel Lezcano пишет:
> > On Thu, Feb 13, 2020 at 02:51:22AM +0300, Dmitry Osipenko wrote:
> >> Technically cpu_suspend() may fail and it's never good to lose information
> >> about failure. For example things like cpuidle core could correctly sample
> >> idling time in the case of failure.
> >>
> >> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >> Tested-by: Peter Geis <pgwipeout@gmail.com>
> >> Tested-by: Jasper Korten <jja2000@gmail.com>
> >> Tested-by: David Heidelberg <david@ixit.cz>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> > 
> > [ ... ]
> > 
> >>  	cpu_cluster_pm_enter();
> >>  	suspend_cpu_complex();
> >>  
> >> -	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
> >> +	err = cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
> >>  
> >>  	/*
> >>  	 * Resume L2 cache if it wasn't re-enabled early during resume,
> >> @@ -208,6 +210,8 @@ void tegra_idle_lp2_last(void)
> >>  
> >>  	restore_cpu_complex();
> > 
> > If the cpu_suspend fails, does restore_cpu_complex() need to be called ?
> 
> Yes, because suspend_cpu_complex() didn't fail. I don't see any reason
> why restore_cpu_complex() shouldn't be called, please clarify yours thought.

If the suspend fails, the power down does not happen, thus the logic is not
lost and then it not necessary to restore something which has not been lost.

I don't know the hardware details, so that may be partially correct.

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
