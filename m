Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595CB19835
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfEJGCB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 02:02:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42098 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfEJGCB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 02:02:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so6137841wrb.9;
        Thu, 09 May 2019 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=24UQ3aORX5j8aOR7V6rEj+tz4OGv+eSvU3XitaWoirw=;
        b=PLkQDk49UcG6Hfu4ZW6ZXp7fs0J10AdhGAzgTSl7YVYRolrttSkj27qYa8S8D9Ic93
         MAbA3EYcExvDlaDfD+yAkhCj2vwzfa+1BJ13aG7tgI2dhaAugNcu6OJe5A7NUOODCX6M
         8BD0VKDcHfYiyT9aDXCP7wUgAEOLvJdN9ZgRMlHacf2n4kYDdtwcWCwBdLOkg0YzvuxQ
         GAmMhB4VTzzc0zmmDt/sbsJRDGvv0GLN3gs0nC2kvhzKNMRDM1/RtGscG38FkhLqb6yO
         IV4zRbtFrou/KZdRzYYs2EjPUHzE2yGokDVWCZ8FNoF78zNZFSEFBHik7V6O4npSR8pq
         2VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=24UQ3aORX5j8aOR7V6rEj+tz4OGv+eSvU3XitaWoirw=;
        b=DxqLfkKnNtSMuPcgW/bYyumZDyZcYoMrctRHipEybVyWGKuuPl6+JURFmFYKCD8DfH
         6/ja2UeqZlaV8vHGQwbsZ2UmuvT7lYaQTAj3tYDhj9gTH+I6yMk8H1bNLP8AlHPODgU6
         gkuU78WY+femtMz2BsOIigHuZPjP+BXYWtoHzeYGHAhxGtqUCyoSMm64Pa3Bgxe39i0E
         ILPEV/2A41INDGv7AsrNRYQf8KYX0jcyuPxsaufZAAwpz/IY3Kag97oVmrqjgPUQl+EA
         JwoFBZ1gHGl9svt5XdW0lrX/QkrQGlqq7JQAxzrlUIosyJiDmGT69nvQllZePzc/ntMQ
         /YMQ==
X-Gm-Message-State: APjAAAUqSy4O9YMndQs7oFnBDqmzpTUpNGcc9x9fwK8xtYs9SvLLuC55
        q/sep9I03gqcFQe/MyojCZE=
X-Google-Smtp-Source: APXvYqyMnSY+V30lmYHX4wTYGYv9h4QRyBfTtk+ogMWzG0/uPI6og3fL3uuUETYc407dM2ucvFRQ0A==
X-Received: by 2002:adf:dd09:: with SMTP id a9mr5853514wrm.228.1557468119225;
        Thu, 09 May 2019 23:01:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c10sm10232527wrd.69.2019.05.09.23.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 23:01:58 -0700 (PDT)
Date:   Fri, 10 May 2019 08:01:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Ido Schimmel <idosch@idosch.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] x86: intel_epb: Take CONFIG_PM into account
Message-ID: <20190510060156.GA20852@gmail.com>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1627338.1fd8ofggM8@kreacher>
 <20190509174338.GA24432@splinter>
 <3431308.1mSSVdqTRr@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3431308.1mSSVdqTRr@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit b9c273babce7 (PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
> interface) caused kernels built with CONFIG_PM unset to crash on
> systems supporting the Performance and Energy Bias Hint (EPB),
> because it attempts to add files to sysfs directories that don't
> exist on those systems.
> 
> Prevent that from happening by taking CONFIG_PM into account so
> that the code depending on it is not compiled at all when it is
> not set.
> 
> Fixes: b9c273babce7 (PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface)
> Reported-by: Ido Schimmel <idosch@mellanox.com>
> Tested-by: Ido Schimmel <idosch@mellanox.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/kernel/cpu/intel_epb.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
