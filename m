Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF18AA5327
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfIBJnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 05:43:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39237 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbfIBJnS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 05:43:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id n2so12470512wmk.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4d0l7N35iWoMyBbjAl4hMooElMfpWLjU+xP3/QM48gE=;
        b=mhtkERu8jUQkzHnNqRbpGC8pMP8PM9wc9YYdW3YJzfxC+5CivPw0eN4Mx0FCBqkZ1k
         MMpoWhfUGlcZ11BMUqW6LIGUqZ5vgXx8aarqN0fXE9js6Z524xGTXLKm6blIp1daoMKx
         0J5VxGMjhAiQxIeU+zuC6dUZUtFUveEcznHTq14si0umE8rRYGiDKfwK+5RFTa/d29GI
         /c/EdZUuoNeHEdVdE8Wk+3yh73Qi+0Ro5yqJlSh32RqsCQGOvjbi8PUiqBo7yQt4iXzn
         6FzeKLgh7cF2NZ50ISsMteEICGPzKmU/mdoKRiwjs/fdB+p7i+EJT9EKTZ0LTnRwsHd+
         Es7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4d0l7N35iWoMyBbjAl4hMooElMfpWLjU+xP3/QM48gE=;
        b=cfP54TxcqkQVSljNGdpAqbuVtw/63mDH8RtlFiZH5nNMxtp66muOsIAa2llJUHkMEC
         QIpZRd2xYECgPg1U+gO/f/hlbJQR610G1p2gTxM4Wfv03EiwNBcT+zYqdInn8ANdy++M
         ZDlSou3RC/7SaY6AMSp7QWy6dAHBVLThwFdqMmMGPim9ScRQxjut+8krTxDUB/2XZcNL
         su/JTTPF1Qp2igQ0pdsCkzR+J3UNRrT4qVJm+TGxn8m5GitdFbbGh+XVHERLeLzBfa9s
         EkJzHfjtV1rkxb5oDWMMcM4BwV8/2y/M1yWDzvVHW+9vgZ2ngzCtzY12CltuZv/5M8Vv
         gHIA==
X-Gm-Message-State: APjAAAXAjY4KHLwvb+JXrPLlgbCO3UzyOv7pvmJeREDdcOx+6tyzqrV8
        jd8p2f+azpIC6AHDK1+eMRYrCA==
X-Google-Smtp-Source: APXvYqzm2jMdu+QtRADNIC1TnhWQKqVD1sQ/ZS7+PqSLNP6Rmxvz386etPsBfvjnR60QuMOGSfWyEg==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr33247098wml.35.1567417396069;
        Mon, 02 Sep 2019 02:43:16 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id e4sm11403837wro.21.2019.09.02.02.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:43:15 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:43:13 +0100
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
Subject: Re: [PATCH v6 01/13] dt-bindings: mfd: mediatek: mt6397: change to
 relative paths
Message-ID: <20190902094313.GP32232@dell>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-2-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818135611.7776-2-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 18 Aug 2019, Frank Wunderlich wrote:

> paths in dt-bindings should be relative as suggested by Lee Johnes
> 
> Suggested-By: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: splitted from dt-bindings: add powercontroller
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
