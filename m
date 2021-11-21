Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26FD4582F5
	for <lists+linux-pm@lfdr.de>; Sun, 21 Nov 2021 11:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhKUKlR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Nov 2021 05:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbhKUKlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Nov 2021 05:41:16 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C9C061574
        for <linux-pm@vger.kernel.org>; Sun, 21 Nov 2021 02:38:08 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id t83so15013304qke.8
        for <linux-pm@vger.kernel.org>; Sun, 21 Nov 2021 02:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=U9bFR249i87O1O0XPfRpKNbBGz5PrHpUlHvoVmWvuzA=;
        b=eCn3D9mtV46ljDY5xS+kCxoggT1kaIPz1Ge1sOeN4GQPfu4GQ/5jk5sENRklWZvAyi
         ukDF+y5c0eKWA37eLrA9XklYRNpDFlEMrH5BqT9fDM2gdtlstnFjiUd6HvFevbe/9d7B
         rVPWNmhRSxgJ7Y4zkXPvAFXl3N8eGyGTm4Vfn8RsbGuqh5rCnv+HU4jkyQYjxEQ+FqDi
         nfODArPTkiSgC0wzw2qE/a2kgUs405VIFDXgyNMNs8QCUCRDGTQaWLPIWQtyKakOv0zI
         B1P8RNgHT8I21d7qgihIOfR0Bzwv+r8GBd1OE0xyKaNsB0NZ+1tVf0JJUcYD38ZlgBW2
         vHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=U9bFR249i87O1O0XPfRpKNbBGz5PrHpUlHvoVmWvuzA=;
        b=bv8vB3H5nfpOZzc0K4BCm1eI8XsTdp8le77R2JGVv39LvO+3m6BTHK/obQXeoadPkI
         7S1X9zmo1GM8zyFdMSjs/DqM7LcgkpmlGrrA8iNkdal6jRi1mc+faLWAn7RlrDLbXakB
         /OoRklmj7w2mMub4iohmEtmNyPzlZzxfd3Sqz0m0rNUVD/nXX3T425Obg62fFUosM0xZ
         6pzEXe/QBuGkK248mUPH8JQeRM4uZcaySv4Kt0rsR45MdJ2TTo/Mge9317S+XkzCm+VV
         WkJ4JOBqXHHdwAYSExLI57rujXW1TxSwT1d+rxuhU371Bd0V855oXcTNf/HYAW93c0Gn
         NJCg==
X-Gm-Message-State: AOAM532pUXHmcJq3c+Px480zjaDKAJs10wG5QzvzBIbpiw6DlyQPjHbd
        UxVTGQ5HiiMtZ4NaANdsNzuRCDHKHTF/bCHHjUIFC6HaJyk=
X-Google-Smtp-Source: ABdhPJyjlzEC5cEZZDAK2e7QOo76YyrnajAt+/ruiPjB4tOuNnHaXav/q29Nf1UeBZk6JpidwFwg3I7qFt/JFpy7ozw=
X-Received: by 2002:a05:620a:1004:: with SMTP id z4mr41711678qkj.243.1637491086889;
 Sun, 21 Nov 2021 02:38:06 -0800 (PST)
MIME-Version: 1.0
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Sun, 21 Nov 2021 10:37:56 +0000
Message-ID: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
Subject: AMD Pstate
To:     Huang Rui <ray.huang@amd.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

I'm not subscribed to the mailing list so apologies for emailing you direct=
ly

It looks like something isn't quite right with the kconfig selects

SCHED_MC_PRIO can't be enabled without CPU_SUP_INTEL



=E2=94=82 Symbol: X86_AMD_PSTATE [=3Dy]

                                                              =E2=94=82
 =E2=94=82 Type  : bool

                                                               =E2=94=82
 =E2=94=82 Defined at drivers/cpufreq/Kconfig.x86:37

                                                               =E2=94=82
 =E2=94=82   Prompt: AMD Processor P-State driver

                                                               =E2=94=82
 =E2=94=82   Depends on: CPU_FREQ [=3Dy] && X86 [=3Dy]

                                                               =E2=94=82
 =E2=94=82   Location:

                                                               =E2=94=82
 =E2=94=82     Main menu

                                                               =E2=94=82
 =E2=94=82       -> Power management and ACPI options

                                                               =E2=94=82
 =E2=94=82         -> CPU Frequency scaling

                                                               =E2=94=82
 =E2=94=82           -> CPU Frequency scaling (CPU_FREQ [=3Dy])

                                                               =E2=94=82
 =E2=94=82 Selects: ACPI_PROCESSOR [=3Dy] && ACPI_CPPC_LIB [=3Dn] &&
CPU_FREQ_GOV_SCHEDUTIL [=3Dy]



=E2=94=82 Symbol: ACPI_CPPC_LIB [=3Dn]

                                                              =E2=94=82
 =E2=94=82 Type  : bool

                                                               =E2=94=82
 =E2=94=82 Defined at drivers/acpi/Kconfig:268

                                                               =E2=94=82
 =E2=94=82   Depends on: ACPI [=3Dy] && ACPI_PROCESSOR [=3Dy]

                                                               =E2=94=82
 =E2=94=82 Selects: MAILBOX [=3Dn] && PCC [=3Dn]

                                                               =E2=94=82
 =E2=94=82 Selected by [n]:

                                                               =E2=94=82
 =E2=94=82   - X86_INTEL_PSTATE [=3Dn] && CPU_FREQ [=3Dy] && X86 [=3Dy] && =
X86_64
[=3Dy] && ACPI [=3Dy] && SCHED_MC_PRIO [=3Dn]
                                                                  =E2=94=82
 =E2=94=82   - X86_AMD_PSTATE [=3Dy] && CPU_FREQ [=3Dy] && X86 [=3Dy] && X8=
6_64 [=3Dy]
&& ACPI [=3Dy] && SCHED_MC_PRIO [=3Dn]
                                                               =E2=94=82
 =E2=94=82   - ACPI_CPPC_CPUFREQ [=3Dn] && CPU_FREQ [=3Dy] && (ARM || ARM64=
) &&
ACPI_PROCESSOR [=3Dy]



=E2=94=82 Symbol: SCHED_MC_PRIO [=3Dn]

                                                              =E2=94=82
 =E2=94=82 Type  : bool

                                                               =E2=94=82
 =E2=94=82 Defined at arch/x86/Kconfig:1029

                                                               =E2=94=82
 =E2=94=82   Prompt: CPU core priorities scheduler support

                                                               =E2=94=82
 =E2=94=82   Depends on: SCHED_MC [=3Dy] && CPU_SUP_INTEL [=3Dn]

                                                               =E2=94=82
 =E2=94=82   Location:

                                                               =E2=94=82
 =E2=94=82     Main menu

                                                               =E2=94=82
 =E2=94=82       -> Processor type and features

                                                               =E2=94=82
 =E2=94=82 (1)     -> Multi-core scheduler support (SCHED_MC [=3Dy])

                                                               =E2=94=82
 =E2=94=82 Selects: X86_INTEL_PSTATE [=3Dn] && CPU_FREQ [=3Dy]



I've used this patch to work around the issue:

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee01546..bdfcf155f48e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1028,8 +1028,8 @@ config SCHED_MC

config SCHED_MC_PRIO
       bool "CPU core priorities scheduler support"
-       depends on SCHED_MC && CPU_SUP_INTEL
-       select X86_INTEL_PSTATE
+       depends on SCHED_MC && CPU_SUP_AMD
+       select X86_AMD_PSTATE
       select CPU_FREQ
       default y
       help

Which gets things working here
