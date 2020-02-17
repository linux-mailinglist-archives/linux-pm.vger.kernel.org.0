Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA7161C1F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 21:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgBQUGd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 15:06:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35354 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgBQUGd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 15:06:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so17313936otd.2;
        Mon, 17 Feb 2020 12:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2E+C/i50SzbxX+GbIPms7/GnK56JF2oC6jfMglSKU8=;
        b=NMeRDoz/vWlg+IaZKFSpD7ttqM9y/N0FS6XN6CoMTKCG0spElCn9RVsApbl6SPQlwF
         IhD7a5i6YMiS4NtdH074EV/ndyXKufn6jKaxL4mODUvsTnMQ4WSpWyBjP/DYZQkGtLtJ
         5r9T/NtWc8CUET5zg9zldbgZRIcdc4Sw/IMrpb33XHuWHnfUarwErTlGaJXrHWYJNrDh
         vZDGtERcvG7K57nVthE+lxoVfkIrk5+lpkbitZ/k3ygyfRfczxx+y9PtCSR5zyXhUCTB
         Vy/DejrzFvDDvTnwdZ8fqb/K9KnZasDq3jgYZ2Q1XFRMTwX/7o8l75AYysSCjuIMwmS2
         clKw==
X-Gm-Message-State: APjAAAWUjQz7adE7P6n4mp9ca4+dNi01Hu4FKBpHAeyLRugwQMHTIVzY
        jyT1MK7CE7UKtiXH2clSG7PRBD5f8x+AR/V21kmb6w==
X-Google-Smtp-Source: APXvYqx13YjUJPbDUgstSkyslXQIQ4L5MaVWTFHFHi0XOwMI1Tl8jiPMXxL0VdE2Kob0oYNgusXZthW8zxOte+A9bnU=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr13410100otn.262.1581969991666;
 Mon, 17 Feb 2020 12:06:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581956285.git.mchehab+huawei@kernel.org> <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
In-Reply-To: <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Feb 2020 21:06:20 +0100
Message-ID: <CAJZ5v0jsQ51cp3LQ8qjmMj6tZJPC=t9Y_5SN78fLWe0mpJX08g@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] docs: cpu-freq: convert index.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 17, 2020 at 5:20 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> most of the stuff there can be re-used with ReST format,
> but we need to add an empty TOC and remove the existing
> entries, as the following conversion patches will be re-adding
> them, as they're converted.

I see a very little value in converting the files in the cpu-freq
directory from .txt to .rst, which I have told you at least twice.

They are just old-style driver API documents for cpufreq, but moving
them under driver-api/ as they are would not be a good idea IMO,
because at least some of them are outdated (note that the admin-guide
part of the cpufreq documentation, in the .rst format, is located
under admin-guide/).

I haven't had the time to write a proper replacement for them yet and
honestly I find it quite obnoxious to see these reoccurring attempts
to blindly convert them to .rst without taking care of their contents
and location.

I will take care of these files at one point as promised, but that's
not going to happen today or tomorrow and please just leave them alone
if that is not a big deal.

Thanks!

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/cpu-freq/index.rst | 35 ++++++++++++++++++++
>  Documentation/cpu-freq/index.txt | 56 --------------------------------
>  Documentation/index.rst          |  1 +
>  3 files changed, 36 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/cpu-freq/index.rst
>  delete mode 100644 Documentation/cpu-freq/index.txt
>
> diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
> new file mode 100644
> index 000000000000..1bff3dfddd23
> --- /dev/null
> +++ b/Documentation/cpu-freq/index.rst
> @@ -0,0 +1,35 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================================================================
> +Linux CPUFreq - CPU frequency and voltage scaling code in the Linux(TM) kernel
> +==============================================================================
> +
> +Author: Dominik Brodowski  <linux@brodo.de>
> +
> +   Clock scaling allows you to change the clock speed of the CPUs on the
> +   fly. This is a nice method to save battery power, because the lower
> +   the clock speed, the less power the CPU consumes.
> +
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +Mailing List
> +------------
> +There is a CPU frequency changing CVS commit and general list where
> +you can report bugs, problems or submit patches. To post a message,
> +send an email to linux-pm@vger.kernel.org.
> +
> +Links
> +-----
> +the FTP archives:
> +* ftp://ftp.linux.org.uk/pub/linux/cpufreq/
> +
> +how to access the CVS repository:
> +* http://cvs.arm.linux.org.uk/
> +
> +the CPUFreq Mailing list:
> +* http://vger.kernel.org/vger-lists.html#linux-pm
> +
> +Clock and voltage scaling for the SA-1100:
> +* http://www.lartmaker.nl/projects/scaling
> diff --git a/Documentation/cpu-freq/index.txt b/Documentation/cpu-freq/index.txt
> deleted file mode 100644
> index c15e75386a05..000000000000
> --- a/Documentation/cpu-freq/index.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -     CPU frequency and voltage scaling code in the Linux(TM) kernel
> -
> -
> -                        L i n u x    C P U F r e q
> -
> -
> -
> -
> -                   Dominik Brodowski  <linux@brodo.de>
> -
> -
> -
> -   Clock scaling allows you to change the clock speed of the CPUs on the
> -    fly. This is a nice method to save battery power, because the lower
> -            the clock speed, the less power the CPU consumes.
> -
> -
> -
> -Documents in this directory:
> -----------------------------
> -
> -amd-powernow.txt -     AMD powernow driver specific file.
> -
> -core.txt       -       General description of the CPUFreq core and
> -                       of CPUFreq notifiers.
> -
> -cpu-drivers.txt -      How to implement a new cpufreq processor driver.
> -
> -cpufreq-nforce2.txt -  nVidia nForce2 platform specific file.
> -
> -cpufreq-stats.txt -    General description of sysfs cpufreq stats.
> -
> -index.txt      -       File index, Mailing list and Links (this document)
> -
> -pcc-cpufreq.txt -      PCC cpufreq driver specific file.
> -
> -
> -Mailing List
> -------------
> -There is a CPU frequency changing CVS commit and general list where
> -you can report bugs, problems or submit patches. To post a message,
> -send an email to linux-pm@vger.kernel.org.
> -
> -Links
> ------
> -the FTP archives:
> -* ftp://ftp.linux.org.uk/pub/linux/cpufreq/
> -
> -how to access the CVS repository:
> -* http://cvs.arm.linux.org.uk/
> -
> -the CPUFreq Mailing list:
> -* http://vger.kernel.org/vger-lists.html#linux-pm
> -
> -Clock and voltage scaling for the SA-1100:
> -* http://www.lartmaker.nl/projects/scaling
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index e99d0bd2589d..4cf37ad1cd1d 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -99,6 +99,7 @@ needed).
>     accounting/index
>     block/index
>     cdrom/index
> +   cpu-freq/index
>     ide/index
>     fb/index
>     fpga/index
> --
> 2.24.1
>
