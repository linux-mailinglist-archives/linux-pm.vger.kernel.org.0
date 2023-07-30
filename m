Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ADA76859F
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jul 2023 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjG3Ndl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jul 2023 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjG3Ndk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jul 2023 09:33:40 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F010FF
        for <linux-pm@vger.kernel.org>; Sun, 30 Jul 2023 06:33:39 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5861116fd74so1833967b3.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Jul 2023 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690724018; x=1691328818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OtNl12nbv4hnnmWMRlJdur9PhpP3nspNUoZ4quDWp7A=;
        b=OhNKPLVYXDcMJuVuqMvYujB1oxv+v9rpcB9NXnKHOqzO6olODYAW63RsDPpaoiFfbn
         fL8JviMaFNnrce66Pc5zaI2NIXa3oabpCpYg3nF6Q0asSBUKHNn2ajBuAg1Xd2zz5GA2
         idq7viHLl2jGO8WbLuvPShi8Hcv/F7UgS93jjib41b6gTg/X/YPNpz82P/gR2IAHZxmr
         wrDoRKYHBNnnESOkwxQufKFHMLXh0bTxlMtzw3cDXn779okDtbbdSJJwVyiqWvanfgoa
         hhOVb3iOPFv9dNe8ACfCkTWUUcZ/tsswe2f+8AiQ5pPLKOPoqp0UdPkPn/CJ2jSmuoPT
         ZpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690724018; x=1691328818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtNl12nbv4hnnmWMRlJdur9PhpP3nspNUoZ4quDWp7A=;
        b=hCrwgzbzmUButfr0aYnG82BVeTUcGiKAU4h/7z3emQQfqylhb5u/lRYQCM5FaSDgT4
         m3Neb692uKumIPDMP00a32FvccCQxzy++Vzi0eZGDpr4eL/q1ZryeAeT3XhARhmd4B01
         slNYx/GijiNohYYcu/6GODKDUqlfRCv7gIJ/zMBscKDuVibhoiEwuRNJQR83PyGWvTp1
         5dNzVO9BJQZ8upEI3hUrT7jZGbBxcygtrpKRhKWRtQjmy+KE3bmMgWOISQWWtjIiYPEa
         BPcR8wiOXF3X5yHqB92pue3Bv+htyugDxZdrYwGlxo2yQXw6MnHDQZqjUQSqmVItqaOy
         xJaw==
X-Gm-Message-State: ABy/qLYCANq1p4oy5bpENF33bv/4AG6jpV++rh74jG+p6d8WpWuUSuBN
        GN4yPLr76K7yS6Romi60tWEL1tDhh/d9smCcYOrl4Q==
X-Google-Smtp-Source: APBJJlGK2ghLVBLAX/CXOTseKd/smCssV1QKYSZWmN/L7EStKZyaXlIvK74ktdZzWflb1vC2uH1y9HggjCb2+udGz9o=
X-Received: by 2002:a81:7c88:0:b0:561:a123:1041 with SMTP id
 x130-20020a817c88000000b00561a1231041mr5867849ywc.29.1690724018385; Sun, 30
 Jul 2023 06:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230720090443.503525-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230720090443.503525-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sun, 30 Jul 2023 15:32:50 +0200
Message-ID: <CAPDyKFoAvrRTZ+kJmPr8sdRPxF=0Jg+CEMLQyKTnDaviSGO2fw@mail.gmail.com>
Subject: Re: [PATCH V2] genpd: Makefile: build imx
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 20 Jul 2023 at 10:59, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The imx genpd was missed to be built out, add it in Makefile
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks for fixing this!

Applied for next, thanks!

Kind regards
Uffe

> ---
>
> V2:
>  Drop scu-pd change
>
>  drivers/genpd/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> index c429485c13f6..666753676e5c 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -3,6 +3,7 @@ obj-y                                   += actions/
>  obj-y                                  += amlogic/
>  obj-y                                  += apple/
>  obj-y                                  += bcm/
> +obj-y                                  += imx/
>  obj-y                                  += mediatek/
>  obj-y                                  += qcom/
>  obj-y                                  += renesas/
> --
> 2.37.1
>
