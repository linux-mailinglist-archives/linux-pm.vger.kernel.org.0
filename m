Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B01F75E
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfEOPWc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 11:22:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfEOPWc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 11:22:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 521E7308620D;
        Wed, 15 May 2019 15:22:32 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CC48608A6;
        Wed, 15 May 2019 15:22:31 +0000 (UTC)
Subject: Re: [PATCH] tools/power turbostat: Increase default buffer size
To:     linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <20190514174621.12227-1-prarit@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <711c305c-4811-d2c0-7791-102d42d6a2c4@redhat.com>
Date:   Wed, 15 May 2019 11:22:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514174621.12227-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 15 May 2019 15:22:32 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/14/19 1:46 PM, Prarit Bhargava wrote:
> 'turbostat -D' fails on INTEL_FAM6_KABYLAKE_DESKTOP systems with a
> segfault because the default buffer size is too small.
> 
> Increase the default to 1536.

Self-Nak.  I will post a dynamic allocation solution in a few minutes.

P.

> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index c7727be9719f..b401d1aec394 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -5135,7 +5135,7 @@ int initialize_counters(int cpu_id)
>  
>  void allocate_output_buffer()
>  {
> -	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
> +	output_buffer = calloc(1, (1 + topo.num_cpus) * 1536);
>  	outp = output_buffer;
>  	if (outp == NULL)
>  		err(-1, "calloc output buffer");
> 
