Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16B3BACD
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfFJRQ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 13:16:26 -0400
Received: from foss.arm.com ([217.140.110.172]:46590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbfFJRQ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jun 2019 13:16:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CF56337;
        Mon, 10 Jun 2019 10:16:25 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB4803F246;
        Mon, 10 Jun 2019 10:16:22 -0700 (PDT)
Date:   Mon, 10 Jun 2019 18:16:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20190610171557.GA4560@redmoon>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
 <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
 <20190607154210.GJ15577@e107155-lin>
 <20190607193407.GB24059@builder>
 <20190610103225.GA26602@e107155-lin>
 <CAPDyKFr31SwmHHAREbR3dWMQ55LzzUyTc4M5FZvNsqWfX7SE8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr31SwmHHAREbR3dWMQ55LzzUyTc4M5FZvNsqWfX7SE8Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 10, 2019 at 05:54:39PM +0200, Ulf Hansson wrote:

[...]

> My summary from the earlier ones, is that because the PSCI spec
> includes support for OSI, we should also support it in the kernel (and
> ATF). In a discussion offlist, Lorenzo agreed that it's okay to add,
> without an apple to apple comparison. Maybe Lorenzo can fill in and
> state this publicly, to save us all some time?

The comparison should have been made before even requesting PSCI OSI
mode changes to the specifications, so we have a chip on our shoulders
anyway.

We will enable PSCI OSI but that's not where the problem lies, enabling
PSCI OSI from a firmware perspective should take 10 lines of code,
not:

 drivers/firmware/psci/Makefile                |   2 +-
 drivers/firmware/psci/psci.c                  | 219 ++++++++--
 drivers/firmware/psci/psci.h                  |  29 ++
 drivers/firmware/psci/psci_pm_domain.c        | 403 ++++++++++++++++++

I have some concerns about these changes that I will state in the
relevant patches.

> My final point in regards to the OSI mode support, it's a minor part
> of the series. I don't see how that should hurt from a maintenance
> point of view, or perhaps I am wrong? In any case, I offer my help
> with review/maintenance in any form as you may see need/fit.

I will go through the series but most of this code should move
to core PM code, it has nothing to do with PSCI.

BTW, apologies for the delay, I was away.

Thanks,
Lorenzo
