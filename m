Return-Path: <linux-pm+bounces-28406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402ACAD4267
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 21:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16368189F774
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 19:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7A25DAE8;
	Tue, 10 Jun 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGh0TMV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB01AAA29;
	Tue, 10 Jun 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582121; cv=none; b=BdtWQ+TZSAze6vKsIn9GWh+1kuSU9qlg6DXQe4vJlDslvpORErwPM1FzWrUYrj7a5/tJantVd78XQ737gPOrc4PzLl/HvrIoVP0N0HcdBALsOkW7ecud9vo6e0hdVXlinTSM9cuv3ueCd23y+L/RNwgePnu4+3cut3ixvonUm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582121; c=relaxed/simple;
	bh=4S/1UkKdaVmCq84FpA74723iMquEj+Z1lqgTsvWJcrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdOW+oZkp0wyqErt/IH6XOUhphJIaoosHXp7Cq+PoxSTzBJVhXD1vi2iyxOjCpQNxAj8jogirCXPdN/d7jKxY5Ll5Hhz0aidOoJSIgofE5mQg/bnR1Fx1IntRVMJ4ogiDj6yxBWrM6IbYD9JQ6hg3sZmwdwXlir56S94Kq/wWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGh0TMV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC94C4CEED;
	Tue, 10 Jun 2025 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749582120;
	bh=4S/1UkKdaVmCq84FpA74723iMquEj+Z1lqgTsvWJcrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dGh0TMV+PTJf8jpIa3GnGDFFxFE9OqZB6amw7k529q8WrITwmCo3MEXOlL6nNqq5K
	 JsYTQHMTAzqRL8qhBvc8+0fxsVdGtwcreT1I8U6KyKtoYQVSbn59EwMSArkaNOcne3
	 kERBUoNKdqaTypH8MdkBjR1gJTMfX8ORbNR+T3ZXPhHNLpzVC3dToBELdfHKDuOr/A
	 sXsWDyFHJrzVchdzg3K9M8mF7+eyGha7uLopHfpaRX+JHmmI6r63MiNmq91rPHkOFi
	 wg/0X0V1Jv8X7+KL2B0k6A56p8GbnM8GtbN/X10jAqzOcaE90bCJULtcJIQruf0qXP
	 5EyL7SM9I3YDQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2d0920ce388so2896843fac.0;
        Tue, 10 Jun 2025 12:02:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVegR1VcIrZsuk/czIXxP8nhchK/Xi7ALShEQVcDUIDHKVKYU7u1U9Dz6q5Annl7rkDWBc9pUNA9ik=@vger.kernel.org, AJvYcCWFRh1rfvr79SsjAS3bJxdw20XnMnVI6yG+kkjtdIIvOjLf/CmjjgHaVNQ8EPRO1t9MPbnjZ8OEs/cE1VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxuAZcZIzf0tTls6fdShKYJX46b5w5vH2hYm9XJ08NG0sGaR1g
	0eGlACjd4/Q2WLSpy9PG+5masggtfSfeZuXfGoPz+W6Y03x9ZRiA+5Ox9e9cFGwnN6S3wJjNNRU
	Jr94htr2lBO868NtuTmT6cqdPdRJSyN4=
X-Google-Smtp-Source: AGHT+IEfHETqXj3BAsLgdQ4AVCIgPE+WnuBRf4symV/b7gLRyCs+GuAHjQfHulFgVo40e6GhO4NKRj7IX02uB4ddAqM=
X-Received: by 2002:a05:6871:330b:b0:2c1:62e9:584b with SMTP id
 586e51a60fabf-2ea96ffde0cmr280949fac.39.1749582120228; Tue, 10 Jun 2025
 12:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab7fe518-0177-4178-a40d-51e0a5fbe8aa@linuxfoundation.org>
In-Reply-To: <ab7fe518-0177-4178-a40d-51e0a5fbe8aa@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Jun 2025 21:01:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+HAqH-aG9R86eWtnbv0cSUUBiMV1Fdt+VEhm3y2F=KA@mail.gmail.com>
X-Gm-Features: AX0GCFt-RuA_b-R9Pf445uj94L6GZJNA-7svlDSPCsip6h3JixVSFU5NvtO2SMk
Message-ID: <CAJZ5v0h+HAqH-aG9R86eWtnbv0cSUUBiMV1Fdt+VEhm3y2F=KA@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower urgent fix for Linux 6.16-rc2
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, Thomas Renninger <trenn@suse.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, Jun 10, 2025 at 5:37=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull this cpupower urgent fix for Linux 6.16-rc2.
>
> Add unitdir variable for specifying the location to install systemd
> service units instead of installing under ${libdir}/systemd/system
> which doesn't work on some distributions.
>
> Note: I meant to send this during the merge window and ran into some
> merge conflicts during the PR test. Decided to wait on it until rc1.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:
>
>    Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.16-rc2-fixes
>
> for you to fetch changes up to e044b8a9545cd8265c7110c179aeec2624c16455:
>
>    cpupower: split unitdir from libdir in Makefile (2025-06-09 10:17:46 -=
0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.16-rc2-fixes
>
> Add unitdir variable for specifying the location to install systemd
> service units instead of installing under ${libdir}/systemd/system
> which doesn't work on some distributions.
>
> ----------------------------------------------------------------
> Francesco Poli (wintermute) (1):
>        cpupower: split unitdir from libdir in Makefile
>
>   tools/power/cpupower/Makefile | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/fixes, thanks!

