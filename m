Return-Path: <linux-pm+bounces-23937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B0A5E558
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 21:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9679C7A7C6B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DF21EE7B9;
	Wed, 12 Mar 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD7UTkFS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F71EF0BA;
	Wed, 12 Mar 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811402; cv=none; b=DW6Fn2cM0OskfcV+W3HPcAPEIfp5k7UpaJD6bc7ovwmLUN55yETQdG0CBjnEGOuehCxOCdyJyJlAc7VnDVyCrrCl0CXQQZ29AtMlCc0x/2GCMn9m0khgXzsuRjJ9i8QbfZGDxZLdYCnUyjN4S/Iw9ugvMHubPEwPnZt33+YnyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811402; c=relaxed/simple;
	bh=W4dBY0J4Uk+rhzgTkH7BaDfHixpCMld49I/HUUQ/wRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBpIQyLs0UzaotwEU3pcBwMXhNfkwLPYrlJ+gfR/dowY40DechWMiu8V1PCwHON4TJsAp+71TCqJfwduQFXW/pR98OzGFsRK/r0TK8TDKNqLNFXHX50TSHyPQHYcbwY1egCE+j9yXinXE/Rb4zM0Lf86qihVcOUGpVI846WyihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD7UTkFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9247AC4CEEB;
	Wed, 12 Mar 2025 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811401;
	bh=W4dBY0J4Uk+rhzgTkH7BaDfHixpCMld49I/HUUQ/wRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SD7UTkFSjyd/N0bUBGm1BvlDP8dY3hRugE1BUK+sbOHD+/w+h9eU5K/mp/4kKLLx9
	 p/erur0xX464O+eIjQC+J0N1S2/SgXWVFcG0hVQg7gqGwk8y9oyJx8lqFCJYZG9SrJ
	 D97vRIiHTWtkD/7D8+w5yHng98D+V7B1jy2wYSgrH6ZnEGpXz22IxdYR8ZNNfstHVM
	 2epyQ5Z4i5u1B3T8CWxUENAB74tjGnC6ctlQw+7EjlFThP7d4GAqtQpFnvcZZzCz+i
	 CUSITgPWjKJBmFOtjuN7My7iUe5JivOImiEu2CgrmlfB2hexhpY4z03mEN99PPPpC6
	 xzfM/9j/fwqdA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72b7f553de3so32489a34.3;
        Wed, 12 Mar 2025 13:30:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNskGZSXKYsmIJNSEXnEoAxci89+o5A/fbp8hGlipG8v5lZgy9Sn56N+yR9LNVdqUiZerigUHrqEQ=@vger.kernel.org, AJvYcCVQ1ECym3MoyYx59GXGY3Y/FNqCNdD3SOFapT0tVY/hAP+jIvSMVzy0kqNRNIg8GfQ/CxJPMGLlWzlenzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjvQ13Es/iVps2EvZfSpnJDCR34Ry+Jp9GdLMfcpaT0uMO4JU
	AgNMW1BuShME7pGtyglrEIQzXpywRHvmxKcOhutGOb/BcrKdtzVwVSo+8RiTiEnwGx9paZ8EOTT
	HhjFBMGWq7tJXVXQL1GL5nvRzUAo=
X-Google-Smtp-Source: AGHT+IGSaa9otr3BuPbKB9DCav98nhlOLCYG4I3D9cGTT7HHUfSlQEFc8c8b23XQEFu/Pmsn7nNttDVsqcO5c9LTnBo=
X-Received: by 2002:a05:6830:821a:b0:72b:a92b:5797 with SMTP id
 46e09a7af769-72ba92b5872mr1434656a34.9.1741811400801; Wed, 12 Mar 2025
 13:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307212347.68785-1-linux@treblig.org>
In-Reply-To: <20250307212347.68785-1-linux@treblig.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 21:29:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iEpojVO=sJ4FR3LvJzYBYGhihx0d-TN95BuCEpDRaO5A@mail.gmail.com>
X-Gm-Features: AQ5f1Jrs9sgVstaY-HhC5LfEtc8S1ViaQMx3sbV1Qd674z4M_w-WEIFHi4m_KNI
Message-ID: <CAJZ5v0iEpojVO=sJ4FR3LvJzYBYGhihx0d-TN95BuCEpDRaO5A@mail.gmail.com>
Subject: Re: [PATCH] PM: clk: Remove unused pm_clk_remove
To: linux@treblig.org
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 10:23=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> pm_clk_remove() is currently unused.
> It hasn't been used since at least 2011 when it was renamed from
> pm_runtime_clk_remove by
> commit 3d5c30367cbc ("PM: Rename clock management functions")
>
> Remove it.
>
> Note that the __pm_clk_remove is still used and is left in.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/base/power/clock_ops.c | 40 ----------------------------------
>  include/linux/pm_clock.h       |  4 ----
>  2 files changed, 44 deletions(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_op=
s.c
> index 97a53215a274..b69bcb37c830 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -343,46 +343,6 @@ static void __pm_clk_remove(struct pm_clock_entry *c=
e)
>         kfree(ce);
>  }
>
> -/**
> - * pm_clk_remove - Stop using a device clock for power management.
> - * @dev: Device whose clock should not be used for PM any more.
> - * @con_id: Connection ID of the clock.
> - *
> - * Remove the clock represented by @con_id from the list of clocks used =
for
> - * the power management of @dev.
> - */
> -void pm_clk_remove(struct device *dev, const char *con_id)
> -{
> -       struct pm_subsys_data *psd =3D dev_to_psd(dev);
> -       struct pm_clock_entry *ce;
> -
> -       if (!psd)
> -               return;
> -
> -       pm_clk_list_lock(psd);
> -
> -       list_for_each_entry(ce, &psd->clock_list, node) {
> -               if (!con_id && !ce->con_id)
> -                       goto remove;
> -               else if (!con_id || !ce->con_id)
> -                       continue;
> -               else if (!strcmp(con_id, ce->con_id))
> -                       goto remove;
> -       }
> -
> -       pm_clk_list_unlock(psd);
> -       return;
> -
> - remove:
> -       list_del(&ce->node);
> -       if (ce->enabled_when_prepared)
> -               psd->clock_op_might_sleep--;
> -       pm_clk_list_unlock(psd);
> -
> -       __pm_clk_remove(ce);
> -}
> -EXPORT_SYMBOL_GPL(pm_clk_remove);
> -
>  /**
>   * pm_clk_remove_clk - Stop using a device clock for power management.
>   * @dev: Device whose clock should not be used for PM any more.
> diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
> index 45c3f3ccbaf8..c3b46fa358d3 100644
> --- a/include/linux/pm_clock.h
> +++ b/include/linux/pm_clock.h
> @@ -42,7 +42,6 @@ extern void pm_clk_destroy(struct device *dev);
>  extern int pm_clk_add(struct device *dev, const char *con_id);
>  extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
>  extern int of_pm_clk_add_clks(struct device *dev);
> -extern void pm_clk_remove(struct device *dev, const char *con_id);
>  extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
>  extern int pm_clk_suspend(struct device *dev);
>  extern int pm_clk_resume(struct device *dev);
> @@ -75,9 +74,6 @@ static inline int of_pm_clk_add_clks(struct device *dev=
)
>  {
>         return -EINVAL;
>  }
> -static inline void pm_clk_remove(struct device *dev, const char *con_id)
> -{
> -}
>  #define pm_clk_suspend NULL
>  #define pm_clk_resume  NULL
>  static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk=
)
> --

Applied as 6.15 material, thanks!

