Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E96159D59
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgBKXjG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:39:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50793 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgBKXjF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:39:05 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id ac3b5ede439dbdc3; Wed, 12 Feb 2020 00:39:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU latency QoS interface
Date:   Tue, 11 Feb 2020 23:51:05 +0100
Message-ID: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

This series of patches is based on the observation that after commit
c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
code dedicated to the handling of global PM QoS classes in general.  That code
takes up space and adds overhead in vain, so it is better to get rid of it.

Moreover, with that unuseful code removed, the interface for adding QoS
requests for CPU latency becomes inelegant and confusing, so it is better to
clean it up.

Patches [01/28-12/28] do the first part described above, which also includes
some assorted cleanups of the core PM QoS code that doesn't go away.

Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
"define stubs, migrate users, change the API proper" manner), patches
[26-27/28] update the general comments and documentation to match the code
after the previous changes and the last one makes the CPU latency QoS depend
on CPU_IDLE (because cpuidle is the only user of its target value today).

The majority of the patches in this series don't change the functionality of
the code at all (at least not intentionally).

Please refer to the changelogs of individual patches for details.

Thanks!



