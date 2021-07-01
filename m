Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D933B938F
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhGAOw7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhGAOw7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 10:52:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD75C061762;
        Thu,  1 Jul 2021 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JKzt46NlE/OClzyqd5L8qkhPno3gsENpKKVZIXqgBLM=; b=r7T6GbpghOx3fktE2bmkIi2N1q
        /rVRSO+kYNfI4KG2tzsa3J5i72e5Pz2ms7+WokBMFUwRJdvrIco/3tsDe/yZeECiRAFtHxzA49+pO
        Gc/6PNHWuV9Pn3o2iye7dcpr+7dkgcrfrFJW39KUGHs/n4DpWv2051zcmB7D219ICwjmCN3cKDVR1
        nXCMbfU4gDQW+ZQkcgniKXqlg8yRwYM/M4PnG3Cas89djZVw2TuH3lwNzhWJGHJyZ/Z+uI9RaltO2
        TlQ2Z3XEPTPcWE9EZ1bQrMlID8fN5G6DpD6qZMEsaYhBNXAzk8ph2mx3YPWals1DkUm5/Pd+x8roo
        4soZ3raQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyy0l-006fTq-1V; Thu, 01 Jul 2021 14:49:59 +0000
Date:   Thu, 1 Jul 2021 15:49:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        kernel@puri.sm, stern@rowland.harvard.edu
Subject: Re: [PATCH v5 2/3] scsi: sd: send REQUEST SENSE for
 BLIST_MEDIA_CHANGE devices in runtime_resume()
Message-ID: <YN3WD4Vem5Zx8Dvq@infradead.org>
References: <20210630084453.186764-1-martin.kepplinger@puri.sm>
 <20210630084453.186764-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630084453.186764-3-martin.kepplinger@puri.sm>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 30, 2021 at 10:44:52AM +0200, Martin Kepplinger wrote:
> +	struct scsi_disk *sdkp = dev_get_drvdata(dev);
> +	struct scsi_device *sdp = sdkp->device;
> +	int timeout, res;
> +
> +	timeout = sdp->request_queue->rq_timeout * SD_FLUSH_TIMEOUT_MULTIPLIER;

Is REQUEST SENSE reqlly a so slow operation on these devices that
we need to override the timeout?
