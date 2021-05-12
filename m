Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6066F37BEED
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhELNzE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 12 May 2021 09:55:04 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43932 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNzE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 09:55:04 -0400
Received: by mail-oi1-f173.google.com with SMTP id j75so22281531oih.10;
        Wed, 12 May 2021 06:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rwslISKq+Eb32KYbC5x+V91AQAjb+7O4nibVn89+djg=;
        b=sxYUR+1jrNyebGcBYWVZErPAKNHLqzm36MsVcg1QHzLVrfKk6HFXiYro8/AZ6KM9PB
         6Iend6+xwP6RQHhF8qaill3DZgfhejDk69W5bGRtano1iWMUtkLn+NJC05HY35Ru6JcL
         UBbIr1pDRL1VZg9nxjXBVclESodp5umymkk6zEc/2laLHajwXZq3C/Wep4F/77u2Pn9c
         gvy0sMSvQzfRiEjOzFIDhnqgI4VfNki/5IkmJlfn7fDxfEPQAP4HRmdQrB3ISbkAj+zd
         D1ZAnQ9kLaS/9f9Fpt0mlQpQGZii7gCmokFjGYtsYm5kW1QIDnwOrvI+s4OUM1HBrhwd
         KYOA==
X-Gm-Message-State: AOAM5330M21J1/VmgQVL9214lpmOz9uaLdvTdcevRFuSsEOmkXK03WCf
        lFxDx51MimTA6Hq/ZWItJUiWVm/x7KeX8BeM/is=
X-Google-Smtp-Source: ABdhPJwPgn4Nlty585qjJ8ZheLBSWbTbelXS1O1cn4etHKsVBW+4DO3z6bD5umNzEuxKcpxG0fWHlU8MqL4xbZl88vo=
X-Received: by 2002:aca:380a:: with SMTP id f10mr7758759oia.157.1620827635760;
 Wed, 12 May 2021 06:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620823573.git.mchehab+huawei@kernel.org> <f24d5bd469a42f4a97b9fa5de13575698789dcd6.1620823573.git.mchehab+huawei@kernel.org>
In-Reply-To: <f24d5bd469a42f4a97b9fa5de13575698789dcd6.1620823573.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 May 2021 15:53:44 +0200
Message-ID: <CAJZ5v0hzCjqWUVYUJ9n4LHgGicD6XgAmLPj4EwPfUySvaFmZYA@mail.gmail.com>
Subject: Re: [PATCH v2 05/40] docs: admin-guide: pm: Use ASCII subset instead
 of UTF-8 alternate symbols
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 2:52 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
> and some automatic rules which exists on certain text editors like
> LibreOffice turned ASCII characters into some UTF-8 alternatives that
> are better displayed on html and PDF.
>
> While it is OK to use UTF-8 characters in Linux, it is better to
> use the ASCII subset instead of using an UTF-8 equivalent character
> as it makes life easier for tools like grep, and are easier to edit
> with the some commonly used text/source code editors.
>
> Also, Sphinx already do such conversion automatically outside literal blocks:
>    https://docutils.sourceforge.io/docs/user/smartquotes.html
>
> So, replace the occurences of the following UTF-8 characters:
>
>         - U+2019 ('’'): RIGHT SINGLE QUOTATION MARK
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/admin-guide/pm/intel_idle.rst   | 4 ++--
>  Documentation/admin-guide/pm/intel_pstate.rst | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
> index 89309e1b0e48..c3c4f5d4c806 100644
> --- a/Documentation/admin-guide/pm/intel_idle.rst
> +++ b/Documentation/admin-guide/pm/intel_idle.rst
> @@ -28,7 +28,7 @@ logical CPU executing it is idle and so it may be possible to put some of the
>  processor's functional blocks into low-power states.  That instruction takes two
>  arguments (passed in the ``EAX`` and ``ECX`` registers of the target CPU), the
>  first of which, referred to as a *hint*, can be used by the processor to
> -determine what can be done (for details refer to Intel Software Developer’s
> +determine what can be done (for details refer to Intel Software Developer's
>  Manual [1]_).  Accordingly, ``intel_idle`` refuses to work with processors in
>  which the support for the ``MWAIT`` instruction has been disabled (for example,
>  via the platform firmware configuration menu) or which do not support that
> @@ -261,7 +261,7 @@ restrict the range of permissible idle states to the ones with core-level only
>  References
>  ==========
>
> -.. [1] *Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 2B*,
> +.. [1] *Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 2B*,
>         https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-vol-2b-manual.html
>
>  .. [2] *Advanced Configuration and Power Interface (ACPI) Specification*,
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
> index df29b4f1f219..d881a32acb6d 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -26,7 +26,7 @@ than just an operating frequency or an operating performance point (see the
>  LinuxCon Europe 2015 presentation by Kristen Accardi [1]_ for more
>  information about that).  For this reason, the representation of P-states used
>  by ``intel_pstate`` internally follows the hardware specification (for details
> -refer to Intel Software Developer’s Manual [2]_).  However, the ``CPUFreq`` core
> +refer to Intel Software Developer's Manual [2]_).  However, the ``CPUFreq`` core
>  uses frequencies for identifying operating performance points of CPUs and
>  frequencies are involved in the user space interface exposed by it, so
>  ``intel_pstate`` maps its internal representation of P-states to frequencies too
> @@ -756,7 +756,7 @@ References
>  .. [1] Kristen Accardi, *Balancing Power and Performance in the Linux Kernel*,
>         https://events.static.linuxfound.org/sites/events/files/slides/LinuxConEurope_2015.pdf
>
> -.. [2] *Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 3: System Programming Guide*,
> +.. [2] *Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3: System Programming Guide*,
>         https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
>
>  .. [3] *Advanced Configuration and Power Interface Specification*,
> --
> 2.30.2
>
