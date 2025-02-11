Return-Path: <linux-pm+bounces-21877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C256DA3165F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6E5188A834
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 20:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C11E47B3;
	Tue, 11 Feb 2025 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIz2nBZA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254026561A;
	Tue, 11 Feb 2025 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304307; cv=none; b=XoHEdX+R625apm64apgYbME2sBcK5ybzrfOmw1xil/c/fe2FmuXwjPVq2d81vLYeuktr+gioUZs3QV6u/7NmrVZuPJvRxBGluVicKJeFwD9kLhSv5PuBlZNiisCZfxB63gZwuSCFpgDCB0rfMZjD5okmhL08P8EmJMAYo5A5BnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304307; c=relaxed/simple;
	bh=RDRL1qjE4Pn/bojp/LkSNcMc0bPso9G7XSBgA/da9mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAMRx5vz7dHWQWH5vvfwdIZPFJi2AZqYrMjRF5ZHLZk0TyRnrfGQFkcY2dNglSDOd+HTtR0u8JAr32yjO3QpsgVN1OkkCO0xq+w7H1u2vdYXdk0TTCXVIku8WSftQZGBeCA7v94hVfCYll9amI+YrNh/QSRZEIDeA3JssBRK0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIz2nBZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54430C4CEE8;
	Tue, 11 Feb 2025 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739304306;
	bh=RDRL1qjE4Pn/bojp/LkSNcMc0bPso9G7XSBgA/da9mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CIz2nBZApbjwkrDrJBIS7LRV9l2f/3k78NCPzoszjpz/4hQ8ZqmwmIuqCKB0qlg2n
	 +CG15v+CSFHMbXjwDoyce8Y1ULqaIaOFbeTVBxdAtqagQk4BUPlpDK/s2XIrX99EEa
	 S5nKLq2MFrwbiuPTIOetYU8ofLW5uwvx7PEYva7HsvYfGX+WTeoEdrYS6jTHOEd5DX
	 D1P22Otfq8Hu3Dubq/C6KmrVrN6Z6FGCTylkFB8iz7sRNVoiWohl2kHwgr6aTE/GBM
	 gO4BFXlaBlGk4XFFCs0L9vdVyz9T9xOuYdWfiwfoSLCO/mTmuO2Jgjx31yab0QFtFj
	 7QL6coHuNec+A==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5fc447b03f2so1523168eaf.0;
        Tue, 11 Feb 2025 12:05:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUepn4eenbw6I7N870g39LM62CfrKCXQDgKcckZyD1MXlc3O/J8+TVqcSEZ+9XMtJMvEKbZQcOxIxbcOQI=@vger.kernel.org, AJvYcCUoNDTwQyHQaZOkRhqh0ACFhleIDakjm9hypzLJ0m0js0hDzLrST1eoq0thj4/7BIc3+GoZ0g7dHjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/kDep015I/ZNL1T+L1nY8CS/ER8nq7hSLesEuMt79plfXD/F
	Z6w6RfhaMi2kXLQKVUQLgTOrqBPFnWtJsjzXvLTy5jSyqo7/c5JvDVBAnqsSUgxSFT4gQ176nO0
	gF07KqMtFoJj+PHhK5C5FBaSpRXE=
X-Google-Smtp-Source: AGHT+IFmfRi3LUQnmJl3G2zF30ySF5EP/rkbIPMDbZ3TdVebm5QTqDMXJXo6dKXyeBgGAgR2nL/Lwu/Q9xwryoWzLYs=
X-Received: by 2002:a05:6870:6125:b0:29d:c870:74 with SMTP id
 586e51a60fabf-2b8d67bdce7mr595970fac.27.1739304305616; Tue, 11 Feb 2025
 12:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211084712.2746705-1-daniel.lezcano@linaro.org> <20250211100237.r32hu366jbihndbc@vireshk-i7>
In-Reply-To: <20250211100237.r32hu366jbihndbc@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Feb 2025 21:04:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jHjqVTgxsN__JdO_9SvdQ-JMV4F38reDEWtZC_UueQew@mail.gmail.com>
X-Gm-Features: AWEUYZnqDrOebhvFrXT4iLjMkN0uz7OxXfkFyZc4G7o5C5RdJJZJCO4Lkids2ac
Message-ID: <CAJZ5v0jHjqVTgxsN__JdO_9SvdQ-JMV4F38reDEWtZC_UueQew@mail.gmail.com>
Subject: Re: [PATCH] thermal/cpufreq_cooling: Remove structure member documentation
To: Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:02=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 11-02-25, 09:47, Daniel Lezcano wrote:
> > The structure member documentation refers to a member which does no
> > longer exist. Remove it.
> >
> > Link: https://lore.kernel.org/all/202501220046.h3PMBCti-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501220046.h3PMBCti-lkp=
@intel.com/
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  drivers/thermal/cpufreq_cooling.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufre=
q_cooling.c
> > index 280071be30b1..6b7ab1814c12 100644
> > --- a/drivers/thermal/cpufreq_cooling.c
> > +++ b/drivers/thermal/cpufreq_cooling.c
> > @@ -57,8 +57,6 @@ struct time_in_idle {
> >   * @max_level: maximum cooling level. One less than total number of va=
lid
> >   *   cpufreq frequencies.
> >   * @em: Reference on the Energy Model of the device
> > - * @cdev: thermal_cooling_device pointer to keep track of the
> > - *   registered cooling device.
> >   * @policy: cpufreq policy.
> >   * @cooling_ops: cpufreq callbacks to thermal cooling device ops
> >   * @idle_time: idle time stats
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.14-rc material, thanks!

