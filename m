Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF34B255A49
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgH1MfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 08:35:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:12447 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgH1Me6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 08:34:58 -0400
IronPort-SDR: Mo1GVfPQPC/Y5T5cP0aDd0GVUrA6cCz1H7zNtNYGABaJRQqr8GdjN6a8qEG4hUFOE3rmi9QBqy
 kStZ25+62pDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="154069923"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="154069923"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 05:34:57 -0700
IronPort-SDR: LsAdrySqa4ZJHrIuWvSuTOi9BQr1x7uyQGuh3GmkbXvlDM53I0PQZaHaeHOY/Fi6c2wRAg8XXv
 X5xoeVVrdmDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="337486445"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2020 05:34:57 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 045F9580628;
        Fri, 28 Aug 2020 05:34:55 -0700 (PDT)
Message-ID: <71c9048e530e1b67b6750b1a9eda175d98096ccc.camel@gmail.com>
Subject: Re: cpu-freq: running the perf increases the data rate?
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>,
        linux-pm@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Aug 2020 15:34:54 +0300
In-Reply-To: <CAPY=qRRekJonX_iX3s4bfietm9D_GM+S4cDGXbj9nMOefJBdTw@mail.gmail.com>
References: <CAPY=qRRekJonX_iX3s4bfietm9D_GM+S4cDGXbj9nMOefJBdTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-08-27 at 22:25 +0530, Subhashini Rao Beerisetty wrote:
> I have an application which finds the data rate over the PCIe
> interface. I’m getting the lesser data rate in one of my Linux X86
> systems.

Some more description, may be? Do you have a PCIe device reading one
RAM buffer and then writing to another RAM buffer? Or does it generate
dome data and writes them to a RAM buffer? Presumably it uses DMA? How
much is the CPU involved into the process? Are we talking about
transferring few kilobytes or gigabytes?

> When I change the scaling_governor from "powersave" to "performance"
> mode for each CPU, then there is slight improvement in the PCIe data
> rate.

Definitely this makes your CPU(s) run at max speed, but depending on
platform and settings, this may also affect C-states. Are the CPU(s)
generally idle while you measure, or busy (involved into the test)? You
could run 'turbostat' while measuring the bandwidth, to get some CPU
statistics (e.g., do C-states happen during the PCI test, how busy are
the CPUs).

> Parallely I started profiling the workload with perf. Whenever I start
> running the profile command “perf stat -a -d -p <PID>” surprisingly
> the application resulted in excellent data rate over PCIe, but when I
> kill the perf command again PCIe data rate drops. I am really confused
> about this behavior.Any clues from this behaviour?

Well, one possible reason that comes to mind - you get rid of C-states
when you rung perf, and this increases the PCI bandwidth. You can just
try disabling C-states (there are sysfs knobs) and check it out.
Turbostat could be useful to check for this (with and without perf, run
'turbostat sleep 10' or something like this (measure for 10 seconds in
this example), do this while running your PCI test.

But I am really just guessing here, I do not know enough about your
test and the system (e.g., "a Linux x86" system can be so many things,
like Intel or AMD server or a mobile device)...


