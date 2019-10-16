Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4461ADA1B3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393383AbfJPWpg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 18:45:36 -0400
Received: from muru.com ([72.249.23.125]:37716 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfJPWpf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:45:35 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D5CEC8107;
        Wed, 16 Oct 2019 22:46:09 +0000 (UTC)
Date:   Wed, 16 Oct 2019 15:45:32 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/5] cpcap battery simplification and calibrate support
Message-ID: <20191016224532.GJ5610@atomide.com>
References: <20191009210621.10522-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009210621.10522-1-tony@atomide.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191009 21:07]:
> This set of changes simplifies the coulomb counter code for cpcap-battery.
> And the last patch in the series add support for coulomb counter calibration
> on probe.

Sebastian, if no other comments, let me know if you need a
resend of this set too with Pavel's acks collected.

Regards,

Tony
