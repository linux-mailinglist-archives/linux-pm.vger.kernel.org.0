Return-Path: <linux-pm+bounces-30725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6D5B029DB
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 09:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19DA3AFD7B
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 07:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0827221F37;
	Sat, 12 Jul 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP0Ih0Lw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948A2AE74;
	Sat, 12 Jul 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752307080; cv=none; b=YrB6vO8KcOm2cjAchWgZe9mkfMt1P6PgJRS6rLnbiPKpzy2yCnR+F3CLPKVKLMfoy5HR5NWaBqOaLBEWXB32tErSybn+azS5R83yeBviCjn4mkDnyehGLcl+q61r4AKQE9b7/0rR5ZooJySa+exVLHMW0UlxfOedRZIwhTSkgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752307080; c=relaxed/simple;
	bh=RkwjRV3ZuwYqmLrwJVkdApmu6rtG/Vwknf3/AowWYCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjVYfRyA9zyX7N0fij/T8iojGpVdItoBA0yYa9fbhgSHP6hOwFb0wxWyu/1lU73n2Lo6E8b3/bK2BmjD4W10QB9BtofsCJMWw13pZvB4oqLzYXfpOkg/uqzNj2Le+0Bzu6acokwrGgpyMV+FW0WjvytTkW/J0Qr67r6fV7zrWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP0Ih0Lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1020C4CEF8;
	Sat, 12 Jul 2025 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752307080;
	bh=RkwjRV3ZuwYqmLrwJVkdApmu6rtG/Vwknf3/AowWYCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sP0Ih0LwWu/bw0ieQ7Lbf/OHTF6GiDNiy4MfIOJOg1CfaXECKKJtj3A6I7o2GyI6w
	 PYQsmX+3J1W3bCPNT94ntlQjNLT8RTH2v7F5+GPx0Gg86aD5IjWukDVrk/CyLA1fTU
	 W/SQXveGNm2xQYFQ6v3tqT15tPy2UVVNa65qoIr6wQpDoYscZnWu1ORxknexDWQyv+
	 Ckecnq9kj8tgdkMCbejaf6DFlIxi/PARzdGgkGQK6aj2wUMUzvNioGWkbu2Tymiu+2
	 q5T+bBjs6cGPkqK7f/boywdQ0sBkVUicwPVcNQhQElBOur3VusFLjuwXX56tHrLO8u
	 HM6aoR4OhlVOg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-611f48c6e30so1486344eaf.0;
        Sat, 12 Jul 2025 00:58:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQw8+5x94G0VjgHCxpwdB/NcFEk38WqlZK1WHjUCBzevI/v/YH/qQGw0BZ5hOfo+jS41ddpyXAfy0=@vger.kernel.org, AJvYcCXpqyRt29HefKqQYhFajyp8eTSEf8hoQotSwhQ72yb7oeQYJI7+Pqp/iHOQgXej/01pXErXozltBuTeVGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyP8E1D4CsTH4WmQHMtWle4zbugdfD0h9fPINm26pLm1kG1c+i
	oyqtN8X9VhWOo7HjkyF/uAS2bnUgErNasYmKu8HJt1ze3Pza1ABphrXHI/VzCm/ks3Cv9XuS2CY
	SdStAEv4Kw5Tht0CNVoD4B9HrFGYXZJs=
X-Google-Smtp-Source: AGHT+IFPgw8XXZks8oL7hKr7Dh5+G1Ho3hLVMjrDUy4CpVUbuxMJBqaXzqul/Tay6YpQrmAB005zmRflK7NUy/ZpWvo=
X-Received: by 2002:a4a:ee87:0:b0:611:a81d:bdf1 with SMTP id
 006d021491bc7-613e5ffdd10mr4386651eaf.6.1752307079704; Sat, 12 Jul 2025
 00:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org> <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
 <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com> <CAGETcx98iQqA_EOWjkFCkgtrt0JppMQE98OTuCXj2zZa2S1yPA@mail.gmail.com>
In-Reply-To: <CAGETcx98iQqA_EOWjkFCkgtrt0JppMQE98OTuCXj2zZa2S1yPA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 12 Jul 2025 09:57:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0isThmYP3-h0-Bm=jP5HighpLR8=LLLf3Es-PxsnHb9gg@mail.gmail.com>
X-Gm-Features: Ac12FXy5LFyBFQEVJUMidbaqRIJKt2QAHZqoAUVEHSGgPnFeiS8n5E2ilScD3ro
Message-ID: <CAJZ5v0isThmYP3-h0-Bm=jP5HighpLR8=LLLf3Es-PxsnHb9gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, William McVicker <willmcvicker@google.com>, 
	Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:30=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Fri, Jul 11, 2025 at 6:54=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Jul 11, 2025 at 3:38=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 3:08=E2=80=AFPM Tudor Ambarus <tudor.ambarus@=
linaro.org> wrote:
> > > >
> > > >
> > > > Hi, Rafael,
> > > >
> > > > On 3/14/25 12:50 PM, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > According to [1], the handling of device suspend and resume, and
> > > > > particularly the latter, involves unnecessary overhead related to
> > > > > starting new async work items for devices that cannot make progre=
ss
> > > > > right away because they have to wait for other devices.
> > > > >
> > > > > To reduce this problem in the resume path, use the observation th=
at
> > > > > starting the async resume of the children of a device after resum=
ing
> > > > > the parent is likely to produce less scheduling and memory manage=
ment
> > > > > noise than starting it upfront while at the same time it should n=
ot
> > > > > increase the resume duration substantially.
> > > > >
> > > > > Accordingly, modify the code to start the async resume of the dev=
ice's
> > > > > children when the processing of the parent has been completed in =
each
> > > > > stage of device resume and only start async resume upfront for de=
vices
> > > > > without parents.
> > > > >
> > > > > Also make it check if a given device can be resumed asynchronousl=
y
> > > > > before starting the synchronous resume of it in case it will have=
 to
> > > > > wait for another that is already resuming asynchronously.
> > > > >
> > > > > In addition to making the async resume of devices more friendly t=
o
> > > > > systems with relatively less computing resources, this change is =
also
> > > > > preliminary for analogous changes in the suspend path.
> > > > >
> > > > > On the systems where it has been tested, this change by itself do=
es
> > > > > not affect the overall system resume duration in a measurable way=
.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-s=
aravanak@google.com/ [1]
> > > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > I'd like to let you know of a suspend crash that I'm dealing with
> > > > when using the OOT pixel6 drivers on top of v6.16-rc4.
> > >
> > > Well, thanks, but there's not much I can do about it.
> > >
> > > It is also better to start a new thread in such cases than to reply t=
o
> > > a patch submission.
> > >
> > > > Similar to what Jon reported, everything gets back to normal if
> > > > I disable pm_async or if I revert the following patches:
> > > > 443046d1ad66 PM: sleep: Make suspend of devices more asynchronous
> > > > aa7a9275ab81 PM: sleep: Suspend async parents after suspending chil=
dren
> > > > 0cbef962ce1f PM: sleep: Resume children after resuming the parent
> > > >
> > > > I also reverted their fixes when testing:
> > > > 8887abccf8aa PM: sleep: Add locking to dpm_async_resume_children()
> > > > d46c4c839c20 PM: sleep: Fix power.is_suspended cleanup for direct-c=
omplete devices
> > > > 079e8889ad13 PM: sleep: Fix list splicing in device suspend error p=
aths
> > > >
> > > > It seems that the hang happens in dpm_suspend() at
> > > > async_synchronize_full() time after a driver fails to suspend.
> > > > The phone then naturally resets with an APC watchdog.
> > > >
> > > > [  519.142279][ T7917] lwis lwis-eeprom-m24c64x: Can't suspend beca=
use eeprom-m24c64x is in use!
> > > > [  519.143556][ T7917] lwis-i2c eeprom@2: PM: dpm_run_callback(): p=
latform_pm_suspend returns -16
> > > > [  519.143872][ T7917] lwis-i2c eeprom@2: PM: platform_pm_suspend r=
eturned -16 after 1596 usecs
> > > > [  519.144197][ T7917] lwis-i2c eeprom@2: PM: failed to suspend: er=
ror -16
> > > > [  519.144448][ T7917] PM: tudor: dpm_suspend: after while loop, li=
st_empty(&dpm_prepared_list)? 1
> > > > [  519.144779][ T7917] PM: tudor: dpm_suspend: before async_synchro=
nize_full
> > > >
> > > > The extra prints are because of:
> > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > > index d9d4fc58bc5a..3efe538c2ec2 100644
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -1967,10 +1967,15 @@ int dpm_suspend(pm_message_t state)
> > > >                         break;
> > > >                 }
> > > >         }
> > > > +       pr_err("tudor: %s: after while loop, list_empty(&dpm_prepar=
ed_list)? %d\n",
> > > > +              __func__, list_empty(&dpm_prepared_list));
> > > >
> > > >         mutex_unlock(&dpm_list_mtx);
> > > >
> > > > +       pr_err("tudor: %s: before async_synchronize_full\n", __func=
__);
> > > >         async_synchronize_full();
> > > > +       pr_err("tudor: %s: after async_synchronize_full();\n", __fu=
nc__);
> > > > +
> > > >         if (!error)
> > > >                 error =3D async_error;
> > > >
> > > > The synchronous suspend works because its strict, one-by-one orderi=
ng
> > > > ensures that device dependencies are met and that no device is susp=
ended
> > > > while another is still using it. The asynchronous suspend fails bec=
ause
> > > > it creates a race condition where the lwis-eeprom-m24c64x is called=
 for
> > > > suspension before the process using it has been suspended, leading =
to a
> > > > fatal "device busy" error. Should the failure of a device suspend b=
e
> > > > fatal?
> > >
> > > It shouldn't in principle, but it depends on what exactly is involved=
 and how.
> > >
> > > It looks like something is blocking on power.completion somewhere.
> > > I'll check the code, maybe a complete() is missing in an error path o=
r
> > > similar.
> >
> > It doesn't look like anything is missing in the core, so the suspend
> > failure seems to be triggering a deadlock of some sort.
> >
> > The remedy should be the same as usual in such cases: Find the device
> > that is marked as "async" incorrectly and make it "sync".
> >
>
> I'm very behind on this thread, but the patches I sent out were well
> tested on Pixel 6 OOT drivers and didn't cause any issues. So I think
> the rewrite is missing some condition my patches accounted for.

This is kind of simple: Your patches eliminated the waiting on
power.completion, so it would not cause the processing to block.

