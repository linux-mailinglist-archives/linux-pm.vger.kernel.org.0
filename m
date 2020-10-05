Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B43283DC5
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 19:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgJERxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJERxk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 13:53:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BCFC0613CE
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 10:53:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so509847wmh.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 10:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=r3tGL5fFCIm4s/MLgZuOWVBF1uAs+0Ko/kCmK+D2BSM=;
        b=Va9xx7BIE4bB1jB0viqZrYu3L52GE5WLEc8khPQ3KY7DmRnDUMUk5Kh5xfit1P2LRh
         YmqYN6BEyO7601sIdYwlIWgBvbvXQgNStI1VPBaeV9wQRr1OkgRkTTJ1wI3I97Xxwfdc
         dW8T9vhE+vmrUkTpherZyku23PKogCmLkwxyT9/uGAHllCZmbWnhbU1QjdSaYIkIeYOx
         WK0iFbroi/LD8mmn4UZCp+ZPSbsHb21gJxVca4OM8ezl8zu2xYTTXhgowOkAsGeXHpVR
         FgzN5FvNs0CP2/QyZ9QsVxJ/GagixwUOMzNhzNO6dIVsfGTcWJFfwWvnofAnCfOBMMvZ
         KKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=r3tGL5fFCIm4s/MLgZuOWVBF1uAs+0Ko/kCmK+D2BSM=;
        b=dUTdfhyg6bolM2uCslxWuFZuf0pS6gePtpa5aCIecMGh8YqNzQxGXoGDQDe4j9+0AI
         I1MUWl1ExfWi8KXzBLf15H/puQUgDdhE/EKTd/rLJmWXHoKZJPgR8oW5J7T+fVeZy4yh
         54SB2QlgZNj31RIUboteBHfJ7qQ672T6rZzAj9ta58rHJA1hOvCGpO5aWb8NWXqFqgRz
         DrJltzHkgEuBcHX1mGe8eTm6hDO/e++pHUOCLQEjMXVtmQNBrwk8IUzJzwu0S4RUFqd2
         e67EQDWF6q5NrGYOzegEqDlOMYOV64O/NhYWGUfKzFie2oIeAqjokxVNQD4R9ngAWJXO
         dJTw==
X-Gm-Message-State: AOAM532eX66fgy4huu3jdxn1Yu/3tjDTCigZVv444PLkf23v4YW592Lp
        U8PY8afuy8bEaJz+utevvYa8bJ59lwo=
X-Google-Smtp-Source: ABdhPJyvHvSIHCqejpa7ATUcLNlYMDizZ2tz1at7+s8HtGHUjQyBY+DOjSm1FWpndbWoS2Y2NNzhMw==
X-Received: by 2002:a1c:ddc2:: with SMTP id u185mr555476wmg.21.1601920419353;
        Mon, 05 Oct 2020 10:53:39 -0700 (PDT)
Received: from localhost ([170.253.46.69])
        by smtp.gmail.com with ESMTPSA id 4sm959022wrn.48.2020.10.05.10.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:53:38 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <kernel@collabora.com>,
        =?utf-8?B?TWlsYW4gUC4gU3RhbmnEhw==?= <mps@arvanta.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] power: supply: sbs-battery: chromebook workaround for PEC
Date:   Mon, 05 Oct 2020 19:53:36 +0200
MIME-Version: 1.0
Message-ID: <9b4f62f2-0bf6-41bb-a946-bd94c75168b8@gmail.com>
In-Reply-To: <20201004224601.420786-1-sebastian.reichel@collabora.com>
References: <20201004224601.420786-1-sebastian.reichel@collabora.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, October 5, 2020 12:46:01 AM CEST, Sebastian Reichel wrote:
> Looks like the I2C tunnel implementation from Chromebook's
> embedded controller does not handle PEC correctly. Fix this
> by disabling PEC for batteries behind those I2C tunnels as
> a workaround.
>
> Reported-by: "Milan P. Stani=C4=87" <mps@arvanta.net>
> Reported-by: Vicente Bergas <vicencb@gmail.com>
> CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Fixes: 7222bd603dd2 ("power: supply: sbs-battery: add PEC support")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Hi,
>
> This is compile-tested only, since I do not have a chromebook at
> hand. Please test if this fixes your issue.

Hi Sebastian,
tested on rk3399-gru-kevin with 5.9.0-rc8 and now the CPU usage is 0 when=20
idling.
dmesg reports:
[    1.370249] sbs-battery 9-000b: Disabling PEC because of broken Cros-EC=20=

implementation

So,
Tested-by: Vicente Bergas <vicencb@gmail.com>

Thanks,
  Vicente.

> -- Sebastian
> ---
>  drivers/power/supply/sbs-battery.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/power/supply/sbs-battery.c=20
> b/drivers/power/supply/sbs-battery.c
> index 13192cbcce71..b6a538ebb378 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -279,6 +279,12 @@ static int sbs_update_presence(struct=20
> sbs_info *chip, bool is_present)
>  =09else
>  =09=09client->flags &=3D ~I2C_CLIENT_PEC;
> =20
> +=09if (of_device_is_compatible(client->dev.parent->of_node,=20
> "google,cros-ec-i2c-tunnel")
> +=09    && client->flags & I2C_CLIENT_PEC) {
> +=09=09dev_info(&client->dev, "Disabling PEC because of broken=20
> Cros-EC implementation\n");
> +=09=09client->flags &=3D ~I2C_CLIENT_PEC;
> +=09}
> +
>  =09dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
>  =09=09"enabled" : "disabled");
> =20

