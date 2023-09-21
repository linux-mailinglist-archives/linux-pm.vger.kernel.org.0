Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92BF7A9AFF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjIUSw5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjIUSwp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 14:52:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599FC90A75
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:47:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053c6f0d3dso628295e9.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695318431; x=1695923231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DpJ/97G25b6TPjTn6QzU+EXfaLRmUn9TD44GKiLbxUc=;
        b=TVcAH8EVOhAKX7jY7A15R/NUShYvR+BmNHZIYvbUpmE2924ztKrVVqs2FPQzaDfRTC
         wWzlTvWgZ6nMwdy0ZFTe8zPA89MVP1s3Rz7ES7ElxRF2eY1I29iOfAI1b1N+cjXUicJM
         /Yudp+CY0il2GnWRGJPS0gOmYurSfx9CBLCGoMPjGg539mEih89CmZVqZ5TKdTvvD8hz
         5SCwk0h5MlWR3rOvoIM1RpxDIhr15q1e9YKlVToI6Ne9OzACt6oMlyJaNNGeXin7NB5f
         mUMUIgpHAdCghNZQ4JAAlIF7OuYVtWZy05ttfmG/nFaHgWlckI1t4brr5H/tyEMt6gEg
         g/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318431; x=1695923231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpJ/97G25b6TPjTn6QzU+EXfaLRmUn9TD44GKiLbxUc=;
        b=X3O2dM9yxvEfbQOAIUIzY2ePS3SqcIjazF/PnNiYZ3QaaBVjHFANhRqmFmJAZYtDfe
         a0xGE+qOdEcBWV9Ic1hnts9PkDWspqcwvzDXSM72AD8e2RA+iVL1t7PE56jkoTFfaD3A
         pYJ9mIuQdrrJK66k5771aZ+KQaVbFWXiGkbgWJ1LGagoR3303771UudL5dmUrQDa0K2k
         K3FCHIkAUSWE2kHKxY/z+N7vFkFfvxoqoi8qLZrgj/zd7G7hSWVozzPoeMwXtj9h122i
         5PBnolsGrfjKLyemLOMp27RuTenZvYVtahEEggjbDaTwlqxgomBMKn3InwaxOEI28Sfp
         0jOg==
X-Gm-Message-State: AOJu0YxsHtkunLj503Y/BF2XTQx0iICV9nxiMoSGO51/NrkES4KaGZGi
        BbKkHkHfkmTBJx8R+595+gd0DKz9UkvH1BY0A3UqqwkYyOTh6Ulybqqx0A==
X-Google-Smtp-Source: AGHT+IFTxMHPC95KiOI2z0xWTy4CeTB0NUWNRpnxeR4sjTTRwKDyfOkzMakcC+k0ZCF0c3b4q1acDPb+GMi6CilNLCU=
X-Received: by 2002:a05:6512:110e:b0:503:7dd:7ebc with SMTP id
 l14-20020a056512110e00b0050307dd7ebcmr6385076lfg.18.1695306665262; Thu, 21
 Sep 2023 07:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org> <20230825112633.236607-12-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-12-ulf.hansson@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 21 Sep 2023 16:30:48 +0200
Message-ID: <CAKohponrQRm5xP4Ahei7ZnSmfdsLk+6tFD+7mXZ_c23pEP+x9w@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] cpufreq: scmi: Add support to parse domain-id
 using #power-domain-cells
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 25 Aug 2023 at 13:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The performance domain-id can be described in DT using the power-domains
> property or the clock property. The latter is already supported, so let's
> add support for the power-domains too.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Move to get the power-domain index from power-domain-names.
>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
