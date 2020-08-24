Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF2324F0C8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 02:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHXAzK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 20:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgHXAzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 20:55:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7CFC061573;
        Sun, 23 Aug 2020 17:55:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u18so6744934wmc.3;
        Sun, 23 Aug 2020 17:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTP1LhQi+PG1kh5LGM9fOBVMY91Y4hCDBdK8fW0QTLM=;
        b=TjM+qDElmui8wfc2Mjkz6wHFsnuL0Zb/oJL2iv58J5pTseMU6FWy7nvlHs/2QRUQsx
         A6SIcxlcHjfHXccgTBu8+NhQSkfVUeXW9sdkob3qngVWN1Dbf1errfwvu0hSoxeJimnZ
         0gCVh3MV04U61GujlkjXkx+ybEQMiGNwLAF6FijYMfbPrN95xAhiTlPmr9pCY2boBISg
         tu+WXI1BLkTlJCCvYvmu7R0IkSiUBbWbUkw07hAZdxLOxfWyWh8gQjYY2wcSMZTWyXp5
         0k1KldNTtjZE6z/D7Es5anbmrASTeGcqFuRgdx/nXRB7kKtit6zqqw+jC5Mtb/xONW8U
         d+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTP1LhQi+PG1kh5LGM9fOBVMY91Y4hCDBdK8fW0QTLM=;
        b=mTKofqD5VRPyy14BpoH+QUV+RQOgSjX5TNLFnqd4/Zqr57gNBK/uFG7zPTRAmVCwNz
         JAVo7NMr/nccVJZpIOfHiOh/HbtPJKzzUeIyHpFn+CjYR5bPAuJMYKGOiXdiYBs3WjDh
         hlu9LiEsD6TIxH6s8kNHmvENiBET0s0rMo0xtGZjx23IIRDQYTL5jWb02FyzC5PRQnXN
         L97LqnPBIEyCwN+rwxD7Sg7xa4TY0IWyPO1FPEEfQWI5jIUVEBynFF7vFHTn0UoLCrhX
         ONcE+ZpGPvVdkr42ngbz4ROFUkNKsIO4Mk14sVRUoUHW7NwRiM0Qt4MLG4zmtr2joJ9O
         Gh4g==
X-Gm-Message-State: AOAM531Cytqqf7aH5Htut+hbNOHcjEjBEJ7oZi05LQC8LAZUocIAT7xn
        vaT1LI4/jPdFL/5g5q6oEComqbV+yKr4Clko/J8=
X-Google-Smtp-Source: ABdhPJz9xVFRPPPglq+S9Oc+3t71RsEDQthYP3Iei15wM1d5CPr3QJ0ORtI5uvT/5KqnY/KYBYsNbqU+gH5SAmCDKng=
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr3255220wmq.60.1598230508092;
 Sun, 23 Aug 2020 17:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597376585.git.huangqiwu@xiaomi.com> <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
 <20200814060909.GD1409566@kroah.com> <CAPtXDt1e3fi7ymW0-FSknUAYCQ80aL=4btbeA2e4Xre7+e7OtA@mail.gmail.com>
 <20200818060707.GB1742213@kroah.com>
In-Reply-To: <20200818060707.GB1742213@kroah.com>
From:   Qiwu Huang <yanziily@gmail.com>
Date:   Mon, 24 Aug 2020 08:54:56 +0800
Message-ID: <CAPtXDt26DdOi6JG7x3mTrR5YwArjkAeXY2TogRnK_xkSabhL2g@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] power: supply: core: add quick charge type property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiwu Huang <huangqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 18, 2020 at 2:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 18, 2020 at 09:56:28AM +0800, Qiwu Huang wrote:
> > On Fri, Aug 14, 2020 at 2:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Aug 14, 2020 at 11:46:54AM +0800, Qiwu Huang wrote:
> > > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > > >
> > > > Reports the kind of quick charge type based on
> > > > different adapter power.
> > > >
> > > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++
> > > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > > >  drivers/power/supply/qcom_smbb.c            | 51 +++++++++++++++++++++
> > > >  include/linux/power_supply.h                | 14 ++++++
> > > >  4 files changed, 87 insertions(+)
> > >
> > > You should also submit your driver that uses these new attributes at the
> > > same time.  What happened to that request?  Otherwise no one really
> > > knows how these are being used, or if they even are used by anyone.
> > >
> >
> > I don't think I can submit the whole driver because our drivers are
> > divided into three parts, the first part is in ADSP, the second part
> > is in kernel and the third part is in Android Hal.This is the second
> > part.
>
> WHat is "ADSP"?

ADSP: advanced digital signal processor

>
> Just submit your kernel driver code, that's all we care about here.
> Userspace code is not anything we can do anything with :)

If we ported the full driver, we would break the existing driver
structure because we would introduce more Qualcomm code. I think
that's an unreasonable change.

>
> thanks,
>
> greg k-h



-- 
Thanks

Qiwu
