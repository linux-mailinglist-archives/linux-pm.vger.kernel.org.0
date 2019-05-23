Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB15427F6A
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfEWOVk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 10:21:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730706AbfEWOVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 10:21:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so2820386plb.9
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2019 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ndu0C78u89Vpd1DZzdszrXEuSgM18mXqDDSkzxtz1S4=;
        b=CVNBJ/cjDL3pknGbhrYYTqpqp06CVRzA5cs2LqAxogdYA+R8Av9i31Yp/FiVvnm4wM
         hDMU4+a0Eq3Sx9hM5F/7Vi/1FNJmQxkYTpm69IM1yJ1W1YVduMnK2QrSLq9k9m9aOu/1
         kGxBBAjH474TdBOmWWzEHMR7b2BStg82cCKNv4SqfrymthZ7krc0bSM5A28Y4HblwKCQ
         AIbAc4Ldoi+326GgW01FDBLjUEYYnAmzCNqo+39HrCETwIDh6bKYLI+kodRZtir+XJs1
         TRPXXKkMb8sZ2fmNSlMzW/iFokac72VlGhV1jypclCNRXn1Iixrg0MPKYORzFbuC/ah7
         myyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ndu0C78u89Vpd1DZzdszrXEuSgM18mXqDDSkzxtz1S4=;
        b=uNl1w1BJ8Z4UDjSkokl+dvMO0T2quIryY1e/PC0cj67up5U0mG9qvACqq13e7XdjfB
         slrlID3uBefCF5WFLSN/VBOKz9NaLDSiC2y0WNDewKoo5UCpOvvwJCcevN9FrG/yJ+Td
         O1216YI0Y3NEHzLwxWCpAulooEdTp07vCLARg07jGC7baV7ix/WfGkZgROWvlMV5xn6h
         o5irYMRV4ikoNvyszNxQ9u1FZPb0MYDHvZiDbpQmRfzs8HcahZsPLb7ZRq+V1aolSP2X
         Zkn1Q0s8gB0CXt4+oYl/XMnk+fuk3TldKWc9aI9Fw4LwN7OPwpHwswFJKLEyFX9bJ+6K
         O9Hw==
X-Gm-Message-State: APjAAAUZQFZ7WmwPN5dqji/2DpcLW8WSdqOE9e9EOFKQUsiEK2GmOUJq
        P9LUEmBtf4u4t1YuOEDTlmLiKx4gbB8dMHVy53U=
X-Google-Smtp-Source: APXvYqyz0tMzVw19CQQcSqtHkHaiGJKrShsUgAzME/k1OZ9BDWY8ufKzGVZYuJ52SoOWAsRj+hyc/QHFjIvRzUGzSuI=
X-Received: by 2002:a17:902:7283:: with SMTP id d3mr54000194pll.274.1558621299898;
 Thu, 23 May 2019 07:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-5-git-send-email-akinobu.mita@gmail.com> <20190522174648.GA26477@infradead.org>
In-Reply-To: <20190522174648.GA26477@infradead.org>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 23 May 2019 23:21:28 +0900
Message-ID: <CAC5umyhsnk_g5N+k_dMiBenPopGCLHg35+X2Jg+sEPBf2ZLKHA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] nvme-pci: support thermal zone
To:     Christoph Hellwig <hch@infradead.org>
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

2019=E5=B9=B45=E6=9C=8823=E6=97=A5(=E6=9C=A8) 2:46 Christoph Hellwig <hch@i=
nfradead.org>:
>
> Is there any good reason why we need to call this from the PCIe driver
> instead of handling it all in the core?

OK. I'll move the thermal zones registration and unregistration into the
core module.

Call nvme_thermal_zones_register() in nvme_init_identify(), and call
nvme_thermal_zones_unregister() in nvme_stop_ctrl().

> Sure non-PCIe devices are usually external, but so are some PCIe
> devices, so if we really care about that we need some sort of flag
> anyway.

I'm going to not use the flag in next version.
If there is a demand, we'll have 'use_tz' or 'no_tz' flag in nvme_ctrl.
