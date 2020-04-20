Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342761B057F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgDTJWV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 05:22:21 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:26907 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTJWV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 05:22:21 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 495LnK5hkRz8L;
        Mon, 20 Apr 2020 11:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1587374539; bh=3MXoIlRv+JlYYbnLOSIrj3nnS5x96d5V041E6lXJFOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwsjvCbuaOQrYT5P5a4M9+BfRlVaTvanm1BxA0zi+/gKwN/31YiRn8FEZOvu8dK/w
         VSehcnEl0n27LX7aWsyp33krF3pDiSE+xpaqTkWXb7WH3aGZ41NV3XIK31QLrah5Tp
         Ep8NsdRh9vS0+VdRB3UawuReVWJmHkex4WBFE1T2znu43XmXoBPQ9j9kI+jZ8F0RTH
         cr3aQDU8RX4I+JdMQl15TqLTOSgl7vk04pzLBzD7bQMIEkTEkSpx9z6jxakIlZO6wK
         haVUgAKxNalhz6npsMnCszbvv4OIonFEs7yXMYikUAN+S3af+qVlVw5KarNvF+310L
         GAEXcntkfydXg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 20 Apr 2020 11:22:09 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 07/11] power: supply: core: tabularize HWMON
 temperature labels
Message-ID: <20200420092209.GA25831@qmqm.qmqm.pl>
References: <29b5043db9a51ef7a0cb6e3a8c69c91e36045cd6.1585944770.git.mirq-linux@rere.qmqm.pl>
 <202004050928.d6QhVcsQ%lkp@intel.com>
 <CAKwvOdm5BhMdAmXR0gCLntkbvF7ajaNoWoHVCCio1CqbGzS6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdm5BhMdAmXR0gCLntkbvF7ajaNoWoHVCCio1CqbGzS6aQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 07, 2020 at 11:13:50AM -0700, Nick Desaulniers wrote:
> On Sat, Apr 4, 2020 at 6:53 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi "Micha³,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on power-supply/for-next]
> > [also build test WARNING on hwmon/hwmon-next linus/master v5.6 next-20200404]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Micha-Miros-aw/extensions-and-fixes/20200405-044024
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
> > config: x86_64-randconfig-b002-20200405 (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 62f3a9650a9f289a07a5f480764fb655178c2334)
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER=clang make.cross ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/power/supply/power_supply_hwmon.o: warning: objtool: power_supply_hwmon_read_string() falls through to next function power_supply_hwmon_write()
> 
> I'm guessing this is from the unreachable:
> https://github.com/0day-ci/linux/commit/b8b2d14ca46ca54257f55c9af58ea25695b9ee36
> I'll need to play with this some more as I couldn't reproduce with a
> simplified test case, but looks like a compiler bug.  Filed
> https://github.com/ClangBuiltLinux/linux/issues/978 for me to track.

Hi,

For gcc this is bug 51513 [1]. This does not affect correctness of the
code, so I wonder if we should/need be trying to work around it.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=51513

Best Regards,
Micha³ Miros³aw
