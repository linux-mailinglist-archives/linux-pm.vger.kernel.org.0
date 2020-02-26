Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1768D16FE1A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 12:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgBZLo7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 06:44:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34265 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZLo7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 06:44:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so2754987ljc.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 03:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zl97/zVIHjv4hKSszGOlk+Ftz8+qJVLf1Iur3zsxKEU=;
        b=NfQbaoBsEnsTwdQcM+s/NQyk0kVyRm+yX9Sro/St7tKSvvMqRx2LyQ4HmrONCuS27U
         ZmOn/9DKSf0umoRHeiiFyzfGnapOV3Uc7jSjBPE6ZsbSvGEmYr+w1mnVjaTMzs+qDEnO
         XooSeFH70wGTvLx7z8PyN9jPhTejPTWThGiEN98x/uqQbkVLHJ/lIsU1R39KUxPNIdLd
         85u3CNZAWSP0ywMT/+1qGK0YUf2r2/9WtLQfIVzY7zK37OAf4pkMQVNOW51e4/zbn3WO
         hiGuZX0H1UjO+5AczonyL/+eJK4FLCQDLSTsavjgP1yur0a0Gg7GUejhG8mgXqMxBeRs
         ILww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zl97/zVIHjv4hKSszGOlk+Ftz8+qJVLf1Iur3zsxKEU=;
        b=gP/6aE0YesXgvP5GDAGDct9d8K6e71Y+C4Mrs8TeF43kHsp+wr3dGKQwEhkJbnz4t1
         FkXEoCnpx1kYEOJlVB4cw9U327LPjrsczO04jM6Owpv3sgpN/besNi/ZjKqfENxizmlk
         ysm0+S+vixUVKS4AKQqUJP0sBecfmKTjx6njQ2CFx1uuNXPmxEv42HyInwI0q0xc9mMC
         HxEW9RhJsanb2g2vfUSkiVr9JaWUjYvvgoeDn6fu5RGilY7//PHOOzYzrIGTsYvDHwhX
         4jkQHQh9CTIx4hj45vYbDaevxFFkkQcDHT84sxC2q+xVBr9FooU0c4bPbl6/v6taupPp
         XBsQ==
X-Gm-Message-State: APjAAAV3RzTzrcmatL2y2ZmfhoFfQFVXB3k1cKLsqWHwn9CqygXGEnCt
        +2IthwxZcCsWsc68lyAsJ0/x8rNeOWw=
X-Google-Smtp-Source: APXvYqxo1VODHOrZ4Pe+VZti5F+/mvOwY5ogxF+V/RcNB+ubd4+6tjPEaewd6RTNbf10Cp6DhE4F4w==
X-Received: by 2002:a2e:8916:: with SMTP id d22mr2900017lji.19.1582717495379;
        Wed, 26 Feb 2020 03:44:55 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id d26sm879333lfn.22.2020.02.26.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:44:54 -0800 (PST)
Date:   Wed, 26 Feb 2020 12:44:54 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Kieran Bingham <kbingham@kernel.org>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Generate interrupt when
 temperature changes
Message-ID: <20200226114454.GE3165317@oden.dyn.berto.se>
References: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
 <46d8fe77-57f1-83e3-33ae-5080c6de2424@kernel.org>
 <20200226112433.GD3165317@oden.dyn.berto.se>
 <7f14a0c4-9d44-f0b5-77f6-60431c22550e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f14a0c4-9d44-f0b5-77f6-60431c22550e@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 2020-02-26 12:41:39 +0100, Daniel Lezcano wrote:
> 
> Hi Niklas,
> 
> On 26/02/2020 12:24, Niklas Söderlund wrote:
> > Hi Kieran,
> 
> [ ... ]
> 
> >>> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> >>
> >> Sounds good to me.
> >>
> >> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > 
> > Thanks! Unfortunately the patch is already merged so it will be hard to 
> > add your tag.
> 
> Where is it merged? I've it in my tree in the 'testing' branch about to
> move it to the linux-next branch. I can still add the reviewed-by.

My bad I was looking at the wrong branch, thanks for pointing it out.

> 
> [ ... ]
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
Regards,
Niklas Söderlund
