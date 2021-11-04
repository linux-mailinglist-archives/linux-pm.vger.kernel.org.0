Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4653E445058
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 09:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhKDIde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 04:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 04:33:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA2C061714
        for <linux-pm@vger.kernel.org>; Thu,  4 Nov 2021 01:30:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d13so7330415wrf.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Nov 2021 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+e1rGQgDiU+AR2ZIiUkF5VNY6vGuBgYqHlQagZctjXo=;
        b=IPcycCE3YPg1cFU8cLD+A9mDm1SrNdo7QaKnMKfoSV5tsiw5v+ESjb6f9iYJw0+RL1
         GNU/cNBvGuuwfFqcR53gfa6nuiiMSSCcAJwHoA17ORKorezh9Xfovzl93banWXCHQf9W
         cJn5gm0C8dymr5f56ne1IqVSaQUJDPAUk/43+q0cHNbpEEPoU7z69b/sE8WnyMhzoerk
         m3uejM6SsKRY/e52IoFTeLQcObkjw7CHpxu+WkXrEdOfC2ZtvW1UYQw34XAG/ADtbdnP
         2Suw7Xvmd+R5frtdC/ZY7ZLEu4OOEL4MLFY/jNPWgsBHWMWlFwcw7fq6e7Tc64tSoXY9
         hB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+e1rGQgDiU+AR2ZIiUkF5VNY6vGuBgYqHlQagZctjXo=;
        b=aISID7D7NYfwlei5OLJ99AWWwRTgYEWCvryDAJyDeXLuf5JUJZJiMe2VKPHrCNRmB/
         qFYBIgbDrdfJzzTfaJ1ROtqe3QrXldfVwdaeKlFx3DeaHmlxWmCJQfurI8CShh6i34h8
         b0phrGv8q0AhSRlta738JSvNR8rdIntsuUlRGkY2MHDif9Fytk2t5sbYHF4glwUDAWHS
         wgnmSu8VTpwd3oyztPayMmf3XbiQSViL6DqbpyEHIL4vON5iazVZKqowQ3eIKYjTx7gI
         otU+GDONer4BrHsspUn2mFjlk32domVuux2oWfBqq4RkZWRnjTeEc4IFHgSEC8quHlXz
         bxrg==
X-Gm-Message-State: AOAM531IqwRYqfuBJy9t6r5IiHYEXaswTq0qsIvby+6HJd2IYc9WWMOH
        pQDT+BNT+waZcHHCnMlXmD1ZnPgJteyGcQ==
X-Google-Smtp-Source: ABdhPJyTt4eyJ7brqUGRlFddpmH8bpCz/HRRLJmamuxKAP1orvhiHWM10Hn5lbXP6Bs8kvK7ERvutQ==
X-Received: by 2002:adf:dc0d:: with SMTP id t13mr62144134wri.158.1636014655152;
        Thu, 04 Nov 2021 01:30:55 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id l2sm4020199wmq.42.2021.11.04.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 01:30:54 -0700 (PDT)
Date:   Thu, 4 Nov 2021 08:30:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/9] Remove unused headers <linux/jz4740-adc.h> and
 <linux/power/jz4740-battery.h>
Message-ID: <YYOaPe2o4Ra0+dL6@google.com>
References: <20211102220203.940290-1-corbet@lwn.net>
 <20211102220203.940290-2-corbet@lwn.net>
 <YYI9t2Ng1Uppkiav@google.com>
 <20211103124046.te5rfhfvkbw2tby3@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103124046.te5rfhfvkbw2tby3@earth.universe>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 03 Nov 2021, Sebastian Reichel wrote:

> Hi,
> 
> On Wed, Nov 03, 2021 at 07:43:51AM +0000, Lee Jones wrote:
> > On Tue, 02 Nov 2021, Jonathan Corbet wrote:
> > > Commit ff71266aa490 ("mfd: Drop obsolete JZ4740 driver") removed the last
> > > file to include <linux/jz4740-adc.h> but left the header file itself
> > > behind.  Nothing uses it, remove it now.
> > > 
> > > Similarly, aea12071d6fc ("power/supply: Drop obsolete JZ4740 driver")
> > > deleted the last use of <linux/power/jz4740-battery.h>, so remove that one
> > > too.
> 
> Thanks for the cleanup Jonathan.
> 
> > > Cc: Paul Cercueil <paul@crapouillou.net>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Paul Burton <paul.burton@mips.com>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > > ---
> > >  include/linux/jz4740-adc.h           | 33 ----------------------------
> > >  include/linux/power/jz4740-battery.h | 15 -------------
> > 
> > It appears as though there are still references to both of these
> > *devices* in the kernel tree.  Should those be removed also?
> > 
> > >  2 files changed, 48 deletions(-)
> > >  delete mode 100644 include/linux/jz4740-adc.h
> > >  delete mode 100644 include/linux/power/jz4740-battery.h
> > 
> > Patch looks fine though.
> > 
> > Let me know if you want me to take it in via MFD.  Otherwise:
> > 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> You can take it through MFD, no immutable branch needed.
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Okay, no problem.

Since the merge-window is already open, we'll aim for v5.17.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
