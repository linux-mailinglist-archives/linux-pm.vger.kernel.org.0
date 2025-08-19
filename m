Return-Path: <linux-pm+bounces-32631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A597B2C3A5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD019A03948
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87F62C11E4;
	Tue, 19 Aug 2025 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JO8XRdOQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424620C000
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606433; cv=none; b=NS44LB9nWuepoQRHUof+Oss48hNc/nlY754+RktN9O4LXhSNfT4/M/ARWXszNgsemCm12f+cibWjuiHPkzHkCyo0h1ObBZeAze5PZfZzE5d8RxVvFnefDbhXqABImcjs7S44D3Icp5cALq1EuSSklYZgthnWsPzbirFB1dgw8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606433; c=relaxed/simple;
	bh=4AoxiOgLAeaNsjikPK651fSU53c2V0f7JPKo4uTzE0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9eRWRbUCcFH56w8+pewPi+2FdUkvm7aII4mKVRT/n/ep2xgmShhtat8v5MWTymXB+gvM/KPG+vBnaSB0ryjfGPeNJkIvzBmvzoR1l40Ns41YDfXzy406GxLLZ5IsYGMJ60ht4FjUOTKU8EMDtKcm3Mr2qbWh+3bn3GfZLlaajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JO8XRdOQ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d60110772so46700817b3.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606431; x=1756211231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0aRsy5XQ2A5B+bslStkieJadz5tU0dBZ7FndcLwnw2U=;
        b=JO8XRdOQVzB46uNFDHwqYvAPtj1wFb0/TuJ/mBtb2FYhZWscknnBueJffmQgkMLigK
         3lGmaVCElpl1W5J/93J9UwEzVswniLDHAWE2vVvgTFdkcjfdcCCNDN3h+3Mx9jS22jVP
         w7PxfOiTnIgx3VEJ1Q8klAAHbHuAqCyGoRDcUdTxi7wPdSPCyL9sRhfhkC9Z6EYH5HJb
         Ca4e8c94R4XnKjv1+2qo+WxaWowQ0byZBN40Bh1qtik0dsNv/yueZm6Hths8dw+w26ks
         KEfp7OFFFngZHACFGUtaR/0lQoFtXT8e35GjRX5GfNk9XaXoVGTpHSd3E3j4adPxsHPk
         TgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606431; x=1756211231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aRsy5XQ2A5B+bslStkieJadz5tU0dBZ7FndcLwnw2U=;
        b=JJs9s/1G3PeUimoqWe6/0Qcy+Kst4EE/oUkupAdHwMOr2BG9Gxv0YZ6UliOWD4aHgw
         fB+iliePPnuLfiWQMZmgtHBayZuNOvoHKiA4YSxgzwfj6JAV4Xl3cI/OXF1s3ZYo/anv
         aVpWgQv25NOU3ofsL1v+pl0eqPOd8ihDIBNx6Znaz5FvA8FZjvemOUBMKEsUx4zvAFaT
         tX8M6VA53LEtyZv7PjxN0S0aWVLNqErmlnqPJkhQscTvzNqEShS0j1PD04t+U+60znRb
         GQ/i2NMBRzT9WK7H914x6JmM2Hao/i27u7UnEPX8lZfBV1O11B3gyYCPdwpTgClhLIo5
         ec6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhOiASNwRWnV6JNVORdQTNq8Ve+xyYJnCBFPNB8n/dMj7WBKpP9Rr5zQxCeZrKrcAFCpuWcIwSDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNCXoQK+7JqxuVSxZPPPis/rJMqVTgpzpwaHIm0cbTgu9Nbxf
	vaubCrF4g2LgfZiRTLSPU8X0QyRSxd/9Fs0+jsr5oQRbfqCXc1RKgFR5dH0JTD39Z8nfbMmA/xu
	5MLWUlRxs5IHW1zQw5oVaDN/geQbAPXsTok200Q/x7w==
X-Gm-Gg: ASbGnctdYpOTHE6tvVbl/JIgOPMDL1/82zusFO3R24iSRzQwYoSLFByBpmsPFiHkpw1
	YTrC8bKauZ0IR2V7p9qsdqhHAWjhwYUJhD8yEIN91thDxYhPo1oWbLC3FMsVnVvzeG89kk9DU0y
	kjejCYoiqRs2ZbOhjAyH9Utp/GGZ7NfoGREtJVICQkMKCa3N5S2kuxr+MunenpmpSNgzC7Tv0i1
	U5ElmA=
X-Google-Smtp-Source: AGHT+IFXFo8PRVAZPJHb4bpkeQ2YcDNH/EmkqmsfRC6uXY5vV38JYto49FcBSLPE35RMZGuEpESlzVZZ88xarzeuPZ4=
X-Received: by 2002:a05:690c:6911:b0:71e:325e:544f with SMTP id
 00721157ae682-71f9d4d9e28mr30801467b3.9.1755606431118; Tue, 19 Aug 2025
 05:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com> <4bdxuzk7gyzww2kckotihch6ljyiofs5gm6ntnpjst3crm462j@z6svwllfcqwk>
In-Reply-To: <4bdxuzk7gyzww2kckotihch6ljyiofs5gm6ntnpjst3crm462j@z6svwllfcqwk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 19 Aug 2025 14:26:35 +0200
X-Gm-Features: Ac12FXwFv_kIb4glzzSCVp_TN4Z1jLpKOtJbRT8FLbTxebOvGA0iZC3qmVJuXmY
Message-ID: <CAPDyKFq+J+iWgotRRTowpYYbmuepACHdOQAizrrDuzpp_if7eQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] pmdomain: qcom: sort out RPMh and RPM power domain indices
To: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Jul 2025 at 05:39, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Fri, Jul 18, 2025 at 07:13:38PM +0300, Dmitry Baryshkov wrote:
> > - Separate RPMh power domain bindings from RPM PD bindings
> >
> > - Drop now-unused (after [1] is merged) binding indices for RPMh
> >   platforms
> >
> > - Introduce generic bindings for RPM power domains controller
> >
> > Two last patches (marked as [DO NOT MERGE]) should only be merged after
> > corresponding DT cleanup lands ([1] and DTS parts of this patchset).
> >
>
> Ulf, please feel free to pick the DT changes through your tree so we
> don't need to wait a whole cycle.

I am worried this may cause a merge conflict for us, should we really do this?

>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Anyway, I decided to start by applying patch 1->4 for next.

Patch 1->3 is also available on my immutable dt branch for you to
pull-in. Please let me know how you prefer us to proceed.

Kind regards
Uffe


>
> Regards,
> Bjorn
>
> > [1] https://lore.kernel.org/r/20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > Dmitry Baryshkov (8):
> >       dt-bindings: power: qcom-rpmpd: split RPMh domains definitions
> >       dt-bindings: power: qcom-rpmpd: sort out entries
> >       dt-bindings: power: qcom-rpmpd: add generic bindings for RPM power domains
> >       pmdomain: qcom: rpmpd: switch to RPMPD_* indices
> >       arm64: dts: qcom: dts: switch to RPMPD_* indices
> >       ARM: dts: qcom: dts: switch to RPMPD_* indices
> >       [DO NOT MERGE] dt-bindings: power: qcom-rpmpd: drop compatibility defines
> >       [DO NOT MERGE] dt-bindings: power: qcom,rpmhpd: drop duplicate defines
> >
> >  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi |   4 +-
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi    |   8 +-
> >  arch/arm64/boot/dts/qcom/msm8917.dtsi    |  10 +-
> >  arch/arm64/boot/dts/qcom/msm8976.dtsi    |   4 +-
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi    |  16 +-
> >  arch/arm64/boot/dts/qcom/sdm630.dtsi     |  16 +-
> >  arch/arm64/boot/dts/qcom/sm6125.dtsi     |  12 +-
> >  drivers/pmdomain/qcom/rpmpd.c            | 112 ++++-----
> >  include/dt-bindings/power/qcom,rpmhpd.h  | 175 +++++++++++++++
> >  include/dt-bindings/power/qcom-rpmpd.h   | 375 ++++---------------------------
> >  10 files changed, 306 insertions(+), 426 deletions(-)
> > ---
> > base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
> > change-id: 20250717-rework-rpmhpd-rpmpd-13352a10cbd5
> >
> > Best regards,
> > --
> > With best wishes
> > Dmitry
> >

