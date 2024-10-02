Return-Path: <linux-pm+bounces-15046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280B98D1D8
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A925F1F21CBB
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 11:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A01EBFE5;
	Wed,  2 Oct 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TV228plC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423B1E764D
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866778; cv=none; b=VfIRXZQgWxKFLYU4RKc7tRa7eG7KEGwVS6nbV8YRaPPxP5ENoytQt/tIOk6ytMKtQPw3i0W0aZq0GtVlL5/qRuT53dHfl1GoZyCj4UxI4FVwPeF8ZaIsx3kJFOMy0VS0oG5BaEKVdEitL6YnpX6TL9Mu9LmwRtpOfnVH8/SMPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866778; c=relaxed/simple;
	bh=NzcFoHTNLNVqGkCHzroWzfsMtjKYi6rRMMba+/kNkXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMbLpLnYQPxmr0rsx+Us87xnkI3P2aejt0vT+HF8z7abSqD5o9cnF/Px0GbaQzyrguEtq85cG3Bgp8PaAvMRTXCLg+FbgooFQE8luuXdlYhAk8zeViAWA9RsRiXzCJmaraW4jetqTmPVtsPqcLkln9KhxKZmcIwj9KMpwULHwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TV228plC; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e04196b7603so5847064276.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727866775; x=1728471575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JCxUhP5PTGRYIcR3m3Jk5Aux/17r3kHlckBWx5mLpvs=;
        b=TV228plCfuV5964mUpzVfMMrtv/WA1PCXRzm5+zQb3gGFKKqCivSlSG5BraFVdHXpO
         xCpfeh2UfAcKgwXRvTVzsDEhQ5+EZM5wp5ziV/GqYjMUEYttDBkD6dEmcslr+y6C88Gb
         vc3ZmNjEQYSkbhahl1V7VuHtJ/NNJexwSqMM2LXqCFFSeCbXnakPWny+T2IEBAAlyoNj
         JK8tZnOpr3ps4vQm3izPPuG3AHlrec7fXkrMo/lLTPT/hBAI07Wm/gaT78yNq+6nYV+C
         ryorBFxLU4cqaBOlBX96/u4Eb+ZeieSn/akLr7IQ4A0p657sAYMfXQXWnHt/KZ5kt1Ln
         iwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866775; x=1728471575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCxUhP5PTGRYIcR3m3Jk5Aux/17r3kHlckBWx5mLpvs=;
        b=GE8AYbZFNqG1D9dJdIxsUBneg8RUlNVKv/yax/j/LkgJPRWhihD9sxFh26J/VfTqNV
         DbzEG+HUtwVG7NZAExoPEV9mB3lASRBb0kbLRPvQAvQFySNVzoSY7gHTr4YZGOXGVPWA
         J6iIHFturLTR9BjCvkrGDrPMJOoDoQQtDBgTUUCp6fBuvzrsgQYQiPT7nwVJJh4WO5Aa
         cMQJYD7c+3g7l3WD98XuIiTay7tYScU0gGpVq3fYf1wUZamjX4CpRJ56AyQbou/XoisM
         h1Y9IkRZsEMf6JwBi1U5ElFGGXzu3pmAIPbyDUtyJYDNbxfwKo6OVvkEd3fOfmV/9ZFh
         rUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVJV0pCx/MzfdY4aAK/eAkineeX+qaye1Zl0HfBEcAAerSSHh/nTxtZRTCI/vA0p24b0PZYBsSbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHxB4XBlmEYoXhV5HfMhR80coGavbg2SLI4xWKJykdVQgdX6k
	KfkeIvVvDRPS7j/LRl0TP5x3CWRaQa6xtWjx+7BtatgWnNC9Qwy2UQwARHbBaAS8rN5BObHc3zs
	PxO7oT3qh0v04cRIyAwmzQEwwq0AV/c+c/6kBgg==
X-Google-Smtp-Source: AGHT+IFq0pk8pMecMnHenj+WF1HIEXl1ETFIdkc88bklqtHOqecgN4eekOLxn+WfMWdGyjsskNLSuEFzJ2UWoa/M8hk=
X-Received: by 2002:a05:6902:2e11:b0:e20:2a9d:f909 with SMTP id
 3f1490d57ef6-e26383998fcmr2106920276.12.1727866775632; Wed, 02 Oct 2024
 03:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930044525.2043884-1-wenst@chromium.org> <ZvsVfQ1fuSVZpF6A@finisterre.sirena.org.uk>
In-Reply-To: <ZvsVfQ1fuSVZpF6A@finisterre.sirena.org.uk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Oct 2024 12:58:58 +0200
Message-ID: <CAPDyKFrNXtFY0Juwa7Hm6Z5yBeXztg2BMRDcMmM4z4NRXdHm-Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] Add of_regulator_get_optional() and Fix MTK Power
 Domain Driver
To: Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Johan Hovold <johan@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 23:17, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Sep 30, 2024 at 12:45:20PM +0800, Chen-Yu Tsai wrote:
>
> > Patch 1 adds a new of_regulator_get_optional() function to look up
> > regulator supplies using device tree nodes.
>
> > Patch 2 adds a devres version of the aforementioned function at
> > Sebastian's request for the two power domain drivers.
>
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
>
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-of-get-optional
>
> for you to fetch changes up to 36ec3f437227470568e5f460997f367f5446a34d:
>
>   regulator: Add devres version of of_regulator_get_optional() (2024-09-30 01:11:41 +0200)
>
> ----------------------------------------------------------------
> regulator: Add of_regulator_get_optional() APIs
>
> Add of_regulator_get_optional() APIs, which can be used by generic code
> to improve integration of regulator management helpers for their users.
>
> ----------------------------------------------------------------
> Chen-Yu Tsai (2):
>       regulator: Add of_regulator_get_optional() for pure DT regulator lookup
>       regulator: Add devres version of of_regulator_get_optional()
>
>  drivers/regulator/core.c           |  4 +--
>  drivers/regulator/devres.c         | 39 +++++++++++++++++++++++++++++
>  drivers/regulator/internal.h       | 18 +++++++++-----
>  drivers/regulator/of_regulator.c   | 51 +++++++++++++++++++++++++++++++++-----
>  include/linux/regulator/consumer.h | 37 +++++++++++++++++++++++++++
>  5 files changed, 135 insertions(+), 14 deletions(-)

I have pulled in the regulator tag from Mark's git tree and applied
patch3 for next, thanks!

Kind regards
Uffe

