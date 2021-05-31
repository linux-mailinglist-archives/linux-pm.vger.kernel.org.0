Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258F63967C2
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 20:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhEaSWw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 14:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhEaSWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 14:22:50 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2630C061760
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 11:21:10 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id m15-20020a4ae3cf0000b029024598c3e273so924963oov.13
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x9RUBmMQU4rnqXddK5v0U/IX48u+qvHAWGVqJ1XFKLs=;
        b=MHfxWL+Lu2oOODkz5EoTuDHIQEi5s7ukPWtuhHlW/8XG5+UTcO6MYZpbiddXDafU5F
         6BUCX2CZFAoWuQQ8ecfq/dbqdNMyWIY+c9A33FW26Z01ymXG2GA/VMbR+EvD0lRi0cSu
         4Y8CfTTpcuLwu1yXNT4k0VmU8UZuRmBLN2V+rexKayEeusAHebQej9WLqyPL77O61dFp
         OmNyKQXf0By6aVugNT+JWITnnowVKt86hejogdhZZzGKiJTp9cmOmuQh2JrFcykSwfHN
         e2W8cJe6cmpiViWHsWatFqGd8Iuh6FLxKXaOs9tNVBj4TIvSqn5CMTkSkaGLKxQ7SZjW
         yMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x9RUBmMQU4rnqXddK5v0U/IX48u+qvHAWGVqJ1XFKLs=;
        b=oL88fMJidgC1bjmXNuG+ccFnJah1b+qLWmzvu4pdziZ59KplVvJFCfXuksbHwXHjaO
         DkO69OluCwspFFYbdMUwNY6BMCF5OZsCFnIYRsh+luvMu7vwnEibv6UF8FQAsSn/kvTd
         5cROqu+KK4KKy/m26uZVePhqQLb/3NzyIYGTETk7i7bGyPZbjwfliahPx2ab1yCEEAm6
         bTCLj58cCBVqTcY9fqfhRD3UojCli6aeteXOyBjolbCtefrnXa+0IZzTMuToMGUblWwC
         V5AuA4GOrrLXaA+lgNYolPieIRaZIiJmbTy3xnZHoHVHWk2D6ktT4ebUBberypt8pW2Z
         dZHg==
X-Gm-Message-State: AOAM5312t/ZPueqMqPwFvcTdHB7jxFp/H6AZvtimbc/075DjsTlSVSq7
        3rW5BDiE34kzk67+v559tdj11w==
X-Google-Smtp-Source: ABdhPJzu0yCihYWPm6Dv4bKzvA3alXKP7M0S6fx8sRM+Ca3aZphKMf4OAgtcwr7wrZvzZ0NcWt084w==
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr17112699oon.2.1622485270083;
        Mon, 31 May 2021 11:21:10 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t26sm3248506oth.14.2021.05.31.11.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 11:21:09 -0700 (PDT)
Date:   Mon, 31 May 2021 13:21:07 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, dianders@chromium.org,
        mka@chromium.org, sboyd@kernel.org, agross@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: blacklist SC7280 in cpufreq-dt-platdev
Message-ID: <YLUpE6NK3WC+Nu2S@builder.lan>
References: <1620807083-5451-1-git-send-email-sibis@codeaurora.org>
 <1620807083-5451-2-git-send-email-sibis@codeaurora.org>
 <20210520035622.e276tqpl4gg5fxhk@vireshk-i7>
 <6f5b1d0992243ff5d71362f463a5f1cf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5b1d0992243ff5d71362f463a5f1cf@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 20 May 02:20 CDT 2021, Sibi Sankar wrote:

> On 2021-05-20 09:26, Viresh Kumar wrote:
> > On 12-05-21, 13:41, Sibi Sankar wrote:
> > > Add SC7280 to cpufreq-dt-platdev blacklist since the actual scaling is
> > > handled by the 'qcom-cpufreq-hw' driver.
> > > 
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > ---
> > >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > index 5e07065ec22f..345418b8250e 100644
> > > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > @@ -137,6 +137,7 @@ static const struct of_device_id blacklist[]
> > > __initconst = {
> > >  	{ .compatible = "qcom,msm8996", },
> > >  	{ .compatible = "qcom,qcs404", },
> > >  	{ .compatible = "qcom,sc7180", },
> > > +	{ .compatible = "qcom,sc7280", },
> > >  	{ .compatible = "qcom,sdm845", },
> > > 
> > >  	{ .compatible = "st,stih407", },
> > 
> > Applied 1/2. Thanks.
> > 
> > What do you want to do for 2/2 ? Go through my tree? need an update ?
> 
> Lets skip pulling in 2/2 for now.

In particular it's ripe for merge conflicts, so I'd prefer to take it
through my tree.

> It depends on a few other changes to land first and the cpufreq node
> for sc7280 needs a re-spin.

What other dependencies do we have?

I dropped the reg-names from the cpufreq node and merged that change.

Regards,
Bjorn
