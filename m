Return-Path: <linux-pm+bounces-793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC7C80883F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 13:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C723F1C20C7C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB33AC2D;
	Thu,  7 Dec 2023 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tz2+RgoE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387D10FD
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 04:46:22 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db548cd1c45so888810276.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 04:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701953182; x=1702557982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VI0Dv+MkJTCAPGHL7fb9uH8dV/Mhy8R6r6OQ9YvGWaY=;
        b=Tz2+RgoEHRb82TqBFGZJZb3cwiiRjTIIw/8Aq4lNIpvlx2ZzcNMoYZRr3Izp5daAus
         6obmVLt5DNB2PQAEW9nY7riWIpwXfr0GCh3yEtexC7OASm44l5ioCHryibfkWrMqXc8z
         1py1zYXWYRTQ9s/w4wI8EtXo6WdS8+ymFyOBaLB1TPsYDNWcj8mxz5kgEuirukEM6hde
         ePhasyTuxrZi0/xYo6WENJg17iTtk4o3k7cjcxTXMHVptgfkXK8Ucabo9cQ8upYLXBIq
         PG8dgyPeIMFh9NfZlviwfIbN0yvrxXY1VF8P5PMsR+ZZgGKB4bhs7Dn6F4K8RYei+s7v
         c/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953182; x=1702557982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VI0Dv+MkJTCAPGHL7fb9uH8dV/Mhy8R6r6OQ9YvGWaY=;
        b=ovY3jqdQEjjjhvdZZmpnu5/gshQrZE05nDC2mq6SIg7SW2dOizb/6wUzz1bmioGOhg
         W3mFoJSR5Uc0TYChr7Cg2XqXHNBGpQdA777sf4z57SmDTCyG9LBxDzNwd+Hrj41D1Dw9
         4qHSzgRfUGOuArStvf+fs0ExFrfxO5yL6pGuIcSINHTT5lWU069sXYe4A4GQe9kyPHbD
         CiUoha849JLkSjYN9jD7hycbOzC0gRaentPAPLjvSsSnHqK1LUnwQtYytwwMp+CLKgyB
         ks57UXItz1bFYfWFeoCkVnNy/9pDqKLc8BmPWycOviQAtfRAVw8jUIkkdGVW6upkL8Gz
         ONTA==
X-Gm-Message-State: AOJu0Yw/jjvM2a83erm++5YVsI/hfHc+ceDANp0khY2BEvnZnRjg+aBv
	8ziRLCgrdoq2Oh1D2yloAS7VnaFR8vGKv3f6Ft+jKA==
X-Google-Smtp-Source: AGHT+IFEOW0K8NPLkg1XDUGQAovRn5vj/jSL4Juak4jk5D8i07yxZPAAzlxqeeQUWKmXDhOp0eDutvDQE7eu5xUt/MY=
X-Received: by 2002:a5b:dc3:0:b0:db7:dacf:2f15 with SMTP id
 t3-20020a5b0dc3000000b00db7dacf2f15mr2108499ybr.92.1701953182192; Thu, 07 Dec
 2023 04:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205225856.32739-1-rdunlap@infradead.org>
In-Reply-To: <20231205225856.32739-1-rdunlap@infradead.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2023 13:45:46 +0100
Message-ID: <CAPDyKFp2HZ1r4FXBYMN=uK6JTkADBtw+NH0dDeT3HJ9bV90wdA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix domain_governor kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 23:59, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix kernel-doc warnings found when using "W=1".
>
> domain_governor.c:54: warning: No description found for return value of 'default_suspend_ok'
> domain_governor.c:266: warning: No description found for return value of '_default_power_down_ok'
> domain_governor.c:412: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain_governor.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff -- a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -49,6 +49,8 @@ static int dev_update_qos_constraint(str
>  /**
>   * default_suspend_ok - Default PM domain governor routine to suspend devices.
>   * @dev: Device to check.
> + *
> + * Returns: true if OK to suspend, false if not OK to suspend
>   */
>  static bool default_suspend_ok(struct device *dev)
>  {
> @@ -261,6 +263,8 @@ static bool __default_power_down_ok(stru
>   * @now: current ktime.
>   *
>   * This routine must be executed under the PM domain's lock.
> + *
> + * Returns: true if OK to power down, false if not OK to power down
>   */
>  static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
>  {
> @@ -406,8 +410,8 @@ struct dev_power_governor simple_qos_gov
>         .power_down_ok = default_power_down_ok,
>  };
>
> -/**
> - * pm_genpd_gov_always_on - A governor implementing an always-on policy
> +/*
> + * pm_domain_always_on_gov - A governor implementing an always-on policy
>   */
>  struct dev_power_governor pm_domain_always_on_gov = {
>         .suspend_ok = default_suspend_ok,

