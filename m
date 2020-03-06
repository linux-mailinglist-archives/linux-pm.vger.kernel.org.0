Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D740B17C0DF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 15:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCFOuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 09:50:17 -0500
Received: from foss.arm.com ([217.140.110.172]:34984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgCFOuR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 09:50:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E4C41FB;
        Fri,  6 Mar 2020 06:50:16 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 042463F237;
        Fri,  6 Mar 2020 06:50:14 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:50:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
Message-ID: <20200306144951.GA11624@bogus>
References: <20200304122312.GE25004@bogus>
 <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
 <20200305162321.GB53631@bogus>
 <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
 <20200306100431.GA16541@bogus>
 <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
 <20200306120646.GB44221@bogus>
 <CA+M3ks7+P=CjvUE28boANhrR6bhzLzyjBLovzWL_LjwL3UqmzQ@mail.gmail.com>
 <20200306134119.GB47929@bogus>
 <CA+M3ks5XBFcJqQozA=k6nU2XawRYT_qKnLW9t_GdkoRGNEd1yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks5XBFcJqQozA=k6nU2XawRYT_qKnLW9t_GdkoRGNEd1yA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 03:44:33PM +0100, Benjamin Gaignard wrote:
> Le ven. 6 mars 2020 à 15:23, Sudeep Holla <sudeep.holla@arm.com> a écrit :
> >
> > On Fri, Mar 06, 2020 at 01:32:59PM +0100, Benjamin Gaignard wrote:
> > > Le ven. 6 mars 2020 à 13:06, Sudeep Holla <sudeep.holla@arm.com> a écrit :
> > > >
> >
> > [...]
> >
> > > > Sure, please create a deeper CPU state than WFI and enter so that the CPU
> > > > state is saved and restored correctly. What is the problem doing that ?
> > >
> > > This state stop the clocks for all the hardware blocks and not only the CPUs
> > > so we can't go on it while devices aren't suspended.
> > > I may have missed something but I don't believe that I could add this kind of
> > > conditions in a cpu idle state, right ?
> > > In this state I need to be able to enable the wake up sources because
> > > it is the only
> > > for hardware block used as broadcast timer to wake up the system.
> > >
> >
> > We have discussed this in past in the thread I mentioned and may be
> > others too. It sounds like a broken hardware, sorry if I am wrong.
> > But this $subject patch is a hack to solve that and I am NACK-ing this
> > now. Please fix it adding another CPU level idle state, we are not
> > supporting without that and there is absolutely no need to.
>
> A CPU idle state only take care of CPU activities, right ? but before going in
> the targeting state I need to be sure that the other hardware blocks
> are suspended.
> Is it possible to describe that in an idle state ?
> What sound broken ? is it because we need to setup the wake up sources ?
>

You said: " In DT I have one system power domain where the hardware blocks
(i2c,uart; spi, etc..) are attached + a power per CPU". Now since the CPU
stays in WFI always in this platform, it means it is always ON and you
can't vote to power down the magic "system power domain".

--
Regards,
Sudeep
