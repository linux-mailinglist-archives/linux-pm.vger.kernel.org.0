Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A740626714
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfEVPoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 11:44:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34010 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfEVPoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 11:44:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so1536422pgt.1
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zi7TPQJ2AgEBRCfEDHwkjIeVMnhLJIppmZLARoXOTOI=;
        b=RRfmpF2nB0MGqFAv5Ka9Ze21Aez4ZQKr74L+8RLa5DTDowwzYMrSA2HpGZqnobTDpn
         woNpeDpTnAuAqoGEDYeZnYjlYqBgpREWTQYJCaSNRsdWB50b5RHfu1bQNzqB25ht1i/Q
         iUKveIIuS0lft0PpRWp6un3D5Km4/9S4G9Rqw0IKLa+hJoP9urw1IrZa7V/tDMmqJnXd
         Jpz1v9wMTP5GYaW9yUugDnYBioOGdn8t+/oz6Dlxl/vcwXMBs9LjXRbEpGMf4FApqjYy
         mJvxK4knN/8nzyvp1GTcSGNtub5PiH1HJXkX1H8ERjQG7aV2lTsCmo7JgM3gJQlJWgYw
         s5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zi7TPQJ2AgEBRCfEDHwkjIeVMnhLJIppmZLARoXOTOI=;
        b=R9Lri7OeHE6a/S9qpUVXfVbt/2OaQnRkOt1tPAMcL//ucIoeIIE1yWh/fhpX2HUhlo
         LV3G9kEXZYhwdu4SUsu4ZbEaG9WEoa0SAumBbomgz8dHHstI2OTHjeHvErN/FiLVwEhY
         a2IQQgmSHBmYSDuwkYAR07gHyB2X3oCegsYqYi/gcVX6NmIEgYVeM74+dPe9BkfXubaY
         fr7A6ImYyTnjk3LlsQdTWEaWn6NgbYSEMlOlw5E3UM7pk4KFtxsW9bQ6O1+BS4XrFGG9
         6cti+CPIqvsCXeWET5b1eraBE1LZUyw+V4F0TnAqN73sJyV2LUbV7ots7PaoTIkYwXa8
         ozOw==
X-Gm-Message-State: APjAAAWMta4Yr15Kk5rfUPeqv5HYPe5zHqbEx2sr6GTdesDHySgkF/3G
        jj6CCbrV324GwtPP4jaCbq1OWdOBpgbHaNp8v0Y=
X-Google-Smtp-Source: APXvYqxW9OK0aMc9IbWilx5Vn0nSOT6FUUgCR0Ldi2EbLveBerecZPbu7Jrglhx4CndvsTGSDtlphLSooajQFPspP+0=
X-Received: by 2002:a63:930d:: with SMTP id b13mr78760352pge.18.1558539855859;
 Wed, 22 May 2019 08:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com> <20190521161532.GD1639@localhost.localdomain>
In-Reply-To: <20190521161532.GD1639@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 23 May 2019 00:44:04 +0900
Message-ID: <CAC5umyi4t-r+0WbGjfa=_6ym_n=vcx5855nwL6NxuXH_HhYXkA@mail.gmail.com>
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

2019=E5=B9=B45=E6=9C=8822=E6=97=A5(=E6=B0=B4) 1:20 Keith Busch <kbusch@kern=
el.org>:
>
> On Wed, May 22, 2019 at 01:04:07AM +0900, Akinobu Mita wrote:
> > +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > +{
> > +     struct nvme_smart_log *log;
> > +     int ret;
> > +     int i;
> > +
> > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
> > +     if (!log)
> > +             return 0; /* non-fatal error */
> > +
> > +     ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > +                        log, sizeof(*log), 0);
> > +     if (ret) {
> > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n", re=
t);
> > +             ret =3D ret > 0 ? -EINVAL : ret;
>
> A ret > 0 means the device provided a response, so don't return a
> negative for that condition, please. That's just going to break
> controllers that don't provide smart data, like qemu.

After looking at __nvme_submit_sync_cmd(), it returns -EINTR if the device
doesn't respond.  So, should this return a negative only when nvme_get_log(=
)
returns -EINTR?

        ret =3D nvme_get_log();
        if (ret) {
                dev_err(...);
                if (ret !=3D -EINTR)
                        ret =3D 0;
                goto free_log;
        }
