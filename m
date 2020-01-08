Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C75133F6B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 11:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgAHKix (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 05:38:53 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:46995 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbgAHKix (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jan 2020 05:38:53 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47t5MG57W2z5H;
        Wed,  8 Jan 2020 11:38:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578479931; bh=QoNiPdOMNz1NFnX43eMEW8/ONkyRF7mIHP81PHqLvTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzfJ5Rmgd93TMFgIBoqjEY6gvywxv8e8m5dww9YaNKtaE78t1Zee06ZQ2HU8Oa5jL
         vIXujjX83gOvliQ7IfmZasBaROrwBfoMysFkMOP72MMy3GF5qqSQSyC7y92HrUer1J
         7z3nVlJwIOvbKDme8uB5CkHDl/+M2LndrMZmUmj+msmZ57i7q0vWBmpJj9qJ6xqoua
         lZHXpn2jfewhwyNprETRAU9NH0RvgSwoyqGaGu1GuX3aQ/UoImL/YbaYNEbja4AUCv
         HKuyvt9SOS0cet72eqpWWNuLQ/eIsMNvS0sQ/4Qd2NGN5SqrtEkXLmg4bY4887/KpE
         WovR8TQjk3YBg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Wed, 8 Jan 2020 11:38:46 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200108103846.GA6894@qmqm.qmqm.pl>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107063616.a3qpepc46viejxhw@vireshk-i7>
 <20200107140449.GB20159@qmqm.qmqm.pl>
 <20200108073338.4z6gktglduigfo5p@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108073338.4z6gktglduigfo5p@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 08, 2020 at 01:03:38PM +0530, Viresh Kumar wrote:
> On 07-01-20, 15:04, Micha³ Miros³aw wrote:
> > On Tue, Jan 07, 2020 at 12:06:16PM +0530, Viresh Kumar wrote:
> > > Discard my earlier reply, it wasn't accurate/correct.
> > > 
> > > On 03-01-20, 20:36, Micha³ Miros³aw wrote:
> > > > When parsing OPP v2 table, unsupported entries return NULL from
> > > > _opp_add_static_v2().
> > > 
> > > Right, as we don't want parsing to fail here.
> > > 
> > > > In this case node reference is leaked.
> > > 
> > > Why do you think so ?
> > 
> > for_each_available_child_of_node() returns nodes with refcount
> > increased
> 
> I believe it also drops the refcount of the previous node everytime the loop
> goes to the next element. Else we would be required do that from within that
> loop itself, isn't it ?

Indeed it is! This means that _opp_add_static_v2() is storing a pointer
to a node without taking a reference to it. Is there something else that
guarantees the node won't disappear later?

Best Regards,
Micha³ Miros³aw
