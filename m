Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E5413231A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 10:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgAGJ6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 04:58:38 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:10498 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgAGJ6i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 04:58:38 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47sSWJ1fDMz39;
        Tue,  7 Jan 2020 10:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578391116; bh=DckSMbQGrkJkV8SZ/4frgGzn8td5s/q5GcUzXT57kyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJeppMG3SUpGR5br0nhNkmnKIgDju2w8v19ouX6n++Z69ayPmOEWktUDLFSWR9CIq
         5esfs1SnAADmKeFLnQinJ2YWTZBadWESl8oIxMsR3WC/AJE4Cuqs3K3D8FGs1KmKTK
         Z1OVX15oefUaopnJrqEiXze0Rddmrnm7FzaupnUlOq5xFGYKjMXnK5RfdkWoBmaPeC
         pLCOK+WiCjAjYKgtu2iwwEAOE8rpbGj35aDecOq9Y4sQ9owY6T2/RYkJNDyi3xjU/F
         k4tKmA2AaeFcjyQ0TC0a8WY6EKESfztt3js7UbdZqXNoAmHwEmt7s+4mc43T8FjkBm
         aqO7uQx6rs/sA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 7 Jan 2020 10:58:35 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200107095834.GB3515@qmqm.qmqm.pl>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107064128.gkeq2ejtvx4bmyhj@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107064128.gkeq2ejtvx4bmyhj@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 07, 2020 at 12:11:29PM +0530, Viresh Kumar wrote:
> On 03-01-20, 20:36, Micha³ Miros³aw wrote:
> > Per CPU screenful of backtraces is not really that useful. Replace
> > WARN with a diagnostic discriminating common causes of empty OPP table.
> But why should a platform have an OPP table in DT where none of them works for
> it ? I added the warn intentionally here just for that case.

Hmm. I guess we can make it WARN_ON_ONCE instead of removing it, but I
don't think the backtrace is ever useful in this case. Empty table can
be because eg. you run old DT on newer hardware version. This is why
it's still communicated via dev_err().

Best Regards,
Micha³ Miros³aw
