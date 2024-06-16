Return-Path: <linux-pm+bounces-9243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1CB909B68
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 05:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF071F2228B
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 03:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB2B16C6A4;
	Sun, 16 Jun 2024 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG/gZt0o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31D944F;
	Sun, 16 Jun 2024 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718507999; cv=none; b=FvHouna/nMdXWTjSkuebyiruFrNdKVnWwN+fEQW62lORibFCAjcwW40CptPDrakzSWZyFuRyuYr3FCrCKhl0UOLegJ50bVluOWeosZHfAczzZGHTPqaEIc+MPV7U+q2cCI5xQDbCQpImkYYNoqkbbmND9bxXGtWtiR4IeY0Ve5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718507999; c=relaxed/simple;
	bh=8AJiaqZIh9eo2TJ7D7brpc5fNkY+Urv6oQKHntt/c8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu1E88bkz+D1ighPAp7IuAHwT7pW49aD/6wqNSl7KrABghWNS33vli7H7I6ByMfEFOB+fbvuvksXfL2Um5cpYEKqedD/PIIiS2vsp/9ElEiQ0QJyBcSZMFH3CgecncHvFQWDszjua7XEdgaphmY6cVHO03gPf+YMq+5vO0CzUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG/gZt0o; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso3644195a12.1;
        Sat, 15 Jun 2024 20:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718507996; x=1719112796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzYum5H73Rwg6QiKYxDU7/ALOjGOuYuf+9NkdG0aSqo=;
        b=WG/gZt0oAJd7R/93GseU2i0Va1DsG1aE6+S3P8GW+v85KWArrAe/RVYeDbisyFGTST
         945+9107AP/zrG2K+UN4xsNnorBAq/YutUoMMNv1c81WF7zWA7WtdiAgMMKbhP1yAR+d
         1XMYL6taOAtZNOqFIN03kMe3DYKiUFN1VsVFDJkU8YnzqePZwE4elSpGMJF1hukA7vcX
         18RV532Z/QxPlUJie+egz5IY2rX3J58xvuCkyHch4EMMnC3lwWRths2du4TcRFiZChgd
         N8mg0qvfN0xHn/8cvRq+hEno0B5qKkfQ2t4hDjx+EFxHylaGTBqbskx50eK/vWhXbELX
         F+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718507996; x=1719112796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzYum5H73Rwg6QiKYxDU7/ALOjGOuYuf+9NkdG0aSqo=;
        b=rp3a1VsEzdVe3+BiIDbSJKnhDmSfLtQuKpXZJEFtNMGra94uG9B7hi370xkRbPyBGt
         BVdLXOlA6wNCSNr8srtEi9SKb2grTiNnMQcDTk7kfPrprM7v0R3og4i9+ItqZjcjrJfI
         v8iqd3sftTVMbQ+Il11dL+btWHwZMUASu+zv/Vn+rLMwblmAjcdb5KH1MJxa2LnFe3ZM
         7TgMYgNQ4q7bUMAASaV0JY193WN384BGdotJPjSJKEplG+G4RQijNiCorfwYhtugi4ZZ
         JcrE6uSn3eBe17sDddBEMuRKjjy5DdI7gU8wwpyVF1Ina+DwjvZEL4niVzQ51ZOJCMq5
         m61g==
X-Forwarded-Encrypted: i=1; AJvYcCVt8EWiBhtbYiUkj0T22QGTFxeiW2zNYiWoimq+ZM1XuhwksQfeGgXNGS7sdgPsqqBO6xiFmnxVk2dT13JerhcH46YVJ7Op6PzOR1MhxJwxRyfWHJygU0zoNvD868YDAp3g7cRMNoQ=
X-Gm-Message-State: AOJu0Yz/7qDGFYFhM00Tmm7SbAaQqXGVOe//iCYhheE4F6oFPKNpMo5u
	RilnKvd8RTLbxIJD3taLBtsANin5Pn2vIx+fl4PhUhUCb3rZ0dD4BAZTHhQgy8II9So+kdlOlhd
	hExo90o+5JgzjvdIy/jSddk6fT3w=
X-Google-Smtp-Source: AGHT+IEEf+C3yEAVHJKwNzOgPX92AlCBtVbrVPr2buXSasN5Ksreg5TDBr8oA4dxULwpVRh8jjYWlh2bnWEQ8WRyOpU=
X-Received: by 2002:a17:906:474b:b0:a6f:5698:ab5b with SMTP id
 a640c23a62f3a-a6f60cf42c9mr402484566b.8.1718507995773; Sat, 15 Jun 2024
 20:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615125617.180521-1-romeusmeister@gmail.com> <2ac9b1a3-fd42-48fc-b1c8-4c1986536ef9@linuxfoundation.org>
In-Reply-To: <2ac9b1a3-fd42-48fc-b1c8-4c1986536ef9@linuxfoundation.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 16 Jun 2024 05:19:44 +0200
Message-ID: <CALsPMBNSJQXz4zG_s=f1E6UbY-m98ibtnHoUDBPLq+x9wMQ5cg@mail.gmail.com>
Subject: Re: [PATCH v2] cpupower: Improve cpupower build process description
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 1:05=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/15/24 06:56, Roman Storozhenko wrote:
> > Enhance cpupower build process description with the information on
> > building and installing the utility to the user defined directories
> > as well as with the information on the way of running the utility from
> > the custom defined installation directory.
> >
> > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > ---
> > V1 -> V2:
> >   - Improved commit description
> >   - Make changed line lenghts 75 chars
> >   - Refactored the description
> >   - Link v1: https://lore.kernel.org/linux-pm/20240613-fix-cpupower-doc=
-v1-1-9dcdee263af1@gmail.com/
> > ---
> >   tools/power/cpupower/README | 160 +++++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 150 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
> > index 1c68f47663b2..2678ed81d311 100644
> > --- a/tools/power/cpupower/README
> > +++ b/tools/power/cpupower/README
> > @@ -22,16 +22,156 @@ interfaces [depending on configuration, see below]=
.
> >   compilation and installation
> >   ----------------------------
> >
> > -make
> > -su
> > -make install
> > -
> > -should suffice on most systems. It builds libcpupower to put in
> > -/usr/lib; cpupower, cpufreq-bench_plot.sh to put in /usr/bin; and
> > -cpufreq-bench to put in /usr/sbin. If you want to set up the paths
> > -differently and/or want to configure the package to your specific
> > -needs, you need to open "Makefile" with an editor of your choice and
> > -edit the block marked CONFIGURATION.
> > +There are 2 output directories - one for the build output and another =
for
> > +the installation of the build results, that is the utility, library,
> > +man pages, etc...
> > +
> > +default directory
> > +-----------------
> > +
> > +In the case of default directory, build and install process requires n=
o
> > +additional parameters:
> > +
> > +build
> > +-----
> > +
> > +$ make
> > +
> > +The output directory for the 'make' command is the current directory a=
nd
> > +its subdirs in the kernel tree:
> > +tools/power/cpupower
> > +
> > +install
> > +-------
> > +
> > +$ sudo make install
> > +
> > +'make install' command puts targets to default system dirs:
> > +
> > +----------------------------------------------------------------------=
-
> > +| Installing file        |               System dir                   =
|
> > +----------------------------------------------------------------------=
-
> > +| libcpupower            | /usr/lib                                   =
|
> > +----------------------------------------------------------------------=
-
> > +| cpupower               | /usr/bin                                   =
|
> > +----------------------------------------------------------------------=
-
> > +| cpufreq-bench_plot.sh  | /usr/bin                                   =
|
> > +----------------------------------------------------------------------=
-
> > +| man pages              | /usr/man                                   =
|
> > +----------------------------------------------------------------------=
-
> > +
> > +To put it in other words it makes build results available system-wide,
> > +enabling any user to simply start using it without any additional step=
s
> > +
> > +custom directory
> > +----------------
> > +
> > +There are 2 make's command-line variables 'O' and 'DESTDIR' that setup
> > +appropriate dirs:
> > +'O' - build directory
> > +'DESTDIR' - installation directory. This variable could also be setup =
in
> > +the 'CONFIGURATION' block of the "Makefile"
> > +
> > +build
> > +-----
> > +
> > +$ make O=3D<your_custom_build_catalog>
> > +
> > +Example:
> > +$ make O=3D/home/hedin/prj/cpupower/build
> > +
> > +install
> > +-------
> > +
> > +$ make O=3D<your_custom_build_catalog> DESTDIR=3D<your_custom_install_=
catalog>
> > +
> > +Example:
> > +$ make O=3D/home/hedin/prj/cpupower/build DESTDIR=3D/home/hedin/prj/cp=
upower \
> > +> install
> > +
> > +Notice that both variables 'O' and 'DESTDIR' have been provided. The r=
eason
> > +is that the build results are saved in the custom output dir defined b=
y 'O'
> > +variable. So, this dir is the source for the installation step. If onl=
y
> > +'DESTDIR' were provided then the 'install' target would assume that th=
e
> > +build directory is the current one, build everything there and install
> > +from the current dir.
> > +
> > +The files will be installed to the following dirs:
> > +
> > +----------------------------------------------------------------------=
-
> > +| Installing file        |               System dir                   =
|
> > +----------------------------------------------------------------------=
-
> > +| libcpupower            | ${DESTDIR}/usr/lib                         =
|
> > +----------------------------------------------------------------------=
-
> > +| cpupower               | ${DESTDIR}/usr/bin                         =
|
> > +----------------------------------------------------------------------=
-
> > +| cpufreq-bench_plot.sh  | ${DESTDIR}/usr/bin                         =
|
> > +----------------------------------------------------------------------=
-
> > +| man pages              | ${DESTDIR}/usr/man                         =
|
> > +----------------------------------------------------------------------=
-
> > +
> > +If you look at the table for the default 'make' output dirs you will
> > +notice that the only difference with the non-default case is the
> > +${DESTDIR} prefix. So, the structure of the output dirs remains the sa=
me
> > +regardles of the root output directory.
> > +
> > +
> > +clean and uninstall
> > +-------------------
> > +
> > +'clean' target is intended for cleanup the build catalog from build re=
sults
> > +'uninstall' target is intended for removing installed files from the
> > +installation directory
> > +
> > +default directory
> > +-----------------
> > +
> > +This case is a straightforward one:
> > +$ make clean
> > +$ make uninstall
> > +
> > +custom directory
> > +----------------
> > +
> > +Use 'O' command line variable to remove previously built files from th=
e
> > +build dir:
> > +$ make O=3D<your_custom_build_catalog> clean
> > +
> > +Example:
> > +$ make O=3D/home/hedin/prj/cpupower/build clean
> > +
> > +Use 'DESTDIR' command line variable to uninstall previously installed =
files
> > +from the given dir:
> > +$ make DESTDIR=3D<your_custom_install_catalog>
> > +
> > +Example:
> > +make DESTDIR=3D/home/hedin/prj/cpupower uninstall
> > +
> > +
> > +running the tool
> > +----------------
> > +
> > +default directory
> > +-----------------
> > +
> > +$ sudo cpupower
> > +
> > +custom directory
> > +----------------
> > +
> > +When it comes to run the utility from the custom build catalog things
> > +become a little bit complicated as 'just run' approach doesn't work.
> > +Assuming that the current dir is '<your_custom_install_catalog>/usr',
> > +issuing the following command:
> > +
> > +$ sudo ./bin/cpupower
> > +will produce the following error output:
> > +./bin/cpupower: error while loading shared libraries: libcpupower.so.1=
:
> > +cannot open shared object file: No such file or directory
> > +
> > +The issue is that binary cannot find the 'libcpupower' library. So, we
> > +shall point to the lib dir:
> > +sudo LD_LIBRARY_PATH=3Dlib64/ ./bin/cpupower
> >
> >
> >   THANKS
>
> This "THANKS" doesn't belong in the patch.

The 'THANKS' does belong to the patch as well as the 'interfaces
[depending on configuration, see below]' line at the top.
Those 2 lines are parts of the original file and show the bottom and
the top of  the changed text area.
Just in case, I tried to re-add my changes using 'git add -i' on my
dev machine and found that it is impossible to get rid of it.
And it's explainable, git wants to know the area of the text to change.
Besides, applying the downloaded patch using "git am' doesn't
introduce the second 'THANKS' word at the bottom of the text.
That is, the patch applies correctly.
I decided to experiment further and removed the 'THANKS' line from the
patch that had been sent and checked it with 'checkpatch':
hedin@laptop:~/lkmp/patchwork/patches/powertools/cpupower/update_doc_instal=
l/tmp$
~/prj/linux/scripts/checkpatch.pl
0001-cpupower-Improve-cpupower-build-process-description.patch
                                                       ERROR: patch
seems to be corrupt (line wrapped?)
#193: FILE: tools/power/cpupower/README:176:

Returned the 'THANKS':
hedin@laptop:~/lkmp/patchwork/patches/powertools/cpupower/update_doc_instal=
l/tmp$
~/prj/linux/scripts/checkpatch.pl
0001-cpupower-Improve-cpupower-build-process-description.patch
total: 0 errors, 0 warnings, 166 lines checked
0001-cpupower-Improve-cpupower-build-process-description.patch has no
obvious style problems and is ready for submission.

So, as you can see 'THANKS' is a required part of the patch.
>
> thanks,
> -- Shuah
>


--=20
Kind regards,
Roman Storozhenko

