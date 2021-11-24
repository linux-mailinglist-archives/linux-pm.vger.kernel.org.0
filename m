Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DCB45C5EA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 15:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353391AbhKXOCO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 09:02:14 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40862 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353533AbhKXOAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 09:00:11 -0500
Received: by mail-oi1-f179.google.com with SMTP id bk14so5493317oib.7
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 05:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HK54UlSDxfCw9CgDRE1ESVSmqRic5XUX28m5y5JYjOQ=;
        b=SB5MG6FgjsekVKUwZxy/DMZm2oBSssTqX1ecLXmJ2c5MaA3aE9s/ihocp/7TydQbWF
         8hshUHKK05cuOYP1KTbnxSmA9u37vqaKTzyvvda5AzR6aF/V/xIkMWiSP4KYutOiNwX4
         djWUz8ksTPfPht3QOhK+c0ntDj/Ij7yctlU3H4osEDtoUoyA/mp1qQlgBh60G1r++5U0
         IW4b8o3DWOAiZAijr1xi9kJDAqBPBuIA1C7aePIfxRTeX9zjx2cbU0xt0T+7hWRMWgw0
         wkPWMQddpw3LmOkGLu6E9g8PMGqWuqiiVii/jKCcRH+YosWAyH0yzZi1Lo7BQ+McQGsB
         QnQQ==
X-Gm-Message-State: AOAM531pkN8mRKUhVttq7MwRr/DmMBJBJHzy4pB+8XEhpmi1avAIn22/
        oM53Mcz7APVu2fy0idvckGbQ3CT/Fp0cthBx2aGeyQKS
X-Google-Smtp-Source: ABdhPJzxqz4P0QEy6slhmb2kxxRHdEdTJOkeE5VbJ+J0gQh2cqpTYdUWxyJKgMWTecfQ5sqTzGKFTOUv0cODBh9qEN8=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr6151664oiw.154.1637762221680;
 Wed, 24 Nov 2021 05:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20211027082237.26759-1-rui.zhang@intel.com> <20211027082237.26759-3-rui.zhang@intel.com>
 <CAJZ5v0juUmxM5gRa5WW=fXo18idRrKGpYmNTF=JFVf5hmscW2Q@mail.gmail.com> <4d8621a923adf4268a2120f517f0897fd4df6b80.camel@intel.com>
In-Reply-To: <4d8621a923adf4268a2120f517f0897fd4df6b80.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 14:56:50 +0100
Message-ID: <CAJZ5v0ijnD3WOCQ0==qiCm2iDCG_q-dRYxYUQ5XP2n9vgv9bjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] intel_idle: fix cpuidle_device unregistration
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 24, 2021 at 2:44 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Wed, 2021-11-24 at 14:20 +0100, Rafael J. Wysocki wrote:
> > On Wed, Oct 27, 2021 at 10:07 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > >
> > > cpuidle_device is allocated as percpu data, and it is registered
> > > for every
> > > CPU that has ever been onlined.
> > > When unregistering, checking current online CPUs is not sufficient,
> > > because some cpu may be offlined later with its cpuidle_device
> > > registered.
> >
> > But the unregistration happens only in the error code path of
> > intel_idle_init(), doesn't it?
>
> yes.
> >
> > While I agree that doing a for_each_present_cpu() walk for that is
> > more prudent', I'm not sure if that makes any difference in practice.
>
> And yes, exactly.
> This is not a problem as long as intel_idle driver can not be unloaded.
>
> There is no technical gap either to unregister the intel_idle cpuidle
> driver, or to unload the intel_idle module. And this potential issue
> will be exposed only when we decided to do so.
>
> If you prefer to describe this *potential* issue more precisely, I
> totally agree.
> If you want to fix it only when really needed, that's also okay to me.

I would prefer to fix it first and then extend as needed.
