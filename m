Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2151A183E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 00:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGWb6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 18:31:58 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40211 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDGWb5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 18:31:57 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so345794pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qO6Gs/+ghdNmMtlex3NyMgewM+o4zRjcI5tZj5v3DvQ=;
        b=E/4CNB6jlUlu49qleV6KxQ3+rWw4kjJMdwVwcCMkXpPFpsTsPpua3C+WV/1jHf7ojh
         d3ggmIOHNaoMdFAqls9uG2yiOEsUxEpwZdiqUR5WcqGodPzBn3sNFru+S+PHGC8zXRCL
         1lW0Vj4/A0c7Mq4l8NSBevs1R13My8jeMCngI0uQA4wKcVyj/BCPlJ/W0AWf7zIiCiVf
         oGp65mb0YqFPvovIDZ90RIw3PJAnD748V/z3rbc3AHfqLuC4jdypt0N2Y09pEVzOtoQ0
         gi/5X0lL7SMCxo51fogti41+srdvAjuTmoCUE9UW7xmiog22pq7QLgsFRV5E4hnNDgCM
         78rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qO6Gs/+ghdNmMtlex3NyMgewM+o4zRjcI5tZj5v3DvQ=;
        b=lXkl5AxLyJAQZlsAmZhyeU1ON/yoB5uqzyu+LeiRg1tuuUaIsLJXb9mT9lJUH4e3dM
         AGfU92yDJ9MCpi2O52f50ir1lZETzUTWc95IkxOIjPydusv8ZhLLnDjf6ej+8yQ8hrtC
         YnS1VG/B5iJuB4jM3aQtGFgm0EOf7rtI+hlJ1RtxGyu443RTdOqzTRd7n/L03NIZTjTk
         ohfGir7+a1LZWoJyxAXqGoIsF8OUaYoE/fPY5Iru/fPnmigo/SbWzDnXGXSCTgyY2CMH
         722tCDTbDwLPl9f9s11jgIq9MxmbNXq5yjl9j+jKNWRIoxCgjXGzyZkPS0zrA9kFYvMa
         jsWg==
X-Gm-Message-State: AGi0PuYWpjYFjKVmsacZFmI4uL5v6Q04D9+MMFuflexQZ2iBDEMOk687
        fSUEqtIKz3Mrj/b9zZKw0SzqoU9khU3BTyyHsriWlw==
X-Google-Smtp-Source: APiQypLo9mflBOzty872Iorw5CxxpHfIgUrfJirngE1DvFdD8tgUthhA/36vO9mtelpunMqgUzFSuw8si7S4s/iyhe4=
X-Received: by 2002:a17:90b:3783:: with SMTP id mz3mr1720959pjb.27.1586298716554;
 Tue, 07 Apr 2020 15:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <29b5043db9a51ef7a0cb6e3a8c69c91e36045cd6.1585944770.git.mirq-linux@rere.qmqm.pl>
 <202004050928.d6QhVcsQ%lkp@intel.com> <CAKwvOdm5BhMdAmXR0gCLntkbvF7ajaNoWoHVCCio1CqbGzS6aQ@mail.gmail.com>
 <20200407195546.GA744@qmqm.qmqm.pl> <CAKwvOdnSgp5fL1B1S02haeEDBTfyHjmMFvGZd+LA3j7BoSLsLw@mail.gmail.com>
In-Reply-To: <CAKwvOdnSgp5fL1B1S02haeEDBTfyHjmMFvGZd+LA3j7BoSLsLw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Apr 2020 15:31:44 -0700
Message-ID: <CAKwvOd=mnCaFS2-4gSn+oGHtiZu-wObo4_LzN74fPNDyO0eegA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] power: supply: core: tabularize HWMON
 temperature labels
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Ilie Halip <ilie.halip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Ilie

On Tue, Apr 7, 2020 at 12:57 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Apr 7, 2020 at 12:56 PM Micha=C5=82 Miros=C5=82aw <mirq-linux@rer=
e.qmqm.pl> wrote:
> >
> > On Tue, Apr 07, 2020 at 11:13:50AM -0700, Nick Desaulniers wrote:
> > > On Sat, Apr 4, 2020 at 6:53 PM kbuild test robot <lkp@intel.com> wrot=
e:
> > > >
> > > > Hi "Micha=C5=82,
> > > >
> > > > I love your patch! Perhaps something to improve:
> > > >
> > > > [auto build test WARNING on power-supply/for-next]
> > > > [also build test WARNING on hwmon/hwmon-next linus/master v5.6 next=
-20200404]
> > > > [if your patch is applied to the wrong git tree, please drop us a n=
ote to help
> > > > improve the system. BTW, we also suggest to use '--base' option to =
specify the
> > > > base tree in git format-patch, please see https://stackoverflow.com=
/a/37406982]
> > > >
> > > > url:    https://github.com/0day-ci/linux/commits/Micha-Miros-aw/ext=
ensions-and-fixes/20200405-044024
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-p=
ower-supply.git for-next
> > > > config: x86_64-randconfig-b002-20200405 (attached as .config)
> > > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-projec=
t 62f3a9650a9f289a07a5f480764fb655178c2334)
> > > > reproduce:
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/mast=
er/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER=3Dclang make.cross ARCH=3Dx86_64
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > > >> drivers/power/supply/power_supply_hwmon.o: warning: objtool: pow=
er_supply_hwmon_read_string() falls through to next function power_supply_h=
wmon_write()
> > >
> > > I'm guessing this is from the unreachable:
> > > https://github.com/0day-ci/linux/commit/b8b2d14ca46ca54257f55c9af58ea=
25695b9ee36
> > > I'll need to play with this some more as I couldn't reproduce with a
> > > simplified test case, but looks like a compiler bug.  Filed
> > > https://github.com/ClangBuiltLinux/linux/issues/978 for me to track.
> >
> > Hi Nick,
> >
> > Just guessing: have you tried adding another unrelated function to the
> > testcase? I would expect that 'fall through to next function' needs
> > some other function to match.

See Ilie's suggestion:
https://github.com/ClangBuiltLinux/linux/issues/978#issuecomment-610633039


--=20
Thanks,
~Nick Desaulniers
