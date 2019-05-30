Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2A2FA1F
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 12:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfE3KTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 06:19:01 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39330 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfE3KTB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 06:19:01 -0400
Received: by mail-pf1-f169.google.com with SMTP id j2so3669919pfe.6
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2019 03:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=isnHQue4wDfjkgN1icuOvHpdVu+ZzR4rZ4E0G5lIGZc=;
        b=ka1gHhxkUFMd+H3+BsyYzGR9RvMPpF/VK9suOcolLYVbG+Ylp0PPuOpm3vfICp50pz
         +Xr7JIOWsqnk05cZoSRLxNin1WoVvOJW/eX7ENf2eRaVLC6Qh85wbRunvarzktlw/t+N
         5lApvy3e1O3BFkZoiY5YyQAt7llQjTM4k8yYcyI3NHVPpUxTGW88I+Q3R0zi13FtP51f
         gY+S/DqWzbFDVPD+YDNnd2DoZQ0eOy6aWh2tZNKoxSN/ZTjdhnKMLZxkKjAe1AWGjsUj
         bDg6beR7WexFTbOS6xLkybPSOgW/Yuo+gyqjhoci0VZo2RJTcRwdjBEU6iRwmwUUZi70
         cJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=isnHQue4wDfjkgN1icuOvHpdVu+ZzR4rZ4E0G5lIGZc=;
        b=euP25KipwKd7PWIa76LAKRYACbBpm369GM0ybgbw2IjB5B3CQAC4bUSRP70h8bB6B3
         1CNjxl35YEGgYBEkK0VOBz26JGUYctUhdYAqGUwWysoiQQXqsVO/D6rbv2u+uFx8+StT
         tp6//ksl9/BWPbcyxBeaG+Dq3HcYsF9uSwTB7hsr5DbxDzbBsIDU+HWsLwl4BESxcQOY
         GP7R3Yf0cfNFqDq6LGdQucj0kWBHTgTbSMbFpKIC4iLm6NNnhi8xOqS9VBWcGmCGFGVS
         VianEwEc3paqDwR0t7idkkl4vBHxEdXwv53mThami//VYgz0rrKUOskpq9eQeqm5CKiu
         kcRA==
X-Gm-Message-State: APjAAAWoz6OII9B4TzgKu073XYHkpbzJVuQ+mehpUZbbwRDV+YyDvogw
        6TTRiPy06Gc7duc/PV7IOkM=
X-Google-Smtp-Source: APXvYqxIXc7xaf6ZkiLraES79OyQ89J+WysEmlNVpSCXVvzlc/G7eS9vIHSNQkX9xa4nvsZ0oveigw==
X-Received: by 2002:a63:dc09:: with SMTP id s9mr3067965pgg.425.1559211539871;
        Thu, 30 May 2019 03:18:59 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id h11sm2393308pfn.170.2019.05.30.03.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 03:18:59 -0700 (PDT)
Date:   Thu, 30 May 2019 19:18:56 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 2/3] nvme: add thermal zone devices
Message-ID: <20190530101854.GA8843@minwooim-desktop>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
 <20190529151517.GC28274@minwooim-desktop>
 <CAC5umyhusw+sQOn5H7ZMP=aVi00GY7R_Jff6447R=yXyUpjFoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyhusw+sQOn5H7ZMP=aVi00GY7R_Jff6447R=yXyUpjFoQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-05-30 01:47:08, Akinobu Mita wrote:
> 2019年5月30日(木) 0:15 Minwoo Im <minwoo.im.dev@gmail.com>:
> >
> > > +/**
> > > + * nvme_thermal_zones_register() - register nvme thermal zone devices
> > > + * @ctrl: controller instance
> > > + *
> > > + * This function creates up to nine thermal zone devices for all implemented
> > > + * temperature sensors including the composite temperature.
> > > + * Each thermal zone device provides a single trip point temperature that is
> > > + * associated with an over temperature threshold.
> > > + */
> > > +static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > +{
> > > +     struct nvme_smart_log *log;
> > > +     int ret;
> > > +     int i;
> > > +
> > > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
> > > +     if (!log)
> > > +             return 0; /* non-fatal error */
> >
> > Do we need to print something like warning here? If kzalloc() fails, it
> > would be good to be distinguished between the nvme failure and internal
> > failure like this.
> 
> We usually remove the error message on kmalloc failure because it's
> redundant as long as we don't set __GFP_NOWARN.

I see what you point.

> 
> > > +
> > > +     ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > +                        log, sizeof(*log), 0);
> > > +     if (ret) {
> > > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> > > +             /* If the device provided a response, then it's non-fatal */
> > > +             if (ret > 0)
> > > +                     ret = 0;
> >
> > It seems like that nvme_init_identify() is just check the internal error
> > which is in negative value now as you have posted.  Why don't we just
> > return the value of "ret" itself without updating it to 0 ?
> 
> Both ways work for me.
> 
> I personally prefer not to return (leak) the nvme status code from
> foo_register() function.

Okay.  In the perspective of registration, the nvme status might not be
needed to be returned.  But I think if we return the nvme status here,
it would be great for the later time when we need to figure out if the nvme
command has failed or not.

But, amyway, I'm fine with this :)

Thanks for your comment on this trivial query.

> 
> > > +             goto free_log;
> > > +     }
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > > +             struct thermal_zone_device *tzdev;
> > > +             int temp;
> > > +
> > > +             if (i)
> > > +                     temp = le16_to_cpu(log->temp_sensor[i - 1]);
> > > +             else
> > > +                     temp = get_unaligned_le16(log->temperature);
> > > +
> > > +             /*
> > > +              * All implemented temperature sensors report a non-zero value
> > > +              * in temperature sensor fields in the smart log page.
> > > +              */
> > > +             if (!temp)
> > > +                     continue;
> > > +             if (ctrl->tzdev[i])
> > > +                     continue;
> > > +
> > > +             tzdev = nvme_thermal_zone_register(ctrl, i);
> > > +             if (!IS_ERR(tzdev))
> > > +                     ctrl->tzdev[i] = tzdev;
> > > +     }
> > > +
> > > +free_log:
> > > +     kfree(log);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +/**
> > > + * nvme_thermal_zones_unregister() - unregister nvme thermal zone devices
> > > + * @ctrl: controller instance
> > > + *
> > > + * This function removes the registered thermal zone devices and symlinks.
> > > + */
> > > +static void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> > > +{
> > > +     int i;
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > > +             struct thermal_zone_device *tzdev = ctrl->tzdev[i];
> > > +             char name[20];
> >
> > Simple query here :)
> >
> > If we are not going to allow the name of link exceed the length of its
> > own device name like nvmeX_tempY, then can we THERMAL_NAME_LENGTH macro
> > here?  If the name of link is not exactly about the device name itself,
> > then it's fine.  What do you think about it ?
> 
> Of course we can use THERMAL_NAME_LENGTH here.  But this char array is
> used only for the symbolic link name.
> It's not used for thermal cooling device type, thermal zone device type,
> or thermal governor name.  So I just used a random constant to avoid
> confusion.

Agreed.
