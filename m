Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C158CBFC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfHNGiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 02:38:08 -0400
Received: from muru.com ([72.249.23.125]:57414 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfHNGiH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Aug 2019 02:38:07 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 79DC780C8;
        Wed, 14 Aug 2019 06:38:34 +0000 (UTC)
Date:   Tue, 13 Aug 2019 23:38:03 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Tri Vo <trong@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Regression in Linux next with show wakeup sources stats in sysfs
Message-ID: <20190814063803.GY52127@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Looks like commit 986845e747af ("PM / wakeup: Show wakeup sources stats
in sysfs") has caused a regression in Linux next where I can now get
some errors like this during the boot:

kobject_add_internal failed for wakeup10 (error: -2 parent: usb)

Any ideas why this might be happening? Maybe some deferred probe
related issue?

Regards,

Tony
