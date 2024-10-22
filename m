Return-Path: <linux-pm+bounces-16213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774DB9AA0EE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05461B215F1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2717119C540;
	Tue, 22 Oct 2024 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbUtiiEt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3F199FAB
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595677; cv=none; b=nsP4nddRs7mny3gjz1Wjv80z5XvzWWrjkfHUjZ9FTPoYBhvYGNPCgIere7rZBe48lsTgM5iMHnm+ypOWn1Y7hQi6BHiC0+8WsDySAK6vJW5PI9Q59rpYDx0Qr4Wqb1/+3g3PAZGaIkRKEKQw/5qFpsaEzlOasPTUSC4EohoucaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595677; c=relaxed/simple;
	bh=RDoWcRABCczbsRh/bIrxVD2pdjz24qe0cc2s6ituHAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxDtDFtkIcFT/U2X8FotnoNzXxZe3S2/147a27ygxzehHOQDraE+GB70NV3yoTG70DQK/XECF5YhL0RMwy2dHlTkNOVj1RtDYK+UANTSdY8FAvSCDESDuBBv9PhtxkqNp438HaKX2GKbU7fHevzu9IFDTDLQmhq0sI/gbcKlq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HbUtiiEt; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so2300964276.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729595673; x=1730200473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nH7CYeO71ANQYCtq9Z6qGrFirusG6U+5W2achtUgNO8=;
        b=HbUtiiEtWnN/6J8LNeCONC0FvZnN5eUYvKsx/AgiTAmvv1ufu9WiEbXzFnXr+TYKpT
         B3sxIrTQ+X9p5576DqckXk8RF/GZlO6Arv+xPBnJiI6hqLCq64kYRwzYpiIXd8efMiwl
         tlbSrtIzDfBm71MbjHNcCQNcqSyR+RL+0X+s8yNMUv6grjQnDOzSAOIk177w7564L9cl
         4/jPKK9de0pxEtoyjdi85RLGmo5TOfXOQ0fP7+G3rkNYsf0RaapxrK6XTsAdpJhsUXQD
         m83sak9MMajN4ykVtpVFr2ZLGWfNHuU7vMC2G+nDmYQXm5TKJ80uJEoPLBqJTlquamk4
         kdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729595673; x=1730200473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nH7CYeO71ANQYCtq9Z6qGrFirusG6U+5W2achtUgNO8=;
        b=OUcZECeTmiGuYx45f1jY4KLEJsvgu/PjJh/MRnUeAm0c9jVxdhebwSo+NCZMaHB5bO
         ilr5223h18fPrzw8ZpPeKIrqT/XCXF03Q3qWPmKkhPL1n6kn6qJ84O9AmtjAMYtdNkgp
         y/7H+dXzgzvFZ1xFuTUFVwlyfzp9/D83MuJ1OQoDGz/1SIVtnGoQ5+BATyyQkGDGFGh2
         JSxU2t1DEApe4GN9ubzq+nZQMrSxeb5IPnWZLFeYO7XniNWcOLgpypT4IItwY5V89nIS
         8wWTdWQVxZ1L1y3sjS4WrgRyay/7bWAzfeapY9VoPf4e+Up8CKNMsolp5OLz9hrNClGi
         5Ytw==
X-Forwarded-Encrypted: i=1; AJvYcCXGDSiIxlBhLIhzRzLaqoORNxNLPW+hVSUkEjvquIp8hKy77Zu9MQSSTpU0WTUNw/kkpsllclLfAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQISFgqFW97A0j0yOlCWFS4e+ae4aViFbgdZ6ykMsgWmBqevnU
	2EhuEBBS1Joa840jZwTuXnso34FirzJCY4MB0SnrqgM6tIVBY2bZ9FTc5YR2evwKXfw2SwzsBb/
	LNsF/AbLBWS7KlWjXG+rad5H+4LOaaH6gU87aqA==
X-Google-Smtp-Source: AGHT+IEO/xvtb/gCSTdniTtZAz329siXTAEkxHcZHf2dVBhENnXkUopUfXByHrvSGCkPQNNCRHhUMb/Ci3JVE9kVetY=
X-Received: by 2002:a05:6902:991:b0:e29:23f7:ccf8 with SMTP id
 3f1490d57ef6-e2bb12eeaf4mr13607038276.14.1729595673177; Tue, 22 Oct 2024
 04:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
In-Reply-To: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 13:13:57 +0200
Message-ID: <CAPDyKFrDmNwj=x-189CUYCk9MqbG1yEmmv=gfFus19dJSCU7Mg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pmdomain: qcom: add support for RPMh power domains on SAR2130P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 19:52, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Define power domains as supported by the RPMh on the SAR2130P platform.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (2):
>       dt-bindings: power: rpmpd: Add SAR2130P compatible
>       pmdomain: qcom: rpmhpd: add support for SAR2130P
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                     | 25 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> ---
> base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
> change-id: 20241017-sar2130p-rpmhpd-010527d95757
>
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>

Applied for next, thanks!

Kind regards
Uffe

