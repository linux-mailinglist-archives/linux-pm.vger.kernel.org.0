Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B906B835D4
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfHFPyL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 11:54:11 -0400
Received: from foss.arm.com ([217.140.110.172]:35802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733105AbfHFPyL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 11:54:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C01344;
        Tue,  6 Aug 2019 08:54:10 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351913F575;
        Tue,  6 Aug 2019 08:54:09 -0700 (PDT)
Date:   Tue, 6 Aug 2019 16:54:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/6] drivers: firmware: psci: Decouple checker from
 generic ARM CPUidle
Message-ID: <20190806155407.GC16546@e107155-lin>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <20190722153745.32446-4-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722153745.32446-4-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 04:37:42PM +0100, Lorenzo Pieralisi wrote:
> The PSCI checker currently relies on the generic ARM CPUidle
> infrastructure to enter an idle state, which in turn creates
> a dependency that is not really needed.
> 
> The PSCI checker code to test PSCI CPU suspend is built on
> top of the CPUidle framework and can easily reuse the
> struct cpuidle_state.enter() function (previously initialized
> by an idle driver, with a PSCI back-end) to trigger an entry
> into an idle state, decoupling the PSCI checker from the
> generic ARM CPUidle infrastructure and simplyfing the code
> in the process.
> 
> Convert the PSCI checker suspend entry function to use
> the struct cpuidle_state.enter() function callback.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Not sure why we didn't take this path from the beginning.
Anyways make sense and much needed for later patches in the series.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
