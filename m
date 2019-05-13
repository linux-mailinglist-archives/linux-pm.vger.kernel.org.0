Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C71B95A
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfEMPAs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 11:00:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:42469 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfEMPAs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 11:00:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 08:00:47 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2019 08:00:46 -0700
Date:   Mon, 13 May 2019 08:55:24 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     hch@lst.de, keith.busch@intel.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513145522.GA15421@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de>
 <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 02:43:43PM +0000, Mario.Limonciello@dell.com wrote:
> > Well, it sounds like your partners device does not work properly in this
> > case.  There is nothing in the NVMe spec that says queues should be
> > torn down for deep power states, and that whole idea seems rather
> > counter productive to low-latency suspend/resume cycles.
> 
> Well I've got a thought, quoting the NVME spec:
> "After a successful completion of a Set Features command for this feature, the controller shall be in the
> Power State specified. If enabled, autonomous power state transitions continue to occur from the new state."
> 
> If APST is enabled on this disk, what is to stop an autonomous  reverse
> transition from queue activity on the way down?

Regardless of whether APST is enabled or not, the controller may
autonomously transition out of a host requested low power state in
response to host activity. Exiting a low power state should mean some
other task is actively using the device, and if that's the case, why are
you trying to enter a low power state in the first place? Alternatively,
if host activity really is idle, then why is the device autonomously
leaving the requested state?
