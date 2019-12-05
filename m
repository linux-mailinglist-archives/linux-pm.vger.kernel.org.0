Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C89113CF5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 09:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfLEIVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 03:21:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45875 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfLEIVL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 03:21:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id v10so1926662oiv.12
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 00:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swOlReUzTHH/0O+oOrjoZCzT8KMwdpVpqYYnprzqiZE=;
        b=KjKa042Yi8vAiA8lHN2eHMtfRiTNcqwG4jtpGLVwhQt0SE4FYomzUYUIhN3qyGuh/C
         IGDeZ7W8K8xWBMLFDLZ3uIwYWfInk489VLUoduiffMcppuOOzvG9bBDSgeX4pUsNJfV+
         V45tzvH5SbJvPjHL9lfxelt4iDHcInOTUjTW5BmTlY+XFfFQG4Dq3uzjgYYoj+JXHeYw
         s6zV7iW8aXeW4vYgQDF3ygAEmfFgEj3Y883dLoXbvE1beqdX+WBH/GVqxqctE9ApCTq5
         jCYDozyd6ZV0ZvysmH7RmtQoStit1lkJr3FB/Xf2XB/nR4IJwkHmDq4Z0iDh9F4trMsl
         uPuw==
X-Gm-Message-State: APjAAAVZo+ecsA63L9EYyCjH1cVl06Q+Zdl8B23nVZr0ZuZSnWOEqDta
        /5YyCS70FzS/D44Qi5583L/lX7ulM4KYB0DtU0jLFAib
X-Google-Smtp-Source: APXvYqzCjlzHBWZPMUFe5PrZNwgRM5SwNE1cYZHEnLV0dtp9SGm+77xXnbScEEToIbnbpwW88I+KXB82jDR/h+Z/E7g=
X-Received: by 2002:a54:488d:: with SMTP id r13mr5894382oic.115.1575534070549;
 Thu, 05 Dec 2019 00:21:10 -0800 (PST)
MIME-Version: 1.0
References: <3ebca53c-b8fa-1e7f-6d4e-abdc93cbf2a6@web.de>
In-Reply-To: <3ebca53c-b8fa-1e7f-6d4e-abdc93cbf2a6@web.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Dec 2019 09:20:59 +0100
Message-ID: <CAJZ5v0i6=NMjkHm7jRT7JD3OEO1tUe+xU_io67rztoZtNe=p8w@mail.gmail.com>
Subject: Re: baseline power consumtion kernel > 5.3.10
To:     Guido Riedel <guido.riedel@web.de>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 5, 2019 at 8:52 AM Guido Riedel <guido.riedel@web.de> wrote:
>
> Hi,
>
> Since Kernel 5.3.11 I got a significant increased baseline Power
> consumption. I tried up to 5.4.1 on arch linux. Powertop shows an
> increase from 3.6W on 5.3.10 to 5.x W on higher Kernels. My laptop fan
> spins a lot more.
>
> I read that a lot of Intel stuff has entered the Kernel in 5.3.11, could
> this cause it? Will it stay like this in the next Versions? Can I maybe
> switch something off etc. to get a lower baseline power?

That's possible.

It would be good to compare the general activity of the system
depending on which version of the kernel is in use.

The turbostat utility can be used for that.

It is included in the kernel source tree (tools/power/x86/turbostat/).
Build it, install it (the version from 5.4.1 can be used with older
kernels too), run it along with your normal workload for some time
with both 5.3.11 and 5.4.1, like this:

# turbostat --quiet --out=output_file sleep 600

(this will cause it to run until the "sleep 600" command is complete,
i.e. for 10 minutes).  Then post the output files from both runs.

Note that you need to run it as root (there is a man page etc).

Thanks!
