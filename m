Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6A1BD1A
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEMSVl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 14:21:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:10239 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfEMSVl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 14:21:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 11:21:40 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2019 11:21:40 -0700
Date:   Mon, 13 May 2019 12:16:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     sagi@grimberg.me, rafael@kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513181618.GD15437@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
 <20190513151652.GB15437@localhost.localdomain>
 <9AE4A3E7-CDB8-4730-8B4E-43C93FC0C47F@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9AE4A3E7-CDB8-4730-8B4E-43C93FC0C47F@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 14, 2019 at 01:16:22AM +0800, Kai-Heng Feng wrote:
> Disabling HMB prior suspend makes my original patch work without memory
> barrier.
> 
> However, using the same trick on this patch still freezes the system during
> S2I.

Could you post your code, please?
