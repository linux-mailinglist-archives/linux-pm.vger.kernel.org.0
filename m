Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5E5B4789
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 18:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIJQol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 12:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIJQok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 12:44:40 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349DFB1CC
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 09:44:39 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p69so254408yba.0
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 09:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2JUdp+VI+NzlDbv+/0UunaUlhoTB747kbhjI0m/8eKA=;
        b=wlmhrHj47HpfWCyZEZB6H0viUsqzukG4VLs2E8SH95e97A93DBOVZc4b9qogqH2+sI
         OLQFbGFSzDbDREupbzkO9RH98ISIkwWo1H/VV6oFEdbAMIlvkUPnLGGngErWYUZ+SOoO
         9UEuSsS0aEP1Sy4aeFpV23SJL+F7P253ZD4+9KjIyaMLCQYrUhwMSMJZylPRZA3XsaA8
         XC2+va5hNXu1NlGM33MydvHjebRQUGoqVyvaAOgVWCDGyn2JAL+9Orha6ZlhPJq5Dcvd
         PfQGaVHoqYNxv5iTpv9CS0hygRwG2mTLf7NSoSDeCGDj5evR5ZDLHXQFi0jAd781aoZ7
         ITfg==
X-Gm-Message-State: ACgBeo0fzhpBBb9DqqXyw+th1830k7j9xKWR4rPKXT9iAl25s2/oDZGk
        rGIPQ2IcXH7O5yirPMMjvVaHgLD29JgHkb8lN1Y=
X-Google-Smtp-Source: AA6agR7VOfGrx6x4rUlcPCO9qH/BLlSqIksVIRUK2lOF2wdb2lnBUMMvbC8pviqYZso2b25fJHugTf0LLZ9qUvWN/W8=
X-Received: by 2002:a25:2f0c:0:b0:6a8:f230:12ed with SMTP id
 v12-20020a252f0c000000b006a8f23012edmr15769788ybv.633.1662828278454; Sat, 10
 Sep 2022 09:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220910131542.22708-1-rui.zhang@intel.com>
In-Reply-To: <20220910131542.22708-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 10 Sep 2022 18:44:27 +0200
Message-ID: <CAJZ5v0hPh21mgTLT6jZf4=bZqNbsLqFnu41j9G3K5TTo3=YKHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powercap: intel_rapl: Add support for MeteorLake platforms
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Sat, Sep 10, 2022 at 3:12 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Add intel_rapl support for the MeteorLake platforms, which behave the
> same as RaptorLake platforms.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>
> Note:
> This patch depends on commit 5515d21c6817
> ("x86/cpu: Add CPU model numbers for Meteor Lake") in the x86/urgent
> branch of tip tree.

So I think I will have to rebase the powercap branch on top of a
future -rc in order to apply this one.

> Note:
> This patch is made on top of commit 0d7a23b5f8e1
> ("powercap: intel_rapl: Add support for RAPTORLAKE_S") in the
> linux-next branch of pm tree to avoid conflict.
>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 6812c1ca3100..949eb90f5733 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1111,6 +1111,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,        &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_spr_server),
>         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defaults_core),
>
> --
