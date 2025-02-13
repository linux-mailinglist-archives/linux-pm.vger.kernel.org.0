Return-Path: <linux-pm+bounces-22002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5754A33A03
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 09:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BEF18842CC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517FD20B80F;
	Thu, 13 Feb 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGNv0Izj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC02054EE
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435492; cv=none; b=E9stMIvkjR6uw00FM1OQDS5PMB4DFeKg5lXNr9SgZhxZhEAH0eV3NjSikF0m1OzbfnpKhglcieE/eSKWm/s4TcfCucc98zhuePRYbr3g+66qKIr4ynuIHIeASNojBgfYpm5nKjjmZUZM06FuKlRhoz8mMLMfAig6+ShVCvyMl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435492; c=relaxed/simple;
	bh=L25nrY27bgTQ9n4g/1cHQoTCJ6y6XVKfBEEs6t5MU20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYqqAdfm8zX59bASkUxSmEWClV/bGgp0dRZqQSe1MkXzE/3dPMnbu9FDNRa/8zdb3/1rgzpHslwYkW3EXoH9PxVqSxhbSa1lRyGtpti25LPhMkMw7SvqOy6f61djsFPo5Meq01QpawcM3T/L1vndroo9HESzQ0VGFKPdX5oWD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGNv0Izj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5450cf3ef63so575939e87.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 00:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739435488; x=1740040288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqYuvd73ewFdC9LGI08iIdezVI5Agbij5wls3/+Pd9w=;
        b=VGNv0IzjdPMpzqkQ6VJwodmsn1hwBsxCu6WnXWa/y6naysLawUWuq+MpBvPg9c/xUB
         0p6Z+kbSXZQsD0wolnid0tWNWv2g8Kt5aRpT4a+5m+6RgOY6mereFXN8mB+WopCXV+iA
         pSGwHcxfPhOk0ygyg7fyDSUnrN8kxgw6jiMqC+KknnKiqgRjQQDZX/WrMJvSapmdGDS4
         RC5lbsG6LV1EGUwNYpxI9PRcJW1vZRylT9dv4TTULUzieLJPAYhJiJuZjIckgj0lCRj5
         NTRkzcR0Zx4UiYq6Pu8PLDU9g/5EEBn9fCYzdtt+Gm8ZZ3VOVbmkl6l0k/AMxKIfwygx
         a5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435488; x=1740040288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqYuvd73ewFdC9LGI08iIdezVI5Agbij5wls3/+Pd9w=;
        b=q0SGRPGIMitM7SMfbsSZTjt6vxrARRq+obor68et5F93pfO7WlVzUk2zMxXqMwG2O1
         1zedSAQwfzs5h75xWmFUAQ3PRXTfhSWi8FY4xHsYCGlmeKWN8LUoJfcHG/JCmyhWCSWY
         zpuR1Do/mV6gA+AlFbq+fp2hyd7K7yoMduwHpe3KsBK4Y3iO5IIDItMiuSd2L+ld9WvQ
         jv/GeX5WYoPn+uyi4GnBM+2w3SaE9rw2uFVWkVti9vR4P6GTyO/h8lKIE9X9AGQsgmJC
         HAjmtbbE+ii1AIZh9eTow9auABY8yDMBn1NbA+6Ryhl4dAfQ/SODHepfqz22tf+CdCBQ
         gZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCX2i9ZbB/FZX0UrJQ0hHSX37CoE4yBRgDlpXnQHsGalRMbAL4fKeGiwzy4HzGLCka83XurQB9IS4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWxMPRSVj2LeWcOcAVsNhRTJTfveYO+QdpLxCGOL0Q7WMojRB
	72uC0UWojfHcOwU8JE/UsJBj6ikMLZleoLdAQYygACZtBi5YBpwNcmnnjeGBla2dHSHUne5nXU2
	RA8yg/CakoZAEXKGViDBdCAfbB/DUSKk+quI4
X-Gm-Gg: ASbGncuHy3Hctbg5sYI42BRCH7rlbHgL8aKNZmvY2kEGeDuQFgkzMuEpyoIvmRCKeLs
	3WIAJx4xkEaY3rKxiO6tdCRXsEdUcJN754H3mI003tmvQhUrkLteVpun4wdAckv4CAmV0BBs=
X-Google-Smtp-Source: AGHT+IGpzgKBnlzlI17bAlkc7hVX0gihSIWqb7XNIa4ZHRZHg8qVXL3z0Eph4UoadM3AqA+kzKLC1HMwKydNxeaTIqM=
X-Received: by 2002:a05:6512:1056:b0:545:8c5:44cb with SMTP id
 2adb3069b0e04-5451dd9e2ecmr815118e87.31.1739435488357; Thu, 13 Feb 2025
 00:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
 <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
In-Reply-To: <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Feb 2025 00:30:52 -0800
X-Gm-Features: AWEUYZlU1z59xVb1UWJjvijh9vxRZwTp3eFMUqBlg8xzQmISt8RNRcB6a9aYInw
Message-ID: <CAGETcx_wA9RB9QhMPqsLHDFZ4cwOFgE8dBL9ssFkT=J6DEgjGg@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:24=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
> > Instrumenting all dev->power.completion accesses in
> > drivers/base/power/main.c reveals that resume is blocked in dpm_wait()
> > in the call to wait_for_completion() for regulator-1p2v, which is
> > indeed a dependency for the SN65DSI86 DSI-DP bridge.  Comparing
>
> [...]
>
> > Looking at /sys/devices/virtual/devlink, the non-working case has the
> > following extra entries:
>
> Note that the SN65DSI86 DSI-DP bridge driver uses the auxiliary bus
> to create four subdevices:
>   - ti_sn65dsi86.aux.0,
>   - ti_sn65dsi86.bridge.0,
>   - ti_sn65dsi86.gpio.0,
>   - ti_sn65dsi86.pwm.0.
> None of them have supplier:* symlinks in sysfs, so perhaps that is
> the root cause of the issue?

Hi Geert,

Sorry, I haven't had time to look into this closely. Couple of
questions/suggestions that might give you some answers.

Is this an issue only happening for s2idle or for s2ram too? I'd guess
both, but if not, that might tell you something?

The only reason the wait_for_completion() wouldn't work is because the
supplier is not "completing"? There's some weird direct_complete logic
that I haven't fully understood. You can look at that to see if some
of the devices are skipping their resumes and hence the "completes"
too? Also, runtime PM and some flag can cause some lazy resume or
avoid suspending already suspended devices behavior. Check that too.

Hope this helps.

-Saravana

