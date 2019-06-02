Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93903235C
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2019 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFBNTU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jun 2019 09:19:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41799 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBNTU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jun 2019 09:19:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so8999584pfq.8
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2019 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0NcDVhmyLxXPhirMBnL/FRprQusnUULjnBfsPdj8Hiw=;
        b=aKQ8JMV8ILuLR2NdUrv0x+VoeRWJ/8Y5T0VrTNkEuDxfeVeFSsEAjyMSRYzdnTKUFB
         2PP901PNB4/g9Tbd5Fc86ksUbXinc/lMNrLpnih3WVgyqo9wLDKdxSkb/evZTnFuu9JM
         8+O8u4PKNsj7nuijDf4N8F48BGpOz5UWymihYMft7VQMlfZs0V9GNnlqOP7lS/V6mO6E
         gTxomGZXMbifSyejUINwi/LzOyg+jVVNWYDVA3bbL4K6iZzJZQdVgZlkQuE6EEANXhhw
         g+0t3tjp1X2M8CI/K4VVS1ez0Sijq1L3TjtMQTEEJML07o2bahZXeeJ559VvYYzlkVb/
         g3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0NcDVhmyLxXPhirMBnL/FRprQusnUULjnBfsPdj8Hiw=;
        b=FbdVSad4xPK/kh1R3DVz5sSp7ftWPLNObQ+950oT0gjQY6OCcOSuE6zritr2iAt1dY
         3h4mQuBACUQW17jZ+QwdNTy+ORz+Yy12GW7k2SK5iK7Smwzl0+hPQ0W50jjuay+vnqop
         /mYl0cTS024CRdZJcmD+jL5rTPYub2pr0rqE5nO2X+ukOFHLXyiHlpC3jg0DyiTPmlV0
         H29bLBp276K+MMdJs5WHZnbKVaHriql97iVfeyKZJQ3nIaTG6N3/5B8FJorzi6wbICYj
         5KK6eU2Bz8uiFBI4JAwvLk/DUSe9M14I2uxt2J3ATXFpeP1omAdtSoRKM2J2f6UmzAaa
         e3AA==
X-Gm-Message-State: APjAAAUnzVDq1vODFzHTr4yIDl9soq51UbQ6/38eku/KNgVaz/zT+0LD
        0hTawHWsOw4ModcdP4PI8bNiyVq1WDYhmsyROXM=
X-Google-Smtp-Source: APXvYqxQZklDdC7pDexcyGQHSlARf1CB5VfxXCV0PWJLeh+lLdSFyLR7tEaN5o6oGkCQsUq9DAdl4fyB9wm2ud571Go=
X-Received: by 2002:a63:110c:: with SMTP id g12mr21293135pgl.18.1559481559894;
 Sun, 02 Jun 2019 06:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com> <20190601090238.GD6453@lst.de>
In-Reply-To: <20190601090238.GD6453@lst.de>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sun, 2 Jun 2019 22:19:08 +0900
Message-ID: <CAC5umyiBmD6-3BNLfG7sNOe9jde8Ct16a9N_Ao3T_1_G1K_DDA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] nvme: add thermal zone devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B46=E6=9C=881=E6=97=A5(=E5=9C=9F) 18:03 Christoph Hellwig <hch@l=
st.de>:
>
> On Mon, May 27, 2019 at 01:29:02AM +0900, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the SMART =
/
> > Health log page (the composite temperature and temperature sensor 1 thr=
ough
> > temperature sensor 8).
> >
> > This provides these temperatures via thermal zone devices.
>
> Can you explain a bit more why we'd do this?  I shows up some sysfs
> files, but we could easily do that with nvme-cli, too.  Is there some
> greater benefit of this integration?

As long as the user space thermal governor is used, there is nothing more
than that from a functional perspective.  And I suppose that this is used
with user_space governor (i.e. there is still some work to be able to bind
actual thermal cooling device).

The main purpose of this is to turn on a fan when overheated without
polling the device that could prevent the lower power state transitions.
But as you noted, we could do that with the existing AEN notifications
through uevent.

So frankly speaking, the benefit of this is providing generic thermal sysfs
interface and the tools like tmon (linux/tools/thermal/tmon) can show the
nvme temperatures.
