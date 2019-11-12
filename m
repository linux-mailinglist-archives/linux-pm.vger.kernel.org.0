Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE33F9F16
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 01:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKMALj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 19:11:39 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49707 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKMALj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 19:11:39 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 0f4d58612dc49b34; Wed, 13 Nov 2019 01:11:37 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 0/3] cpuidle: teo: Bug fix, formal correction and cleanup
Date:   Wed, 13 Nov 2019 00:57:10 +0100
Message-ID: <13588000.TfE7eV4KYW@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

These are three updates of the teo cpuidle governor.

Patch [1/3] fixes a bug in it (present from the outset and not addressed by
recent updates).  Patch [2/3] is a formal correction, mostly about avoiding
unrealistic expectations (even if that doesn't make much of a practical
difference), and patch [3/3] is a cleanup.

The series is on top of the linux-next branch in the linux-pm.git tree from
today.

Thanks,
Rafael



