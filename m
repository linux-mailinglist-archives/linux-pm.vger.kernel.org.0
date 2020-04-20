Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E561B032B
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTHgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTHgn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 03:36:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E3C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 00:36:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so10162054wmh.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Mb0X0VbhAnhVtMeOXLuQ8HsuJ6uYYtL6iIOac3n0PJU=;
        b=st0iZapP+zDcsQ4UrQb7rcM/hsGHFlairhxjzCU+eWwjjuseXuqjJPI+WXPiBeW+Ul
         493WUgOLbd3mEM16Cz06eaR8/6bMoVqw5mTtKi8z4TMnE1oxQVpLJVVt+gfkQ+awZtBz
         Llr3jJX2BwEJq6rwnMOXeZHh0HD0SCgTsSVh4nnX6ZlTuAdVem4zbngqA18U1cPELUZ/
         sp8zegHh6y8ehz3646WCK8B67qgzanSNH1hLnjoluhIns84gS4L6UP74qr+2o2ZskG3I
         UFiPAJ0w6uzb0ZGGR3YkpjjQ3s73dRbet54XvXOraKAVsFDH372JkVtKLsg+g+bV0NQf
         x8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mb0X0VbhAnhVtMeOXLuQ8HsuJ6uYYtL6iIOac3n0PJU=;
        b=cW5uvnAIYyIJSVg/QFz7TyhjZrMy+gLiR6oP/ic3P+CBKcMjG9NqY08NIkX0m2YOgR
         dnBPg+Ah9roRoYgSUyWHww1nM0G7emlV+CSIRhNzenmtsYPiZzE2i0p3YBjYEXxvpsUi
         bUNRtTIaFLTpSoOr/I0QOD9feFBz3LxB3SIZ8rUHM1+4tlV7r0YFSmpka3UR6jH1ZAf+
         Ba9E9Tw89kA5yYKbfMJ5mgX1/fd1uekWM/JwkI7go8uBrSwTNxZjvo8QnMdR4e6iO0sX
         fILuMgsB2dbUt1VUl4QAonQwGvcoFgnLIVKQAP46XwV6egA0btCR7eIV93jj9kObOpCX
         zGww==
X-Gm-Message-State: AGi0PubQPNBPAdQFlnk9Jy0RG+WmZf9/p6EsJxh6Pa+SDessn++zhPm3
        iqfImGOvJyCO8marH0WIvzCV6w==
X-Google-Smtp-Source: APiQypJ25Kjm3y9Zgopg3qXJE7CUHbyrlxsvNzWf6js5QWhmpv4/KdDycmxZJtwyZTMEA2yfKfjtHw==
X-Received: by 2002:a1c:40c4:: with SMTP id n187mr15810229wma.28.1587368201801;
        Mon, 20 Apr 2020 00:36:41 -0700 (PDT)
Received: from dell ([95.149.164.107])
        by smtp.gmail.com with ESMTPSA id w18sm19085wrn.55.2020.04.20.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:36:41 -0700 (PDT)
Date:   Mon, 20 Apr 2020 08:36:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ran Bi <ran.bi@mediatek.com>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v12 5/6] rtc: mt6397: Add support for the MediaTek MT6358
 RTC
Message-ID: <20200420073639.GL3737@dell>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1586333531-21641-6-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20200416091438.GA2167633@dell>
 <1587112169.12875.2.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587112169.12875.2.camel@mhfsdcap03>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 17 Apr 2020, Ran Bi wrote:

> On Thu, 2020-04-16 at 10:14 +0100, Lee Jones wrote:
> > On Wed, 08 Apr 2020, Hsin-Hsiung Wang wrote:
> > 
> > > From: Ran Bi <ran.bi@mediatek.com>
> > > 
> > > This add support for the MediaTek MT6358 RTC. Driver using
> > > compatible data to store different RTC_WRTGR address offset.
> > > This replace RTC_WRTGR to RTC_WRTGR_MT6323 in mt6323-poweroff
> > > driver which only needed by armv7 CPU without ATF.
> > > 
> > > Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Acked-by: Sebastian Reichel <sre@kernel.org>
> > > Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > 
> > Please place these in chronological order.  They should provide some
> > history, rather than a unordered slab list of random sign-offs.
> > 
> 
> I suppose that you mean the order should be like below, right?
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> Signed-off-by: Ran Bi <ran.bi@mediatek.com>

This would imply that it was reviewed before it was written, which
would subsequently imply time-travel, so I suggest not.

Author(s)
Review(s)/Acks(s)/Tested(s) /* ideally in the order they were received */
Sub-maintainer sign-off     /* if applicable */
Maintainer sign-off

> > > ---
> > >  drivers/power/reset/mt6323-poweroff.c |  2 +-
> > >  drivers/rtc/rtc-mt6397.c              | 18 +++++++++++++++---
> > >  include/linux/mfd/mt6397/rtc.h        |  9 ++++++++-
> > >  3 files changed, 24 insertions(+), 5 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
