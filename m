Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF892544D8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgH0MPa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 08:15:30 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:16044 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgH0MPK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 08:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598530497;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=s0ziZsW1eWa4IKIjQ+u0Ec5vtYjwpjgOTZnjWgtRR/0=;
        b=hWVPBlho+RqUPiCjIcp/n+U6qUknoD4aNeLbaWMan9QlOVa4FcpfMc0OqsP9mHptgK
        WEN9Eoyx1PxncYz3xh8KCuRWlfwf7+zFJ7QUgmw93Q+LMw4M0OMXVW5OGHZjd3qKz/xO
        hWekvibgsSItzb+5NiEJnrdDCwzvk8xEqkJi9Vy6hKpE5YGlfRPS+yhr/xbDmFZLHcci
        u2sdDPugEE30CuFWaHtxgSesLhmGkLegCkU6fa/A33hoSv4X4Ej0X8+RNXSO9Cxql7VQ
        MnjfGk7ZwwmewtGNrSStbPGlOPgwhfRchljZKFtIIfkxfstdktPiITPmdIwxV8srzv/c
        ubTw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/Fboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7RCEutYs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 27 Aug 2020 14:14:56 +0200 (CEST)
Date:   Thu, 27 Aug 2020 14:14:49 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Drop unnecessary check frmo
 dev_pm_opp_attach_genpd()
Message-ID: <20200827121449.GA21147@gerhold.net>
References: <88c8522b556d15bd44b8388d47cf25ac6f06b057.1598522635.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c8522b556d15bd44b8388d47cf25ac6f06b057.1598522635.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 27, 2020 at 03:35:15PM +0530, Viresh Kumar wrote:
> Since commit c0ab9e0812da ("opp: Allocate genpd_virt_devs from
> dev_pm_opp_attach_genpd()"), the allocation of the virtual devices is
> moved to dev_pm_opp_attach_genpd() and this check isn't required anymore
> as it will always fail. Drop it.
> 

Only partially related to this patch, but actually I noticed that
dev_pm_opp_attach_genpd() does not work correctly if it is called
multiple times.

For example, qcom-cpufreq-nvmem calls this for every CPU because it is
not aware that the OPP table is shared between the CPUs.
dev_pm_opp_attach_genpd() does not check if opp_table->genpd_virt_devs
is already set, so when it is called again for other CPUs we will:

  - Cause a memory leak (opp_table->genpd_virt_devs is just replaced
    with new memory)
  - Attach the power domains multiple times
  - Never detach the power domains from earlier calls
  - Crash when dev_pm_opp_detach_genpd() is called the second time

Oh well. :)

I think the function should just return and do nothing if the power
domains were already attached, just like dev_pm_opp_set_supported_hw()
etc. But this is a bit complicated to implement with the "virt_devs"
parameter, since callers will probably assume that to be valid if we
return success.

Another advantage of my proposal to remove the virt_devs parameter [1] :)

Stephan
