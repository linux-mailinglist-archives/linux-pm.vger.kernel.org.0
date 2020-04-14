Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EBF1A7657
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 10:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437020AbgDNImk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 04:42:40 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17852 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436845AbgDNImi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 04:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586853598; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ZSK1M9iyq2xeDVWV8f1PWAKe/9uCU4E9T6vOsK6u9aSiBWGXfIn0pocsjl4tzWveQh2ZDy2cj1b7bpHgekQf0jbXo9LUSmHOeFntpMA9PPG8b23qxVeQDSY4EsbYXLiuAT1HFLfypwEDqH3WZQeK5l7MGE8gNsnNqPEbAdLbAlU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1586853598; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5yxE8rjIQbfWB2zY24IJme7e+SE38jsS1KkXESLePEI=; 
        b=MxrSvTiMyZFwn8zPfXMUcshZgT9ZAOJ0+qDa6+Tzu6So7Sme1O/aiY+OqbHehQy4rx3Xw09wK2lY2ViNCEJpA1yP8gFpRCNHDfyGSPKKWhGbLu/guUngLhylu0oHCtT3ggf/NpQGrV50PP2CpYp0098dw1hWvD/QtR4tAy5dycc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=flygoat.com;
        spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
        dmarc=pass header.from=<jiaxun.yang@flygoat.com> header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1586853598;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=5yxE8rjIQbfWB2zY24IJme7e+SE38jsS1KkXESLePEI=;
        b=GpdV1a2IgBQOShDin5PNisEXA6+bNxd8Mf4rATLprEMaKlc4jf5QVVU3k27MHqSA
        UeRk2dKl2ZRMbjt9syeLztoXGin7EcYipNexBIvvaQFIBtsgI+VxL4WIGrfrnDqUgNf
        gaPqGT9RgEkxsHstO7khtgGjXMV3drq4ap00TVuE=
Received: from localhost (122.235.212.87 [122.235.212.87]) by mx.zoho.com.cn
        with SMTPS id 1586853596243411.62253278794117; Tue, 14 Apr 2020 16:39:56 +0800 (CST)
Date:   Tue, 14 Apr 2020 16:39:57 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-mips@vger.kernel.org, dietmar.eggemann@arm.com,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        " =?GB18030?B?1tzn/L3c?= (Zhou Yanjie)" <zhouyanjie@wanyeetech.com>,
        YunQiang Su <syq@debian.org>, Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steve Winslow <swinslow@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/11] MIPS: setup: Drop prefill_possible_map
Message-ID: <20200414163957.00006d65@flygoat.com>
In-Reply-To: <20200414082123.GA6459@bogus>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
        <20200412032123.3896114-2-jiaxun.yang@flygoat.com>
        <20200414082123.GA6459@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Apr 2020 09:21:36 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> On Sun, Apr 12, 2020 at 11:20:31AM +0800, Jiaxun Yang wrote:
> > All the plat_smp_setup are setting up possible cpus in their
> > platform code. So prefill_possible_map is actually overwriting
> > platform's setup, which seems unreasonable.
> >   
> 
> Why don't you rearrange the code so that this still remains as is and
> the platforms can override if they need. If you do so, you don't need
> the change in 04/11 as I suggested previously.

Actually this code break a case that cpumask is not continuous.
It do happen on some MIPS platforms.

Yes. rearrange this is a option but I think it is making the logic
unnecessarily complex.

If you think that's better I'll do so.

Thanks.
> 

--
Jiaxun Yang
