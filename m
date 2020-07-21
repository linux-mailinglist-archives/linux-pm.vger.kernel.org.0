Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E922766B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 05:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgGUDMr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 23:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgGUDMr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 23:12:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B82C061794;
        Mon, 20 Jul 2020 20:12:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a15so4737164wrh.10;
        Mon, 20 Jul 2020 20:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QmWkp+pLXRh/gXZUp7qiRhPmHHKd7eq2d0NWiyvOMkM=;
        b=IL3gzcHT7td0H6RZ8vgJLxeW6j2TSaQkhrvkWv+Dvx5x0FwsrsXISZnCo2B4Vq817E
         7P/qxL0w3YfNDJb8JSVe58a6qjZvxLMLx6G+MNtrjmwdKdiincxlg3Wl2UHIuxcH1Suj
         LFb9fYu43S5GhRmzXAOnBeBpI86XYJCk3L5xXSFumVpyIqkAe1y5skECjTyPSfPMmcU1
         U6qW2UlGMd+OHCHheq571mFMSGS9sUvTCYa6aMv5K9VAtiaAPzBZWQJmJumPLopTyUKr
         Mv51vz43IZs2RdnafHeARbgZvugyLNiGuEk7zEjBs+T4u/r77DJbKUyqjvFyTKOkm2Mk
         nLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QmWkp+pLXRh/gXZUp7qiRhPmHHKd7eq2d0NWiyvOMkM=;
        b=ltHKabegIjsDqPM6I0ezvxZIzcUZpanjqEzL5CQgtuWbbOskTBign62WqWXesZBi41
         N5ZTnk2ksdPkIBem2wSqchvfIOZOeEpQsMQ/XKKVjJCi6NvtaONXUQFfNKXtxm5Jx2CR
         JBzjAeJu89PIxrFC2aCIbTGef9NL9sOmFS2JAIJMNhw3haFHNCNSuYy4ZF5k90njz1gk
         ECz9tDrfNjKQ0Aje/2uWO0c/M1QdYzUQHadIjxHbZmkSLNZfJs45GPOjIdPplYMjfYwu
         MRKRhna41CiH5Ur3jT04RM5cFn0j2qeQkfGnnZe5zn0hxa3CdpBkxvdtbV9oMVMc7DtC
         DC6Q==
X-Gm-Message-State: AOAM532iqK9i/mfHhKR77Ls+GWFYDxQPF/rsoGPqkJ/D9DS7YTf6SMHW
        YuG/XVIbBXVgglKMDMkDpbPh8X08tfhsUVRoltngWzEqtoZQpNZY
X-Google-Smtp-Source: ABdhPJzT6sH02cjhcT6NreTADImut0tj7cBEsIStKDXcS4HLicMhEmtB5ONK2n7aerQQcVyOYCV1HjeGi/WsfObwVIY=
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr25917757wrh.95.1595301163893;
 Mon, 20 Jul 2020 20:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595214246.git.huangqiwu@xiaomi.com> <20200720082100.GA720171@kroah.com>
In-Reply-To: <20200720082100.GA720171@kroah.com>
From:   ivan <yanziily@gmail.com>
Date:   Tue, 21 Jul 2020 11:12:32 +0800
Message-ID: <CAPtXDt39QMWE5jYeszBD8z9P_BHgwZ86wArpCEafC_Xx+hjKLQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] add some power supply properties about
 wireless/wired charging
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 20, 2020 at 01:47:13PM +0800, Qiwu Huang wrote:
> > From: Qiwu Huang <huangqiwu@xiaomi.com>
> >
> > quick_charge_type reports quick charge type based on charging power.
> > tx_adapter shows wireless charging adapter type.
> > signal_strength shows degree of coupling between tx and rx when wireles=
s charging.
> > reverse_chg_mode supply interface to enable/disable wireless reverse ch=
arging.
> >
> > Qiwu Huang (4):
> >   power: supply: core: add quick charge type property
> >   power: supply: core: add wireless charger adapter type property
> >   power: supply: core: add wireless signal strength property
> >   power: supply: core: property to control reverse charge
>
> What changed from the previous versions of this series?  Normally you
> either include that in the 0/X email, or in the individual patches.  I
> don't see that in either place in this series :(
>
> See the many examples of how this is done by looking at other patches on
> the mailing lists and in the submitting patches documentation.

Sorry =EF=BC=8CI will add it in new version

This patchset aims to provide power supply properties about
wireless/wired charging.
 =E2=80=9Cquick_charge_type=E2=80=9D reports different types of quick charg=
e based on
the charging power;
 =E2=80=9Ctx_adapter=E2=80=9D shows the type of wireless charging adapter;.
 =E2=80=9Csignal_strength=E2=80=9D shows the coupling level between TX and =
RX;.
 =E2=80=9Creverse_chg_mode=E2=80=9D provides the interface of enabling/disa=
bling
wireless reverse charging.

 Changes in v5
  - Add details in 0/X email

 Changes in v4
  - Exclude the patch of =E2=80=9Cpower: supply: supply battery soc with de=
cimal form=E2=80=9D
  - Fix some typo

 Changes in v3
  - Add enumederated for quick charge type
  - Add enumederated for tx adapter type
  - Update the return type and description in ABI

 Changes in v2
  - modify to capital letters for =E2=80=9Cpower_supply_attrs=E2=80=9D
  - Update the return type and description in ABI

 Qiwu Huang (4):
   power: supply: core: add quick charge type property
   power: supply: core: add wireless charger adapter type property
   power: supply: core: add wireless signal strength property
   power: supply: core: property to control reverse charge

  Documentation/ABI/testing/sysfs-class-power | 71 +++++++++++++++++++++
  drivers/power/supply/power_supply_sysfs.c   |  4 ++
  include/linux/power_supply.h                | 31 +++++++++
  3 files changed, 106 insertions(+)


> thanks,
>
> greg k-h



--=20
Thanks

Qiwu
