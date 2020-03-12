Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70C1826B4
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 02:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbgCLBlt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 21:41:49 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38306 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387600AbgCLBlt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 21:41:49 -0400
Received: by mail-vs1-f66.google.com with SMTP id k26so2695441vso.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2020 18:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+2wQEy+NMnEIDcA6S02pCEqP6eFCuK4Z4/8szPajwc=;
        b=dEXMnPsUOVToOowHXjjb6pViv6j7NYO7alRyodmH88IKDJ9teW/utBZ2GV7iOxO+Zc
         BrLj3iTeeQ+MIS6lFh5vpKzqi+cXFhOJrEjLbZciKYQInENdAVdYCjV2c3wwPVIHA+yu
         Z3R+683VAjC18js16mQ/SEe7KXz99FCSaNuSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+2wQEy+NMnEIDcA6S02pCEqP6eFCuK4Z4/8szPajwc=;
        b=nVCz+uTX932csEEmAiHDW84gtDgmG+4z9hECOpoXqXf6k+KhhgpBIlq5HiAM1aBx7J
         C6+Wbcxa0CoF3RVYon6hhWtA5WXNsPEixGiGCe1r/AkEvYEKn4wW+ZjTApNyGtfECXKO
         CRSMZzjv4wUR04mjTDDRwc6DwXTKp/GT8FmapLIQpp8wZlzS6CziZ5l8lPo0sqtIBs/h
         TrgF+X4vxc7NzPDcuuD5+B2i6ZjjJtWaeRZiVNU+R99M9g8mOA7wMlX6pNp3Hxfkt3Q5
         NS4s2S/s7eNoEKngYRU8VsnlqTPEGnMSx7BVOrVArNwpbY+WzHDFELV2ymXq0/h+mMXS
         eZgw==
X-Gm-Message-State: ANhLgQ0IRByw0QctHB1oYT/dMItGoBSFytVHtvVKl8fwrb/sy7wF8Mju
        aqM6+sBXmyWaAOjWzY0oggXIHAUa1cXKYZQYfM2XNA==
X-Google-Smtp-Source: ADFU+vtwixbNza+rk01UttXlhW3Uxqa+sfYsUCDCqXXbvWG6vOSRtdS02syicarawHJ6J0EPqdPba2S1Oz1D1r/xpoo=
X-Received: by 2002:a67:3201:: with SMTP id y1mr4190035vsy.54.1583977308293;
 Wed, 11 Mar 2020 18:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1583918223-22506-4-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1583918223-22506-4-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 12 Mar 2020 09:41:37 +0800
Message-ID: <CANMq1KBdYPiWDHqSUwu86q3Kj=r0PWCoYcj28v5poNKNsB5U0w@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] mfd: Add support for the MediaTek MT6358 PMIC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Ran Bi <ran.bi@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 5:17 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> This adds support for the MediaTek MT6358 PMIC. This is a
> multifunction device with the following sub modules:
>
> - Regulator
> - RTC
> - Codec
> - Interrupt
>
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6358 MFD is a child device of the pwrap.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/mfd/Makefile                 |   2 +-
>  drivers/mfd/mt6358-irq.c             | 236 +++++++++++++++++++++++++++++
>  drivers/mfd/mt6397-core.c            |  55 ++++++-
>  include/linux/mfd/mt6358/core.h      | 158 ++++++++++++++++++++
>  include/linux/mfd/mt6358/registers.h | 282 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |   3 +
>  6 files changed, 731 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/mfd/mt6358-irq.c
>  create mode 100644 include/linux/mfd/mt6358/core.h
>  create mode 100644 include/linux/mfd/mt6358/registers.h
