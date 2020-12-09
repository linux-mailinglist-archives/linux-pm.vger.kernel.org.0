Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898122D3F6E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 11:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgLIKBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 05:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgLIKBc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 05:01:32 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3F3C0613D6
        for <linux-pm@vger.kernel.org>; Wed,  9 Dec 2020 02:00:51 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id q8so1524603ljc.12
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jt+5a6oYg4MnhhkTdaCwz0B6cI+BkiaAfkU1vZvtSs=;
        b=pbaAjZY6oqqN3zF6UVsJUNNAQmkKyA1In/7axbp1U/213/TFi0ybPgLenmKvlRKluj
         p7Fp4CICHTs3Jod08nBkdhV9bVbIvZpjAVDEWsAiWn+M41DWaiX04oyA46tInyZ5hjfO
         vRhbHc2/YENwYRALTIPVPLyhHsaMkQjMuAyzIxlrZmmzvV+4Pg6sIF0g0Gi2IbSaDe0j
         KnaEN0npIwjV0l5LP19J2wIU3TGhm3Pc4jz2LIM1EqWlRUphK6xMaOjZIpo7obiuzhsf
         rCteEQUMJIq0tEc4/mKMuX1N61EBOn0BkFvHS46hmJojP0ROPlmzG12sH2XcjA6NE6no
         6riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jt+5a6oYg4MnhhkTdaCwz0B6cI+BkiaAfkU1vZvtSs=;
        b=XJKglB1/9djxrLN6CQP1Dbg3YjQgh5oPMdU5wZ9OvwBvGPWqGp2J2o1DEksXyojc7f
         VVlqc7bGeDKC39UdKMBsVaqB+wIHJIQcamCFNXuK6gvumVPjg4A/v5r7OiWZSRs7DM5l
         WdU6mBmpgDPRwYSTPsuJjVSGLfGjB1w7p8MeYWHgzGBbzC6Ipel0OJ0N+wIFcXKlTtyb
         4hGhOtqyciMhaFkmChmWa8pKyZe+INhIjBZHuEL259Jrkjwqinr2nNZov3fkkWqy6OnH
         evh+Qw0Te2YrzvMIy5dsAgW1Iv5e6srer3AP3Nozd1+175XV986QlfYmAS2mXDxy3lAT
         5rRQ==
X-Gm-Message-State: AOAM533izLl9XjZWT0WYjVwZ1M6Gu5FBzfEBQX8iYypRLjhTiLIAw1XA
        osXPIVksSQu4Jj/yHj7HjytAO+u1SCCwD6erkdFryfLgNYlEiQ==
X-Google-Smtp-Source: ABdhPJzpScFe7jIXruafDpiNN+uih56UR1feIixVQFBcYAdxyavs7O2gudReVeE/R0xHcK6NnCdqq5a2pFP+2WOmU/E=
X-Received: by 2002:a2e:910f:: with SMTP id m15mr719663ljg.467.1607508050158;
 Wed, 09 Dec 2020 02:00:50 -0800 (PST)
MIME-Version: 1.0
References: <X8pNAJq2LdPJ29w9@mwanda>
In-Reply-To: <X8pNAJq2LdPJ29w9@mwanda>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Dec 2020 11:00:39 +0100
Message-ID: <CACRpkdb==Xr5Ywm=BxESuwtpM45WLhDOQMBeW8qSa=PyBJR2pQ@mail.gmail.com>
Subject: Re: [bug report] power: supply: generic-adc-battery: Use GPIO descriptors
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 4, 2020 at 3:53 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The patch b0327ffb133f: "power: supply: generic-adc-battery: Use GPIO
> descriptors" from Oct 30, 2020, leads to the following static checker
> warning:
>
>         drivers/power/supply/generic-adc-battery.c:97 gab_charge_finished()
>         warn: signedness bug returning '(-4095)'
>
> drivers/power/supply/generic-adc-battery.c
>     93  static bool gab_charge_finished(struct gab *adc_bat)
>     94  {
>     95          if (!adc_bat->charge_finished)
>     96                  return false;
>     97          return gpiod_get_value(adc_bat->charge_finished);
>
> The gpiod_get_value() can return negative error codes so it's not
> necessarily clear if that should translate to a true as it does now or
> to a false...

It *can* do that but in 9999 cases out of 10000 it does not. Mostly
because it just boils down to readin a register and masking a bit
which does not fail. This only happens in the rare circumstance that
the GPIO is on some slow bus that lost contact with the bridged
device (such as an I2C or SPI chip).

I agree it is not a perfect (in the mathematical sense) API but
in most cases the odd case of this call returning negative is
ignored and there are thousands of in-kernel users.

If this is a real problem I would rather turn the call into a bool
and ignore errors on the few that care to test for them than trying
to augment all sites using this call to handle negative
return codes.

Yours,
Linus Walleij
