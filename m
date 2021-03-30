Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13634F1BD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhC3Tpm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 15:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhC3Tpa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Mar 2021 15:45:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39797619C2;
        Tue, 30 Mar 2021 19:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617133530;
        bh=u6vjZz4oDPFjlMjSlG8IJVQP899H5kLIGVQLMArI6Cc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iqt3eYMX+Ja0Ta1xuaATVHuAcqS2ni0JcM/ULtxrbl0clxM5ej+FGvxvwrr3ny6Uf
         1wr9XhxphUnVQlKB3ftip0iAScOX1N9icLKet2VHKmmvKwUa4XtrT/Aykbxp65sSrE
         HI8x5ZRxZNiPbti1LvGahvko7l+nvA3jTyZiGk0+QKRJfApFRVaA43TqK5kfNCBBa2
         TmAIXjhmXpOe4ZsQbl/FEqG9SZqMEPHC4u/CbOoAtElxJXnnX27vlDuVs9KKyAp78d
         2wtWijRe9iG23ivVP9yi1IAKV+JVtiJOSuYmSdDsnItOTTnHAGFZ1K/KUXT1G/CUaR
         f2Tbrf/AtA7fQ==
Received: by mail-ot1-f45.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so16683149ota.9;
        Tue, 30 Mar 2021 12:45:30 -0700 (PDT)
X-Gm-Message-State: AOAM530DDgxXGAdddmys3ZsxFoCBQxKCLzWnMjKp6l+l8I3R9dTjMDzX
        Br84j9iG8VPUIMhrgTclJB0e9/B5BtZaKHlc4eE=
X-Google-Smtp-Source: ABdhPJy2E7mSVBPaOGFTIjkA7I+VL/eeWS5OWSKhUl9IvVtc7HmxKyHS6as8hEfibKIMxOGu6rat0YqJN4BVUP63/hY=
X-Received: by 2002:a9d:12cb:: with SMTP id g69mr27883972otg.77.1617133529596;
 Tue, 30 Mar 2021 12:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com> <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
In-Reply-To: <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 30 Mar 2021 21:45:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
Message-ID: <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
Subject: Re: Fix hibernation in FIPS mode?
To:     Simo Sorce <simo@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
>
> On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> > On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> > > Hi,
> > > MD5 was marked incompliant with FIPS in 2009:
> > > a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> > > a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> > >
> > > But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> > > due to the 2018 patch:
> > > 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> > >
> > > As a result, hibernation doesn't work when FIPS is on.
> > >
> > > Do you think if hibernation_e820_save() should be changed to use a
> > > FIPS-compliant algorithm like SHA-1?
> >
> > I would say yes, it should.
> >
> > > PS, currently it looks like FIPS mode is broken in the mainline:
> > > https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
>
>
> FYI, SHA-1 is not a good choice, it is only permitted in HMAC
> constructions and only for specified uses. If you need to change
> algorithm you should go straight to SHA-2 or SHA-3 based hashes.
>

What is the reason for using a [broken] cryptographic hash here? if
this is just an integrity check, better use CRC32
