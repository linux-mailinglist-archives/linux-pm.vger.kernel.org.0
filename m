Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD27F58E4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 21:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKHUuz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 15:50:55 -0500
Received: from muru.com ([72.249.23.125]:41184 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfKHUuy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 15:50:54 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2156D80D4;
        Fri,  8 Nov 2019 20:51:30 +0000 (UTC)
Date:   Fri, 8 Nov 2019 12:50:50 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, hns@goldelico.com,
        adam.ford@logicpd.com, Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: ti-soc-thermal:  Enable addition power
 management
Message-ID: <20191108205050.GO5610@atomide.com>
References: <20191108200501.29864-1-aford173@gmail.com>
 <20191108204531.GN5610@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108204531.GN5610@atomide.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191108 20:46]:
> Also, you may want to check if the driver needs to
> save and restore it's context in the notifier as that
> might get lost during the off mode depending what
> domain it's at.

Oh never mind, looks like you already took care of
saving and restoring the context in the notifier,
I just missed it.

Thanks,

Tony
