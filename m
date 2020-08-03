Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34723A923
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgHCPIQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 11:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgHCPIP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 11:08:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71A12076E;
        Mon,  3 Aug 2020 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596467294;
        bh=Lrbi2rsIAExF59EuLBc7ucnI9amz38W6mCJdKugNiSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICoWVarNkJzobZx++tnhhJngFcae6r4xhlEqj89aatZag49QjN5O7mXay7bxj7NCH
         JQE6yTT6PfFgtOkugp3ORwOlnC4/BgyQYnlSHTNw08W/1cT7W8D1WHH92PsbDVprvw
         hGrE+qO9QSqdzq+k0XSsdZeJMweV3FqiiRp79DUg=
Date:   Mon, 3 Aug 2020 17:07:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        devel@driverdev.osuosl.org, gulinghua@xiaomi.com,
        tanggeliang@xiaomi.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangdongdong@xiaomi.com,
        duhui@xiaomi.com, zhangguoquan@xiaomi.com, fengwei@xiaomi.com,
        taojun@xiaomi.com, rocking@linux.alibaba.com, huangqiwu@xiaomi.com
Subject: Re: [PATCH v3] sched: Provide USF for the portable equipment.
Message-ID: <20200803150756.GA1098726@kroah.com>
References: <cover.1596464894.git.yangdongdong@xiaomi.com>
 <23719695ee476715ec54d3310c95d535f8e1391a.1596464896.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23719695ee476715ec54d3310c95d535f8e1391a.1596464896.git.yangdongdong@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 03, 2020 at 10:31:15PM +0800, Dongdong Yang wrote:
> +	/*
> +	 * create a sched_usf in cpu_subsys:
> +	 * /sys/devices/system/cpu/sched_usf/...

I thought I asked you not to use a "raw" kobject, you are making this
much harder than it has to be.

Just use a normal struct device.

Also you failed to document your new sysfs files in Documentation/ABI/
like is required :(

Because of both of those things, this isn't ok as-is, sorry.

greg k-h
