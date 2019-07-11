Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBE865E28
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 19:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfGKRGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 13:06:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42690 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfGKRGq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 13:06:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so4550441lfb.9
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5j7z1tlACT61nuFnKG/Eec995GLAXwXEnm5NfF1n5nI=;
        b=U9sxa8fSXSruS90asSicj9t1oMJy9v72igCT9Qbcik/hA2dpzv/9CUHo6btpjcTrSD
         gIE4ApjaO9/tQ754+nqPWc101+0P0JsvUDPMdMxiR0PybRR3o1Q2vBtMpkFcY9U8ArJJ
         sO5KOKBFMbHuR+7UAixtCB9tDnCSusoxMLLTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5j7z1tlACT61nuFnKG/Eec995GLAXwXEnm5NfF1n5nI=;
        b=jXOLAUWumwToRmsaSHSTgkIWJubQ7WLOKw8GVvKSokVT4iUuPYuJKrlGPbVfxHcLNr
         R1FBJWf7h4EWoE7oNhKyQigAW3Olm/hkk+cVsp/dmYgb6GKe7y6CEWGZ1zLEetLw4thd
         42QSisTAnnGyuCP7WI9d2mrd8MWDR/82o0vCPsJPn5QvcMZr1j1pxe7+nmoEw5GXH6Mx
         fSj85gaTXHQ9z1Cu6I7VNZcuCOGw20GNkuv7Ye5uWrO1UzJ/phoO2KXmda4xNlPtR2JX
         E3NxO7d5UqUPhfUqGLDb6Xy3ZwfhytDQUmAvDfMbtgaim2UCN+4/KkakgbdAi2xkCKTm
         yx0w==
X-Gm-Message-State: APjAAAWu5x0gd/P6VgLRi4amwV+kCUTvNYew8kcwb5lnIKdDzOrkpB6Y
        SZ/4fAyEqPpnOm+4iwA/xgA5CSgMgmY=
X-Google-Smtp-Source: APXvYqzNFUsiDPZObfqDS7AnaDE96xl46NhK2rdfizqRCyrdVW6+23KsBpOE9dDoAZXtMpAQIsAcvQ==
X-Received: by 2002:ac2:495e:: with SMTP id o30mr2430318lfi.140.1562864803376;
        Thu, 11 Jul 2019 10:06:43 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id n1sm813294lfk.19.2019.07.11.10.06.41
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:06:41 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id r15so4546168lfm.11
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 10:06:41 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr2410156lft.79.1562864800872;
 Thu, 11 Jul 2019 10:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190618091724.28232-1-georgi.djakov@linaro.org> <20190618091724.28232-2-georgi.djakov@linaro.org>
In-Reply-To: <20190618091724.28232-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 11 Jul 2019 10:06:04 -0700
X-Gmail-Original-Message-ID: <CAE=gft6=5txOBNEyrzqPEgaZc8ehd4sm5CmDBYOaV+o3-vCNWw@mail.gmail.com>
Message-ID: <CAE=gft6=5txOBNEyrzqPEgaZc8ehd4sm5CmDBYOaV+o3-vCNWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] interconnect: Add support for path tags
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

Hi Georgi and David,

On Tue, Jun 18, 2019 at 2:17 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Consumers may have use cases with different bandwidth requirements based
> on the system or driver state. The consumer driver can append a specific
> tag to the path and pass this information to the interconnect platform
> driver to do the aggregation based on this state.
>
> Introduce icc_set_tag() function that will allow the consumers to append
> an optional tag to each path. The aggregation of these tagged paths is
> platform specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c           | 24 +++++++++++++++++++++++-
>  drivers/interconnect/qcom/sdm845.c    |  2 +-
>  include/linux/interconnect-provider.h |  4 ++--
>  include/linux/interconnect.h          |  5 +++++
>  4 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 871eb4bc4efc..251354bb7fdc 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -29,6 +29,7 @@ static struct dentry *icc_debugfs_dir;
>   * @req_node: entry in list of requests for the particular @node
>   * @node: the interconnect node to which this constraint applies
>   * @dev: reference to the device that sets the constraints
> + * @tag: path tag (optional)
>   * @avg_bw: an integer describing the average bandwidth in kBps
>   * @peak_bw: an integer describing the peak bandwidth in kBps
>   */
> @@ -36,6 +37,7 @@ struct icc_req {
>         struct hlist_node req_node;
>         struct icc_node *node;
>         struct device *dev;
> +       u32 tag;
>         u32 avg_bw;
>         u32 peak_bw;
>  };
> @@ -204,7 +206,7 @@ static int aggregate_requests(struct icc_node *node)
>         node->peak_bw = 0;
>
>         hlist_for_each_entry(r, &node->req_list, req_node)
> -               p->aggregate(node, r->avg_bw, r->peak_bw,
> +               p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
>                              &node->avg_bw, &node->peak_bw);
>
>         return 0;
> @@ -385,6 +387,26 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  }
>  EXPORT_SYMBOL_GPL(of_icc_get);
>
> +/**
> + * icc_set_tag() - set an optional tag on a path
> + * @path: the path we want to tag
> + * @tag: the tag value
> + *
> + * This function allows consumers to append a tag to the requests associated
> + * with a path, so that a different aggregation could be done based on this tag.
> + */
> +void icc_set_tag(struct icc_path *path, u32 tag)
> +{
> +       int i;
> +
> +       if (!path)
> +               return;
> +
> +       for (i = 0; i < path->num_nodes; i++)
> +               path->reqs[i].tag = tag;

It's a little unfortunate to have this tag sprayed across all the
request nodes in the path, even though it's really a single value. If
we thought there were likely to be more attributes common to a path
that a provider might want access to, we could add a pointer to the
path in icc_req, then stick the tag in the path. But if the tag ends
up being the only thing worth looking at, then I guess what you have
now is slightly better.
