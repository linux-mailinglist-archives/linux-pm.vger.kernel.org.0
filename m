Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA18918A723
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 22:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCRVhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 17:37:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45640 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRVhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 17:37:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id e9so185731otr.12
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2020 14:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/LjTXDxpowMwP1P8geARIgSvCBTa/4IIeP31kPobGY=;
        b=su+/5SEXQ1st0XO2L/GMdus793gRIqoNrLIEwD1w2mHlLohGOin4g6VmBZ/s25cVAQ
         hWiWyYGz0kTJgraNWiA10ndm8k2+1e2ppxivjRE9M5qx4YVNTrTkRgeVnSC/xK8/qF+R
         9AWWpn+EKp1NBY887n27pJqW8wuBC0I+4Ql5kUxBl3r2DboWEHgSKbgHDafgUZFNbNxJ
         qiJeGZ31ym99YISkjMx4KLlEVHx/TsvijGhppFEYzZylZpdRwWlGieUPMKTQgM2AQ8Uu
         cbWm+mgPsTSTNJt+ETXmB8RJrB2TLrIF0aFZ99A5AJoEvxlSG/H0QLkHbSja+OP6+1pq
         Z7CA==
X-Gm-Message-State: ANhLgQ1DbI84AVncUEi9zV8IlBqb53gnJvr3LFFXpSjsJTOipiXzxM4i
        IE2jt/ibV1QCM7xdpnB8PWLxZkcwl6O70ErqYgG5pg==
X-Google-Smtp-Source: ADFU+vvzPv5H2RYWiQCahYOtiEESGIsq6M9fCsen+LB7h5ZTrZLpKZXXYJ6s/HKEkbmnSYzISqMW2Y9WrVeMzROSQXk=
X-Received: by 2002:a9d:649a:: with SMTP id g26mr5858475otl.266.1584567431742;
 Wed, 18 Mar 2020 14:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>
In-Reply-To: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Mar 2020 22:37:00 +0100
Message-ID: <CAJZ5v0iYojtO=FJR4PuB_XDcLKiE2xXUWTvON-jQJJa+OBw18Q@mail.gmail.com>
Subject: Re: RFH with debugging suspend issues
To:     Jonas Meurer <jonas@freesources.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Tim Dittler <tim.dittler@systemli.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 9, 2020 at 12:14 PM Jonas Meurer <jonas@freesources.org> wrote:
>
> Hello,
>
> I'm searching for help with debugging a suspend issue:
>
> Apparently, on some devices (Lenovo laptops in particular), the kernel
> causes a I/O operation on the root filesystem when suspending the system
> - even though the final sync[1] is disabled thanks to setting
> `/sys/power/sync_on_suspend` to 0, see my corresponding patch that got
> accepted in Linux 5.6[2].

And that's how it goes.  There is no guarantee whatever that there
will be no I/O carried out during system-wide suspend without the
sync.

> My current guess it that some hardware-specific firmware is loaded
> during system suspend. But unfortunately, so far I failed to find what
> exactly it is despite following the 01.org debugging documentation[3].
> Maybe you can help me shed some light on it?
>
> The problem I'm facing is the following:
>
> When luksSuspending my LUKS encrypted root file system just before
> running `echo mem >/sys/power/state` on a Lenovo Thinkpad, the kernel
> suspend function freezes my system..
> *BUT*: If I first run `echo mem >/sys/power/state` without luksSuspend,
> and do the luksSuspend + system suspend thing after a successful first
> system suspend, then my luksSuspend + system suspend succeeds reproducibly.
>
> So apparently, at the first system suspend, something triggers a disk
> I/O operation that isn't triggered at subsequent system suspends.

I'm not quite sure how you arrived at this conclusion.  Can you
elaborate, please?

> Do you have an idea what that could be and how to further debug it?

Not really.

> To give some context: together with Tim (Cc'ed), I'm working on
> automatically suspending encrypted LUKS devices during system suspend in
> Debian. Our code basically uncompresses the initramfs image into a
> ramfs, chroots into it, luks-suspends all encrypted LUKS devices and
> sends the system to suspend mode. After resume, commands to unlock/
> resume the suspended LUKS devices are executed.

Sounds interesting. :-)

Unfortunately, I'm not familiar with LUKS at all, so I cannot give you
any useful advice on that particular topic.
