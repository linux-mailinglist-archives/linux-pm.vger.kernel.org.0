Return-Path: <linux-pm+bounces-33732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C739B42371
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 16:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82FA1A87D05
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B33101D5;
	Wed,  3 Sep 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqUWuBdb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D56430FC33;
	Wed,  3 Sep 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909307; cv=none; b=Z29zhWmCuo5vXYX0AcLvYFv0aBSx+jzzvir0CwqCRgs3dzIZdNqOd4fi95I6xulwozvM7BOz9dLzaFCVOeWCqW8HS7cZ5/+kneSemU9dQEioygBUv0U/ejH13+i0I8HUMey16LEqrDjMOw71sYJ7dUjI2x/fY/dNLpCNmauaX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909307; c=relaxed/simple;
	bh=n/Xz2hmk5L7XvLf6PA/5tUm3W71LDatU86gMp2FwJCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn2NXI41eRAqF8A5SgS8LoCLYDRLEChtsGETg0bR16PKH98jKuk2ETH84pi29C8KVVKO+Vcw4jzAnCr8URtTUZF1qQTsiGJ3GHv1AcTHZ3aG4+TDUJ7iiBblz6vVgAUE0bORFdRJxNYbsp8fYeQUug3mZhvXcJRxcykFG0oWdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqUWuBdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C12C4CEF4;
	Wed,  3 Sep 2025 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756909307;
	bh=n/Xz2hmk5L7XvLf6PA/5tUm3W71LDatU86gMp2FwJCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QqUWuBdb7jNEOSFk/fGahyy2N2V1/1G9Y+XIWMQO8BOLqbtBa8ldRllW2q3fNy6QM
	 NZNHNP9smGuOe5hYU0N2q6avzhXmigvsPJWlf4WJbmpeituABL26jEPFxYrYL0dNnt
	 Uu9YkLOHHoXfQ+kvdV7JyMnOsupFd0iZDCh36O68/ZS45TNjksnqq9kDfVe7R5WU5n
	 6fsDzu/lvt1yfYEJXVqcddFDPFeVJJKL5ZkI8ZxgnuiFQGjmFYWFBSx6047oggPAZ9
	 yO+1orn03p5V93BvltPSGl2cHdcwGI2qnklt87KfltpWph5R1OSjRqum+vsR678K6y
	 9ARzb1/pawMkQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61e1f772403so1013662eaf.3;
        Wed, 03 Sep 2025 07:21:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvUPCerYWqm/NRdb5sWYEPdsUTwhjgMd7MqgPFKDrWUeLdDnSeHP81/MCqVMxkXsMXROu4F1qVejM=@vger.kernel.org, AJvYcCXR1A2GKlYejBVZGdWEaY4sLw3uJzRslx6tlQ33CC0yFZhBlAIogPbA7Mpnybm1SHrYaCFT9gW4uvRaq6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOC95F+NYTPIniT7nYWrYpkZ8E9tvdo5AGbFD7rDGnlDuZqLLz
	RVoAPWdKSlpd2KmYRlEUexKHUfnePSlbeH6e8XM343R929ErirT177t4iNdHNTKpate2UAqsQGL
	8q2nEGAz6RW40w0HCuYdNKehL094l+ms=
X-Google-Smtp-Source: AGHT+IGz6Z/BCqXvej+gVwvE7vn6veGcBct4rtY8apmNp5Z8m7MDpxCg7VpBc+Mk+l/hS2BivjuTI2whKJczlp536U8=
X-Received: by 2002:a05:6820:1ad3:b0:61e:7139:b475 with SMTP id
 006d021491bc7-61e7139b636mr1122499eaf.4.1756909306386; Wed, 03 Sep 2025
 07:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901150653.166978-1-osama.abdelkader@gmail.com>
 <CAJZ5v0hrKBNxDeZOKpUXyuZV7LRUX4ov4ifEGDtNMrA8km6uOA@mail.gmail.com> <aLhK_zMvtkdCtsHR@osama>
In-Reply-To: <aLhK_zMvtkdCtsHR@osama>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 16:21:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2ooBwnPWKjXGyYOOBtjs6zbAh-+jaUaV5u7sBi87+Rw@mail.gmail.com>
X-Gm-Features: Ac12FXy15ijx-KPz46ogXZE37_h0U5NReGILOk6HIqD8jARqT68wLrSSSK7YgjQ
Message-ID: <CAJZ5v0j2ooBwnPWKjXGyYOOBtjs6zbAh-+jaUaV5u7sBi87+Rw@mail.gmail.com>
Subject: Re: [PATCH] thermal: hwmon: replace deprecated strcpy() with strscpy()
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:04=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> On Wed, Sep 03, 2025 at 01:50:03PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Sep 1, 2025 at 5:06=E2=80=AFPM Osama Abdelkader
> > <osama.abdelkader@gmail.com> wrote:
> > >
> > > strcpy() is deprecated; use strscpy() instead.
> >
> > So why is it better to use strscpy() in this particular case?
>
> Thanks for the review. Technically, there is no change since both have co=
nst buf size,
> it's just for consistency with other drivers.

$ cd linux-kernel-source
$ git grep strcpy | wc -l
1187

What kind of consistency do you mean?

