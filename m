Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC24D337C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfJJVeP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 17:34:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65291 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVeP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 17:34:15 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 41120e105ba2e198; Thu, 10 Oct 2019 23:34:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 0/4] cpuidle: teo: Fix issues related to disabled idle states
Date:   Thu, 10 Oct 2019 23:30:40 +0200
Message-ID: <60416800.X4hXmAfbqi@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

There are a few issues related to the handling of disabled idle states in the
TEO (Timer-Events-Oriented) cpuidle governor which are addressed by this
series.

The application of the entire series is exactly equivalent to the testing patch
at https://lore.kernel.org/lkml/3490479.2dnHFFeJIp@kreacher/ , but IMO it is
cleaner to split the changes into smaller patches which also allows them to
be explained more accurately.

Thanks,
Rafael



