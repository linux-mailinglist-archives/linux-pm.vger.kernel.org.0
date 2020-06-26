Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727D320B038
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgFZLKe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 07:10:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:56609 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbgFZLKd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jun 2020 07:10:33 -0400
IronPort-SDR: ORHEVgrLOqtf0S73KEDcfKToelhaZ7/UYbm1H30uy/XSkPcjyMIYnu4DZJirKYagikl6Uk1X5s
 sWqQx8Qe/3/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="206798107"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="206798107"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 04:10:33 -0700
IronPort-SDR: K4BpJTLQFjvUecyfJ59jAZx3IUS4nvdGOF0MMcryn8g4hpfmGRZG5EyttPZBQWEmsfe7cMKLp5
 Lw/u3v7QRMNA==
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="280117272"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.133.102])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 04:10:32 -0700
Message-ID: <3924b9356476fd78a563ff9296c88a6f716ba4e1.camel@linux.intel.com>
Subject: Re: [PATCH] lib: Extend kstrtobool() to accept "true"/"false"
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, jic23@cam.ac.uk,
        keescook@chromium.org, akpm@linux-foundation.org
Date:   Fri, 26 Jun 2020 04:10:32 -0700
In-Reply-To: <20200626104442.GF117543@hirez.programming.kicks-ass.net>
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
         <20200626084903.GA27151@zn.tnic>
         <20200626102255.GZ4817@hirez.programming.kicks-ass.net>
         <20200626104442.GF117543@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-06-26 at 12:44 +0200, Peter Zijlstra wrote:
> On Fri, Jun 26, 2020 at 12:22:55PM +0200, Peter Zijlstra wrote:
> 
> > > This is too lax - it will be enabled for any !0 value. Please
> > > accept
> > > only 0 and 1.
> > 
> > kstrtobool() ftw
> 
> And looking at that, I find it really strange it does not in fact
> accept
> "true" / "false", so how about this?
looks good.

Thanks,
Srinvas

> 
> ---
> Subject: lib: Extend kstrtobool() to accept "true"/"false"
> 
> Extend the strings recognised by kstrtobool() to cover:
> 
>   - 1/0
>   - y/n
>   - yes/no	(new)
>   - t/f		(new)
>   - true/false  (new)
>   - on/off
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  lib/kstrtox.c | 60 ++++++++++++++++++++++++++++++++++++++++++++-----
> ----------
>  1 file changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 1006bf70bf74..b8b950325097 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -325,9 +325,17 @@ EXPORT_SYMBOL(kstrtos8);
>   * @s: input string
>   * @res: result
>   *
> - * This routine returns 0 iff the first character is one of
> 'Yy1Nn0', or
> - * [oO][NnFf] for "on" and "off". Otherwise it will return
> -EINVAL.  Value
> - * pointed to by res is updated upon finding a match.
> + * This return return 0 on success, otherwise it will return
> -EINVAL.
> + * It will accept (case invariant):
> + *
> + *  - 1/0
> + *  - y/n
> + *  - yes/no
> + *  - t/f
> + *  - true/false
> + *  - on/off
> + *
> + * and set @*res to either true/false respectively.
>   */
>  int kstrtobool(const char *s, bool *res)
>  {
> @@ -335,30 +343,52 @@ int kstrtobool(const char *s, bool *res)
>  		return -EINVAL;
>  
>  	switch (s[0]) {
> +	case 't':
> +	case 'T':
> +		if (!s[1] || !strcasecmp(s, "true"))
> +			goto have_true;
> +
> +		break;
> +
>  	case 'y':
>  	case 'Y':
> +		if (!s[1] || !strcasecmp(s, "yes"))
> +			goto have_true;
> +
> +		break;
> +
>  	case '1':
> +have_true:
>  		*res = true;
>  		return 0;
> +
> +	case 'f':
> +	case 'F':
> +		if (!s[1] || !strcasecmp(s, "false"))
> +			goto have_false;
> +
> +		break;
>  	case 'n':
>  	case 'N':
> +		if (!s[1] || !strcasecmp(s, "no"))
> +			goto have_false;
> +
> +		break;
>  	case '0':
> +have_false:
>  		*res = false;
>  		return 0;
> +
>  	case 'o':
>  	case 'O':
> -		switch (s[1]) {
> -		case 'n':
> -		case 'N':
> -			*res = true;
> -			return 0;
> -		case 'f':
> -		case 'F':
> -			*res = false;
> -			return 0;
> -		default:
> -			break;
> -		}
> +		if (!strcasecmp(s, "on"))
> +			goto have_true;
> +
> +		if (!strcasecmp(s, "off"))
> +			goto have_false;
> +
> +		break;
> +
>  	default:
>  		break;
>  	}

