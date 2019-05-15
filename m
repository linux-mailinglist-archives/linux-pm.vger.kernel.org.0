Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A121D1F8AE
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEOQbV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 12:31:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48698 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfEOQbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 12:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lrDbCxLPOQmnTKtI7+fVuZnBx56mAdej3C4tjV05qA8=; b=gsty7Si8cMOJ7hPROVkuUgGw5
        VpKVbc8kxM6Vgqebuw/qvY72+EEMkVgBD5EWo6smYaaOBtyLDfSJBQC5+4HjF870a291U4w3xdAYr
        ET2qhEBg1iSiHdNNsY6X/+6DdYp5rzgHJvBgZlkRVo89Eor1g3B5FZmZHTTJxFfLkzyXMSfqm3cGX
        WNshTolEjd3qVcl+RAEN3/86on1K/NKem7ZPn3KHZA0u1I8agv/yMioL5lqAVdBXRKE1htGpOLvf7
        jleFmzsLxofBUYxj1Zh/MPG4tuONYFkFT8Y346RpEsMXmVi6twUihhcpl/2Im5awaNVk0MS83uPED
        /cn62Vd2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQwoG-0001CT-EZ; Wed, 15 May 2019 16:31:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FF8D2029906B; Wed, 15 May 2019 18:31:15 +0200 (CEST)
Date:   Wed, 15 May 2019 18:31:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
Subject: Re: [RFCv2 3/6] sched/core: Update turbo_sched count only when
 required
Message-ID: <20190515163115.GV2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-4-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-4-parth@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:19PM +0530, Parth Shah wrote:
> Use the get/put methods to add/remove the use of TurboSched support from
> the cgroup.

Didn't anybody tell you that cgroup only interfaces are frowned upon?
