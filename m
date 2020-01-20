Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA1142E1E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgATOxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 09:53:44 -0500
Received: from foss.arm.com ([217.140.110.172]:33146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbgATOxn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jan 2020 09:53:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAFF530E;
        Mon, 20 Jan 2020 06:53:42 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FF8C3F52E;
        Mon, 20 Jan 2020 06:53:36 -0800 (PST)
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
To:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Chris.Redpath@arm.com,
        ionela.voinescu@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, patrick.bellasi@matbug.net
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
Date:   Mon, 20 Jan 2020 15:53:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116152032.11301-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/01/2020 16:20, lukasz.luba@arm.com wrote:
> From: Lukasz Luba <lukasz.luba@arm.com>
> 
> Add support of other devices into the Energy Model framework not only the
> CPUs. Change the interface to be more unified which can handle other
> devices as well.

[...]

> -The source of the information about the power consumed by CPUs can vary greatly
> +The source of the information about the power consumed by devices can vary greatly
>  from one platform to another. These power costs can be estimated using
>  devicetree data in some cases. In others, the firmware will know better.
>  Alternatively, userspace might be best positioned. And so on. In order to avoid
> @@ -26,7 +28,7 @@ framework, and interested clients reading the data from it::
>         | Thermal (IPA) |  | Scheduler (EAS) |  |     Other     |
>         +---------------+  +-----------------+  +---------------+
>                 |                   | em_pd_energy()    |
> -               |                   | em_cpu_get()      |
> +               |  em_dev_get()     | em_cpu_get()      |

Looked really hard but can't find a em_dev_get() in the code? You mean
em_get_pd() ? And why em_get_pd() and not em_pd_get()?

>                 +---------+         |         +---------+
>                           |         |         |
>                           v         v         v
> @@ -47,12 +49,12 @@ framework, and interested clients reading the data from it::
>          | Device Tree  |   |   Firmware    |  |      ?       |
>          +--------------+   +---------------+  +--------------+

[...]

> +There is two API functions which provide the access to the energy model:
> +em_cpu_get() which takes CPU id as an argument and em_dev_get() with device
> +pointer as an argument. It depends on the subsystem which interface it is
> +going to use.

Would be really nice if this wouldn't be required. We should really aim
for 1 framework == 1 set of interfaces.

What happens if someone calls em_get_pd() on a CPU EM?

E.g:

 static struct perf_domain *pd_init(int cpu)
 {
-       struct em_perf_domain *obj = em_cpu_get(cpu);
+       struct device *dev = get_cpu_device(cpu);
+       struct em_perf_domain *obj = em_pd_get(dev);
        struct perf_domain *pd;

Two versions of one functionality will confuse API user from the
beginning ...

[...]

> +enum em_type {
> +	EM_SIMPLE,
> +	EM_CPU,
> +};

s/EM_SIMPLE/EM_DEV ?

Right now I only see energy models and _one_ specific type (the CPU EM).
So a tag 'is a CPU EM' would suffice. No need for EM_SIMPE ...

[...]
