Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A699943BF42
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbhJ0CFB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 22:05:01 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38201 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S237704AbhJ0CFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 22:05:01 -0400
Received: (qmail 1306909 invoked by uid 1000); 26 Oct 2021 22:02:35 -0400
Date:   Tue, 26 Oct 2021 22:02:35 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
Message-ID: <20211027020235.GA1306582@rowland.harvard.edu>
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026222626.39222-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 27, 2021 at 12:26:26AM +0200, Ulf Hansson wrote:
> During system suspend, the PM core sets dev->power.is_suspended for the
> device that is being suspended. This flag is also being used in
> rpm_resume(), to allow it to succeed by returning 1, assuming that runtime
> PM has been disabled and the runtime PM status is RPM_ACTIVE, for the
> device.
> 
> To make this behaviour a bit more useful, let's drop the check for the
> dev->power.is_suspended flag in rpm_resume(), as it doesn't really need to
> be limited to this anyway.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/runtime.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index ec94049442b9..fadc278e3a66 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -742,8 +742,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
>   repeat:
>  	if (dev->power.runtime_error)
>  		retval = -EINVAL;
> -	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> -	    && dev->power.runtime_status == RPM_ACTIVE)
> +	else if (dev->power.disable_depth > 0 &&
> +		dev->power.runtime_status == RPM_ACTIVE)

IIRC there was a good reason why the original code checked for 
disable_depth == 1 rather than > 0.  But I don't remember exactly what 
the reason was.  Maybe it had something to do with the fact that during 
a system sleep __device_suspend_late calls __pm_runtime_disable, and the 
code was checking that there were no other disables in effect.  This is 
related to the documented behavior of rpm_resume (it's supposed to fail 
with -EACCES if the device is disabled for runtime PM, no matter what 
power state the device is in).

That probably is also the explanation for why dev->power.is_suspended 
gets checked: It's how the code tells whether a system sleep is in 
progress.

So overall, I suspect this change should not be made.  But some other 
improvement (like a nice comment) might be in order.

Alan Stern
