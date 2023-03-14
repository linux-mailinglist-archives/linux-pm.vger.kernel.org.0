Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178B06B9DCC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCNSDY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 14 Mar 2023 14:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCNSDX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 14:03:23 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F986A404
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 11:03:20 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id o12so65505158edb.9
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 11:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2RROzC0o9WqySHsHq3IFCv4O9KqAgawmYq/Wc38umg=;
        b=ISK00IvFTZpgtW3PWJdq70XopkTj/k3TFUX7FekrlRILTcJ6PnPMHEHMYsp+ZDJZq3
         CbYPdJdAR0ZMdO+6uFW1DdQZBFm/nRDzl5TertHjRejaX3iORI/dTTKynLWUUHGtr/ba
         /zzCQEY8mFgWdIsnicQjZuUNzO05yKBb/bavFgV5yA5XA6Uli8cCq6IzcfHjYFy35BnK
         ZjK3ON3QpJtPoJgXFiOL9WLkhBhFFmnfixvl8sf6PZQ1o6Mr0wdXs/3fnciWCscDeFNp
         oydczTJZo/SsiUoNKG5xBwwZv0TAeaJJ1n7r7tccGAwK+KOURq2mnF0V3zyYl12fWGgm
         Ro5A==
X-Gm-Message-State: AO0yUKW2z70H6f/XxVNRVYTpAai9LVp/SSgeQ0CncDqyGcERQuH12Ns7
        dnACrYqIDy/p+WM90tTp6KGcyV1cELghZ3MkFwI=
X-Google-Smtp-Source: AK7set9BStrej4ruV/reeb/zqbnBsyVe3rjE7876HedES949Wk5ZfmYxuQw2Bhotymw8kJY16g9uABsIOB9Mz9jU7KU=
X-Received: by 2002:a17:906:bcc1:b0:8b1:749f:b2c6 with SMTP id
 lw1-20020a170906bcc100b008b1749fb2c6mr1555218ejb.2.1678816998588; Tue, 14 Mar
 2023 11:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230314155010.3692869-1-idosch@nvidia.com>
In-Reply-To: <20230314155010.3692869-1-idosch@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Mar 2023 19:03:07 +0100
Message-ID: <CAJZ5v0gKR6xzZUgATEMCGnAgtq3dGo-QyM372yvWqJPMu3r=GQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Restore behavior regarding invalid trip points
To:     Ido Schimmel <idosch@nvidia.com>, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, mlxsw@nvidia.com, vadimp@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 14, 2023 at 4:50 PM Ido Schimmel <idosch@nvidia.com> wrote:
>
> Cited commit stopped marking trip points with a zero temperature as
> disabled, behavior that was originally introduced in commit 81ad4276b505
> ("Thermal: Ignore invalid trip points").
>
> When using the mlxsw driver we see that when such trip points are not
> disabled, the thermal subsystem repeatedly tries to set the state of the
> associated cooling devices to the maximum state.
>
> Fix this by restoring the original behavior and mark trip points with a
> zero temperature as disabled.

What if the temperature is negative?  I think that you'd still want to
disable the trip in that case, wouldn't you?

Daniel, what's your take on this?

> Fixes: 7c3d5c20dc16 ("thermal/core: Add a generic thermal_zone_get_trip() function")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 5ae72f314683..63583df4498d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1309,7 +1309,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>                 struct thermal_trip trip;
>
>                 result = thermal_zone_get_trip(tz, count, &trip);
> -               if (result)
> +               if (result || !trip.temperature)
>                         set_bit(count, &tz->trips_disabled);
>         }
>
> --
