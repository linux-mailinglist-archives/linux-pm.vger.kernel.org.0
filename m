Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDB32685
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 04:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFCCS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jun 2019 22:18:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38786 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFCCS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jun 2019 22:18:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so6357035plb.5
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2019 19:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/7iBPtQZzLxgPL56MasB5FK8dS1pUDHi1k1WFOdlpQ0=;
        b=Zm5HIycCv5R3MblFT/tG296U41p/ks8TumGra6QPWNLK8y/b0bwIfeeMCIQJzO4NL7
         kL8ioRhqk2vk5WWgwcTl1t8bdAdL0ZEfGGeN7Rc3dtkMEj3Uujqmm55Z529ELne5ZbX/
         jcViWVnZWBYbmFFdR9wK2YwU5hE+TYCawIcjWV9DkMKAOUwrFUQpyHIYPRNVhYMtV3pt
         q9N1InNGY9ngcyj87ITjcp0L1OL8I0Gt91pPuP+YF0uq4jvWqWrmTSPWNb9VXt20Hi05
         4FV5IwyK4a/Q4ZCJ2oVdPc5sqRPZyp8F6GeOKYIJlJ4z0y3GOH9QJkrFr5FUNF8beuxv
         T41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/7iBPtQZzLxgPL56MasB5FK8dS1pUDHi1k1WFOdlpQ0=;
        b=Pz5e68GXWfEhXpc6IEASOjUOCTsZrVjGxpJor97FolizVV0HIFgMA65bYKH22p4NzS
         58aaiuhCCngRbhha1j5bupz4L/Uoge+xoN6PnYRSYjrdGETpW1l415+fQi1wslFXfFqd
         y7xtbgtfEKaAuFUrRo20v1w7m4z7aZFccSUM/phUic4fi/ijcNWy2YXLjmnm6VFQn5b+
         TFApoQnbA8nXFitXXCdglGTlB7ZhztEEfsRrKr+2r2Drs7zNJ1u/Hk/LM7jYal587+Lt
         0KI+BYWBvwXjDuATq3C1MyocxfXPd994R2YrJxCZ0xdF6gn0MgVqfnFyyUwa9A6sPUyz
         +Z1g==
X-Gm-Message-State: APjAAAV8cej2uR55Mrb95I9TCODoy7GQ9GLoebTcQ6gxy04nNbc9GlG/
        TD9Fh9fzPGOK5ECDuMK0DvKkDQjK
X-Google-Smtp-Source: APXvYqwqQVFWad10LAUryg+VR9P/9Mw2P1+On+08nDK+xL5u5XJ7zkRmGXS/v2hg5039B48koxxJUw==
X-Received: by 2002:a17:902:e311:: with SMTP id cg17mr27016256plb.202.1559528308235;
        Sun, 02 Jun 2019 19:18:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id j64sm29489394pfb.126.2019.06.02.19.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 19:18:27 -0700 (PDT)
Date:   Sun, 2 Jun 2019 19:18:23 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
Message-ID: <20190603021821.GA8354@localhost.localdomain>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
 <20190524023520.GC1936@localhost.localdomain>
 <CAC5umyhCHJrzSSEy3NF38BhRQ9FSjVr8YfjChN-_3pVR5QwXsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyhCHJrzSSEy3NF38BhRQ9FSjVr8YfjChN-_3pVR5QwXsA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 24, 2019 at 10:57:36PM +0900, Akinobu Mita wrote:
> 2019年5月24日(金) 11:35 Eduardo Valentin <edubezval@gmail.com>:
> >
> > Hello Mita,
> >
> > On Wed, May 22, 2019 at 01:04:07AM +0900, Akinobu Mita wrote:
> > > The NVMe controller reports up to nine temperature values in the SMART /
> > > Health log page (the composite temperature and temperature sensor 1 through
> > > temperature sensor 8).
> >
> > Is this a fixed number or we should be more flexible on the amount of
> > sensors?
> 
> Max number is fixed.  In NVMe spec revision 1.3, a controller reports up
> to nine temperature values in the SMART / Health information log.
> 
> It may change to more than nine in the future, but we can fix then.
> 
> > > The temperature threshold feature (Feature Identifier 04h) configures the
> > > asynchronous event request command to complete when the temperature is
> > > crossed its corresponding temperature threshold.
> > >
> > > This adds infrastructure to provide these temperatures and thresholds via
> > > thermal zone devices.
> > >
> > > The nvme_thermal_zones_register() creates up to nine thermal zone devices
> > > for all implemented temperature sensors including the composite
> > > temperature.
> >
> > great!
> >
> > >
> > > /sys/class/thermal/thermal_zone[0-*]:
> > >     |---temp: Temperature
> > >     |---trip_point_0_temp: Over temperature threshold
> > >
> > > The thermal_zone[0-*] contains a symlink to the corresponding nvme device.
> > > On the other hand, the following symlinks to the thermal zone devices are
> > > created in the nvme device sysfs directory.
> > >
> > > - nvme_temp0: Composite temperature
> > > - nvme_temp1: Temperature sensor 1
> > > ...
> > > - nvme_temp8: Temperature sensor 8
> > >
> > > The nvme_thermal_zones_unregister() removes the registered thermal zone
> > > devices and symlinks.
> > >
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Cc: Jens Axboe <axboe@fb.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Sagi Grimberg <sagi@grimberg.me>
> > > Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> > > Cc: Kenneth Heitke <kenneth.heitke@intel.com>
> > > Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> > > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > > ---
> > > * v2
> > > - s/correspoinding/corresponding/ typo in commit log
> > > - Borrowed nvme_get_features() from Keith's patch
> > > - Temperature threshold notification is splitted into another patch
> > > - Change the data type of 'sensor' to unsigned
> > > - Add BUILD_BUG_ON for the array size of tzdev member in nvme_ctrl
> > > - Add WARN_ON_ONCE for paranoid checks
> > > - Fix off-by-one error in nvme_get_temp
> > > - Validate 'sensor' where the value is actually used
> > > - Define and utilize two enums related to the temperature threshold feature
> > > - Remove hysteresis value for this trip point and don't utilize the under
> > >   temperature threshold
> > > - Print error message for thermal_zone_device_register() failure
> > > - Add function comments for nvme_thermal_zones_{,un}register
> > > - Suppress non-fatal errors from nvme_thermal_zones_register()
> > > - Add comment about implemented temperature sensors
> > > - Instead of creating a new 'thermal_work', append async smart event's
> > >   action to the existing async_event_work
> > > - Add comment for tzdev member in nvme_ctrl
> > >
> > >  drivers/nvme/host/core.c | 265 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/nvme/host/nvme.h |  27 +++++
> > >  include/linux/nvme.h     |   5 +
> > >  3 files changed, 297 insertions(+)
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index c04df80..0ec303c 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -2179,6 +2179,271 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
> > >       }
> > >  }
> > >
> > > +#ifdef CONFIG_THERMAL
> > > +
> > > +static int nvme_get_temp(struct nvme_ctrl *ctrl, unsigned int sensor, int *temp)
> > > +{
> > > +     struct nvme_smart_log *log;
> > > +     int ret;
> > > +
> > > +     BUILD_BUG_ON(ARRAY_SIZE(log->temp_sensor) + 1 !=
> > > +                  ARRAY_SIZE(ctrl->tzdev));
> >
> > When would this be triggered?
> 
> This just ensures that the temperature fields for the SMART log page
> structure and nvme_ctrl are not changed accidentally.
> 

Ok.

> > > +
> > > +     if (WARN_ON_ONCE(sensor > ARRAY_SIZE(log->temp_sensor)))
> > > +             return -EINVAL;
> > > +
> > > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
> >
> > Do we really need to allocate memory every time we want to read
> > temperature? Is this struct too large to fit stack?
> 
> I think 512 bytes is too large in the kernel stack
> 

I see


<cut> 

> > > +
> >
> > Do we have something more meaningful or descriptive here? A more
> > interesting type would be a string that could remind of the sensor
> > location. Unless nvme_temp0 is enough to understand where this
> > temperature is coming from, I would ask to get something more
> > descriptive.
> 
> The SMART log page defines composite temperature and temperature sensor 1
> through temperature sensor 8.  So I think nvme_temp1 to nvme_temp8 are
> descriptive.  And I personally prefer 'nvme_temp0' rather than
> 'nvme_composite_temp'.

I was leaning towards something even more descriptive. nvme_temp0 means
what? Usually we want something more meaningful, Is this a co-processor?
Is this a disk? what exactly nvme_temp0 really represents?


> 
> BTW, if we have more than two controllers, we'll have same type names
> in the system.  So I'm going to append instance number after 'nvme'.
> (e.g. nvme0_temp0).
> 
> > > +     tzdev = thermal_zone_device_register(type, 1, 1, ctrl, &nvme_tz_ops,
> > > +                                          &nvme_tz_params, 0, 0);
> >
> > Have you considered if there is a use case for using of-thermal here?
> 
> Is it possible to specify the device node properties for the pci devices?
> If so, of-thermal zone devices are very useful.
> 

Yeah, I guess that would depend on the PCI device node descriptor that
the sensor is going to be embedded, not of-thermal. But I would expect
that DT has already a good enough DT descriptors for PCI devices, can
you check that?

> I think normal thermal zone devices and of-thermal zone devices can
> co-exist. (i.e. add 'tzdev_of[9]' in nvme_ctrl and the operations are
> almost same with the normal one)

Right, that is usually the case for drivers that have a real need to
support both. Most of the drivers from embedded systems would prefer
to keep only DT probing. But if you have a use case to support non-DT
probing, yes, your driver would need to support both ways.
