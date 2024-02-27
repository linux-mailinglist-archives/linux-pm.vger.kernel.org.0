Return-Path: <linux-pm+bounces-4468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C486A055
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 20:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579021C23521
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B20524CF;
	Tue, 27 Feb 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rB8m1HS0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F41524CC
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062698; cv=none; b=uVI59rQmnwFktsOOZnCew6AH1kyoKGB90fYgw1pqqZklBX2SAIaX3KXCzn/Cr8j4P1t//jQrr2rLKvtpHQOEIfwsvmD/l0FNaM8P/2SMtY3POBC8+dbbeviiGCyh3w9z+SZwlqK7EVnj3eVpw/7kaLClMjxfn+xWL3tA+iUMk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062698; c=relaxed/simple;
	bh=uXGgIR6AlyuVRK/MpaWhS5RpNMdPXETDnhac0JBD9Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW3rUiUv76WhQnV5opIXvGPS5NStLqUKzOFSg+LPCy3ntuR9KutmjXTEMOhqx69dPLEUoiLxDvqrEpX/0Y8weFm6GkxyEKobIughtDOlxgDgGbTY808kkKk7c9QOJpJ16y67s/i/eAyb670DuNb5df7LsLlTv6Ut3d/E9oGCl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rB8m1HS0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so10265e9.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 11:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709062693; x=1709667493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oshdnUJfJnWYqjpxJrbBngXlFKiFKoDWj+mV4FoHF3Y=;
        b=rB8m1HS0Uu0OLl4vqgIAu1pZrYLJtWm4SgPT+c+KeckLPLWCJBEO3+Yd36zGe5/arj
         qMOqrr4yK6v9c6oEuwkhgXJ6f8Pr5HiKRQu9Od5yZuUjcloS/HRaG/iOiu53Qs/ECXLD
         8vg5e1XYWMOBTuRUezl8OmVEekfVtZVZQJWRdQvRF6MtRdQM0zyFQKzvx3fuz6vAsCiG
         +ZyBZB1JMfijrRsm45841cqJ3L2jeoYmqCrtRCQsbT7nkJvFncFQZKDw2dBtcSIXGn6E
         Hubn0InxTjiOLSSQuYi8e2Ij9vmmDHbN0jzo+OXXkFD91M+S0PQxiljaZGcY4e2sfQ0D
         WEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062693; x=1709667493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oshdnUJfJnWYqjpxJrbBngXlFKiFKoDWj+mV4FoHF3Y=;
        b=xF20Y0u+gshF3dmERjjajzhHTCj1LHDmtD1nZg3CHidFkrkMtrDKAYCeEUu/hJlV8v
         6+z0foHqXzedQ4+DzjyCdN3VIPlrVUpE3PKsY5SBP4Cp9Z46Rlkzsra2C35a/0gB9i5m
         U5FoD45wEefpq4alQqcdZjtiq9ICaZOHbKb/oPcAjPcYS01KYAQAvQqnkAfpNYe6NBi7
         //WcnrBvLlyvVpaPZ0/xRxFSJbFR5Qxv6W+meoDBqGQnZ+RRbcFnbRGgbN7gOfda81Fm
         hVLBtZokgQjm0Oh4tKpl+eiBgaFTprEeCLjYWGzXSqIL69S8BBYmtK6JJZa+Clg9Jaqx
         noLg==
X-Forwarded-Encrypted: i=1; AJvYcCVkP/4TUWMd93BL24uIy/qdBjHJSAKZe9x02h/5My14xd6kIhpudXES5UM2I3zXJwFUMOVNBDsmwlnQOE+srbFgu+0XbgMYbv4=
X-Gm-Message-State: AOJu0Yy79BlG+idemsSZzIZ7f2PVgHflL0pyQJQNUli1Fw9JI0umAwQl
	S2OymxrwKUAadVcZvvalQJJ0ldanSiGfsU1wKIf4syZoBbbZY0mF8f5Mmf5ypQ8dsv30Cwa7vpa
	8pdKf4u6WfoaB7OspfA9Ie49EtZfJw0SLq2w=
X-Google-Smtp-Source: AGHT+IGgE7pybhMGkAZbJpOdx6GdA8Gm2qtbM4A7vr/iWITTqkgKV0bwFGCof3F2RyX1iI9NK48sH3pjL4VfXaAkawU=
X-Received: by 2002:a05:600c:a3a3:b0:412:9829:2dd5 with SMTP id
 hn35-20020a05600ca3a300b0041298292dd5mr231716wmb.7.1709062692681; Tue, 27 Feb
 2024 11:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131552.864701583@linuxfoundation.org> <20240227131554.144760148@linuxfoundation.org>
In-Reply-To: <20240227131554.144760148@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 27 Feb 2024 11:38:01 -0800
Message-ID: <CANDhNCoGL7voc11QFt5rBXXibMSvDM2YxZ8ocV1fkGYh=Mm0nA@mail.gmail.com>
Subject: Re: [PATCH 5.4 39/84] driver core: Set deferred_probe_timeout to a
 longer default if CONFIG_MODULES is set
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-pm@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Bjorn Andersson <bjorn.andersson@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, John Stultz <john.stultz@linaro.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:27=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.4-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: John Stultz <john.stultz@linaro.org>
>
> [ Upstream commit e2cec7d6853712295cef5377762165a489b2957f ]
>
> When using modules, its common for the modules not to be loaded
> until quite late by userland. With the current code,
> driver_deferred_probe_check_state() will stop returning
> EPROBE_DEFER after late_initcall, which can cause module
> dependency resolution to fail after that.
>
> So allow a longer window of 30 seconds (picked somewhat
> arbitrarily, but influenced by the similar regulator core
> timeout value) in the case where modules are enabled.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Link: https://lore.kernel.org/r/20200225050828.56458-3-john.stultz@linaro=
.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/base/dd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

This change ended up being reverted upstream in ce68929f07de

Is there some specific reason it got selected to be pulled into -stable?

thanks
-john

