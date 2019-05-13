Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB501B98D
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfEMPKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 11:10:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:60387 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfEMPKV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 11:10:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 08:10:20 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2019 08:10:20 -0700
Date:   Mon, 13 May 2019 09:04:58 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     hch@lst.de, keith.busch@intel.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513150458.GA15437@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de>
 <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
 <20190513145522.GA15421@localhost.localdomain>
 <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 03:05:42PM +0000, Mario.Limonciello@dell.com wrote:
> This system power state - suspend to idle is going to freeze threads.
> But we're talking a multi threaded kernel.  Can't there be a timing problem going
> on then too?  With a disk flush being active in one task and the other task trying
> to put the disk into the deepest power state.  If you don't freeze the queues how
> can you guarantee that didn't happen?

But if an active data flush task is running, then we're not idle and
shouldn't go to low power.
