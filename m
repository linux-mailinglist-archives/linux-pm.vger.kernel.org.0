Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1581E3A8D
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgE0HaQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 03:30:16 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:55286 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgE0HaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 03:30:16 -0400
Received: by mail-wm1-f41.google.com with SMTP id h4so2036376wmb.4;
        Wed, 27 May 2020 00:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXATUV2kmWVOj+bOGqsD/6QdFtMrMkN6a5cRn2rn+Rc=;
        b=ZgesieiwpyHalzO5TUH7qUcXy14B+96aKZopS/5oLQRWZcAvkAbUjMiXcwL0u+xCfz
         U0DgC6TWkwzFCbaH0bRhHuDUjON+e7IM9/KbYwYsXU4PNnIwdPiB6UBD91GdYsjMFjA6
         EJOySgM6R741p9J4EFYDKzu1M7J8/C3PHfF4PiCT1tcGy1evPWoJHqEofHHImHuov/QR
         0My5UI3RwR6NRdi4wF+FXClrrJqePYTUB44QRR/In3vcLaiMl7GuN3OEiFkqITsoc2pE
         S0aFjtO/vtFDL/LodgZ0/8ubHl/iRNafUS0I0Y0LyTuHkLW9yzd5NUDiaxwrm1iFTnFd
         5Etg==
X-Gm-Message-State: AOAM531V9WxwKK7BvWgBZ/JElCBEQmV+kFFokJB+USG3XIhNlVIAXmiy
        9IjeW3t9dFh8dnLerXSGdj0XAX9k
X-Google-Smtp-Source: ABdhPJzO+L2ciScB/jcJnVz2CSF5gGGv1JX8spAkVEyXRDbttpKWZaHX3kqA+/fQrn4w52SZunBg/g==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr3131726wmh.31.1590564614363;
        Wed, 27 May 2020 00:30:14 -0700 (PDT)
Received: from pi3 ([194.230.155.118])
        by smtp.googlemail.com with ESMTPSA id z6sm1980255wrh.79.2020.05.27.00.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 00:30:13 -0700 (PDT)
Date:   Wed, 27 May 2020 09:30:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@proceq.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: bq27xxx_battery: Notify about all
 battery changes
Message-ID: <20200527073011.GA4615@pi3>
References: <20200525141200.17199-1-krzk@kernel.org>
 <fc59bcd5-1868-8c7a-9fc9-67ad70b477f4@ti.com>
 <20200527072218.GA4575@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527072218.GA4575@pi3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 27, 2020 at 09:22:24AM +0200, Krzysztof Kozlowski wrote:
> On Tue, May 26, 2020 at 09:24:39PM -0400, Andrew F. Davis wrote:
> > On 5/25/20 10:11 AM, Krzysztof Kozlowski wrote:
> > > All battery related data could be important for user-space.  For example
> > > time-to-full could be shown to user on the screen or health could be
> > > monitored for any issues.  Instead of comparing few selected old/new
> > > values, just check if anything changed in the cache.
> > > 
> > 
> > 
> > At least some value will change every time we poll the battery, are we
> > okay with having power_supply_changed() called every time?
> 
> Hi,
> 
> Let me give few arguments:
> 1. "Every time" means still once per poll interval or in case of many
>    get_property() calls, once per 5 seconds. In first case, if users
>    sets polling every 1 second, I expect he knows what he wants. I2C
>    will be busy anyway so uevents should not matter that much.
>    In second case, called through get_property(), once per 5 seconds is
>    not that frequent.
> 
> 2. Different drivers do it differently. Many chargers notify about
>    everything. Most fuel gauges only on status or capacity change (although
>    I am not sure if they measure more) but few FG send uevents about
>    everything (max17042_battery, sbs-battery, s3c_adc_battery).
> 
> 3. If drivers does not send notifications on changed properties of
>    battery, then basically the user-space has to poll every time for all
>    data which is not being a trigger.  The overhead for system would be
>    the same, I guess.
> 

And one more:
4. I actually needed for my project. I have a user-space which
   previously was polling the battery status but I converted it to udev
   events.  The voltage, current and temperature are important for me as
   well so I need all uevents.

Best regards,
Krzysztof
