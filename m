Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E589821A3C
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfEQPCJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 11:02:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40376 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfEQPCJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 11:02:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id g69so3473456plb.7
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2019 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s7B7wWE3RrzKwEWxic7OC8bzl//pottNx24ZlL4GUWw=;
        b=Do2gPjc2pR68y+NaLBOo2f6vzFZO9xcifvUgBNtbnRxe6SSUxV0tm7CFZJqcPduowr
         WVHVI8sX53lUeAzaIf1viLAIS9G5m8xJbbi/INh5XW1Qpo+/TNDh2ZGB+ON0b89dtOBE
         TxNqQlECdTOZoVp/ty63KqYAf1HCFHblskqz6RmSqPo6R5+HRX1t2djXqL6gGNpsCtRM
         Ujd3zLw0M5qSJDRiSmVPZ4HPPgVYcMBflrRw88h7d8I2lqva1WQIxH4sHW6Mcd5LfL04
         JA08QR4Z/paAovFslD5YndhcBu+HX+pJ2D/2Jj5sEoSOLgrXXbjrTVhkeBYPtjpCdfWj
         xNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s7B7wWE3RrzKwEWxic7OC8bzl//pottNx24ZlL4GUWw=;
        b=n7GbUc5ebGpIN75iDUqiEl/Hqh/932mhwS9FzxPaFCTRylYecFD0ZNoMR2uYK5+RF/
         i5u3ZJypLTrSnI8Y8mUpwr3MD7EyRojQkwSjystBUQjnBxXLp5uitbUyrFO3p8n4rgff
         0xGpCc+C+OdkKkPr654D2tUisq667a2jreI/WaoznFr+y+vvcBlKb4VIfBDbZnceRCi/
         F9dyvs5ezITX8jORvi8SX0jjL+lKYs585rjFAKukbbjUn0I6Xt64i+jienoGnsMKk4rg
         Ctu0lLuah/uHiWLbTfMlnlbeiAqo4A3JAZL1ECDI8NV+n2xWKOtrOrPxJ5brCRoFAqM4
         7GDQ==
X-Gm-Message-State: APjAAAWisf6glom7RUy3oUjtuiRsKgHnvsl1R7kwEjaOvKhTKVvaVwkd
        lG8JfYlAPEzGToCDH3UdUNZY/5F88o1bLTzhUcM=
X-Google-Smtp-Source: APXvYqzvZjIYhpk+hS1KThgi15JOpBB8AKw1u6tMVoqxNqc+vxfn1E+pCdtKTjkoK1SiqdPQ1Zcowvva9sLKf1j76Ow=
X-Received: by 2002:a17:902:6a83:: with SMTP id n3mr58027713plk.109.1558105328823;
 Fri, 17 May 2019 08:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com> <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>
In-Reply-To: <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 18 May 2019 00:01:57 +0900
Message-ID: <CAC5umygRTpq3GktaMKBdC8+-ghkJKCzFME+rm+V6vasrOAyOPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     "Heitke, Kenneth" <kenneth.heitke@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8817=E6=97=A5(=E9=87=91) 6:22 Heitke, Kenneth <kenneth=
.heitke@intel.com>:
>
>
>
> On 5/15/2019 9:17 AM, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the SMART =
/
> > Health log page (the composite temperature and temperature sensor 1 thr=
ough
> > temperature sensor 8).
> > The temperature threshold feature (Feature Identifier 04h) configures t=
he
> > asynchronous event request command to complete when the temperature is
> > crossed its correspoinding temperature threshold.
>
> s/correspoinding/corresponding/

OK.

> > +
> > +static void nvme_thermal_init(struct nvme_ctrl *ctrl)
> > +{
> > +     INIT_WORK(&ctrl->thermal_work, nvme_thermal_work);
> > +}
>
> Does this work queue need to be destroyed at some point?

This is work_struct, not workqueue.  So it can't be destroyed.
But I noticed that we should call flush_work for thermal_work at
unregistering thermal zone devices.
