Return-Path: <linux-pm+bounces-26656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C347DAA9852
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 18:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014E13B5A01
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A1A25D549;
	Mon,  5 May 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="AnjVrNkl"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23C25F98D
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461200; cv=none; b=I3Qts1U83pv/gTp9Vl3qFL22mDLDMxXeOmvFqKJoWNNxuSFZ2ERCqaS69vQuM22NuPPZqcH30Cgi822ZCWCMejJhqfFelxQWD8rjGObeER1MCZ8JCNE/DQPzKRZTeQ6wEq8pvD1+oLaYx+CjHEW1IscdnJHCtwmF9Wd3/1LEsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461200; c=relaxed/simple;
	bh=6BiYzLt13FpbsjuoGBCE9enFuPJv5DJOAuUhbPFel4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEUKlsBWS1dZGOAqBcK8jlD10Nlai0F52LCLLeE2N1chzCnjnEjcsA9Y+C8JlDdwFHtPGeqWrmLlKAR30GbKpJj2uFm3bqUOpLfS4DX+3LW6xHFxHVudNq9lON4lEwLJoh9+g8r2wV+lvay808QnvLoKyVCSgQ4lVe+ySmMBPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=AnjVrNkl; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KxQWpogNNtGNwsa5aJUcAs9QhCahQnA+uIt3Fl5q7YY=; t=1746461198;
	x=1746893198; b=AnjVrNklLgF/47QWOBQz/4UbJDKoqduReWotDKIxLA9BvZrTV65pEfCQ7sbD3
	R25+DK2E/oAPcqTadmNjez1HvWLsifWSxeDubkG6HoV2kd3lajaOIIZ2uaqwdn77wYBquPIidT21B
	6/KyYY6VjrF1CWbs4UlwC0eTRkKty3adnLIDMe747XCawdE3IZJVrix64Ui18Km0BEzRhb1mEsFRX
	+HA2DkaftZ2SsB3kms/dmowO7BCeof6hSsXMZMdwsTHSRR2bLV1HRWYdbK2mX+05NNjU6jyfb2vRB
	2yCxz/wYFlcv1xNQvEy7EvzUc/3mtCC71nxs/w0dmkEc0xnynw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1uByKt-009XI3-1H;
	Mon, 05 May 2025 18:06:31 +0200
Message-ID: <d06fb5d6-b8fe-4c4f-9ee9-6710c05cc51e@leemhuis.info>
Date: Mon, 5 May 2025 18:06:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
To: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>,
 Shuah Khan <shuah@kernel.org>, linux-pm list <linux-pm@vger.kernel.org>
Cc: Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Justin Forbes <jforbes@redhat.com>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20250425151024.121630-1-invernomuto@paranoici.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1746461198;a17d08f4;
X-HE-SMSGID: 1uByKt-009XI3-1H

[CCing Justin Forbes FYI]

On 25.04.25 17:07, Francesco Poli (wintermute) wrote:
> One of the most typical use cases of the 'cpupower' utility works as
> follows: run 'cpupower' at boot with the desired command-line options
> and then forget about it.
> 
> Add a systemd service (disabled by default) that automates this use
> case (for environments where the initialization system is 'systemd'),
> by running 'cpupower' at boot with the settings read from a default
> configuration file.
> 
> The systemd service, the associated support script and the
> corresponding default configuration file are derived from what is
> provided by the Arch Linux package (under "GPL-2.0-or-later" terms),
> modernized and enhanced in various ways (the script has also been
> checked with 'shellcheck').
> 
> Link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux-tools/-/tree/dd2e2a311e05413d0d87a0346ffce8c7e98d6d2b
> Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>

Lo! I'm wondering if the the DESTDIR usage in this patch is wrong, as it
caused trouble for me today when it showed up in -next. During debugging
I furthermore found a related problem.

> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 835123add0ed..9c2b5f71fee1 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for cpupower
>  #
>  # Copyright (C) 2005,2006 Dominik Brodowski <linux@dominikbrodowski.net>
> +# Copyright (C) 2025      Francesco Poli <invernomuto@paranoici.org>
>  #
>  # Based largely on the Makefile for udev by:
>  #
> @@ -71,6 +72,7 @@ bindir ?=	/usr/bin
>  sbindir ?=	/usr/sbin
>  mandir ?=	/usr/man
>  libdir ?=	/usr/lib
> +libexecdir ?=	/usr/libexec
>  includedir ?=	/usr/include
>  localedir ?=	/usr/share/locale
>  docdir ?=       /usr/share/doc/packages/cpupower
> @@ -83,6 +85,7 @@ CP = cp -fpR
>  INSTALL = /usr/bin/install -c
>  INSTALL_PROGRAM = ${INSTALL}
>  INSTALL_DATA  = ${INSTALL} -m 644
> +SETPERM_DATA  = chmod 644
>  #bash completion scripts get sourced and so they should be rw only.
>  INSTALL_SCRIPT = ${INSTALL} -m 644
>  
> @@ -302,6 +305,14 @@ install-tools: $(OUTPUT)cpupower
>  	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
>  	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
>  	$(INSTALL_SCRIPT) cpupower-completion.sh '$(DESTDIR)${bash_completion_dir}/cpupower'
> +	$(INSTALL) -d $(DESTDIR)${confdir}default
> +	$(INSTALL_DATA) cpupower.default '$(DESTDIR)${confdir}default/cpupower'
> +	$(INSTALL) -d $(DESTDIR)${libexecdir}
> +	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
> +	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
> +	sed 's|___CDIR___|$(DESTDIR)${confdir}|; s|___LDIR___|$(DESTDIR)${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'

While building -next kernel RPMS for Fedora the above line lead to the
this build error today:

"""
/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT/usr/lib64/systemd/system/cpupower.service
Found '/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT' in installed
files; aborting
"""

This somewhat cryptic error message means that the path
"/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT/" ended up in the
file "cpupower.service"; RPM noticed that and rightfully aborts the
build, as that path should not end up there. It's inserted by the sed
call in the last line quoted above.

I could easily fix this up in the RPM spec file with another sed call,
but wonder if that path should end up there in the first place. Not
quite sure, but I guess it should not (removing the first two
"$(DESTDIR)" in the line with the quoted sed call would fix that).

[1] Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/08996136-next-next-all/builder-live.log.gz

Build command used is basically "/usr/bin/make [redacted] -C
tools/power/cpupower
DESTDIR=/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT
libdir=/usr/lib64 mandir=/usr/share/man CPUFREQ_BENCH=false install


> +	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
> +	if test -d /run/systemd/system; then systemctl daemon-reload; fi

While investigating the issue I did a manual local build using
"make DESTDIR=~/tmp/out libdir=/usr/lib64 CPUFREQ_BENCH=false install"
to take a closer look. That make call then made systemd ask me for the
root password, which I found odd. Turns out that happens due to that "if
test -d" command quoted above.

I'd say that should not have happened this case (or maybe in general?).
The service afterwards would not have been available in systemd anyway,
as the service file was as instructed installed to
~/tmp/out/usr/lib64/systemd/system/cpupower.service -- but there systemd
would never have found it own it's own, so reloading the daemon is
meaningless in this case anyway.

Ciao, Thorsten

