Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E752ACE3
	for <lists+linux-pm@lfdr.de>; Tue, 17 May 2022 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbiEQUnG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 May 2022 16:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiEQUnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 16:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED72F517D4
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652820180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3trp4THKfLyNocMqM17tbB76f3WfC6Jda0LcAL37Fw=;
        b=hU6JX74agI+e/rZMwauCYC6l4a2y5p8Xlnag8amN3sPbRIZ6x2KdPuVYbHoJ3EXTuh4pDW
        kLaoKdxoECBG3YMT17cCU9Wp89kJJ3kcx1noBOuRUuneL44qSSzEnxtcNPcq9dnQegZSa3
        tQ29IhtXgeh1CzBl0jcsg7Gpxgt+cfg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-9A5Br3XCMrqAjf6fRK9DSg-1; Tue, 17 May 2022 16:42:58 -0400
X-MC-Unique: 9A5Br3XCMrqAjf6fRK9DSg-1
Received: by mail-il1-f200.google.com with SMTP id b13-20020a92c56d000000b002d125a2ab95so108284ilj.13
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 13:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=P3trp4THKfLyNocMqM17tbB76f3WfC6Jda0LcAL37Fw=;
        b=CrdJHkMxxdxhw7SFpQC47It1eBu46orPzyq2qgnLs0dFGDE9gh1xDAvVxzYsgQ+qU2
         o279vHPTCLlNOJ5+bSL8mW3p52lq7D51/J7Naf2KibFQON60SCZbYu+LiDXp8ochuOlv
         V5UCHfnHdeUA/+MM8CVsweHJN/mcypUdQ4Yw1hUfDY0r7BjB7IPzXCTfIBKIY9RP3VyI
         CW7JOwTOawh2L4jGw78GMx7hNZfkZhHzgbcAj3A1CmJGUFaHMHkrb2iKsE5+6OAt7oOu
         Ucn31BJhGEhBP2GiXIN4GoGjTTzC6WtJOkNMSHUQaZzOJ8SBi5UqqRJaHpdP4EDXQ3UO
         /VXA==
X-Gm-Message-State: AOAM530RKmTZAf9Zv++moRQ81StRupXN2KbKrunKxFx8BXOBfysWvrz2
        sdINy7WwCPWNJ5CqlGFgqrpvHEjcTQoc11XHLUK6+dn4r0+gga3XfjgJMltbSGdtDWkYSiyUEKY
        1/CytI72sCTi1fRbDaK4=
X-Received: by 2002:a05:6638:238d:b0:32b:7bda:c64f with SMTP id q13-20020a056638238d00b0032b7bdac64fmr12542386jat.83.1652820178181;
        Tue, 17 May 2022 13:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysULVQudYSzAq7UHtvBIObb6CAUc81Y/IWTz7+noeXw8UvvY/htZu0mz/yF3emnUQORNpBVA==
X-Received: by 2002:a05:6638:238d:b0:32b:7bda:c64f with SMTP id q13-20020a056638238d00b0032b7bdac64fmr12542372jat.83.1652820177995;
        Tue, 17 May 2022 13:42:57 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d12-20020a0566380d4c00b0032e40f3e40dsm25502jak.124.2022.05.17.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:42:57 -0700 (PDT)
Date:   Tue, 17 May 2022 14:42:56 -0600
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
Message-ID: <20220517144256.15991375.alex.williamson@redhat.com>
In-Reply-To: <20220517100219.15146-5-abhsahu@nvidia.com>
References: <20220517100219.15146-1-abhsahu@nvidia.com>
        <20220517100219.15146-5-abhsahu@nvidia.com>
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

On Tue, 17 May 2022 15:32:19 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:
> 5. Since the runtime PM framework will provide the same functionality,
>    so directly writing into PCI PM config register can be replaced with
>    the use of runtime PM routines. Also, the use of runtime PM can help
>    us in more power saving.
> 
>    In the systems which do not support D3cold,
> 
>    With the existing implementation:
> 
>    // PCI device
>    # cat /sys/bus/pci/devices/0000\:01\:00.0/power_state
>    D3hot
>    // upstream bridge
>    # cat /sys/bus/pci/devices/0000\:00\:01.0/power_state
>    D0
> 
>    With runtime PM:
> 
>    // PCI device
>    # cat /sys/bus/pci/devices/0000\:01\:00.0/power_state
>    D3hot
>    // upstream bridge
>    # cat /sys/bus/pci/devices/0000\:00\:01.0/power_state
>    D3hot

I'm not able to reproduce these results.  Output below abridged:

# lspci -t
-[0000:00]-+-00.0
           +-01.0-[01]--+-00.0
           |            \-00.1

# grep . /sys/bus/pci/devices/*/power_state
/sys/bus/pci/devices/0000:00:01.0/power_state:D0
/sys/bus/pci/devices/0000:01:00.0/power_state:D3hot
/sys/bus/pci/devices/0000:01:00.1/power_state:D3hot

# lspci -ks $DEV
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port (rev 09)
	Kernel driver in use: pcieport
01:00.0 VGA compatible controller: NVIDIA Corporation GM107 [GeForce GTX 750] (rev a2)
	Subsystem: eVga.com. Corp. Device 2753
	Kernel driver in use: vfio-pci
01:00.1 Audio device: NVIDIA Corporation GM107 High Definition Audio Controller [GeForce 940MX] (rev a1)
	Subsystem: eVga.com. Corp. Device 2753
	Kernel driver in use: vfio-pci
	Kernel modules: snd_hda_intel

Any debugging suggestions?  Thanks,

Alex

