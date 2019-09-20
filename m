Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6D7B917E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfITOSF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 10:18:05 -0400
Received: from muru.com ([72.249.23.125]:33978 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387773AbfITOSE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Sep 2019 10:18:04 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 610A580AA;
        Fri, 20 Sep 2019 14:18:36 +0000 (UTC)
Date:   Fri, 20 Sep 2019 07:18:01 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 3/3] power: supply: cpcap-charger: Improve battery
 detection
Message-ID: <20190920141801.GN5610@atomide.com>
References: <20190917213501.16907-1-tony@atomide.com>
 <20190917213501.16907-4-tony@atomide.com>
 <20190919091955.GC9644@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919091955.GC9644@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190919 09:20]:
> Would it also make sense to publish battery temperature somewhere? It
> is somehow important for checking "what is going on" and it should
> also be used to control charging. (Normal charging should only be
> allowed in normal temperatures, like >10C and <30C or so..)

We have it show up for battery already, not for usb charger
since it's battery value. The usb charger just uses it for
battery detection.

Regards,

Tony
