Return-Path: <linux-pm+bounces-27509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DACCAC0ABA
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 13:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5964E4B69
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369E28A1CC;
	Thu, 22 May 2025 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VV1CP/2l"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348818AE2
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914243; cv=none; b=KGp6mRLopxjmzR7RPUgQE23dYSF7XvSlxgW5fbU67O42wAtb+D6X7zO4wXytqmf75jvQBIyuR55WJPVNemWLdCbMuKsPZ+hF9zbCEaEEOKWcRoireaIt7FgW4sE0M4u1ZHHmi/GTEqNFsHaU5GGC8i+v9XNCqkq+V/fI/ED7YYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914243; c=relaxed/simple;
	bh=ddztaC93XsxXspd5f83K4Tqr+OAVb8jVQZWVa2DOFZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyCKGpu6+XrR3Hi/g1/IBMFHq7vyQyNZvVtlC0nCDBZD6xqlbMPH7Jk2jUSHH9RWsZB0m7A/VJ4prx3eTqh+tZ1N6a7y5ZHlCM0QInyodN4VueaTLrWIrsZXj8U6Q61oNhJJz1+r640Fr4khk0R7r7hcfStFqTpVOjDXDsNvd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VV1CP/2l; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ao5pSf3NGDn3Ek7X1VvDzRrHSsrUaYrxQb1kPX/zF4U=; t=1747914240;
	x=1748346240; b=VV1CP/2lz8ibaZCMspipkjEYZdAuOyRpu3VayMU9tpyUHFs2e5gxihZqE+DJD
	P9qraT7utIl0K2mH9F5sr2pu2HgkZpcZrtsaM1CDq8eX7CeppyiFVLl0r+C2YTXPiJCDtklJZ52oF
	XLgayiGjcecMKZprohVDA8IJSCcKPJGy+QZCdJ83igTf3L2AZhBkePjUZ97rPKGaID5Hj35AbhRoy
	7Vf3XqRQHCtH8MlpnZXT1Oeh7PQv8mPTKUoK53O+OjshYU6Qd8l2DGtfFhoEKAAws9JrYLyd+Gvy5
	333+DBkhdvJPCcSiUA/qqMxv1+KiipvT7j856FjMW5Hphz18rw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1uI4L2-007FXu-19;
	Thu, 22 May 2025 13:43:52 +0200
Message-ID: <6deefc69-856e-44d7-b970-2f0127090539@leemhuis.info>
Date: Thu, 22 May 2025 13:43:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: split unitdir from libdir in Makefile
To: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>,
 linux-pm list <linux-pm@vger.kernel.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Justin Forbes <jforbes@redhat.com>
References: <20250521211656.65646-1-invernomuto@paranoici.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20250521211656.65646-1-invernomuto@paranoici.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1747914240;036afa35;
X-HE-SMSGID: 1uI4L2-007FXu-19

On 21.05.25 23:14, Francesco Poli (wintermute) wrote:
> Improve the installation procedure for the systemd service unit
> 'cpupower.service', to be more flexible. Some distros install libraries
> to /usr/lib64/, but systemd service units have to be installed to
> /usr/lib/systemd/system: as a consequence, the installation procedure
> should not assume that systemd service units can be installed to
> ${libdir}/systemd/system ...
> Define a dedicated variable ("unitdir") in the Makefile.

Many thx for doing this!

Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Nitpicking:

> Link: https://lore.kernel.org/linux-pm/260b6d79-ab61-43b7-a0eb-813e257bc028@leemhuis.info/T/#m0601940ab439d5cbd288819d2af190ce59e810e6
> 
> Fixes: 9c70b779ad91 ("cpupower: add a systemd service to run cpupower")

There should be no blank line between those two lines.

And you should use
https://lore.kernel.org/linux-pm/16ad2364-0161-4724-90e1-b57559168843@leemhuis.info/
as URL after "Link:", as it is shorter. That's the URL you get to when
you open
https://lore.kernel.org/linux-pm/260b6d79-ab61-43b7-a0eb-813e257bc028@leemhuis.info/T/#m0601940ab439d5cbd288819d2af190ce59e810e6
and hit "permalink".

Some maintainers might reject patches due to such aspects, so I thought
it was better to let you know this before it causes trouble sooner or later.

Thx again! Ciao, Thorsten


> Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
> ---
>  tools/power/cpupower/Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index be8dfac14076..c43db1c41205 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -73,6 +73,7 @@ sbindir ?=	/usr/sbin
>  mandir ?=	/usr/man
>  libdir ?=	/usr/lib
>  libexecdir ?=	/usr/libexec
> +unitdir ?=	/usr/lib/systemd/system
>  includedir ?=	/usr/include
>  localedir ?=	/usr/share/locale
>  docdir ?=       /usr/share/doc/packages/cpupower
> @@ -309,9 +310,9 @@ install-tools: $(OUTPUT)cpupower
>  	$(INSTALL_DATA) cpupower-service.conf '$(DESTDIR)${confdir}'
>  	$(INSTALL) -d $(DESTDIR)${libexecdir}
>  	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
> -	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
> -	sed 's|___CDIR___|${confdir}|; s|___LDIR___|${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
> -	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
> +	$(INSTALL) -d $(DESTDIR)${unitdir}
> +	sed 's|___CDIR___|${confdir}|; s|___LDIR___|${libexecdir}|' cpupower.service.in > '$(DESTDIR)${unitdir}/cpupower.service'
> +	$(SETPERM_DATA) '$(DESTDIR)${unitdir}/cpupower.service'
>  
>  install-man:
>  	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
> @@ -348,7 +349,7 @@ uninstall:
>  	- rm -f $(DESTDIR)${bindir}/utils/cpupower
>  	- rm -f $(DESTDIR)${confdir}cpupower-service.conf
>  	- rm -f $(DESTDIR)${libexecdir}/cpupower
> -	- rm -f $(DESTDIR)${libdir}/systemd/system/cpupower.service
> +	- rm -f $(DESTDIR)${unitdir}/cpupower.service
>  	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
>  	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
>  	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-info.1
> 
> base-commit: e5174365c13246ed8fd2d40900edec37be6f7a34


