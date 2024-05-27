Return-Path: <linux-pm+bounces-8168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5548D0212
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC0328D976
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278915EFC1;
	Mon, 27 May 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9lGSbVd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F815ECE7
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817501; cv=none; b=O9RhyZRSuz2wGF9qok5a4vE185lphILBp7kHD6GGfEDmUFuep9RqoIIDUo1tnsplrontJ7GWgIqN0dWQ756hKsdJ6KmTggDL7f3sGHyVoXcheBK8bm8HvtvSqAEm2W6pbUA9tCh659/mZvy7VEv2aDc3BwNheAmIFsd/9qxbbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817501; c=relaxed/simple;
	bh=fwXZJFB4nkMzHi+97DNTbv/zQhYOdEGJXF+z0FAofVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hscyvFSjjP0r5iWMjVjaNxHNQQsMv4YyrFxEQO9Vv1uVCmByeYvKStOMsylwcFQocINkqXY5t239HwisNd+3ET3DmuiJ9r3nq68ZtFh8NXpMNVdDfB1hIYTuIlDd9NvjvUSa3hTCjmW/a6QPCoOXirMwwP4lw5JFHQLtKP9Z92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e9lGSbVd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35507e3a5deso1739350f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716817497; x=1717422297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOPePvII73dyzyHk15m4pOPTJxMdXeXMFiP5kpq9p44=;
        b=e9lGSbVdDpdFXgNm35duyPuVOM/s1buSjbwUS0K5ZobzfaSjZuLM3Hw2899t4KI3MG
         bq3HSGk/Ohwf12avPGDex6UGjcJIcgKb05oaesFmqiWy3EC3a4zPPayUfAGE7KV0ypJy
         e1hPM+laFVLGmnj53y62u4rJCj1XixGIkwjmyOmpja6880dIQUWnpMCFah/YnFQOVgUg
         fiHx7CS2dM8XjFWEGaFGuYGZp6PKfH0i5fUugxS8AhWDATtQCnKJKN3YXJAnGfp5kXAI
         sbt2cBs88sZAdWNRwbLNHVcZjd1rGLPwJ8+z6c21vI0ic78NiN/Aw7VvrWXxMWZO/bGo
         BP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817497; x=1717422297;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOPePvII73dyzyHk15m4pOPTJxMdXeXMFiP5kpq9p44=;
        b=lbK8qRqv1Hf16biH4r8nw5tIk4LO7oo+1FK4PgmTRIenTqG4mT2MFTfR+2m76KoNlf
         q6dKU/A1zxl4jnZwh8SngghY79cZShRdNRClzTv70qIqt8Up1cjaxrHifQIR9L6yxOva
         2DdJm0o2Vbsu8U61LZp+X4ugqMgn5B0whduSicLVVdnlzcrEHZ17ztWg0pzfoKb3M/u8
         cpLCcXPwCxws/J4/9ALm6QJaANp7oa441qmA9xdn0EEMW/fB/RaYJAT6KOdMFjVqLO6c
         Jcb/qqM/65d51q6nTTjT32Jv+Xj9nZQzTWm81BsUmRxVbKEBrNI95ZHPPlwvYTH+hYDe
         Ravw==
X-Forwarded-Encrypted: i=1; AJvYcCXnsqtVBNyLV5eyjv/6BM+NLovGlVwbJuuW6mbpVP46OXxsBWqJvdAE9B9S2f/csxrUCxXlaBbAm2S6u3ey4LSIer2Uc6q2Qbc=
X-Gm-Message-State: AOJu0YzTl6MV2zxk3Nws0znCIslPbN6qSsA/cp2sF5uDYo6RUINF2C48
	GvCzKvcKqLFevKeX/d6QDiQAJfcz3OisnaYgTaQNXtylotr/D1B0O6i/XAkoYZ0=
X-Google-Smtp-Source: AGHT+IGwS0/nDa3ITAcmca/nsJyVuSykEMrLjJDamCmRirIOzO7crmASNfLCNT5BvQ9XhxFkMcLswA==
X-Received: by 2002:a5d:598a:0:b0:356:4cd7:d3ac with SMTP id ffacd0b85a97d-3564cd7d4eemr7776462f8f.12.1716817496449;
        Mon, 27 May 2024 06:44:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a091051sm9114549f8f.61.2024.05.27.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:44:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: jbrunet@baylibre.com, mturquette@baylibre.com, khilman@baylibre.com, 
 martin.blumenstingl@googlemail.com, glaroque@baylibre.com, 
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
 lukasz.luba@arm.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: kernel@salutedevices.com, rockosov@gmail.com, 
 linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240328192645.20914-1-ddrokosov@salutedevices.com>
References: <20240328192645.20914-1-ddrokosov@salutedevices.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: amlogic: a1: introduce thermal
 setup
Message-Id: <171681749543.2905422.16742406814394221719.b4-ty@linaro.org>
Date: Mon, 27 May 2024 15:44:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Thu, 28 Mar 2024 22:26:34 +0300, Dmitry Rokosov wrote:
> This patch series introduces thermal sensor declaration to the Meson A1
> common dtsi file. It also sets up thermal zones for the AD402 reference
> board. It depends on the series with A1 thermal support at [1].
> 
> Changes v2 since v1 at [2]:
>     - provide Neil RvB for cooling-cells dts patch
>     - purge unnecessary 'amlogic,a1-thermal' fallback
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/3] arm64: dts: amlogic: a1: add cooling-cells for DVFS feature
      https://git.kernel.org/amlogic/c/947bde9069c8241afe401433a6eff276595bb073
[2/3] arm64: dts: amlogic: a1: introduce cpu temperature sensor
      https://git.kernel.org/amlogic/c/049d141161903e656d9475950bb976240802c01c
[3/3] arm64: dts: amlogic: ad402: setup thermal-zones
      https://git.kernel.org/amlogic/c/593ab951232be4779e77f5b1bee0bef4e6fc1022

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


