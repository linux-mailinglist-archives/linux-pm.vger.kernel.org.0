Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A617496F57
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jan 2022 02:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiAWBBP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jan 2022 20:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiAWBBO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jan 2022 20:01:14 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8254C06173B
        for <linux-pm@vger.kernel.org>; Sat, 22 Jan 2022 17:01:14 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p5so39292487ybd.13
        for <linux-pm@vger.kernel.org>; Sat, 22 Jan 2022 17:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvjIHzoYjX2wrs+EpzMBjfsTjarifS+awxMyAGX77+c=;
        b=icZbSbAmMydOl2Lfh9/+QWimtCNVaKajeqB22HdXuG20nsP2qvlOHr0ZXqR12bQaRa
         6THaCHTNdTiILsj8W2oMq/Gajn+J+3je19fwojwy376TurxKHscJ66fabnlY7GQPFwu+
         IZdvBgTYHcw/UtGA8KuXyQis0rqVaXd3WWc+o5mkISfA3Gq+XYX98RNhE3H0XZD86FyT
         YhJcecRRdsqF4lc0d+33JV+kjrK0yenicrpHodrZ1DSmZ3JKR+cv5O/DPJHwx/Tp8vJT
         eYSYRuQGocZtmIrJ0kP9s3y+V+atWqx//BqvWTVrK44h0mX1rZtOo+qetBXVR5Kr8mQh
         Ul7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvjIHzoYjX2wrs+EpzMBjfsTjarifS+awxMyAGX77+c=;
        b=ZPqQy71+qmxT6LnanMk2GvlYiAxoSSiK30G4ttkV3lJMwUFMNIIaidqjlYpCBun9kx
         llnXOKhfJ9nBO9klcG87NB6RKOwxy5lLTD/ssHB+G8jzEokXHKiARoOlfhptUkTn9m1+
         13wIfVMsKG4NoeJantemZhBY2wt5l1vwrT/rUnz7wICHEUR2ENJAM7fGM9WF6GgWRxAX
         HWDxdWNVuJmVmuSf7YSZAyPrF6CFZHxD+45gYYTtGS5c401i0yWUtZ6rFIra6XoS+P11
         wuFJrtblUl5NHatDRU9QTmNz3bH9nIhDI7xzD4zmQ3FpG3fF7UNRsxhh3TD+4TtQmuJp
         X5cA==
X-Gm-Message-State: AOAM530CqHrmql3On9C2HGkpVSf1HpCTZPIAj5hZ8SWB9ZefahFy3mTk
        ALgYwIYq1PNDSwTK5uY4BjQRBfQ+9hSUziQnA+ZkI2lqJwA=
X-Google-Smtp-Source: ABdhPJzcFq5FLHHPy0k5FGDVTqtTPkpyeCAFkkn4StwSpMeNSwCm9BWFgXu2HHWL0bNrGeGZBGZz0ZkoFoFwPwCYmjA=
X-Received: by 2002:a25:8e89:: with SMTP id q9mr16586053ybl.520.1642899673159;
 Sat, 22 Jan 2022 17:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20220120104654.3467-1-linmq006@gmail.com>
In-Reply-To: <20220120104654.3467-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 23 Jan 2022 02:01:01 +0100
Message-ID: <CACRpkdbKyg3wAqvbCH0nm4uOByr2P14=iabOcXTAvz85qgdYiw@mail.gmail.com>
Subject: Re: [PATCH] power: gemini-poweroff: Fix IRQ check in gemini_poweroff_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 20, 2022 at 11:47 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: f7a388d6cd1c ("power: reset: Add a driver for the Gemini poweroff")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
