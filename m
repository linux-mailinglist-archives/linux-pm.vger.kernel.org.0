Return-Path: <linux-pm+bounces-10073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D2918EBA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95ECA1F23318
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5D191474;
	Wed, 26 Jun 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOQiKKQg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876319068A;
	Wed, 26 Jun 2024 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427400; cv=none; b=ofVoaM8KQ6GfhcpCLxsOhfGTnroigdZ8Jj881C3rprvDaCajuSrtop12cjeda9/FEjDZ2zKWd5szy0kN/wJyRP8UKdFd0ZmejLYlcYTK/LtOIACBiB0VdcC8s52vwOPT34MzFrMPxTpGxrVgyI50LllLfSD6ooqkkg7AKoYpSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427400; c=relaxed/simple;
	bh=zxJ/trqs037LOC82Wzr9oSEimFRNgDHJpVcrhf6ECCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vuh60sp3TEZ/NzHWwy3f39d6LF4B4tpRNfHPqf933zyg07Kiah8JUj1pAX71ylta0EDKlGxPKlyP84FU04ZVWrSLEsNLtDpGfnNai6vTv314IzMGc3W8TYZYXeYaS2fNYTYK08mX5Cs1LwTWeVCVU9p8sQzpdgZjAfjWB9kkN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOQiKKQg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so781334a12.1;
        Wed, 26 Jun 2024 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719427397; x=1720032197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtTWCWeJx7mnAovFW0ao59h67JeXpvr8VNu5M9/gMfM=;
        b=mOQiKKQgZAoZnfCC7u7SVUWZ/zm7X4BiZ7bcGIqqkEnnpHmu9FOtywH55UklRCmzLa
         XuKB5m1weo4wEyH5C0+fUAYTG/b7TKRyjLwNPySNhgvjaQyrUPknM1qdzumhtHVs6QqH
         D/5iv1mxsWH+DH9HSwDjxqq3Ua/6YbvsyxQpaKwYAMKIhZy0Sb13wg5wbLpGQSSq9eYF
         OB1CgT1DuG+Ziu1hR4QW6n759XEV6re33uqyrIWqhP4/aWAZ/YPLK+fq5MWuI5QMEcaT
         /0ht/1rHCTJSdSUd02ETqNsVv9NhCWArrhA9sL7/SQcAvNVh9SLaWoxUUAYPWH3UX4c3
         4OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719427397; x=1720032197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtTWCWeJx7mnAovFW0ao59h67JeXpvr8VNu5M9/gMfM=;
        b=UbuSdHAGK0RlC6s8M/oAldntRn3dJfXOfmJGXQWey1Kp7j58I6f3ArPXNAVD8EaUKm
         mND12kNveGrM65XNT9lQMn0eJoYnIO/l7fPhEeFRQilhYWq9jR9uSmoZirjvKRtqPJWa
         +Q5UWTL51y762hkVLPAeMlyYIODSvTN8oXKiUXUEbo2GpkD426o2cTcWqq0Wh9H+Drs6
         OOa2lZxtxb8gl1yDHRnvqoiYWXyTU415o+q6hZQ14lTepodiK0bpseGgtT/f00gp1AC3
         ezOIrL7YK1OmGMHHiUqHEJYITE3T2qDqzbefzIuNZHLjHqGsp0x1SidPu2aqIwa6I30r
         EzsA==
X-Forwarded-Encrypted: i=1; AJvYcCXWY6Dn/blt1KQ+QWCfaIXfh29WihNPD7FeWrimAs+JDcFeK/qtE8W7EhF/rSMsleJxL91pfdcHP7pB5xdNGccOVUrBRFp4gcM1wRwDYJKgrB1xuXr9sR4tJm/yFBBSmXsGqwhB+iQ=
X-Gm-Message-State: AOJu0YwmrvTDaw8x5gqAy7Z/u1DWtWuBs90cbsVLIIDz+aWXy9xeLYS0
	ojd1omfHcXsgvQoYsPpoJICnGQwA1EzjtZ0KQqsSGsj+Y/ETg97M2CEJS/gbEIygaV3xp3HJz3H
	edJXTYg5vTsteN5LL3Ptp0v0gXmU=
X-Google-Smtp-Source: AGHT+IEyGkzYLAyIxCwvniZn0T3nkuwfkViX9XfjWuopWGxrEQx6INc8ek8qH2V8Bj/x3OW2VI7lb1fxMLLhqCjbOQw=
X-Received: by 2002:a50:bac3:0:b0:57c:9c5d:d18e with SMTP id
 4fb4d7f45d1cf-57d4bdd02b0mr10882508a12.36.1719427396512; Wed, 26 Jun 2024
 11:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622-fix-help-issue-v2-1-6c19e28a4ec1@gmail.com>
 <0a5ab4c0-e397-4dda-92f8-a23bcb42765c@linuxfoundation.org>
 <CALsPMBMUAEwFOSfkjrd2Os+6YKunrAnkNHrJ6eU3DOvaE6BrsQ@mail.gmail.com> <7ea62dd3-723b-4691-a0e6-c4bea07db532@linuxfoundation.org>
In-Reply-To: <7ea62dd3-723b-4691-a0e6-c4bea07db532@linuxfoundation.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Wed, 26 Jun 2024 20:43:04 +0200
Message-ID: <CALsPMBOuzzoW4Va9RhgTpTzz3t3kOYN8pKKU5dpiLGbXQOJjxg@mail.gmail.com>
Subject: Re: [PATCH v2] cpupower: Make help command available for custom
 install dir
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 5:36=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/26/24 01:29, Roman Storozhenko wrote:
> > On Tue, Jun 25, 2024 at 9:29=E2=80=AFPM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >>
> >> On 6/22/24 07:01, Roman Storozhenko wrote:
> >>> When the 'cpupower' utility installed in the custom dir, it fails to
> >>> render appropriate help info for a particular subcommand:
> >>> $ LD_LIBRARY_PATH=3Dlib64/ bin/cpupower help monitor
> >>> with error message like 'No manual entry for cpupower-monitor.1'
> >>> The issue is that under the hood it calls 'exec' function with
> >>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> >>> path is defined in '/etc/manpath.config'. Of course it contains only
> >>> standard system man paths.
> >>> Make subcommands help available for a user by setting up 'MANPATH'
> >>> environment variable to the custom installation man pages dir. That
> >>> variable value will be prepended to the man pages standard search pat=
hs
> >>> as described in 'SEARCH PATH' section of MANPATH(5).
> >>>
> >>> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>> - Fixed spelling errors
> >>> - Simplified man pages search approach by the 'MANPATH' variable usag=
e
> >>> - Link to v1: https://lore.kernel.org/r/20240621-fix-help-issue-v1-1-=
7906998d46eb@gmail.com
> >>> ---
> >>>    tools/power/cpupower/utils/cpupower.c | 41 +++++++++++++++++++++++=
+++++++-----
> >>>    1 file changed, 35 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpup=
ower/utils/cpupower.c
> >>> index 9ec973165af1..1b1b79c572ad 100644
> >>> --- a/tools/power/cpupower/utils/cpupower.c
> >>> +++ b/tools/power/cpupower/utils/cpupower.c
> >>> @@ -12,6 +12,8 @@
> >>>    #include <unistd.h>
> >>>    #include <errno.h>
> >>>    #include <sched.h>
> >>> +#include <libgen.h>
> >>> +#include <limits.h>
> >>>    #include <sys/types.h>
> >>>    #include <sys/stat.h>
> >>>    #include <sys/utsname.h>
> >>> @@ -80,14 +82,17 @@ static void print_help(void)
> >>>
> >>>    static int print_man_page(const char *subpage)
> >>>    {
> >>> -     int len;
> >>> -     char *page;
> >>> +     char *page, *man_path, *exec_dir;
> >>> +     char exec_path[PATH_MAX];
> >>> +     int subpage_len;
> >>>
> >>> -     len =3D 10; /* enough for "cpupower-" */
> >>> -     if (subpage !=3D NULL)
> >>> -             len +=3D strlen(subpage);
> >>> +     if (!subpage)
> >>> +             return -EINVAL;
> >>>
> >>> -     page =3D malloc(len);
> >>> +     subpage_len =3D 10; /* enough for "cpupower-" */
> >>> +     subpage_len +=3D strlen(subpage);
> >>> +
> >>> +     page =3D malloc(subpage_len);
> >>>        if (!page)
> >>>                return -ENOMEM;
> >>>
> >>> @@ -97,6 +102,30 @@ static int print_man_page(const char *subpage)
> >>>                strcat(page, subpage);
> >>>        }
> >>>
> >>> +     /* Get current process image name full path */
> >>> +     if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
> >>
> >> Using /proc/self/exe is Linux and platform specific and not a
> >> good solution. Did you loom into using argv[0]?
> >
> > Yes, it is not the best solution. I would rather prefer to have a porta=
ble,
> > POSIX-based one. But after exploring possible options I came to the
> > conclusion that unfortunately such a solution doesn't exist.
> > According to C11 language standard:
> > "If the value of argc is greater than zero, the string pointed to by ar=
gv[0]
> > represents the program name;....".
> > Notice - program name, not the absolute path to the program. The actual
> > value of argv is under control of the calling environment.
> > You could look at the nice discussion of the topic for example here:
> > https://www.reddit.com/r/C_Programming/comments/dgcmhd/exactly_how_reli=
able_is_argv0_at_being_the/
> > Besides - this utility is a part of the Linux Kernel source tree and th=
erefore
> > has no requirement of the portability to another OSes.
> >
>
> Even so, you don't want to move it towards non-portable.

I tried to find a portable solution one more time but couldn't.
If you know how to do this please let me know.

> I think I asked
> this before on your previous version of the patch:
>
> What happens when you set the MANPATH before running the command?

Nice catch. Thanks. Will fix this and send v3.

>
> thanks,
> -- Shuah
>

--=20
Kind regards,
Roman Storozhenko

