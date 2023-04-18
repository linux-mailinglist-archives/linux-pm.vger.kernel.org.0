Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB86E5BD3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjDRIPU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 04:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjDRIPU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 04:15:20 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78726E94
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 01:15:15 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-555bc7f6746so3040407b3.6
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681805715; x=1684397715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ga90w5aZN7pc1fzGiYERoAYWb3VLnRbaSw6+nc26HoQ=;
        b=k1+6UORUVvsISmZWX2L3FYvL2kHbjH+EVBIZSZO+7TsML2E6p9om+X6RJLVOasf0Ek
         TYn42uj75ExhcaVZgeQIvkodRprNCucMHW/JEP+kmATJ/wK3nfw2vwhKQUxJ5Qu9/P/D
         moVpRaa1zQoLzKWOYPbX3PnIIBXl2n68FiC6cEQo6UYUabLb5ZKlDyCkWiwUpRWsnJku
         wXrNhGlUtQaBdEdm4vB7dps955jX/3dmjFk0MwyS42FwHgG1tEMLpHh0JK0hJ9NrIMe4
         LpYShVSA2ggN5KvIw4DmLRPrkyujFhzNfiCE+70+Wx0WPgJwlw6Y9KGZJWP4B1QvAmxJ
         iXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681805715; x=1684397715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ga90w5aZN7pc1fzGiYERoAYWb3VLnRbaSw6+nc26HoQ=;
        b=K4Uoub2V/FWJfl7RRqY6kjkJjOTjnggCkUVecMTvaCbLD04wjwJCCglDkOmaM6vxZS
         OpdoDmnMyR7i4TpDD9RXRY0MawORQ3U17DGPonlW70T65ckPDsYfs11eCvVXX3uRixHq
         FfIxEGFL34/2Tr5k5adO4AWWjhgblsYew7JooUQhriQmNmtC8t7002nQiOVEOhx+/oJ9
         1GAuhQj0gdxdHoFI7qVF0fy+2ZTPWSXrN96xXw64aP+CLZzplkNee1Hz4+oFhErmbLFe
         JDJDb52JwAMBCzVsWr/RtiNjYoLbkYQ06rmRWKBsWMuJ5tUlVvTj0iRELC+GaVQFAcJ7
         vRXQ==
X-Gm-Message-State: AAQBX9cggUz8EdNGpdIEN9IJxgA4O3+u89z9xXfEsDVLOt67Zmv0wA6O
        ksKseGeSoWn7MlGpoUOzA+h+gnn+kbxeaQ1N/JoEGw==
X-Google-Smtp-Source: AKy350YXLmM0Icx5pytx/kZZhmhbncZwO68Jo/boiD4hprALFyUqooXiKYsSX+9rHvlBLSIEOFpWPKaqi9MkqNMbR30=
X-Received: by 2002:a81:7c06:0:b0:552:c425:829a with SMTP id
 x6-20020a817c06000000b00552c425829amr7718381ywc.49.1681805714901; Tue, 18 Apr
 2023 01:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230414055502.23920-1-quic_mkshah@quicinc.com> <20230414055502.23920-2-quic_mkshah@quicinc.com>
In-Reply-To: <20230414055502.23920-2-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Apr 2023 10:14:39 +0200
Message-ID: <CAPDyKFqJySWVSkNd=fZ20j7RY-qz+HAcuxaYSHxnYYG2HR68mg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] cpuidle: dt_idle_genpd: Add helper function to
 remove genpd topology
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     andersson@kernel.org, dianders@chromium.org, swboyd@chromium.org,
        wingers@google.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Apr 2023 at 07:55, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> Genpd parent and child domain topology created using dt_idle_pd_init_topology()
> needs to be removed during error cases.
>
> Add new helper function dt_idle_pd_remove_topology() for same.

Except for the missing s-o-b line, this looks good to me.

Reviewed-by: Ulf Hanssson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/cpuidle/dt_idle_genpd.c | 24 ++++++++++++++++++++++++
>  drivers/cpuidle/dt_idle_genpd.h |  7 +++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
> index b37165514d4e..1af63c189039 100644
> --- a/drivers/cpuidle/dt_idle_genpd.c
> +++ b/drivers/cpuidle/dt_idle_genpd.c
> @@ -152,6 +152,30 @@ int dt_idle_pd_init_topology(struct device_node *np)
>         return 0;
>  }
>
> +int dt_idle_pd_remove_topology(struct device_node *np)
> +{
> +       struct device_node *node;
> +       struct of_phandle_args child, parent;
> +       int ret;
> +
> +       for_each_child_of_node(np, node) {
> +               if (of_parse_phandle_with_args(node, "power-domains",
> +                                       "#power-domain-cells", 0, &parent))
> +                       continue;
> +
> +               child.np = node;
> +               child.args_count = 0;
> +               ret = of_genpd_remove_subdomain(&parent, &child);
> +               of_node_put(parent.np);
> +               if (ret) {
> +                       of_node_put(node);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  struct device *dt_idle_attach_cpu(int cpu, const char *name)
>  {
>         struct device *dev;
> diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
> index a95483d08a02..3be1f70f55b5 100644
> --- a/drivers/cpuidle/dt_idle_genpd.h
> +++ b/drivers/cpuidle/dt_idle_genpd.h
> @@ -14,6 +14,8 @@ struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
>
>  int dt_idle_pd_init_topology(struct device_node *np);
>
> +int dt_idle_pd_remove_topology(struct device_node *np);
> +
>  struct device *dt_idle_attach_cpu(int cpu, const char *name);
>
>  void dt_idle_detach_cpu(struct device *dev);
> @@ -36,6 +38,11 @@ static inline int dt_idle_pd_init_topology(struct device_node *np)
>         return 0;
>  }
>
> +static inline int dt_idle_pd_remove_topology(struct device_node *np)
> +{
> +       return 0;
> +}
> +
>  static inline struct device *dt_idle_attach_cpu(int cpu, const char *name)
>  {
>         return NULL;
> --
> 2.17.1
>
