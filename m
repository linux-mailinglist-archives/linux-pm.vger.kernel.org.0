Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E937E4A9EEE
	for <lists+linux-pm@lfdr.de>; Fri,  4 Feb 2022 19:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377514AbiBDSZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Feb 2022 13:25:40 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:41905 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377520AbiBDSZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Feb 2022 13:25:34 -0500
Received: by mail-yb1-f176.google.com with SMTP id g14so21145480ybs.8
        for <linux-pm@vger.kernel.org>; Fri, 04 Feb 2022 10:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atWEyHSnUBVM1VPuCOanje1Np1yfQUZk0+Z/FrpuYk4=;
        b=AS3LPO6eSkVZ1jbH5KiX6v1cfxwKE5FQUTzGFneJid2PYkhmO/nce3tyJD3uDRk25I
         kJCsIb7EZ/kciwg2WW3ep61pUZp1fp/ziglnU5tzs2hO+5mI63Wpi6tteloilIE7K23w
         oI3Hq383CimD/dNPhnkMMbiN7wpcnw0WGFq1D4Z9RY8WKvl6Rhw8TyFVi3HlJIf6gVad
         oqoqqyq0YOGH46dVZohvb2lN2RTFNXMfdI8ss1QR/DRLmwffIXTlQ1lZxwCDBTxSSlhe
         3UWIv0/aZyk9yf62E6r36go//d+HSKFlz5TyRHI0/lNekoRkA2PSfuTMRKq09rBRcLUe
         OcSQ==
X-Gm-Message-State: AOAM531+uv/xAPVkUBNW9KwlaDJ/oSVD0jmqCb6QGsodxTclEpkr05vT
        5zQfD7rVUpHM6wI0Aj3x0KWYMKbQX2LZBC9xEZ3sSpEl
X-Google-Smtp-Source: ABdhPJzkJyGSbHA33V6ivBzEIikzEopTd/nOS1/pXnVwSu3oqVtPk25yskDmwRAlQd5H96f7uPBKHhFSRb8GDCLx02g=
X-Received: by 2002:a05:6902:54c:: with SMTP id z12mr440573ybs.624.1643999133509;
 Fri, 04 Feb 2022 10:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20220123124508.463305-1-haokexin@gmail.com>
In-Reply-To: <20220123124508.463305-1-haokexin@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 19:25:22 +0100
Message-ID: <CAJZ5v0j0d4VwmwzZ1E+Qv28DLQDLLwAxZ3KGCZgOBrikWHpXbg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: Move to_gov_attr_set() to cpufreq.h
To:     Kevin Hao <haokexin@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 23, 2022 at 1:49 PM Kevin Hao <haokexin@gmail.com> wrote:
>
> So it can be reused by other codes.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_governor_attr_set.c | 5 -----
>  include/linux/cpufreq.h                     | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor_attr_set.c b/drivers/cpufreq/cpufreq_governor_attr_set.c
> index a6f365b9cc1a..771770ea0ed0 100644
> --- a/drivers/cpufreq/cpufreq_governor_attr_set.c
> +++ b/drivers/cpufreq/cpufreq_governor_attr_set.c
> @@ -8,11 +8,6 @@
>
>  #include "cpufreq_governor.h"
>
> -static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
> -{
> -       return container_of(kobj, struct gov_attr_set, kobj);
> -}
> -
>  static inline struct governor_attr *to_gov_attr(struct attribute *attr)
>  {
>         return container_of(attr, struct governor_attr, attr);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 1ab29e61b078..f0dfc0b260ec 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -658,6 +658,11 @@ struct gov_attr_set {
>  /* sysfs ops for cpufreq governors */
>  extern const struct sysfs_ops governor_sysfs_ops;
>
> +static inline struct gov_attr_set *to_gov_attr_set(struct kobject *kobj)
> +{
> +       return container_of(kobj, struct gov_attr_set, kobj);
> +}
> +
>  void gov_attr_set_init(struct gov_attr_set *attr_set, struct list_head *list_node);
>  void gov_attr_set_get(struct gov_attr_set *attr_set, struct list_head *list_node);
>  unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *list_node);
> --

This one and the [2/3] have been applied as 5.18 material.

I've replied to the [3/3] directly.

Thanks!
