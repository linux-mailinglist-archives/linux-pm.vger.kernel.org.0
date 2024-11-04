Return-Path: <linux-pm+bounces-16975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9799BBA20
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70401F22970
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ECF1BF80C;
	Mon,  4 Nov 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewh2eyN0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2120326;
	Mon,  4 Nov 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737159; cv=none; b=loVDrpV7EJT5wXMY34OICe37VtJ4sd5zj0437HM20bbL2L/53G2ACkKxR/qEG8dIfqnYc1g0PsHyU17hoAFLTIWql3DUSjKibUGFfZZF/ZWb/m62kqnWE9/dylL96fq3HZodgrtOQysaUHrWABtD1z6I1KK+v1vg+yyD2LtzHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737159; c=relaxed/simple;
	bh=qcc5wwogCCg/3CJNiRaQIodFn92fQCPP7f4yo6Kd2gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bh86UkIWhx4gZ5iznOcp7opDfZibnt/d9JOA3jhF+iJjgHw3sHsBuTsIJdBdTjOXfonk7wMEot2J5iK7JZvsQc9tXvregZwCBel1f7sPdmhoiX2BeDNoAeYZzoqp0D0diuy8Aehcs+05YM4k5xrmTANKgnQ4NZidkAL3bmWghjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewh2eyN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F21EC4CED0;
	Mon,  4 Nov 2024 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737157;
	bh=qcc5wwogCCg/3CJNiRaQIodFn92fQCPP7f4yo6Kd2gQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ewh2eyN0rSwyj6hlvYv6jrozhOgemmrSUQAMbcvnf9Gu+0WTNdT7sdW+0Gz5rRvB7
	 Ttse6eVZ4EN6+gk3dmt8UDwvsJlHIWa29BAqk00iXI9KMWJdY58D3z+DgFMVieca7/
	 IRsEbTpgNGvXOGAjWJZxYC7Cj7gcESGMz4onNZW72nS5szOgT2030Lyl2XWV8bMq9T
	 CO3LYNPUP3POJRu/Nli16fi+mEwEQutzzAO0PIbQOGpFrrQaD9nlkFBC6GEiZyWDA2
	 qo2369Lf61XhNBoMvxojz/J7DMkW3DFi2I92huPRciL3aGSwibzVsFMoq67s2rb329
	 7iP8u87UsilmQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2689e7a941fso2080476fac.3;
        Mon, 04 Nov 2024 08:19:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHTnui2L334Hl0tHjVZVj55g2WCp0lWx7iJgq3zmcq7Aq59MZ8vIYKuPYcDbJevkeQdGc+7tRs7GY=@vger.kernel.org, AJvYcCXCw87Dga59bH/0hov+xxgQbfZ50gTpfIcQBWisq8tQCcgSkqJXrWws8cxHfObI6QSdteKYD46Ie2hKhdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4u1BkV/PerQMIxed8tLR31ZEl+APlHszi3JeGgeDf0vut+Edc
	jAd0v42RFRVe67HZKckHpVzMY9a53hMZQ3oZ4FFDjf06Yay/tjEeqOJNLyIgyBc9hKO4TUXySZa
	DhuSeZf7JAZvFpIwZQsrj0m2VZ2A=
X-Google-Smtp-Source: AGHT+IGn2HAJxmEr+MPsbJFZg9mVeGXRXBnu/wSwYab8tx6glELqAWWk0vxDLRL489Ez9uwHbaV7ogD9NYWrik7e1Iw=
X-Received: by 2002:a05:6871:69c2:b0:288:e7f2:e9f9 with SMTP id
 586e51a60fabf-2948449bce2mr13180420fac.11.1730737156606; Mon, 04 Nov 2024
 08:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6cbdeb08-5832-4089-b0b4-d7ae2b258811@linuxfoundation.org>
In-Reply-To: <6cbdeb08-5832-4089-b0b4-d7ae2b258811@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 17:19:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g3EJtMOHtHatwa9cZnKov7=np1gsBe7yuc-MQWaZxh2w@mail.gmail.com>
Message-ID: <CAJZ5v0g3EJtMOHtHatwa9cZnKov7=np1gsBe7yuc-MQWaZxh2w@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower second update for Linux 6.13-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Fri, Nov 1, 2024 at 11:49=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower second update for Linux 6.13-rc1.
>
> cpupower second update for Linux 6.13-rc1
>
> - add Chinese Simplified translation for cpufrequtils package
> - add checks for dependencies, xgettext and msgfmt before
>    attempting to generate GNU gettext Language Translations.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit b6a2dbf88aa793a288f77e0eddb395f7959490=
8f:
>
>    pm: cpupower: bindings: Add test to confirm cpu state is disabled (202=
4-10-02 14:50:23 -0600)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.13-rc1-update2
>
> for you to fetch changes up to 47d7650b9cb10381e5472840cf180a803f61fb0e:
>
>    cpupower: add checks for xgettext and msgfmt (2024-10-21 16:10:43 -060=
0)
>
> ----------------------------------------------------------------
> linux-cpupower-6.13-rc1-update2
>
> cpupower second update for Linux 6.13-rc1
>
> - add Chinese Simplified translation for cpufrequtils package
> - add checks for dependencies, xgettext and msgfmt before
>    attempting to generate GNU gettext Language Translations.
>
> ----------------------------------------------------------------
> Kieran Moy (1):
>        cpupower: Add Chinese Simplified translation
>
> Siddharth Menon (1):
>        cpupower: add checks for xgettext and msgfmt
>
>   tools/power/cpupower/Makefile    |  14 +-
>   tools/power/cpupower/po/zh_CN.po | 942 ++++++++++++++++++++++++++++++++=
+++++++
>   2 files changed, 955 insertions(+), 1 deletion(-)
>   create mode 100644 tools/power/cpupower/po/zh_CN.po
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!

