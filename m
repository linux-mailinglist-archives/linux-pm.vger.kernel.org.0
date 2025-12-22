Return-Path: <linux-pm+bounces-39784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623BCD6D54
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A8D30365A6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10233BBA8;
	Mon, 22 Dec 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XNkYCQOz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385333AD87
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766424387; cv=none; b=P13iB8+vr0MMcc5SoTs7uif7pkjm8610q8FOj4hAWAjO6ynZqN54c6948I6OjTrdlg8pWXVC5Gqy+8JXZckHtyh67ZG9saXEh0EXjJKOCQNJk/Z2JMy2BXLDyH7YTmIWF7/6jPs9Pd7VpYgHYNqQHOcDTZ8pHTeZOE6cj2c3b0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766424387; c=relaxed/simple;
	bh=OMHHcBrunLTAqrONlLcoGvei/dPQg1xIVNEoe6PRSCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Red5by99Yk2kxy59+KLyZphot5Wk7RXhuvQTNTW/Biqg7uzYizKykKTPClogE0vS4EOqT3LPGUecW8bHzD1HyB2fK5hA1Ss+IgsXiGpwVJsh2tiigBwtDpZqwCOFHXFb76U9W0SlwwHmAJrFBIattqf8yRZV7npf+l52gVxwi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XNkYCQOz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5957db5bdedso4824913e87.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1766424383; x=1767029183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaDcd5KsdnsvFsY11kNpZaauB3pAQDiUFi0UpOQzbhI=;
        b=XNkYCQOzaAMjo7ceogJAePGsKHnQEHjhnhS4rdEcjV/TffyilFYToPzdhZMzUBtegz
         UNGlXggLfNDnllynjCZ1sjMPm0jxBQ4foWuOULkPJ7sza8e+ricmgNnFipakpvOT+H7t
         +xANBKzGwZHgsMGKmVpYfFjJEUAIZudpnrr9xISbMk8bBt45Tx67+dh39syr3KxBzz+y
         MRedrovjvtYKfkLTi5GDgTMwAs9njBA2AvMBVYYnFVl/S+T2laIDiI0fewgxCtiAGx3c
         SEhkF6yHumu212t1H2DiproatsWPGmPdOjCKPweFrx7ptKCdqfzzxs2awYr2DBC4Dh2U
         xHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766424383; x=1767029183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NaDcd5KsdnsvFsY11kNpZaauB3pAQDiUFi0UpOQzbhI=;
        b=oIVYD6OenLlMHDXC1n6DLz7Z9KJz2YD9mtO5IcnDLUupUOl5sIe6xAhjRPrNMWLYyx
         kdlxAzC/QEVuqlPvtW7lsnmMk8WnAn8O9P4AqXRP7/xLO4KFc6TXIbi81QRVhGsuURbS
         z/h9SGyPgdSX2R/ZolLGcCx3sxWexESd+bTfD+oD/bVQic5tvDcKUKmB9vmkWYu+gb+u
         F3rypbIWqobCLFdDb/qXK3Q3eCu8HnYIa/MvnpOZWNwn1jVMpNb9oLJ3AgC2/183c486
         zLj1rVSsvNyitB3yNH0qVDaObIvvRU7GURaalcNtjn420ukrOE2IFz5bEBYasCBT4PNd
         srZg==
X-Forwarded-Encrypted: i=1; AJvYcCXqmexB3X67MuQ6U78v/pKPZ5BxSEUBJfvwzT0P2/R1iXlAPRp97O/MGmKmZYqdv8ZLcHoSx+BVKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4bOXOzh19n5AOKPDCQcLUkZwmMCRnc8gFOMaDBCHm1oILMBLD
	9WdMcl7WH4sgkeA755o2TIA/AST6XDz4hgF7SaScxgHx29I2yqMHbGNyv6StxhQWY1qMmQ+ZfwP
	WEZPmOxUkF5J7QiHviEm7WIXQ4GwHW2+Iljjb0+Y7PQ==
X-Gm-Gg: AY/fxX7W5Un7D5szFESgqVSL+62KSJN/6oHjdZOTqASTagxsWI2S6RuOx6Qyxe2q0EP
	6dFGjqEwFuNJqH0bUG0348vG4bIygJHzlqOWkcHmzQwMDdEPT1TIlaRp7kj5TYVB1iayhddGUst
	G74N4gcvExOP+/CDyuq647NWjqGnFmsiFzChfrNbEVeWXZCL76uqqP7vbXrGru359riBjt3q0Qm
	QVI80tcOxrYgFN4NrVQC2EJa6hvVql4yEbv/B+ebERn4+TJV9KJPv+AhS5MzTj5soj+1tQdw/xY
	4KjCb+m2lanMNDilCDzosNV9eHfh4rJlJzqGFw==
X-Google-Smtp-Source: AGHT+IHHrUjioE+4oGxrI2RZEOyG2V4gz0UD1pM+souTBtkWhlOrJEwpjpsg0kUgeSqCWXF/vwVFEgr3FOA2uN43Vw8=
X-Received: by 2002:a05:6512:3e16:b0:598:eecb:c7ef with SMTP id
 2adb3069b0e04-59a17d5ddc0mr3918851e87.26.1766424382502; Mon, 22 Dec 2025
 09:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-next-15nov_expose_sysfs-v21-0-244614135fd8@oss.qualcomm.com>
 <20251222-next-15nov_expose_sysfs-v21-2-244614135fd8@oss.qualcomm.com>
In-Reply-To: <20251222-next-15nov_expose_sysfs-v21-2-244614135fd8@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Dec 2025 18:26:10 +0100
X-Gm-Features: AQt7F2qw7k825VeBGH-gxAXeuuEKzY6BBYGjMxRWjHkHXafUFF3NWVKxl_TZNI0
Message-ID: <CAMRc=MeBiHcYd_3p9k=QOc5zxC930W6=aaD4Jbh9zhMWjwZ=bA@mail.gmail.com>
Subject: Re: [PATCH v21 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <bgolasze@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:33=E2=80=AFAM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> Currently, there is no standardized mechanism for userspace to discover
> which reboot-modes are supported on a given platform. This limitation
> forces tools and scripts to rely on hardcoded assumptions about the
> supported reboot-modes.
>
> Create a class 'reboot-mode' and a device under it to expose a sysfs
> interface to show the available reboot mode arguments to userspace. Use
> the driver_name field of the struct reboot_mode_driver to create the
> device.  For device-based drivers, configure the device driver name as
> driver_name.
>
> This results in the creation of:
>   /sys/class/reboot-mode/<driver>/reboot_modes
>
> This read-only sysfs file will exposes the list of supported reboot
> modes arguments provided by the driver, enabling userspace to query the
> list of arguments.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

[snip]

> +
>  static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reb=
oot,
>                                           const char *cmd)
>  {
> @@ -76,6 +109,15 @@ int reboot_mode_register(struct reboot_mode_driver *r=
eboot)
>         size_t len =3D strlen(PREFIX);
>         int ret;
>
> +       reboot->reboot_mode_device =3D device_create(&reboot_mode_class, =
NULL, 0,
> +                                                  (void *)reboot, reboot=
->driver_name);

You should define a separate struct in this file and pass it as
drvdata as argument 4. The main reason for using device_create() was
to not have to store any data associated with the sysfs ABI in a
separate struct, not in the public one.

> +       if (IS_ERR(reboot->reboot_mode_device)) {
> +               ret =3D PTR_ERR(reboot->reboot_mode_device);
> +               reboot->reboot_mode_device =3D NULL;
> +               return ret;
> +       }
> +
> +       mutex_init(&reboot->reboot_mode_mutex);

Add a corresponding mutex_destroy() please.

[snip]

> +
>  MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
>  MODULE_DESCRIPTION("System reboot mode core library");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..d7141a1a609b62bd3185642ec=
c1478fdd3555037 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -2,9 +2,15 @@
>  #ifndef __REBOOT_MODE_H__
>  #define __REBOOT_MODE_H__
>
> +#include <linux/mutex.h>
> +
>  struct reboot_mode_driver {
>         struct device *dev;
>         struct list_head head;
> +       const char *driver_name;

I have no idea why you're storing the name here.

As I said above: you should not need to modify this structure (if
maybe for the mutex if modifications of this struct from existing code
can race with the sysfs code). Use a separate one for sysfs data.

> +       struct device *reboot_mode_device;

I think you misunderstood my comment about the renaming: what I meant
was: propose to rename the existing reboot_mode_driver structure to
reboot_mode_device because this is what it is in reality.

> +       /* protects reboot_mode list */
> +       struct mutex reboot_mode_mutex;
>         int (*write)(struct reboot_mode_driver *reboot, unsigned int magi=
c);
>         struct notifier_block reboot_notifier;
>  };
>
> --
> 2.34.1
>

Bart

