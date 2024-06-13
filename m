Return-Path: <linux-pm+bounces-9071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8419E90689F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A01B228E6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4B813E03A;
	Thu, 13 Jun 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nemvFDK8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58D13E036
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270861; cv=none; b=P3N9wXKQRpTdDxRMcDk81HNVkGe4PMZp/5ccbEyOSzwke33h3hAM/cuqVescR0LBrYvMsyaq2SsdbyeiCxXfYU4qxkTeiYtBmxyyH+9kZd/1+tKpi7Psn+ZJr9eS1WBcO66mJoOWKK+24R3yJB7b9iR5sI5vsENBQbJRFn3ISMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270861; c=relaxed/simple;
	bh=TnUOJ+4HklKphOw7S+P2VCYav3R6drT/0KkPUfevcPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn/wQS45d6WypPlos1v9u6zFtJl1qkXhEJMu/obwt1C/9Bc2tOAvaX8f5UHPmwNKMKf9sJC4+Ap9/c7IcG5hcOv/SsUP716EeAkbEM2POKTl0kirOnZtAQjrGF9xxpLbPU5a9OaNR/5vYWzZ9uNnfaedFcjXM5d0dQo9hDrgMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nemvFDK8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b78ef397bso1727087e87.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718270858; x=1718875658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=insQvK9R1EyR54r7anWWzLFx+1Jofdzk7RsBG6boHmk=;
        b=nemvFDK87pMj0jBj0dFQIMn+kY1Q3qPloGqMuw5pi+KqjY06LQf7d+NXBq09aie2Ba
         oUYkXNJeo1LxYOqwMYuOzVk3BMF+I5rQWMCUaaLnzO0x/LsxAj5BZlnJ+Y7cDLqsB4yQ
         1At8ByaGrbJCXdnrlnRg+ykMRMuSoyNsnjDKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270858; x=1718875658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=insQvK9R1EyR54r7anWWzLFx+1Jofdzk7RsBG6boHmk=;
        b=mIrceL4EfOTu5Rdue7Xibtl4XMDpgtB3q1U8cU01B+n3Ly0uPeegxSrS6RS5xW7fWC
         IC7huhyhAeEpJ1PrAo9VDCgfCVi+2dSQ4mfdt9O/o9JbMTwz0EsKpWFcoZ0aC48j5cGG
         rjplmqp05VGUzdfdtaWzQhrR6JlG5UkBP4zM4MIEhm3evseazEamMCD+kH/rdf6UmbWY
         Ty9boeCz7qu5j0BuduR1HLfQTGjhpgYUFf40kUwn4F1JxAs3wwPSsiiXThntPTZEn0CA
         daL9C17uNTC5EM3ukCvqrl77Wm8d+Rk45XDB1LC7WGqZx3VEL9JF3F16D6rryeNe+LPR
         OKyA==
X-Forwarded-Encrypted: i=1; AJvYcCX3xETVYlpny1Q/eFgavTmQO/vdBHkJiSFoSeoQjU45RLs9xA1y9bQcekBZykteXxMNjT9BZ13mJBohbSJnZR1xiHDhccIJ5VM=
X-Gm-Message-State: AOJu0YxHdioqYdsbx+udin0HwirM3Y0xK0WmTsPTXBwB3LgZPhcUJbZR
	Vl3R7y6pJrgezwJXpgUU3SWBMLBRj+t95ruj170GH/qMLmZgUiIXKvWhKL6k0rQsoT/9eZmSZLt
	ydz6cp2UBWX/NB+l7eIlJyw3KA6Qq9DKHENWqlYEocLKtWK+oTUI6
X-Google-Smtp-Source: AGHT+IFweMRmygtvvTDSiYUDYKIwSqL4gWtyMZ2J0Xr4c3ALSyvlOKPfmYXStZjbiDznGJXEbiu6dI+fQZipiRcMkM4=
X-Received: by 2002:a19:3854:0:b0:52c:8508:e851 with SMTP id
 2adb3069b0e04-52ca022cfebmr561772e87.14.1718270858065; Thu, 13 Jun 2024
 02:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com> <145ba1e5-628c-4e07-bae7-039d1655885d@linaro.org>
In-Reply-To: <145ba1e5-628c-4e07-bae7-039d1655885d@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 13 Jun 2024 17:27:26 +0800
Message-ID: <CAGXv+5HYkZJrTfr6bYKe3qySSzN9Zbxkhp8T9X2SS234srXOAg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:45=E2=80=AFAM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 04/06/2024 18:46, Julien Panis wrote:
> > This patch prevents from registering thermal entries and letting the
> > driver misbehave if efuse data is invalid. A device is not properly
> > calibrated if the golden temperature is zero.
> >
> > Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage The=
rmal Sensor driver")
> > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > ---
> > Guard against invalid calibration data, following this discussion:
> > https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collab=
ora.com/
> > ---
>
> Applied for v6.10-rc3

(Dropped most recipients and mailing lists; added Stephen and linux-next ML=
)

This isn't showing up in linux-next.  Could we have linux-next track
the thermal tree's fixes branch [1] as well?

[1] http://git.kernel.org/thermal/h/thermal/fixes

