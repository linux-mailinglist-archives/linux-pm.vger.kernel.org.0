Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35787BF356
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 08:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442330AbjJJGvv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 02:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442295AbjJJGvu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 02:51:50 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A6B59D;
        Mon,  9 Oct 2023 23:51:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0AB8980A9;
        Tue, 10 Oct 2023 06:51:47 +0000 (UTC)
Date:   Tue, 10 Oct 2023 09:51:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Kumar Udit <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: serial: 8250_omap: suspend issue with console_suspend disabled
Message-ID: <20231010065145.GD27774@atomide.com>
References: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
 <20230920053828.GD5282@atomide.com>
 <a5bee830-07af-426b-94ac-3574cba34bec@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5bee830-07af-426b-94ac-3574cba34bec@bootlin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

* Thomas Richard <thomas.richard@bootlin.com> [231009 15:13]:
> > The runtime PM usage count should keep the related power domain on though,
> > sounds like this issue somewhere else if the power domains get force
> > suspended with runtime PM usage count?
> 
> If I understand correctly, there are 2 solutions to keep the power
> domain on through.
> The first one is to set the flag GENPD_FLAG_ALWAYS_ON for the power domain.
> The second one is to set the wakup_path of the device (using
> device_set_wakeup_path) and set the flag GENPD_FLAG_ACTIVE_WAKEUP to the
> power domain.
> 
> I didn't found any flag or option to say that the device is not
> suspended, but it is not an error, so we don't want to poweroff the
> power domain.

If no_console_suspend is set then GENPD_FLAG_ALWAYS_ON makes sense to
me as we want to see the debug messages. This will also alter the SoCs
suspend state though, so no_console_suspend is of limited use. Can you
please send an updated patch against tty-next branch for this?

It would be good to understand why the related power domain gets suspended
with active runtime PM usage count though. To me it seems this might be
an issue somewhere in the SoC related power domain code that just tries
to force suspend everything.

Regards,

Tony
