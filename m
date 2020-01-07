Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42A2132837
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 14:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgAGN5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 08:57:50 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:43075 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGN5u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 08:57:50 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47sYqJ14XNz81;
        Tue,  7 Jan 2020 14:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578405468; bh=BoDbS0Y77Y46eqRee+OSdUUGKre0sFOIVfgYgRLHBGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbjY1UiP9HTz1ohnf71liNTB6gld9zHzWo+R2tRC+y3TUgHFE5JlPdOWq0f+Ecvwn
         vweWiW6WGv9vE0Zcc66WE5RdzREbR8HaDDhF+ZiZn3mOZc7A1ZtNiG+eiWny3i1FTK
         5jGP2j/y9Xbbj1IMZSsl3aOcn+GkDmDUEf3vnlJvHCDCt9S9/u/O1jiDjERnghiwwS
         VdWMqR1mhMlO6ZVZAs4MCH+3Yh3rAFpYT9Y5/S8hLmCwg6PYlZV8Guw29VZA3wEGcd
         TpTbC+PYDRhWbuR1V3PJBW/uaLw44qyrrEhwc6jGkJHzmakMgxrLsb/TsKo7A767uu
         EVcH17+qvDrNQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 7 Jan 2020 14:57:43 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200107135743.GA20159@qmqm.qmqm.pl>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107064128.gkeq2ejtvx4bmyhj@vireshk-i7>
 <20200107095834.GB3515@qmqm.qmqm.pl>
 <20200107113055.d4ebweisve73yf3m@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107113055.d4ebweisve73yf3m@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 07, 2020 at 05:00:55PM +0530, Viresh Kumar wrote:
> On 07-01-20, 10:58, Micha³ Miros³aw wrote:
> > On Tue, Jan 07, 2020 at 12:11:29PM +0530, Viresh Kumar wrote:
> > > On 03-01-20, 20:36, Micha³ Miros³aw wrote:
> > > > Per CPU screenful of backtraces is not really that useful. Replace
> > > > WARN with a diagnostic discriminating common causes of empty OPP table.
> > > But why should a platform have an OPP table in DT where none of them works for
> > > it ? I added the warn intentionally here just for that case.
> > Hmm. I guess we can make it WARN_ON_ONCE instead of removing it
> I am not sure this will get triggered more than once normally anyway, isn't it ?

It is triggered once per core.

> > , but I
> > don't think the backtrace is ever useful in this case.
> Hmm, I am less concerned about backtraces than highlighting problem in a serious
> way. The simple print messages are missed many times by people and probably
> that's why I used a WARN instead.

> 
> > Empty table can
> > be because eg. you run old DT on newer hardware version.
> 
> Hmm, but then a big warning isn't that bad as we need to highlight the issue to
> everyone as cpufreq won't be working. isn't it ?

A user normally can't do much about it. Rather this is a developer targeted
message. Maybe a rewording of the messages be better? Something to also
include consequences of the error?

Best Regards,
Micha³ Miros³aw
