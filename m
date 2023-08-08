Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B76773B58
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjHHPtK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjHHPrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 11:47:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E97213E
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 08:41:39 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7679ea01e16so465425185a.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509283; x=1692114083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KdNPcZqmtXQcuBkzS9CoNBBYMwWbfur9izXMF+UKcpU=;
        b=ldkyb9mZl3eVGgpbNM9Es3hEufCVn9WXixRVYLlhLt3s1xote04QkrDoy5eAmt+s/X
         SewTxW/pxGRUQ1x9T9Mn7RzWL94L+8OH1VFmGEuvgq28WdOB7ovUPyLcKPlicxV4VE39
         8mYDPjO+BI2HUP0UmyOpw3mwzqYb4EabiJYH6JLMQnnxlpV3/EvCE+rAZVE+vw9DoAaz
         U+0gASAok8EtxQpqqP0KSFxuHWYZqfN5y582q0PA5M+r59gNSAcAyMO6PF3xT/bip94M
         QuHSm9mvSsg4eRdXnUzMU5PG62VvGXz+UOki/enOSY+dGIdP4SNsN/6CdMvE8Vz/Wb4R
         Ddkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509283; x=1692114083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdNPcZqmtXQcuBkzS9CoNBBYMwWbfur9izXMF+UKcpU=;
        b=CGA1acDoN/q/2ewAPDsLVBwB6LA76lHfowxJuCOe6/t/KtR+ptZyIhdVCRxkGU6zhu
         TpBF3j1O4dKceJebcWsgUWUESSVkdQnipY5beINg6ZkbY/yuxIiE0U6q5M8Q/15L7cc7
         9xlJ+M18v9AidhTjoTemTeO78c1SwPdXDf4eLmOF3+HP3kU1mreNnfughIKIpJD8mbSf
         DbZAruAzbj86IjMCO8fTXe2hXfN+sZOSj9hFk0TqeDfdhB0srzPHlQXe3MKY5Xtatg0t
         biJ96LY2h5LyfomzlXGvzfQJiRmMrbEv8MxBif1N6oLksDyWdZYO/9gh88y32dG3hKL5
         zPHQ==
X-Gm-Message-State: AOJu0YxiNurp+ZSu40QCU9uAyayk3meXAWQqQ0zhazCke9GXtdvvfcDf
        UIeKRSWs7XXZvt+a+4T29k91as0hVh5I5a9jyBREoDJqnZbA9dLtQHU=
X-Google-Smtp-Source: AGHT+IGuyTfHVUm0ldXaXrpMjSkfrIAQhLkFo1ndJ+yOlR8TxUe3HqDJUGXb27eojG4uRIDIwVCqRszIGFSQKMDYZi8=
X-Received: by 2002:a25:ced1:0:b0:c6f:b2de:21ba with SMTP id
 x200-20020a25ced1000000b00c6fb2de21bamr11990109ybe.17.1691507553159; Tue, 08
 Aug 2023 08:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230731122611.4309-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230731122611.4309-1-lukas.bulwahn@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 17:11:56 +0200
Message-ID: <CAPDyKFpffTGpiQ5PSyKm+hcVntE==SH6O0XnvafgyReXwxNT_g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in STARFIVE JH71XX PMU
 CONTROLLER DRIVER
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Arnd

On Mon, 31 Jul 2023 at 14:26, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit f3fb16291f48 ("soc: starfive: Move the power-domain driver to the
> genpd dir") moves:
>
>   drivers/{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c}
>
> However, the update to the file entry in MAINTAINERS only addresses the
> move in directories, but misses the renaming from jh71xx_pmu.c to
> jh71xx-pmu.c. Hence, ./scripts/get_maintainer.pl --self-test=patterns
> complains about a broken reference.
>
> Adjust the file entry in STARFIVE JH71XX PMU CONTROLLER DRIVER.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied for next (and the immutable branch) to my new genpd tree [1], thanks!

Kind regards
Uffe

[1]

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 003b0461641a..7a20d6ab1d18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20408,7 +20408,7 @@ M:      Walker Chen <walker.chen@starfivetech.com>
>  M:     Changhuang Liang <changhuang.liang@starfivetech.com>
>  S:     Supported
>  F:     Documentation/devicetree/bindings/power/starfive*
> -F:     drivers/genpd/starfive/jh71xx_pmu.c
> +F:     drivers/genpd/starfive/jh71xx-pmu.c
>  F:     include/dt-bindings/power/starfive,jh7110-pmu.h
>
>  STARFIVE SOC DRIVERS
> --
> 2.17.1
>
