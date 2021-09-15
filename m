Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B140C2DD
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhIOJjg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 05:39:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:58453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhIOJjg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Sep 2021 05:39:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="222310760"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="222310760"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 02:38:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="544766083"
Received: from singanam-mobl1.gar.corp.intel.com ([10.213.67.66])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 02:38:13 -0700
Message-ID: <48eef209ab34b7885790bf25fd93163f3eea4795.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support
 in no-HWP mode
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Sep 2021 02:38:10 -0700
In-Reply-To: <CAAYoRsUnuNL+orjeXpxEE4fyknGGk3Kngk6Gt+hoCHxLYg9D6A@mail.gmail.com>
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
         <20210513132051.31465-1-ggherdovich@suse.cz>
         <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
         <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz>
         <CAAYoRsX0xJf1mm1a_YUCzDy86r8q4QE98iVtS1AMLaUx+KTgQQ@mail.gmail.com>
         <CAAYoRsXK79PspEUh9pqgj2OGQnxQONkEeK-7af3=5frBzAqULQ@mail.gmail.com>
         <2a1b000cd101737400f6320ef18c0143d3a5145b.camel@linux.intel.com>
         <CAAYoRsVeMCivVBp-q_9N23BDOVvkc8ZLS3mubnz+4TREZ9Cz_A@mail.gmail.com>
         <7abae13c235d74f4789cd93c6c6b0cbf69df243d.camel@linux.intel.com>
         <CAAYoRsVd4uU7sofcvYWd__evKJTf7HE5mi2ZVDjAYNYWXS3mzQ@mail.gmail.com>
         <CAAYoRsUnuNL+orjeXpxEE4fyknGGk3Kngk6Gt+hoCHxLYg9D6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-09-14 at 11:41 -0700, Doug Smythies wrote:
> On Tue, Sep 7, 2021 at 8:43 PM Doug Smythies <dsmythies@telus.net>
> wrote:
> > 

[...]

> > The intel_pstate driver works fine.
> 
> Hi Srinivas,
Hi Doug,

> 
> I heard back from ASUS, and they now confirm that they
> did change the behaviour of the "Auto" setting in BIOS
> version 2103. They say they did it to fix an issue with
> ITB3.0, which I assume means Intel Turbo Boost 3.0.
> I'll copy and paste the relevant portion of the email
> below:
> 
> " I am in direct contact with the engineers.
> Here is the result from their test:
> 
> In BIOS 2103,the “Auto” setting transfers control to
> the OS with HWP available and enabled.
> 
> This is side effect to fix ITBM3.0 not work after HWP enabled.
> We can remove this patch, but ITBM3.0 will not work when HWP enabled"
> 
> Are you familiar with this issue?
No. I think they mean that they need to expose ACPI CPPC information.
It is possible they only expose ACPI CPPC information when HWP feature
is available. But not sure why it requires HWP enable also. We (on
Linux) depend on ACPI CPPC for turbo 3.0, but don't require HWP to be
enabled by default.


Thanks,
Srinivas



> 
> I want the original behaviour of the "Auto" setting, as it is
> the only way for control to go to the OS with HWP
> available but disabled.
> 
> ... Doug


