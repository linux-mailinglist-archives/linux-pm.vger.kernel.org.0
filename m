Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD3FBDFA
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 03:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKNClk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 21:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfKNClk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 21:41:40 -0500
Received: from localhost (unknown [124.219.31.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 666F5206D5;
        Thu, 14 Nov 2019 02:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573699298;
        bh=Yt6Nkqaq95j3Arfhg2uiVLVTDYSRiDP4ZIp3z3GdCnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PffdIoRMPoHSk13UdKL7NxTPK1EHnLXIsPzh/aupmfSeuJ/GvDzNw5ZB2ix6wa0Gk
         8QfTqzVj2Vllar6lXZYMRjyUHWbiSsazZkUzcrNTinFRthXwx1o1k84mHF8BDh4CTD
         6lwXifZ/mVAl6SzEftkTnkOf60jQ+b87gKXL7xGU=
Date:   Thu, 14 Nov 2019 10:41:34 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] interconnect: Add interconnect_graph file to debugfs
Message-ID: <20191114024134.GA47006@kroah.com>
References: <70f672b39780ba7387d15fd6485f94b75d47b1ec.1573692109.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f672b39780ba7387d15fd6485f94b75d47b1ec.1573692109.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 14, 2019 at 02:50:49AM +0200, Leonard Crestez wrote:
> The interconnect graphs can be difficult to understand and the current
> "interconnect_summary" file doesn't even display links in any way.
> 
> Add a new "interconnect_graph" file to debugfs in the graphviz "dot"
> format which describes interconnect providers, nodes and links.
> 
> The file is human-readable and can be visualized by piping through
> graphviz. Example:
> 
> ssh $TARGET cat /sys/kernel/debug/interconnect/interconnect_graph \
> 	| dot -Tsvg > interconnect_graph.svg

You might want to document this somewhere so we don't all have to go dig
it out of the changelog every time we want to look at this file.


> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/interconnect/core.c | 66 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> Example output as a github gist:
> https://gist.github.com/cdleonard/2f74a7efe74587e3d4b57cf7983b46a8
> 
> The qcs404 driver was hacked to probe on imx, the links to "0" seem to
> from incorrect trailing 0s on DEFINE_QNODE. Possibly fallout from
> switching to ARRAY_SIZE(__VA_ARGS__)?
> 
> I'm not sure that "graphviz" is allowed as an output format even in
> debugfs.

Why not!  :)

This is great, I love it, nice job, no objection from me.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
