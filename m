Return-Path: <linux-pm+bounces-30907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9438B075F8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F5F168255
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CEE2F2734;
	Wed, 16 Jul 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TCsPaXPw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE73121B9C8;
	Wed, 16 Jul 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669831; cv=none; b=HyM+qu59cbpmuugt1iU7b/GUhteNPBFV2SnE4CBy2RznKGKg0Y0ck4Pxs4iwI6DKiwu7uulqWX4bAgf3m7adZQUUAt05CgO06xfcryEJQfX+9r07+0urJmvKdI4QYbaMXEEYClAUnCVa/OvIMRi+2Ieu+pLlSjMqQzV00eKoKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669831; c=relaxed/simple;
	bh=Ie/vudHyUAw0gcZE2VY84j6FL1GN4ErvwXH8B3crDUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9yndH2g2Gb6EzjZBg+nWWwRvANqp0h+BiCt3jcxt0qhzLBG9r6rHWSd0yvQR13R0DR4npem1+qePde9g/lWSL21ZcoMPOqqTpKZFKLFk6t8/WbmdI8tMfbWhIdGA9ESZWt4hugXUOC8gKbdVMlwfJddbkpA4vGolHnm4ETrBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCsPaXPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E4CC4CEF0;
	Wed, 16 Jul 2025 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752669830;
	bh=Ie/vudHyUAw0gcZE2VY84j6FL1GN4ErvwXH8B3crDUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCsPaXPwDySpyV0F+5fg5akK205LWTDPjc+nQxMjMnMTS25ziEdReHyN1ZI0ckoJy
	 995/flkzHfWCECdiEQv0YVaHDwynRE/JiEoBn8KaOAFJhKOl/POE4HzzGKyI4GjGI+
	 c0QZ9tsNkK4yZPEnTx2lF/KlTkz7Uq5MaTz0019k=
Date: Wed, 16 Jul 2025 14:43:47 +0200
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
Subject: Re: [PATCH v11 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <2025071645-panoramic-pyromania-2f8c@gregkh>
References: <20250618120255.3141862-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618120255.3141862-4-o.rempel@pengutronix.de>

Overall, no real issues, just some very minor ones:

On Wed, Jun 18, 2025 at 02:02:51PM +0200, Oleksij Rempel wrote:
> + * Sysfs Interface:
> + * ----------------
> + *   /sys/kernel/pscrr/reason       - Read/write current power state change
> + *				      reason
> + *   /sys/kernel/pscrr/reason_boot  - Read-only last recorded reason from
> + *				      previous boot

The sysfs documentation is in the ABI file, so it's not needed here.

> +static int pscrr_reboot_notifier(struct notifier_block *nb,
> +				 unsigned long action, void *unused)
> +{
> +	struct pscrr_backend *backend;
> +	int ret;
> +
> +	guard(g_pscrr)(&g_pscrr);
> +
> +	backend = g_pscrr.backend;
> +
> +	if (!backend || !backend->ops || !backend->ops->write_reason)
> +		return NOTIFY_DONE;
> +
> +	ret = backend->ops->write_reason(get_psc_reason());
> +	if (ret) {
> +		pr_err("PSCRR: Failed to store reason %d (%s) at reboot, err=%pe\n",
> +		       get_psc_reason(), psc_reason_to_str(get_psc_reason()),
> +		       ERR_PTR(ret));
> +	} else {
> +		pr_info("PSCRR: Stored reason %d (%s) at reboot.\n",
> +			get_psc_reason(), psc_reason_to_str(get_psc_reason()));

Why print anything?  If this works properly, it should be quiet, right?

> +static ssize_t reason_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			   char *buf)
> +{
> +	struct pscrr_backend *backend;
> +	enum psc_reason r;
> +
> +	guard(g_pscrr)(&g_pscrr);
> +
> +	backend = g_pscrr.backend;
> +
> +	if (!backend || !backend->ops)
> +		return scnprintf(buf, PAGE_SIZE, "No backend registered\n");

So a string, or an int will be returned?  That's crazy, just return an
error here, -ENODEV?

> +
> +	/* If the backend can read from hardware, do so. Otherwise, use our cached value. */
> +	if (backend->ops->read_reason) {
> +		if (backend->ops->read_reason(&r) == 0) {
> +			/* Also update our cached value for consistency */
> +			set_psc_reason(r);
> +		} else {
> +			/* If read fails, fallback to cached. */
> +			r = get_psc_reason();
> +		}
> +	} else {
> +		r = get_psc_reason();
> +	}
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", r);

sysfs files should use sysfs_emit() so you don't get people sending you
patches later on to convert it :)

> +static ssize_t reason_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct pscrr_backend *backend;
> +	long val;
> +	int ret;
> +
> +	guard(g_pscrr)(&g_pscrr);
> +
> +	backend = g_pscrr.backend;
> +
> +	if (!backend || !backend->ops || !backend->ops->write_reason)
> +		return -ENODEV;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > U32_MAX)
> +		return -ERANGE;
> +
> +	if (val < PSCR_UNKNOWN || val > PSCR_MAX_REASON)
> +		/*
> +		 * Log a warning, but still attempt to write the value. In
> +		 * case the backend can handle it, we don't want to block it.
> +		 */
> +		pr_warn("PSCRR: writing unknown reason %ld (out of range)\n",
> +			val);

Do not let userspace cause a DoS of kernel log messages just because it
sent you an invalid data range.

> +static struct kobj_attribute reason_attr = __ATTR(reason, 0644, reason_show,
> +						  reason_store);

__ATTR_RW(), right?  If not, why not?

> +static struct kobj_attribute reason_boot_attr =
> +	__ATTR(reason_boot, 0444, reason_boot_show, NULL); /* Read-only */

__ATTR_RO(), right?  Then no comment is needed :)

> +int pscrr_core_init(const struct pscrr_backend_ops *ops)
> +{
> +	enum psc_reason stored_val = PSCR_UNKNOWN;
> +	struct pscrr_backend *backend;
> +	int ret;
> +
> +	guard(g_pscrr)(&g_pscrr);
> +
> +	backend = g_pscrr.backend;
> +
> +	if (backend) {
> +		pr_err("PSCRR: Core is already initialized!\n");

All of the "PSCRR:" stuff should just be set with pr_fmt being defined
at the top of this file, don't put it everywhere manually.

> +		return -EBUSY;
> +	}
> +
> +	if (!ops->read_reason) {
> +		pr_err("PSCRR: Backend must provide read callbacks\n");
> +		return -EINVAL;
> +	}
> +
> +	backend = kzalloc(sizeof(*backend), GFP_KERNEL);
> +	if (!backend)
> +		return -ENOMEM;
> +
> +	backend->ops = ops;
> +	backend->last_boot_reason = PSCR_UNKNOWN;
> +	g_pscrr.backend = backend;
> +
> +	ret = ops->read_reason(&stored_val);
> +	if (!ret) {
> +		backend->last_boot_reason = stored_val;
> +		pr_info("PSCRR: Initial read_reason: %d (%s)\n",
> +			stored_val, psc_reason_to_str(stored_val));

When code works properly, it should be quiet.  Don't spam the boot log
please.

> +	ret = sysfs_create_group(g_pscrr.kobj, &pscrr_attr_group);
> +	if (ret) {
> +		pr_err("PSCRR: Failed to create sysfs group, err=%pe\n",
> +		       ERR_PTR(ret));
> +		goto err_kobj_put;
> +	}
> +
> +	pr_info("PSCRR: initialized successfully.\n");

Same here, be quiet.

> +void pscrr_core_exit(void)
> +{
> +	guard(g_pscrr)(&g_pscrr);
> +
> +	if (!g_pscrr.backend)
> +		return;
> +
> +	if (g_pscrr.kobj) {
> +		sysfs_remove_group(g_pscrr.kobj, &pscrr_attr_group);
> +		kobject_put(g_pscrr.kobj);
> +	}
> +
> +	unregister_reboot_notifier(&g_pscrr.reboot_nb);
> +
> +	kfree(g_pscrr.backend);
> +	g_pscrr.backend = NULL;
> +
> +	pr_info("PSCRR: exited.\n");

Same here, please be quiet.

thanks,

greg k-h

