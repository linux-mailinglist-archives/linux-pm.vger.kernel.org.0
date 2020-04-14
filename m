Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7C1A7647
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436966AbgDNIiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 04:38:21 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17822 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436965AbgDNIiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 04:38:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586853318; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=X69YMJgD4rV2vo8a/7oARBHBEmxcrrECiE/OTTv6kBGFrETLPTRc0861mbMUwUCrTGBS36MyyBEsJIIZbksTJ/FQuCHL1zy2ODjt03CaaHwvycxUc9ll4Fz99UecVVkS2F8jl6QcEQcrP9S9NUBKUVFkTnkGbQrzRg2TlmxyaMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1586853318; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=84CrosZczlRKs4cv9GnHtu9KBHymfYmBVO3bAUZ/y6w=; 
        b=CoYq2vjxJaEW+p0M4Lsbbahs37GRWw4yRPoaYhzcW5PLKVelw3TsNo5PpiXn6bLbukLLMxIGb8nZMJscwaV46TIMvhO1QVUI1KAvvx8v1kjKG8UxqnLx+x6a4zOsjRLgHKjjC4tHAEwtm31ppwXEBLAPI7Mh6eYoUP+031ORxu4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=flygoat.com;
        spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
        dmarc=pass header.from=<jiaxun.yang@flygoat.com> header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1586853318;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=84CrosZczlRKs4cv9GnHtu9KBHymfYmBVO3bAUZ/y6w=;
        b=dUMOEe2tgenEpWpWEB8vbLn1NBqOpK/XUtm1E6UFZohY9nHzmqlco79iN+9dw8wP
        uDCfdQXCwPSr58TCvYu0aVswfmnZIQS/I5rGh/+5iaXPEORCKYapvGzZ78pQpkAo2ol
        VuCI8ufTEp3yUUH1iG2It/baKThv55NNZ8rR2DJo=
Received: from localhost (122.235.212.87 [122.235.212.87]) by mx.zoho.com.cn
        with SMTPS id 15868533144941003.2196604203903; Tue, 14 Apr 2020 16:35:14 +0800 (CST)
Date:   Tue, 14 Apr 2020 16:35:14 +0800
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
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] arch_topology: Reset all cpus in
 reset_cpu_topology
Message-ID: <20200414163514.00000100@flygoat.com>
In-Reply-To: <20200414082734.GC6459@bogus>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
        <20200412032123.3896114-5-jiaxun.yang@flygoat.com>
        <20200414082734.GC6459@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Apr 2020 09:27:34 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> On Sun, Apr 12, 2020 at 11:20:34AM +0800, Jiaxun Yang wrote:
> > For MIPS platform, when topology isn't probed by DeviceTree,
> > possible_cpu might be empty when calling init_cpu_topology,
> > that may result cpu_topology not fully reseted for all CPUs.
> > So here we can reset all cpus instead of possible cpus.
> >  
> 
> As I have told before adjust and make it default before this function
> gets called.

Hi,

That's really impossible under current MIPS code structure.

Another option would be prefill possible_cpu with all_cpu_mask before
calling topology_init, but that would make the code unnecessarily
complex.

Here simply reset the whole array won't cause any regression.

Thanks.
> 
--
Jiaxun Yang

