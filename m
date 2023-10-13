Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B417E7C8F0C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 23:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJMVaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 17:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMVaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 17:30:14 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFFDB7
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 14:30:12 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-419b53acc11so35941cf.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697232611; x=1697837411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAFhh0UnBjMrpFbTC5AXbZwOOdusiznbF8lSwFMaVaE=;
        b=bnySvF2PI3SYjja3YZWxTqdLncedf11lm45Vuucqhv0b5MH2ODTOnLG/p1f4toEwgD
         m7unZwSSu0V0H5mQ3cYxk3mfkzwdwDSPcg3tiWFtxVMMkIEstrSZOHPM5Ur9zPKv95fM
         F1rcPJ2o5upGlRmF+yLy1mWTT9ASbnB235N1Vsj6S/2Z48ijIbUpg7zUHI23ADAQQl1+
         /DOMa+Zc+l9gFN99qSQ7xnAPPSBxUS4P4Z13HWCO3LT/fbvmoKGQ0eIHlAt5Hesxe8Fy
         fsTPXXc2S/zPdPWuAUmGADN4aAd4dgHxS23aaZts5No268Y4mLwv6O8Df4naXtUlcpQi
         /QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232611; x=1697837411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAFhh0UnBjMrpFbTC5AXbZwOOdusiznbF8lSwFMaVaE=;
        b=AR1r7H31cvcq9Yh8cryGdjLAki65BeFCi5yTCTTU2kJGrtlhqlYfyHBlRbkZS1eZ5J
         3rr8pSQJcg6eSgDhQk35XRA4afUD+o9FN76Gh+lbAtua3VkumUsUcng206znhj/k7fta
         BXwzvdwNe1iTMA6Af7qhz9jxXhxyHPCFxTdPix7B2IcxQZqLax/G/rt8ojHh4Pg05ruJ
         YDk2udYZEHPlgV9d6bu+1D9afIVW4i6EwG5jX6azCBSQrIiBbc/kRfVGHK+EhqFfiryH
         FtDfxg7jsNF2vxEWSv4+3oTN82eqmPzUtrujwBbgWmyLTKjocVR2VRX026oPwibTIh2G
         KMjw==
X-Gm-Message-State: AOJu0YzYqqOrEuqRsu309zDCLVmmPD/gLgKn0dju8R4cSeXE/9PS1cnk
        xepOppY2aD32zhp4oVBrU91YBHzY9oS0R6h8i9sP4A==
X-Google-Smtp-Source: AGHT+IF4Z+15fJ9zlezugWUa6Y7qSQixakl5BbpSQAF0GpLbjLvXXPWs6Dm/F13K9ZY2NPOpTn0J3CMZt0JHWcrYsPo=
X-Received: by 2002:ac8:5e8c:0:b0:3fa:3c8f:3435 with SMTP id
 r12-20020ac85e8c000000b003fa3c8f3435mr2108qtx.27.1697232611523; Fri, 13 Oct
 2023 14:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231012132214.257207-1-emkan@prevas.dk>
In-Reply-To: <20231012132214.257207-1-emkan@prevas.dk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 Oct 2023 14:29:35 -0700
Message-ID: <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
To:     Emil Kronborg Andersen <emkan@prevas.dk>
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 12, 2023 at 6:22=E2=80=AFAM Emil Kronborg Andersen <emkan@preva=
s.dk> wrote:
>
> Before commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> detection more robust"), consumer devices without their fwnode set
> printed errors like the one below:
>
> [    1.039830] imx-gpc 20dc000.gpc: Failed to create device link (0x180) =
with 20c8000.anatop:regulator-vddpu
>
> To fix this, set the fwnode so fw_devlink can find and handle it
> properly.
>
> Signed-off-by: Emil Kronborg Andersen <emkan@prevas.dk>
> ---
>  drivers/pmdomain/imx/gpc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 90a8b2c0676f..8759eab72880 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -411,6 +411,8 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>         void __iomem *base;
>         int ret;
>
> +       device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
> +

Similar question as the other patch. Can we do this at a pmdomain
framework level instead of per driver?

-Saravana

>         pgc_node =3D of_get_child_by_name(pdev->dev.of_node, "pgc");
>
>         /* bail out if DT too old and doesn't provide the necessary info =
*/
> --
> 2.41.0
>
