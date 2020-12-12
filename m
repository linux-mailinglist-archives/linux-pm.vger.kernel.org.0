Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F362D842F
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 04:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405339AbgLLD7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 22:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405302AbgLLD6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 22:58:45 -0500
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Dec 2020 19:58:04 PST
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:84:22e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7489C0613CF;
        Fri, 11 Dec 2020 19:58:04 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 6E4CB41572; Sat, 12 Dec 2020 03:50:12 +0000 (UTC)
Date:   Sat, 12 Dec 2020 03:50:12 +0000
From:   Matthew Garrett <mjg59@codon.org.uk>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] thermal/core: Make 'forced_passive' as obsolete candidate
Message-ID: <20201212035012.GA11926@codon.org.uk>
References: <20201208153046.297456-1-daniel.lezcano@linaro.org>
 <cc2085ca-ada9-d616-eed5-3496889da3bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2085ca-ada9-d616-eed5-3496889da3bb@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 11, 2020 at 02:17:55PM +0100, Daniel Lezcano wrote:
> On 08/12/2020 16:30, Daniel Lezcano wrote:
> > The passive file in sysfs forces the usage of a passive trip point set
> > by the userspace when a broken BIOS does not provide the mitigation
> > temperature for such thermal zone. The hardware evolved a lot since
> > 2008 as a good thermal management is no longer an option.
> > 
> > Linux on the other side also provides now a way to load fixed ACPI
> > table via the option ACPI_TABLE_UPGRADE, so additionnal trip point
> > could be added there.
> > 
> > Set the option obsolete and plan to remove it, so the corresponding
> > code can be removed from the core code and allow more cleanups the
> > thermal framework deserves.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> 
> Is there any concern about this change ?

Yes - what's the reason to do so? The code isn't specific to ACPI,
so being able to override ACPI tables doesn't seem to justify it.
