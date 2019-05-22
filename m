Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC226956
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfEVRqu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 13:46:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfEVRqt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 13:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9DJVgy8Tpl4BdMwoiRb2/qFYVN8qm/rU2GhZn7zukJQ=; b=myOqGtDDnNTCMPsyTqdFZ7JDi
        FQsFH+/LNyytXjUP+rnFY0Xd58s+5dA+RlE1u67ydhV3fzTNRiEeH1oGher1RRQaCJkKxNaGJT3Jv
        hogXw3WN952EAJFDEga/l0fJnUl6vpcsvezTyX8G8VEpuijEwDmBbQU7dKFh9dZf7NHBXhBjZ9Ykr
        jDRWhd9Sdjsoqr4MKv7pZ/XB1beSyb2Kk6R2mCt+8zWAfYm/jAjZZTTei1OtBdBW0Yq5uKi7O1PFY
        CV/c9AtfCFSad6qEa0EkkNo7qXkwacsR8446YoRXzSUe9iWf54pF6KFG12yXuw0YXTrCFD7vpERew
        EURCg4XqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTVKC-0008GA-T1; Wed, 22 May 2019 17:46:48 +0000
Date:   Wed, 22 May 2019 10:46:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/4] nvme-pci: support thermal zone
Message-ID: <20190522174648.GA26477@infradead.org>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-5-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558454649-28783-5-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Is there any good reason why we need to call this from the PCIe driver
instead of handling it all in the core?

Sure non-PCIe devices are usually external, but so are some PCIe
devices, so if we really care about that we need some sort of flag
anyway.
