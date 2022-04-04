Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248134F1A54
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 23:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiDDVSU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380203AbiDDTOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 15:14:14 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69215377E0
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 12:12:17 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so7879293otj.10
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HaBSCtvM0Wy0SP5zUFXCSh2FNwBC2ZpaaXakEoGwFXA=;
        b=QRbaJLGqfSytgeLDMDaMo3pFIvgnJhK7msg48BshQ/1jFwC2lmeFIpeANmoKV1C0Dh
         QmZjrgbS5ILg8xTOkr/r9cRrhri5vMI0bOo6Sj7Zhay+EAnjeM5tHaAHiSDnO6ippfYC
         SNuYSPC01YTnGkFxL2M9JzpVppdEvEyc1sd+n9sMfgFDDEeH2msq14bKRtHb3gUfpuM4
         j6QBQ4pB3LUxFwi1zJmuMLj30FRsqd1iGipjHqua8F0j9obgvzV+H8yVvYb1Y/IOSpCd
         KL37R65BysmpaksgZOIkWdkcLEcTXU0SFFWmWBDUrla9NhEuBcGpoqSgC+Rh7RKfq7M7
         GAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HaBSCtvM0Wy0SP5zUFXCSh2FNwBC2ZpaaXakEoGwFXA=;
        b=F7AnAbNBMPthSWnr03exc4lJ5dL/zCBZXjdLzcCQSfHuAEqLqBE1sA2X6ilKs0dQu/
         ajY4Ffxn5eXXn+2L2XVPlw2IiMkmRklTmIvQ4Aep0l0QdUVFAz74tCSg6VGuAMBLngm9
         cDeq6kF+8IowRVGyQt07D6LDnJPJZNf4XQOwhTXNBEA+L7DK6kaVCHPkq40jUAijsB7K
         mJqnbzpT2wjV4A+5edRHLSzCSW/s7pCy1T2z0OwUwreab3odrx8Cws0ufNXF7yiUWHJb
         vTY6AL6PiAmaXLZQIOKXqHxqz8CfRADXTrvK8uwCAofIo76m2Uty/0opOSd4ZLvAUqFI
         oMYw==
X-Gm-Message-State: AOAM531CCpsUHHkc0JRhwbR81w2TdFhEbUdHiMDgJEiYNxGB2JuVh80R
        8+xg7JZ/1j+D57iFLfFedDNnUaqGYjD/Y6rUYxQ2qs8BaULRzg==
X-Google-Smtp-Source: ABdhPJx53qVjugPFtagCZ/vg5SciUqxZhWJ8+WqD50ec1zmxvdqxeCVjEmx4wXSm3ZFYN/d0UAvZ/O81KzKS1ewGUc0=
X-Received: by 2002:a9d:1729:0:b0:5b2:3828:c84c with SMTP id
 i41-20020a9d1729000000b005b23828c84cmr406189ota.362.1649099535465; Mon, 04
 Apr 2022 12:12:15 -0700 (PDT)
MIME-Version: 1.0
From:   Evan Green <evgreen@google.com>
Date:   Mon, 4 Apr 2022 12:11:39 -0700
Message-ID: <CAE=gft4a-QL82iFJE_xRQ3JrMmz-KZKWREtz=MghhjFbJeK=8A@mail.gmail.com>
Subject: Lost MSIs during hibernate
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas et al,
To my surprise, I'm back with another MSI problem, and hoping to get
some advice on how to approach fixing it.

Summary: I think MSIs are lost across the hibernate freeze/thaw
transition on the way down because __pci_write_msi_msg() drops the
write if the device is not in D0.

Details:
I've been playing with hibernation on an Alderlake device, and have
been running into problems where the freeze/thaw transition that
should generate the hibernate image ends up hanging (eg before we even
start writing the image out to disk). When it hangs I find it in
usb_kill_urb(), an error path that comes out of a failed attempt to
send a control packet to a hub port coming from usb_resume().
Occasionally, I see the classic "HC died; cleaning up" message
instead. XHCI in general appears to be very sensitive to lost MSIs, so
I started down that road.

I printed the three major paths through __pci_write_msi_msg() so I
could see what the XHCI controller was ending up with when it hung.
You can see a full boot and hibernate attempt sequence that results in
a hang here (sorry there's other cruft in there):

https://pastebin.com/PFd3x1k0

What worries me is those IRQ "no longer affine" messages, as well as
my "EVAN don't touch hw" prints, indicating that requests to change
the MSI are being dropped. These ignored requests are coming in when
we try to migrate all IRQs off of the non-boot CPU, and they get
ignored because all devices are "frozen" at this point, and presumably
not in D0.

So my theory is XHCI for whatever reason boots affinitized to a
non-boot CPU. We go through pci_pm_freeze(), then try to take the
non-boot CPUs down. The request to move the MSI off of the dead CPU is
ignored, and then XHCI generates an interrupt during the period while
that non-boot CPU is dead.

To further try and prove that theory, I wrote a script to do the
hibernate prepare image step in a loop, but messed with XHCI's IRQ
affinity beforehand. If I move the IRQ to core 0, so far I have never
seen a hang. But if I move it to another core, I can usually get a
hang in the first attempt. I also very occasionally see wifi splats
when trying this, and those "no longer affine" prints are all the wifi
queue IRQs. So I think a wifi packet coming in at the wrong time can
do the same thing.

I wanted to see what thoughts you might have on this. Should I try to
make a patch that moves all IRQs to CPU 0 *before* the devices all
freeze? Sounds a little unpleasant. Or should PCI be doing something
different to avoid this combination of "you're not allowed to modify
my MSIs, but I might still generate interrupts that must not be lost"?

-Evan
