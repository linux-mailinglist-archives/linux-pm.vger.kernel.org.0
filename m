Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4616ECFE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 18:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgBYRso (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 12:48:44 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:59064 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBYRso (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 12:48:44 -0500
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: floppym)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 9BB7634F310
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 17:48:43 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id c16so245806ioh.6
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 09:48:43 -0800 (PST)
X-Gm-Message-State: APjAAAXObNZwInUqDRP6FaH11YSm6yEKD8tCDIC0NszORJ+dbLbJA1Yk
        w0VMqFEMod+2ApGZSVnVWkYlVOnSNnWsc9y6PaY=
X-Google-Smtp-Source: APXvYqyTdSw3YRHtXyWh5v6vOd+ifgrMR7emkxCp/YJ9CqJRifYjhWIgyMnW/ZteYPKdWsqWt+tYgjvkxS70p6KnFlg=
X-Received: by 2002:a5e:8402:: with SMTP id h2mr207157ioj.30.1582652921725;
 Tue, 25 Feb 2020 09:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20200201175046.3948500-1-floppym@gentoo.org> <20200224202029.877025-1-floppym@gentoo.org>
 <a4c5af79-d9f0-2ea8-4013-30fe8f2a96d3@kernel.org>
In-Reply-To: <a4c5af79-d9f0-2ea8-4013-30fe8f2a96d3@kernel.org>
From:   Mike Gilbert <floppym@gentoo.org>
Date:   Tue, 25 Feb 2020 12:48:30 -0500
X-Gmail-Original-Message-ID: <CAJ0EP40RZSf8nAVJ-Ot4uFOLD=JSvo_hJ3VhEJX9L7c6iDtoXA@mail.gmail.com>
Message-ID: <CAJ0EP40RZSf8nAVJ-Ot4uFOLD=JSvo_hJ3VhEJX9L7c6iDtoXA@mail.gmail.com>
Subject: Re: [PATCH v2] cpupower: avoid multiple definition with gcc -fno-common
To:     shuah <shuah@kernel.org>
Cc:     linux-pm@vger.kernel.org, trenn@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 24, 2020 at 5:26 PM shuah <shuah@kernel.org> wrote:
>
> Hi Mike,
>
> On 2/24/20 1:20 PM, Mike Gilbert wrote:
> > The -fno-common option will be enabled by default in GCC 10.
>
> Great. It landed in my inbox now.
> Please include the message you are seeing in the change log.

Sure, I will roll a v3 shortly.

> > diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
> > index 33dc34db4f3c..20f46348271b 100644
> > --- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
> > +++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
> > @@ -82,7 +82,7 @@ static struct pci_access *pci_acc;
> >   static struct pci_dev *amd_fam14h_pci_dev;
> >   static int nbp1_entered;
> >
> > -struct timespec start_time;
> > +static struct timespec start_time;
> >   static unsigned long long timediff;
>
> Does it make sense to move start_time and timediff defines to
> cpupower-monitor.c and adding externs for them in
> cpupower-monitor.h?

I don't think that makes a lot of sense. start_time is really an
internal value and does not need to be shared between the two object
files.
