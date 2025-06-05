Return-Path: <linux-pm+bounces-28141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F3ACEB7B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E1D7AAA18
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1A1FFC6D;
	Thu,  5 Jun 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YhDF0Or7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A221F8BD6
	for <linux-pm@vger.kernel.org>; Thu,  5 Jun 2025 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111028; cv=none; b=cxjpQKtaxAXui4pGEwhgsN07dwGIH3SsIvVCYePFwDTBDAsf9ezPBQwVlR51Dko6EdaSO0QVK0ruD4WFDCtJrI49idctU2KQv9YhKU5dvXiK7O24djkys7FK0Q+Wzy72nOnfc8rq145zefzP9+CD5KGb07H5rPdrQNddq3oSpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111028; c=relaxed/simple;
	bh=1EnW/yxpvBpxax3gx1shRrGfyOQX14oH8W/BcrsAWl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5By8YkwSsgzl1S4rIykNPrIS4ZrKUC4VY1lbGldrjz/6W6jVkN83IIShnzY/lT3zzoxrgiJmrju7IXAnH5OKmZG6XaG9EghPZXnzhu7QaGEfSH2rs05O9rLp9ucRkBBOkrkWKbUvHA9koQwtNj+/1BQTXCBBAyAKoGdOE6QUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YhDF0Or7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55320ddb9edso666095e87.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2025 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749111025; x=1749715825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EnW/yxpvBpxax3gx1shRrGfyOQX14oH8W/BcrsAWl4=;
        b=YhDF0Or7q2IZBfavzv6PqKE2u8OKb77WdE71Fn6gvEfMU69eS0ZIDmdhI7dZlNyLll
         vSiHCltGSeq44BjQfE1lGtxzji3DU+BCY5d7ndbeuffGLl0C+ZM2dR/dQmORf/llUyBd
         SlvjRBj2TKXky//2+w12bgzLAlIY19iY4HxLnLuCmiUIaeQ3EfoyMy+GZ9G3UTsFzLzL
         23IYZ3tXYmOpdRk3SkZ9EicHR+cTQs13N8UAwmSo5XT8XxLFX4yG1PNmTAMA5KujCZmd
         Cp9UM5xE7eeBlZOh46eMJZzJjlULrn6VDnF04Sc2apbajwf5Fd8TvzvRgTQ4lKiCwJR6
         iQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111025; x=1749715825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EnW/yxpvBpxax3gx1shRrGfyOQX14oH8W/BcrsAWl4=;
        b=IE+zyalNJ5/TAslYwzqPqvDegpFsMreZpU8DKgOYLF0g3T3VzLIKpVmxw1KnS9zAI/
         VqG3xzeBjEKVditReCKEk+Z4wXdx8uSJTA1+H4muzpBSQx4i9HQHAwuyp8qe0eWhpNDT
         rKj3JLEKEvZXzI68G7CPOVqhde/o/mogkA5yHd3AQPieusF7gzXINZPGqMf+/7cLbbA1
         sMguPgjfA795AbAyBdd1QxtltqxzgmKn/4lIBg+AaBK1z3eXxTb+HkcehWgStRBVKoRi
         EdZYGY8lEc02HKqX47FrS2o+Z6UP1UpvEvrSuC/ZJ1/oUMORGecf8nPzrYsomHNPQtvk
         e3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtyRoe0vwuSeT3e/wesssEf06Eig7JTfp5rFNrK/ZTlo0FvwjkawByc+Fwc3am+6hZ3CaqwzfdOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylM8B+MW6OBhhglWxeuydRbp+M7W45Z7dM1afkWghBZ4XSfG62
	8S44iWe6Q+LjqblfLuNwtf2bEQXGX97HB4qUl/haKyoRb2GYORnA/4zx97q5xtiUy6Ow8/JNJmn
	MJDp2/goUoLgbzRFjz5qFiln+iqTS9n4mKGL+0dgM2A==
X-Gm-Gg: ASbGncv4swykMcSD3C6e8rKjhVspfGAOR/utAXb79BNa46SUw1CDjme3Fs5lub2VExc
	hSWpqsfokvy8SX0RH3iCzrEUJdQwCKwa6P02QLCwNoTatFRq8fBlDnudan2xlgwJF1zlw5IMqIN
	J/VR7+HJDdxtpWQI8TBz0naF3hIhMhZxGxFa4tfnNOjOgTaUCrm3SVgDyrGqRYsHI=
X-Google-Smtp-Source: AGHT+IFmvaUxKM2YmSDzUPFoymenSB08cxuJBJYeqTxsL+DsKne2xe1WD05RHO30V66uoOomO/WhoKlJDKAjJemViv0=
X-Received: by 2002:a05:6512:1101:b0:553:24b7:2f61 with SMTP id
 2adb3069b0e04-55356df2b3cmr1838173e87.57.1749111024615; Thu, 05 Jun 2025
 01:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <CGME20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1@eucas1p1.samsung.com>
 <20250530-apr_14_for_sending-v3-3-83d5744d997c@samsung.com>
 <20250603-whispering-jaybird-of-thunder-f87867@kuoka> <d42a8c49-7ad2-49ef-bd9c-1e3d9981b58e@samsung.com>
 <e5a0bee2-ff74-47cf-ad2c-0c78b57ae6cf@kernel.org> <a6a29e58-8613-47f0-9e5c-d125da7ddb49@samsung.com>
 <cc4dbf7c-e023-403c-88be-4691f97a0ff0@kernel.org> <c7774790-07c3-469d-a994-9e84108ad21d@samsung.com>
In-Reply-To: <c7774790-07c3-469d-a994-9e84108ad21d@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Jun 2025 10:10:12 +0200
X-Gm-Features: AX0GCFvEjcOAzs8GqTAWhoTL8unWEk1FSQC7E_ts2kCxQpL9-TEmMcPX7FYfnJE
Message-ID: <CAMRc=Mexq9ThfG6jZUbs3wYDA9UZN-+pHnX_Y-7WO4ubXvEuCw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] drm/imagination: Use pwrseq for TH1520 GPU power management
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 9:47=E2=80=AFAM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
>
>
> On 6/4/25 14:07, Krzysztof Kozlowski wrote:
> > On 04/06/2025 13:53, Michal Wilczynski wrote:
> >>>>
> >>>> The GPU node will depend on the AON node, which will be the sole
> >>>> provider for the 'gpu-power' sequencer (based on the discussion in p=
atch
> >>>> 1).
> >>>>
> >>>> Therefore, if the AON/pwrseq driver has already completed its probe,=
 and
> >>>> devm_pwrseq_get() in the GPU driver subsequently returns -EPROBE_DEF=
ER
> >>>> (because pwrseq_get found 'no match' on the bus for 'gpu-power'), th=
e
> >>>> interpretation is that the AON driver did not register this optional
> >>>> sequencer. Since AON is the only anticipated source, it implies the
> >>>> sequencer won't become available later from its designated provider.
> >>>
> >>> I don't understand why you made this assumption. AON could be a modul=
e
> >>> and this driver built-in. AON will likely probe later.
> >>
> >> You're absolutely right that AON could be a module and would generally
> >> probe later in that scenario. However, the GPU device also has a
> >> 'power-domains =3D <&aon TH1520_GPU_PD>' dependency. If the AON driver=
 (as
> >> the PM domain provider) were a late probing module, the GPU driver's
> >> probe would hit -EPROBE_DEFER when its power domain is requested
> >> which happens before attempting to get other resources like a power
> >> sequencer.
> >
> > Huh, so basically you imply certain hardware design and certain DTS
> > description in your driver code. Well, that's clearly fragile design to
> > me, because you should not rely how hardware properties are presented i=
n
> > DTS. Will work here on th1520 with this DTS, won't work with something =
else.
> >
> > Especially that this looks like generic Imagination GPU code, common to
> > multiple devices, not TH1520 only specific.
> >
> >>
> >> So, if the GPU driver's code does reach the devm_pwrseq_get(dev,
> >> "gpu-power") call, it strongly implies the AON driver has already
> >> successfully probed.
> >>
> >> This leads to the core challenge with the optional 'gpu-power'
> >> sequencer: Even if the AON driver has already probed, if it then choos=
es
> >> not to register the "gpu-power" sequence (because it's an optional
> >> feature), pwrseq_get() will still find "no device matched" on the
> >> pwrseq_bus and return EPROBE_DEFER.
> >>
> >> If the GPU driver defers here, as it normally should for -EPROBE_DEFER=
,
> >> it could wait indefinitely for an optional sequence that its
> >> already probed AON provider will not supply.
> >>
> >> Anyway I think you're right, that this is probably confusing and we
> >> shouldn't rely on this behavior.
> >>
> >> To solve this, and to allow the GPU driver to correctly handle
> >> -EPROBE_DEFER when a sequencer is genuinely expected, I propose using =
a
> >> boolean property on the GPU's DT node, e.g.
> >> img,gpu-expects-power-sequencer. If the GPU node provides this propert=
y
> >> it means the pwrseq 'gpu-power' is required.
> >
> > No, that would be driver design in DTS.
> >
> > I think the main problem is the pwrseq API: you should get via phandle,
> > not name of the pwrseq controller. That's how all producer-consumer
> > relationships are done in OF platforms.
>
> Bart,
> Given Krzysztof's valid concerns about the current name based
> lookup in pwrseq_get() and the benefits of phandle based resource
> linking in OF platforms: Would you be open to a proposal for extending
> the pwrseq API to allow consumers to obtain a sequencer (or a specific
> target sequence) via a phandle defined in their Device Tree node? For
> instance, a consumer device could specify power-sequencer =3D
> <&aon> and a new API variant could resolve this.
>

I can be open to it all I want, but I bet Krzysztof won't be open to
introducing anything like a power-sequencer device property in DT
bindings. Simply because there's no such thing in the physical world.
The concept behind the power sequencing framework was to bind
providers to consumers based on existing links modelling real device
properties (which a "power-sequencer" is not). I commented on it under
another email saying that you already have a link here - the
power-domains property taking the aon phandle. In your pwrseq
provider's match() callback you can parse and resolve it back to the
aon node thus making sure you're matching the consumer with the
correct provider.

Please take a look at the existing wcn pwrseq driver which does a
similar thing but parses the regulator properties of the power
management unit (in the pwrseq_qcom_wcn_match() function).

We've tried to do something like what you're proposing for years and
it always got stuck on the fact that DT must not make up bogus
properties only to satisfy the driver implementation. We've done it in
the past, that's true, but just because we didn't know any better and
DT maintainers are currently much stricter as to what kind of
properties to allow.

Bartosz

