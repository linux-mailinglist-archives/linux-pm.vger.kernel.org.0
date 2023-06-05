Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0497233A6
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jun 2023 01:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjFEX2A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 19:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFEX17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 19:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA1BE
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 16:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12B4C6265E
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 23:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1645CC433D2;
        Mon,  5 Jun 2023 23:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686007677;
        bh=BYCVSsEyelOAWWE1sQOSsLc2DeQ21yDPoWsKgjx1vs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGBaLYg8L9dr9z5J9wXHH2NrEt1llJ/6LryphQAfTrMjaYq54OrqAdKX3iHWV8P3g
         C75mP0SPTcHO0A4gtqAz2FjxvGr9gvLgFxuhFI3iQx9MYBEQiFPUKeujSqgd4ssvDB
         pSLcFQyoDWtCU7Bo/8Vew8S+Qf/cvLtO4iwqj9jyUS7wtcjgWHH7RtqnIxLG5re/93
         h6MM6pYawdoXmwOJCQHnlRoV/RTSJE00fpQkDUIm9sPcSXGkrG1a3aMgbjhZRbbnxt
         YBE5uI5Kx7PV2erI3uQGT+nMVAnF70AKJOdbOMhzg2MF+ohgzc4gBeZ5mROR7Xs1t/
         t+dVdcAxnV8yg==
Date:   Mon, 5 Jun 2023 16:27:55 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org, Eduardo Valentin <eduval@amazon.com>
Subject: Re: [EXTERNAL][PATCH 0/3] thermal: hook in with reboot and crash
Message-ID: <ZH5ve2KX/Y0DXQnE@uf8f119305bce5e.ant.amazon.com>
References: <20230525211655.627415-1-evalenti@kernel.org>
 <fb558491-9906-fb3a-60c5-349cb4210695@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb558491-9906-fb3a-60c5-349cb4210695@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 26, 2023 at 10:27:39AM +0200, Daniel Lezcano wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> Hi,
> 
> On 25/05/2023 23:16, Eduardo Valentin wrote:
> > From: Eduardo Valentin <eduval@amazon.com>
> > 
> > Hello,
> > 
> > This small series of changes teaches thermal core about
> > reboot and crash callbacks. The intention is to have the core
> > to get notified and the pass in the event to thermal governors
> > that are willing to perform actions during reboot or crash events.
> > The thermal workers will be teared down in the process too.
> 
> What problem does it solve?

This cover letter was not clear enough. In fact, the context for
all patches I am sending now and will be sending in near future
is when the thermal subsystem is configured to control temperature
of a target device. The thermal subsystem is configured to have
cooling devices that will act on the target system, and has
input, temperature sensors, to have visibility to the target system
temperature.  In this case, the problem is when the controlling system
becomes unresponsive upon reboot or crash, therefore losing
control of temperature of the target system. This series solves the
problem by giving knowledge to the governors of such events, allowing
the governors to have opportunity to act before the actual event happens. 

> 
> 
> > There is no code dependency this series was built on top of:
> > https://lkml.org/lkml/2023/5/18/1207
> > 
> > Separate governor changes will be sent in another series.
> > 
> > BR,
> > 
> > Eduardo Valentin (3):
> >    thermal: core: introduce governor .reboot_prepare()
> >    thermal: core: register reboot nb
> >    thermal: core: register a crash callback
> > 
> >   drivers/thermal/thermal_core.c | 54 ++++++++++++++++++++++++++++++++++
> >   include/linux/thermal.h        |  4 +++
> >   2 files changed, 58 insertions(+)
> > 
> 
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
All the best,
Eduardo Valentin
