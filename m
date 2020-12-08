Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B159D2D3469
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 21:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgLHUjf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 15:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgLHUjd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 15:39:33 -0500
Date:   Tue, 8 Dec 2020 20:51:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607456997;
        bh=Hn6NwvPynuuwwJBvitAq6Fnqy3V2/I8AX+JshJwvimI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBHpqRlbM0n8LlZcjrRUfF1f4NhvdAyeCafQaH/2aefKOhooCxE9EVeGThq7Ax1nh
         3638/nvEsfLn1tKGof2QDh/jkVQcoVMxIRROFonelKqjBz67hUFzlJtWFk8n2CYGE4
         D7bxt+BMSuxgp5Rmr+1xaYV5znVuvxtGbtcdNlmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Strudel <tstrudel@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PM: domains: create debugfs nodes when adding power
 domains
Message-ID: <X8/ZM7Vm/aD9FdlG@kroah.com>
References: <20201208191955.2466057-1-tstrudel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208191955.2466057-1-tstrudel@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 08, 2020 at 11:19:55AM -0800, Thierry Strudel wrote:
> debugfs nodes were created in genpd_debug_init alled in late_initcall
> preventing power domains registered though loadable modules to have
> a debugfs entry.
> 
> Create/remove debugfs nodes when the power domain is added/removed
> to/from the internal gpd_list.
> 
> Signed-off-by: Thierry Strudel <tstrudel@google.com>
> Change-Id: I8a2e0616746afe2a6bbd9c24bc3a0eaa84725a75

You don't need this, checkpatch.pl should have warned you :)

> ---
> v2: fix forward declaration and genpd_debugfs_dir being NULL - Ulf
> v3: remove extra trailing char added by mistake in v2 - kernel test robot
> v4: cleanup includes and regroup CONFIG_DEBUG_FS CPP blocks - Greg
>  drivers/base/power/domain.c | 73 +++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 28 deletions(-)

Looks good to me, thanks for fixing it up.  Rafael, will this go through
your tree?

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
