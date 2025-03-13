Return-Path: <linux-pm+bounces-23949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1094A5E985
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 02:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308A717AD91
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 01:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3C527713;
	Thu, 13 Mar 2025 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ji0YQxkn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BA4C6C
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830441; cv=none; b=GvU+WSW3zusjATxIgOMBwU8fpctQatMcl6krlHdr2H+kG6K9z0pNbjrZbnDpxsi6mjxYmEu0F/Ul3VDhnCA6FNVr8m4DBBSXrCcw1crWKLMXV1imI9stPzzHXzxIuWHp+8x/fq2LbGaKrd+B3Jv1XRRLOrSciJNxsMSuR3mDLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830441; c=relaxed/simple;
	bh=CNzX2BLt9vSy0RwqsvvJFnXAbLJjSgMYXeOXRYHsjfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VU//SpwVaMKlsrwLXaey0nLBnevxZREAa6Lc0hTkneopgI+cRU/hSaYjm7eJWTjUSOSnTrQkYoxggqB8+CWP9eSH+EpHSIapSMku5rqCTgbNFbAU+Di84QwM6zW7Kd0sW5k4Mm2Wgl3agpcdqWSrYTXu2V61CjvB+WFVPWu09Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ji0YQxkn; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso5311471fa.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 18:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741830438; x=1742435238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxo19Z41i1BGllZFR/UFGbGYG0KQe5O29loXSOdObiM=;
        b=Ji0YQxknpRrUBH55FrPVD9hpXuEXDMhMhUPELz69eGISqzpqhi/Ze30ZlQj7oS5ROA
         HXaJkoWx9H3SushWL7uXsrGpbxR5/QbaE4GiJwXIolYEY72zsfTkXomqqOUsvSg1Wd5n
         O+ZZeAoKxaobifggQRu038D6C22k2pwxbEY/n8pk7MNq+me9SkB9auLiGzlpVDLDcuUE
         nHv9SMeKXltU86wXp47qnyNeF2ictso8OCkVV/C2wNwnsI/axcxDOvNss1w+2+++gJu1
         PvYieS76Tvk20rgLoAKSi16TQHdhtwrM/RpGWU8hfcg9DM3CSB7/eD/ylHyjZm1oC9w/
         mW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741830438; x=1742435238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxo19Z41i1BGllZFR/UFGbGYG0KQe5O29loXSOdObiM=;
        b=BdnShk448WelFeQ6cCr7nf/torM4/0i9b5Dywu63Jut+AjrKwFdwU4ORd6O4avwBc+
         h6j2T/FnjUlPqKS8euNoxavtndUooABgJiH2KXBiZh8NDUg6UVvNYFliDRdfyptAv/wn
         QAz99FKoQA+tn9iwTHFWUWtG1KE1gcDHZGdEo/tIwBUm0+96uKxLF5sHxEnuzXKcbzt+
         D4HQCcAJzBf6EmppQ+FbnpAPcWCqxzU9+R4eDIdJeJqpnVDOGIv/zV+Rt4AibEMUnjA4
         dbMg9ZwsWBKR90CYP6mK3KfvEjixUEoqAy1ngLHENqIQgiFnRd1abHi7kniHNSq6dAQV
         zjOQ==
X-Gm-Message-State: AOJu0YwihCNqX3fJvhcp0051VH0EuvfeV9MObUx2nfHeJNOY9rfkbOO1
	vO1ZyDHaf5sp/4g0PlFuwFUFJdeYTmcXReg1O3aI9yetibEGLkbNSaVpQRjbweQfsBQX1mP1Gaz
	BK3H0ba1FWF/8Yn+XKuLKz6Gm4AqFqyshj90k
X-Gm-Gg: ASbGnct2OdIX1UV2RO46GoUckPQ51JKJlIxMLxqrMYS2IbhUy1jD7brdtLo1TJOLk/E
	Sj4Nk8yfT4ENGLX6ijCohzL+ydazNQB6cpTS8oQuPNmjmfxYjNvhy9E+mSigT9fXFX4KChBULbI
	49tyhLxuVGVIMs8oPevI0fD/w9Zqz68kvxL54gHYSOg0sW7Vb+NwkIpFEYtjPNjag=
X-Google-Smtp-Source: AGHT+IHBMMlR+WeA0g0MIwwF5aBQXbpjbTmUfMWTU50ympR1rsZPq4VdmUa2cc0kWXmoeoa0ebTlcEsJ+7I4yxZ4kS8=
X-Received: by 2002:a05:6512:3dab:b0:549:4e88:2e6a with SMTP id
 2adb3069b0e04-54990e2bca7mr9022964e87.6.1741830437391; Wed, 12 Mar 2025
 18:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <8536271.NyiUUSuA9g@rjwysocki.net>
In-Reply-To: <8536271.NyiUUSuA9g@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 12 Mar 2025 18:46:40 -0700
X-Gm-Features: AQ5f1Jq-16AfGXUjWcMj9D0w6-WVNfS-_YrMcJ1i9u46rv9rFjfsh6vZwFCgFc8
Message-ID: <CAGETcx8htyu635DhuE_+2X7RzwBwcvT7Wdkh9RL7Zswf1B079A@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] PM: sleep: Start suspending parents and suppliers
 after subordinate suspend
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In analogy with the previous change affecting the resume path,
> make device_suspend() start the async suspend of the device's parent
> and suppliers after the device itself has been processed and make
> dpm_suspend() start processing "async" leaf devices (that is, devices
> without children or consumers) upfront because they don't need to wait
> for any other devices.
>
> On the Dell XPS13 9360 in my office, this change reduces the total
> duration of device suspend by approximately 100 ms (over 20%).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   73 +++++++++++++++++++++++++++++++++++++++=
++++---
>  1 file changed, 69 insertions(+), 4 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1237,6 +1237,49 @@
>
>  /*------------------------- Suspend routines -------------------------*/
>
> +static bool dpm_leaf_device(struct device *dev)
> +{
> +       struct device *child;
> +
> +       lockdep_assert_held(&dpm_list_mtx);
> +
> +       child =3D device_find_any_child(dev);
> +       if (child) {
> +               put_device(child);
> +
> +               return false;
> +       }
> +
> +       /*
> +        * Since this function is required to run under dpm_list_mtx, the
> +        * list_empty() below will only return true if the device's list =
of
> +        * consumers is actually empty before calling it.
> +        */
> +       return list_empty(&dev->links.consumers);
> +}
> +
> +static void dpm_async_suspend_superior(struct device *dev, async_func_t =
func)
> +{
> +       struct device_link *link;
> +
> +       mutex_lock(&dpm_list_mtx);
> +
> +       /* Start processing the device's parent if it is "async". */
> +       if (dev->parent)
> +               dpm_async_unless_in_progress(dev->parent, func);
> +
> +       /*
> +        * Start processing the device's "async" suppliers.
> +        *
> +        * The dpm_list_mtx locking is sufficient for this.
> +        */

Why is dpm_list_mtx sufficient? Is it because you are assuming no
driver is trying to change the device links during suspend/resume? Or
is there some other reason? That sounds a bit risky. Is it because if
you do, you'll hit a AB-BA deadlock or at least a lockdep warning?
Also, if we can use the device links read locks, we won't block the
other readers -- so, less contention.

> +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
> +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> +                       dpm_async_unless_in_progress(link->consumer, func=
);

This will still queue a lot of devices that can't suspend yet.

Curious, how many devices do you have in the system where you are testing t=
his?

-Saravana

> +
> +       mutex_unlock(&dpm_list_mtx);
> +}
> +
>  /**
>   * resume_event - Return a "resume" message for given "suspend" sleep st=
ate.
>   * @sleep_state: PM message representing a sleep state.
> @@ -1663,6 +1706,8 @@
>         device_links_read_unlock(idx);
>  }
>
> +static void async_suspend(void *data, async_cookie_t cookie);
> +
>  /**
>   * device_suspend - Execute "suspend" callbacks for given device.
>   * @dev: Device to handle.
> @@ -1791,7 +1836,13 @@
>
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
> -       return error;
> +
> +       if (error || async_error)
> +               return error;
> +
> +       dpm_async_suspend_superior(dev, async_suspend);
> +
> +       return 0;
>  }
>
>  static void async_suspend(void *data, async_cookie_t cookie)
> @@ -1809,6 +1860,7 @@
>  int dpm_suspend(pm_message_t state)
>  {
>         ktime_t starttime =3D ktime_get();
> +       struct device *dev;
>         int error =3D 0;
>
>         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
> @@ -1822,15 +1874,28 @@
>
>         mutex_lock(&dpm_list_mtx);
>
> +       /*
> +        * Start processing "async" leaf devices upfront because they don=
't need
> +        * to wait.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)=
 {
> +               dpm_clear_async_state(dev);
> +               if (dpm_leaf_device(dev))
> +                       dpm_async_fn(dev, async_suspend);
> +       }
> +
>         while (!list_empty(&dpm_prepared_list)) {
> -               struct device *dev =3D to_device(dpm_prepared_list.prev);
> +               dev =3D to_device(dpm_prepared_list.prev);
>
>                 list_move(&dev->power.entry, &dpm_suspended_list);
>
> -               dpm_clear_async_state(dev);
> -               if (dpm_async_fn(dev, async_suspend))
> +               dpm_async_unless_in_progress(dev, async_suspend);
> +
> +               if (dev->power.work_in_progress)
>                         continue;
>
> +               dev->power.work_in_progress =3D true;
> +
>                 get_device(dev);
>
>                 mutex_unlock(&dpm_list_mtx);
>
>
>

