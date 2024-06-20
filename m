Return-Path: <linux-pm+bounces-9710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426869112CF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 22:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3DCB246C8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05291B4C4B;
	Thu, 20 Jun 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v07k7aKO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5571B9AAD
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914430; cv=none; b=hplguAn0+Lz0cVMrOLObmiolVf1gvQJHdNoTPspiFC6uxp7h7m3eNrfRTKPKUJ0HBFqPQ2IL3dn/TEj8BzOGr5HL6C2t0SIKIRZAjJwv4dW6q+/hQVesFbIcIGRCNtMDoAiFC4dqCSFhYdDWlQ84w40Cao6qqJKC/4TWvtef6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914430; c=relaxed/simple;
	bh=6FnKxC2oNZkMYNiFsU+CMhRZU/2u+PXH2Xg0uEEq4BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a88u90VMb5Isvqg5bkkiTymOqEIJTcUSq8MI5BEL5OjQ3u8v5x6Ef31KE2aCnRkn7GRVuIr9DvmaXa0zkhkX2QSwl4CFbeh9zDRQ8tK2DMSY+WtCgcSbDRwEOpwuwuqyviyZOi8jlocOScnBZsWM9/tkzrZrnsHvPauyLXi/Z7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v07k7aKO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso13427271fa.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718914426; x=1719519226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gf88bxwZuTUs5YXwWPX6yadFRnjP9I8sFXH8/ud6MPc=;
        b=v07k7aKOFKW1LD4tidMaju2MCZrGuYlTNaXBmlccEh5lil7gRIiog25J8q7wDde/Yu
         dFLKtwwVimNMoQwz6mwKt1VAYalED0YsU9mxExVV6x6Xx+f+2oqmhDnr76jOLjdvxEtS
         oetI96YKomXF2TM0FjPdutYa/gZIXQYaZ1KKsSDfd1j0l5i6CQdoDL26unODSpuNqtDx
         WEdM7woVtlJOEogvD2nQxWIQnAtcBly5gVLY5wuq9URPA9A9JOPlSAPuInwyz3vqscCe
         RbtUKCRGF9d9B62fjsLhlleCEog3o+xNY3KiVhPonLh5wSJzRlFR11Yuh0Kozvm+YF3M
         grjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718914426; x=1719519226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf88bxwZuTUs5YXwWPX6yadFRnjP9I8sFXH8/ud6MPc=;
        b=E0pQYK+cxx3eFiYxKDmpInjFAVQCG0Nyjf9Am3L2D2jFjpbyIDTUqxAMsYAt3qa0EU
         1f710tsccNzdD0fo99mCtdPXPhlt9WnU6Tf8IJdQki049/CSBnt9bq8ody9BFRwulbbc
         dXfz7wviGeLRm2VZmwYFUqH8xv21BCNk1H3gZghhw0+mujdwbKwFVdW2luY7Ia58H2+U
         grhs7xFzm7llwcwdtVbhvXdmbd+KkH22cDYbSy/AYGawRBWfTzVlBBpZqzMLHkuvATiC
         seOEqW7NJucZmHX8B7dZyjHBi6CL10z81kOEULTjtLqLFMc2Bn3Trhok5RsBHFVkKIf2
         Sl3A==
X-Forwarded-Encrypted: i=1; AJvYcCVRebsB6wrZjL6WDHKP3cW4epIKU4TQAiZxF+jNAc7HIaI5n4X2/XT6nfxJSM1KrU9wPVgX1Nb/DvQOFr1MoiMy7A1WcQ+d460=
X-Gm-Message-State: AOJu0YxTOEriTwowdF8a9BaTQxs4194oL+hElMzOo7od7ots3KWduK1W
	YV0x1ZGT6Yc8TtgBY0/fsIZsR+XJ9FVI8L3LBtHE3W7DUod+g/WEFBMumHU/3nY=
X-Google-Smtp-Source: AGHT+IHmscm1ta08k7kKifcSjPxr0pk1YHMHeVkmRekDXSZgsUcQQz9WUuxqquxICdBXbipcg1QQvg==
X-Received: by 2002:a2e:9b0a:0:b0:2ec:2583:2ba5 with SMTP id 38308e7fff4ca-2ec3cfe8b1dmr40485741fa.36.1718914426346;
        Thu, 20 Jun 2024 13:13:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d757f9fsm104511fa.73.2024.06.20.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:13:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:13:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 11/23] drm/panel: Add support for S6E3HA8 panel driver
Message-ID: <c4g235wj3yfdftnwqe3pbupifhy5ploo7chumdgfnl4skzuahf@ftuellx4zwsn>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-11-e3f6662017ac@gmail.com>
 <pkmxbxoc4sno6mbjsftz6hp5lxefc6yhwxjlhiy2pd4wbkzpvl@as43z4t64mm6>
 <CABTCjFABEY0urmgrr5E3-oq9u_aNR8KcCTMpJpoGLOTPOfKAGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABTCjFABEY0urmgrr5E3-oq9u_aNR8KcCTMpJpoGLOTPOfKAGg@mail.gmail.com>

On Wed, Jun 19, 2024 at 04:27:40PM GMT, Dzmitry Sankouski wrote:
> вт, 18 июн. 2024 г. в 21:39, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>:
> >
> > > +     ret = mipi_dsi_compression_mode(dsi, true);
> > > +     if (ret < 0) {
> > > +             dev_err(dev, "Failed to set compression mode: %d\n", ret);
> > > +             return ret;
> > > +     }
> >
> > Interesting, compression mode is being set before the PPS programming?
> >
> Yes, as per vendor kernel:
> https://github.com/klabit87/twrp_android_samsung_kernel_sdm845/blob/e8bb63039008e1704a2f1bde68d39ded9c16ea88/drivers/gpu/drm/msm/samsung/S6E3HA8_AMB577PX01/dsi_panel_S6E3HA8_AMB577PX01_wqhd_octa_cmd.dtsi#L5508

Ack

-- 
With best wishes
Dmitry

