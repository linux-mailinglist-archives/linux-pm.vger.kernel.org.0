Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5272101E
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 23:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfEPVjM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 17:39:12 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33302 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfEPVjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 17:39:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id y6so3330422vsb.0
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++a8Pfd1pmd0gtgzMiYzStSZkT1QAJ0q9LoMMmyznno=;
        b=lxC0mVIjA0SLzDUNfcqRwxoiM0ULrrdBItgvpMV0PYh4yCZN/egZlHDYXZIOCb0MWy
         MEptyIyNH17TyhG2+6tHcF8ypoGmsF8PJqLzkBm6+Qlwyk2Q/8Ro+UcRneAkuDiSuMtV
         KnOVeynDlXHVxD7AA7uJiQXAlzHOQX14yDO8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++a8Pfd1pmd0gtgzMiYzStSZkT1QAJ0q9LoMMmyznno=;
        b=Dy8lUBCsjHL4CZiLet+neQfbCoPvLCL4fdl9ig3eYJBJghQ7/CwEjla4vWQH3UlSx6
         05hlYpw+28hJ1Rexs8wIkbsRrwCAPBrfv1Q1mVp6Cde6wFbSMt3yubi//TvIoDbxbgUW
         7FsumRDsfvMA5D5HN8WljuWH7c4YvtUuqG0FED3toAsBXsj+8flFwoqP76d/8I/Z8oFe
         fR9jx8nTdY0r5pqi4CUk/wwTOIk5e9kvTSqtl0xEA8SIBvT5pchXwSrNekGdqHN3bGF9
         pInKoiU847BBVC6pIK9Ci16pDV/rdEs7mU1M5FnMTUQOlg+TPUsL8eNCUb08ErygMrLh
         LhyQ==
X-Gm-Message-State: APjAAAVM+aLGxxSGhZ/7eHzSv4CO+FRxjD/RFxHbgbYkRrI5haf1YKJN
        A87RPSyKdtB8ZOj0V6DQk04REZUfjIA=
X-Google-Smtp-Source: APXvYqxVG1GHyPmOkEAMjter+do9CFDHyQ0gbkou0rfkfYHQvUcnCKBV+sWzUjxjIrQjzUPotxHskw==
X-Received: by 2002:a67:f6d0:: with SMTP id v16mr26222576vso.142.1558042750019;
        Thu, 16 May 2019 14:39:10 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id l125sm1653036vsd.31.2019.05.16.14.39.07
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:39:08 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id e2so3268474vsc.13
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 14:39:07 -0700 (PDT)
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr18643024vsk.149.1558042747509;
 Thu, 16 May 2019 14:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <5cdae78b.1c69fb81.a32a9.870f@mx.google.com>
In-Reply-To: <5cdae78b.1c69fb81.a32a9.870f@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 May 2019 14:38:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WDjUBvwoAaWNOmXPaLpZCccpAgRWDzRSnvsQ62TFwVmQ@mail.gmail.com>
Message-ID: <CAD=FV=WDjUBvwoAaWNOmXPaLpZCccpAgRWDzRSnvsQ62TFwVmQ@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190514 on rk3288-veyron-jaq
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        mgalka@collabora.com, Mark Brown <broonie@kernel.org>,
        matthew.hart@linaro.org, Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

From: kernelci.org bot <bot@kernelci.org>
Date: Tue, May 14, 2019 at 9:06 AM
To: <tomeu.vizoso@collabora.com>, <guillaume.tucker@collabora.com>,
<mgalka@collabora.com>, <broonie@kernel.org>,
<matthew.hart@linaro.org>, <khilman@baylibre.com>,
<enric.balletbo@collabora.com>, Elaine Zhang, Eduardo Valentin, Daniel
Lezcano
Cc: Heiko Stuebner, <linux-pm@vger.kernel.org>,
<linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
Zhang Rui, <linux-arm-kernel@lists.infradead.org>

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> next/master boot bisection: next-20190514 on rk3288-veyron-jaq
>
> Summary:
>   Start:      0a13f187b16a Add linux-next specific files for 20190514
>   Details:    https://kernelci.org/boot/id/5cda7f2259b514876d7a3628
>   Plain log:  https://storage.kernelci.org//next/master/next-20190514/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20190514/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
>   Result:     691d4947face thermal: rockchip: fix up the tsadc pinctrl setting error
>
> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       next
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     rk3288-veyron-jaq
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y
>   Test suite: boot
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit 691d4947faceb8bd841900049e07c81c95ca4b0d
> Author: Elaine Zhang <zhangqing@rock-chips.com>
> Date:   Tue Apr 30 18:09:44 2019 +0800
>
>     thermal: rockchip: fix up the tsadc pinctrl setting error
>
>     Explicitly use the pinctrl to set/unset the right mode
>     instead of relying on the pinctrl init mode.
>     And it requires setting the tshut polarity before select pinctrl.
>
>     When the temperature sensor mode is set to 0, it will automatically
>     reset the board via the Clock-Reset-Unit (CRU) if the over temperature
>     threshold is reached. However, when the pinctrl initializes, it does a
>     transition to "otp_out" which may lead the SoC restart all the time.
>
>     "otp_out" IO may be connected to the RESET circuit on the hardware.
>     If the IO is in the wrong state, it will trigger RESET.
>     (similar to the effect of pressing the RESET button)
>     which will cause the soc to restart all the time.
>
>     Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>     Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>     Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

I can confirm that the above commit breaks my jerry, though I haven't
dug into the details.  :(  Is anyone fixing?  For now I'm just booting
with the revert.


-Doug
