Return-Path: <linux-pm+bounces-12623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969C3959998
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6BEB2742E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B120DB94;
	Wed, 21 Aug 2024 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OGAZx4aB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B9F20DB8D
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234961; cv=none; b=hqqDfBUxDMdx4S5zQqyRMjnmhpwaRWkb8Us2r4YRlXntuk9PG6M/zw+m15ge6/nXIxU2akB2/WpPIDCSnFebrhJj8qkdnivglfZeZbtkpWrjpR5a0gjhfrg88okF7abJmxSJsNnNwQ5jibMImiIlUT1aoQrgTczAiAjVHHI70+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234961; c=relaxed/simple;
	bh=2CnvFDBpoOmIJPEwWYRm+tbMpmDawJVyobMgSJbQRAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ7wD7Qi/XTUCXQhXEkUXxbyEwtzrDB8omw0vh++1y/kLBCeo2gHOYfmgFWdUi53Ko7GhVybw6UnyHK+JMM/VW0zL5hemFwsUHWiRIWJTjWkfBjwRatjM5DkP86FCw7NX1vyIPZU80tnv3jTODnmWcV8Vh2yIsKTTBPtOL9lPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OGAZx4aB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3e2f5163dso30170331fa.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724234958; x=1724839758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CnvFDBpoOmIJPEwWYRm+tbMpmDawJVyobMgSJbQRAQ=;
        b=OGAZx4aBg8aiY3oJo4fLG4No03Q1zZ6ZIs0HhqnO2cNXYzDLLGtnR3hknab86rferM
         zcBK2pcz7WuenhIasaQv9ZAZVPIlkIh5RQQIao/fUqmbDA2s1w3L5rYkX6Zfg2++l062
         z38GgdZsMPXyPswhiZkXE8p4UMvzeL9s98rznE7G1S4/SN8uvt2VbePFUgo9m5ZNiOEB
         c80WJOhhC4OmNlXz5Z6ZwCLz0ftZtKMa+a+cM2X6urB0gjSzpsm4MNeRfDgughMcKZAM
         AZzLAE3Z6dhymG5iY0h8LEpreHxs6msqdaKcGnEvYbWUg5EXUvZuA22Dr20UFuNMDbbV
         +Pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234958; x=1724839758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CnvFDBpoOmIJPEwWYRm+tbMpmDawJVyobMgSJbQRAQ=;
        b=UmMpdtdMuFd/73PtCK3bDjv+0m3cZYmiVqg8BWvaGaZUOHjp7CcMOVIpVd+WvPx9i6
         JFqkcat6BhChgfq3eKpH0VhK8kFYuz+2M/+pZWOAQcNn1Sr0W674ecbGMU9paQHO4al5
         C4C0DNhn2uUGNH29riEf+TQYoCiJmYShRkX5o2s73qUddNktg53j/EBAq7GUH0QhXavG
         Y/KLJ3xXwx4dWvSnfaSmNZW1FqhioAeDpyAburaF8clRn/qJy3Nzkw+qtdLDzN/7ru3h
         xLAWbVNCB6x7/L4B61HC/0pDmPSVs5nT54FvM2XR1dcvlBvXvc4KHwHGGFqt9vT8Nie8
         An8A==
X-Forwarded-Encrypted: i=1; AJvYcCXze9oRznB3MWFJ/b0OtcCp4hy6WkolbfhCQqPdYNPy2BYqQ7wabX5sP39vPNPxQPGoH8nDK9qbOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5drNxL8i84gT9ZzBO6sGODBfnHDdlamjyUQwwOxabVumjulJ
	js4vx/CD6WSci9QIolM3zkASc/9IRm6jOvpqO/3Xy32/zsEv0JFfxon6zEuvn5dcAyxpNQWbdcW
	yhQyX3qHET9h8Jl0gN1jcPPRQ+Jci0t5bzEOShQ==
X-Google-Smtp-Source: AGHT+IH/KROqd4SBZBae9gjn5KPL2Xtm+TzJJpxpcFP2raa1nwIor65T1emivTiTtt+tA6WUId6hptYcdpMUP4C3LDc=
X-Received: by 2002:a2e:7219:0:b0:2f3:d82b:1955 with SMTP id
 38308e7fff4ca-2f3f88922a1mr10409461fa.25.1724234957071; Wed, 21 Aug 2024
 03:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820153855.75412-1-brgl@bgdev.pl> <87cym3f447.fsf@trenco.lwn.net>
 <CAMRc=MeGew-iHFmeKuKqDfDPZtjCfdNXzOzj56=qxssGP90SzQ@mail.gmail.com> <874j7ff0kt.fsf@trenco.lwn.net>
In-Reply-To: <874j7ff0kt.fsf@trenco.lwn.net>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Aug 2024 12:09:06 +0200
Message-ID: <CAMRc=MffQCapPQ-O=GQUVEcEGx8ey6Mcum9-new-BEis+Yk-eQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add a driver API doc for the power
 sequencing subsystem
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:36=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > Am I getting that right, are all these :c:func: directives useless in
> > this file or only in this paragraph?
>
> Throughout - it is really just not needed for kernel docs.
>
> Thanks,
>
> jon

Just sent a v2. I can pick it up into my pwrseq tree with your Ack.

Bart

