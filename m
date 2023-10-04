Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B87B781A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Oct 2023 08:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjJDGoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 02:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjJDGoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 02:44:05 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99099E;
        Tue,  3 Oct 2023 23:44:02 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 0EE2618F346;
        Wed,  4 Oct 2023 08:44:01 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1696401841; bh=7CFkT8AGUKfOPiea29UqCnIyV1oKqSqe6Qkat6U2vRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iDVIuMVDyzvm8fcbyX3YK4AphG5vWZoiU2Z9V7x13MYrH68zVE7zHOw+P9EOXtoMe
         W8eJM0RpCxYR9SZmjzb/rmAm5T4UCy7QrohKxRgN14uqgsmtDEpd2YzId7w+R0bGy+
         KgcnJM4pVr3Ym+SZAtpuSpJyfWIzQu407po7F5yHwk3K/1K12xYySZS8jCUT7k+dYu
         X4DaMqOOlBqBpsz3K3ZL2Fb5uwagAr8HwD4b9oxpEzy29CFMt4b4/dm1lLZve5tuy8
         Oq+1fOrIXnOn7tlO6FEqWTG6id/b0OTp3c1gh/QN9w74550+G/OazXwDin4PIhNfCl
         5SLWz5T+bwDtw==
Date:   Wed, 4 Oct 2023 08:43:59 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: Thinkpad E595 system deadlock on resume from S3
Message-ID: <20231004084359.59c5d308@meshulam.tesarici.cz>
In-Reply-To: <539ec93d-b4f4-1c36-632b-48b89537c9dd@kernel.org>
References: <20230930122054.3cf727a4@meshulam>
        <20231003113135.38384a87@meshulam.tesarici.cz>
        <CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
        <20231003130240.0c64bc2e@meshulam.tesarici.cz>
        <CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
        <20231003144019.24566b05@meshulam.tesarici.cz>
        <CAJZ5v0jttFqKE_CLpF+-vJ_wDAuOo_BUS33htpFUs6idNMugKg@mail.gmail.com>
        <20231003145110.1f22adfb@meshulam.tesarici.cz>
        <CAJZ5v0jbT0DaDpFpLbzO46-Yg6QJ-MrcZAuP+c60q9KpFHAtpQ@mail.gmail.com>
        <20231003171710.2c6a913c@meshulam.tesarici.cz>
        <CAJZ5v0hXZx3ghWrfcTmTzwDJzYqLpzeBhx+CqBjg65Dngc2eRg@mail.gmail.com>
        <20231003220744.07c4fa0a@meshulam.tesarici.cz>
        <539ec93d-b4f4-1c36-632b-48b89537c9dd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 4 Oct 2023 10:25:47 +0900
Damien Le Moal <dlemoal@kernel.org> wrote:

> On 10/4/23 05:07, Petr Tesa=C5=99=C3=ADk wrote:
> > I just want to confirm that my understanding of the issue is correct
> > now. After applying the patch below, my laptop has just survived half a
> > dozen suspend/resume cycles with autosuspend enabled for the SATA SSD
> > disk. Without the patch, it usually freezes on first attempt.
> >=20
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index a371b497035e..87000f89319e 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -4768,6 +4768,14 @@ void ata_scsi_dev_rescan(struct work_struct *wor=
k)
> >  		ata_for_each_dev(dev, link, ENABLED) {
> >  			struct scsi_device *sdev =3D dev->sdev;
> > =20
> > +			/*
> > +			 * If the queue accepts only PM, bail out.
> > +			 */
> > +			if (blk_queue_pm_only(sdev->request_queue)) {
> > +				ret =3D -EAGAIN;
> > +				goto unlock;
> > +			}
> > +
> >  			/*
> >  			 * If the port was suspended before this was scheduled,
> >  			 * bail out. =20
>=20
> This seems sensible to me: scsi_rescan_device() only checks that the devi=
ce is
> running, without checking that the device queue is also resumed. So the r=
ight
> place for this check is scsi_rescan_device():
>=20
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 3db4d31a03a1..b05a55f498a2 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1627,12 +1627,13 @@ int scsi_rescan_device(struct scsi_device *sdev)
>         device_lock(dev);
>=20
>         /*
> -        * Bail out if the device is not running. Otherwise, the rescan m=
ay
> -        * block waiting for commands to be executed, with us holding the
> -        * device lock. This can result in a potential deadlock in the po=
wer
> -        * management core code when system resume is on-going.
> +        * Bail out if the device or its queue are not running. Otherwise,
> +        * the rescan may block waiting for commands to be executed, with=
 us
> +        * holding the device lock. This can result in a potential deadlo=
ck
> +        * in the power management core code when system resume is on-goi=
ng.
>          */
> -       if (sdev->sdev_state !=3D SDEV_RUNNING) {
> +       if (sdev->sdev_state !=3D SDEV_RUNNING ||
> +           blk_queue_pm_only(sdev->request_queue)) {
>                 ret =3D -EWOULDBLOCK;
>                 goto unlock;
>         }
>=20
> Can you try the above to confirm it works for you ? It should, as that is
> essentially the same as you did.

After revertung my patch and applying yours, my system can still resume
from S3. Congrats!

Tested-by: Petr Tesarik <petr@tesarici.cz>

Petr T
