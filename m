Return-Path: <linux-pm+bounces-4427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31786891D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 07:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B9B1F239B2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD0053388;
	Tue, 27 Feb 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVgIQzsm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200F52F98
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016444; cv=none; b=X9HQUfLntPCtoq1XZT1uZs49lLsKNItlRkkgCQnDCp+QYiXc7jLo1eV4ZYaH/mV0I1pGeOYnZ5q9prZYytxfx2YKnTrfX8PNTCWuPmBo5IFbO0fFQyogL/1YQvAvFRLbWiMI0vwfJO7tTbm2e6lKgt8HZ+wDh+RMe0ROK7EblsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016444; c=relaxed/simple;
	bh=FQTudPcpkZaTI0zIJDvUPtJ37VPCPjXib0ufIdpEE+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa59aOJiU/qB37jyFdhRZ1PBazkLcFhVtdj4FLLNONtvlfkZZE1rEnNO6YggrLOggc12BdPQ8nK2cMTlbUIql9clhyZUo8VqYpeFlo0ncbsZ+mViFbOjzzlXvaXnbitPEvb+k+FzmnaBtEZ2NT2eM4jq5d/mzj1m1mE7yPRtjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVgIQzsm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so27535e9.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 22:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709016441; x=1709621241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXqI+zcN6Kyg8yDvDhjQmTqttyow+PlffI1J4OY9Sd0=;
        b=LVgIQzsm6UDZpI30PF0zus+O+6w86GSx9qLElY9fqysjEfA7w6PUfDyiyrj2Lw5RJX
         9v/uV2ixSb4dvaqw3NrK6/lmPp6gBqXagWNwVsC4EFJPZXXGi80AdeZ4ehIZdhozA9Aq
         kCUabK0/ctcnmg6dJk3cclxmTB6Cqj4xw2CzeemYBLoGchDQVxhnKOEu75dIl/GIhctf
         UClJOYVNKKUFgZxapPCh8jymBq5dzPOJK/ubjBqGa2msGm7gFil+bttLfl5DF0tFXCVI
         cRHf66smthXENdB9lfzaG1W/B2u/q1qp6UNogLJHtVkZbGvgdv8um35/HaHeuIelXVzG
         YNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016441; x=1709621241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXqI+zcN6Kyg8yDvDhjQmTqttyow+PlffI1J4OY9Sd0=;
        b=V0v0RHgoIzOyxEgTcLjGElCwqWZ9d+FuNaEroWxR2I1Ubf8M40jMOqKej+n9ASu0tq
         JlyYekb1JPerAbz4j8tEVx4EdQxCl3s4FcP9S2H+7wm5QHDtdMoUhgCvIE/5QL/tXuLn
         rCOnZBEqG+3zRVdLThHqDU90cShFwTyDuDyHBc+8sbIf1PLzX2UT9DBJ+mfZEEJLDH4s
         /dY69V6Si3605o91wZ8Kmi65pUFYuQQipKg3zsxpMxIpSXsmSJCru2FaWXoeEdQyeaG3
         OHPLOR0cycDMdIaR3XLs7s+9Ur0cBZRSFZbk2CTnKTdA+Ugc/UL/KjaIi6aBzrOhVFa+
         GQrw==
X-Forwarded-Encrypted: i=1; AJvYcCVFahyUVKK0K+gkGt5do7Q8EPxAf2PZ8GoAhNRo2bw4WzIh+YRSncmyYo7u/pPufjonCWw0Cfp+KKaYpHGMRDoSuQ+W474mT/0=
X-Gm-Message-State: AOJu0YzY7xSFqt2iUDzAwHQLnWcU/6U7ojxqVPJGPbrPcGtTvK5WGH+M
	2DKG1fYl68wXuW+tjxogHHZjlvXNpCRLdXDIO3HkOP7XTdZhM1NRosoJMH//llKaYZCar5sFt/B
	EyP5Jeq+P1Y/dkqoTh9ghchk4ykVECF7q+9PK
X-Google-Smtp-Source: AGHT+IH/QljZiEIXJggfA5kRRMKF1y6R5GkHf7YRtbf5BV7l15E1091WjJjsLSbmMVb1UG0GQrjRm6iiyuAYck5XeZs=
X-Received: by 2002:a05:600c:500b:b0:412:a4a5:dec6 with SMTP id
 n11-20020a05600c500b00b00412a4a5dec6mr87731wmr.1.1709016441361; Mon, 26 Feb
 2024 22:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com>
 <Zdi3UWWRfKw1N_Jn@smile.fi.intel.com> <CAOuDEK1KbZ9=W3ffWN-h_AAhbB9RqJvKsnF4G9qus3o2wkk=3w@mail.gmail.com>
 <ZdyZ-e6m_rFG4dY6@smile.fi.intel.com>
In-Reply-To: <ZdyZ-e6m_rFG4dY6@smile.fi.intel.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Tue, 27 Feb 2024 14:47:00 +0800
Message-ID: <CAOuDEK3ZiwaXR974mMDrPMDzCqbLnBHfxS24KH1fLD6iT-n4pQ@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, rdunlap@infradead.org, james@equiv.tech, 
	broonie@kernel.org, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 26, 2024 at 05:15:00PM +0800, Guan-Yu Lin wrote:
> > On Fri, Feb 23, 2024 at 11:18=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Feb 23, 2024 at 02:38:29PM +0000, Guan-Yu Lin wrote:
>
> ...
>
> > > > +     if (kstrtoint(buf, 0, &ret))
> > >
> > > Why is it int? It seems like flags, should not be unsigned as u32 or =
so?
> >
> > The ".event" member in struct pm_message is an int, but the values
> > assigned to it are used like bit flags (e.g. PM_EVENT_FREEZE=3D0x1,
> > PM_EVENT_SUSPEND=3D0x2, PM_EVENT_HIBERNATE=3D0x4). Is this an intention=
al
> > design choice? We might need to change the design accordingly.
>
> It might give a subtle errors related to promoted signdness.
>

Should we refrain from using the bitwise operation here? Or should we
just change the type here to u32?

> --
> With Best Regards,
> Andy Shevchenko
>
>

