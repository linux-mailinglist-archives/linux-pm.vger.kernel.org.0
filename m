Return-Path: <linux-pm+bounces-19812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E079FDC76
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 23:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91D53A1556
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 22:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB9194A73;
	Sat, 28 Dec 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQJx0q36"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FCA1531C0
	for <linux-pm@vger.kernel.org>; Sat, 28 Dec 2024 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735426559; cv=none; b=J9UtBfYbRYVAo1JTN6hkZoBnCbwKcmHgHjggQqsa/4nwx033YsJDKIQigBuhYcjVDwiAdtMa9FUQO4LqcuiEWfoi19SVxeEWRaD53gyXkI3oxk1xt4A22ZZHzrpYZuLH/y09+MhWSALh6KvrPg/fGTlkkyzd/nvLI0oER2afMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735426559; c=relaxed/simple;
	bh=Og/Ya+X+3++Et3/7WcbZEScyD/vU8dvbGouUjKmS+Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNWqLUMoxypHaZosyGq2w/+14Tp/axke7PoILs7zasDnXGVqMfrgT+GVfeKpAw3qkICqUrvOqjOIYsXDwYOe5WH1bXOQQymK6uGBFmxI1VYnObSwPy/0hgvyF+mu3c9YeQnFKFVLisifd9aTryAdMX8vyICRLxtYEYyQz2ZR2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQJx0q36; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so9064597e87.2
        for <linux-pm@vger.kernel.org>; Sat, 28 Dec 2024 14:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735426556; x=1736031356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og/Ya+X+3++Et3/7WcbZEScyD/vU8dvbGouUjKmS+Yg=;
        b=rQJx0q368x3w9zAL1TOJsbAVl/tJqWQthYrQHZ3dPmiw1tNxMbEAkaaw9Q2nOwcLFl
         +rNajV3RXS7Zw6K74cyOCL4XymdNlYbhBNIBjwFSxO2JmEcR6bfPwOB+Wkmy3bVgpmIf
         l+f7I0t0rIWU0irJFAMJWdGAYhbNvhIaKK0a8TAIYAcgPPW7uLwUFNavtto4r8H/Ykjs
         5YjKfAIPIwe3ZT+4CmWJlGttLYGDdT3jY8QNZNfDoI+xobA7wathITRBzbwl4YUt+Lpp
         0jI+mIPy4kPNIL7GKFItZyHm/8z/1KCxbWFMk73T/7KiwSRXsx+mEmbTL8Qw0DhuqbuX
         5Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735426556; x=1736031356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og/Ya+X+3++Et3/7WcbZEScyD/vU8dvbGouUjKmS+Yg=;
        b=ZjyGmii6RovMi70vG2UtV0a3/xnbRwIKAb7hgQsqk/m61wi8hKpYwsqlQ13HEWMuRc
         dkQXaBwqMBKn2nWCm1LYbOxR96uz6eC585EjPB2cMYXx6z4lyDM/jmEuYCOI7z9iXDmn
         GyymEon15ByiNOhcg7LzsJeXU1Sv8qzL1h9Tbh8LJqytjV6jYwY3ZTTsKdQraDCImgV2
         YB16o1Vnusst9GagZJeFyd4Zn3kSQ0AV1i3THxMekh0Ic/LqxezYSYhwfYuPsq1SVnyu
         f2BYKe/V4ZSrhHPG0Y0Khn21gByQHZgIojYJDsNLDJW6EwZFLNOw2xYunWDWUG5cQHoU
         E9yw==
X-Forwarded-Encrypted: i=1; AJvYcCUoLzFg/K8Ef2M4JEp3uc1Ci13WoJ9skhpzpctTxJ7XXL/IQgFOKDDW+4ImDkNTYIAa8P0h0ssFtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aWoR3wI10Ybz21gGffxvV9kAZ1J6r6ofYVWHG/1N4+NgI0Hz
	/cxzOvhQYLP9g25REOwdwCvio7OZizo7xvCtk366vfxPW66DSdVqcWnw5FWvCDM1D+rpyr8I50r
	niGVlyFalUX/oTZQ/U8hDP19+JoqUN1wmMfrHpA==
X-Gm-Gg: ASbGncsm4eVQTfjIk4X3JG5R3k9OHfPxAogon/9zyn9mP0fWu3wDVirlSuVbnrs5nWm
	kqOUa+w80lmYFIfTApOXslOJRb+u2kWqm3scu
X-Google-Smtp-Source: AGHT+IEOcI/QKkD3AUBydUx80A/BH8Zb+xNHEVzuo3JP6PjvydFsYRRsKbYFCgVkNWvtDpuRPklRSeHgUyviYhKsrpU=
X-Received: by 2002:a05:6512:2246:b0:542:2e04:edd1 with SMTP id
 2adb3069b0e04-5422e04f073mr6848917e87.42.1735426556517; Sat, 28 Dec 2024
 14:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com> <20241228-wake_irq-v1-12-09cfca77cd47@nxp.com>
In-Reply-To: <20241228-wake_irq-v1-12-09cfca77cd47@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 28 Dec 2024 23:55:45 +0100
Message-ID: <CACRpkdaTBSpk7wToj2TLS1Tgj2cshuSrYgEm4bj-WmFSVohYoQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] rtc: pl031: Use resource managed API to simplify code
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 2:16=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
> error handling code and 'driver.remove()' hook.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

