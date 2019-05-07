Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4816D15CCC
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 08:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfEGGHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 02:07:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38573 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfEGGHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 02:07:05 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hNtFo-0005Pa-02; Tue, 07 May 2019 08:07:04 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hNtFm-0001Aa-Re; Tue, 07 May 2019 08:07:02 +0200
Date:   Tue, 7 May 2019 08:07:02 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] cpufreq: imx6q: Fix the resource leak caused by
 incorrect error return
Message-ID: <20190507060702.ub4zjsurylldj2mm@pengutronix.de>
References: <20190505080736.27970-1-ping.bai@nxp.com>
 <20190507055327.sakuoy2j3g7dwv3f@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507055327.sakuoy2j3g7dwv3f@vireshk-i7>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 07, 2019 at 11:23:27AM +0530, Viresh Kumar wrote:
> On 05-05-19, 08:02, Jacky Bai wrote:
> > Previous goto only handled the node reference, the opp table,
> > regulator & clk resource also need to be free before error return.
> > 
> > Fixes: ddb64c5db3c (cpufreq: imx6q: fix possible object reference leak).
> 
> This should have been.
> 
> Fixes: ddb64c5db3cc ("cpufreq: imx6q: fix possible object reference leak")
> 
> Auto configure it with following in .gitconfig
> 
> [pretty]
> 	fixes = Fixes: %h (\"%s\")
> 	onelin = commit %h (\"%s\")
> 
> and then:
> 
> git log --pretty=fixes ddb64c5db3c
> 
> will generate it by itself.

Just to add my color of the bikeshed, I have (among others):

[alias]
	oneq = show -s --pretty='format:%h (\"%s\")'

in my ~/.gitconfig and can do:

$ git oneq ddb64c5db3c
ddb64c5db3cc ("cpufreq: imx6q: fix possible object reference leak")

which is a bit shorter than Viresh's suggestion.

(Originally I had "one" without the quotes which I learned (IIRC) from
the git mailing list. Instead of deviating from this I added 'q' for
"quotes" to match the usual convention in kernel land.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
