Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33D63E0C6F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 04:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhHEC3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 22:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhHEC3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 22:29:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521E3C061765;
        Wed,  4 Aug 2021 19:29:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x14so6132627edr.12;
        Wed, 04 Aug 2021 19:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hcrbuo/eI/947WksZPPotw6nEi7GjDzfNHwXQNC+UzE=;
        b=nwwkLudnzjFmnS9SJehZ6QB75IhJdVsdr1SqDdsngdllPPsdShPqH4mvn05+tbjwl7
         h1M8QWUIJQIkDFlUQ7DYan/GKhx1DLrWW5lbKk4ikGwnGeqVUlFQlBMXK22IUvDlPXxu
         DNYGTL4nqt8rXGz8aS0FJVRBmaqLvDJG6c6OGs6320JZJrKhTyo/mH9EOsd9ubua9H23
         F3UwljHEB7WwIUsOMyOEQWuOWqIJf8OkgI372dOcbChPo7dcIHOH/awCjWSaKHDZIDEr
         zPCVpOt8YvhfawBtDvzrpkwp6IveOkPV81WnfEzRVPFwSTY1n5zPw9fvusDY0RmBnGMc
         umHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hcrbuo/eI/947WksZPPotw6nEi7GjDzfNHwXQNC+UzE=;
        b=eQjaS8OEHpAIg3yLbt55cxx3xNv820YZ9p/5xgEVSNT/9J6FiF46b2co5ItK+PcBKA
         4Zptxm13ZLSfGOwRCdYvvWgdVVk65Tjtlga4PGVcdS7b0kC7wZZZF/wzl4Laf4H+JXr+
         DUq1JJ95ufFsLuCRYrlE2Ik4Jb1zz3po4vexTRyMm4RfGyan/uhXpyPOwUYfJiMUuOMA
         FrLzgmBbblylcgCiHOskOLfSvTYPaCykzvOOzj+sLc269BDuh6R6QEVxxgib5G5lGMrj
         krCIgqpyqvLWQ6s5tMqyoy2Ix9Ka3/uPO/dhr0VWnG50xd6Vu6dllDw59o8sVQZZ22m9
         Op2w==
X-Gm-Message-State: AOAM533OsonKC2KkNSmgUQuK6/r0IRggSa3eTK2xsMpe2806n8wgW1sZ
        TLgxzbVpNADaeXJ0Nj0Bfr1/d1UU94kOFNrSeQQ=
X-Google-Smtp-Source: ABdhPJzb+2TzxJfJb2e8HF5avLFj3koEXDKBINkpVYO2yKgjLo5Y+Jh85kkSOsc1M8Cjy8sVEk/+kU36IMoj3ebg2vI=
X-Received: by 2002:a05:6402:510:: with SMTP id m16mr3354641edv.280.1628130559007;
 Wed, 04 Aug 2021 19:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627992564.git.wangting11@xiaomi.com> <YQqCNKoLdwaCjmIl@kroah.com>
In-Reply-To: <YQqCNKoLdwaCjmIl@kroah.com>
From:   =?UTF-8?B?5ZCnIeeOi+Wptw==?= <zxc52fgh@gmail.com>
Date:   Thu, 5 Aug 2021 10:29:08 +0800
Message-ID: <CAA=jPj2RVcQ3eyrcu2=2uPrZoTU0ffB9vsM-bpy8yGOu2w8odQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] add some power supply properties about
 wireless/wired charging
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangting11 <wangting11@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

 A demo of =E2=80=9CThe usage of quick charge type property=E2=80=9D is upl=
oaded in
PATCH v11 1/4 drivers/power/supply/qcom_smbb.c.


The usage of the other three properties is about wireless charging.The
code of our driver can refer to the link below.

POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE=EF=BC=9A
https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/p=
ower/supply/qcom/qpnp-smb5.c#L1434

POWER_SUPPLY_PROP_REVERSE_CHG_MODE=EF=BC=9A
https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/p=
ower/supply/qcom/qpnp-smb5.c#L2572

POWER_SUPPLY_PROP_TX_ADAPTER=EF=BC=9A
https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/p=
ower/supply/qcom/qpnp-smb5.c#L2633

POWER_SUPPLY_PROP_SIGNAL_STRENGTH=EF=BC=9A
https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/umi-q-oss/drivers/p=
ower/supply/qcom/qpnp-smb5.c#L2609

Thanks=EF=BC=8C
Wangting

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2021=E5=B9=B48=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 04, 2021 at 07:01:57PM +0800, Ting Wang wrote:
> > From: wangting11 <wangting11@xiaomi.com>
> >
> > This patchset aims to provide power supply properties about wireless/wi=
red charging.
> > "quick_charge_type" reports different types of quick charge based on th=
e charging power;
> > "tx_adapter" shows" the type of wireless charging adapter;
> > "signal_strength" shows the coupling level between TX and RX;
> > "reverse_chg_mode" provides the interface of enabling/disabling wireles=
s reverse charging.
> >
> > Changes in V11
> >  - Fix build error on linus/master
> >  - Fix build error on power-supply/for-next
> >  - Fix conflict
>
> Where are the users of these new properties?  Shouldn't drivers be
> submitted with them as well, otherwise why would these be added?
>
> thanks,
>
> greg k-h
