Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A423E1658B0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 08:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgBTHrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 02:47:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgBTHrz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 02:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=E3T563SF0eKEHoviTTxB3y6ZGmgRDG+L2KrkBZJ8dno=; b=OPTgFSrZoBEjxRwh4HmFXrbEoV
        qiDx0U0lhfLIESR79Dln5kgHaSrj5vRKjhFLFrWJrnaNugG9qcUrIR1HrBE9g2HGeCgtgpAGqySCu
        VqZxd2fNzdW58mJKtE9cbWEl3yHmIcyNQT7naYMMkmO6WwXH3OirVwFCWffMMAYPwfL5wm7fX/1bD
        2wXCR1yCB3qOi6eXBz5Jp40xczg0uVGUmEK5vYLU274nMZargLsDjIk0OuPY8i4Cqc/p0ttafsFhT
        G5uIL8INi2oW/n3NMTTso7pklEoCd/9sQdyxlTyMf2WN8KsFS8v1buFz3HpJERKdtdeTi0LUagvWn
        sM4FYqIQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4gYs-0002eN-Or; Thu, 20 Feb 2020 07:47:54 +0000
Subject: Re: [RFC PATCH v3 3/8] drivers: base: add linear ranges helpers
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
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
 <1f6cb9fb9dbc429dc48110f18ad3a8c0c40196c6.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2f0755df-4bc6-c53d-edea-45bc99e6a47b@infradead.org>
Date:   Wed, 19 Feb 2020 23:47:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1f6cb9fb9dbc429dc48110f18ad3a8c0c40196c6.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
Here are some kernel-doc comments for you:

On 2/19/20 11:35 PM, Matti Vaittinen wrote:
> ---
>  drivers/base/Kconfig         |   3 +
>  drivers/base/Makefile        |   1 +
>  drivers/base/linear_ranges.c | 246 +++++++++++++++++++++++++++++++++++
>  include/linux/linear_range.h |  48 +++++++
>  4 files changed, 298 insertions(+)
>  create mode 100644 drivers/base/linear_ranges.c
>  create mode 100644 include/linux/linear_range.h

> diff --git a/drivers/base/linear_ranges.c b/drivers/base/linear_ranges.c
> new file mode 100644
> index 000000000000..5fa3b96bf2b8
> --- /dev/null
> +++ b/drivers/base/linear_ranges.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * linear_ranges.c -- helpers to map values in a linear range to range index
> + *
> + * Original idea borrowed from regulator framework
> + *
> + * It might be useful if we could support also inversely proportional ranges?
> + * Copyright 2020 ROHM Semiconductors
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/linear_range.h>
> +
> +/**
> + * linear_range_values_in_range - return the amount of values in a range
> + *
> + * @r:		pointer to linear range where values are counted
> + *
> + * Compute the amount of values in range pointed by @r. Note, values can
> + * be all equal - range with selectors 0,...,2 with step 0 still contains
> + * 3 values even though they are all equal.
> + *
> + * Returns the amount of values in range pointed by @r

    * Return: ...

> + */
> +
> +/**
> + * linear_range_values_in_range_array - return the amount of values in ranges
> + *
> + * @r:		pointer to array of linear ranges where values are counted
> + * @ranges:	amount of ranges we include in computation.
> + *
> + * Compute the amount of values in ranges pointed by @r. Note, values can
> + * be all equal - range with selectors 0,...,2 with step 0 still contains
> + * 3 values even though they are all equal.
> + *
> + * Returns the amount of values in first @ranges ranges pointed by @r

    * Return: ...

> + */
> +
> +/**
> + * linear_range_get_max_value - return the largest value in a range
> + *
> + * @r:		pointer to linear range where value is looked from
> + *
> + * Returns the largest value in the given range

ditto.

> + */
> +
> +/**
> + * linear_range_get_value - fetch a value from given range
> + *
> + * @r:		pointer to linear range where value is looked from
> + * @selector:	selector for which the value is searched
> + * @val:	address where found value is updated
> + *
> + * Search given ranges for value which matches given selector.
> + *
> + * Returns 0 on success, -EINVAL given selector is not found from any of the

ditto.

> + * ranges.
> + */
> +
> +/**
> + * linear_range_get_value_array - fetch a value from array of ranges
> + *
> + * @r:		pointer to array of linear ranges where value is looked from
> + * @ranges:	amount of ranges in an array
> + * @selector:	selector for which the value is searched
> + * @val:	address where found value is updated
> + *
> + * Search through an array of ranges for value which matches given selector.
> + *
> + * Returns 0 on success, -EINVAL given selector is not found from any of the

same, again.

> + * ranges.
> + */
> +
> +/**
> + * linear_range_get_selector_low - return linear range selector for value
> + *
> + * @r:		pointer to linear range where selector is looked from
> + * @val:	value for which the selcetor is searched

                                    selector

> + * @selector:	address where found selector value is updated
> + * @found:	flag to indicate that given value was in the range
> + *
> + * Return selector which which range value is closest match for given

    * Return:

> + * input value. Value is matching if it is equal or smaller than given
> + * value. If given value is in the range, then @found is set true.
> + *
> + * Returns 0 on success, -EINVAL if range is invalid or does not contain
> + * value smaller or equal to given value
> + */
> +int linear_range_get_selector_low(const struct linear_range *r,
> +				  unsigned int val, unsigned int *selector,
> +				  bool *found)
> +{
> +	*found = false;
> +
> +	if (r->min > val)
> +		return -EINVAL;
> +
> +	if (linear_range_get_max_value(r) >= val)
> +		*found = true;
> +
> +	if (!r->step)
> +		*selector = r->min_sel;
> +	else
> +		*selector = (val - r->min) / r->step + r->min_sel;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(linear_range_get_selector_low);
> +
> +/**
> + * linear_range_get_selector_low_array - return linear range selector for value
> + *
> + * @r:		pointer to array of linear ranges where selector is looked from
> + * @ranges:	amount of ranges to scan from array
> + * @val:	value for which the selcetor is searched

                                    selector

> + * @selector:	address where found selector value is updated
> + * @found:	flag to indicate that given value was in the range
> + *
> + * Return Scan array of ranges for selector which which range value matches

drop "Return" ?

> + * given input value. Value is matching if it is equal or smaller than given
> + * value. If given value is found to be in a range scannins is stopped and

                                                      scanning

> + * @found is set true. If a range with values smaller than given value is found
> + * but the range max is being smaller than given value, then the ranges
> + * biggest selector is updated to @selector but scanning ranges is continued
> + * and @found is set to false.
> + *
> + * Returns 0 on success, -EINVAL if range array is invalid or does not contain

    * Return:

> + * range with a value smaller or equal to given value
> + */

> +
> +/**
> + * linear_range_get_selector_high - return linear range selector for value
> + *
> + * @r:		pointer to linear range where selector is looked from
> + * @val:	value for which the selcetor is searched

                                    selector

> + * @selector:	address where found selector value is updated
> + * @found:	flag to indicate that given value was in the range
> + *
> + * Return selector which which range value is closest match for given
> + * input value. Value is matching if it is equal or higher than given
> + * value. If given value is in the range, then @found is set true.
> + *
> + * Returns 0 on success, -EINVAL if range is invalid or does not contain

    * Return:

> + * value greater or equal to given value
> + */


cheers.
-- 
~Randy

