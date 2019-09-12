Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF129B0BFC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 11:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfILJzT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 05:55:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730428AbfILJzT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Sep 2019 05:55:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7EDCB67E;
        Thu, 12 Sep 2019 09:55:17 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        shuah@kernel.org, Thomas Renninger <trenn@suse.com>
Subject: Re: [PATCH] cpupower : Handle set and info subcommands for powerpc
Date:   Thu, 12 Sep 2019 11:54:08 +0200
Message-ID: <12087195.kFesu4gPPu@skinner.arch.suse.de>
In-Reply-To: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
References: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abishek,

On Wednesday, September 11, 2019 11:54:24 AM CEST Abhishek Goel wrote:
> Cpupower tool has set and info options which are not being used by
> POWER machines. For powerpc, we will return directly for these two
> subcommands. This removes the ambiguous error message while using set
> option in case of power systems.
> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>  tools/power/cpupower/utils/cpupower-info.c | 5 +++++
>  tools/power/cpupower/utils/cpupower-set.c  | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-info.c
> b/tools/power/cpupower/utils/cpupower-info.c index
> 4c9d342b70ff..674b707a76af 100644
> --- a/tools/power/cpupower/utils/cpupower-info.c
> +++ b/tools/power/cpupower/utils/cpupower-info.c
> @@ -39,6 +39,11 @@ int cmd_info(int argc, char **argv)
>  	} params = {};
>  	int ret = 0;
> 
> +	#ifdef __powerpc__
> +	printf(_("Cannot read info as system does not support performance bias
> setting\n")); +	return 0;
> +	#endif
> +
Please do no do this.

cpupower info
is designed to show general information related to powersaving features of your CPU.

For examle there has been (see changelog):
cpupower: Remove mc and smt power aware scheduler info/settings
These kernel interfaces got removed by:

Unfortunately only -b (perf bias on Intel only) is left right now.

So if you cut this out for Power you do not see anything and the cmd is useless.
Which is a pity, but for now makes sense.
Ideally you provide some tag/option which makes sense on power (e.g. whether run
in OPAL mode and if provide some figures otherwise tell running in VM mode).

But if this is cut out something like this should do the same and is more flexible:
- Still allows additional cpupower info features for other CPUs later easily
- Should also cover AMD or other non-perf bias supporting CPUs to exclude perf_bias
  setting/info

If this one works for you, can you please re-submit with also handling the set cmd
similar. If it works or you only slightly adjust, feel free to already add:
Acked-by: Thomas Renninger <trenn@suse.de>

Thanks!

       Thomas

--- tools/power/cpupower/utils/cpupower-info.c.orig	2019-09-12 11:45:02.578568335 +0200
+++ tools/power/cpupower/utils/cpupower-info.c	2019-09-12 11:46:09.618571947 +0200
@@ -55,8 +55,11 @@
 		}
 	};
 
-	if (!params.params)
+	if (!params.params) {
 		params.params = 0x7;
+		if !(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS)
+			params.perf_bias = 0;
+	}
 
 	/* Default is: show output of CPU 0 only */
 	if (bitmask_isallclear(cpus_chosen))



