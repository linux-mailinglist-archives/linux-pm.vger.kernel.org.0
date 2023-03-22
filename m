Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD666C549E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 20:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCVTMZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 22 Mar 2023 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCVTMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 15:12:23 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237B5D888
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 12:12:17 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id i5so30281316eda.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 12:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol/IGN1lGg75qzmAkOcWS3DYpAO+pbte/S04wpN0vBU=;
        b=QMCWaOgp1Ehcq6joEI8BH44OfQI3lwElKxtHHKpaoVKWp0NMRmaExdeCqr664hZ4/H
         9HkdxB7tI/EoHqHD8uG37z3iUukRcBLOaiFvtXllVUeZLIg1gjo8UtI/pPfw9moRNfLi
         6RPWjstaSEW777cj++OWvUcSJ9Qgzw+Ut4yTQubVuhcXP+6Nf0u6ACLwXTcKotmCow9u
         l5qz8Idux/8+CBrlOeN753XAyuxs+KpZ4VH9wnxroFazH3SsV41OX2DpM2GD3u8+w1B8
         7WOB4KwnLFCHOjJ3cO5G2ulV/u9z0cZ6QNdfqSNonWIJ1KLvule6ZupF1xpyY/luG2Qx
         5Vyw==
X-Gm-Message-State: AO0yUKXvHvMu/FvbBqNutkMXKyOmN30xY1LhFoYjXg9WmM6LYxcwmWid
        /Oe5hh+Ft3FvA5uQdYkJc+zHpQwbVrulfHqVMSU=
X-Google-Smtp-Source: AK7set8Ank6eSqO3VUrUrWdp2a7IXdWJIzjIW2S4zrvHJ4VEJ4obYRAFqbFj85LyiOnqHgQYCaHhXDvB+05d+ueIUA4=
X-Received: by 2002:a17:907:8a19:b0:931:f8b1:4472 with SMTP id
 sc25-20020a1709078a1900b00931f8b14472mr2523545ejc.2.1679512335465; Wed, 22
 Mar 2023 12:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0gFpdWih3Z4Jy6O8t9qz64w1md00ZcQY_exEn9+rC1BOw@mail.gmail.com>
 <20230320081702.203843-1-qinyu32@huawei.com>
In-Reply-To: <20230320081702.203843-1-qinyu32@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 20:12:04 +0100
Message-ID: <CAJZ5v0hROXBbV5nQ_DArx+6CgGUdGuaMMpBocGAcj9q+PiDVAA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: warn about invalid vals to
 scaling_max/min_freq interfaces
To:     qinyu <qinyu32@huawei.com>
Cc:     rafael@kernel.org, hewenliang4@huawei.com, linfeilong@huawei.com,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        zhangxiaofeng46@huawei.com, yumpusamongus@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 20, 2023 at 9:09 AM qinyu <qinyu32@huawei.com> wrote:
>
> When echo an invalid val to scaling_min_freq:
> > echo 123abc123 > scaling_min_freq
> It looks weird to have a return val of 0:
> > echo $?
> > 0
>
> Sane people won't echo strings like that into these interfaces but fuzz
> tests may do. Also, maybe it's better to inform people if input is
> invalid.
>
> After this:
> > echo 123abc123 > scaling_min_freq
> > -bash: echo: write error: Invalid argument
>
> Signed-off-by: qinyu <qinyu32@huawei.com>
> Tested-by: zhangxiaofeng <zhangxiaofeng46@huawei.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> v2:
> - reword commit message to match the actual code changes.
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6d8fd3b8d..d61f7308f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -725,9 +725,9 @@ static ssize_t store_##file_name                                    \
>         unsigned long val;                                              \
>         int ret;                                                        \
>                                                                         \
> -       ret = sscanf(buf, "%lu", &val);                                 \
> -       if (ret != 1)                                                   \
> -               return -EINVAL;                                         \
> +       ret = kstrtoul(buf, 0, &val);                                   \
> +       if (ret)                                                        \
> +               return ret;                                             \
>                                                                         \
>         ret = freq_qos_update_request(policy->object##_freq_req, val);\
>         return ret >= 0 ? count : ret;                                  \
> --

Applied as 6.4 material, thanks!
