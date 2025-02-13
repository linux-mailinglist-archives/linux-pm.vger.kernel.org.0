Return-Path: <linux-pm+bounces-22044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A2A35088
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 22:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982B8188D9A0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3724BC0E;
	Thu, 13 Feb 2025 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXQeeq8u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE21245018
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482443; cv=none; b=mSBJ3Gfudr/+jW/I7prgum0QDz0dKsBVQD0y8268T7fF1E4sZRX0PfEvcNv7ZhmJ1/f+lNftEYklZF2tvOYijXenA6nWfpv53gSdubtSQOQP9H3UhqAXWvYP+TQMt/OsypZLzqelf86TBw4ogduO17CvVq9mBDkxtFF/705eycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482443; c=relaxed/simple;
	bh=BWZk2OIyG/4/rewn6TydvxjHKdlDWjJH8mWNKLHYe68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrnjaSswmsXhGyAWENJUM3T0vPV1kuoEbi/YFHZmAw7jC1j6trHKDQIrI2/R1T0OvnJB/zROMkbk1xe4I4ZeprCNDh5Hy5meWRUx8QgQNd/pOo3H3+YytmW28pbfF+PBTOSxVg1uXGrBiUitgyyWEuzRrROyXoIWb59EgfTwinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXQeeq8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F098BC4CED1
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739482443;
	bh=BWZk2OIyG/4/rewn6TydvxjHKdlDWjJH8mWNKLHYe68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HXQeeq8uVgyzpN4WtlwkHnS1Rkea49WV0QeQCWwkgBZkrflyTgzrOVhM3+i6jFf7a
	 FHafiEDmmeaO9cVP2o65bdSt6ceR5RLIqWwOzJYq6h3dhY32SAZEkbXpbsetje9QPV
	 cDa7WdHtpW32JTLoE+P2G2Mc82wwgPZ8F20OD04/+p1Dpec1UYmvqWLmxbHwJrA8bg
	 PwCvA0yZX7sSdXJJIBPVP9Fr8m9lfAmv0Z6BwyTPqlGzxSRcqKJbHg7SqAh6cUuDoX
	 rI5zL83uEtkh/V3uLY2ncDQQKsjTLkVGNEr/sVgeoNvEre0kRxST5gIyYSqR0TYp2r
	 PN348dRM8nPzA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fa9778fa2cso742456eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 13:34:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwc2RN2hyYyw1Vel/AskEyvh1U/m6X9NoBk0KllqDBjoEi2ed04zW5Fm1Fv5YzhrmoDZo8ADvTGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxHGNsxPDh0K/4VvgybsRJI8cT0NaFac1W6MdmqkeuocH8kpm
	FopkqRy08Ja75rngMQOsEYkizi+cNvVhHUP92Gtr2129KD8CBqkdr3AKtZ3qKd4MN9xFLMTbBzb
	aZ/4ZNexEeHwkW2KZ3haBMZX42Q8=
X-Google-Smtp-Source: AGHT+IFGKkJZQjPfM6H19DLTjIpGZ8DjDY/HqQk5NYv2OvLZQG2pk7Foqcjvj/jZ7fGrB2Hx2JxrjMOFsRvB5jlIJs4=
X-Received: by 2002:a05:6870:961c:b0:2ba:11dd:249d with SMTP id
 586e51a60fabf-2ba11dd27bemr2221364fac.24.1739482442311; Thu, 13 Feb 2025
 13:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213105840.2864654-1-xu.yang_2@nxp.com>
In-Reply-To: <20250213105840.2864654-1-xu.yang_2@nxp.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Feb 2025 22:33:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gGO95FvSVg1xrG+5B8rbDCXbVyfBm8jDgiKUXieTfVPA@mail.gmail.com>
X-Gm-Features: AWEUYZnD-ivCQUVM0FdYlS-XYLMJ_exTj_l0q9U2liHz2A94HkPIPUviOAaIHGE
Message-ID: <CAJZ5v0gGO95FvSVg1xrG+5B8rbDCXbVyfBm8jDgiKUXieTfVPA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: core: Clear is_prepared if no_pm_callbacks
 is true before checking power.syscore
To: Xu Yang <xu.yang_2@nxp.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, stern@rowland.harvard.edu, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 11:58=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Currently, if power.no_callbacks is true for a device, device_prepare()
> will also set power.direct_complete to true. When device_resume() check
> power.direct_complete, setting power.is_prepared will be skipped if it
> can directly complete. This will cause a warning when add new devices
> during resume() stage.
>
> Although power.is_prepared should be cleared in complete() state, commit
> (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to is_prepared) allow
> clear it in earlier resume() stage. However, we need also set is_prepared
> to false before checking syscore if the device has no pm callbacks.
>
> Take USB as example:
> The usb_interface is such a device which setting power.no_callbacks to
> true. Then if the user call usb_set_interface() during resume() stage,
> the kernel will print below warning since the system will create and
> add ep devices.
>
> [  186.461414] usb 1-1: reset high-speed USB device number 3 using ci_hdr=
c
> [  187.102681]  ep_81: PM: parent 1-1:1.1 should not be sleeping
> [  187.105010] PM: resume devices took 0.936 seconds
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>
> ---
> v2: clear is_prepared before check syscore as suggested by Rafael
> ---
>  drivers/base/power/main.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 40e1d8d8a589..5e69cfaec661 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -926,6 +926,9 @@ static void device_resume(struct device *dev, pm_mess=
age_t state, bool async)
>         TRACE_DEVICE(dev);
>         TRACE_RESUME(0);
>
> +       if (dev->power.no_pm_callbacks)
> +               dev->power.is_prepared =3D false;
> +
>         if (dev->power.syscore)
>                 goto Complete;
>
> --

As I've already said in the other thread, my initial feedback was
based on an oversimplified view of this code, and the problem will
need to be addressed differently.

Sorry about that.

