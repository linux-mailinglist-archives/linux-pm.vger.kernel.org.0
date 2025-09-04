Return-Path: <linux-pm+bounces-33825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694FBB43988
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 13:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155521B27781
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7FB2FD1BA;
	Thu,  4 Sep 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNNxGCot"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6682FC01B
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983987; cv=none; b=OmLbQZVM/cAKXyqO6uVICK4UM5dglr+F43Nc7I5dgKjenbg6mz2i5txXo7za1s2q1dOUwt9apDLm9VTGj4Rw3iyR9oHVLiCGjoMpgX+bFk7Lzof05gv7Z5+c45UJx+Q4OHBattosbOLZPzJ57TkNPgyJLcK79/kfDTXKPGi5avU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983987; c=relaxed/simple;
	bh=5ePcVdkCAP+ESkraZYbyKnHjr7ZHVyyj6qsuO2F5SsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=join83wKc4DrMoCcdKyo7lBZ5m/8eE51S8GeZnOxt1TBH4rgEsSVCUYwTEhpPrpqS4W6gVMPYkOSUDxfRV/KOJn4LZI99Oid83HB2QSveMMrudt3GmULO/jDTjl9J3tpfRV0L8aFrBszMT70HCPoE2tsK++ISf2QOQrSWyI9vP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNNxGCot; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d71bcab6fso8671787b3.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756983984; x=1757588784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qqKmJAcNXHCDcjaAnbZVhbmbW/ApAzLJDIUDuK/HU4s=;
        b=eNNxGCotUilXfuyt8TL1JfKDjSU+ol8BSFAjNeoUbWMGFmASGOuEbKKM5PPdJERShC
         rMAmxCo5WcY1ceTbAxL6W+w/mDPVk71mIV7AUQ0Exv6OtU8uQ7kkllq+M2Bxvfb/ofvw
         Gs/SoafXsTo8a3lQMWrVSlBy7OAZgNo5JZc1sAu80kWqFXOz31I/Vmc/Tt/UXeaqyp/M
         0lb9SqV16OeIcCjxd5/9WOP81+n/9nnPUPBSpO3RV6uHXcBVZrx/i4e8zL2Dl6+x43W0
         jNiOBvJcztbLs3u8tvqrh0BKWc0ywi+QwZUC5wxaaslZwajzhfeHb7N+KyfLeS9y1D0L
         BXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756983984; x=1757588784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqKmJAcNXHCDcjaAnbZVhbmbW/ApAzLJDIUDuK/HU4s=;
        b=uTYOHgMfRt0Mda8dFBwEnb7f/GZMDKsx7MxhEmx3grp23Lw7dvAPmAFFyVXVp8ZC3Q
         F+iN5ARnpXK0C6iAAhRy833fZxB2JqwN6xjrc5rsDlsdRw1IxD/3LbuUesizmCkryFLR
         KMphVcqJ0Oil/GqDXeU4Jy/0WcetcfZ7yyIEYlkwrWvsbNIEuC49OWWhnajIHzbtLal8
         Bgs7/8lcXW2kwwarnhd4ng7IyaIfQrHa1qaPEakECUeIgRkv3kIPjRGmIBPWsnzC042x
         TJEKq1WaE5B0pDuABXnoHBGFaCZLmti3Vu4hVXR6+wcFNjwtROJlv2e/xolBD5ge0rp1
         ejqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo47PDT8dF922U+Kjo8awpw0TtJjna9XIugbewG41PCq/o2fD5agITDl8AUvqQDko0m5nbZtpCsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpZaoUT1kXBicMaQL0+B451+prjqru8A9hoBVtjszTSViothx
	6rvT77fbk1gW5tGBlz6XmNUNfn1GckCOIr1FlU6cuG7w1mYBp55QMku897dBrhgTwvBSWPaAe08
	njGpAHSOU3hHXwF7/t4jz4GVpF/UYtn+rzKeUkcbW2w==
X-Gm-Gg: ASbGnct6WPevE41cHzt5OrqksKkh5Da17dFeET+MoSBe5k0BFbf1gLZXId7iYUtSAAu
	YF9xbjJyWATxXSr8CQR3gh7swiVlYq8PRf04B94LhSinzxU/Tkn09qJoGuO47vo+HBXqWKC6tOn
	GANjBF0Qtg7kWQgqIYa7K5Jbx3OUTdztHHZ/yje6D6vM7XnYJo8j5isT/SX3vwo1q+/cO3POgeS
	Ciu4cUu
X-Google-Smtp-Source: AGHT+IGqecQe5yOp9cR8x9hlAxxhDZsB8TfIupcC0FJtDt5AMK3d6JhTkzzkgdPyrWC0L7dsYj69W3txBCo/Z85TaT0=
X-Received: by 2002:a05:690c:9a8d:b0:71c:1754:2696 with SMTP id
 00721157ae682-72276542673mr206178927b3.36.1756983983654; Thu, 04 Sep 2025
 04:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
In-Reply-To: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 13:05:47 +0200
X-Gm-Features: Ac12FXzzO6lh2XeuKq6zK_9jSCFOJd4db2W5dfvQA3Y4rmF6D3oa47ZB2y7XJS0
Message-ID: <CAPDyKFo=pwb43vZFkKprbBthxAy_YtYD2mKitY6Oe-rMHYCkDQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Power: Add power domain driver for S6 S7 S7D
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jianxin Pan <jianxin.pan@amlogic.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "hongyu.chen1" <hongyu.chen1@amlogic.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Aug 2025 at 07:41, Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> Add power controller driver support for Amlogic S6 S7 S7D SoC.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Patch 1 and 2 applied for next, thanks!

Note, the DT patch (patch1) is available on my immutable dt branch too.

Kind regards
Uffe


> ---
> hongyu.chen1 (5):
>       dt-bindings: power: add Amlogic S6 S7 S7D power domains
>       pmdomain: amlogic: Add support for S6 S7 S7D power domains controller
>       arm64: dts: amlogic: s6: add power domain controller node
>       arm64: dts: amlogic: s7: add power domain controller node
>       arm64: dts: amlogic: s7d: add power domain controller node
>
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  3 +
>  arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 10 +++
>  arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 10 +++
>  arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 10 +++
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 95 ++++++++++++++++++++++
>  include/dt-bindings/power/amlogic,s6-pwrc.h        | 29 +++++++
>  include/dt-bindings/power/amlogic,s7-pwrc.h        | 20 +++++
>  include/dt-bindings/power/amlogic,s7d-pwrc.h       | 27 ++++++
>  8 files changed, 204 insertions(+)
> ---
> base-commit: ffeebf7587f518a3717fad308cf735adbbcaba97
> change-id: 20250820-pm-s6-s7-s7d-950f720aac6d
>
> Best regards,
> --
> Xianwei Zhao <xianwei.zhao@amlogic.com>
>
>

