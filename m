Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A694924FDA7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHXMXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 08:23:53 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:11185 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHXMXn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 08:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598271819;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=v5kzANU3Oie0lUWo0lAXAmjYL+TjUFc4AxXMGhziSqs=;
        b=m/ViP6gviCKrj/w4I3lrko/7on3v+3yark59jZFio1o6fwnAr+jbltCXkJCSJp6Gu1
        pb31xR8aYPnnkzLzj26LIL5T5r1X3rRl856zRLm4rdiflGaUXB8iWtaE/mIRAanO/qAX
        HgDgtlcKKPOAnKc5nEshE94TIDIewE0yHaoxF43/O6O4aG4jVcbXzqlDXZsJ7fcvXMT1
        zi7HNRIgDFMfQHyRzKLuTi3HPjL28Cv2fMDzqa93lvGGw9c1jDnX1CMSLh3SVCo+xob2
        oGtPlpW1XePeXuMFF+qTwOFUlA9O1C1VDnN7nTblkCkg28uctrnGfKbzZVAaUwA0Bw9G
        Tznw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7OCNcX7V
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 24 Aug 2020 14:23:38 +0200 (CEST)
Date:   Mon, 24 Aug 2020 14:23:31 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/3] opp: Reduce code duplication in
 _set_required_opps()
Message-ID: <20200824122331.GA857@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-2-stephan@gerhold.net>
 <20200824111820.rcaingohxw3wozgd@vireshk-i7>
 <20200824113016.GA131681@gerhold.net>
 <20200824121004.mvssnqu4khg75cyb@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824121004.mvssnqu4khg75cyb@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 05:40:04PM +0530, Viresh Kumar wrote:
> On 24-08-20, 13:30, Stephan Gerhold wrote:
> > You're right. Not sure why I removed it.
> > 
> > I suspect I had it in _set_required_opp() at some point, but I moved
> > code around several times until I was happy with the result.
> > 
> > We should just add it back.
> > Should I send a v2 with it fixed or would you like to handle it?
> 
> I have applied the first two patches to linux-next branch in my tree,
> please have a look.
> 

Looks good to me. Thank you!

Stephan
