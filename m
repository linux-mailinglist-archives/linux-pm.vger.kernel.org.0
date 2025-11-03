Return-Path: <linux-pm+bounces-37322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D94C2E0CE
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 21:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6593BC79F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A62C0290;
	Mon,  3 Nov 2025 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ZNbBgS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBD2BF015
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202303; cv=none; b=LxMuHYweQXEmMS+IJyr9Yl3g98w/VQ+YXNjnHot98h1FXIMKFgpjeNXvS59hhfu9jGy3WxNLvYSt1OVrPctPRlBsjJXQ28N/36DFOY9Wf+nPittce3RCWZRZOSB65HwUKnRaUwchusM4HfNoH4XEm06QmIbgI1f+HWqcDn1okNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202303; c=relaxed/simple;
	bh=ixbbKT/7jqNzUp3sJiQZjwNrkqcxk+Z2mOz6dmayOHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pePZLMIKu7AoKZa29MemXJ4ZU2APqxahTnHsvWoV3muSlkkC3GT5kR7xs397RMbLbKsTno8E2IeZJp9JH/rE2CWnmuRJ5LRB/UN3g7jiaaEI4rijXJ3QhYcmil9fRp0KUGFVoyvlg66wellXDswM13J5HrJ5eIXbdi3KtDU/Y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+ZNbBgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E75C19425
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 20:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762202303;
	bh=ixbbKT/7jqNzUp3sJiQZjwNrkqcxk+Z2mOz6dmayOHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l+ZNbBgSXx5aDZFRoc9b5owIKB7nwcCnLzZpf2Tr5xIStNtAtwSviif+8y8gjxA/q
	 zGOEYMCDeNemPauW5Y1nBiWw2GGvcvBMYehVNr1cfFVpN5ErhRW1UGBv9JEsepnysG
	 0lgVLDmZJ3BNUurgnHimUzJpDzZMkeBCp2lEhL9z8Iw2wg0Q7uL0iMK1GJr6YGIEqx
	 c6sPprFXpr9+4vHUonR34doW7juV3ZZPS/qDDTas0mjl0sqiWXFtAhKJ/7t5vDNCur
	 7jhPd82BJJiRh68G/t7vsvas09CEtjYPsU1t4ZyGn7yttZKhS8sWggBpXemxz+B9eE
	 gJXckVQ1iL7Ig==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65681b64384so2577069eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 12:38:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPydiZE1aqRSoEQxkYri728Ivd0dOnHn/UjjbgnLEoc3GD2i2zU+c7I0RM87t97MlNhjpZAEGUnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4krLlizt6IBrYcoxATeVHf9ahN2eh1acsd/ch5M/o00kdNcOn
	HK1CioH8kZ+17aMCGxj3pFl8dXQWSGc9H5Z02ztWbZPR5ZUjLx3JHI8KTxkt0Vmo7i+5FFXnGUO
	6Jty032x9qzVFUzzqgzdLRkscvwaTz7M=
X-Google-Smtp-Source: AGHT+IFrdJTnVd9pdPPOBL58HjDw/lTNVI1R1ajOYhQDDMukScMp485ggihIVn1/BiIBlZMX7crGxhCf9XNFtvOYS64=
X-Received: by 2002:a4a:ee0e:0:b0:651:ce89:27b8 with SMTP id
 006d021491bc7-6568a00e5d5mr6457806eaf.0.1762202302577; Mon, 03 Nov 2025
 12:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026050905.764203-1-superm1@kernel.org> <20251026050905.764203-5-superm1@kernel.org>
 <CAJZ5v0hXR5wb5chsqT1Vu5i5ucneeGpbRDEU9TPVxZVCAfuiow@mail.gmail.com> <06cd1b43-e765-4597-9f61-5058c8a13425@kernel.org>
In-Reply-To: <06cd1b43-e765-4597-9f61-5058c8a13425@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 21:38:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iH4rvRPB5XVgTKV-9aKimYOM5NkjskCTUX31eyoB0_eQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkYnk_805y71jbTKIR5ivNrzQaf6fI4vWybP9d6lc31RvZY0gwuRQxXpTY
Message-ID: <CAJZ5v0iH4rvRPB5XVgTKV-9aKimYOM5NkjskCTUX31eyoB0_eQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] USB: Pass PMSG_POWEROFF event to suspend_common()
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Mon, Nov 3, 2025 at 9:10=E2=80=AFPM Mario Limonciello (AMD) (kernel.org)
<superm1@kernel.org> wrote:
>
>
>
> On 11/3/2025 2:09 PM, Rafael J. Wysocki wrote:
> > On Sun, Oct 26, 2025 at 6:09=E2=80=AFAM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> suspend_common() passes a PM message indicating what type of event
> >> is occurring.  PMSG_POWEROFF is intended to be used when hibernate
> >> callbacks were utilized for turning off the system.
> >>
> >> Add a new callback hcd_pci_poweroff() which will
> >> determine if target state is power off and pass PMSG_POWEROFF as the
> >> message.
> >>
> >> suspend_common() doesn't do any special handling with this case at
> >> the moment, so there are no functional changes in this patch.
> >>
> >> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >> ---
> >> v9:
> >>   * Reword commit message (Bjorn)
> >> v8:
> >>   * Drop SYSTEM_HALT case
> >> v7:
> >>   * Reword commit mesasge
> >> v6:
> >>   * Fix LKP robot issue without CONFIG_PM_SLEEP
> >> v5:
> >>   * New patch
> >> v4:
> >>   * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1=
@kernel.org/
> >> ---
> >>   drivers/usb/core/hcd-pci.c | 11 ++++++++++-
> >>   1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> >> index cd223475917ef..959baccfb07d1 100644
> >> --- a/drivers/usb/core/hcd-pci.c
> >> +++ b/drivers/usb/core/hcd-pci.c
> >> @@ -6,6 +6,7 @@
> >>   #include <linux/kernel.h>
> >>   #include <linux/module.h>
> >>   #include <linux/pci.h>
> >> +#include <linux/pm.h>
> >>   #include <linux/usb.h>
> >>   #include <linux/usb/hcd.h>
> >>
> >> @@ -531,6 +532,13 @@ static int hcd_pci_freeze(struct device *dev)
> >>          return suspend_common(dev, PMSG_FREEZE);
> >>   }
> >>
> >> +static int hcd_pci_poweroff(struct device *dev)
> >> +{
> >> +       if (system_state =3D=3D SYSTEM_POWER_OFF)
> >> +               return suspend_common(dev, PMSG_POWEROFF);
> >> +       return suspend_common(dev, PMSG_SUSPEND);
> >> +}
> >> +
> >>   static int hcd_pci_suspend_noirq(struct device *dev)
> >>   {
> >>          struct pci_dev          *pci_dev =3D to_pci_dev(dev);
> >> @@ -602,6 +610,7 @@ static int hcd_pci_restore(struct device *dev)
> >>   #define hcd_pci_suspend                NULL
> >>   #define hcd_pci_freeze                 NULL
> >>   #define hcd_pci_suspend_noirq  NULL
> >> +#define hcd_pci_poweroff       NULL
> >>   #define hcd_pci_poweroff_late  NULL
> >>   #define hcd_pci_resume_noirq   NULL
> >>   #define hcd_pci_resume         NULL
> >> @@ -639,7 +648,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops =3D {
> >>          .freeze_noirq   =3D check_root_hub_suspended,
> >>          .thaw_noirq     =3D NULL,
> >>          .thaw           =3D hcd_pci_resume,
> >> -       .poweroff       =3D hcd_pci_suspend,
> >> +       .poweroff       =3D hcd_pci_poweroff,
> >>          .poweroff_late  =3D hcd_pci_poweroff_late,
> >>          .poweroff_noirq =3D hcd_pci_suspend_noirq,
> >>          .restore_noirq  =3D hcd_pci_resume_noirq,
> >> --
> >
> > I would defer this patch until you know what exactly suspend_common()
> > will do for PMSG_POWEROFF because it may just be simpler to check
> > system_state =3D=3D SYSTEM_POWER_OFF in it internally.
>
> OK - in that case would you just take the first 3 for 6.19?

I still need to go through them once again, but overall that's the plan.

