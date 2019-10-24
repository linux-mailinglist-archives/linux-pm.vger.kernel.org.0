Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1FE369F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503124AbfJXP1k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 11:27:40 -0400
Received: from foss.arm.com ([217.140.110.172]:54358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503101AbfJXP1k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Oct 2019 11:27:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0280331F;
        Thu, 24 Oct 2019 08:27:27 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF8F3F71F;
        Thu, 24 Oct 2019 08:27:25 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:27:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 03/13] firmware: psci: Export functions to manage the OSI
 mode
Message-ID: <20191024152722.GB11467@bogus>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010113937.15962-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 01:39:27PM +0200, Ulf Hansson wrote:
> To allow subsequent changes to implement support for OSI mode through the
> cpuidle-psci driver, export the existing psci_has_osi_support(). Export
> also a new function, psci_set_osi_mode(), that allows its caller to enable
> the OS-initiated CPU-suspend mode in the PSCI FW.
>
> To deal with backwards compatibility for a kernel started through a kexec
> call, default to set the CPU-suspend mode to the Platform Coordinated mode
> during boot.
>

FWIW,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
