Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0802D63DFEA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Nov 2022 19:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiK3Svp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Nov 2022 13:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiK3Svg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2022 13:51:36 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947263D51
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 10:51:34 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id z1so12989423qkl.9
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 10:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcnDPX9svyHzAY+SGpfsstGlxBbhhE6arJq/FM0DFsI=;
        b=UzNc4sNHMDRcT5K8+5FU51ykJ9PpRl2t8kg0YWXgwJCOuzd7ghDWz7+6ZRJjvgld4x
         +xAaNP1EG491Wy4BycS0l0/6KX9yAfZZVllN9JZ4lYcENcbF8gcKevFYAweA3zxMrMci
         3laEd6LXq7L9OTf8zOnYpxGgYYyRXpaYb+qhlW/NrXMtSN8IFhhX1c7tQ5oLk6vSHnqI
         baiBWJoR43V9+gO6E26I9a7GcDU1Lsr4ZMsQJpkarBoLeSPKFtjW/WpQFiEJ/XMXUJ5f
         R5ZDuBDm1PM6ZDw6hgEiRpyagpSZ1zBoEed2xetttEtinWwmHmb4/SupsMJWW6uOngiu
         cn8Q==
X-Gm-Message-State: ANoB5pkddKlNkWp1x/Z0rv43mKdioPEuSuLOscBu5zim+LgYz0IT58gA
        mhFtcpPgTjlolXZjlztjqpH1WNXhfY3GojIGrwS2Ikxf
X-Google-Smtp-Source: AA0mqf4fMcc2IuUNojATTHFCRTc90S4Z4/JN23knTpBlzZUQkjt/MEyns/mHZFK/8AQ8+V415jZM3LnXh+iOlogZoys=
X-Received: by 2002:a37:b901:0:b0:6ec:2b04:5099 with SMTP id
 j1-20020a37b901000000b006ec2b045099mr42858826qkf.501.1669834294052; Wed, 30
 Nov 2022 10:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20221116113339.177740-1-wangxiongfeng2@huawei.com>
In-Reply-To: <20221116113339.177740-1-wangxiongfeng2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Nov 2022 19:51:22 +0100
Message-ID: <CAJZ5v0jKL+bEwVw0SS_O2wZCa5EbH1KQZ09Q3kWFpWsrFRCPvg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd_freq_sensitivity: Add missing pci_dev_put()
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, Akshu.Agrawal@amd.com,
        linux-pm@vger.kernel.org, yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 16, 2022 at 12:15 PM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> pci_get_device() will increase the reference count for the returned
> pci_dev. We need to use pci_dev_put() to decrease the reference count
> after using pci_get_device(). Let's add it.
>
> Fixes: 59a3b3a8db16 ("cpufreq: AMD: Ignore the check for ProcFeedback in ST/CZ")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/amd_freq_sensitivity.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
> index 6448e03bcf48..59b19b9975e8 100644
> --- a/drivers/cpufreq/amd_freq_sensitivity.c
> +++ b/drivers/cpufreq/amd_freq_sensitivity.c
> @@ -125,6 +125,8 @@ static int __init amd_freq_sensitivity_init(void)
>         if (!pcidev) {
>                 if (!boot_cpu_has(X86_FEATURE_PROC_FEEDBACK))
>                         return -ENODEV;
> +       } else {
> +               pci_dev_put(pcidev);
>         }
>
>         if (rdmsrl_safe(MSR_AMD64_FREQ_SENSITIVITY_ACTUAL, &val))
> --

Applied as 6.2 material, thanks!
