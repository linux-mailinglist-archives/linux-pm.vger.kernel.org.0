Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6152674D
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfEVPw0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 11:52:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35945 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfEVPw0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 11:52:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so1285777plr.3
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y0uEsZx9NaTIzCiY5FZ9eD9lISDd+g2yLSUq+hTXz2I=;
        b=AYZidYbcLV5l28nykvM2qtlyRUOIL5PLa5TM/0dyKvoDbwcJf3bUEXmWsiuQT6RXTN
         K/pAEldd1BEAEND9y02qHsWfEZCNVvDj6MX4MUBgXZx5yJbGBu6lJq8OBWCewLfOMRHz
         4oAFVec/Nj/7/MqEwOUBwW/sRdTMO0bOkudyNtQ8vPlc3Nvt5jpu7pdUu5V0cwyNYtL0
         kRaIy3qFuOoSrT9dOPB/iA7+VxdqQ0eyZTCyTJvdS0ydTVfUebnS4dTsN2TjZiAyV4v5
         FbDNjUXtVvAiVvXuLihOZQuEXvhoRss7dtn/WAjEN25CXM7sRHH7S3WdxNb3LD0q4F5O
         mErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y0uEsZx9NaTIzCiY5FZ9eD9lISDd+g2yLSUq+hTXz2I=;
        b=OOKd07RCThdjjW/NJvdkweIsVpluk7PFAlDugQbDU6nx656SEYbuhKcNfNqlXaUrNz
         iNYCKPyU3LVQK+lUhibdJuUMbw6JCRKG9kmO9Q9OSoE0pGO+reJc+3y32021k5wOna0Y
         wM+QEJCSFy6l1jZDm1hMtyelL4yG/FkWZ8bCoijcliUpPq+xWrFWRnLwc7BRz2mxq1i6
         vRE9FsUtNAvjNJf8fXwuRknK5Dq6TymsXYNcwA0akty1BKZrxtLeSIAm0/0hilGTK0ki
         /HpDOywePVuj519pK9FUmkxWXj0PHWE6hImHjRl+xMSSkt0Ne9ftMXDiqaJMxF00T0KL
         Oq2A==
X-Gm-Message-State: APjAAAUi030otjwYGrq48R1R/3c1w6q7P3rLXC3OAZFtEv5njkAfDhn5
        kROROG8Um4JsW5rkYlzVpmyIkb+Xd1lPKcQiozQ=
X-Google-Smtp-Source: APXvYqyeyL8L6vGcyaHKU7LggySZBfZlhj8SmMd8pL5wcHys+zNFTKbX8JdpUjQwtPnW+LopB9s7CTxtVZHkAeu8TZc=
X-Received: by 2002:a17:902:7283:: with SMTP id d3mr46975846pll.274.1558540345349;
 Wed, 22 May 2019 08:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
 <20190521161532.GD1639@localhost.localdomain> <CAC5umyi4t-r+0WbGjfa=_6ym_n=vcx5855nwL6NxuXH_HhYXkA@mail.gmail.com>
 <20190522154448.GA5393@localhost.localdomain>
In-Reply-To: <20190522154448.GA5393@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 23 May 2019 00:52:14 +0900
Message-ID: <CAC5umyhhO61hjm4vO++YpL8JgcyT05VfDpTpLZx0fQywvd7_kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8823=E6=97=A5(=E6=9C=A8) 0:49 Keith Busch <kbusch@kern=
el.org>:
>
> On Thu, May 23, 2019 at 12:44:04AM +0900, Akinobu Mita wrote:
> > 2019=E5=B9=B45=E6=9C=8822=E6=97=A5(=E6=B0=B4) 1:20 Keith Busch <kbusch@=
kernel.org>:
> > >
> > > On Wed, May 22, 2019 at 01:04:07AM +0900, Akinobu Mita wrote:
> > > > +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > > +{
> > > > +     struct nvme_smart_log *log;
> > > > +     int ret;
> > > > +     int i;
> > > > +
> > > > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
> > > > +     if (!log)
> > > > +             return 0; /* non-fatal error */
> > > > +
> > > > +     ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > > +                        log, sizeof(*log), 0);
> > > > +     if (ret) {
> > > > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n"=
, ret);
> > > > +             ret =3D ret > 0 ? -EINVAL : ret;
> > >
> > > A ret > 0 means the device provided a response, so don't return a
> > > negative for that condition, please. That's just going to break
> > > controllers that don't provide smart data, like qemu.
> >
> > After looking at __nvme_submit_sync_cmd(), it returns -EINTR if the dev=
ice
> > doesn't respond.  So, should this return a negative only when nvme_get_=
log()
> > returns -EINTR?
> >
> >         ret =3D nvme_get_log();
> >         if (ret) {
> >                 dev_err(...);
> >                 if (ret !=3D -EINTR)
> >                         ret =3D 0;
> >                 goto free_log;
> >         }
>
> We return a different negative error if we can't allocate a request,
> like what happens if the controller is dead, like a surprise hot remove.
>
> There's a simpler way to look at this: if ret >=3D 0, we may proceed,
> otherwise we're done with this controller. Don't make it any more
> complicated than that.

OK.  Sounds good.
