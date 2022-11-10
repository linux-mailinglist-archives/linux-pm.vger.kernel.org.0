Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC16243E9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Nov 2022 15:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiKJONk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Nov 2022 09:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiKJONi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2022 09:13:38 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BD56F344
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 06:13:16 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id lf15so1420248qvb.9
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 06:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcOKyhiKkkowUCFi51YnZQ/PQ2a1QmOGsyVqWI+X7Lc=;
        b=2cvA9/TL7qDzncdBV0q4HM2RvMPXwxnV1WnTB8wAZuMdHubY/zY3aYpT3ZS2gxCjRJ
         N/EwIOmpeKyVzRiMIPvPBeDIAEP/wWt2NzedZH/2Tl/UArtwOyOtzuhyqUlg+bGXhZbO
         cErgM0bxeN6Ngk0bvRuDSmGKLTXMUX9sLNtAmaNcUE2Zo0GmFVRAdCzwZGB2zsdr2DJo
         Dya+cjWBADhWT4bJPB31o5gk6mjV6eKeCMyIbZGi7bDQHLokCpq9Y+He06cRoChYFzS/
         07KDDowvU0g+c+vnuxg4bMO4h485lzcfobyh9CKBHD2wiL6m6fMo/LvuYpttlmVv6TA5
         lpiA==
X-Gm-Message-State: ACrzQf3n7rhwzcCu0O147Uo9j46N1pSa3cP17HyL0AcgxXY5EIcc+aYg
        10tsQv4MXtqubyd2WPR8Bu6ybt71DY6XMyZ/DVI=
X-Google-Smtp-Source: AMsMyM5ohI9Aytud/u2usSbRiZ5SXM1nvZTgsrVDbq+9ynmSPQyfWtl2g70P6bBemk2/kkHITAPavBjT1tncLjhbFuI=
X-Received: by 2002:a05:6214:4517:b0:4b1:a9ac:21de with SMTP id
 oo23-20020a056214451700b004b1a9ac21demr1272045qvb.119.1668089595447; Thu, 10
 Nov 2022 06:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20221031142017.26750-1-luoxueqin66@gmail.com>
In-Reply-To: <20221031142017.26750-1-luoxueqin66@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 15:13:04 +0100
Message-ID: <CAJZ5v0g1JU=Se2yPW2z9_PHCJ=CE6NAmP1cFTJbK9oitwiWQSw@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/power : add pr_err() for debugging "Error -14
 resuming" error
To:     Luo Xueqin <luoxueqin66@gmail.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, xiongxin@kylinos.cn,
        Xueqin Luo <luoxueqin@kylinos.cn>
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

On Mon, Oct 31, 2022 at 3:20 PM Luo Xueqin <luoxueqin66@gmail.com> wrote:
>
> From: Xueqin Luo <luoxueqin@kylinos.cn>
>
> The system memory map can change over a hibernation-restore cycle due
> to a defect in the platform firmware, and some of the page frames used
> by the kernel before hibernation may not be available any more during
> the subsequent restore which leads to the error below.
>
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
> So, by adding an Error message to the unpack () function, you can quickly
> navigate to the Error page number and analyze the cause when an "Error -14
> resuming" error occurs in S4. This can save developers the cost of
> debugging time.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>
> v2: Modify the commit message and pr_err() function output
>
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
> +                               pr_err("The page frame number: %lx is not valid.\n", buf[j]);

What about printing this message instead:

pr_err(FW_BUG "Memory map mismatch at 0x%llx after hibernation\n",
page_address(pfn_to_page(buf[j])));

>                         return -EFAULT;
> +               }
>         }
>
>         return 0;
> --
> 2.25.1
>
