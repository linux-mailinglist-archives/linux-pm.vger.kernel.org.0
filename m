Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC383F2D4C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhHTNms (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbhHTNmr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 09:42:47 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DADC061756
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 06:42:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s3so17350405ljp.11
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DhOH14/6lzie5JE/kLqdu0LS3u763/qjtgmVKcWngA=;
        b=zabsO4jEjrqC54MNbZPJHDq4ijAV1KPbEh6BP8i2kEs0sPVk075P9lSvJpRxoXuY5D
         mZ0vxdr/mAdAKNoFpqACJXcxddk/v/L6svqpliziyehv7hgF4APRnmcyeY2I1Dlx01vA
         +ZEX6oGgoGHrTEWC0wnCGzH/lJCtBPT3t0nJNKrleREeWl4j5XLoE/SXmQrXvg0fSq0H
         VB5LPOwP6K4k1bR1c2ksBBYauoE9+mh3xnhdKmjTVIVeGLJBYf4iTzJXcDarEUdA7Q7I
         nc+TZletAllWT/9raEvaeKiw81q+vifHItZHVSnC/zQ6hYaAbPA6wX03Us6rgVEtnJjk
         WfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DhOH14/6lzie5JE/kLqdu0LS3u763/qjtgmVKcWngA=;
        b=PRolD/BHFFlcwuK7bWYmNB3YETEjbG2PCNGB7ywcFZJQkEF4iUvzky/RRu8Ppnb25a
         jrdbS4bMl+0jfU9H1xoQoPcW6I90dXbVTpV/leq/zQ77Zb+JH/SiIKBIIOb4moAzWgPw
         hhZVdIMpShM1kcaKNC68MhSTZqqa2EKh9evxsu4EL14zmQhfmoTnwdQFVtuKsi6jp9cZ
         bV9Ox/ssjUA5fDab/JQMCUCdzOrC0o8iTsxd2OErODFVTnBWhjZ+c4EOm6Kii/fuvY++
         JP9nV6bvuoOYluYSuMzFU4j29jHC5RUHU+MYM8xQCkckz6uXfZsd5XBu3r3ziwwqwwru
         9R6w==
X-Gm-Message-State: AOAM533LU1oXYGpgbicgsZ80T2NDvWRdRENa4XYoqI6n7CJhka+VJ+AV
        mOOkVVKLtOddYvtu5NRe0kHE1SNaBfR3yeI7Yhdupw==
X-Google-Smtp-Source: ABdhPJxy7I2ZoIN04yH4cApSk/hCQ1gO2a2bE2macF6+9WF0KIXIBaWfG7BeNnu0GwGNz/NVXmNNvg5vCoUYKMWT4D8=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr16160137lja.200.1629466928042;
 Fri, 20 Aug 2021 06:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210819235111.25357-1-digetx@gmail.com>
In-Reply-To: <20210819235111.25357-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Aug 2021 15:41:56 +0200
Message-ID: <CACRpkda=hcw5dN8TfV01egb4_fzSi3kNOCz1UguYcKyQKDW9mA@mail.gmail.com>
Subject: Re: [PATCH v1] power: supply: core: Fix parsing of battery chemistry/technology
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 20, 2021 at 1:51 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> The power_supply_get_battery_info() fails if device-chemistry property
> is missing in a device-tree because error variable is propagated to the
> final return of the function, fix it.
>
> Fixes: 4eef766b7d4d ("power: supply: core: Parse battery chemistry/technology")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Oops,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
