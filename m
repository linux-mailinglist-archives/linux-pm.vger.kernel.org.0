Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2320D52
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEPQsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 12:48:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38704 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfEPQsS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 12:48:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so1844677pgl.5
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xGzOdEjbkXQI4XN5U9fk3ggStqgmR5/EE4ixhly3O2A=;
        b=Bu0Qn4kktWsD3rAV1GUd3JeYgoHJy5Xy55l8u9PsPgiqlneSxFPvzvxLfoLgM89pOW
         1n1Y8ArrxGdys3wg+GHraGMinlicbCuIIFmc3NDk187p7cjfJXyq7Yzy+6kAGsvGTLCC
         D+Ny8OPi8JMucEPU+wI1awvKVfL4KXzEmoziGasIyMtoEKkTMPuHGvqSfD3a/i9Cm3g5
         heZZSZf+vEB7Il04F16l3g2xTH+tgo0hFrZj01evzTu+QvHeRWZJtIKwmgkMfwEsBjha
         H0s2ChNcFMT2IBTDaSxuyyi/YbPFAPtlxvjRPsSIXA+BbELDk3aylFHO3L/9uYnLQQG/
         hCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xGzOdEjbkXQI4XN5U9fk3ggStqgmR5/EE4ixhly3O2A=;
        b=QtA47d1Kn4Rihsgt5QN5SJQ7TgcEbxVNHU4wqiGIgm1wKTXRvF0dJPxFweiuMcGpZ/
         uDa/RaqnyQmPS0AZOIgpbu0vHYF7bbFoF8A3RiiFxZc+xGyigP87iIsPge5SKxhrhdll
         zYy1dCqtvMkA0BZHxYUJ6cmyB6YamRs51yx1rr385edgyRXBB2o7sCUNGzMZ6wI0N2Yl
         PvbmDZ+VTc08kFnLLPA162hPG4Rl0FFQQQlJkS1W6eWBAZ53rQboM54yvSGkJuazEAWC
         M/IOzIg3RKuVa/Kk3+Q6dWgciHEV2p6vy/jhIhi6W3wTkOytI9/yEDy6UtB+U7EAMD6I
         QSrA==
X-Gm-Message-State: APjAAAUr5b3QYwFigEddxxItDntSKA+VI3TNJz9Gw5MJvQOvkru/xmZc
        qNzOMxMNpPstvf+GZWPEUZYfL/Ez3Fs=
X-Google-Smtp-Source: APXvYqzil0ehZc90CSqN+2Pmtn8vNBmPO90h4w8n8jHTQZYQTOuEdi+W+6QpL8RYioHUuG01uoCPiA==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr50918024pgo.335.1558025297166;
        Thu, 16 May 2019 09:48:17 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id q193sm9884262pfc.52.2019.05.16.09.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:48:16 -0700 (PDT)
Date:   Fri, 17 May 2019 01:48:13 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
Message-ID: <20190516164811.GF24001@minwooim-desktop>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
 <20190516143212.GE24001@minwooim-desktop>
 <CAC5umyjxxWzCgyMOS=Q7BBBJY+n6xD1dg49fQ0W5okPh58Z1Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyjxxWzCgyMOS=Q7BBBJY+n6xD1dg49fQ0W5okPh58Z1Kw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-05-17 01:17:31, Akinobu Mita wrote:
> 2019年5月16日(木) 23:32 Minwoo Im <minwoo.im.dev@gmail.com>:
> >
> > > +     if (sensor < 0 || sensor > 8)
> > > +             return -EINVAL;
> >
> > Does we really need to check the negative case here ?  Am I missing
> > something in this context ?  If we really want to check it in this
> > level, can we check the invalid case in the following function?
> 
> The negative case should never happen, so it can be just removed.

Cool.

> 
> > > +static struct thermal_zone_device *
> > > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, int sensor)
> > > +{
> > > +     struct thermal_zone_device *tzdev;
> > > +     char type[THERMAL_NAME_LENGTH];
> > > +     int ret;
> > > +
> > > +     snprintf(type, sizeof(type), "nvme_temp%d", sensor);
> >
> > Before preparing "nvme_temp%d", maybe we can make it sure here. :)
> > What do you say?
> 
> The nvme_thermal_zone_register() is only called from
> nvme_thermal_zones_register() which is defined just below, and it's very
> clear that the value of 'sensor' is from 0 to ARRAY_SIZE(ctrl->tzdev) - 1.

If so, we don't need to check the negative case above there.

> 
> > > +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > +{
> > > +     struct nvme_smart_log *log;
> > > +     int ret;
> > > +     int i;
> > > +
> > > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
> > > +     if (!log)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > +                        log, sizeof(*log), 0);
> > > +     if (ret) {
> > > +             ret = ret > 0 ? -EINVAL : ret;
> > > +             goto free_log;
> > > +     }
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > > +             struct thermal_zone_device *tzdev;
> > > +
> > > +             if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
> > > +                     continue;
> > > +             if (ctrl->tzdev[i])
> > > +                     continue;
> > > +
> > > +             tzdev = nvme_thermal_zone_register(ctrl, i);
> > > +             if (!IS_ERR(tzdev))
> > > +                     ctrl->tzdev[i] = tzdev;
> >
> > Quenstion here. Are we okay not to print some warnings here in case
> > of error returned?
> 
> I'm going to print warning in case of thermal_zone_device_register() error.
> For sysfs_create_link() error, the warning is printed by the function
> itself.

Sounds great.

Thanks,
