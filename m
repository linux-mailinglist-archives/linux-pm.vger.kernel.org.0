Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4138123A3A6
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgHCL5C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 07:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgHCL5B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 07:57:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09522076C;
        Mon,  3 Aug 2020 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596455820;
        bh=1B32VBXkTOu6ya5xaGuX3/aemtBhFCxYL4uyodnisPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ySAidrBqFvVbFJBiyKk5eKRAVNEPQTe1b/IakySXRyswxtAk+Rb0NnSrrwhcl5NyP
         6V6d/ViKOFYR+8cpXtDtVFD1TrgrQYhV45Xfq5uDIpa2QpodQbFboeVl7R+clRcRzV
         cV0nkP+1OGKBRp7hZM2gmAG+kQwbZquZHKdOQSlA=
Date:   Mon, 3 Aug 2020 13:56:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>, Qiwu Huang <yanziily@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangfei1@xiaomi.com, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v4 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200803115644.GC955269@kroah.com>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
 <20200802120015.GA1289@bug>
 <20200802123742.GA257810@kroah.com>
 <20200802142825.GA20261@amd>
 <20200802165738.GA293244@kroah.com>
 <20200803114950.oyb3gzyiccybah3u@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803114950.oyb3gzyiccybah3u@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 03, 2020 at 01:49:50PM +0200, Sebastian Reichel wrote:
> More importantely I prefer not to merge new APIs without any users
> (i.e. a driver making use of those values). Having a reference
> driver means, that there is an example how to use the values
> correctly and proves it is actually needed upstream. Right now
> this looks like "let's modify the upstream kernel, so that we can
> easily maintain our out of tree driver".

Agreed.  Qiwu, can you also submit your driver so we can see these
values be used?

thanks,

greg k-h
