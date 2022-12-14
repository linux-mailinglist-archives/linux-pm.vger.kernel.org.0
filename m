Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF68664CDCD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Dec 2022 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbiLNQRP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Dec 2022 11:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiLNQRO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Dec 2022 11:17:14 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359E212A88
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 08:17:13 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id s9so2845160qtx.6
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 08:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7Ymab7cD/wHmHDafuH2eWQm0Ijt5FNyprRpbCwN6YE=;
        b=ne1syXh5oiO0V+brq3FfGe/L0rPjzl9/t8QUx/LS36zKKiEQvUNTvikYEMtpUCXGVP
         JGna/5qvL/5E4Q7nxHUH4z14FEYZ1S//+tw7cvTXjUZ9kK7fR/Xn67EpercV90Sg0qmE
         7SS5MYtAcyMLw5YOY5B4V2IDRhfwT5+PiQjpEtetWkU1nAJ5I1vtX1d5BpSUWXc6gALV
         5ZoFXDmQrUgB7B8j89H9kNH9Qmfam3td6N6uto15QmO7mcil26pfJzzB4aFmJ8NfeAK3
         CdMrUKM+L94fyc7mAZq20LkZW5DhXQpdqtU/PFYZj3Yh7JQVxBv3fFq6D6sdfbhvarbv
         9YZw==
X-Gm-Message-State: ANoB5pn2SeFYpxKypEccCaAhwnf5fw+cq1V0CCnv+tqeVVDrvhSlN9sC
        /geM3p+2DQKmw3g9zy1wUSRTloy5wRVVE9HpZb4=
X-Google-Smtp-Source: AA0mqf5C15ZNMl7+Hm2Vb4Swq0NpPliksd8SF9gqrg9Z3TcQITpF20lTC2h0ZKDL8PbPfTxYbRevl+u01fsvjGZigEQ=
X-Received: by 2002:ac8:7c8f:0:b0:3a8:1410:2dbe with SMTP id
 y15-20020ac87c8f000000b003a814102dbemr706243qtv.48.1671034632319; Wed, 14 Dec
 2022 08:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20221108033332.27760-1-rui.zhang@intel.com> <20221108033332.27760-2-rui.zhang@intel.com>
 <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
 <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
 <b40f141c0266b6971f8dec0e63964dd1311b1747.camel@intel.com>
 <CAJZ5v0j=x6ofgTFcoRw1bsoCbsbA7uAqQNddXVeXXOuwQzcNBQ@mail.gmail.com>
 <10cae7a3db86278c39ecb8837ec000b054c51ebc.camel@intel.com>
 <CAJZ5v0gscS-b+B-uqSFOVX=wA-gABP8f9n+oJ5WMZTRcrs66bQ@mail.gmail.com> <144b4c404eeaac1cf323ff3801d622d1beda3efc.camel@intel.com>
In-Reply-To: <144b4c404eeaac1cf323ff3801d622d1beda3efc.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Dec 2022 17:17:01 +0100
Message-ID: <CAJZ5v0jom8YvVR0cBHVEhmrF_3TGvksYvPqxWyo3PS85nxbN3A@mail.gmail.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 14, 2022 at 5:15 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Tue, 2022-12-13 at 16:34 +0100, Rafael J. Wysocki wrote:
> > On Tue, Dec 13, 2022 at 2:38 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > > On Mon, 2022-12-12 at 13:11 +0100, Rafael J. Wysocki wrote:
> > > > On Sun, Dec 11, 2022 at 8:24 AM Zhang Rui <rui.zhang@intel.com>
> > > > wrote:
> > > > > > > > +       if (err)
> > > > > > > > +               return err;
> > > > > > > > +
> > > > > > > > +       *tjmax = (eax >> 16) & 0xff;
> > > > > > >
> > > > > > > This means that the tjmax value cannot be negative.
> > > > > > >
> > > > > > > > +
> > > > > > > > +       return *tjmax ? 0 : -EINVAL;
> > > > > > >
> > > > > > > So the return value of this function could be tjmax if
> > > > > > > positive
> > > > > > > or
> > > > > > > a
> > > > > > > negative error code otherwise.  No return pointers needed.
> > > > > >
> > > > > > I tried both. And I think I chose this solution just because
> > > > > > it
> > > > > > makes
> > > > > > the following cleanup patches in this series looks prettier.
> > > > > >
> > > > > > I will try your suggestion, and if there is any other reason
> > > > > > I
> > > > > > wrote
> > > > > > it
> > > > > > in this way, I will find it out again. :p
> > > > >
> > > > > I see.
> > > > > Say, we have to use
> > > > >
> > > > > intel_tcc_get_temp(int cpu, int *temp)
> > > >
> > > > Do we?
> > >
> > > temp = tjmax - digital_readout
> > >
> > > tjmax and digital_readout are from MSR and they are both positive
> > > values, but temp can be negative in theory.
> >
> > I know, but is this ever expected to happen?
> >
> > > so are you suggesting that we should treat the negative CPU
> > > temperature
> > > as an error because this won't happen in real world?
> >
> > No.
> >
> > If it's necessary to handle negative temperatures, an int is needed
> > and the additional return value is useful.
> >
> > Now there is also the question of what the callers will do with a
> > negative temperature value.  Do they care?
>
> Currently, all the callers are from sysfs attribute.
> for userspace tools, at least thermald ignores negative CPU
> temperature.
> So I will return an error for negative temperature in next version.

Sounds good.
