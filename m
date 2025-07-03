Return-Path: <linux-pm+bounces-30080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F2DAF8012
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF6A582E6E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C582F237F;
	Thu,  3 Jul 2025 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0GOz2Dg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC91D5CE5;
	Thu,  3 Jul 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567603; cv=none; b=k0Dv9SVc8qbrwo2JwNI/x5sDRT+PoJfVlI3NDe0fymPj15b81Pdks+ccSmRCuC/KcyStlXrcmJ/7Osst0kDC2xaY8NnR2DvnoX3IL5aKrc5vq/CXr0b+7ctfj9yHbwb2b70xSwRHeSK8RWecrSBQ9d8GdWmmaR/OdMa9oh+/Vs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567603; c=relaxed/simple;
	bh=iY85BkZVGgoxJEu88tGytmKfxLrT4qHZK8r+PttF4yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8Pf8wJ8pLNmOEoBOsHEozJm8h4VtianqnzvB6z1HLssNYwQEZPiREJVjAY/kqtPLBx6SuLBGOrMkgmiv+zwdfn54IfCxju3d24N8aLUCJ3j9QgVW+GR/JGS/5dZvZZOX1z1BjvHGxzBkDdFYaCahDC24lMA/Esz3oyIOIYNvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0GOz2Dg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b50f357ecso2048771fa.2;
        Thu, 03 Jul 2025 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751567600; x=1752172400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8mXa+t6YUXZo7Fg3Xqd/oUrkEQP+PUVzRz3Oo94FoU=;
        b=e0GOz2DgP5pF+RMhwiQYdixVuuBiNMs+KoTEbRTrWRmzIt+Zcxl+tYAD9+dQXvUSvm
         P3uWgybfW6eLZnHljcWs4bNWBt9XKri7T8sEcRPZWWnR323K8MeGYor9oaMf8dVxFVlh
         6qgxMiO/KeNbSTIiGY+MO/yCRPWviSxI3xHMJ7tyDqRC22OvX9/czYbAwD3J4pOhnp86
         Tg1NS7mkWC59Q8jBrOQJgepka6Q6iGZB9+//vuF/KWmBms1QXcYP68lallhHc6gOF5Jp
         in/pr0gpj7IET9vCMiDDIfJ3I4ae01RQ/MBPdeiyzV1rxVCyKUuqeGz0uWZs3ggtgPD5
         od3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751567600; x=1752172400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8mXa+t6YUXZo7Fg3Xqd/oUrkEQP+PUVzRz3Oo94FoU=;
        b=nQSc45sJ8AfaVfp7WzLCvNz9yhaaM4Z4ICVn1aTwvo4jnV9c5sIuCAWVba7HeizdrU
         mzhYKQe4OUnHLO7vEXBK9B1qfIhvcVVUBZJA6DVRcLY5TUiD6GrQPtsnmMchG49a6cL6
         jgMIX9yOCiu3dfHklziP4CBL8kMgYj4lKeGJ+KazKJrF0IA2OxxdKVDK+71AT1Ovj6J4
         1vA/abSkSQivaXPmW2DQpByF1c62HirBoqVBcNzlgaeP0Yhli+X8uNzyyOk44m6QSJof
         ckNf4lmzVeQm9B0bmKinitTxbBfRahuekGXqhFsYUwEDul4obswfuU2msZ+dPZ3+3s7v
         eJrA==
X-Forwarded-Encrypted: i=1; AJvYcCV/U/jJQEdWRNF3FysZZ9t9sVGVJnTgIDQEhbscDrqxtWt1LIuo4FBFjettQy0pSTQQYUHd7gRdh34=@vger.kernel.org, AJvYcCVwzVGoU2qZanipLMfhkmsrDikgetTLl/tqSJPjrKFoiXgWEg4UdFGNp842fYklAM5zhcTDqKaKfcupQR0=@vger.kernel.org, AJvYcCXQiCo/ZSF/zP6IUj20hkFvidgodjyb5h9IyNQLBL2g+GpohyZC6mL62RM5fPyOlcq/3T82fFzZ2kQOPSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrD81w0fIvRIPKPVDHaqicbOCMQkMx7lRytzsxZn0yiUsGuoy
	kXZ6vR51ksbvbQ6rhEXQk7gZzoZzjfdxP0xqbJCEt2lOOjqKW9Jc7JFsuoC00BF7BV2LKdm/dAi
	V1beIDISRVNXR/lG5dZhFJqpRhQP4Q4Dy3y4wUuY=
X-Gm-Gg: ASbGncsDfnZVviGZdhIwP+b/9e+RjNtdZV4E+4LtR4FW7xl/SLCavp+ZCCWc+gnMuD0
	ms/zIzwQ4WRHfi3LAxtYcabQ8ozpgWH5uAM4/VD8Vb8cFGtGeJijD+MHxG0Hl8YcZ3DN34jI1Q5
	8j8DbapVl7Y2eDPxPN3qysjhkJLKMKoWuGP588BseJYFk=
X-Google-Smtp-Source: AGHT+IF4aaN60H2XWg6v+/Qj8Z244EqH2cUzPIpYmYhJXoZrcvEZvdNgze4bbKHNl+FZmlYaAo5AYWk3DruHq8QO/tQ=
X-Received: by 2002:a05:6512:1381:b0:553:37e7:867c with SMTP id
 2adb3069b0e04-55628347062mr3215354e87.50.1751567599796; Thu, 03 Jul 2025
 11:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
 <20250702-tegra124-cpufreq-v5-3-66ab3640a570@gmail.com> <20250702081207.bzru3mtl56ns372v@vireshk-i7>
In-Reply-To: <20250702081207.bzru3mtl56ns372v@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 3 Jul 2025 13:33:08 -0500
X-Gm-Features: Ac12FXzz5Yv8oiI05qYO9V66A8XCIkXZSe5g1pk_3izL2EhDAowW1MUYRp6QlbM
Message-ID: <CALHNRZ_jzSGF2xTNMt_giEa4T6r6+qfhp-EubTViqYL7jYf=sw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] cpufreq: tegra124: Allow building as a module
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 3:12=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 02-07-25, 02:46, Aaron Kling via B4 Relay wrote:
> > +static struct platform_device *platform_device;
>
> Maybe initialize this to an error value...
>
> > +static void __exit tegra_cpufreq_module_exit(void)
> > +{
> > +     if (platform_device && !IS_ERR(platform_device))
>
> ... and then this could be simplified ?
>
> Or use !IS_ERR_OR_NULL .

Latter sounds better to me. I'll queue that up and send a new patchset
in a couple days, pending any further comments.

Aaron

