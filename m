Return-Path: <linux-pm+bounces-15985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD949A4422
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5401C213E5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F312036E9;
	Fri, 18 Oct 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKGVXcOE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27689202644;
	Fri, 18 Oct 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270135; cv=none; b=AJambIODVDr2j6RjAKWvg3L5etf1K46Lqyxqn7pLKG5eHxtUg9OYOhNUK97a/lX1QMoi9qS+v1Jjph/Kq2TXdHm2OegCfHHZyuUxdJuqCO9h2kUnZmf7bfNT9P0SqDU77BY4DENpnSZ8/eKVQ4iylNMdBvrREfYDtWhkQxeHGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270135; c=relaxed/simple;
	bh=5be1HF+hOuNGC1SEF5sFVkWpnDgYkPHvPN/yVsMnXRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdxSioRiUhUiRghy7PEht8HfTaeXH0iUCH0ggc82vEXxfZjPXWmB+XEIddgK5ZHbPAIseWpS+jjXuOaWtRAN35a4dxnr2uKox34XkYhPAa0AOs5M13pF+RH9sTUtTDvZCbQMjd097rmRoQ04FCtgfA9dMA+LmOSKqSNZ/mBVC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKGVXcOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7837C4CEC7;
	Fri, 18 Oct 2024 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729270134;
	bh=5be1HF+hOuNGC1SEF5sFVkWpnDgYkPHvPN/yVsMnXRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sKGVXcOEv0LzJtWBs3cEBKbBmWOVbsZgEyhtR1EXZhA38z0n044vWHh44mQRJSjXp
	 18zzwtvR577Z1SayWoTDnd/c1rg26SA5sr4eqoodEiFGXVDosKsqwUaY3381wyHfsp
	 P1yln48Mb2YPAj4LTz4BQLm8qlaNBkf9r6d7zlOdH5QzJV+JYaqhjNI3jbrJLFCIO5
	 FGP8qr2IXAQwDJyjAbjL+VpDLsJl7/iCJCkZS1n9aG02hFtoyVLC0b8LxSTilK5b9Q
	 FeOnSo93Zdyu/47CvudpeipFXMuazmceRYT+UHP5Hp93oP72LKiu+U4P0jBD1j7jL6
	 r7HRecQOYcdJQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-287b8444ff3so1041894fac.1;
        Fri, 18 Oct 2024 09:48:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWgIZhr+wytn01YCbrQmtP6DiicIVY0NWcM1X7KJswogRPiETxE/pmYL3igv1qlqbqexoH41kRpj9yKQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdr2Y/A4+FOPx8D1YuWq2XeZ9+U4tgLjk9CRTS37zPIWfSXiZi
	c1m+d2jAOzz0+htOF7tnjksHorc3p8yO56EMtCKwRQSguMahF1LwDVFQPnU8A2oOBys0E6mYbyn
	rIbYkfwX7ARdxON4Zkxv53GPCI0Q=
X-Google-Smtp-Source: AGHT+IH79d4xgd9a9Uis4M0NH+AfruKXwqTKgrXhahKWvCU5Il0ONkuo0LSfgfyOmFDIrbusLgmNZQVeSfOhAAsq2rs=
X-Received: by 2002:a05:6870:82a0:b0:277:d360:8971 with SMTP id
 586e51a60fabf-2892c549c2amr3314534fac.43.1729270133982; Fri, 18 Oct 2024
 09:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909095529.2325103-1-marcin.juszkiewicz@linaro.org> <CAKohpokMUqaMUJaSfdyY39idmh_ycYj+hi5sMSBmZV1CQ511qA@mail.gmail.com>
In-Reply-To: <CAKohpokMUqaMUJaSfdyY39idmh_ycYj+hi5sMSBmZV1CQ511qA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Oct 2024 18:48:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ic-b6-dqcfMDTwkEL=MKcVCgHtJ7WH6o==vFDbQy9YPQ@mail.gmail.com>
Message-ID: <CAJZ5v0ic-b6-dqcfMDTwkEL=MKcVCgHtJ7WH6o==vFDbQy9YPQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: use proper units for frequency
To: Viresh Kumar <viresh.kumar@linaro.org>, 
	Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 5:04=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On Mon, 9 Sept 2024 at 15:25, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
> >
> > When I booted my RK3588 based system I noticed that cpufreq complained
> > about system clock:
> >
> > [  +0.007211] cpufreq: cpufreq_online: CPU0: Running at unlisted initia=
l frequency: 816000 KHz, changing to: 1008000 KHz
> >
> > Then I realized that unit is displayed wrong: "KHz" instead of "kHz".
> >
> > Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 04fc786dd2c0..76da29c2bd3f 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1539,7 +1539,7 @@ static int cpufreq_online(unsigned int cpu)
> >                          * frequency for longer duration. Hence, a BUG_=
ON().
> >                          */
> >                         BUG_ON(ret);
> > -                       pr_info("%s: CPU%d: Running at unlisted initial=
 frequency: %u KHz, changing to: %u KHz\n",
> > +                       pr_info("%s: CPU%d: Running at unlisted initial=
 frequency: %u kHz, changing to: %u kHz\n",
> >                                 __func__, policy->cpu, old_freq, policy=
->cur);
> >                 }
> >         }
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.13 material, thanks!

