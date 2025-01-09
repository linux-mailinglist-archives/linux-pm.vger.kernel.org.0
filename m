Return-Path: <linux-pm+bounces-20161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9EA08075
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 20:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65477A28E3
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F419FA8D;
	Thu,  9 Jan 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QP4vU+zO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04C2AF07
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449807; cv=none; b=tEvxc/nZbe8PbIDenyUr4QG/lLar3eT2SVPdXwBpQISBtrje+fLoDOBYuTqiEleHNAJVwUCzjsCSe0KxUUvNmOhvi7Ux/yoPLwKADuUAciDgdW85vFfopORoNsMsJBuX6od/sC1FYTrU/No49vtGL2WnPxK6y/bGZdKvJ38p8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449807; c=relaxed/simple;
	bh=ztB8QMxXG57fyiJiPyOTkzqaNbYZnkur2dYi4+l9Wyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVJlQeceQ1TT/FStiw3xjAdXrih24rL3GWFaMrYKaTHODGXehoc2EpsQpcv0a/V0GpCWmj1enSV4ralMCGCiKyr9t4Su0jzv/EeEovLoS2qnsC8x41wZMXS1A8BrivsJk+l4FmaoeDMEGGBooWgzXBAnouBtrv0wu+amau9iwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QP4vU+zO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54252789365so1512509e87.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736449803; x=1737054603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=033JmqE4kVUrBXvHgjgoIo0v08Uj8oWqcjO2I4rH828=;
        b=QP4vU+zO746F49YXD1iPoSvLmAX0BXVRcNBiaHvfKdyfcMAmhoOuLk1+MauCCA0YEf
         ZouPQYhlsDRPMBOGheSqD6q8t5ZM/jGP00gvZnItXeqbDCrfxxUwtZE/C+Y+b4NGAp8l
         Gbap/f+fpAO9nlh3o1Zrz7rpDbkOTJ449R/tmk6H4ungSuLWq3P7RPDdqWZJwRI64/4o
         pp+EpDKa6mBc6Ea1Sx5QOA+/YhYGIcv99c16DhBsEZtP+tbLSTDtQW4A8Xd/e38OP13A
         24uy9j7E9yL6UI8jGlBgWfCVml5ZLvpgKvl8+h4fpZppdc0NNZskU+Plc824Q3JYqJUa
         fh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736449803; x=1737054603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=033JmqE4kVUrBXvHgjgoIo0v08Uj8oWqcjO2I4rH828=;
        b=U2a8nZ/cyiGSBxC6IycWeka7wrhgP4mFg2KYo63Z/OTTyV11VyS1WGq5eBgJ4VZUMx
         +ZZLV4cxwZm8OwtanX8jVF6SBhMcsfzQQYv6k1IPkfObXR8U0kiaa8gvFQVqFxi7ooGq
         XThGvKpyPdcLNMbbnylRtmle4HGld/YVMihNLu7yj3YLrf/JrDMwKgndWOTDhcsKoDN1
         k7y114nKP2VRx3UgKpmY/X0HI11ojtbDycBlbB74BNTHm/B2hkDkSVEaY6eQ0bfLzotE
         nJNFu2FWSylGqrVGsq1aDbw9V/RXkQ1EUa/0I/9t6GA3aJuBqb2t1Btc8WW206A8DqY1
         6yYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI6VizLcWBlsSkNxAX8qJtIQxbc2ogvq29xdL60KuTqwXLhOb4mow0i3E8ZCeloh4jthFnK7Bazw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHELfRCESPj22l00zX2cpJcMD098PZm0AFicLeVmlUTh3FjvaF
	pHxJlGn7OGw9AQuOjIcuIjeW7s+9INYVKw1TUCPWfaeTtFYoVtoyBCFt0D/bxs7kXXhZ5Nqc5Vq
	jh26edDY2mMJcyccdLEzlkUC4OO9Ev5FzKby61eYKHFmtqFOP4TGA8w==
X-Gm-Gg: ASbGncvb/HhNY6pBjh9LElcdIWncwJ52xt7OQtfrCd27DB+z6Mt9BhWzCByZVPk3Ij9
	449NItV8rqBdM54m2mMecKxBUGLSzlKyuv7Ug
X-Google-Smtp-Source: AGHT+IEFDXEsZPp57ElAkHFJsGAlwp0fqUVCLKoqAIDa5G+0kJdNGr7OynTSJFBCj/Xys060QDD3Toklafw1jfetu94=
X-Received: by 2002:a05:6512:3c9c:b0:540:2d64:4ef4 with SMTP id
 2adb3069b0e04-542844b04a3mr2685807e87.0.1736449803247; Thu, 09 Jan 2025
 11:10:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107113346.170612-1-hdegoede@redhat.com> <20250107113346.170612-7-hdegoede@redhat.com>
In-Reply-To: <20250107113346.170612-7-hdegoede@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Jan 2025 20:09:51 +0100
X-Gm-Features: AbW1kvZfXESF5ov-jAJd_iT6ZXD-KPIGqtsD3CP-ZItklrq2KDPUdrvRBzUDWs8
Message-ID: <CACRpkdb-YQZeJ4igWaJAr-FwokW721tdM28TtgrZYtar1j=Ydg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] power: supply: Add new Intel Dollar Cove TI
 battery driver
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans!

This patch set continues to be intriguing, I like it!

I try to help out as best I can, more comments below.

On Tue, Jan 7, 2025 at 12:34=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:


> +       /* Read Vbat */
> +       ret =3D iio_read_channel_raw(chip->vbat_channel, &volt_raw);
> +       if (ret < 0)
> +               goto out_err;
> +
> +       /* Apply calibration */
> +       volt_raw -=3D chip->vbat_zse;
> +       volt_raw =3D volt_raw * (VBAT_GE_DIV - chip->vbat_ge * VBAT_GE_ST=
EP) / VBAT_GE_DIV;
> +       *volt =3D VBAT_RAW_TO_UVOLT(volt_raw);

This thing looks like a property of the ADC rather than this charger.

Can you not simply implement this as a processed channel in the
ADC driver and use iio_read_channel_processed[_scale]()
with IIO_CHAN_INFO_PROCESSED?

(The _scale version is used when you wanna just say *1000, which
you often want to do because these tend to be microvolts or
microamperes).

See drivers/iio/adc/ab8500-gpadc.c ab8500_gpadc_read_raw()
ab8500_gpadc_ad_to_voltage()
for a (complex...) example.

Yours,
Linus Walleij

