Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91377AAD2
	for <lists+linux-pm@lfdr.de>; Sun, 13 Aug 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjHMTMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Aug 2023 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjHMTMy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Aug 2023 15:12:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6FEEA
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 12:12:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso5935241e87.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2023 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691953974; x=1692558774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWAwLCIfCahvMHuC9MGhuZ1YxyXXpQRWsB/LQjc7rmM=;
        b=5TOFcFK7OBs9r+360d93HLi5NQ2gd2bCBrjdn7VrtwXcq9QlQL8VA82Tuv+f1fc+Nw
         njCyyt0vOfmqPG+9aPj3ZD6Pu/0T3nwvDk63k8YZWSDgamAfwhVRxOLnpBj6Ly8hYwbf
         pfAFEKjZmCHMonpPM60bnvkL8gEaBw6RFmeCoPGyXX/JlqK5crYsGHjCneXHt69kU4lU
         Sm+a+8nRQkEMn4b/H6+5koMIBdX5LjE6w8z7e+LsQj5G4/nxJPLZ8IDWXTBATmLLI6yM
         HUDQZfGBgDQZK4fSndd7WQAkU37JGjeVLZ9cKfKy8Mjls1C/9vg+EmyiT0L3ylbYQN8C
         p21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953974; x=1692558774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWAwLCIfCahvMHuC9MGhuZ1YxyXXpQRWsB/LQjc7rmM=;
        b=IsPRfnOPcLja+CkPhd2bGoUN+z4ofECuOjtQXil58zAQYHnpMq6T9LJAe9lriXcBJq
         DR+Nd0zSd+q0fDxmBBBrdw7c2M1hhBQW5W3eObPtpINZuIcwApu7ICYxdI392uk+znVs
         j382wUQDI45tXm8BorPdld9HoyeX26IT2uxkn/K5NJ8BIYU/LbLB/DkWrzO3Zr2Q0VU/
         SfJaUeLP7zHm88XVJ7P0fmSnHahfTnQ7mjGY0tZMjn9BRoflMVS9lRh4lH5TV/BgCAUg
         3QSfiJl46tFwoHUR/vDJ/qmOjcUm4Q7O0gwV4i26Sz9xEwsnx5X2xeRlEEqgzjl6zTX8
         hV4g==
X-Gm-Message-State: AOJu0YxTkWuuuZK61R102QDaGt+rOA+hG51y8Wny5TEnDPLcAN001pOm
        /0AdEXVtPg/i27Oc3fjnnwZ1OuFGlxFrryzUNYo1jg==
X-Google-Smtp-Source: AGHT+IEObO5DkVrfyAcAS7dtnYFOpV7QOvPWQC9Pz9LfSja4u5ttXygAkEAKqRnR6kPvEFwK3/YovyhAvZ/bCXFx/t8=
X-Received: by 2002:a05:6512:3193:b0:4fe:1ac9:fe5a with SMTP id
 i19-20020a056512319300b004fe1ac9fe5amr6919745lfe.39.1691953974530; Sun, 13
 Aug 2023 12:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230811191548.3340-1-aboutphysycs@gmail.com>
In-Reply-To: <20230811191548.3340-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Sun, 13 Aug 2023 22:12:43 +0300
Message-ID: <CAH3L5QrpWpxVL3LA_omJiHhs2KKB2e71qiEy_0n32wF7ZR9O7w@mail.gmail.com>
Subject: Re: [PATCH] thermal: max77620_thermal: removed unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 11, 2023 at 10:16=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail=
.com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

I was (at first) tempted to say that this may be reduced to "return
devm_request_threaded_irq(...)", but after a while, I thought that
this is quite fine on it's own.
Just removing the 'platform_set_drvdata(...)' does add a bit of neat
symmetry to the code.

So

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>


> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/thermal/max77620_thermal.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max7762=
0_thermal.c
> index 61c7622d9945..919b6ee208d8 100644
> --- a/drivers/thermal/max77620_thermal.c
> +++ b/drivers/thermal/max77620_thermal.c
> @@ -139,8 +139,6 @@ static int max77620_thermal_probe(struct platform_dev=
ice *pdev)
>                 return ret;
>         }
>
> -       platform_set_drvdata(pdev, mtherm);
> -
>         return 0;
>  }
>
> --
> 2.34.1
>
