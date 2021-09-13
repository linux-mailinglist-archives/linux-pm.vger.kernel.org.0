Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43E1409A99
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbhIMRZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:25:05 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45859 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbhIMRY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 13:24:59 -0400
Received: by mail-oi1-f179.google.com with SMTP id j66so2935893oih.12;
        Mon, 13 Sep 2021 10:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iVxQRQB36TAj9OZg4tC/QuKQkIXEC+nRLpJKX9NbXo=;
        b=lmZk2Cdc81A7efq7vCFF0oDXr45tfhZeAHzuCfXDw+v3KskXBfURVxyZ4rE3vtnKie
         D3FjSkoceW3R9SQ7hsNDBQAXn+bUVGfGJKxta7i9OEW6bp9GS+CmVj4hPMtQ2IbOIl5V
         kZOzkW9YQQH+c1lDY5MLwjTAzlqAW4XMqx16em7oWjyCvicu9gOH+jStmlyA+9skcsZW
         Nn+6rFy+DE+VoJiHIWt8/tzgYeBjR/0Yp5KKNBdkVBpahYBBE42qNb5u0OWWkNl8qOMW
         WT78j/IX3Dy/y1zng4YBtOXo/ogN/FXT/l87Kk2tbZCp7C5OZsqAnxv4So13PTNoQgGr
         ln3Q==
X-Gm-Message-State: AOAM532QRYlDLh9XsFUFgrQgZH8PpX04EymR46IpbbDb43uG2l8fJnPZ
        +/iHS+XA9/mv/dZEhn92oMkbMbFIyu7AY94EuX8=
X-Google-Smtp-Source: ABdhPJz+IKuBM90R/GwmNMgEM3fziO42XrK3F65t4bfmQqdcGBaLs65Qj4VhMezhc41dGAjaBOhrxIR5kbUhGo4bqHo=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr8629968oie.71.1631553823574;
 Mon, 13 Sep 2021 10:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210908214146.8640-1-mario.limonciello@amd.com> <20210908214146.8640-2-mario.limonciello@amd.com>
In-Reply-To: <20210908214146.8640-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Sep 2021 19:23:32 +0200
Message-ID: <CAJZ5v0gip6L0cDxUJq-LsG4khmS0QW=xs5jAQr+OY6i28XBnwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/acpi: Don't add CPUs that are not online capable
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 8, 2021 at 11:41 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> A number of systems are showing "hotplug capable" CPUs when they
> are not really hotpluggable.  This is because the MADT has extra
> CPU entries to support different CPUs that may be inserted into
> the socket with different numbers of cores.
>
> Starting with ACPI 6.3 the spec has an Online Capable bit in the
> MADT used to determine whether or not a CPU is hotplug capable
> when the enabled bit is not set.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html?#local-apic-flags
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I've added the patches in this series to my queue, but given what this
one does, I think that it's a bit risky, because it exposes the kernel
to a new category of possible platform firmware bugs.

For this reason, I'd rather queue it up as 5.16 material (and of
course x86 reviewer comments are welcome).

> ---
>  arch/x86/kernel/acpi/boot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> Changes from v1 -> v2:
>  * Make the change only apply on ACPI 6.3 or later
> Changes from v2 -> v3:
>  * Make acpi_support_online_capable static and only valid if CONFIG_X86_LOCAL_APIC is defined
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index e55e0c1fad8c..d915f01b582b 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -62,6 +62,7 @@ int acpi_fix_pin2_polarity __initdata;
>
>  #ifdef CONFIG_X86_LOCAL_APIC
>  static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
> +static bool acpi_support_online_capable;
>  #endif
>
>  #ifdef CONFIG_X86_IO_APIC
> @@ -138,6 +139,8 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
>
>                 pr_debug("Local APIC address 0x%08x\n", madt->address);
>         }
> +       if (madt->header.revision >= 5)
> +               acpi_support_online_capable = true;
>
>         default_acpi_madt_oem_check(madt->header.oem_id,
>                                     madt->header.oem_table_id);
> @@ -239,6 +242,12 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
>         if (processor->id == 0xff)
>                 return 0;
>
> +       /* don't register processors that can not be onlined */
> +       if (acpi_support_online_capable &&
> +           !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +               return 0;
> +
>         /*
>          * We need to register disabled CPU as well to permit
>          * counting disabled CPUs. This allows us to size
> --
> 2.25.1
>
