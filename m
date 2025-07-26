Return-Path: <linux-pm+bounces-31430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A842B12D01
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 00:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B524540ED7
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jul 2025 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB42217723;
	Sat, 26 Jul 2025 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B25JUo4p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244AA93D
	for <linux-pm@vger.kernel.org>; Sat, 26 Jul 2025 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569716; cv=none; b=QIHFZw7eO5/87WnyfVc2ZM8sLaFq/3CcIIQkm0r6CDp1Cu9ok4nIPbhNgFJO2e8VGAwVcN0EYs6bC0dfYVYL1ZrEsjglHFplzdlo3+eMKZAUqtauqdgEhgsyxrlftzk1W3NIlXGzobkmEmlPSf38UPBzlKoFzfbMfJG21nh/vaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569716; c=relaxed/simple;
	bh=cBi4HghK3qgYtUjLxJgoh0K3nC6QeiUnR//4jzGy97A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCCxJVnlU8STd1N7DYnOteDMqaR3iuZyAmKWjoNafOcMROJUn9Zn0aDXqvqfmFTcLE8CMZUg0t2xFjuHsSU5o5OZoBn4OTSpuqBGsgXP5Wgsa6QXdnknKoxCB5vZomEo4aY616fd1ek+fVXZtW46taMDZExo2J7qr6Av8GfLdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B25JUo4p; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-555024588b1so3431508e87.1
        for <linux-pm@vger.kernel.org>; Sat, 26 Jul 2025 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753569712; x=1754174512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBi4HghK3qgYtUjLxJgoh0K3nC6QeiUnR//4jzGy97A=;
        b=B25JUo4pytKFF3EK9YF3MkVDNGofjTSu2jBDZWRUePWt5Vbhx7gTRNyYOn7wU7p6S+
         GXLPE7Uded1D0TDEEsFFImHpQkBteFqYUcuycelGwTQ+zA1uldw0LfKmBCzz2bLZ/BLR
         npxc0Pe1C0agRXKTRJvFYn1YFevHTZ+G7/uuQjRDibciDt449s0Y+9mOsPhx+A94rbCZ
         DHgLmkOqkhe3nS7j/TToV0O+GU6oGWDtJaeVDQsoneiWIo/+Q+ULxCp0SgYv3FRWj1+r
         glXAbMy3VdJOxajzfUkmv7+YV8nTTO3G23tNL7dP4sQI4mVn2c8WHbMKXM3ZRWxlBXQX
         uctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753569712; x=1754174512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBi4HghK3qgYtUjLxJgoh0K3nC6QeiUnR//4jzGy97A=;
        b=Kpwzs/zQD4S2prGaKBjO3jQrBBBES4nv3lzde2apqrUwjlEEgpK+pnzTu1Xm4+Jec/
         e2VWIqlboxgloKzO8dtboUNyKOSwBel6M15oL12kT/zDTNoZEq+4yX3wN+0aeW2R/VPD
         wRNSUT1lJxu1x6IB2ev4RbtUGYwQ1IXsI2LcyJBxbbMwfW44v7B+1de8o8EO7krbOSA7
         9/NVEXHF2svwiw+9yBCUQInx0xTmACK5o1/ZLXXp2e9D1WmOsL84AF0tAUI2JWapXCUH
         vuJ+q6vlRu1hnOxG2iMJIC/PaY2ngD7POo3EoME9478dk4iXPLJa0aZG3Yj5jSZM4+Rl
         FGaA==
X-Forwarded-Encrypted: i=1; AJvYcCW78ngmeo21e6R7TJud0lf2093mxmSdRGaLxzKfBoCv5Qd51VqA/BOue38RQqpak3gfHq6WBaoNsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWqtTwqB3RxsgEyBYizgZvEH9mpS6TZqMZ3k8kHtlHjIrMfbVc
	50+rpmffkYoDpnVdY0rXQ34a4NYS9pJQBz/ybC1DX+idUpV0EtZJ0XwH9hCtWcAre8VPAyVarvB
	YHUkPeNNyxZ7varnBMsfpHw5juV2A2hvEGTeRixcPdeKB7DhasUQU
X-Gm-Gg: ASbGncsnxy+8GdT+8xOA0LtM/p/0k1e36rP+rtatBX2Eweril9O9ND0X0YSRqU9Ju5P
	Iv7099UsG2SLxkGH805oFInBdKfyGYbjR3GS21VW/E8HYPMTyN1F9WC/UqC4xR/9Y+CZ+9XjFm2
	Sy+rSFBuMPJr4GSR+8FhCJMRoAbxGgqQG/engoX5Bud360kPhkBIs3jQA9y9XsYNyqPfoOhsPlK
	L/Nnwg=
X-Google-Smtp-Source: AGHT+IGoV8rz8tfY6oMSV7iDtICBOrl2xr2pMB+NL6+PFmuiObxTuR0V+mjCVLvct6uyUwUOGv9kibYDz2VsOt25Rq4=
X-Received: by 2002:a05:6512:2313:b0:553:aed7:9807 with SMTP id
 2adb3069b0e04-55b5f3cf4cemr1848352e87.9.1753569712426; Sat, 26 Jul 2025
 15:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721122605.46724-1-hansg@kernel.org> <20250721122605.46724-3-hansg@kernel.org>
In-Reply-To: <20250721122605.46724-3-hansg@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 27 Jul 2025 00:41:41 +0200
X-Gm-Features: Ac12FXw1SAFJWNA4SnLXz1mUzXGKtUJ-Pea8sZDLLP4OaQSEcqL2AXaVewmHXpI
Message-ID: <CACRpkdZZ0qQBQN8fDjZyMveCK371s2gpRqEssK=P=Hq7gj-_Gg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] power: supply: ug3105_battery: Switch to adc-battery-helper
To: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:26=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:

> Switch ug3105_battery to using the new adc-battery-helper, since the
> helper's algorithms are a copy of the replaced ug3105_battery code
> this should not cause any functional differences.
>
> Signed-off-by: Hans de Goede <hansg@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

