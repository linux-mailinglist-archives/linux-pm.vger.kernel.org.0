Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86BD2F7336
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 08:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbhAOG6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 01:58:38 -0500
Received: from muru.com ([72.249.23.125]:44898 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbhAOG6h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 01:58:37 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8EA44805C;
        Fri, 15 Jan 2021 06:57:57 +0000 (UTC)
Date:   Fri, 15 Jan 2021 08:57:52 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel@collabora.com,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH] power: supply: cpcap-battery: constify psy_desc
Message-ID: <YAE88PStvdXSR5Sk@atomide.com>
References: <20210114223617.313588-1-sebastian.reichel@collabora.com>
 <20210114233159.GA18332@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114233159.GA18332@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [210114 23:32]:
> On Thu 2021-01-14 23:36:17, Sebastian Reichel wrote:
> > There is no dynamic information in cpcap-battery's
> > power-supply description struct, so let's make it
> > static const.
> > 
> > Cc: Arthur Demchenkov <spinal.by@gmail.com>
> > Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> > Cc: Merlijn Wajer <merlijn@wizzup.org>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Tony Lindgren <tony@atomide.com>

