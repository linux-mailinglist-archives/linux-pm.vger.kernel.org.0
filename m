Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1A73DF846
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhHCXM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 19:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhHCXM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 19:12:56 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64191C06175F
        for <linux-pm@vger.kernel.org>; Tue,  3 Aug 2021 16:12:44 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n16so750677oij.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Aug 2021 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i+DGuoeLoChs6Ei4AJ031ih+E+zcev4zRO6x+z1vz+s=;
        b=tgrVhS0xsGM0woAKFLMfnMFTciJ1Rc6vsLIQyP/i2i8ArCp0ErwmvRnIh5IaCpVlVT
         de6ZVG4jUMWYikAZYeiPkbmPlV2DsOGvq7lZUJ/cnhqGCo4bUXEcWINETSM5w7fv7Hva
         meSj8az8RjT/s1kpdDIlaAiSnkSjO8AKAfP1EltllFdN/t4WHr4SCA0oVy31rtY3s0+V
         kQJB1KPg20T8AJ2dmOSmm6ilkk26gRow/9MByAqNm5NK8kFyfkBDFOqIfG7Uz9E3879/
         4zcK42u0y90EM4WwbBLdEpGe+F+chBSADThwzz8A/bEGNJrRef2ktx867M7jdQKxXcRn
         0DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i+DGuoeLoChs6Ei4AJ031ih+E+zcev4zRO6x+z1vz+s=;
        b=BWUxsi5cczeVWKuTMGkDuihkp3RJUyH1Vr34ai3wbp1d7wktsTRgIxZj/K+Cbkpnsz
         hRtEbhkE5om2B3gPAazYZ8ilGDHooroBYEpKZMOBFJIuizSnbFS3G+bYoB78Pjn+QRPc
         /5C/OCbFK3MI1s1F+/dWGgCVzlODSFbj6taO63CoHMQlRVe2NvtJXHdM0af9Cv85Wa7s
         7lhERwCmyc+v9vDU/9IMXesDP8vhfPN13H8XVX9psaztVjilXyxgxvjfuVLkVflifIW2
         hoNyY8tvxiJAeAHacFv/7OM3WD4UdM8PEWSxHnGbd3d3mNRismPMbWQPTmF3qV1vwI3q
         6PEw==
X-Gm-Message-State: AOAM531+5Trgh14mLAsqg+oArUgm99ysvMYcWl7XI2RQYsrx/m0/tdOG
        eQkR5w/k7dfxNkD1KtGKl9ynmQ==
X-Google-Smtp-Source: ABdhPJwa87SFdE7d4lnFkZg5tizEp+UNMG3WPscx4sDxJhPVVs2Sft3z8URa70QYD0vL7GWqu3V4gw==
X-Received: by 2002:a54:4107:: with SMTP id l7mr4759521oic.66.1628032363639;
        Tue, 03 Aug 2021 16:12:43 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q187sm132746oif.2.2021.08.03.16.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:12:43 -0700 (PDT)
Date:   Tue, 3 Aug 2021 18:12:41 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] PM: AVS: qcom-cpr: Use
 nvmem_cell_read_variable_le_u32()
Message-ID: <YQnNaULsNVuQwYOz@builder.lan>
References: <20210521134437.v2.1.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
 <CAD=FV=X8xgn=ueyryFZVA-VNLEU_sk8H29D08JaEpw2Qh2OFqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X8xgn=ueyryFZVA-VNLEU_sk8H29D08JaEpw2Qh2OFqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 23 Jul 18:05 CDT 2021, Doug Anderson wrote:

> Rafael / Bjorn,
> 
> On Fri, May 21, 2021 at 1:45 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > Let's delete the private function cpr_read_efuse() since it does the
> > basically the same thing as the new API call
> > nvmem_cell_read_variable_le_u32().
> >
> > Differences between the new API call and the old private function:
> > * less error printing (I assume this is OK).
> > * will give an error if the value doesn't fit in 32-bits (the old code
> >   would have truncated silently).
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I haven't done any more than compile-test this. Mostly I'm just
> > writing this patch because it helped provide inspiration for the
> > general API function.
> >
> > Changes in v2:
> > - Resending v1 as a singleton patch; dependency is merged in mainline.
> >
> >  drivers/soc/qcom/cpr.c | 43 +++++-------------------------------------
> >  1 file changed, 5 insertions(+), 38 deletions(-)
> 
> Are either of you interested in landing this? I guess Rafael landed
> most of the recent changes to this driver, but it used to be under the
> 'power' directory. Now that it's under 'drivers/soc/qcom' maybe it
> should go through Bjorn's tree?
> 

Yes, it makes sense to pick it up through my tree, unfortunately I
forgot about this move and ignored the patch in my queue based on the
$subject.

I've picked it up now.

Regards,
Bjorn
