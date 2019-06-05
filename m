Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1F36076
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfFEPmq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 11:42:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45677 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbfFEPmp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 11:42:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id x7so8838953plr.12
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2019 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HT8rs4hwGaWG5IuOFVaFlA5Z0E57AgaycUBt63djjCg=;
        b=cn+itN2+p3FswXzcc3Qp9etSRe9Gj6W2oMDHJWFFreOh7hx99jpUUvWPutyY/jSRwM
         eYJeHAr0OCROyY6Lq2xCDXICTig8fvcFF3hqQMFCa/Sb4TF5wAVJ1X/KyyPcpGB6n/u3
         iJpiE1T9ipHjDioMANp3sTQQ6sISYLywriftPJMUF5aO6A4Gc8cOM3+w2W4A+SHN7qF1
         mb8JS296BYik/VN0roz3o+OmqR+ioeZ8kKAkj4YxtaRAVOEK2xk4PV09NFaKKfhoh6dC
         ESYeJlKc7ks/VF0Werc2K+JIyQKSO0cZPO+KeWfEAOSpOp/J9IbPADhhh+b1MNJCSLik
         qC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HT8rs4hwGaWG5IuOFVaFlA5Z0E57AgaycUBt63djjCg=;
        b=UaiSWG8JU68Ci6g1fdgihD1j3abceT9s8CQQdRVX7nfP5VNTsOtsjccYHlPsmRbW4p
         lVU5WhL87gguvwWS1djjVRd4tZ4TyiMigcnApqQv1/xVEywQ0a11tamoVPLHG/maje8z
         +TbkPHsORbvg+gEmDMr397f7gG67rfVJODPOltG1EFkh2lEQEt2CfjHgzmVeKPOhn6LH
         N9qPs/9ee2LxlEHeuRP4OpkobOfkPg8jEbNMNDG3vFFmcq+/R9up5qB6yWgiFn7KA5MB
         MRJb0SbKSwmYx+nFy892eEM3SBYm2M/8RbZg//ugovvQLvfO503eSBB0Hmi4Z3U8A73A
         5zxA==
X-Gm-Message-State: APjAAAU90d/NojE1kAt5qn8IDpfhUyium/T3dNXP2xrJDT3Owo34sm0f
        EZGfAaOiyAO1scuTXANtx8AkRZ91mJ+5eBGzYAU=
X-Google-Smtp-Source: APXvYqw5p6OZod0skAJniUBSTG08MFQgBJ0KoMKwplhFuH2z6vn85MjmNkcGf40iAL1LVV4c2EIWlJLW13wu1g4VqLA=
X-Received: by 2002:a17:902:24c7:: with SMTP id l7mr45027535plg.192.1559749365079;
 Wed, 05 Jun 2019 08:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com> <20190601090238.GD6453@lst.de>
 <CAC5umyiBmD6-3BNLfG7sNOe9jde8Ct16a9N_Ao3T_1_G1K_DDA@mail.gmail.com> <20190604073140.GH15680@lst.de>
In-Reply-To: <20190604073140.GH15680@lst.de>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 6 Jun 2019 00:42:33 +0900
Message-ID: <CAC5umyiN9TTi5rrYjsk-Gh-6aYLJRYjemm-U5F_BpF_+XMaJ_g@mail.gmail.com>
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

2019=E5=B9=B46=E6=9C=884=E6=97=A5(=E7=81=AB) 16:32 Christoph Hellwig <hch@l=
st.de>:
>
> On Sun, Jun 02, 2019 at 10:19:08PM +0900, Akinobu Mita wrote:
> > As long as the user space thermal governor is used, there is nothing mo=
re
> > than that from a functional perspective.  And I suppose that this is us=
ed
> > with user_space governor (i.e. there is still some work to be able to b=
ind
> > actual thermal cooling device).
> >
> > The main purpose of this is to turn on a fan when overheated without
> > polling the device that could prevent the lower power state transitions=
.
> > But as you noted, we could do that with the existing AEN notifications
> > through uevent.
> >
> > So frankly speaking, the benefit of this is providing generic thermal s=
ysfs
> > interface and the tools like tmon (linux/tools/thermal/tmon) can show t=
he
> > nvme temperatures.
>
> I'm just a little worried about bloating the nvme driver with features
> that look kinda nifty but don't buy us much.  I'd rather keep at least
> the core and PCIe drivers as minimal.  Now the thermal device support
> is pretty small and except for the smart uevents I can't find anything
> actually bad, but I'm not exactly excited either.

I'll add thermal.c file in order to minimize the core driver changes and a
module parameter to disable the thermal zone support.

Device tree thermal zone will also be supported. It enables to use thermal
governor other than user_space governor.
