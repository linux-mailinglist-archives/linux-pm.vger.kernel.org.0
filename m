Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1E168B23
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 01:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgBVAmz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 19:42:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBVAmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 19:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=IoauFu+SPVxJ/QgMkD5H70t6W74upwBHouoPWlRKDBs=; b=mlZk+5DHPSke/pQ6XCytBfGkjH
        hkIgPJ+WZD70eJKDNBWwAy9MSR8hIq6WZ2I3LBjGVsjOVdMZlPU3nFzTPi6C8vFZYM4masCDI5A/M
        MCydby8lJ2dnhxOTkf2kTNzbTmVlYfO+kfMRMj1NN5HqKnpwjnzGPWiJHgh7S0nc1Jncl4iSVtEUx
        xtXS5ven+MNBNrhjRAY5CrOWTYTggZ61qDjrdfkmrqGcqbl9rSJEei60nQDhM+lOnXvVvGHwVnUhr
        qW5PgludRb3NWWqKCTfcQVul57sEuSJ3O6PdAyYm5UVBblNcN2yKCTH+WCpme3XZvdwnjrUtIoILk
        At1JJZMw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5Is1-0000Tu-Eh; Sat, 22 Feb 2020 00:42:19 +0000
Subject: Re: [PATCH v3 1/4] PM / EM: add devices to Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com
References: <20200221194731.13814-1-lukasz.luba@arm.com>
 <20200221194731.13814-2-lukasz.luba@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4ac6a187-1a09-335d-5c05-bf810ff81aaa@infradead.org>
Date:   Fri, 21 Feb 2020 16:42:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221194731.13814-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
One minor nit. Please see inline:

On 2/21/20 11:47 AM, Lukasz Luba wrote:
> Add support of other devices into the Energy Model framework not only the
> CPUs. Change the interface to be more unified which can handle other
> devices as well.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/power/energy-model.rst     | 133 ++++----
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index 90a345d57ae9..7576820664e5 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst

> @@ -85,13 +89,20 @@ API.
>  2.3 Accessing performance domains
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> +There is two API functions which provide the access to the energy model:

   There are two

> +em_cpu_get() which takes CPU id as an argument and em_pd_get() with device
> +pointer as an argument. It depends on the subsystem which interface it is
> +going to use, but in case of CPU devices both functions return the same
> +performance domain.
> +


cheers.
-- 
~Randy

