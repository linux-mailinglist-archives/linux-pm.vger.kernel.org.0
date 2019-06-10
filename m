Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC33AD7A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 05:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbfFJDOq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 9 Jun 2019 23:14:46 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:47244 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfFJDOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jun 2019 23:14:46 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x5A3ES3v025320
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jun 2019 12:14:28 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5A3ESX2013887;
        Mon, 10 Jun 2019 12:14:28 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5A3DBGX022181;
        Mon, 10 Jun 2019 12:14:28 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-1144291; Mon, 10 Jun 2019 12:14:07 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Mon,
 10 Jun 2019 12:14:07 +0900
From:   Kosuke Tatsukawa <tatsu@ab.jp.nec.com>
To:     Prarit Bhargava <prarit@redhat.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] turbostat: Fix Haswell Core systems 
Thread-Topic: [PATCH] turbostat: Fix Haswell Core systems 
Thread-Index: AdUfOpCHielU6xFoSDOKwDdYkf3/KQ==
Date:   Mon, 10 Jun 2019 03:14:07 +0000
Message-ID: <17EC94B0A072C34B8DCF0D30AD16044A02A66DD0@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <20190605135830.23941-1-prarit@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.78]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

> On Haswell (model 0x3C) turbostat fails with
>
> turbostat: cpu0: msr offset 0x630 read failed: Input/output error
>
> because Haswell Core does not have C8-C10.
>
> Output C8-C10 only on Haswell ULT.

has_hsw_msrs() uses the model number returned by intel_model_duplicates(),
but commit f5a4c76ad7de added code to return INTEL_FAM6_HASWELL_CORE for
INTEL_FAM6_HASWELL_ULT there.  So I think Haswell UTL also doesn't
output C8-C10 with your patch.

Something similar to the below patch is needed to differentiate between
INTEL_FAM6_HASWELL_CORE and INTEL_FAM6_HASWELL_ULT.  I don't have a
Haswell-ULT machine, so I've only tested it on a Haswell-DT CPU.

Best regards.

> Fixes: f5a4c76ad7de ("tools/power turbostat: consolidate duplicate model
> numbers")
> Cc: Len Brown <len.brown@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index c7727be9719f..ec8797005731 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -4296,7 +4296,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
> 		return 0;
> 
> 	switch (model) {
> -	case INTEL_FAM6_HASWELL_CORE:
> +	case INTEL_FAM6_HASWELL_ULT:
> 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
> 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
> 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
> -- 
> 2.21.0


diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb..5830552 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3209,6 +3209,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		break;
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -3405,6 +3406,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -3841,6 +3843,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -4032,6 +4035,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
@@ -4251,6 +4255,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -4284,7 +4289,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
@@ -4568,9 +4573,6 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_XEON_PHI_KNM:
 		return INTEL_FAM6_XEON_PHI_KNL;
 
-	case INTEL_FAM6_HASWELL_ULT:
-		return INTEL_FAM6_HASWELL_CORE;
-
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;

