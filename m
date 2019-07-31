Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D877E7D114
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfGaWWi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 18:22:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:38707 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfGaWWi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Jul 2019 18:22:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 15:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,331,1559545200"; 
   d="scan'208";a="371719160"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2019 15:22:36 -0700
Date:   Wed, 31 Jul 2019 16:19:56 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Message-ID: <20190731221956.GB15795@localhost.localdomain>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher>
 <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 31, 2019 at 11:25:51PM +0200, Rafael J. Wysocki wrote:
> 
> A couple of remarks if you will.
> 
> First, we don't know which case is the majority at this point.  For
> now, there is one example of each, but it may very well turn out that
> the SK Hynix BC501 above needs to be quirked.
> 
> Second, the reference here really is 5.2, so if there are any systems
> that are not better off with 5.3-rc than they were with 5.2, well, we
> have not made progress.  However, if there are systems that are worse
> off with 5.3, that's bad.  In the face of the latest findings the only
> way to avoid that is to be backwards compatible with 5.2 and that's
> where my patch is going.  That cannot be achieved by quirking all
> cases that are reported as "bad", because there still may be
> unreported ones.

I have to agree. I think your proposal may allow PCI D3cold, in which
case we do need to reintroduce the HMB handling.
