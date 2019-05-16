Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAD209AD
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEPOaW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 10:30:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34769 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPOaW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 10:30:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so1669112pgt.1
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F3WBfCSGQ1S3ZrQi1vnb+tms40ACrCS3PRWnR27giHQ=;
        b=cavoVWjIaqV5ouirIMGCShuXCwnx+MV6zz/TwIIsXu2SnKUvZBC6CpiS89z7USmoTZ
         pCQGNCupE7Ks3CiI0jn9NzF3Escj/nqBru1YAcj7oRLUIezVvlzYO2NxfAu3FfXSu0fa
         pz8UFDHcFj3Bfjp0LqkJyMI663jc0FhUTWZoTO0lJtR793mOLC3DOqaUAn6y4uI9OmXX
         i0BM2Ncx1zqDMkwdNEz8T/PuSBRQGiC1HNGbvQlWnGkWrDTySxvJe35I78y7pNd4JOQj
         CHz5wCIbciapYj7+c+ySg+ezZUvabZEkIgpWZV53hq/ka+JzSV6XWMm2693hhAzvByLi
         aTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F3WBfCSGQ1S3ZrQi1vnb+tms40ACrCS3PRWnR27giHQ=;
        b=sY/vtzqm50JKKaMOROa5hBCXC/toIbWp5M4rIjeyL0K0tQfsgimYIPHTOMWQMugYu/
         5SE/2Or9DVIL90wd6SGrdJxhsPajtim2mz7LWZg3gDhqQA8GP2iUn0L8iy6B+b/MZdFG
         gTou5b2/KvXDZ0WklfwYjSiM90XM/ru0pPa09hn1K+0qfqyRXXcWmqdqu9rREetz/NL1
         Sfcyq8qthnB4JkhEWRnBH2oWAYugBBazbQIH0wfBsDx5oj3mRKBWKIMG6NumpqKxZAXC
         KL6nK9PPG9aMt4Do1ruz8uxpBJMGugSF4VBYH9iTRy1QFRh3Nv8ePLveHnCffNb2DAm1
         avxw==
X-Gm-Message-State: APjAAAVW4EgnY3H7OSacz4R0sXFUJ4obzB2S6LZRSsa1zy1EEtkfMetR
        it2OtpbHyKg5TdMq8jvmAlyw27EP2EmWPM+hy/E=
X-Google-Smtp-Source: APXvYqyA3NGdQGXPE0C8VJRcA+O0oqHudMt1eEMQNr6iPXuk0bxJXjV+Wkp7pmV2UWzeVLphRKHf99oQuNw8d6gm4+Q=
X-Received: by 2002:a62:1a51:: with SMTP id a78mr53158071pfa.133.1558017021738;
 Thu, 16 May 2019 07:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-3-git-send-email-akinobu.mita@gmail.com> <20190515170320.GA21663@localhost.localdomain>
In-Reply-To: <20190515170320.GA21663@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 16 May 2019 23:30:10 +0900
Message-ID: <CAC5umyi97O+-4Dpspx-mouSReJBxqDXvigxw-SzDSa4BeEM9Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: support thermal zone
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8816=E6=97=A5(=E6=9C=A8) 2:08 Keith Busch <kbusch@kern=
el.org>:
>
> On Thu, May 16, 2019 at 12:17:17AM +0900, Akinobu Mita wrote:
> > This enables to use thermal zone interfaces for NVMe
> > temperature sensors.
> >
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  drivers/nvme/host/pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index fad5395..88a25dc 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2470,6 +2470,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *=
ctrl)
> >       if (dev->ctrl.admin_q)
> >               blk_put_queue(dev->ctrl.admin_q);
> >       kfree(dev->queues);
> > +     nvme_thermal_zones_unregister(&dev->ctrl);
>
> This unregister should probably go in the nvme_remove() rather than in
> the last reference release.

You are right.  It is too late to unregister and it caused a lot of
sysfs_remove_link() failures when removing driver.
