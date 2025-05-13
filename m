Return-Path: <linux-pm+bounces-27096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0749AB5D8C
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 22:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8723A6B1E
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA32BF3FE;
	Tue, 13 May 2025 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKLYzYmV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112151CD0C;
	Tue, 13 May 2025 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747167079; cv=none; b=BGG2YmzQez497e1m4Y3TFZAswYa/vo1qxu9NTgNiVYNLciVd20K7KjBLJCWiJZhkmzhlEytALj6gwij/hZasp7Jd68YZuvV2+OYJ/jVUD2JLBNuThb9qFsQ4B5m+W2e6c++0EF9cEVwEk7fMO8yj60eeY2ABdS8/Xoeb5eBYYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747167079; c=relaxed/simple;
	bh=gjUgppDr+4DpgDh8u28iizTAHW2k0i9Nc6jDwMykpqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7aRhtiNJZwRz/mcu+qsYcfQJW1cQZ71TWF+OB/ZwpHBt4w6vkKXOhcWXA54jg+LLcnueX9FI68BW1vLtUwISvy1Jas/0M8MtbJU1lkQClgxr5Ud0VQg0tmGGJdyfBjbMfbrueqKkT0Ej1Mbsv0LaxCHjYXuNmLlaUQEh9jPeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKLYzYmV; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f54bba3e54so62327776d6.0;
        Tue, 13 May 2025 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747167075; x=1747771875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tF5j1rQdmb4dVKBXTK19MRRgnhCEFWZEWB8e/76g+FA=;
        b=kKLYzYmVCOejjygbEGD/6oJfWSqsvI66MELBgjMyQ07CiLwSRT6WVO6TVYywvS0lWv
         EzAqUNO86z4OwSok3zEdsHZCsmzLLlTOYMWKc+IZMqqqsqt7Isq0ywofYBPPQcMTdErq
         cggJeMKT/PKrusQGrmg4sPpZlTutU/D1PMThjndduHeBk3pINV+RbJN2w6IzkLxhdysc
         /YS98zgIr+Zd+4w1a6aAvD1/hRxti4oixgWaPnj1/FB2DxS6DKBW/Anqv5+2SN9Pu2/J
         kT7tWZVYVVf9XEYkWEvMGA6Q7DAZZUibwVVipzrr1RMC+600X+ND4t02w++BYzQ9jrUf
         TPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747167075; x=1747771875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tF5j1rQdmb4dVKBXTK19MRRgnhCEFWZEWB8e/76g+FA=;
        b=HeZvFxfGF14Z//6ng7xLS2Yabfx429cjL+OnuKMsLfvN1tVbWOgOeO1KPwlRWA/J2f
         kpUxPQKxffOPjCS2ewrTLEP4jy/OMpJWfzHZdPISq76WbfsOfrV/uulHPp2zzLp7M856
         EVZA+bLqTIl9/DqQTIO0Z6Bvb3vAuZXP5ufCFX1ChkV2K4z7vuKJOJ9nWN9lwMdh5P2L
         lfBELZXRTePjrPoduDkyd9yM/b429RE3fTrdJfLwFj2tYRz3jGWJbHhTcfVao1pnwoog
         xTYPYWE4dO02InXahrtIELwQgGt0Arz4ZCdQTfhEM1fGT2htw4+FVUMchOsfXWx4er/D
         dkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnG31Mr8wOK/2ViCoJR03yX6kpGLZcD/Qse8pONX/z+mNQeyAGrjaMkDtOrdhyR+T5ZoLVwEu4io8=@vger.kernel.org, AJvYcCWoS+tqJ1pNRHNMWMta2vdO2pEOfpgrvrKWy+Sa7QbMOG5s7OM2S1b2einOlt80V97omxxZj14SZZMT@vger.kernel.org, AJvYcCXlQjja093/l3DNH7QvunuqkIcblStJ+gWF7pX5sXKUivxaszwChAuf5h47WiL1pDCZ4ZCumiRsRcg+D0MS@vger.kernel.org
X-Gm-Message-State: AOJu0YwA11H14eoHrvyjg4zdsoI8BS7S+KwAlZ4updBk3j+lsEeV5J3v
	jnhaJa0Ao+IfNtJTpD3zq5s/sJPWKHQMLb3n19iHDlRm3Y8Fby9M8iMWiKIh6zFjDVCkHUPIxU1
	bFq3I8kW0Wgm3LNrq14Zdp1wT7R4=
X-Gm-Gg: ASbGncsniEw8gWInTOz5ur0/ix2B8ChRgdb/klVBmV/p87HK7wKpD8HQWJ5GZQ7NjZL
	FRI0pv4/1STVmOIq57y1ZkQgB9jSNCpPaLMQdLzpJZijqTyBOkosgEpeXXZKy+B8hIG7HHlS7rB
	NwuGQnj0keD0iPDsX+t0zQ9Xe7+DmS5Ho=
X-Google-Smtp-Source: AGHT+IFAXj8ieeEB8HV91rcVj1ko9QjNssRLChXSoKZxjbSN4sXJhngxOyj6TOZMni4KsqSfr7eK6jqZHoNRu9CLwvQ=
X-Received: by 2002:a05:6214:519b:b0:6e6:6c39:cb71 with SMTP id
 6a1803df08f44-6f896ef6c59mr11442306d6.45.1747167074815; Tue, 13 May 2025
 13:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510172509.2547273-1-ansuelsmth@gmail.com>
 <20250510172509.2547273-2-ansuelsmth@gmail.com> <084240c5-48aa-406a-9bbe-2f349f9c2509@oracle.com>
In-Reply-To: <084240c5-48aa-406a-9bbe-2f349f9c2509@oracle.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Tue, 13 May 2025 22:11:03 +0200
X-Gm-Features: AX0GCFvqn1cVWBQbmoNskROEKnfBH2QCcLULy5fheXZiMdztNaMOcmZyFMrn8EU
Message-ID: <CA+_ehUy+WSzRre+64KxeJKtOb_Et8HO=oMV+fNrGF5HHLzh3MA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] thermal: Add support for Airoha EN7581 thermal sensor
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 13 mag 2025 alle ore 21:50 ALOK TIWARI
<alok.a.tiwari@oracle.com> ha scritto:
>
> > + * the same addr is used for ADC volt and valid reading.
> > + * In such case, VALID ADDR is used and volt addr is ignored.
> > + */
> > +#define   EN7581_RD_CTRL_DIFF                        BIT(0)
> > +#define EN7581_TEMPADCVALIDMASK                      0x884
> > +#define   EN7581_ADV_RD_VALID_POLARITY               BIT(5)
> > +#define   EN7581_ADV_RD_VALID_POS            GENMASK(4, 0)
> > +#define EN7581_TEMPADCVOLTAGESHIFT           0x888
> > +#define   EN7581_ADC_VOLTAGE_SHIFT           GENMASK(4, 0)
> > +/*
> > + * Same values for each CTL.
> > + * Can operate in:
> > + * - 1 sample
> > + * - 2 sample and make average of them
> > + * - 4,6,10,16 sample, drop max and min and make avgerage of them
>
> typo avgerage -> average
>
> [...]
> > +}
> > +
> > +static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
> > +{
> > +     /* Set measure mode */
> > +     writel(FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4),
> > +            priv->base + EN7581_TEMPMSRCTL0);
> > +
> > +     /*
> > +      * Configure ADC valid reading addr
> > +      * The AHB temp monitor system doesn't have direct access to the
> > +      * thermal sensor. It does instead work by providing all kind of
> > +      * address to configure how to access and setup an ADC for the
> > +      * sensor. EN7581 supports only one sensor hence the
> > +      * implementation is greatly simplified but the AHB supports
> > +      * up to 4 different sensor from the same ADC that can be
>
> "all kind of address" ->  "various addresses"
> 4 different sensor -> 4 different sensors
>
> > +      * switched by tuning the ADC mux or wiriting address.
>
> typo wiriting -> writing
>
> > +      *
> > +      * We set valid instead of volt as we don't enable valid/volt
> > +      * split reading and AHB read valid addr in such case.
> > +      */
> > +     writel(priv->scu_adc_res.start + EN7581_DOUT_TADC,
> > +            priv->base + EN7581_TEMPADCVALIDADDR);
> > +
>

Thanks a lot for the spelling check. I can send a follow-up or resend this...

Don't know what Daniel prefers.

