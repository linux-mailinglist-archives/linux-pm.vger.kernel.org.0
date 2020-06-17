Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8602C1FCDAC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFQMsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 08:48:02 -0400
Received: from foss.arm.com ([217.140.110.172]:57334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQMsB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 08:48:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E62E1042;
        Wed, 17 Jun 2020 05:48:01 -0700 (PDT)
Received: from bogus (unknown [10.37.12.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C35E93F6CF;
        Wed, 17 Jun 2020 05:47:59 -0700 (PDT)
Date:   Wed, 17 Jun 2020 13:47:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: arm_scmi: Set fast_switch_possible
 conditionally
Message-ID: <20200617124753.GA15211@bogus>
References: <20200617094332.8391-1-nicola.mazzucato@arm.com>
 <20200617094332.8391-2-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617094332.8391-2-nicola.mazzucato@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 17, 2020 at 10:43:32AM +0100, Nicola Mazzucato wrote:
> Currently the fast_switch_possible flag is set unconditionally
> to true. Based on this, schedutil does not create a
> thread for frequency switching and would always use the
> fast switch path.
> However, if the platform does not support frequency
> fast switch, this may cause the governor to attempt an
> operation that is not supported by the platform.
>
> Fix this by correctly retrieve the fast_switch capability
> from the driver which knows if the platform can support
> this feature.
>

Hi Viresh,

This is first step towards avoiding polling based cpufreq set if firmware
has fast access registers that bypass normal mailbox based messaging.

If you happy with this and provide ack, I will take this along with scmi
changes via ARM SoC. Hope that is fine by you.

--
Regards,
Sudeep
