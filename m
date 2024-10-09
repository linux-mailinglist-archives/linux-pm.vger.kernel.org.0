Return-Path: <linux-pm+bounces-15409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB88E9970FA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821901F21ACC
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E49E1E131E;
	Wed,  9 Oct 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7kj1Olp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3F1E04AE
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489585; cv=none; b=gimHYemqbeWwfQAQBy2qD6cU4rTs5umVdb/r8PdZ2ld1YYGF36zQ+Gt7rx2SnTZxNVL5/+NJRxMXPhcKBodoMXA/x6wKyIJrtiF0+nxKDxAe/SFSMt7t8kA/lOdvFpSgfozpPFBdh7I23hksIvDm+LmPU0EfJrHrwfY4qcQFPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489585; c=relaxed/simple;
	bh=xwopJ+CGEk7FXIiTOjEI60sWNElcBaD8CeL/EvQGYoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6Z5CgOLiI7RK2jBKfQKDqHS0cYR6M/vZiJN4wFWECcMSwdcIsag4hLMsRoneRBdlSBE6X/kBC915oRGWnTkoIGH1wCFhTGJoXBWZunhmCEDljYgahBYmyJlEQYyKyadePU4dUevuN56PEfbS6Ia6iCNTrc4ghT5pMTP6jhR/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7kj1Olp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2C2C4CECE
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728489585;
	bh=xwopJ+CGEk7FXIiTOjEI60sWNElcBaD8CeL/EvQGYoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G7kj1Olp8IspAlFdNlGa+/bHtV74WZCnMnCk5rw5bVryZ9i8DevurN0+ZKhP10BPM
	 eJYgp5Ihr6pOURDzkIktiRPdWupyKksLG5z/LHhgs92P7infmeShvciA5MiXva+4DN
	 35/4has8oSzDi3PpP7QssT4m2if5Y3oU6YitmLf15va8wWfjg50hWCrvHZT3nvRb5M
	 w4ak3MQeqsc6+cR4D5Wj2f9gx0ljvoekmtwJnSfQ7Yvnz5upYSKRA1SkHElm2K74h2
	 bmgbFhEXRMZaRN4ZcnW+eaJkPC9dM1EMYxPUx4b3U7xyOYtaRtLK9tQ0aubyDOkjH+
	 qrhDaNVF+tSuw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e4d624ac53so174431b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 08:59:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyiiofJPo6RHWgwGOrSFyZnn7XJxA7dBNDG8WKI5CkSSUOPaQmAVvHL83lrs+eJkYKKhsYx/9xgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSD3NEzjyAB6q71fuxhPpmC0dCCs51r2AmP5b+2xhcAP5zcNN
	8QezuawWyErWMtJ+DESTH6WOw6VtQUmHzlCFbe9v8MUAJFTqjnGZLmW10+5fdp3Ku8nVvSrcHpq
	vvE9ZgouJzNeMJ//lDACPUkPFeUc=
X-Google-Smtp-Source: AGHT+IFRIzW0rvgvYgpnuefRw9cmpzBzmczqOtRT+SNgwsnxICh10g+PTBGQpSHPz4ppMDw0Pt3uZbYT5t2XVta0yAw=
X-Received: by 2002:a05:6808:170a:b0:3e3:e3ae:b73b with SMTP id
 5614622812f47-3e3e672b12dmr1700456b6e.25.1728489584754; Wed, 09 Oct 2024
 08:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
 <20240923100005.2532430-2-daniel.lezcano@linaro.org> <CAJZ5v0i9N_ie_duMXYSumQSnFDVxHj1h1ikSyrApJyEjXs_mQg@mail.gmail.com>
 <CAJZ5v0jCOHAmpmniVRuGCrtvKj6+YtCKidKSJf1t+HitwpKrwg@mail.gmail.com> <d9682276-1068-4b90-8478-bf1f5047d306@linaro.org>
In-Reply-To: <d9682276-1068-4b90-8478-bf1f5047d306@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 17:59:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iUYnJi61TAaUz5exRhH7fjwDSXCCeVVUQgm80L-ujfnw@mail.gmail.com>
Message-ID: <CAJZ5v0iUYnJi61TAaUz5exRhH7fjwDSXCCeVVUQgm80L-ujfnw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] thermal/core: Add user thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Oct 9, 2024 at 5:40=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
>
> Hi Rafael,
>
> On 02/10/2024 14:22, Rafael J. Wysocki wrote:
> > On Tue, Oct 1, 2024 at 9:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >>
> >> On Mon, Sep 23, 2024 at 12:00=E2=80=AFPM Daniel Lezcano
> >> <daniel.lezcano@linaro.org> wrote:
> >>>
> >>> The user thresholds mechanism is a way to have the userspace to tell
> >>> the thermal framework to send a notification when a temperature limit
> >>> is crossed. There is no id, no hysteresis, just the temperature and
> >>> the direction of the limit crossing. That means we can be notified
> >>> when a threshold is crossed the way up only, or the way down only or
> >>> both ways. That allows to create hysteresis values if it is needed.
>
> [ ... ]
>
>
> > I'm inclined to apply these 2 patches with the change mentioned above,
> > so that I can base my 6.13 work on them.
>
> I was expecting you to pick these two patches and do the modifications
> but I don't see them in your tree. Did I misunderstood your comment?

That's still the plan, I've been waiting for you to respond and confirm.

I gather that this is OK then.

