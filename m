Return-Path: <linux-pm+bounces-28088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A1BACD7F2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 08:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618F33A5266
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 06:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8991EDA14;
	Wed,  4 Jun 2025 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ftkxMIWk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D051EDA0B
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749018995; cv=none; b=sNpSLHI9x2JzMnI7V+DJsQ3N59aDRJndgUZ4H/5HFmUhMpiMoxoFDb6+hX6ImdIRDyN31oRWp/WeVfBgvkAxqBZD8pvnC4W4Qyh4fYHBdBobTfhvV5/flvDKzIXDFvNNEgtdpSMuD4TeDByffTvhes0K1Wrpnwk/qzk3/jgeESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749018995; c=relaxed/simple;
	bh=D9K32ZU1XZ7DXPyePnHI+L2d3Xh8pDC7EJ8l3Ins/TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7ig8ou+VvXRqnraC/Jo9cYR6lUHSoM778rkwA+GeBQAjPSKYowXqzIPcsJSrh/4reqf4UJYp5L363eQfWIKXRVz13Kjrn1JTKjogB1W73a1HlnhFHDAm1DIGwYrt2rMIPatR8wagOV7w0ingDdjoKOzaB6VOKWdQ4zDUvKS0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ftkxMIWk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54b10594812so7734592e87.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 23:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749018991; x=1749623791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9K32ZU1XZ7DXPyePnHI+L2d3Xh8pDC7EJ8l3Ins/TM=;
        b=ftkxMIWkR9ol6+d8ZlxXrg8ZC2y/J2lZNSGWdWkTHqBamQEUf007DZc64bD9OW1KPL
         +EncYm7YJKqr1Gi/437L5Hr1w1aupkn2bHynnPS4ysvwYJkLfYrqlK/TvCpSGvQuDBa2
         3P/LCplxl9f6pxZhXrJbUAKGENroG0JXwzBB793fPeum8gU1iLn8kUkYJoeBdVJrJXOZ
         HYbTMMmuWd+Qw4XiK9PhVp2Q243iKLNKx+dRwIJEnRbZ3l43+HUf2qiHQcEE++i3whHb
         6dB26KW2pmb4OeqUJAi8NjQKt/FatfLIOEDZMAAhnc6iIGdNtpBNEVtwXxo5dzb273PX
         0djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749018991; x=1749623791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9K32ZU1XZ7DXPyePnHI+L2d3Xh8pDC7EJ8l3Ins/TM=;
        b=FqIGgRH7LZVfs3+gNKhHWNMVu3MRYVKQTE2+yDgfcOjV8NdBXhgYccZ/QTUMbBnUKs
         Fp3u0/d2dqB2Qn+1B99pp2Oafn0Q93z1JePM1qvlhjBxeU2UAD6QmKvEMjMnXAe35izu
         lZA1OkoBMkngOtH0qZfZiQqXSE+gk114G882D+wFWbKQcgkhHrvDXKt5iSUHfGmQNmZ3
         LcDbI7iUO7+LfYl1G3EJ24+QQGXCMlHmQSVcYLPZ4J+rXqtk3+QjIrIISbBXS1xD5tDy
         ebhVQ2UztK9WV9CIJ9iz9Scc/xaqytJcsLJEYiPAfpzwODML0XWk471O1qJlxUcm/UX+
         uF9w==
X-Forwarded-Encrypted: i=1; AJvYcCV5L5WwDwYNcaBPQwvTRrMy+5PLRP7ROcpT97KCxb2U8iAnZHe/+BB/3n7jrda+IK+ljBQazjPJTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Vev5vNqwaLVesXWY2qK7zOQtiqcGilc0O7X0aSIhFF2Q1DJA
	Ele2+9Xg8RoGMsrF0GHTDhtOeeMor8A3m3h1pwP6AVTZQAr2RKQ6+3x71dwvTPhnHpcDbw1kCdy
	2PU+KgoupGgzlb+YK+Xwd7ExyyHDu1H+iTeHnXxC+/Q==
X-Gm-Gg: ASbGnct9U+S8qAYfSudi4eJxUQFcU91gQn+06c6dOVT7aTL2uNdexRScHqXtxHI272x
	+tX2IsdIBCbl7axAczCnddxRCjNEAxNDbTLKAKZeDmKXWPGk/TGkWgkr4NP6RQOov2Du5WpHDRz
	ma59tQah5UrdZO9n8WTz6Hgon8pJMpOz0KYfFBv9pL3LDIs3SyhFg2lXU0EtfLAQtXmF0UsDi+C
	aI=
X-Google-Smtp-Source: AGHT+IGNn5KBz1XRTjIkzj6b6e6ObvNtG1QhrXiTlXPwZa2NH6Gn7Xw0y4y87hgGMzhfMTB1WYM8NYUps+Cmt6+hJMs=
X-Received: by 2002:a05:6512:1192:b0:553:2ed2:15b5 with SMTP id
 2adb3069b0e04-55356df2fe7mr504394e87.57.1749018991176; Tue, 03 Jun 2025
 23:36:31 -0700 (PDT)
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
 <CAMRc=MfXashaEscE1vF_P6cs9iOCBerfNFiB4yC+TX76fZ87nA@mail.gmail.com> <05aa1fad-acf6-4cea-9a20-e54a2a4669b7@samsung.com>
In-Reply-To: <05aa1fad-acf6-4cea-9a20-e54a2a4669b7@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 4 Jun 2025 08:36:20 +0200
X-Gm-Features: AX0GCFusZW-oAOcE0lriS1jLbCdqE2F5QAmjvVg87YP8T3XsEwEGxH56sPN1Z7A
Message-ID: <CAMRc=McDb13ZOM5v5gYBAT40Z6eNd8am6gy=FysWU72cG1172w@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: power: Add T-HEAD TH1520 GPU power sequencer
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:24=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
> >
> > Agreed. And as far as implementation goes, you can have the same
> > driver be a PM domain AND pwrseq provider. It just has to bind to the
> > device node that represents an actual component, not a made-up
> > "convenience" node.
>
> Sure - this can be done using existing AON node.
>
> To keep the pwrseq code organized in drivers/power/sequencing/, a
> similar approach to our th1520-pd driver interfacing with the AON
> firmware library (drivers/firmware/thead,th1520-aon.c) could work.
>
> The idea would be to treat code like pwrseq-thead-aon.c (changed from a
> current pwrseq-thead-gpu.c) as a library. It would export its necessary
> functions (e.g., for specific sequence init/deinit steps) using
> EXPORT_SYMBOL_GPL. The main AON driver would then call these to provide
> the pwrseq functionality.
>
> This will introduce a compile-time dependency, as expected.
>
> An alternative would be to keep the driver in drivers/power/sequencing/
> as a platform driver and start it up using, for example, an auxiliary
> bus. This is similar to what the JH7110 clock driver
> (drivers/clk/starfive/clk-starfive-jh7110-sys.c) is doing with a reset
> driver. This could offer a cleaner separation of roles if that's
> preferred.
>
> Please let me know which way would be preferred.

I forgot the auxiliary bus is a thing. Yeah, definitely use that, it's
more elegant than a library function IMO.

Bart

