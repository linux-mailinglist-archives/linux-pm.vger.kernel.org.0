Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C63B751E3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfGYOzF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 10:55:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:21779 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388424AbfGYOzE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jul 2019 10:55:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 07:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="177989924"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jul 2019 07:55:03 -0700
Date:   Thu, 25 Jul 2019 08:52:10 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Message-ID: <20190725145209.GA6949@localhost.localdomain>
References: <2332799.izEFUvJP67@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2332799.izEFUvJP67@kreacher>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 25, 2019 at 02:51:41AM -0700, Rafael J. Wysocki wrote:
> Hi Keith,
> 
> Unfortunately,
> 
> commit d916b1be94b6dc8d293abed2451f3062f6af7551
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Thu May 23 09:27:35 2019 -0600
> 
>     nvme-pci: use host managed power state for suspend
> 
> doesn't universally improve things.  In fact, in some cases it makes things worse.
> 
> For example, on the Dell XPS13 9380 I have here it prevents the processor package
> from reaching idle states deeper than PC2 in suspend-to-idle (which, of course, also
> prevents the SoC from reaching any kind of S0ix).
> 
> That can be readily explained too.  Namely, with the commit above the NVMe device
> stays in D0 over suspend/resume, so the root port it is connected to also has to stay in
> D0 and that "blocks" package C-states deeper than PC2.
> 
> In order for the root port to be able to go to D3, the device connected to it also needs
> to go into D3, so it looks like (at least on this particular machine, but maybe in
> general), both D3 and the NVMe-specific PM are needed.
> 
> I'm not sure what to do here, because evidently there are systems where that commit
> helps.  I was thinking about adding a module option allowing the user to override the
> default behavior which in turn should be compatible with 5.2 and earlier kernels.

Darn, that's too bad. I don't think we can improve one thing at the
expense of another, so unless we find an acceptable criteria to select
what low power mode to use, I would be inclined to support a revert or
a kernel option to default to the previous behavior.

One thing we might check before using NVMe power states is if the lowest
PS is non-operational with MP below some threshold. What does your device
report for:

  nvme id-ctrl /dev/nvme0

?
