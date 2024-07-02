Return-Path: <linux-pm+bounces-10377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E269992479A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200021C225D0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB71CB32F;
	Tue,  2 Jul 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsfFomf+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FBC1C8FDD;
	Tue,  2 Jul 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946426; cv=none; b=Vepm9AgbVLZDzFjnnHeIT77YwpB0w9JcAy/l9PSjPEvq7CWJ/hb9w4g8sHXc5jTL+J/8FSZP13U4SmocHyAFYBgVkpZ0GY3V0JEvnJj5C3z2kdJ5jFiKH+y5ebaMLS/gPqI+w2Ax+QQBBZqQTr6hUhjC6nMF+QlADq5Xf/Wt87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946426; c=relaxed/simple;
	bh=ezJf6cLaqU3OnSCRVrefYWZmn43HHxW31pSvgc4jH2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSp3joNkCYzZWOADuC0Mk/Cd579wIo3YBpVXOyqiRF6uDq/18FRjvqY+B1dWMEJcf7ApIKi7oiQREe0puXrqZmrV+3fEyWgxFuFJd+excZTk4SLIjQtRHkLnU/HL9J0pDfl1pjq0WI+kxitRFJ9ANhiz1RXsVGHFAuC+D882y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsfFomf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF92C116B1;
	Tue,  2 Jul 2024 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719946425;
	bh=ezJf6cLaqU3OnSCRVrefYWZmn43HHxW31pSvgc4jH2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SsfFomf+Ctm4KESy4B1sUPqJEIJvRCrqdGStCuhWaTU36j2uizlvsKqh93R+XpY3F
	 UwtyvJup62dMUxM+TB6bQV/9tLpVmzfHLptK2g9bg9FXVZmywQNgrr+8am1Z1PVvbh
	 9lKemZ25TBwc5XkDIqU5RKPLDkpd6mzGY+5hEC3K9P/D1wXMK6eoY1lAHUy3mRZofz
	 KZiAKblSFCSt1h9RepBXuhqjaJJbIjyB1p2vBbFu89GnOLHYsjpoiQey8CyQUlsSbL
	 Elq2/hRQdrUEtwyXq2q2hXFprDasvr75FeFs6fqNrlQi6a9Kkly0oT4nSCXPoMzBaq
	 ZWJQX74ruQEQg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-254c411d816so553029fac.1;
        Tue, 02 Jul 2024 11:53:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL8DHQoJqeqlE5hdVLBseXOcSPvr1Y3eIIgSWcgWjaNh+Vy27KAUQ5aNubHvl3zhhaOe7AeyhrKJrUvcwYApLlEotaGkFxTtDk1QCDZP59zjYxCVfEG/2lHdONr5bknhI3dP01/ImfUUE80AfGUppS8jqPH6/cE5QDd31qF+jZ9Ak=
X-Gm-Message-State: AOJu0Yz+1YLV0NEVsIvd1qri9jEnvlJSHMK7qMUG1IkE9TeSg8ARxJk3
	XUWDHBYKuijwlmM3Fqoqe2xBirprVmqUN17OpoVp4STmYocX6ECpiVhiZVKmZklmEJP5QNsTzgQ
	7Gp1FYRVeaccNMXsaLAl5AoNAjRQ=
X-Google-Smtp-Source: AGHT+IH88BNJJAfIkTe9YwM6yk4Q9nUPD87bjmV/cCgwWZrppHPLHSFtxPXZkRQGaR/cLenYUP4dAz4hXdrm8cmeLng=
X-Received: by 2002:a05:6871:24d9:b0:25e:922:57ac with SMTP id
 586e51a60fabf-25e092258c3mr364021fac.1.1719946424777; Tue, 02 Jul 2024
 11:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701171040.369030-1-rgallaispou@gmail.com> <20240702043658.jwumgakxplddqlnx@vireshk-i7>
In-Reply-To: <20240702043658.jwumgakxplddqlnx@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 20:53:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0giVPfjJKvZKc1GGk6Rb247ra1Laay167ALD0BQZs8D9w@mail.gmail.com>
Message-ID: <CAJZ5v0giVPfjJKvZKc1GGk6Rb247ra1Laay167ALD0BQZs8D9w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: docs: Add missing scaling_available_frequencies description
To: Viresh Kumar <viresh.kumar@linaro.org>, Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:37=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 01-07-24, 19:10, Raphael Gallais-Pou wrote:
> > Add a description of the scaling_available_frequencies attribute in
> > sysfs to the documentation.
> >
> > Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> > ---
> >  Documentation/admin-guide/pm/cpufreq.rst | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/a=
dmin-guide/pm/cpufreq.rst
> > index 6adb7988e0eb..fe1be4ad88cb 100644
> > --- a/Documentation/admin-guide/pm/cpufreq.rst
> > +++ b/Documentation/admin-guide/pm/cpufreq.rst
> > @@ -267,6 +267,10 @@ are the following:
> >  ``related_cpus``
> >       List of all (online and offline) CPUs belonging to this policy.
> >
> > +``scaling_available_frequencies``
> > +     List of available frequencies of the CPUs belonging to this polic=
y
> > +     (in kHz).
> > +
> >  ``scaling_available_governors``
> >       List of ``CPUFreq`` scaling governors present in the kernel that =
can
> >       be attached to this policy or (if the |intel_pstate| scaling driv=
er is
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.11 material, thanks!

