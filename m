Return-Path: <linux-pm+bounces-142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679F7F6410
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FDA1C20DC6
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA9328AA;
	Thu, 23 Nov 2023 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vg6XzRyp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD4DD
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:39:05 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-db057de2b77so997906276.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700757544; x=1701362344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILiBl3fw2ItmQ6qveZxg3Js/iA8qtmzSnw1HvX8bqaw=;
        b=vg6XzRypjX5xFTrQJC5rhS1YGwLkhjI5wjutcbK507mwytE1SQeMe6HYWUhpkQakC0
         qzBGi/kO7vJ1b2tn7bMrJEFafZRWikYAK4E6CqHmYndjr8eVIa456Mbz9xitZdfkUaq0
         3PbZ7EJ0W5rSrfaEtO6L34V2KqvUD4LafDP/GKJvJcWdWJ0vCxlEbYCfjDhDF2Zs63mM
         j5CEApFfPNkirRoZDbgX3jCmM/8STFZi4AwIdr5hgbLUp8ir5Uj/EdCSYujuPYH5Nt96
         KkOkbvXz3bS/TAcCMeW1HY1ywvofzvMaKDUCpKVj1kXx0XdvHT91C/lPlNih2Di23HDW
         22IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757544; x=1701362344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILiBl3fw2ItmQ6qveZxg3Js/iA8qtmzSnw1HvX8bqaw=;
        b=UWe3TkETAtUA0nQ4GYonaql2N7ubD/eWYr60V5pD/Lyh1DEm28gniC2XH1iMUXPIGB
         uSLBCxrr7yQjz4xjv2GXCWwBt7JpbvxZ7pOpitWEUGL9nNTRA27RedNR6Nwyjj4e/8/O
         I931ICNqZ+7S5AEfijCcoF2qjfuitiU4HosBfofVaEfqHS74mHaXD7YjLIGB6J7gq6ww
         oQWd4Vn89lQ573SDBqza8OeuzMsq6xU3NIt/ucNvBeCipEmirjjx/XsLphjHMScPLgJw
         UxnpiojVHoPN2xr63F6nWc7twEHZ8odxp7Zka3xkHR+CJx6mOWve+ST+BB87ZtFpnsjB
         IWjg==
X-Gm-Message-State: AOJu0YwH8YVT19fW/8VuiyZpOpxoGDLM2zSr8A5xGK+6mTx5e717hEGt
	r6tQIbQAcZk79vGWG+Yxexc2WTaHyojNTMWFKfnmsQ==
X-Google-Smtp-Source: AGHT+IHyEIVYlN4F4vyQBH9BTfFozPqgQ9H3YOtEeJFgrrYDbBBfTUFwzsGY/k+etU5uqbsqanAFeQTZObkfBoTvB+c=
X-Received: by 2002:a25:8188:0:b0:d9a:6669:68ce with SMTP id
 p8-20020a258188000000b00d9a666968cemr5853600ybk.32.1700757544266; Thu, 23 Nov
 2023 08:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
 <20231123-topic-amlogic-upstream-isp-pmdomain-v2-1-61f2fcf709e5@linaro.org> <20dee547-8358-4af4-ba90-c5e9a7367c48@linaro.org>
In-Reply-To: <20dee547-8358-4af4-ba90-c5e9a7367c48@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 17:38:27 +0100
Message-ID: <CAPDyKFqcq4F_HtCOomiZK+X1me8KK1i6y9mXjn-Bzg9COzS-aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: meson-g12a-power: document ISP
 power domain
To: neil.armstrong@linaro.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 17:19, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 23/11/2023 17:17, Neil Armstrong wrote:
> > Add MIPI ISP power domain ID to the G12A Power domains bindings header
> >
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >   include/dt-bindings/power/meson-g12a-power.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
> > index 44ec0c50e340..01fd0ac4dd08 100644
> > --- a/include/dt-bindings/power/meson-g12a-power.h
> > +++ b/include/dt-bindings/power/meson-g12a-power.h
> > @@ -10,5 +10,6 @@
> >   #define PWRC_G12A_VPU_ID            0
> >   #define PWRC_G12A_ETH_ID            1
> >   #define PWRC_G12A_NNA_ID            2
> > +#define PWRC_G12A_ISP_ID             3
> >
> >   #endif
> >
>
> I forgot:
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> If needed I can send a v4 with those added...

No problem, I will add the tags when applying.

Kind regards
Uffe

