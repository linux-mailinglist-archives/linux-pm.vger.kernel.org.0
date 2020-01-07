Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8713286B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 15:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgAGOEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 09:04:53 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:2519 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGOEx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 09:04:53 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47sYzQ4YNdz81;
        Tue,  7 Jan 2020 15:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578405890; bh=XfoQMUnXZ3Glt0sRfyK+w1caLMhptVW6zmno8kSOLR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iiXv+F6/UQ1utYIz0/MoMQiF00RNjS+x1Y13YR+LMrW23hG+aZM+pDS14pDXDyUtN
         QXjGg6DdaJBUSKsVIG1/1k+KOE2bgrPre75Yfg4L2X7iOSmAtY4YXX+S+LYNXrTMHn
         kRlU3FVIisXO0hoc3nwgsF1eWQuTcrlelzf1E/gqsQQdKBH55ozSTZ9eHukMvxgpMs
         H6lKUnyEsMWDDMQOt9WWbFo0kd3wzO7CnAa2kjmT2eyV3t2OSnyq0aVq5ys0+is7V2
         IcgWiuhp64/gJ1x4YFZJ9Rw4riP6UC9KI3s4dZKMiU8M6n7TZTCplDML+0weDNIWyU
         cK+dk4iclft3Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 7 Jan 2020 15:04:49 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200107140449.GB20159@qmqm.qmqm.pl>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107063616.a3qpepc46viejxhw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107063616.a3qpepc46viejxhw@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 07, 2020 at 12:06:16PM +0530, Viresh Kumar wrote:
> Discard my earlier reply, it wasn't accurate/correct.
> 
> On 03-01-20, 20:36, Micha³ Miros³aw wrote:
> > When parsing OPP v2 table, unsupported entries return NULL from
> > _opp_add_static_v2().
> 
> Right, as we don't want parsing to fail here.
> 
> > In this case node reference is leaked.
> 
> Why do you think so ?

for_each_available_child_of_node() returns nodes with refcount
increased, and _opp_add_static_v2() returning NULL does not store the
pointer anywhere - the created (temporary) OPP structure is freed,
but _opp_free() does not release node at opp->np.

I guess maybe the _opp_free() should be fixed instead?

Best Regards,
Micha³ Miros³aw
