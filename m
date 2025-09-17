Return-Path: <linux-pm+bounces-34873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9181B8009E
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19124A191A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9885215F4A;
	Wed, 17 Sep 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUYV48in"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23210225A23
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119569; cv=none; b=b6pVeHcPN+DZ5VxaNA58g0tfPRhde49Sd4Osc7wS3F/jTt/c+P6fjC38TOAKTpPJafW3qtHx3jjV2iTffOQDfqdB4XphpAqNyjc2fvhAT+jTktWJlgPqMI2bqQ5dPZzIpYsp64vEBtfhP/2tnuarM2xq3ZgGjvJLEY1X0K5NUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119569; c=relaxed/simple;
	bh=EPP9Vl6NqhaMU3EPY2zVx+QbBHXXovM2n/lYKSxXZDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMa5YRw9QuLKjYrTgt0+Rh41r8fHPfI7uXLklIMBgnhA/ezJrf4A9e1rQZOrLPCEr2bjbBqajFqz9jAd3Vo4xvXVp/pZl+npcXMbYUEtXYnFSPYnFy7fY7X+PT55SvWQaOwjERYLwLt8MDMuLOMHMuUOxHyj6VlHb3+rCwhUyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OUYV48in; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ea5bdbe191bso772770276.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758119567; x=1758724367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPP9Vl6NqhaMU3EPY2zVx+QbBHXXovM2n/lYKSxXZDQ=;
        b=OUYV48inhaKrKUvjYB7tdrAfAuewYRj+RLVJWMrAY7IAFAzABVufqZV5YelVdS4xr0
         9Yhewg5BsXreT2vaPw31Pq5/GGt54tgd/QBGH+3es0fxAjhfutft7w4IIYAb74YR8Bkh
         5NWViOjWBYqSXx5mn50IfB2dQSFXU+/pfVNKQSDDBNcuv7gzCRXBVE4yd5c9HbC7P5as
         f1q5JC7+3/w9VGQo4FhAAICJrjVc02MmdBgY3GPXYN96Z+EP6I5bfpC+KXnNRLnMlTj0
         2GdAyayUYLqVV48RKZ2YtaKu5uM2+w6ap2WxzEpFdKlsAeb8fXmd4yjkaRoYMrFFWPym
         eAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119567; x=1758724367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPP9Vl6NqhaMU3EPY2zVx+QbBHXXovM2n/lYKSxXZDQ=;
        b=cRwq4pexXPqNVGB48PrxkIO9EgbPvombhu6k8czrZE9djC1Dg3oaIH9uKLux5YD+bE
         QIGKaqwD/KOfZ0UyFBNf89vZVNMF9wnGvmr15cw1qDy9XEwXWI+Jnev3izu+zSZquiGP
         YLz5Q4jzJX+pLq+IhJbs9PHC0XLh7uch2JroXpClGT1MSKp4enRASzu3QvMiu9ByIJ37
         d7+GB0JyWIHRbri1+8uh1Ggh8rKUP3x8Gxp9xb8AbkWiWdzETFg/+lSHpSGvRsCMYnXi
         V6oImQue6YnaLsxyAbN6iUk1jzfLp4xu4BB2gQ7Re1CMjTMcwdXk220tY9y6TRB6rxmF
         RhGA==
X-Forwarded-Encrypted: i=1; AJvYcCVhZRGHuca37D/DhYBoRvqsJMGfRufjwDtSzsvubnzcdRKIVLTH8IHwJCR83yLy4hMAqdnbs3zVgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4prkv3n/+ttKTAwB9yrUd5ILt7/vV7j8QDdxu7bAHa0y43Hpq
	A1CJUgq6xnlCuIGlGDUa5uWEm/W4kHYPpCg2VN0R6o7ZeQ1ONq+qp9aaGJEP88ifQqqX2WOBi3H
	iIIFyTe1tEIMWntqpKJiE0ayg99z9YFr2ojhf5TibRg==
X-Gm-Gg: ASbGncv6BbPerlhwA/ssrd/bbWt0Yi0oiIElJ/pDr3ovV+uwW0HRMn2zjNZlIj7KUNF
	4a0D3dRmAnH7o+cAas7UYy9NpmaFfHs8T2wTQEb/NYdokpBtM8qiZjZGuKBlYT2asQiSfvxIcvn
	okEtl4przQSaOEaESGwL70NvZ+/wA1sMaS/RVJ5hQ1OMQSN9cLB30TDlVsYmLzs1BygZyglqS3X
	juefD6/
X-Google-Smtp-Source: AGHT+IF8958qtxMgepRmmh01erhzEe2CCKMaB8p0aTdmbEk0KITYYPXFKjQVfYFyDlneSgtW8sFxeX7TRTnXN5JBV/c=
X-Received: by 2002:a05:6902:6c1b:b0:ea3:d667:affd with SMTP id
 3f1490d57ef6-ea5c06c1586mr1899822276.53.1758119566841; Wed, 17 Sep 2025
 07:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810-pmdomain-round-rate-v1-1-1a90dbacdeb6@redhat.com> <aMasUV14w0Dc1ki0@redhat.com>
In-Reply-To: <aMasUV14w0Dc1ki0@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Sep 2025 16:32:11 +0200
X-Gm-Features: AS18NWC-l2ZajfsWo9MjcYD2GJjmouYf3pDYfF1nnijLrVzTzi40JFoPMgBPLz8
Message-ID: <CAPDyKFosHY_aVP3EdzXJj4=DvZCPfC5c80oSwTEeyyV-7MRQJA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: airoha: convert from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Sept 2025 at 13:51, Brian Masney <bmasney@redhat.com> wrote:
>
> Hi Ulf,
>
> On Sun, Aug 10, 2025 at 06:16:19PM -0400, Brian Masney wrote:
> > The round_rate() clk ops is deprecated, so migrate this driver from
> > round_rate() to determine_rate() using the Coccinelle semantic patch
> > appended to the "under-the-cut" portion of the patch.
> >
> > Note that prior to running the Coccinelle,
> > airoha_cpu_pmdomain_clk_round() was renamed to
> > airoha_cpu_pmdomain_clk_round_rate().
> >
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
>
> Would it be possible to get this picked up for v6.18? I'd like to remove
> this API from drivers/clk in v6.19.

Sorry for the delay, applied for next, thanks!

Kind regards
Uffe

