Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDCF21B7
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 23:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKFWau (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 17:30:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40415 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfKFWau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 17:30:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id e3so10045639plt.7;
        Wed, 06 Nov 2019 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mPlyd2uOwDFOJHnR0FcKb5obhlxfQ+BfqyeB8GcPgsM=;
        b=ipYgt89j3kpMg5qiTffNN6LdEoQP3g88e4XH3OUIaj0Z1pwFVRdoVoPrav7ormtT6e
         Yf6Zlqm0O6Cu2dz1Jgu7MzZ6i7vvuOMrZlc+520c0B5WoTg1vngQsV9E8VQ5/y8FEPAf
         sZs+isfCarOcx8lO2M2uDUS5piSvkSVBJ+Fsm5JnyE4Bn1FWsFBLumzdq3eFlOmqY1hS
         UblmrDi/CJE/00/cMNHcjqsxiKXlTRKCaf2phgBK+xzt3Lo3A7IofRysuc854zYiHqal
         epMUIgkSu5EO5pgC/oalwJLC4H+zrJoRTTZBRlpOnKIyvDs6Deyr00nN4xehlV4PpMNH
         Qr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mPlyd2uOwDFOJHnR0FcKb5obhlxfQ+BfqyeB8GcPgsM=;
        b=KJDQg7M7FjrZODb6HWiJ6l4tOZ6FsYieEKMeC//y2eb1OrdqY892XR8GgEYV28YITo
         phqsvZMvkAgqEFjKyvrP2YBZ4ua6kpD/BA1PlvYqxlj92gouvA+d+Xjc03bfM5TJK3d+
         Xi5qSV8U4+G5jDsrCWYNiDCCrIYGDLq/Q2niCU94RjKeQRNJLufF39tSrvsyWrTPvDGh
         6hJPgqa0HHN1siBFPbocKO14MPrWcRRBGyt+5uioN8diCMXrPMXlVOf7EXNlWObvwoDo
         C9oyaswLfMObIyDV+MiJ/2MVy2SY1YygSZXMDT2oV8/nonvjmBGmMlCMz92mi+Lir4A1
         t7Hw==
X-Gm-Message-State: APjAAAW2P3KOysytZXojhrHUJLnI9+NQv1JnualAhDPJnKrPyrwKE7u1
        NLKkLBvmOct7eOHM/+pCMdE=
X-Google-Smtp-Source: APXvYqz/nEBTHz99NrVlIxam5Ibb6hcu+7t9BxFhU/n7xTbsGLzwL4ZkdOXjp/g2h9VT2OgKYIofkA==
X-Received: by 2002:a17:902:860a:: with SMTP id f10mr5228913plo.233.1573079449371;
        Wed, 06 Nov 2019 14:30:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o7sm8717360pjo.7.2019.11.06.14.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 14:30:48 -0800 (PST)
Date:   Wed, 6 Nov 2019 14:30:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191106223046.GA19493@roeck-us.net>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
 <20191106212921.GA7020@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106212921.GA7020@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 06, 2019 at 10:29:21PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > nvme devices report temperature information in the controller information
> > > (for limits) and in the smart log. Currently, the only means to retrieve
> > > this information is the nvme command line interface, which requires
> > > super-user privileges.
> > > 
> > > At the same time, it would be desirable to use NVME temperature information
> > > for thermal control.
> > > 
> > > This patch adds support to read NVME temperatures from the kernel using the
> > > hwmon API and adds temperature zones for NVME drives. The thermal subsystem
> > > can use this information to set thermal policies, and userspace can access
> > > it using libsensors and/or the "sensors" command.
> > > 
> > > Example output from the "sensors" command:
> > > 
> > > nvme0-pci-0100
> > > Adapter: PCI adapter
> > > Composite:    +39.0°C  (high = +85.0°C, crit = +85.0°C)
> > > Sensor 1:     +39.0°C
> > > Sensor 2:     +41.0°C
> > > 
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > This looks fine to me, but I'll wait a few more days to see if there are
> > any additional comments..
> 
> User wants to know temperature of /dev/sda... and we already have an
> userspace tools knowing about smart, etc...
> 
> pavel@amd:/data/film$ sudo hddtemp /dev/sda
> /dev/sda: ST1000LM014-1EJ164: 48°C
> 
> I see we also have sensors framework but it does _not_ handle
> harddrive temperatures.
> 
> Does it need some kind of unification? Should NVMe devices expose
> "SMART" information in the same way other SSDs do?
> 

The unification to report hardware monitoring information to userspace
is called the sensors framework. Also, users in general prefer to not
have to run "sudo" to get such information.

Guenter
