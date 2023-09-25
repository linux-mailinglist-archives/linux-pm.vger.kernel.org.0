Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6FC7ADB64
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjIYP06 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 11:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjIYP0o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 11:26:44 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EEDB1B9;
        Mon, 25 Sep 2023 08:26:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5E64780E2;
        Mon, 25 Sep 2023 15:26:31 +0000 (UTC)
Date:   Mon, 25 Sep 2023 18:26:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Kumar Udit <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: serial: 8250_omap: suspend issue with console_suspend disabled
Message-ID: <20230925152630.GT5282@atomide.com>
References: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
 <20230920053828.GD5282@atomide.com>
 <332111c2-f3f5-3d7f-09ef-f3ebb3f48eb0@bootlin.com>
 <0ab0dc61-aa9b-1f3f-f889-9c6e10dc62f7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab0dc61-aa9b-1f3f-f889-9c6e10dc62f7@bootlin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Thomas Richard <thomas.richard@bootlin.com> [230925 13:03]:
> On 9/21/23 09:58, Thomas Richard wrote:
> > I tested it, it works for me.
> 
> Tony,
> 
> As your proposal works well, do you plan to send a patch ?
> Or would you prefer me to send it ?

Thanks I'll type up the description and send it.

Regards,

Tony
