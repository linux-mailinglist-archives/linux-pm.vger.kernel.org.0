Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87397587F2C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Aug 2022 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiHBPls (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Aug 2022 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiHBPlf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2022 11:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 467EAB8F
        for <linux-pm@vger.kernel.org>; Tue,  2 Aug 2022 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659454892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vpq/mpo2WNFVjK/1SFKm7AqhW/wtXa+ryiiWx9FIdwo=;
        b=OszbwqrfR7TiJi1I8vrPWCO2EKTzC5w+yCkQmbo1ctg8gsMy/YKwz8vleU6D8OKxid8MJ2
        kCronqdSAYZA1+/8JfaUTM4Cm5bAySnoNgZ65QpjYuN1DYSxclMCQeK8YwsbtX2rRxiSBa
        Ka5iu51LkyG34dotqLdpPTm7Pq8CTWg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-0q1015oXNGmhOjiADbPq3g-1; Tue, 02 Aug 2022 11:41:31 -0400
X-MC-Unique: 0q1015oXNGmhOjiADbPq3g-1
Received: by mail-il1-f199.google.com with SMTP id i8-20020a056e020d8800b002d931252904so8853196ilj.23
        for <linux-pm@vger.kernel.org>; Tue, 02 Aug 2022 08:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Vpq/mpo2WNFVjK/1SFKm7AqhW/wtXa+ryiiWx9FIdwo=;
        b=RG9l4nnp+FwW1p5PgFt3LdJJT363tXBpbHdpbq5buDUOOpwgOsrDyqr+Hxts4S55OL
         N+0EegJDOuHoOCCfDDY6jsLoQuXF3T3T4kWQNDf1iy9JfgfPckMo2a2WT4pnAfDiGgB+
         PrT+isA5V7lvQ5g6R7btbLp0au7UkMUHFjjZfHjdNaawvn1T/itK27jLiUOqkX1TCBvA
         Cz5hkYS6gRCHCMJ8OonrD7iO9vH5I7sl66I5vc+83EqErcMvzKW31JYYIT4x6DqhPJC0
         tRG/9ucrYY7gt8KDYzgTI0Z1lOO2MxvV0D/UvtIxKU2XVqn9PpRwMKcUkcwSS0MsEEGW
         sliQ==
X-Gm-Message-State: ACgBeo1H+I9GGEQoDW5JUhiNjN+lnp9yo/BhAtpZaZtMfBPctYsoZJWw
        Fub9rp6WB+PR3Ttd+3TAbEDyLOLzITpUT2FtWWjKY7nRBLPKGgQnZ2DXGNItGCgh3Kjy0Zlnd0a
        /i1X3mIo3VqjzEh07k6I=
X-Received: by 2002:a05:6e02:e14:b0:2de:60af:e408 with SMTP id a20-20020a056e020e1400b002de60afe408mr6063697ilk.170.1659454890372;
        Tue, 02 Aug 2022 08:41:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7b9a7RjKkWMNOiP3M5XstmTpCDl0M45uztCly2mRb5G/+mIzsYnvwcX6X02nRrNDdeg1moeA==
X-Received: by 2002:a05:6e02:e14:b0:2de:60af:e408 with SMTP id a20-20020a056e020e1400b002de60afe408mr6063688ilk.170.1659454890099;
        Tue, 02 Aug 2022 08:41:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y10-20020a02730a000000b003427170b558sm2309947jab.57.2022.08.02.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:41:29 -0700 (PDT)
Date:   Tue, 2 Aug 2022 09:41:28 -0600
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
Subject: Re: [PATCH v5 1/5] vfio: Add the device features for the low power
 entry and exit
Message-ID: <20220802094128.38fba103.alex.williamson@redhat.com>
In-Reply-To: <YukvBBClrbCbIitm@nvidia.com>
References: <20220719121523.21396-1-abhsahu@nvidia.com>
        <20220719121523.21396-2-abhsahu@nvidia.com>
        <20220721163445.49d15daf.alex.williamson@redhat.com>
        <aaef2e78-1ed2-fe8b-d167-8ea2dcbe45b6@nvidia.com>
        <20220725160928.43a17560.alex.williamson@redhat.com>
        <bd7bca18-ae07-c04a-23d3-bf71245da0cc@nvidia.com>
        <20220726172356.GH4438@nvidia.com>
        <f903e2b9-f85b-a4c8-4706-f463919723a3@nvidia.com>
        <20220801124253.11c24d91.alex.williamson@redhat.com>
        <YukvBBClrbCbIitm@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2 Aug 2022 11:04:52 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Aug 01, 2022 at 12:42:53PM -0600, Alex Williamson wrote:
> > On Wed, 27 Jul 2022 11:37:02 +0530
> > Abhishek Sahu <abhsahu@nvidia.com> wrote:
> >   
> > > On 7/26/2022 10:53 PM, Jason Gunthorpe wrote:  
> > > > On Tue, Jul 26, 2022 at 06:17:18PM +0530, Abhishek Sahu wrote:    
> > > >>  Thanks Alex for your thorough review of uAPI.
> > > >>  I have incorporated all the suggestions.
> > > >>  Following is the updated uAPI.
> > > >>  
> > > >>  /*
> > > >>   * Upon VFIO_DEVICE_FEATURE_SET, allow the device to be moved into a low power
> > > >>   * state with the platform-based power management.  Device use of lower power
> > > >>   * states depends on factors managed by the runtime power management core,
> > > >>   * including system level support and coordinating support among dependent
> > > >>   * devices.  Enabling device low power entry does not guarantee lower power
> > > >>   * usage by the device, nor is a mechanism provided through this feature to
> > > >>   * know the current power state of the device.  If any device access happens
> > > >>   * (either from the host or through the vfio uAPI) when the device is in the
> > > >>   * low power state, then the host will move the device out of the low power
> > > >>   * state as necessary prior to the access.  Once the access is completed, the
> > > >>   * device may re-enter the low power state.  For single shot low power support
> > > >>   * with wake-up notification, see
> > > >>   * VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP below.  Access to mmap'd
> > > >>   * device regions is disabled on LOW_POWER_ENTRY and may only be resumed after
> > > >>   * calling LOW_POWER_EXIT.
> > > >>   */
> > > >>  #define VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY 3
> > > >>  
> > > >>  /*
> > > >>   * This device feature has the same behavior as
> > > >>   * VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY with the exception that the user
> > > >>   * provides an eventfd for wake-up notification.    
> > > > 
> > > > It feels like this should be one entry point instead of two.
> > > > 
> > > > A flag "automatic re-sleep" and an optional eventfd (-1 means not
> > > > provided) seems to capture both of these behaviors in a bit clearer
> > > > and extendable way.  
> > 
> > I think the mutual exclusion between re-entrant mode and one-shot is
> > quite a bit more subtle in the version below, so I don't particularly
> > find this cleaner.  Potentially we could have variant drivers support
> > one w/o the other in the previously proposed model as well.  It's
> > interesting to see this suggestion since since we seem to have a theme
> > of making features single purpose elsewhere.  Thanks,  
> 
> It is still quite single purpose, just
> VFIO_DEVICE_LOW_POWER_REENTERY_DISABLE is some minor customization of
> that single purpose.
> 
> Either the flag is set or not, it isn't subtle..

The subtlety is that there's a flag and a field and the flag can only
be set if the field is set, the flag can only be clear if the field is
clear, so we return -EINVAL for the other cases?  Why do we have both a
flag and a field?  This isn't like we're adding a feature later and the
flag needs to indicate that the field is present and valid.  It's just
not a very clean interface, imo.  Thanks,

Alex

