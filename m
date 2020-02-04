Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0EF151AAC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 13:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBDMnL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 07:43:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38154 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgBDMnL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 07:43:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so7240917plj.5;
        Tue, 04 Feb 2020 04:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oK7WxSDye40Q4exQOmSbaOEE2awt0AmOHfgQ/uSgZ+c=;
        b=JRwCOSuR2tp+0d28muTxd7Vm+g5fQiqscXD0GrBsRFOfkbwQp+A9AiPdYYlpQkvW19
         DeLV4Gbxc4vJ7+v5DVFOEg8iVWfXLwCkpTlOW8H6++hgzLxiL0KaqBvUuFXOx90kcg/y
         nwQNwYmqpe3QJ1rsmbTfiy9Zm/sBVKoYgowdZ0B/7dUdDyyoVLi01e0ayIhph0m60zTR
         PDPzeSghMahwuKCA1re4pyG7BFoKiAHpXFhuAtJ37ciMdADdUpo7AvKvpb7g6m8lQsuU
         4pR8PwmzY82D509Hke/UAhFsW9FROXSDLPctvIOQiO5GvScgakpOGzjZCswOthVU6Bw8
         9mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oK7WxSDye40Q4exQOmSbaOEE2awt0AmOHfgQ/uSgZ+c=;
        b=fva/RjobqzToZHVWrb+Z8Np9E4Rd9Ai9BHnFlEaACiCWXQXwj5nx4at8kSpI1GV2Ca
         72y2INl0h742mxxqNjJknjgIZ6qFkxDb6prVhgSGt1jyjJYurr+QzJr0Y736eaE6a2+a
         zLuzv2iXvKOf2YF8+MvR2s14mhFc3VLJZwlgaJE1s9hMISU42Jb8T5U0EwDG/R47pqan
         wXAhNKhaIVrCv6wt0kdobeeskWEX86i03N2YNIFs57gOQmNiyGgAuza+xIRJeiR07X90
         skaZX948Iy9HseFtqGB9kO56D6UKVEZe8Fx0l867ZZlVlE5NI2xr2m7dtZTHcQTrzlcl
         0bSQ==
X-Gm-Message-State: APjAAAXux2gnw2yiPoYYeBRF2edClwZwNsmlcZ8h62qNgNyyY01wIwUw
        Ac981uQNQl+O7EgmKkQff+Y=
X-Google-Smtp-Source: APXvYqzMyByEtQrwQXHneoNt7j6f1bwKwikmbbZDpMd2+UB0JSbapMDRb7NVdrxaDdHv8J5sXv6rDQ==
X-Received: by 2002:a17:902:82cc:: with SMTP id u12mr27257199plz.342.1580820190632;
        Tue, 04 Feb 2020 04:43:10 -0800 (PST)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r66sm25316910pfc.74.2020.02.04.04.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 04:43:09 -0800 (PST)
Date:   Tue, 4 Feb 2020 20:43:01 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Fix build error for
 cpu-idle-cooling.rst and client.rst
Message-ID: <20200204124301.g5acaod54bellxzm@mail.google.com>
References: <20200203140223.10298-1-changbin.du@gmail.com>
 <20200203152255.GQ2841@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203152255.GQ2841@vkoul-mobl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 03, 2020 at 08:52:55PM +0530, Vinod Koul wrote:
> On 03-02-20, 22:02, Changbin Du wrote:
> > This fixed some errors and warnings in cpu-idle-cooling.rst and client.rst.
> > 
> > Sphinx parallel build error:
> > docutils.utils.SystemMessage: ...Documentation/driver-api/thermal/cpu-idle-cooling.rst:96: (SEVERE/4) Unexpected section title.
> > 
> > Sphinx parallel build error:
> > docutils.utils.SystemMessage: ...Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > 
> > ---
> > v2: rebase.
> > ---
> >  Documentation/driver-api/dmaengine/client.rst | 14 +++++++---
> >  .../driver-api/thermal/cpu-idle-cooling.rst   | 27 ++++++++++---------
> >  Documentation/driver-api/thermal/index.rst    |  1 +
> >  3 files changed, 26 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> > index a9a7a3c84c63..2104830a99ae 100644
> > --- a/Documentation/driver-api/dmaengine/client.rst
> > +++ b/Documentation/driver-api/dmaengine/client.rst
> > @@ -151,8 +151,8 @@ The details of these operations are:
> >       Note that callbacks will always be invoked from the DMA
> >       engines tasklet, never from interrupt context.
> >  
> > -  Optional: per descriptor metadata
> > -  ---------------------------------
> > +  **Optional: per descriptor metadata**
> 
> I have already fixed it up and it is linux-next (thru dmaengine tree)
> 
> Can you please send rest of client.rst changes to me as well
>
No problem. But I think here it should not create a new section, so instead I
made it bold.

> Thanks
> -- 
> ~Vinod



-- 
Cheers,
Changbin Du
