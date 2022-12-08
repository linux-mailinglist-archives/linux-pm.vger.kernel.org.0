Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096E6647580
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 19:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLHS0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHS0o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 13:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6F88B55
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670523949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1VVUcW2d/r4TNKwvpnKWV11TO1c/pvTjCV/IvxcjRo=;
        b=VtaKdjHYAhRMFFMVxdN0mk3ZeRQorik4gTxfyi2Bw14eJCQH5XXfp1/+ftFedct2zycMVv
        dpQ2S5EB4gqMMRHI5NJFQQnbo5JvEAtsKKeww9PXbrP92Aqj2Uj/1UGYKawgk5VJgLnh/+
        Z8QKd7o0R9ISmJ9JE2Ib+GlU3Lzjqtc=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-bzGZu1wTNxOsfBxsh-8_Gw-1; Thu, 08 Dec 2022 13:25:48 -0500
X-MC-Unique: bzGZu1wTNxOsfBxsh-8_Gw-1
Received: by mail-io1-f69.google.com with SMTP id h11-20020a6b7a0b000000b006e0004fc167so724588iom.5
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2022 10:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1VVUcW2d/r4TNKwvpnKWV11TO1c/pvTjCV/IvxcjRo=;
        b=zgksU8DzIuYriu+wDXOLN2UI16lKZCR4J80QTfLIty9GvPhIvgll/Eo4lpgK4C9m42
         6jZ5Jx6CGQ/eudu5+DpA/W02Fmxosh5v2S/3F2UaDOQ45W3zFTfTFGkxOHHaeUpLfOJG
         +IY/V+f5disWKvkZv3mWRknEHjcL0/K94sTtS6z1+KOEYYoUGphUU4SlLtyzOhYmQzic
         ewufyEbatDRvkPF1kazusZOZiWxMiossyCN0NiznAgyKul7HHwkaXn6goSVZ6GDockGv
         2LsTkrIn+gXPEd3wsYXByy/ofzufrx/6yV6TKuPf8hPYFjUOau5OY625Ehm73j6bUKHk
         VZCg==
X-Gm-Message-State: ANoB5pnfUd6SrOgS0xud/hiuNnqHxUxLcdRIGnqTxTNWNDYcjurYlR4W
        iHy8qZZ9hUUG7aezAOiWi2ptd491fC6x2ojPHbKmMZXbKPv1TxzhcaOC8qHC9ZVr54MNvrLcT8P
        aZmobjl1Qf3cw4MbRDT8v3vpZSmS7/b443Fk=
X-Received: by 2002:a02:c737:0:b0:375:1c5f:3127 with SMTP id h23-20020a02c737000000b003751c5f3127mr35668695jao.251.1670523948074;
        Thu, 08 Dec 2022 10:25:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7XCBcc0cLWH0jfXhA5ZbFHiNTG82whiCD4Mw1h1hz6rEL64t1cqCthrqMh8k4p9AolzPHI251n+gp0C6VYXbE=
X-Received: by 2002:a02:c737:0:b0:375:1c5f:3127 with SMTP id
 h23-20020a02c737000000b003751c5f3127mr35668682jao.251.1670523947849; Thu, 08
 Dec 2022 10:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
 <c09c9cef-14ac-2ab3-5e01-13189823a053@redhat.com> <CAO-hwJLHzRCJF96gKJwj7zCCPxRLoEw=cQ2w8=yLBOfyZz-c8w@mail.gmail.com>
 <304bce39-2ece-863c-33b3-b432685faa2d@gmail.com>
In-Reply-To: <304bce39-2ece-863c-33b3-b432685faa2d@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 8 Dec 2022 19:25:36 +0100
Message-ID: <CAO-hwJJ3MLvSeEkqdT_aj6kHLWzk2sVNRVsaeyfk4VpTdzK5Gw@mail.gmail.com>
Subject: Re: [PATCH 0/9] platform/surface: aggregator: Improve target/source
 handling in SSH messages
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 8, 2022 at 5:49 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 12/8/22 17:24, Benjamin Tissoires wrote:
> > On Thu, Dec 8, 2022 at 5:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Maximilian,
> >>
> >> On 12/2/22 23:33, Maximilian Luz wrote:
> >>> We have some new insights into the Serial Hub protocol, obtained through
> >>> reverse engineering. In particular, regarding the command structure. The
> >>> input/output target IDs actually represent source and target IDs of
> >>> (what looks like) physical entities (specifically: host, SAM EC, KIP EC,
> >>> debug connector, and SurfLink connector).
> >>>
> >>> This series aims to improve handling of messages with regards to those
> >>> new findings and, mainly, improve clarity of the documentation and usage
> >>> around those fields.
> >>>
> >>> See the discussion in
> >>>
> >>>      https://github.com/linux-surface/surface-aggregator-module/issues/64
> >>>
> >>> for more details.
> >>>
> >>> There are a couple of standouts:
> >>>
> >>> - Patch 1 ensures that we only handle commands actually intended for us.
> >>>    It's possible that we receive messages not intended for us when we
> >>>    enable debugging. I've kept it intentionally minimal to simplify
> >>>    backporting. The rest of the series patch 9 focuses more on clarity
> >>>    and documentation, which is probably too much to backport.
> >>>
> >>> - Patch 8 touches on multiple subsystems. The intention is to enforce
> >>>    proper usage and documentation of target IDs in the SSAM_SDEV() /
> >>>    SSAM_VDEV() macros. As it directly touches those macros I
> >>>    unfortunately can't split it up by subsystem.
> >>>
> >>> - Patch 9 is a loosely connected cleanup for consistency.
> >>
> >> Thank you for the patches. Unfortunately I don't have time atm to
> >> review this.
> >>
> >> And the next 2 weeks are the merge window, followed by 2 weeks
> >> of christmas vacation.
> >>
> >> So I'm afraid that I likely won't get around to reviewing
> >> this until the week of January 9th.
> >>
> >>> Hans, Jiri, Benjamin, Sebastian: While patch 8 ("platform/surface:
> >>> aggregator: Enforce use of target-ID enum in device ID macros") touches
> >>> multiple subsystems, it should be possible to take the whole series
> >>> through the pdx86 tree. The changes in other subsystems are fairly
> >>> limited.
> >>
> >> I agree that it will be best to take all of this upstream through the
> >> pdx86 tree. Sebastian thank you for the ack for patch 8/9.
> >>
> >> Jiri or Benjamin may we have your ack for merging patch 7/9 + 8/9
> >> through the pdx86 tree ?
> >
> > I can give you an ack for taking those through your tree, but I can
> > not review the patches themselves because I was only CC-ed to those 2,
> > and so was linux-input. Given that SSAM_SSH_TID_KIP is not in my
> > current tree I assume it comes from this series.
> >
> > Anyway, enough ranting :)
>
> Apologies for that. I should have included you in the CC on at least
> patch 2 as well, which introduces this symbol.

No need to apologize. There is a tight balance between not annoying
people with too many emails and then having those people wanting to
have all of the series :)

I have enough trust in Hans to know that when he reviewed the series,
he did it correctly.

>
> FWIW, here's the patchwork link to this series:
>
>    https://patchwork.kernel.org/project/platform-driver-x86/list/?series=701392

thanks!

Cheers,
Benjamin

