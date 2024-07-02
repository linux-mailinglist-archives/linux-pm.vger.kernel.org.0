Return-Path: <linux-pm+bounces-10376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C629924798
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53496282238
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F71CCCD0;
	Tue,  2 Jul 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8rzKs7m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDE481D0;
	Tue,  2 Jul 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946381; cv=none; b=U3xFdC3YjE3q7TWDsp++q5IfonzT7Bohnmd8peb61KZHxGhhg9/UKPiClbU1oWWd830mfSX0sN3KeiZVz932756t9TAsUlHp/xa6coMXA+uYcZJ2mdAO13Vwkve1+TsA3sNxguiwtlpknN+feevHobfP0xNel46J8P7fF3J6L1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946381; c=relaxed/simple;
	bh=fx7y1zfZDl+Gycet3dUj8TAXXUjjcumC4lRXDq8EyXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjap19LEOaKZIFEHA+wgvwSSyUB42ypQNQc0IhbR/lNO5k+gMDhAk0kkIiFhurmE+QXOVwJU1rfJem2aoYqcfzjHFsH5fe4jSNiJKWKwSMkiS4iG0e9MYZAKdmbP39hNUnEFy10M1WpBR9gOJfYGsDavyPRlm7R7Seb/WKT6azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8rzKs7m; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so1331113a12.1;
        Tue, 02 Jul 2024 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719946378; x=1720551178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx7y1zfZDl+Gycet3dUj8TAXXUjjcumC4lRXDq8EyXA=;
        b=H8rzKs7mxe/f+kuJUXFpv2EJ5Lbje/nalmzRbJEHoQZA0UJ9r7Lu6EuYqZbSieTukr
         Kpgf47CzwuHLgAC/Okajzv8RD0vBfly41gRyUQGjNNDCHLoZ4u3TBNuJWzWoak9XUHUF
         caMHew+NKYx7sBr/yRMbDZRFlg3sX4s9IpFdmSHzqyqaAawvxb5eYx69W6wtPVnt3/Yt
         WRicxHAy3EixCYdJP8iezhH7Uf0GHvLuPXu+ThcEmI1O6Bl3V+f8tsU4fNlS0o+xFElf
         z+mYO73o2QxdQCLzDw3d6X8pRuz4B5k9QiiFM2Tn6jn4mT7YqWm6FzUheT+aBddQYFIk
         yIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946378; x=1720551178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fx7y1zfZDl+Gycet3dUj8TAXXUjjcumC4lRXDq8EyXA=;
        b=B+N91dxqJN8c/jEkdn3X9+1w02lxJ67Mx4aZK8DfH9q0Y0sucV7n2u2WZucT1KG8qx
         PStPheWml3oM4ViyUqfgN9sfwMmt5ASCkLFK7y5kCy1O/UNelLgDaENfSxZGapUMY6Fy
         K8WTnY7ki+AGWOMkcghGs30O+59OSbDeBlWo8ZceehRdGCASLBso7Spp3IyckGoEdbvC
         2OsULQuQ0ieQUBgwJIZZHLinI+LCDM7wfrSoMqUzTQzuFO/JiVnA2hqI1HmWq+c5lG7j
         HFC4c/kkBVB5McwMRXwaw0b7zVsmrgOdHSDfEEZhq9ck36f9mfaEnXsa6laTysBa3JwR
         9FVg==
X-Forwarded-Encrypted: i=1; AJvYcCUg4K6BAoeyvaJ92u0S2S8zBx2UtpRGbjoxBl7S1I/y5RmepnZKi9V5oxCBUWnzN3ewVzK763DC47PgGR4BxByCl4AJ2K7v4F5WLl8lnGd+l7q1XT3Iw81H7GhKMS3m6WR3tY7nO2E=
X-Gm-Message-State: AOJu0Yw1qquqY4+TKc7WogEepoWcgXzGJhmgWVa4lGgJJoIuMQaGe2it
	LB8mbDQ4xaWWtHh6q33y+hWsSEB9mASWb7nNuZhWxkPdcFtMjX34S3OKPUVanBnUYNky7NonA+j
	F3rcsPCiYyfT2RBeRwVjA4Z9A1VI=
X-Google-Smtp-Source: AGHT+IEYc/PB6/JZIlvU8rpBd/OR3sKMF3W4z+xWLfAR/Vxnk5NUnFRvXVo5wFkGvuD96Xgq0D8dISY2DuvmbMuRe9M=
X-Received: by 2002:a05:6402:4302:b0:582:774c:a6b6 with SMTP id
 4fb4d7f45d1cf-5879f0c4b0dmr6614640a12.4.1719946377940; Tue, 02 Jul 2024
 11:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
 <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
 <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
 <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
 <CALsPMBP42_oKJDegVQOzHUE00mie2Mh_aPyvyTUhgsnjQO1DDQ@mail.gmail.com>
 <501954d6-3f0a-4f1e-863b-c60353435700@linuxfoundation.org> <CALsPMBPkE=CCTgm8UcsdL7qEG+1u1H8NFYYTJvEMK3uXvg97Ng@mail.gmail.com>
In-Reply-To: <CALsPMBPkE=CCTgm8UcsdL7qEG+1u1H8NFYYTJvEMK3uXvg97Ng@mail.gmail.com>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Tue, 2 Jul 2024 20:52:46 +0200
Message-ID: <CALsPMBP8HR8eETzuua1STdnLPwLb1-53ipQg1c3vcEN4inU65g@mail.gmail.com>
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:40=E2=80=AFAM Roman Storozhenko
<romeusmeister@gmail.com> wrote:
>
> On Mon, Jul 1, 2024 at 9:40=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
> >
> > On 6/29/24 04:48, Roman Storozhenko wrote:
> > > On Fri, Jun 28, 2024 at 9:45=E2=80=AFPM Shuah Khan <skhan@linuxfounda=
tion.org> wrote:
> > >>
> > >> On 6/28/24 05:30, Roman Storozhenko wrote:
> > >>> On Thu, Jun 27, 2024 at 7:33=E2=80=AFPM Shuah Khan <skhan@linuxfoun=
dation.org> wrote:
> > >>>>
> > >>>> On 6/27/24 01:49, Roman Storozhenko wrote:
> > >>>>> When the 'cpupower' utility installed in the custom dir, it fails=
 to
> > >>>>> render appropriate help info for a particular subcommand:
> > >>>>> $ LD_LIBRARY_PATH=3Dlib64/ bin/cpupower help monitor
> > >>>>> with error message like 'No manual entry for cpupower-monitor.1'
> > >>>>> The issue is that under the hood it calls 'exec' function with
> > >>>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' sear=
ch
> > >>>>> path is defined in '/etc/manpath.config'. Of course it contains o=
nly
> > >>>>> standard system man paths.
> > >>>>> Make subcommands help available for a user by setting up 'MANPATH=
'
> > >>>>> environment variable to the custom installation man pages dir. Th=
at
> > >>>>> variable value will be prepended to the man pages standard search=
 paths
> > >>>>> as described in 'SEARCH PATH' section of MANPATH(5).
> > >>>>
> > >>>> What I am asking you is what happens when you set the MANPATH befo=
re
> > >>>> running the command?
> > >>>
> > >>> It adds the custom search path to the beginning of the MANPATH vari=
able.
> > >>> I tested this case. All works as expected.
> > >>>
> > >>
> > >> Let's try again. What happens if you run the command with MANPATH se=
t and
> > >> exported and then run the command. Can you send the output?
> > >
> > > hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> > > /tmp/
> > > hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=3Dlib64/
> > > bin/cpupower help monitor
> > > ...................
> > > man output
> > > ...................
> > > hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> > > /tmp/
> > > hedin@laptop:~/prj/cpupower/install/usr$
> > >
> >
> > Is this with your patch or mainline? Can you give cut and paste
> > the man output here for the mainline coupower without your patch?
>
> The above output is from my patch.
> This is the output from the mainline:
> hedin@laptop:~/prj/cpupower/install/usr$ sudo LD_LIBRARY_PATH=3Dlib64/
> bin/cpupower help monitor
> [sudo] password for hedin:
> No manual entry for cpupower-monitor
> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> /tmp/
> hedin@laptop:~/prj/cpupower/install/usr$
>
Based on our today's conversation the following is the output for the mainl=
ine:

hedin@laptop:~/prj/cpupower/install/usr$
MANPATH=3D"/home/hedin/prj/cpupower/install/usr/man:"
LD_LIBRARY_PATH=3Dlib64/ bin/cpupower help monitor
hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH

.............
man output
.............

hedin@laptop:~/prj/cpupower/install/usr$ export
MANPATH=3D"/home/hedin/prj/cpupower/install/usr/man:"
hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
/home/hedin/prj/cpupower/install/usr/man:
hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=3Dlib64/
bin/cpupower help monitor

.............
man output
.............

hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=3Dlib64/ sudo
bin/cpupower help monitor
[sudo] password for hedin:
bin/cpupower: error while loading shared libraries: libcpupower.so.1:
cannot open shared object file: No such file or directory

As you can see we can use MANPATH for correct help invocation, unless
we call it with 'sudo'. I can guess that it simply
inherits the environment variables from the root shell that contains
no 'MANPATH' variable set with an ordinary user.

Worth mentioning this in an appropriate manpage?

>
> >
> > thanks,
> > -- Shuah
> >
>
>
> --
> Kind regards,
> Roman Storozhenko



--=20
Kind regards,
Roman Storozhenko

