Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC136AFD5
	for <lists+linux-pm@lfdr.de>; Mon, 26 Apr 2021 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhDZIlf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 04:41:35 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40567 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhDZIle (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Apr 2021 04:41:34 -0400
Received: by mail-lj1-f181.google.com with SMTP id u25so24778500ljg.7;
        Mon, 26 Apr 2021 01:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6gNVvOiR0ozmqw7vkwGL4qgwZk8wq86oyuvkoYSrXvU=;
        b=UaGoRJ/5kr9iBP3Kfbi/16ivZgTh+CVe8jCNzO+zVvxQHpyL5/N0oU8Ylkf7yLDxwB
         gsf2ipKEbCLr4a2y0JrX40YlwOUUBuC/ZS/b2ZR1c73bZ9zDwrkmx7WL47oZDVAPlgt4
         2qTqUAZlScdCTtwebvMhdaS+zA/8UBFc32BgeLkO+nzOAAc/uDQU/xuk9P/0vhDxszj7
         3deJKf6wY+nKQdwtLZOzbnRHByPah/0/4noeOaRsCptj2b0jlaVqZzqigFg5BK4XphZU
         zl9AtkbcGxoLV81eLvp1/B/wjIiKmJ0XcE/zzqxM1j0214VAVHZywaZT9kTBFINnUO+G
         qXhQ==
X-Gm-Message-State: AOAM533ZDsN3LVkft4od/jTG6uwy3DbbH53yl5oSJvArXNZS1rcJTmgw
        m1Z0PjNwHnvlr/FL35cXh6NUJUpueVxSoA==
X-Google-Smtp-Source: ABdhPJztgLX4u8BWEczFJjAJocn97DL6/OoLug0rr3nRZ70W/CSjYIbipK1rsXJa4L7LXnv6mH1ySw==
X-Received: by 2002:a2e:9d05:: with SMTP id t5mr12404958lji.352.1619426451775;
        Mon, 26 Apr 2021 01:40:51 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id v11sm1445189ljp.63.2021.04.26.01.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 01:40:51 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 124so6020988lff.5;
        Mon, 26 Apr 2021 01:40:51 -0700 (PDT)
X-Received: by 2002:ac2:550a:: with SMTP id j10mr12313284lfk.618.1619426451227;
 Mon, 26 Apr 2021 01:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421090354.GF19953@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20210421090354.GF19953@lemon.iwr.uni-heidelberg.de>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 26 Apr 2021 16:40:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v64U3vMew8LUU776Mx7jYj3eVb4FXQdXMZ0aJNBPUh2D2A@mail.gmail.com>
Message-ID: <CAGb2v64U3vMew8LUU776Mx7jYj3eVb4FXQdXMZ0aJNBPUh2D2A@mail.gmail.com>
Subject: Re: [RFC PATCH] axp209 PMIC: setting constant_charge_current to 0
 disables battery charging
To:     Hermann.Lauer@uni-heidelberg.de
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Apr 21, 2021 at 5:05 PM <Hermann.Lauer@uni-heidelberg.de> wrote:
>
> Dear Maintainers,

First of all, please format the subject line like other commits to the
same file. So that would be:

    power: supply: axp20x_battery: <change>

> this proposed patch allows setting constant_charge_current to 0 on axp209
> PMIC to disable charging. constant_charge_current_max with a value of 0 makes
> no sense and should still report the maximum allowed value, so the getter code
> is unrolled for the POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT case.

This is probably not the right way to do it.

The sysfs ABI docs say that some chargers implement a writable "status" sysfs
property to allow disabling the charger [1]. IMO this is the proper place to
enable/disable the charger. POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT only
refers to the "constant current" portion of the charge cycle, and should not
be used to implement full control of the charger.


Regards
ChenYu

[1] https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-class-power#L444
