Return-Path: <linux-pm+bounces-30909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6BB07621
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF005830A6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7560B38F80;
	Wed, 16 Jul 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMvmh7k0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEC15E90;
	Wed, 16 Jul 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670100; cv=none; b=YwRPJVwMzpJVK7XO95wT/AJN7nnpy1phE0o33DB5SnZUamKtlvXALpUPIiBjnW4AGSV30uAnVQcGUnFJiy8auWSMFAW6U4hyOb+kw1fVoo0CQSvs8e7k555y9+m5niGDwR4iXnNSOy7l5FclcmerSJUUXbWbuf0B3I15skTEvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670100; c=relaxed/simple;
	bh=63w7oNRAk83e3Ep9LQ2Kj3gqiIuG7YZNBO5D5MDOFAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgX0mZiwnaOXwaiKSvXuNc5J/FfXASy2u+Gy/Ht4Ayy+JQtxwbKexYFjJNiWhYfadZOsfSuypm8AulqCEfpGzVYvm+igEUhKb+H7Pi4AkBVH6byjBDFn5fraM9hG52b9EZKeaGlsODHUh93VegQ0DaYVtq+qBr3IznafN00wMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RMvmh7k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5749BC4CEF0;
	Wed, 16 Jul 2025 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752670099;
	bh=63w7oNRAk83e3Ep9LQ2Kj3gqiIuG7YZNBO5D5MDOFAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMvmh7k0tJYcfIJa7vlel1wovSXvVSxnoLfI5j1DtrDTLqAVqI9Gi5tpDkQc1F7Z9
	 4U6vQH+3mwwiIP9CH0iq68Z1ApBUKaj5wf0q/31lb3um9t7UVw0gD6d+beknD3QQ5U
	 e5SgHlgM25ElKQSYEhcmCMy0PHHTSW2C0IdrWiA8=
Date: Wed, 16 Jul 2025 14:48:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v11 5/7] nvmem: add support for device and sysfs-based
 cell lookups
Message-ID: <2025071609-cardigan-polish-aba6@gregkh>
References: <20250618120255.3141862-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618120255.3141862-6-o.rempel@pengutronix.de>

On Wed, Jun 18, 2025 at 02:02:53PM +0200, Oleksij Rempel wrote:
> Introduce new API functions to allow looking up NVMEM devices and cells
> by name, enhancing flexibility in cases where devicetree-based  lookup
> is not available.
> 
> Key changes:
> - Added `nvmem_device_get_by_name()`: Enables retrieving an NVMEM device by
>   its name for systems where direct device reference is needed.
> - Added `nvmem_cell_get_by_sysfs_name()`: Allows retrieving an NVMEM cell
>   based on its sysfs-style name (e.g., "cell@offset,bits"), making it
>   possible to identify cells dynamically.
> - Introduced `nvmem_find_cell_entry_by_sysfs_name()`: A helper function
>   that constructs sysfs-like names and searches for matching cell entries.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v5:
> - fix build we NVMEM=n
> ---
>  drivers/nvmem/core.c           | 105 +++++++++++++++++++++++++++++++++
>  include/linux/nvmem-consumer.h |  18 ++++++
>  2 files changed, 123 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 59c295a11d86..d310fd8ca9c0 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1177,6 +1177,23 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
>  EXPORT_SYMBOL_GPL(of_nvmem_device_get);
>  #endif
>  
> +/**
> + * nvmem_device_get_by_name - Look up an NVMEM device by its device name
> + * @name: String matching device name in the provider
> + *
> + * Return: A valid pointer to struct nvmem_device on success,
> + * or ERR_PTR(...) on failure. The caller must later call nvmem_device_put() to
> + * release the reference.
> + */
> +struct nvmem_device *nvmem_device_get_by_name(const char *name)
> +{
> +	if (!name)
> +		return ERR_PTR(-EINVAL);
> +
> +	return __nvmem_device_get((void *)name, device_match_name);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_device_get_by_name);
> +
>  /**
>   * nvmem_device_get() - Get nvmem device from a given id
>   *
> @@ -1490,6 +1507,94 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
>  EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
>  #endif
>  
> +/**
> + * nvmem_find_cell_entry_by_sysfs_name - Find an NVMEM cell entry by its sysfs
> + *					 name.
> + * @nvmem:      The nvmem_device pointer where the cell is located.
> + * @sysfs_name: The full sysfs cell name, e.g. "mycell@0x100,8".
> + *
> + * This function constructs the sysfs-like name for each cell and compares it
> + * to @sysfs_name. If a match is found, the matching nvmem_cell_entry pointer
> + * is returned. This is analogous to nvmem_find_cell_entry_by_name(), except
> + * it matches on the sysfs naming convention used in the device's attributes.
> + *
> + * Return: Pointer to the matching nvmem_cell_entry on success, or NULL if no
> + * match is found.
> + */
> +static struct nvmem_cell_entry *
> +nvmem_find_cell_entry_by_sysfs_name(struct nvmem_device *nvmem,
> +				    const char *sysfs_name)
> +{
> +	struct nvmem_cell_entry *entry;
> +	char tmp[NVMEM_CELL_NAME_MAX];

That's a lot of bytes on the stack, are you sure?

> +
> +	mutex_lock(&nvmem_mutex);

Use a guard?

> +	list_for_each_entry(entry, &nvmem->cells, node) {
> +		int len = snprintf(tmp, NVMEM_CELL_NAME_MAX, "%s@%x,%u",

You have a naming scheme here that you now need to keep in sync with a
naming scheme else where.  Why?  How is that going to happen?

sysfs names are NOT static, or deterministic, and will be totally random
depending on the boot order and the phase of the moon.  Attempting to
look, within the kernel, at a sysfs path name is almost always the sign
of something gone wrong.

Please don't do this, it will only cause headaches and issues over time,
trust me.

> +				   entry->name, entry->offset,
> +				   entry->bit_offset);
> +
> +		if (len >= NVMEM_CELL_NAME_MAX) {
> +			pr_warn("nvmem: cell name too long (max %zu bytes): %s\n",
> +				NVMEM_CELL_NAME_MAX, sysfs_name);

What can a user do about this?  

> +			continue;

Shouldn't you have errored out?

> +		}
> +
> +		if (len < 0) {
> +			pr_warn("nvmem: error formatting cell name\n");
> +			continue;

No error?

> +		}
> +
> +		if (!strcmp(tmp, sysfs_name)) {
> +			mutex_unlock(&nvmem_mutex);
> +			return entry;
> +		}
> +	}
> +
> +	mutex_unlock(&nvmem_mutex);
> +	return NULL;
> +}
> +
> +/**
> + * nvmem_cell_get_by_sysfs_name - Retrieve an NVMEM cell using a sysfs-style
> + *				  name.
> + * @nvmem: Pointer to the `struct nvmem_device` containing the cell.
> + * @sysfs_name: The sysfs-style cell name, formatted as
> + *		"<cell_name>@<offset>,<bits>".

Again, who is keeping this naming scheme in sync?  And what happens when
the firmware changes it?

Please don't.

> + *
> + * This function enables dynamic lookup of NVMEM cells via sysfs-style
> + * identifiers. It is useful when devicetree-based lookup is unavailable or when
> + * cells are managed dynamically.
> + *
> + * Example Usage:
> + *   nvmem_cell_get_by_sysfs_name(nvmem, "mycell@0x100,8");
> + *
> + * Return: Pointer to `struct nvmem_cell` on success. On error, an ERR_PTR() is
> + * returned with the appropriate error code.
> + */
> +struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
> +						const char *sysfs_name)
> +{
> +	struct nvmem_cell_entry *entry;
> +	struct nvmem_cell *cell;
> +
> +	entry = nvmem_find_cell_entry_by_sysfs_name(nvmem, sysfs_name);
> +	if (!entry)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (!try_module_get(nvmem->owner))
> +		return ERR_PTR(-EINVAL);

Why are you messing with a module owner field, when no other nvmem call
uses that?  Who will decrement it?  Are you sure you didn't just race
with it being unloaded?  module owner fields are almost always wrong
these days.

thanks,

greg k-h

