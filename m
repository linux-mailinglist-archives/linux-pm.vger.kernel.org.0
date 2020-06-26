Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D1920B3A2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgFZOeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 10:34:02 -0400
Received: from foss.arm.com ([217.140.110.172]:55536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFZOeB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jun 2020 10:34:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40B201FB;
        Fri, 26 Jun 2020 07:34:01 -0700 (PDT)
Received: from bogus (unknown [10.37.12.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AB3E3F6CF;
        Fri, 26 Jun 2020 07:33:57 -0700 (PDT)
Date:   Fri, 26 Jun 2020 15:33:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] cpuidle: psci: Fail cpuidle registration if set OSI
 mode failed
Message-ID: <20200626143355.GC27140@bogus>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
 <20200615152054.6819-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615152054.6819-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15, 2020 at 05:20:50PM +0200, Ulf Hansson wrote:
> Currently we allow the cpuidle driver registration to succeed, even if we
> failed to enable the OSI mode when the hierarchical DT layout is used. This
> means running in a degraded mode, by using the available idle states per
> CPU, while also preventing the domain idle states.
>

Is that not better than not registering itself ? I tend to disagree here.

> Moving forward, this behaviour looks quite questionable to maintain, as
> complexity seems to grow around it, especially when trying to add support
> for deferred probe, for example.
>

I thought the sync_state in the driver must deal with that.

> Therefore, let's make the cpuidle driver registration to fail in this
> situation, thus relying on the default architectural cpuidle backend for
> WFI to be used.
>

CPU level states work w/o the need of OSI, and better than WFI. That was
the original aim. If that is not working, we must make it work instead
of falling back on WFI IMO.

--
Regards,
Sudeep
