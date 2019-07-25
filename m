Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4767A74FA9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbfGYNgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 09:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388905AbfGYNgh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jul 2019 09:36:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F7B21901;
        Thu, 25 Jul 2019 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564061796;
        bh=P14qZ4ZPdWg+EwZRpeIuk270A0Co0pdknb9KeS6lC4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6bpJHz6DFdt5uEwrs27i+gAFHPJru5oJr7PTkquA28Ocz9PtQRkwMqgvyNuukZ4W
         6TApLTf63pgqo2x9w5WCxfFbspZYQYIubWztcYb9W1LVXizSRGqDPLpb1jW4bTNi3A
         hEEYUOBoJZz5sCm1jyF0sjT7QnRMU5Alu+8X0FvI=
Date:   Thu, 25 Jul 2019 15:36:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 06/10] arch_topology: Use CPUFREQ_CREATE_POLICY
 instead of CPUFREQ_NOTIFY
Message-ID: <20190725133634.GA11115@kroah.com>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
 <3afc5046ba9435d229a004c17b005197488006d4.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3afc5046ba9435d229a004c17b005197488006d4.1563862014.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 11:44:06AM +0530, Viresh Kumar wrote:
> CPUFREQ_NOTIFY is going to get removed soon, lets use
> CPUFREQ_CREATE_POLICY instead of that here. CPUFREQ_CREATE_POLICY is
> called only once (which is exactly what we want here) for each cpufreq
> policy when it is first created.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/arch_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
