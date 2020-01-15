Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C4913CC3F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAOSjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 13:39:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37350 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgAOSjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 13:39:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so13504017lfc.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 10:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zXVPagk9qy6y1pvhnWsVit2PeslU4wNbSMADm371SMA=;
        b=aj7b4wZMsmzA/j5jJk0eKoPAbxmen1HlcPaI3zqGFb7zqb4T4zPXtek0Iv/FvRVEuw
         V0H2lPqNZptjw+8JXVznLeuYNHDqg6lIviGqr61W/bW5YlVA+yI1UVVfIpShh/OtQOVl
         Zp9XicUCnP8CdkU8cQED9Q0QP/np6sYi7HSTu/XG7IDjj6OMQ5xfPxKdBnctdOCNL4PX
         VOr11WEvexBioKDMriayxGNH2V6r5aVn5JHD843MjMtt9JbGGNmfdQ2XyaJSLxyc6XcW
         9pag2DjD43LS9hpmMaqvQ15QN7QKQD5EtAJHWP44YrPxpDrj6WTMCMkfPweR5VoP096T
         tqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zXVPagk9qy6y1pvhnWsVit2PeslU4wNbSMADm371SMA=;
        b=Xn9ucr47sf+1PdEwNKVsAepatbCi182q2CYpPxrt+AGkVO2KDThL/T8xmY16eSvxbF
         SHtiEJDJGNPIXyScGjyCMli+UAZ+gGU6jxEN2vq/cMQqJP7giyOUXtyhVut9Rzd7PVV6
         wlfFod9hMx2tfvsY9TpKgxcVcN33czrLli4hBawPBiYF1LMMpXSyghEebkP6NF61p824
         L7tbayKdvqM8Sljj+zPK7U9hpk/WeDLx8TrXosM+cyIkRl/6tGC9RejGw0S2ziqR5Hh3
         UeY8sDoFR80NzF7MNYPf9ZaeMNe1cIniReUJljJ0BSEMG+q52gq4QgRpYbr2K4Dl7IfL
         +5Ug==
X-Gm-Message-State: APjAAAX1bRVCCkz/NGjQzbrbzXR7A/jmIhfseNznnxLDDk8r4+4ZjF9o
        uhgfWOSM/lT40uDShDkSTUFM5EKIB88=
X-Google-Smtp-Source: APXvYqx3o1geG9DVN0+yWVxPH0U1oYe+kMH4w2sGpk9818GWZ5uKiP2U9GaNpKvS32E35/1CF+eZVg==
X-Received: by 2002:ac2:544f:: with SMTP id d15mr172788lfn.126.1579113582544;
        Wed, 15 Jan 2020 10:39:42 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id 140sm9469856lfk.78.2020.01.15.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:39:41 -0800 (PST)
Date:   Wed, 15 Jan 2020 19:39:40 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: rcar_thermal: Remove temperature bound
Message-ID: <20200115183940.GA979534@oden.dyn.berto.se>
References: <20200114222945.3128250-1-niklas.soderlund+renesas@ragnatech.se>
 <20200114222945.3128250-2-niklas.soderlund+renesas@ragnatech.se>
 <a98baf8f-e2ef-d77d-ff3c-f5838e268dd7@linaro.org>
 <20200115134559.GA945270@oden.dyn.berto.se>
 <d7c7bb44-897d-a3a3-c203-d87ffb7de9be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7c7bb44-897d-a3a3-c203-d87ffb7de9be@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 2020-01-15 19:15:11 +0100, Daniel Lezcano wrote:
> On 15/01/2020 14:45, Niklas Söderlund wrote:
> > Hi Daniel,
> > 
> > Thanks for your feedback.
> > 
> > On 2020-01-15 14:24:30 +0100, Daniel Lezcano wrote:
> >> On 14/01/2020 23:29, Niklas Söderlund wrote:
> >>> The hardware manual states that the operation of the sensor is not
> >>> guaranteed outside the range of -40°C to 125°C, not that the readings
> >>> are invalid. Remove the bound check and try to deliver temperature
> >>> readings even if we are outside the guaranteed operation range.
> >>
> >> And what if the sensor is returning crap in this out-of-range operation?
> > 
> > I'm not sure what is worse, reporting an untrue (but still outside the 
> > guaranteed operation range) extreme temperature or failing with -EIO.  
> > The view of the hardware guys is that it's better to report what the 
> > sensor indicates then to return -EIO.
> 
> I don't get the point.
> 
> What happens if we read the sensor while it is above or below the limits?

The manual describes the read outs as being +/- 2°C from the true 
temperature for the guaranteed operating range. Outside this range the 
difference between the true temperature and the read out temperature 
might be larger than 2°C.

> 
> 
> [ ... ]
> 
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
