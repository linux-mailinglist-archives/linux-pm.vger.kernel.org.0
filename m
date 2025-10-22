Return-Path: <linux-pm+bounces-36650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F241BFC249
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE02628302
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3134CFBB;
	Wed, 22 Oct 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmqDb2Hk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B434A79E
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137923; cv=none; b=O6jGFYOlnQxyEPq8VsS6hpK1DgUG/QkdhoZXtmEkYrfSjqGhL8LYLx8SJ7KIVtGy2iorski0yNdv13KmRgrqkW8JtkHxujay/1ZqN9Jz/0/B3qys3uxQvXEV5OwQ52N0aA0REVp15AWFBR5sgouA602+iDSJzMVz+Fm4HNPCm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137923; c=relaxed/simple;
	bh=jSSjnCM4ER8aKOW0t6/ZA+XtyoMrKYkP+HhxvOTGTRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlL44jWy9Ih3PMLSBKejUHL8hgQRqF8XN3m207hPVU72gnn3BdOWG5trAhroBY0IRvYHfyXkEcE61GHQ1z+tWgcW/s0b8Omm6qDvTWO+MHyaDmPZGpbXZBXWkLLKvBd0u9yqjm9+GcJbzKhXwaGtYMCNvnGqaKxLVd0u5p8KB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmqDb2Hk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7849c889ac8so14229607b3.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761137919; x=1761742719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LqfpXhH8oikGFpnElT3hOnVI48sa1H9J9/n1+8f904w=;
        b=nmqDb2HkjgVL53xtQOZCewrjRcYrK4sr5mhoqEx4Z1ziGkwRAmC2mHotDzhgOQf1Pu
         aj1IcllYgahfMp/jUyHoAI7OwiDKjLxlaS6dMgmDRlNdNTLBmBxDzF2GjiFShrJaYM3N
         BZCONm1ijU2AYhhOez0Q89RT6RRyMUPO/c5r5R4XhB4ApufYIOtOBqCQFDhVwMf3ioD9
         fSDpJiKroLniC5hkho0XLRJc212KheA8vmiCIF9R4yZTcrfHY44GXGBzbuMQf5ZGGHgi
         2afCKanK2fDPvEet1IX+CCSgVj13CXSVnqUeFezeptPiWTtvnAHnhOoP7tRmwFI8chCv
         nysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137919; x=1761742719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqfpXhH8oikGFpnElT3hOnVI48sa1H9J9/n1+8f904w=;
        b=QhY1S8zlmi5f0auuAaACC/tlXobD3rmzsg+vcfsV7p4TGjxaT5PtspisADsX09bmHK
         jCDArkDnRkwi+SJLQBtJBMjWLYtt69TOFUYbBOCV+3VycwIdfKS/LBnsRPtZM0ceOcr5
         bt0HEfupBzOA3p9EgqPrVlCsy+d4CsigOqHZevec9KozyBP9PBng8bRCZxknT9VdAd68
         yKFev9hPIGWEhE1hsecs4jDYDYs7P+YEDRnDtcAS3SInHOWKZ37aYWK4vPZzltj045Ca
         +eZaJdl7d0HxkXvXM3HUImYjBt/OQnLjGFOP8nv4MBuN4JTLc2tjAORMr4ZRlE1Yz/tn
         BjlA==
X-Forwarded-Encrypted: i=1; AJvYcCUDM0SpxKfD54/xF4q/AJldetOzZsKP0knAjtYZX7popYQNJRz7b7HCBdlDIyINeedp1Gbh176ckw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FVLUFUQ6wbds75h5QbiKuWdWqLrLAWS3sUrjVC8CKl7Ju03J
	n+D/7KaWNzueL5Of1lJsv7oqUGZNYU2RLVv8KN3VjK8ivKJAONxs1N/8Iy6XPKdfO88jJjFbCmo
	zeimHIo52m5YO3IDTUj7tMvG73UAmtHnjYjeMpO99ZbygiEkJnuQN
X-Gm-Gg: ASbGncu3s+0ombetEGAKzN7sFVtl33OIStupHmWyD56RVenfEhEpreYF4Truahv1yPX
	8P7GCvPJPMu2Rr+UcshuzRkNptqWB43IpEp2HNQ1zIF1gIzExFMvCPaVxCeAK5KWfQTBHpDO5pO
	mgzMnNbVjzcPkeddzh2fnHot7vYjaomCVbRMvySGWJihX5x/4UyGvun/wmBHKMOASlNOpheQbks
	84JSAOR86vgUtHwNcHFP2YSxI6kJEnGFFpU1iqn396Uhp+5z0CGlAv7odZax3jvu0OtnAhPdg+I
	TBAZ7TY=
X-Google-Smtp-Source: AGHT+IEjyOT6ZnWjtbuwKFmQbeLCXJvC9+ovHItNxLtceyMzt5RJXygROmaPW1mTzx718f9fX9ymVtGCF2aAo4JR26M=
X-Received: by 2002:a53:da0d:0:b0:63c:f5a6:f2d0 with SMTP id
 956f58d0204a3-63f2833575dmr2112548d50.31.1761137919613; Wed, 22 Oct 2025
 05:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017093834.331998-1-finley.xiao@rock-chips.com>
In-Reply-To: <20251017093834.331998-1-finley.xiao@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 14:58:03 +0200
X-Gm-Features: AS18NWCPlgQ2C3y-wODiJDQlKOeRdWjBY3paMVLSMS-IfDxCiXVh7nLiSG0YRnM
Message-ID: <CAPDyKFrDAmfN16fQdf5en-Du=sG5U61NK7vRhd_CtiSz19rU_A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add power-controller support for RV1126B
To: Finley Xiao <finley.xiao@rock-chips.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, zhangqing@rock-chips.com, 
	sugar.zhang@rock-chips.com, huangtao@rock-chips.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 11:38, Finley Xiao <finley.xiao@rock-chips.com> wrote:
>
> Add support for the power domain controller on the RV1126B SoC.
>
> Finley Xiao (2):
>   dt-bindings: power: rockchip: Add support for RV1126B
>   pmdomain: rockchip: Add support for RV1126B
>
>  .../power/rockchip,power-controller.yaml      |  2 +
>  drivers/pmdomain/rockchip/pm-domains.c        | 41 +++++++++++++++++++
>  .../power/rockchip,rv1126b-power-controller.h | 17 ++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 include/dt-bindings/power/rockchip,rv1126b-power-controller.h
>
> --
> 2.43.0
>

The series applied for next, thanks!

Kind regards
Uffe

