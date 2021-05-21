Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13F38BD20
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 06:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhEUED7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 00:03:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57824 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhEUED7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 00:03:59 -0400
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1ljwMt-0002lM-G1
        for linux-pm@vger.kernel.org; Fri, 21 May 2021 04:02:35 +0000
Received: by mail-oo1-f72.google.com with SMTP id 126-20020a4a17840000b02901e5e0ccc28aso12471942ooe.13
        for <linux-pm@vger.kernel.org>; Thu, 20 May 2021 21:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkxUPctLlMYTanG/NbpSu5XniOih0RSQFTbMnTWQYJM=;
        b=MGWTtEIsIBb6efgVB1rJPmZnMFYCNixTW3zbysi/6Hj/2KDsls/Ko2w1o1qZnjFs9l
         bhqZpZIiUDFLJNIYiRKWJ8DDS+4Lf6f655ck0CgMFF8pMz1TZbdEF/Z0z6TnxT1skBv2
         pbcZ5I7vuLy6Sw9UhKbC7HhlxmrhHwBtDmevoXFtjKBIAPNtKUzrcif+ZESFpuLx3z+X
         uoaXIXr5HnmGj1FuwdMhh5l05SonhaaMwl0ar9camtA8O6Y1xKn14aRDfgUQmVw2Pjct
         hyAGC1JBkr+rzBjAfC/9XxxCrIJccp0P2qbjOOvzXQ7uzDXymItr2xGtHaNJo1aBJC5N
         uTcA==
X-Gm-Message-State: AOAM5304JoIZwes6PO3WCwcZRLas6Gs7pyxIi7tfCyWbgX6lbx4f4Y4w
        a5fjZFmCAc1eGUxMOKhesuAIk5PDei0f9u/apM2BWu15tjNhYhcskSGgs7eBsb/ajgpt+7+IAR5
        q+FbeH69K1j1pFcgd9pZ+3fVRqwBGn0vcKMbftIMUy+dGmYVN72Fg
X-Received: by 2002:a4a:c1:: with SMTP id 184mr6397281ooh.25.1621569753983;
        Thu, 20 May 2021 21:02:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN8oKjol1achG45QUkmKxb4AL9fVw2ETq9jSXQdBZuFnWj3B3G19NBSti3JEmAoGlQnBW6NHSRu31xIqEnv1U=
X-Received: by 2002:a4a:c1:: with SMTP id 184mr6397260ooh.25.1621569753749;
 Thu, 20 May 2021 21:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABTNMG0Y5iAD4E8XFkOwrNTBHNDcNKRt=+BLPHs4tw5O2eVBDA@mail.gmail.com>
 <CAJZ5v0hqU4xc8oCWXPBYhdGdG__=15+M67QWVSfFeUR3DN4Evw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqU4xc8oCWXPBYhdGdG__=15+M67QWVSfFeUR3DN4Evw@mail.gmail.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Fri, 21 May 2021 12:02:23 +0800
Message-ID: <CABTNMG12A5qJ5ygtFTa7Sk-5W=fmMxt0L90=04H5qRDD4vWGRQ@mail.gmail.com>
Subject: Re: NVIDIA GPU fallen off the bus after exiting s2idle
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 6, 2021 at 5:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, May 4, 2021 at 10:08 AM Chris Chiu <chris.chiu@canonical.com> wrote:
> >
> > Hi,
> >     We have some Intel laptops (11th generation CPU) with NVIDIA GPU
> > suffering the same GPU falling off the bus problem while exiting
> > s2idle with external display connected. These laptops connect the
> > external display via the HDMI/DisplayPort on a USB Type-C interfaced
> > dock. If we enter and exit s2idle with the dock connected, the NVIDIA
> > GPU (confirmed on 10de:24b6 and 10de:25b8) and the PCIe port can come
> > back to D0 w/o problem. If we enter the s2idle, disconnect the dock,
> > then exit the s2idle, both external display and the panel will remain
> > with no output. The dmesg as follows shows the "nvidia 0000:01:00.0:
> > can't change power state from D3cold to D0 (config space
> > inaccessible)" due to the following ACPI error
> > [ 154.446781]
> > [ 154.446783]
> > [ 154.446783] Initialized Local Variables for Method [IPCS]:
> > [ 154.446784] Local0: 000000009863e365 <Obj> Integer 00000000000009C5
> > [ 154.446790]
> > [ 154.446791] Initialized Arguments for Method [IPCS]: (7 arguments
> > defined for method invocation)
> > [ 154.446792] Arg0: 0000000025568fbd <Obj> Integer 00000000000000AC
> > [ 154.446795] Arg1: 000000009ef30e76 <Obj> Integer 0000000000000000
> > [ 154.446798] Arg2: 00000000fdf820f0 <Obj> Integer 0000000000000010
> > [ 154.446801] Arg3: 000000009fc2a088 <Obj> Integer 0000000000000001
> > [ 154.446804] Arg4: 000000003a3418f7 <Obj> Integer 0000000000000001
> > [ 154.446807] Arg5: 0000000020c4b87c <Obj> Integer 0000000000000000
> > [ 154.446810] Arg6: 000000008b965a8a <Obj> Integer 0000000000000000
> > [ 154.446813]
> > [ 154.446815] ACPI Error: Aborting method \IPCS due to previous error
> > (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> > [ 154.446824] ACPI Error: Aborting method \MCUI due to previous error
> > (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> > [ 154.446829] ACPI Error: Aborting method \SPCX due to previous error
> > (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> > [ 154.446835] ACPI Error: Aborting method \_SB.PC00.PGSC due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> > [ 154.446841] ACPI Error: Aborting method \_SB.PC00.PGON due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> > [ 154.446846] ACPI Error: Aborting method \_SB.PC00.PEG1.NPON due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> > [ 154.446852] ACPI Error: Aborting method \_SB.PC00.PEG1.PG01._ON due
> > to previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> > [ 154.446860] acpi device:02: Failed to change power state to D0
> > [ 154.690760] video LNXVIDEO:00: Cannot transition to power state D0
> > for parent in (unknown)
>
> If I were to guess, I would say that AML tries to access memory that
> is not accessible while suspended, probably PCI config space.
>
> > The IPCS is the last function called from \_SB.PC00.PEG1.PG01._ON
> > which we expect it to prepare everything before bringing back the
> > NVIDIA GPU but it's stuck in the infinite loop as described below.
> > Please refer to
> > https://gist.github.com/mschiu77/fa4f5a97297749d0d66fe60c1d421c44 for
> > the full DSDT.dsl.
>
> The DSDT alone may not be sufficient.
>
> Can you please create a bug entry at bugzilla.kernel.org for this
> issue and attach the full output of acpidump from one of the affected
> machines to it?  And please let me know the number of the bug.
>
> Also please attach the output of dmesg including a suspend-resume
> cycle including dock disconnection while suspended and the ACPI
> messages quoted below.
>
> >            While (One)
> >             {
> >                 If ((!IBSY || (IERR == One)))
> >                 {
> >                     Break
> >                 }
> >
> >                 If ((Local0 > TMOV))
> >                 {
> >                     RPKG [Zero] = 0x03
> >                     Return (RPKG) /* \IPCS.RPKG */
> >                 }
> >
> >                 Sleep (One)
> >                 Local0++
> >             }
> >
> > And the upstream PCIe port of NVIDIA seems to become inaccessible due
> > to the messages as follows.
> > [ 292.746508] pcieport 0000:00:01.0: waiting 100 ms for downstream
> > link, after activation
> > [ 292.882296] pci 0000:01:00.0: waiting additional 100 ms to become accessible
> > [ 316.876997] pci 0000:01:00.0: can't change power state from D3cold
> > to D0 (config space inaccessible)
> >
> > Since the IPCS is the Intel Reference Code and we don't really know
> > why the never-end loop happens just because we unplug the dock while
> > the system still stays in s2idle. Can anyone from Intel suggest what
> > happens here?
>
> This list is not the right channel for inquiries related to Intel
> support, we can only help you as Linux kernel developers in this
> venue.
>
> > And one thing also worth mentioning, if we unplug the display cable
> > from the dock before entering the s2idle, NVIDIA GPU can come back w/o
> > problem even if we disconnect the dock before exiting s2idle. Here's
> > the lspci information
> > https://gist.github.com/mschiu77/0bfc439d15d52d20de0129b1b2a86dc4 and
> > the dmesg log with ACPI trace_state enabled and dynamic debug on for
> > drivers/pci/pci.c, drivers/acpi/device_pm.c for the whole s2idle
> > enter/exit with IPCS timeout.
> >
> > Any suggestion would be appreciated. Thanks.
>
> First, please use proper Intel support channels for BIOS-related inquiries.
>
> Second, please open a bug as suggested above and let's use it for
> further communication regarding this issue as far as Linux is
> concerned.
>
> Thanks!

Thanks for the suggestion. I opened
https://bugzilla.kernel.org/show_bug.cgi?id=212951 and have a new
finding in https://bugzilla.kernel.org/show_bug.cgi?id=212951#c13. It
seems that maybe we could do something in the i915 driver during
resume to handle the hpd (because we unplug the dock/dongle when
suspended) at the very beginning. Since it involves HPD, PMC and the
BIOS, I don't know which way I should go to fix this since Windows
won't hit this problem.

Please let me know if there's any information missing in the
bugzilla.kernel ticket. Any suggestions would be appreciated. Thanks

Chris
