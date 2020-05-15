Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079F01D4AC9
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgEOKXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 06:23:08 -0400
Received: from foss.arm.com ([217.140.110.172]:52894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgEOKXH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 May 2020 06:23:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1094C2F;
        Fri, 15 May 2020 03:23:07 -0700 (PDT)
Received: from bogus (unknown [10.37.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D6513F71E;
        Fri, 15 May 2020 03:23:03 -0700 (PDT)
Date:   Fri, 15 May 2020 11:22:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] cpuidle: psci: Fixup execution order when entering a
 domain idle state
Message-ID: <20200515102255.GA25927@bogus>
References: <20200511133346.21706-1-ulf.hansson@linaro.org>
 <20200514142015.GA23401@bogus>
 <CAPDyKFoVo8L7eiGdEVNYR2DY7cszDuLkmX8O_SfyUKh73pbpMQ@mail.gmail.com>
 <20200514172816.GA42669@bogus>
 <CAPDyKFrdrOnxFHaAR=cmMi2VfSudyHdjZ7vRZKhTQtepdkiXug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrdrOnxFHaAR=cmMi2VfSudyHdjZ7vRZKhTQtepdkiXug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 14, 2020 at 09:11:50PM +0200, Ulf Hansson wrote:
>
> No worries, thanks for reviewing.
>

You are welcome.

> That said, are you fine with Rafel queuing this then?
>

I am fine with that. However I told if you need fixes tags as there are
no users of the notification yet in the kernel. Though this is trivial,
but do we need this backported to stable kernel. I don't have strong
opinion and leave it to you and Rafael.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
