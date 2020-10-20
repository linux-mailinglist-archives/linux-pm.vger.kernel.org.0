Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1263293C18
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406442AbgJTMpW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 20 Oct 2020 08:45:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43684 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406414AbgJTMpW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 08:45:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id k68so1539550otk.10
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 05:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ofX3+kZa0+9VRA4qnL9CNhfP7h66jtwe3kJeuBqLXs0=;
        b=tN7fW7oZ2FpNOO1ZvoM2cENBGZVT39Hj8ztXXkBaWHlfIR7D1+1hqvtTGXJHKys5Zp
         AEQyg8GO+CVqVwnwTTHaZKJ0Oo60W+PpkahIUFsuLdptdHvSbIefDQeO5A6CMbsol0cB
         FDu7GvHceRdyspS9sy0SjMMeNFbBENE91ZzoB8x3oE6Z4bBRnb7NFWDDl42QRdT2s9C8
         RfaSyCaCxDVMVf2IWE4nXwbdMrxgcfelyUpCUNA3OUS+vd37LRP5YQ/LHGJMLAC/lJPM
         BPC9E22nWnAwGOM0v7O7RHR1pm3WLV8jFQfMoP1+tiIkArdplAqpPu/T58/ARiZKTQWm
         lf1w==
X-Gm-Message-State: AOAM5323Xd3uobZ+YRsMbx+OvLg9fhUA3PcEh6bSmlvYg+jHBNnrCRwr
        3Oq5R0uGiPK7S1V4CPUXmc80Oa8C1MeoFgQuZyA=
X-Google-Smtp-Source: ABdhPJx/ZrZN8kpyIWlse6ZBajIoRIpNnVYu7FFlBy/PgdyCqrhMefbWjWs8nU+idwps/mXWU4PMOyozR9B01zIsclI=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr1669562ote.206.1603197921660;
 Tue, 20 Oct 2020 05:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <1600780266-155908-1-git-send-email-chenxiang66@hisilicon.com>
 <CAJZ5v0jXWV0ewLWbn2Fabp1HsK8oCsio3J1h7UMr5ZEcVTGjqg@mail.gmail.com>
 <CAJZ5v0h6Sf9zpKFZsmzwpOiSWnqrASEo8PQVr5rTm=pwUxM-bw@mail.gmail.com> <3b56a749-b145-6a41-c069-571ca784ca9b@hisilicon.com>
In-Reply-To: <3b56a749-b145-6a41-c069-571ca784ca9b@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Oct 2020 14:45:10 +0200
Message-ID: <CAJZ5v0iDVtz62kSCvLA+-sAoBB7OuSxsRg5az-pVyD1Q_s99bg@mail.gmail.com>
Subject: Re: [PATCH v2] PM:runtime:Remove the link state check in function
 rpm_get_supplier() and rpm_put_supplier()
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 4:24 AM chenxiang (M) <chenxiang66@hisilicon.com> wrote:
>
> Hi Rafael,
>
> 在 2020/10/20 1:03, Rafael J. Wysocki 写道:
> > On Fri, Sep 25, 2020 at 5:02 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> On Tue, Sep 22, 2020 at 3:15 PM chenxiang <chenxiang66@hisilicon.com> wrote:
> >>> From: Xiang Chen <chenxiang66@hisilicon.com>
> >>>
> >>> To support runtime PM for hisi SAS driver (the driver is in directory
> >>> drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
> >>> (consumer device) and hisi_hba->dev(supplier device) with flags
> >>> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
> >>> After runtime suspended consumers and supplier, unload the dirver which
> >>> cause a hung. We find that it calls function device_release_driver_internal()
> >>> to release supplier device hisi_hba->dev, as the device link is busy,
> >>> it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
> >>> device_release_driver_internal() to release consumer device
> >>> scsi_device->sdev_gendev). Then it will try to call pm_runtime_get_sync()
> >>> to resume consumer device, as consumer-supplier relation exists, it will try
> >>> to resume supplier first,
> > It looks like I have overlooked one thing here.
> >
> > Does it help (without the $subject patch) to move the
> > pm_runtime_get_sync(dev) in __device_release_driver() before the while
> > (device_links_busy(dev)) loop?
>
> I have tested it, and it also solve the issue.

OK, thanks!
