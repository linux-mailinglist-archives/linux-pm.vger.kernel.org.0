Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2BF1B94E
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfEMO5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 10:57:30 -0400
Received: from verein.lst.de ([213.95.11.211]:39834 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbfEMO53 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 10:57:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4F4D368AFE; Mon, 13 May 2019 16:57:08 +0200 (CEST)
Date:   Mon, 13 May 2019 16:57:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario.Limonciello@dell.com
Cc:     kbusch@kernel.org, keith.busch@intel.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513145708.GA25897@lst.de>
References: <20190510212937.11661-1-keith.busch@intel.com> <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM> <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM> <20190513143754.GE15318@localhost.localdomain> <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 02:54:49PM +0000, Mario.Limonciello@dell.com wrote:
> The Intel DMA controller suspend callbacks in drivers/dma/idma64.c look to me to
> turn off the controller.

How is that relevant?  That thing is neither a NVMe controller, nor
even an PCIe device..

> And NVME spec made it sound to me that while in a low power state it shouldn't
> be available if the memory isn't available.
> 
> NVME spec in 8.9:
> 
> "Host software should request that the controller release the
> assigned ranges prior to a shutdown event, a Runtime D3 event, or any other event
> that requires host software to reclaim the assigned ranges."

The last part of the quoted text is the key - if the assigned range
is reclaimed, that is the memory is going to be used for something else,
we need to release the ranges.  But we do not release the ranges,
as we want to keep the memory in use so that we can quickly use it
again.
