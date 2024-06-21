Return-Path: <linux-pm+bounces-9734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3067911BDF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8886D1F21F55
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70615A863;
	Fri, 21 Jun 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HUVhUVcB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440871534EA
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951792; cv=none; b=TGAxpuip+c/Ge5+PNqZswAoQlEkWxlge+zESX0Gxll8CHRnfxaGVNAEOW1SusOZ0khASLjm0pvl3Oe02FIqJcsvhLbBQG9zOlc4l3N2SYjqGu4LGReLEKtlp3ZC+LAM0rVqAduacOiyChIRD1Z0++Sh06wxd3gBxzaambjkZxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951792; c=relaxed/simple;
	bh=tIZJesXUiqyNL0+tf4ZcTxHwPed67ixLIRK/Y7eHy/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4+D4q/5AEmJK8fEQo0yo/xmDNwCu1uIrlNfjJeXS+7h7snZJWkKvlST/bIk6HhhY2dvR/UCJyK9Rrho6azjuHdyAP/jJcqFQfHQ0BF/PZGFG9RHTfR+swcN5JydFg7eFqWDwC/sf6IV3gbNODwa2feIMiUBTdd1J7gMZXMHtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HUVhUVcB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c85a7f834so2089057e87.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 23:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718951788; x=1719556588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDlgAx36WtQTmqaDPFS1bjCgqZ49vXGvfFSl1X9D+uI=;
        b=HUVhUVcBAeDvJ5ZLv1iN1LWfop8ExyJAFdfsg1JKTzJz61HrhU+wCprK6eCgQppvl3
         87Ev0hVgKDsOwpvg2mP2Vs9sskeVo+EC8InncdH89cRmL7mymKQBKQxTf7BK4gt6JLx1
         FwGNhlqdkvVDT4gTahsMglZSw4pdSxPT67qqRiqoJ3P9lk8RzQP4zMrzzCy/sTls0Q8J
         MBCDerIHOSsH0aSWNSGyhNwusYKUAdI0+r6vl52k0YVnh6oIsi3ScQrVJ1t+iC+v2Z8W
         pS0kxlSmMsd7HHLM9pI8TYKx7Nlx2hPI4TdUnsh/QmfjSR9vmsQTSrCehWz5ZYRZrgHX
         a0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718951788; x=1719556588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDlgAx36WtQTmqaDPFS1bjCgqZ49vXGvfFSl1X9D+uI=;
        b=raMZiK2pls6aTt+DO98xH9Nt+3VmF8KgYICy0LEI1Kezd5xbefc/4av+S0ZPRPwyYM
         a2nPGc6j36uE0mvbuQ8At567nw9PdpW1NMJttNmha9CrOqqbqMq/71NhCYJ/cILiuBpi
         l4z4aMisVPjuyu49JY3qBGpILjN076qIdIg0v+nDUXSzF5/0q1m1KK5RzCOkJKljWv9N
         wagl4mGYsSBUQrmPZjC69tYgK4crBJ5iibx9zC58wnpiIvRgBueVFL2l/MTVhoDj7lze
         3hnOkquJMBqI5HhxFdiA+LsVN8oqTww6lyYfXa8bpVWDp1qe28l0wtaKGGAYhfahWHkX
         ES6A==
X-Forwarded-Encrypted: i=1; AJvYcCVi+XwSc2/4YobBDvV8b4NG7Te2lD3NebHGxTDQ1hzgmJ7AxP07h5/jB1jLIzKSxPI1/IZahLeDPqJ1YBn96efynijaFcdCsug=
X-Gm-Message-State: AOJu0YxjmCEOQ8pOtPVAjsd+sHsPPRz0e4bNXXADD9OhphlMWmmKQL5k
	Q6q6g32NuJuirhbe7DhU5nfpmmZbq0ISJeaWSiIpE6waDDgZvI2+mza2P1WVFxkRhxG5DDEol3Z
	075vCSJL0IhAbht7fulue4YrIX87yh/YL7TgjgQ==
X-Google-Smtp-Source: AGHT+IETcccKM8WA7GpqQapLV3BglD0CyTXI7Fuf3artRzg+wwCccDOMDfEs5iixeaBWfAxzjwo6k5OyfcLU1ZQouHU=
X-Received: by 2002:a05:6512:33c9:b0:52c:8a4e:f4bf with SMTP id
 2adb3069b0e04-52ccaa98d21mr4559244e87.51.1718951788223; Thu, 20 Jun 2024
 23:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605123850.24857-1-brgl@bgdev.pl> <171889385036.4585.6482250630135606154.git-patchwork-notify@kernel.org>
 <0b144517-4cc5-4c23-be57-d6f5323690ec@163.com>
In-Reply-To: <0b144517-4cc5-4c23-be57-d6f5323690ec@163.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Jun 2024 08:36:17 +0200
Message-ID: <CAMRc=Mf2C4ywa+wQ6pcq5RtehQD00dDhzvS6sDcD8tAn=UypUA@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
To: Lk Sii <lk_sii@163.com>
Cc: patchwork-bot+bluetooth@kernel.org, marcel@holtmann.org, 
	luiz.dentz@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, kvalo@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com, 
	broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	bhelgaas@google.com, saravanak@google.com, geert+renesas@glider.be, 
	arnd@arndb.de, neil.armstrong@linaro.org, m.szyprowski@samsung.com, 
	elder@linaro.org, srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org, 
	abel.vesa@linaro.org, mani@kernel.org, lukas@wunner.de, 
	dmitry.baryshkov@linaro.org, amit.pundir@linaro.org, wuxilin123@gmail.com, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, bartosz.golaszewski@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 3:14=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
>
>
>
> On 2024/6/20 22:30, patchwork-bot+bluetooth@kernel.org wrote:
> > Hello:
> >
> > This series was applied to bluetooth/bluetooth-next.git (master)
> > by Bartosz Golaszewski <bartosz.golaszewski@linaro.org>:
> >
> Hi luiz,
>
> i am curious why Bartosz is able to merge his changes into bluetooth
> development tree bluetooth-next directly.
>

This conversation is getting progressively worse...

> 1)
> his changes should belong to *POWER* scope instead of *Bluetooth*
> obviously, however, there are *NOT* any SOB tag from either power and
> bluetooth maintainer. these changes currently only have below Acked-by
> and Signed-off-by tags:
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>

It's a new subsystem that has been discussed and reviewed for months
and thoroughly tested. Please refer to the cover letter under v8
linked in this thread. It's not related to power-management or
power-supply, it's its own thing but IMO the best place to put it is
under drivers/power/. And I will maintain it.

> 2)
> his changes have not merged into linus mainline tree yet.
>

This is why they are in next! They are scheduled to go in during the
upcoming merge window. But since changes belong in multiple trees, we
need a cross-tree merge.

> 3)
> perhaps, it is safer to pull his changes from linus mainline tree when
> merged than to merge into bluetooth-next firstly.
>

It's not safer at all, why would spending less time in next be safer?

> > On Wed,  5 Jun 2024 14:38:48 +0200 you wrote:
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> Hi!
> >>
> >> These are the power sequencing patches sent separately after some
> >> improvements suggested by Bjorn Helgaas. I intend to pick them up into=
 a
> >> new branch and maintain the subsystem from now on. I then plan to
> >> provide an immutable tag to the Bluetooth and PCI subsystems so that t=
he
> >> rest of the C changes can be applied. This new branch will then be
> >> directly sent to Linus Torvalds for the next merge window.
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - [v9,1/2] power: sequencing: implement the pwrseq core
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/249ebf3f65f8
> >   - [v9,2/2] power: pwrseq: add a driver for the PMU module on the QCom=
 WCN chipsets
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/2f1630f437df
> >
> > You are awesome, thank you!
>

Why are you top-posting anyway?

Bart

