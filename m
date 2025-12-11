Return-Path: <linux-pm+bounces-39429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB67CB5ABF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 12:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED25300B981
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C622FFDCA;
	Thu, 11 Dec 2025 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUiEWFPh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416C2DA743
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453346; cv=none; b=ioNRFZfQCzRRjqxxO+NCjjVkD5CbkLPixvjchmq+SDhxCmazG7y3/sWvb+xmafbVpWd2an7nIRckR+VLjYk6si0rSzlyXfAd7d94LToUeIl2O9a9WqoXuTknEUbE3D6jwIqNQasDF/ILdqJuBEtSvwILVc10hgChY8GPNGnCe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453346; c=relaxed/simple;
	bh=X4W6VdSJMZDWzU5q7/taH9//HBgenfsjSIz1HlAy/OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeTLZII+nje/v3HVGMH33ZRhpOshFdQ448VCneEJdrk6ZNwdwY12JTOvh7mux5ttwgCO+SVKr1jguFAduEOBQjmKoiRCXRWj8PPdmrdxItj5I3dyhUe7BRdiMb8yEA2B8HpyX2YIWR1LpxQdjIhVkFKu6zFaEPdxSHMBdZDd5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUiEWFPh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78ab03c30ceso7287117b3.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 03:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765453343; x=1766058143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9IFdfWdLJAyjd1BcVLsmGOyCGVUW8Zr+SeuVuiATEpo=;
        b=AUiEWFPhpgIp32G0GaHPKgJ3ZtQBBe1SSh2CjTC/5OhzyuVCC4yorQ0qbFmcmsuM4y
         PHXXjAxWmZaHel7DUgERW9iImMNXc9Wrh6ju04kBlead8GDNaNkBRzmYaF2s+Nws/frs
         8wLQ9O/DD4Sosd0T9nIqFxap/o/mBPRMLyZOh4jPtDaMzNHE00Q2RIoptjy50i4oMgLb
         X5YFtxpoqzsIDeQenNPi4YnVWvrXWB8b43yyRGSszY1V+2ekuifPpQBy5ziQJKEjPuMp
         fZGGfRHI1ZEbGleDgTGv9pHCvKVPdhHCopL2VYs4gZ164SOiDfaQjNFDgkFjdMTTmtZX
         MF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765453343; x=1766058143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IFdfWdLJAyjd1BcVLsmGOyCGVUW8Zr+SeuVuiATEpo=;
        b=gpPWxrdi+d6amGcHvczb5gvBUsR1N+3AYXxkmKiBFgnY49DoEcjh2UV3nJTavBo9+M
         EwZ5nXZPgwDNThX6xWSho8WDuIB5wg7pzvdMt4bDSvmiCoMyvcYSMPYI6QhINkctNc6P
         Kw/lQsTkUoYg8Eu6qnEz2g0nIz8D8E+xPGx+748yuR/Bfa936jDYMebEMiX+NRg8RQU2
         DOVJZnhKo93dv3BNJC9UQlgVwZ39cG68GVVdkVzePdvKDw27bfPDrofhVYHBJ8FBLMU3
         XF2OqhVzI0TYEvcFzeVVvgg2pptYWGtzxmmyra1h7Mw73ZU3TLDIZr9yv4FnGo8Vd2s4
         5Pzw==
X-Forwarded-Encrypted: i=1; AJvYcCUEp4sxeUbm/QnkB3idBrIKpIp/oEgBKa26e6a0zJbXFVcLvkxmyfZXiiQ9SD6kxDzlG6BCMOmotg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EZd5X1FiuRPWMzUbDMuXs5z52ApRV4dZLJqR92oEudTqW+rh
	87n2eOEFTZMBHDQfCs3mVdK5N5tNmPGLyRhMHwgzNaRBIUq6r6vsJ1HLYrgSM627A+9Rqi6nLQo
	acW5D86ZR220QKi1qA5Ejpss9Wj7pd0FUF0C7VOqG5g==
X-Gm-Gg: AY/fxX5cy8RXg3TDRYifaH91E4I+5RTDYQh6qVSp2pG/qmToZrYiwZCInqqT5oHEXGV
	jy7YGrPfbpkdFGypqvcbqUrjEklgN8ZeVtaQoxVmzxZGAHWNRC0TydMcm/rXSU+aqCSaJCWXCDx
	wnC+ahvuFa7qaTecTI55uW0zYKyUsOIBNoGRUGnRNFIiicY18Xqfp82EcXCbgDcSSKNJ2mqq+6E
	lI8Z1Aip4GjNiW9a5b9r1qTo7QfJKobISAw9Bzf/+F5TjEb4Ja+mptyGUsV+OzTS0280ZmA
X-Google-Smtp-Source: AGHT+IEoYIRkikxEWVC+siA1pF45o1MKKPPvk1VzFP0SFtR3L38NqSQi2qStQv6qtu1IQS3nOgNj9UtKBKUj4gYRHDE=
X-Received: by 2002:a05:690c:23c2:b0:78c:68f3:1abf with SMTP id
 00721157ae682-78ca640dd42mr51225907b3.66.1765453343352; Thu, 11 Dec 2025
 03:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
In-Reply-To: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 12:41:47 +0100
X-Gm-Features: AQt7F2qfbZ_yXjZRaxadymjtJdZWFf0EdSmG6EOOmg6lb1RRoJS4liOjZFEQ6Q4
Message-ID: <CAPDyKFpCZyseq2XiQLfL+zHWjYZpS-4Wo56=W5AkBpdhajJxrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pmdomain: qcom: sort out RPM power domain indices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 02:52, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> - Switch platforms to using bindings for RPM power domains controller
>   where compatible
>
> - Drop now-unused binding indices for RPM platforms.
>
> Two last patch depend on first two patches and either should be merged
> through the same tee, should be merged with the help of the immutable
> branch or just merged in the next release.

As soon as a couple of related changes [1] that are taken care of by
Bjorn, has reached an 6.19-rc[n], I can pick the complete series and
share it via an immutable branch. Let me know if you prefer another
route.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/176499396490.224243.15580177530806530343.b4-ty@kernel.org/



>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rebased on linux-next, dropping merged patches.
> - Split RPMh bindings patch to separate series.
> - Link to v1: https://lore.kernel.org/r/20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com
>
> ---
> Dmitry Baryshkov (3):
>       arm64: dts: qcom: dts: switch to RPMPD_* indices
>       ARM: dts: qcom: dts: switch to RPMPD_* indices
>       dt-bindings: power: qcom-rpmpd: drop compatibility defines
>
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi |  4 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi    |  8 +--
>  arch/arm64/boot/dts/qcom/msm8917.dtsi    | 10 ++--
>  arch/arm64/boot/dts/qcom/msm8937.dtsi    | 12 ++---
>  arch/arm64/boot/dts/qcom/msm8976.dtsi    |  4 +-
>  arch/arm64/boot/dts/qcom/msm8998.dtsi    | 16 +++---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi     | 16 +++---
>  arch/arm64/boot/dts/qcom/sdm660.dtsi     |  2 +-
>  arch/arm64/boot/dts/qcom/sm6125.dtsi     | 12 ++---
>  include/dt-bindings/power/qcom-rpmpd.h   | 88 --------------------------------
>  10 files changed, 42 insertions(+), 130 deletions(-)
> ---
> base-commit: 008d3547aae5bc86fac3eda317489169c3fda112
> change-id: 20250717-rework-rpmhpd-rpmpd-13352a10cbd5
>
> Best regards,
> --
> With best wishes
> Dmitry
>

