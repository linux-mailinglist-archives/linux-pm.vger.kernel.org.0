Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF325D914
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 02:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGCAd5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 20:33:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34444 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGCAd5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 20:33:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so503144otk.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 17:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zC+ZxH6wfPZPhaTqx6b1yz89KG17lgp6HdOygwa818U=;
        b=ojmECjv4va08ZFnKiVQWQPkWOuqw+QYN4q0IMzzFDZ/4GsH9vFcCAH/bi2eIWxZaKW
         GBU9DRCtMCsI7D6u4jKiJjlFVisqmq2LLahJWWzml3GdfC2416DzfC16O2q+B9LO+Hl2
         RBdY3sZM0364JmSf5fNmDy3nDf4BdTVb8JSfwvgE8VUvb+oFnTnFAT0jXq4mrofk+Gn3
         S7JMJmbjK6e9L11P6QxqD2Sc9W9LLnXYGPSKj8cObhr05LnhIkbSR6KLD1fKhgWeO6qH
         U3yttMtszUlJiYkSQSdWS/wxd972Vko0WvAiX1qI5NWQkWmYSI4AYfEXXITmXyUR9VdK
         +9fQ==
X-Gm-Message-State: APjAAAV0xfba9K+ArPpXJ/87Y6Ru75I4LCLxLKUzEhmlPTRuUZaBdCH4
        pHkG5yMFMQSgYfFoHxSK9QJ828dShFSiJ3uG8RqKQw==
X-Google-Smtp-Source: APXvYqwFRZtxB6++6phGPG7QCu7yHCBFs6pmoZ3qCgJRf+VGoHwc+hizsS82xwWuJgojxsboS32J/8kifcOSg43cOwg=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr6375341otp.189.1562110015992;
 Tue, 02 Jul 2019 16:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com>
 <1561701029-3415-4-git-send-email-rui.zhang@intel.com> <CAJZ5v0hmfUtaQGgkf0p4_xWca+unKDUTsUb-BPXGr-1f4hCWaQ@mail.gmail.com>
 <38a3f6de85e55d94a1f3e9aa48e99c9f53d97127.camel@intel.com>
In-Reply-To: <38a3f6de85e55d94a1f3e9aa48e99c9f53d97127.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 01:26:44 +0200
Message-ID: <CAJZ5v0hLngERNPk=ptLFefZVaE1rWOkMdEzq_44zeY0XYETgeg@mail.gmail.com>
Subject: Re: [PATCH 03/13] intel_rapl: introduce intel_rapl.h
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 3, 2019 at 12:13 AM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> On Wed, 2019-07-03 at 00:01 +0200, Rafael J. Wysocki wrote:
> > On Fri, Jun 28, 2019 at 7:50 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > >
> > > Create a new header file for the common definitions that might be
> > > used
> > > by different RAPL Interface.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  MAINTAINERS                   |   1 +
> > >  drivers/powercap/intel_rapl.c | 101 +-----------------------------
> > > -------
> > >  include/linux/intel_rapl.h    | 113
> > > ++++++++++++++++++++++++++++++++++++++++++
> >
> > Does the header need to go into include/linux?
> >
> > That is, what is there in addition to the code under
> > drivers/powercap/
> > that will need that header file?
> The rapl common functions will be called from outside drivers/powercap.
> For MMIO it will be called from processor_thermal driver in
> drivers/thermal/intel/int340x

I see, OK
