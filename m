Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AFD6EF01
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2019 12:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfGTKSx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 20 Jul 2019 06:18:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34893 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfGTKSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Jul 2019 06:18:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so35381174otq.2
        for <linux-pm@vger.kernel.org>; Sat, 20 Jul 2019 03:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+mOd35hSo9QgB6V7Yb6SbHLSHMmtIs2b2Hit3bVGUHY=;
        b=MRXytJocfMGim//Y8yS3s5SgMGX7rXXv8RHTnDo9Q8rvUlKEBCosR5MLebrnCPXS3L
         +nWcDdqwvB8y1NeOilZEs8DFTk9cwlN8bRYGunsY5pNcFtvr2N+ErRZ3M7izs4z6gBt/
         fse6/5+asYssxeNF0X07Xc80oE5bfbxoh9+bMl33N1/7a8dtwKqDHmkmYjdFiUnAZDWk
         UcHaxwdJqVLkAzzqz20y8e+1sohZHXniAyjDdKDn+n77wsGVIK3NEAx6W17xCCGffs0h
         8oSJrq6urgJwOd20bfcmbpBdayOxegv28jvzjnmYs0oxaTM4hrYtf+UzCnR1DC0wqgjN
         Hehg==
X-Gm-Message-State: APjAAAWYMZD49xqMWZnz+p3zS59L/VEEisjhI/pbVMUCmnBjHdDaPbRJ
        +wf8Zm/0RS3N/B8sWylFrWUfeDzbC/r26zPsJYvD+A==
X-Google-Smtp-Source: APXvYqzG01Ka/momyzWlEAWtNpw1vGcGTuPoIyWnHkKykoQmqluoEN9eagtqLjFTYXcx1R8gUqs58evQvoOauzSNX+E=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr1628370otn.266.1563617932303;
 Sat, 20 Jul 2019 03:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360> <1563514893.2433.3.camel@intel.com>
 <alpine.DEB.2.21.1907182308321.2769@hp-x360> <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>
 <alpine.DEB.2.21.1907190601580.2769@hp-x360> <1563550442.2455.1.camel@intel.com>
 <alpine.DEB.2.21.1907191030130.2853@hp-x360> <1563585953.2455.7.camel@intel.com>
In-Reply-To: <1563585953.2455.7.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 20 Jul 2019 12:18:39 +0200
Message-ID: <CAJZ5v0j7QxrWtY8h=GgHWjpTm37AhnpNe5j=zLY3v7EwGi94ig@mail.gmail.com>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device: add
 support for MMIO RAPL") boot failure]
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 20, 2019 at 3:25 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On 五, 2019-07-19 at 10:31 -0700, Kenneth R. Crudup wrote:
> > On Fri, 19 Jul 2019, Zhang Rui wrote:
> >
> > >
> > > please try the patch below and confirm if it helps or not.
> > >
> > > From: Zhang Rui <rui.zhang@intel.com>
> > > Date: Fri, 19 Jul 2019 23:25:14 +0800
> > > Subject: [PATCH] powercap: adjust init order
> > The patch fixes the boot crash, yes.
> >
> Hi, Kenny,
>
> thanks for testing.
>
> Rafael,
>
> can we merge this urgent fix before the merge window closed?

Well, we could try that, but it is not even in Patchwork ATM and it
would be good to let it appear in linux-next too.

Please resend it as a proper patch, so that Patchwork can pick it up
and I'll queue it up and push it next week.

Cheers,
Rafael
