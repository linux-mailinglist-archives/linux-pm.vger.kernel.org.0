Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77932189C94
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 14:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCRNIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 09:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgCRNIl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Mar 2020 09:08:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD8B720724;
        Wed, 18 Mar 2020 13:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584536920;
        bh=IK7Y5ZSmtcwGdd99YOsDwYG87YcJBtNmXMYebt4itiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ao/O4jIgBcUwSCsqm5OQ5agm3YDTJ5N6RbEIYQECoGVoyxucRrKGyKpCerM8428XJ
         aCpTzqj+I0NJC510y9k85ukfosiquOlCq2FBoibr8MH08Gx24pBrpOzPgvjCPF6mp/
         eCzNrbj4EaMiVzYfLuTKgiRZ5B8eYc1rCeEr4U3c=
Date:   Wed, 18 Mar 2020 14:08:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 3/9] drivers: base: add linear ranges helpers
Message-ID: <20200318130838.GB2769584@kroah.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
 <01ac2439f9d33ae405999065c5d28c368bad4a28.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ac2439f9d33ae405999065c5d28c368bad4a28.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 10:53:01AM +0200, Matti Vaittinen wrote:
> Many devices have control registers which control some measurable
> property. Often a register contains control field so that change in
> this field causes linear change in the controlled property. It is not
> a rare case that user wants to give 'meaningful' control values and
> driver needs to convert them to register field values. Even more
> often user wants to 'see' the currently set value - again in
> meaningful units - and driver needs to convert the values it reads
> from register to these meaningful units. Examples of this include:
> 
> - regulators, voltage/current configurations
> - power, voltage/current configurations
> - clk(?) NCOs
> 
> and maybe others I can't think of right now.
> 
> Provide a linear_range helper which can do conversion from user value
> to register value 'selector'.
> 
> The idea here is stolen from regulator framework and patches refactoring
> the regulator helpers to use this are following.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Changes since rfc-v3:
>   - Kerneldoc fixes
>   - Corrected commit message typo meaningfull => meaningful
> 
>  drivers/base/Kconfig         |   3 +
>  drivers/base/Makefile        |   1 +
>  drivers/base/linear_ranges.c | 246 +++++++++++++++++++++++++++++++++++

Why in drivers/base/ ?

Why not in lib/ ?

>  include/linux/linear_range.h |  48 +++++++
>  4 files changed, 298 insertions(+)
>  create mode 100644 drivers/base/linear_ranges.c
>  create mode 100644 include/linux/linear_range.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 5f0bc74d2409..636b6fa8e499 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -209,4 +209,7 @@ config GENERIC_ARCH_TOPOLOGY
>  	  appropriate scaling, sysfs interface for reading capacity values at
>  	  runtime.
>  
> +config LINEAR_RANGES
> +	tristate

No help text at all???

> +EXPORT_SYMBOL(linear_range_values_in_range);

EXPORT_SYMBOL_GPL() for all of these?  I have to ask...

> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Are you sure about the "or later"?  Again, I have to ask.

> +/* Copyright (C) 2020 ROHM Semiconductors */
> +
> +#ifndef LINEAR_RANGE_H
> +#define LINEAR_RANGE_H
> +
> +#include <linux/types.h>

Why is this needed?

thanks,

greg k-h
