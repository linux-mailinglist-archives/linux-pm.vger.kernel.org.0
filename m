Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07BC23C744
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHEH5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 03:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgHEH47 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 03:56:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA4321744;
        Wed,  5 Aug 2020 07:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596614219;
        bh=w7tzLksrCv4ALQStcKSfize2/X8xdy7tmJu6ujP5RS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQ3t3d/V6OFAF4jjvStcD4uckOm0QSQoQ0ILHB90Xk0i2BlpAETwThQixlfZIKjpG
         dPmkatHTgnaOnRkwxjpJjemVuyScuS5NKc4zmucMOXgjQPb3jOvZRO2rBLJWk+kGYR
         XH/OAyMyv883UUdN7M5GPzQ8WCaJHVjxVtOp38fM=
Date:   Wed, 5 Aug 2020 09:57:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        devel@driverdev.osuosl.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
Subject: Re: [PATCH v5] sched: Provide USF for the portable equipment.
Message-ID: <20200805075717.GB635696@kroah.com>
References: <cover.1596612536.git.yangdongdong@xiaomi.com>
 <3bbd9a487176a05588e33ff660d4e58efa1fdb10.1596612536.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbd9a487176a05588e33ff660d4e58efa1fdb10.1596612536.git.yangdongdong@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 05, 2020 at 03:36:21PM +0800, Dongdong Yang wrote:
> +#define usf_attr_rw(_name)						\
> +static struct device_attribute _name =					\
> +__ATTR_RW(_name)

I also asked you to use DEVICE_ATTR_RW() and not use "raw" kobjects.

Why you ignore code review is odd...

greg k-h
