Return-Path: <linux-pm+bounces-543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D217FEDE3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 12:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8600BB20E23
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ADF3C081;
	Thu, 30 Nov 2023 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sv/PdGSf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA82172C
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 03:31:02 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so704999276.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 03:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701343861; x=1701948661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7OU53fGBOPG6Pf4dr1TYI+8Sj5e49OX70Q1sOZhEyk=;
        b=sv/PdGSfE9Z5FdcY3EK45zoWKbMNLrwNd5bsAsu2RU4pTxMjEpom1hkjOi5f7IsD6t
         0orvMN81PS4fNiX0ULxOb1NGGZ2nL6T9g/8h7sgyiY7P557nMf3Oo/7dvX8rbLsxNsIj
         n0yHsK6B3m7uHYB2+ovIArGitkaf3DN79bB9yBBbu3KyN59vLUf+5rp6ngKg3WJUjBbU
         s+hKadHLVHBZe1287puHKUzMQ3hJIm/DbLwEMejgbm11XHkS2/Cjck7Uorqkvr4yRYS3
         tAUBCeOvgug5mWeYMnw44HrUjOMWHfhWmyReDDXwKziWn6TqegxjTpdFIAJHhb0DmxyQ
         wjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343861; x=1701948661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7OU53fGBOPG6Pf4dr1TYI+8Sj5e49OX70Q1sOZhEyk=;
        b=kCHTOeaaC1vtu/athvYXkleiSitoXnz0QkY3pT0ZT9TlgpSoA4+5sLYivzkCnM6QDP
         aUk6wmOV5Zmug/S15S9fi7Kaa2FKIgiGh8iodAFLOdZ5vOy4VFq91qdZ3vdWC4x6Bung
         RluTEmKZxXUohm3O4nMfun4JauJVLiVpeVv3p0UkQ3aBmlV+lp9QsyX8cXE2iF2x8lpy
         L+4ojXty/QWZTRq29xc/ynYciAmMHzfG+urv49X48LOphjJOFfMLA0Tcc7UIDwfGrHRI
         6C6XuX0G8Ro61x+Rj3ZxQ0KZnUYvbM4BLwdSpCiAlN+B4CpRLXrBmqMrd8WCO5jeLIHq
         vAWQ==
X-Gm-Message-State: AOJu0Yx9RsaSQ6TVvFzmMV2rIvaNpStIEPEXPY+Sx5ibuE1416tPfv4g
	heb6FQjmqs/kSvGdtFJH+RbiUIg4Hsvzqfp0cHqerA==
X-Google-Smtp-Source: AGHT+IGLBA9cAvCW/BlFwViZaJGDvVrjeHv8nYpm9n0xFyqiDsBqoa/xFpj/b8u0mPKQS3ZU6c/jj0h4qWRRrKDRbwY=
X-Received: by 2002:a25:ab0b:0:b0:da0:76eb:3d31 with SMTP id
 u11-20020a25ab0b000000b00da076eb3d31mr19895548ybi.15.1701343861311; Thu, 30
 Nov 2023 03:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
 <20231123-topic-amlogic-upstream-isp-pmdomain-v2-1-61f2fcf709e5@linaro.org>
In-Reply-To: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-1-61f2fcf709e5@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Nov 2023 12:30:25 +0100
Message-ID: <CAPDyKFr9jtg8rf2bs1N3zR146TvCmHgTwqWRr=LJNjervpfOkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: meson-g12a-power: document ISP
 power domain
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 17:17, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add MIPI ISP power domain ID to the G12A Power domains bindings header
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next and the immutable dt branch, thanks!

Kind regards
Uffe


> ---
>  include/dt-bindings/power/meson-g12a-power.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
> index 44ec0c50e340..01fd0ac4dd08 100644
> --- a/include/dt-bindings/power/meson-g12a-power.h
> +++ b/include/dt-bindings/power/meson-g12a-power.h
> @@ -10,5 +10,6 @@
>  #define PWRC_G12A_VPU_ID               0
>  #define PWRC_G12A_ETH_ID               1
>  #define PWRC_G12A_NNA_ID               2
> +#define PWRC_G12A_ISP_ID               3
>
>  #endif
>
> --
> 2.34.1
>

