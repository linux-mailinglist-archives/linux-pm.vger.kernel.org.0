Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A058AC60
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 03:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHMBKi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 21:10:38 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:44537 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHMBKi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 21:10:38 -0400
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-10.nifty.com with ESMTP id x7D17D2i010957;
        Tue, 13 Aug 2019 10:07:13 +0900
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x7D176Mn007003;
        Tue, 13 Aug 2019 10:07:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x7D176Mn007003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565658427;
        bh=L2h8Vjy+9Y09mIZApsXwsIOGlDr1pBAU/zwW1xEP40g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FV0r+t/xoyQLmuz2UDYkscN7ObVMkCWOksWupspNOfLUKXPjN2yEPK6vxvHZmspGY
         7WiYNdb090oh5usm/+ZJKRKLOmFEGwQdoNnG4qaBFmJKm/vLVtG6Ecl5VVgEmnwJ2k
         +bC1ACr0AKSRC+Irjv2kyzfLppI4yk53plPRnJGi/a6IyJkK7b0JqOz+k3qAV6BYcf
         sztuXX/YGhsCBIY2dF3CaANg0SGd6DQFIWRyBmbYOX89s/pVDLi2nynHGiYxwg52Ex
         iAgpXrNmu5kBXzmjTWAtTHPf5jw+MLm/FNz35LtmWCLSdO0C/VI3Pu46K+HEc8kFXY
         MWp2sQwp3qR+A==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id b64so21132641vke.13;
        Mon, 12 Aug 2019 18:07:07 -0700 (PDT)
X-Gm-Message-State: APjAAAVV+9Ln3Prvs5d5dO3KY2PuEGWj3I1d9X09Qq1vVgJM1D3KasEy
        q+qfJ5vE563yqPA81OTb27U7RwBEz3ifs5ivHdw=
X-Google-Smtp-Source: APXvYqyKjWR/Z/JcA6WmuFmnY8qTkln8CqolkATBJfU2C59DSnCk5mHe9UmWulyW2+MWtzJgbOu31LayBPnAgY6UAmU=
X-Received: by 2002:a1f:93cd:: with SMTP id v196mr7101948vkd.84.1565658425832;
 Mon, 12 Aug 2019 18:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190809002104.18599-1-stancheff@cray.com> <20190809002104.18599-2-stancheff@cray.com>
 <CAK7LNAScm9P+QMZiqqSQnOoPsN54OTcTGpaDgxTbjJ_knoeGhA@mail.gmail.com> <CAJ48U8Xp40is+R1dMW8sXq77ZS5D_h+hHte5Mq5eOrtpb41Qxw@mail.gmail.com>
In-Reply-To: <CAJ48U8Xp40is+R1dMW8sXq77ZS5D_h+hHte5Mq5eOrtpb41Qxw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 13 Aug 2019 10:06:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5OVcw9tJtaR8VE_JEemAzkqV6FeSHPEy38wotxjhkZg@mail.gmail.com>
Message-ID: <CAK7LNAT5OVcw9tJtaR8VE_JEemAzkqV6FeSHPEy38wotxjhkZg@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: recursive build of external kernel modules
To:     Shaun Tancheff <shaun@tancheff.com>
Cc:     Shaun Tancheff <stancheff@cray.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 13, 2019 at 2:34 AM Shaun Tancheff <shaun@tancheff.com> wrote:
>
> On Mon, Aug 12, 2019 at 10:24 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Fri, Aug 9, 2019 at 9:21 AM Shaun Tancheff <shaun@tancheff.com> wrote:
> > >
> > > When building a tree of external modules stage 2 fails
> > > silently as the root modules.order is empty.
> > >
> > > Modify the modules.order location to be fixed to the
> > > root when KBUILD_EXTMOD is specified and write all
> > > module paths to the single modules.order file.
> >
> > Could you try v5.3-rc4 please?
>
> So it seems we are using 'subdir-m' but that is now gone?
>
> Is there a recommend pattern for backward compatibility?
>
> Thanks!


Please convert

subdir-m += dir1
subdir-m += dir2

into

obj-m += dir1/
obj-m += dir2/


Thanks.

-- 
Best Regards
Masahiro Yamada
