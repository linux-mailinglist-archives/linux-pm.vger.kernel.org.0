Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3713C4344E4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 08:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTGC3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 02:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhJTGC3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Oct 2021 02:02:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06F1E610FF;
        Wed, 20 Oct 2021 06:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634709615;
        bh=wDOdj7RzJdGG3ZtY7kMoD5R7naLe/tRavGS5wQdN7NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIAcNsNSKMCDAuaFi3cF7hfC6kuu3kF9vxppGNnz5xoQua+Ti+zDPUWFAVPoP5uvC
         qrWASDc/5T60ldrCusUvq931GXuBbUk9avanngh6sQQL/No4MfXTqbfXZRUJ8Ifklh
         4KPtfkwIRWiTpb4cRNSEr4iUecwywaqLO6ys8zDE=
Date:   Wed, 20 Oct 2021 08:00:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, jiangshanlai@gmail.com, jirislaby@kernel.org,
        rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4] workqueue: Introduce show_one_worker_pool and
 show_one_workqueue.
Message-ID: <YW+wagIij7zUbfsZ@kroah.com>
References: <20211020030900.321837-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020030900.321837-1-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 20, 2021 at 02:09:00PM +1100, Imran Khan wrote:
> Currently show_workqueue_state shows the state of all workqueues and of
> all worker pools. In certain cases we may need to dump state of only a
> specific workqueue or worker pool. For example in destroy_workqueue we
> only need to show state of the workqueue which is getting destroyed.
> 
> So rename show_workqueue_state to show_all_workqueues(to signify it
> dumps state of all busy workqueues) and divide it into more granular
> functions (show_one_workqueue and show_one_worker_pool), that would show
> states of individual workqueues and worker pools and can be used in
> cases such as the one mentioned above.
> 
> Also, as mentioned earlier, make destroy_workqueue dump data pertaining
> to only the workqueue that is being destroyed and make user(s) of
> earlier interface(show_workqueue_state), use new interface
> (show_all_workqueues).
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
> Changes in v4:
>   - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
>     for-5.16

"RFC" means "I am not sure about this patch, please do not apply it."

Yet a v4 is very odd, why not be sure about this?

thanks,

greg k-h
