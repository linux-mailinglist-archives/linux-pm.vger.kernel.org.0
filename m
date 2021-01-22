Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06672FFCB8
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 07:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbhAVG27 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 01:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbhAVG1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 01:27:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB0C06174A
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 22:27:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u67so3075238pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 22:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=svgrB85wDJvp1wFsJQnCVp+ank0Arsi8GO3FERYAPGc=;
        b=ux0UjAuQYmGVBrb8Ye8qm1tpjApuGIEbLNzDKfWG+sREKtOBhs9wc69kCk2XcGEVUh
         u4H3V16lDaQ13d/AsqE4nHLxmPe4u06EH1Ukvg1m+2aWKGTgxgUMmm0h9Dyvq3nJb8ZP
         wCFeHZ709a0RsxBpawIx7FvwlQZ8KLhnixCtMwH2xgNME8aSrvH+oC4TzP1Dr5/Q2t3Y
         N7tUbU7RSFbJcNRFLbM6VehvtjO8Sb5j3WRpjKSVSc63nhcKQUoNQNIRXe6oINWi8Mz6
         tP5tfq11q/Tl8+KmTKFLM8pkvPvi50GMr6qKyC077jMTvm/URFFLSlHH/sqZHxmEpnqa
         qNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=svgrB85wDJvp1wFsJQnCVp+ank0Arsi8GO3FERYAPGc=;
        b=e8na/E6uTo0yA3DC9kwUfwBg/Or4WiFl84GIfrYEY/+IVbw8RP6ciYu9j3di9IyB7d
         x3Jvnip7ArJ297GS47Ixb2acMQi4odRI3N0ca+FLTvvY1i5vh4wkd14bq8bsqqI729wZ
         DlRXoOGioblo4sYH99dZU9tkrvJ/L6fDcweVDppe49sPfydLbUBYp3DEh4dHOiwTMEYG
         RcanXXdYaDMm68gGlrKaWkPZ0sv0/NvaosNvVBZvRGQeL4u6aYgowT7Ug/KRWeOnVdhb
         yUTMlt9wIonaQIFCNBXlD2IwC6LoN3CZTWcE4Xbmup2m1zrG5AVSqg+hhAd3XHo3cQlJ
         oBQQ==
X-Gm-Message-State: AOAM533r5ybm/cYMyeR6jVeBeVy0XVvD81yOwrCfPjRnQioa3wHHyhX+
        JJj78t1KRNEu4yb8JGcrESPkjA==
X-Google-Smtp-Source: ABdhPJyYey8B/wZZECCKK/6z6M0ZdDm5dsyDljIPXQKsuXilPAqgZAz+8Uqbev9+vKmCz1YIcKVNQg==
X-Received: by 2002:a17:90a:f2d2:: with SMTP id gt18mr3578692pjb.102.1611296822502;
        Thu, 21 Jan 2021 22:27:02 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id q2sm6678851pfj.32.2021.01.21.22.27.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 22:27:01 -0800 (PST)
Date:   Fri, 22 Jan 2021 11:56:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 11/13] devfreq: tegra30: Migrate to dev_pm_opp_set_opp()
Message-ID: <20210122062659.qss3hef4kltfgciu@vireshk-i7>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
 <71451eb2-46b2-1ea0-efcc-0811568159a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71451eb2-46b2-1ea0-efcc-0811568159a4@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-01-21, 00:36, Dmitry Osipenko wrote:
> 21.01.2021 14:17, Viresh Kumar пишет:
> > dev_pm_opp_set_bw() is getting removed and dev_pm_opp_set_opp() should
> > be used instead. Migrate to the new API.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> > index 117cad7968ab..d2477d7d1f66 100644
> > --- a/drivers/devfreq/tegra30-devfreq.c
> > +++ b/drivers/devfreq/tegra30-devfreq.c
> > @@ -647,7 +647,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> >  		return PTR_ERR(opp);
> >  	}
> >  
> > -	ret = dev_pm_opp_set_bw(dev, opp);
> > +	ret = dev_pm_opp_set_opp(dev, opp);
> >  	dev_pm_opp_put(opp);
> >  
> >  	return ret;
> > 
> 
> This patch introduces a very serious change that needs to be fixed.
> 
> Now dev_pm_opp_set_opp() changes both clock rate and bandwidth, this is
> unacceptable for this driver because it shall not touch the clock rate.
> 
> I think dev_pm_opp_set_bw() can't be removed.

I am wondering here on what would be a better solution, do what you
said or introduce another helper like dev_pm_opp_clear_clk(), which
will make sure the OPP core doesn't play with device's clk.

-- 
viresh
