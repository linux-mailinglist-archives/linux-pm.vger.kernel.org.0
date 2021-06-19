Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27DF3AD95F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 12:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhFSKYO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Jun 2021 06:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFSKYN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jun 2021 06:24:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FF0C061574
        for <linux-pm@vger.kernel.org>; Sat, 19 Jun 2021 03:22:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u13so1812876lfk.2
        for <linux-pm@vger.kernel.org>; Sat, 19 Jun 2021 03:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6I26t7fM8LNVGBvMvIkZnR2elsnA6cZhYPj1SFfm0XI=;
        b=Mp6ihPhMacYEli1uL2tiKf45XwcFFeXAqE+rs6eJJr2KhyPHN9J8q13MLk3JXptZA/
         3AU+Yw0rWQIL35z77Jc19uTrs08uOEvs75eBu/TAbd/UJBxPGc/0GyvHBwJIN2fH1QtZ
         xUxuffMsuTMrLM20wNW6Zz5L4EJJFMAVu3U94b908JC80YhQXzC59aO58ABj/5SEk4WG
         aErrgPQ8xlOd/LHV9fUewrdH/S9E3U+GcMPbG+Xm3hMCexD0RpDbC/4zoDyhmajfKE8R
         /7k4xQZhAhngDFB1S00Hz/ea20ZJTogF7Aq8BUI7q3cQ2BWtD9fplH0/Rbe35qP06dl8
         xhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6I26t7fM8LNVGBvMvIkZnR2elsnA6cZhYPj1SFfm0XI=;
        b=FEpwI0psHyANIVSUkLgiYoZKhnWfANwwPxh4ZUkevSsNwwo8bFgl94nIS7zn7XDrcR
         +eLKmCwTdnpguXWfDU7nDQ5aB4/Alny44Q+HvN12h/JCgyCoP1W3CsJWm2VsyOK1C8jH
         kPdJZjY+SzP6iVKG+VWb+WUqaeWwSA6T9N1vOXLnIrBG2SRMKjLgU/SMqNfBjwxxAXCz
         TKSJ48tDeQ+Oq8a7FF4i6RV4GLC67Yg9WDb9NY0j+7iVRkG2JtB35jXJiOILfru+d20B
         69K2F+hmBWMk+6CLg3fZD2BD3YTRc8737g19gjdJCYD7ngLko3eeZxlaagp1HJMvd/hP
         26OQ==
X-Gm-Message-State: AOAM533m/Bh9R98CreUoQAYws7rACWKooGoIltkBpyhhCjT93w5MKxr6
        xN4ARSMAdN9eJK15dFb+1g5RcHEaRhM=
X-Google-Smtp-Source: ABdhPJyliSzUulFJUgp8NlUDQlIdYfYMynA+R4YF5I/sHo0j9LSQ1NZBrM6yxNkvugRPNDXTTv4CQA==
X-Received: by 2002:a19:c383:: with SMTP id t125mr2224159lff.522.1624098120207;
        Sat, 19 Jun 2021 03:22:00 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id m3sm1187298lfg.241.2021.06.19.03.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:21:59 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 15JALu5k014586;
        Sat, 19 Jun 2021 13:21:57 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 15JALtsH014585;
        Sat, 19 Jun 2021 13:21:55 +0300
Date:   Sat, 19 Jun 2021 13:21:55 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Martin Ashby <martin@ashbysoft.com>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: cw2015: Add CHARGE_NOW support
Message-ID: <20210619102155.GC14960@home.paul.comp>
References: <20210218124250.128008-1-martin@ashbysoft.com>
 <20210618123017.GA10695@home.paul.comp>
 <8390c743-e4a4-bf1d-457e-2bfdcf9143d2@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8390c743-e4a4-bf1d-457e-2bfdcf9143d2@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tobias,

On Sat, Jun 19, 2021 at 11:52:34AM +0200, Tobias Schramm wrote:
> > Are you sure the chip reports current state of charge relative to the
> > full design capacity rather than to the latest auto-calibrated full
> > capacity? That would mean that over time as the cells wear out
> > cw_bat->soc (PROP_CAPACITY) is never going to be reaching 100; does
> > this match your experience?
> > 
> As far as I'm aware the gauge reports SoC relative to what it believes to be
> the the current, auto-calibrated full battery capacity.
> However, since I don't know how to extract that value from the gauge we just
> always assume it to be the design capacity [1].
> Since we inquire the gauge about current SoC directly [2] there is no way
> for any miscalculation on our end preventing it from reaching 100%.

After reading the datasheet for the gauge I'm rather disappointed. Not
using a shunt resistor for real current measurements and instead
relying on some magic doesn't make any sense in my book.

So to sum up, what you can get from the chip itself:

0. Battery voltage; pretty accurate.

1. Its idea of current state of charge; this is percentage relative to
the charge_full; I'd expect that to be reasonably accurate for not too
worn-out batteries.

2. Its idea of the remaining run time; involves secret magic to
somehow guess the current; I'd expect this to be relatively
inaccurate, would be interesting to learn how this performs for your
real life loads.

That's it. We can't learn charge_full and current_now.


Your driver code always reports charge_full equal to
charge_full_design which is plain incorrect IMHO. It's just wrong and
misleading, as after e.g. 2 years of usage the battery might lose half
its capacity; and people are used to get real data from power_supply
subsystem to be able to judge about battery health and performance.

Now you're also using the same value to calculate the current
reported. But the CW2015 datasheet says that SOC is relative to the
full capacity, not full design capacity, so the current you report
might get wildly inaccurate too. Same about charge_now that Martin
added: you just can't rely on unknown values when doing calculations.


If I was using this driver I would certainly prefer it to _not_ report
any grossly inaccurate guessimations. So I propose to remove
POWER_SUPPLY_PROP_CHARGE_FULL, POWER_SUPPLY_PROP_CHARGE_NOW and
POWER_SUPPLY_PROP_CURRENT_NOW altogether since they can't be
meaningfully obtained from anywhere. Please do not fool userspace into
thinking they have some information when in fact it's pulled out of
thin air.

I'm not the authority here so it would be nice to hear the opinion of
the subsystem maintainers, adding Sebastian to Cc. Ready to be proven
wrong :)

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
