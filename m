Return-Path: <linux-pm+bounces-28028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6D4ACC98B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AEA3A22AC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85A5238D49;
	Tue,  3 Jun 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YjkSn1dZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1A1EEF9
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962173; cv=none; b=lZfcVnOrzQTel/H9pTfvYvut26YgW9MEwQmv3Ue9IJvu9LxOAgCdGwf+BCsTlE0pOQkp1WRcZ6HS7+og22RT1yNxLFkpeHAfs4opl2l/BI31W8ePxIQhLcd0t2enqmWYQw2bSAe0a34DiiDiyhgKwwN8YWzAhTh2hqlImBGEc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962173; c=relaxed/simple;
	bh=Ex3LHxHEHJ4BZQ38M7qwegLl2zSlvRBxwaOVQhyHde4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVWxE7NVdVOaCH5iAoT40RVOM0xOXgPQ7oAyjnpNkcZ5QsZ+KQIfhQuLieFifUF7scEZxu4jo9h58S10kDQFN+nFyIJjIin9G+kw6lZ/ejLHIUulAw7IMRhypYg7WHEBVyZTeNrD1PxOlWxlfBQ3vU5jCTz0j08MARy2CXtLkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YjkSn1dZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-551ed563740so7130731e87.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1748962170; x=1749566970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex3LHxHEHJ4BZQ38M7qwegLl2zSlvRBxwaOVQhyHde4=;
        b=YjkSn1dZmHZhA/6TYufayxKqC70zA6znDbflQDTnjnBrsWaxljYkBbPCxK81coZf0h
         CUjA8ptdll9T29L8j2aQJd3HiSeL99XHEjTdmpU9UGxccQor9H9lmue6AQfr0htn/kB3
         wzvWy4MRrBLjVJ0kRP0Wd/HHLLPULCRE3O05gOTYmCU9y5A1sG/GZSTWAoXHx9+8SozE
         i5yGn6m8tiyenOGWzVSXuyqkkuoEKQBenmQrtjLgMyQgX0NpUuRajuV39NtmZj1UV7Gg
         O1vM+Jr5TZ769wW0eneZOzAoMxliOfVvEzkEhaLfUyc7/ZdYeoTzb/kFqlnPWqBUPpfZ
         mxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748962170; x=1749566970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex3LHxHEHJ4BZQ38M7qwegLl2zSlvRBxwaOVQhyHde4=;
        b=hqZUQcBRU+MnRi6sRWcobB83kbffn75kpehWGYfzQpzeE6vYlD9z5nKGZAZ6ythGkS
         889W49btmqYNlBmcunR8XxDpeFQeiJIUt6n93k/nWxwzVjqVXN/8BtOP0EUkohBdzmhJ
         uJaxsrU5Qbv+MdU5jm4m8eOKT4N+WlLMlfyKMao/7S72NVwO1dO4ks2PF+W9ZcpmdIoQ
         nl0vXpoMVWu/hc4yvSJI+JHwNYKDYfoY0Y0bqt59LHkNglnjcDVs4iTU8kYt5Cx/40ZG
         Haa8V9XujSPuJ8cbpqUNNtWeyLpv6BPMwAa72UQk3TG3s2+VLJt80+1HMiHhApaLFNES
         UOfA==
X-Forwarded-Encrypted: i=1; AJvYcCUs4BoM3o/pl27CghFEoLZxYkjyHD7XDKWd/7MAK/+3u9gtGQ+qApzRAda2oYKYNsVl0uK66RjrwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqX962lUCCjqw3BFdZNkMQ4gRVF51wvRrFkLbpphCR+drCCf6
	UAu4KhZ88Xa4cpQaWlSlfkFeTHD4es2BNfE7p+wbjv/I4Jk/M0eCsON0hK2oZtxphj6o6N/rePY
	HtKauQc0o8lJOdgw9BpYDyygXGwiC7zGdy7IKd/SYBw==
X-Gm-Gg: ASbGncvja/EYMbCS61b8Ji1ewHe7lA2ZbA1tynPpv98dDXofzQA+cMxlZeLr/rzVlj/
	KwUyqV8HuJtKmVwbw3nwHwwh9RuuI/DPP+HTJub/YpuRqpbHaXEAhFhjkswlROgJx154bLc+wFN
	xwVm+LzuFxzbS8beZUtIef9N4Al6nZGcIW9qs+ceV/3T12rYGC5qQ2zRwxtb1rHSa6ok5CtqUne
	g==
X-Google-Smtp-Source: AGHT+IHc0KihO6QMjKjy0pMBkN2tQA80vRJ1vg3x2S+UcGNd55YVBv2aTqZA0Vmu7gFOqc5cx2vs3hmS2lLX+V2bUMY=
X-Received: by 2002:a05:6512:318d:b0:553:23c4:6822 with SMTP id
 2adb3069b0e04-5533b8f6183mr5171073e87.13.1748962170032; Tue, 03 Jun 2025
 07:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529222403eucas1p1923fe09240be34e3bbadf16822574d75@eucas1p1.samsung.com>
 <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <20250530-apr_14_for_sending-v3-1-83d5744d997c@samsung.com>
 <CAMRc=Me9cWfe2mL=Q6JQbAFjpd55MOBZuAWC793Us0criiQr4Q@mail.gmail.com>
 <4519844e-b1c0-40a7-b856-a6e4a80c6334@samsung.com> <20250603-cuddly-certain-mussel-4fbe96@kuoka>
 <CAMRc=MfXashaEscE1vF_P6cs9iOCBerfNFiB4yC+TX76fZ87nA@mail.gmail.com>
In-Reply-To: <CAMRc=MfXashaEscE1vF_P6cs9iOCBerfNFiB4yC+TX76fZ87nA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Jun 2025 16:49:18 +0200
X-Gm-Features: AX0GCFs2qeMG4HtPzgixdlaSw6fJIrCjF4lFG8AFOQDBjIfm0hhKZz_Zk6uhWO0
Message-ID: <CAMRc=Mc-jjULmc=3fS0qZgXbq9Sgfg8JBoH7peWML1PdyyyH+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: power: Add T-HEAD TH1520 GPU power sequencer
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:35=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> > >
> > > The compatible string could be updated like so:
> > > "thead,th1520-aon-pwrseq"
> >
> > Should not be separate node, you already have one for AON.
> >
>
> Agreed. And as far as implementation goes, you can have the same
> driver be a PM domain AND pwrseq provider. It just has to bind to the
> device node that represents an actual component, not a made-up
> "convenience" node.
>

I'm seeing that there's already a main driver under
drivers/pmdomain/thead/th1520-pm-domains.c and a "logical sub-driver"
under drivers/firmware/thead,th1520-aon.c which exposes
th1520_aon_init() called by the former. Maybe just follow that
pattern, add a module under drivers/power/sequencing/ called
pwrseq-th1520-pwrseq.c and call its init function from the pm-domains
module?

Bart

