Return-Path: <linux-pm+bounces-31429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28824B12CFF
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 00:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F53ADB70
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jul 2025 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045BF219A81;
	Sat, 26 Jul 2025 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8kaC9q7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88214A93D
	for <linux-pm@vger.kernel.org>; Sat, 26 Jul 2025 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569668; cv=none; b=jm/N3nAy2LpfnnxzRG+9bMWElBn/w2UH0E66KOCLMlFxqFtnEoA06R0VGwK4iyZBn0/156dcA2/k4IcTmyULg2tXNmtajMAPMGftjjFkoJgF2qhrgPgM2OdGbVRR8+9N1adtppqc4MCVBNzRabQRnSTp3ROu3He8Farw23VaFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569668; c=relaxed/simple;
	bh=tcU71LRDEMVFOiI9tP+jdgfbNAKhBN32NUIe2SpyyLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t50Gd8YoT/V0b8x25hbCPE9jV80algsCUJ93OHFi/IrzHrxF8M/ZYskocEv5tBfbW2MFrmer8KFXgGn5ux2Ghx0ho+AoIfCvBb96xcdGWhxe8xsSy1V96MN6FYXw/MgHcACPGxErprqzN44Xfj/Jo9RCUFcMng+OFFGScKItHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8kaC9q7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso33494061fa.0
        for <linux-pm@vger.kernel.org>; Sat, 26 Jul 2025 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753569664; x=1754174464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dbq5nmogjnmgenqAd6yufDdmrxbuCTvbIb1xJIqKtJU=;
        b=F8kaC9q74/ocQ7GiOS+kkEOj5d5bf8UIVSVNE1GhIfpHa4X3mAlK5JhiAqVTltuQ12
         kicaERClSd/O6i9d3UwAf2eqgpVBtvvcOY9IFTeJhwoxMko/tH0mRQJs8mGw6k2pm5cL
         wQiqDVJwQrJtpGn+YBE/X0FML1HkVcNGWqWzbBkObAXwWZGEOIQmsa4XriGthdebL1P6
         N7coWYJYigG3wcLcxo0NTRAZ+EUXqX84QILoSIBDj8D0/W4Pe3Ci732pAdzRgNGhVFYm
         an0H28cz83ip4o0ZPFvt8bijdjpePm5JlKtliAoUYxTs85DMy93QbHhLQBSfrht/AChi
         Kkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753569664; x=1754174464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dbq5nmogjnmgenqAd6yufDdmrxbuCTvbIb1xJIqKtJU=;
        b=m1Y6WICdOKBXgDW3DWZm8G+3JuoyG99x1HRs4LPnpEnQPsB8uzlTiKH9KEaBXk+nYz
         rwnvb0OBdhJmjNj9E8e4pYKk7P/i9pcmjZCUCMUinvPVi24Liq2NrBwLB1EOu/x6rhtp
         o+s4pfVdoCoAPPIPOof9cCY3Ip1GVrGM6FgegIebJT2ahBRmuIUqz7rY4Fq5KpUiSwg4
         DUE/5TA0me/+DFf1WWWZ3Xd9XyQdNXYVQbjts3DhOHURiiKqg2gbij1B9IQNPgSObJOU
         XpAWq5+C0eb7SRp1LWdgvsuKvOmJDNKy6Rm5I7Mnr+TGZiJB6MvRgzPvxDIDvFtb+SOc
         mz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWACsBstpxxQyeqcNHj7EDXPr+aOicIZXpyOYWHfShgzmkrM0eTxPyzpqqR2fKUlB+SgbGXerSP+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIPMsNqzf37cjkiXfNn0bGgTkab+bE6njWJNZj/9NnmrO2xzn
	gFyru+RQBWDTSw1843jj0pVKHLc2y187bkvAxeSKT8lQdFTMGg/yfmlfx3zwUAbhRcaCIoN+lJQ
	Q/lTCb/YY+cUhM/HhJGhwlli3ZgBlnicFeX9R8LM3Ug==
X-Gm-Gg: ASbGnctkPpf1IpQuTJ5OuNDj/aC/P0icIcb17ekm22CeBy1XTEmjYMaIojgCMkBKoM0
	/CDrn50FO1XHA5WPy3UasVyfaaRnXTye2kEL/sFC4ZYrSo1+Rz28WDYWKS79GhdEVdMw+y+EVY9
	JLF1pwktkWRmjdp4TF+/AH+BeU6x7MJnWBdM/bRBzaf7rnoVEg6ocwrTqg8qN6tOIisjmm00UNu
	JEl68U=
X-Google-Smtp-Source: AGHT+IF4PvUQh5QHAj0CwYpKVaIyIWR/HNxFA4y9WCedLUEYElROY0nlG38D0SQDbSKMNQO/SI1Ul0KcklnPYeWxbrg=
X-Received: by 2002:a05:6512:3c88:b0:553:314e:8200 with SMTP id
 2adb3069b0e04-55b5f3cfcc2mr1811599e87.8.1753569664491; Sat, 26 Jul 2025
 15:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721122605.46724-1-hansg@kernel.org> <20250721122605.46724-2-hansg@kernel.org>
In-Reply-To: <20250721122605.46724-2-hansg@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 27 Jul 2025 00:40:53 +0200
X-Gm-Features: Ac12FXytBvPPs2UIIy8DnvowHcKzIaMGXtNd8FQ7An4664XOorTry8EJEbed-MA
Message-ID: <CACRpkdb9xcCuGW503-ffMhnKg78rF5+rcECDEcKmhcR5NO+u9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] power: supply: Add adc-battery-helper
To: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:26=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:

> The TI PMIC used on some Intel Bay/Cherry Trail systems has some builtin
> fuel-gauge functionality which just like the UG3105 fuel-gauge is not
> a full featured autonomous fuel-gauge.
>
> These fuel-gauges offer accurate current and voltage measurements but
> their coulomb-counters are intended to work together with an always on
> micro-controller monitoring the fuel-gauge.
>
> Add an adc-battery-helper offering open-circuit-voltage (ocv) and through
> that capacity estimation for devices where such limited functionality
> fuel-gauges are exposed directly to Linux.
>
> This is a copy of the existing UG3105 estimating code, generalized so tha=
t
> it can be re-used in other drivers.
>
> The next commit will replace the UG3105 driver's version of this code wit=
h
> using the adc-battery-helper.
>
> The API has been designed for easy integration into existing power-supply
> drivers. For example this functionality might also be a useful addition
> to the generic-adc-battery driver.
>
> The requirement of needing the adc_battery_helper struct to be the first
> member of a battery driver's data struct is not ideal. This is a compromi=
se
> which is necessary to allow directly using the helper's get_property(),
> external_power_changed() and suspend()/resume() functions as power-supply=
 /
> suspend-resume callbacks.
>
> Signed-off-by: Hans de Goede <hansg@kernel.org>

This is a useful and beautiful helper library, approved.
This makes it simple and clear what is going on.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Small nitpicks you can fix or ignore:

> +#define ADC_BAT_HELPER_MOV_AVG_WINDOW                          8

_SIZE

> +struct adc_battery_helper {
> +       struct power_supply *psy;
> +       struct delayed_work work;
> +       struct mutex lock;
> +       adc_battery_helper_get_func get_voltage_and_current_now;
> +       int ocv_uv[ADC_BAT_HELPER_MOV_AVG_WINDOW];              /* micro-=
volt */
> +       int intern_res_mohm[ADC_BAT_HELPER_MOV_AVG_WINDOW];     /* milli-=
ohm */
> +       int poll_count;
> +       int ocv_avg_index;
> +       int ocv_avg_uv;                                         /* micro-=
volt */
> +       int intern_res_poll_count;
> +       int intern_res_avg_index;
> +       int intern_res_avg_mohm;                                /* milli-=
ohm */
> +       int volt_uv;                                            /* micro-=
volt */
> +       int curr_ua;                                            /* micro-=
ampere */

The units are pretty evident from the name I think but if you like it
this way that is fine.

> +       int capacity;                                           /* procen=
t */

percent

Yours,
Linus Walleij

