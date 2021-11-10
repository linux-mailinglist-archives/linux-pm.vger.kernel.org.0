Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190DC44CAA2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 21:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhKJUbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 15:31:35 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46057 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJUbf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 15:31:35 -0500
Received: by mail-oi1-f180.google.com with SMTP id u2so7421570oiu.12;
        Wed, 10 Nov 2021 12:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71g0hVNQ/HmZhx7GJjy6i5weBeQV0HZJWcsXB6BitqY=;
        b=Xfol6i4pm9CtT4rLzsoEmMX80jn5EbAz8Q8UtgnDl6CdgAAPSwZDQFBnxifty85Z6+
         jjBVbuHEnS0VT6xuWFQq9vkQ6BdMze25yu5YWbtYe/Tb7Z4N5U6kEDnxCO92iKbShmWo
         GwD8zBqWxPEWjeUS1UifE7kQXcl4ueqZFQyi1EihIVolcWz3DTFzRqqRk9+hfgoX8nSR
         m285SOdsRGffgejTD7LWtexnYUK6Yo4aoI/1GcOcUD2Cmo4OaFuc9Pr7TkXbHdxxRZRY
         DPv+KlrIoKH2vUrmSXp8hhbYAwiY8rLFxpVAjOSwYtiGkrjeAmQkvHOXS6ULgWXG4/ev
         GyHw==
X-Gm-Message-State: AOAM531n1+FSPS3e53HapfTMDFrB3BeRauwBcGogFGNkplZVGhPdmbiM
        SrGZSMtVEGs4KjVzlVCeS5dDEQCwn4tCU0LbZtg=
X-Google-Smtp-Source: ABdhPJyPHY3CrmAJQdBfHPMgVXDmFydTgdm87KTq2W3Ct1aVfVRJEelM47TSBt6anjo7vBlvEZIWCvGxOiHv83Zy14U=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr1650047oif.154.1636576126888;
 Wed, 10 Nov 2021 12:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20211102180144.1647-1-lukasz.luba@arm.com> <22bdfc88-983d-fc86-0abb-404eedf03274@arm.com>
In-Reply-To: <22bdfc88-983d-fc86-0abb-404eedf03274@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Nov 2021 21:28:35 +0100
Message-ID: <CAJZ5v0hf-ZG9RTpoyYhzZSLhy3HxcHDGgvfibPnb3oubx4cfNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: power: Add description about new
 callback for EM registration
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 9, 2021 at 11:38 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
>
> On 11/2/21 6:01 PM, Lukasz Luba wrote:
> > The Energy Model (EM) registration for CPUs should now be done using
> > a dedicated callback added recently into CPUFreq framework and drivers.
> >
> > Commit c17495b01b72 ("cpufreq: Add callback to register with energy model")
> >
> > The callback guaranties that the EM registration is called at the right
> > time during driver setup. To avoid mistakes update the documentation
> > to align with the existing code implementation.
> >
> > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > ---
> >   Documentation/power/energy-model.rst | 31 ++++++++++++++--------------
> >   1 file changed, 16 insertions(+), 15 deletions(-)
> >
>
>
> Gentle ping. Could you have a look at these documentation
> two patches and maybe pick them, please?
> They are trying to solve some confusion discussed with our partners
> recently.

Both applied as 5.16-rc material now, thanks!
