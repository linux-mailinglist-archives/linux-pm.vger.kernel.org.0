Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C446953AC96
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356195AbiFASP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353818AbiFASP4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 14:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A037D9808F
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654107351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lnhgnSWwHutqtYkh7EtY0e4ON7IRphJYIb523UmDxM=;
        b=gV/qqw1SwOLntwNjgwGSjwMO59S7Jzdx10x0qARGpwevRr6yJVuOlRgAu23H6O2uAho8mU
        L6jdmKkORhD4LhywR6/653GBld/iJvPOA35hX0gboa63Brg/Kr9avNWj9IodRX75oAZy6w
        a6Oladznh7NQ71fCI/b/HVc4Hmk1ycE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-t8YspQAqMNOGL1HEYWE3GQ-1; Wed, 01 Jun 2022 14:15:50 -0400
X-MC-Unique: t8YspQAqMNOGL1HEYWE3GQ-1
Received: by mail-io1-f71.google.com with SMTP id i189-20020a6bb8c6000000b0065e475f5ca9so1351354iof.15
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 11:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8lnhgnSWwHutqtYkh7EtY0e4ON7IRphJYIb523UmDxM=;
        b=wcEh9oArkHU8WtlwHNShoOvwgE1EYVq23uOWWR66Ij1itvv7h0M9KByzVWAo3yG3GW
         aFEtLDAvnhyRYSowNu7SWYbgxOlnFNfOaDuIrS/iJCKvKpckR0XXiu55iZ+C/KwoKaUE
         yHHc6/u/QILTnLEohTQCKfg44pRtNiy6e9evfkD1WEFNaXueY9OTv93BehgZDc/wZouy
         Y0Q6wEvA0aBRKFalQH80UDobN0C+Z6lormOIftoDMrOHhzioawJFFNE9Od2ik+qqs2Ti
         xeO6z4/KltP9hpbzg61diDtE2A8kLzv3I+152bGG4wM5hzjs1CMabXrW0kwNaLkevpkB
         ml4g==
X-Gm-Message-State: AOAM5339SkgFSPh17Lb7LQZk4MNFdivdq13FNAQoqsMFsjyytPGq4d3A
        5N3So8OqI2PgVf3is5tJtEWwctoT55SWxt59HgnHC9z01nvq5ruvOmoMrlBnvd+fG1/J0ceJ3x8
        zC9b7nZIqTMMkxmZC7Qo=
X-Received: by 2002:a05:6638:1909:b0:32e:d7f1:9072 with SMTP id p9-20020a056638190900b0032ed7f19072mr799194jal.261.1654107349223;
        Wed, 01 Jun 2022 11:15:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtWWYwIifn8Zm9fGxaP3UsiArl+84D6kY0AJluqcAh0yFl+n2OY1BLZaHw5+41MWCfjqu8Fw==
X-Received: by 2002:a05:6638:1909:b0:32e:d7f1:9072 with SMTP id p9-20020a056638190900b0032ed7f19072mr799178jal.261.1654107349017;
        Wed, 01 Jun 2022 11:15:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i12-20020a926d0c000000b002d39ae9918asm719208ilc.54.2022.06.01.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:15:48 -0700 (PDT)
Date:   Wed, 1 Jun 2022 12:15:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Abhishek Sahu <abhsahu@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 8/8] vfio/pci: Add the support for PCI D3cold state
Message-ID: <20220601121547.03ebbf64.alex.williamson@redhat.com>
In-Reply-To: <20220601173054.GS1343366@nvidia.com>
References: <9e44e9cc-a500-ab0d-4785-5ae26874b3eb@nvidia.com>
        <20220509154844.79e4915b.alex.williamson@redhat.com>
        <68463d9b-98ee-b9ec-1a3e-1375e50a2ad2@nvidia.com>
        <42518bd5-da8b-554f-2612-80278b527bf5@nvidia.com>
        <20220530122546.GZ1343366@nvidia.com>
        <c73d537b-a653-bf79-68cd-ddc8f0f62a25@nvidia.com>
        <20220531194304.GN1343366@nvidia.com>
        <20220531165209.1c18854f.alex.williamson@redhat.com>
        <00b6e380-ecf4-1eaf-f950-2c418bdb6cac@nvidia.com>
        <20220601102151.75445f6a.alex.williamson@redhat.com>
        <20220601173054.GS1343366@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 1 Jun 2022 14:30:54 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 01, 2022 at 10:21:51AM -0600, Alex Williamson wrote:
> 
> > Some ioctls clearly cannot occur while the device is in low power, such
> > as resets and interrupt control, but even less obvious things like
> > getting region info require device access.  Migration also provides a
> > channel to device access.    
> 
> I wonder what power management means in a case like that.
> 
> For the migration drivers they all rely on a PF driver that is not
> VFIO, so it should be impossible for power management to cause the PF
> to stop working.
> 
> I would expect any sane design of power management for a VF to not
> cause any harm to the migration driver..

Is there even a significant benefit or use case for power management
for VFs?  The existing D3hot support should be ok, but I imagine to
support D3cold, all the VFs and the PF would need to move to low power.
It might be safe to simply exclude VFs from providing this feature for
now.

> > I'm also still curious how we're going to handle devices that cannot
> > return to low power such as the self-refresh mode on the GPU.  We can
> > potentially prevent any wake-ups from the vfio device interface, but
> > that doesn't preclude a wake-up via an external lspci.  I think we need
> > to understand how we're going to handle such devices before we can
> > really complete the design.  AIUI, we cannot disable the self-refresh
> > sleep mode without imposing unreasonable latency and memory
> > requirements on the guest and we cannot retrigger the self-refresh
> > low-power mode without non-trivial device specific code.  
> 
> It begs the question if power management should be something that only
> a device-specific drivers should allow?

Yes, but that's also penalizing devices that require no special
support, for the few that do.  I'm not opposed to some sort of
vfio-pci-nvidia-gpu variant driver to provide that device specific
support, but I'd think the device table for such a driver might just be
added to the exclusion list for power management support in vfio-pci.
vfio-pci-core would need some way for drivers to opt-out/in for power
management.  Thanks,

Alex

