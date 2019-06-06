Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06E380DA
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 00:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfFFWdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 18:33:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46173 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfFFWdO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 18:33:14 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b1e59abe70cc4a25; Fri, 7 Jun 2019 00:33:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] PCI: PM: Optimization and cleanup
Date:   Fri, 07 Jun 2019 00:28:16 +0200
Message-ID: <2958812.87Qy2A3tJo@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This is a v2 of the patch at

https://patchwork.kernel.org/patch/10969867/

and a cleanup of the PCI PM code modified by it as discussed with Bjorn in the
thread started by that patch.

Thanks,
Rafael



