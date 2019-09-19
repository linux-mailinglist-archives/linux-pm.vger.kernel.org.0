Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3CB7F6B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfISQxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 12:53:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36255 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfISQxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 12:53:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id 67so3729452oto.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 09:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZTc9sjZpy2gPmBVd6B4A7rZq/01al/4hqPyP/T6m0c=;
        b=qIYl0Pvvdxxnu51Lsj7vgi8Nzvz2FsV6hrpusw6Pk5a1PxfDbnzI/dvyYU5UsKKEid
         gV5w6SuEjoM8SJTfsXR11XUG5+dQYow7U6JvPsOabHDkao1cPiDd5VFHUJnQN8WGsZcR
         Oyjer2GlyKSkJYIqkgXxM/j4oP2QYrboNjorO+oPvcyN957My83U7RUfuqVKnzj722LF
         iCDTaAB2Zii8YtLT8NPKQwDYCCzQsmpbms+0JOllbZLXyIBaSSdUakOEqeuQax79+oEF
         yXwdf9bYvVKU8LchTTJVQHaD4GF62xwpZm/ivphGOO/1sYm2Laf0NmJgRwrhgZGp3Y7J
         WjGA==
X-Gm-Message-State: APjAAAVBvdPQWiRJb44tCRPrnCvtOM+tsNbv19+VGnN1DaRdt+Ahq30q
        9W8y8YIkuksIVQxo9ieYzwVLMMEf6aGW2rTHXdM=
X-Google-Smtp-Source: APXvYqzpDCPy4j0EnUU7PNnNt1KJKQ+8tSeRLJndMsn+R/SHMFNEa0G+ILxK3XV1RJdrMKR7QUl8a59sKyNSqFhmBLs=
X-Received: by 2002:a05:6830:9:: with SMTP id c9mr7630302otp.262.1568911993451;
 Thu, 19 Sep 2019 09:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n> <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com>
 <alpine.DEB.2.21.1909190444190.2973@hp-x360n> <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
 <alpine.DEB.2.21.1909190909440.2973@hp-x360n> <alpine.DEB.2.21.1909190930190.2842@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1909190930190.2842@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Sep 2019 18:53:02 +0200
Message-ID: <CAJZ5v0iQp4MNCY-ksGTaTntnmaARSZaOW4sX49zqavtSUvo=Xw@mail.gmail.com>
Subject: Re: Help me help you debug what seems to be an EC resume issue
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 6:35 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> > BTW, is there any way to determine which devices are still on (out of d3cold)
> > at the time the kernel relinquishes control to the BIOS/ACPI as the last thing
> > to happen at suspend?

In the suspend-to-idle case the BIOS doesn't get control at all.

I would recommend to read

https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux

at this point if you have not done it yet.

> So I turned on "DEBUG" at the top of ".../include/linux/acpi.h"
> I have no idea if I'm reading this correctly, but does this mean that there are
> devices that will always(?) stay in d3hot during s2idle?
>
> If this is the case, is there anything I can/should do about it?

Not really.  That's just debug output.
