Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68556E13
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZPwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 11:52:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44516 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZPwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 11:52:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so1563069pfe.11
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HkPZhKVnh+qdvDEc8DXxUejx1F5VL/Izq9TwqeEZ6EE=;
        b=rK/KjgnmCgBGSBy0AAJEVwtKInDV12WaxjxIzJJuc0WS+kblwMGxrjo8mKJ2LDLZIX
         XxX6T8+vkFhiImxx2OfOg9L8lWQqciYeFdoncUglDaW6ygbYvnOHMLemQKC1y7dKdhmc
         HfQjP56WhrxzTgyiGPZieCDUT0GGeKHkrpGfST+9BcE53HI/rDmj+1cOTQnLoUlfYcq5
         Ix7/SbcZUkUWKDNK2kzjdPgo668IY2KJLLGlEFYuPCwPoWKqTezzFSUKay5V2BnVlKFP
         CDoD2XTqN/Ng2FDFEksAKBOy2MWKmxwTW3a/IqYdzf1Pl7VkF22ogGLyGcK++m3tLr94
         yEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HkPZhKVnh+qdvDEc8DXxUejx1F5VL/Izq9TwqeEZ6EE=;
        b=BuePrxzHjGJ0pFhiX4bNCDIySKug8CPSrDDEihFnecvHtKiPQA+Owor08AEW8Uh8No
         nJ4vDtyqeFi1VCv24OSfttB5pOVbgIvu51kvrAsaqvCxK3uh9kWkuMB9GtEXfEZbi2vD
         YlZhxPbMfAbnP8X89vutmTs6ju7TnCiJsznXJ3UTcHup+Vg/yiJ2sowLzwLffQvfhbDH
         CqblUWRR7Ur2276eVfdXp2oKe94Lt55BmtogO7Ld6/ilr3xy+ciXW3Dbw6jbPtI2LAaa
         HlKCoXttqSPlQ2GZe99RmLkUJOno+LpyfxIGmJeL7sY02iuOfQu99YKFT2+cNmiNp33K
         SVEA==
X-Gm-Message-State: APjAAAWjPrK0R538Yr9qgRCFkWkSXm6rWvBUtdJxN0Ouu3puaMVk1BYL
        D9r58VkJCIzAKXRQqfcXbdx9PusJlwQl9do/qsk=
X-Google-Smtp-Source: APXvYqz9+ULgvtedXAWfTd7GPHpvJKUfRSirjlPpCRI4Ppfvy+USfi3IAFz2Yd0ASafWfSWTKCoTJkpjZmiWE/tIyjI=
X-Received: by 2002:a17:90a:d681:: with SMTP id x1mr5460230pju.13.1561564354050;
 Wed, 26 Jun 2019 08:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
 <1560439238-4054-3-git-send-email-akinobu.mita@gmail.com> <1561474998.19713.13.camel@intel.com>
In-Reply-To: <1561474998.19713.13.camel@intel.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 27 Jun 2019 00:52:22 +0900
Message-ID: <CAC5umyjhU7Xv=UyhfO5ikDwpGBTXCdaggfLt9UM7ZygUL1O1DQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] nvme: add thermal zone devices
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
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

2019=E5=B9=B46=E6=9C=8826=E6=97=A5(=E6=B0=B4) 0:03 Zhang Rui <rui.zhang@int=
el.com>:
>
> On =E4=BA=94, 2019-06-14 at 00:20 +0900, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the
> > SMART /
> > Health log page (the composite temperature and temperature sensor 1
> > through
> > temperature sensor 8).
> >
> > This provides these temperatures via thermal zone devices.
> >
> > Once the controller is identified, the thermal zone devices are
> > created for
> > all implemented temperature sensors including the composite
> > temperature.
> >
> > /sys/class/thermal/thermal_zone[0-*]:
> >     |---type: 'nvme<instance>-temp<sensor>'
> >     |---temp: Temperature
> >     |---trip_point_0_temp: Over temperature threshold
> >
> > The thermal_zone[0-*] contains a 'device' symlink to the
> > corresponding nvme
> > device.
> >
> > On the other hand, the following symlinks to the thermal zone devices
> > are
> > created in the nvme device sysfs directory.
> >
> > - temp0: Composite temperature
> > - temp1: Temperature sensor 1
> > ...
> > - temp8: Temperature sensor 8
> >
> > In addition to the standard thermal zone device, this also adds
> > support for
> > registering the DT thermal zone device.
> >
> I don't see standard thermal zone device and DT thermal zone device are
> registered at the same time very often, especially if they represent
> the same sensor.

Good point.

It is pointless to register both standard and DT thermal zone devices for
the same sensor.  We should register either one. (i.e. firstly try to
register DT thermal zone.  If no thermal zones found for the sensor in
device tree, then try to register standard one)
