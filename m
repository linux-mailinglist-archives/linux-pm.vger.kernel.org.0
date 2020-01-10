Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF41367B5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 07:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgAJGyZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 01:54:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46565 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbgAJGyY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 01:54:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so642680pff.13
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2020 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YhPLZOvbusu+BDcW4xtLEV0ezjrgdDBJUzmow7dtjMQ=;
        b=sKUMJWsXvcFP9jEO0Hl4uUyNvbyljQCLxhGsldiqDRvsC8IpLpEay5tiVJTep7pkQo
         oRqBgROQLiR2Dvoq/TyO1UMoQhdyRJ3wjy/MPdywSKlfQfgIT8OA5zHb8eDxN8hur6+m
         bmj0RfiXa6xUTOzhi3oi6cDzqHFZQqMWYm1TGCbkHjBAjoW1ygXyRXpF3uzJoPIuknpy
         U45mfuGgCk9q6RAjFHyZZE2ggGK2YJciePz/phNcN5zwDp79efcs1taM0Ee8bj8mvq6Z
         Vmx+d9BNX8QdTcgXvWiC6oEoF3c/fN21NQ2PM/PN7y0A+ZT+UCIE+AziDVobHNKrEQ5H
         6cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YhPLZOvbusu+BDcW4xtLEV0ezjrgdDBJUzmow7dtjMQ=;
        b=t5m22qBnt/AEs2s4AzBdtYbjQ6C1Q2huO47a3na67waCWIeMAIYDRhlTPjZcoqej5J
         WdQVJ9tpFnxW2yCaj47AxygsaHo3iobUPImVtOV4AbcD3hASZgfSFboOFPNft8wWL3ls
         pCYhdQQHWqMIqRsM1kR0suRqALMhLXHtq4ofIpuhSvlJto6nBjCxcKlUdUqjxN+7zy4N
         81aHgQho3cfTfvvq6ty0YeTOW22m/Kyn7vEKrd1Mkv2ZHmFfD4S9wweIozfqyOTc44S8
         U9XQmssy8A0AplW7+3geB0pp5wnBqtrDC52t9xxtTWhGTIb2ggkDtwsKulfdiqGqqgyD
         6lqg==
X-Gm-Message-State: APjAAAWxQ86jbun6w9F/DxXjQ0aJ9lBG9xtn+DQ10j/9yoRAgBhlyl0N
        BC/k1xbTjzPp+lDO9oLj0qudWA==
X-Google-Smtp-Source: APXvYqyqmwrNqG8WUg323dOQJc2jziGsBSe/4bAS5Q+Tv3gJE3iTY9fjXWBEohxRSFWlHgkV0K65JA==
X-Received: by 2002:a63:4824:: with SMTP id v36mr2501774pga.343.1578639263873;
        Thu, 09 Jan 2020 22:54:23 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id i3sm1384035pfo.72.2020.01.09.22.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 22:54:23 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:24:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20200110065420.3bp4fjj2wbezoyrc@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-3-saravanak@google.com>
 <20200108105348.p4y3s2mbuchiu4mf@vireshk-i7>
 <CAGETcx8QEV+_+d2yt_+bE09mi4qyHZDHPJqPiDXv_HgJPgQJoQ@mail.gmail.com>
 <20200109043108.fzvk3hp7vodtw6zy@vireshk-i7>
 <CAGETcx_1B8AfxBuJ9Mbq8BNx-fYyP8pOnF6caN=ooyPARaaJ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_1B8AfxBuJ9Mbq8BNx-fYyP8pOnF6caN=ooyPARaaJ3A@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-01-20, 10:35, Saravana Kannan wrote:
> Agreed for the example you are giving where PM domains/voltages are
> dropped automatically when dropping the device freq to suspend freq.
> I'm just wondering about a different scenario where if some power
> domain needed to be at say 0.5v when it's suspended (no consumer using
> it)

The domain should be powered off in this case I think.

> to not lose state, or to come back up without brownouts, etc then
> suspend OPP for PM domains might be useful. But I don't know enough
> about that to speak with authority, so I'll leave it at this.
> 
> I see this suspend-opp as a way to mark to what level the bandwidth
> needs to be dropped to/brought back up from during suspend/resume by
> the driver making interconnect bandwidth requests. For example, what
> if the CPU -> DDR needed to be at some level to avoid suspend/resume
> issues (say CPU bug with respect to timing/latencies)? In this
> example, the CPU driver would be the one making bandwidth requests for
> CPU -> DDR bandwidth during normal operation and during
> suspend/resume. So it's basically exactly the same way it would treat
> CPU freq OPP.

I understand your concerns but to me it all looks hypothetical right
now. I am not saying we won't support suspend-opp for interconnect or
domains, but that we should do it only if it is required.

> Btw, I don't have a strong opinion on this. But, even if we do only a
> rate comparison, what does it even mean to compare rates for genpd or
> BW opp tables?

We will never do the comparison because those tables will never have
the suspend OPP in the respective tables.

-- 
viresh
