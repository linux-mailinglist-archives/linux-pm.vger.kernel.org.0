Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362DE89CE0
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfHLL1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 07:27:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55069 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfHLL1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 07:27:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so11815884wme.4
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=onzhCYAhu69mMnXiA3vphG6i/bzFEmmStwTFQWrMk/M=;
        b=LO5JKiJdEnUY8rCcJ2Dk0Cx7bVBWYoQfej9KzgsHgDhAkyu5Y53OGvPMUIyUokibZk
         Zq3jSti6K5bU1CJ1cDsfIvltT3cpISE22lYn65JOgKwL0eAC4njzGhFQOH0fs648Ld1p
         qR8D+vvuePJgI5XIy2e6QmnkXtoZxFh1k1FIf3QoOj5cPvSzuFIraDR9m/Ej91wJ9lHG
         MzA0WxkE8gJ7UbJ970D1xLiwDnkOp5LkugO3JNEFjh8jNRwZeWjGmQwOpSRQ1GJwXJxh
         xkJIHvQ7nBoS5vusCij3D0275J2K8rV9GTxNsY8GZDHgGh68O6JeV3dAqlT+aK6w4z9s
         4xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=onzhCYAhu69mMnXiA3vphG6i/bzFEmmStwTFQWrMk/M=;
        b=G+xRHFkW8yzwo4+aZ4V4WEFWFVfLM3nXXJjScM77/Nu6KglUpnjSE65wGMypIMaK3e
         7EzliN/dweANfQjaMO328PVJ/DxfLsfdp990g0rY5sN+LxBi7iVE5EcD+AgR8sjsi6Rq
         gVU5gDPG5oiLAu/0cmJsVuIJjXtWB+DHfr/hyN2HqmpyL9s22fatvOxPliqCZgFRQDwW
         dND1gKz2clpqsplR4kXDzCbHAWVgYozqFQjz07xitP6tMgkqgi8Mv6NbuSXTE/K5rwLa
         nNgXrZqlCqMvcwpIQ3qEngbDEj7bn2z2GWOw8k331fDDFIr/4vChe4bjJJGhdqhvGHhB
         FHsg==
X-Gm-Message-State: APjAAAWQQgT7Xt9SOBadp9Bl/fLQhP2kYyq2XO9J/NrHyQY/UUOPt2pl
        mEqC42KMJ/z+5mY9UFZgiS21xQ==
X-Google-Smtp-Source: APXvYqxmaNB4W7rQ1NBaIa13dmH8j4PeVi2WkfZMssZuVRKBziRrA/ksz+FwV16y1femTzoXzfSu1Q==
X-Received: by 2002:a05:600c:54c:: with SMTP id k12mr8590960wmc.117.1565609260064;
        Mon, 12 Aug 2019 04:27:40 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id e11sm13412913wrc.4.2019.08.12.04.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 04:27:39 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:27:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Richard Fontana <rfontana@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rtc@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Josef Friedl <josef.friedl@speed.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: Re: [PATCH v3 06/10] mfd: mt6323: some improvements of
 mt6397-core
Message-ID: <20190812112731.GS26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-7-frank-w@public-files.de>
 <20190812102209.GI26727@dell>
 <trinity-0fa641df-f7bb-4627-a9ab-aac3cabc90ba-1565609115974@3c-app-gmx-bs80>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-0fa641df-f7bb-4627-a9ab-aac3cabc90ba-1565609115974@3c-app-gmx-bs80>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 12 Aug 2019, Frank Wunderlich wrote:

> > Gesendet: Montag, 12. August 2019 um 12:22 Uhr
> > Von: "Lee Jones" <lee.jones@linaro.org>
> 
> > > - * Copyright (c) 2014 MediaTek Inc.
> > > + * Copyright (c) 2014-2018 MediaTek Inc.
> >
> > This is out of date.  Please update it.
> 
> maybe i should drop change of this line completely (else it needs to be adjusted every year)

It only needs changing when the Copyright is changed.

If you want to update it to 2014-2019, that's fine.

Or leaving it untouched, is also fine.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
