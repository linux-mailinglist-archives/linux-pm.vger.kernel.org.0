Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3363641BD
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbhDSMdy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 08:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232633AbhDSMdy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Apr 2021 08:33:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAA8F61057;
        Mon, 19 Apr 2021 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618835604;
        bh=k5AqWiHiSGzVFF5ZCtgDF6Xn/MDDt8ogi+VTZfIZ7DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMzCWQbP3VDzGvOgeV5I1ZHvyt2XNYGYpF+kY+oJ+N2rYwNteXEKeSknFx2Ag6HLE
         rlWZZErNbH/h6WcxlyQmuk3Q523Vm2g63qY1p+uIFe27oyaXAjm+p41TwPtGs9/1SW
         XphOAzXX7+xXLnNeHEJNIwCk9agGGZklJufdvJEmpNFakIT5LOwt4S0P8H92WthKjC
         bK4/utFm9I4/KEH9sAAIZRomfg1N2zmECNxVrwIhQrgUZmfVYHH+AipKodwHh1Exbz
         Zf7uINlZ46mZM3iaZJrAg/ja4z/pqh5PW0YsK7c0wPrJX03xHpI0iH1srtLzDcK2ul
         jEVwKrjBPxDxg==
Date:   Mon, 19 Apr 2021 13:33:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 1/4] arch_topology: Rename freq_scale as
 arch_freq_scale
Message-ID: <20210419123318.GA30124@willie-the-truck>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
 <2dd2c60c0268550f566c3c83d06b651b4f0e9e4e.1615351622.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd2c60c0268550f566c3c83d06b651b4f0e9e4e.1615351622.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 10, 2021 at 10:53:23AM +0530, Viresh Kumar wrote:
> Rename freq_scale to a less generic name, as it will get exported soon
> for modules. Since x86 already names its own implementation of this as
> arch_freq_scale, lets stick to that.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/kernel/topology.c  | 6 +++---
>  drivers/base/arch_topology.c  | 4 ++--
>  include/linux/arch_topology.h | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
