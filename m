Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240C9138F76
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 11:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgAMKoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 05:44:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46907 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMKoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 05:44:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id 13so7744311oij.13;
        Mon, 13 Jan 2020 02:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEnbMshqr7AnMOxCyyxMuTDrOAfleJ5v6/STbjwGwzM=;
        b=lJEqlBeLsndQtien74qIzpslbY85KmR9XoyUZQBknjOai3wLkf3All2l7MUpuKEodh
         4sSNTaV3mnwvOt/F8W0FFeKjmbTMXDqMQ4chpRZ7t9m33MEZZ/tzE0vx+VR657/A1pFt
         5koXAuag7+t8Mb17lz8M6oHY3lERhjdFqyy1ZdBsL68bSjLtN60gFl/NNjqpPjKcytch
         xL/gza7zKqEzrcy4rwN7cZ7wbkTc2r6FdaqDahRouU7yvrEKsFw4IsgzPNRNY1ph+eTO
         GYXiPaKuUVwT2JA2oqhcSrv7vEbF4uKU1s2X8gPqqP3Jj2m2R33+XIbwTmFtEuKDj6sP
         UDGA==
X-Gm-Message-State: APjAAAWYJCd7KN0Dyg4Ee/hlApLNtCy0jPtG20Gwkj69EVLMT9wgWKVP
        n7TqUOxmMSpM3C0KgH8ZL/ASyoCi24JcqW8ZNg526A==
X-Google-Smtp-Source: APXvYqyiZCdCzQpXVYnCf6pQB7KZdVUv2zazGXrVSy9+MjtOMihy4cgpphS8MSGTZKEzENG3jqfdYirsnxxVuBvvwh4=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr11806704oig.68.1578912261632;
 Mon, 13 Jan 2020 02:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20200110174712.7019-1-ikjn@chromium.org>
In-Reply-To: <20200110174712.7019-1-ikjn@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jan 2020 11:44:10 +0100
Message-ID: <CAJZ5v0hc37cSNidhQUnJr5Gp4D-wjhNdgpLQvXv=9ESu9NGb4g@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: teo: bugfix in intervals[] array indexing
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "RafaelJ . Wysocki" <rafael.j.wysocki@intel.com>,
        DanielLezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 10, 2020 at 6:47 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Fix a simple bug in rotating array index.
>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  drivers/cpuidle/governors/teo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index de7e706efd46..6deaaf5f05b5 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -198,7 +198,7 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>          * pattern detection.
>          */
>         cpu_data->intervals[cpu_data->interval_idx++] = measured_ns;
> -       if (cpu_data->interval_idx > INTERVALS)
> +       if (cpu_data->interval_idx >= INTERVALS)
>                 cpu_data->interval_idx = 0;
>  }
>
> --

Applied as a fix for 5,5 and "stable", thanks!
