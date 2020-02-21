Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA9168532
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBURle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 12:41:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34274 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgBURle (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 12:41:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so5672236wme.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WYt19hWbIa5Xu8CWd9oipzHMFzU2GBfzETdCcySKemk=;
        b=vLOXiT3LsFWCymfBWSf00sI8eNVCzOAsnAYW2uMu2fl5aol6UNQA1cDd5eBMO6+E8X
         cDJpIAGGZx0RA+9rmpmL2S7/RmM7BY0Y9qQ7thrXPF3b6AR+Ykj6cN27an4Hi7FKF2wN
         NBlG16z/AfiNYeM7wwugQp1X1RtxgjPYHtspY6lEjAuL9pXH6WaOmthn6YgTAx/eIQhp
         +TNVXXACeXcBBOEkEUvKjSL6RG6A+uLcldANURzXnA3MGyO8jpjF2QWiQvTQD0QP1ozd
         98KvSuy1Oe+7jTHBZub6c5lA7xdKBc8ZDnx922r6+qRd9EiaogA+6Tz9MIobp6ObKwib
         jKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WYt19hWbIa5Xu8CWd9oipzHMFzU2GBfzETdCcySKemk=;
        b=RhAKlv6h9hc2onMXVWbCiPoHaMPPG514mwtw+u5CgnbLgsxCxBOVKTZkpQOCeOPsCI
         hRbz+AbIAF0N1/qLzAupVLHq5npV08dEFN6HyJbIhSeF4jwr5GCY9Za/ry5pBaEg+4wm
         RwbrXkgze4oUwMwPJ8maJj6yfX3oH24RtBMMy/fXrzK8iqBhnybGIfvSrqjodEf5dKag
         YFAM4Weh2ZCY/0VF0DZFXYVUaU8e9yFKMbVtCR8qhLD6pQooPdzPvr8sLRdt00ZBpFHO
         M0oevSIrfPXZCvh4sEr0n3lgmue2T1pyrBK9YUg2TLDFl+cTcZsN8MM3OXChinErpDL+
         WiBw==
X-Gm-Message-State: APjAAAW3yoJtGsZ4ml/z9sDQYATE9y/GItucIQwCqqZASg1KIb8Deast
        gS6zPc9pAvWXuaZnTse3X3ZvqA==
X-Google-Smtp-Source: APXvYqxS9rE7ngm9CQLvZpUgXpRRYzTQIAk89jaGKyx1v3OnFAHZORuHOe8eqf+brp+9uMmwLjbhbA==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr5150857wmi.28.1582306891123;
        Fri, 21 Feb 2020 09:41:31 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id a5sm4658651wmb.37.2020.02.21.09.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 09:41:30 -0800 (PST)
Date:   Fri, 21 Feb 2020 18:41:28 +0100
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
Subject: Re: [PATCH v9 13/17] cpuidle: tegra: Squash Tegra30 driver into the
 common driver
Message-ID: <20200221174128.GW10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-14-digetx@gmail.com>
 <20200221162951.GQ10516@linaro.org>
 <89a9838c-faf3-b890-cea2-aad53df1eac3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89a9838c-faf3-b890-cea2-aad53df1eac3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 07:59:14PM +0300, Dmitry Osipenko wrote:
> 21.02.2020 19:29, Daniel Lezcano пишет:
> > On Thu, Feb 13, 2020 at 02:51:30AM +0300, Dmitry Osipenko wrote:
> >> Tegra20 and Terga30 SoCs have common C1 and CC6 idling states and thus
> >> share the same code paths, there is no point in having separate drivers
> >> for a similar hardware. This patch merely moves functionality of the old
> >> driver into the new, although the CC6 state is kept disabled for now since
> >> old driver had a rudimentary support for this state (allowing to enter
> >> into CC6 only when secondary CPUs are put offline), while new driver can
> >> provide a full-featured support. The new feature will be enabled by
> >> another patch.
> >>
> >> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >> Tested-by: Peter Geis <pgwipeout@gmail.com>
> >> Tested-by: Jasper Korten <jja2000@gmail.com>
> >> Tested-by: David Heidelberg <david@ixit.cz>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  arch/arm/mach-tegra/Makefile          |   3 -
> >>  arch/arm/mach-tegra/cpuidle-tegra30.c | 123 --------------------------
> > 
> > Add the -M option when resending please.
> 
> Okay, thank you very much for taking a look at the patches!

Yeah, sorry for the delay. Nice cleanup BTW.

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
