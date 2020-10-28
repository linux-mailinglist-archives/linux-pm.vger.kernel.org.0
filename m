Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072F529D970
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389758AbgJ1WzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389780AbgJ1WzP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:55:15 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B866AC0613D1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 15:55:14 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k27so1271375oij.11
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 15:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KfnjVkSYavUZpAOuFxYL10A68Gk+riZcuOkpLm+UKsQ=;
        b=orPttfCJNvUzyey7uOGV6qbycVKTL/tawKuMW0R4tXOU76W3N/0abqCNmDOmSmvRKN
         L2JU10SN8to5CTiFxG5wFlRZ+x6UlUgMbOG7N/pua3fxvZBZCJS+EYHvE8FzLHr3047a
         IusQdNKndPmJTL/Pn2PASNVNzQizL4HKrr9h8Sa4s9vTWSzUv1vWxJlLWL7qBwiNZZH0
         NL3jimF1eAupDw4lp9obwTBpfo4tAMxacCG2xG9Ai03ir7HEjMODGsb6q1L4ESlUir48
         MW4RzbQapeOS637/B5YLbaa26ZNLRjDyIkCnrRdrCVaqLf/6SiGLh23zR+zTIGWZ/xQI
         LDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KfnjVkSYavUZpAOuFxYL10A68Gk+riZcuOkpLm+UKsQ=;
        b=OLvdQhxVPAXz1OIegW3tE4A9J7PV7VVtEtsY2K5KHO6gmipbmV6BufVQ8mFw2o2lTm
         rk0sAxQsLYBwnrB3uTt8nYGRzfXp5TrWQI8AuQd/BaymZirMbnBzSO9ZDA1robF8ViBG
         D9sz2yCqWL93jr7WoZHan20hgcF4bhDJWsjGGaU8YBz0//1uXNh76jca9UmI8KZVZRIr
         xwtV5JkMYkgo1rAVfvl5u1M7pHZmeGNGk6Gj70ig8xH01HId+ZUWkupJo43wlMywQJlJ
         MoC3rrfXN8jKebWHWuKvLdp27RBvjKsMOiXKVvcgJPLjbhQ1cFQ0btWNmE1Zb8y4Z45f
         hJFA==
X-Gm-Message-State: AOAM5301UHz+V/KzX+9lzhWIoOgSWvnnDYIkzctK9vDVU9BXjmuOZN5m
        bZkx4JyAr42m9g1DDk58Ty/rzq/NEDglSQ==
X-Google-Smtp-Source: ABdhPJyMbjsKNL+0AaYE+74jjeyJZn6dVKEnUKfModkHmF8ww8t+Tpr9o99iUojODmy3PW8gk7wIdw==
X-Received: by 2002:a17:90a:2c41:: with SMTP id p1mr4749376pjm.129.1603857999683;
        Tue, 27 Oct 2020 21:06:39 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id q35sm3548111pja.28.2020.10.27.21.06.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 21:06:38 -0700 (PDT)
Date:   Wed, 28 Oct 2020 09:36:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        nks@flawful.org, georgi.djakov@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201028040637.26kw2qk7digel6yb@vireshk-i7>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
 <20201027222428.GA125472@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027222428.GA125472@roeck-us.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-10-20, 15:24, Guenter Roeck wrote:
> Trying again through different e-mail provider. My previous e-mail
> got stuck in spam filters. Apologies if this is received multiple
> times.

I received only once :)

> On Mon, Aug 24, 2020 at 02:39:32PM +0530, Viresh Kumar wrote:
> > From: Stephan Gerhold <stephan@gerhold.net>
> > 
> [ ... ]

You removed way too much and this lost the context. Keeping the
routine's prototype line would have been useful.

> >  
> >  	opp_table = dev_pm_opp_get_opp_table(dev);
> > -	if (!opp_table)
> > -		return ERR_PTR(-ENOMEM);
> > +	if (!IS_ERR(opp_table))
> > +		return opp_table;
> 
> This should have been
> 
> 	if (IS_ERR(opp_table))
> 		return opp_table;

I believe this is the delta from dev_pm_opp_register_set_opp_helper()
?

A proper fix is already pushed in linux-next for this yesterday.

-- 
viresh
