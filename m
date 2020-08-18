Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE1247C05
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 03:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgHRB4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 21:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHRB4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 21:56:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E8BC061389;
        Mon, 17 Aug 2020 18:56:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so14311191wmd.1;
        Mon, 17 Aug 2020 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmkS2Ia+h+ApMIAh8GROqTADSC13UjF+XMotsJE/2dg=;
        b=FeW9T1y6GFuUyT8vEZ6AA3oQ7jbmue2B9kbwH1q5mpTxdaxatd/9gTaotsQikHmy3F
         xO5mReT7F5MJvCygN1kne8XlGTCa+E/ONajJOIdcz+kBVLEeg7vZL9Q0E9+PDnG/X7Eq
         XUMKeFemFiHqcL9yTnYh14EN0gNnkNV4hMGzsOWFw/gJskL2FT50fYr5ADwpumCKn9D+
         JZyJE58Z4w4JbPrssyzyVe1KQxi3hLdWsZA+NbilcltPewjefi5uc+7AAMmOLXr2LN3i
         iL8gZgIzcGGvxsTT/hsY74Ebdtce5GPP/kvWt5jPRZ3rkkZnDQTNsSssH8FKUseDetKi
         SVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmkS2Ia+h+ApMIAh8GROqTADSC13UjF+XMotsJE/2dg=;
        b=UKgBPm0x81+vYOhUUqdTbNkTXK9SUzvEdPON1/Hj0wsLAkbIHnqv30QZulZcJojT/k
         h77DkwTw1n9bzDxxYVz7nIOkVdy82v/zya7VvDbMCjhzUWO3TUl8bXmZQB55tcn61sli
         FpgTkf2d+9UxXxy75WX2QS+mDG6agVtMo2N8MQQxpGKuNa4U3/L7FoioQInoLWqo2gcD
         lv0hp1hcSfFX1OtUZZGicwjSKEUZ59bfpJyK3KXtliDhl+dGo0B2OcAs6ZMdOfBPAoNU
         m6HLidZimZg0jyPG8VeQjLmIuwTrVt+Tb3/xs6bOyBBKdxxMD90scLLc95GWM60PoCMc
         /b6w==
X-Gm-Message-State: AOAM533jZNkV5rqmKSbkiNR596dwVdO4+kIeNSVJESpnDBspoo6FULHO
        wrTShniqM2CIvgn5YVVw/O0Pq2VmvXIFFnDQ8L0=
X-Google-Smtp-Source: ABdhPJz4sPFnbc7ctDgUsfyOTslCQY/PttwBMI08GOkL8ttcF8xgZtn05M1fx5hvVfiZealhpL9dldYxWM/Ibx+i8Zk=
X-Received: by 2002:a1c:9803:: with SMTP id a3mr16266540wme.57.1597715799682;
 Mon, 17 Aug 2020 18:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597376585.git.huangqiwu@xiaomi.com> <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
 <20200814060909.GD1409566@kroah.com>
In-Reply-To: <20200814060909.GD1409566@kroah.com>
From:   Qiwu Huang <yanziily@gmail.com>
Date:   Tue, 18 Aug 2020 09:56:28 +0800
Message-ID: <CAPtXDt1e3fi7ymW0-FSknUAYCQ80aL=4btbeA2e4Xre7+e7OtA@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] power: supply: core: add quick charge type property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 14, 2020 at 2:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 14, 2020 at 11:46:54AM +0800, Qiwu Huang wrote:
> > From: Qiwu Huang <huangqiwu@xiaomi.com>
> >
> > Reports the kind of quick charge type based on
> > different adapter power.
> >
> > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++
> >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> >  drivers/power/supply/qcom_smbb.c            | 51 +++++++++++++++++++++
> >  include/linux/power_supply.h                | 14 ++++++
> >  4 files changed, 87 insertions(+)
>
> You should also submit your driver that uses these new attributes at the
> same time.  What happened to that request?  Otherwise no one really
> knows how these are being used, or if they even are used by anyone.
>

I don't think I can submit the whole driver because our drivers are
divided into three parts, the first part is in ADSP, the second part
is in kernel and the third part is in Android Hal.This is the second
part.


> thanks,
>
> greg k-h



-- 
Thanks

Qiwu
