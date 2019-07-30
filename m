Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C957A16A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 08:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfG3GrC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 02:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbfG3GrC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jul 2019 02:47:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098442087F;
        Tue, 30 Jul 2019 06:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564469221;
        bh=+mcR5vDHWu/voTGbeuStxWO8Zg7KMvSmaUE+hk1z5dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0X5uEEo5+XexQbACNSHfGbmgZue0fuH4eOG88WT8lnCgrTpj3I0E2x5BdwQvUPll7
         RUhw2QmDGr0vzuKU954IxoLym6f2DEYUFwYCepH89H1sHSffZ2WMjT2QE8Lkemk22f
         VBf6ewfiHSwgdPz5HpKWFLQK5qMqZ86NJDNvuGNU=
Date:   Tue, 30 Jul 2019 08:46:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, rafael@kernel.org,
        hridya@google.com, sspatil@google.com, kaleshsingh@google.com,
        ravisadineni@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190730064657.GA1213@kroah.com>
References: <20190730024309.233728-1-trong@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730024309.233728-1-trong@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 07:43:09PM -0700, Tri Vo wrote:
> Userspace can use wakeup_sources debugfs node to plot history of suspend
> blocking wakeup sources over device's boot cycle. This information can
> then be used (1) for power-specific bug reporting and (2) towards
> attributing battery consumption to specific processes over a period of
> time.
> 
> However, debugfs doesn't have stable ABI. For this reason, create a
> 'struct device' to expose wakeup sources statistics in sysfs under
> /sys/class/wakeup/wakeup<ID>/*.

I agree with Rafael here, no need for the extra "wakeup" in the device
name as you are in the "wakeup" namespace already.

If you have an IDA-allocated name, there's no need for the extra
'wakeup' at all.

> +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> +{
> +	struct device *dev;
> +	int id;
> +
> +	id = ida_simple_get(&wakeup_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0)
> +		return id;

No lock needed for this ida?  Are you sure?

> +	ws->id = id;
> +
> +	dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> +					wakeup_source_groups, "wakeup%d",
> +					ws->id);
> +	if (IS_ERR(dev)) {
> +		ida_simple_remove(&wakeup_ida, ws->id);
> +		return PTR_ERR(dev);
> +	}
> +
> +	ws->dev = dev;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> +
> +/**
> + * wakeup_source_sysfs_remove - Remove wakeup_source attributes from sysfs.
> + * @ws: Wakeup source to be removed from sysfs.
> + */
> +void wakeup_source_sysfs_remove(struct wakeup_source *ws)
> +{
> +	device_unregister(ws->dev);
> +	ida_simple_remove(&wakeup_ida, ws->id);

Again, no lock, is that ok?  I think ida's can work without a lock, but
not always, sorry, I don't remember the rules anymore given the recent
changes in that code.

thanks,

greg k-h
