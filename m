Return-Path: <linux-pm+bounces-18527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EC9E39C5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E64285F98
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16E1B5ED0;
	Wed,  4 Dec 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv1N7JLk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CDF1B415E;
	Wed,  4 Dec 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314932; cv=none; b=T9aPrGx7lkiAFzhyxzx3Gsp8YrCDqN94ImOhEZBPiD0L5sAZsxuAtpxnI7leWhzAdmKkP9IwL18YTPl/XiBaLs3wBccErOhUIpMUw4ojVSjy39HerS4D9pn7a6jga8OZ6RrzStvQofaeffQbKlW0PdKsNXVxEe8g8n9P2RTraa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314932; c=relaxed/simple;
	bh=tjr1M7MkQ0S2HPXGlwpING1TuiC6eFQWfJLpc6ksvG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8FlMGKKbWn05nblZueKt+YmUxXJ933/JxE1LrgzHq0gUDL217tHYnQqVYtJGPAIJb+OikkYoEE4j2TCj0uyEUwVB11N3/TqtnH0yP1APa+uDqkKtRXcF2qfOSV9gSj5NXHXXFe2X/XBguC9hwSk2hKjUljKUZHisjjagGzmskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv1N7JLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44EDC4CEE2;
	Wed,  4 Dec 2024 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733314931;
	bh=tjr1M7MkQ0S2HPXGlwpING1TuiC6eFQWfJLpc6ksvG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iv1N7JLk1vqTGr0DsJB/X/R0S+Latl5026ItxHYFjH9X6WH4fE9ldhyVMPSu72cF8
	 QVYdjWoOupeUOMbn1C4Mu/gNqku/imioPex3qhr2vYmKCWwHCHqleAxkt83B9lYlgJ
	 MjEZbapCbE8xpzMwo+2Lx/Jr8qDMc/H1YPkeUdQI1byc4KOCLZG7AwEMVfAjaWQhxd
	 bFspyR5JP5lqmA9bukcewmSlLy2UnPeXgKjRsOQiY5kJ+2Zbkw5rdvjvhWg/FKp/zh
	 6guO30I7JpuvXz5aMu/fqhotKV1TPzzyp6jry2hTJwlzK2HiV7BjScNABiyjqrl3pD
	 nlYcoAsksy7NA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2689e7a941fso3411423fac.3;
        Wed, 04 Dec 2024 04:22:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2/J3lK+d/Koj7PULk9ycIdGdEExNkQ+AgA6QxmgBtPlLmWMlTmEM6NH9uJF6mUG9QnVwj4hW/ogJgbd8=@vger.kernel.org, AJvYcCU3zUnFqO6dPTA4RAG755MYQuAqyar9ViyzkZMYtbWbfqhBqG13okeqHN77zPPCQVW3140lfP0MAfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/lDsrnTxenrWQZC+rVQ4SDCuWX0KhAHvuq0hw/mFTuSETxR8
	bfzqbwKa9HGenmIH3cOoTsPKoetj9jMT27vzFpiAsmyZ05XavHzkjujj+/hYG4eK5AcShN6XOlY
	GI3jit7bwG4dXIIMWM+oJqPNC5oM=
X-Google-Smtp-Source: AGHT+IERIngqodiQUKumdns0sgwYfBGFnnGJz/Q7vcS7j43S3kf6FXOgyEPZgrNo2Zav3OpogvXLOI35ZnvKullWCIc=
X-Received: by 2002:a05:6871:150:b0:29e:719b:7837 with SMTP id
 586e51a60fabf-29e88664fdbmr3978287fac.13.1733314931192; Wed, 04 Dec 2024
 04:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-3-saravanak@google.com> <CAJZ5v0jPO24JR5um0gv5U5AwiR_RHx37x6DisG-nUxaZt9gfGA@mail.gmail.com>
 <CAJZ5v0iLq9L5nMp13BrBmbWavFs1ZEAtJ-WeyRzv3D2GXPNuag@mail.gmail.com>
 <CAGETcx-9XSdXcuGQFSoS-mMPwp=UJ3_FfTJ1Cx+9jddyjYTKEg@mail.gmail.com>
 <CAJZ5v0iWCWdjP9Gku2uV0Qz-Hp6ZEHDspaPVzHPPzHfvyREeWA@mail.gmail.com> <CAGETcx_5oRA-kTzU7WtWSV2=Bp0cKcT=2kPa0+ZkwkHTA+rwOQ@mail.gmail.com>
In-Reply-To: <CAGETcx_5oRA-kTzU7WtWSV2=Bp0cKcT=2kPa0+ZkwkHTA+rwOQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Dec 2024 13:21:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g9A1pZ5FjPAjdLY5ybNmefnBVVMJM7h3czW38p1fTfqQ@mail.gmail.com>
Message-ID: <CAJZ5v0g9A1pZ5FjPAjdLY5ybNmefnBVVMJM7h3czW38p1fTfqQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PM: sleep: Remove unnecessary mutex lock when
 waiting on parent
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 12:28=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Mon, Dec 2, 2024 at 1:15=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Mon, Dec 2, 2024 at 9:46=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> > >
> > > On Mon, Dec 2, 2024 at 12:16=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Mon, Dec 2, 2024 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
> > > > >
> > > > > Sorry for the delay.
> > > > >
> > > > > On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravan=
ak@google.com> wrote:
> > > > > >
> > > > > > Locking is not needed to do get_device(dev->parent). We either =
get a NULL
> > > > > > (if the parent was cleared) or the actual parent. Also, when a =
device is
> > > > > > deleted (device_del()) and removed from the dpm_list, its compl=
etion
> > > > > > variable is also complete_all()-ed. So, we don't have to worry =
about
> > > > > > waiting indefinitely on a deleted parent device.
> > > > >
> > > > > The device_pm_initialized(dev) check before get_device(dev->paren=
t)
> > > > > doesn't make sense without the locking and that's the whole point=
 of
> > > > > it.
> > > >
> > > > Hmm, not really.
> > > >
> > > > How is the parent prevented from going away in get_device() right
> > > > after the initial dev check without the locking?
> > >
> > > Not sure what you mean by "go away"? But get_device() is going to kee=
p
> > > a non-zero refcount on the parent so that struct doesn't get freed.
> >
> > That's after it has returned.
> >
> > There is nothing to prevent dev from being freed in get_device()
> > itself before the kobject_get(&dev->kobj) call.
> >
> > So when get_device() is called, there needs to be an active ref on the
> > device already or something else to prevent the target device object
> > from being freed.
> >
> > In this particular case it is the lock along with the
> > device_pm_initialized(dev) check on the child.
>
> Ugh... my head hurts whenever I think about get_device(). Yeah, I
> think you are right.
>
> Hmm... I wanted to have this function be replaced by a call to a
> generic helper function dpm_for_each_superior() in the next patch. But
> that helper function could be called from places where the dpm_list
> lock is held. Also, I was planning on making it even more generic (not
> specific to dpm) in the future. So, depending on dpm_list lock didn't
> make sense.
>
> Any other ideas on how I could do this without grabbing the dpm_list mute=
x?

You don't need to replace the existing function with a new helper.

Just add the helper, use it going forward and drop the old function in
a separate patch when there are no more users of it.

> Actually, with the rewrite and at the end of this series, we don't
> have to worry about this race because each device's suspend/resume is
> only started after all the dependencies are done. So, if the parent
> deletes a child and itself, the child device's suspend wouldn't have
> been triggered at all.
>
> So, another option is to just squash the series and call it a day.

No, no.  This is complicated enough and the code is super-sensitive.

I think that you need to split the changes even more.

> Or add a comment to the commit text that this adds a race that's fixed by
> the time we get to the end of the series.

That would create a bisection trap, so not really.

