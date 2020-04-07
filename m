Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516491A1653
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgDGT5i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 15:57:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44554 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDGT5g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 15:57:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id n13so794943pgp.11
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v/v3EOCeKlH1yy1lBBdbnJgt8NXsE7ukja0JvSrCQjQ=;
        b=CQE9Dcfhusx6FQIpv2B+gU7vG9dGA9oCh6IUgcsC12yvUuXxsRfaZpgHl6wb5eLPZi
         F3mImKMTSl9feXaYzFnVf5OtPOZYH/rLINu1QxvttL0HeVnQf0i6RQ1quXFRxjE+d4Ro
         WJiLyCIkCTAlsm2txRotBFwXqETsl2dMXNi7feFe+9yUh8s+rSkzkgf3MipiaigCNqiX
         l36L9zXjGuo6s4K6qt4CnOg+8VUh2DtwJFzLqNE6Y+wYr0VNPCcy6HkPSa4xpm90I2jy
         XiOsQnBlCwPwfm+DokOlqNKk2grgcCYlht/MJ4ZnEH7eGyurFObi54XdeZsmTiJ/1dSt
         M1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v/v3EOCeKlH1yy1lBBdbnJgt8NXsE7ukja0JvSrCQjQ=;
        b=Svo5dppMJdzfZtg6zC9vN6kfVG9I9i2754cbW57Ln8AB/iqZCAeHGKHW2AHC1XQ2Da
         xTNLfptjFNhUrvS21Y41+AV4HauluSpjNh8jkBfxK3A/Yt3hUrqFqTuRmCSP5OygHLvj
         QTiE67tpxrWfURWvPLm+J6UnvZ2xK6bZLft47ISOrEa7HuquYEpsLM5588efd7gkXgtZ
         Fekm3+Q95HD92ryQSYxuDUnaME4RNjLw35+xyzxuTGU56LYb04gZfJzPNOO94Avswooy
         pHqPcET8CApJPQfEQImDN7xzSUFFHpV7O5nZbTJqu1DIrruCr34JXdz5EfNmeXoqdAkA
         Yf8A==
X-Gm-Message-State: AGi0PuZAQAgVQm2gFHOkCuPI8uiyVXLZ4jL93NgFFCxA0GzYXZLddald
        EQotNIsTL9BSBl9KRHWzYcUTdtXVZuyMFccoyqFubA==
X-Google-Smtp-Source: APiQypII/JsB+LYF2NyT6Q4N251TPQgr++zZZo+BiIULYVeFrP2T7zYy37qhEpV/Syk1GqNaKD4JaMLDMmplOFP/jq0=
X-Received: by 2002:a05:6a00:42:: with SMTP id i2mr4102001pfk.108.1586289454742;
 Tue, 07 Apr 2020 12:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <29b5043db9a51ef7a0cb6e3a8c69c91e36045cd6.1585944770.git.mirq-linux@rere.qmqm.pl>
 <202004050928.d6QhVcsQ%lkp@intel.com> <CAKwvOdm5BhMdAmXR0gCLntkbvF7ajaNoWoHVCCio1CqbGzS6aQ@mail.gmail.com>
 <20200407195546.GA744@qmqm.qmqm.pl>
In-Reply-To: <20200407195546.GA744@qmqm.qmqm.pl>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Apr 2020 12:57:23 -0700
Message-ID: <CAKwvOdnSgp5fL1B1S02haeEDBTfyHjmMFvGZd+LA3j7BoSLsLw@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] power: supply: core: tabularize HWMON
 temperature labels
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 7, 2020 at 12:56 PM Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.=
qmqm.pl> wrote:
>
> On Tue, Apr 07, 2020 at 11:13:50AM -0700, Nick Desaulniers wrote:
> > On Sat, Apr 4, 2020 at 6:53 PM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > Hi "Micha=C5=82,
> > >
> > > I love your patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on power-supply/for-next]
> > > [also build test WARNING on hwmon/hwmon-next linus/master v5.6 next-2=
0200404]
> > > [if your patch is applied to the wrong git tree, please drop us a not=
e to help
> > > improve the system. BTW, we also suggest to use '--base' option to sp=
ecify the
> > > base tree in git format-patch, please see https://stackoverflow.com/a=
/37406982]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Micha-Miros-aw/exten=
sions-and-fixes/20200405-044024
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-pow=
er-supply.git for-next
> > > config: x86_64-randconfig-b002-20200405 (attached as .config)
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project =
62f3a9650a9f289a07a5f480764fb655178c2334)
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         COMPILER=3Dclang make.cross ARCH=3Dx86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/power/supply/power_supply_hwmon.o: warning: objtool: power=
_supply_hwmon_read_string() falls through to next function power_supply_hwm=
on_write()
> >
> > I'm guessing this is from the unreachable:
> > https://github.com/0day-ci/linux/commit/b8b2d14ca46ca54257f55c9af58ea25=
695b9ee36
> > I'll need to play with this some more as I couldn't reproduce with a
> > simplified test case, but looks like a compiler bug.  Filed
> > https://github.com/ClangBuiltLinux/linux/issues/978 for me to track.
>
> Hi Nick,
>
> Just guessing: have you tried adding another unrelated function to the
> testcase? I would expect that 'fall through to next function' needs
> some other function to match.

I was throwing the test case linked into godbolt and looking at the
generated assembly.  It contained no jumps, only movs and conditional
movs.  Thank you for the suggestion.


--=20
Thanks,
~Nick Desaulniers
