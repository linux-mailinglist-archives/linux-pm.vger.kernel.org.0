Return-Path: <linux-pm+bounces-14919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E9989B9F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483BF1F211DB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916A17A924;
	Mon, 30 Sep 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZ93GS0B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86011176AC8
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681620; cv=none; b=t1vtwuBkVkidQgh1hIcLKanUcZLyQz1PmtgrqBBEcsrDzKN8xwT0QrwmiQOIgTqAIP2lfFoCMfySVRO34r/MF6Jw9dUAcVM2zfaABVZRyu/D6eZhI/DUvevDo4y3jIsk+04lZSD/xdGjrY+XypWu3KtBym7UVzEjgYRBJC6fOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681620; c=relaxed/simple;
	bh=P7Uo+EtmFtLIczihn/B0DVex/aCRuBuU1akWzDHLmoY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I2N5Ne/mEhZluz/nqeXYONx1QwSghoTgX6PzfzB0xfEqL3R22YBVLwU7xGueO5RROb3/oQEY/WNBTVrE+Hawlbh/IJ3t2fAVqHI5j8ylanLJSyA0LfuEdC/gaLpbH+qQ2ccV5MB1Mhx3n3lPaxXEXyrSr22fYPx5I20/9eQYgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZ93GS0B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cafda818aso38690665e9.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 00:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727681617; x=1728286417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge67RKvyAjwxvFyFHbHP8Cjfyu4HRjQ4k8rzGZeOScU=;
        b=WZ93GS0BUY9NBuDiSdOsxUWu9yAtKr3U7qnpQlxEfwHcpnhlh8sOiNKz1fGaskV5WK
         YeAuzgAo/F7znctcWPTmtScDEAR8cubQlOcoXNQTY9+S1ZtCOogBMSrhvKGfgFUAj8XK
         Rm5G/JrDt7R+GGYCC3IZdUJdcn++1qH4KjlP9hDPE6VDJ68Dmu3LFzf7uwsjmaWrhz2j
         DkPPeM66MTHiV7Bv+WkTdNqdq70IuQBJPD/IxwKEz/GR3MuWuiN5KhWWNQIRs/DS5mEU
         oDr6Y4QpytjKEQ4ZrXkhM9UVvIHnba0/gUvAuzqFyeFNZTIznx9lI8keO8RdBFCY8stV
         Qbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727681617; x=1728286417;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge67RKvyAjwxvFyFHbHP8Cjfyu4HRjQ4k8rzGZeOScU=;
        b=DIaoezjY52N7HeNk4bzh1A04uclLsWHh+J1nwYdX5NGhsI7BkJqKLfm/3iXAC5Y+T3
         QsB8ynr1xYkb+hWCN65K5mm2jlzSPpRT1vPtKBhbrEq6EJ77FT5z7vPLhXIb4gnvJ8yo
         ohUjmd4jHIoLUvI+gLvhBpw+2dT2c1rdzdK98glGcvgDP+q47LRYlPqdT7eVsXi2u0HR
         FtXOF0w5+KhECpKtmEy4I/hwgMnOU2ewFpVlasbhnVgW3OPFiwOlggxzlvi3kSBuqqze
         aMCnAw17HF+/XjpI0ZQ6MOfH/Pq6yUE0Vi6REWZvxAbdKVO3XK1P5/P4qA0DFRpq046F
         So+A==
X-Forwarded-Encrypted: i=1; AJvYcCWA4FISsaS+jacuOB/9ADQkORD4kcMxDInr9+PEoZkKhupzAjURGh+gAuRM2hKz2PShS97SSK2o7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Wt4pW/aZZv9r65M2OMj4PkVtWSySwFVTwHi0wj3fHwA78q7i
	fVwu2WVHWuEeZ8GyN51GmZpHaIhYeAdWlnIc1Ow16k5kg5Lx7jO8jvv8wOHvX1A=
X-Google-Smtp-Source: AGHT+IEILOGstLLqV+dwL8EFZQMfy9IEnSMRvstj3RzZnzCOZfqZUywgp/v+TiHhIJ5gXhKCMQqgWw==
X-Received: by 2002:a05:600c:1e16:b0:42c:b95c:65b7 with SMTP id 5b1f17b1804b1-42f58437692mr89334255e9.8.1727681616959;
        Mon, 30 Sep 2024 00:33:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e90274aa0sm105673295e9.0.2024.09.30.00.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:33:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com, 
 martin.blumenstingl@googlemail.com, glaroque@baylibre.com, 
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
 lukasz.luba@arm.com, b.galvani@gmail.com, mmkurbanov@sberdevices.ru, 
 George Stark <gnstark@salutedevices.com>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@salutedevices.com
In-Reply-To: <20240710223214.2348418-1-gnstark@salutedevices.com>
References: <20240710223214.2348418-1-gnstark@salutedevices.com>
Subject: Re: (subset) [PATCH v2 0/3] amlogic SoC's power-domains fixes
Message-Id: <172768161502.3724702.6653433141402666004.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 09:33:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Thu, 11 Jul 2024 01:32:11 +0300, George Stark wrote:
> Here's some fixes to the bindings and device tree related to Amlogic A1 SoC.
> The SoC provides dedicated power domain for for almost all periphery.
> 
> Changes in v2:
>   dt-bindings: spi: amlogic,a1-spifc: make power-domains required
>     - drop the patch
>   dt-bindings: thermal: amlogic,thermal: add optional power-domains
>     - drop required conditional
>     - rewrite commit message
>   dt-bindings: i2c: amlogic,meson6-i2c: add optional power-domains
>     - add RvB: Neil Armstrong <neil.armstrong@linaro.org>
>     - add RvB: Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>   arm64: dts: meson: a1: bind power domain to temperature sensor
>     - add RvB: Neil Armstrong <neil.armstrong@linaro.org>
>   previous version [1]
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.13/arm64-dt)

[3/3] arm64: dts: meson: a1: bind power domain to temperature sensor
      https://git.kernel.org/amlogic/c/7e3b4f56a76b233a70db09ddaa5e822f7cddf371

These changes has been applied on the intermediate git tree [1].

The v6.13/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


