Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F298B33903E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhCLOqJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 09:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230443AbhCLOqC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 09:46:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5C1E64FF5;
        Fri, 12 Mar 2021 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560362;
        bh=uKuPCJmVXKdSvoBoK1n5jZj6W+kPOug0nlBkfL0be5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=im/9hk4ENclg5+Xl4SZnjFMg+ZqnI/vNYwKOmDApOE2g9OPfuPHZ4+gdVwr3iv9Sp
         ljTJ3jAIBrJttHBCcHWkfxtGRpHoiDAF5u41/4Z3qKtEM/xCDq3ppv9/7pE0FBYFne
         Hlb0XbbwiMn03x6YaRJYo9XdEQgLVYvR7FmUlBic2OHRmOelOELw7lniNnW4V0o+fQ
         7eYE9RD26wO+JSZHBwkM6GQneAOBJfK/hAWl+USyGAs7Bi4KDq34uIEQhSlgxCANLu
         8y0DVCXmX9GlX7ZrKU6prgXaojTZtCzatqQ9c568Ng9qEyRrQQPCWqpne6ECzstLdl
         on3VTUlPz2kSw==
Received: by mail-ej1-f41.google.com with SMTP id c10so53744966ejx.9;
        Fri, 12 Mar 2021 06:46:01 -0800 (PST)
X-Gm-Message-State: AOAM533MOIT4/NgZCKxAMhEaURsju2SiR2aBbnwIq/wXYdEKaKym0LN1
        No+ViL7Xa5lPsthDussB5QEdSLgtMA8yXZ2aP/A=
X-Google-Smtp-Source: ABdhPJzArJLq7E8p/Wrjxvx39fPZ3Za3s8FDD0PZIoHrONi5/qkRVSnSI5kJXYDPXrHvffWbTcGkp98tbeAWXs+gyXg=
X-Received: by 2002:a17:906:a896:: with SMTP id ha22mr8774370ejb.503.1615560360439;
 Fri, 12 Mar 2021 06:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20210312141051.blqkm2v2yx6psild@linutronix.de>
In-Reply-To: <20210312141051.blqkm2v2yx6psild@linutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 12 Mar 2021 15:45:48 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeXQS2pZ-siZGP+E3y1Gus5_9-ByAetUD9Mk0UH+t0OYA@mail.gmail.com>
Message-ID: <CAJKOXPeXQS2pZ-siZGP+E3y1Gus5_9-ByAetUD9Mk0UH+t0OYA@mail.gmail.com>
Subject: Re: [PATCH] extcon: Provide *extcon_*_notifier_all() stubs for !CONFIG_EXTCON
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Timon Baetz <timon.baetz@protonmail.com>, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sebastian.reichel@collabora.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 12 Mar 2021 at 15:10, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> CHARGER_MAX8997 fails to compile without CONFIG_EXTCON. There are stubs
> already present for *extcon_*_notifier() but are missing for the _all()
> variant.
>
> Add *extcon_*_notifier_all() stubs for !CONFIG_EXTCON.
>
> Fixes: f384989e88d44 ("power: supply: max8997_charger: Set CHARGER current limit")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/extcon.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Thanks for the patch.

Fix was sent some time ago and is already in extcon tree:
https://lore.kernel.org/lkml/20210215100610.19911-2-cw00.choi@samsung.com/

Did you base your work on next?

Best regards,
Krzysztof
