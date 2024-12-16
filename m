Return-Path: <linux-pm+bounces-19297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C19F2E34
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 11:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FBE1887278
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 10:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A9203711;
	Mon, 16 Dec 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpHF1bso"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FED203703
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345226; cv=none; b=Y+4TKkeD2sH60PL+/IY4naZWQhE62CweiKgd5KPLG+JgJXFb2abRAdGrxAFVb13k/AfzQwxe68s4k1OZ4Az3YWyb+kUGFd1VBCkr5UBA1DPh/rzEN5Nt4baArdbOVDwTfDraxrNuUvIaw65SNRIriI+2nZTb3WsK13Gtsq2eqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345226; c=relaxed/simple;
	bh=PYwh9Ejzktqnk/4b3X6HTET4UjWYpwtQYwse3ElACjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPFDxoi4bjim9AxE8SpnTba2lxvnayBPCgWkQCpa9xjiVF2/4J4zmzd1WXnmTQEFMsqjI6+5kgPkdVC3ua2+CHFEEY6FGFfglQdDJE4mYEkjj22D/XxObPOIKkGI8ILXZ/s+6a0A/72R5nJoOBGTIsfpl1TEjxJkAY9DPoiobRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpHF1bso; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so42955291fa.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 02:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734345221; x=1734950021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81rR1eTM9HElymQ2hIkXvkfh84mtbQHR8oN+z/vprns=;
        b=dpHF1bsoXY5M3b7MlnEpOGGHghGom+pSsXU1kbrqQrbtRIs8cx1uhnSzks/KNBTRHJ
         DDh91QvjfyewUjLrjskEBJ1MnZb4EWytNTwFvF4ODS+gBeWYtv5f6ftxVKezxH8bfUxr
         YwSSlNMwi+ALqQRPr5fvgsaZqy/faIRKD0R7AXaJrYOii8bd2oIPpIsA57IDTmvJjAV6
         X2Edqs0XGJwYI9T137tVGg+7dXjgn0dccJ+iscBzpZHBVLieHIvhQ1uxRb7jEvLX4xQ9
         bXpsY8++GJ/vOCrO8STHTESfFnmuiZYksPnnwJz6E0lyh9iKp6Lh2y3MC2ArjmDHftQ2
         oZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734345221; x=1734950021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81rR1eTM9HElymQ2hIkXvkfh84mtbQHR8oN+z/vprns=;
        b=rS5g7gOzjRWgK+5Ys0AemY772v/z3t4I0KzWMD4y8VhegkkhGpwcKAkgvP5nYicGSE
         OrAYRUSC5EY2KsuaROz26p4nVU/ettKmvt91OqeLQcvlL+9l8HqorYN+Q2oIU5PePBrh
         lXNlaOYrPuiABjLub9hdn0z+C4G7abQgmuTFpVZNbX29QYEMp1Ne0lYR1H4zcOZlcQwl
         bUa2+C7wZ4hFPFHELNT/x0tAfjTR4ZObTpnELO3YJE8k44YVKwlzJLFYxTa5G6FBZx2m
         nAw99kua93gG2OCV6FBdhurPmkawui9CNr1qukrVbQc2h0GzRnCk7GF6+QDCfxPNhLdE
         Kf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaUCzWKPlTJAFoKtdOAJ3I3dR7IWkUqBhnBqGLJlu6XlUcskAzfWkTHSk+4FHQUbKuGTmG4BJFsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpxsWoZMRombxlWLGVFrhh0zp2h0lKpH+SdNmBihOx4CotVjy
	ovrSm8c8G1C0QX0AHyJD3CZvmeeY9+6afror6LBn0d7JSt5WuSuFU75lHvlX2SctfvXsD9JUM1t
	mpiPOBtTrdmlOklW+Kx2ZYoyli12DvtiQKzYCfw==
X-Gm-Gg: ASbGncuBvvoximG2nCSjjWxkLAHqJ9Fk05Sbu1hJNRAxrpJLqDNXdM0qJpeywPELa8x
	d9d96Dncx1rzzK0s3S53ELSrjkLsrK3N2As8Y
X-Google-Smtp-Source: AGHT+IEUf3iLQlaHwj+huKVEu7Rf6ZfMRHEmd0RkbAiajFtXRNVDdgnZzJS2Enw8KLsa6+/B9ivQKuoEjmBWCEUg1Qo=
X-Received: by 2002:a05:6512:230b:b0:540:3561:969d with SMTP id
 2adb3069b0e04-54099b7188fmr3706580e87.49.1734345221514; Mon, 16 Dec 2024
 02:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2024 11:33:30 +0100
Message-ID: <CACRpkdZ-ZEiGMUPObHU=kw=OUADrRGtxgMc-QC3EaBevp-Shng@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] Add MSM8917/PM8937/Redmi 5A
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Dang Huynh <danct12@riseup.net>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
(...)
>       dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
(...)
>       pinctrl: qcom: Add MSM8917 tlmm pinctrl driver

Is it possible for me to apply these two patches in isolation?

I want to make sure the patches get moving.

Yours,
Linus Walleij

