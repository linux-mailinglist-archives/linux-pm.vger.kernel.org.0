Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABE216EB42
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 17:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgBYQVf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 11:21:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYQVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 11:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=J3p3P1Xs0O9vBplWiDfg1XuROWQome6tzfHEzwiApJU=; b=Kz5vmBt0G2YWRfEPqm9mUBVMss
        cPiRtJ23JAwKdJiDWEcQn6d9h7UzBhbjjgDJPBXzpxPD5zPKnkixFabpBou2UJGkwQgOMDFvX432+
        Jy0ogOtBMxdji+YUDDm4EREXv5uLplk7GBPmOYpM+JQwTauVHYCUovkLaUV+7DbnKbN3gDgIU0f4I
        lohHkNFlNlsdqekU+IG+wMdRQWgYVVGlZ0CwscvUWxDO8ITwsrWA7uL7NNOo+dB2Ru/AnYeTD6Rwn
        WVS6KlYp7cyECY4cbvgwFXRwQ+ccyRBY6iMychwLSb2vvFzHr4nDnPelXTtgxC0u4N2aaiDaPb3k7
        r40hwkmQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6cxi-0003cc-4t; Tue, 25 Feb 2020 16:21:34 +0000
Subject: Re: [PATCH v4 9/9] power: supply: Support ROHM bd99954 charger
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
 <529dd6298be245051f333ab4d9264902bf889aa6.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c187bb77-e804-93bd-64db-9418be58f191@infradead.org>
Date:   Tue, 25 Feb 2020 08:21:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <529dd6298be245051f333ab4d9264902bf889aa6.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/25/20 12:55 AM, Matti Vaittinen wrote:
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 8781c674ed07..0b3bad6fc736 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -702,6 +702,16 @@ config CHARGER_BD70528
>  	 information and altering charger configurations from charger
>  	 block of the ROHM BD70528 Power Management IC.
>  

Hi,

> +config CHARGER_BD99954
> +	tristate "ROHM bd99954 charger driver"
> +	depends on I2C
> +	select LINEAR_RANGES
> +	default n

Drop the "default n", since it is already the default.

> +	help
> +	 Say Y here to enable support for getting battery and charger
> +	 information and altering charger configurations from the ROHM
> +	 BD99954 charger IC.

Please indent the 3 lines of help text with one additional space (2 total).
See Documentation/process/coding-style.rst:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.  Example::

  config AUDIT
	bool "Auditing support"
	depends on NET
	help
	  Enable auditing infrastructure that can be used with another
	  kernel subsystem, such as SELinux (which requires this for
	  logging of avc messages output).  Does not do system-call
	  auditing without CONFIG_AUDITSYSCALL.

> +
>  config CHARGER_WILCO
>  	tristate "Wilco EC based charger for ChromeOS"
>  	depends on WILCO_EC

thanks.
-- 
~Randy

