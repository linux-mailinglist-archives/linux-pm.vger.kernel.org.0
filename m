Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1226C29365C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbgJTIFv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 04:05:51 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:39914 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbgJTIFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 04:05:34 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 04:05:33 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 10CCE3F683;
        Tue, 20 Oct 2020 09:59:02 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=Zb2hyLbn;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xiSkbJdUV73x; Tue, 20 Oct 2020 09:59:01 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 3CA853F583;
        Tue, 20 Oct 2020 09:58:59 +0200 (CEST)
Received: by flawful.org (Postfix, from userid 1001)
        id F3569D0F; Tue, 20 Oct 2020 09:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1603180745; bh=1Z/yOBJ1mwXulVdv8ofe3B4igKsGHtOc+5x58n5IEvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zb2hyLbn/gJvJFvkYr6UkWqQ9xK/ivXJw17cJS4jw6tdmFajLzLH1i3Ayo8jHXhXW
         oavZOJ/PGWs2py9Q8yJ7l1TN+3VxU5JlFVPwhwrZwvRKrve3LdKxN/vmh4PYL8/a9p
         2b1NbAquSoH7iwFMZDxfltVNnP4yXJ1Cby7AMPKA=
Date:   Tue, 20 Oct 2020 09:59:04 +0200
From:   Niklas Cassel <nks@flawful.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] power: avs: qcom-cpr: Move the driver to the qcom
 specific drivers
Message-ID: <20201020075904.GA2575@flawful.org>
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
 <20201006160516.319830-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006160516.319830-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 06, 2020 at 06:05:13PM +0200, Ulf Hansson wrote:
> The avs drivers are all SoC specific drivers that doesn't share any code.
> Instead they are located in a directory, mostly to keep similar
> functionality together. From a maintenance point of view, it makes better
> sense to collect SoC specific drivers like these, into the SoC specific
> directories.
> 
> Therefore, let's move the qcom-cpr driver to the qcom directory.
> 
> Cc: Niklas Cassel <nks@flawful.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Niklas Cassel <nks@flawful.org>
