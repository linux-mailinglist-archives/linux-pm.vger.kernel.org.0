Return-Path: <linux-pm+bounces-16082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E39A66FD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C1B26079
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C181E7C2B;
	Mon, 21 Oct 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWsvELI1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD61E7C03;
	Mon, 21 Oct 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511371; cv=none; b=owaHSTzLIZe8Sscc/LZ4odg1MD3t0Iw05ppVVssfXgSlQPAeLa4iawmPBu1sfNxcNiWEldDU0H65sIwz77d2XO05GXSno7Sx63QAMei1Xmzr2KlTkQ8EERlx9JDg2g+8OAI4g16eQYOPt0Ox4hCFroj8xRk2Upv6Ri+V7G6NXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511371; c=relaxed/simple;
	bh=p/KY9csEnBUhnMzpBwtnUh06z5mxHDh+JsWyU9R7k9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4LxNniOjs55x60xT0wEdVJn3KLllREx1tiD2wrtBuZFu5nWyRoOr6ThpAAYFm1D58/9LYva0alTJ7uXjZasBeHjU9QLuMwNkOt51yotPyj6C53VcA4xRQD6VAM+US0CWWVXeHEEi+ceujNp2+sc4AzJOoXCdpgCIHHddSJ9uPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWsvELI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE56C4CEE5;
	Mon, 21 Oct 2024 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511370;
	bh=p/KY9csEnBUhnMzpBwtnUh06z5mxHDh+JsWyU9R7k9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NWsvELI1dZiWx8lBBHZ3px1DPJ09Os1TudV5aWgkxE6e4PqRXyuw4ma50yCORUOWT
	 tN20kpzX+reRiABhgDEu1xbYjX2a7ssW9deoXGa5KSLqMdpR4EtpcMNW018pDIwTQT
	 UAqhAG9xm2/Rfbpckg5zidKZ/AJzbkjEBeGh8XhqtE19VHNDqWm1cAjhpIRQO9pPJO
	 LF8obp+jrwgwzEm8o1OBUsQvJjbVZzuA+1+25T+8Zq4mIaHA7pM8cC5ZGmzEcu51Ab
	 cjn7gbsAcMM/Y2Fm0gbt34re96+k7mymKkDpKnGWkZ0mdY9oMv6JkAC+5xzPKEiUYI
	 Rz0isMPUkzAqw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e7ae4c504fso1884034eaf.1;
        Mon, 21 Oct 2024 04:49:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVC16WENTqNfiWRila6nJi8ZKqJrkhHcNyRXL2o3ivO2fggypvoeLqzYHSVi/aIZ3l502xoFJs8vVg=@vger.kernel.org, AJvYcCXJQOXu6duzDUEkWWFSoWjZZFjq3lzXX99JyKUCs0Khf0T6ZEBHoz5U5k+1HyQg3Nf5SUOygHffm8Y5J6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybek3mb9ixmBbU8t/fsvK83DIe9ebjZdZfH+HEeBsjD5RrPN2O
	6T9PmM3ZJ9QCIVQRI4/4zctl9GGqMbUnlDduzT1ZjWUn0AT4Jac5m9LqXmZn7RaDpZ5CYzla8v0
	LTESz1bkqy6s0DX/oxd8V+3aof0w=
X-Google-Smtp-Source: AGHT+IH0LQRh6n0yjHKgftLQrFdw1cblnbCkBTDoJI5Fl6j8NVwJLdPwvs7KVjBC4ggT7rfRl5feUqCTgYGub0ttNck=
X-Received: by 2002:a05:6870:d607:b0:288:3762:f7f5 with SMTP id
 586e51a60fabf-2892c5cf565mr6584529fac.47.1729511370100; Mon, 21 Oct 2024
 04:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1930069.tdWV9SEqCh@rjwysocki.net> <40ec7bb0-02ef-4af7-8934-9f960fa15355@web.de>
In-Reply-To: <40ec7bb0-02ef-4af7-8934-9f960fa15355@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:49:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaR1e6OMpY=wMBKhqg8F6DAX5KUqa+YACEr0z3EZxo-w@mail.gmail.com>
Message-ID: <CAJZ5v0iaR1e6OMpY=wMBKhqg8F6DAX5KUqa+YACEr0z3EZxo-w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] thermal: core: Add and use thermal zone guard
To: Markus Elfring <Markus.Elfring@web.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 1:41=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > +++ linux-pm/drivers/thermal/thermal_helpers.c
> > @@ -60,13 +60,13 @@ bool thermal_trip_is_bound_to_cdev(struc
> >  {
> >       bool ret;
> >
> > -     mutex_lock(&tz->lock);
> > +     guard(thermal_zone)(tz);
> > +
> >       mutex_lock(&cdev->lock);
> >
> >       ret =3D thermal_instance_present(tz, cdev, trip);
> >
> >       mutex_unlock(&cdev->lock);
> > -     mutex_unlock(&tz->lock);
> >
> >       return ret;
> >  }
> =E2=80=A6
>
> Would you become interested to apply a statement
> like =E2=80=9Cguard(mutex)(&cdev->lock);=E2=80=9D?

Well, please see
https://lore.kernel.org/linux-pm/5837621.DvuYhMxLoT@rjwysocki.net/

