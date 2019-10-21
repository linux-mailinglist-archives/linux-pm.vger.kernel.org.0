Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DCDEB7B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfJUMA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 08:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfJUMA7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Oct 2019 08:00:59 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 312BF859FE
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 12:00:59 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id v143so13157317qka.21
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 05:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3fNeTrb8zczujjHnQNEjI0XuAROR+Pj6w/x2dFfu/8=;
        b=JwfGMorwXpEBRn67VCwe77MtZlruyGDYx7bYQ+fvmETHw6vAMTmCLNEMQx7Op0RjEi
         whju71qLMP5iSSb03WdBBj5iTCtenOZprM3+/uhnjJPhoAkE0V0LIGt1/5okyP3Ln0Aq
         xE5r1xlLSbia3CaLHVXgjdTYuF5A91ec0ojl4VCv3v+dnz5CeAsO4zqjfLtFEa1dR1E1
         8oM2kCwvp8zD4yqA+MdIFzNU7ubCuluH02UlNsURuBqTMckbu9gdBQUDLHl350ZRoFhf
         Gfc3V9m6MkDwWEPDWnMYxjGauIO/vEopv9X8tCb6yce+tKraBQ2kJu7TzO82kfz6oX0o
         9BNA==
X-Gm-Message-State: APjAAAWnBFFUnQSrhyPUqzjO6TbnGeqmRTdujGYtF7WJl2YP1HHHvEkZ
        ZxP06nFsaEVq/KtL8Gwj6LEjTCMO8L37VNltRMAy63v3SS4SyI7JB9qQLKFo1yr5ftr7FGfuwGx
        b7FACc+FKctgm0KBJ9NG6s1RMZfR1b0HPNig=
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22668516qkj.102.1571659258422;
        Mon, 21 Oct 2019 05:00:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLKUy/SzC+Ir3UqXb3Coc4vgrt7sjwm3oLMxhXO6j4sAHWuzrRvXNIFYbci0UPZXZOe/I7+Lh9FVGm0cooVzg=
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22668481qkj.102.1571659258106;
 Mon, 21 Oct 2019 05:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191016144449.24646-1-kherbst@redhat.com> <20191021114017.GY2819@lahna.fi.intel.com>
In-Reply-To: <20191021114017.GY2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 14:00:46 +0200
Message-ID: <CACO55tt2iGcySugTAb1khEYpiGoq6Os3upG5fGq+0PbE2gyyeQ@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 21, 2019 at 1:40 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> Hi Karol,
>
> Sorry for commenting late, I just came back from vacation.
>
> On Wed, Oct 16, 2019 at 04:44:49PM +0200, Karol Herbst wrote:
> > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > states.
> >
> > v2: convert to pci_dev quirk
> >     put a proper technical explanation of the issue as a in-code comment
> > v3: disable it only for certain combinations of intel and nvidia hardware
> >
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > ---
> >  drivers/pci/pci.c    | 11 ++++++++++
> >  drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>
> I may be missing something but why you can't do this in the nouveau
> driver itself?

What do you mean precisely? Move the quirk into nouveau, but keep the
changes to pci core?
