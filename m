Return-Path: <linux-pm+bounces-5532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ACE88EEA9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 19:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94041C2A16B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD81F14F138;
	Wed, 27 Mar 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VV+0VnhV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E314D6FF
	for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565765; cv=none; b=G4xsA8ogjOw0FySKk6FGSIfCGYUofN8Cg+oxuO7VIOWWAL1WEuZDs7gOFOTt1eClaDWlGlIEm7FqvP8hMIGtGSFt+0LczaxysG6MXEiN2UyU7NeZvunC+rolQx4gCgsZO5mMFtP3mVHcatDsvbp8b0o09U6dSie8WGYLkNJmJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565765; c=relaxed/simple;
	bh=H/eTOCcjo9aN7qQPdq07jhsvhHbGanS8AyyyYf4Umi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQBh6UtTDQTfY7VzzH4w95JGnMwiNfmlM5lGg81hS+P9GomKaGJfUxmATxp8jshFLWAiK9EinQ8bah0zXwfioqiYL7ea+ySRw4G+ypDhwg0DWWaLvAUYq4/EA/NGuLK1Aig/GwPq5PedY3VZY/tMmYE4iyeonaEUCsaGr9Bc3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VV+0VnhV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d094bc2244so1042671fa.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711565762; x=1712170562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/eTOCcjo9aN7qQPdq07jhsvhHbGanS8AyyyYf4Umi4=;
        b=VV+0VnhVEki3ILwm72RPkCOxQjmcPyNa5rlAf+qZ438dgZs/xKJxeiQoGEQFJuioUx
         Vbq6R5nNIlf+nucsCHFBGLM+zFicFajoPs2T/pbSHbYu53+e6BUPCLudWwwD6Rh0qDdh
         UjWAQjJBP4arE5fOXwBcifFWLwxNak/p2DWXpGYSu2QhPEZhRjLJe8Iy50TttYq4OHd0
         0jLYXTf6PPoLqMPVa+mZXoF9j7AebRY3eRxNXu8utctAhs4jdAuR5B/1FxO8zDXSq6x3
         bE9Zn0QoIuRDVF9lB5roTPOXQBynJ3tDJa58OcvPzoTagZZJMlxjsrjqGM9S10RItQQ4
         J1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711565762; x=1712170562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/eTOCcjo9aN7qQPdq07jhsvhHbGanS8AyyyYf4Umi4=;
        b=BNltGkq73nbnGgkRE0HmL+8shXg6vFYKRC1fNMqnyJa5UmOxYGqwbZl7orSK11DwfO
         6KlkC8N/p9N0abXCuUtg3V1axopIUIIO2xc7dr9kNOuL9SmQde+S3VOEu3/dF5N/HwsF
         RTcp/BWfd1En3K8KYgfJ+k/vxA5HdPDsNUJue/17z1WkIIhH/d/P0cDI57bxt3oU6sRN
         Gz2XpNC+r30CbAhsJv1w1G5gsogoDrs3ktqvLINcnj9zH7BnUgeY++MCswsZT3ODdesD
         9aAH/hnvD/fIQCGbU4z5pAn47LFkb2TLRbtx2s1Ebk8ojvhbQ5ABFeSI3HE6KAc2M2/0
         LYug==
X-Forwarded-Encrypted: i=1; AJvYcCUDcSo5NJd8lEjpss5g8CPSMOEWbOp+q2HUdgqMN815WbnsfNTK7sIkgp+4HhW/sLLhlcXG17AsdvZgRdK1x28E1BFJPPlU/Ig=
X-Gm-Message-State: AOJu0Yx7tm5aoPj7FmoMhPAJN/S8qkBVdgVRSz6BLsQ9nn7CyfWN0mDD
	z2PA2wR0H10rbC7Hdyv88NiGnzfOSpl+WFshT46vg4a2yRoV9OE9vxHGawMZ+QKeLifHSf4DxT3
	Z3bi+kPkoHOxtH3ufi+8+fdN+cJce0DR1LFAuuQ==
X-Google-Smtp-Source: AGHT+IFfaQnTAbP7+beuXcrrsmTHRVPtnb/RHBukbiOBMqcY0DDZ63uCDR3FE1XKpIsOQEkleMW2WlpbTNeUExk8xKY=
X-Received: by 2002:ac2:4648:0:b0:515:9ae1:9a6e with SMTP id
 s8-20020ac24648000000b005159ae19a6emr206133lfo.67.1711565762008; Wed, 27 Mar
 2024 11:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325131624.26023-1-brgl@bgdev.pl> <20240325131624.26023-2-brgl@bgdev.pl>
 <af9def4e-c6d6-49d9-a457-68c40492587a@linaro.org>
In-Reply-To: <af9def4e-c6d6-49d9-a457-68c40492587a@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Mar 2024 19:55:50 +0100
Message-ID: <CAMRc=Mdw9Ox5EC6=GdR_1kzWcfhpdbz1Hu3e7+GY9-wqTh2fhQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/16] regulator: dt-bindings: describe the PMU module
 of the QCA6390 package
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/03/2024 14:16, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The QCA6390 package contains discreet modules for WLAN and Bluetooth. T=
hey
> > are powered by the Power Management Unit (PMU) that takes inputs from t=
he
> > host and provides LDO outputs. This document describes this module.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Can you start using b4?
>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
>

As per the first sentence of the cover letter: I dropped review tags
from the patches that changed significantly while keeping them for
those that didn't. If there's a way to let your automation know about
this, please let me know/point me in the right direction because I
don't know about it.

Bart

