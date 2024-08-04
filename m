Return-Path: <linux-pm+bounces-11892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB2946DDD
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 11:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165381F20FD1
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 09:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6A17588;
	Sun,  4 Aug 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFGsWleN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05521345
	for <linux-pm@vger.kernel.org>; Sun,  4 Aug 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722763033; cv=none; b=Pijnxw+0okqRV+beXkhG7OaHXLyBjlmreus6reoRbmjW5QwUVY6xhsre2FmQh3/HOk6qYx8RBHiCAhi6mkkDLDUeJZOCMwOnF1TTncCfAdf8HwhlV2FMANN20OObMNc6tbjgZ9Gzo7HPYf4EhqdhHUDxZIAe23g0p+IY9iyxka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722763033; c=relaxed/simple;
	bh=8t4KkhEqwa8vESWacxIB0ZboE9iO2+3ko0q2paQ4RL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRslLGKakdpRs3FNBYySiLTXimlK99Dm2m1hbt8fsBAqSJC7mbS4UqnBMf/vtEl7Z5h0HjWDAtL/sqWKrOLxAd7oaKW/97DB+Stf4elX1+LLenuY6RMjqMePzn9shKJFS+9+dvHQivDgUCeOUWVq/TYVzILYFZt/tA1ox68vpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFGsWleN; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6510c0c8e29so77359247b3.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Aug 2024 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722763030; x=1723367830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mwig1T/GI7J6NZajQWaoVMnmbX4imhd/r3iYNF53W6Y=;
        b=IFGsWleNSnPNpVpwGrPUpZj7iCAzjkklZfxK9bCkcnmS7VB4jf6h+0XjXMGyVl50H6
         28FAD6whFjSzEY6KEgvQQGHczcFbkpGRh1t3D67v9jrLCTb24QH+M7W6k9WcT6x/uE90
         d8Z5mnpXCg4JjoqneBomYVpJIJSm0aCVb6IBHiiuBV/eq7oBpd0Q9epWK/1Ff8jNHOyO
         3W95E01znQh6qCXexkrY2+M+QR77icatJULeYG4IOYleyCcnHVLS6LGPXs+lohLWiWsA
         /n16I+Y+0n89258pyP8BzS576johplzLIvvbZbHOK4HajdWKBlTpWu/Ak1+DdgKDR4zv
         KMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722763030; x=1723367830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwig1T/GI7J6NZajQWaoVMnmbX4imhd/r3iYNF53W6Y=;
        b=DQGJ6e2OBmG8nC4709z9B/e4izR6QCBUEFyryrrwewry8zkVgoZCaJ1BgDj8gSCSAd
         r4ZI8D+YEdVG/cSvS+UH/WoQbf2w45bOwHeHXRgoYHE7HS6RTVxHDsbsyxnwQQgubyyr
         YM0clA2jAFbw00heTv5fbUPGOj1AIvV3xI7cJWMM9kS0iovZgnlmQ2FM0MPnN41RjoZm
         Eal7mliRdGPJXgnTPXaYEo0GmV++jrb6mtOVkcSp4HMBV+uNvETLH12gO+jnjdiLl3Lg
         Fw2LD9d1fWDBEhHIMkP66Gr0YzH1mymfOFogG6wb00+gBgvsC7TJD96ujFf59MMsKfqk
         nVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl1pNKBa1lRMOQJj1HtSmcq9l5+j0Y8avajHiN/DpQ5S3NOXPxWo0fOHBFE2ehbQ0mwMDMTODKHA7VCuzh99+A0pP7ncevfy8=
X-Gm-Message-State: AOJu0YzmtYlvj8/tTu2mo3m23Sa9W0wIsEbUMjdS/86Qzg1P8wjQa3Xz
	Cj8SOFl+h6Gb7O9iUbmRPzNNTINF1dKxJtuIl/dNwpb5FH0YVcj1InPoRgT8O9TOy9oeJ3KI3xc
	REgXswrOQRH5rLz8YBiKHm0OJkrpHIaIX8aZE7w==
X-Google-Smtp-Source: AGHT+IEjvRALfHiK20+HqWr/VOyns/i1THpuPrDOhczyqEMfLwxtq9r+VorCam7xfy5I9cowlh1ysHraCKWf6o+C75Q=
X-Received: by 2002:a0d:c247:0:b0:644:ffb2:5b19 with SMTP id
 00721157ae682-6895fbdbd45mr94218977b3.9.1722763030652; Sun, 04 Aug 2024
 02:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804-sm8350-fixes-v1-7-1149dd8399fe@linaro.org> <202408041643.qHy043eG-lkp@intel.com>
In-Reply-To: <202408041643.qHy043eG-lkp@intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 4 Aug 2024 12:16:59 +0300
Message-ID: <CAA8EJppbLUvSyq_AEh4Cw4ZOf2h=2-A3EuG5SPuhc2RDChWMFg@mail.gmail.com>
Subject: Re: [PATCH 07/11] dt-bindings: interconnect: qcom,sm8450: drop DISP nodes
To: kernel test robot <lkp@intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jonathan Marek <jonathan@marek.ca>, Robert Foss <rfoss@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Tipton <quic_mdtipton@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 11:50, kernel test robot <lkp@intel.com> wrote:
>
> Hi Dmitry,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 668d33c9ff922c4590c58754ab064aaf53c387dd]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/clk-qcom-dispcc-sm8250-use-CLK_SET_RATE_PARENT-for-branch-clocks/20240804-134328
> base:   668d33c9ff922c4590c58754ab064aaf53c387dd
> patch link:    https://lore.kernel.org/r/20240804-sm8350-fixes-v1-7-1149dd8399fe%40linaro.org
> patch subject: [PATCH 07/11] dt-bindings: interconnect: qcom,sm8450: drop DISP nodes
> config: arm64-randconfig-051-20240804 (https://download.01.org/0day-ci/archive/20240804/202408041643.qHy043eG-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.1.0
> dtschema version: 2024.6.dev8+gf13c181
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408041643.qHy043eG-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408041643.qHy043eG-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> Error: arch/arm64/boot/dts/qcom/sm8450.dtsi:3055.31-32 syntax error
>    FATAL ERROR: Unable to parse input tree

I see, I had this patched in my tree. So for sm8450 we have to keep
backwards compatibility. Please ignore sm8450 patches.

-- 
With best wishes
Dmitry

