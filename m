Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A4DCBD8
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502154AbfJRQsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 12:48:11 -0400
Received: from [217.140.110.172] ([217.140.110.172]:45822 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2502156AbfJRQsL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 12:48:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2DAE101E;
        Fri, 18 Oct 2019 09:47:45 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4EC83F718;
        Fri, 18 Oct 2019 09:47:43 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:47:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 01/13] cpuidle: psci: Fix potential access to unmapped
 memory
Message-ID: <20191018164739.GA19850@e121166-lin.cambridge.arm.com>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-2-ulf.hansson@linaro.org>
 <20191018093839.GB25918@e121166-lin.cambridge.arm.com>
 <CAPDyKFqcHY6+Eq9d6xTPYMDrUOtGs+64YuwZ1EbFtqQZe0+xEw@mail.gmail.com>
 <20191018100304.GA28830@e121166-lin.cambridge.arm.com>
 <CAPDyKFoEf1-2z8d2r15=fg-9sY5u93iOzuUmmsYYiG9+8uB9Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoEf1-2z8d2r15=fg-9sY5u93iOzuUmmsYYiG9+8uB9Dw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 12:29:54PM +0200, Ulf Hansson wrote:

[...]

> > Technically we are not fixing anything; it is not such a big
> > change, we need to allocate one entry more and update the array
> > indexing.
> 
> Okay, let me do the change - and it seems like it doesn't even have to
> be sent as a fix then. Right?

No it does not (even though I agree that's misleading and "fixing"
it for v5.4 would not hurt either).

Lorenzo
