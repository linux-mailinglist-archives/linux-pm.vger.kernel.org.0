Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9942854547A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiFIS4D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiFIS4C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 14:56:02 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DC4F1FF
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 11:56:00 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-30ce6492a60so250972297b3.8
        for <linux-pm@vger.kernel.org>; Thu, 09 Jun 2022 11:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GeHMYVX1FuU/253EFrpq6cC8pS8DNefF3ay0F/Fq8K8=;
        b=DRjzYzBCuPnLS7TnyNeekLk9kBl/9CpAEubqFXDdbCz8rvaUobJ3Vt9GtmTKtM9M+C
         t4cRk2zqYwqu5imOdQGMnMDP1BRmEYqN7W7PqM/y43dFsgDoQgPY4Hju01nqGC6fOlVa
         2HVD98zS8ylg+Nd+OOE6wVSD7qQ/bWe/dxVNz1NceP8klT+xXSTQNXr20C7dhAxG94io
         RYXufnqVqnxQVNv+HTWmkc5G28TzVahQ4GPN3eIXl9CrC5nejD5a3l4lF9g4n4U415os
         YPoIqxClPN+HDt3PYrgi0tWcRYJIEZDwx7gw7TGhbldgSBulbwoFNe2Fp6HFRqhA7efU
         ZRYg==
X-Gm-Message-State: AOAM53021odUIaZ7MIYbXLXdHdwfuS/Wf/5l5u0IQIWoRtgzqb69jM5o
        +vDNqHUSRrRbGwj2L/ytQ923Y0e+cZE6RAMSZ30=
X-Google-Smtp-Source: ABdhPJzCCMc3GI7Oc0mwGj6ZcJFH/tVMsogzTmbKqzDjMe697J0jopK2uZUBTgzspjL1w+CeNjWqiR76mpD7OCh04YI=
X-Received: by 2002:a81:8844:0:b0:2fe:a7de:20c2 with SMTP id
 y65-20020a818844000000b002fea7de20c2mr45544850ywf.515.1654800959903; Thu, 09
 Jun 2022 11:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220601192216.9174-1-george.d.sworo@intel.com>
In-Reply-To: <20220601192216.9174-1-george.d.sworo@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 20:55:48 +0200
Message-ID: <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        George D Sworo <george.d.sworo@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rui, Srinivas, should I take this one?

On Wed, Jun 1, 2022 at 9:22 PM <george.d.sworo@intel.com> wrote:
>
> From: George D Sworo <george.d.sworo@intel.com>
>
> Add RAPTORLAKE_P to the list of supported processor model in the Intel
>
> RAPL power capping driver.
>
> Signed-off-by: George D Sworo <george.d.sworo@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index a9c99d9e8b42..21d624f9f5fb 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1109,6 +1109,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_spr_server),
>         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defaults_core),
>
> --
> 2.17.1
>
