Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0940EA5359
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfIBJtp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 05:49:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38349 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbfIBJtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 05:49:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so4500834wrx.5
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E32oxsdnFpfc9iole83hLZS+yX2KdMIZPUDAku90LVw=;
        b=DHcGpJtMYCczLv1+Nie2Tj6mpnjbjmwe3yYNzk9LxjNhZjDCCR3p39Th1I+SqVxIaz
         98Pd8TJLid5zcAoEpcC+GSd4UoNtyF6C86TaShbt57DVzK2mhRYAk24S3WnRQPt9cMvw
         OIl/NQLkhdhBVMXyopRS3RkzS0CS7j8Rglve83RyAivl8MLiri8CYBBwHuIHdoUwEv9R
         GyQPH5u7fCF38I0HqOkIRjcmQbJ+Jut+R88Y5eTqN0Hrfk5jrA31nY/meR6fOX5xbre/
         bfOsadVAiHf9ItjJnm1d0ARtUkZvdmNKScHrdEvfb70KZZ+I3MaywYc7+2ltoBX7lRVm
         AEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E32oxsdnFpfc9iole83hLZS+yX2KdMIZPUDAku90LVw=;
        b=KNz7bXrAWnOk4GI+zaZ/XEV8OSPasZSiCe5rRt7qCTcLo64PFoQaWBEDO0wpPwLIVu
         VXY+C4VDGG4QaoiJ2aw3H8a2SfZaI4hU9pn5PEC6pBgpEjf3Re/oxmWMlMGJbvOj+YtO
         MX6rmLzCOukegWffJHPW6hCwkHOIOv/zeiMdozjtA/8btT4QnnD/8V3QBnoNE6mVce/n
         bcDuxMIzcVHE7aCO1cf049F9F3H0snOZyq1uXnlInv0bAlyohEFWGRbSIgPv1zlRNNY1
         E+An5Dp6QZD7hVNPC3KK7V2CL128k/iYXe12y93580h9HY1tFi3i4+4FNlDas/25zIJK
         YeMg==
X-Gm-Message-State: APjAAAV813muBU91pGUx5powunorlYfGfCwjPNDZm6YFyz4p7Vo/Bl9E
        VNTe+74W5Lbcn0Dwr9YtLYJ4DQ==
X-Google-Smtp-Source: APXvYqx0dDZhgt2N2frM+clSUwC9JsS7KqvVvVuZzoRhLXZHbrdEBi472foVvr2vFZvp5E2gox599w==
X-Received: by 2002:adf:c508:: with SMTP id q8mr34660218wrf.287.1567417783054;
        Mon, 02 Sep 2019 02:49:43 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id s26sm1861063wrs.63.2019.09.02.02.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:49:42 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:49:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v6 08/13] mfd: mt6323: some improvements of mt6397-core
Message-ID: <20190902094941.GU32232@dell>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-9-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818135611.7776-9-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 18 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> simplyfications (resource definitions my DEFINE_RES_* macros)
> 
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> changes since v5: none
> changes since v4: do not touch year of copyright
> changes since v3: moved part 6 forward to let compatible and driver be together
> changes since v2: splitted v2 part 4 into 6+7
> ---
>  drivers/mfd/mt6397-core.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
