Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA546A56BE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjB1K3l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 05:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1K3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 05:29:40 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9072CFFB
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 02:29:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p20so8666984plw.13
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 02:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i51i9L4gm9YgKmcn4+3JtRaZ6InzUluZanVTZexr5Co=;
        b=MQI3+VCO9wdC/HFNe4GNotPSKnkHHYwzWxV1eOah4VsrY11XEfhhc7V+gTR/WKZtii
         bePvF+W0Mi15Zr3iN/HPABSddfRcYKyhzK2CLEB96tqhjJ0+5+dZeXPvkyx5FNQHFoqZ
         Kp8Rj2g55078K94j80asZPqWNqc47fUKRgWPjdbDMhHpZWV7MbOEjfnxr6wFyEgSVNyZ
         twetF5MRZvGxY88XRbOhawZeG+w4hhOfXHNwi3LGkNWcfvORZ6uMjMJPYZRuqnuBB7QT
         Q28rOmdTYJzlVh0nCm3YW4cok3mmsRBnBW76oxQIr9E1qKiD5K87XLHUm5/0/ETaDMUy
         IHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i51i9L4gm9YgKmcn4+3JtRaZ6InzUluZanVTZexr5Co=;
        b=b2YtzH9WwVGwEuyMMucwx7ZtZWEr4oMmiQzfuQ5g+zUY+7x+EINSkPPhjoe19h6Eam
         R6+KRPUqFTM0s/0WLRW8G7ue/gF8RoSm0eEY8SHwURuuBDy99PSjzfPKJnKkn1iNMRIX
         IuhPDyupozf5nAj4qOfZGxBLL+9UDqVOdw9zy+gLCeA7+OUZOG49IVfcVPR2EMFT2clt
         oJGxpI82mr+z6Hs1bhE+32s61pIZXUOQSVpg0aIgaXj78S2ToMqHXDst4mSWmX9qYDLF
         zQA908hhHsaA/GTnHi+yFr5MeOmDi+U/dgq3uUGeu0ZtkfTueEFVL7Y2GsIxJfwDk3ko
         IzXA==
X-Gm-Message-State: AO0yUKX1VnmIOPjG5JHD9oD/JhCwwTTD5HTNx+qour+u2ooe+hz8+zjK
        ut/hWyNsQ5COgsa6+9tMg9REDH9p4vnTHhk1Yf89vg==
X-Google-Smtp-Source: AK7set/CYKec8nhgr4pOAL6ruqsISq+MRqDlYtM3A8PX0EsLOokkixuKVPOItnrDyymvYU2FIII1h3TU2u6iX0/wtFE=
X-Received: by 2002:a17:90b:3c08:b0:235:1fb7:393c with SMTP id
 pb8-20020a17090b3c0800b002351fb7393cmr6962063pjb.1.1677580127836; Tue, 28 Feb
 2023 02:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20230228080619.412820-1-jindong.yue@nxp.com>
In-Reply-To: <20230228080619.412820-1-jindong.yue@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Feb 2023 11:28:11 +0100
Message-ID: <CAPDyKFqR=Agf77bpgUvVKRw0V4p2-1c0bKYjjDCgr3VP3ij64w@mail.gmail.com>
Subject: Re: [PATCH 4/6] PM: domains: Export genpd_dev_pm_attach_by_name()
To:     Jindong Yue <jindong.yue@nxp.com>
Cc:     rafael@kernel.org, khilman@kernel.org, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, peng.fan@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 28 Feb 2023 at 08:59, Jindong Yue <jindong.yue@nxp.com> wrote:
>
> The genpd_dev_pm_attach_by_name() allows a device to be associated with
> its PM domain by name.
>
> Export it for use by kernel modules, such as the i.MX8M blk-ctrl drivers:
> imx8m-blk-ctrl and imx8mp-blk-ctrl.

The genpd_dev_pm_attach_by_*() are not intended to be used by any
consumer drivers at all. Instead, please use
dev_pm_domain_attach_by_*() instead.

>
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> ---
>  drivers/base/power/domain.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 32084e38b73d..6d66b6b14863 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2908,6 +2908,7 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev, const char *name)
>
>         return genpd_dev_pm_attach_by_id(dev, index);
>  }
> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_name);
>
>  static const struct of_device_id idle_state_match[] = {
>         { .compatible = "domain-idle-state", },
> --
> 2.36.0
>

Kind regards
Uffe
