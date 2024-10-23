Return-Path: <linux-pm+bounces-16285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24669AC75D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F56283568
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2DC1A0724;
	Wed, 23 Oct 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zef9Zx+E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AB19F49F
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677990; cv=none; b=VY0FgWCQLtADhcDw3zRqOQqtX2sGtq45Cta9LbThgxlEvzs+YMZWvdX7PbwwAFJf6bzO20K1dd3dVYq6ZsBqEJJE5yH0sHkQ9hihgphqFUNQZgOdUy/1MzlJPqhrJrM35ecqiomjTzxoXwG2BMFr+u7ezyChj9Q4nq5MdPapbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677990; c=relaxed/simple;
	bh=a95S/TCmJUb9zAzOT/Z7FGsQTjMV4ZgF2D4dSS7l1HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCiqCr5oXWHeTsk+UtHxtB3XJdmUFh5gjIkfbFmTuVpJYj1YyIqBgHjsg4KRIJnLhHEr190GVw4aMthH6hqNhdZwE3WXMMJhdwHU/fAD1kjhLI+ndMGCSXiSamJcxLkRhVcRhb3RVOEVpnOgYCXtdDmPF/DDFKVUqlVf+CnZMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zef9Zx+E; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e314136467so7054667b3.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729677987; x=1730282787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a95S/TCmJUb9zAzOT/Z7FGsQTjMV4ZgF2D4dSS7l1HM=;
        b=zef9Zx+EJUg5vR9H9/bgYEaqvY7drLABxWeW5rTOHVsvhb8RnyKzIBFL3+kkHMgmF/
         2Gs+9vUWmPAs3TWwQFtw7AmD1IWf4f9mwzZGENb/VspLPo/6vcxjE1aLTHIK5qsG/vVQ
         B7mJZVBSkpqDkUFWPy83mrE0rGHSmAJOKsKuRt5BrTxT2XJs4Tp/cJZnMeFPLlYoJaPu
         uxm5lahZvUknt8Ng689mtgFUsohbkYN4ZFo5AijgPJQlK4f7m53rR8ndk4f66u5j0VZt
         CBnUepMiaEU3L6whdD02F98S508+VmPItJ19xXHNM9EZMqfyncUP3UUEmwEGrqyB2aMZ
         bIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677987; x=1730282787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a95S/TCmJUb9zAzOT/Z7FGsQTjMV4ZgF2D4dSS7l1HM=;
        b=AWD/Z07ZCYl6Ea0xqq5spRM2XVXhNPNKAbsUbSmWi7mFyZ+A8INX3DECX5zabfyRXv
         +uVGa5sTtnBfs8GuvyOWw6VDBQeI5hVfz6+GMlWqszhB1zWJLJDthNLNHJjSrMTq7DTq
         rXhZtSR2tmqxn81xDPEbjo449XUE4aDyg/1roL30esdvcRBVe0HJFlRdHDcgjzMEfESR
         o4/gzo8oqQSNXOAK7agHeoua+Ho1bsgz3rJQCJsqSlYm4ECVpFvlGTwjKcZyGja6fW9d
         Wezs7JktOpcBwDh+tiLt2U5NEO0gXeu8JhSUrkzFdUJ+vOiR9i9+d746MvThLl7U+SXh
         /VzA==
X-Forwarded-Encrypted: i=1; AJvYcCWc7LI1MHXdcSQ5y0a1iOJsg5hTn4SJuXPUXE8Mx8b7MmDAUQeH3BUon/47GLeasKjCY5pHFPXBUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy21w8g2gie2hrcxjmkHCPUkNdvZclRpj+2yo8SffQR2ctffKQZ
	6Fbv+IOgNXpjXgSn4OxOHOtmdWPsy9veNU+ZHUtI9o+vGa5QCb8Bt9OZWr9Oi41fXW5lUKWgit4
	xuPtaPJyf/Aa7uybejYEDYiMEPQIwpeVRM2rRCg==
X-Google-Smtp-Source: AGHT+IFwOZBv/9xV3wiaI1U67V6VvBJcsk2sGD6YUBFHxuleavk/W9fHcm2zNaYIQVNokSq8zuqqKdyHygLlMwbU20o=
X-Received: by 2002:a05:690c:fc7:b0:6e2:b262:bebc with SMTP id
 00721157ae682-6e7f060d560mr19960777b3.0.1729677987373; Wed, 23 Oct 2024
 03:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
In-Reply-To: <20241022154508.63563-1-sebastian.reichel@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Oct 2024 12:05:51 +0200
Message-ID: <CAPDyKFoAv1jeQitHmTMhvwG9vGzN-vLby0fPzkX1E6+-Qe2dog@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
To: Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 17:45, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> driver is loaded late after booting. The crash starts with the following
> shortened error print:
>
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'gpu', val=0
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to get ack on domain 'gpu', val=0xa9fff
> SError Interrupt on CPU4, code 0x00000000be000411 -- SError
>
> This series first does some cleanups in the Rockchip power domain
> driver and changes the driver, so that it no longer tries to continue
> when it fails to enable a domain. This gets rid of the SError interrupt
> and long backtraces. But the kernel still hangs when it fails to enable
> a power domain. I have not done further analysis to check if that can
> be avoided.
>
> Last but not least this provides a fix for the GPU power domain failing
> to get enabled - after some testing from my side it seems to require the
> GPU voltage supply to be enabled.
>
> This series is now based on the pull request from Mark Brown:
> https://lore.kernel.org/linux-pm/ZvsVfQ1fuSVZpF6A@finisterre.sirena.org.uk/
>
> I added one more patch, which adds devm_of_regulator_get without the
> _optional suffix, since that is more sensible for the Rockchip usecase.
> Longer explanation can be seen in patch 6, which adds the handling to
> the Rockchip driver. My merge suggestion would be that Mark adds the
> regulator patch on top of the immutable branch and creates a new pull
> request.

The merge strategy seems reasonable to me. But I am fine with that
whatever works for Mark.

[...]

Kind regards
Uffe

