Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA191BDAC4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 13:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2Lfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 07:35:38 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:42687 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2Lfi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 07:35:38 -0400
Received: by mail-oo1-f66.google.com with SMTP id e18so341578oot.9
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 04:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0vSdUuXrYZvnS79+Lrz5kLHOmSAN476BbZ7LKFfO+c=;
        b=Pq0T84k3ylfWicJxClXTQrdBqAMsTHwkloXaz4Iae5frQz2ErOmpj94PyuKs/OB2N4
         M1K5f354k/CxfjH3PAXEW7N2SeEkZ6SHRAtmT/9DOLv6R1HUPsixiTOWQ4iJGIZRwhtD
         Iqz1/da/hW18eLcGzol74TQl0H3QUu65cCZlqy5MbbxoaAawBLpb9tioG3zXh8h8C1bk
         yP5FY02ugKTaa34O9CFY+7vmfxAnoWRYAJowpuDtWDZBdrKG9G1Kyw/vyQ0JE0x9WIxu
         ZU1BViGqzMKC5Be27aqzkz6jX3QL6Jam8daboTq3MBN/SZg+TOn/UfewgC2l/9lXTUhW
         SWfQ==
X-Gm-Message-State: AGi0PubZASxpkOKxvXXoy1+qgE/RL0i04QzrLfp1hXQvVquPM3oCUyX4
        cW0bltb9FlOH6xfZLxufkBCT6/IvE7E+J3ejciuFBQ==
X-Google-Smtp-Source: APiQypLerkxoi0DGQ2uBl+evWEdtiSQ6lgKz2ftuIeWlqXq1DEG7DDEPptmR7TncCGDc1dQbTBj5kH/FpoMBKv3A9W8=
X-Received: by 2002:a4a:a286:: with SMTP id h6mr26856639ool.38.1588160137191;
 Wed, 29 Apr 2020 04:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <1587980061-16433-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1587980061-16433-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Apr 2020 13:35:25 +0200
Message-ID: <CAJZ5v0iLqKS66Sv0cMSp-Rqkg_RKJen3RNV-mf8eexk32yx9tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: sysfs: Remove the unused define_one_r(o/w) macros
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 27, 2020 at 11:42 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> The define_one_ro and define_one_rw macros are not used,
> remove it.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/cpuidle/sysfs.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index cdeedbf..7729cf6 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -167,11 +167,6 @@ struct cpuidle_attr {
>         ssize_t (*store)(struct cpuidle_device *, const char *, size_t count);
>  };
>
> -#define define_one_ro(_name, show) \
> -       static struct cpuidle_attr attr_##_name = __ATTR(_name, 0444, show, NULL)
> -#define define_one_rw(_name, show, store) \
> -       static struct cpuidle_attr attr_##_name = __ATTR(_name, 0644, show, store)
> -
>  #define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
>
>  struct cpuidle_device_kobj {
> --

Applied as 5.8 material along with the [2/2], thanks!
