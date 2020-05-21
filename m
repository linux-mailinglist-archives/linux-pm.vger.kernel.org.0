Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866101DC7F0
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgEUHrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 03:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgEUHrX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 03:47:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE46C08C5C0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 00:47:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r3so3779368wrn.11
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=scVYFjBGBAzKQ/hMy8PhK3pElGqsrP2y83QVfuiAxH4=;
        b=vqpwnjz86M45u3Gnp4IxKufT5KEo7fxf+vl36qzM3nHslyhDCEJIEgQAXKyrOkPOzr
         sxkJdaadCkojgsCryJFV/NsqAGAwrjmBPRNvm9KBnA7Rh2O1j/zY5DwTpPhcFG/rXfkM
         6S23fM0SLLJ7TiHNbL0XWiLK7+upJ5+t62Ye2cO2Wkc0mHW9D9DAJ/WC/rz68M4FmrLX
         k27QqVbp3qP4CmlFWSn5xCNh4GWwvUfMdUElIrpD+rHd5Pa/4AMCOHm/zmAtjuENvG0C
         TUv6XE2S4gfjQ9slqcNHl1ztwdytcQWprTsMRJNpfjLkzetO4LLbY5K/5RpxkGAy8lfS
         nK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=scVYFjBGBAzKQ/hMy8PhK3pElGqsrP2y83QVfuiAxH4=;
        b=PVHKO+S8Aw81osrXIAUAY5B4VOGakrTqPgXk2T4qSt/qz5nnW6C2FZrm5m0Itk2WMP
         4sbl/gbb78rNLr7Cs8yHQeI4wCKxb5VhOCBNbOCMSd3CiEEF1ossoNPTYpRp6XOGCHKc
         UA5bcdvHI9C5KQmiAV5fr8Vx0Z72wge+unc8JmeZosge7+qqLSIkppJqWx08TPlHieuP
         b1dqjlmfAI1aUUaoUXaJ8Q27ubMEqi3kTqtQfgvUgho3YgOufToOnabMoOL7TFtAxkPw
         v6yYSH1kICaEtHeu9pBV2SDupg5XI1Jm7258sG9sabramnUelIJuDacLCUpuKpZwVrp5
         PqGg==
X-Gm-Message-State: AOAM5316/UfIAVYiLJXZijGYEonekfLz7a0jdQYs+I0gZS1JXEzlVQWb
        GWgk5HHcu5kJ1Aze5ekvW2YQWw==
X-Google-Smtp-Source: ABdhPJxcZ6ZWteBLNFuVjrXs9CMtGph22AZeEwlyAM3AdFye7vHS83vjlNDUgEYM0NT1woW4CXf4Zg==
X-Received: by 2002:adf:9010:: with SMTP id h16mr7329094wrh.412.1590047241123;
        Thu, 21 May 2020 00:47:21 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id h20sm5542798wma.6.2020.05.21.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:47:20 -0700 (PDT)
Date:   Thu, 21 May 2020 08:47:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        drinkcat@chromium.org, Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v13 5/6] rtc: mt6397: Add support for the MediaTek MT6358
 RTC
Message-ID: <20200521074718.GN271301@dell>
References: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1587438012-24832-6-git-send-email-hsin-hsiung.wang@mediatek.com>
 <27c107b3-6ea8-e6f9-697c-7c3c4479008c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27c107b3-6ea8-e6f9-697c-7c3c4479008c@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 16 May 2020, Matthias Brugger wrote:

> Hi Lee,
> 
> On 21/04/2020 05:00, Hsin-Hsiung Wang wrote:
> > From: Ran Bi <ran.bi@mediatek.com>
> > 
> > This add support for the MediaTek MT6358 RTC. Driver using
> > compatible data to store different RTC_WRTGR address offset.
> > This replace RTC_WRTGR to RTC_WRTGR_MT6323 in mt6323-poweroff
> > driver which only needed by armv7 CPU without ATF.
> > 
> > Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Acked-by: Sebastian Reichel <sre@kernel.org>
> > Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> 
> We have Acked-by from rtc and reset drivers maintainers. Are you OK to take them
> through your mfd branch?
> 
> Are you planning to queue them for v5.8?
> 
> Just asking because if so I'd queue patch 6 through my tree.

Yes, please take patch 6.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
