Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACF632D6EB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 16:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhCDPnt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 10:43:49 -0500
Received: from mail.ispras.ru ([83.149.199.84]:50806 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235348AbhCDPnp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Mar 2021 10:43:45 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 10:43:44 EST
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 4C99740D403E;
        Thu,  4 Mar 2021 15:34:43 +0000 (UTC)
Date:   Thu, 4 Mar 2021 18:34:43 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: AHCI SATA Runtime PM
Message-ID: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello, Hans, Linux PM folks,

I'm looking for clarification regarding this patch discussion:

https://patchwork.kernel.org/project/linux-pm/patch/20180420101834.15783-2-0v3rdr0n3@gmail.com/

Hans said,

> Ah, so the AHCI code has runtime pm enabled by default (so there
> is another pm_runtime_allow() somewhere, but then disables it for
> unused ports to make hotpluging something into those ports work.

I have a laptop where two unused AHCI SATA controllers are present (but
obviously nothing can be hotplugged into them). Apparently due to the above,
they do not enter runtime autosuspend.

The problem is, these "ATA port" nodes don't seem to participate in udev
hierarchy, so it's unclear how I'm supposed to automatically re-enable
runtime PM for them. For PCI device nodes, I have

ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"

but ata1/uevent is empty, so there's no obvious way to write the corresponding
UDev rule.

Prior to discovering the above patch discussion, I have filed a bug:
https://bugzilla.kernel.org/show_bug.cgi?id=211837

Does the above correctly reflect how AHCI PM is supposed to be? If so, what is
the proper way to enable runtime PM for unused ATA ports?

Thank you.
Alexander
