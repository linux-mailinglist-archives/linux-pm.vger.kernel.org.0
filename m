Return-Path: <linux-pm+bounces-35608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6BBAF3A2
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 08:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417123C8177
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7282D6605;
	Wed,  1 Oct 2025 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBmH2+ws"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C52C2368
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299866; cv=none; b=ZXoGjmd82Deckv51bBL8K2i2TyXmzAv5Otz1nyensRow9Zact6BUUYxaufpPwtWP9qr3BR8sKnSG8GHhTovX1SnXsU7mQ5nBcuIrxk3LsqWuhpeo2JQupZifxcV/IZAx82/Zm0XsN99jD/MPXdWbKu05G9/rxrscYQa9Ikx9rgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299866; c=relaxed/simple;
	bh=CRAgifSudG0wZpugBPM8hbg3tAFsd9BARcUmc0q8uy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfiYtiBgqneUyIFnL5sOUPvgP8QetkCbjT20FIrE2Cwwz/qbTlaIUQqK0eHNFp58SBZvtmWk3/90wFkqfes3GAoeqCkq0f6KtKa2eQuF7+i3YW9m7viTfl0O3i3SmwFSamtnq7P+Zz59uXv3uCcHwj9SB83v9mC3/pIJe3sSt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBmH2+ws; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57f1b88354eso7282176e87.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759299862; x=1759904662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRAgifSudG0wZpugBPM8hbg3tAFsd9BARcUmc0q8uy0=;
        b=WBmH2+ws8/DDuBObE2cAr8KZ/24nrJYEIYCwS+M7mxGUmUwpdH3/oskZ2UqtynHEun
         RbP2kdtvDP7liHTY7D0oF7RdORfI+HqIrEG8bC1bkBIFgoD2/Yl/x8OXTx4msfQV7+Uk
         aDP0J/wwS1CbmxhR7grMGDhEqp5BmBP1Bp4mWug7YdxhUubT9IVlFfeuJTQY80jmRdrA
         5YHHFLH0shOZ380FYVXwdhKOUcs1cNa1/kiNTVBNP6rLHKXWICR2pWsScOd4Xr5LFCib
         l4CChbXU9ykn0RNwTi0ulhcAfrCw0uyxFXw/ntewc9zmIng2QDGIPBrCMdzMJa4HBkBB
         16sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299862; x=1759904662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRAgifSudG0wZpugBPM8hbg3tAFsd9BARcUmc0q8uy0=;
        b=I2mT8zd6I5YL6kr8VkGnhrdFlvAUHLts1ELVZJYftgyvg9YjzbhGyJDbt4MUTONMKV
         Kw7h0jnyS4Xrc97tuPf/mmD/65eHYjq1gkFO8r7N9eMNKpEYNSRCF5aS7DDicfiAn2cI
         ZnG6ZxCGxs6iJt1KWnAvvo5SKaXFdUNXBYRP7DzBV9Aklz0Dvvodyd3nD7cny8SOlr51
         yQQMoHY625Tw7VNAp0tL2aAHFi4Yacl0348h9BtBfKYqhy0T2so97MCdsN2x7/GRiBIZ
         Gb56zFnSaoHRLgTZIsBIvrCiOQMTcZE/BsRfUkrA6LdYNiQxcU4UTH6P03gB3S4yWBFe
         pz/g==
X-Forwarded-Encrypted: i=1; AJvYcCVVn03riNrYer2EiQI/z22aYlTqEWOBQX67QAAcJDLt2+t4tUZKOwfKh6eqNM5165Mrud4vc9W59g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtjxahpFcLxPpOL9kzwag0S3ttRlunkJmeJTD5zIEyC2JGc9Q
	p4q6SUbD2RS2e633jePrtgdezjVieAvl4S7emqLDVEayLF312WkLP6+CshiJBPLWZhLHRqKpHIi
	8qde+Pf/tDBibGcSsYOlOrivYvZ0lvGWl3EgoxCiDBQ==
X-Gm-Gg: ASbGncuyp9q/2TVqs7PpkWWAuM7ooSVLQHGH0BrG3vNlv/enb/L3E2GCBhOgUPekvHZ
	KQHahkLAio8bQ8Emw16Rhq7+HkdoKvmFec4XNC/cWTpG4VZcg2NXr9qHNv/CQH58aX5n6J97d5n
	NzJT/RGGUj3GDvfbU+DM7/l0/ZrvA4TellblKwIZZe1p8W/i+vkNiMhALNOguo8IB4n22uNgv+4
	3AzicB+h/MupMU10Nb1ujsl6YfNtLM=
X-Google-Smtp-Source: AGHT+IFozN4lyb6vOpauqxIZ3ZLWPP665BWKXXa2eLUpNSUCsqO967pjOJIApkPryd/vgSxP+dQ4iOCA8lbPex5gtHE=
X-Received: by 2002:a05:6512:6c9:b0:57a:1818:480f with SMTP id
 2adb3069b0e04-58af9f6e9famr596020e87.46.1759299861855; Tue, 30 Sep 2025
 23:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org> <20250917-rda8810pl-drivers-v1-3-74866def1fe3@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-3-74866def1fe3@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 08:24:10 +0200
X-Gm-Features: AS18NWB7xcfQD0XZT5zZ03zQzwmaWFrlIYwfqVvy-IagezTBvTp7mSD81HURh8c
Message-ID: <CACRpkdbhTWtu1tvGQ-nY3phUeD8+0D2TmEQQUwDXhXS5thHn1g@mail.gmail.com>
Subject: Re: [PATCH 03/25] dt-bindings: gpio: rda: Make interrupts optional
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:09=E2=80=AFPM Dang Huynh <dang.huynh@mainlining.=
org> wrote:

> The GPIO controller from the modem does not have an interrupt.
>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>

Can you split out the GPIO patches (like the 3? of them?)
into it's own series and send them separately? They seem
to be possible to review and apply separately.

Yours,
Linus Walleij

