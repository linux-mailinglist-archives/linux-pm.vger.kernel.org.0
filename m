Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134F07E407
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfHAUZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 16:25:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:17876 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfHAUZc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Aug 2019 16:25:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 13:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="163729047"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2019 13:25:30 -0700
Date:   Thu, 1 Aug 2019 14:22:51 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Message-ID: <20190801202251.GD15795@localhost.localdomain>
References: <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <CAJZ5v0hxYGBXau39sb80MQ8jbZZCzH0JU2DYZvn9JOtYT2+30g@mail.gmail.com>
 <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70D536BE-8DC7-4CA2-84A9-AFB067BA520E@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 01, 2019 at 02:05:54AM -0700, Kai-Heng Feng wrote:
> at 06:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Aug 1, 2019 at 12:22 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> >> In which case we do need to reintroduce the HMB handling.
> >
> > Right.
> 
> The patch alone doesn’t break HMB Toshiba NVMe I tested. But I think it’s  
> still safer to do proper HMB handling.

Spec requires host request controller release HMB for D3cold. I suspect
you're only getting to D3hot.
