Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9A5E06D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGCJCP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 3 Jul 2019 05:02:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38243 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGCJCP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 05:02:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so1568175oth.5
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 02:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ExAR0ChiG/XE2kn81HZ1Zn1jsLOp72ri/uL2YdkXXog=;
        b=p3HyGRDcWJACaHrkmaJTWn9rHTkuC9I24yKHk77UwN8W1Gl4QIdQZBF1zS+XWcz+p1
         G/W7CjgmIoYfO13oC1j9Adrz91OvdZDGbCqTbzBhShQlCGcZzz1CW5+DGo14uIXab8t0
         +mQEAgqlG9CInSMT4ENLwjpnO3beh661eplSQMPvAtuERMB0IBbg9S47K33W4ahBMnOC
         0K+SohsUfhxonxpA5EVQ5AxaBde6s16JSlmCt8SEaIkb8c68jXAKM0rfVqXyKgWN7LKg
         iwXjmB48QQhbM7ECnbKVHWCwm+dQuQZdDQEG43L2c1bC+oa2TiZMfkgIugqCQ8r62Mwk
         LjBw==
X-Gm-Message-State: APjAAAXX6GVUpx8uvKTz8eILfuRiGFVeknhYvyntlWtQ8vVcUNk04BIJ
        77UeObV646h48NyJpYxV5IONKjZmpAjYjFFlXLg=
X-Google-Smtp-Source: APXvYqxoZJSAafaB3PGx6qZul/twjFzTY6cWGonp+DcxvtvKopNv7dlXkwgd2wD6wtuRbEsvZF+1s11391GVmF+dakQ=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr8188098otp.189.1562144534839;
 Wed, 03 Jul 2019 02:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com>
 <1561701029-3415-10-git-send-email-rui.zhang@intel.com> <CAJZ5v0gEW_9UaZDnJdz60e6baEYQOuG-SdZu54tswho6J+zYkQ@mail.gmail.com>
 <1562142196.3256.15.camel@intel.com>
In-Reply-To: <1562142196.3256.15.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 11:02:02 +0200
Message-ID: <CAJZ5v0jdbtLWCwamgxJ=cTwwjxqtF9zVwotE55AtTOZOzTPbDQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] intel_rapl: abstract RAPL common code
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 3, 2019 at 10:23 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On 二, 2019-07-02 at 23:59 +0200, Rafael J. Wysocki wrote:
> > On Fri, Jun 28, 2019 at 7:50 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > >
> > >
> > > Split intel_rapl.c to intel_rapl_common.c and intel_rapl.c, where
> > > intel_rapl_common.c contains the common code that can be used by
> > > both MSR
> > > and MMIO interface.
> > > intel_rapl.c still contains the implementation of RAPL MSR
> > > interface.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/powercap/Kconfig             |   11 +-
> > >  drivers/powercap/Makefile            |    1 +
> > >  drivers/powercap/intel_rapl.c        | 1427 +---------------------
> > > -----------
> > >  drivers/powercap/intel_rapl_common.c | 1468
> > > ++++++++++++++++++++++++++++++++++
> > intel_rapl_common.c and intel_rapl_msr.c, please.
> >
> I kept the MSR RAPL interface in intel_rapl.c for compatibility reason,
> and that was made when the module autoloading issue is not fixed, so
> people can still use "modprobe intel_rapl" manually to get the MSR RAPL
> interface.

The module still can be called intel_rapl.o.
