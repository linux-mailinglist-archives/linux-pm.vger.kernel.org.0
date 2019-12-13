Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60FA11E93F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 18:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfLMRbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 12:31:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36638 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbfLMRbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 12:31:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so1825147pfb.3;
        Fri, 13 Dec 2019 09:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rAse+HUSmAaqHJABAbnX0rRs7xuvJErVIeGJ5dj9few=;
        b=MQ9l8tB7Eji8SPxaWILyz05JwsHf8cIRm4+r/t5FGHu9snbvMU2PA7sak8miuVlRIK
         CffoteJoRgqSMhHiy/rOkcoZvZTYOceGobicLOSrngq/yAlbBMp/th1bgSC3mPeonNbF
         QCQKp7b+bd8+Ap9DpM3K6mSoIkOKl1IH/LVDUE5HxgmyNZY7tVMqjg2d/wOzJ3lWZuzl
         bzpFWUqWJOQIwZI7L8CqJWBeBoV+uhtHnjGN2ax2oazcu2kbwrlrWbMIjmkdrtFrQY2W
         /9uNs9/rmbaTMdo7hDnrGJHw+cJhw0g2pT3Pakei9oWWTwEKnNzJmHL3ayoH3yLTX10M
         smuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rAse+HUSmAaqHJABAbnX0rRs7xuvJErVIeGJ5dj9few=;
        b=KchvybgMQkCtmV2AY2hWIV7ehLsIxt2x3mNVU3Vm8zH9G8qxqXqeHgQlQtqXe6dSKn
         AgbSLp8zU23c3JckxYWygKYgQB6woWt32d25hImONIBQY2lwBmWZMmyye9yemeHPV5zH
         oGqtrNrIw5kutM8mV6vN3TsR2NzIvgX7ofBmEtwKlMjcX52lY/k5+rtwR48cXA7cJmN+
         Gy8glKTHEaJkfNmXIEqpZwpIda0TvU2Row2wU24BLT3Ym2jHFXf1SCjml8X+OAhuiw/e
         NU08NU/cc3SUHDVHjgNBpWH33z3JtAhxtCN7b/Y8e0divuDqKptoJNgQiCZBp5LiH4JL
         vYdw==
X-Gm-Message-State: APjAAAXafi5ppmlHZOlNOwcFS6nPQg4TZfvqAts6M47W583mU/J3eGix
        BN0HDkp7m9tzSLhjNs29SI0=
X-Google-Smtp-Source: APXvYqwhUACNgTJzGRRy1jtJOv0oTmko6DYqndJTw3CeclwzY4A7VkH70DpTXSUoyWYjH9suvPQynQ==
X-Received: by 2002:a62:5290:: with SMTP id g138mr627671pfb.54.1576258282234;
        Fri, 13 Dec 2019 09:31:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k60sm10828136pjh.22.2019.12.13.09.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Dec 2019 09:31:21 -0800 (PST)
Date:   Fri, 13 Dec 2019 09:31:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     schaecsn@gmx.net, jdelvare@suse.com,
        Heiko Stuebner <heiko@sntech.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        lakml <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH] thermal: rockchip: enable hwmon
Message-ID: <20191213173119.GA4231@roeck-us.net>
References: <20191212061702.BFE2D6E85603@corona.crabdance.com>
 <CAHLCerOHjAEEA1BpUqPdZvFwHMy11SqC+ZtjdFyManu7iOpBXA@mail.gmail.com>
 <20191212232859.E09FC6E85603@corona.crabdance.com>
 <CAHLCerN9jc94ydKKoaDZPoTy=LmVZti6UUpND5aK3FMzTkCmoA@mail.gmail.com>
 <CAHLCerMf1nbuxjZz81QnE6jXeQ5UvB=R18SDu69cE9Q6rQp8+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerMf1nbuxjZz81QnE6jXeQ5UvB=R18SDu69cE9Q6rQp8+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 13, 2019 at 10:09:49AM +0530, Amit Kucheria wrote:
> Fix Guenter's email.
> 
> On Fri, Dec 13, 2019 at 10:08 AM Amit Kucheria
> <amit.kucheria@verdurent.com> wrote:
> >
> > Hi Stefan,
> >
> > On Fri, Dec 13, 2019 at 4:59 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
> > >
> > > Hello Amit,
> > >
> > > > On Thu, Dec 12, 2019 at 11:47 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
> > > > >
> > > > > By default, of-based thermal drivers do not enable hwmon.
> > > > > Explicitly enable hwmon for both, the soc and gpu temperature
> > > > > sensor.
> > > >
> > > > Is there any reason you need to expose this in hwmon?
> > >
> > > Why hwmon:
> > >
> > > The soc embedds temperature sensors and hwmon is the standard way to expose
> > > sensors.
> >
> > Let me rephrase - is there something in the hwmon subsystem that is
> > needed that isn't provided by the thermal subsystem inside
> > /sys/class/thermal?
> >

Doesn't the sentence below answer that question ?

> > > Sensors exposed by hwmon are automagically found by userland clients. Users
> > > want to run sensors(1) and expect them to show up.
> > >
> >
> > That is a good point. In which case, I wonder if we should just fix
> > this in of-thermal.c instead of requiring individual drivers to do
> > write boilerplate code. I'm thinking of a flag that the driver could
> > set to enable the thermal_hwmon interface for of-thermal drivers.

It seems to me that would be outside the scope of this patch.

> >
> > > Why in rockchip_thermal.c:
> > >
> > > drivers/thermal/ provides a high-level hwmon api in thermal_hwmon.[hc] which is
> > > used by at least these thermal drivers: rcar_gen3_thermal.c, rcar_thermal.c,
> > > st/stm_thermal.c, and broadcom/bcm2835_thermal.c. I want to hook up
> > > rockchip_thermal.c exactly the same way.
> > >
> > > Apparently, other architectures hook up the cpu temperature sensors to hwmon
> > > elsewhere. Most seem to do this in hwmon/, e.g. hwmon/coretemp.c. These drivers
> > > are written from scratch. Utilizing thermal_hwmon.[ch] for chips which have
> > > already drivers in drivers/thermal/ seems to be more elegant.
> > >

There should either be a hwmon driver with a bridge to thermal, or a
thermal driver with a bridge to hwmon, but not both. A couple of
existing drivers implement both, but that should really be fixed.

Guenter
