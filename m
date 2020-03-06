Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169FB17C024
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 15:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFOXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 09:23:34 -0500
Received: from foss.arm.com ([217.140.110.172]:34598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgCFOXe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 09:23:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9797031B;
        Fri,  6 Mar 2020 06:23:33 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137363F534;
        Fri,  6 Mar 2020 06:23:31 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:23:30 +0000
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] cpuidle: psci: Allow WFI to be the only state for
 the hierarchical topology
Message-ID: <20200306134119.GB47929@bogus>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-5-ulf.hansson@linaro.org>
 <20200304122312.GE25004@bogus>
 <CAPDyKFpcN-p6sKqB0ujHAY29qPSg7qpSjYGymPaJ4W8jgCKGcg@mail.gmail.com>
 <20200305162321.GB53631@bogus>
 <CAPDyKFogjPG+mRsfPaxN7RjB7TQL9=qHNzA=K_t0F6M6Q9-TuA@mail.gmail.com>
 <20200306100431.GA16541@bogus>
 <CA+M3ks764moVU2h9iZJuN6B-e4wBUMymBfPnob_zraf50xqezA@mail.gmail.com>
 <20200306120646.GB44221@bogus>
 <CA+M3ks7+P=CjvUE28boANhrR6bhzLzyjBLovzWL_LjwL3UqmzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks7+P=CjvUE28boANhrR6bhzLzyjBLovzWL_LjwL3UqmzQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 01:32:59PM +0100, Benjamin Gaignard wrote:
> Le ven. 6 mars 2020 à 13:06, Sudeep Holla <sudeep.holla@arm.com> a écrit :
> >

[...]

> > Sure, please create a deeper CPU state than WFI and enter so that the CPU
> > state is saved and restored correctly. What is the problem doing that ?
>
> This state stop the clocks for all the hardware blocks and not only the CPUs
> so we can't go on it while devices aren't suspended.
> I may have missed something but I don't believe that I could add this kind of
> conditions in a cpu idle state, right ?
> In this state I need to be able to enable the wake up sources because
> it is the only
> for hardware block used as broadcast timer to wake up the system.
>

We have discussed this in past in the thread I mentioned and may be
others too. It sounds like a broken hardware, sorry if I am wrong.
But this $subject patch is a hack to solve that and I am NACK-ing this
now. Please fix it adding another CPU level idle state, we are not
supporting without that and there is absolutely no need to.

--
Regards,
Sudeep
