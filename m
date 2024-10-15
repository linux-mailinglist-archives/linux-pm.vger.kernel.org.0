Return-Path: <linux-pm+bounces-15687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CD799F746
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49AA284922
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929271B6CE3;
	Tue, 15 Oct 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0BZjtAS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5115C145;
	Tue, 15 Oct 2024 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020445; cv=none; b=Qc4xXlO09GVjnIwYQNZdPtnTlexqHg8tIyB8RkoZVDslE7GOY3b6G/3NnwWRGpjWePAs9EvhaTBQwrqNhKxH1EKSVKBjFWwTOjVEm6Q6ErOMhjoOnytzXSJuAbmVykrYD9YxW0rHBJdSWVVI41199GnlsOPpsf0D/rVdNAmTLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020445; c=relaxed/simple;
	bh=+kwRJEx1P1gm4ZlKKT/3XUreJqKphIJwpiDRDugkIoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcWh/v+LDEzXoqILZM+9fJV/dqS8gleEIZP5zuqjKabtfyxpOnrsgqi9P4lAEzZFeDadKThDJqjlpApa02xX1PG91S9WdINs2MaEkfdaWtSQt2KRbFOVSK4rhm+kpmRxfActGfSWdi2oLVaYPUXjXvc7DzqAVgBdFy/Yh+/Pnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0BZjtAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56F9C4CEC7;
	Tue, 15 Oct 2024 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729020444;
	bh=+kwRJEx1P1gm4ZlKKT/3XUreJqKphIJwpiDRDugkIoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f0BZjtASEqS3bTVEbT/p+7jW/+UkHnVprvuMQW4t2QwWhQAAgwVZoYqGt0EsN/9Tf
	 fAQD6iGc0KOx8BCMWDjGmkp+DcsAh+izFDJtd6/pQuXe1Os0m82X7y1Xtx/O7i6735
	 vNskZv3rAB08YbZwsbUuIZLZdoGSK2w36xCxpXRVHBBwHm5gzykONtBSTb+zTfoqKt
	 lqr6RV45+LxCGPkrXu/LwysHaDNYv8udDMlcWHXN9FOrn7P4lpN2qF0rZlA8E03Ihd
	 GKJTwhRz1+q4a/g7x5GAjnWd5a/0creLdWrVnTHsz8HIbAkHkNKeN4ciy0bI7TD99x
	 KzU7H+PtRkQRg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-288a90e4190so891715fac.0;
        Tue, 15 Oct 2024 12:27:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsHR1dwETVcfYU04YlIZBUJe2OljoxSez0a6eYMKGOCFrTZ63GmuH2WKgH8OGDOnkfZ2spU6q7TsI=@vger.kernel.org, AJvYcCXym25ow+/HTDLBLN2GxKaXPpHb64VMr0mVj0DYPuPNelc8BxhJavbs6IXi3XQFG7Y4eYTKdb57LXQIOTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70Pzy2a9/OgmCEsCsnN8Byq/WRilfF3+TY4PDQzl1XZPUyfMs
	FrXh2VpnggG+5HmjcOoilLeuV3AAz3A7tNWbU+VyZaeIJSLtRru5rC+ttmZCeXLiLarV2/MIeHS
	FN6W7fw3s2anveBDUKaYh8UPl02U=
X-Google-Smtp-Source: AGHT+IH1tVY7rQhSVW8XedkkQ1gXBAKbOr6hHPM5gTez/NDFMj7N3XKLcMBOq7gPXmSYPJOOi1xQAOuGZ6rlXUnRAY8=
X-Received: by 2002:a05:6870:89a4:b0:286:f9c3:ed78 with SMTP id
 586e51a60fabf-28887477421mr7568029fac.36.1729020444230; Tue, 15 Oct 2024
 12:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9e75c82-77c5-4f10-972f-14dbc2b70843@linuxfoundation.org>
In-Reply-To: <c9e75c82-77c5-4f10-972f-14dbc2b70843@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Oct 2024 21:27:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iekYv-sV6seygiTvZmY_xdSwAHZb6G3OZGCP8fWQMaEA@mail.gmail.com>
Message-ID: <CAJZ5v0iekYv-sV6seygiTvZmY_xdSwAHZb6G3OZGCP8fWQMaEA@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.13-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Sat, Oct 12, 2024 at 12:45=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.13-rc1.
>
> This cpupower update for Linux 6.13-rc1 consists of changes to:
>
> -- bindings:
>     - add generated files to gitignore
>     - improve disable c_state block
>     - new test to confirm cpu state is disabled
>
> -- bench:
>     - print config file path when open cpufreq-bench.conf fails
>
> -- Makefile
>     - override cross-compiling env params to make it easier for builds
>       in Yocto environment.
>
> -- add documentation for new EPP value change, amd_pstate mode change,
>     and turbo-boost features.
>
> diff is attached.
>
> Sending it early to get the Yacto build available in next.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758e=
dc:
>
>    Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.13-rc1
>
> for you to fetch changes up to b6a2dbf88aa793a288f77e0eddb395f79594908f:
>
>    pm: cpupower: bindings: Add test to confirm cpu state is disabled (202=
4-10-02 14:50:23 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.13-rc1
>
> This cpupower update for Linux 6.13-rc1 consists of changes to:
>
> -- bindings:
>     - add generated files to gitignore
>     - improve disable c_state block
>     - new test to confirm cpu state is disabled
>
> -- bench:
>     - print config file path when open cpufreq-bench.conf fails
>
> -- Makefile
>     - override cross-compiling env params to make it easier for builds
>       in Yocto environment.
>
> -- add documentation for new EPP value change, amd_pstate mode change,
>     and turbo-boost features.
>
> ----------------------------------------------------------------
> John B. Wyatt IV (3):
>        pm: cpupower: gitignore: Add compile_commands.json
>        pm: cpupower: bindings: Improve disable c_state block
>        pm: cpupower: bindings: Add test to confirm cpu state is disabled
>
> Peng Fan (2):
>        pm: cpupower: bench: print config file path when open cpufreq-benc=
h.conf fails
>        pm: cpupower: Makefile: Allow overriding cross-compiling env param=
s
>
> Tor Vic (1):
>        tools/power/cpupower: Add documentation for some recently introduc=
ed options
>
>   tools/power/cpupower/.gitignore                    |  3 ++
>   tools/power/cpupower/Makefile                      | 12 +++----
>   tools/power/cpupower/bench/parse.c                 |  5 +--
>   .../bindings/python/test_raw_pylibcpupower.py      | 28 ++++++++++++---=
-
>   tools/power/cpupower/man/cpupower-set.1            | 38 +++++++++++++++=
+++++--
>   5 files changed, 70 insertions(+), 16 deletions(-)
> ----------------------------------------------------------------

Pulled, thanks!

Sorry for the delay, I'll add it to the linux-next branch tomorrow.

