Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBFE5032
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395431AbfJYPdl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 11:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395430AbfJYPdl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Oct 2019 11:33:41 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3805021929;
        Fri, 25 Oct 2019 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572017620;
        bh=H7fURjLkyZ1XV2iHKmY6CUs6YlFPI+akWYnt8ibppik=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WVxU7e9XByy6NZTJWF5jfJgaNH9FoceabuNtEJyuSCiXjzbzuKkg2Ytii1fLoU+gx
         xl7B5XtgkhBk1d2JtOTgucvx2vW6Pp3Ngs2UuGZFPSpz4JA/erwgPKkxroaa3dUvsq
         ce92QC4I3jypxCLySUq8RVX784/cGMNibrYvI8UY=
Subject: Re: [PATCHv2 2/3] cpupower: mperf_monitor: Introduce per_cpu_schedule
 flag
To:     Thomas Renninger <trenn@suse.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Pu Wen <puwen@hygon.com>, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Borislav Petkov <bp@suse.de>, shuah <shuah@kernel.org>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
 <bb4b0e4137b62651b9d028925fa8f09ca5fbd989.1570819652.git.Janakarajan.Natarajan@amd.com>
 <24194241.SRZ5kbjNg7@skinner.arch.suse.de>
From:   shuah <shuah@kernel.org>
Message-ID: <e5c0ed24-6b2f-ea2f-6ce1-533f3727cb17@kernel.org>
Date:   Fri, 25 Oct 2019 09:33:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <24194241.SRZ5kbjNg7@skinner.arch.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/25/19 4:39 AM, Thomas Renninger wrote:
> Hi Natarajan,
> 
> sorry for answering that late.
> I post on top as it doesn't fit to the patch context:
> 
> While I like the 2 other patches, especially the first preparing for
> a generic "ensure to always run on the measured CPU at measure time"
> interface..., this patch does make use of it in a very static manner.
> 
> I then tried to get this more generic..., without any outcome for now.
> 
> If someone likes to play with this, my idea would be:
> 
> - the monitors need cpu_start() and cpu_stop() callbacks to register
> - either start(), stop() and/or cpu_start(), cpu_stop() callbacks have to
>    be provided by a monitor.
> - current behavior is only start/stop which means the whole per_cpu logic
>    resides inside the monitor
> - if cpu_start/cpu_stop is provided, iterating over all cpus is done in
>    fork_it and general start/stop functions are an optionally entry point
>    before and after the per_cpu calls.
> 
> Then the cpu binding can be done from outside.
> Another enhancement could be then to fork as many processes as there are CPUs
> in case of per_cpu_schedule (or an extra param/flag) and then:
> 
> - Bind these forked processes to each cpu.
> - Execute start measures via the forked processes on each cpu
> - Execute test executable (which runs in yet another fork as done already)
> - Execute stop measures via the forked processes on each cpu
> 
> This should be ideal environment to not interfere with the tested executable.
> It would also allow a nicer program structure.
> 

It will be good to capture these ideas in the ToDo file.

Natarajan! WOuld you like to send a patch updating the ToDo file with
these ideas?

thanks,
-- Shuah

