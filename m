Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872FD3E569B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 11:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhHJJS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 05:18:29 -0400
Received: from foss.arm.com ([217.140.110.172]:51682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238813AbhHJJS0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 05:18:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78AA6D6E;
        Tue, 10 Aug 2021 02:18:04 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC2E23F718;
        Tue, 10 Aug 2021 02:17:59 -0700 (PDT)
Subject: Re: [PATCH 0/8] cpufreq: Auto-register with energy model
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6449a61f-a5fc-0b81-65b2-7bf77b8a71aa@arm.com>
Date:   Tue, 10 Aug 2021 10:17:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1628579170.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

I like the idea, only small comments here in the cover letter.

On 8/10/21 8:36 AM, Viresh Kumar wrote:
> Provide a cpufreq driver flag so drivers can ask the cpufreq core to register
> with the EM core on their behalf. This allows us to get rid of duplicated code
> in the drivers and fix the unregistration part as well, which none of the
> drivers have done until now.

The EM is never freed for CPUs by design. The unregister function was
introduced for devfreq devices.

> 
> This would also make the registration with EM core to happen only after policy
> is fully initialized, and the EM core can do other stuff from in there, like
> marking frequencies as inefficient (WIP). Though this patchset is useful without
> that work being done and should be merged nevertheless.
> 
> This doesn't update scmi cpufreq driver for now as it is a special case and need
> to be handled differently. Though we can make it work with this if required.

The scmi cpufreq driver uses direct EM API, which provides flexibility
and should stay as is.

Let me review the patches.

Regards,
Lukasz
