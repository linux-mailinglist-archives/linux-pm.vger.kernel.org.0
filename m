Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9A242D58A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhJNJAv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 05:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhJNJAo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 05:00:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1124C61156;
        Thu, 14 Oct 2021 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634201919;
        bh=Qw3l7IJcHXKWWmKpZXk9UOXRMne+5JKQaHSvk44+PwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONkvYbps+yGS+Z5Jp/LImbMWWVia76/Y27u6YR+8SPq9ibTWHHD2Alb9j9wQnFEXn
         R23DoFXkyhP6hy/8H8xx9kdT1Px0UyUJA3kTHY71tVQHhoFpg9Fr9kkstm+Dna/aG+
         5dUbELmbNydC0HW+4/P9rX3E92f3GWIdkIlG62rOLx7KZZObsUC5pDG2PuFXDheSGV
         ju1Ieh5GRu6uCBXtBXUNkQ4UnlU0yS9HqyJuUfncR5Yhq00oyj/5jv7hAcBEOQcHd6
         moypIuJn67N5mUplXlAxIu1Y5jMKOHWloT4NnZyCgoYOotQTnUYkuaPeFreWXdf8D/
         EcsyzitLe/5sA==
Date:   Thu, 14 Oct 2021 09:58:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/6] freezer: Have {,un}lock_system_sleep()
 save/restore flags
Message-ID: <20211014085834.GA8135@willie-the-truck>
References: <20211009100754.690769957@infradead.org>
 <20211009101444.853151071@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009101444.853151071@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 09, 2021 at 12:07:55PM +0200, Peter Zijlstra wrote:
> Rafael explained that the reason for having both PF_NOFREEZE and
> PF_FREEZER_SKIP is that {,un}lock_system_sleep() is callable from
> kthread context that has previously called set_freezable().
> 
> In preparation of merging the flags, have {,un}lock_system_slee() save
> and restore current->flags.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/scsi/scsi_transport_spi.c |    7 ++++---
>  include/linux/suspend.h           |    8 ++++----
>  kernel/power/hibernate.c          |   35 ++++++++++++++++++++++-------------
>  kernel/power/main.c               |   16 ++++++++++------
>  kernel/power/suspend.c            |   12 ++++++++----
>  kernel/power/user.c               |   24 ++++++++++++++----------
>  6 files changed, 62 insertions(+), 40 deletions(-)

There's lots of Christmas tree inversion sprinkled in here, but the change
looks good so:

Acked-by: Will Deacon <will@kernel.org>

Will
