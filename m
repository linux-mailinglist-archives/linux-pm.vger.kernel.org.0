Return-Path: <linux-pm+bounces-37320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C44DC2E00A
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 21:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E39E1894702
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183629D27F;
	Mon,  3 Nov 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTAjsdbb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87229AAF7
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200578; cv=none; b=JBQN8/dK4qJTmWtqjITsXvdLr7JAYN8uTAcDRV/ij7O4g2fm8qifipTq/r8v0U7FZeOY8JcUupSU0dSYAMPAC7LU7uFEIjfN0U/1QeCT3N9Ore+/D5pAFdmegBaqsLeDHveCbNyFtuJAvqbRRuDfrtgItt3D53gdfUsyK+oQnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200578; c=relaxed/simple;
	bh=oaRZmfFMKL6+SPCVhh6hkk7N+IiGpHtQNsDtpxFD1uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQnTFtOquMiyxM73TC+WrkyONA/bf9ep/RoZb+iFMN4Jv7peqdGoiHnHXlhz4PpTDgKy6OjlduBfFn2ywP0F0HwRPgIWXL+NY5FW0XQCISQpBJDafLpkzUN9irCLO4wgEtPgRZlmj8n6OCMWR7FgK3/5FxoDe+rOaU09Bxs79Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTAjsdbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC73C4AF09
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 20:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762200577;
	bh=oaRZmfFMKL6+SPCVhh6hkk7N+IiGpHtQNsDtpxFD1uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KTAjsdbbKeKZiK0H3EnH/5YITwWqUJNXMDJeDzoIAlofjmAdWLNPqqcG7vKRfD570
	 nsiwC16Uq7okoApeAq6cJMjI4CgKKv5HUBLUA4PUj/WgV1TN6ZiqGmGGBhT9DR9A3z
	 7OpyUd4e1pSC+ggs1WUSFcIy64fwDzm896mBh+1jzvIYJClVsVwo3QpqQwPGpYPG4G
	 R4aEZy+HEFfUaL7gdi75agh+ArLu2i9s+9ipeUhklCp16MqIhVleuUbS5MGMZ65+eO
	 susdeNJV0qfWhCA0sdjJGZvlJtJfyBcGx2LXkYwQxn4PhhoElhz9KzSdxnyg+ZgAjW
	 +Tpd+03vXvSbA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4439ecf6004so3616098b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 12:09:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrmJSJP962IZL+M8rXUm37EGHHBNl3oSu9nG6qGS7DiTV6zaibQrdvDcwFMBQ/dhRINoxBjmxe3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhbWqsTLQEgLoxzWg322oYUl0JXSCJIuNK2arwbcM2F70nZaTU
	R+m/PhITGNILOamVhFLqpHXTqqC60QAnoRRF4vu83Oduy09heAZi8fyW/u11dvGgJC4+cDYSZkP
	JtyRnSonJTX9e7B7upsOZcEyR29n0nzU=
X-Google-Smtp-Source: AGHT+IF+xjBmK1e1Hm7NYeA/5t6Jo1JKsIrxkw4mGzCE6i4w9LqUCGe2VoP9x0Rqin8tHF2QI+AlMJ9+aymtRMzj6sE=
X-Received: by 2002:a05:6808:50a9:b0:44d:b997:d82c with SMTP id
 5614622812f47-44fdbfcc8bcmr357233b6e.18.1762200577146; Mon, 03 Nov 2025
 12:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026050905.764203-1-superm1@kernel.org> <20251026050905.764203-5-superm1@kernel.org>
In-Reply-To: <20251026050905.764203-5-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 21:09:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hXR5wb5chsqT1Vu5i5ucneeGpbRDEU9TPVxZVCAfuiow@mail.gmail.com>
X-Gm-Features: AWmQ_bnLo68AwsBkeTbZXdr1s26v2XElYjbbdn0dEZuatcIMcgzUIPjHjEb-CuI
Message-ID: <CAJZ5v0hXR5wb5chsqT1Vu5i5ucneeGpbRDEU9TPVxZVCAfuiow@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] USB: Pass PMSG_POWEROFF event to suspend_common()
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Eric Naim <dnaim@cachyos.org>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:09=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> suspend_common() passes a PM message indicating what type of event
> is occurring.  PMSG_POWEROFF is intended to be used when hibernate
> callbacks were utilized for turning off the system.
>
> Add a new callback hcd_pci_poweroff() which will
> determine if target state is power off and pass PMSG_POWEROFF as the
> message.
>
> suspend_common() doesn't do any special handling with this case at
> the moment, so there are no functional changes in this patch.
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v9:
>  * Reword commit message (Bjorn)
> v8:
>  * Drop SYSTEM_HALT case
> v7:
>  * Reword commit mesasge
> v6:
>  * Fix LKP robot issue without CONFIG_PM_SLEEP
> v5:
>  * New patch
> v4:
>  * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@ker=
nel.org/
> ---
>  drivers/usb/core/hcd-pci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index cd223475917ef..959baccfb07d1 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -6,6 +6,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pm.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
>
> @@ -531,6 +532,13 @@ static int hcd_pci_freeze(struct device *dev)
>         return suspend_common(dev, PMSG_FREEZE);
>  }
>
> +static int hcd_pci_poweroff(struct device *dev)
> +{
> +       if (system_state =3D=3D SYSTEM_POWER_OFF)
> +               return suspend_common(dev, PMSG_POWEROFF);
> +       return suspend_common(dev, PMSG_SUSPEND);
> +}
> +
>  static int hcd_pci_suspend_noirq(struct device *dev)
>  {
>         struct pci_dev          *pci_dev =3D to_pci_dev(dev);
> @@ -602,6 +610,7 @@ static int hcd_pci_restore(struct device *dev)
>  #define hcd_pci_suspend                NULL
>  #define hcd_pci_freeze                 NULL
>  #define hcd_pci_suspend_noirq  NULL
> +#define hcd_pci_poweroff       NULL
>  #define hcd_pci_poweroff_late  NULL
>  #define hcd_pci_resume_noirq   NULL
>  #define hcd_pci_resume         NULL
> @@ -639,7 +648,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops =3D {
>         .freeze_noirq   =3D check_root_hub_suspended,
>         .thaw_noirq     =3D NULL,
>         .thaw           =3D hcd_pci_resume,
> -       .poweroff       =3D hcd_pci_suspend,
> +       .poweroff       =3D hcd_pci_poweroff,
>         .poweroff_late  =3D hcd_pci_poweroff_late,
>         .poweroff_noirq =3D hcd_pci_suspend_noirq,
>         .restore_noirq  =3D hcd_pci_resume_noirq,
> --

I would defer this patch until you know what exactly suspend_common()
will do for PMSG_POWEROFF because it may just be simpler to check
system_state =3D=3D SYSTEM_POWER_OFF in it internally.

