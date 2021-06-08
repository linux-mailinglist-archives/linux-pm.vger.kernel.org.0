Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC83839F8FF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhFHO0w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 10:26:52 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43701 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233300AbhFHO0w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 10:26:52 -0400
Received: (qmail 1805405 invoked by uid 1000); 8 Jun 2021 10:24:58 -0400
Date:   Tue, 8 Jun 2021 10:24:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PM: runtime: Update behaviour for no callbacks
Message-ID: <20210608142458.GD1804083@rowland.harvard.edu>
References: <20210608090250.85256-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608090250.85256-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 08, 2021 at 11:02:47AM +0200, Ulf Hansson wrote:
> While reviewing a patch on the mmc-list, I ended up inspecting the behaviour of
> how we deal with the no callback case for runtime PM.
> 
> A couple of observations:
> 
> *) When pm_runtime_no_callbacks() have been called, it allows the PM core to
> takes a quicker path, but at the same time, consumer/supplier device links are
> being skipped in rpm_resume|suspend().
> 
> **) Calling pm_runtime_no_callbacks() to avoid boiler plate code (assigning
> empty functions to ->runtime_suspend|resume()), doesn't work if there could be
> consumer/supplier device link being used or a platform dependent PM domain that
> could get attached to the device.
> 
> Therefore, this series suggests to change the behaviour in the PM core, to
> allow the ->runtime_suspend|resume() callbacks to be unassigned. This is already
> supported for ->runtime_idle() callbacks, so it would also move things into a
> more consistent behaviour.
> 
> I have looked at various error paths, in the kernel of callers of
> pm_runtime_get_sync(). I couldn't find anyone that made sense, that looked for
> the special error code, -ENOSYS, which is the error code getting returned when a
> callback is missing. Whether that is sufficient proof that these changes are
> 100% safe, I can't guarantee, but I think it would be worth a try as the
> benefits of avoiding boilerplate code and the corresponding additional code
> paths are quite nice, if you ask me.

In principle I have no objection to these changes.  It's likely 
that if any problems do crop up, we'll be able to fix them pretty 
easily.  For patches 1 and 2:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
