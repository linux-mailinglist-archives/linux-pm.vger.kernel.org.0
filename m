Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23AE24FCDC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHXLnJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:43:09 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:9933 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHXLnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 07:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598269386;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=L8FpAL/QNc5PlqFAg2tSEIydb3LWy4d4tNr31Xlb1hQ=;
        b=tv1pHU3MHv1Mrz4JHi/uE2Uv2FBEHTAoFa5fgL9RD9aoZb0srjDvyE4mGws8oI5z97
        Uy6sGLFNjNgAseyLCKQ0TIjYDfvv9qSPY631y0J1WKwetGFjqtgVc6hh/F+CmAA9wSv3
        DLYIgvd4FjvxLOJsm228zPBMp0/7Imop2muOxVYZurbmeDprMsaqYsaGYbUCYfR+7eOj
        rGc/TgyyuXWybVITNWrk+HUI4S5JBoBUY+hW1XGd75Ac6r2lQ16P6EQpITtO0nstIeEQ
        6+USbti05nUucoxo4xqoZMSigOf5CWMVcY6X2LvWcoROpABTHi9B0QXQBePStKJvwZwI
        mkUw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7OBh4WqW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 24 Aug 2020 13:43:04 +0200 (CEST)
Date:   Mon, 24 Aug 2020 13:42:54 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 2/3] opp: Set required OPPs in reverse order when
 scaling down
Message-ID: <20200824114254.GA208090@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-3-stephan@gerhold.net>
 <20200821163152.GA3422@gerhold.net>
 <20200824113027.lzh6fp4bottjl6cc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824113027.lzh6fp4bottjl6cc@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 05:00:27PM +0530, Viresh Kumar wrote:
> On 21-08-20, 18:31, Stephan Gerhold wrote:
> > This patch does not apply anymore after the cleanup you pushed to
> > opp/linux-next. I would be happy to send a v2 with that fixed.
> > 
> > On my other OPP patch set you mentioned that you might apply these
> > directly with some of your own changes - would you also prefer to do it
> > yourself in this case or should I send a v2?
> 
> I will pick the first 2 myself, that's fine. Lets see where we go with
> the third one :)
> 

OK, please ignore my question in my reply to PATCH 1/3 then. I replied
before I read this one. Just add back the NULL checks and it should be
fine :)

> > Still looking for your feedback on both patch sets by the way! :)
> 
> Sorry about the delay, I was on vacation for over a week in between and
> this and the other patchset was a bit tricky (which you may have not
> realized, not sure, as I wondered if something will not work within
> the OPP core for v1 binding, but it did finally I believe) :)
> 

No problem! I guess I did indeed not realize potential problems for the
v1 bindings, all this compatibility code is quite confusing. :)

Thanks!
Stephan
