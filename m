Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21EAB168522
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 18:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBURg5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 12:36:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38417 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgBURg4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 12:36:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id e8so2948777wrm.5
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cOA4oxIDLNEOCBal0R/IP5RYlFODdDSxtRHckIrqeJ4=;
        b=v7aJNSIG55RSpI+kvJoPYDGiihHOWpIdfAyG0hdY2APIVnqzV4JL7uODkwTZO90JO/
         P6A/dDva78t/fzWksSqCAkLBnDkTDvgArP22dQeyhh/pG+YxC4x15gWBAuRTuCW/FEuW
         6qCLIgPdjJDiQZKIa3QXg08OsfVXvZrxuxhH4IjdtwD7PBQEy6JHok7agRWQkxhE1lh4
         QhXw3bFHaeEedQ+tSQum/WljvqNTSCrCK8+E0wMrCwSheQ/1RDjX5fITEP0rNa5V7zZZ
         8sZ2uhOUKIFQrveh/rE3Ilbjl7dqicc5MggCJDFv/w/c7kcUVYjtSp7a0RyhoHsTqQWm
         16rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cOA4oxIDLNEOCBal0R/IP5RYlFODdDSxtRHckIrqeJ4=;
        b=beUsSRA4jMesLE/LJqXVnNjwKlpX+hEvVMB3/cSi7tBfrHSLgOx8eJNXNnlyl4INt/
         93HbhuVv40XjO/QlbBUEdvB/xf+KkgX9zGjK7DzJFLQfiEXePgSDp1fmVWhqiY2Twvhx
         ObNVk6XVZS3ZrGm7vRZHYMvMwMvneBc1/cu67UgRqpLMneUIHc7EVGF99VdXxH8LjBey
         9p0Ms8m94a0YOM/Rte8dCbeLBZclObAlQ5SNckN+1pPCd2mrfTlY9jGOB+Rey8WaVNNC
         cbhTwnL0+e2E/POwwRT4r+UHek9YEy9/hv6dSz0rmi8iM03C9FR+lHULXsu/vwWEHCk6
         h2ww==
X-Gm-Message-State: APjAAAVpf8oot9WtLHYLUtPxBmT5o0RwxHh2VAR38JFTT5fs3rOLn0iH
        VvdCTrnGGNSOB2u06GBIFxmh/A==
X-Google-Smtp-Source: APXvYqwm/yZN8q2d2aAZWNRq65dvNIZQip29PxGIJMjGNqoIHX2PoeqOaYKt1kazZ2ydG5WVCENWIA==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr47847596wrq.93.1582306613174;
        Fri, 21 Feb 2020 09:36:53 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id c74sm4916248wmd.26.2020.02.21.09.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 09:36:52 -0800 (PST)
Date:   Fri, 21 Feb 2020 18:36:50 +0100
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
Subject: Re: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where
 secondary CPU hangs on entering LP2
Message-ID: <20200221173649.GU10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-10-digetx@gmail.com>
 <20200221154318.GO10516@linaro.org>
 <239a2b66-8da8-2e6c-d19d-9ed207ad0a64@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <239a2b66-8da8-2e6c-d19d-9ed207ad0a64@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 07:56:51PM +0300, Dmitry Osipenko wrote:
> Hello Daniel,
> 
> 21.02.2020 18:43, Daniel Lezcano пишет:
> > On Thu, Feb 13, 2020 at 02:51:26AM +0300, Dmitry Osipenko wrote:
> >> It is possible that something may go wrong with the secondary CPU, in that
> >> case it is much nicer to get a dump of the flow-controller state before
> >> hanging machine.
> >>
> >> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >> Tested-by: Peter Geis <pgwipeout@gmail.com>
> >> Tested-by: Jasper Korten <jja2000@gmail.com>
> >> Tested-by: David Heidelberg <david@ixit.cz>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---

[ ... ]

> >> +static int tegra20_wait_for_secondary_cpu_parking(void)
> >> +{
> >> +	unsigned int retries = 3;
> >> +
> >> +	while (retries--) {
> >> +		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
> > 
> > Oops I missed this one. Do not use ktime_get() in this code path, use jiffies.
> 
> Could you please explain what benefits jiffies have over the ktime_get()?

ktime_get() is very slow, jiffies is updated every tick.

> >> +
> >> +		/*
> >> +		 * The primary CPU0 core shall wait for the secondaries
> >> +		 * shutdown in order to power-off CPU's cluster safely.
> >> +		 * The timeout value depends on the current CPU frequency,
> >> +		 * it takes about 40-150us  in average and over 1000us in
> >> +		 * a worst case scenario.
> >> +		 */
> >> +		do {
> >> +			if (tegra_cpu_rail_off_ready())
> >> +				return 0;
> >> +
> >> +		} while (ktime_before(ktime_get(), timeout));
> > 
> > So this loop will aggresively call tegra_cpu_rail_off_ready() and retry 3
> > times. The tegra_cpu_rail_off_ready() function can be called thoushand of times
> > here but the function will hang 1.5s :/
> > 
> > I suggest something like:
> > 
> > 	while (retries--i && !tegra_cpu_rail_off_ready()) 
> > 		udelay(100);
> > 
> > So <retries> calls to tegra_cpu_rail_off_ready() and 100us x <retries> maximum
> > impact.
> But udelay() also results into CPU spinning in a busy-loop, and thus,
> what's the difference?

busy looping instead of register reads with all the hardware things involved behind.

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
