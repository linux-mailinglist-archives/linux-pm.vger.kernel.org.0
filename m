Return-Path: <linux-pm+bounces-917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA7480DC12
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 21:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372EC1F21216
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067C5466F;
	Mon, 11 Dec 2023 20:52:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3CA6;
	Mon, 11 Dec 2023 12:52:43 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d9dcb2cb45so684733a34.1;
        Mon, 11 Dec 2023 12:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327963; x=1702932763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CykTHh1hqBcv3lKDskZucqp2rC4spPVBJz+bCkyVI0Y=;
        b=OWeJ1uiDJH3gs+wCkd9zoTS0+DDTXZIip7H61WgZQ7OA7FXPw9V1GSJMFdBHv++D4d
         ROFDqdBtInWYKHat3oR+9YmItScY3hEHejS5aS7VXG1GXiX87rPQdaoMau4McAwTVnor
         ihg5rx1qMbolpmYMSjwjBZHecL69vseg/2LKSH+r/9IXJLG+TzL1CGnpqqxUK0TK2zlb
         BC1fXf9DGJNuPhmAnsNDkfs5BiRgC7pToLbVU+NF5wUdZ2gNJhEmgkbSOfKZFLwHsO19
         A3Zbu2iEm5kgqW96z5iezpuWoZdxOoMTM6a/OFZLRZNqTXgOka6SHjHLcD6lQhMsETr/
         O98g==
X-Gm-Message-State: AOJu0Yy1ekGqqz3Fq7m4uNvShN9MIPKMNj+XpF22V40izWPBvH6PwVw+
	yquPqImsjJMFfAV7v3539n71c59W1teNQQeCgw67wrEr
X-Google-Smtp-Source: AGHT+IFiPTo3RDtP82ZwRSC8e4XK+Lt0aEs8qo9f/K5fbtrpNzhp0pRvpS807F8FJY7idqMywszjXwC+xT4Tilxbgr4=
X-Received: by 2002:a05:6871:208c:b0:1fb:19d6:8715 with SMTP id
 ry12-20020a056871208c00b001fb19d68715mr9409171oab.4.1702327963105; Mon, 11
 Dec 2023 12:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116132619.69500-1-bo.ye@mediatek.com>
In-Reply-To: <20231116132619.69500-1-bo.ye@mediatek.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 21:52:31 +0100
Message-ID: <CAJZ5v0hP6VRKmBy9gSPkg82w+g7wwQBVGs6gHDW9BJnr-qrBnw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: idle exit_latency overflow
To: Bo Ye <bo.ye@mediatek.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, yongdong.zhang@mediatek.com, 
	mtk24676 <C.Cheng@mediatek.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 2:26=E2=80=AFPM Bo Ye <bo.ye@mediatek.com> wrote:
>
> From: mtk24676 <C.Cheng@mediatek.com>
>
> In detail:
> In kernel-6.1, in the __cpuidle_driver_init function in
> driver/cpuidle/driver.c, there is a line of code that causes
> an overflow. The line is s->exit_latency_ns =3D s->exit_latency
> * NSEC_PER_USEC. The overflow occurs because the product of an
> int type and a constant exceeds the range of the int type.

In general, but does it actually occur in that code?  IOW, is there
any system for which the exit latency of an idle state is so large
that it will trigger the overflow, for example?

> In C language, when you perform a multiplication operation, if
> both operands are of int type, the multiplication operation is
> performed on the int type, and then the result is converted to
> the target type.

Right, that's how C works.

> This means that if the product of int type
> multiplication exceeds the range that int type can represent,
> an overflow will occur even if you store the result in a
> variable of int64_t type.

True.  However, does this really happen in the particular case at hand?

If not, it would be better to say something like "For a multiplication
of two int values, it is better to use mul_u32_u32() that prevents
overflows from occurring."

> Signed-off-by: mtk24676 <C.Cheng@mediatek.com>
> Signed-off-by: bo.ye <bo.ye@mediatek.com>
> ---
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index d9cda7f..631ca16 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -187,7 +187,7 @@
>                         s->target_residency =3D div_u64(s->target_residen=
cy_ns, NSEC_PER_USEC);
>
>                 if (s->exit_latency > 0)
> -                       s->exit_latency_ns =3D s->exit_latency * NSEC_PER=
_USEC;
> +                       s->exit_latency_ns =3D (u64)s->exit_latency * NSE=
C_PER_USEC;

mul_u32_u32()/?

>                 else if (s->exit_latency_ns < 0)
>                         s->exit_latency_ns =3D  0;
>                 else

