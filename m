Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B973F1B181C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTVNv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 17:13:51 -0400
Received: from nimbus1.mmprivatehosting.com ([54.208.90.49]:59626 "EHLO
        nimbus1.mmprivatehosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgDTVNv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 17:13:51 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2020 17:13:50 EDT
Received: from localhost (localhost [127.0.0.1])
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTP id A02F96007C;
        Mon, 20 Apr 2020 21:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at mmprivatehosting.com
Received: from dave.mielke.cc (CPE74dada261772-CMac202ebc50a0.cpe.net.cable.rogers.com [174.115.199.202])
        (Authenticated sender: relay@dave.mielke.cc)
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTPA;
        Mon, 20 Apr 2020 21:07:11 +0000 (UTC)
Received: from beta.private.mielke.cc (beta.private.mielke.cc [192.168.0.2])
        by dave.mielke.cc (Postfix) with ESMTPS id C07FF4A7;
        Mon, 20 Apr 2020 17:07:10 -0400 (EDT)
Received: from beta.private.mielke.cc (localhost [127.0.0.1])
        by beta.private.mielke.cc (8.15.2/8.15.2) with ESMTP id 03KL7ASh029807;
        Mon, 20 Apr 2020 17:07:10 -0400
Received: (from dave@localhost)
        by beta.private.mielke.cc (8.15.2/8.15.2/Submit) id 03KL7AKd029805;
        Mon, 20 Apr 2020 17:07:10 -0400
Date:   Mon, 20 Apr 2020 17:07:10 -0400
From:   Dave Mielke <Dave@mielke.cc>
To:     linux-pm@vger.kernel.org
Cc:     Samuel Thibault <Samuel.Thibault@ens-lyon.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Writing to /sys/../power/autosuspend when not root.
Message-ID: <20200420210710.GF28801@beta.private.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're working on getting brltty to run as an unprivileged user with just a few
required capabilities. We don't want one of those required capabilities to be
CAP_DAC_OVERRIDE (bypass file permission checks).

Some USB-connected braille devices don't respond very well to being
autosuspended. We get around this, when running as root, by writing to the
SYSFS power/autosuspend file associated with the device. Our problem is that
only the root user can write to it.

Other than using CAP_DAC_OVERRIDE (which we don't want to do), what other
way(s) might we be able to use to overcome this restriction? For example, is
there some kind of safe (enough) udev rule?

-- 
I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
Phone: +1 613 726 0014 | Canada  K2A 1H7   |
