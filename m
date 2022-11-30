Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336B463DF4C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Nov 2022 19:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiK3Spu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Nov 2022 13:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiK3Sp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2022 13:45:28 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEFD97013
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 10:45:25 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id a17so10872239qvt.9
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 10:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ci03k9+jtZTzCMSgyBPFBr2TOw3ZtUAnLxVlp1INCI=;
        b=OovIQ12Kk6QlyZIVrZtmgcmKfdinQyqwvM/iITFpYEihZSRLKe4j94Q62l75E1Z4yR
         HDF5lAwSz9BSar2tE8e2tflpMXuWnPZhqlIoDcR3p9/PeuQKKN5lTX4KSfHCuikVwBEJ
         oVXytmM+cgxOlNIWYEDCghKLZMTvKkFmgBLK29QaEofwSRb/N8KSLdr5XPwaZLMKkDk3
         Iq0pqEKwDiJIzYc8Cz7eAPpk7g5H9y18pX4gaR9Ox7vlGL5KwlwQm5w5Dcv8h1yrYyVv
         I9zJgXpYY1pfKHsxpHK1uiuX6vm/N8X+VoZEDuZabb1bDlFYsPmShie4Tojsp7Hj+8tC
         TB1w==
X-Gm-Message-State: ANoB5pkwsBlE1mEgXEOUqnR89bcvkFj7VG9ELMcWFF8989X6El7VAUTy
        uwFyETccpnc57UlUmyL3tKyBpkEm1kpvuDEfcta1lnQ2
X-Google-Smtp-Source: AA0mqf4wRW5HtNLtDkEG8F1vwGCf8uODr+yItkv9beuyeZSjzkfUzKyL1UMb64hquN1TtDY3n+mdCLVE9k64cPSrzOo=
X-Received: by 2002:a0c:c582:0:b0:4af:b750:b569 with SMTP id
 a2-20020a0cc582000000b004afb750b569mr41473204qvj.83.1669833924916; Wed, 30
 Nov 2022 10:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20221111045242.530607-1-luoxueqin@kylinos.cn>
In-Reply-To: <20221111045242.530607-1-luoxueqin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Nov 2022 19:45:14 +0100
Message-ID: <CAJZ5v0hdP_=DecQCfwcdX4hm=i5WFKhmJexLWKN4SMkFdzrhvQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/power : add pr_err() for debugging "Error -14
 resuming" error
To:     Xueqin Luo <luoxueqin@kylinos.cn>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, xiongxin@kylinos.cn
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

On Fri, Nov 11, 2022 at 5:53 AM Xueqin Luo <luoxueqin@kylinos.cn> wrote:
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
> v3: Modify the pr_err() function output again
>
> v2: Modify the commit message and pr_err() function output
>
>  kernel/power/snapshot.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index c20ca5fb9adc..e7bd4531faf2 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2259,10 +2259,14 @@ static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
>                 if (unlikely(buf[j] == BM_END_OF_MAP))
>                         break;
>
> -               if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
> +               if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j])) {
>                         memory_bm_set_bit(bm, buf[j]);
> -               else
> +               } else {
> +                       if (!pfn_valid(buf[j]))
> +                               pr_err(FW_BUG "Memory map mismatch at 0x%llx after hibernation\n",
> +                                               PFN_PHYS(buf[j]));
>                         return -EFAULT;
> +               }
>         }
>
>         return 0;
> --

Applied as 6.2 material under a new subject and with some edits in the
changelog.

Thanks!
