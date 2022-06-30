Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D73A561A5A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiF3Mch (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiF3Mcf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 08:32:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246535265
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 05:32:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3137316bb69so177140557b3.10
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HyMDM1ipDsbO0l2TbDoyOA8pUKl0ZnNBjdUuFHRbh3Q=;
        b=oRrTeAxq4Xjuq7sFm1KX0zZ4X5LjTJU+mdKmIlEVIMB5eaHXkUx7cE6nmMAvR6uoXg
         F9+LD9DMv3DRjZG6MS+00UqbpbZnH/jgyMKv3ULp+3tw22XIK2+X1E+AU3R2iJy8vUXe
         wYJnrgRIimPa31JUyTixitaLebUu2WvqSVgkgJ7rWUDD+YqyQ3ask4b/Afr5eq+6lgMa
         5pMAaXi5SoHBqIwynQyA4NlQiCt31/zJSGP2D7dC6lglhbL0fVNUUEtO7kh2siZx/GXI
         cROxqT9RasWT0Zc4I6+OnXTSamGMfzgfZzyZmAtLXPBrtAPSyUWxSgHJN9a0Zlh7PG5O
         TlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HyMDM1ipDsbO0l2TbDoyOA8pUKl0ZnNBjdUuFHRbh3Q=;
        b=mwiTGUjOx3w7KPVxpNHZqhZikhcuL2avci01Iw0dHA9kWq8uOQClSyoe4ythLa4FYA
         3zL3aOreqe/vP1IQXLkGmi8lDppkHvpz6E+IiLYe1P1eJa+FSigjH/2qai+7QDkcbF3P
         9DDtw4sa8RwFCx53wKeljDDQ1cOe5dsURnAwTvDl7KHZUWxsc4hlH015/A2sYlyfAMQ0
         oScxRAPDZjwusNXXGm15Z76rD/jVyiEqLnG3bxE0HmMmrgTq5EuLJk1AsrEywitoLmRp
         GWozVoEKnzYZCouxwX9JnNEX7z2Vhu3I0UCddzbvO/vphtkMJ/lmS1bK1q6dc6rq3ex6
         Ottg==
X-Gm-Message-State: AJIora9t/uXuWXiDTdXrKfRv1PvCM150HLDr5dbygxX6nMAPk7lTWXH1
        NX9G3iH7tT+aebfowwCjxquADVRYfT5LntPWcbC1AkSzUww=
X-Google-Smtp-Source: AGRyM1sT3ISzQ2vYR5Y12XfUF2QMLK8+b2KOA26vDpjK6ok0YPeQLsyI0Q8Ryf0oNTn2A6bQ7fs4/TEAeVLy6DffVf4=
X-Received: by 2002:a0d:cb88:0:b0:31b:7595:34a7 with SMTP id
 n130-20020a0dcb88000000b0031b759534a7mr10156389ywd.67.1656592354261; Thu, 30
 Jun 2022 05:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-3-daniel.lezcano@linaro.org> <f4b13249-abe8-080f-4d36-24ef67d4fb62@linaro.org>
 <CACRpkdZBUVGP6whu-ojW9KKapeuYKQbXWn1MEpJ33KFav+8zqQ@mail.gmail.com> <0a6c992d-ea88-c3fe-1837-8be4e912d266@linaro.org>
In-Reply-To: <0a6c992d-ea88-c3fe-1837-8be4e912d266@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Jun 2022 14:32:23 +0200
Message-ID: <CAKfTPtBVBDsy3oc1vaSSLwYcz6y2VdT4d-NZzt=QRW+eUMm9tA@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/drivers/u8500: Remove the get_trend function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Jun 2022 at 12:16, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 28/06/2022 14:50, Linus Walleij wrote:
> > On Tue, Jun 28, 2022 at 10:40 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >
> >> Adding Linus who is missing in the recipient list.
> >>
> >>
> >> On 16/06/2022 22:25, Daniel Lezcano wrote:
> >>> The get_trend function relies on the interrupt to set the raising or
> >>> dropping trend. However the interpolated temperature is already givin=
g
> >>> the temperature information to the thermal framework which is able to
> >>> deduce the trend.
> >>>
> >>> Remove the trend code.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > I certainly trust you with this :)
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > The code was originally written by Hongbo Zhang, but co-developed
> > and tested by Vincent Guittot I think, so paging
> > him as well.
>
> Ok, thanks
>
> If Vincent has no concern with this change, I'll queue up the series

I don't have any particular concerns. I'm just curious, are you
planning to remove the get_trend completely from the thermal framework
?

>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
