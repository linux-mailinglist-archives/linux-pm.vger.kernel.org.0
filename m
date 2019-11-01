Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221BCEC8EC
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 20:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKATOa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 15:14:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32784 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKATOa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:14:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id u23so7071214pgo.0;
        Fri, 01 Nov 2019 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dxValgYvhHxSnFI6gnr2oyO17cKwpSxzLNQyRqzKdCA=;
        b=EqTJjvNGDW7WZvYDnkDxvcome8PseIkxEJcxdi4JjfhktZRFgIdkmiajPLB44gOEyO
         /AyQh/VB3aSYZswNeWPhcY1/py5PEXv6IofpKS8fZA0id8M2Je4YWQWX90+cnTFeMq2q
         1GUtlZDx5IV5tNcrZpbtRwSbAZpaeJXP23gOz6ZGboEThQDs4QHPpzSz4KCCJOdZTjrH
         3+7fWkUIt5MEC6SpzEKZhjZgQAjENCFj9objO7DLhCc0r9yEFcB3RyBNTe2OJ7fDbUUP
         L/sCD2sjz/rMHxmxPX3e+hWUnftnU4amq9n0keWLp/KErtvtgpDwXaDEPp2uQwZ7vwJA
         c8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dxValgYvhHxSnFI6gnr2oyO17cKwpSxzLNQyRqzKdCA=;
        b=B/N4AIXHTohTLUEisVkdvDZFX4RJUmo+91QF9tTsDaWV8o10IZgtk5SdaCMJ2ra0E7
         q9QK55FaUNclf+3wKyj+9Sve8eyqBxRE4volsfJJFe+kf5GmzjJFpBZ3fArHFJJpZ7Ny
         5sx07s0X4BXBdGzrU2qzJlHv3EfdH0hWQkKAx4l0SVpRiQVoEk/fkyp8JX2dmfULgBNU
         p9QL4OrIPNooWD3SI3ShPESISckGjYJ3+Si6Brde8uTQy5kiXgi4cTvYajNOMvvnw/7l
         bRVOuGHftQDx4j5vogH7GdLhQZC3cTr3fAzZTrxSsWnak1JIU0Q/ZJQkrfV17LXBQR+U
         3sXQ==
X-Gm-Message-State: APjAAAUaOYk9G3ZpmKF5paLKB5XE5mAX2kRL/Rr/rkdns0mzOXXtoewX
        tMgAq/QsD0iMG3JGUcHgwuk=
X-Google-Smtp-Source: APXvYqzUe+fumh35OZfggMheJb3fdt8kBltkY6Q1u9Qw+Ozs70zXlYY4A97YV/+K1EIrFyWe0LbEIw==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr14514939pgj.86.1572635668072;
        Fri, 01 Nov 2019 12:14:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18sm6722086pff.95.2019.11.01.12.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 12:14:26 -0700 (PDT)
Date:   Fri, 1 Nov 2019 12:14:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] nvme: Add hardware monitoring support
Message-ID: <20191101191425.GA16792@roeck-us.net>
References: <20191101035646.25644-1-linux@roeck-us.net>
 <CAC5umyhiOiAiYWs2Y=L5133CCQNnAgi8oq6AbGzgkznZKz5f-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyhiOiAiYWs2Y=L5133CCQNnAgi8oq6AbGzgkznZKz5f-w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 02, 2019 at 01:19:03AM +0900, Akinobu Mita wrote:
> 2019年11月1日(金) 12:56 Guenter Roeck <linux@roeck-us.net>:
> > +void nvme_hwmon_init(struct nvme_ctrl *ctrl)
> > +{
> > +       struct device *dev = ctrl->device;
> 
> Should we use 'ctrl->dev' instead of 'ctrl->device'?
> 

Excellent point, and most definitely yes. I should have done that
from the beginning.

> The 'ctrl->device' is a pointer to char device and the '->of_node' member
> is NULL.
> 
> So if devm_hwmon_device_register_with_info() (i.e. __hwmon_device_register)
> is called with 'ctrl->device', it doesn't attempt to register a sensor to a
> DT thermal zone (i.e. hwmon_thermal_add_sensor() is not called at all).
> 
> This change was required, when I tried this nvme hwmon patch with the
> following DT thermal setup.
> 
> https://lore.kernel.org/linux-devicetree/1561990354-4084-3-git-send-email-akinobu.mita@gmail.com/
> 
> > +       struct nvme_hwmon_data *data;
> > +       struct device *hwmon;
> > +       int err;
> > +
> > +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return;
> > +
> > +       data->ctrl = ctrl;
> > +       mutex_init(&data->read_lock);
> > +
> > +       err = nvme_hwmon_get_smart_log(data);
> > +       if (err) {
> > +               dev_warn(dev, "Failed to read smart log (error %d)\n", err);
> > +               devm_kfree(dev, data);
> > +               return;
> > +       }
> > +
> > +       hwmon = devm_hwmon_device_register_with_info(dev, dev_name(dev), data,
> > +                                                    &nvme_hwmon_chip_info,
> > +                                                    NULL);
> 
> If the above change is applied, the second 'name' argument is changed
> from 'nvme0' to '0000:01:00.0' as a side effect.  So we may want to
> change the second argument, too.
> 

Yes. I'll just name it "nvme"; after all, that is sufficient and more
consistent with other drivers. Currently, we get something like
	nvme0-pci-0100
	nvme1-pci-2500
if there are multiple drives, where the "0" and "1" are not really
necessary.

Thanks!
Guenter
