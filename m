Return-Path: <linux-pm+bounces-16814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD2A9B7871
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 11:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2827DB24A1D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DE197A9A;
	Thu, 31 Oct 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLsI4n1a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA612B169
	for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369552; cv=none; b=a7nlbBYGm3Y9yusSsM4AHxagn5xHZhY9Qyf8L7o4qAMUbimRkc7GsA8O/MrPOTaD3bHRjEtuczpkU2QxvNXV12EOjaInbljTJV8m+ZMb13Sd+WiYSptZQswVHvxDb2MIn7lcT+sh126ON8PFh0FJm9L4sor4QIBfXBK55m1zhTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369552; c=relaxed/simple;
	bh=T35wMVs1MNW3myHz/mrvwXNZ7HSH/Zu34Y04Hh5lKAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvld9pFqXM2vd00izBFfLvlotyaZY4GVqvO7mMbMT1/P3Xy9EyTjGwN7sFQ6kYfatAUHcvUkFCC4Cp0P7klmI7ulk0MgjEDNO9Y2SBJNYbFuke/wSBkmfHJOTh4SrYu33gwZaZfZMNCWrOxP19mZf4BsRxa74JFmbYfYNzRBT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLsI4n1a; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ea0b25695dso5824497b3.2
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2024 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730369549; x=1730974349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T35wMVs1MNW3myHz/mrvwXNZ7HSH/Zu34Y04Hh5lKAk=;
        b=uLsI4n1a5fllndcUeZW6rxJGQcwDJIbID5YPjcLyH+X5hKDiGu513j/2dCm9N/407S
         SpwA/vN/p33kpGh6Cpq5eXZWWxs8oPId0614pz57/JZNJsLaqsNcgSY57Ta/RbcBQXne
         vhlrz9K48Z5aoX7yn3P922/7504Yn9Taqe6OFJXeNG18S5M8GCPaKCHg3LwI0YtcdF/f
         g4EXn89mka2dSyHzKimCtycGldyhYyTx4ddCpdNMffXk7S0eVvj4/BbaKj/Q7xVMaE65
         CTLxZ8KSQynJdV/Zzcqfoftf42cVxlZJPEUca7u8AhzkEkHQwvy5Ac9rzhRlC6S21QMj
         12Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730369549; x=1730974349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T35wMVs1MNW3myHz/mrvwXNZ7HSH/Zu34Y04Hh5lKAk=;
        b=HdyYoTMw9YeeIxr4iOmNrSMvEBh1jo51rb1QhKqcICcKYKYzzW92wJwJz7YrX8Djcx
         xNOOoV2ofTTP8tYyuOJKW8pWH3gTCo7ttm6clgaBL0hPsPsZ1BZaxb4Nr4hGO0md3vJW
         AnFSjyMo3KiVXNW2LGgKhoX4vf5SEtB1BMe5owZO2iqGO8IEweD/GwV2rXWnvAOdnice
         UweBIVoKofdMEKIEVKFNNL+oMf/Zofu3ZcRQm+Z36ieBgFxSZk8BFLc57+ixPJKCrz90
         hUqcfYirylwb6mMAo0927WOxANjdfkXDcRLAXce2a5fV/sJHYZYqjdRXN3qKsMO250kf
         Egrg==
X-Forwarded-Encrypted: i=1; AJvYcCUuA6b4WXWJbmgIXqCW07OblBm9AUVk7bc0IJbpkgrtaYjhw9a4sg+ayLVnrH0tNeVdp0j0mLU5nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8h/NL3IC+DxHNKhwR08rBY6LQOZvE27dKtA5y0oLe6XcGo6e
	GaUhsiDo69B1O2nOg4hXxhGtB5a4gKod1KPSENY6o33sabhKXCxr5qK4A6pZjh5kE/4VKShKZMQ
	wN7dDgnLkHg5CN9PB/ddA+ucMldlJBHvN+thITA==
X-Google-Smtp-Source: AGHT+IFa7GpMRcZBsCmM7CXrwXH4F/9S0bZVX2rOTwZ8gwWPISz40Itv+XpN30B/P4QqbSfNO35YnVdPLxOpi1AIrVk=
X-Received: by 2002:a05:690c:ecf:b0:6db:9b55:80df with SMTP id
 00721157ae682-6e9d8acaffcmr188192657b3.33.1730369549381; Thu, 31 Oct 2024
 03:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <173029317079.2440963.17313738472826934777.b4-ty@ti.com> <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
 <7hv7x9qsvt.fsf@baylibre.com>
In-Reply-To: <7hv7x9qsvt.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Oct 2024 11:11:52 +0100
Message-ID: <CAPDyKFpdgg+kM_Ot5GPTpMUtjmBF-pUhCeRpVb=j852_7qm=3A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power mode constraints
To: Kevin Hilman <khilman@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 20:43, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > On Wed, 30 Oct 2024 at 14:01, Nishanth Menon <nm@ti.com> wrote:
> >>
> >> Hi Kevin Hilman,
> >>
> >> On Fri, 06 Sep 2024 09:14:48 -0700, Kevin Hilman wrote:
> >> > The latest (10.x) version of the firmware for the PM co-processor (aka
> >> > device manager, or DM) adds support for a "managed" mode, where the DM
> >> > firmware will select the specific low power state which is entered
> >> > when Linux requests a system-wide suspend.
> >> >
> >> > In this mode, the DM will always attempt the deepest low-power state
> >> > available for the SoC.
> >> >
> >> > [...]
> >>
> >> I have applied the following to branch ti-drivers-soc-next on [1].
> >> Thank you!
> >>
> >> Ulf, based on your ack[2], I have assumed that you want me to pick
> >> this series up. Let me know if that is not the case and I can drop the
> >> series.
> >
> > Well, that was a while ago. The reason was because there was a
> > dependency to another series [2], when this was posted.
> >
> > If that's not the case anymore, I think it's better to funnel this via
> > my pmdomain tree. Please let me know how to proceed.
>
> The build-time dependency on [2] still exists, and since that was just
> queued up by Nishanth, I think this series should (still) go along with
> it to keep things simple.
>
> Kevin

Right, that makes perfect sense to me too. If we discover conflicts,
let's deal with them then.

[...]

Kind regards
Uffe

