Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584DF7A5B1C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjISHgx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Sep 2023 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjISHgw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2023 03:36:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78A114
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 00:36:45 -0700 (PDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80A173F680
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695109003;
        bh=MLRLAry2NlpMQaxof2G7yyxkoAcAjcPTZ7UlFboZNJM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SZWJDHoEG0yDPi/Fuq1xLNSP2yOXdoX3J+ss1zmEE17cSEu+AhU3Vz48Amy4YADA9
         ifE8rKGx+5rPo/4M8GKhJQMpRgjOKDoKJXtof34Dg4PTSkYGF+NEkO9xYz04ostjim
         OfW1ZMpmTo5pmviRG/eO29BnEgVjnhKoZ3g/dTzl9TOQUMwLqWncrvDN4yrVUT+INn
         x/XZicf9FU/gs+grI1ttdc/is+LDt3nY0oyFy+S42oh9kO8OQFbjKwAYIN4T5pXrSV
         Bqx8GRvF8BxyvqeSBhh49Yg6n3YBzSSCrMSl5Ev1wR2f6JAOueyXCX35i5ba1zxq0S
         65XyEusf6vaSg==
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-34feb260e6eso10679685ab.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 00:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695109000; x=1695713800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLRLAry2NlpMQaxof2G7yyxkoAcAjcPTZ7UlFboZNJM=;
        b=No+ZzwntPFnOOwnd7FhjTgqBtfI+AldY4bN9nZ7fO01SefLrhLp4HdW3y2XgeSvbqL
         cXN4llHO030dBJpls4cJAE5k1JEPYhs2xd9doYkckCxYP6aeSw3x9SUaLCNBBzjkJ0Xg
         k/L3SpfSesToefWMkVo1+91gTiqKbBFyxDd3tuSr8KBomL3Oov9g9LIRpEC3vQzsI3kQ
         3GG8CBaXSHAmN/8LzqPlL6lihpJD345NXvEsS4/SPy9AdSRiu/XhwL8G+FOd5br+lLXW
         bdbzm6qVhltERk4KcN5bweh5RQfeBqhkJWNhdxmnAVLYYcUyr2i3DJb4mJmyInBFJn5k
         Wprw==
X-Gm-Message-State: AOJu0YyLvPklzrlXcvyCtwXY10KqzB9XZatI8ldBpoeh34w5yhHtVv/O
        iRhvABSPXNkElRdpTNtE1BxAa2uHCtt6vXfOolt5VlZYlg9dyU2XRW17yVWeO5ywYz+YW62IqEs
        Pg/TupHMI3WqlffSpOR7v5GdED20LgCwZ6/X3x27T9jX2T/5NWvnc
X-Received: by 2002:a92:a309:0:b0:34d:f0b9:97fd with SMTP id a9-20020a92a309000000b0034df0b997fdmr12317189ili.8.1695109000340;
        Tue, 19 Sep 2023 00:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtri+KycX7M4hWznMCNNys0wX8zYEKHaKuDUTL0tUNv3osCz1Z8lf8TJIPjKOLFz9JEBYy31Md7d0wA4KM3eY=
X-Received: by 2002:a92:a309:0:b0:34d:f0b9:97fd with SMTP id
 a9-20020a92a309000000b0034df0b997fdmr12317179ili.8.1695109000063; Tue, 19 Sep
 2023 00:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
 <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
 <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
 <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <DM6PR11MB26184A8A3F955589F5FC6836F4FBA@DM6PR11MB2618.namprd11.prod.outlook.com>
 <CAAd53p4o1pB-yzpvUCYsvuYEvQQK0my=u-ogrByRCx_Lvns=hw@mail.gmail.com> <bbbf36724d63f7532696a960a9d56d7ccd5a5bee.camel@linux.intel.com>
In-Reply-To: <bbbf36724d63f7532696a960a9d56d7ccd5a5bee.camel@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Sep 2023 15:36:26 +0800
Message-ID: <CAAd53p6MA9YLbcXxpC8=YEtbO6frFJk1LQ1BNUgPk=r1_uR8iw@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Xu, Even" <even.xu@intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lee, Jian Hui" <jianhui.lee@canonical.com>,
        "Zhang, Lixu" <lixu.zhang@intel.com>,
        "Ba, Najumon" <najumon.ba@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 18, 2023 at 11:57=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Hi Kai-Heng,
> On Mon, 2023-09-18 at 09:17 +0800, Kai-Heng Feng wrote:
> > Hi Even,
> >
> > On Mon, Sep 18, 2023 at 8:33=E2=80=AFAM Xu, Even <even.xu@intel.com> wr=
ote:
> > >
> > > Hi, Kai-Heng,
> > >
> > > I just got feedback, for testing EHL S5 wakeup feature, you need
> > > several steps to setup and access
> > > "https://portal.devicewise.com/things/browse" to trigger wake.
> > > But currently, our test account of this website are all out of
> > > data.
> > > So maybe you need double check with the team who required you
> > > preparing the patch for the verification.
> >
> > The patch is to solve the GPE refcount overflow, while maintaining S5
> > wakeup. I don't have any mean to test S5 wake.
> >
> The issue is not calling acpi_disable_gpe(). To reduce the scope of
> change can we just add that instead of a adding new callbacks. This way
> scope is reduced.

This patch does exactly the same thing by letting PCI and ACPI handle
the PME and GPE.
Though the change seems to be bigger, it actually reduces the duped
code, while keep the S5 wakeup ability intact.

Kai-Heng

>
> Something like the attached
>
> Thanks,
> Srinivas
>
>
>
>
>
>
> > So if you also don't have ways to verify S5 wake functionality, maybe
> > we can simply revert 2e23a70edabe  ("HID: intel-ish-hid: ipc: finish
> > power flow for EHL OOB") as alternative?
> >
> > Kai-Heng
> >
> > > Thanks!
> > >
> > > Best Regards,
> > > Even Xu
> > >
> > > -----Original Message-----
> > > From: Xu, Even
> > > Sent: Friday, September 15, 2023 3:27 PM
> > > To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>;
> > > jikos@kernel.org; benjamin.tissoires@redhat.com;
> > > linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee, Jian Hui
> > > <jianhui.lee@canonical.com>; Zhang, Lixu <Lixu.Zhang@intel.com>;
> > > Ba, Najumon <najumon.ba@intel.com>; linux-input@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
> > >
> > > Hi, Kai-Heng,
> > >
> > > I am also not familiar with this S5 wakeup test case.
> > > I already sent out mails to ask for help on it.
> > > Will come back to you once I get feedback.
> > > Thanks!
> > >
> > > Best Regards,
> > > Even Xu
> > >
> > > -----Original Message-----
> > > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > Sent: Friday, September 15, 2023 2:01 PM
> > > To: Xu, Even <even.xu@intel.com>
> > > Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>;
> > > jikos@kernel.org; benjamin.tissoires@redhat.com;
> > > linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee, Jian Hui
> > > <jianhui.lee@canonical.com>; Zhang, Lixu <lixu.zhang@intel.com>;
> > > Ba, Najumon <najumon.ba@intel.com>; linux-input@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
> > >
> > > Hi Even,
> > >
> > > On Fri, Sep 15, 2023 at 1:31=E2=80=AFPM Xu, Even <even.xu@intel.com> =
wrote:
> > > >
> > > > Hi, Srinivas,
> > > >
> > > > Sure, I will test it.
> > > > As long term not working on EHL, I doesn't have EHL board on hand
> > > > right now, I can test this patch on other ISH related platforms.
> > > > From the patch, it's focus on EHL platform, I assume Kai-Heng
> > > > already verified the function on EHL board.
> > >
> > > I only made sure the GPE overflow issue is fixed by the patch, but
> > > I didn't test the S5 wakeup.
> > > That's because I don't know how to test it on the EHL system I
> > > have.
> > > I'll test it if you can let me know how to test the S5 wakeup.
> > >
> > > Kai-Heng
> > >
> > > > I don't think it will take effect on other platforms, anyway, I
> > > > will test it on the platforms I have to provide cross platform
> > > > verification.
> > > >
> > > > Thanks!
> > > >
> > > > Best Regards,
> > > > Even Xu
> > > >
> > > > -----Original Message-----
> > > > From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Sent: Friday, September 15, 2023 12:11 AM
> > > > To: Kai-Heng Feng <kai.heng.feng@canonical.com>;
> > > > jikos@kernel.org;
> > > > benjamin.tissoires@redhat.com
> > > > Cc: linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee,
> > > > Jian Hui
> > > > <jianhui.lee@canonical.com>; Xu, Even <even.xu@intel.com>; Zhang,
> > > > Lixu
> > > > <lixu.zhang@intel.com>; Ba, Najumon <najumon.ba@intel.com>;
> > > > linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB
> > > > wakeup
> > > >
> > > > Hi Even,
> > > >
> > > > On Thu, 2023-09-14 at 12:18 +0800, Kai-Heng Feng wrote:
> > > > > System cannot suspend more than 255 times because the driver
> > > > > doesn't
> > > > > have corresponding acpi_disable_gpe() for acpi_enable_gpe(), so
> > > > > the
> > > > > GPE refcount overflows.
> > > > >
> > > > > Since PCI core and ACPI core already handles PCI PME wake and
> > > > > GPE
> > > > > wake when the device has wakeup capability, use
> > > > > device_init_wakeup()
> > > > > to let them do the wakeup setting work.
> > > > >
> > > > > Also add a shutdown callback which uses pci_prepare_to_sleep()
> > > > > to
> > > > > let PCI and ACPI set OOB wakeup for S5.
> > > > >
> > > > Please test this change.
> > > >
> > > > Thanks,
> > > > Srinivas
> > > >
> > > > > Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power
> > > > > flow for
> > > > > EHL OOB")
> > > > > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > ---
> > > > >  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 59
> > > > > +++++++----------------
> > > > > --
> > > > >  1 file changed, 15 insertions(+), 44 deletions(-)
> > > > >
> > > > > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > > index 55cb25038e63..65e7eeb2fa64 100644
> > > > > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > > @@ -119,42 +119,6 @@ static inline bool
> > > > > ish_should_leave_d0i3(struct
> > > > > pci_dev *pdev)
> > > > >         return !pm_resume_via_firmware() || pdev->device =3D=3D
> > > > > CHV_DEVICE_ID;  }
> > > > >
> > > > > -static int enable_gpe(struct device *dev) -{ -#ifdef
> > > > > CONFIG_ACPI
> > > > > -       acpi_status acpi_sts;
> > > > > -       struct acpi_device *adev;
> > > > > -       struct acpi_device_wakeup *wakeup;
> > > > > -
> > > > > -       adev =3D ACPI_COMPANION(dev);
> > > > > -       if (!adev) {
> > > > > -               dev_err(dev, "get acpi handle failed\n");
> > > > > -               return -ENODEV;
> > > > > -       }
> > > > > -       wakeup =3D &adev->wakeup;
> > > > > -
> > > > > -       acpi_sts =3D acpi_enable_gpe(wakeup->gpe_device, wakeup-
> > > > > > gpe_number);
> > > > > -       if (ACPI_FAILURE(acpi_sts)) {
> > > > > -               dev_err(dev, "enable ose_gpe failed\n");
> > > > > -               return -EIO;
> > > > > -       }
> > > > > -
> > > > > -       return 0;
> > > > > -#else
> > > > > -       return -ENODEV;
> > > > > -#endif
> > > > > -}
> > > > > -
> > > > > -static void enable_pme_wake(struct pci_dev *pdev) -{
> > > > > -       if ((pci_pme_capable(pdev, PCI_D0) ||
> > > > > -            pci_pme_capable(pdev, PCI_D3hot) ||
> > > > > -            pci_pme_capable(pdev, PCI_D3cold)) &&
> > > > > !enable_gpe(&pdev-
> > > > > > dev)) {
> > > > > -               pci_pme_active(pdev, true);
> > > > > -               dev_dbg(&pdev->dev, "ish ipc driver pme wake
> > > > > enabled\n");
> > > > > -       }
> > > > > -}
> > > > > -
> > > > >  /**
> > > > >   * ish_probe() - PCI driver probe callback
> > > > >   * @pdev:      pci device
> > > > > @@ -225,7 +189,7 @@ static int ish_probe(struct pci_dev *pdev,
> > > > > const
> > > > > struct pci_device_id *ent)
> > > > >
> > > > >         /* Enable PME for EHL */
> > > > >         if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > > > > -               enable_pme_wake(pdev);
> > > > > +               device_init_wakeup(dev, true);
> > > > >
> > > > >         ret =3D ish_init(ishtp);
> > > > >         if (ret)
> > > > > @@ -248,6 +212,19 @@ static void ish_remove(struct pci_dev
> > > > > *pdev)
> > > > >         ish_device_disable(ishtp_dev);  }
> > > > >
> > > > > +
> > > > > +/**
> > > > > + * ish_shutdown() - PCI driver shutdown callback
> > > > > + * @pdev:      pci device
> > > > > + *
> > > > > + * This function sets up wakeup for S5  */ static void
> > > > > +ish_shutdown(struct pci_dev *pdev) {
> > > > > +       if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > > > > +               pci_prepare_to_sleep(pdev); }
> > > > > +
> > > > >  static struct device __maybe_unused *ish_resume_device;
> > > > >
> > > > >  /* 50ms to get resume response */
> > > > > @@ -370,13 +347,6 @@ static int __maybe_unused
> > > > > ish_resume(struct
> > > > > device *device)
> > > > >         struct pci_dev *pdev =3D to_pci_dev(device);
> > > > >         struct ishtp_device *dev =3D pci_get_drvdata(pdev);
> > > > >
> > > > > -       /* add this to finish power flow for EHL */
> > > > > -       if (dev->pdev->device =3D=3D EHL_Ax_DEVICE_ID) {
> > > > > -               pci_set_power_state(pdev, PCI_D0);
> > > > > -               enable_pme_wake(pdev);
> > > > > -               dev_dbg(dev->devc, "set power state to D0 for
> > > > > ehl\n");
> > > > > -       }
> > > > > -
> > > > >         ish_resume_device =3D device;
> > > > >         dev->resume_flag =3D 1;
> > > > >
> > > > > @@ -392,6 +362,7 @@ static struct pci_driver ish_driver =3D {
> > > > >         .id_table =3D ish_pci_tbl,
> > > > >         .probe =3D ish_probe,
> > > > >         .remove =3D ish_remove,
> > > > > +       .shutdown =3D ish_shutdown,
> > > > >         .driver.pm =3D &ish_pm_ops,
> > > > >  };
> > > > >
> > > >
>
