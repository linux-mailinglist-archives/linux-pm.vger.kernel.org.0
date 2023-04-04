Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29FB6D68E8
	for <lists+linux-pm@lfdr.de>; Tue,  4 Apr 2023 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDDQb3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 4 Apr 2023 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjDDQbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2023 12:31:20 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B115B81
        for <linux-pm@vger.kernel.org>; Tue,  4 Apr 2023 09:30:48 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id b20so133009424edd.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Apr 2023 09:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nniYFSIGuTA8MFuuIMW21naopGKTC+tEgkqVe6Evkug=;
        b=2U8ELGIZv/34CjP/D54ZZAhkRQ1qQN/W2t710wn4ComPMvdQpqARlgB1Mhc8Za2Bfz
         TheAxeCnu6NE5ervwlOtLWk1m5O+E2+wXynQqKXB8p470ODVTqh5fwEOr3ePUSSGbBrh
         W5pomAOdSf6bmw0m8blAUihQePzGlorvKUmiJGN0ISxvxmrrMDawGc8bz0Lc5BTtqDBc
         5OSlyGzs+7bQKomQSJuvwA4KwGHvEJSaBySI+5rSEPtsKfIVnQue/T1S1gbb4fthb5NE
         C6QLL2jVVYtHexru7F1J19jQ75Fv8HuWj05utAGoTmwiOne0nCMBdsw3hzJYi/NfTOLe
         tsQA==
X-Gm-Message-State: AAQBX9cbekxL9roOPQvlKBRuOwBqr5FxfVE44uTvLV2UtDBUiFwaeEZb
        4MyaEkLiXOmsDe4OgITdcFlofVLy2wXwWWd2Btk=
X-Google-Smtp-Source: AKy350ZY/tAoJeIic46x5FAV7fleyEFcniS4BDR6voBJXcosylRpXQM9XGi/04jOtmLZa+qnWgihk4i2BQ5NfXwvK34=
X-Received: by 2002:a50:cd14:0:b0:4fb:f19:87f with SMTP id z20-20020a50cd14000000b004fb0f19087fmr47329edi.3.1680625844408;
 Tue, 04 Apr 2023 09:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230404083656.713825-1-xiongxin@kylinos.cn>
In-Reply-To: <20230404083656.713825-1-xiongxin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Apr 2023 18:30:33 +0200
Message-ID: <CAJZ5v0g+yrmCH0o2-ezCNmoXe24ooA4U-JAWD4xNXsjT9XBwyQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Optimize rp->domains memory allocation
To:     xiongxin <xiongxin@kylinos.cn>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 4, 2023 at 10:37 AM xiongxin <xiongxin@kylinos.cn> wrote:
>
> In the memory allocation of rp->domains in rapl_detect_domains(), there
> is an additional memory of struct rapl_domain allocated to prevent the
> pointer out of bounds called later.
>
> Optimize the code here to save sizeof(struct rapl_domain) bytes of
> memory.
>
> Test in Intel NUC (i5-1135G7).
>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Tested-by: xiongxin <xiongxin@kylinos.cn>
> ---
>  drivers/powercap/intel_rapl_common.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 8970c7b80884..f8971282498a 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1171,13 +1171,14 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>  {
>         struct rapl_domain *rd;
>         struct powercap_zone *power_zone = NULL;
> -       int nr_pl, ret;
> +       int nr_pl, ret, i;
>
>         /* Update the domain data of the new package */
>         rapl_update_domain_data(rp);
>
>         /* first we register package domain as the parent zone */
> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
> +       for (i = 0; i < rp->nr_domains; i++) {
> +               rd = &rp->domains[i];
>                 if (rd->id == RAPL_DOMAIN_PACKAGE) {
>                         nr_pl = find_nr_power_limit(rd);
>                         pr_debug("register package domain %s\n", rp->name);
> @@ -1201,8 +1202,9 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>                 return -ENODEV;
>         }
>         /* now register domains as children of the socket/package */
> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
> +       for (i = 0; i < rp->nr_domains; i++) {
>                 struct powercap_zone *parent = rp->power_zone;
> +               rd = &rp->domains[i];
>
>                 if (rd->id == RAPL_DOMAIN_PACKAGE)
>                         continue;
> @@ -1302,7 +1304,6 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
>   */
>  static int rapl_detect_domains(struct rapl_package *rp, int cpu)
>  {
> -       struct rapl_domain *rd;
>         int i;
>
>         for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
> @@ -1319,15 +1320,15 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
>         }
>         pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
>
> -       rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
> +       rp->domains = kcalloc(rp->nr_domains, sizeof(struct rapl_domain),
>                               GFP_KERNEL);

Why can't you modify just the above statement alone?  What would break
if you did that?

>         if (!rp->domains)
>                 return -ENOMEM;
>
>         rapl_init_domains(rp);
>
> -       for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++)
> -               rapl_detect_powerlimit(rd);
> +       for (i = 0; i < rp->nr_domains; i++)
> +               rapl_detect_powerlimit(&rp->domains[i]);
>
>         return 0;
>  }
> --
> 2.34.1
>
