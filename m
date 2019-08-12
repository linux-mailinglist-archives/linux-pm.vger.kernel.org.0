Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25768A206
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfHLPLf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 11:11:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40904 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfHLPLe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 11:11:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so12094392wmj.5
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GUVrtoEfscx3IZ80Na3X/rWaOd9dRKNDQf1aNP1gKJQ=;
        b=SF7YYcitpnmLEfAIg1jOi9hmKo1i+Rcoivb2acbFvzJTcAy0/wOVgXhFfL/86Xv3Sx
         dC+O3vUZWV4HQcQKJEV8MAtHUgBFzbWrDZv2UXKJTpgvytBorP3RknUn6lZsPEozuxBP
         F3D72dCDxFyNY4KUClx+epNbiA4zhlB1+88AU39AEP7kRZc0KdP+bEFWPPAYe46iiWx6
         U+4S1sir5JuK91IbOrf2IoIRcfBuFdJrx6uLRoWwQWlxZ78ecsCRBXv+gwX/Cz+6kzR+
         xMza4uhVz+49uL8JYrZ9KKPp9w5Ty8IeyU7v+KTRjDUxmiKxRWfhwdpeq0662ruHnQQL
         ABhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GUVrtoEfscx3IZ80Na3X/rWaOd9dRKNDQf1aNP1gKJQ=;
        b=Ls+Fd08s3ei10xFMr9Fitg5vgPyYG1wV9pOYOD+5x1TNaMdIalxMlimZPY53nBuY3s
         iwhsAxOmHK+VYSHXkXHhzr4fbzoB/wkY8iVByFvfFjQUsL4sJiYGbrzmsOt12cCfvv8M
         pEEOTUgjAU15YBybREAwuw6UcwokGnrixAfWUx2WsSuizMJwe2eON/0lYY8nNWEhHT1n
         iEa3UVZUzOOokCAVeZWO960FWtYWnieZuyM12nL5xrrISl8PMipXAxav5BuMDWNd1ZZZ
         VpKffmHKtl271iuGrUgCychXCloi0Ae+Gw9t977QlcOBbyyja5UHrswUlsSHb/OcSiIH
         Ls2w==
X-Gm-Message-State: APjAAAXSrZDmI/o0n6hgv8TcMbbhHD+pda4tQLieNIoWY9V0apuhC8MY
        cGJpHlQov0Rp9Xkb5SjMjFdLMw==
X-Google-Smtp-Source: APXvYqzzq2N35RxoX6M2lYFHPFEysjYpmtcFojnVg276i12s+isDXsA6w+Dfor/LAfFbQnLudsik5w==
X-Received: by 2002:a1c:1b97:: with SMTP id b145mr26940656wmb.158.1565622691528;
        Mon, 12 Aug 2019 08:11:31 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id k1sm12674396wru.49.2019.08.12.08.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 08:11:30 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:11:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: [PATCH v5 03/10] rtc: mt6397: move some common definitions into
 rtc.h
Message-ID: <20190812151128.GV26727@dell>
References: <20190812121511.4169-1-frank-w@public-files.de>
 <20190812121511.4169-4-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812121511.4169-4-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 12 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> move code to separate header-file to reuse definitions later
> in poweroff-driver (drivers/power/reset/mt6323-poweroff.c)
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v4: none
> changes since v3: none
> changes since v2: add missing commit-message
> ---
>  drivers/rtc/rtc-mt6397.c       | 55 +-------------------------
>  include/linux/mfd/mt6397/rtc.h | 71 ++++++++++++++++++++++++++++++++++

include/linux/rtc/mt6397.h?

>  2 files changed, 72 insertions(+), 54 deletions(-)
>  create mode 100644 include/linux/mfd/mt6397/rtc.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
