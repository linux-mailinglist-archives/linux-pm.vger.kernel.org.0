Return-Path: <linux-pm+bounces-40746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D7DD19AC5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 16:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D69BB30124D9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0602D7DE2;
	Tue, 13 Jan 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHWsIAxy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340372D73AD
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316389; cv=none; b=sxNDwSySuE9VTLTSChxddW5XuuHQUgph4Ye39t0Tl7DX8rjZFgGtRf8pk1K3vvN0eD6m5OoSoub0+oNihvez3V+HnpyJrWHIFF8fRiVyHDIGa03MnGaVFCol1voWzMduSTICMYZaQt/mJLsKYiiuSKfBJZfQGyUOBaXU3rnA3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316389; c=relaxed/simple;
	bh=tQadruJtxmTbpXQwTK9LfM1gAaIAvYJ7hwO3+2qDwKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWTNVun19le0eeS2R3EZW0ljR95w30Ha8/v1kPYfb1thOQtypuT1q8rOoTkJyub3jALXj4ORbPDtVudwbrxN/qOb968h7LrbCjN7eLd226iOhMGRY3J8NxDvm6SlDb/xDqkbq/ZZIadNhaoql/L9XLhYJkrWQLiZfF2sV4d/4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHWsIAxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE22C2BC87
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768316388;
	bh=tQadruJtxmTbpXQwTK9LfM1gAaIAvYJ7hwO3+2qDwKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PHWsIAxyxOfbmJicN6UnT/sD3VAMyEEV7GbJNBx9MoC9DvfLdwHPgmoOvngifkAg1
	 FpfQv3GlCsCq4GbGfGiF7G0h46YlV1aId46JMX6qHmYE/mTP4ATNGZhYgQFTXkx48X
	 4SGTeuWYh35KmKxEu6QGSyPAPnGEOkVhNOZFf002PgRKK/c5JKlnjjBkY5mRCna81M
	 /SiyO1/PD9HHfzsJW/DtSpjinrHUZewwnu9pvhQC2dOB2fOiWXvTVWsG58/cgcZCTj
	 ZNqMC8k0v4Ii2+VvtYXK9SSzpVdz7RRVDFcG3KxHPx4YqrYx8VtUsFqAU4dPdCfLwp
	 8ywGTH6s4hKIQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b685d2b79so7368831e87.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 06:59:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdluK4N1fcdSO4Pr6gYObCgBCnTfn9jerBz0AKoZAYkca0NwH5eGB4RgFQwGWx2pl6YFPRSlRS/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBGfG3/8IDbA0rPbITYm540mSkLHMKdSfiBub1cX7ICyf8NQQ
	URalDnjMayRS24RMXy71TrxkxDlT6yOy2TO4sfsimZFyK+LqJ+TBxjThplC9BSSobwnNIU9PK4+
	qSQcGDEjF3Vf2onWOyJm9Z8kQ9EbdpuqEiGDj9opvBA==
X-Google-Smtp-Source: AGHT+IHoAkGe0e3qdUlYSk0a+ywNjp7vVj+8KXkbYwW12DVf5qs2c3LuhktveDflBx3nm/JLFmrM67710bfXAlbaMrs=
X-Received: by 2002:a05:6512:1593:b0:59b:7311:b261 with SMTP id
 2adb3069b0e04-59b7311b469mr7215517e87.3.1768316387451; Tue, 13 Jan 2026
 06:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227-next-15nov_expose_sysfs-v22-0-2d153438ba19@oss.qualcomm.com>
 <20251227-next-15nov_expose_sysfs-v22-2-2d153438ba19@oss.qualcomm.com>
 <CAMRc=MewoxcijL_OYi=LwWMJmYCSsYFQ2j+koOF5b2_w8VyGsg@mail.gmail.com> <ee0c4a7b-e3d1-1816-d5b3-e53ec3cf2e8f@oss.qualcomm.com>
In-Reply-To: <ee0c4a7b-e3d1-1816-d5b3-e53ec3cf2e8f@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 13 Jan 2026 15:59:34 +0100
X-Gmail-Original-Message-ID: <CAMRc=MedMkQTGYzSFeiCovKTb_3Mpy8sOa66usQxtu+yi46-2g@mail.gmail.com>
X-Gm-Features: AZwV_QhXj_Fm3OeEdkdOlVokkUjWWgob1WLfiq5N2joWXWmXf-Q3ErgwLdMcQlo
Message-ID: <CAMRc=MedMkQTGYzSFeiCovKTb_3Mpy8sOa66usQxtu+yi46-2g@mail.gmail.com>
Subject: Re: [PATCH v22 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
	Bartosz Golaszewski <bgolasze@quicinc.com>, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:45=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
>
>
> On 1/2/2026 6:55 PM, Bartosz Golaszewski wrote:
> > On Fri, 26 Dec 2025 19:56:34 +0100, Shivendra Pratap
> > <shivendra.pratap@oss.qualcomm.com> said:
> >> Currently, there is no standardized mechanism for userspace to discove=
r
> >> which reboot-modes are supported on a given platform. This limitation
> >> forces tools and scripts to rely on hardcoded assumptions about the
> >> supported reboot-modes.
>

Sorry for the delayed response.

> [SNIP..]
>
> >>
> >> +struct sysfs_data {
> >
> > Let's make this more descriptive? struct reboot_mode_sysfs_data?
>
> Ack. thanks.
>
> >
> >> +    const char *mode;
> >> +    struct list_head list;
> >> +};
> >> +
>
> [SNIP..]
>
> >> +
> >> +    reboot->reboot_mode_device =3D device_create(&reboot_mode_class, =
NULL, 0,
> >> +                                               (void *)head, reboot->=
dev->driver->name);
> >
> > No, why pass the list? You should create an instance of struct sysfs_da=
ta per
> > device_create(). If it needs to contain a list, then let it contain a l=
ist but
> > don't allocate the list_head, that's really unusual.
> >
>
> ok. Will create struct reboot_mode_sysfs_data with a list head and
> allocate it as data.
>
> >> +
>
> [SNIP..]
>
> >>
> >> +static inline void reboot_mode_unregister_device(struct reboot_mode_d=
river *reboot)
> >> +{
> >> +    struct sysfs_data *sysfs_info;
> >> +    struct sysfs_data *next;
> >> +    struct list_head *head;
> >> +
> >> +    head =3D dev_get_drvdata(reboot->reboot_mode_device);
> >> +    device_unregister(reboot->reboot_mode_device);
> >> +    reboot->reboot_mode_device =3D NULL;
> >> +
> >> +    if (head) {
> >> +            list_for_each_entry_safe(sysfs_info, next, head, list) {
> >> +                    list_del(&sysfs_info->list);
> >> +                    kfree_const(sysfs_info->mode);
> >> +                    kfree(sysfs_info);
> >> +            }
> >
> > This loop is duplicated, can you please factor it out into a dedicated
> > function?
>
> The loop frees the sysfs data. You mean i should directly call
> reboot_mode_unregister_device in error path of reboot_mode_create_device
> as not to duplicate the loop?
>

I was thinking about wrapping it in a dedicated function and calling
it here and in the error path in reboot_mode_create_device().

> >
>
> [SNIP..]
>
> >> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> >> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b56783c32068096325f924=
45b9530d1856c4826c 100644
> >> --- a/include/linux/reboot-mode.h
> >> +++ b/include/linux/reboot-mode.h
> >> @@ -5,6 +5,7 @@
> >>  struct reboot_mode_driver {
> >>      struct device *dev;
> >>      struct list_head head;
> >> +    struct device *reboot_mode_device;
> >
> > Why can't this be part of struct (reboot_mode_)sysfs_data?
> >
>
> If reboot_mode_device is kept in sysfs_data, we need a reference to free
> it. Should I maintain reference for it in "reboot struct" and store
> sysfs_data pointer, so that it can be used to call device_unregister()?
>
> Eg:
> struct reboot
> {
> ..
> ..
>   void *priv;
> };
>
> struct reboot_mode_sysfs_data {
>     struct device *reboot_mode_device;
>     struct list_head head;
> };
>

You can use class_find_device(). Store the address of the associated
reboot_mode_driver in the private structure and compare by it in the
match callback.

Bart

