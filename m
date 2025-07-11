Return-Path: <linux-pm+bounces-30691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F00AB01E66
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97944A7F02
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45C2D97AF;
	Fri, 11 Jul 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XljhKiK6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FB210F53;
	Fri, 11 Jul 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242053; cv=none; b=PcPLcTTzPCa9fCw0uKV1Go+Axjv5fxfEU7vsVA8WtxxqCJDvgRGTn+IwEeTcZ8OOuLBpza87gL9Pn82bgWBdSxMTmGPHEbMaHKHyS5iyvSPQtiqViIWZtLixZj4Azys+eF+B4rPKopeYA09tJN3A6cSPR/WicHzug3/M0LiwSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242053; c=relaxed/simple;
	bh=BBU7ghguCAyJiiRPZdR2uiWNVY8X666q1wqwPfC8xAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rONk3dDv44hb2fOKdVMHtf8C98IaVvRo9Znar9iajdKYOiPqfeJZ34/PVIj041PofsTBf9j9iAhuf9vrtLDsteeHGKdTTZKG/bk6ZvjkydntXX9kHuihX/lWfDBrwrfTx2WuHNqIhlO2wcadV42OU0RE3Hl7lL65hflMyDoMFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XljhKiK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BAFC4AF09;
	Fri, 11 Jul 2025 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752242052;
	bh=BBU7ghguCAyJiiRPZdR2uiWNVY8X666q1wqwPfC8xAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XljhKiK6U5fag/L0cmG4rsXCqkzQZNfIpJxGfxIrJlsA8Af9z5TsyJROVbibGH1n1
	 3ir0HHQiKaeH4eTAsvyRR0x/phv4P5zblA3dNiL6qQUeH7JWbzOPDivSUq57jI7GcI
	 /Z5GyUzWbxSDp8EAKzXD+W0LNTqgrDAj63khWhqEXHKTNUn+B4KCsDvESEdoohMmrn
	 VOMlbqtxU45YNT9+VhydGNyU92G0XI+yRJQswTv6go5F/Ybj1n3IPjk74aNADBjLer
	 PZ25VFGVWdg57dBUywJ8HjEjCp3RmN1P4GVk7i+qG+EfSDrh0OK4M3AfzDIq1swqRK
	 4IhaJnHvuiEDQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-613aaa2cf43so1035120eaf.3;
        Fri, 11 Jul 2025 06:54:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ9Ol/PObhDfK3dymGRgfbvT5VKNsyTWBPwvHKooMS1wlp0DymYu37lcK6RH7LRqx5oaeKYnzJitNEXgM=@vger.kernel.org, AJvYcCXy+GQi5pUE+SYmzid4Cyn4GX6PaiH42zM6gf0qBHMgWlrhmJ7tOqhHzTrIjLQ0M7xEtQllCu/i1No=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvflQqSPT1DTeyDG4xyYj69VAYDKFYUz8hSyCfY4NPFMiZrWB
	UTevC74opeB+OWAAhiXfidh1SQoVU+cnfrD3qyJ8+uonnm/6Mobkz1yKjQgc/hMSELNUkKMas36
	p/XtXy0yd5Slg/smODc/6R6nE1DATvDw=
X-Google-Smtp-Source: AGHT+IHcbRx8zflYRK44B206ejqHvKHmceTOK6hhDtxpr315zHhIZ6i5cX09RLZ5Yuiix09dEGvoF1IPPJkkDNwZoYc=
X-Received: by 2002:a4a:edc3:0:b0:613:c16e:9bd9 with SMTP id
 006d021491bc7-613e6055771mr2388935eaf.6.1752242051967; Fri, 11 Jul 2025
 06:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org> <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Jul 2025 15:54:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
X-Gm-Features: Ac12FXyz3J2tiOmW_RNP9CqOsWSDmplRGWYB5Pd7mingf33KckjNNRFtcfz5AeE
Message-ID: <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>, 
	William McVicker <willmcvicker@google.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 3:38=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Jul 11, 2025 at 3:08=E2=80=AFPM Tudor Ambarus <tudor.ambarus@lina=
ro.org> wrote:
> >
> >
> > Hi, Rafael,
> >
> > On 3/14/25 12:50 PM, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > According to [1], the handling of device suspend and resume, and
> > > particularly the latter, involves unnecessary overhead related to
> > > starting new async work items for devices that cannot make progress
> > > right away because they have to wait for other devices.
> > >
> > > To reduce this problem in the resume path, use the observation that
> > > starting the async resume of the children of a device after resuming
> > > the parent is likely to produce less scheduling and memory management
> > > noise than starting it upfront while at the same time it should not
> > > increase the resume duration substantially.
> > >
> > > Accordingly, modify the code to start the async resume of the device'=
s
> > > children when the processing of the parent has been completed in each
> > > stage of device resume and only start async resume upfront for device=
s
> > > without parents.
> > >
> > > Also make it check if a given device can be resumed asynchronously
> > > before starting the synchronous resume of it in case it will have to
> > > wait for another that is already resuming asynchronously.
> > >
> > > In addition to making the async resume of devices more friendly to
> > > systems with relatively less computing resources, this change is also
> > > preliminary for analogous changes in the suspend path.
> > >
> > > On the systems where it has been tested, this change by itself does
> > > not affect the overall system resume duration in a measurable way.
> > >
> > > Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-sarav=
anak@google.com/ [1]
> > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > I'd like to let you know of a suspend crash that I'm dealing with
> > when using the OOT pixel6 drivers on top of v6.16-rc4.
>
> Well, thanks, but there's not much I can do about it.
>
> It is also better to start a new thread in such cases than to reply to
> a patch submission.
>
> > Similar to what Jon reported, everything gets back to normal if
> > I disable pm_async or if I revert the following patches:
> > 443046d1ad66 PM: sleep: Make suspend of devices more asynchronous
> > aa7a9275ab81 PM: sleep: Suspend async parents after suspending children
> > 0cbef962ce1f PM: sleep: Resume children after resuming the parent
> >
> > I also reverted their fixes when testing:
> > 8887abccf8aa PM: sleep: Add locking to dpm_async_resume_children()
> > d46c4c839c20 PM: sleep: Fix power.is_suspended cleanup for direct-compl=
ete devices
> > 079e8889ad13 PM: sleep: Fix list splicing in device suspend error paths
> >
> > It seems that the hang happens in dpm_suspend() at
> > async_synchronize_full() time after a driver fails to suspend.
> > The phone then naturally resets with an APC watchdog.
> >
> > [  519.142279][ T7917] lwis lwis-eeprom-m24c64x: Can't suspend because =
eeprom-m24c64x is in use!
> > [  519.143556][ T7917] lwis-i2c eeprom@2: PM: dpm_run_callback(): platf=
orm_pm_suspend returns -16
> > [  519.143872][ T7917] lwis-i2c eeprom@2: PM: platform_pm_suspend retur=
ned -16 after 1596 usecs
> > [  519.144197][ T7917] lwis-i2c eeprom@2: PM: failed to suspend: error =
-16
> > [  519.144448][ T7917] PM: tudor: dpm_suspend: after while loop, list_e=
mpty(&dpm_prepared_list)? 1
> > [  519.144779][ T7917] PM: tudor: dpm_suspend: before async_synchronize=
_full
> >
> > The extra prints are because of:
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index d9d4fc58bc5a..3efe538c2ec2 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1967,10 +1967,15 @@ int dpm_suspend(pm_message_t state)
> >                         break;
> >                 }
> >         }
> > +       pr_err("tudor: %s: after while loop, list_empty(&dpm_prepared_l=
ist)? %d\n",
> > +              __func__, list_empty(&dpm_prepared_list));
> >
> >         mutex_unlock(&dpm_list_mtx);
> >
> > +       pr_err("tudor: %s: before async_synchronize_full\n", __func__);
> >         async_synchronize_full();
> > +       pr_err("tudor: %s: after async_synchronize_full();\n", __func__=
);
> > +
> >         if (!error)
> >                 error =3D async_error;
> >
> > The synchronous suspend works because its strict, one-by-one ordering
> > ensures that device dependencies are met and that no device is suspende=
d
> > while another is still using it. The asynchronous suspend fails because
> > it creates a race condition where the lwis-eeprom-m24c64x is called for
> > suspension before the process using it has been suspended, leading to a
> > fatal "device busy" error. Should the failure of a device suspend be
> > fatal?
>
> It shouldn't in principle, but it depends on what exactly is involved and=
 how.
>
> It looks like something is blocking on power.completion somewhere.
> I'll check the code, maybe a complete() is missing in an error path or
> similar.

It doesn't look like anything is missing in the core, so the suspend
failure seems to be triggering a deadlock of some sort.

The remedy should be the same as usual in such cases: Find the device
that is marked as "async" incorrectly and make it "sync".

Thanks!

