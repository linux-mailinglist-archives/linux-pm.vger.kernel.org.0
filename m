Return-Path: <linux-pm+bounces-2557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A81838EEE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 13:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998D21F2424A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1985EE7A;
	Tue, 23 Jan 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miusm1XE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8F604B8
	for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014435; cv=none; b=nZuKoS/66j10PG7MAC1FamjXfQUgNpVdCy8zhKjBuiDyE1t/MDEURo8JD2XZb0gtHrvGgDXxSzGCxz72U4bvo/BY8pBS5UP2nGie0BmUz2iXui5ojT+KBKTqkHFSJ0715HfCH6VhWDd4otj8cwSvFdhguGRjvS0idNbVFxEaKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014435; c=relaxed/simple;
	bh=SrubDBE5WcpcfK7f3xovnFiXn5W/MQUApTBY96p2ZzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxiXfUeHcIQtMnRZ5WqtMCV//+Smy0DbLR9m6mnu2Xepf3UEetXyXmD2CW//UhOdj/U4bjF+A8ZpLSW0SsxtkoycTt93u99pBCYyTAkTYhuVkrjYLKMRYcaTTpIAH7JlKPszRq59emh9rQbj2CILOHtEKYOt9cE/zP4vmWaJJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=miusm1XE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f15a1052b3so41129267b3.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 04:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706014433; x=1706619233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+asE/AToOCsan6HoT4XnPwjdlU0T+m2L6pRIK9YYNg=;
        b=miusm1XEW4kveUW39ihoH7X2eavQf30EvZ5jgVfQWWY/zt/IWT22Rm+4iDYPEIVkki
         2TLNjczpT94D4VDDycDi6L03wipZAqwwisLsWa/xIxepIGeqP0cVZxjK0dXzHL6K+jgc
         M8ApoJ1YNlZXrp7Q80rdHzUeWd5/seBUnP06WpRchKAb4aYecJLRtYbmICvX+KWaukaP
         TRmKIJ4zm2CDeoHgCsRBkPfphfQdDdtcJIjGzzmXmj/Q7BNpjvM2fdD/606BivVFpJxb
         Gbu/LHx9nlo6APz1V7Hb4mJO8/IK2RmitPxp+HlO7Y8mIKJ6w+Kvjs4dXOzx1TXdAz4p
         Stww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014433; x=1706619233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+asE/AToOCsan6HoT4XnPwjdlU0T+m2L6pRIK9YYNg=;
        b=wRulCJhhxjc8tR5OuQ+xf1SkVGiKNWiV1ECSvsKNZCLNFXqNE70VOJ5al5C5FkgkcX
         3zzOfHIA/I5Q1zx9oFiMATK0DL4o/L+f/KkrJyaTdcrGIcuJbwmm9dTE6BDmD5eKW3Se
         MFeGz5fbPr2BvRbduBwz4zbApnXjOt/Rn9pN3rQWc3iJjs2+wK5nt6zGEC6sD0m54x+T
         p6kkBFmdqFLySFIhHeiAxVPrORjDAEftNoILncUI5DYSOBPnZPEN0a8+uNKj2smCWsan
         /yp2Wmaa7VmlUVm+OA4MW3GZUhT/r7sFqPEYw8FVu3LFFHVBW9gFi2wvyb5+R7Mwh6MH
         qzuA==
X-Gm-Message-State: AOJu0YzPj5HF8x2RBCY0ogTBlCYLhj4T9y67vFI5sxp5ggxybZWbWQJm
	XUDOQCvZTPIcAZNngB30qJiLAonB5L4Q59RA1j/XuV8LLgg5G72YL7Bc8zq3zLXNAFo2WAeA/C3
	H72SRwgTxtVwXXMz4JFrzCkig/1eP6FQTYgq9Zg==
X-Google-Smtp-Source: AGHT+IF0zt7gwjJbmvCQYkLw24rgqNSfBdkANuOxWkItD7WSZEKNeUhd5CZMquNm3DCcAVEY1T/CrJcgJ5At/Eh1vmI=
X-Received: by 2002:a81:9113:0:b0:5e3:320b:7c with SMTP id i19-20020a819113000000b005e3320b007cmr4912440ywg.37.1706014432844;
 Tue, 23 Jan 2024 04:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org> <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
In-Reply-To: <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Jan 2024 13:53:17 +0100
Message-ID: <CAPDyKFp3F16iQnR9jw6_AJStWvGv2u8CHsF4YJCZSxJj-8p0LA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd to be
 managed by HW
To: Abel Vesa <abel.vesa@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> +
> +/**
> + * dev_pm_genpd_get_hwmode - Get the HW mode setting for the device.
> + *
> + * @dev: Device for which the current HW-mode setting should be fetched.
> + *
> + * This helper function allows consumer drivers to fetch the current HW mode
> + * setting of its the device.
> + *
> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> + * while this routine is getting called.
> + */
> +bool dev_pm_genpd_get_hwmode(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (!genpd)
> +               return false;
> +
> +       if (genpd->get_hwmode_dev)
> +               return genpd->get_hwmode_dev(genpd, dev);

Not sure why I haven't spotted this before - but we should probably
assign dev_gpd_data(dev)->hw_mode here, rather than returning the
result from the callback directly.

> +
> +       return dev_gpd_data(dev)->hw_mode;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);

[...]

Kind regards
Uffe

