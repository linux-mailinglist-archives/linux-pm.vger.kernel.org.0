Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080031039AE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfKTMMG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:12:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729598AbfKTMMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574251924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VF+bQZFHPewNnM9aH9KyZQntlM8F2dUwAxVJVb/6oKY=;
        b=BRMvBy0jr6Cl7DF+3UNGZo3rjEa3ndIOh44ahtijq+vY8thtK4qQKQG/adR0rb5RqFX2La
        j/FCO8gVonNnmDnprlVcE7/k11Xgg7+hbuXhiDlo5dhNxTOEebod66yjSqYxZUtV+RXigH
        GjJmuXTdJUzUwwhwtOfEsy8BByTm7dI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-7vUJX46aOuCVV71oDZZjLw-1; Wed, 20 Nov 2019 07:12:03 -0500
Received: by mail-qk1-f197.google.com with SMTP id v9so6101236qkj.14
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VF+bQZFHPewNnM9aH9KyZQntlM8F2dUwAxVJVb/6oKY=;
        b=H4QM/7wEpfDqzYIziSeJoT1CQYeQEKv2xciXwiOZowFs3BdEflJl4voAkL8YmHnXKm
         XaXA7srzChxf8TMghVy59Bg0Txe2Vpj2Vz1p+oYr8MgFA0FFZgNo9F2q4nmL9rREnGzj
         qFvjWxAvC2o3lw9ES7xxYoAHT+94k16ZYgU4T6yVXqtd5UyXL8T1sRbfPCXLu/Va4zmW
         F8wL9yJlIJGNwYZ1AjJwBcJPPalXqsBwKd7UXTE0aHFXrMqTh+mLvten8MGrxOCI2eU3
         9pOha3pquSOvNBT3Zl46jBmMToN2p/OIzoXzPbgLHA7FcpRxA60zCDT1ESVtU9RW/7zM
         0Gsg==
X-Gm-Message-State: APjAAAWfLsUJxnM+cTbKZsu2+MtqR4WVYzRS0b//ZDc6kbbB4R9QIxfF
        /hhbuL9VuTKob6z6fvjDcBAlmAH302N8vLnFhl5Sipz78MZgPYvkoT6f5ATKHxL/z0FsvnOOCi+
        cN0F61gmVrcaqEGfVYwxVEnQPn5MdqSdUaWQ=
X-Received: by 2002:a37:9083:: with SMTP id s125mr2044111qkd.192.1574251923299;
        Wed, 20 Nov 2019 04:12:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBAA4TCCMTkJLA3fk7uQ/livSO00sZJsFKKfFUtKcydvGnjFRyWiHk4b/E6hpfbS10eFj88YdwU+FKUdPz0cI=
X-Received: by 2002:a37:9083:: with SMTP id s125mr2044079qkd.192.1574251923040;
 Wed, 20 Nov 2019 04:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com> <20191120120913.GE11621@lahna.fi.intel.com>
In-Reply-To: <20191120120913.GE11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 13:11:52 +0100
Message-ID: <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: 7vUJX46aOuCVV71oDZZjLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 20, 2019 at 1:09 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 12:58:00PM +0100, Karol Herbst wrote:
> > overall, what I really want to know is, _why_ does it work on windows?
>
> So do I ;-)
>
> > Or what are we doing differently on Linux so that it doesn't work? If
> > anybody has any idea on how we could dig into this and figure it out
> > on this level, this would probably allow us to get closer to the root
> > cause? no?
>
> Have you tried to use the acpi_rev_override parameter in your system and
> does it have any effect?
>
> Also did you try to trace the ACPI _ON/_OFF() methods? I think that
> should hopefully reveal something.
>

I think I did in the past and it seemed to have worked, there is just
one big issue with this: it's a Dell specific workaround afaik, and
this issue plagues not just Dell, but we've seen it on HP and Lenovo
laptops as well, and I've heard about users having the same issues on
Asus and MSI laptops as well.

I will spend some time to collect all the necessary information,
create a bug to put it all in there and send out a v5 with the updated
information and references to this bug.

