Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7542052C7
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbgFWMqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgFWMqA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 08:46:00 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1917CC061755
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2020 05:46:00 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g14so968706ual.11
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2020 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAof4l6XkgdGT8Mvck4bZOKs1Q1y9tSFhmWkYUfuub8=;
        b=RkQSkqLyGwzs2iFHffDo1JgFlZQCxD0GMS1SrehB2RFZw9k0BJYiHmRBlNEwe1tCPy
         +jPLJSiXL6eSGnAFlsjoSczsgTk3TPm/9R8U+QLLJx49+C4W9iOGAf6iOC6Pn+e2jS87
         IBZuG2DZUr8Y1bY35wdtz4HPFn+v6jIie8BxFfPjkMfzpnZoyb4+a7kzJ/4mavO9N2UF
         xwBdk8dXrsPR6epUDoIJNV2fb937Jbc5D0scsYIeeJScw61PIz3j0AULrpkEhxI83K33
         GR4SwWNBU3kGPztqFmTi3OqIqR4MEcpY2ja/N6bnL3jAZ05EVKSXF9obk6elz9SOOva5
         kwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAof4l6XkgdGT8Mvck4bZOKs1Q1y9tSFhmWkYUfuub8=;
        b=KvEZMvMV6Rdx9mKugF9dBWj72ubFwJf0fO0t3qPGXIZ9Q5YmNwOvqZGwDNRR5pYLks
         gReqylLwQJf+wOz9zNC8qKuubal4qQmG/KKgopgojOl900wiw+jZX/DYbaKG+VGpt6Fo
         /8ebZqtCMovIn7eNOefs5Xkil+PSVdchzJLQeBkoP3dHHCNnhvSOKCwPsrLcipq5q+Ck
         4BQnEpQCv9a5/0wv9QOzNue1yND7+95wx/U8V448k0vgn5yxG2Q2d9lLU8vXeyW3Cfhh
         vsbHCbuHFzW83m+3IiNW0+v9imVTaEMF+XYmQqID9kBWIi9KzzSav2io22dHdXpuhGzm
         fSJg==
X-Gm-Message-State: AOAM532tmuTULflJcGwWfpkJN6Ra3uDN0ZN3Qvw8EuEe+4zBRIx88pfe
        EOPpoti+G+ozlWBJyiYJ9JGls9Ofkynqo0VZLAzS4g==
X-Google-Smtp-Source: ABdhPJyIYYRHdQZVKDkjYnKg3hSsbW9yUVOGY6lvGON7kQV2dQbJBZxTNVcxlvAzgD+CVerQPYrcvIbxjahad/EcX3A=
X-Received: by 2002:ab0:a81:: with SMTP id d1mr15034075uak.67.1592916359200;
 Tue, 23 Jun 2020 05:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <1592212056-31955-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1592212056-31955-1-git-send-email-wangqing@vivo.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 23 Jun 2020 18:15:48 +0530
Message-ID: <CAHLCerNJ8QAzTohuNW3tseji31Ab7Ga11PXo=T+sm8yeoPFkaA@mail.gmail.com>
Subject: Re: [PATCH] drivers/thermal: Use kobj_to_dev() instead
To:     Wang Qing <wangqing@vivo.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15, 2020 at 2:37 PM Wang Qing <wangqing@vivo.com> wrote:
>
> Use kobj_to_dev() instead of container_of()
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/thermal/thermal_sysfs.c
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb..3e92ff9
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -438,7 +438,7 @@ static umode_t thermal_zone_mode_is_visible(struct kobject *kobj,
>                                             struct attribute *attr,
>                                             int attrno)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct thermal_zone_device *tz;
>
>         tz = container_of(dev, struct thermal_zone_device, device);
> @@ -464,7 +464,7 @@ static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
>                                                struct attribute *attr,
>                                                int attrno)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct thermal_zone_device *tz;
>         enum thermal_trip_type trip_type;
>         int count, passive = 0;
> --
> 2.7.4
>
