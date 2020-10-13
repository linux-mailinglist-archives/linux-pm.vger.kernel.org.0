Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79B728D369
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgJMSFU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJMSFT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 14:05:19 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C378CC0613D0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 11:05:19 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a12so390317ybg.9
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EL4YSi40Waetm8JFtlQtx58rjTb1nx9uVO2kymWX9Y=;
        b=i+IYLsy3sc6AGUKbF306nPzn3sLKeRQ9RsHTyiWhhaAB0uuyl1YO7ytYC/KVSEyLSK
         r7NP9DQoHat4rjLhgtkriDTD8xPowBaRhnyeqoKJp/D3VLQNokhQ2/s1W5volQK9A+W3
         aq5DVRw2uvmLmzK4dAqARo+Op/sPuPHSIf5PTsznLnjSPQnbz641/zaHmh0rNfsOHHKX
         uhxyNOC5IY84QanDw2AuGAW4VMh2qd3EcBx9jlzftKaczQ793/Xm4ET6QYo3qhJYiRQy
         D/XWAn0f68+tzMYKEJQidgnviOo/cICWuhLPSxuBz9hRQ9H2CFxMIvPLbhqQUf0dRcIQ
         AUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EL4YSi40Waetm8JFtlQtx58rjTb1nx9uVO2kymWX9Y=;
        b=Zkmp5X+cjpzbBzavlwtz2mYpN+wVnkj2JjCfs5v9OZ7PsFq187VWbOXvOICjTJsra7
         E2Sh1P5ponPXWqtSjAo5YLoZACBIa/VBNV5A56N1hGQ0xkEm0l4cC7bkVpOfmks7NxWK
         mbq2vM3vC4BmjZ8vaUaW/eWuX/DZD7iStMET/KOMurSMSMH0YhJNYfeSzSmUpgSmchc3
         F0hyyYeyd6mb1z9SATxGxK2lZhG8+2IuVOhFN4j3vnckZvwJH61cHEgLqySGaqZRXkfc
         8jGuCJkWDj8fEqEdrm1dpQYKpThskGzE++njO9hTDOXX2+apdFQ4xP4ZuU1vgTNfkdxb
         UPhg==
X-Gm-Message-State: AOAM532eZ9v4fzO01JoKULU6QH+w0iKw4qC4ELe4wpXSvjiQrbXV8Uhg
        hbG8PP2hW0fXrimKc15AisCPDsKEFCtysu0DELPlzA==
X-Google-Smtp-Source: ABdhPJx8gHsXGel6BVOgxpgYgx4FbMqAL0fAllKSdt2tK5tSyxg2VuJHaqgzZ4oAgQDQD4lqVnq4q3SJPRnoH2rjFQY=
X-Received: by 2002:a25:380c:: with SMTP id f12mr1850176yba.32.1602612318764;
 Tue, 13 Oct 2020 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201013135913.29059-1-georgi.djakov@linaro.org>
In-Reply-To: <20201013135913.29059-1-georgi.djakov@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 13 Oct 2020 11:04:42 -0700
Message-ID: <CAGETcx8JWztwy8LevoT30NrhioxF+L9XF7ezxJQ7NscL5=+Xiw@mail.gmail.com>
Subject: Re: [PATCH 1/3] interconnect: Aggregate before setting initial bandwidth
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
> When setting the initial bandwidth, make sure to call the aggregate()
> function (if such is implemented for the current provider), to handle
> cases when data needs to be aggregated first.
>
> Fixes: b1d681d8d324 ("interconnect: Add sync state support")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index eea47b4c84aa..974a66725d09 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -971,6 +971,9 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>         }
>         node->avg_bw = node->init_avg;
>         node->peak_bw = node->init_peak;
> +       if (provider->aggregate)
> +               provider->aggregate(node, 0, node->init_avg, node->init_peak,
> +                                   &node->avg_bw, &node->peak_bw);
>         provider->set(node, node);
>         node->avg_bw = 0;
>         node->peak_bw = 0;

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana
