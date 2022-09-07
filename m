Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C371E5B0E77
	for <lists+linux-pm@lfdr.de>; Wed,  7 Sep 2022 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiIGUs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Sep 2022 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIGUs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2022 16:48:27 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD85AC22AC
        for <linux-pm@vger.kernel.org>; Wed,  7 Sep 2022 13:48:25 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-127f5411b9cso7688163fac.4
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2022 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YASIjzw1LDe+VKtphl3/fRbVIDxJaus83cpKP5HNsyw=;
        b=VoDi7KKvOVMlkNb6NTLmj1/EUmOIK4dTzEbszNq5fElMHLBSt5uVH2td68MJlNQqR5
         FajYEDywytSduxtlHZLRoxWfpLh5I+3SiR55tKsuUiTaAZLra7Uh17k/CWM8sjcpr+Gs
         a67vn3vjtsB2deaAuScN0Zt7lmSAj/aZScSoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YASIjzw1LDe+VKtphl3/fRbVIDxJaus83cpKP5HNsyw=;
        b=7DrqPZOHgHGo5W9run/9KEqnDWqLbW8cknt0HjnEDONFyMzwDPnduTXt/h2Z8a0bic
         89ifrxwADwTAFPS7EN5mEdqE2ibNTm1sTPALcbjkEcjR444jNEuKIkp1ee1uds/ifRpQ
         cMDDpG+0AIGhwztxE9nMhZhYNnSsMPgd8H90vrJy6ePwNH6DE1TlXTpeG/XOLxgaMTwZ
         WCY3iD8QNVmbWzdVYsYc3Nj4JksACp91Gkh4Ro9WqqyELO1JhB27fob04gUoGPWzaTiy
         dFSHKJWjJnmzC7uiOGy661xQUJzlA2iYUSDEa/pnd71EnroXrIjeBi2pjHs/5Ua23Bm5
         L3uw==
X-Gm-Message-State: ACgBeo1Iz0hGvLaUxEZbpMkid99DLnAdQEub1wGPf8aaNZ1TgEiS5s0b
        gqei1KHrO6jL06LzJd5btP5NmeTlM5hl+Q==
X-Google-Smtp-Source: AA6agR7j9FZqxLurLNiZKUum4QLDfEHCl4/mVTp9lFg7HyyVz5Dk8Q+RkgquTMn/oBa3NlnSEzrNWw==
X-Received: by 2002:a05:6870:a78f:b0:127:ef52:2c7f with SMTP id x15-20020a056870a78f00b00127ef522c7fmr133902oao.237.1662583704881;
        Wed, 07 Sep 2022 13:48:24 -0700 (PDT)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com. [209.85.160.48])
        by smtp.gmail.com with ESMTPSA id b10-20020a05687051ca00b0011e73536301sm8685749oaj.52.2022.09.07.13.48.23
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 13:48:24 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1274ec87ad5so24138492fac.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2022 13:48:23 -0700 (PDT)
X-Received: by 2002:a05:6870:b28c:b0:127:ad43:573e with SMTP id
 c12-20020a056870b28c00b00127ad43573emr171693oao.174.1662583703304; Wed, 07
 Sep 2022 13:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com> <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
 <Yw7L+X2cHf9qprxl@kernel.org>
In-Reply-To: <Yw7L+X2cHf9qprxl@kernel.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 7 Sep 2022 13:47:47 -0700
X-Gmail-Original-Message-ID: <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
Message-ID: <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
Subject: Re: TPM: hibernate with IMA PCR 10
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <mgarrett@aurora.tech>,
        Ken Goldman <kgold@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 30, 2022 at 7:48 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 02:51:50PM -0700, Matthew Garrett wrote:
> > On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
> > >
> > > On 5/4/2022 7:20 PM, Evan Green wrote:
> > > > Enabling the kernel to be able to do encryption and integrity checks on
> > > > the hibernate image prevents a malicious userspace from escalating to
> > > > kernel execution via hibernation resume.  [snip]
> > >
> > > I have a related question.
> > >
> > > When a TPM powers up from hibernation, PCR 10 is reset.  When a
> > > hibernate image is restored:
> > >
> > > 1. Is there a design for how PCR 10 is restored?
> >
> > I don't see anything that does that at present.
> >
> > > 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> > > restored?
> >
> > They're part of the running kernel state, so should re-appear without
> > any special casing. However, in the absence of anything repopulating
> > PCR 10, they'll no longer match the in-TPM value.
>
> This feature could still be supported, if IMA is disabled
> in the kernel configuration, which I see a non-issue as
> long as config flag checks are there.

Right, from what I understand about IMA, the TPM's PCR getting out of
sync with the in-kernel measurement list across a hibernate (because
TPM is reset) or kexec() (because in-memory list gets reset) is
already a problem. This series doesn't really address that, in that it
doesn't really make that situation better or worse.

-Evan
