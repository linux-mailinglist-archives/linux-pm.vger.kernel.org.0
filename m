Return-Path: <linux-pm+bounces-10023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D89179B1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 09:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08B52870E5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA61598E9;
	Wed, 26 Jun 2024 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVkKvZVF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A622645978;
	Wed, 26 Jun 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386987; cv=none; b=sEttuC1US5+DIBRuu+hbyxE9nTX0Yp4MZ0BQr/DqMqgZ+YjseJh3Fu8yfKkP9TE3o73hFQ5MY6n0fL1onECiXmFJn76/8Ue148prMELHP4tnAq5KkZyQNckSBojlq7us86SYt02eCkRe6gsHfpEw0uHRnSZ6w1lClTPXeEjqr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386987; c=relaxed/simple;
	bh=btPQt6h4XwprAHYKvRyqIyBal4wkclf3SJRV4OeaJKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0SwtZnIZi3pHypgCD+88+K9HbR0MY920E+ldoRtncwyngOuHzA7JQJ7/pwOxQCZ8zCzl/06cCBfaow3Eszgh1yBKFDsFBqzjI16G3lLybDK2oXdXmSMvKhUn8j/I2KHptBppkcA8trRhLSLGUpAMbiKu7gwHBmGBfuoxm9sB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVkKvZVF; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so7489027a12.3;
        Wed, 26 Jun 2024 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719386984; x=1719991784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvsLfYrxWOLYQugRQzs49q155HgDaGdoFenRxpUZgAs=;
        b=BVkKvZVFmpIIYLgGMSkjF7OuJfsplR3QUTyCNxfNpYU/ah4w+PDVgTDcdyKTU8NQAk
         WSOCgkW+IulpiIMoEqyrDf7oBjVVUXCzv/YsK6QMcFXT+dXhSUoNO9THr6ywnrzn1akA
         YCe4pI//KhTlvhO0/nHRX4nGaXy6TSQRu46QSG4iHAj3+I0qRlBCN8awTB5zQ/kUmlse
         qDzBEaxELx2oSC1IMefmOpqWyKt9xU6UQ0vFNR1zOdQ/6CY/Xq1QZMIRQ/evXiDQBIvc
         ArPP8fq/HSOSgrOyIPGBCi3ynleuw3PVg+gfikPBcYCypXO97E3Iat9gJjjzmxFbiEUa
         5b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719386984; x=1719991784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvsLfYrxWOLYQugRQzs49q155HgDaGdoFenRxpUZgAs=;
        b=mOADmEgJZ+rI4OMG7SNzzs5UCbq72Q2JzeSdROcLwgGU0VxTz2CRPkU2kGjPev3KnB
         NzpmRND+UR9CGg0YBJ5rRVhIiF0pptj5/hqQ9f2lbqHJFvQ/+06JO3BM0rE4kBUkgwHV
         WYBkMBsJEgRCc/qvVF2LnUnLCyPi9DnXAIvjcEjZtPnHHpxaIdST3L79+5bypNWD+tDB
         /7ZsmHQAfXC/evOqQkmInn3L1ep+kgFtzixkGM23F6cicp8p9l8cVRBJo9/zqlCuTyOX
         whJUW0V/eolWtrSwMMmM4XDpMmt/uehMX6PfVIunKtoYbPsVXdRTAKzGabhdbE/xwcuw
         XovA==
X-Forwarded-Encrypted: i=1; AJvYcCVICZa+0e6ZUug8EBU9jTZenGDqmPV7zxCjPlXc80IxTiocW/B9yC56xYjEBtJiqEXG1HQ0vJzF9KCm+Ax6ySDOd3ewc4r1k5hdY1pUuJoa9xXPsgC1tc861gUM39w8ej1Eg2phIJo=
X-Gm-Message-State: AOJu0Yx+gvyBGLPL3qxzP9R1bdQBaDsuEErF7k0gIATAGYL+Z/uUD9cu
	tQ8/ubYmHaoeL0bB3Uxbh2K0B2awT27D9prkvivJSAc62QxQ4t76uy7whK//3INYDP0MVdQ3Ts0
	L7rXW4Vb83aRZjhkL68/74IEhdKQ=
X-Google-Smtp-Source: AGHT+IGuTpoA0mcypNBslKf6qwgEHhL6gvANk+W+gmPwXKESWU0iyT3xhAEY0exEl6rRiF0piHwaElmvhXTznngSSu0=
X-Received: by 2002:a50:a6d9:0:b0:579:e6ff:c61f with SMTP id
 4fb4d7f45d1cf-57d4bd79eb6mr7551629a12.25.1719386983674; Wed, 26 Jun 2024
 00:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622-fix-help-issue-v2-1-6c19e28a4ec1@gmail.com> <0a5ab4c0-e397-4dda-92f8-a23bcb42765c@linuxfoundation.org>
In-Reply-To: <0a5ab4c0-e397-4dda-92f8-a23bcb42765c@linuxfoundation.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Wed, 26 Jun 2024 09:29:31 +0200
Message-ID: <CALsPMBMUAEwFOSfkjrd2Os+6YKunrAnkNHrJ6eU3DOvaE6BrsQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpupower: Make help command available for custom
 install dir
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:29=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/22/24 07:01, Roman Storozhenko wrote:
> > When the 'cpupower' utility installed in the custom dir, it fails to
> > render appropriate help info for a particular subcommand:
> > $ LD_LIBRARY_PATH=3Dlib64/ bin/cpupower help monitor
> > with error message like 'No manual entry for cpupower-monitor.1'
> > The issue is that under the hood it calls 'exec' function with
> > the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> > path is defined in '/etc/manpath.config'. Of course it contains only
> > standard system man paths.
> > Make subcommands help available for a user by setting up 'MANPATH'
> > environment variable to the custom installation man pages dir. That
> > variable value will be prepended to the man pages standard search paths
> > as described in 'SEARCH PATH' section of MANPATH(5).
> >
> > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > ---
> > Changes in v2:
> > - Fixed spelling errors
> > - Simplified man pages search approach by the 'MANPATH' variable usage
> > - Link to v1: https://lore.kernel.org/r/20240621-fix-help-issue-v1-1-79=
06998d46eb@gmail.com
> > ---
> >   tools/power/cpupower/utils/cpupower.c | 41 ++++++++++++++++++++++++++=
++++-----
> >   1 file changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupow=
er/utils/cpupower.c
> > index 9ec973165af1..1b1b79c572ad 100644
> > --- a/tools/power/cpupower/utils/cpupower.c
> > +++ b/tools/power/cpupower/utils/cpupower.c
> > @@ -12,6 +12,8 @@
> >   #include <unistd.h>
> >   #include <errno.h>
> >   #include <sched.h>
> > +#include <libgen.h>
> > +#include <limits.h>
> >   #include <sys/types.h>
> >   #include <sys/stat.h>
> >   #include <sys/utsname.h>
> > @@ -80,14 +82,17 @@ static void print_help(void)
> >
> >   static int print_man_page(const char *subpage)
> >   {
> > -     int len;
> > -     char *page;
> > +     char *page, *man_path, *exec_dir;
> > +     char exec_path[PATH_MAX];
> > +     int subpage_len;
> >
> > -     len =3D 10; /* enough for "cpupower-" */
> > -     if (subpage !=3D NULL)
> > -             len +=3D strlen(subpage);
> > +     if (!subpage)
> > +             return -EINVAL;
> >
> > -     page =3D malloc(len);
> > +     subpage_len =3D 10; /* enough for "cpupower-" */
> > +     subpage_len +=3D strlen(subpage);
> > +
> > +     page =3D malloc(subpage_len);
> >       if (!page)
> >               return -ENOMEM;
> >
> > @@ -97,6 +102,30 @@ static int print_man_page(const char *subpage)
> >               strcat(page, subpage);
> >       }
> >
> > +     /* Get current process image name full path */
> > +     if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
>
> Using /proc/self/exe is Linux and platform specific and not a
> good solution. Did you loom into using argv[0]?

Yes, it is not the best solution. I would rather prefer to have a portable,
POSIX-based one. But after exploring possible options I came to the
conclusion that unfortunately such a solution doesn't exist.
According to C11 language standard:
"If the value of argc is greater than zero, the string pointed to by argv[0=
]
represents the program name;....".
Notice - program name, not the absolute path to the program. The actual
value of argv is under control of the calling environment.
You could look at the nice discussion of the topic for example here:
https://www.reddit.com/r/C_Programming/comments/dgcmhd/exactly_how_reliable=
_is_argv0_at_being_the/
Besides - this utility is a part of the Linux Kernel source tree and theref=
ore
has no requirement of the portability to another OSes.

>
> thanks,
> -- Shuah



--=20
Kind regards,
Roman Storozhenko

