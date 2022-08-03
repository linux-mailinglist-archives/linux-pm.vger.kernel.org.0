Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE925893D6
	for <lists+linux-pm@lfdr.de>; Wed,  3 Aug 2022 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiHCU4R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Aug 2022 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiHCU4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2022 16:56:16 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDCD17AA1
        for <linux-pm@vger.kernel.org>; Wed,  3 Aug 2022 13:56:15 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d16so2179741qtw.8
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2022 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybP/ElRLkO+EJL+/j9uG30N2lLShN588ns/EY1gUwXs=;
        b=Ciy86lX6LuQK0c5yd6gR52m67WVfapJjjyJqpBfkLvfZMQ/fOScolJAYm98o1FWitT
         b3bG/cJFhkjGnNpxEEwnGbCqGT/Uu9JHWs/h5krFWqmVLMiBzgt4xOX2Y03TVeB4e4Zu
         p8bCkmMuI4XQ6sMTiw+nKNv4elcQtAk7R76f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybP/ElRLkO+EJL+/j9uG30N2lLShN588ns/EY1gUwXs=;
        b=voEuKL8+Ztb3FHEWqLhHUz4CRoXtVz2cA2+0y+OKVNF7gP6MwZVfMxKoQIgXpb2j/o
         PsCWT0HVsUPUUKcw7SPiGfMQy9h7+a4lKYQEPxDMGvlhBgWPf9bmu/wA8WPc/kNlnuAI
         AvBRPilcw/AJ1zM9qurb/PVbgN/0uJ+8LGoUaFoB1JIoD210Em6vqimNX1PNxO+5XzPU
         m46ZygZXk9zd9DdMTwY9sPVadNFuCJoO07o/rdVhVosRcqHmt0heQ7APr5Wr1GACIfWR
         Nh7Hfr4G3ktQYtGE+gwyi2UMmoOor7phagUETTcoKVWIWOfWzl4oO98gD+IADkQjWmBX
         vRyg==
X-Gm-Message-State: AJIora9ZTSUstPdJ/Kms1/awAKo4NfWKyKNzynevODQaRUUffjgO9zys
        4ktNtfmVa/Lx7ceJ1+yCSJnRF9YQIxlKjw==
X-Google-Smtp-Source: AGRyM1tUOE8j+zPGoqgtmejsPnX6fBpZlovZyDyXrtLmTvsiRs1iOCnXpwRlyBCspW+MS+CFiBr01g==
X-Received: by 2002:ac8:7fcb:0:b0:31e:f635:c9a0 with SMTP id b11-20020ac87fcb000000b0031ef635c9a0mr24269144qtk.157.1659560174538;
        Wed, 03 Aug 2022 13:56:14 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05620a31a700b006b555509398sm12474839qkb.136.2022.08.03.13.56.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 13:56:14 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 204so29023285yba.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2022 13:56:14 -0700 (PDT)
X-Received: by 2002:a05:6830:290a:b0:618:b519:53f5 with SMTP id
 z10-20020a056830290a00b00618b51953f5mr9795274otu.237.1659559724240; Wed, 03
 Aug 2022 13:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <YumpwkIz+S+zDfol@sol.localdomain>
In-Reply-To: <YumpwkIz+S+zDfol@sol.localdomain>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 3 Aug 2022 13:48:08 -0700
X-Gmail-Original-Message-ID: <CAE=gft4_M=9TsbHFEVQO-3BRrQsDia0Mwt0C9OpA6fMcnaDsrw@mail.gmail.com>
Message-ID: <CAE=gft4_M=9TsbHFEVQO-3BRrQsDia0Mwt0C9OpA6fMcnaDsrw@mail.gmail.com>
Subject: Re: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 2, 2022 at 3:48 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, May 04, 2022 at 04:21:00PM -0700, Evan Green wrote:
> > +/*
> > + * Allow user mode to fold in key material for the data portion of the hibernate
> > + * image.
> > + */
> > +struct uswsusp_user_key {
> > +     /* Kernel returns the metadata size. */
> > +     __kernel_loff_t meta_size;
> > +     __u32 key_len;
> > +     __u8 key[16];
> > +     __u32 pad;
> > +};
>
> Shouldn't the key field be 32 bytes?
>

Short answer: yes, it should, will fix. Long answer: I had used a
hardcoded AEAD algorithm of "gcm(aes)", and was envisioning it being
AES128. But making it accommodate 32 bytes now before this gets set in
stone is a better idea.

> > +/* Derive a key from the kernel and user keys for data encryption. */
> > +static int snapshot_use_user_key(struct snapshot_data *data)
> > +{
> > +     struct shash_desc *desc;
> > +     u8 digest[SHA256_DIGEST_SIZE];
> > +     struct trusted_key_payload *payload;
> > +     struct crypto_shash *tfm;
> > +     int ret;
> > +
> > +     tfm = crypto_alloc_shash("sha256", 0, 0);
> > +     if (IS_ERR(tfm)) {
> > +             ret = -EINVAL;
> > +             goto err_rel;
> > +     }
> > +
> > +     desc = kmalloc(sizeof(struct shash_desc) +
> > +                    crypto_shash_descsize(tfm), GFP_KERNEL);
> > +     if (!desc) {
> > +             ret = -ENOMEM;
> > +             goto err_rel;
> > +     }
> > +
> > +     desc->tfm = tfm;
> > +     ret = crypto_shash_init(desc);
> > +     if (ret != 0)
> > +             goto err_free;
> > +
> > +     /*
> > +      * Hash the kernel key and the user key together. This folds in the user
> > +      * key, but not in a way that gives the user mode predictable control
> > +      * over the key bits. Hash in all 32 bytes of the key even though only 16
> > +      * are in active use as extra salt.
> > +      */
> > +     payload = data->key->payload.data[0];
> > +     crypto_shash_update(desc, payload->key, MIN_KEY_SIZE);
> > +     crypto_shash_update(desc, data->user_key, sizeof(data->user_key));
> > +     crypto_shash_final(desc, digest);
> > +     ret = crypto_aead_setkey(data->aead_tfm,
> > +                              digest,
> > +                              SNAPSHOT_ENCRYPTION_KEY_SIZE);
> > +
> > +err_free:
> > +     kfree(desc);
> > +
> > +err_rel:
> > +     crypto_free_shash(tfm);
> > +     return ret;
> > +}
>
> Just select CRYPTO_LIB_SHA256, and you can use sha256_init/update/final which
> would be much simpler.  Similarly with sha256_data() that is added by the next
> patch; you could just call sha256().

Good idea, will do. Thanks!

>
> - Eric
