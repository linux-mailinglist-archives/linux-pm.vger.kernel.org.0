Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C440E3ADB74
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhFSTIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Jun 2021 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbhFSTIr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jun 2021 15:08:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14EC061574
        for <linux-pm@vger.kernel.org>; Sat, 19 Jun 2021 12:06:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j2so22670577lfg.9
        for <linux-pm@vger.kernel.org>; Sat, 19 Jun 2021 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQ8vk+SamXT0d6L+lwKEHwWBDQaHqxNIr8PibRmpAgw=;
        b=s++2zpnnxrfXg/cxjs4/7acBtCW8Wdt/2IQLGJ3ZQLF4zBn+8LuIsMjo1n9JCm0zY8
         ahyStleMq80TnpqqY70TnsRIr7/qwo5gawinBBiR8cicVH9TX+Ilf75Q/pUPss+yL5k6
         +kgbfvi8Z6c62TOGxqSe0OIOsjAyJgjcJteaXvOsbHjZwEyGc+tc4M2MqN22KpkP54Ri
         DibcvU8HfKSLtqYU+A5rZbpnKpEO09Z/im8yV+T8+uduZRg0PtfkKu0vqHnvLmDaDVI9
         PKlI2asQX90VGM6cuXGPNhuYyUW8xAnycUQ1zyPaCrHCy/IJz9xhuU819LQdha3+BsPj
         NDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQ8vk+SamXT0d6L+lwKEHwWBDQaHqxNIr8PibRmpAgw=;
        b=sQUZegTz5emqKIcNUpgdhYpO7DQM2sqdJjBx3FbynbRd5JyF951+6pbBgCpk8+0wb2
         A1ymd3ox/dRsnZbb+1RLxKjtDmkb6fn4gyqd9YLPf7hyqqw9aIT07ZcGL4vOkz2EY8JM
         YMtQuVz16gZ5RGx38zZTsloYqVBJlCFz0s9TzQKISs+ntgbPdvRR87JVzlZz5KFAYl9Q
         MHs5NaLSRs/ZfThGoEDbr5xQQwmaqIQ71pngdTue6C2PWBIeDx/dABstFNZy+gsTcxd6
         tG0De99DbH9LYBMJ3DDAhIpPii1OD7RTRBKSU20WRcpvDni+7zqUXI+C0bRPNcJ+UshR
         W7XQ==
X-Gm-Message-State: AOAM533TGZ0c5lAX3PzGPDTtxJ7aGjwBaH9DPYLydSsTwEYCqjO/67wU
        pk/WX+KE17HblphWh/kw5w8=
X-Google-Smtp-Source: ABdhPJxHCmIS9bwKUPtfhSB4kSLPWQo8yolxZFTxQsQaGH1rlHPFWJPiXF/BiwN6M34NiQ8gmNE9Rg==
X-Received: by 2002:a19:4c03:: with SMTP id z3mr997876lfa.78.1624129593202;
        Sat, 19 Jun 2021 12:06:33 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id t13sm1517116ljc.30.2021.06.19.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 12:06:32 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 15JJ6TV7015386;
        Sat, 19 Jun 2021 22:06:30 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 15JJ6THi015385;
        Sat, 19 Jun 2021 22:06:29 +0300
Date:   Sat, 19 Jun 2021 22:06:29 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Martin Ashby <martin@ashbysoft.com>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: cw2015: Add CHARGE_NOW support
Message-ID: <20210619190628.GN14960@home.paul.comp>
References: <20210218124250.128008-1-martin@ashbysoft.com>
 <20210618123017.GA10695@home.paul.comp>
 <8390c743-e4a4-bf1d-457e-2bfdcf9143d2@manjaro.org>
 <20210619102155.GC14960@home.paul.comp>
 <84e6a4f2-7eaa-c606-d5e7-b15da91b24be@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e6a4f2-7eaa-c606-d5e7-b15da91b24be@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tobias,

On Sat, Jun 19, 2021 at 03:48:12PM +0200, Tobias Schramm wrote:
> Am 19.06.21 um 12:21 schrieb Paul Fertser:
> ...
> > After reading the datasheet for the gauge I'm rather disappointed. Not
> > using a shunt resistor for real current measurements and instead
> > relying on some magic doesn't make any sense in my book.
> 
> I felt similarly when reading it for the first time. However, by now some
> more well known manufacturers have started offering similar products [1].

Thank you for the link, that's rather interesting, especially combined
with the TRM for the product.

What I find of specific relevance to our current discussion is that
this chip provides not one but two "charge_full" values: one assuming
less than C/20 load, and another assuming the current load. While
cx2015 doesn't give even one. 

> It seems the manufacturers are relying on internal resistance of the battery
> to measure current draw.

I'm still puzzled about how they might be able to estimate the current
looking just at the voltage and temperature. Apparently they're
successful enough but how do they manage?

> In general it seems to work pretty well in the Pine64 Pinebook Pro for about
> two years now.

In other words, if you leave the laptop idling and check RRT every now
and then, you see reasonable values and it reaches zero at about the
time it turns off; and same when you're doing an e.g. stress-ng --cpu
run?

> > Your driver code always reports charge_full equal to
> > charge_full_design which is plain incorrect IMHO. It's just wrong and
> > misleading, as after e.g. 2 years of usage the battery might lose half
> > its capacity; and people are used to get real data from power_supply
> > subsystem to be able to judge about battery health and performance.
> 
> It most definitely is. I'm not really happy with reporting them either.
> However it seems that a lot of battery widgets get very confused if those
> stats are not reported.

Probably rightfully so? Having no reliable data to show _is_ indeed
confusing.

> Thus I went for some level of guestimation there. Please feel free to remove
> them and test whether all the usual battery monitoring tools still work.
> I'll be more than happy to remove them if it is not a problem anymore.

If I had a Pinebook Pro I would be using Xmobar on it and I would
propose a patch to fall back to show "capacity" and "time_to_empty" in
cases like that; in other words, knowing the limitations, I'd make my
own choices about what to show where and whether I need any
guessimations or not.

> The supported parameters were mostly chosen based on the Android
> reference code provided to me by CellWise

If anything, that should serve as a "requires careful
re-consideration" red flag ;)

> and user feedback (battery applet compatibility). I'd hate breaking
> the latter.

If some battery applet finds certain set of parameters to be
insufficient then it's just that, the applet is not compatible with
this hardware. I know the "we do not break userspace" mantra but
breaking something (that used to work before) is one thing and luring
the userspace into doing things by presenting it with fake data is
another.

My userspace is Xmobar and I'm ready to fix it for Pinebook Pro users
if you remove reporting of the fake data. 

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
