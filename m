Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A821ED816
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 23:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFCVbM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 17:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgFCVbL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 17:31:11 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C0C08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 14:31:10 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y123so2304936vsb.6
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUaeWtaycwIzCev5kfRxlW9qrUY+p8Hm/aqijsovNfY=;
        b=oFj9Ts67r+0LFpea3FIfUHxM4TANETordKvibgmkjMpGDDLUFCSbH/kuh9lIGPl2Rn
         +fma5i6tVDsGXZSRh8ugXVEaKvRCbvlcEMgwDwafb7+ncHNLbrQlv8SWOETsPHJ8Nd5i
         Z1Yd4Mry/xXUGfMaiUhQQkPSZIT0T7O5rnR0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUaeWtaycwIzCev5kfRxlW9qrUY+p8Hm/aqijsovNfY=;
        b=O5YJabKB+KV0jEQWOIASuHGOUFt1dw2BDyjzfVn8GyZJgS8cds5kiUSOjkAgsiIstU
         Eq8h0E4BHeVx3Idjmn4tC9nNcb+r8zrY6DuwimitdxLvhZG2CBzd2mGPI7C0YC/9ON06
         mnlDAVHg82t/q2HrcAzn0YxDiq80p79hMFUvmq30t0fOyqHEHlhTPKSdT30ChEpWUWVk
         W5s4Hu3KebROjf40qWd9vf255wYOCvdPEa5+RUbiLKlTwoH2k6aVfu1jNFEFJIT9LQ6Y
         gyFD4ZeE/bkoBrIEmbnRwlJ9+tEKxMsVVLaCzVKPTN29Z3r2tvQva/PZyLxNsTs7pP2V
         RtNQ==
X-Gm-Message-State: AOAM532whUoqNL/2QlnjjVGImkr1Lum7iQjNTTfRW/3Ky0N/nHaxVqxV
        NE+VfGZcjRUHbXiM2kGIZbJh0oBU3SWv2FG40Z5w2A==
X-Google-Smtp-Source: ABdhPJwFcYbNTcopnrN4YAmNTrC+Qxlv6gAVC12W0WU7kgh2pTRMPlBfn6XuFpceDw+ZKvXLPW2oKaX344QBepbbRP8=
X-Received: by 2002:a67:7307:: with SMTP id o7mr1113957vsc.93.1591219869527;
 Wed, 03 Jun 2020 14:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0gA9Egmff0y4yTm2UH=ge+jJH1nMbLhTsRbUtP=+m8OLg@mail.gmail.com>
 <CANFp7mWTk9qFqUhvwhxZY97_J=MwwWV-8ctJYFGT8_QJw_bPmA@mail.gmail.com> <CAJZ5v0jmdAK2R_oo50w0WLqG5rfGeeAxoDetuH-FEMRh=Oz4tw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jmdAK2R_oo50w0WLqG5rfGeeAxoDetuH-FEMRh=Oz4tw@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 3 Jun 2020 14:30:55 -0700
Message-ID: <CANFp7mXdJbVk_4zpUPV+5sstUfErycO-yuhBc0MrzO++8c7kag@mail.gmail.com>
Subject: Re: Problematic BT commit in Linux 5.7
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I've sent a patch to fix this titled: [PATCH] Bluetooth: Allow suspend
even when preparation has failed
https://patchwork.kernel.org/patch/11586223/

Please take a look.

Thanks
Abhishek

On Wed, Jun 3, 2020 at 9:32 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Abhishek,
>
> On Wed, Jun 3, 2020 at 6:29 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > Hi Rafael,
> >
> > I left a comment on the bugzilla post as well but I agree with you now
> > that it's probably bad to fail suspend when this occurs.
> >
> > At https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_core.c#n3363,
> > we try to recover from a failed suspend by restoring running state and
> > returning an -EBUSY.
> > I think if we change this logic to not attempt to restore until
> > resume, log the error and allow suspend, that would probably be
> > preferable from a suspend perspective.
> > I will make this change, test it out and send the patch today.
>
> Thank you!
>
> Please CC linux-pm as well as Len Brown and Todd Brandt (both in the
> CC list of this message) on that patch.
>
> Thanks!
>
>
> > On Wed, Jun 3, 2020 at 9:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > Hi Marcel,
> > >
> > > Unfortunately, we are observing system suspend failures on multiple
> > > lab machines as reported in the BZ entry at
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=207629
> > >
> > > which is due to the following commit:
> > >
> > > commit dd522a7429b07e4441871ae75ebbfcf53635bdd4
> > > Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > Date:   Wed Mar 11 08:54:02 2020 -0700
> > >
> > >     Bluetooth: Handle LE devices during suspend
> > >
> > > Ostensibly, this is because the BT firmware on the machines in
> > > question does not match the new kernel code, but the firmware update
> > > requirement is not entirely obvious to the users and the steps to take
> > > in order to upgrade the firmware are not clear.
> > >
> > > Apart from the above, failing system suspend for a reason like a
> > > protocol timeout isn't really user-friendly, because the user may just
> > > have closed the lid of a laptop and is expecting the system to be
> > > suspended (so it may go into a backpack or similar).  Yes, the driver
> > > may not be able to suspend its device gracefully, but failing the
> > > entire system suspend really is a big deal and should be treated as a
> > > last-resort type of action.
> > >
> > > As stated in the BZ above, reverting the above commit along with
> > > "Bluetooth: Pause discovery and advertising during suspend"
> > > (4867bd007d25a8dfd4ffc558534f7aec8b361789) makes the issue go away, so
> > > can you please consider doing that?
> > >
> > > Alternatively, would it be possible to address the issue in a way that
> > > would not require many users to update firmware on their systems?
> > >
> > > Cheers,
> > > Rafael
