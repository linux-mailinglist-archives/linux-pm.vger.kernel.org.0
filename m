Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B474B317
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjGGOdw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjGGOdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:33:47 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B801FC6
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:33:46 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57045429f76so24089737b3.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688740426; x=1691332426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WekvXAmU0QQVL2ZEw2tjkX0EAjaAPbaYREDimQcMGk=;
        b=Dq5C0e56lUdmmh/1HJppW/d7Qr/tEUwD3D7yPUh+hUT+id+ADBmK6/LvwANK3RsGG0
         hnvnQK6g83sJiMF6eePm9WZ/M8QEMXJQehXKZIbq83ahUYIcDSmX3lbe3lSpssAx6vFk
         MsDSamW/EQgrEWV/3FN41EMapTD2PDD8utM6pYgJEPyRfbsM2cn6mKcI12HKBiuqH4n2
         hzJsTbOW1d3oo/Hg8iIEgvMGDHzKpDXjSIHRn+KCmTARBgm2ssbHTw0g4t8yFo3JhxAU
         nFs7cAZGDldUNodW8TUhlgxgYL4RAHczsu4lTm422IaY5kOew8qJ3KuDpK5W6hGkeE5+
         4Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688740426; x=1691332426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WekvXAmU0QQVL2ZEw2tjkX0EAjaAPbaYREDimQcMGk=;
        b=eE8rPkpZuo/e/alKlk/p9menr4CrP6DtMHP3P+5GohVsdWi/dnl5sa9h+oZv7zqh1/
         nQl0l9tQh9KDJ2GRJwzh6srUG3A5yu2fUSZzlqSSLLfYTA3yifjYS2QWeIAw0XI/QTak
         2Nz6+jtabltyaS4BknIhFOpq32CDyDg9r3NmCkRuAWwS52Ub1zHnDLKSev0hAlcUndN+
         EFejXwX3A9qly3S+nxGW2/p2hijKqg+7BpIuDoCLW7kmGQBZNcIfwIAssbPM/VZX+nbD
         rsSXNrjdcZbgD3Y2P4wdm6HQZ3rftNJwXMO74HtYB+anJ/GlcDXLPTnp7AkSGj7k8Kf8
         sMPw==
X-Gm-Message-State: ABy/qLbWmDgQYs0h93LBRQwdtjIyO7VCS8ZXTVHWEkSNwBg1bnEG9hF5
        XN55tAbxfGloqZ+AAJtWwlvbNf5JN5fi2kPZC8aGFA==
X-Google-Smtp-Source: APBJJlFQodjakzRWF8WW0DCaumWalOESZwzgo6hb6I5dEQD49XSPTIEw4ttkvMpWuNZ565vLnSKAh8JEv5CG1I743dM=
X-Received: by 2002:a25:1483:0:b0:c66:4ffb:69f7 with SMTP id
 125-20020a251483000000b00c664ffb69f7mr4370202ybu.52.1688740424904; Fri, 07
 Jul 2023 07:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-7-ulf.hansson@linaro.org> <CAOMZO5Df5bHGy6-kTKwysSe6Kp7e2HNn+uhOD2E6MT+cDkS07A@mail.gmail.com>
In-Reply-To: <CAOMZO5Df5bHGy6-kTKwysSe6Kp7e2HNn+uhOD2E6MT+cDkS07A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jul 2023 16:33:09 +0200
Message-ID: <CAPDyKFofqTYpYxSiMm173U75nF17tHaZMwbzHum3k1Bj05GrWA@mail.gmail.com>
Subject: Re: [PATCH 06/18] soc: imx: Move power-domain drivers to the genpd dir
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 7 Jul 2023 at 16:25, Fabio Estevam <festevam@gmail.com> wrote:
>
> On Fri, Jul 7, 2023 at 11:04=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: <kernel@pengutronix.de>
> > Cc: <linux-imx@nxp.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> A commit log explaining the motivation would be helpful here.

Right. I was a bit lazy and added motivation only as part of the
commit message in patch 1/18 (and in the cover letter).

I deliberately didn't want to spam everyone with this, but you find it
at the generic linux-kernel list.

>
> With that added:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
> Thanks

Thanks!

Kind regards
Uffe
