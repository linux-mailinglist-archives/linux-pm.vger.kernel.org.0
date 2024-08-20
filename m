Return-Path: <linux-pm+bounces-12583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E420958E50
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 20:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A2C2865D5
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450C156228;
	Tue, 20 Aug 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ldO+kBAn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03B1547D1
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180024; cv=none; b=g3Cc/q+8RL/2ebsBpXogRLvwTDyTTeqCJ1dcOAfW8PyUSZGkhlaTxJ9FNiQvnHR3YG6wpB4IL7ZGMiLK3fp1HeQr9BZFT/FBF5OpoILmz+fvPDnoMsbZGPA/h8QsxsMCDGI29oLW6SRA6iis8jZ1EomprN2/4QtHldveHdMJ9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180024; c=relaxed/simple;
	bh=Q2U6jltiiNaK+JNKXKBVgR+Xb/Bhf/4VdjQFQy+dZ9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8FQYZu4MZiYHzOUq3HTZKKqblIrPXJEuBH0WqlM65bG20ITy/JJXckY4hCYQguU9V+Do5wGn2XOc6LBI2+skgi7KtfTcJrCkrvb/THnrIsSGDl530Rw5WDyLG+BqZHwE4Ld1j14Imp01cDbOGM4LzEVBFBtaqUMRTPXtZ7yoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ldO+kBAn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53345dcd377so868845e87.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724180019; x=1724784819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlTLMLs7In8/gOHrNjsLpOQwDWaLLP6ewH5dG/aMvH0=;
        b=ldO+kBAnLYJSj81DchJcTCILRdSpTTwbpvy2z+1WHWwlQXNWBjMNHe06NYo8y2k8Y6
         H4kVYQAK4cUZvBmf5ADNOQD+KrzjzuMq8rOT8zX7YjvrxIRa5W3RzAomUSdhvlqOOEN7
         AHrSEAE3RYdsnyoyYjH2K874LuqqFq2Z3dnplMj2hpwzRPm+CVzkegoI791KMhFFnLEi
         5VIuz5M0MKBF5eChi1Fy0D9C0cLEz/QwuGzHnioZdJfz5V9MHjmfEDd4MNHb9v77PiwA
         ryFZ9boLbR8VV9NvSCt/Hwb6NfrYK7Ym8P5WvcrOhxm7sNdfVw0wviYNA/dDFxFpgF37
         dQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724180019; x=1724784819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlTLMLs7In8/gOHrNjsLpOQwDWaLLP6ewH5dG/aMvH0=;
        b=g2n/ygX5NVGcxi82fv98XzrIq3VvsUH748soDocUJr/ETe8EO/ghV/SSEGMJHMmSdS
         RLiyuyOk68qA4gftbWrjU84P04Ye8xRSbxw5BtuAvMYkoCxkpbQsNEq+yfbmAg7EBty6
         DJkXrSgxOX6YmbROgR2/BTeuRANMH9ZT+w3+MK19+3a58+89SUfSrDFluQzaNgjf0HtX
         HtnWwQjnJl7/IE6s2hXjw2nVnqkE1wjblZe/6EYbKp3QRdHvhc+MmtWsYrh6v/l9X6vo
         TE6wb40HG6nDynk2hJuAlcbcnX5JKGjv3oTDj14ehAK4oUT97nDKR6AwoUafbaX0Axak
         s+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsaNA0Wfc4aQ2PjvpfSJp7wUICQEswjrBGGC9Rxg/ROclnvx7dTktUNJKPgYgP67ORPYbsWWsehg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mZhbFDJ9dhWrSVa003uvazo3AFb3e4m7KCTiDwz9DcwiR4eU
	/9QC1iY1Xvtb4T/tzIJ+EiLoLVZbOts5FLiOZowhxwCmZa048ygQqNaUbSt2bc9z8vUzDTmv2x3
	NIHJGqvO902W4GGirorS8dErwOOAW66e4aogS3A==
X-Google-Smtp-Source: AGHT+IEDXYmnOcAXEgHI+T1DxDx1Io5reHaoh1XIPDPaSvNR3Qz2IYQiyr3/KRaoVuRTo4UR8HZi7b1wzjYn3J3QPqU=
X-Received: by 2002:a05:6512:2511:b0:533:4689:973c with SMTP id
 2adb3069b0e04-533468998b6mr434610e87.23.1724180018746; Tue, 20 Aug 2024
 11:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820153855.75412-1-brgl@bgdev.pl> <87cym3f447.fsf@trenco.lwn.net>
In-Reply-To: <87cym3f447.fsf@trenco.lwn.net>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Aug 2024 20:53:27 +0200
Message-ID: <CAMRc=MeGew-iHFmeKuKqDfDPZtjCfdNXzOzj56=qxssGP90SzQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add a driver API doc for the power
 sequencing subsystem
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:20=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe what the subsystem does, how the consumers and providers work
> > and add API reference generated from kerneldocs.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  Documentation/driver-api/index.rst  |  1 +
> >  Documentation/driver-api/pwrseq.rst | 98 +++++++++++++++++++++++++++++
> >  MAINTAINERS                         |  1 +
> >  3 files changed, 100 insertions(+)
> >  create mode 100644 Documentation/driver-api/pwrseq.rst
>
> Thanks for this ... just one quick nit...
>
> > +The consumer API is aimed to be as simple as possible. The driver inte=
rested in
> > +getting a descriptor from the power sequencer should call :c:func:`pwr=
seq_get()`
> > +and specify the name of the target it wants to reach in the sequence a=
fter
> > +calling :c:func:`pwrseq_power_up()`. The descriptor can be released by=
 calling
> > +:c:func:`pwrseq_put()` and the consumer can request the powering down =
of its
> > +target with :c:func:`pwrseq_power_off()`. Note that there is no guaran=
tee that
> > +:c:func:`pwrseq_power_off()` will have any effect as there may be mult=
iple users
> > +of the underlying resources who may keep them active.
>
> There is no need to use :c:func: here; just say function() and the Right
> Things will just magically happen.

Am I getting that right, are all these :c:func: directives useless in
this file or only in this paragraph?

Bart

