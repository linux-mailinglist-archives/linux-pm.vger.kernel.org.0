Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2E448D95B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jan 2022 14:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiAMN7A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jan 2022 08:59:00 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:36460 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiAMN7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jan 2022 08:59:00 -0500
Received: by mail-ua1-f50.google.com with SMTP id r15so11236578uao.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Jan 2022 05:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SHuQ+GQJi9smz/NV7qEkw/eADyttwCKXUpY/Kmca6L0=;
        b=WfpU2KTEQvVywyc1YwTqOT/eCB5gnrvAi86F8MSWqAOg5CQzbKHLKHbw983YunzFsA
         jLF2Jki7UF4ScENq5Kyz6MMZMi1alJ3xzY1iDdXfBt56TKrA+gLYjyCxsMZZCRAudmCG
         JpJ/kflfrJe8w54MG8H4gTjgoO//xsQBtPVWSrni1LpOdvCxhc61ZonSFIjuncsQkQ3G
         T0yi6lDgzelThMq0gmFtYmbCTuAPHxL6d+2ugd2YLovjq/gZULnOBC7uk8DkCayjQ2e1
         78IaOShBgdYYNa7C/FPqefQX/BrvI4Xa795ZPy0VPcd4Glyrzpculd4Qo1ReYrfKoc4d
         w8Kg==
X-Gm-Message-State: AOAM532UyvOP8mhejlMWJr986hYSlImDKx0Fq6KZWuZim/QqY+BXBDhf
        c1SPu87I+x+WLrFUB7azr9RjswlE+SwDIQ==
X-Google-Smtp-Source: ABdhPJxKartykEMQRrzcyUYhgaTHQrkUf4OFUINwuyaRZSnBSdunZ9KDaz9oSRWG2oVC0lYMeJnZUg==
X-Received: by 2002:ab0:2752:: with SMTP id c18mr2212404uap.95.1642082339770;
        Thu, 13 Jan 2022 05:58:59 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id y26sm1609085vsk.31.2022.01.13.05.58.59
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 05:58:59 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id g5so3908662vkg.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jan 2022 05:58:59 -0800 (PST)
X-Received: by 2002:a1f:a010:: with SMTP id j16mr2016401vke.29.1642082339284;
 Thu, 13 Jan 2022 05:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20220112084727.131053-1-boger@wirenboard.com>
In-Reply-To: <20220112084727.131053-1-boger@wirenboard.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 13 Jan 2022 21:58:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v64YXfiKjWbXgHghyh_2WnQV8ghEYwQH1skxHV1Pc-d-YA@mail.gmail.com>
Message-ID: <CAGb2v64YXfiKjWbXgHghyh_2WnQV8ghEYwQH1skxHV1Pc-d-YA@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: axp20x_battery: properly report current
 when discharging
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Quentin Schulz <foss@0leil.net>,
        Sebastian Reichel <sre@kernel.org>,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 12, 2022 at 4:47 PM Evgeny Boger <boger@wirenboard.com> wrote:
>
> As stated in [1], negative current values are used for discharging
> batteries.
>
> AXP PMICs internally have two different ADC channels for shunt current
> measurement: one used during charging and one during discharging.
> The values reported by these ADCs are unsigned.
> While the driver properly selects ADC channel to get the data from,
> it doesn't apply negative sign when reporting discharging current.
>
> [1] Documentation/ABI/testing/sysfs-class-power
>
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
