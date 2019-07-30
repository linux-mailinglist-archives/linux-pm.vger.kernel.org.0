Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3579F5D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 05:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbfG3DCw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 23:02:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbfG3DCB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 23:02:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so29230408pgp.12
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 20:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+E8omEH906TCMOUVaEXWKpNgn+JOLXcUorYQ/vWPPf0=;
        b=Jc/YC9lel3yNzxidJjL/B8/vFfeBsxFRicp39Oey3HLLBmzOKFl/TkdXqJsgaO1ojq
         U2JDseu5QkwHIr9DHg0Zy0zyY6F38DCkSBbHVg66ejwCQhUvk8ZNDHIfTgLKiL4wcxnX
         kp3K5zAmDoNjx9JdClWVxBf6JClsj1i/bpDJvJd/D2JYl0wPfjFznJl6Dx/c/a+kWsZy
         0JCiBkHDo1hgK5btmADMHNmvEiuAHyWZnndkFa5ojybqyyPu7YS0X5qky1c/fzbAFGkL
         k34hKPYhDnIFWjNHjar8YM+WjTadzFWy1D8/2FLDNSc7iZtKUFacgaiGgqk2bpFYZNGh
         XuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+E8omEH906TCMOUVaEXWKpNgn+JOLXcUorYQ/vWPPf0=;
        b=Gwe6amWsnbXWppFDwczIlG7pY61z8N8vPe2BzG+yGMnz9jLVuevJYlG5nPyKjIzGYc
         2FTsU+RVzpuZna2IghwFYrbbAnJLq/hII4EbjxGPv9oO12KP9A3EzJzwwjFaFn5bUatg
         IwEp6aR3l/U5AeJ9cNI/9tp8kfpoBUzNYEStmXLdnjRJodwP3YVUzh1WmTFnzScK8ipX
         c+APZBxg6WrN8pCKUX62BSfiNRt5+017zJAo0NmvzaWX4/46SWQSeqjLXFDxd/AuH9rZ
         u7uu0RH5N14R3hAMorGmBm/NizAOUOQ7N/H4iC3wkqp81qgEBK6s+GLc9Vksv7gHoDlb
         Nuiw==
X-Gm-Message-State: APjAAAWfjx0dxSXq4VC0OhT3OMU+6OOqGEVc3Lx7DiOmQYcpc8aeegMt
        pnoJkiWg1DXzuMI+E3uluc139A==
X-Google-Smtp-Source: APXvYqzE6E6bwEiPVPhC8MPvNKfvs+L5X43/lx99CsVqkOn2lJdGMjp42IO+nI7wkwvsesO+oQP+bA==
X-Received: by 2002:a63:101b:: with SMTP id f27mr103042864pgl.291.1564455720224;
        Mon, 29 Jul 2019 20:02:00 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id i126sm75052149pfb.32.2019.07.29.20.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 20:01:59 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:31:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
Message-ID: <20190730030157.aml7z6vfsiqgyief@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190717103220.f7cys267hq23fbsb@vireshk-i7>
 <CAGETcx-tbjVzRKW8D-564zgNOhrA_z-NC1q5U70bhoUDBhp6VA@mail.gmail.com>
 <20190718053746.64drmonk72vwnt4s@vireshk-i7>
 <CAGETcx_-=b3An9YdxLUnZap=0iaeczvWTEnw65FMLU8BwA3HfQ@mail.gmail.com>
 <20190729092454.6lfqzmhkvrhpimsp@vireshk-i7>
 <CAGETcx_7fK20VZ6Zn07Z+Ran1_O7gSPohck_tg-aEr5oONQ5iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_7fK20VZ6Zn07Z+Ran1_O7gSPohck_tg-aEr5oONQ5iA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-07-19, 13:12, Saravana Kannan wrote:
> On Mon, Jul 29, 2019 at 2:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-07-19, 21:12, Saravana Kannan wrote:
> > > On Wed, Jul 17, 2019 at 10:37 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > I would like
> > > > to put this data in the GPU OPP table only. What about putting a
> > > > range in the GPU OPP table for the Bandwidth if it can change so much
> > > > for the same frequency.
> > >
> > > I don't think the range is going to work.
> >
> > Any specific reason for that ?
> 
> The next sentence was literally explaining this :) Fine to debate
> that, but ignoring that and asking this question is kinda funny.

Okay, but ...
 
> > > If a GPU is doing purely
> > > computational work, it's not unreasonable for it to vote for the
> > > lowest bandwidth for any GPU frequency.

... it wasn't clear to me even after reading this sentence again now
:)

I understand that you may have to vote for the lowest bandwidth but
that doesn't explain why a range can't work (sorry if it was just me
who doesn't understood it :)).

> > I think that is fine, but if the GPU is able to find how much
> > bandwidth it needs why can't it just pass that value without needing
> > to have another OPP table for the path ?
> 
> You were asking this question in the context of "can the GPU OPP just
> list all the range of bandwidth it might use per GPU frequency". My point
> is that the range would be useless because it would the entire
> available bandwidth range (because purely compute work might not need
> any bandwidth).

If it is useless to have entire range here, then why bother providing
one ? Why can't the GPU request what it needs in exact terms, based on
its calculations ? And then based on these requests, let the
interconnect find what's the best/stable values it really wants to
program the path for (and for that the interconnect can use its own
OPP table, which would be fine).

> Whereas, what the GPU's algorithm actually needs might be the list of
> "useful" bandwidth levels to use.

Hmm, I am not sure GPU's algorithm needs this table AFAIU based on all
the conversations we had until now. It is very capable of finding how
much bandwidth it needs, you just want the GPU driver to finally align
that with a stable bandwidth for the platform later on. And what I am
asking is that it is not required for the end driver to look for
stable values, it just requests what it wants and let the interconnect
core/driver decide the stable values.

Very much like the clock framework, most of the user drivers just ask
for a clk value to be programmed and it is the clock driver which
keeps a table of the stable values and then aligns the requested value
to one of those.

> Also, as we add more ICC request properties, this range idea will not scale.

I am not sure about what kind of properties there can be and where
should they land. My feedback is completely based on what you have
presented in this patchset.

-- 
viresh
