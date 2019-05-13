Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935091B8C8
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfEMOnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 10:43:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:2011 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbfEMOnR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 10:43:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 07:43:17 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 13 May 2019 07:43:16 -0700
Date:   Mon, 13 May 2019 08:37:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513143754.GE15318@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 02:24:41PM +0000, Mario.Limonciello@dell.com wrote:
> This was not a disk with HMB, but with regard to the HMB I believe it needs to be
> removed during s0ix so that there isn't any mistake that SSD thinks it can access HMB
> memory in s0ix.

Is that really the case, though? Where may I find that DMA is not
allowed in this state? I just want an authoritative reference to attach
to the behavior.
