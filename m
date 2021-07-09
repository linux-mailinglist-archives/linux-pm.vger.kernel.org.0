Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D473C22B0
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 13:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhGILWe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 07:22:34 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46765 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhGILWe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 07:22:34 -0400
Received: by mail-oi1-f169.google.com with SMTP id u66so5980677oif.13;
        Fri, 09 Jul 2021 04:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bp3zv5UVrm6BSpyuWDLFluQwCulbY10bxcdNogbu+jI=;
        b=MRNCtGjkUGqdTfCfXeFuSFf9wbVanZ9urPJySuBOCi2TyBfOOIDwSNDQxcgySSVicb
         y2S+o1tluU0fRxD0dmDUCVYs8cwRK9by7mzrVJuLr1unmnqFwPYeHvsxkdvcRPew6+LS
         AuV/pTn1exlfGtK53w7Eo/AwBDwQ/smZHMHrjPaSF1Q3E+LSsMQXkjnWn4toCWNC48QK
         nTtmLn1z1SuDkOkrkoWGMchO4uFNF1h44HCzfpYROdqBNHDe1QlUSFwBrWSutfEZOME+
         Q4ZJOvsSTK4gbtQ1nEL5AJMCKrxHwM0nQipmlAGfeZEZ6ImpdVzQPk20EvYwSrCfi1WX
         sBhg==
X-Gm-Message-State: AOAM531SceXYgRr71RGV4fN/7jXRpXHor/H5jNt43h4VpzfMKrsbFyPd
        r3FC7UXNY3VUBoxbsyQBYzHTbX4LErmxSqpPkOk=
X-Google-Smtp-Source: ABdhPJzgNbYnhSQ4ajgMbfcHlG6qbY9k7stVxBIZGKXMJqAo9alAJR+kv4E4d0Pn/v0G9Pio/GOXAzaCELQKI7MCBDc=
X-Received: by 2002:aca:ab8f:: with SMTP id u137mr18817009oie.71.1625829589766;
 Fri, 09 Jul 2021 04:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210709064341.6206-1-adrian.hunter@intel.com>
 <20210709064341.6206-2-adrian.hunter@intel.com> <YOgdBGBEYNndLLwa@kroah.com>
In-Reply-To: <YOgdBGBEYNndLLwa@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Jul 2021 13:19:37 +0200
Message-ID: <CAJZ5v0g8fbV6ansDQOM7WchbE3tzvd5iFmnvu2wTOu-F4enM0g@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] driver core: Add ability to delete device links of
 unregistered devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 9, 2021 at 11:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 09, 2021 at 09:43:40AM +0300, Adrian Hunter wrote:
> > Managed device links are deleted by device_del(). However it is possible to
> > add a device link to a consumer before device_add(), and then discover an
> > error prevents the device from being used. In that case normally references
> > to the device would be dropped and the device would be deleted. However the
> > device link holds a reference to the device, so the device link and device
> > remain indefinitely.
>
> Why are you not just manually removing the link you just created?  You
> manually added it, you know something failed so you need to clean up, so
> why not clean this up too?

His changes are needed to do just that.
