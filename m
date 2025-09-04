Return-Path: <linux-pm+bounces-33818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B959BB43704
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824747A29B7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6FE2EFDBE;
	Thu,  4 Sep 2025 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cb/I2Q7j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3E28153C
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977856; cv=none; b=liGmsbMN58JcfiOEp2mtdXKzXUaJk7dLEX1nHRFEXksUqNRjnLr5TdUmxgsvMTdby7v18HYHkJtxdQmcVXUNcdMpwaEV5vi/qT70IksBtCjbyZpoHkStayMmG7jk0ItrsvHfPKRhycHnht7dB1u73gcq0nwcAAuDYwwRzaec8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977856; c=relaxed/simple;
	bh=uYQwEsV26uyiF33/5+omMD9V9iEl78f7qW8OA8RKrMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqK5F5FwOvdz7JdHJFt7U/1RGSV3WDkOUJ8OGcGLW+T+rBJ1F/sAR5853eN+lt1d0EsAalDtG+7z//aohoktBUZocv9J2VlwQIrU40mXieQDgSpdpH1dDMW8JbO6swCyKp7oOm6xtAipBHsSL1Ce4UbVsnlXtIGEhx9/ujWSVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cb/I2Q7j; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-723bc91d7a6so7726907b3.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756977853; x=1757582653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zFJhiMPD+uwhG6k6f6Q75zlCjRBbKevPS6vf3fOV+A=;
        b=Cb/I2Q7jTggbwZ0cr3p/5BPZq2XbBjBZZ4tyGSik9wMXDKNrjSdJZzkFwoyKQD6ewl
         eRgFD9saH/dDXZ2dg8kafYxAa/HMgVCWgX2n/GqvXVToY9mb1CmjLvGZRv3xFJI7bVQw
         pL3dYmAquXQ4HrD8YxJthgq06JnbDqAPjfc6QE7SQstxee3QiEurOdJwZWF1c16M+JqR
         rnU3zqxSNLEywuYkk+UoMUVWxEpqDfAFMCdVodASWrkzKcwf9AkDPda6Q7XjhM8t7tq2
         XA39jDETsEn/D5lI5k3KoyzAfPRagZmg2ZjMbBAK2uX51B5N+KXx4SfQ/kQFro4/JA5D
         imOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756977853; x=1757582653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zFJhiMPD+uwhG6k6f6Q75zlCjRBbKevPS6vf3fOV+A=;
        b=su6/ldHrbgeiqwV0AOf59basmtXz7k5JETcO35huhr7sy+cjFa4n/gMmRIOjteyWw2
         B4HlprwDTxVCbzCn8o2+rMkngt2msYgTaMb6pEMv8Ij8xTGuRa5cUizEThLRJe5WIFm/
         4sBq5YfrdOG64rFqc8dTdtUOzdYIjuPsDrPh6Zj/OUEBYpy1/YO9hfdbvaO6y5rX0d78
         O9qs4+kpLPXILK7kCnMU3YaKl+yWG6z4mJQjlqKYBkpEKBldorfbXlml6wTL1HTxB0FC
         QfRiVXEWdsUgiFarwIP9Xx8VEzyLv00UY6fornFFCtdjLI+F5q8VeHxMydXTH/I67nZx
         qclw==
X-Gm-Message-State: AOJu0Yw7NJTFzZlynKIQSEk8lPbZvh644wMoDf/1XL4c4AN0ITy0cvyO
	N8C2iU4bHpjC54Xart9mqjWSRfeW9EO8DZd+mQJvc0QSkKUQvQPOPz2JktfYLOG9vBKsD7XhuzS
	zloOvqrm7Mcef4Lactnelv06x8zwISifDHGYAMj0RJw==
X-Gm-Gg: ASbGncv49usWcq37HjVAkxIvQX/OM4gdKS3udMn7u8gHjxx0fx3SDh8tCIZUCIVgNXU
	PwnlS8WRzxpNBqoz4M1RNuYsiS32AZMaB0d/ierJu/hA4Rf1FGn/YLJ5nu9pbpccS06M80/1PcY
	XGFVHA7i6n+oQ49GZ7Qsaql3LY04YZEoW/CmNUV9dnhY4QXP5Dh0mozh5F8zAb/N7MnFjKr6SMN
	Of1EzFc
X-Google-Smtp-Source: AGHT+IG37JhQex61eDc1SgaSz8ur+qTtFQluU+JwZN+cvPKDYKxJr9LdsVHmwWYuck+QaeAqUuWEF3W3vOnXxegvOK4=
X-Received: by 2002:a05:690c:d08:b0:722:6dab:3565 with SMTP id
 00721157ae682-722763637ebmr172876817b3.17.1756977853010; Thu, 04 Sep 2025
 02:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6202205.lOV4Wx5bFT@rafael.j.wysocki> <1944671.tdWV9SEqCh@rafael.j.wysocki>
In-Reply-To: <1944671.tdWV9SEqCh@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 11:23:36 +0200
X-Gm-Features: Ac12FXwp5QDoK5Srq0ThrMB8tJqXxRlk5lFucCimGbG_88p-vdW1No0S88b_6fA
Message-ID: <CAPDyKFpxthRunA6f0RkjAt=sBMiyjQp_iUv0vfTn31m+DE5Krw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PM: core: Add two macros for walking device links
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 15:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add separate macros for walking links to suppliers and consumers of a
> device to help device links users to avoid exposing the internals of
> struct dev_links_info in their code and possible coding mistakes related
> to that.
>
> Accordingly, use the new macros to replace open-coded device links list
> walks in the core power management code.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/base.h          |    8 ++++++++
>  drivers/base/power/main.c    |   18 +++++++-----------
>  drivers/base/power/runtime.c |    3 +--
>  3 files changed, 16 insertions(+), 13 deletions(-)
>
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -251,6 +251,14 @@
>  void fw_devlink_drivers_done(void);
>  void fw_devlink_probing_done(void);
>
> +#define dev_for_each_link_to_supplier(__link, __dev)   \
> +       list_for_each_entry_srcu(__link, &(__dev)->links.suppliers, c_node, \
> +                                device_links_read_lock_held())
> +
> +#define dev_for_each_link_to_consumer(__link, __dev)   \
> +       list_for_each_entry_srcu(__link, &(__dev)->links.consumers, s_node, \
> +                                device_links_read_lock_held())
> +
>  /* device pm support */
>  void device_pm_move_to_tail(struct device *dev);
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -40,10 +40,6 @@
>
>  typedef int (*pm_callback_t)(struct device *);
>
> -#define list_for_each_entry_srcu_locked(pos, head, member) \
> -       list_for_each_entry_srcu(pos, head, member, \
> -                       device_links_read_lock_held())
> -
>  /*
>   * The entries in the dpm_list list are in a depth first order, simply
>   * because children are guaranteed to be discovered after parents, and
> @@ -281,7 +277,7 @@
>          * callbacks freeing the link objects for the links in the list we're
>          * walking.
>          */
> -       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
> +       dev_for_each_link_to_supplier(link, dev)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_wait(link->supplier, async);
>
> @@ -338,7 +334,7 @@
>          * continue instead of trying to continue in parallel with its
>          * unregistration).
>          */
> -       list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
> +       dev_for_each_link_to_consumer(link, dev)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_wait(link->consumer, async);
>
> @@ -675,7 +671,7 @@
>         idx = device_links_read_lock();
>
>         /* Start processing the device's "async" consumers. */
> -       list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
> +       dev_for_each_link_to_consumer(link, dev)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->consumer, func);
>
> @@ -1330,7 +1326,7 @@
>         idx = device_links_read_lock();
>
>         /* Start processing the device's "async" suppliers. */
> -       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
> +       dev_for_each_link_to_supplier(link, dev)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->supplier, func);
>
> @@ -1384,7 +1380,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
> +       dev_for_each_link_to_supplier(link, dev)
>                 link->supplier->power.must_resume = true;
>
>         device_links_read_unlock(idx);
> @@ -1813,7 +1809,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
> +       dev_for_each_link_to_supplier(link, dev) {
>                 spin_lock_irq(&link->supplier->power.lock);
>                 link->supplier->power.direct_complete = false;
>                 spin_unlock_irq(&link->supplier->power.lock);
> @@ -2065,7 +2061,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
> +       dev_for_each_link_to_supplier(link, dev) {
>                 if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
>                         continue;
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1903,8 +1903,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_srcu(link, &dev->links.suppliers, c_node,
> -                                device_links_read_lock_held())
> +       dev_for_each_link_to_supplier(link, dev)
>                 if (device_link_test(link, DL_FLAG_PM_RUNTIME)) {
>                         link->supplier_preactivated = true;
>                         pm_runtime_get_sync(link->supplier);
>
>
>

