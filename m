Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C125121AC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiD0SzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiD0SyS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 14:54:18 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DAA76E7
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:40:38 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y2so4988632ybi.7
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chZb8w5bYc1qBopCdjXmUEvsnb8DkgKej+LPnTG3gvk=;
        b=ooBV2RRG6pitQwTCrEYlf+yYOCeQTsER3fuzGkPYhF74FbmjyzJndYPiht7qRwAcC9
         Pr52hjZq/AbztgiDn+f9CJogesESZrWfdbwSNfvm5iut2iLT7DNtxjd9EfXLVQTAyd4k
         HsJagvxhkX5lIvcIIMmvOoKxaHe+CXP8H6pJu96OpJRM/ngrsLdSPyrjUisk1f4Iw5dV
         JuqyE5hhGRHDOMr+o2xSJ4WAk2ZOH8w2HBdvRUSzv1IyHl98CXUu2/KX8HRdF+muLkjL
         Eb5+50pb129nFSKMh64K5PgYBMQEGCz+1V8dqLk5e1M/M0CeRsB2EepzbaoBPtdSHDKt
         +yDA==
X-Gm-Message-State: AOAM533wJbAERZ30d5LjdMPqpwBWHSZFo0nhZIQidrmiUxwgXDwgOL2K
        FgPfhQvVrjfKPBTqhTJniotc/VtpTWyHUkLYLA0=
X-Google-Smtp-Source: ABdhPJx0VZOvAyUiOE17WS3hK4tPXZ+29DFUK5DxGBnO5x6/S55PXQaR41YC/Am6py+pYu4zpztaUstAJUPe4c/Wc8o=
X-Received: by 2002:a25:da84:0:b0:648:423e:57b0 with SMTP id
 n126-20020a25da84000000b00648423e57b0mr19047968ybf.137.1651084837338; Wed, 27
 Apr 2022 11:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220427060853.3975453-1-dedekind1@gmail.com>
In-Reply-To: <20220427060853.3975453-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Apr 2022 20:40:26 +0200
Message-ID: <CAJZ5v0gx6BmUK_yKQefA-S1LZuiW=u=viUvCG0KVGYa1+OH9pA@mail.gmail.com>
Subject: Re: [PATCH 0/2] intel_idle fixes for 5.18
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Jan Beulich <jbeulich@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 27, 2022 at 8:08 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> Hi Rafael,
>
> these patches fix a couple problems in the intel_idle SPR support code.
> Could you please merge these fixes to 5.18?
>
> Both problems were spotted by Jan Beulich, thanks Jan!
>
> Thank you!
>
> Artem Bityutskiy (2):
>   intel_idle: fix the 'preferred_cstates' module parameter
>   intel_idle: fix SPR C6 optimization
>
>  drivers/idle/intel_idle.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> --

Both applied as 5.18-rc material with Fixes: tags added and some minor
changelog edits.

Thanks!
