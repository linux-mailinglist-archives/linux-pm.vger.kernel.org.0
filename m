Return-Path: <linux-pm+bounces-9895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596C914F6F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0132F2834D9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAAA142900;
	Mon, 24 Jun 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAV0wsM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106EF1428F3;
	Mon, 24 Jun 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237598; cv=none; b=I/5zxFBbxPYwctz0aqCNxxqlo1x6+1pvHzUua7S3fpJ5lDZo1FyhmSTEAhuG5CgsmeQLayaf3sJA6ZGCb/ZrAXyxow5uYntrurw/Q0hkdfvizuXVzPVGvcYf+GixHTHLW4jxzrbU0ufDP+yjSUmQ7ZPyTAkgP8PROCFrmGieDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237598; c=relaxed/simple;
	bh=coXtbqCf1aNj3qVdYnPXmxKBPVijC1WLWyWksnTo/1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGINUfE0ngbNSInK8LTGCWjY2CotZBGIJZ13UgI8obnE+Q/5wCszm5xuiruIbiUtl1ahn00WyyuT+dsLSvLv5SJkOJM3EnJRH45JocuorOXVnYbG8vRgopDCj0VXDM7zaFVPiP1ilZOvlRuSHA2WNfXiJ6JQ2FBHbNc6Jhaj/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAV0wsM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9444C4AF0E;
	Mon, 24 Jun 2024 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719237597;
	bh=coXtbqCf1aNj3qVdYnPXmxKBPVijC1WLWyWksnTo/1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mAV0wsM0cADYwyD6NVIBgIhgkMkPdGau5CfJRet8njK2i/sJ/NN7nwEsTsTldrN/x
	 bV3AbDKdd29z+wyllcnM1nwTXdmw54IEqK42TNxjeicRkw8lE1xtPJWOA0LvaxzBmf
	 QXulf91UI8eijTGTGf59+GS9llFIixPc1egosBWxyqRShStAmnnRfS8AdGHFQkxYO4
	 1esIcgf0eBJZuN3V+JNnE2LVih4vyHQP3TrcB75OD7G/mOyYwJwNUNs4ESOGvmDwkR
	 Qj0Vl0+Jesmwxf63rDFirhYyeS+aj+7DSR9libUZ7qkAesJUgPtP99sLgxq73TYs6m
	 QcOOA7f12gQRg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a724598cfe3so196887966b.1;
        Mon, 24 Jun 2024 06:59:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4N48r3tudnnOGcz2BXZGRY817yJhNR+1YiQyJe3ozRzSyNAKqP0HtFL8owM8DBmJAZJFRPqPkMyuZPlGFMf9PHQzLZeGVlShPm2VNU7gwJM+DWrHb2+0eGPIbjH6ojkjo7E37/v0=
X-Gm-Message-State: AOJu0YwEd33QqdiMKxsqsRXk1Ibp9LyWTG59028dlOpPp/qbsn+BJGtt
	/tQ8sAvISinCQR2zQkzhKgZahss77Sa/gyFwR0U+yLV/qcQBCdq0ZLZzV/MLl9y7riqoLO4hDZo
	OOZu4vw5s9EsS9XLcaVWhzvxgK2E=
X-Google-Smtp-Source: AGHT+IHjpo7qhwSxrshQ6fSOoAxjRT5arwHFlaPZSLMAAGZvXgBkmcbz9a/bQeGuRV4RqFXywLYOktdS93LPF8cHCiI=
X-Received: by 2002:a17:906:f21a:b0:a6f:c9c6:7219 with SMTP id
 a640c23a62f3a-a7245c8096bmr367938866b.47.1719237596245; Mon, 24 Jun 2024
 06:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612064205.2041548-1-chenhuacai@loongson.cn> <1dc3823c0f0a459ae033a69b2eeb3d2929254fc2.camel@xry111.site>
In-Reply-To: <1dc3823c0f0a459ae033a69b2eeb3d2929254fc2.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 24 Jun 2024 21:59:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6jLt_hZV3PmOXPPvPOy59G9_5XQK8Z3F97jG4Y7=ugNg@mail.gmail.com>
Message-ID: <CAAhV-H6jLt_hZV3PmOXPPvPOy59G9_5XQK8Z3F97jG4Y7=ugNg@mail.gmail.com>
Subject: Re: [PATCH 0/2] LoongArch: Add Loongson-3 CPUFreq driver support
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 9:30=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Wed, 2024-06-12 at 14:42 +0800, Huacai Chen wrote:
> > This series add architectural preparation and CPUFreq driver for
> > Loongson-3 (based on LoongArch).
> >
> > Some of LoongArch processors support DVFS, their IOCSR.FEATURES has
> > IOCSRF_FREQSCALE set. And they has a micro-core in the package called
> > SMC (System Management Controller) to scale frequency, voltage, etc.
> >
> > Huacai Chen(2):
> >  LoongArch: Add architectural preparation for CPUFreq.
> >  cpufreq: Add Loongson-3 CPUFreq driver support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> A question: is it OK to enable cpufreq when overclocking is set via the
> firmware?
Yes, it's OK.

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

