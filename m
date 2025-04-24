Return-Path: <linux-pm+bounces-26066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA35A99F2A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 05:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E247A469D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC661A0BFD;
	Thu, 24 Apr 2025 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkETZOR+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5DF17BB0D;
	Thu, 24 Apr 2025 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463802; cv=none; b=gLdsgxkSo5XAs8qTTeVev9ppOX2vYx3KwvTz8oib2tQ67v9d5fxI1fL2Mfz7Io9myZzAeSfpsIkun9ftBjRHuaOcmx7IDFfmJJ1CiEsnT6BcQHnNlut4+wPe2X7OSapKE9VaVsHiO3gMg9FSmEk47LUkHxqnC7Le++XPEZmRVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463802; c=relaxed/simple;
	bh=VJgVkYspiLr69iy7tyKuhkRGOkGOu7zIaIZdJSWEPzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHG9FNW75s2gttTOsJvAacwVfMAsC/HNKt7RHX5XGq0zqYcchWMuS/2kGxHuNHeMRDptb1GXYtR/aWXtHHyhqaPVq/eCObm/1Pkw8jYF6Ool/yeY+dieYA5SQOPbixLHmxwHFD4XPkJjYG23hWQrQpgrNK0K4VERiWjQfa5Bh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkETZOR+; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-3106217268dso5596681fa.1;
        Wed, 23 Apr 2025 20:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745463799; x=1746068599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJgVkYspiLr69iy7tyKuhkRGOkGOu7zIaIZdJSWEPzk=;
        b=CkETZOR+4L7oH3fwYFbIwjBT2M6wwRgFyzc+rUwF9FVIiG4KXPXOJ73UKSxW09CZwJ
         mxIlqxetgC4GFbEkm8aZK9TEgwfajB4OFK/6v5USly/JvqLJSMoRYt1s2h4Lu0DT3O/x
         +oU9G+DMb8HJU24fSolyAbVIC0ew5km3FkKDsjclYaEDbaJ+59aLBAx0CmwnkC8qLk8Z
         5Cwc4HcrzaS2izXd0nceubioLmXhDvqmJZYXrWb9aHa2xMKo/SGP05+AgtfPqiDWDGKi
         Zmw2ykaC1yEBDQ563K4OldrFI1llr8X8wWlaJSIi1a2PuAyj4DXVuMNnYUMY7bFB8UPn
         TKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745463799; x=1746068599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJgVkYspiLr69iy7tyKuhkRGOkGOu7zIaIZdJSWEPzk=;
        b=YFIyypFYbeZTXKR+ft167vruWvh0iXMbPivMRrxI6+tmHtUh+eit5U2HdKFmSHjjdj
         deu/U4RuafMCcLL5GWW8r4984DZaUGO17LnirIJ7hvJ7NKUUpL4NinDXJI6HOWxy33gO
         /LH2SwJ0SRuEZXpPkBMO/WMRTUx/xl06gxyxswYalnXSWg9fvLxHpTbuKISD1kf9u+z1
         XtvcUdLClg9KBimpbTuvNcczSRLV4ljppBBIM/S8yzevEWm+x9ZOKyp5I6be0Anp1Xia
         4BRuyRQHEEgAV4LhaBpPCWEY3aAtoBWwL1NHGVo3NMJw0gcMCyIuLm7GSRF0leiAvJtf
         5psg==
X-Forwarded-Encrypted: i=1; AJvYcCUaK2CXTOiXcZhY1BFW21mSX5uRG+bBUd18XzGl2Cq8/OVhL9pngHKTOoWcxI1//FDDiHsOfmi48YKVH3A=@vger.kernel.org, AJvYcCVLYp0iWN9AIdh/VzvW3fiOvO4+9gAlEH986WeBbLp13kalkn4nR/zEVRki3JyKtVA7bUdW4YofXgo=@vger.kernel.org, AJvYcCWLniRpCSvQ3RJT/GXYWVfO1B3JKY2v8Lhjf8NB0t67yqAmMgR2r0Mzv7I99lqE/nFJz2wf3Z/vsdwKSMNCzwqlKrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4Zu3NnPKjJArIVgbXfp2S/FkvPBSxJWjvRkIdcMWe1sbMOHR
	OLHCcwIJCeBFwcm8xNRnLOh/9XWLlZedFI8UDE2IDgUOilLSeQPEcbVwBtAIx4weN1WJ9B9kDD8
	zt+G1qQpn4e67M75T26/oqFa/L6w=
X-Gm-Gg: ASbGncvFasYeW77NbV5+Na53j3NBWnKo1rjBxVCkVqFGQbVNDOaLLBI3xW7gAt46r3R
	aGYHwVbmi19epBhrn9w+pqcsnFIl9YHoa8E+9eYDjlxHE627RyTOtvYJFpw4QliDWJpfwqrfeJA
	9pC7tTadO+1vdQEUGJ/cv3zA==
X-Google-Smtp-Source: AGHT+IHEFdU6AkUjEDsg9os0FKyDTupZOXaV8Eg0JIYI3IbQ+wKen8hrgMsyt3fgQt+8e2hv23seZ7XdRIJjTGcx9NQ=
X-Received: by 2002:a05:651c:1549:b0:30b:b956:53c2 with SMTP id
 38308e7fff4ca-3179e9ee6c1mr3610421fa.11.1745463798645; Wed, 23 Apr 2025
 20:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401104518.25391-1-bsdhenrymartin@gmail.com> <f59af2ac-a7a2-4490-8858-30c7f98e4149@kernel.org>
In-Reply-To: <f59af2ac-a7a2-4490-8858-30c7f98e4149@kernel.org>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Thu, 24 Apr 2025 11:03:09 +0800
X-Gm-Features: ATxdqUFi3ltLX0JNZInCro5GgmN0f5TCi8PDuD-PAPOj1o31dYGRRL_n0J8qIWI
Message-ID: <CAEnQdOowa1LJbe7Uj4yR+r=NSysyTbagpvbfR0toc=BBk-UaTg@mail.gmail.com>
Subject: Re: [PATCH v2] backlight: pm8941: Add NULL check in exynos_generic_icc_probe()
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: georgi.djakov@linaro.org, s.nawrocki@samsung.com, a.swigon@samsung.com, 
	alim.akhtar@samsung.com, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Just a friendly reminder about the patch below which received your Reviewed=
-by
tag but hasn't been applied yet. Could you let me know if there are any fur=
ther
actions needed?

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B44=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=BA=8C 19:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On 01/04/2025 12:45, Henry Martin wrote:
> > devm_kasprintf() returns NULL when memory allocation fails. Currently,
> > exynos_generic_icc_probe() does not check for this case, which results
> > in a NULL pointer dereference.
> >
> > Add NULL check after devm_kasprintf() to prevent this issue.
> >
> > Fixes: 2f95b9d5cf0b ("interconnect: Add generic interconnect driver for=
 Exynos SoCs")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

