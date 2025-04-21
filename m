Return-Path: <linux-pm+bounces-25804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7FA953B4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 17:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4283AEFE0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD81C84A5;
	Mon, 21 Apr 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9WoStT7"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAF19C54F
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250518; cv=none; b=kMDlmnNmpB1S8ihFb3oBC4tJDwu4TDWQJxG/7ghXT7aTS0zmhh5XQfyW5psANAx+u1sxh/eZxefJn4XpeALkVZl9xLtas1GXq6nBgjF7CUZXgf1szyi/Cs5RynxuFlGrLpBNr0JVzAkkVFQuvg1hFdGLlIVuSeoYlgwzuiHXSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250518; c=relaxed/simple;
	bh=lEnq0pigDYgVqsjGZCj7dBHEZpU/Z1cfI8mZE8s/VDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7dgko78VC9D4+1ZrfsvbZYlgd6lzxeMPNulMeLKS7OZelt/nh3A+uHdeKBtN+4F3+8XQDh+GiSlml1eNiLtunqSRYRTIlvgNbOjPbk/MVh1HvqBrjjjq0pAP9M6ZcCzZyI5IjE0NXnMGG4dQ8Pv58fa/eTbwH6isxF8Wg0fQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9WoStT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745250514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RuXH+DbocBOderxtp+S/b5SxTPiogxv8XyzLlzeJzoY=;
	b=H9WoStT7LbJtHZFghLmJB4XErYXT274opVCxqS+ieDSXHVKxIE06ENCI8LktYdkq0S27Ig
	GknrYmUSulhzo0YnGj9CRN9a6uOYMT5oeSr7mZx8H080sALj8YE/GdtZrvVhrxC6xpV0B9
	HY8mQj6Oz4sQsUXvDpdWJPDkmN49WWM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-XercSNZUOwu1EoeUl5cs3Q-1; Mon, 21 Apr 2025 11:44:33 -0400
X-MC-Unique: XercSNZUOwu1EoeUl5cs3Q-1
X-Mimecast-MFC-AGG-ID: XercSNZUOwu1EoeUl5cs3Q_1745250273
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8f9450b19so88429706d6.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 08:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745250273; x=1745855073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuXH+DbocBOderxtp+S/b5SxTPiogxv8XyzLlzeJzoY=;
        b=SkyiWFdY9UlsRe581K1s9fnSdpdnwUHOMj0yppb9tHdre3T2zfvWRlltYO4b87GKj9
         hvIrpvLqC0T1k7CQtdjU0a2VBecaiJfuANa6ENMo57CYnFX3qNTmJUcgHAU9AISVvSF7
         yhKmyGfgZ5Hjh1jyRc0OUD3cS24fgNKbhIbEnb8sje1AiQ9UD2Rk5/hLCGjuHTqZ5M2b
         4iv+E9WdBhOhPhuJ2/y7Ac9HpFyk6B+1hywfOHXsG6VA2fw9GH3oPkDDm4XJCUvGqPBe
         CaMlQjzG8MRdj4wkGPNNgyFIJrgchak1W0uvYfJXrIS0YeqPokbEPVnNeHG7ErAJRE8o
         IMpw==
X-Gm-Message-State: AOJu0Ywt6iTFBeYMfTQSxoGNPCig0A41uSUT1VhBpUk2L8nkMIIkSAbz
	EFwqtQoQYZQPquHODAx1co4ZzsZxdYP6yiXMVOoXOdt0h6yb3iLxR7u+T50Z97Or4L+jfIkeghS
	vjnTKFTZA8DjsRudmpSYKAtNmUvlRQpOUokpmf4PICgi+TcDQC5hrdeN4Mt2NZSh1ZNI=
X-Gm-Gg: ASbGncukNAzfR0vI7EWN5kjV3TlsifMisNjkZBUvdiHPyFL/Yq9B9MEjtIh06tzVkRY
	qxZ6XVE3Qr5l7YjhgFgs7sJTVZVhWuVezVJKW1fuw6JNHAFLAXpuDC5UEC8eZHDpGfaMDub+m5N
	KP4HFXT2Y3VkFlo76jMUzTIKbvlaefzMm7TyWqUaZv8MN9aUV+muRiPWwC/LTXPIPqwWg4IbwaY
	6S2mlwzzazPHvYRzm7M0JblNNVPwyEumvW/P8hrflqRMMVlFhtl6U+qwiByPFG5UE+2IJpPzsgV
	P5TNpkcD
X-Received: by 2002:a05:6214:d0b:b0:6e6:5b8e:7604 with SMTP id 6a1803df08f44-6f2c4dae4b8mr185692036d6.12.1745250273082;
        Mon, 21 Apr 2025 08:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBwkLqitIzzAIQahaPc8RAuNZzMxF01w3wDAjj3FxEnm7yJGKz3kzEOc3bZDExvUxxQkN+hA==
X-Received: by 2002:a05:6214:d0b:b0:6e6:5b8e:7604 with SMTP id 6a1803df08f44-6f2c4dae4b8mr185691726d6.12.1745250272682;
        Mon, 21 Apr 2025 08:44:32 -0700 (PDT)
Received: from thinkpad2024 ([71.217.87.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21db2sm45093816d6.111.2025.04.21.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:44:32 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:44:30 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cpupower: add a systemd service to run cpupower
Message-ID: <aAZn3rcwa5e-L68i@thinkpad2024>
References: <20250408203641.37195-1-invernomuto@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408203641.37195-1-invernomuto@paranoici.org>

Thank you for sending the patch Francesco.

There are several issues:

On Tue, Apr 08, 2025 at 10:32:46PM +0200, Francesco Poli (wintermute) wrote:
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
> 
> Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
> ---
>  tools/power/cpupower/Makefile            | 14 ++++++++++++
>  tools/power/cpupower/README              | 18 +++++++++++++++
>  tools/power/cpupower/cpupower.default    | 28 ++++++++++++++++++++++++
>  tools/power/cpupower/cpupower.service.in | 16 ++++++++++++++
>  tools/power/cpupower/cpupower.sh         | 26 ++++++++++++++++++++++
>  5 files changed, 102 insertions(+)
>  create mode 100644 tools/power/cpupower/cpupower.default
>  create mode 100644 tools/power/cpupower/cpupower.service.in
>  create mode 100644 tools/power/cpupower/cpupower.sh
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 51a95239fe06..2bdfb2bfe88a 100644
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
> @@ -68,6 +69,7 @@ bindir ?=	/usr/bin
>  sbindir ?=	/usr/sbin
>  mandir ?=	/usr/man
>  libdir ?=	/usr/lib
> +libexecdir ?=	/usr/libexec
>  includedir ?=	/usr/include
>  localedir ?=	/usr/share/locale
>  docdir ?=       /usr/share/doc/packages/cpupower
> @@ -80,6 +82,7 @@ CP = cp -fpR
>  INSTALL = /usr/bin/install -c
>  INSTALL_PROGRAM = ${INSTALL}
>  INSTALL_DATA  = ${INSTALL} -m 644
> +SETPERM_DATA  = chmod 644
>  #bash completion scripts get sourced and so they should be rw only.
>  INSTALL_SCRIPT = ${INSTALL} -m 644
>  
> @@ -299,6 +302,14 @@ install-tools: $(OUTPUT)cpupower
>  	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
>  	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
>  	$(INSTALL_SCRIPT) cpupower-completion.sh '$(DESTDIR)${bash_completion_dir}/cpupower'
> +	$(INSTALL) -d $(DESTDIR)${confdir}default
> +	$(INSTALL_DATA) cpupower.default '$(DESTDIR)${confdir}default/cpupower'
> +	$(INSTALL) -d $(DESTDIR)${libexecdir}
> +	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
> +	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
> +	sed 's|___CDIR___|$(DESTDIR)${confdir}|; s|___LDIR___|$(DESTDIR)${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
> +	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
> +	if test -d /run/systemd/system; then systemctl daemon-reload; fi
>  
>  install-man:
>  	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
> @@ -333,6 +344,9 @@ uninstall:
>  	- rm -f $(DESTDIR)${includedir}/cpufreq.h
>  	- rm -f $(DESTDIR)${includedir}/cpuidle.h
>  	- rm -f $(DESTDIR)${bindir}/utils/cpupower
> +	- rm -f $(DESTDIR)${confdir}default/cpupower
> +	- rm -f $(DESTDIR)${libexecdir}/cpupower
> +	- rm -f $(DESTDIR)${libdir}/systemd/system/cpupower.service
>  	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
>  	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
>  	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-info.1
> diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
> index 2678ed81d311..3c34ef67e0cf 100644
> --- a/tools/power/cpupower/README
> +++ b/tools/power/cpupower/README
> @@ -59,6 +59,10 @@ $ sudo make install
>  -----------------------------------------------------------------------
>  | man pages              | /usr/man                                   |
>  -----------------------------------------------------------------------
> +| systemd service        | /usr/lib                                   |
> +-----------------------------------------------------------------------
> +| systemd support script | /usr/libexec                               |
> +-----------------------------------------------------------------------
>  
>  To put it in other words it makes build results available system-wide,
>  enabling any user to simply start using it without any additional steps
> @@ -109,6 +113,10 @@ The files will be installed to the following dirs:
>  -----------------------------------------------------------------------
>  | man pages              | ${DESTDIR}/usr/man                         |
>  -----------------------------------------------------------------------
> +| systemd service        | ${DESTDIR}/usr/lib                         |
> +-----------------------------------------------------------------------
> +| systemd support script | ${DESTDIR}/usr/libexec                     |
> +-----------------------------------------------------------------------
>  
>  If you look at the table for the default 'make' output dirs you will
>  notice that the only difference with the non-default case is the
> @@ -173,6 +181,16 @@ The issue is that binary cannot find the 'libcpupower' library. So, we
>  shall point to the lib dir:
>  sudo LD_LIBRARY_PATH=lib64/ ./bin/cpupower
>  
> +systemd service
> +---------------
> +
> +A systemd service is also provided to run the cpupower utility at boot with
> +settings read from a configuration file. In order to enable this systemd
> +service, edit '${DESTDIR}/etc/default/cpupower' and then issue the following
> +command:

Edit what? What should they change?

I am new to systemd files so knowing how to test this is important.

> +
> +$ sudo systemctl enable --now cpupower.service
> +
>  
>  THANKS
>  ------
> diff --git a/tools/power/cpupower/cpupower.default b/tools/power/cpupower/cpupower.default
> new file mode 100644
> index 000000000000..b2fd3c37e277
> --- /dev/null
> +++ b/tools/power/cpupower/cpupower.default
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2012, Sébastien Luttringer
> +# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
> +
> +# defaults file for linux-cpupower

Should be:

# Default file for linux-cpupower

Otherwise, the additional comments added to the Arch files are welcome.
:)

> +
> +# --- CPU clock frequency ---
> +
> +# Define CPU governor
> +# valid governors: ondemand, performance, powersave, conservative, userspace.

Since we are at proofreading; please capitalize valid.

> +#GOVERNOR='ondemand'

One thing I noticed is that you changed the variables to their
uppercase. Is there a reason for that? Have you tested it?

Last you wrote, you copied the Arch files to test in Debian. Once again,
not familiar with systemd files so this is a change.

> +
> +# Limit frequency range
> +# Valid suffixes: Hz, kHz (default), MHz, GHz, THz
> +#MIN_FREQ="2.25GHz"
> +#MAX_FREQ="3GHz"
> +
> +# Specific frequency to be set.
> +# Requires userspace governor to be available.
> +# If this option is set, all the previous frequency options are ignored
> +#FREQ=
> +
> +# --- CPU policy ---
> +
> +# Sets a register on supported Intel processore which allows software to convey
> +# its policy for the relative importance of performance versus energy savings to
> +# the  processor. See man (1) CPUPOWER-SET for additional details.

double space

> +#PERF_BIAS=
> diff --git a/tools/power/cpupower/cpupower.service.in b/tools/power/cpupower/cpupower.service.in
> new file mode 100644
> index 000000000000..f91eaed03872
> --- /dev/null
> +++ b/tools/power/cpupower/cpupower.service.in
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2012-2020, Sébastien Luttringer
> +# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
> +
> +[Unit]
> +Description=Apply cpupower configuration
> +ConditionVirtualization=!container
> +
> +[Service]
> +Type=oneshot
> +EnvironmentFile=-___CDIR___default/cpupower
> +ExecStart=___LDIR___/cpupower
> +RemainAfterExit=yes
> +
> +[Install]
> +WantedBy=multi-user.target
> diff --git a/tools/power/cpupower/cpupower.sh b/tools/power/cpupower/cpupower.sh
> new file mode 100644
> index 000000000000..a37dd4cfdb2b
> --- /dev/null
> +++ b/tools/power/cpupower/cpupower.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2012, Sébastien Luttringer
> +# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
> +
> +ESTATUS=0
> +
> +# apply CPU clock frequency options
> +if test -n "$FREQ"
> +then
> +    cpupower frequency-set -f "$FREQ" > /dev/null || ESTATUS=1
> +elif test -n "${GOVERNOR}${MIN_FREQ}${MAX_FREQ}"
> +then
> +    cpupower frequency-set \
> +      ${GOVERNOR:+ -g "$GOVERNOR"} \
> +      ${MIN_FREQ:+ -d "$MIN_FREQ"} ${MAX_FREQ:+ -u "$MAX_FREQ"} \
> +      > /dev/null || ESTATUS=1
> +fi
> +
> +# apply CPU policy options
> +if test -n "$PERF_BIAS"
> +then
> +    cpupower set -b "$PERF_BIAS" > /dev/null || ESTATUS=1
> +fi
> +
> +exit $ESTATUS

Where did you get this file? I do not believe I see it in the Arch
package repo. What is it used for with the systemd scripts? They do not
reference it.

https://gitlab.archlinux.org/archlinux/packaging/packages/linux-tools/-/tree/main?ref_type=heads

> 
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> -- 
> 2.47.2
> 

Just got back from PTO so may have more comments later.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


