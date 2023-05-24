Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99770FBD2
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjEXQkv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 May 2023 12:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjEXQku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 12:40:50 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F6E7
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 09:40:49 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-96f72e6925cso26856566b.1
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 09:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946448; x=1687538448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWcbgYQgtmwVAalaEpfC1JpWDRKIHQvmUuBPZCBbaAg=;
        b=KrXXK4qBsC+95H10J5DJ7uc1/WIlKKoHCiLNC30KrJ2MRIZiVbIM2XclwvHDOHqZC0
         11SPDfqqmqcMv3zOSgz39zq4c+E27LD1JkmfdKIaLyZ9+9vjjZu7dfUZfaE4gKx/SVyJ
         +01LxQm/KLR+cjfjUIe1LZwRb7WZGienYcON21z6hqolUw6PVrn0D9QJe+TdthFkB5nX
         3x7eANknvW/8hxwvMuk4HCTtUQQE72GLHISWYpHB9WrMgn1Bhm0alJ0yjSkplFuaRG1w
         3TodA07Bx6B/lum55X2IkhE+CsXazI41RU/xG+V1WSuOyK12s/jZh3dgxjNf+Vgoh8cv
         KTwg==
X-Gm-Message-State: AC+VfDxSWuyPlZ/FrAEr1nbStYadrsCqj1Eo6SZwNyPrbnuc4t0GdSOn
        AWYLOHueaVl5tJlem60/2H4rbvQkFPLqb9er8is=
X-Google-Smtp-Source: ACHHUZ7XveAeO11HtEaBJWPYNJKpf8yd1Hx3AEYsMtXP5REsedEFsOe9rn233K4bOeS8Qic64ICFbnBHbtJfpy1VC0w=
X-Received: by 2002:a17:906:10ca:b0:965:c518:4681 with SMTP id
 v10-20020a17090610ca00b00965c5184681mr2563490ejv.7.1684946447894; Wed, 24 May
 2023 09:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230407024759.2320858-1-xiongxin@kylinos.cn>
In-Reply-To: <20230407024759.2320858-1-xiongxin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 18:40:36 +0200
Message-ID: <CAJZ5v0juDz6=P23NJ11mNCVBCjp_p3qNRFo0i8YqFBPUW9tkQQ@mail.gmail.com>
Subject: Re: [v2] powercap: intel_rapl: Optimize rp->domains memory allocation
To:     xiongxin <xiongxin@kylinos.cn>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 7, 2023 at 4:48 AM xiongxin <xiongxin@kylinos.cn> wrote:
>
> In the memory allocation of rp->domains in rapl_detect_domains(), there
> is an additional memory of struct rapl_domain allocated, optimize the
> code here to save sizeof(struct rapl_domain) bytes of memory.
>
> Test in Intel NUC (i5-1135G7).
>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Tested-by: xiongxin <xiongxin@kylinos.cn>
> ---
>
> v2: The extra memory will never be used, so can directly remove '+1'.
>
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 8970c7b80884..a766d6e43c34 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1319,7 +1319,7 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
>         }
>         pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
>
> -       rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
> +       rp->domains = kcalloc(rp->nr_domains, sizeof(struct rapl_domain),
>                               GFP_KERNEL);
>         if (!rp->domains)
>                 return -ENOMEM;
> --

Srinivas, is this OK, or does it miss anything?

>
