Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4C225726
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 07:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgGTFne (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 01:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgGTFne (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 01:43:34 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE088C0619D4
        for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2020 22:43:33 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j186so7848162vsd.10
        for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2020 22:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbLapiGcJOFTbUyK//8Fe9PD8yV2JZi5AG9HjtvvQrA=;
        b=jj1lurMJabflLy5RgODdvDSsqwg4LNBBvV2vJXasXqtYgo0+msjC1M2ABFQX2Hx0S5
         JWRrVYPqvC6wx21kAa9FwFts+z6ojJytWWnpeK0SPmUSZortpePdjvlDiVu2PQnIcM/S
         RsUIgoiQLAjSFOnQgadcWhqlix+fY4oThTwOJ95eghx9hxzF/NUGG347CBv/+2yQSd2v
         ac9XPl9rkZpSEFqgHhK8ffVqcCUvfCEJJrDtuVT7HWHQWYx2YFmBfbM4G/hJweli/Zfn
         ikouE1LntmptRTsrCvV19wZcTWEEsvSGyw+TAA5K/N07kmoqvT275Vq1a5AhRZS47OcC
         FtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbLapiGcJOFTbUyK//8Fe9PD8yV2JZi5AG9HjtvvQrA=;
        b=hFvae3PqYROZVqkYMuf8J9I1cNimwGkH8q1Z/S7c2OuMuBuV6esvD/93Q6PJUtUfqw
         ZtH6ggL4ZaIyySnPO+RKuYxsGdxsgXizgrLKXmp4Zrc0B+ldnHTG5UxDW56DXjjmvxp3
         y5T79Hgeyt7q+/lnDtQH7RuLSkPayhZd88C9lF/3IAkwc2BMHOJtJuWx2so+/DdnFqOD
         Li3t1v1XPzH182n2nTYaf2TgEZuAGL3zo5Y+bESAHzxu+nBjnaRgSaI10etTmNkc6bbl
         meJGctjLFC4m0qUTir0ZoefqYvCZs3LRKiUAmFqeTd9Zc05Q1AQ/prfchFoSfCrpCPta
         fETA==
X-Gm-Message-State: AOAM531BO8GpZGNWog8w8LvGqsBKSnN7oMojCyMtI6WFhO0wrDnw1+TR
        STCLUf8JJVPXo5hiqGZ+lJqYZ5tMseMvY8NReJAQeFSQcBq+KA==
X-Google-Smtp-Source: ABdhPJyjgOlgkreB2uvU8zXbH7F+KFhG4EFoZL6NjUMOyUv9H1nqnfOF2ArdbefVQmvPiC+CFEQwocwOCYmxkSO99Cg=
X-Received: by 2002:a67:2285:: with SMTP id i127mr14138213vsi.159.1595223812879;
 Sun, 19 Jul 2020 22:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200717164217.18819-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200717164217.18819-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 20 Jul 2020 11:13:21 +0530
Message-ID: <CAHLCerNfKGmEz9g98VA6iMYy7MjfwfH=gaF9KR0o_qpJwFPekA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: netlink: Improve the initcall ordering
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 17, 2020 at 10:12 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The initcalls like to play joke. In our case, the thermal-netlink
> initcall is called after the thermal-core initcall but this one sends
> a notification before the former is initialzed. No issue was spotted,

typo: initialized

> but it could lead to a memory corruption, so instead of relying on the
> core_initcall for the thermal-netlink, let's initialize directly from
> the thermal-core init routine, so we have full control of the init
> ordering.

> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c    | 4 ++++
>  drivers/thermal/thermal_netlink.c | 3 +--
>  drivers/thermal/thermal_netlink.h | 6 ++++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 25ef29123f72..c2e7d7aaa354 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1581,6 +1581,10 @@ static int __init thermal_init(void)
>  {
>         int result;
>
> +       result = thermal_netlink_init();
> +       if (result)
> +               goto error;
> +
>         mutex_init(&poweroff_lock);
>         result = thermal_register_governors();
>         if (result)
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index dd0a3b889674..42eace7401da 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -641,8 +641,7 @@ static struct genl_family thermal_gnl_family __ro_after_init = {
>         .n_mcgrps       = ARRAY_SIZE(thermal_genl_mcgrps),
>  };
>
> -static int __init thermal_netlink_init(void)
> +int __init thermal_netlink_init(void)
>  {
>         return genl_register_family(&thermal_gnl_family);
>  }
> -core_initcall(thermal_netlink_init);
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
> index 0ec28d105da5..828d1dddfa98 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -6,6 +6,7 @@
>
>  /* Netlink notification function */
>  #ifdef CONFIG_THERMAL_NETLINK
> +int __init thermal_netlink_init(void);
>  int thermal_notify_tz_create(int tz_id, const char *name);
>  int thermal_notify_tz_delete(int tz_id);
>  int thermal_notify_tz_enable(int tz_id);
> @@ -23,6 +24,11 @@ int thermal_notify_cdev_delete(int cdev_id);
>  int thermal_notify_tz_gov_change(int tz_id, const char *name);
>  int thermal_genl_sampling_temp(int id, int temp);
>  #else
> +static inline int thermal_netlink_init(void)
> +{
> +       return 0;
> +}
> +
>  static inline int thermal_notify_tz_create(int tz_id, const char *name)
>  {
>         return 0;
> --
> 2.17.1
>
