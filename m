Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC38C100
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 20:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHMSrW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 14:47:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39188 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMSrW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 14:47:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C48C60A4E; Tue, 13 Aug 2019 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565722041;
        bh=4vlQBHXZefdhk1fMpS9K60hc0yLOya2J7kL8k05ISsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzKvf3Bdi4lF9Vx/WDwVpzChgPmmDmNM7n9XD4ndxMS3tZ059aEv6ySa4+kR+OrzE
         HNHphu71chDg5he16DcbDOtVAJK+L0j3dBYXgru4z3u6C8z2tEI+KOAU0cYKcFBXAH
         kL6gHFGYnvZ+YvCWfkbGRdWNl624vTAvguWhac+Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8773B605A2;
        Tue, 13 Aug 2019 18:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565722040;
        bh=4vlQBHXZefdhk1fMpS9K60hc0yLOya2J7kL8k05ISsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEw1XN3rhVtk1HvRWxOSp3f/VsT0koH4XYN1tvdk1wXd1LTOGh6wtXqQoohnlgqM2
         Z14vc2EYUHFduUw/JlE0KKNQK/QVsWiRyBpzrUzpAenAVE15VT6q77Zoqjzkx3id0M
         gPM9ohyoSWiM14roPi3Dx7z7EfQykuA02NczTqPw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8773B605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 13 Aug 2019 12:47:17 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-clk@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2] drivers: qcom: Add BCM vote macro to header
Message-ID: <20190813184717.GA28465@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Stephen Boyd <sboyd@kernel.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org>
 <20190807234232.27AA720880@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807234232.27AA720880@mail.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 07, 2019 at 04:42:31PM -0700, Stephen Boyd wrote:
> Quoting Jordan Crouse (2019-08-05 13:33:46)
> > The macro to generate a Bus Controller Manager (BCM) TCS command is used
> > by the interconnect driver but might also be interesting to other
> > drivers that need to construct TCS commands for sub processors so move
> > it out of the sdm845 specific file and into the header.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> Unless this is supposed to be applied by me?

I figured this landed in Bjorn's domain, but you guys can fight it out if you
want.

Jordan

> BTW, I wonder why we need an rpm clk driver much at all nowadays, except
> maybe for the XO clk state. The big user, from what I can tell, is the
> interconnect driver and we don't use any of the features of the clk
> framework besides the API to set a frequency. Maybe it would be better
> to just push push the bus frequency logic into interconnect code, then
> XO clk is the only thing we need to keep, and it can be a simple on/off
> thing.
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
