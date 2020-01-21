Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569A4144098
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 16:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAUPg5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 10:36:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAUPg5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 10:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A2Jl2bLHZhl7wIlCaLkS8vYGcnAwtZe/zKKDWk316Z0=; b=O8ypNryAqkVOOcR5KkTRtyOQ0
        MCrTL2KY6noTexMRlTYtRKHeguvWokumk4A7tO8qrdo1y5cOonXRgPEzrzcysvD6CSyc62hJ5sdEb
        KQbuDKOv3jA3W1Rta99+2+Udf2uU+B1HHk3+kMvAoPIuzcL5La8dCvzACWGwVIxzDbu0krATbH5XL
        bufhzWJ48Bwjr8H/6pBlcuQBlZWdaLx8oA1QQvT1aZoSNk8XkH/9tMsgjg/WAgz40VFKsb38Biywj
        8fvE/zKO7azHt08wvmIbi7/jdzGDEuFxT1HSVgtqiYtfz6oi3ornGddMAfoQ3AbYgKgAvA3kEiCwh
        DDeXmC2ag==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itvaK-0000MG-MK; Tue, 21 Jan 2020 15:36:56 +0000
Subject: Re: [PATCH v2] cpuidle: fix kernel doc warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200121082758.8808-1-benjamin.gaignard@st.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4c2b0c6f-c0d7-5866-44cf-e32d84c4261a@infradead.org>
Date:   Tue, 21 Jan 2020 07:36:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121082758.8808-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/21/20 12:27 AM, Benjamin Gaignard wrote:
> Fix cpuidle_find_deepest_state() kernel documentation to avoid warnings when compiling with W=1.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> CC: rdunlap@infradead.org
> version 2:
> - fix the comment done by Randy
>  drivers/cpuidle/cpuidle.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 33d19c8eb027..19c6dee88921 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -121,6 +121,9 @@ void cpuidle_use_deepest_state(u64 latency_limit_ns)
>   * cpuidle_find_deepest_state - Find the deepest available idle state.
>   * @drv: cpuidle driver for the given CPU.
>   * @dev: cpuidle device for the given CPU.
> + * @latency_limit_ns: Idle state exit latency limit
> + *
> + * Return: the index of the deepest available idle state.
>   */
>  int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  			       struct cpuidle_device *dev,
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
