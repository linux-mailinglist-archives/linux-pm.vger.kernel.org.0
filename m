Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309C589B57
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfHLKWk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 06:22:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51579 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfHLKWk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 06:22:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so11648276wma.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5m2IUZRROGymOefDRF7neqY5caAFmV8hI7w+ygmONvA=;
        b=VbvHp5gq3ZfIv129Gw/NtZ87lFa2bGMn4EuR83iecdeL2Csep9DpwQiL7+zz5JqjFK
         X8bIxV0RuZYkwYNxNlQfaKfvyhdfMRe+fsByZ+5/9Q4URPmHiuFfC+v/g4Na72n/MRMw
         r5gWKC5znHtVRRq1Mdy7xb3V/NfaocaWCQA7G19e1ZfLLTVKay0EAG6Eyp0ykdSV+4+H
         m8IfxciiLoaWNeDAQlVb35jDEAHgnVhlwiGdrJnKqaWswW3Ci+r549m18+lM5cv/jCuF
         1hFxRPVjIE+R+CsJoPvG28LQ6WUzne3g9QFS7qHahxLXO0k9kPM/IiwVA3zxzlc5GxvS
         W5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5m2IUZRROGymOefDRF7neqY5caAFmV8hI7w+ygmONvA=;
        b=bEGR0MvmQJpHLYXOaKWU/i+TYPdpF9T/nsXLms1w2bZdQZYhPWdmYtU3ZVQLJNsE0j
         TY6NtwEzIaIOVgy7wLoD2It4XJm7e9NbeivqzTvFc4a9CONRvm7a6AIIpVJbs9E6tBy5
         tRvxlgCMKPKypvubvgmUssVvaik8M+YD/fF/1zGhCfRdA7TI+STfQTpWqRuSUCNAZrpX
         fQn+DBbRnW8QXGc9awscorh2RuVddwTSvz/NI+Z/0jYpR8QdvkqydMSST58PxkasABHl
         kqTxmzawM44iOo43cLqTQc0sawxHoVXnJpZt+0+EuvH3Ns7DnPOvn2C37Yn6paXggrn1
         vJiA==
X-Gm-Message-State: APjAAAUhCeOMSy2JZUbQLa89YdTmDmZ7paOrocDY3fU9G2vMFWOnKiaF
        Y5oK8y4zbiJqrJa5oyQw0/qu5Q==
X-Google-Smtp-Source: APXvYqybIDxE+3tj5T831ZEq1FImfdGr3gRRq6UGg2lHX1HJoq0eScbIUxcvMhMextMyi7Sx8dZgKQ==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr19124477wmc.87.1565605358267;
        Mon, 12 Aug 2019 03:22:38 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id g26sm1478821wmh.32.2019.08.12.03.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:22:37 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:22:35 +0100
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
Subject: Re: [PATCH v3 07/10] mfd: mt6323: add mt6323 rtc+pwrc
Message-ID: <20190812102235.GJ26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-8-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729174154.4335-8-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 29 Jul 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> add entry for rtc and power-controller to mt6323
> 
> changes since v2: only splitting, second part of v2 part 4
> 
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/mfd/mt6397-core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
