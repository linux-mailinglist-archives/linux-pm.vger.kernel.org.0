Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE96A64A9B9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Dec 2022 22:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiLLVt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Dec 2022 16:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiLLVtV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2022 16:49:21 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FB31A077
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 13:49:20 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id q128so12722468vsa.13
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 13:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJe5NEtSkbd9smAWbsgSF2T73y6hJatTH6s+Fn1bMbI=;
        b=CBQRevtmEFAqd1TtAKxP52T/gInU3x1G/rR28CPD6d5LoM2NbmJtOCBmnkif99utni
         O5pCKwWTxzqjNRAWTW7BccuM2OxZGxZAHQskt0fzg9yCiIZ2uovsrKvuG8H5EnkFAZGd
         KMPYFsDGCbYshP2oszD+ifModnSqJq1MfwJ+mZn6O7Kpj8mAEQP95wgg/9Rup4brgWc1
         m6R7ufgPLJKBCW2XZpeO1hKSX+l5Qw8Y+i2mrV56PV/p9AXPwgqj2aovjc66a2WOlp03
         bjzZ5PHqOOX5ETDvZRg8YznZHdypMd0OpjbWabARTxRzoFldKlDS1KC1QKvbQcMs8Ns+
         UpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJe5NEtSkbd9smAWbsgSF2T73y6hJatTH6s+Fn1bMbI=;
        b=ezjtwkPyYwUDvWZ70cCV1VpjMXLV0nq1yf+j5gasQHU3AFbt+oz63vN7M9zi2JaedV
         LwTPqPWcYjGqDgNy7HcctruAiM3lQBFdf44kIoqPkgeAq0Yq0k/H72Hq5SkvDoAfco9n
         nIQ+cr2J6A9hPIB2HGW5C3RY5uaVik3iuCD+5CwC6evC29SRGEIhsHYu0SyqOvDEjNaU
         9OJMQBqF6/2MWj388PKBTgWe7muplUUeWxnvaAyXHp0WJDrE79IhPUPrY4/bADTHXev+
         gJ5TdAPw+CYnaS9mlsbO6u3Sj/st2vVxOyMRMVuUsJYxIHId6aLkQRC0+39WI0yYJ0mI
         sPeA==
X-Gm-Message-State: ANoB5pmJO9QDwyDoQbzl/h7p7BCugb0qgWXMjNk371QLrQI8RxlhnD5A
        Bd/zqRNsFFvFgFYsYMXAwYf0N2luRxh9V5H0CIOnOw==
X-Google-Smtp-Source: AA0mqf5dJiRM2ruDp6Rvl99YdXcuYvQa1gNgQk9oBbm9lzyUbe0xFq/GifZUtj9oUrij8m1EjjXnDkdgpWTROSeOhX0=
X-Received: by 2002:a05:6102:6c1:b0:3a9:b437:8bfb with SMTP id
 m1-20020a05610206c100b003a9b4378bfbmr43679050vsg.70.1670881759303; Mon, 12
 Dec 2022 13:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20221212213857.3636830-1-grundler@chromium.org>
In-Reply-To: <20221212213857.3636830-1-grundler@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 12 Dec 2022 13:49:08 -0800
Message-ID: <CABXOdTd34M1fCEdYfT7F7RAMDmvEj=Ak_Wcg+HgcU83nOFor8w@mail.gmail.com>
Subject: Re: [PATCH] power: supply: cros_usbpd: reclassify "default case!" as debug
To:     Grant Grundler <grundler@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 12, 2022 at 1:39 PM Grant Grundler <grundler@chromium.org> wrote:
>
> This doesn't need to be printed every second as an error:
> ...
> <3>[17438.628385] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1: default case!
> <3>[17439.634176] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1: default case!
> <3>[17440.640298] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1: default case!
> ...
>
> Reduce priority from ERROR to DEBUG.
>
> Signed-off-by: Grant Grundler <grundler@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
> ---
>  drivers/power/supply/cros_usbpd-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index cadb6a0c2cc7..b6c96376776a 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -276,7 +276,7 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
>                 port->psy_current_max = 0;
>                 break;
>         default:
> -               dev_err(dev, "Port %d: default case!\n", port->port_number);
> +               dev_dbg(dev, "Port %d: default case!\n", port->port_number);
>                 port->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
>         }
>
> --
> 2.39.0.rc1.256.g54fd8350bd-goog
>
