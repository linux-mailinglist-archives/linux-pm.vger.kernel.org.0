Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6044CAB95
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 18:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiCBR2c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 12:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243849AbiCBR23 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 12:28:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29DF7DFBB
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 09:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646242052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LdGVpD6JC2co+YDkL+SNwGtc/UkboD0tVW/slwVWtYg=;
        b=IWNGfT2v3ZIEOrSnBcP2wGemlyXI4GX56fY0oO04XkZFrv1Qgy+skz2NVfaHv+HJWdGdN+
        kNEq4acBO6qlhREtZF/7d95afHXl/08ujZMVMQ8fgM5Mh3AzoEeSLYNA0PqjufXkwoSYa6
        RF0W+F7w6xDggKA8svL75yAHxyIlDKs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-SqFZwHH_NPuGfK54zNZbGA-1; Wed, 02 Mar 2022 12:27:31 -0500
X-MC-Unique: SqFZwHH_NPuGfK54zNZbGA-1
Received: by mail-wr1-f69.google.com with SMTP id ba15-20020a0560001c0f00b001f01822f821so884549wrb.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2022 09:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LdGVpD6JC2co+YDkL+SNwGtc/UkboD0tVW/slwVWtYg=;
        b=7l915yt4ISmjFkhIUpjftU0OUEloCNJ1mxVo6o0DA1F24X+RC/0ei/49s1vedemr6i
         odvkBLuliTT78Ek7QDzifPWjjw26WrAkfvXPU/FNAYhHcGGrhowrg5StWyZsj42OMzE6
         RMMbGrly7yCJMDYaqSVL1OrO6nS+GFVbMcw3Cfz4lC+xGXwf7D/T20FB+C32uKjE7XA6
         RU7UcnXRBrpSUemQP/1NOtBe7IMO2/kDwiFOulIIuTW4pJb2bt2elPPvbE4fD/cHicLS
         /2Qbz6YCwfZ0cwTwrrAFYa42q3+01mCI2whk2Fn6cF2fkNHrlWlgNbX64Pmc6ySJwBZ+
         Wk+A==
X-Gm-Message-State: AOAM532kPVKbIT4WEmlVbcfC4vnkzVpOnBECE7cq7+HsEw8dIAqK2e9b
        dWsBKYiigYG4GKMwdvmnsUzFs1q38+OlieCEhcZivuDafZwTy5EXAk0KVthRaJApXlsys6MaC2z
        NjHO/C909DfWdgxJEkE0=
X-Received: by 2002:a5d:47ac:0:b0:1ed:164f:8ed0 with SMTP id 12-20020a5d47ac000000b001ed164f8ed0mr23095468wrb.622.1646242050319;
        Wed, 02 Mar 2022 09:27:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5jLSkK6NkZFrdgBwYO0IRaD957h+T8kNnewiZxTC2pec2pB+yzgfBbghP0YSfy6Ertpoqhw==
X-Received: by 2002:a5d:47ac:0:b0:1ed:164f:8ed0 with SMTP id 12-20020a5d47ac000000b001ed164f8ed0mr23095446wrb.622.1646242050108;
        Wed, 02 Mar 2022 09:27:30 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003808165fbc2sm7335011wmq.25.2022.03.02.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:29 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:27:24 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        linux-hyperv@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adrian@parity.io,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: propagating vmgenid outward and upward
Message-ID: <20220302122640-mutt-send-email-mst@kernel.org>
References: <20220302031738-mutt-send-email-mst@kernel.org>
 <CAHmME9pf-bjnZuweoLqoFEmPy1OK7ogEgGEAva1T8uVTufhCuw@mail.gmail.com>
 <20220302074503-mutt-send-email-mst@kernel.org>
 <Yh93UZMQSYCe2LQ7@zx2c4.com>
 <20220302092149-mutt-send-email-mst@kernel.org>
 <CAHmME9rf7hQP78kReP2diWNeX=obPem=f8R-dC7Wkpic2xmffg@mail.gmail.com>
 <20220302101602-mutt-send-email-mst@kernel.org>
 <Yh+PET49oHNpxn+H@zx2c4.com>
 <20220302111737-mutt-send-email-mst@kernel.org>
 <Yh+cB5bWarl8CFN1@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+cB5bWarl8CFN1@zx2c4.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 02, 2022 at 05:32:07PM +0100, Jason A. Donenfeld wrote:
> Hi Michael,
> 
> On Wed, Mar 02, 2022 at 11:22:46AM -0500, Michael S. Tsirkin wrote:
> > > Because that 16 byte read of vmgenid is not atomic. Let's say you read
> > > the first 8 bytes, and then the VM is forked.
> > 
> > But at this point when VM was forked plaintext key and nonce are all in
> > buffer, and you previously indicated a fork at this point is harmless.
> > You wrote "If it changes _after_ that point of check ... it doesn't
> > matter:"
> 
> Ahhh, fair point. I think you're right.
> 
> Alright, so all we're talking about here is an ordinary 16-byte read,
> and 16 bytes of storage per keypair, and a 16-byte comparison.
> 
> Still seems much worse than just having a single word...
> 
> Jason

And it is, I saw a 30% higher overhead, it is however 30% of a very
low number ;)

-- 
MST

