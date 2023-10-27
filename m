Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039F97D92FD
	for <lists+linux-pm@lfdr.de>; Fri, 27 Oct 2023 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjJ0JEh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Oct 2023 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345601AbjJ0JEg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2023 05:04:36 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5154B187
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 02:04:33 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2b1af09c5so1116162b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698397472; x=1699002272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NYwW0s2BOh04TrQgARy+ZAGjgN1hKxj4KAq6p+VCH1M=;
        b=JdzLuzE/kXA+cJFjqjEKUZk1e2ob4pThnDvJ4HauNVne3JkJ2WFORj5XtKfraioCTf
         Equ7rI+gR4uKT+R/01RVvTZV6fynB2sARfQf1aUTeNdrhIel3uViRzOZolUYDfeXv0sQ
         7ufR8ctRdufNmHOE7VhtdUAfj1Pmye9Q4yJ6bAbZUbBY3dB/SgxbkDVdD6P1BvEVFloc
         n9Xj/m954G2nsVXcBbdEMnfkX0FXx5Fjywh4aOuj9b049nOUkZwy02JpXtrqx9Up38NR
         41bPZmuxR2Zs5b/Kif7+VKvupS0ZJylVK2/VaToQLPmzqPfvOUj+Y1thAY89XEdJjAPN
         TN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698397472; x=1699002272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYwW0s2BOh04TrQgARy+ZAGjgN1hKxj4KAq6p+VCH1M=;
        b=Kpqr98cRJODqVnnctKnfH+KaxARXqpjolwnj6e3+t9lVnqbkZiw4hCuU0idIv47Ez5
         6CZe6KH8J8fkgI9+SUdE3lw2hsFa3W7frZJRylpE8QOG51StuuD4fcDL/F3koAP3D7no
         di+ss3BFSYhi3JUvNfS7A1rxLIZq86TEksyKtYxTLfwwOTj45Doozk8iap7Vw+/Iij3o
         Iza6WtH8MKUVF02LfqFyGDrYgmCyKKWsRIiRtj2w9ZkrdqHe17juXhFjU0Ir6jsW/eo4
         Rz2zcKIu7/RVtBy+/iJsFa7HnzvXedYAN9TGBk8bPJqaUNC5nBPriEZS58wFN7Hb4UxG
         jhhw==
X-Gm-Message-State: AOJu0YxEc/Lh1nly4F5CPnG6y+pvK8llnLyR9J6r8hOcv3kzwSVLX8t9
        CRMVc0fMCKMjsCHchvs338reIOs9s5Ue3ab9rHh1ag==
X-Google-Smtp-Source: AGHT+IERiaQhDUuJ+K73/pCAPsO3dmX+uBgBKrfXATpvIXv7hztsC5N3Wu7K3OXqiqxsi1yk3Oi/hglez561ytzAqJ4=
X-Received: by 2002:a05:6808:10d2:b0:3ae:156f:d319 with SMTP id
 s18-20020a05680810d200b003ae156fd319mr2312336ois.45.1698397472641; Fri, 27
 Oct 2023 02:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231016080205.41982-1-tomeu@tomeuvizoso.net> <20231016080205.41982-2-tomeu@tomeuvizoso.net>
In-Reply-To: <20231016080205.41982-2-tomeu@tomeuvizoso.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Oct 2023 11:03:53 +0200
Message-ID: <CAPDyKFpecaKQSJCTP5ntm243WTiQ-Y0TpU7x7F8f6Xh74+LT0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: amlogic: Fix mask for the second NNA mem PD domain
To:     Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     linux-kernel@vger.kernel.org, Da Xue <da@libre.computer>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Oct 2023 at 10:02, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>
> Without this change, the NPU hangs when the 8th NN core is used.
>
> It matches what the out-of-tree driver does.
>
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Applied for fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/amlogic/meson-ee-pwrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> index cfb796d40d9d..0dd71cd814c5 100644
> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> @@ -228,7 +228,7 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
>
>  static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
>         { G12A_HHI_NANOQ_MEM_PD_REG0, GENMASK(31, 0) },
> -       { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(23, 0) },
> +       { G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(31, 0) },
>  };
>
>  #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)        \
> --
> 2.41.0
>
