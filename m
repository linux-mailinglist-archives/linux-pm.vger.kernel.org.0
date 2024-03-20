Return-Path: <linux-pm+bounces-5151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE34888124D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 14:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1867328536A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA93BBF7;
	Wed, 20 Mar 2024 13:28:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5DE40BEF;
	Wed, 20 Mar 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941284; cv=none; b=RbZdsf0eoN4twDIPipsUBC7iqEn6yoXuuQ7VxWmBQjLMek+16RcHWCiQscf+Lcw15VxneAMHuG2cpLCA8qE6AWhDcUfjKKRcSI20Pd9LnyieE3kJqrhRfaEcb8thutumaHrnH1XlmSOdp2tRwJE0gLzDFe60Vl1Z/eU/lSKtUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941284; c=relaxed/simple;
	bh=SAS8x5+vV8kmt+Bdh1g/hpo40/8FHlAWGl6PFgxzYzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnk/jr0Ss3mKCJH4FaAvkKXptNBu3q8pYe0NX5I3JbyYYG7tKyB07WvSZmI07CNZYPeDMrWKRMT6pDRXPmOYYhKTuCg34CnT82Phn+owzm0i3JKZynfDO+a3y5E3TRfwt4R05XFuA3J3pdarZ9kH9NAH4dnhaZcIwrhxo+QCCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60fff981e2aso46004127b3.3;
        Wed, 20 Mar 2024 06:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941281; x=1711546081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WY9EZgJoIoiyjehzdgc6Ws3JFp3jjq1yIwTafZ9ZenY=;
        b=JeF4nd9jzVYsRAr/mCNUiMsvC/QrupLbyj4XctXv2wxhW9AVHKlbLUPtTyqrXOCBdo
         RW9T5VUVTzTclGpSBKRps0mlE2c+K0OeQtQ3iAaC2m4MWvPACuYkSUzCyXCMuuOH3TNY
         +cuwd/B+hnnk7XWB6IhOj1GK4XzN0eFfegz4FXOEzyFDLmSBrU37iWHwUJl3T1uLVTTF
         K1YCJ65kexSvCFjmvNCWTjMPiSoo3LiKGhiDvL470SDgKLUv/Fj1OEY5+T9AAzxDS/MN
         zYFc+wYBXn7KAv0LKhrfy3KTPdc1IKtXjuCd1jDelBqEej0RqWClPlyutrjS8LIgOHrY
         t97Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJR5/6sbbXpCixVY3WSlaIFVKp5v1eU4/KJJUCw+opcwWZO2rAhLmTtu9UW3HREpA6eGAs9XSon1fS1y3+0meqfV0KH9F7u71Dw41surEex/74qJf9VkLGlHQA2T1th85ZdhP1EIk9TYTprA==
X-Gm-Message-State: AOJu0Yy6qr9Zw1ooBnbrRg+e8+qAIBAi5K8MXsF2Z6zdCZ/cnRudv2FC
	JcboBGTY0xsB74z/Cw3m8RD9hSvalq8szTa6SJq53VlEWRXHLnrZnCWy40mGWtc=
X-Google-Smtp-Source: AGHT+IGosTwMaPAtxyWnENGp4eaRCQEtzHv/pPFj121m0U7IePhOOLhGdl0gqcnpEuAyrapXPm0vnA==
X-Received: by 2002:a0d:e8c7:0:b0:609:fa49:2112 with SMTP id r190-20020a0de8c7000000b00609fa492112mr18202851ywe.27.1710941280990;
        Wed, 20 Mar 2024 06:28:00 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id et13-20020a05690c2e0d00b00609f45c6b89sm2754331ywb.88.2024.03.20.06.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 06:28:00 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60fff981e2aso46003727b3.3;
        Wed, 20 Mar 2024 06:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVB5CfkQ2lRsSZIUBH4XGBpNv6dX9qaKG+9b5w1OAigYdhPuljDuIZk1axyCThudB5apiUcyPQ/ESLucMlKNbRwe2oFX6w9/hWw+0wL5rd5MbWUseHTUpWXgFtAwmApr1NffJiZmsn2ojaP3w==
X-Received: by 2002:a0d:e601:0:b0:60a:bb3:1b0a with SMTP id
 p1-20020a0de601000000b0060a0bb31b0amr15538370ywe.14.1710941280502; Wed, 20
 Mar 2024 06:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110216.2962918-1-niklas.soderlund+renesas@ragnatech.se> <20240307110216.2962918-4-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20240307110216.2962918-4-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 14:27:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVkpBpNt4NeE6Uhs4AMivcdv_+uFSyoV8U0Ym59PaW0fQ@mail.gmail.com>
Message-ID: <CAMuHMdVkpBpNt4NeE6Uhs4AMivcdv_+uFSyoV8U0Ym59PaW0fQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal: rcar_gen3: Increase granularity of readings
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:03=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Later versions of the datasheet (Gen3 rev 2.30) have examples of
> temperature approximations with one decimal. Increase the granularity
> when reporting temperatures to match this.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

