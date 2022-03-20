Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1284E1E2C
	for <lists+linux-pm@lfdr.de>; Sun, 20 Mar 2022 23:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbiCTWyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Mar 2022 18:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiCTWyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Mar 2022 18:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D76473633C
        for <linux-pm@vger.kernel.org>; Sun, 20 Mar 2022 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647816790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbklHsC4p2zDoA9Qm45sY9QvlkWdqqX9EtVTWkPxbLA=;
        b=TcNXjRqi/sMoz/p1eroeIlV8om0e909RmQme1L3vYD7ftn0dINAU/ouGFmIeBdqHCCsFGE
        VRsaV8Es6s2PXM/n2gSWTdphJNFWqBzZnxYmVQzF2YHJrPAij4lVc29ibYl48xVMmUj8KD
        CR2+/7q3Kna6eC9g0vB/Mh5GSrxWL9E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-5kqHZM3-MyGmfkvURSHk5A-1; Sun, 20 Mar 2022 18:53:08 -0400
X-MC-Unique: 5kqHZM3-MyGmfkvURSHk5A-1
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso7708078edh.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Mar 2022 15:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lbklHsC4p2zDoA9Qm45sY9QvlkWdqqX9EtVTWkPxbLA=;
        b=OAkO+jPFMY/07MMauRQ9uI60C1a+fMulQaHgU7SgjsS69uOXhKnXJ/2NTdEs/1z/f3
         LJR/ok8Xsxf/E9X8XcrhW/psH+By6MhHWY2sgoRd/e7xRX/CirWId/rX928VNtPYbD6T
         taH/Vyv2YDP8ohDjzMXf46DaFdkfoFEgDZEcjxokaqrpGc6v5BnAebs4JCau3bdIG9UG
         E6qAjL10aN2wCg+FRrWrK4ZWW+eFjmWtCncMbYjLgqZIPzqdhOuAs3e0SznRIqFhYSUc
         2aSuSto1aDOWqRI8eKJULlzRcA5XhwMfcoi6cEuctPJKUvUPAKpt/dUyw+oRIMUt1gUh
         ecnQ==
X-Gm-Message-State: AOAM533/VV/RHyAIWx0yZXWW79I94hX4JYcfF9cn+TIXWlDluXmNgSK6
        NO2AN64vqO/HG9Fa68l+HGjqHsAXyosHnFu4zWpYnSqO4ukuXDaZxqL7+tF/kuogmn954RVYoWg
        MHMLgj3JcqiVbW4DanB4=
X-Received: by 2002:a17:907:7287:b0:6df:8f48:3f76 with SMTP id dt7-20020a170907728700b006df8f483f76mr17022716ejc.411.1647816787615;
        Sun, 20 Mar 2022 15:53:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZe9l6Up1iG5LURVWCj/AihbE5iv/oi8hjD6mxD1AXkSiAxFIFKMfPOvm35kPXKaxucLH/AQ==
X-Received: by 2002:a17:907:7287:b0:6df:8f48:3f76 with SMTP id dt7-20020a170907728700b006df8f483f76mr17022701ejc.411.1647816787435;
        Sun, 20 Mar 2022 15:53:07 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm6300968ejj.74.2022.03.20.15.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 15:53:06 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:53:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        linux-hyperv@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adrian@parity.io, Laszlo Ersek <lersek@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: propagating vmgenid outward and upward
Message-ID: <20220320185049-mutt-send-email-mst@kernel.org>
References: <Yh4+9+UpanJWAIyZ@zx2c4.com>
 <c5181fb5-38fb-f261-9de5-24655be1c749@amazon.com>
 <CAHmME9rTMDkE7UA3_wg87mrDVYps+YaHw+dZwF0EbM0zC4pQQw@mail.gmail.com>
 <47137806-9162-0f60-e830-1a3731595c8c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47137806-9162-0f60-e830-1a3731595c8c@amazon.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 10, 2022 at 12:18:04PM +0100, Alexander Graf wrote:
> I agree on the slightly racy compromise

Thought hard about this, I think I agree, and I guess as a minimum we
can start with at least the ACPI+RNG patch, right? That will already
address wireguard ...

-- 
MST

