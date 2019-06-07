Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC496395CA
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfFGTeL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 15:34:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46051 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfFGTeL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 15:34:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so793463plb.12
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2019 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wpKUd2nT5fJdpxBIuy/BOsoGuLISr+yeuc18GcpDf6g=;
        b=tf63b50aos3gIs6Uh0x0ZPeVIy4dEEbpe9EQmwGyT5+A2Gw+N/fvymG2EdZPGIy8L9
         5xNyeQKO8zT6AP0IKirJTEmIaiKb0OS22rDKMOn0xOxkquKtpLyow98OJ4nggW92g6My
         9pdMTgF13mlwfqUP3g8TWHhyUpxL9SbblVrXJdKjTdqxqojrU5td0HmAQ0uovPfbnxVC
         drUELbnT0qtfXIoREosTwsWm+DTIQBTK17ZyUprcwTpWecwDd1KhtfUWf8qd3HewI/gj
         yccWS8LfVbTTNCkPA7VUiFxQPzMCcZkELxdnOr46rMOQzYY/LSG5VMTANT0WWgP6jyeo
         1SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wpKUd2nT5fJdpxBIuy/BOsoGuLISr+yeuc18GcpDf6g=;
        b=P2PbUeRa3+VXiQLncwlbTUm0ZtSf9PYVYgULr1nrANHcTmSFwT7Fzwf4IguQs2MH5r
         IdL1LBGRNWpuGrpDM40yaX1XvWIXTpb8Dx1kVWozY01bBkLKqgfEev7SEjMeVOXwh6Oc
         G69NOUT5SrINwhNnaq6Q/kgTTdgFiRzRby/Yy/8f6xX8OVP/7RW/2ifmbxKYRomDrmTX
         +iCPg4NPmUzw0IA8kOk0pgj3FOBdbF/lPGVLoP4go+P47CUmOAU1vkWqhVcD9ceEidCF
         dKkHDfDkoklB5Zl2SK6X0+DlHwrWjyS/tXPenfhRZCvolj5C9ypOf1z16TeplSfrMeBZ
         3pRQ==
X-Gm-Message-State: APjAAAUq7HgBt4phKXFkuOMCyle4XRZ7/NGVhu+rTnWjTOjsq4gyvim8
        I7nrrXxWqHVEgtNQILN/1uuhuAGrv9w=
X-Google-Smtp-Source: APXvYqxSC7rw05vLxn/PlSEW90GOUry7OdvPp1Qde6epr5HHI6UoO46GU4ItChia53NkMezfJO+8dA==
X-Received: by 2002:a17:902:2883:: with SMTP id f3mr57841151plb.111.1559936050681;
        Fri, 07 Jun 2019 12:34:10 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o26sm2726497pgv.47.2019.06.07.12.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 12:34:10 -0700 (PDT)
Date:   Fri, 7 Jun 2019 12:34:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement
 for PSCI
Message-ID: <20190607193407.GB24059@builder>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
 <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
 <20190607154210.GJ15577@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607154210.GJ15577@e107155-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 07 Jun 08:42 PDT 2019, Sudeep Holla wrote:

> On Tue, May 14, 2019 at 10:58:04AM +0200, Ulf Hansson wrote:
> > On Tue, 14 May 2019 at 10:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, May 13, 2019 at 9:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > This series enables support for hierarchical CPU arrangement, managed by PSCI
> > > > for ARM/ARM64. It's based on using the generic PM domain (genpd), which
> > > > recently was extended to manage devices belonging to CPUs.
> > >
> > > ACK for the patches touching cpuidle in this series (from the
> > > framework perspective), but I'm assuming it to be taken care of by
> > > ARM/ARM64 maintainers.
> >
> > Thanks for the ack! Yes, this is for PSCI/ARM maintainers.
> >
> > BTW, apologize for sending this in the merge window, but wanted to
> > take the opportunity for people to have a look before OSPM Pisa next
> > week.
> >
> 
> I will start looking at this series. But I would request PSCI/other
> maintainers to wait until we see some comparison data before we merge.

What comparison are you asking for here? Do you want to see the
improvement this series gives or are you hoping to compare it with some
other mechanism?

> If they are fine to merge w/o that, I am fine. As of now we have just
> 1-2 platforms to test(that too not so simple to get started) and the
> long term support for them are questionable.

Why is the support for these platforms questionable? People are actively
working on these platforms and the feature set constantly improving.

> Also with SDM845 supporting PC, we have excellent opportunity to
> compare and conclude the results found.

That's correct, ATF exists for SDM845. But with the standard choice of
firmware you will get OSI and I don't know of a board out there where
you can switch between them and do a apple to apple comparison.

Devices such as RB3 (96boards SDM845), Pixel3 and the Windows laptops
are all OSI only.


So landing this support is not a question of PC or OSI being the better
choice, it's a question of do we want to be able to enter these lower
power states - with the upstream kernel - on any past, present or future
Qualcomm devices.

Regards,
Bjorn
