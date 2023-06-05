Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF37233AF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jun 2023 01:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjFEXcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 19:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFEXcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 19:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B67BA7
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 16:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A3562AE6
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 23:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E696AC433D2;
        Mon,  5 Jun 2023 23:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686007943;
        bh=HU9rRaCdM7V7GOnw7KJT5Xvf4bbmMOre0fWe6Kb8RG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNXGddwQhtXq1qsDfz0j1bhxx0owaq6f9haVwOr6ZGjL1s6Bh7aAU2uoEfCx9uJrL
         I9I0/49n0r6ay5w0QlnVS5muTSDrA6YCEepjLgnSxEiGYvU+jQshvrYu0cr3lEWNCl
         hlZICk+/jBLyOC7bzkl0wfN9S2xBQQnHhYF1LhHH6RzcnLxivDTozOxBpvq88XvwtB
         j9sgtw+HDSB/15KouGrj6jXTNMiyvC3R9qbz5QQ85aXpZVTh6gE9WcgAYQWWa3x7jP
         OaW2az4+JvlMziHCidbdwj8lwx0rM3e906q8+rBUjSnvtT7OJ9qArroTVZ5yElSxuW
         k3LIFN4y9gfyQ==
Date:   Mon, 5 Jun 2023 16:32:21 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org, Eduardo Valentin <eduval@amazon.com>
Subject: Re: [PATCH 0/3] thermal: hook in with reboot and crash
Message-ID: <ZH5whRBkGCun3Gq+@uf8f119305bce5e.ant.amazon.com>
References: <20230525211655.627415-1-evalenti@kernel.org>
 <fb558491-9906-fb3a-60c5-349cb4210695@linaro.org>
 <ZH5ve2KX/Y0DXQnE@uf8f119305bce5e.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH5ve2KX/Y0DXQnE@uf8f119305bce5e.ant.amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 05, 2023 at 04:27:55PM -0700, Eduardo Valentin wrote:
> 
> 
> 
> On Fri, May 26, 2023 at 10:27:39AM +0200, Daniel Lezcano wrote:
> >
> >
> >
> > Hi,
> >
> > On 25/05/2023 23:16, Eduardo Valentin wrote:
> > > From: Eduardo Valentin <eduval@amazon.com>
> > >
> > > Hello,
> > >
> > > This small series of changes teaches thermal core about
> > > reboot and crash callbacks. The intention is to have the core
> > > to get notified and the pass in the event to thermal governors
> > > that are willing to perform actions during reboot or crash events.
> > > The thermal workers will be teared down in the process too.
> >
> > What problem does it solve?
> 
> This cover letter was not clear enough. In fact, the context for
> all patches I am sending now and will be sending in near future
> is when the thermal subsystem is configured to control temperature
> of a target device. The thermal subsystem is configured to have
> cooling devices that will act on the target system, and has
> input, temperature sensors, to have visibility to the target system
> temperature.  In this case, the problem is when the controlling system
> becomes unresponsive upon reboot or crash, therefore losing
> control of temperature of the target system. This series solves the
> problem by giving knowledge to the governors of such events, allowing
> the governors to have opportunity to act before the actual event happens.


Again, this is a different situation than a emergence shutdown due to 
temperature/overheat on the typical application of the thermal subsystem.
Where it runs in the same system it controls the temperature of.

Here we want to reduce the likelihood of loosing control of temperature of a target systems
upon events where the controlling system is unavailable.



-- 
All the best,
Eduardo Valentin
