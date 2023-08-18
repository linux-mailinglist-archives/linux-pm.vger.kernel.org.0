Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40255780808
	for <lists+linux-pm@lfdr.de>; Fri, 18 Aug 2023 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358956AbjHRJK4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Aug 2023 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358961AbjHRJKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Aug 2023 05:10:41 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F7530E6
        for <linux-pm@vger.kernel.org>; Fri, 18 Aug 2023 02:10:39 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7225259f52so734513276.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Aug 2023 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692349838; x=1692954638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kVu/aeTA+55HR39FC0HYYhqcrjVArFZelI78cd0qrGw=;
        b=AoHzgcMuoqLJASg65gXIsk1fhSlU9Ers8x8PXjcFqU8zvMg4pJezjgmP1h4zhhvAIW
         riKkRGIBVVWmxi2mzm9r8943kEuc+7RrXmFRHUpmeGpQqc3C3KVJqm+OzFbuJmzg6EYo
         7/kxfmwtlxfYQ6ezUv5KJXjYbJISzIhhRisYZfvWB4PCKY/AZMiY3l4YtDqw7IFsO9YR
         FothCZW1LZDGsPITD3/Imf7+eJkD26h9t0d68/Kg75QFgHOEC2VjflSAL+8WbdTjLGyR
         YZOEIh62a7N0Soab1RTiQ00/8PJtEhrDOcN3aQTd3INYZ1ZW8f3/FMDTHExqLAvNwhvl
         V2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349838; x=1692954638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVu/aeTA+55HR39FC0HYYhqcrjVArFZelI78cd0qrGw=;
        b=QAxZ9WvTcMIXwso4WNFEre560NHbkjzATyqhtx+Bqa+jOwYu3nL0HHLrcYwxUnxh4c
         ee78UmTAKJu0UzqgiobnhD4nEpk++N9RktSXKvzhFVd8ZfqVoGbjjOVrVh1dA7yIOYX/
         GYa0rCgH3kGFiPashG8RVEw2znR5pD26/THSdhOo9uryspNezTXvWWEIGQE0myNIY3Hv
         PDnnJBO56nkR0/7jQ4J07eyrF/9f6owciNekY7TUn3IkEnuHyk2vpNq3IOABdt7aCine
         X8zgvEElz0P7SwtSgaPnjsovJgAgpCq4Ga7yimvgHQWNKobTkqw7n3+SSLYxnLffyswJ
         LiSg==
X-Gm-Message-State: AOJu0YzFf8rtdOjzG9LmAgDnJwt2hz4KAUg5VDrRLmwLunDQX8+005bZ
        dRss/7YTclaVa8Em11YVSg1K9QKw/ecRueEhloFJnQ==
X-Google-Smtp-Source: AGHT+IFvKL90uy8b8Tk8GOqFI3dUEmc7l5zSklXm+O1HQNrueZGc8Nuj/Y/o56+fyc/vhKd4goKBjW0vg3fbuhSWJ50=
X-Received: by 2002:a25:dccc:0:b0:d4d:d260:44bf with SMTP id
 y195-20020a25dccc000000b00d4dd26044bfmr2075531ybe.59.1692349838558; Fri, 18
 Aug 2023 02:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230818070149.23103-1-zhangzekun11@huawei.com>
In-Reply-To: <20230818070149.23103-1-zhangzekun11@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Aug 2023 11:10:02 +0200
Message-ID: <CAPDyKFrL86MdfUwYm9UWy4AZtWBq0j_6sP8rimF7fwEXh0XtRw@mail.gmail.com>
Subject: Re: [PATCH] soc: ti: Use for_each_node_with_property() simplify code logic
To:     Zhang Zekun <zhangzekun11@huawei.com>
Cc:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Aug 2023 at 09:10, Zhang Zekun <zhangzekun11@huawei.com> wrote:
>
> Introduct for_each_node_with_property() to iterate through the
> nodes, this can simplify the code logic a bit, no functional
> change here.

I would prefer if we can start using the prefix "genpd: ti*" for the
commit message header.

>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

This looks good to me and I can pick it up, but awaiting and ack from
the soc maintainers too.

Kind regards
Uffe

> ---
>  drivers/genpd/ti/ti_sci_pm_domains.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/genpd/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
> index a33ec7eaf23d..34645104fe45 100644
> --- a/drivers/genpd/ti/ti_sci_pm_domains.c
> +++ b/drivers/genpd/ti/ti_sci_pm_domains.c
> @@ -119,7 +119,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct ti_sci_genpd_provider *pd_provider;
>         struct ti_sci_pm_domain *pd;
> -       struct device_node *np = NULL;
> +       struct device_node *np;
>         struct of_phandle_args args;
>         int ret;
>         u32 max_id = 0;
> @@ -138,11 +138,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>         INIT_LIST_HEAD(&pd_provider->pd_list);
>
>         /* Find highest device ID used for power domains */
> -       while (1) {
> -               np = of_find_node_with_property(np, "power-domains");
> -               if (!np)
> -                       break;
> -
> +       for_each_node_with_property(np, "power-domains") {
>                 index = 0;
>
>                 while (1) {
> --
> 2.17.1
>
