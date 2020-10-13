Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0E28D36E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgJMSGy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgJMSGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 14:06:54 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD77C0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 11:06:53 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s89so378342ybi.12
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtobIb+A6viiRru8d79APeEFh87bD0AFLsr1fjkdhuE=;
        b=k3l9vpH1V8xOE3NCxYEK+h37hCqwUttm0yyJEAqW6aDw2VnHIDwf++fXcx5Dg58wYH
         zEtT3t6kocHDSb1s4kBmAsYkvSp329MQ7mi+DPGDIuUbqdrYzOn5n51kOTP0kfd/zoby
         g5TVpd1g/5/tK7T6tfgFuai9RaL2RgqlXvdDele01utn87caDonT/kcUTQUq0jP85i0z
         Fcbnd8eM4C8hOAcco4TzRn/P2TW2e/aVfJbfw2dIhZH0/i/lyBjirA349s9Ut1zbMXry
         I0C1dOtS9/8oryUyC2eRABikYEGu8rlBH9bFIre6il17dBNRJPlMYOp8eUgV05uSsszy
         r5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtobIb+A6viiRru8d79APeEFh87bD0AFLsr1fjkdhuE=;
        b=Z6B4+aa9ZcxAkCQjZvQFROJNYbZ1G+ECU6QVxJpnyHTLLlKJtl2Q7Apr8jvPW0yXlC
         cB+RKjAm+QH8aOK76ZrkPrvdhBQjPN1GslKCKcI22KE8qeskHcKkUY0T9aPJPmFDubA/
         MwV5+MfC+uQrMOrwwBm6PPS/veWosmi3VrnyJ2AdmXj87A9NE0MxdaCVuS9u6DWxuSMF
         w9JZUnOVlBC7ihohTMC+rZyS1jV4LxT19930MlC3kWZgV71/leGCavbPPbhIAqdT6lkq
         otf86aoiWq4ZvxVsKNgyRA/YG6TwRQr5iDMqFQEqmw9ZBxmS3LnNSWhjYlwwjJwidnM8
         Z44Q==
X-Gm-Message-State: AOAM5335u1UMaT4bH/LjT1Q24Rr1jocDxzySAvWytIHSd315JknHHPBL
        m5r9mhqZmVsU7a5OHwQeK6pfZcmUNUiLN07NA/z6+w==
X-Google-Smtp-Source: ABdhPJyA9B2d4k/BLN+YlgZ956Kq0TBgqLh/LAv5CQUubzJKNNprdD+OPYvVcmMGWCijfe7bNVID4AMRQWC3bvuEBK8=
X-Received: by 2002:a5b:88a:: with SMTP id e10mr1625126ybq.412.1602612412891;
 Tue, 13 Oct 2020 11:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201013135913.29059-1-georgi.djakov@linaro.org> <20201013135913.29059-3-georgi.djakov@linaro.org>
In-Reply-To: <20201013135913.29059-3-georgi.djakov@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 13 Oct 2020 11:06:17 -0700
Message-ID: <CAGETcx9kzB2QxNXUNtVx0szh4c=J=ZuBFXZDiRwb8+y-NVa1qA@mail.gmail.com>
Subject: Re: [PATCH 3/3] interconnect: qcom: sc7180: Init BCMs before creating
 the nodes
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>, okukatla@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 6:59 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently if we use sync_state, by default the bandwidth is maxed out,
> but in order to set this in hardware, the BCMs (Bus Clock Managers) need
> to be initialized first. Move the BCM initialization before creating the
> nodes to fix this.
>
> Fixes: 7d3b0b0d8184 ("interconnect: qcom: Use icc_sync_state")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/qcom/sc7180.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
> index bf11b82ed55c..8d9044ed18ab 100644
> --- a/drivers/interconnect/qcom/sc7180.c
> +++ b/drivers/interconnect/qcom/sc7180.c
> @@ -553,6 +553,9 @@ static int qnoc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       for (i = 0; i < qp->num_bcms; i++)
> +               qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
> +
>         for (i = 0; i < num_nodes; i++) {
>                 size_t j;
>
> @@ -576,9 +579,6 @@ static int qnoc_probe(struct platform_device *pdev)
>         }
>         data->num_nodes = num_nodes;
>
> -       for (i = 0; i < qp->num_bcms; i++)
> -               qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
> -
>         platform_set_drvdata(pdev, qp);
>
>         return 0;

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana
