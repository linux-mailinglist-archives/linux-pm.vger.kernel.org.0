Return-Path: <linux-pm+bounces-9789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C460B912D1D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C102870D9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6B15F3E9;
	Fri, 21 Jun 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OytInhHV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75068C1E;
	Fri, 21 Jun 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993946; cv=none; b=JvnTcKMa1F2/jaax9Efbdcu3laLvnLD4Syt36fIAOxx4Hj8kiacXEMXPjSm0nl+wlOKVUSCixKQdZI3zM2DqE/cInmIrouBho+zQgf/9mI+XHVfAbpN8P9oZir5aeKlDtvn1owQ/TVPKe98gBRyx2vWDg5ibSVpvclDq7KIrbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993946; c=relaxed/simple;
	bh=vkjVfVSKNRVirrgvI+TLcy4nhfx47DfgnhJuexdliUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VU9FW56UdFUnn/D+aqWQ4oGOagvI0n56A+jGdG0lmP6j8n+42hY9j2G33vQdmpsr3RJHYjGiyd08fRF2DkeAvzbAMu22bpWXcwwI8sqE/1b5GFE3DZmzGUtpK6cY9XpucdfBs1+BzkHYmMVenA538uDaigd7f42RdSH/UBFQlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OytInhHV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d21b1c8efso2492824a12.3;
        Fri, 21 Jun 2024 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718993943; x=1719598743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dT7BE9vS3IAurT8KcadCRcpuNa2YZkMbwMwKoRwsu8=;
        b=OytInhHVXyC6nhhT+AlVIjykVe/NFARXTgDfFZ/CoaSq5TWKfF9S0dgffiOjf3R2RP
         BKv0caOllJQsdDa3Zq73owuXZx3SnAIjf6m5Zln+Vp+Da6xUPrsyAhT2QIjinb9jgGsy
         zVg7vkOtaicerxEMDJCbtqMYbYcKuZ4lcgdKC/I+w2qmv38RHHIy2gSxb7c39z9g7+zC
         C1TOZuY/pgS3sKrDO+39n7Bl2d6X40YgqY3nhz2n28SpvYfstjwhwGDcjIv/EA+h73by
         G8nIB71FjLgC5AOrV3kmND8A/ySWX90HybimaHKvPjW2LKSuRYSVXPiUg89tuSFibW+Z
         TJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993943; x=1719598743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dT7BE9vS3IAurT8KcadCRcpuNa2YZkMbwMwKoRwsu8=;
        b=SNo8cF5s52Oppx8wNS6wemlTiQ0wN+DwFxIJoDH3H2awIqJBXizi+9vIIIJSfhDV8c
         dv9V24TkETvivW86Za/LNMcjmI8MuFnvwpnu0n4Asf0ed1mXLSNs4tU6AJw6pJLL45A1
         wm2eEQBKbiArCSLIQTz/D2R1keaqabNkQ7dxK5NQtgNmgBqW9vYDp6Qf+Jzt5CXd69mO
         Q6tA204vhybNJU8SK6CwFJIBZZ9h0Q8fSyBdtoCXYFchPo/TlnvyxKoRiXGcpI31+Vmn
         zox5TLM1HEenZguEwHpMSU5lfN2F1vABZEZcZTLC+75hN1kWsVsmyQWvolrREdqK9uDw
         v47g==
X-Forwarded-Encrypted: i=1; AJvYcCXe3hMh5MFbk2sZrVZ7aDhZJJIQGexVTP8v97Vn5UwT4BCrsDIjGATfh8VwrDCZD7dmAmLTH+GADkxlTmxgSue4qlsd3hJc4jrlVVZDvlGOo0a+qGZmvOwwwYm/pVfwD+VJfdVa4mk=
X-Gm-Message-State: AOJu0YxWpmbdX3yNhecyEnlsZHD/Zo1fyWlxqLmBQX41QtIW4/VImFTb
	lXkQSG2rVD9LgagtIvIWEDj0OBJZQfVolnX34FuCcB8Yn1Oq06VtDUT8htH9zwvDu4zkC1/T2O6
	d2LVMKry0wvetzVucSsU3HZR2fFtR2RYC
X-Google-Smtp-Source: AGHT+IH6voJPAJ/Pv/FQ95s9QMgmm8yX7etPdoCAizaXJMl95+4+kYLX/5NCw2hUPnb9FDBMuSNQXcnXJHn9HdLgrpg=
X-Received: by 2002:a50:c30f:0:b0:57d:40aa:9486 with SMTP id
 4fb4d7f45d1cf-57d40aa94ebmr31723a12.22.1718993942840; Fri, 21 Jun 2024
 11:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com> <6d745d8d-33b1-4aed-b9c5-095073bc8cde@linuxfoundation.org>
In-Reply-To: <6d745d8d-33b1-4aed-b9c5-095073bc8cde@linuxfoundation.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Fri, 21 Jun 2024 20:18:50 +0200
Message-ID: <CALsPMBPd1O2zBxyvfTJiPvuWO+zaTxrYizmiKULr1A-77ME_Rw@mail.gmail.com>
Subject: Re: [PATCH] cpupower: Make help command available for custom install dir
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 5:02=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/21/24 02:13, Roman Storozhenko wrote:
> > When the 'cpupower' utility installed in the custom dir, it fails to
> > render appopriate help info for a particular subcommand:
>
> appopriate -> appropriate
> Spell check the commit message.

Thanks for highlighting this, will fix.
>
> > $ LD_LIBRARY_PATH=3Dlib64/ bin/cpupower help monitor
> > with error message like 'No manual entry for cpupower-monitor.1'
> > The issue is that under the hood it calls 'exec' function with
> > the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> > path is defined in '/etc/manpath.config'. Of course it contains only
> > standard system man paths.
> > Make subcommands man pages available for user using the following rule:
> > Render a man page if it is installed in the custom install dir, otherwi=
se
> > allow man to search this page by name system-wide as a last resort.
> >
>
> Good find.
>
> > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > ---
> >   tools/power/cpupower/utils/cpupower.c | 54 ++++++++++++++++++++++++++=
++++-----
> >   1 file changed, 47 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupow=
er/utils/cpupower.c
> > index 9ec973165af1..da4bc6de7494 100644
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
> > @@ -21,6 +23,8 @@
> >   #include "helpers/bitmask.h"
> >
> >   #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
> > +#define MAN_REL_PATH "/../man/man1/"
> > +#define MAN_SUFFIX ".1"
> >
> >   static int cmd_help(int argc, const char **argv);
> >
> > @@ -80,14 +84,17 @@ static void print_help(void)
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
> > @@ -97,7 +104,40 @@ static int print_man_page(const char *subpage)
> >               strcat(page, subpage);
> >       }
> >
> > -     execlp("man", "man", page, NULL);
> > +     /* Get current process image name full path */
> > +     if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
> > +
> > +             man_path =3D malloc(PATH_MAX);
> > +             if (!man_path) {
> > +                     free(page);
> > +                     return -ENOMEM;
> > +             }
> > +
> > +             exec_dir =3D strdup(exec_path);
> > +             if (!exec_dir) {
> > +                     free(page);
> > +                     free(man_path);
> > +                     return -ENOMEM;
> > +             }
> > +
> > +             *man_path =3D '\0';
> > +             strncat(man_path, dirname(exec_dir), strlen(exec_dir));
> > +             strncat(man_path, MAN_REL_PATH, strlen(MAN_REL_PATH));
> > +             strncat(man_path, page, strlen(page));
> > +             strncat(man_path, MAN_SUFFIX, strlen(MAN_SUFFIX));
> > +
> > +             free(exec_dir);
> > +
> > +             /* Check if file exists */
> > +             if (access(man_path, F_OK) =3D=3D -1) {
> > +                     free(man_path);
> > +                     man_path =3D page;
> > +             }
> > +     } else {
> > +             man_path =3D page;
> > +     }
> > +
> > +     execlp("man", "man", man_path, NULL);
>
> You can simplify all of this by using getenv() to get the environment
> variables for the program.
>
> Take a look getenv() usages in the kernel sources for reference.

If you mean that I can extract the current working directory and then add
relative path to man page to it then yes, I can. But the issue with
this approach
is that this will work only if I run the binary from its directory,
otherwise it fail,
because current_working_directory is not the image_path. And there is no
environment variable which defines the path to the process's binary.
Just in case, I looked to the kernel sources which use getenv() in userspac=
e and
also examined the list of the POSIX environment variables:
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html
And nothing came to my mind in terms of simplification.
So, please suggest me what I could change.

> >
>
> thanks,
> -- Shuah
>


--=20
Kind regards,
Roman Storozhenko

