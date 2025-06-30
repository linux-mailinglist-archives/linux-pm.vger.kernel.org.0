Return-Path: <linux-pm+bounces-29815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A13AED39D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 06:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E343B135B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA31A3154;
	Mon, 30 Jun 2025 04:54:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185E194A44;
	Mon, 30 Jun 2025 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751259251; cv=none; b=LENQiwp8YkLTBNVuYlHZOprkcBgjdWoIhV/7SC+YGYZFWwWKZK9gKTFIM9mmLlu5zMHHyIDOe/PzibwJ1ZPZgK2x/3wJdTlVjxxdpFr7MGSns9iGsLHSdcY9e7947bfrMXtws+yahYQxFgBN/ASookQLBPf/A626S4CTy22OCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751259251; c=relaxed/simple;
	bh=q4cChbdvhDL1OSZn8A56fKuAJVHQOXAwQbXbtQgi6LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUDtsisxlUC7fLzVMzA8raPCOZVP03sI3HfJTI84aqj5JOEi03xLIfudUDpfNleDm4DBzk9yacg6iCSSjF8U3aLRl8ZKklDNgHyCQ2h0FfJ2z9sejB7MMnI/rISETE7V6Ip+LOB0/hhssEEFBMxfpQKQdgxaQge8xtmpgOWjMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5535652f42cso4737256e87.2;
        Sun, 29 Jun 2025 21:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751259244; x=1751864044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+et2JbQsekjoDqNx2V23zrGG58Up1Zz2cWU2HWIxxkw=;
        b=J7l+GeIPwAG9EqZ4O3gPdEEHLnDeSXM+pDI6ul1GI1yHvzlEPA3Eo5bVF40fP51+qP
         T++bNfYYFvsCCNr8iGy5JCy7omXALrfXHYe1UGPF36Z/V3aqX+8VJ+52wJKp0ancCbfy
         K4DY2FYAX+7kqX+y/Mo+achwRLj5tTHedHwe6w5VImNY60vuQ4nYwXMoExQsFRDwLMzS
         JX+m8Wv00v/DRR7kFceoVLSXaH/513S1mIlUY+W2rR+Q/GiUSwRTg+qUfblLYXjA2hW1
         c4qQntPB2Usc8m378GcQB4nfkN1/TI6YMpQ8UnSO4a5xRiYkF7GZpY2VAn7FFhdEEEie
         mH8w==
X-Forwarded-Encrypted: i=1; AJvYcCV38otyxYvCYbLavSFnz7nLFFK8ZKLhTGw7+KcAatJVoBw7izQQKjuFwg2WBAKYFTarcHJWeNx9Rbq9@vger.kernel.org, AJvYcCVkJOr0NFVr3zNyqgqnXgEc4Bj75S8+6i/MPpz0RRoipoG3YlnYCQo0GYZCbbGVD7rF16ad5q7OGW1TtSK6@vger.kernel.org, AJvYcCWb6qrOfjUHmQT3D5sx9BagGtE1BlbFe7vMqGaFlxgUaDuF/SmjfU+5tPjNguYAO7agPFXMeFADzYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsP+nfC4WNDRrpSoiEiLtCkYVHOSDg5pv+GEtn3am3OWB2jy/p
	sdflreBZAJWUEL2N1vHyK1q0oYkXv4tsihOxNPO111xp++KphkcFT5tYdFrIz6nE
X-Gm-Gg: ASbGncutoOpZpuwyhkC271wBZaqG3YRmHnVRCS/1V4LHKmg9frryHbKzoKXfS0ooZIH
	pwzUiJdMBA1ucCVBbaqoJoD8fax+2UaEIwPsXGeIro+ni4ZU2j0scy3heKq27YnEqAlPnCq2KJQ
	vfBg+T3GeTJ99Pi7gNoKFhvWM2UKGBz6e/uK/0AnXCPTvWIPTbjhoLZVDQSrILoGmYuUM2gU/wJ
	qGJrYpcwdU4wDQ5UhOO/luC0zvZSkV6wgjkbWLUm3olaJJqlBfXR2pX1gYGzKqBwxTrG392m3tM
	7BqS8lsy3WBUcGOl2tNtaQgMB7tMhrcme1pJ4KgzZOyU72DaEftU4jWURMGTFyd9nW5zf8KUObv
	RTvwvmsNw3lctYvNSEjo=
X-Google-Smtp-Source: AGHT+IEPXdE08Sp3Oy4NMTRIgRjshR5wQvGlfnBAMYKeAZ2ac9PBCar5nquYG8ey///R0QWkpPyf4A==
X-Received: by 2002:a05:6512:e95:b0:553:33b9:bd3a with SMTP id 2adb3069b0e04-5550b8e6179mr3083357e87.53.1751259244355;
        Sun, 29 Jun 2025 21:54:04 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24ed7esm1296440e87.81.2025.06.29.21.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 21:54:03 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b910593edso33078961fa.1;
        Sun, 29 Jun 2025 21:54:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXoFPwTajZmdNDJv5gpY9As3jzy/9jE6EcXYRcezcAjLTOcDXmPhXDFN0iyQKOZ72UNtVTruGD29c=@vger.kernel.org, AJvYcCW/NGMFdB5zI+MzFBwYQ83N71XVP3byyvygbxqyQKVbFypbccL1FrttKIisdhYZDAcHefbXxWkMywpVrOhr@vger.kernel.org, AJvYcCXPUirFIg43WaEVRDHW5bgx9p8oMDkZFXU7zYjjrrJtZyxkAC/9PdXqoImfkPxL8TRe3E/6CJdD5aNA@vger.kernel.org
X-Received: by 2002:a05:651c:31ca:10b0:32c:a851:e4e with SMTP id
 38308e7fff4ca-32cdc575ebcmr24256581fa.40.1751259243150; Sun, 29 Jun 2025
 21:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411003827.782544-1-iuncuim@gmail.com> <20250411003827.782544-3-iuncuim@gmail.com>
In-Reply-To: <20250411003827.782544-3-iuncuim@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 30 Jun 2025 12:53:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v670s_r4NG8hWHQ_exc6TM5JnvAEYw-vp5ndMn39X-B4Yw@mail.gmail.com>
X-Gm-Features: Ac12FXylrAnNPmh-5tW8elyoVrQtjqLfo-AL1Tmi56dNnknRJjo1EfbWOyGYXgQ
Message-ID: <CAGb2v670s_r4NG8hWHQ_exc6TM5JnvAEYw-vp5ndMn39X-B4Yw@mail.gmail.com>
Subject: Re: [PATCH 2/6] thermal/drivers/sun8i: replace devm_reset_control_get
 to shared
To: iuncuim <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andre Przywara <andre.przywara@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 8:39=E2=80=AFAM iuncuim <iuncuim@gmail.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> The A523 processor has two temperature controllers, but they share a comm=
on
> reset line. We need to use devm_reset_control_get_shared() instead of
> devm_reset_control_get()
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 1f3908a60..dc4055c9c 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -391,7 +391,7 @@ static int sun8i_ths_resource_init(struct ths_device =
*tmdev)
>                 return PTR_ERR(tmdev->regmap);
>
>         if (tmdev->chip->has_bus_clk_reset) {
> -               tmdev->reset =3D devm_reset_control_get(dev, NULL);
> +               tmdev->reset =3D devm_reset_control_get_shared(dev, NULL)=
;

You could just use devm_reset_control_get_shared_deasserted() and then
drop the reset_control_deassert() and devm_add_action_or_reset() stuff belo=
w
this hunk. This simplifies the driver a bit.

>                 if (IS_ERR(tmdev->reset))
>                         return PTR_ERR(tmdev->reset);
>
> --
> 2.49.0
>

