Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322913E868B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 01:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhHJXb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhHJXb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 19:31:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D41C061798
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 16:31:34 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id z9-20020a9d62c90000b0290462f0ab0800so1120571otk.11
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=DdVdn9iNnWyMUjEKky2BxxbxaluBkvajxWA2hdi0viQ=;
        b=SJyRTDGNn25cPioEO33i9E465TFVUM3oyVwTlhDMc/02U34Y6PJudLH+ImNGYKQHij
         ZymOHdDNXbbJyU7vyl3D8Q07kVLp+l19e9o7YEcgvDWLD/Y3ZCoMSqAik3ogP+qXFVKb
         awn+a8WwyYujXfV6b5hFgk5tLM5b2e9Aj4d0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=DdVdn9iNnWyMUjEKky2BxxbxaluBkvajxWA2hdi0viQ=;
        b=tEqujsOmTNRMaZnjrHK8RIBtjKd6tbgeTy8DKIEaCFP76tEAK+6CsAenYqS/okuLeJ
         PxICskxJPNd73WWaKIgai3iHpQSrU0//I8yAXZJFxa7ippocAt7hkqeOv7qOwnxvdHvB
         YW/D15PxfrXYkvl+S5TK+iYTdGlvKtfH10gLWeg4NAjBbsC6mveEISsTQliZ/HE6uEhh
         Ev3trpca8KsVyTywkbvFAdFRhzcKyUAVTW8bHmFoSLnwx2Pim+UrOMTaX/o8YR446ADa
         IoSGsSOsTek7L+wijcrfERXhFr86LXzDnxWu0kCZ6mUAG+FKtCwGM8mfhywL5uG96nEt
         KXaQ==
X-Gm-Message-State: AOAM5305UrDetF6iKhs875EaPN+ndUfNwP8VCkni895fcq2QLcpjuCwZ
        DEtpHrz/Wa55Qy3W4Ozqcr/NNAMdEg4GubGjeMS6vQ==
X-Google-Smtp-Source: ABdhPJx2AAfQiWqyLOxU4A5451d9RiJWf3pxTqnLNNHUZFFyXlTs8W8aHceuoLd9sS3hJE9+rvOco02aXCO3VgUcCgI=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr23006661otq.233.1628638293521;
 Tue, 10 Aug 2021 16:31:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 16:31:33 -0700
MIME-Version: 1.0
In-Reply-To: <20210721175432.2119-5-mdtipton@codeaurora.org>
References: <20210721175432.2119-1-mdtipton@codeaurora.org> <20210721175432.2119-5-mdtipton@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 16:31:33 -0700
Message-ID: <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] interconnect: qcom: icc-rpmh: Add BCMs to commit
 list in pre_aggregate
To:     Mike Tipton <mdtipton@codeaurora.org>, djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alex Elder <elder@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Mike Tipton (2021-07-21 10:54:32)
> We're only adding BCMs to the commit list in aggregate(), but there are
> cases where pre_aggregate() is called without subsequently calling
> aggregate(). In particular, in icc_sync_state() when a node with initial
> BW has zero requests. Since BCMs aren't added to the commit list in
> these cases, we don't actually send the zero BW request to HW. So the
> resources remain on unnecessarily.
>
> Add BCMs to the commit list in pre_aggregate() instead, which is always
> called even when there are no requests.
>
> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---

This patch breaks reboot for me on sc7180 Lazor

[  107.136454] kvm: exiting hardware virtualization
[  107.163741] platform video-firmware.0: Removing from iommu group 13
[  107.193412] SError Interrupt on CPU1, code 0xbe000011 -- SError
[  107.193428] CPU: 1 PID: 4289 Comm: reboot Not tainted 5.14.0-rc1+ #12
[  107.193432] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
[  107.193436] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO BTYPE=--)
[  107.193440] pc : el1_interrupt+0x20/0x60
[  107.193443] lr : el1h_64_irq_handler+0x18/0x24
[  107.193445] sp : ffffffc014093a10
[  107.193448] x29: ffffffc014093a10 x28: ffffff8088295ec0 x27: 0000000000000000
[  107.193465] x26: ffffff8080ed4c18 x25: ffffffd0beece000 x24: ffffffd0bef45000
[  107.193476] x23: 0000000060400009 x22: ffffffd0be0bc1a0 x21: ffffffc014093b90
[  107.193487] x20: ffffffd0bdc100f8 x19: ffffffc014093a40 x18: 000000000007d829
[  107.193497] x17: ffffffd067412b54 x16: ffffffd0be0bc164 x15: ffffffd067413d0c
[  107.193507] x14: ffffffd0bdd24fa4 x13: ffffffd0bdc26180 x12: ffffffd0bdc26260
[  107.193517] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[  107.193528] x8 : 00000000000000c0 x7 : bbbbbbbbbbbbbbbb x6 : ffffffd0bde488dc
[  107.193539] x5 : 0000000000200017 x4 : ffffff809b5c4b40 x3 : 0000000000200018
[  107.193549] x2 : ffffff8088295ec0 x1 : ffffffd0bdc100f8 x0 : ffffffc014093a40
[  107.193561] Kernel panic - not syncing: Asynchronous SError Interrupt
[  107.193564] CPU: 1 PID: 4289 Comm: reboot Not tainted 5.14.0-rc1+ #12
[  107.193567] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
[  107.193570] Call trace:
[  107.193573]  dump_backtrace+0x0/0x1c8
[  107.193577]  show_stack+0x24/0x30
[  107.193579]  dump_stack_lvl+0x64/0x7c
[  107.193582]  dump_stack+0x18/0x38
[  107.193584]  panic+0x158/0x39c
[  107.193586]  nmi_panic+0x88/0xa0
[  107.193589]  arm64_serror_panic+0x80/0x8c
[  107.193593]  do_serror+0x0/0x80
[  107.193595]  do_serror+0x58/0x80
[  107.193597]  el1h_64_error_handler+0x30/0x48
[  107.193601]  el1h_64_error+0x78/0x7c
[  107.193603]  el1_interrupt+0x20/0x60
[  107.193606]  el1h_64_irq_handler+0x18/0x24
[  107.193609]  el1h_64_irq+0x78/0x7c
[  107.193612]  refcount_dec_and_mutex_lock+0x3c/0xb4
[  107.193616]  ipa_clock_put+0x34/0x74 [ipa]
[  107.193619]  ipa_deconfig+0x64/0x74 [ipa]
[  107.193622]  ipa_remove+0xbc/0x110 [ipa]
[  107.193625]  ipa_shutdown+0x24/0x50 [ipa]
[  107.193628]  platform_shutdown+0x30/0x3c
[  107.193631]  device_shutdown+0x150/0x208
[  107.193633]  kernel_restart_prepare+0x44/0x50
[  107.193637]  kernel_restart+0x24/0x70
[  107.193640]  __arm64_sys_reboot+0x188/0x230
[  107.193643]  invoke_syscall+0x4c/0x120
[  107.193646]  el0_svc_common+0x84/0xe0
[  107.193648]  do_el0_svc_compat+0x2c/0x38
[  107.193651]  el0_svc_compat+0x20/0x30
[  107.193654]  el0t_32_sync_handler+0xc0/0xf0
[  107.193657]  el0t_32_sync+0x19c/0x1a0

Presumably some sort of interconnect is getting turned off earlier than
before?

>  drivers/interconnect/qcom/icc-rpmh.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index f118f57eae37..b26fda0588e0 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -20,13 +20,18 @@ void qcom_icc_pre_aggregate(struct icc_node *node)
>  {
>         size_t i;
>         struct qcom_icc_node *qn;
> +       struct qcom_icc_provider *qp;
>
>         qn = node->data;
> +       qp = to_qcom_provider(node->provider);
>
>         for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>                 qn->sum_avg[i] = 0;
>                 qn->max_peak[i] = 0;
>         }
> +
> +       for (i = 0; i < qn->num_bcms; i++)
> +               qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
>
> @@ -44,10 +49,8 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>  {
>         size_t i;
>         struct qcom_icc_node *qn;
> -       struct qcom_icc_provider *qp;
>
>         qn = node->data;
> -       qp = to_qcom_provider(node->provider);
>
>         if (!tag)
>                 tag = QCOM_ICC_TAG_ALWAYS;
> @@ -67,9 +70,6 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>         *agg_avg += avg_bw;
>         *agg_peak = max_t(u32, *agg_peak, peak_bw);
>
> -       for (i = 0; i < qn->num_bcms; i++)
> -               qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
> -
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
