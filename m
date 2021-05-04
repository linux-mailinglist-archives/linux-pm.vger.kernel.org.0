Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D03726F0
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 10:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhEDIJg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 04:09:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60167 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEDIJg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 04:09:36 -0400
Received: from mail-oi1-f199.google.com ([209.85.167.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1ldq6j-0004yM-8i
        for linux-pm@vger.kernel.org; Tue, 04 May 2021 08:08:41 +0000
Received: by mail-oi1-f199.google.com with SMTP id s9-20020acadb090000b0290101bacefaa4so4567282oig.2
        for <linux-pm@vger.kernel.org>; Tue, 04 May 2021 01:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7snMEmI+fhOlxdU/CfqCczjaAies3jTJlLhdo4cx9qI=;
        b=nOyKuFcTpUsHgyc0mo7lonRZPEhlWMCTXXDS2KQCU7WcOjIe60OEKV4HDwlg5IFN6y
         u64VYkIq4uUsFZKaY5v6sIVu2Ir9K15KfHEro8D3nZkPal45s63N9PNIvuRrgBxfTxNk
         UW9X6vOqB5CKuh0yqT1eJaIs3W7YPOQ8RiCTK50HQxEWpr5Ljky9uH7074S8AeiIQ7Zl
         ZUy/J2xYelEHo8b9UWgi7YT9qbfIT/750HwbC4s093eZ+jOOUrLBxaLCL7QjGYec8Odi
         VNH7/b9cmtkzYHNvRAfmPe7QKZB0BEhPSt4LRGiWGINt1/bL11NqiFst43oofx+iQ7Mm
         AW8Q==
X-Gm-Message-State: AOAM530bWGcb2lu3u6U/OvKC1Dnyx8QrxVs+4rFLPLRCPIeCurgWFtLD
        6viwNBjPOz+SByVedE0yUO+6Pa/WgxJbNgSmEml6qcfdp1pNrBHkIKFtTLUkvvFJ0NTqb+vyYAX
        dEIzJumY0ozl1t692wzyWbLPZjjn4dtqS8Ko9jNSIjf8t2in/Yhb/
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr3800160oto.347.1620115719800;
        Tue, 04 May 2021 01:08:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFR5Zm3Pe2X7d2J6AVWBHROjCyWNPofZhzx+1Jh4XHk3l+k5mzPUgFdXvmSmSgjCnR7vFlRTmxdluvN02aBdA=
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr3800136oto.347.1620115719428;
 Tue, 04 May 2021 01:08:39 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Tue, 4 May 2021 16:08:28 +0800
Message-ID: <CABTNMG0Y5iAD4E8XFkOwrNTBHNDcNKRt=+BLPHs4tw5O2eVBDA@mail.gmail.com>
Subject: NVIDIA GPU fallen off the bus after exiting s2idle
To:     kherbst@redhat.com, bhelgaas@google.com, rjw@rjwysocki.net,
        mika.westerberg@intel.com, len.brown@intel.com
Cc:     linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
    We have some Intel laptops (11th generation CPU) with NVIDIA GPU
suffering the same GPU falling off the bus problem while exiting
s2idle with external display connected. These laptops connect the
external display via the HDMI/DisplayPort on a USB Type-C interfaced
dock. If we enter and exit s2idle with the dock connected, the NVIDIA
GPU (confirmed on 10de:24b6 and 10de:25b8) and the PCIe port can come
back to D0 w/o problem. If we enter the s2idle, disconnect the dock,
then exit the s2idle, both external display and the panel will remain
with no output. The dmesg as follows shows the "nvidia 0000:01:00.0:
can't change power state from D3cold to D0 (config space
inaccessible)" due to the following ACPI error
[ 154.446781]
[ 154.446783]
[ 154.446783] Initialized Local Variables for Method [IPCS]:
[ 154.446784] Local0: 000000009863e365 <Obj> Integer 00000000000009C5
[ 154.446790]
[ 154.446791] Initialized Arguments for Method [IPCS]: (7 arguments
defined for method invocation)
[ 154.446792] Arg0: 0000000025568fbd <Obj> Integer 00000000000000AC
[ 154.446795] Arg1: 000000009ef30e76 <Obj> Integer 0000000000000000
[ 154.446798] Arg2: 00000000fdf820f0 <Obj> Integer 0000000000000010
[ 154.446801] Arg3: 000000009fc2a088 <Obj> Integer 0000000000000001
[ 154.446804] Arg4: 000000003a3418f7 <Obj> Integer 0000000000000001
[ 154.446807] Arg5: 0000000020c4b87c <Obj> Integer 0000000000000000
[ 154.446810] Arg6: 000000008b965a8a <Obj> Integer 0000000000000000
[ 154.446813]
[ 154.446815] ACPI Error: Aborting method \IPCS due to previous error
(AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
[ 154.446824] ACPI Error: Aborting method \MCUI due to previous error
(AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
[ 154.446829] ACPI Error: Aborting method \SPCX due to previous error
(AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
[ 154.446835] ACPI Error: Aborting method \_SB.PC00.PGSC due to
previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
[ 154.446841] ACPI Error: Aborting method \_SB.PC00.PGON due to
previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
[ 154.446846] ACPI Error: Aborting method \_SB.PC00.PEG1.NPON due to
previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
[ 154.446852] ACPI Error: Aborting method \_SB.PC00.PEG1.PG01._ON due
to previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
[ 154.446860] acpi device:02: Failed to change power state to D0
[ 154.690760] video LNXVIDEO:00: Cannot transition to power state D0
for parent in (unknown)

The IPCS is the last function called from \_SB.PC00.PEG1.PG01._ON
which we expect it to prepare everything before bringing back the
NVIDIA GPU but it's stuck in the infinite loop as described below.
Please refer to
https://gist.github.com/mschiu77/fa4f5a97297749d0d66fe60c1d421c44 for
the full DSDT.dsl.
           While (One)
            {
                If ((!IBSY || (IERR == One)))
                {
                    Break
                }

                If ((Local0 > TMOV))
                {
                    RPKG [Zero] = 0x03
                    Return (RPKG) /* \IPCS.RPKG */
                }

                Sleep (One)
                Local0++
            }

And the upstream PCIe port of NVIDIA seems to become inaccessible due
to the messages as follows.
[ 292.746508] pcieport 0000:00:01.0: waiting 100 ms for downstream
link, after activation
[ 292.882296] pci 0000:01:00.0: waiting additional 100 ms to become accessible
[ 316.876997] pci 0000:01:00.0: can't change power state from D3cold
to D0 (config space inaccessible)

Since the IPCS is the Intel Reference Code and we don't really know
why the never-end loop happens just because we unplug the dock while
the system still stays in s2idle. Can anyone from Intel suggest what
happens here?

And one thing also worth mentioning, if we unplug the display cable
from the dock before entering the s2idle, NVIDIA GPU can come back w/o
problem even if we disconnect the dock before exiting s2idle. Here's
the lspci information
https://gist.github.com/mschiu77/0bfc439d15d52d20de0129b1b2a86dc4 and
the dmesg log with ACPI trace_state enabled and dynamic debug on for
drivers/pci/pci.c, drivers/acpi/device_pm.c for the whole s2idle
enter/exit with IPCS timeout.

Any suggestion would be appreciated. Thanks.

Chris
