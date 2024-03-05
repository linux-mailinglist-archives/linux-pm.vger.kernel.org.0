Return-Path: <linux-pm+bounces-4684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F77A872054
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B871F23691
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93AC85C7B;
	Tue,  5 Mar 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AyWl/pU1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ADB5821B
	for <linux-pm@vger.kernel.org>; Tue,  5 Mar 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645815; cv=none; b=jM8uFqDTYlSm9oCoI1IL9sPMyqxxm06vRONbTKD+Q9+MfEQtJFM94COFcfQ1utZ5oionmLIrEmOju5e9Z9JQc0H4XE6bC+2YbKUkxB6Ms/QJj6wThhtxUKW1soGk4rC2yIBe+Lcz7rk6Ue9lOlCZKOkTYEq5JkiFpMuqO5iwj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645815; c=relaxed/simple;
	bh=nQfK6V2xWgqSLI9E0BBwgQAFWw3SBgmC1BgXmzftNdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaLwYxm60rzZJxUEOINITZ8Lr+hR9fIxnJIzWciT9nV6cl+YRqsbODmFfkqzfewbWNQ2dMlF8WASKA9B1DY9EzSYWebQ0mV2beuQin4Fdp8xbcsG9Nkn1eWgzFdmP1fzgRasCJQJNDxYrjAdea29XMtVZYGAjHqt5JeAHMIXf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AyWl/pU1; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 68F7A41192
	for <linux-pm@vger.kernel.org>; Tue,  5 Mar 2024 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709645809;
	bh=0402VVh+GEeRN2UVZuJPSy+RAbWSxhwA40pSMz4rtJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=AyWl/pU1w2FgKtAJXHaV3E39wJu3X/crmMsukfFa76BVcFurwG78B+ItnZWnjGUUJ
	 Rg9fEnYC0PokG9mP8IXXVD6ghJ5EfgUC6bcC33ZJvTkCC6A1eb2oHcVtDfkY/o1KGj
	 OWXjZB+1yawCu2KhWF6CkKDZ7GocNLT6c3r2H2rxUoiLsr9/2wlN8aFJWFLWhrMtNW
	 LAYb93N3yF0iqkPg8L6oOJf6mrxL5lhl0h5t3LXH1/MKYDmjSP22T8iqPGQWLNAjbI
	 YR/PS5FCYGjGPNXbvPzTPGpu3Y/Xuk3EC5UR7kut3tsJy8dvZeVqKmgD/86e4a8X9/
	 w8aCy/lVXtHHg==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c670f70a37so5688635a12.2
        for <linux-pm@vger.kernel.org>; Tue, 05 Mar 2024 05:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645808; x=1710250608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0402VVh+GEeRN2UVZuJPSy+RAbWSxhwA40pSMz4rtJQ=;
        b=KaeF59b6JQhO7vBIvQ8D7xthuOfT9ElA+IpjKw92BEq0HJnheoXQWbMfnorJ4UEPGm
         R8rCSjw1rkWRYsxfS4y69IsBkxJ6WNAWCmfoykEmOirHhMxsLr9DAhKFOo8o6ogXAUVN
         Q6ufsqZQVxHd/OlGF+nZzzENzaaG8esIG4e3fOw5rRhf7mYAyKn2FNEhkPvpTSauXuZv
         1BRKsejEruCTHMoO2YyCoTmiCBfAhghyNvRu94yfDURKHcVPQG/yfsIZoeNqu1msvMfu
         lb3ksobprxTa/yN6i+Ucu3Mgn6xVy95bSD9Mz8/TTwZUyNRs8k3TBZPDglAQigxEEPHL
         NuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW85t7d+3QKn5s4s5xwpuynV3pzI0LxG418qyXITeEAGTm0PvBpYcDM0gJTkV5B1sBG0FzJfhogOgwZisSj6NTqhFFkU5i8AeA=
X-Gm-Message-State: AOJu0YxItVx4wv3jWu2wHBYNL+IDdr52jTct3rMr3D/jPmM6YYy2z2OR
	Lbw0dW8EGsB9c+WYWcx5FjoLmemSMyPz0h+y5kN6NTQbtSIsq3lGuuJkTD765bQxOEFcEU+M2dA
	vGgprsrjG1MtcYK2o/a0OAVzQ0tGp8459wc/XogqEbFx7+8kgQ6dznPxiN6BZaKU8VMfm4WExqn
	sLVlBRRmUCggeA/I74oklmhRIOczrxFUJKdfmC1p9w++n306o=
X-Received: by 2002:a05:6a20:af87:b0:1a1:4487:ee25 with SMTP id ds7-20020a056a20af8700b001a14487ee25mr1501417pzb.49.1709645808124;
        Tue, 05 Mar 2024 05:36:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOP//ufniFPMkZx0twz+0xxIGTYOpse5o4+VGR1RjmYtquYB3hCwcIfz/sDtZDINGIz76nhkwZK3Ux85NQF40=
X-Received: by 2002:a05:6a20:af87:b0:1a1:4487:ee25 with SMTP id
 ds7-20020a056a20af8700b001a14487ee25mr1501407pzb.49.1709645807855; Tue, 05
 Mar 2024 05:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5761426.DvuYhMxLoT@kreacher>
In-Reply-To: <5761426.DvuYhMxLoT@kreacher>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 5 Mar 2024 21:36:36 +0800
Message-ID: <CAAd53p774TjJkdtRxxUo8b--LvznTBMgGPdpA=yjGxu8eBgmKw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: PCI: Drain runtime-idle callbacks before
 driver removal
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ricky Wu <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 6:45=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> A race condition between the .runtime_idle() callback and the .remove()
> callback in the rtsx_pcr PCI driver leads to a kernel crash due to an
> unhandled page fault [1].
>
> The problem is that rtsx_pci_runtime_idle() is not expected to be
> running after pm_runtime_get_sync() has been called, but the latter
> doesn't really guarantee that.  It only guarantees that the suspend
> and resume callbacks will not be running when it returns.
>
> However, if a .runtime_idle() callback is already running when
> pm_runtime_get_sync() is called, the latter will notice that the
> runtime PM status of the device is RPM_ACTIVE and it will return right
> away without waiting for the former to complete.  In fact, it cannot
> wait for .runtime_idle() to complete because it may be called from that
> callback (it arguably does not make much sense to do that, but it is not
> strictly prohibited).
>
> Thus in general, whoever is providing a .runtime_idle() callback, they
> need to protect it from running in parallel with whatever code runs
> after pm_runtime_get_sync().  [Note that .runtime_idle() will not start
> after pm_runtime_get_sync() has returned, but it may continue running
> then if it has started earlier already.]
>
> One way to address that race condition is to call pm_runtime_barrier()
> after pm_runtime_get_sync() (not before it, because a nonzero value of
> the runtime PM usage counter is necessary to prevent runtime PM
> callbacks from being invoked) to wait for the runtime-idle callback to
> complete should it be running at that point.  A suitable place for
> doing that is in pci_device_remove() which calls pm_runtime_get_sync()
> before removing the driver, so it may as well call pm_runtime_barrier()
> subsequently, which will prevent the race in question from occurring,
> not just in the rtsx_pcr driver, but in any PCI drivers providing
> runtime-idle callbacks.
>
> Link: https://lore.kernel.org/lkml/20240229062201.49500-1-kai.heng.feng@c=
anonical.com/ # [1]
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Ricky Wu <ricky_wu@realtek.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the debugging and patch.
Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/pci/pci-driver.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> Index: linux-pm/drivers/pci/pci-driver.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -473,6 +473,13 @@ static void pci_device_remove(struct dev
>
>         if (drv->remove) {
>                 pm_runtime_get_sync(dev);
> +               /*
> +                * If the driver provides a .runtime_idle() callback and =
it has
> +                * started to run already, it may continue to run in para=
llel
> +                * with the code below, so wait until all of the runtime =
PM
> +                * activity has completed.
> +                */
> +               pm_runtime_barrier(dev);
>                 drv->remove(pci_dev);
>                 pm_runtime_put_noidle(dev);
>         }
>
>
>

