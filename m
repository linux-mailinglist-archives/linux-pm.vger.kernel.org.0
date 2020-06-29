Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A820D1F1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 20:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgF2SpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 14:45:12 -0400
Received: from muru.com ([72.249.23.125]:59948 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgF2SpL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jun 2020 14:45:11 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 599F08196;
        Mon, 29 Jun 2020 15:56:10 +0000 (UTC)
Date:   Mon, 29 Jun 2020 08:55:15 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        linux-pm@vger.kernel.org
Subject: Re: [RFC] Limiting charge current on Droid 4 (and N900)
Message-ID: <20200629155515.GR37466@atomide.com>
References: <20200615140557.GA22781@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615140557.GA22781@duo.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [200615 07:06]:
> Hi!
> 
> Droid 4 has same problem as N900: it is often neccessary to manually
> tweak current draw from USB, for example when using thin charging cable.
> 
> N900 creates unique attribute by hand, but I believe
> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT looks suitable. (Should N900 be
> converted?)
> 
> Comments? Would the patch be acceptable after fixing whitespace?

Looks OK to me. Until we have better charger vs host vs usb3 charging hub
detection in place this seems like a good thing to do.

Regards,

Tony
