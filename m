Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75103F4D8A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhHWPbE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhHWPbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 11:31:04 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9C4C061757
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 08:30:19 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so4445630ood.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q1I6UIQ/dYdeGuL5vsdxomD4lXFNDoC4pbA5dcQ1sos=;
        b=F5FOu4Uju7d1zSzqsLiaek0JWIxkanzrkfr9LImQ9tIa9/TQFsU3gqcYqib3b5lCT4
         9FNjO3UYej2V1n+rp+smV/DUc44d7B5zGWc2c6kmu2UjxSCwDRlSfT/KphvBwFG++OLQ
         Dibm+03F+EjgqMfNIFtl3jVREMD16OsEnNCWaW2fYGvIE8RqRQi9cJGQiDAcNdAAxWty
         /DHwRzhNq2OF7nJtArRwMHo6Oezlua8TBWlHDU+/TvwoX/chw6NzK+WxsIDtGsnQikbw
         MsHSkL8QAnoQt4TFCzGXajF/Dfo+nzGvLZMbHCXik39ZYzwgRg1JmwJeqoKi0xx3Mh10
         kN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q1I6UIQ/dYdeGuL5vsdxomD4lXFNDoC4pbA5dcQ1sos=;
        b=e3FyIW1y/nxN+A1aX0sGcG/DAnKceUbNegHAOJ1U0dYNFf4t0lprndsswN23madb/A
         KLbMHt0P2hzaM7r4/fYlRiDCmqNIPCBbMTzEEj1256f5Q0pqGaJuTvTMsMLwwXChJ0Uw
         r2YSpcb1vr+WJ9scg+oNSk0IiQSrbjih3TGWJg2SWP34MBh08Sdui3hpQyr4tWL+BF4a
         3adro8uUidDK1Bh3VBew8lnsof+JddxZuYhdiLDZem5Y8jppqs589kqfw/hkNyADfXeK
         fVE9U9gdNignMLQIRxk3Njltw/Rif5kBfYI+pzF0mJWUIjNFxfQ1TG7dTwBfN/uWSLpL
         hW+g==
X-Gm-Message-State: AOAM531hFDmQhThSPPE5PYv4196fyMMDCnwAx4tnPdTjthv18lzM04lG
        /f8PM0Q3ybwKX64MpwJ0oajVVg==
X-Google-Smtp-Source: ABdhPJxvxAPBPV4s/EVPjaPI6SW7gljf5tIj+ZYNiOEbumWPWZjhzi3Klk8ORxyHCSYPVCHKbi/lTA==
X-Received: by 2002:a4a:e1a4:: with SMTP id 4mr26231000ooy.14.1629732619089;
        Mon, 23 Aug 2021 08:30:19 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a23sm1607314otp.44.2021.08.23.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 08:30:18 -0700 (PDT)
Date:   Mon, 23 Aug 2021 08:31:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: sdm660: Fix id of slv_cnoc_mnoc_cfg
Message-ID: <YSO/Wfq6CvO89g2V@ripper>
References: <20210823014003.31391-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823014003.31391-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun 22 Aug 18:40 PDT 2021, Shawn Guo wrote:

> The id of slv_cnoc_mnoc_cfg node is mistakenly coded as id of
> slv_blsp_1.  It causes the following warning on slv_blsp_1 node adding.
> Correct the id of slv_cnoc_mnoc_cfg node.
> 
> [    1.948180] ------------[ cut here ]------------
> [    1.954122] WARNING: CPU: 2 PID: 7 at drivers/interconnect/core.c:962 icc_node_add+0xe4/0xf8

Happy to see that the WARN_ON() turned out useful to others :)

> [    1.958994] Modules linked in:
> [    1.967399] CPU: 2 PID: 7 Comm: kworker/u16:0 Not tainted 5.14.0-rc6-next-20210818 #21
> [    1.970275] Hardware name: Xiaomi Redmi Note 7 (DT)
> [    1.978169] Workqueue: events_unbound deferred_probe_work_func
> [    1.982945] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.988849] pc : icc_node_add+0xe4/0xf8
> [    1.995699] lr : qnoc_probe+0x350/0x438
> [    1.999519] sp : ffff80001008bb10
> [    2.003337] x29: ffff80001008bb10 x28: 000000000000001a x27: ffffb83ddc61ee28
> [    2.006818] x26: ffff2fe341d44080 x25: ffff2fe340f3aa80 x24: ffffb83ddc98f0e8
> [    2.013938] x23: 0000000000000024 x22: ffff2fe3408b7400 x21: 0000000000000000
> [    2.021054] x20: ffff2fe3408b7410 x19: ffff2fe341d44080 x18: 0000000000000010
> [    2.028173] x17: ffff2fe3bdd0aac0 x16: 0000000000000281 x15: ffff2fe3400f5528
> [    2.035290] x14: 000000000000013f x13: ffff2fe3400f5528 x12: 00000000ffffffea
> [    2.042410] x11: ffffb83ddc9109d0 x10: ffffb83ddc8f8990 x9 : ffffb83ddc8f89e8
> [    2.049527] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
> [    2.056645] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : ffffb83ddc9903b0
> [    2.063764] x2 : 1a1f6fde34d45500 x1 : ffff2fe340f3a880 x0 : ffff2fe340f3a880
> [    2.070882] Call trace:
> [    2.077989]  icc_node_add+0xe4/0xf8
> [    2.080247]  qnoc_probe+0x350/0x438
> [    2.083718]  platform_probe+0x68/0xd8
> [    2.087191]  really_probe+0xb8/0x300
> [    2.091011]  __driver_probe_device+0x78/0xe0
> [    2.094659]  driver_probe_device+0x80/0x110
> [    2.098911]  __device_attach_driver+0x90/0xe0
> [    2.102818]  bus_for_each_drv+0x78/0xc8
> [    2.107331]  __device_attach+0xf0/0x150
> [    2.110977]  device_initial_probe+0x14/0x20
> [    2.114796]  bus_probe_device+0x9c/0xa8
> [    2.118963]  deferred_probe_work_func+0x88/0xc0
> [    2.122784]  process_one_work+0x1a4/0x338
> [    2.127296]  worker_thread+0x1f8/0x420
> [    2.131464]  kthread+0x150/0x160
> [    2.135107]  ret_from_fork+0x10/0x20
> [    2.138495] ---[ end trace 5eea8768cb620e87 ]---
> 

The SDM660 provider was picked up in a previous release, so let's help
this get backported by adding:

Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/interconnect/qcom/sdm660.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index 632dbdd21915..ac13046537e8 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -307,7 +307,7 @@ DEFINE_QNODE(slv_bimc_cfg, SDM660_SLAVE_BIMC_CFG, 4, -1, 56, true, -1, 0, -1, 0)
>  DEFINE_QNODE(slv_prng, SDM660_SLAVE_PRNG, 4, -1, 44, true, -1, 0, -1, 0);
>  DEFINE_QNODE(slv_spdm, SDM660_SLAVE_SPDM, 4, -1, 60, true, -1, 0, -1, 0);
>  DEFINE_QNODE(slv_qdss_cfg, SDM660_SLAVE_QDSS_CFG, 4, -1, 63, true, -1, 0, -1, 0);
> -DEFINE_QNODE(slv_cnoc_mnoc_cfg, SDM660_SLAVE_BLSP_1, 4, -1, 66, true, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_CFG);
> +DEFINE_QNODE(slv_cnoc_mnoc_cfg, SDM660_SLAVE_CNOC_MNOC_CFG, 4, -1, 66, true, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_CFG);
>  DEFINE_QNODE(slv_snoc_cfg, SDM660_SLAVE_SNOC_CFG, 4, -1, 70, true, -1, 0, -1, 0);
>  DEFINE_QNODE(slv_qm_cfg, SDM660_SLAVE_QM_CFG, 4, -1, 212, true, -1, 0, -1, 0);
>  DEFINE_QNODE(slv_clk_ctl, SDM660_SLAVE_CLK_CTL, 4, -1, 47, true, -1, 0, -1, 0);
> -- 
> 2.17.1
> 
