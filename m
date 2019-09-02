Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA63EA5360
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 11:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfIBJuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 05:50:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40253 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfIBJuE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 05:50:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so13317231wrd.7
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z/iNfh9lERKCL4WNCXIHABmMvr8yzyMTtcia6mN52EQ=;
        b=F3ev0/94Lp7tRgH5QkOB7GchzXuzea7zDMr/QPIscw1kwGvE47q6u3+dDwu3Iu12WC
         gbNy68B9TnB61ZUYtjULImN4UGYq4IsfRXjBdyRPJDKodTe+woG/43DGOEka+gy4L8Ks
         y+zQf9aCd9hE9KlB2Vhl70ew//mw+HIjbwA5bjVMM4hV7ZAAE3u8eKUA/DpLqdDmsnWy
         LVs1P90/kjUlAnPerYhSn30AYhNIrcJCd0W0+X7eMOV/bANxa67nRPY7BHFSFjUVVMt2
         VihWvo4ntzvGsFSkTSkWXyxvgRnWflTJTq5QU80FbvrbeeWj1rJBHCB2PgMaYT0oGZa/
         Lv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z/iNfh9lERKCL4WNCXIHABmMvr8yzyMTtcia6mN52EQ=;
        b=tP+LZBAVVDg1bAMqgRBWcVG5o0lSYpSctUneo/Vgfve7imLlMiBpgsnJ14o8mcJoua
         Dy1sYbNjVZC4RAT9EYWWoH+aR7yauzZfg9+Sowy74Vds6la44tv+em7fEasXI46voLAX
         AliNJrKYmQRs4tgEBZ2aJVHkA9PyLE4wY9jnczjuEWcaJGouD+wWOS1zP7yzrx0WZHVi
         nvfLxsDkYaVJ4cZMQyNA6/Ve8uJup2/tWh8nCULUUDVtaUEa+kl2Bm4GP94AHUJ3hvmx
         Zc/XecPDY9+MMHsEriceaaJjlThyA0ipo/u86gofz2O9WOuq3quKgxbL14gJbw+Z+7JL
         J6gg==
X-Gm-Message-State: APjAAAXnWsBnsxNTQz0KSl24DzCMsBNj4b3yY+NI+9+kia7wQFn2flck
        6eG6jzKZOaBlGS88kOOtEiOrPg==
X-Google-Smtp-Source: APXvYqzKfwhjRcpSww0X5JvjADuGYoZnJVDaisET7pRsBYvpYFMr7Bmpd+NM8IppVRkyGVrVHrE3rQ==
X-Received: by 2002:a5d:4f05:: with SMTP id c5mr31271928wru.349.1567417803097;
        Mon, 02 Sep 2019 02:50:03 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id y3sm28567157wmg.2.2019.09.02.02.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:50:02 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:50:01 +0100
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
Subject: Re: [PATCH v6 10/13] mfd: mt6323: add mt6323 rtc+pwrc
Message-ID: <20190902095001.GV32232@dell>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-11-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818135611.7776-11-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 18 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> add entry for rtc and power-controller to mt6323
> 
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> changes since v5: none
> changes since v4: none
> changes since v3: none
> changes since v2: only splitting, second part of v2 part 4
> ---
>  drivers/mfd/mt6397-core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
