Return-Path: <linux-pm+bounces-20617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFB6A14F2F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8380166A97
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51F1FECBC;
	Fri, 17 Jan 2025 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0E4lNp3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057341FCFD9;
	Fri, 17 Jan 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117156; cv=none; b=VRvqgN+QNo2N/CzWSDj/er5l/FvAcmIbRO2nhF2QR7Zg++ZCfiVy/183LLnSdnfdJrN72W8hzuLIBr11Fr+QZ8kJb62lqNkSWPhXFzMXPomi1t3N96s9umjpUwVXnitVqvYWWdQuqg7XSIF7eeRKkj7yPpjHpboRC6cksOZGQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117156; c=relaxed/simple;
	bh=mqz26Fh/x9DyhlccpdqVgdCq6zWu6Wh2lg8PYOD69HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F083vP7bCgRAeFCzaottxYa12AjNCnIg5kX/syYCpDYalhg/A1iSykxGNohUjKCVp5OOSlx2TGQKxgS3NFeCkecskq6v4DPYqdLdWbt/cIKj8Y/VgEbByZbAoyqR++riVa3R7EctxbpiuO0HqQ+odM7+zHJ2wBHlW4It2kBpRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0E4lNp3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46c7855df10so35187471cf.3;
        Fri, 17 Jan 2025 04:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737117154; x=1737721954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLrKx2+xTF2aOZo6+sc9CokcMkc+Xyh2+/CzbTrJtIM=;
        b=Y0E4lNp3lofRzKOnvczpXMfXL46BOb9M+uPvfhBsc/7caf6uv/ukyd6T1Min3W5I0/
         saXxLD2HDHFBpu7X/saxwfiu0kDntcdpCzxqSWF9XRKaUFMjsX5PVGD+63EzVV23bUyr
         XwyyzeWtLJ/WE9D9aknesmAchlGhtHoYchGKLgxj3uKuXuMUOWBgJQEDpIbUstgK0X9U
         34IqIc5Fh5qWlXn/Os9DGTiorYtxhR8GVGPvy6/He28J6BI1SxOHs6Io1NlMQZ9Z0reX
         9CmXUVy3pbltCjWNQ13EQmrfHLLn1F1w5fc6l8R7Y0ldMzUqjYIuR3slQaFyIufKL6bz
         l/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117154; x=1737721954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLrKx2+xTF2aOZo6+sc9CokcMkc+Xyh2+/CzbTrJtIM=;
        b=WwYkOy06lay+qwrUXX0lL+OO99eos7/CrqEhLYIuzQDdPI09mADBKTNg2ya4DooUUR
         NiHxTM/KplaJI59SqMi3NC01Tvcx52aaZUScYM2cT22dIfQNPO0pzxx33I5hgqVezswp
         doZIh/IRMUPcVSHswOF7OYZtzey2BZXyhsrum5yuCyctuJvdRRnSo0s1jrIwGdnAUPiJ
         tEcOIe2TT+zm0dcaxTCcnbvIUAMNqNM6F9Q6GD43T9j5idzvjRgCakw2zvmmsA5U+cC+
         snXx7iU5I6CO0P+AGDdif4ka/30s4GVLeR5dDsiLMmvDEhrRBS/tuSiNAyNDwJn7TERg
         gvww==
X-Forwarded-Encrypted: i=1; AJvYcCVgMhQ5ohETzvBviGkoyNTRzMcCN2j76TPJR9gnw1cpT3gDqh7YIMj6AVVI6WOY5QqK5eHnzh7l3KhBEA==@vger.kernel.org, AJvYcCVraLKF9UWO5q9z13xGiJZGgs1Zs40C/YLVjDu7r3Ifa2M4cd1vxq8LzU6xFxYzhE5g6WYyxXtqG0Lp2NI=@vger.kernel.org, AJvYcCWD6O50Xv6Dx5SrL6DagLHLjiHMqmMVs+SLTdn3Hbx/FE2FYNjosNjqfPvIE2AxwLNmaLgSK/IgiNs=@vger.kernel.org, AJvYcCXDyUFTlbXENLcljS/yWwUOCsiYaVBJD8bzb7w4sePVefadxN6DEamCj62oO2QqX8kA2OKoeAQAc/v20u8t@vger.kernel.org, AJvYcCXFWg9PfKiKLQLxxRhN/W9BGSfWlFsLMTskNGC7ORAp6/E+kHvC5KYDfKjZMpuJ/kIEWeA2WygkcuqA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6HK/OegoHCQ84z4UWY1hI0o6HZRK6MnxqbwHOIJljifZRcQs
	nUn6Gc/1v6pK98nCI8UtJci/caXYijAa35ytg79zUGF9S5NNXbbBVQNqqmtwLzZs/5kSLo2AOlk
	msffrW8ckYh0a+HW+jjhM5jEsLjI=
X-Gm-Gg: ASbGncttV7a5jIIxR7IPf9Rgxju1IP5AgvafVW5oRAkFPiLD/92cLeJ6E6edM5hwi0o
	N2686Ya6im074HJ046/q644y8mJuM1g624R197g==
X-Google-Smtp-Source: AGHT+IEasG4GEAwxuDzLs69Bpj/5s6Rpow8aj8W5GZK+iDdDIGfm4eTX2/kOrzCYS7fp5P4fm6nb0+tyWOBNZ6jup48=
X-Received: by 2002:a05:622a:34c:b0:466:86aa:efd9 with SMTP id
 d75a77b69052e-46e12bddab4mr36304111cf.51.1737117153821; Fri, 17 Jan 2025
 04:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
 <20250116-starqltechn_integration_upstream-v15-6-cf229de9f758@gmail.com> <20250117-chubby-convivial-axolotl-29e2df@krzk-bin>
In-Reply-To: <20250117-chubby-convivial-axolotl-29e2df@krzk-bin>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 17 Jan 2025 15:32:23 +0300
X-Gm-Features: AbW1kvbLbvefMNqJ340BulwA83dgy5C9sl4tO4GomasdcM4Jj0ng0uJJF-Nt04g
Message-ID: <CABTCjFBF7C=MOcLgyyQg3FeRF3gVVPASDGBT+ogCTSLs-yQo6w@mail.gmail.com>
Subject: Re: [PATCH v15 6/7] input: max77693: add max77705 haptic support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 17 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 11:01, Krz=
ysztof Kozlowski <krzk@kernel.org>:
>
> On Thu, Jan 16, 2025 at 07:26:08PM +0300, Dzmitry Sankouski wrote:
> >  #define MAX_MAGNITUDE_SHIFT  16
> > @@ -115,6 +116,13 @@ static int max77693_haptic_configure(struct max776=
93_haptic *haptic,
> >                       MAX77693_HAPTIC_PWM_DIVISOR_128);
> >               config_reg =3D MAX77693_HAPTIC_REG_CONFIG2;
> >               break;
> > +     case TYPE_MAX77705:
> > +             value =3D ((haptic->type << MAX77693_CONFIG2_MODE) |
> > +                     (enable << MAX77693_CONFIG2_MEN) |
> > +                     (haptic->mode << MAX77693_CONFIG2_HTYP) |
> > +                     MAX77693_HAPTIC_PWM_DIVISOR_128);
>
> That's the same as previous one, why duplicating?
>

config_reg is different. I don't see any good way to get rid of that duplic=
ation

> > +             config_reg =3D MAX77705_PMIC_REG_MCONFIG;
> > +             break;
> >       case TYPE_MAX77843:
> >               value =3D (haptic->type << MCONFIG_MODE_SHIFT) |
> >                       (enable << MCONFIG_MEN_SHIFT) |
(...)
> >
> >  static const struct platform_device_id max77693_haptic_id[] =3D {
> >       { "max77693-haptic", },
> > +     { "max77705-haptic", },
> >       { "max77843-haptic", },
> >       {},
> >  };
> > @@ -414,6 +426,7 @@ MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
> >
> >  static const struct of_device_id of_max77693_haptic_dt_match[] =3D {
> >       { .compatible =3D "maxim,max77693-haptic", },
> > +     { .compatible =3D "maxim,max77705-haptic", },
>
> So the device looks fully compatible with max77693. Drop this change and
> express compatibility with fallback.
>

The only difference is config_reg.

