Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD661ED466
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFCQcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 12:32:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34191 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgFCQcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 12:32:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id b8so2376788oic.1;
        Wed, 03 Jun 2020 09:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eVVamDCZsIXed1FQdAjYh2BNwd5A5G0fRXGVIZoFWM=;
        b=FbfqrSLgcK5XwKzujDlED+V2dplMD2J0Li78KRQQsGuJQHEth8zHqf6P0mk7VOHCWu
         ENvO66jlp0IatYh0cg+VDxTX+k1PqbgKHP27GUylTKjx0klmibLz1G7+V7Zct7ZR5pSa
         NGzxNK9P6kwu6FX5zgf1zOKIlKSRNAxyDUEFWpM6QvlyjwpZS8ZBSUK8Cv7E7z7msNNk
         FoPeuCK2GIj0LOqVYyhfCrROfXYIWgmVtlbI4tcUBWCKg2uBWmiW+v+iLp4VfPPcmeaV
         l0MJ2V54T5i/e/wgVrbxTHmsA2QCSmCh6tEJ8iditgpBpgEwoXPBJpcfE3OCJKyUdNXk
         E5Bg==
X-Gm-Message-State: AOAM530W+hX/0vKJuzYQtjWLT3Yn9Hf4bs+dZB5wsZhxs6UfJBTzfNpm
        iIuSliv/0xpls2c96zuAofDj9Qz4SuUN5H8GLCsUIQ8u
X-Google-Smtp-Source: ABdhPJz0XArac/3LIuFoc/H/3+Ble7c2chheFZ1rjEzLZvOE7U6XFbZtXKWmLGb80Lg2DNZ1rGGjiNejavWr1SRQL/w=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr392135oie.103.1591201965522;
 Wed, 03 Jun 2020 09:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0gA9Egmff0y4yTm2UH=ge+jJH1nMbLhTsRbUtP=+m8OLg@mail.gmail.com>
 <CANFp7mWTk9qFqUhvwhxZY97_J=MwwWV-8ctJYFGT8_QJw_bPmA@mail.gmail.com>
In-Reply-To: <CANFp7mWTk9qFqUhvwhxZY97_J=MwwWV-8ctJYFGT8_QJw_bPmA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 18:32:34 +0200
Message-ID: <CAJZ5v0jmdAK2R_oo50w0WLqG5rfGeeAxoDetuH-FEMRh=Oz4tw@mail.gmail.com>
Subject: Re: Problematic BT commit in Linux 5.7
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
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

Hi Abhishek,

On Wed, Jun 3, 2020 at 6:29 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Rafael,
>
> I left a comment on the bugzilla post as well but I agree with you now
> that it's probably bad to fail suspend when this occurs.
>
> At https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_core.c#n3363,
> we try to recover from a failed suspend by restoring running state and
> returning an -EBUSY.
> I think if we change this logic to not attempt to restore until
> resume, log the error and allow suspend, that would probably be
> preferable from a suspend perspective.
> I will make this change, test it out and send the patch today.

Thank you!

Please CC linux-pm as well as Len Brown and Todd Brandt (both in the
CC list of this message) on that patch.

Thanks!


> On Wed, Jun 3, 2020 at 9:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Hi Marcel,
> >
> > Unfortunately, we are observing system suspend failures on multiple
> > lab machines as reported in the BZ entry at
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=207629
> >
> > which is due to the following commit:
> >
> > commit dd522a7429b07e4441871ae75ebbfcf53635bdd4
> > Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Date:   Wed Mar 11 08:54:02 2020 -0700
> >
> >     Bluetooth: Handle LE devices during suspend
> >
> > Ostensibly, this is because the BT firmware on the machines in
> > question does not match the new kernel code, but the firmware update
> > requirement is not entirely obvious to the users and the steps to take
> > in order to upgrade the firmware are not clear.
> >
> > Apart from the above, failing system suspend for a reason like a
> > protocol timeout isn't really user-friendly, because the user may just
> > have closed the lid of a laptop and is expecting the system to be
> > suspended (so it may go into a backpack or similar).  Yes, the driver
> > may not be able to suspend its device gracefully, but failing the
> > entire system suspend really is a big deal and should be treated as a
> > last-resort type of action.
> >
> > As stated in the BZ above, reverting the above commit along with
> > "Bluetooth: Pause discovery and advertising during suspend"
> > (4867bd007d25a8dfd4ffc558534f7aec8b361789) makes the issue go away, so
> > can you please consider doing that?
> >
> > Alternatively, would it be possible to address the issue in a way that
> > would not require many users to update firmware on their systems?
> >
> > Cheers,
> > Rafael
