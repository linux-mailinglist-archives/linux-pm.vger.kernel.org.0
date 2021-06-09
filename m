Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353393A16E4
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhFIOST (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 10:18:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60103 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233832AbhFIOST (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 10:18:19 -0400
Received: (qmail 1843599 invoked by uid 1000); 9 Jun 2021 10:16:23 -0400
Date:   Wed, 9 Jun 2021 10:16:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PM: runtime: Clarify documentation when callbacks
 are unassigned
Message-ID: <20210609141623.GA1842836@rowland.harvard.edu>
References: <20210609100610.97830-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609100610.97830-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 09, 2021 at 12:06:10PM +0200, Ulf Hansson wrote:
> Recent changes to the PM core allows ->runtime_suspend|resume callbacks to
> be unassigned.
> 
> In the earlier behaviour the PM core would return -ENOSYS, when trying to
> runtime resume a device, for example. Let's update the documentation to
> clarify this.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v4:
>         - This time, really, fix spelling and further clarified the behaviour,
> 	according to comments from Alan.
> 
> ---
>  Documentation/power/runtime_pm.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 18ae21bf7f92..8a0a43811e3a 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -827,6 +827,15 @@ or driver about runtime power changes.  Instead, the driver for the device's
>  parent must take responsibility for telling the device's driver when the
>  parent's power state changes.
>  
> +Note that, in some cases it may not be desirable for subsystems/drivers to call
> +pm_runtime_no_callbacks() for their devices. This could be because a subset of
> +the runtime PM callbacks needs to be implemented, a platform dependent PM
> +domain could get attached to the device or that the device is power managed
> +through a supplier device link. For these reasons and to avoid boilerplate code
> +in subsystems/drivers, the PM core allows runtime PM callbacks to be
> +unassigned. More precisely, if a callback pointer is NULL, the PM core will act
> +as though there was a callback and it returned 0.
> +
>  9. Autosuspend, or automatically-delayed suspends
>  =================================================

Acked-by: Alan Stern <stern@rowland.harvard.edu>

I don't know what happened before.  Maybe the terminal window got 
resized without me noticing, so the lines looked too long when they 
actually weren't.

Alan Stern
