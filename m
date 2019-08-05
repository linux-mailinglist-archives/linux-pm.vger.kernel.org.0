Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1082132
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHEQFY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 12:05:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43103 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHEQFX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 12:05:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so58429756lfm.10
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61p5AzjQF9OjwcCgDHmk+Gn1Hy4tPflyDpQWg2DQeqY=;
        b=Wpyzd4Y2/nkmPiRjFFM8P8mROdyXEGby1MykkxLW9L1Exfr+0LwcJOAJCMZms0c2Im
         /0Ir/txcMgrbgOV1l8OtAba+XUIKIq55sZqgoSCknx6AWCJpLu+LwC9fDZiEEiRBaHgL
         fqdm4ygFQZzcnCi4raOJMsAdKGJ9l+fKlol/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61p5AzjQF9OjwcCgDHmk+Gn1Hy4tPflyDpQWg2DQeqY=;
        b=sjsX7y2isx24+xAL9DQ2ZYgtyWw6Tux/WY9KGrE9LmIwDgSuRzCfA+vDRMbrfBpJ1j
         pFSKMsiATFoAx5Ut1pb8kixbdzYOVaE9F3yVD0WE9jN4yuB0d3RWDU3R3a2NPfXLj6IK
         0REL5NXmFKUFognd3fX8GieHM3Iw2ysgVF6xyI6QOlEMWwaaQh6tngnYlgYdgJRZ74yy
         D16/cx9FfgW46jWRcqDhvRSpvwjNUnJQQtmu3QRR2bubhYzFWGxRrufKMJQPpgMUBRn7
         WR3RipveKQ0GKbv75pFWqPTiQ0nPPfK/fegpexrjX8Fb2lMzYKVcg0Ylj3xtPEO+0DIT
         9vTw==
X-Gm-Message-State: APjAAAWspHK1ATz5i+esvgijWuGwFlPFI9psjNPtbHB6EuyBmeT7mIeF
        fC1LTZHxg3j6gLIS2Gv0G9BQ6T/IUxM=
X-Google-Smtp-Source: APXvYqwMWcl7yecZ9DmR5VZEOWVbToCGyH+jhk7jnqZ40uDcdaK7W9meVCsLHCjASV/3beHbWX9yGQ==
X-Received: by 2002:ac2:5dc3:: with SMTP id x3mr1434955lfq.168.1565021121289;
        Mon, 05 Aug 2019 09:05:21 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id k82sm17393653lje.30.2019.08.05.09.05.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:05:20 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id p197so58398132lfa.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 09:05:20 -0700 (PDT)
X-Received: by 2002:a19:cbd3:: with SMTP id b202mr8777985lfg.185.1565021119654;
 Mon, 05 Aug 2019 09:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <752aca6f-4f69-301d-81ef-ff29bc25b614@linaro.org> <20190805153332.10047-1-georgi.djakov@linaro.org>
In-Reply-To: <20190805153332.10047-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 5 Aug 2019 09:04:43 -0700
X-Gmail-Original-Message-ID: <CAE=gft48ytM4Bb8iVdE7=mZkum-xx8TBm9=vE1Dj9fxnH7stnQ@mail.gmail.com>
Message-ID: <CAE=gft48ytM4Bb8iVdE7=mZkum-xx8TBm9=vE1Dj9fxnH7stnQ@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Add pre_aggregate() callback
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, David Dai <daidavid1@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 5, 2019 at 8:33 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Introduce an optional callback in interconnect provider drivers. It can be
> used for implementing actions, that need to be executed before the actual
> aggregation of the bandwidth requests has started.
>
> The benefit of this for now is that it will significantly simplify the code
> in provider drivers.
>
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks Georgi, I like it! We should confirm that it actually does
allow David to remove the sum_avg_cached and max_peak_cached shadow
arrays.

> ---
>  drivers/interconnect/core.c           | 3 +++
>  include/linux/interconnect-provider.h | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 251354bb7fdc..7b971228df38 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -205,6 +205,9 @@ static int aggregate_requests(struct icc_node *node)
>         node->avg_bw = 0;
>         node->peak_bw = 0;
>
> +       if (p->pre_aggregate)
> +               p->pre_aggregate(node);
> +
>         hlist_for_each_entry(r, &node->req_list, req_node)
>                 p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
>                              &node->avg_bw, &node->peak_bw);
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 4ee19fd41568..fd42bd19302d 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -36,6 +36,8 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
>   * @nodes: internal list of the interconnect provider nodes
>   * @set: pointer to device specific set operation function
>   * @aggregate: pointer to device specific aggregate operation function
> + * @pre_aggregate: pointer to device specific function that is called
> + *                before the aggregation begins (optional)
>   * @xlate: provider-specific callback for mapping nodes from phandle arguments
>   * @dev: the device this interconnect provider belongs to
>   * @users: count of active users
> @@ -47,6 +49,7 @@ struct icc_provider {
>         int (*set)(struct icc_node *src, struct icc_node *dst);
>         int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
>                          u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
> +       int (*pre_aggregate)(struct icc_node *node);
>         struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
>         struct device           *dev;
>         int                     users;
