Return-Path: <linux-pm+bounces-25768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC29A94C45
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504CC3A70CC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0059D257AF5;
	Mon, 21 Apr 2025 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcMAfeU5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04B257AE7;
	Mon, 21 Apr 2025 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214777; cv=none; b=dHE+bYFvOPk9GeiGtCWCgAXz5TtfLFFkP3Ajrv770TYQOLdfyKqJcKqrsuWeeMQU4SAwP4Uw9d6In4Dn8khbHnoLNbtBwcRonhzDg4jg1a1ruwTIN2ynIXfxcuf/5gWKidWIk8CS4jxu4ZDYAYff5pdvmTvKqArPGCEItlKeJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214777; c=relaxed/simple;
	bh=kscSWFnRLUJNhjABaNneTFqbF7Hw1ZSHk8dlTGfuVFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yp8ZnC4jsY5Kdm3tSqscNPsc17/JPgyNCyH8z8Du4ec8AuM6BEZOvts1StwgdBhXt+/rctUQMujST/vZMVEvy8tFSCT6w4fS8bf0XTVdRBGyg7FxHqW6neUfz5QpyNxjeSZEKZfDTqa7UrxJ5HB+8DnQp7YCwfeQw8E+79p9zCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcMAfeU5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso35996051fa.3;
        Sun, 20 Apr 2025 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745214774; x=1745819574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7rmrjTeX1yWFT3hHcREaOvvsJDAwlPSldOXeGpcxzY=;
        b=KcMAfeU5JHxrczXMLVTuixNkoc5TakCqfeLeFrXKyYgkPOSBbFYLIVH+cOOAU3akeo
         Bk8FvfJbiW6i/tIq9gndqe53HcCW5QAjzT1UL8zFSJPJtIOrV24+T2+D3ixm8zePlmee
         +rPToMZ8nUnYvKU622j8q+XBdCDx6gXTJRkGKAm7RzeKERtjX1btZoKfEeqPbT0OJPI8
         k8a2iob8WGyobp1DtqtxzJ87j0NlXzfh+lLV7WCgPxa/uvHjBE10FoI0jnvvPg/q38Z3
         1szMrjVljO9nWDmoAOshvxEyDRJBVE+hbBvRr50ArtgixaPVM/arKnsdiL27YzQvT9Ry
         bl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745214774; x=1745819574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7rmrjTeX1yWFT3hHcREaOvvsJDAwlPSldOXeGpcxzY=;
        b=SZviaklDGF7/qAxaqhme5PvqaJpDx/4OsgAh3QqQ83Dsqu1V74FKhE8KFodULJVTk3
         oR+Xhcif3SQwLMIDZgl0yVNOFLjCugB3YIiv6qGxhDZAs+YDkSv/35YfzF+PQA1Wgw52
         i+kDPpt2kWWXQTivv7r5I92d1wehAsomZy9vVYN9fEcu5/W+UzDgkDIanau8M2Tqq/GP
         hFP4p0vNVDv4q+oh556Edl4HRzv4qrraGeoPs00b4n9rIw3acUkCukRlwx6nkjntcxcz
         FNFloVEQCpeCkz8IJVj+GenhPnZkqz6ZPuH3OQCtTwMMehefW89IX5eExs5eZ1EL8tqU
         K57A==
X-Forwarded-Encrypted: i=1; AJvYcCV0qcGpH5lQ09JWcyGT1gHydxirQ7pQN4r3fK2CGDUZG9/BaqG4Vy4ctK0wEUmkVYhJZZPKalxnXjk=@vger.kernel.org, AJvYcCXBfj7zsrJaBHK1q2WiMaGFwVxQApB7gOBDH3TYH/T4xbYBXL/2Q4ZQce+rxHP9/scT3QDghaL1uhUsBUU=@vger.kernel.org, AJvYcCXIzA42i+up7eberpxxp+0QTsidFhMPkVL90l6Lfu/h3tpJ0SgukRGMoqgTFyrtPuAGFxGWyugB26z7TWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZy/vTp/xKaakvW2XDYCulzlRLajzMUPqIMke8Vhu5QLl9gJp
	Qb38xxeEf/Qi49LFZY4PN/F9G2ku1Mu94OAZizuKskjgSPCJptYTplG1xQy5wT5qBvjUxkN8QDk
	E9aNa7aMLMFDyaCJCw/C6OJRBKqM=
X-Gm-Gg: ASbGnctQpWTzWCwJnVVGk/H5HCPV1jTEH+r8uIe2Qb1j1sLzbYvNFwlTnUVsEwtyYXZ
	xsIU5RIrpIhkunQ43tgGbuGbyPgOEimH18IJ94xhryRXcq7fo/R3HKg4PDYbQVQuGIr5KcL/3yl
	iVqhapk0VCJ2SBV3vn3OyTog==
X-Google-Smtp-Source: AGHT+IGMRyjDx5rOQz2UIuP/EAdxpzrvvwRlw8xLaTB1ACdWnh4xiEdywdsUc7m8mKEfNgh2AqpiDAiTF/9piCp/iuw=
X-Received: by 2002:a05:651c:994:b0:310:856b:6875 with SMTP id
 38308e7fff4ca-310904d5e55mr23407681fa.14.1745214773876; Sun, 20 Apr 2025
 22:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
 <20250420-tegra124-cpufreq-v1-2-0a47fe126091@gmail.com> <20250421054555.oavale3xjqlrc236@vireshk-i7>
In-Reply-To: <20250421054555.oavale3xjqlrc236@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 21 Apr 2025 00:52:42 -0500
X-Gm-Features: ATxdqUEBdC9vjv0mOf_Uas6FzXG_i9MJfQLUpMb6r-WdKxPm5ZSSF28JtrH3vUU
Message-ID: <CALHNRZ-1XfbN8nOt33Ktsq9z2cjGL8AiWKEZwigXO6OYd64fFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: tegra124: Allow building as a module
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 12:45=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 20-04-25, 15:42, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This requires a soft dependency on cpufreq-dt as this driver only
> > handles power management and cpufreq-dt does the real operations. Other
> > than that, this works fine as a module, so allow building as such.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/cpufreq/Kconfig.arm        | 2 +-
> >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 4f9cb943d945c244eb2b29f543d14df6cac4e5d4..625f6fbdaaf5fd774e3b0bb=
996eb7ce980da41ee 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -238,7 +238,7 @@ config ARM_TEGRA20_CPUFREQ
> >         This adds the CPUFreq driver support for Tegra20/30 SOCs.
> >
> >  config ARM_TEGRA124_CPUFREQ
> > -     bool "Tegra124 CPUFreq support"
> > +     tristate "Tegra124 CPUFreq support"
> >       depends on ARCH_TEGRA || COMPILE_TEST
> >       depends on CPUFREQ_DT
> >       default y
> > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra=
124-cpufreq.c
> > index 514146d98bca2d8aa59980a14dff3487cd8045f6..9e46b53487fafdc1e9e95e7=
65b9b490d9c95f2c6 100644
> > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > @@ -211,5 +211,7 @@ static int __init tegra_cpufreq_init(void)
> >  }
> >  module_init(tegra_cpufreq_init);
> >
> > +MODULE_SOFTDEP("pre: cpufreq-dt");
> >  MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
> >  MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
> > +MODULE_LICENSE("GPL");
>
> Can you try inserting/removing/and inserting the driver again ? I
> believe it will lead to some failures as no cleanup is being done by
> the driver.
lsmod lists the module as "[permanent]" and if I try to rmmod the
module, the command throws 'device or resource busy'.

Sincerely,
Aaron

