Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACD9266D4
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfEVPXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 11:23:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33840 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfEVPXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 11:23:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so1246860plz.1
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KEHUlVRwOUqUR0G9pKydXDrTlMBnpUN3P5XbzZmAyQU=;
        b=cHSIt3r1Mf+SDHZ2hxMYFYLBv+9vOTFJtajhkuNxbF7y3wnf9jHDJ+o0pMA2T0lHA1
         chp9yohr58CMqLjPkl/MCDTRTG7yrlO8xqugp/uIj9WsSdvUWmUCfGQRwApPs4CUGaXd
         ouZtU+Cf7f6Shn/y/KEW0R+k03OzYPrEm9g+Umay/ExJzPFn/fgTLofDFIJ0lzlCG6Eu
         rqujMG9BZGtBnJTqriPDlsIM6S9yG1PUe0VXxIkay/O7Fvra0pz7ogs++saYAfjgegoM
         45J6mRRdj6UggyrCUTn0Q9nGWiPOA5nxOC+rDHNbuyghWx4cKkjKVTAG+qWVGcNBlwFt
         g9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KEHUlVRwOUqUR0G9pKydXDrTlMBnpUN3P5XbzZmAyQU=;
        b=AnySueu86gNCjokWdAZsqFFVYtGblJhul6jD2jHbKMs8IqDJQ4OHHM3R2KBY3SuFnQ
         AUwrwIMXXdo/JcbWaM+haifxfsFBbT/ILSl4SA4TcfxvmElV7woKVrIOD5NPy3tWsnsi
         g7L+IQacDD/8f/DKQapjXW+aH2D67Z54ZtoL2z+P50yuRN8njrSWQxKRjdkgIxPSY7zR
         5/P8kYNry+IODWB0HbbhMV0F5yXflpn+2Ad1UhgUd2zQX9jJ7bbN6aLXr2Q1Nn0AwttD
         nJQ1tj29OFkAdN3jMgHKsDTeRzfUq+eYbwAUvv6yC+llEEeBWLZScNeCfv5brRWkFshu
         B9CA==
X-Gm-Message-State: APjAAAXDBXqyHyFbt0XKdi24lU3oYTKlDC0UgPbt+cXEZ9xtRoHE0zfv
        bYqR1Z56gjXu1fy7X8q74oGIiOOvrXKvBJWCnbk=
X-Google-Smtp-Source: APXvYqzFQFmEsH3/064oxAVgtmEWl85JnsEVsjNxSmomphsa1ybji8nHBbmM/fOY47niJ+LdXppCM8NqhGDIusKLIF4=
X-Received: by 2002:a17:902:7283:: with SMTP id d3mr46836903pll.274.1558538629991;
 Wed, 22 May 2019 08:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com> <44154394-c0a0-4895-d406-ea357a906cfe@intel.com>
In-Reply-To: <44154394-c0a0-4895-d406-ea357a906cfe@intel.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 23 May 2019 00:23:38 +0900
Message-ID: <CAC5umyghtb58HB08PPZsds5Kf82wr3jq0HPG4861_9JS7KF4gw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
To:     "Heitke, Kenneth" <kenneth.heitke@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@fb.com>,
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

2019=E5=B9=B45=E6=9C=8822=E6=97=A5(=E6=B0=B4) 6:05 Heitke, Kenneth <kenneth=
.heitke@intel.com>:
>
>
>
> On 5/21/2019 10:04 AM, Akinobu Mita wrote:
> > +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
> > +                                  unsigned int sensor, int temp)
> > +{
> > +     unsigned int threshold =3D sensor << NVME_TEMP_THRESH_SELECT_SHIF=
T;
> > +     int status;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(sensor >=3D ARRAY_SIZE(ctrl->tzdev)))
> > +             return -EINVAL;
> > +
> > +     if (temp > NVME_TEMP_THRESH_MASK)
> > +             return -EINVAL;
> > +
> > +     threshold |=3D temp & NVME_TEMP_THRESH_MASK;
> > +
> > +     ret =3D nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold,=
 NULL, 0,
> > +                             &status);
>
> I'm not sure about best practices here but since 'status' is unused, you
> can pass in a NULL pointer. The called function deals with it correctly.

OK.  Make sense.
