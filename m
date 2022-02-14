Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45CC4B3E94
	for <lists+linux-pm@lfdr.de>; Mon, 14 Feb 2022 01:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbiBNAXW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Feb 2022 19:23:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiBNAXW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Feb 2022 19:23:22 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA96F51E70
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 16:23:15 -0800 (PST)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 265CC402DF
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644798194;
        bh=FKWnfN/WbjqhqsAVtrMRiodDo/GKGytdhw0dhlXasS4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Dj2gJWYxvriIXtVYXLiDtVPcZyrMckFLoRILBvNqHmkxUi/2UAqqXRhah713YblhT
         tFb6WH3ALVVRig8mBq/HovIL415sYtiT7SDliFN6nFvtnvhpvpGKDItK/EVI7i2SaP
         53Hc7swDu4TBOgO5Tnh2T8m8k9gtQqV9Uc6U9Fc6wFSMa/Zkg7vCMPsgyI9zjAFHzW
         nKW6iSiJuDnlBryPxLz3Th9LW52YTbsJKSwFJERurVIhdvLlHUjXh11zdu4xCTG2V2
         oJCiGvUidAj/Im4DYQU7VTbckjWjqp7mEIUOzKgLpSe0SH18f4IvW7LKxUV+i9kOik
         EG4iat0f8a1mA==
Received: by mail-ot1-f70.google.com with SMTP id h5-20020a9d5545000000b0059ecbfae94eso9379845oti.17
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 16:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKWnfN/WbjqhqsAVtrMRiodDo/GKGytdhw0dhlXasS4=;
        b=NuXKE0CoNsmOMWaDSF/KzGwBaqHTX5HLKxksqvb4i4vKMhTe1lSVeaqTGw9j3DN9im
         lAunH5QTcYnrGzD3E0Ub8aDtKVYHYU7SpRY5TM8ncGhz2sUtFSMvjr7bqIhMywA/DJgz
         JRycu1sTB5HMbM3eo2pqR2bv3Oz+uBo3nh7JgCRmTGce6MJmGXlZpSLgbrd0LPxH/UH4
         303qoYL/60jQYvb+mZWz1ChZPDDtcH5dgTD3kOlqWJ8v0YJDFYntiPAHW9qPFUf6A9PH
         lWfRd0L7A7ulQEPIafiovRcRn3yFeK7zcVSSVpKEgkUyjAl83o7D9TzQspohQ8uxbY0n
         eOzQ==
X-Gm-Message-State: AOAM531XNtSGFLzRIi3iZAW/9/xzwp5Kqq7cdcaqrvzgYRPE+Gb17HQL
        raa/UB64S5z4El3GxlV3mKFcrGuOyvLY2rKfLPJQzxJLuGFjOrVgfMCcbnmQNMWiHyiPzN6le7m
        j+H1fT+mXHcab/9g/7ID76uNMuKCzBKB4F4Dl1GNTM6ZrrUwSuc4D
X-Received: by 2002:a05:6870:a3c5:: with SMTP id h5mr3114908oak.247.1644798192978;
        Sun, 13 Feb 2022 16:23:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+WuYF9eEYmGhM2K/IEWyKKIk8WvmBdOMqhcZL6iQKfdtQKTg6lvvYzeqTIHyChu1WimbvB+VCETfqFVx8z7c=
X-Received: by 2002:a05:6870:a3c5:: with SMTP id h5mr3114897oak.247.1644798192676;
 Sun, 13 Feb 2022 16:23:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gUFY8fFKFhqmRHLKvaRA7mqDwkx7q=7soSGmu51dSD_Q@mail.gmail.com>
 <20220209213638.GA587920@bhelgaas>
In-Reply-To: <20220209213638.GA587920@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 14 Feb 2022 08:23:05 +0800
Message-ID: <CAAd53p6hATV8TOcJ9Qi2rMwVi=y_9+tQu6KhDkAm6Y8=cQ_xoA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

On Thu, Feb 10, 2022 at 5:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Dec 07, 2021 at 02:15:04PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
> > > On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
> > > > When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> > > > combination causes AER message flood and drags the system performance
> > > > down.
> > > >
> > > > The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> > > > isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> > > > is enabled regardless of _OSC:
> > > > [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> > > > ...
> > > > [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> > > >
> > > > Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> > > > disable PCIe features accordingly to resolve the issue.
> > >
> > > At least for some versions of this hardare, I recall ACPI is unaware of
> > > any devices in the VMD domain; the platform can not see past the VMD
> > > endpoint, so I throught the driver was supposed to always let the VMD
> > > domain use OS native support regardless of the parent's ACPI _OSC.
> >
> > This is orthogonal to whether or not ACPI is aware of the VMD domain
> > or the devices in it.
> >
> > If the platform firmware does not allow the OS to control specific
> > PCIe features at the physical host bridge level, that extends to the
> > VMD "bus", because it is just a way to expose a hidden part of the
> > PCIe hierarchy.
>
> I don't understand what's going on here.  Do we understand the AER
> message flood?  Are we just papering over it by disabling AER?

To be more precise, AER is disabled by the platform vendor in BIOS to
paper over the issue.
The only viable solution for us is to follow their settings. We may
never know what really happens underneath.

Disabling ASPM/AER/PME etc is a normal practice for ODMs unfortunately.

Kai-Heng

>
> If an error occurs below a VMD, who notices and reports it?  If we
> disable native AER below VMD because of _OSC, as this patch does, I
> guess we're assuming the platform will handle AER events below VMD.
> Is that really true?  Does the platform know how to find AER log
> registers of devices below VMD?
>
> > The platform firmware does that through ACPI _OSC under the host
> > bridge device (not under the VMD device) which it is very well aware
> > of.
