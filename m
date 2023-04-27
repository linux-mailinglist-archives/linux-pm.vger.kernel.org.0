Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F3E6F0B16
	for <lists+linux-pm@lfdr.de>; Thu, 27 Apr 2023 19:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbjD0RlT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 27 Apr 2023 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244281AbjD0RlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2023 13:41:16 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E87459C7
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 10:40:51 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94f161ee14fso246308266b.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 10:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617231; x=1685209231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aRlmezdTamuZ8jYFboeGaWQiLdC5hVv/Nih5s87XPg=;
        b=PQa+435RitDHoA+x51fFLV5AOLCNSDBNLobvNc+EA7O0KKZQeV5jSaym+IkjRzMozA
         C6zDYK2TyZmsOcnVBj8BM0+dFqi/p34wHMU3k4yW4yRQokq8Xcsa+RXpE5T7Bb54DoKx
         iqQ7Z8YXLkcJm8a6vYYt09l8o9rOdKQif+dorQCU157rEOa649ZLA9Fe3jCs64Vv+Qfw
         Wqi03Ka73MD1+4bdoAztsaucXEk3o/+8Q1xbFMyjugtHzmgJ6UjbsHRGC1dOSXgQWit5
         qHZwKh2VoFWcFBhdbEs/U67macqrHYqQIidgk/R6ejGCYikmp7p4Gyo+NgOb5J0ftyUe
         WYmg==
X-Gm-Message-State: AC+VfDwOX2rSjbHNTXybL00VDC/zaOXqjTGHzuqvbjcMip5ukrnREYiz
        oyw9aS7hMPK7xFmeJQsIiMHOQoJibokmAB//iH5liCbM
X-Google-Smtp-Source: ACHHUZ5C1F7IUPWcOK1SRMFQJQ+XoWjt5QXKHdN631owmx0M910Tj40bmlufyq06+YeQ0lsuuAB2NWf/zIKEvMuj0eE=
X-Received: by 2002:a17:906:738a:b0:94e:9235:d77d with SMTP id
 f10-20020a170906738a00b0094e9235d77dmr2359983ejl.0.1682617231555; Thu, 27 Apr
 2023 10:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230419143947.1342730-1-dedekind1@gmail.com>
In-Reply-To: <20230419143947.1342730-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Apr 2023 19:40:20 +0200
Message-ID: <CAJZ5v0ipBh2_NDn5K73ksfJ=accMAVD_5ou0Z8UH-qaJOHJABA@mail.gmail.com>
Subject: Re: [PATCH 0/7] misc intel_idle cleanups
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 19, 2023 at 4:40 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> These are misc. clean-up and minor improvement patches for 'intel_idle'. The
> common theme in them is improving the 'intel_idle_init_cstates_icpu()' function
> and things around it.
>
> The patches are against the 'linux-pm' tree, the 'linux-next' branch.
>
> Artem Bityutskiy (7):
>   intel_idle: use pr_info instead of printk
>   intel_idle: cleanup 'intel_idle_init_cstates_icpu()'
>   intel_idle: further 'intel_idle_init_cstates_icpu()' cleanup
>   intel_idle: improve C-state flags handling robustness
>   intel_idle: fix confusing message
>   intel_idle: do not sprinkle module parameters definitions around
>   intel_idle: mark few variables as '__read_mostly'
>
>  drivers/idle/intel_idle.c | 58 ++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
>

Applied as 6.4-rc material with patch updates taken into account.

Thanks!
