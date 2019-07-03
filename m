Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF95DE2B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 08:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfGCGpf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 02:45:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34031 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCGpf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 02:45:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so1155847ljg.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptGTicjFq+J0eTU/VpcxUsmOsp/qaZSNFW8K0GR+TOs=;
        b=kWifykzpZN5anpXIiQ4YGdylV33AXUn4GyrE0mtZQ50+vZthGp8hOmYzwGAaFUTju/
         5DmP+TbKSdayBm2W4adywOLUqzuZv2ldPWrpFcUc4oUr3uWIG3tC+oZTIkunY+1HI1Hl
         I1LQvdxcJEK8TZC4EfOOfwVqjWewrJJyUAnEEkVRYxoLxXdcpyXqjkmtbEey0c/oLSF2
         jKAMFREDiyC4VRZyQ953d3IohkmgbTG+O9rdLN0dQ9j0FdaOld5pnEPn7H244FRBQqSG
         L+PpuwWTK0rCWmAI9TRp9eK8EdXAcfnU0FIvWnEFru9hwMQ/DxDvqRt1Ut4VJOFn6hnC
         hJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptGTicjFq+J0eTU/VpcxUsmOsp/qaZSNFW8K0GR+TOs=;
        b=W4O2uGrtAcbVY6gdBZrjtypp5OfNU3gB+2UzdjyOMtzGfe5jHtYyQGPvmQOxBo+PDd
         3jcBDUtx3omnleMfKgUDi2GWpn0QlIRgb+JQWHCnkXNftIdPY9wQvj3YoY4R522Xm9Xv
         3AH3kekr1Jm6a5qScUpPpz1qeKKAcCjuxupT7d1VD+TAyKZTJboBql6e1shhDk9OdFiM
         b7Bt2MBHNhBZnb9ribJpy821OucOglTzuS+q2XQMW55F49ULR2ZsH31BZP0UHvcOAGtg
         G6whVoDsWOcy3T6xejksKPV4w4dt6UtPHlQy8LaCBhwePCeLYCf/+Li/hnaexArOEXMs
         lNWQ==
X-Gm-Message-State: APjAAAWadbSOJJ51AIS1nRU7l/OoOP2GvkdT5cIPo/WmPUxV/IVkO8fX
        EtTakGtk6Pfaenu4e6Fezz7niUEol5jMN/5c9uCLwg==
X-Google-Smtp-Source: APXvYqzHLP5x6CDVK5N1nXarqor8EAB7jH3AjLWnOHwZsb5xNHK5SYSF45C/ETdsoHYS4PNC/AJ0+jRqGmYO2T35c80=
X-Received: by 2002:a2e:2e18:: with SMTP id u24mr13211024lju.204.1562136332739;
 Tue, 02 Jul 2019 23:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-7-saravanak@google.com>
In-Reply-To: <20190703011020.151615-7-saravanak@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Jul 2019 08:45:21 +0200
Message-ID: <CAKfTPtCJFaEfvu3Dnp9WSxQEwSfY=VS+xsoQ+4P+vg7_WL0BAQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] interconnect: Add OPP table support for interconnects
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>, kernel-team@android.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 3 Jul 2019 at 03:10, Saravana Kannan <saravanak@google.com> wrote:
>
> Interconnect paths can have different performance points. Now that OPP
> framework supports bandwidth OPP tables, add OPP table support for
> interconnects.
>
> Devices can use the interconnect-opp-table DT property to specify OPP
> tables for interconnect paths. And the driver can obtain the OPP table for
> an interconnect path by calling icc_get_opp_table().

The opp table of a path must come from the aggregation of OPP tables
of the interconnect providers. So such kind of OPP table should be at
provider level but not at path level.

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/interconnect/core.c  | 27 ++++++++++++++++++++++++++-
>  include/linux/interconnect.h |  7 +++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 871eb4bc4efc..881bac80bc1e 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -47,6 +47,7 @@ struct icc_req {
>   */
>  struct icc_path {
>         size_t num_nodes;
> +       struct opp_table *opp_table;
>         struct icc_req reqs[];
>  };
>
> @@ -313,7 +314,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  {
>         struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>         struct icc_node *src_node, *dst_node;
> -       struct device_node *np = NULL;
> +       struct device_node *np = NULL, *opp_node;
>         struct of_phandle_args src_args, dst_args;
>         int idx = 0;
>         int ret;
> @@ -381,10 +382,34 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>                 dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
>         mutex_unlock(&icc_lock);
>
> +       opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);
> +       if (opp_node) {
> +               path->opp_table = dev_pm_opp_of_find_table_from_node(opp_node);
> +               of_node_put(opp_node);
> +       }
> +
> +
>         return path;
>  }
>  EXPORT_SYMBOL_GPL(of_icc_get);
>
> +/**
> + * icc_get_opp_table() - Get the OPP table that corresponds to a path
> + * @path: reference to the path returned by icc_get()
> + *
> + * This function will return the OPP table that corresponds to a path handle.
> + * If the interconnect API is disabled, NULL is returned and the consumer
> + * drivers will still build. Drivers are free to handle this specifically, but
> + * they don't have to.
> + *
> + * Return: opp_table pointer on success. NULL is returned when the API is
> + * disabled or the OPP table is missing.
> + */
> +struct opp_table *icc_get_opp_table(struct icc_path *path)
> +{
> +       return path->opp_table;
> +}
> +
>  /**
>   * icc_set_bw() - set bandwidth constraints on an interconnect path
>   * @path: reference to the path returned by icc_get()
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index dc25864755ba..0c0bc55f0e89 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -9,6 +9,7 @@
>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
> +#include <linux/pm_opp.h>
>
>  /* macros for converting to icc units */
>  #define Bps_to_icc(x)  ((x) / 1000)
> @@ -28,6 +29,7 @@ struct device;
>  struct icc_path *icc_get(struct device *dev, const int src_id,
>                          const int dst_id);
>  struct icc_path *of_icc_get(struct device *dev, const char *name);
> +struct opp_table *icc_get_opp_table(struct icc_path *path);
>  void icc_put(struct icc_path *path);
>  int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>
> @@ -49,6 +51,11 @@ static inline void icc_put(struct icc_path *path)
>  {
>  }
>
> +static inline struct opp_table *icc_get_opp_table(struct icc_path *path)
> +{
> +       return NULL;
> +}
> +
>  static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  {
>         return 0;
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
