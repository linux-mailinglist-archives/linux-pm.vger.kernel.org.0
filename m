Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC44119EAF
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfEJOHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 10:07:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:32011 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfEJOHi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 May 2019 10:07:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 07:07:38 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 10 May 2019 07:07:37 -0700
Date:   Fri, 10 May 2019 08:02:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Message-ID: <20190510140209.GG9675@localhost.localdomain>
References: <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 11:05:42PM -0700, Kai-Heng Feng wrote:
> Yes, that’ what I was told by the NVMe vendor, so all I know is to impose a  
> memory barrier.
> If mb() shouldn’t be used here, what’s the correct variant to use in this  
> context?

I'm afraid the requirement is still not clear to me. AFAIK, all our
barriers routines ensure data is visible either between CPUs, or between
CPU and devices. The CPU never accesses HMB memory, so there must be some
other reasoning if this barrier is a real requirement for this device.
