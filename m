Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1773BED4A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhGGRpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhGGRpH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 13:45:07 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D0C061574
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 10:42:27 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i4so4452273ybe.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67r38bE7gQFQq3QdwWGtHId+Jukj2mvNHeTDPSYrtoQ=;
        b=PiICEgwc7suyXxN0mAopoGLe6qStu8w216bkY7ntbFJES64gkKAVvNRXyVO1GFHbgC
         l9k1jMUt3w3jw3TBaa55TTLeqvXmKjFlQV19yvAV97K/xigbpxsUIsifvWN7LxvoXoAs
         fFHHN17hY2dGumqaplrWaYI2uedjSijA70my9t9Nx0mZIuhWwHQ6UMsv+PVFsWQtI/1S
         Qkoj6ZtER+1olb/t7PvFV/X5wVqfllmBXnWc5GERs6mAjs+ZkAW8grwinee3GZDlHqGz
         +ZPUO2slLAckkd7WtWORZHyQREJLk+EpS1RLHxfCtC3g2Tc5JRSDNaGyWOfzs3bUhz4K
         tExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67r38bE7gQFQq3QdwWGtHId+Jukj2mvNHeTDPSYrtoQ=;
        b=JaXNb1Zdl2wCPvGlA/Rja4WlWkJDwyvsRitYiiKaH2D4VpfRlc75bu0kMeOfmzn5Ut
         DodqdHOQ5EqvPHKD3yKkHNabCaSaMuzJAh3mMLTc0mhwvbqY1EXt0wTHaUHBp8Vsg+R2
         KB5BQzqSSWm29HyU354kEFXcAjWCUq+dB5Qz95SezFCSfde5W/xWd4Zfy944WoTSJ2tZ
         noUntltYv6+2Zt7ZiNlYcxJnUyMBrPb33WHKLqz3jceh/R40anyOiZD1CVXdhThVlCtB
         bIhnBkgvvWbz2aTae5sMWqvhHT5tPqHfbp1Vz8ahMCrrc2jZuxpqFnjw25RfhCzPyBOi
         uv8A==
X-Gm-Message-State: AOAM5314keDnK/ZDerNcs/P8eFYhz4IbdmqfN9eCDz0rgkRM3/F1VzZe
        gQCay26jWrYvZm4pq8R2pQ/5H40HIHdzrRidVCJTIg==
X-Google-Smtp-Source: ABdhPJwFttiWi7Jgj1I6L5f60b/n53pkLOBE3RjrV8WhESNsOLc+ROGmWITcmAdN6pWWu9sBPobsQik3WKj/TFI/JsQ=
X-Received: by 2002:a25:bb46:: with SMTP id b6mr31453156ybk.346.1625679746076;
 Wed, 07 Jul 2021 10:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210707172948.1025-1-adrian.hunter@intel.com> <YOXnF4BBPeBEMB38@kroah.com>
In-Reply-To: <YOXnF4BBPeBEMB38@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 7 Jul 2021 10:41:48 -0700
Message-ID: <CAGETcx-Sjo3scN-ZK-aqRCKi-6+1y_KXOuCqK97YgJS32u6tbg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] driver core: Add ability to delete device links
 of unregistered devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 7, 2021 at 10:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 07, 2021 at 08:29:46PM +0300, Adrian Hunter wrote:
> > Hi
> >
> > There is an issue with the SCSI UFS driver when the optional
> > BOOT well-known LUN fails to probe, which is not a fatal error.
> > The issue is that the device and its "managed" device link do not
> > then get deleted.  The device because the device link has a
> > reference to it.  The device link because it can only be deleted
> > by device_del(), but device_add() was never called, so device_del()
> > never will be either.
>
> How was a link created for something that never had device_add() called
> on it?  Who is doing that?
>

Greg responded as I was typing :)

Nak for the series. I don't like mixing and matching the control of
managed device links like this.

Can I get more details please. How is the device link added in the first place?

-Saravana
