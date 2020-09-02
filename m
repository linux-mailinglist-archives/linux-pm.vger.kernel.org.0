Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414B425AFE4
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgIBPqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 11:46:53 -0400
Received: from foss.arm.com ([217.140.110.172]:38114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgIBNcG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 09:32:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 872E811B3;
        Wed,  2 Sep 2020 06:32:05 -0700 (PDT)
Received: from bogus (unknown [10.57.4.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12E373F68F;
        Wed,  2 Sep 2020 06:32:02 -0700 (PDT)
Date:   Wed, 2 Sep 2020 14:32:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] arch_topology: validate input frequencies to
 arch_set_freq_scale()
Message-ID: <20200902133200.GH25462@bogus>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200901205549.30096-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901205549.30096-2-ionela.voinescu@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 09:55:45PM +0100, Ionela Voinescu wrote:
> The current frequency passed to arch_set_freq_scale() could end up
> being 0, signaling an error in setting a new frequency. Also, if the
> maximum frequency in 0, this will result in a division by 0 error.
>
> Therefore, validate these input values before using them for the
> setting of the frequency scale factor.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
