Return-Path: <linux-pm+bounces-22084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D9BA35EC6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 14:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06196166832
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFD264A62;
	Fri, 14 Feb 2025 13:16:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42E22D786;
	Fri, 14 Feb 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538990; cv=none; b=uSmVrkaUVMQaSWmwYWKMzBwbHxKfob59egWdRpNaa8rhOy9EA+g4AOy7BCqOVJbLaVKevqomYrRMNIHog4zwo3gB/gUP171qk40hgyjFD3LUCCxMF73CegkfuKhQlTHsfo+JGjW2FwmNWp/IihBMgAjUXLb45QyGtnWxbbXQDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538990; c=relaxed/simple;
	bh=1hS5Vle+g/q9XvEnA2MvPqrBd/gpu16zPsjPc98juo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehJSJ3UdxBDJAo8bFS0W7zPzqAjoh1CsGqYPdr93hNSTqDSxTg1gCvIstClfrIEcbO31WVS8qx4u0WG8y7w+Ehg/9jnBHeh0BjBcQGC2pHrtmQ5wf1C3bdPE5Xz1zSCVQDt5b6bR/ll0mGV9v2NgKFWYc3cRy5v5uPnwHoUoCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-520847ad493so641866e0c.1;
        Fri, 14 Feb 2025 05:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538987; x=1740143787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0BS+w+btNVzSfe+gnqs3oIU7cm6xzL/ZJ4nnMO7/6Q=;
        b=l1hJf9VBMf2d9I91/M+e2BHbD0Z+IrGeo3zy1d9DPVq6BIIqDlb46jTTRBMYtgXQBv
         IZWScsUZ7IFHBYFOSbOYBL/EOTGrtDuKsjCVdXkWdYchwkz2f2Wsys/B6SydfkWcg8cX
         kNtqRgRXn//o50LTgdGb8v4psAVFJICUgZ4T13NsiU/7iig3/ZfZqOoXN4YYgFQg73JG
         4OLQ/g9PJuUHAKd1wMdeBpU0OZ0w1N1hfImf1X1AgTxHHR6j1w0ZH7wmm7z55/UoRPms
         pan4lB0eoqYhTmK+tYyDuqGyBQU5/TMRDly1Q5h5ywMufQKza7FhP8yM2SlRAKztsCfI
         qhRg==
X-Forwarded-Encrypted: i=1; AJvYcCWVBk4hC6ZzpCC1JAUg2fmIYmN1ZJ84gHva/+QBSwxDjqq/SWNAht3JO43VwJhP4UwnUH0nfTYQeAWvKbI=@vger.kernel.org, AJvYcCWilvAli0hr7bvPXdbniCmMH+MCWueU8Po7GY/Lv5CX3ATguRh7iv8uKfsqBMgHPvmh4pnyY4xCX98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCl4hY5X6u1yWOYyxsZi2Uyrne2DAbuL2WVmF42vAryUYrA1E
	MqEoIpJ5hhzP8ET1bOTLqrJn/BFCtys/QpydU8bLOhE81LGPJg7YD7DK0xQygxA=
X-Gm-Gg: ASbGncsT1jew4WuSqYpB6mN2fA/z45bD/L4rWauxZItjliwgiY3rOQYjK5gxgDPh3kN
	eYltuOSdTlbp9htC7i4uZTbkACUkWYdVSugcENBTFM4wukvC/xBD7pXNVVplMkFyRcSRIMphfkt
	KO2hmDSTr3BU9Qv+FLi71LtHb35BKym/TJhqnvWI9CwUF6+Rex4vMhZdRpiK162U+hJGydmND1r
	rY2SzARF4T7kJzaHgL/0W3QHQRJe4Pz7MC/nRtYaiIIDqihWcetgrgt05vHzEIOl5eY5IAUxSYB
	YlZ+pb6UFJfy6gcKkhlC92QoviSFwYSWKy3DeCaULTNYb7Uksvdyhg==
X-Google-Smtp-Source: AGHT+IHGnw44gehwqh+RkmcYENFLiq+rSRSd2rAQxkwhb2ItUZ+th07v2CP2/RH8c/vEJQZwjj6COA==
X-Received: by 2002:a05:6122:2510:b0:51f:3eee:89e7 with SMTP id 71dfb90a1353d-52067cd6b2amr9368556e0c.11.1739538986742;
        Fri, 14 Feb 2025 05:16:26 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207ab4f633sm615456e0c.35.2025.02.14.05.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 05:16:26 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4bbe31ef430so1342232137.3;
        Fri, 14 Feb 2025 05:16:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwuLsQd/IxvMMH6Y+nBpmbg4e1AznQAM+EV8cEfMRrDFBqNDcUlrDraqpvyPAh2xcvG4R19LNtwqU=@vger.kernel.org, AJvYcCWnDtVP4qDBuGP6cz/k0EfO6o+7P9XXsBehgH78s69G+VnoJtqZk2QQ05a5OekU9FqCwgFiQEja50DbGq0=@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:4bb:edc9:f95c with SMTP id
 ada2fe7eead31-4bbf210aa1emr9510669137.15.1739538986275; Fri, 14 Feb 2025
 05:16:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214102130.3000-1-johan+linaro@kernel.org>
 <CAPDyKFr98DraLvOC83rRFa=uKj_hmwS7Lj0L3JqrbqcFuhdWGA@mail.gmail.com> <Z688uKdqVDaQhm5V@hovoldconsulting.com>
In-Reply-To: <Z688uKdqVDaQhm5V@hovoldconsulting.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Feb 2025 14:16:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXD1yF65ezOmLz2ShP=gnYNNkUfTLfY8RA0m=C+WwtaVw@mail.gmail.com>
X-Gm-Features: AWEUYZlSIlRmseK5vNNQ4sx2pg6SL5RqLE-jro8jxejgHcUj6Mk9u1FfpeC4bLY
Message-ID: <CAMuHMdXD1yF65ezOmLz2ShP=gnYNNkUfTLfY8RA0m=C+WwtaVw@mail.gmail.com>
Subject: Re: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Fri, 14 Feb 2025 at 13:53, Johan Hovold <johan@kernel.org> wrote:
> On Fri, Feb 14, 2025 at 01:36:48PM +0100, Ulf Hansson wrote:
> > On Fri, 14 Feb 2025 at 11:21, Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > > The simple-pm-bus driver only enables runtime PM for some buses
> > > ('simple-pm-bus') yet has started calling pm_runtime_force_suspend() and
> > > pm_runtime_force_resume() during system suspend unconditionally.
> > >
> > > This currently works, but that is not obvious and depends on
> > > implementation details which may change at some point.
> > >
> > > Add dedicated system sleep ops and only call pm_runtime_force_suspend()
> > > and pm_runtime_force_resume() for buses that use runtime PM to avoid any
> > > future surprises.

Thanks for your patch!

> > > Fixes: c45839309c3d ("drivers: bus: simple-pm-bus: Use clocks")
> >
> > This doesn't look like it is needed to me. It isn't broken, right?
>
> I didn't add a CC stable tag since this currently works, but I still
> consider it a bug to call these helpers unconditionally when not using
> runtime PM.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> [ And during rc1 these callbacks were suddenly called and triggered a
> NULL-pointer dereference as you know. [1] ]
>
> Johan
>
> [1] https://lore.kernel.org/lkml/Z6YcjFBWAVVVANf2@hovoldconsulting.com/

Thanks, that was the context I needed to raise review priority ;)

Perhaps Reported-by: and Closes:?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

