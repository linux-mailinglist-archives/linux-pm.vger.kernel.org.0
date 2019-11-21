Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9831059D6
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 19:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKUSoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 13:44:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53007 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUSoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 13:44:14 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 0f0c262c8173fe24; Thu, 21 Nov 2019 19:44:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael@kernel.org>
Subject: [PATCH 0/2] cpuidle: Allow CPU idle states to be disabled by default
Date:   Thu, 21 Nov 2019 19:35:42 +0100
Message-ID: <5961586.ml7s97geqL@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

This is a follow-up to

https://lore.kernel.org/linux-pm/1688511.GgkECGP1XA@kreacher/T/#u

Patch [1/2] is a cleanup on top of the changes waiting for the 5.5 merge
window in linux-next.

Patch [2/2] is for the future, to be considered along with the first user of
CPUIDLE_FLAG_OFF.

Thanks,
Rafael



