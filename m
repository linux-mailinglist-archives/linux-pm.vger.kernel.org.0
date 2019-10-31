Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14276EB176
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 14:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfJaNq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 09:46:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35665 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfJaNq6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 09:46:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id c8so4109367pgb.2;
        Thu, 31 Oct 2019 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q5d0ydYp/ptTQ9vHd3UzSNtpmE/REEwTqm2IaznSbE4=;
        b=JDJR04Z2x1prHv1ALXSs8WeR/FfMUBuDg+FckRq9WOy3QuTjr4tv8/K+URJwEBgW7w
         XoGJ3BDWa5NLEIG0kBg5dv0nwIMywUA+4UfLFe57n+3xO9lORFCV3GPyDLu82qW5WODA
         cdLz+IW9KIOVl84p39YNMiK0/KTFvC4r//22hCtAP7x7iP5EwZU9bz7xuie41/UaPgZ5
         8MIF+wrBv/+KIkAoy2afLqJ/iSQiZvGXRQ4ApWhgnxLPpgoW0vlHPKdjF3Fa0Q6ubVtT
         iiV4JUA98oeMQttYJNQxViYfSsT3RmHjBCcv7KqM/+y5s5CqT6FNppSsxdtelzDLfhOT
         AMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q5d0ydYp/ptTQ9vHd3UzSNtpmE/REEwTqm2IaznSbE4=;
        b=rbxgsYr7xsL0DMUjVTO55MtiGkdf6mt0dybABFJkatIusj1RW8p1zAl5HKHusbidau
         mxp/OU41oqBLy/ZpiZWc45Aj7N85px2sNoi4uwMhc7qNxSeb+EDMeetknpIy1A6Cg/TJ
         ZoDnwD6owSrBf3Hi4Rn8MmY/4wArrhNqPZVIR6KulQ05guheajplduqxERLwffplksnQ
         mvvcNbFVML/LOa+CMo3b3CDsQ7ztXZkAPkoRz4y885hdmc3YPDwWfbGxYlDCeBO9xCvq
         rC5AsoOKytNDAfr9wxMNO2AYeitxOc5Jek3YPUN5q1KzYmG25hY3edKLpGPrTiJOGioH
         W5BQ==
X-Gm-Message-State: APjAAAWlUTKDOWlphzW/xZpE/L2OXq4fDEAuA6h/PB3GNXSvdGkQ9Une
        UYeVJ1oFelX607X8QcGsNblHX6/2k/WcIiP2uM0=
X-Google-Smtp-Source: APXvYqy7EE4JFOOg5FTnK+3IMnUZVKb5ZAfLuaHrGr2eAWfbGLp8iZxTZ9qxwC9iNhwEkm6Psecrym4OGrhakGAJewo=
X-Received: by 2002:a17:90a:f48f:: with SMTP id bx15mr7672163pjb.115.1572529616927;
 Thu, 31 Oct 2019 06:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191029223214.18889-1-linux@roeck-us.net> <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
 <20191030140511.GA14252@lst.de>
In-Reply-To: <20191030140511.GA14252@lst.de>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 31 Oct 2019 22:46:46 +0900
Message-ID: <CAC5umyg-QAvyKdSYQnVdST=p7CAGCQjmWpfc=rnK3dau36Y+mg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B410=E6=9C=8830=E6=97=A5(=E6=B0=B4) 23:05 Christoph Hellwig <hch=
@lst.de>:
>
> On Wed, Oct 30, 2019 at 08:16:48PM +0900, Akinobu Mita wrote:
> > The nvme_init_identify() can be called multiple time in nvme ctrl's
> > lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
> > should we need to prevent nvme_hwmon_init() from registering hwmon
> > device more than twice?
> >
> > In the nvme thermal zone patchset[1], thernal zone is registered in
> > nvme_init_identify and unregistered in nvme_stop_ctrl().
>
> So Guenter said above the thermal subsystem could use the information
> from hwmon as well.  Does this mean this patch would solve your needs
> as well?

The main reason I chose thermal framework was to utilize the temperature
threshold feature for notification on crossing a trip point temperature
without polling for smart log.

But the device I used for testing doesn't seem to report asynchronous
event immediately, so I'm not fully sure that's useful for now.

I have no problem with this nvme hwmon patch.  Maybe we can integrate
the temperature threshold feature into the nvme hwmon afterward.
