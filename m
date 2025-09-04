Return-Path: <linux-pm+bounces-33817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72018B43702
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 11:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CD37C3045
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34802F0698;
	Thu,  4 Sep 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LyDIgMvd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C72EFDA5
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977839; cv=none; b=LBGcNEA8Yy24Jc8FZ2V+b5Os7NeSHMtPSdfI1Q20HUIlwIw8RXjYMy2UIT9jRdw19fj7lKQQDtyxxX3rZSuDLtTvqQJZrhox6DcLVaQHtMJ+xcKKP3ITfqRKWwOtOCMiDyvQtT+JLREMNBmFLP8e+nZD8oCGu2goEbU2sKJoVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977839; c=relaxed/simple;
	bh=d6DJnsU//9cevGg0jVYiTkvbd/hhmd7yOLgFi5tH7ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKoQB8cdHGB2lLCBdG9n4JJeDA0u8jyrBXiQUNJbAq++c2J3huNGtoDt7xRHPmOVQdaaMJDATYfppUrLbGTtdjC6dtr1a/9r6tF8BB4jn1bb9fkDKmRfNI7AZIMdIPl+0GikZy1B0o1LrPPEW20KiL46Efs8rA3fh6t4e1FB6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LyDIgMvd; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603f13abso8825097b3.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756977835; x=1757582635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzeRrlKixisMVnd0UvA2X18pYorJUCabya/Ko1pEIRg=;
        b=LyDIgMvddeO+vc8a4eJGFhR0zJl8f8yzfsITu5RlWe1+ApPietDxRSM2CLqLcWk2+o
         ptgE71GJMlTsy9eeLRZU3res9T3jz34q6l1c5aQ7yOn8HHIwY+wB3lmKjhd0DDtuH5OJ
         ZPq0sAfgWAx+1P8lOyNPJjj0oXlkXH1rWuEVDMB30OPfLF2MF7KoNfJYNNEayhg7EjOm
         yNJ4E6Oyj3SD22oi2maaCxU1DX8DStrLS6Jmjh61xa/UUxAgO33VCZRxkVQj0L9l1pTL
         GDEmROPRXxrnFKcDvwSOdUSghGNaDyZhtoW718UBH+oVqywGmg2pHzz8XNNsEdjvJBib
         35ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756977835; x=1757582635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzeRrlKixisMVnd0UvA2X18pYorJUCabya/Ko1pEIRg=;
        b=AOwBqMKOKlBnPW6SFojfrUwK2HeCc9kUVZA4yWe2wiN6JqYv99IuNNoyHHSkUJNkeV
         1Jh8FBMeqPZQOmKeEjwBsRXHXeUCLzLaS0e2cfAypv/ztbqpibcJh940HpPhjwUgESKX
         VPVkXP6G6390upzJvEtZqqlRi4AeJPI54dVzlXMqXffeGVQ6rhVVJB6dN3SyvrmQibgB
         msDGuDnuH3x+ZcsKqPkcpqNfxPBYD1yMjhbTdQdxpfuuVbELO2e0EKn+aZ2tpqaaPoPG
         js0fqARsQ9MlKRDvrwV2VZSjd4E0HbfCQLdkt5KFJjbH5VioLxpTmqNU4wRXEBer2Nxt
         vj2g==
X-Gm-Message-State: AOJu0YwAO3Z7fIvZ5d0KJzpWgu1Vk3Y1K2wPsZVvQNu2AunlVHLUbJ2Z
	/35sNFjxxCu5B9MiMyVAIceI1jpqYbDAcUp/nTtnZ734T00ihdRS328eE45I4PyHjg3EiFR1cQX
	iYhssfgB4dPZtYYzdOwl1S06a0EChGXjKZWFg7yfxEQ==
X-Gm-Gg: ASbGnctHzykFnNAAeI/4XM0qXABm2mHF4ckrfl3paKtdB9joNIbnNDfwjuKYrkZ5z4p
	Qhf9LRJHvWcUwFNUSfHg/qhS7YVRiwZNPw1/ncqxAuNpnN2lm4092HdEEgFckQa5JUG071QiQfJ
	Nv2qWomk3ecq2n9cV8wDu2eGDC8FbuWJGMCPrIGp3eXNHE6IHtmsnOl7a1QKW1fhRgFnITa9EkI
	TyBYUmj
X-Google-Smtp-Source: AGHT+IFr9L4PrSZPmzSuetZEfmDWJaA0qvzMSVVhGJl1HJQyaGQxkOvsSArE/36UhbKntob1lOo5JVJohbDRYtoqRbY=
X-Received: by 2002:a05:690c:6c85:b0:71f:f198:da8f with SMTP id
 00721157ae682-72276335654mr205654447b3.2.1756977835142; Thu, 04 Sep 2025
 02:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6202205.lOV4Wx5bFT@rafael.j.wysocki> <2393512.ElGaqSPkdT@rafael.j.wysocki>
In-Reply-To: <2393512.ElGaqSPkdT@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 11:23:18 +0200
X-Gm-Features: Ac12FXwDCpU4_C_Ls_ht_T7Y3VN2FOjJ3-MfI0MyM4u_qIM41ufdSl_RCheNlgI
Message-ID: <CAPDyKFp5NbEtiLRZihta0y=DXSTKghnfGHH1N_Y1BF=Q73eTtA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PM: core: Annotate loops walking device links as _srcu
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
> Since SRCU is used for the protection of device link lists, the loops
> over device link lists in multiple places in drivers/base/power/main.c
> and in pm_runtime_get_suppliers() should be annotated as _srcu rather
> than as _rcu which is the case currently.
>
> Change the annotations accordingly.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c    |   18 +++++++++---------
>  drivers/base/power/runtime.c |    4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -40,8 +40,8 @@
>
>  typedef int (*pm_callback_t)(struct device *);
>
> -#define list_for_each_entry_rcu_locked(pos, head, member) \
> -       list_for_each_entry_rcu(pos, head, member, \
> +#define list_for_each_entry_srcu_locked(pos, head, member) \
> +       list_for_each_entry_srcu(pos, head, member, \
>                         device_links_read_lock_held())
>
>  /*
> @@ -281,7 +281,7 @@
>          * callbacks freeing the link objects for the links in the list we're
>          * walking.
>          */
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_wait(link->supplier, async);
>
> @@ -338,7 +338,7 @@
>          * continue instead of trying to continue in parallel with its
>          * unregistration).
>          */
> -       list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_wait(link->consumer, async);
>
> @@ -675,7 +675,7 @@
>         idx = device_links_read_lock();
>
>         /* Start processing the device's "async" consumers. */
> -       list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->consumer, func);
>
> @@ -1330,7 +1330,7 @@
>         idx = device_links_read_lock();
>
>         /* Start processing the device's "async" suppliers. */
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->supplier, func);
>
> @@ -1384,7 +1384,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
>                 link->supplier->power.must_resume = true;
>
>         device_links_read_unlock(idx);
> @@ -1813,7 +1813,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
>                 spin_lock_irq(&link->supplier->power.lock);
>                 link->supplier->power.direct_complete = false;
>                 spin_unlock_irq(&link->supplier->power.lock);
> @@ -2065,7 +2065,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
>                 if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
>                         continue;
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1903,8 +1903,8 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> -                               device_links_read_lock_held())
> +       list_for_each_entry_srcu(link, &dev->links.suppliers, c_node,
> +                                device_links_read_lock_held())
>                 if (device_link_test(link, DL_FLAG_PM_RUNTIME)) {
>                         link->supplier_preactivated = true;
>                         pm_runtime_get_sync(link->supplier);
>
>
>

