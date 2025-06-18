Return-Path: <linux-pm+bounces-29010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74368ADF6ED
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 21:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AD656216E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1521859A;
	Wed, 18 Jun 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpTAXfyG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD1207A0B;
	Wed, 18 Jun 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275336; cv=none; b=pnrsbg+VIiotBKb+oQfb/DRtgdxeICUbtI3u8nOYohEyinUoBpDSyQ4EdTV0IioVg+sQW3QcUHTlfM/EPIKq19y33YK966mukvV4h4iILckAr9jm9AgmYAbvGz6Ab6Ri2PUty2UZVBN5h/mFUc4BANIFRVvMlOSWq3OZZeXw62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275336; c=relaxed/simple;
	bh=ibZCNLRyeEMp+DU8vDaNixDMjljfDwBaUO2seybxd2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNHjZDkGiEpvmhjFDt94pvh3LcDlISWH5iC6Qg5ykzcupxv6WmbjYS1tBbc0zR9ngnYBWN2dpSAOvMtf2wqMHwo9GXcGvYoMOscX8RGVPaQkqmAI/cNBEKWSA2S3VtztvcbnKsjhAaM9YEDzhrv5IilPgpFF1DglXvQE9MlwstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpTAXfyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF59C4AF0B;
	Wed, 18 Jun 2025 19:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750275336;
	bh=ibZCNLRyeEMp+DU8vDaNixDMjljfDwBaUO2seybxd2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NpTAXfyGXdCjS6PWbYMCZTjgtd1G0PkHgIQD2pOfWdw9wmflp32cDCM/dx3itLwhH
	 0qvAfD18XtMUyyba6lnZZxue+QnMfxUbs2/YHv4AAjZeRH+RZegPGqaXM3LHY+UMZ5
	 s332Xude62F911i+uyGA7+znyEKySDsMIlRr1EjQKM7BhtoQnQdoZSUP1gYPCoNNkZ
	 nQcDSy22cwKfDTYKZHQ28RaoEQPZHkwwTLOQ7lNZsMKq5CsTCVJ8uGwHuvApdGe9xU
	 XFc4ap8CGEiUnY40t5i1v4nWCE8a7OmtdXVjXiq9dJp4GtUKPd9dk3yYoo3vdliYel
	 5h5j2ltn1hPNQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6114114daddso11425eaf.2;
        Wed, 18 Jun 2025 12:35:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvH6swtq6QsD0N1YRVH8eJqJO1ye5lkueiVPiqTCceH2TfpdiYXrXesdm+nGNKfbfWgkkhEYiS854=@vger.kernel.org, AJvYcCVpMSpaxHSnf14JjKuaKhIY9HOAWtXKdPLhjZmKp1Hy7dp5kqGF7B0Iz1i2DyCAOkTufG2GzFChVp4WM5mg@vger.kernel.org, AJvYcCXXPNKBFiO66+cKDhT/tjpCssAPRHOR71fLWjLFbZJyOsRP5k/O/66sPlzj9QIQx0jQcD1UY4slgLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmLMEZrHQCPlSjE4Y7PpwAEp6s6pAQxkLy0VOyvnZxm3kFH8M
	fUD78QvX9qK9qEWnjAsn4sDGO89lq9Sbv91kHGftHncZe1QhyySbd0hrf1/3uQK83/6YJjcX31v
	xhyp4lhxKbbpA4gIl/QXvIWqjJOB6Et8=
X-Google-Smtp-Source: AGHT+IHDWpKnlspa0o+43owsaQjOcACO5glECALOewcb8dOxPPJptp3Q1tEf7PrM3unhD/hjfgTMkjT3X4sR0vRZSvQ=
X-Received: by 2002:a05:6820:160a:b0:60d:66ff:fd44 with SMTP id
 006d021491bc7-61110ff376cmr10689322eaf.8.1750275335287; Wed, 18 Jun 2025
 12:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>
In-Reply-To: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 21:35:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ipapmw==9rePsnsdUt_Ks1duLfFKs+qU8s4q44XAfuGA@mail.gmail.com>
X-Gm-Features: AX0GCFviGfa9ZO3aB4JfHcU-SqMz9qMQ0GhpaAIntMXfAPC_uU4vedN7Zx3F7ns
Message-ID: <CAJZ5v0ipapmw==9rePsnsdUt_Ks1duLfFKs+qU8s4q44XAfuGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cpufreq: userspace: add CPUFREQ_GOV_STRICT_TARGET flag
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
	20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 3:00=E2=80=AFPM Shashank Balaji
<shashank.mahadasyam@sony.com> wrote:
>
> In-Reply-To: 20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
> Changes in v2:
> - Instead of modifying the documentation to say that variation in frequen=
cy is
> possible despite setting scaling_setspeed, add the CPUFREQ_GOV_STRICT_TAR=
GET
> flag to the userspace governor to make its behaviour match the expectatio=
n when
> used with the intel_pstate driver with HWP enabled
> - Mention in the documentation that variation in frequency due to hardwar=
e
> factors is possible
> - Link to v1: https://lore.kernel.org/r/20250522-userspace-governor-doc-v=
1-1-c8a038e39084@sony.com
>
> ---
> Shashank Balaji (2):
>       cpufreq: userspace: set CPUFREQ_GOV_STRICT_TARGET flag
>       cpufreq, docs: userspace: mention variation in freq due to hw coord=
ination
>
>  Documentation/admin-guide/pm/cpufreq.rst | 4 +++-
>  drivers/cpufreq/cpufreq_userspace.c      | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> ---

Both patches applied as 6.17 material, thanks!

