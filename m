Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244CE60D1BA
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJYQle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiJYQld (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 12:41:33 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731474DE2
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 09:41:30 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id b25so8460996qkk.7
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 09:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2SaQpI/48+OBtsHYK1p3r6bOQYqwf5uL5Qs2+5lRvE=;
        b=rhIWMnu3kQUQqO1oD/hZQ/qv752v2Dg+92tprutl37W+twam0/YNNGyMc/imcTj3vQ
         DINo0NMo3npErswYs594iFcz0j0Z2e+nM5hZHXb/beGRX6rqNqY/OxRI2Q0LqyHv6yFf
         fuIPagh+neV9mpSIW7YuIfj0kAs0ZMSwg++Wq5YefO8dKfrp5FnDswY+o7/IMUIb+dlH
         tR2bc1js3wuQqak/cycRt9dEO+RMsR3/jbZbX0CFCxd0tpQagfCvFM8VsWDnhFr2GtFh
         l2iby5arWiRY7ARSQTAktpNvKYgd9zO/tOz7lmpuKXBkuXYl9LUDK91z9y2STT3cY05v
         /G8Q==
X-Gm-Message-State: ACrzQf1IwzpAtO8L5gewlI0PN8vxRp1zjSttS9upZpAB4QnH1H4Ba2x/
        nSbug4OT7OXJ1nYRuusiIcsszRRn/xgwL/SPWDxvneAz
X-Google-Smtp-Source: AMsMyM4k30qj2Kh2eAWk3ighvwuhUqH2PQakIim2XHdbfr8uDjVq4JALlIsNUPptSTRMnCI3115FdlXYzHM9YQ5VoXE=
X-Received: by 2002:a05:620a:348:b0:6ec:a429:cc88 with SMTP id
 t8-20020a05620a034800b006eca429cc88mr27366840qkm.648.1666716089532; Tue, 25
 Oct 2022 09:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220930010821.221381-1-luoxueqin@kylinos.cn>
In-Reply-To: <20220930010821.221381-1-luoxueqin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 18:41:18 +0200
Message-ID: <CAJZ5v0jrtPFpHmiRjt+dqQb0iG7q2birWzUezgQQ43v1OZatzw@mail.gmail.com>
Subject: Re: [PATCH -next] kernel/power : add pr_err() for debugging "Error
 -14 resuming" error
To:     Xueqin Luo <luoxueqin66@gmail.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, Xueqin Luo <luoxueqin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 30, 2022 at 3:09 AM Xueqin Luo <luoxueqin66@gmail.com> wrote:
>
> As the machine boots normally, bios initializes the memblock and sets the
> flags of some memblocks to 0x1. During the S4, the bios once again
> initializes the memblock.This initialization may change the flags value
> of some blocks, for example, changing the flags value from 0x1 to 0x4.
> 0x4 means do not add to kernel direct mapping. These changed addresses do
> not pass the validity check of the pfn_valid() function, resulting in the
> following "Error -14 resuming" error.

I suppose that you wanted to say that the system memory map can change
over a hibernation-restore cycle and some of the page frames used by
the kernel before hibernation may not be available any more during the
subsequent restore which leads to the error below.

It would be good to also note that this can be regarded as a platform
firmware defect.

> [  T357] PM: Image loading progress:   0%
> [  T357] PM: Read 2681596 kbytes in 0.03 seconds (89386.53 MB/s)
> [  T357] PM: Error -14 resuming
> [  T357] PM: Failed to load hibernation image, recovering.
> [  T357] PM: Basic memory bitmaps freed
> [  T357] OOM killer enabled.
> [  T357] Restarting tasks ... done.
> [  T357] PM: resume from hibernation failed (-14)
> [  T357] PM: Hibernation image not present or could not be loaded.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  kernel/power/snapshot.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 2a406753af90..2be2e9f5a060 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2259,10 +2259,13 @@ static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
>                 if (unlikely(buf[j] == BM_END_OF_MAP))
>                         break;
>
> -               if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
> +               if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j])) {
>                         memory_bm_set_bit(bm, buf[j]);
> -               else
> +               } else {
> +                       if (!pfn_valid(buf[j]))
> +                               pr_err("Address %lx is not valid.\n", buf[j]);

buf[j] is not an address here.  It is a page frame number.

The message is still a bit cryptic IMV, it doesn't explain what's the
problem and cannot be understood without reading the code.

>                         return -EFAULT;
> +               }
>         }
>
>         return 0;
> --
