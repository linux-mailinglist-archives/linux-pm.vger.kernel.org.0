Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743275AB874
	for <lists+linux-pm@lfdr.de>; Fri,  2 Sep 2022 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIBSnK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Sep 2022 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIBSnJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2022 14:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BB81144C4
        for <linux-pm@vger.kernel.org>; Fri,  2 Sep 2022 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662144186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ohTeF4+cvF8PKkr4lYOWbH1b2UayUkG4FJ3FZMJwY0=;
        b=L2TSwXM77c7FKmq1huyxY6eOoV8zZXw4z8d0wwZfCZktNUG6q81DYa59MGdzFbaqUdj1Bb
        41wZJXxphclCn0vSTf6pCqg2iRxr0rV3EU5BqEAzezZVF00AmQJvSVEsT0jYwMjawR6neF
        mhtU1O8JIMCNbSMuwsqD0ZIifuJO4ug=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-sU-huRZoNfWJC1UNRsDkLQ-1; Fri, 02 Sep 2022 14:43:05 -0400
X-MC-Unique: sU-huRZoNfWJC1UNRsDkLQ-1
Received: by mail-io1-f70.google.com with SMTP id bh11-20020a056602370b00b00688c8a2b56cso1825976iob.13
        for <linux-pm@vger.kernel.org>; Fri, 02 Sep 2022 11:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=2ohTeF4+cvF8PKkr4lYOWbH1b2UayUkG4FJ3FZMJwY0=;
        b=b6lvTpSFi6Is75uwbBg9cN7EtmQCRzWL/S/ch69lMKYu4zJVCwsKzmm0GgC6yQwHLK
         Zaq/HzMphThBw2zL8vDc8nxyBJop/YG4L2DKFbEKJK+HozT0vWj8uRW6vPm6/S869ZP+
         mBk57ZYrU1x3qRHuBnr88mkJ5LRBGS9PSKzdZGNYmeOw9iVp7RXJEFvvr/JVDws1/GcO
         VA8E9tDvkyqtLAfoK5EqgJ/X7OBwyAScqKd2L4iVWlCisrgHX6zqNTWabBPrMhagZ5vG
         s2SMG+dHivsNHc7zlM6NIWgCuMh4sCtTQDC23uqGb8yduuu6jCOy4jJ8AWuoxZQMxPxD
         wRfQ==
X-Gm-Message-State: ACgBeo3l8xU7aVdSY2iKcmbqMqjY3FEuNiVF+O4jr8ZW4UJ/j79eiRKW
        oLMH7zHdnZsaGX+dO0xX2TxMjk+EhJs/p4Bt9KC9jSkN1x4ON+R/jdYb9Zg8tKpuwx3oBIJ/NH1
        s8HQowRAPO3woEfRYUR4=
X-Received: by 2002:a5d:8b47:0:b0:689:a436:81d2 with SMTP id c7-20020a5d8b47000000b00689a43681d2mr17433537iot.138.1662144185065;
        Fri, 02 Sep 2022 11:43:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5c8tYFnpO88dkPGbcmTL6O4ouPV+XYGlcQvH3lOAZzQUG+Sde454M/r0vL2MBGLi157knPaQ==
X-Received: by 2002:a5d:8b47:0:b0:689:a436:81d2 with SMTP id c7-20020a5d8b47000000b00689a43681d2mr17433520iot.138.1662144184825;
        Fri, 02 Sep 2022 11:43:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x6-20020a056602160600b0067b7a057ee8sm1126680iow.25.2022.09.02.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:43:04 -0700 (PDT)
Date:   Fri, 2 Sep 2022 12:42:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] vfio/pci: power management changes
Message-ID: <20220902124234.472737cd.alex.williamson@redhat.com>
In-Reply-To: <20220829114850.4341-1-abhsahu@nvidia.com>
References: <20220829114850.4341-1-abhsahu@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 29 Aug 2022 17:18:45 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> This is part 2 for the vfio-pci driver power management support.
> Part 1 of this patch series was related to adding D3cold support
> when there is no user of the VFIO device and has already merged in the
> mainline kernel. If we enable the runtime power management for
> vfio-pci device in the guest OS, then the device is being runtime
> suspended (for linux guest OS) and the PCI device will be put into
> D3hot state (in function vfio_pm_config_write()). If the D3cold
> state can be used instead of D3hot, then it will help in saving
> maximum power. The D3cold state can't be possible with native
> PCI PM. It requires interaction with platform firmware which is
> system-specific. To go into low power states (Including D3cold),
> the runtime PM framework can be used which internally interacts
> with PCI and platform firmware and puts the device into the
> lowest possible D-States.
> 
> This patch series adds the support to engage runtime power management
> initiated by the user. Since D3cold state can't be achieved by writing
> PCI standard PM config registers, so new device features have been
> added in DEVICE_FEATURE IOCTL for low power entry and exit related
> handling. For the PCI device, this low power state will be D3cold
> (if the platform supports the D3cold state). The hypervisors can implement
> virtual ACPI methods to make the integration with guest OS.
> For example, in guest Linux OS if PCI device ACPI node has
> _PR3 and _PR0 power resources with _ON/_OFF method, then guest
> Linux OS makes the _OFF call during D3cold transition and
> then _ON during D0 transition. The hypervisor can tap these virtual
> ACPI calls and then do the low power related IOCTL.
> 
> The entry device feature has two variants. These two variants are mainly
> to support the different behaviour for the low power entry.
> If there is any access for the VFIO device on the host side, then the
> device will be moved out of the low power state without the user's
> guest driver involvement. Some devices (for example NVIDIA VGA or
> 3D controller) require the user's guest driver involvement for
> each low-power entry. In the first variant, the host can move the
> device into low power without any guest driver involvement while
> in the second variant, the host will send a notification to user
> through eventfd and then user guest driver needs to move the device
> into low power. The hypervisor can implement the virtual PME
> support to notify the guest OS. Please refer
> https://lore.kernel.org/lkml/20220701110814.7310-7-abhsahu@nvidia.com/
> where initially this virtual PME was implemented in the vfio-pci driver
> itself, but later-on, it has been decided that hypervisor can implement
> this.
> 
> * Changes in v7

Applied to vfio next branch for v6.1.  Thanks,

Alex

