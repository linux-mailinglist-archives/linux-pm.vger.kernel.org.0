Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A665A20B49
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfEPPbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 11:31:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:63398 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPPbj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 11:31:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 08:31:38 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2019 08:31:38 -0700
Date:   Thu, 16 May 2019 09:26:23 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
Message-ID: <20190516152622.GC23416@localhost.localdomain>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
 <20190515191518.GA21916@localhost.localdomain>
 <CAC5umyhh7eNHa4D9sndsoB7EgTJZTEL9OTd=a+7x817XvPZ_eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umyhh7eNHa4D9sndsoB7EgTJZTEL9OTd=a+7x817XvPZ_eQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 17, 2019 at 12:22:51AM +0900, Akinobu Mita wrote:
> > Since this routine is intended for use in the device initialization path,
> > the error returns are extra important. We have used < 0 to indicate we
> > need to abandon initialization because we won't be able communicate with
> > the device if we proceed. Since thermal reporting is not mandatory to
> > manage our controllers, out-of-memory or a device that doesn't support
> > SMART should just return 0. We should only halt init if the controller
> > is unresponsive here.
> 
> Make sense.  I'll change the return type to void, and print warning in
> case of some errors as Minwoo said in other reply.

Oh, still needs to be an 'int' return, but just suppress non-fatal
errors by returning 0. If the 'nvme_get_log' times out, though, we need
to return that error since the caller will need to abort initialization.
