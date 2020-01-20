Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D6142F96
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgATQ2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 11:28:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATQ2G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 11:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RVGteCNPSxBOd3jK5jlnv8Bj2S7v0sx7k9crBQcFwxA=; b=sH+7R311dDI3YHDxOL9qPuV7e
        zNgsq/1Ta2uXWfwAoIZJf1Nyehl5lb/ctom1kmqSqtPGPAtMYRn8dGQB6TrlPqJUmgzbsqvGh2Qa2
        lb7OxA6F7zc/2mvNhfNlWT2JIokyTS0fp8Y6rjEzHEmpU4yXg6AgZtNdmeEgqrlsvUIOx1ui1OyCA
        OyRkoBbdmS8GFh9GmPJ9l3YMOCaDKDghwc1kPtA0nzjeEWfyYAdQ4g/4NvNc5eUfCJz5plxV+f2A3
        W7IoEzlCMJgBZj7lV4j3mUdh7NHcQV+BQ1BBdNKw9OQOScTiO4hxyvxUvXi/x/I3xWyP2QGAwr7JJ
        l/oVSXTSA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itZuH-0002Bv-Ha; Mon, 20 Jan 2020 16:28:05 +0000
Subject: Re: [PATCH] cpuidle: fix kernel doc warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200120130701.29948-1-benjamin.gaignard@st.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ab9ae316-e01e-117c-36d5-0f733c407217@infradead.org>
Date:   Mon, 20 Jan 2020 08:28:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200120130701.29948-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/20/20 5:07 AM, Benjamin Gaignard wrote:
> Fix cpuidle_find_deepest_state() kernel documentation to avoid warnings when compiling with W=1.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
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
> + * Returns the index of the deepest available idle state.

Preferably:

  * Return: the index of the deepest available idle state.

>   */
>  int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  			       struct cpuidle_device *dev,
> 

thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
