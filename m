Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0EC587076
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiHASnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiHASnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 14:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54CBB764E
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659379379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VSxu6kH6OVSyxacr8C8nn8K1lJQbLqb/x2+RqZOLy0=;
        b=hBS/jpCOoozNh3YUO+vJiogzCjfwO767S74pf626Q6qczwzMp/pQTVDzaOwA/VE5OLT4Rl
        5Ve837uMOSrywEOUAFLaqh1Ts6UbWz/DRDszX/sC0fSYGpqhIabclFLtQfvFPBoLGGMxdS
        IeNMse/17zdnw9+IfT6bQVwC+rmKGtQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-TWB05Yy4O5i0XRjwYM4g7g-1; Mon, 01 Aug 2022 14:42:56 -0400
X-MC-Unique: TWB05Yy4O5i0XRjwYM4g7g-1
Received: by mail-io1-f72.google.com with SMTP id n19-20020a056602341300b0066850b49e09so4155280ioz.12
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 11:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9VSxu6kH6OVSyxacr8C8nn8K1lJQbLqb/x2+RqZOLy0=;
        b=qDSu5Y/tCT5BEKneQkH/ij3FFW6pxrha9yhIcIUZfr/w1dUvck8rb+5EDevTiN/wk5
         haVv9Bu0oXIvHifyby5GV8QrgS+6IOp8vkVfwwWN+H+j2gATj42eHy3dMRUYZnQUX0IF
         HMeWkOaUh/vXMu9uqmxq0DBO+KZWK5yFpM/YwxfFSG9cYEDxRcD2c0xNjNlkjPBjM67b
         vl4u8LwCjK8bgJPmozYIXDerhvPiiof2IxRCT6lc8uVev5JpucbNobkY1cwCDETpnM2U
         1OagZhCSqThgJgjlxI9VPmtuGtJ1J8ozwK/iW/27A0e04gwbXWcKPVwAdlRNejXMF0d2
         XEwQ==
X-Gm-Message-State: AJIora+v2oyQ4e3nk/HIP0lr30KX66TFHLRxw+oTMVYlSa6b8aSfw5Xs
        HKX4WA1a0iHJLB3Qoaqoose3mtEwnvIh3izBRqko4GW/i8RJXSBbtsNovPydV4Jq787ZX9bKVNF
        hppl44IDAzxeV4c5RdUo=
X-Received: by 2002:a05:6e02:12c7:b0:2dc:8862:15ed with SMTP id i7-20020a056e0212c700b002dc886215edmr6218131ilm.253.1659379375619;
        Mon, 01 Aug 2022 11:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPhYcUSteoNNgux6SlllUg3TqHUG5Z8FH+OPi18qAeH1VyuLr2yZZAoZeI2cQIAMhW3mQv6g==
X-Received: by 2002:a05:6e02:12c7:b0:2dc:8862:15ed with SMTP id i7-20020a056e0212c700b002dc886215edmr6218115ilm.253.1659379375287;
        Mon, 01 Aug 2022 11:42:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id cs12-20020a056638470c00b003427bb38ccasm771291jab.54.2022.08.01.11.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:42:54 -0700 (PDT)
Date:   Mon, 1 Aug 2022 12:42:53 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20220801124253.11c24d91.alex.williamson@redhat.com>
In-Reply-To: <f903e2b9-f85b-a4c8-4706-f463919723a3@nvidia.com>
References: <20220719121523.21396-1-abhsahu@nvidia.com>
        <20220719121523.21396-2-abhsahu@nvidia.com>
        <20220721163445.49d15daf.alex.williamson@redhat.com>
        <aaef2e78-1ed2-fe8b-d167-8ea2dcbe45b6@nvidia.com>
        <20220725160928.43a17560.alex.williamson@redhat.com>
        <bd7bca18-ae07-c04a-23d3-bf71245da0cc@nvidia.com>
        <20220726172356.GH4438@nvidia.com>
        <f903e2b9-f85b-a4c8-4706-f463919723a3@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Jul 2022 11:37:02 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> On 7/26/2022 10:53 PM, Jason Gunthorpe wrote:
> > On Tue, Jul 26, 2022 at 06:17:18PM +0530, Abhishek Sahu wrote:  
> >>  Thanks Alex for your thorough review of uAPI.
> >>  I have incorporated all the suggestions.
> >>  Following is the updated uAPI.
> >>  
> >>  /*
> >>   * Upon VFIO_DEVICE_FEATURE_SET, allow the device to be moved into a low power
> >>   * state with the platform-based power management.  Device use of lower power
> >>   * states depends on factors managed by the runtime power management core,
> >>   * including system level support and coordinating support among dependent
> >>   * devices.  Enabling device low power entry does not guarantee lower power
> >>   * usage by the device, nor is a mechanism provided through this feature to
> >>   * know the current power state of the device.  If any device access happens
> >>   * (either from the host or through the vfio uAPI) when the device is in the
> >>   * low power state, then the host will move the device out of the low power
> >>   * state as necessary prior to the access.  Once the access is completed, the
> >>   * device may re-enter the low power state.  For single shot low power support
> >>   * with wake-up notification, see
> >>   * VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP below.  Access to mmap'd
> >>   * device regions is disabled on LOW_POWER_ENTRY and may only be resumed after
> >>   * calling LOW_POWER_EXIT.
> >>   */
> >>  #define VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY 3
> >>  
> >>  /*
> >>   * This device feature has the same behavior as
> >>   * VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY with the exception that the user
> >>   * provides an eventfd for wake-up notification.  
> > 
> > It feels like this should be one entry point instead of two.
> > 
> > A flag "automatic re-sleep" and an optional eventfd (-1 means not
> > provided) seems to capture both of these behaviors in a bit clearer
> > and extendable way.

I think the mutual exclusion between re-entrant mode and one-shot is
quite a bit more subtle in the version below, so I don't particularly
find this cleaner.  Potentially we could have variant drivers support
one w/o the other in the previously proposed model as well.  It's
interesting to see this suggestion since since we seem to have a theme
of making features single purpose elsewhere.  Thanks,

Alex 

> 
>  We discussed about that in the earlier version of the patch series.
>  Since we have different exit related handling, so to avoid confusion
>  we proceeded with 2 separate variants for the low power entry. Also,
>  we don't need any parameter for the first case.
> 
>  But, I can do the changes to make a single entry point, if we conclude
>  for that. 
> 
>  From my side, I have explored how the uAPI looks like if
>  we go with this approach.
> 
>  /*
>   * Upon VFIO_DEVICE_FEATURE_SET, allow the device to be moved into a low power
>   * state with the platform-based power management.  Device use of lower power
>   * states depends on factors managed by the runtime power management core,
>   * including system level support and coordinating support among dependent
>   * devices.  Enabling device low power entry does not guarantee lower power
>   * usage by the device, nor is a mechanism provided through this feature to
>   * know the current power state of the device.  If any device access happens
>   * (either from the host or through the vfio uAPI) when the device is in the
>   * low power state, then the host will move the device out of the low power
>   * state as necessary prior to the access.  Once the access is completed, the
>   * device re-entry to a low power state will be controlled through
>   * VFIO_DEVICE_LOW_POWER_REENTERY_DISABLE flag.
>   *
>   * If LOW_POWER_REENTERY_DISABLE flag is not set, the device may re-enter the
>   * low power state.  Access to mmap'd device regions is disabled on
>   * LOW_POWER_ENTRY and may only be resumed after calling LOW_POWER_EXIT.
>   *
>   * If LOW_POWER_REENTERY_DISABLE flag is set, then user needs to provide an
>   * eventfd for wake-up notification.  When the device moves out of the low
>   * power state for the wake-up, the host will not allow the device to re-enter
>   * a low power state without a subsequent user call to LOW_POWER_ENTRY.
>   * Access to mmap'd device regions is disabled on LOW_POWER_ENTRY and may only
>   * be resumed after the low power exit.  The low power exit can happen either
>   * through LOW_POWER_EXIT or through any other access (where the wake-up
>   * notification has been generated).  The access to mmap'd device regions will
>   * not trigger low power exit.
>   *
>   * The notification through the provided eventfd will be generated only when
>   * the device has entered and is resumed from a low power state after
>   * calling this device feature IOCTL.  A device that has not entered low power
>   * state, as managed through the runtime power management core, will not
>   * generate a notification through the provided eventfd on access.  Calling the
>   * LOW_POWER_EXIT feature is optional in the case where notification has been
>   * signaled on the provided eventfd that a resume from low power has occurred.
>   *
>   * The wakeup_eventfd needs to be valid only if LOW_POWER_REENTERY_DISABLE
>   * flag is set, otherwise, it will be ignored.
>   */
>  #define VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY 3
>  
>  struct vfio_device_low_power_entry_with_wakeup {
>  	__u32 flags;
>  #define VFIO_DEVICE_LOW_POWER_REENTERY_DISABLE	(1 << 0)
>  	__s32 wakeup_eventfd;
>  };
>  
>  /*
>   * Upon VFIO_DEVICE_FEATURE_SET, disallow use of device low power states as
>   * previously enabled via VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY device feature.
>   * This device feature IOCTL may itself generate a wakeup eventfd notification
>   * if the device had previously entered a low power state with
>   * VFIO_DEVICE_LOW_POWER_REENTERY_DISABLE flag set.
>   */
>  #define VFIO_DEVICE_FEATURE_LOW_POWER_EXIT 4
> 
>  Thanks,
>  Abhishek
> 

