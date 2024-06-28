Return-Path: <linux-pm+bounces-10213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1785391C644
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E2B25DCC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 18:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05C6BB33;
	Fri, 28 Jun 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lky0WtaY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E426A8BE;
	Fri, 28 Jun 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601163; cv=none; b=j0UeT0HUnzES3Hlmc2vbXZ0vB1C0Ykr/lcTURLnDu4z45KQSXqYSdA6DjTRBqzHcLdsKAegKfWqlbuMtc1VP4bgWJOgmyac/90GRAT1lHbB5x88tVE3R7EGazHcCP1VGTO4LKQbvS5axuHP/qv0Pi4ms7FP84P9W83+n+QOqa0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601163; c=relaxed/simple;
	bh=e+e7fSsfY1C3BBErHbLSk9HJdSyiw+J5R+fAtwg1pJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJlcZS+fSM2JXzGI9Ot8fTF2RV5czDoSyx9RohzhCj6D+rWuxVkD5DTuoKCSLakpxphCxP2EcQPL6ITK6f9OQWlxTkUKFye3J7qAwTrRXDlaOO6koOAA0+NsCSCNGeXCIlniBvhNL4bedAfZLUNiSGHOWZhfhnH2hVgYSg6VOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lky0WtaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11488C2BD10;
	Fri, 28 Jun 2024 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719601163;
	bh=e+e7fSsfY1C3BBErHbLSk9HJdSyiw+J5R+fAtwg1pJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lky0WtaYuX9PtdrDhTgm23grSRxDhHGxW4BhJUHnVqn8GHOUFSnSROVzVO4VgWTQz
	 SHKeJSXNzyrDfbL4TahWt2t52sR9ajV42iSG94c/6IjUIg0vHcIV8iHCWRULoGgc22
	 hJlosNQRftqIoKlzmIOwCuBSCaVIb5fXp1uSRt/FBQKhSvsvg0qPYDjWKhAnVon1Zy
	 CFuoWtPyLpqqPVlIp7NF1ryKDOCQieRdGEGU1isA0zTxupD82MIBEPUmbfiPdLlgib
	 E7RvYplbxoYaEcG10JKgWhGQCGmNHjRnHMz5TOqc2RvYdJ0uB9FIQr/Unp9AHsGsVN
	 zSAypOoa20OwA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-24c5ec50da1so142627fac.3;
        Fri, 28 Jun 2024 11:59:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1DmNDMbpZco8IKYuZbsQM3VQD/RSLp7vfweGYjFKxGFk6pMXLa8mor+y1TJ9iuxGky0bBdNc0uJyMxVGyrr3UjCBQ9AzLQgzzuW3jdQOYs2RHJHYCME543P+7bPWJfPp7LgYPx+4=
X-Gm-Message-State: AOJu0YzOTGIFM2fVYsBu38wmjZHO6wClz/7EJPLc3OtcMNG3IqLRdnD1
	es3aRpPgSzwK5NVpw5qOUdHmWVF3uAjl9z1TAiSpZFsY7sdQWRFscEkANBrwfq3rD4SJDyJq/Ns
	B2jyQStYpCSbYt7gcOHnwVjzxzDs=
X-Google-Smtp-Source: AGHT+IFCGem2eoo0rvWIQme4AModLWMeThmakQhaXznbYg6pzoUdgPw1z1j4Z3n03wPqWNcgzKpINtZF+b7Ieem+r/0=
X-Received: by 2002:a05:6870:7d1a:b0:25d:7935:43b7 with SMTP id
 586e51a60fabf-25d7935f4f4mr6079402fac.0.1719601162419; Fri, 28 Jun 2024
 11:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627060117.1809477-1-d-gole@ti.com> <31841424-c6dd-49e2-ac2c-2394662b7f30@amd.com>
In-Reply-To: <31841424-c6dd-49e2-ac2c-2394662b7f30@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 20:59:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hqvdTo5TJkB1S+23dMfC8ivs5_rNbV1XnhkaTntkZ3Aw@mail.gmail.com>
Message-ID: <CAJZ5v0hqvdTo5TJkB1S+23dMfC8ivs5_rNbV1XnhkaTntkZ3Aw@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: make cpufreq_boost_enabled return bool
To: Mario Limonciello <mario.limonciello@amd.com>, Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:57=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 6/27/2024 01:01, Dhruva Gole wrote:
> > Since this function is supposed to return boost_enabled which is anyway
> > a bool type make sure that it's return value is also marked as bool.
> > This helps maintain better consistency in data types being used.
> >
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 6.11 material, thanks!

> > ---
> >
> > Changelog:
> > "return false" instead of 0 as per Mario's suggestion.
> >
> > Link to previous patch:
> > https://lore.kernel.org/linux-pm/20240626084354.1762483-1-d-gole@ti.com=
/
> >
> > ---
> >
> >   drivers/cpufreq/cpufreq.c | 2 +-
> >   include/linux/cpufreq.h   | 6 +++---
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 82c500389a40..709e7b1f9826 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2873,7 +2873,7 @@ int cpufreq_enable_boost_support(void)
> >   }
> >   EXPORT_SYMBOL_GPL(cpufreq_enable_boost_support);
> >
> > -int cpufreq_boost_enabled(void)
> > +bool cpufreq_boost_enabled(void)
> >   {
> >       return cpufreq_driver->boost_enabled;
> >   }
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 20f7e98ee8af..6f57de7de433 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -785,7 +785,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mas=
k, char *buf);
> >
> >   #ifdef CONFIG_CPU_FREQ
> >   int cpufreq_boost_trigger_state(int state);
> > -int cpufreq_boost_enabled(void);
> > +bool cpufreq_boost_enabled(void);
> >   int cpufreq_enable_boost_support(void);
> >   bool policy_has_boost_freq(struct cpufreq_policy *policy);
> >
> > @@ -1164,9 +1164,9 @@ static inline int cpufreq_boost_trigger_state(int=
 state)
> >   {
> >       return 0;
> >   }
> > -static inline int cpufreq_boost_enabled(void)
> > +static inline bool cpufreq_boost_enabled(void)
> >   {
> > -     return 0;
> > +     return false;
> >   }
> >
> >   static inline int cpufreq_enable_boost_support(void)
> >
> > base-commit: df9574a57d02b265322e77fb8628d4d33641dda9
>
>

