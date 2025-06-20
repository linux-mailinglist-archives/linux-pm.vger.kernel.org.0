Return-Path: <linux-pm+bounces-29176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C08AE24D6
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 00:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47D13B8CF3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 22:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E038238C16;
	Fri, 20 Jun 2025 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKK7sG80"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BB221DAC;
	Fri, 20 Jun 2025 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457182; cv=none; b=ZFzsswkZfP8mr+TpiKnINyC3X9EAAMX+me6eaLirRIBGpEme4IJcV3SZT4U+7YOmFc4dQMoVlokNw6cxyAJEqJ0vLyymZEJm20QvRbDS7rFnGC2/7/oN+cTVg0bhb+s7Qp4DB0uFqordfq0b+sRA8Kr+QfbuD6Qm1SFjuEreQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457182; c=relaxed/simple;
	bh=H8bLbm8mQ5ONpzCJ5rL6mWTR4959rBNGjMmqbfMAJKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quv9t8fcXRa3cl+T/B0chAKuMEMvK3mZEjaKqVBUG1pNa39UaSvVBlesMc4tFqaS6CQ6wWPXlbcIiwTZq+Vyt2W4w5qrnyDT9kt6RaAuE7O9/AN33RYPKHAgAh+X/yH5Y3ShLjpw8FGt/FdXJBgKRwY4UoH0OP3ab1woA89vpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKK7sG80; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb4e36904bso453607866b.1;
        Fri, 20 Jun 2025 15:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750457179; x=1751061979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nZ5vLwAzsNnnPm1vpVhd40+MzAtASMHps3Kb30tzxE=;
        b=VKK7sG80WDD05slSwWtDQHHyX4BoAoEDC5l5Y+MV5WX2kbsweHhzHmH5Wxbm7SFNlH
         PmpBObpJ3XxrIVcSoH0F6TYLRIHTPD/943oBPyawQEl+KUeY0wlsa4q4glfI+14LupqO
         G1PhWu1M7a48U+V6avLqKjtHfLpJKR9v50Y3Q133G6jOyGi1iUuEcXFWNiXJNtTXGqWV
         uC2gQMTWm0F+PimJDPBSxC46rptGpKJKcG3MHN7x8IRFfPcSS418J2/W1s5FJsBo6bQU
         G38V4HbG6mDpoLEas5zwDgRXtRMMeC3ZfI1KpG+c1GoNBJF+xQK2bYF43GD7HRB6PmwL
         F7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457179; x=1751061979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nZ5vLwAzsNnnPm1vpVhd40+MzAtASMHps3Kb30tzxE=;
        b=i6RyLoB9CTpMzslgo/6/17BjfsuWadCN9eBowN0MeLFF7SoG44Wnp8Njr8FyTIv8J9
         HSDvfuN+IKm9TnhDEIoNTWk+eFwvN2Qqx87V493PmON1KpUUCUQPey+Q0jJiuCygMita
         rEgyq68xyT5tSvxFTX+mMmqjkR1IUS062runLlnSAdge+Ok5XUcWP3UP/V/beNQhx3Xm
         5evhGtt4N++ESglhx3yzbJbej83GB7A0vL/Nu434apX1xvm87cwBeLSspoZ3fmEtdz1Q
         0aHyLa332iL3uaxMMQGRfn8m1931a1jHtITzdwzF51zfWe1xiHnOGP5xRldLTHpWnCBW
         vDoA==
X-Forwarded-Encrypted: i=1; AJvYcCU1eblzd5toEo75zzJjNCSOyGaxbFae7muhiXmynWJpkIIsV4XosWwf9bCr2ktb+EfbGYlD8dlT5Z9k/njfdg==@vger.kernel.org, AJvYcCVUwxRtehTxa/mdOrBm0FH6fvGE0fpcGYAq0+IdVTr3WoTXktNhc98TeTEQ6ZcC5qbVAyoIcBe9Mnxy@vger.kernel.org, AJvYcCW6fY1Mlv2m5yOsHgrGe5A1cqXdwbC7UDlXsvF9G5vnAET8a8K5/bzlOoh/B+VvgzI4aK9aGNmlOEu7MsLx@vger.kernel.org, AJvYcCWyXcw4JoP8h1UIkT2EKyVzGIZgKri6P/lbwn3K3+5/C25M1nhW/hBB31jK9r+YWb6irE/KcJD5hLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyavWSwGOY+mUbeuT2Y7oI9bCgZEAzbOXBGUimim8MZ1byU2sgR
	VRGnj38ZSLuJI9+CQ+2UHk4S6yAUg8IVp/l3oixvIZn9bb6v0tpcP8E=
X-Gm-Gg: ASbGnctPU8a+RclwvOU1PIt9ffvp0kiDRYGHD+DaU6qaM/kuw6BDCrfVqIklZ/xC5dz
	aJhpysU7x/uClOjuuvvE4ArsvzTM/Z1FKU6Cp+akwCK5MlVvr8Wn7wt3Z7S3dO6iEvc9Ex51q3D
	Vi75bGlWLvwjTWZ5/lQ17b82PSHMrw/pNPmeKUKHMKbDTmzJM79iSwRH/mNX1yp5eVBhEEmqQge
	USZHp32JfLuB4+c8qqKY860l0ftV6hNKzwZW4Y5y4r7KSW1cprREbxfk79OSSS2a8MHCOoa8yuU
	u2ysIFkGiFVz8KIMRWxNkX20dCGdUp8p+EXG1W2LtfFcvvCLtRieygSMZw8bYpbZITv1nvZumQ=
	=
X-Google-Smtp-Source: AGHT+IEYDHPLPS/aiLsylQmdV4aS29FcdoVYkARHkjeD3JC5HuUi2/GalehZw8KEnx2WXwNuzXZgDw==
X-Received: by 2002:a17:907:1ca8:b0:ade:35fc:1a73 with SMTP id a640c23a62f3a-ae057f9e1b6mr483910966b.55.1750457178076;
        Fri, 20 Jun 2025 15:06:18 -0700 (PDT)
Received: from [192.168.20.26] ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054083406sm227701466b.75.2025.06.20.15.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 15:06:17 -0700 (PDT)
Message-ID: <970c41dc-e89b-4963-abbe-398dc3d53110@gmail.com>
Date: Sat, 21 Jun 2025 00:06:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Support for Adreno X1-45 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250620-x1p-adreno-v3-0-56398c078c15@oss.qualcomm.com>
Content-Language: en-US
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
In-Reply-To: <20250620-x1p-adreno-v3-0-56398c078c15@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/20/25 08:54, Akhil P Oommen wrote:
> Add support for X1-45 GPU found in X1P41200 chipset (8 cpu core
> version). X1-45 is a smaller version of X1-85 with lower core count and
> smaller memories. From UMD perspective, this is similar to "FD735"
> present in Mesa.
>
> Tested Glmark & Vkmark on Debian Gnome desktop.
>
> I think Bjorn can pick the DT patch and Rob Clark can pick up the rest.
>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Hi,

Thanks for the long awaited series!
Works on Asus Zenbook A14 UX3407QA (x1-26-100), tested on Ubuntu 24.10 
with Gnome 47 on Wayland.

Tested-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com> # x1-26-100

Regards,
Alex

> ---
> Changes in v3:
> - Rebased on v6.16-rc1
> - Fixed speedbin table in drm/msm
> - Corrected the regex for the adreno opp node (Krzysztof)
> - Replace underscore with hypen in DT node names (Krzysztof)
> - Link to v2: https://lore.kernel.org/r/20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com
>
> Changes in v2:
> - Skip 'delete-property' wherever it is unnecessary (Dmitry)
> - Reorder dt nodes alphabetically (Konrad)
> - A new patch#1 to fix the dtbs_check error
> - Link to v1: https://lore.kernel.org/r/20250607-x1p-adreno-v1-0-a8ea80f3b18b@oss.qualcomm.com
>
> ---
> Akhil P Oommen (4):
>        dt-bindings: opp: adreno: Update regex of OPP entry
>        arm64: defconfig: Enable X1P42100 GPUCC driver
>        drm/msm/adreno: Add Adreno X1-45 support
>        arm64: dts: qcom: Add GPU support to X1P42100 SoC
>
>   .../bindings/opp/opp-v2-qcom-adreno.yaml           |   2 +-
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi             |   7 ++
>   arch/arm64/boot/dts/qcom/x1p42100-crd.dts          |   4 +
>   arch/arm64/boot/dts/qcom/x1p42100.dtsi             | 120 ++++++++++++++++++++-
>   arch/arm64/configs/defconfig                       |   1 +
>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  39 +++++++
>   6 files changed, 170 insertions(+), 3 deletions(-)
> ---
> base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
> change-id: 20250603-x1p-adreno-219da2fd4ca4
>
> Best regards,

