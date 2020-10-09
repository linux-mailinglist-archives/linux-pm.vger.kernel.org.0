Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DFA28895F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgJIMzU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 08:55:20 -0400
Received: from foss.arm.com ([217.140.110.172]:50578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbgJIMzU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 08:55:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F831063;
        Fri,  9 Oct 2020 05:55:19 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8AD13F70D;
        Fri,  9 Oct 2020 05:55:18 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:55:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Add section for cpuidle-psci PM domain
Message-ID: <20201009125512.v5dx4lrlpjv55awe@bogus>
References: <20201001092852.124740-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001092852.124740-1-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 01, 2020 at 11:28:52AM +0200, Ulf Hansson wrote:
> The cpuidle-psci-domain.c is not listed in the section for the cpuidle
> driver for ARM PSCI. From discussions at LKML, Lorenzo and Sudeep prefer
> that we add a separate section for it, so let's do that and add myself as
> the maintainer for this part.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
