Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ACC52AD18
	for <lists+linux-pm@lfdr.de>; Tue, 17 May 2022 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiEQUzu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 May 2022 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiEQUzs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 16:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71EAC229
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652820942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjDVUYk4HAdG1tZM7dsKEhmRYaWZVB/tCHA1P3Bkphg=;
        b=EL1te23LBSapBK/LIiXlubmGTFqqBvalo6/KeMK2HbPr0uLXC/7bRPOZufcKNV1IQpB+rq
        xecOO4jokXAG0f5mBgIJxh7uIp2S48POtDeap6y1V2ZsHDxl4lD05KJVTeYCdSiiuoEC9b
        vE3+l+MNxPePVVAM1sYM5z1rWos018E=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-DmHFGrkvNfCGlhReNK3arA-1; Tue, 17 May 2022 16:55:41 -0400
X-MC-Unique: DmHFGrkvNfCGlhReNK3arA-1
Received: by mail-il1-f198.google.com with SMTP id e3-20020a056e020b2300b002d10200d90fso149067ilu.2
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 13:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bjDVUYk4HAdG1tZM7dsKEhmRYaWZVB/tCHA1P3Bkphg=;
        b=eP00fLvATUbrEfANscb6QYVAI7HtRN5eXKnL+kQZUTSlZNvT5Ak9pyrwfMo+fB6SW3
         gL42KsndiWIp1aA8JU5RXingzHeGRaDvWtom1uVEHrbSvdt63Yw64UYFedckjD76XK5X
         PTsX06NmfumLo5mb7fyJWvXv7emgmaOwHIxf/L266ZPkYT6f2lC29MZhqQj7xbv3El6Z
         IDdpeCQGT4q0ciVU3ZmILCm3C3wNeiSNMqNMQQm5J0b4rHLANnXQpS5xBoeRkmbWprwc
         68GtR2fv1azzau+h/qXkc+0CY8wquNVgYMI9+JS9veMZB6t6K+m2cee7NKQB/spJA1Ck
         5+vA==
X-Gm-Message-State: AOAM533pQX8FH/wmcWx/rN5SPIM41QOnMU3Fq9UUl1UZ7rnG/APTTYq0
        Trql7dHafQ6h3At6gsDM/Rrz5oelohdhpQMpLU4a9yI2V04cGgbUeqDW5/GLfwKal3lr86DJMXy
        fiP6Pq60HvHaTKpkMDHY=
X-Received: by 2002:a05:6638:4185:b0:32b:6a0d:90dc with SMTP id az5-20020a056638418500b0032b6a0d90dcmr12863691jab.193.1652820941092;
        Tue, 17 May 2022 13:55:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9BjoRLt6hzI2bLuSuOSH1OMVZ6HeJ3OXGYhShr0wiGLKOz5B/iPyuZS/yHg0uVPwGQJxgNw==
X-Received: by 2002:a05:6638:4185:b0:32b:6a0d:90dc with SMTP id az5-20020a056638418500b0032b6a0d90dcmr12863678jab.193.1652820940861;
        Tue, 17 May 2022 13:55:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a2-20020a02ac02000000b0032e2996cadesm40325jao.66.2022.05.17.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:55:40 -0700 (PDT)
Date:   Tue, 17 May 2022 14:55:39 -0600
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
Subject: Re: [PATCH v4 4/4] vfio/pci: Move the unused device into low power
 state with runtime PM
Message-ID: <20220517145539.7265b41a.alex.williamson@redhat.com>
In-Reply-To: <20220517144256.15991375.alex.williamson@redhat.com>
References: <20220517100219.15146-1-abhsahu@nvidia.com>
        <20220517100219.15146-5-abhsahu@nvidia.com>
        <20220517144256.15991375.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 17 May 2022 14:42:56 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 17 May 2022 15:32:19 +0530
> Abhishek Sahu <abhsahu@nvidia.com> wrote:
> > 5. Since the runtime PM framework will provide the same functionality,
> >    so directly writing into PCI PM config register can be replaced with
> >    the use of runtime PM routines. Also, the use of runtime PM can help
> >    us in more power saving.
> > 
> >    In the systems which do not support D3cold,
> > 
> >    With the existing implementation:
> > 
> >    // PCI device
> >    # cat /sys/bus/pci/devices/0000\:01\:00.0/power_state
> >    D3hot
> >    // upstream bridge
> >    # cat /sys/bus/pci/devices/0000\:00\:01.0/power_state
> >    D0
> > 
> >    With runtime PM:
> > 
> >    // PCI device
> >    # cat /sys/bus/pci/devices/0000\:01\:00.0/power_state
> >    D3hot
> >    // upstream bridge
> >    # cat /sys/bus/pci/devices/0000\:00\:01.0/power_state
> >    D3hot  
> 
> I'm not able to reproduce these results.  Output below abridged:
> 
> # lspci -t
> -[0000:00]-+-00.0
>            +-01.0-[01]--+-00.0
>            |            \-00.1
> 
> # grep . /sys/bus/pci/devices/*/power_state
> /sys/bus/pci/devices/0000:00:01.0/power_state:D0
> /sys/bus/pci/devices/0000:01:00.0/power_state:D3hot
> /sys/bus/pci/devices/0000:01:00.1/power_state:D3hot
> 
> # lspci -ks $DEV
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port (rev 09)
> 	Kernel driver in use: pcieport
> 01:00.0 VGA compatible controller: NVIDIA Corporation GM107 [GeForce GTX 750] (rev a2)
> 	Subsystem: eVga.com. Corp. Device 2753
> 	Kernel driver in use: vfio-pci
> 01:00.1 Audio device: NVIDIA Corporation GM107 High Definition Audio Controller [GeForce 940MX] (rev a1)
> 	Subsystem: eVga.com. Corp. Device 2753
> 	Kernel driver in use: vfio-pci
> 	Kernel modules: snd_hda_intel
> 
> Any debugging suggestions?  Thanks,

Nevermind, I see a whole bunch of reasons in pci_bridge_d3_possible()
that runtime-pm wouldn't support D3hot on this bridge/system.  Thanks,

Alex

