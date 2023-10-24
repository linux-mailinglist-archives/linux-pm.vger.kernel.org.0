Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E107D4E2C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjJXKoh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJXKoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 06:44:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB962E5
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 03:44:34 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so3943600276.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698144274; x=1698749074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57CJP2CeKNDQxn7ZmDxUfwchphm7FXKKVZwgrQ82/58=;
        b=LCOu1H3q16nrSVyenEkU1v1+L0LWrcjbKJmccExsbSAbl1WO7lB6UFDb+oAnY2VUCJ
         69T4eabAT6l3kU5NVb0vAhNAw1f7/it1OKncBCkOEF1fXTAyyj95j3JqAi3YhEVxBN+E
         03+IIW9M56erDdOx3M54SISrVx1vwBfSNAC7b5s/NWdSkyjejWSGO7T+rSEcRORhsSE6
         EX/mQrwNx41k2EUw0fn0gHnBQ/DRsAuXIH7gGuiP+5QEThx6rtqG15Iua9ez+FimSet0
         aPOm2YMeG9Y24SrvfgE3+hN1O/tpKt3SkfNKvDp0RRps1IFxYKuWUoDrbC+dWosC6QQV
         CIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698144274; x=1698749074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57CJP2CeKNDQxn7ZmDxUfwchphm7FXKKVZwgrQ82/58=;
        b=nA9u8S9yPDM4LG3bbIi4cW6/tMCf/fqmCWeAYWlH/I5XhnC7VIJSUVhGCOB08IKx0h
         /z8eYadFx5fI38gryLyqJZPv8/LLy9BsPkfqH0KIumZYyPDAdYGzYVfM6J23CdN0VEgF
         qXNGdSt+hAESzAGHS/IDRerFKdQI1+zXl8xdlVoeNpKm0ilHDPVSQdNkcATid7wryZlF
         uzgo+g2OB91tqY8aABpu6CEC1O8VtgDyrCu62UDY19JnsxVjJnmG5O6oxWCXKoRXUZyx
         kBCjdUweouib2oGpQOKnFdGS9aK3kv+mWeujWNqHwiRXUC7amsd7P604lVEHe/toHYGf
         71Kg==
X-Gm-Message-State: AOJu0Yy6KY3hkgET0g6vbMOFX1CAjMjafPZQ9u6lCa7L70NMXb4iM/Uc
        Y1m558D7Y/1WGT5rzQs5kt7ZMxdUbkXgCWeWgZtE7Q==
X-Google-Smtp-Source: AGHT+IG1v3l8QqghzcZNW12R9dqeFhTDhSBz68vgtAwKvYcl3iHp3lbtX+TDyexSy7qCPgoa8HoyrWCOBHYIVM15PK4=
X-Received: by 2002:a05:690c:fc4:b0:5a7:bff2:12fd with SMTP id
 dg4-20020a05690c0fc400b005a7bff212fdmr13665421ywb.10.1698144274008; Tue, 24
 Oct 2023 03:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231024101251.6357-2-mcanal@igalia.com>
In-Reply-To: <20231024101251.6357-2-mcanal@igalia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Oct 2023 12:43:58 +0200
Message-ID: <CAPDyKFrk5OQVQi-OpqWHJt7KrRqonertjaPEngrO2RCuvY9fUA@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: bcm: bcm2835-power: check if the ASB
 register is equal to enable
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Melissa Wen <mwen@igalia.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 24 Oct 2023 at 12:13, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
> refactored the ASB control by using a general function to handle both
> the enable and disable. But this patch introduced a subtle regression:
> we need to check if !!(readl(base + reg) & ASB_ACK) =3D=3D enable, not ju=
st
> check if (readl(base + reg) & ASB_ACK) =3D=3D true.
>
> Currently, this is causing an invalid register state in V3D when
> unloading and loading the driver, because `bcm2835_asb_disable()` will
> return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
> ASB slave for V3D.
>
> [v2]:
>     * Use the !! operator to assure the correct assertion (Stefan Wahren)
>
> [v3]:
>     * Include a changelog (Stefan Wahren)
>     * Include Florian's and Stefan's Reviewed-by

The version information belongs a few lines below.

>
> Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>

No need to resend this time. I have amended the patch to remove the
version information from the commit message, applied it for fixes and
added a stable tag!

Kind regards
Uffe

> ---

This is where you manually need to edit the format patch-file to add
the version information.

End the section with three dashes and a newline, like below:

---
>  drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index 1a179d4e011c..d2f0233cb620 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power *=
power, u32 reg, bool enable
>         }
>         writel(PM_PASSWORD | val, base + reg);
>
> -       while (readl(base + reg) & ASB_ACK) {
> +       while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
>                 cpu_relax();
>                 if (ktime_get_ns() - start >=3D 1000)
>                         return -ETIMEDOUT;
> --
> 2.41.0
>
