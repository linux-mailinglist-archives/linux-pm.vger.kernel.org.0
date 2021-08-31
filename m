Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74A83FC481
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhHaIzk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 04:55:40 -0400
Received: from foss.arm.com ([217.140.110.172]:52410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240380AbhHaIzk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 04:55:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803EB1FB;
        Tue, 31 Aug 2021 01:54:44 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FE993F5A1;
        Tue, 31 Aug 2021 01:54:40 -0700 (PDT)
Subject: Re: [PATCH V3 0/9] Add callback to register with energy model
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
References: <cover.1628742634.git.viresh.kumar@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3d5b823f-259a-8fc6-27ab-2a5d5df89844@arm.com>
Date:   Tue, 31 Aug 2021 10:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1628742634.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/08/2021 06:35, Viresh Kumar wrote:
> Many cpufreq drivers register with the energy model for each policy and
> do exactly the same thing. Follow the footsteps of thermal-cooling, to
> get it done from the cpufreq core itself.
> 
> Provide a new callback, which will be called, if present, by the cpufreq
> core at the right moment (more on that in the code's comment). Also
> provide a generic implementation that uses dev_pm_opp_of_register_em().
> 
> This also allows us to register with the EM at a later point of time,
> compared to ->init(), from where the EM core can access cpufreq policy
> directly using cpufreq_cpu_get() type of helpers and perform other work,
> like marking few frequencies inefficient, this will be done separately.
> 
> This is build/boot tested by the bot for a couple of boards.
> 
> https://gitlab.com/vireshk/pmko/-/pipelines/351965580
> 
> FWIW, I have queued up the series for linux-next to get more testing, but your
> reviews are welcome. Thanks.
> 
> V2->V3:
> - Drop the auto-register part from all logs, this isn't called auto registration
>   anymore.
> - Call register_em() only for new policies.
> - Update scmi driver to register with EM only when required.
> - Add Rby tags.

LGTM. Tested on TC2 (vexpress-spc), Juno-r0 (scpi-cpufreq and scmi).

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>


