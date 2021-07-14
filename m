Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A953C8ABB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGNSYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 14:24:36 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:35409 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGNSYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 14:24:36 -0400
Received: by mail-oi1-f177.google.com with SMTP id p67so3323726oig.2;
        Wed, 14 Jul 2021 11:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KcpjwXhcCKnHcviynWkzqMFtlMWRocVGM/Qc8KU/ac=;
        b=aNhdwBKIGRxlkBRsO56bx9W8HHTKu0QMlZjah98H+vVsRLUyuZIsIQjP3hm0de51du
         kci5BF6oSlBDzVBhWQiPocYULLLFqy0HieAe0xu2jtiHuUX6mQgeR3Sy8GKQDtzGLS3J
         cXILLptA+eVf/cdbHKnbENkkIVH55zhKg8ThCLjqETUKtqkB/DQB6gZub6z8lURnsAHp
         4PsSyZLfRwnUCFbc/NLm1gQdtKpih6yLB3G+0brX00EgODhLQ7UGSjH07yG+dvOu4w1J
         p59kVTkkkub23HnQoedwzrq8Pat8DFTamTV+DhoEZXmzpKY/APNg+FjH+sQzkpd10dLN
         PhMg==
X-Gm-Message-State: AOAM530Uwrxk3CX/FFPaNGL+ykjysMrrz8/OjMwmjxxEKuUv8lQEXP55
        vlfuryZVYi9w06+wgIYqNfO7wAWUXwu50vIeiV8=
X-Google-Smtp-Source: ABdhPJzqbNv3YOFVhJxye+TyrJL14HgG5jNwvBep50muv7b1MOtq0jwqlVnIdv9Ufn/78vBQWnLxWc5ZndD5gGXkrcM=
X-Received: by 2002:a05:6808:10d0:: with SMTP id s16mr7913602ois.69.1626286903018;
 Wed, 14 Jul 2021 11:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210710103819.12532-1-adrian.hunter@intel.com>
 <20210710103819.12532-2-adrian.hunter@intel.com> <YOm6hWQ+RL7ILm3p@kroah.com>
In-Reply-To: <YOm6hWQ+RL7ILm3p@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 20:21:32 +0200
Message-ID: <CAJZ5v0gpS3L_PM0=jetCac=GwK-GAEz8paKk15GX9F+Bhszv7A@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] driver core: Prevent warning when removing a
 device link from unregistered consumer
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

On Sat, Jul 10, 2021 at 5:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 10, 2021 at 01:38:17PM +0300, Adrian Hunter wrote:
> > sysfs_remove_link() causes a warning if the parent directory does not
> > exist. That can happen if the device link consumer has not been registered.
> > So do not attempt sysfs_remove_link() in that case.
> >
> > Fixes: 287905e68dd29 ("driver core: Expose device link details in sysfs")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  drivers/base/core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> No Cc: stable for this?  Why not?

AFAICS that would be

Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
