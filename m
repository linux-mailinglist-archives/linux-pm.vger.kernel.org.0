Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304171509BB
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 16:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBCPXB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 10:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgBCPXA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Feb 2020 10:23:00 -0500
Received: from localhost (unknown [223.226.103.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C03B2086A;
        Mon,  3 Feb 2020 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580743380;
        bh=rkn26MrpMFcSHnE5z5fUj/UAjI+2umNWmo/mhUQUu48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0ePOciZ27Uh5SbHvFJ7/ESP+OTN9zC5mlignaJ1YY8NDoyOos0idjAxW4iL4ArHn
         HETVSENpbZ6BQzXZyXf6MXPNeXUar/ODYXXS1YUSE0r1w4WCFrXUTeWDfaDpY75QV+
         VytdIXNISJpgRTLL43fW9wzFYmgM5VlHYQnJFoJk=
Date:   Mon, 3 Feb 2020 20:52:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Fix build error for
 cpu-idle-cooling.rst and client.rst
Message-ID: <20200203152255.GQ2841@vkoul-mobl>
References: <20200203140223.10298-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203140223.10298-1-changbin.du@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-02-20, 22:02, Changbin Du wrote:
> This fixed some errors and warnings in cpu-idle-cooling.rst and client.rst.
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage: ...Documentation/driver-api/thermal/cpu-idle-cooling.rst:96: (SEVERE/4) Unexpected section title.
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage: ...Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v2: rebase.
> ---
>  Documentation/driver-api/dmaengine/client.rst | 14 +++++++---
>  .../driver-api/thermal/cpu-idle-cooling.rst   | 27 ++++++++++---------
>  Documentation/driver-api/thermal/index.rst    |  1 +
>  3 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> index a9a7a3c84c63..2104830a99ae 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -151,8 +151,8 @@ The details of these operations are:
>       Note that callbacks will always be invoked from the DMA
>       engines tasklet, never from interrupt context.
>  
> -  Optional: per descriptor metadata
> -  ---------------------------------
> +  **Optional: per descriptor metadata**

I have already fixed it up and it is linux-next (thru dmaengine tree)

Can you please send rest of client.rst changes to me as well

Thanks
-- 
~Vinod
