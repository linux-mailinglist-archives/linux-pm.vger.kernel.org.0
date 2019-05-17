Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093F021A5E
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfEQPOo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 11:14:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:6783 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbfEQPOn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 May 2019 11:14:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 08:14:39 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2019 08:14:37 -0700
Date:   Fri, 17 May 2019 09:09:25 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     "Heitke, Kenneth" <kenneth.heitke@intel.com>,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
Message-ID: <20190517150924.GA25006@localhost.localdomain>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
 <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>
 <CAC5umygRTpq3GktaMKBdC8+-ghkJKCzFME+rm+V6vasrOAyOPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umygRTpq3GktaMKBdC8+-ghkJKCzFME+rm+V6vasrOAyOPw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 18, 2019 at 12:01:57AM +0900, Akinobu Mita wrote:
> 
> This is work_struct, not workqueue.  So it can't be destroyed.
> But I noticed that we should call flush_work for thermal_work at
> unregistering thermal zone devices.

Instead of creating yet-another-work_struct, let's append this event's
action to the existing async_event_work.
