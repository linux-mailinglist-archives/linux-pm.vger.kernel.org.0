Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0AA376611
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhEGNYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 09:24:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60262 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEGNYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 09:24:51 -0400
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E444EF;
        Fri,  7 May 2021 15:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1620393830;
        bh=Z+/qATPuVcKfDSUD7dOeGR9wKJY7p3Dw+vktDAXvPbU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rA0/tLLo8qyaWE8DHa3y6WKj1IFO9evM61CpPBZDU3ELl6XSIhQ3SDXOLrR7Do6xl
         7xQmU4C7zflQ1Ed6iiXTqQAjnMM2bedyeg4486cq5gjfOc7468nPDgWqneuMfuR4zd
         Fd6MyawtVrsv7elD0eX+l4WddBI4tjs639h7OkIQ=
Subject: Re: [PATCH] PM: runtime: Fix unpaired parent child_count for
 force_resume
To:     Tony Lindgren <tony@atomide.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20210505110915.6861-1-tony@atomide.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <8ee97450-a568-765f-77b8-d48a494f1da1@ideasonboard.com>
Date:   Fri, 7 May 2021 16:23:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210505110915.6861-1-tony@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/05/2021 14:09, Tony Lindgren wrote:
> As pm_runtime_need_not_resume() relies also on usage_count, it can return
> a different value in pm_runtime_force_suspend() compared to when called in
> pm_runtime_force_resume(). Different return values can happen if anything
> calls PM runtime functions in between, and causes the parent child_count
> to increase on every resume.
> 
> So far I've seen the issue only for omapdrm that does complicated things
> with PM runtime calls during system suspend for legacy reasons:
> 
> omap_atomic_commit_tail() for omapdrm.0
>   dispc_runtime_get()
>    wakes up 58000000.dss as it's the dispc parent
>     dispc_runtime_resume()
>      rpm_resume() increases parent child_count
>   dispc_runtime_put() won't idle, PM runtime suspend blocked
> pm_runtime_force_suspend() for 58000000.dss, !pm_runtime_need_not_resume()
>   __update_runtime_status()
> system suspended
> pm_runtime_force_resume() for 58000000.dss, pm_runtime_need_not_resume()
>   pm_runtime_enable() only called because of pm_runtime_need_not_resume()
> omap_atomic_commit_tail() for omapdrm.0
>   dispc_runtime_get()
>    wakes up 58000000.dss as it's the dispc parent
>     dispc_runtime_resume()
>      rpm_resume() increases parent child_count
>   dispc_runtime_put() won't idle, PM runtime suspend blocked
> ...
> rpm_suspend for 58000000.dss but parent child_count is now unbalanced
> 
> Let's fix the issue by adding a flag for needs_force_resume and use it in
> pm_runtime_force_resume() instead of pm_runtime_need_not_resume().
> 
> Additionally omapdrm system suspend could be simplified later on to avoid
> lots of unnecessary PM runtime calls and the complexity it adds. The
> driver can just use internal functions that are shared between the PM
> runtime and system suspend related functions.
> 
> Fixes: 4918e1f87c5f ("PM / runtime: Rework pm_runtime_force_suspend/resume()")
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/base/power/runtime.c | 10 +++++++---
>   include/linux/pm.h           |  1 +
>   2 files changed, 8 insertions(+), 3 deletions(-)

Tested on DRA76 EVM, with and without HDMI plugged in. I can see DSS 
shutting down properly by looking at the CM_DSS_DSS_CLKCTRL register.

Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi
