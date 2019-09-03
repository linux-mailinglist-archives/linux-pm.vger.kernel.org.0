Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F68A6C0B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfICO75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 10:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICO75 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Sep 2019 10:59:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE7CC22D6D;
        Tue,  3 Sep 2019 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567522796;
        bh=r1dGTU09uOiL3xCXgprleyqpzShijOgQ2UNAYYJDUpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtgSNN539VQj9J36MgDl+JFmjW8DX+T2BDAngoMe1t0XeSDAd31597Iu6zA1mFUT3
         OmfV6n0WeuyjDjZ1+FnBYw/h2nY8S4K0zadTI+Kc0r9zofd//pIoCvl6yATzXPmp/+
         Hb1DMAj016A8z07m37goOjsH4hmd3twuzbegMObY=
Date:   Tue, 3 Sep 2019 15:59:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, qperret@qperret.net, corbet@lwn.net
Subject: Re: [PATCH] mailmap: Update email address for Quentin Perret
Message-ID: <20190903145950.xko5fejupxj3f5nx@willie-the-truck>
References: <20190902105036.32419-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902105036.32419-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Quentin,

[+Jon]

On Mon, Sep 02, 2019 at 11:50:36AM +0100, Quentin Perret wrote:
> My @arm.com email address will stop working in a few weeks, so add an
> entry to .mailmap so others have a way to reach me if they want to.
> 
> While at it, move some entries around to keep the file in alphabetical
> order.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
> Hi guys,
> 
> Will/Catalin: any chance this could be merged via the arm64 tree ?

Since this isn't really an arm64 change (there's no change to MAINTAINERS),
I'd rather it went via Andrew or Jon. However, there was some resistance
last time this sort of email change happened:

  http://lkml.kernel.org/r/20190806112959.14845da4@lwn.net

so I'm not sure what the current preference is. Jon? What's the best way
for get_maintainer.pl to retrieve up-to-date contact details for developers
who aren't in MAINTAINERS?

Will

> diff --git a/.mailmap b/.mailmap
> index afaad605284a..934d848f0b2f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -180,6 +180,11 @@ Mythri P K <mythripk@ti.com>
>  Nguyen Anh Quynh <aquynh@gmail.com>
>  Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
>  Nicolas Pitre <nico@fluxnic.net> <nico@linaro.org>
> +Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
> +Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
> +Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
> +Oleksij Rempel <linux@rempel-privat.de> <o.rempel@pengutronix.de>
> +Oleksij Rempel <linux@rempel-privat.de> <ore@pengutronix.de>
>  Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>  Patrick Mochel <mochel@digitalimplant.org>
>  Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
> @@ -190,11 +195,7 @@ Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
>  Praveen BP <praveenbp@ti.com>
>  Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
>  Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
> -Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
> -Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
> -Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
> -Oleksij Rempel <linux@rempel-privat.de> <o.rempel@pengutronix.de>
> -Oleksij Rempel <linux@rempel-privat.de> <ore@pengutronix.de>
> +Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
>  Rajesh Shah <rajesh.shah@intel.com>
>  Ralf Baechle <ralf@linux-mips.org>
>  Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
