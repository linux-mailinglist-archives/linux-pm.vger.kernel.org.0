Return-Path: <linux-pm+bounces-20531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B573AA13634
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 10:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC80616782E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDED1D90B9;
	Thu, 16 Jan 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ4xu/k2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436C1D86C7
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018548; cv=none; b=IDEjLBT2eblaF09L4rU9RGSN+BngE2EVQtLZaVa0tg77YM1EWe+8022WRjEs/GsVIbn0Kyrkh2zJk2BSAuA5Itw9jMwmOMRK99dpe3qT8WoeODjQRYvluXrPolICjMbIcCDIA0f2MIbSsZ3MNF/RA6Nv8belzfJV8A63aluyLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018548; c=relaxed/simple;
	bh=6oElNuHGnh2SndiJKSmzP3b2+Y0n7fF/o6Bw/SCWA8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwDvD77ZoJSR5/fTwTC6ZebiwXZarUSMuTm2k8bLwzNRm/cUV7jGxn1szLWsyes23Q1yB6vU6rNyAk8voKX4X5BOqyz+blMPW3CWOfGhyQ19K+0OsHuDzZKi0SiZt2haF7rZiebqT0M96OL+OkLsgl2U+YVZQF2Z+M+5T1a7GVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQ4xu/k2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3061513d353so7278521fa.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 01:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737018543; x=1737623343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oElNuHGnh2SndiJKSmzP3b2+Y0n7fF/o6Bw/SCWA8s=;
        b=IQ4xu/k27KRRWT8+BR952Rp6sKVE/VBK5DV2ZXczu1NXcUukvmSRhxYLL+0UXBIJ4c
         3XLFDkgeNmHYnmaZ1Y+a9giINHrU31aBwZYdr2dnFxiFW1/qGxFPCUuOm9gPYsHh4oHG
         0vzH+G0XYL84pZEwCnLOqSj66IjfcnuQlbsgN/qIvOrhWppNR7wGIUs1hexzLPxTpmyt
         3hbCRYP/n4ekMfXpEKGouRTTopOyA6dAL2JuiYN7x087ZTdBG7STUK9luWQEInOjkGUe
         hBgxFng++giL4qYxSLhDii9GH5/I3L8nHqsV4VGu8zTpo4mXnEuh6k3KbDxJ3Mg/WwBz
         L5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737018543; x=1737623343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oElNuHGnh2SndiJKSmzP3b2+Y0n7fF/o6Bw/SCWA8s=;
        b=mpD6X9sVgSvGk8dC1ibtSxTXjgv9wesd8we8XF9cdu8nbHlNNLzZZ4tSVbS7Snylyr
         ROthxah+VIyJSAh/iJq/UXkSTineA1FpYiV46ONJkHAPw5+7jK+9eVPnIg+qQjyx9f3e
         SFuuXL22YvKff9Xcdn01lpffx1WllHJwTCkQfVSY7Vwu3yDkR3+gLlYRb8VMqR5Z6fXC
         SqIpqZSklY5LMnehl+xe3trrahoeLM6oM4zmrlZF1w3300qiAQ/AbjCWDeK4oe6bfgf1
         tN69k4vGMO1/xlzAsHPx8r8fFft8UGJfEl/LXKG2Gz+V6ONw1Jf9ImbiyxnEmRxBVMzx
         IGNg==
X-Forwarded-Encrypted: i=1; AJvYcCUlacnJaxeDwZ+RExmZ7vglXpomyxdzdrwfP5D5aTwDKyCg6crXwuyY+vj9fqUB1CJEAwBk+6Myvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3ZtWjGOQYn14kmJaYKHBVGWHknJV6VQ4DzW70uSDaI5Inxa4
	T0lagfKldOvMmMGVpjXQz9DA1oPwrVahmS20pH3caichiO0g2zzSZtIJHsZsm2k3GbnXRy+wVJ0
	EEs34HqT82gk/tCKqu2kQV43XYIV3JmYhlrScpg==
X-Gm-Gg: ASbGncslo9HhmIcjCZCTClfoYTtQNB1cuBUKAprwxUfZbb32I1f5CUHGVBMsOplIUk3
	47idOzsmqHIQudj3ys6Al6nSuKNBHCGG8Xo4h
X-Google-Smtp-Source: AGHT+IGshDnah7yTVkge7frSzXP6u6YQ9EMlI5n0k71zbBXiVfkDniOTr0RXn5mT0CNZhOwwkIPYxH+G4Ml04S4rkI8=
X-Received: by 2002:a05:651c:221a:b0:302:1e65:f2ab with SMTP id
 38308e7fff4ca-305f45dcb78mr119399301fa.20.1737018543217; Thu, 16 Jan 2025
 01:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110123923.270626-1-szemzo.andras@gmail.com> <20250110123923.270626-3-szemzo.andras@gmail.com>
In-Reply-To: <20250110123923.270626-3-szemzo.andras@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jan 2025 10:08:52 +0100
X-Gm-Features: AbW1kvZEtDtDDV1b-JCy06VodlCu92OcKCF4KhRqyAArlBqTeeutEPgAkUkNoec
Message-ID: <CACRpkdZ6yNvtqjYHaWC6ynP4CdkGSdt5AH9ZrZDqYq=wTehu-g@mail.gmail.com>
Subject: Re: [PATCH 02/12] dt-bindings: pinctrl: sunxi: add compatible for V853
To: Andras Szemzo <szemzo.andras@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maxime Ripard <mripard@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 1:39=E2=80=AFPM Andras Szemzo <szemzo.andras@gmail.=
com> wrote:

> Add compatible strings for V853 family pinctrl.
>
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>

Patch applied because stand-alone, clear cut and reviewed.

Yours,
Linus Walleij

