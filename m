Return-Path: <linux-pm+bounces-8179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246378D0525
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482EF28F7D3
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086C16D337;
	Mon, 27 May 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPuHgg+4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405516D330
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820687; cv=none; b=n6CuXDTahssr2SgT3g7lmN/Pa35DaOubQDbZBZrohXVtBXToREO1+AbHJfnpZbEVMsyuX7vXW5GzfQdPCh475S87jHRzWxIDpD24wmKJ/JPIwAHAXCmNebkS4M5+eIyU+2DXcvgmjUoZznvoNO83S7j38gcJ87tCWzJINXysfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820687; c=relaxed/simple;
	bh=TsORAf+30DK49YwxeDsXCfFaQYfYRcUm4oGKDiMwiIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOMgYYVB1BzS8n5O13rODmKI3sx9mBR1MgZ4ZA9BEs1LMtrhP1eSr0HFGoD2i1yUCqzjcHUCrlDoN4WBOkHRB3PQvjw/PKCbE/si4JpSp/3ZwRcZfTmHg9XtRFMbhecpjApvRS6ZBdGxRdKvJiqAw+adftyINIgORNslv/qAo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPuHgg+4; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df4df150f29so4747256276.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716820684; x=1717425484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TsORAf+30DK49YwxeDsXCfFaQYfYRcUm4oGKDiMwiIg=;
        b=DPuHgg+4KYNWgq7fqY/iFCm3R1+zkrtT3WVhwz5XfVtHmbGcdwr1y7ltnmbWu74aev
         f8t6wAdtq3CMWCgh/1UfGv65PaDwGHiQuuz7qO0JNXLaALFq7zVQhnB1kNnkTV9PUmmu
         M9BL9m+WL0VE9Qz8PSgmkY3WpbvKe8oj+9pnRsnwmMlmuD/h7VtZRDbgWfbC78LHY4qO
         W2j2+JPRWk1zDKAYz1QcLP0cXJ59RTEKX7kod+RtkWxL217Ut1dc3w7s94HKyhZg58uh
         wiTZTJyWvjppGdncahdFWW189eVr4qDXHVmavrzQHqqAI/4tPNeRlfFDeJow4DuOstRF
         FEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716820684; x=1717425484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsORAf+30DK49YwxeDsXCfFaQYfYRcUm4oGKDiMwiIg=;
        b=JxawUhzAliDZZyuRjW6gSrwZKC6bgpRv9F17+ArN1+Sy/bv0umd9grKMkw0ZDShLeM
         kMMrcM4y0Ox5aMLX0t2+DZ6vkcYPoG0WebJjFnYQbRq8AfG93Ch16qGsWcNoEHMhpVkP
         KOkqTgsaccekXNbCtSlay/O1vNpP1sDWu05eyHKd8B4YKvTBaSURJNyC/S0Glh+8rjw2
         t+eTQZCvkXDvsIfbhAKYDmKQ78nfCkipx8Gtb3mCPhIGE0G9+OfmI0OEnwcJjeUdTwfJ
         n6AXxcP972/7CRCKpNIecKK/Qzj1CZrMnrLTSrL9Vi4SJiuQQr8qjGVb9O2O5PZtRW34
         Snlw==
X-Forwarded-Encrypted: i=1; AJvYcCVZITJNQjT+kfHlxJyXfdbzAniV52AtrfXXsFMkdSzhi8kS4KG79qs/IdpLuBfIeIV133VpFpGWaViqdiFjyhtaRaWdEpnGwXo=
X-Gm-Message-State: AOJu0Yw/2w2qY5PhWa7V/LRPJT2yPTeMpuk+DaJ94ahe8q6LkphqSbQZ
	yZDXgH5DYigGBnoJwyyGTSpHpbp5W0wkWpog9NnWo0t2nBieDF5bf5PnPiNXmmSxMJeHFrAXMvY
	AGL1VhCvcSHKGvMXkvkgWUSAzoy14hgY/OP+h3Q==
X-Google-Smtp-Source: AGHT+IEwTZzUZTnOFyK1J+Cmkx0U06fySsAKy1c+9/Zyl9b38yE9jX5xO+y6/SfRx/NvtCMT1w5cN419DuraUe6mJAc=
X-Received: by 2002:a25:ab8a:0:b0:df4:df29:bcc6 with SMTP id
 3f1490d57ef6-df7721a2897mr8786729276.31.1716820684554; Mon, 27 May 2024
 07:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>
 <CAPDyKFp4V8f0iyeRASSEu4YaCSz0m56=8ssBJ9ogSvqG1dzMZA@mail.gmail.com> <a04b3939-081a-49e0-a063-5b50d3321ca7@sirena.org.uk>
In-Reply-To: <a04b3939-081a-49e0-a063-5b50d3321ca7@sirena.org.uk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 May 2024 16:37:28 +0200
Message-ID: <CAPDyKFrhvB9bXiuQS6QKd28S2tOu7WJ-48qHP7KEBTpE8SSi+Q@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Add delay after power up handshake
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, heiko@sntech.de, u.kleine-koenig@pengutronix.de, 
	geert+renesas@glider.be, rafael@kernel.org, linux-pm@vger.kernel.org, 
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	shengjiu.wang@gmail.com, frank.li@nxp.com, mkl@pengutronix.de, 
	linus.walleij@linaro.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 May 2024 at 14:49, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 21, 2024 at 12:22:41PM +0200, Ulf Hansson wrote:
> > On Sat, 11 May 2024 at 05:15, Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> > > The BLK-CTL module needs to add delay to wait for a handshake request finished.
> > > For some BLK-CTL module (eg. AudioMix on i.MX8MP) doesn't have BUS clk-en
> > > bit, it is better to add delay in this driver, as the BLK-CTL module doesn't
> > > need to care about how it is powered up.
>
> > Sorry for the delay!
>
> > Applied for fixes, thanks!
>
> I see this is in -next but mainline is currently broken for i.MX8
> platforms - could we get it in for -rc2?

Yes, I am preparing a pull-request as of right now!

Kind regards
Uffe

