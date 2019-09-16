Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C88B3D50
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 17:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfIPPJk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 11:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388324AbfIPPJk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Sep 2019 11:09:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FBF93001571;
        Mon, 16 Sep 2019 15:09:40 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A2424E6A0;
        Mon, 16 Sep 2019 15:09:39 +0000 (UTC)
Subject: Re: [PATCH 09/19] tools/power turbostat: fix buffer overrun
To:     Len Brown <lenb@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
References: <eeb71c950bc6eee460f2070643ce137e067b234c.1567277326.git.len.brown
 () intel ! com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <f335ff51-4c10-11c4-c022-401d15aab8c3@redhat.com>
Date:   Mon, 16 Sep 2019 11:09:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eeb71c950bc6eee460f2070643ce137e067b234c.1567277326.git.len.brown
 () intel ! com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 16 Sep 2019 15:09:40 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/31/19 3:34 PM, Len Brown wrote:
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> turbostat could be terminated by general protection fault on some latest
> hardwares which (for example) support 9 levels of C-states and show 18
> "tADDED" lines. That bloats the total output and finally causes buffer
> overrun.  So let's extend the buffer to avoid this.
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 2fb5c155289b..f8f4e1c130a6 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -5131,7 +5131,7 @@ int initialize_counters(int cpu_id)
>  
>  void allocate_output_buffer()
>  {
> -	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
> +	output_buffer = calloc(1, (1 + topo.num_cpus) * 2048);

While this "works" I'm not convinced it is a final fix. I think moving to the
proposal Naoya & I laid out would be better.

https://marc.info/?l=linux-pm&m=155809356001873&w=2

Len, what do you think?

P.

>  	outp = output_buffer;
>  	if (outp == NULL)
>  		err(-1, "calloc output buffer");
> 
