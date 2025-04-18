Return-Path: <linux-pm+bounces-25728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A79A93E32
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 21:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1341B619A7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916B225766;
	Fri, 18 Apr 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+FtPGFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4121D3EF;
	Fri, 18 Apr 2025 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004535; cv=none; b=WyeuqgZKmJiQAtGEYZTzGmlzBNxypU2m9tLD7X0u3/cN05qpjak0orkdzBj3DTVb8M4yxo0tsA7u7fIm5Rxa09vBP7QhK5RbFFqD+D22SoQ+HBaPgQlN0Hu/k2R1R7EuXQ7JYH2ZO1wSUICfAuB3hA/v0e7v3cyicJZpXhfIc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004535; c=relaxed/simple;
	bh=+TbOaJ7dNqY0CeX/LfGFTz9EnPyPI3Sqdi/0xWcLcrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EORSR+wR2TayZE4EepA/XtUZKNvycoO7a+iBIgmkRjE8LJ4zyT4FGOoJiUYZwEEXmtmcr3yhgRTKtDM8Z7cuL+Irm7AQP7HSWpGwyCUe0koV5IlW/wBmCg8B0QIXbW0WNu9TbAkSdxcpuf/O3VEciVbX0PyRthq8WKv+oPxFKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+FtPGFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE90FC4CEED;
	Fri, 18 Apr 2025 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745004533;
	bh=+TbOaJ7dNqY0CeX/LfGFTz9EnPyPI3Sqdi/0xWcLcrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z+FtPGFYPxElCaQNM++iHDNFZqYBN58/56/31qslxNyKHZ6+9bw9WIX57KZtFYPDY
	 NGE+1fu+o1Iwwg+Pn5Txh73pK0d4RgTNw/nthfc94E/SCmu5db1sEKV2LblGwTWoeE
	 fZni4Sk1mx4Z9t/7ASfc9C9vPw8fOTMcXcoJCqzA3WQ71Xk+8epvAFwsh5vENCOXPP
	 E+6QFWWwpZQ5105lY07E5VjUYCA86H4om0FCJ12YsjKE1VSjdXOiBLRDtPQGVn2fAZ
	 PPjDlRMJn2m5x1K+47TL10fi8MXKnSFj1we/pvHe6JLcQ9Lpnmjb5I8MKrCFZooOBa
	 SO76PEQDVzPUQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c6f27599abso571547fac.2;
        Fri, 18 Apr 2025 12:28:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+/5o87CdprFhIAIOEO6av+3CxScJQ5rSLLVZJkm3BGGJDFlWybhAjxNN+Ks6seBI0eKy5QYB+Hew=@vger.kernel.org, AJvYcCVtUgYILkUdbOu/4mtkQJDgWZYEZzH6DpPVrkgbtYIWfjeB0my5410COCp7fuB5LLGBZpXx7gDSyfelvw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fTzxyAyj0oS00CiYW48UUHLZoiGxVTm2FwiroCAXwFMYsEOD
	Z2NsZJacvdQVdcPoqOZNzJGCn8nQxqfnGH3Ydyk6xCrjoBCWZnRXBfVCWAk0YXo+kpHXitHgyzq
	urlTn0Qpb1l4mDTmBB+EFclWMr0k=
X-Google-Smtp-Source: AGHT+IGGCRL7igPjBrqktCEi13enWNNdUGzb0JAZ2xwmpzD25HADrBysg3O9yOFOkQTwaACvbdYoFPy82OF5AhAMg8g=
X-Received: by 2002:a05:6871:613:b0:2c1:62ba:cd7c with SMTP id
 586e51a60fabf-2d5269d6991mr2033698fac.15.1745004533066; Fri, 18 Apr 2025
 12:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com> <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7> <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com> <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
In-Reply-To: <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Apr 2025 21:28:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
X-Gm-Features: ATxdqUHZf3vRhVwstEV-HPbDHWIsTs8CoNOzeZ2Mo3-FPjyj-w-6Pd3im33lTT0
Message-ID: <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Nicholas Chin <nic.c3.14@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	vincent.guittot@linaro.org, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 7:06=E2=80=AFPM Nicholas Chin <nic.c3.14@gmail.com>=
 wrote:
>
> On 2025-04-17 23:58, Viresh Kumar wrote:
> > What about something like this instead ? Nicholas, can you give this a =
try
> > along with the $Subject patch (both patches should be applied) ?
> >
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpuf=
req.c
> > index 924314cdeebc..71557f2ac22a 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -909,8 +909,10 @@ static int acpi_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)
> >         if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].fr=
equency)
> >                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
> >
> > -       if (acpi_cpufreq_driver.set_boost)
> > +       if (acpi_cpufreq_driver.set_boost) {
> >                 policy->boost_supported =3D true;
> > +               policy->boost_enabled =3D boost_state(cpu);

So it updates policy->boost_enabled in accordance with the current
setting in the MSR.

IMO it would be better to update the MSR in accordance with
policy->boost_enabled or users may get confused if their boost
settings change after a suspend-resume cycle.  Or have I got lost
completely?

> > +       }
> >
> >         return result;
>
> Thanks, applying this patch along with the $Subject patch works.

