Return-Path: <linux-pm+bounces-4524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8B86B65E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C92B2270F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8979E15DBC3;
	Wed, 28 Feb 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="et/TxfRK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4615DBB5
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142509; cv=none; b=PfzNr8x9Ldrx5oUzp7rgC2bKNrZDNQt1CwlYcrp4iEos4fkDt9Q72/0uFVxKFoTJRgwx9GMZYKzJ2+fq6F8Ycu8e5CH9tKONGVm1GBFoOvuKQ6VbdpIatxRwC/Adzsr4Ih/mmMtx9fKdyb3+oeJK1KBcNlN2KbuJ2uOm6C2AbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142509; c=relaxed/simple;
	bh=dXvYAhmkYcjGWARl7hgbthDBAfsGWyz70D4tvgd/LGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3xZLB06+zZU9jv3pB+C22X93Ep+n5cQwKgwIraUA2ZOdJG/k4cAStp2nYux+lJVPyXfwD5hCFUabKHuzjYuxFKylTdvFn1YljOTsp/zugU9ymadfqh4zW4F7SXQN2d2V/s2l0PRPbUoprZM+Dpg+UGD1JrTdeR9GmYrniOODWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=et/TxfRK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc0e5b223eso505135ad.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709142507; x=1709747307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WM/LnzzYMg9VooSl3tyFbgZCCVmVnx60g53OBbQ0+k=;
        b=et/TxfRKOiKI5c7Gv4OnewW9GEBpxpJ6vAGkOSlGN9KMGqVEcfkYLE3mOkecvLfL+X
         Px7pDNEG3Hvk033GgHGhjF1IVqFhCZAZbQXYGOelgmIIkRXihfSM3hnZk0XFngAhf9Mi
         uQzFbalPOoQsIwBnZDZPmDP7moFIhcc7VSvTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142507; x=1709747307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WM/LnzzYMg9VooSl3tyFbgZCCVmVnx60g53OBbQ0+k=;
        b=Pv0HLrKC95CORM0Og+ESqiZlSEceAkTXSA7KuxDSOyCa5/fk6A6aP3r1SW/LNlBHwb
         M3q+ye9Ia9t7+1oinRJvVJsIn3/7YYfh3dxMdiu7Qrq4eAs0EzqIvD3wAMpOMMuR65qo
         Zqk0XKD/+fX7cNM1ALUtcOgf21vLHWskLopwflQLvFcraiEtuIlCYE/3ZJEJ3STKtw7j
         ZIK046EvCDOPvh7fBUhSmBiaqVLzIHs03SWfEKckwPvW5/cMGDH5BJW2rMUAAPkIFqaC
         dXsPID6gzUIbTOYdqAZ5gJa6Cx44MSJ0gCr6rRCpd1LPq5SGCnKNM8fWx5EbWOJnBVm2
         6CYg==
X-Forwarded-Encrypted: i=1; AJvYcCUnCadHl9EBx5qIpRQXSsHDBdh+o4VbBZuV+eeil17HXXfTNrOa5arwfQpaG/AEk6vDwDiXCK+Z8b/Tp8ovoft0vIwb3c1izqg=
X-Gm-Message-State: AOJu0YwGVyZ27M2vrYs9HGHumg9Q/SYxOUkEbcvtBl8SuOpToPB7EwYO
	xfCBKF82S7mBboazm3AOreEsfJR4m4QyQAzSsDE++XgTwlrPoWPizACxazLgig==
X-Google-Smtp-Source: AGHT+IESP0EHYAJw+XKsHw0+0gEOxsKXhQ4JPqQc7jTcHPqGl3oRdKut0HWB7EJyZ5KfIQrOtGCd4w==
X-Received: by 2002:a17:903:110d:b0:1dc:1ff2:c6d6 with SMTP id n13-20020a170903110d00b001dc1ff2c6d6mr248654plh.22.1709142507278;
        Wed, 28 Feb 2024 09:48:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ba6-20020a170902720600b001db604f41dcsm3564350plb.103.2024.02.28.09.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:48:26 -0800 (PST)
Date: Wed, 28 Feb 2024 09:48:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
	gustavoars@kernel.org, morbo@google.com, justinstitt@google.com,
	stanislaw.gruszka@linux.intel.com, linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Message-ID: <202402280944.CE26D81@keescook>
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
 <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
 <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>
 <202402270816.0EA3349A76@keescook>
 <bbc65508-eb0e-4d63-921b-85d242cc556f@linaro.org>
 <202402270852.E46A5268@keescook>
 <3ed4ad69-1229-4834-95b7-9397364ea401@arm.com>
 <20240228165651.GA2158263@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228165651.GA2158263@dev-arch.thelio-3990X>

On Wed, Feb 28, 2024 at 09:56:51AM -0700, Nathan Chancellor wrote:
> On Wed, Feb 28, 2024 at 08:41:07AM +0000, Lukasz Luba wrote:
> > Hi Nathan and Kees,
> > 
> > On 2/27/24 17:00, Kees Cook wrote:
> > > On Tue, Feb 27, 2024 at 05:47:44PM +0100, Daniel Lezcano wrote:
> > > > Ok my misunderstanding was I thought sizeof() was calling _bdos under the
> > > > hood, so when calling sizeof(flex_array), it was returning the computed size
> > > > inferring from the __counted_by field.
> > > 
> > > Yeah, sizeof() has a very limited scope. __builtin_object_size() has
> > > more flexibility (via the 2nd argument, "type"), but it was still
> > > compile-time only. __builtin_dynamic_object_size() was added to bring
> > > runtime evaluations into the mix (initially to support the alloc_size
> > > attribute, and now includes the counted_by attribute too).
> > > 
> > 
> > Thanks for your earlier emails explaining these stuff.
> > Do you have maybe some presentation about those features
> > for the kernel (ideally w/ a video from some conference)?
> 
> I think Kees's 2022 and 2023 talks at LPC are a good place to start:
> 
> https://youtu.be/tQwv79i02ks?si=Nj9hpvmQwPB4K3Y4&t=452
> https://youtu.be/OEFFqhP5sts?si=u6RnOP641S8FkouD&t=614
> 
> https://outflux.net/slides/2022/lpc/features.pdf
> https://outflux.net/slides/2023/lpc/features.pdf

I've also got a write-up on the entire topic of array bounds, which ends
with some discussion of "the future" (which is now) involving the use of
the "counted_by" attribute:
https://people.kernel.org/kees/bounded-flexible-arrays-in-c#coming-soon-annotate-bounds-of-flexible-arrays

-- 
Kees Cook

