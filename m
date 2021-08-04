Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECF3E072C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhHDSHN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:07:13 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34550 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhHDSHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:07:13 -0400
Received: by mail-ot1-f49.google.com with SMTP id e13-20020a056830200db02904f06fa2790cso2440710otp.1;
        Wed, 04 Aug 2021 11:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYqG4QXoSp28eXqQGcJnRQ+yb/Mnrr/VGHid3OstWEM=;
        b=BZt3alAl9T4ch9/PjpSbppW/C+pxLSjnuDMsWnRGqsIvYSyMTwy+ueKL4AprUJH9ks
         u3WxW9GCPmBCw/zfYc1jp1AWJ8pYWFJ4JAu5jZ4YZVsWQ+SJlFOt9DhFLws+t3ClgghW
         qwZxK++fgL/+dwQuYe4u10QVQRd8IsnUJUU4WZcWTBoz7eC55LPjsSdxlbSLYFyBKbvX
         gdlOkPDhkYhBU7rhgiVWH3YbPpdI9DJYQW4PWBBFv2/dAfXzBWURUqoAZ1h7Ugwesbfe
         law8AaGdQXyJoNMJjUF8LHpJmIDyxL8LCN5DjLdOypLblJNvmH6sPDPvohG/oPVgYbU/
         j7FQ==
X-Gm-Message-State: AOAM530pNU/YtjrFZrrWM3cTfYe8NBppZN1jJNM3tkCc0raYSnFb4zBy
        aWwuaIZ16idUo2spg4GnEAWO2rxPbtjviNgFuoo=
X-Google-Smtp-Source: ABdhPJzfkepS4uxITjIGI3lPF2wXivJvih2RRS4BkNi5QoB0chen1jcEDWhaltCu67IBdWxRsFvLP7NXLSTRKEv02hI=
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr712161oto.260.1628100419994;
 Wed, 04 Aug 2021 11:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org> <20210731195034.979084-2-dmitry.baryshkov@linaro.org>
In-Reply-To: <20210731195034.979084-2-dmitry.baryshkov@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 20:06:49 +0200
Message-ID: <CAJZ5v0gWD8WSQU4oPMSdZFM9VpNpc4TAFJ=_wQLB60XFxw-Ciw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: runtime: add devm_pm_runtime_enable helper
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 31, 2021 at 9:50 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> A typical code pattern for pm_runtime_enable() call is to call it in the
> _probe function and to call pm_runtime_disable() both from _probe error
> path and from _remove function. For some drivers the whole remove
> function would consist of the call to pm_remove_disable().
>
> Add helper function to replace this bolierplate piece of code. Calling
> devm_pm_runtime_enable() removes the need for calling
> pm_runtime_disable() both in the probe()'s error path and in the
> remove() function.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/base/power/runtime.c | 17 +++++++++++++++++
>  include/linux/pm_runtime.h   |  4 ++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 8a66eaf731e4..ec94049442b9 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1447,6 +1447,23 @@ void pm_runtime_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
> +static void pm_runtime_disable_action(void *data)
> +{
> +       pm_runtime_disable(data);
> +}
> +
> +/**
> + * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
> + * @dev: Device to handle.
> + */
> +int devm_pm_runtime_enable(struct device *dev)
> +{
> +       pm_runtime_enable(dev);
> +
> +       return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);

When exactly is pm_runtime_disable_action() going to run by this rule?
 When the device goes away or when the driver is unbound from it?

> +}
> +EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
> +
>  /**
>   * pm_runtime_forbid - Block runtime PM of a device.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index aab8b35e9f8a..222da43b7096 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -59,6 +59,8 @@ extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device_link *link);
>
> +extern int devm_pm_runtime_enable(struct device *dev);
> +
>  /**
>   * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
>   * @dev: Target device.
> @@ -253,6 +255,8 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
>  static inline void pm_runtime_allow(struct device *dev) {}
>  static inline void pm_runtime_forbid(struct device *dev) {}
>
> +static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
> +
>  static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
>  static inline void pm_runtime_get_noresume(struct device *dev) {}
>  static inline void pm_runtime_put_noidle(struct device *dev) {}
> --
> 2.30.2
>
