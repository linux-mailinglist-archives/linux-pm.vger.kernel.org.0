Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4167319B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGXO2i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 10:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXO2i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jul 2019 10:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 902B5308421A;
        Wed, 24 Jul 2019 14:28:37 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A110910190A8;
        Wed, 24 Jul 2019 14:28:36 +0000 (UTC)
Subject: Re: [PATCH v2] x86/turbostat: Dynamically increase output buffer
To:     linux-pm@vger.kernel.org
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20190517114548.16280-1-prarit@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <2c411734-ac0e-5f96-ab5d-ae16e6e7336a@redhat.com>
Date:   Wed, 24 Jul 2019 10:28:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190517114548.16280-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 24 Jul 2019 14:28:37 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Len?  Rafael?

P.

On 5/17/19 7:45 AM, Prarit Bhargava wrote:
> 'turbostat -D' fails on INTEL_FAM6_KABYLAKE_DESKTOP systems with a
> segfault because the default buffer size is too small.
> 
> Implement an output function that dynamically increases the output buffer
> size.
> 
> v2: Naoya, use realloc & memset instead of copying data & remove extra pc10
> line
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 401 ++++++++++++++------------
>  1 file changed, 214 insertions(+), 187 deletions(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index c7727be9719f..c38044a19081 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -625,6 +625,33 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
>  	return retval;
>  }
>  
> +static int curr_buf_size;
> +static int output_buffer_size;
> +
> +void output(char *fmt, ...)
> +{
> +	va_list argptr;
> +	va_list argptr2;
> +	int output_offset;
> +
> +	va_start(argptr, fmt);
> +	va_copy(argptr2, argptr);
> +	curr_buf_size += vsnprintf(NULL, 0, fmt, argptr2);
> +	if (curr_buf_size >= output_buffer_size) {
> +		/* increase the output buffer size by 1024 */
> +		output_buffer_size += 1024;
> +		output_offset = (int)(outp - output_buffer);
> +		output_buffer = realloc(output_buffer, output_buffer_size);
> +		if (output_buffer == NULL)
> +			err(-1, "realloc output buffer");
> +		if (debug)
> +			printf("Output buffer was extended.\n");
> +		outp = output_buffer + output_offset;
> +		memset(outp, 0, (output_buffer + output_buffer_size) - outp);
> +	}
> +	outp += vsprintf(outp, fmt, argptr);
> +	va_end(argptr);
> +}
>  
>  void print_header(char *delim)
>  {
> @@ -632,173 +659,173 @@ void print_header(char *delim)
>  	int printed = 0;
>  
>  	if (DO_BIC(BIC_USEC))
> -		outp += sprintf(outp, "%susec", (printed++ ? delim : ""));
> +		output("%susec", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_TOD))
> -		outp += sprintf(outp, "%sTime_Of_Day_Seconds", (printed++ ? delim : ""));
> +		output("%sTime_Of_Day_Seconds", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Package))
> -		outp += sprintf(outp, "%sPackage", (printed++ ? delim : ""));
> +		output("%sPackage", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Die))
> -		outp += sprintf(outp, "%sDie", (printed++ ? delim : ""));
> +		output("%sDie", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Node))
> -		outp += sprintf(outp, "%sNode", (printed++ ? delim : ""));
> +		output("%sNode", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Core))
> -		outp += sprintf(outp, "%sCore", (printed++ ? delim : ""));
> +		output("%sCore", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_CPU))
> -		outp += sprintf(outp, "%sCPU", (printed++ ? delim : ""));
> +		output("%sCPU", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_APIC))
> -		outp += sprintf(outp, "%sAPIC", (printed++ ? delim : ""));
> +		output("%sAPIC", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_X2APIC))
> -		outp += sprintf(outp, "%sX2APIC", (printed++ ? delim : ""));
> +		output("%sX2APIC", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Avg_MHz))
> -		outp += sprintf(outp, "%sAvg_MHz", (printed++ ? delim : ""));
> +		output("%sAvg_MHz", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Busy))
> -		outp += sprintf(outp, "%sBusy%%", (printed++ ? delim : ""));
> +		output("%sBusy%%", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Bzy_MHz))
> -		outp += sprintf(outp, "%sBzy_MHz", (printed++ ? delim : ""));
> +		output("%sBzy_MHz", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_TSC_MHz))
> -		outp += sprintf(outp, "%sTSC_MHz", (printed++ ? delim : ""));
> +		output("%sTSC_MHz", (printed++ ? delim : ""));
>  
>  	if (DO_BIC(BIC_IRQ)) {
>  		if (sums_need_wide_columns)
> -			outp += sprintf(outp, "%s     IRQ", (printed++ ? delim : ""));
> +			output("%s     IRQ", (printed++ ? delim : ""));
>  		else
> -			outp += sprintf(outp, "%sIRQ", (printed++ ? delim : ""));
> +			output("%sIRQ", (printed++ ? delim : ""));
>  	}
>  
>  	if (DO_BIC(BIC_SMI))
> -		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
> +		output("%sSMI", (printed++ ? delim : ""));
>  
>  	for (mp = sys.tp; mp; mp = mp->next) {
>  
>  		if (mp->format == FORMAT_RAW) {
>  			if (mp->width == 64)
> -				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), mp->name);
> +				output("%s%18.18s", (printed++ ? delim : ""), mp->name);
>  			else
> -				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), mp->name);
> +				output("%s%10.10s", (printed++ ? delim : ""), mp->name);
>  		} else {
>  			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
> -				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), mp->name);
> +				output("%s%8s", (printed++ ? delim : ""), mp->name);
>  			else
> -				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), mp->name);
> +				output("%s%s", (printed++ ? delim : ""), mp->name);
>  		}
>  	}
>  
>  	if (DO_BIC(BIC_CPU_c1))
> -		outp += sprintf(outp, "%sCPU%%c1", (printed++ ? delim : ""));
> +		output("%sCPU%%c1", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_CPU_c3))
> -		outp += sprintf(outp, "%sCPU%%c3", (printed++ ? delim : ""));
> +		output("%sCPU%%c3", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_CPU_c6))
> -		outp += sprintf(outp, "%sCPU%%c6", (printed++ ? delim : ""));
> +		output("%sCPU%%c6", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_CPU_c7))
> -		outp += sprintf(outp, "%sCPU%%c7", (printed++ ? delim : ""));
> +		output("%sCPU%%c7", (printed++ ? delim : ""));
>  
>  	if (DO_BIC(BIC_Mod_c6))
> -		outp += sprintf(outp, "%sMod%%c6", (printed++ ? delim : ""));
> +		output("%sMod%%c6", (printed++ ? delim : ""));
>  
>  	if (DO_BIC(BIC_CoreTmp))
> -		outp += sprintf(outp, "%sCoreTmp", (printed++ ? delim : ""));
> +		output("%sCoreTmp", (printed++ ? delim : ""));
>  
>  	if (do_rapl && !rapl_joules) {
>  		if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
> -			outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
> +			output("%sCorWatt", (printed++ ? delim : ""));
>  	} else if (do_rapl && rapl_joules) {
>  		if (DO_BIC(BIC_Cor_J) && (do_rapl & RAPL_PER_CORE_ENERGY))
> -			outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
> +			output("%sCor_J", (printed++ ? delim : ""));
>  	}
>  
>  	for (mp = sys.cp; mp; mp = mp->next) {
>  		if (mp->format == FORMAT_RAW) {
>  			if (mp->width == 64)
> -				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
> +				output("%s%18.18s", delim, mp->name);
>  			else
> -				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
> +				output("%s%10.10s", delim, mp->name);
>  		} else {
>  			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
> -				outp += sprintf(outp, "%s%8s", delim, mp->name);
> +				output("%s%8s", delim, mp->name);
>  			else
> -				outp += sprintf(outp, "%s%s", delim, mp->name);
> +				output("%s%s", delim, mp->name);
>  		}
>  	}
>  
>  	if (DO_BIC(BIC_PkgTmp))
> -		outp += sprintf(outp, "%sPkgTmp", (printed++ ? delim : ""));
> +		output("%sPkgTmp", (printed++ ? delim : ""));
>  
>  	if (DO_BIC(BIC_GFX_rc6))
> -		outp += sprintf(outp, "%sGFX%%rc6", (printed++ ? delim : ""));
> +		output("%sGFX%%rc6", (printed++ ? delim : ""));
>  
>  	if (DO_BIC(BIC_GFXMHz))
> -		outp += sprintf(outp, "%sGFXMHz", (printed++ ? delim : ""));
> +		output("%sGFXMHz", (printed++ ? delim : ""));
>  
>  	if (DO_BIC(BIC_Totl_c0))
> -		outp += sprintf(outp, "%sTotl%%C0", (printed++ ? delim : ""));
> +		output("%sTotl%%C0", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Any_c0))
> -		outp += sprintf(outp, "%sAny%%C0", (printed++ ? delim : ""));
> +		output("%sAny%%C0", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_GFX_c0))
> -		outp += sprintf(outp, "%sGFX%%C0", (printed++ ? delim : ""));
> +		output("%sGFX%%C0", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_CPUGFX))
> -		outp += sprintf(outp, "%sCPUGFX%%", (printed++ ? delim : ""));
> +		output("%sCPUGFX%%", (printed++ ? delim : ""));
>  
>  	if (DO_BIC(BIC_Pkgpc2))
> -		outp += sprintf(outp, "%sPkg%%pc2", (printed++ ? delim : ""));
> +		output("%sPkg%%pc2", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Pkgpc3))
> -		outp += sprintf(outp, "%sPkg%%pc3", (printed++ ? delim : ""));
> +		output("%sPkg%%pc3", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Pkgpc6))
> -		outp += sprintf(outp, "%sPkg%%pc6", (printed++ ? delim : ""));
> +		output("%sPkg%%pc6", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Pkgpc7))
> -		outp += sprintf(outp, "%sPkg%%pc7", (printed++ ? delim : ""));
> +		output("%sPkg%%pc7", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Pkgpc8))
> -		outp += sprintf(outp, "%sPkg%%pc8", (printed++ ? delim : ""));
> +		output("%sPkg%%pc8", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Pkgpc9))
> -		outp += sprintf(outp, "%sPkg%%pc9", (printed++ ? delim : ""));
> +		output("%sPkg%%pc9", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_Pkgpc10))
> -		outp += sprintf(outp, "%sPk%%pc10", (printed++ ? delim : ""));
> +		output("%sPk%%pc10", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_CPU_LPI))
> -		outp += sprintf(outp, "%sCPU%%LPI", (printed++ ? delim : ""));
> +		output("%sCPU%%LPI", (printed++ ? delim : ""));
>  	if (DO_BIC(BIC_SYS_LPI))
> -		outp += sprintf(outp, "%sSYS%%LPI", (printed++ ? delim : ""));
> +		output("%sSYS%%LPI", (printed++ ? delim : ""));
>  
>  	if (do_rapl && !rapl_joules) {
>  		if (DO_BIC(BIC_PkgWatt))
> -			outp += sprintf(outp, "%sPkgWatt", (printed++ ? delim : ""));
> +			output("%sPkgWatt", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
> -			outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
> +			output("%sCorWatt", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_GFXWatt))
> -			outp += sprintf(outp, "%sGFXWatt", (printed++ ? delim : ""));
> +			output("%sGFXWatt", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_RAMWatt))
> -			outp += sprintf(outp, "%sRAMWatt", (printed++ ? delim : ""));
> +			output("%sRAMWatt", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_PKG__))
> -			outp += sprintf(outp, "%sPKG_%%", (printed++ ? delim : ""));
> +			output("%sPKG_%%", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_RAM__))
> -			outp += sprintf(outp, "%sRAM_%%", (printed++ ? delim : ""));
> +			output("%sRAM_%%", (printed++ ? delim : ""));
>  	} else if (do_rapl && rapl_joules) {
>  		if (DO_BIC(BIC_Pkg_J))
> -			outp += sprintf(outp, "%sPkg_J", (printed++ ? delim : ""));
> +			output("%sPkg_J", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_Cor_J) && !(do_rapl & RAPL_PER_CORE_ENERGY))
> -			outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
> +			output("%sCor_J", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_GFX_J))
> -			outp += sprintf(outp, "%sGFX_J", (printed++ ? delim : ""));
> +			output("%sGFX_J", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_RAM_J))
> -			outp += sprintf(outp, "%sRAM_J", (printed++ ? delim : ""));
> +			output("%sRAM_J", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_PKG__))
> -			outp += sprintf(outp, "%sPKG_%%", (printed++ ? delim : ""));
> +			output("%sPKG_%%", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_RAM__))
> -			outp += sprintf(outp, "%sRAM_%%", (printed++ ? delim : ""));
> +			output("%sRAM_%%", (printed++ ? delim : ""));
>  	}
>  	for (mp = sys.pp; mp; mp = mp->next) {
>  		if (mp->format == FORMAT_RAW) {
>  			if (mp->width == 64)
> -				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
> +				output("%s%18.18s", delim, mp->name);
>  			else
> -				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
> +				output("%s%10.10s", delim, mp->name);
>  		} else {
>  			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
> -				outp += sprintf(outp, "%s%8s", delim, mp->name);
> +				output("%s%8s", delim, mp->name);
>  			else
> -				outp += sprintf(outp, "%s%s", delim, mp->name);
> +				output("%s%s", delim, mp->name);
>  		}
>  	}
>  
> -	outp += sprintf(outp, "\n");
> +	output("\n");
>  }
>  
>  int dump_counters(struct thread_data *t, struct core_data *c,
> @@ -807,80 +834,79 @@ int dump_counters(struct thread_data *t, struct core_data *c,
>  	int i;
>  	struct msr_counter *mp;
>  
> -	outp += sprintf(outp, "t %p, c %p, p %p\n", t, c, p);
> +	output("t %p, c %p, p %p\n", t, c, p);
>  
>  	if (t) {
> -		outp += sprintf(outp, "CPU: %d flags 0x%x\n",
> +		output("CPU: %d flags 0x%x\n",
>  			t->cpu_id, t->flags);
> -		outp += sprintf(outp, "TSC: %016llX\n", t->tsc);
> -		outp += sprintf(outp, "aperf: %016llX\n", t->aperf);
> -		outp += sprintf(outp, "mperf: %016llX\n", t->mperf);
> -		outp += sprintf(outp, "c1: %016llX\n", t->c1);
> +		output("TSC: %016llX\n", t->tsc);
> +		output("aperf: %016llX\n", t->aperf);
> +		output("mperf: %016llX\n", t->mperf);
> +		output("c1: %016llX\n", t->c1);
>  
>  		if (DO_BIC(BIC_IRQ))
> -			outp += sprintf(outp, "IRQ: %lld\n", t->irq_count);
> +			output("IRQ: %lld\n", t->irq_count);
>  		if (DO_BIC(BIC_SMI))
> -			outp += sprintf(outp, "SMI: %d\n", t->smi_count);
> +			output("SMI: %d\n", t->smi_count);
>  
>  		for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
> -			outp += sprintf(outp, "tADDED [%d] msr0x%x: %08llX\n",
> +			output("tADDED [%d] msr0x%x: %08llX\n",
>  				i, mp->msr_num, t->counter[i]);
>  		}
>  	}
>  
>  	if (c) {
> -		outp += sprintf(outp, "core: %d\n", c->core_id);
> -		outp += sprintf(outp, "c3: %016llX\n", c->c3);
> -		outp += sprintf(outp, "c6: %016llX\n", c->c6);
> -		outp += sprintf(outp, "c7: %016llX\n", c->c7);
> -		outp += sprintf(outp, "DTS: %dC\n", c->core_temp_c);
> -		outp += sprintf(outp, "Joules: %0X\n", c->core_energy);
> +		output("core: %d\n", c->core_id);
> +		output("c3: %016llX\n", c->c3);
> +		output("c6: %016llX\n", c->c6);
> +		output("c7: %016llX\n", c->c7);
> +		output("DTS: %dC\n", c->core_temp_c);
> +		output("Joules: %0X\n", c->core_energy);
>  
>  		for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
> -			outp += sprintf(outp, "cADDED [%d] msr0x%x: %08llX\n",
> +			output("cADDED [%d] msr0x%x: %08llX\n",
>  				i, mp->msr_num, c->counter[i]);
>  		}
> -		outp += sprintf(outp, "mc6_us: %016llX\n", c->mc6_us);
> +		output("mc6_us: %016llX\n", c->mc6_us);
>  	}
>  
>  	if (p) {
> -		outp += sprintf(outp, "package: %d\n", p->package_id);
> +		output("package: %d\n", p->package_id);
>  
> -		outp += sprintf(outp, "Weighted cores: %016llX\n", p->pkg_wtd_core_c0);
> -		outp += sprintf(outp, "Any cores: %016llX\n", p->pkg_any_core_c0);
> -		outp += sprintf(outp, "Any GFX: %016llX\n", p->pkg_any_gfxe_c0);
> -		outp += sprintf(outp, "CPU + GFX: %016llX\n", p->pkg_both_core_gfxe_c0);
> +		output("Weighted cores: %016llX\n", p->pkg_wtd_core_c0);
> +		output("Any cores: %016llX\n", p->pkg_any_core_c0);
> +		output("Any GFX: %016llX\n", p->pkg_any_gfxe_c0);
> +		output("CPU + GFX: %016llX\n", p->pkg_both_core_gfxe_c0);
>  
> -		outp += sprintf(outp, "pc2: %016llX\n", p->pc2);
> +		output("pc2: %016llX\n", p->pc2);
>  		if (DO_BIC(BIC_Pkgpc3))
> -			outp += sprintf(outp, "pc3: %016llX\n", p->pc3);
> +			output("pc3: %016llX\n", p->pc3);
>  		if (DO_BIC(BIC_Pkgpc6))
> -			outp += sprintf(outp, "pc6: %016llX\n", p->pc6);
> +			output("pc6: %016llX\n", p->pc6);
>  		if (DO_BIC(BIC_Pkgpc7))
> -			outp += sprintf(outp, "pc7: %016llX\n", p->pc7);
> -		outp += sprintf(outp, "pc8: %016llX\n", p->pc8);
> -		outp += sprintf(outp, "pc9: %016llX\n", p->pc9);
> -		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
> -		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
> -		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
> -		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
> -		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
> -		outp += sprintf(outp, "Joules COR: %0X\n", p->energy_cores);
> -		outp += sprintf(outp, "Joules GFX: %0X\n", p->energy_gfx);
> -		outp += sprintf(outp, "Joules RAM: %0X\n", p->energy_dram);
> -		outp += sprintf(outp, "Throttle PKG: %0X\n",
> +			output("pc7: %016llX\n", p->pc7);
> +		output("pc8: %016llX\n", p->pc8);
> +		output("pc9: %016llX\n", p->pc9);
> +		output("pc10: %016llX\n", p->pc10);
> +		output("cpu_lpi: %016llX\n", p->cpu_lpi);
> +		output("sys_lpi: %016llX\n", p->sys_lpi);
> +		output("Joules PKG: %0X\n", p->energy_pkg);
> +		output("Joules COR: %0X\n", p->energy_cores);
> +		output("Joules GFX: %0X\n", p->energy_gfx);
> +		output("Joules RAM: %0X\n", p->energy_dram);
> +		output("Throttle PKG: %0X\n",
>  			p->rapl_pkg_perf_status);
> -		outp += sprintf(outp, "Throttle RAM: %0X\n",
> +		output("Throttle RAM: %0X\n",
>  			p->rapl_dram_perf_status);
> -		outp += sprintf(outp, "PTM: %dC\n", p->pkg_temp_c);
> +		output("PTM: %dC\n", p->pkg_temp_c);
>  
>  		for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
> -			outp += sprintf(outp, "pADDED [%d] msr0x%x: %08llX\n",
> +			output("pADDED [%d] msr0x%x: %08llX\n",
>  				i, mp->msr_num, p->counter[i]);
>  		}
>  	}
>  
> -	outp += sprintf(outp, "\n");
> +	output("\n");
>  
>  	return 0;
>  }
> @@ -916,12 +942,12 @@ int format_counters(struct thread_data *t, struct core_data *c,
>  		struct timeval tv;
>  
>  		timersub(&t->tv_end, &t->tv_begin, &tv);
> -		outp += sprintf(outp, "%5ld\t", tv.tv_sec * 1000000 + tv.tv_usec);
> +		output("%5ld\t", tv.tv_sec * 1000000 + tv.tv_usec);
>  	}
>  
>  	/* Time_Of_Day_Seconds: on each row, print sec.usec last timestamp taken */
>  	if (DO_BIC(BIC_TOD))
> -		outp += sprintf(outp, "%10ld.%06ld\t", t->tv_end.tv_sec, t->tv_end.tv_usec);
> +		output("%10ld.%06ld\t", t->tv_end.tv_sec, t->tv_end.tv_usec);
>  
>  	interval_float = tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;
>  
> @@ -930,108 +956,108 @@ int format_counters(struct thread_data *t, struct core_data *c,
>  	/* topo columns, print blanks on 1st (average) line */
>  	if (t == &average.threads) {
>  		if (DO_BIC(BIC_Package))
> -			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +			output("%s-", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_Die))
> -			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +			output("%s-", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_Node))
> -			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +			output("%s-", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_Core))
> -			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +			output("%s-", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_CPU))
> -			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +			output("%s-", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_APIC))
> -			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +			output("%s-", (printed++ ? delim : ""));
>  		if (DO_BIC(BIC_X2APIC))
> -			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +			output("%s-", (printed++ ? delim : ""));
>  	} else {
>  		if (DO_BIC(BIC_Package)) {
>  			if (p)
> -				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->package_id);
> +				output("%s%d", (printed++ ? delim : ""), p->package_id);
>  			else
> -				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +				output("%s-", (printed++ ? delim : ""));
>  		}
>  		if (DO_BIC(BIC_Die)) {
>  			if (c)
> -				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), cpus[t->cpu_id].die_id);
> +				output("%s%d", (printed++ ? delim : ""), cpus[t->cpu_id].die_id);
>  			else
> -				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +				output("%s-", (printed++ ? delim : ""));
>  		}
>  		if (DO_BIC(BIC_Node)) {
>  			if (t)
> -				outp += sprintf(outp, "%s%d",
> +				output("%s%d",
>  						(printed++ ? delim : ""),
>  					      cpus[t->cpu_id].physical_node_id);
>  			else
> -				outp += sprintf(outp, "%s-",
> +				output("%s-",
>  						(printed++ ? delim : ""));
>  		}
>  		if (DO_BIC(BIC_Core)) {
>  			if (c)
> -				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_id);
> +				output("%s%d", (printed++ ? delim : ""), c->core_id);
>  			else
> -				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
> +				output("%s-", (printed++ ? delim : ""));
>  		}
>  		if (DO_BIC(BIC_CPU))
> -			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->cpu_id);
> +			output("%s%d", (printed++ ? delim : ""), t->cpu_id);
>  		if (DO_BIC(BIC_APIC))
> -			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->apic_id);
> +			output("%s%d", (printed++ ? delim : ""), t->apic_id);
>  		if (DO_BIC(BIC_X2APIC))
> -			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->x2apic_id);
> +			output("%s%d", (printed++ ? delim : ""), t->x2apic_id);
>  	}
>  
>  	if (DO_BIC(BIC_Avg_MHz))
> -		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""),
> +		output("%s%.0f", (printed++ ? delim : ""),
>  			1.0 / units * t->aperf / interval_float);
>  
>  	if (DO_BIC(BIC_Busy))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->mperf/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * t->mperf/tsc);
>  
>  	if (DO_BIC(BIC_Bzy_MHz)) {
>  		if (has_base_hz)
> -			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), base_hz / units * t->aperf / t->mperf);
> +			output("%s%.0f", (printed++ ? delim : ""), base_hz / units * t->aperf / t->mperf);
>  		else
> -			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""),
> +			output("%s%.0f", (printed++ ? delim : ""),
>  				tsc / units * t->aperf / t->mperf / interval_float);
>  	}
>  
>  	if (DO_BIC(BIC_TSC_MHz))
> -		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), 1.0 * t->tsc/units/interval_float);
> +		output("%s%.0f", (printed++ ? delim : ""), 1.0 * t->tsc/units/interval_float);
>  
>  	/* IRQ */
>  	if (DO_BIC(BIC_IRQ)) {
>  		if (sums_need_wide_columns)
> -			outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->irq_count);
> +			output("%s%8lld", (printed++ ? delim : ""), t->irq_count);
>  		else
> -			outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->irq_count);
> +			output("%s%lld", (printed++ ? delim : ""), t->irq_count);
>  	}
>  
>  	/* SMI */
>  	if (DO_BIC(BIC_SMI))
> -		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->smi_count);
> +		output("%s%d", (printed++ ? delim : ""), t->smi_count);
>  
>  	/* Added counters */
>  	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
>  		if (mp->format == FORMAT_RAW) {
>  			if (mp->width == 32)
> -				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) t->counter[i]);
> +				output("%s0x%08x", (printed++ ? delim : ""), (unsigned int) t->counter[i]);
>  			else
> -				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
> +				output("%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
>  		} else if (mp->format == FORMAT_DELTA) {
>  			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
> -				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->counter[i]);
> +				output("%s%8lld", (printed++ ? delim : ""), t->counter[i]);
>  			else
> -				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->counter[i]);
> +				output("%s%lld", (printed++ ? delim : ""), t->counter[i]);
>  		} else if (mp->format == FORMAT_PERCENT) {
>  			if (mp->type == COUNTER_USEC)
> -				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), t->counter[i]/interval_float/10000);
> +				output("%s%.2f", (printed++ ? delim : ""), t->counter[i]/interval_float/10000);
>  			else
> -				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->counter[i]/tsc);
> +				output("%s%.2f", (printed++ ? delim : ""), 100.0 * t->counter[i]/tsc);
>  		}
>  	}
>  
>  	/* C1 */
>  	if (DO_BIC(BIC_CPU_c1))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1/tsc);
>  
>  
>  	/* print per-core data only for 1st thread in core */
> @@ -1039,32 +1065,32 @@ int format_counters(struct thread_data *t, struct core_data *c,
>  		goto done;
>  
>  	if (DO_BIC(BIC_CPU_c3))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c3/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * c->c3/tsc);
>  	if (DO_BIC(BIC_CPU_c6))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c6/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * c->c6/tsc);
>  	if (DO_BIC(BIC_CPU_c7))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c7/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * c->c7/tsc);
>  
>  	/* Mod%c6 */
>  	if (DO_BIC(BIC_Mod_c6))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->mc6_us / tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * c->mc6_us / tsc);
>  
>  	if (DO_BIC(BIC_CoreTmp))
> -		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_temp_c);
> +		output("%s%d", (printed++ ? delim : ""), c->core_temp_c);
>  
>  	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
>  		if (mp->format == FORMAT_RAW) {
>  			if (mp->width == 32)
> -				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) c->counter[i]);
> +				output("%s0x%08x", (printed++ ? delim : ""), (unsigned int) c->counter[i]);
>  			else
> -				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
> +				output("%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
>  		} else if (mp->format == FORMAT_DELTA) {
>  			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
> -				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), c->counter[i]);
> +				output("%s%8lld", (printed++ ? delim : ""), c->counter[i]);
>  			else
> -				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->counter[i]);
> +				output("%s%lld", (printed++ ? delim : ""), c->counter[i]);
>  		} else if (mp->format == FORMAT_PERCENT) {
> -			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->counter[i]/tsc);
> +			output("%s%.2f", (printed++ ? delim : ""), 100.0 * c->counter[i]/tsc);
>  		}
>  	}
>  
> @@ -1078,9 +1104,9 @@ int format_counters(struct thread_data *t, struct core_data *c,
>  		fmt8 = "%6.0f**";
>  
>  	if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units / interval_float);
> +		output(fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units / interval_float);
>  	if (DO_BIC(BIC_Cor_J) && (do_rapl & RAPL_PER_CORE_ENERGY))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units);
> +		output(fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units);
>  
>  	/* print per-package data only for 1st core in package */
>  	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
> @@ -1088,92 +1114,92 @@ int format_counters(struct thread_data *t, struct core_data *c,
>  
>  	/* PkgTmp */
>  	if (DO_BIC(BIC_PkgTmp))
> -		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->pkg_temp_c);
> +		output("%s%d", (printed++ ? delim : ""), p->pkg_temp_c);
>  
>  	/* GFXrc6 */
>  	if (DO_BIC(BIC_GFX_rc6)) {
>  		if (p->gfx_rc6_ms == -1) {	/* detect GFX counter reset */
> -			outp += sprintf(outp, "%s**.**", (printed++ ? delim : ""));
> +			output("%s**.**", (printed++ ? delim : ""));
>  		} else {
> -			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
> +			output("%s%.2f", (printed++ ? delim : ""),
>  				p->gfx_rc6_ms / 10.0 / interval_float);
>  		}
>  	}
>  
>  	/* GFXMHz */
>  	if (DO_BIC(BIC_GFXMHz))
> -		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->gfx_mhz);
> +		output("%s%d", (printed++ ? delim : ""), p->gfx_mhz);
>  
>  	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
>  	if (DO_BIC(BIC_Totl_c0))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0/tsc);
>  	if (DO_BIC(BIC_Any_c0))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_core_c0/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_core_c0/tsc);
>  	if (DO_BIC(BIC_GFX_c0))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_gfxe_c0/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_gfxe_c0/tsc);
>  	if (DO_BIC(BIC_CPUGFX))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_both_core_gfxe_c0/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_both_core_gfxe_c0/tsc);
>  
>  	if (DO_BIC(BIC_Pkgpc2))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc2/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc2/tsc);
>  	if (DO_BIC(BIC_Pkgpc3))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc3/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc3/tsc);
>  	if (DO_BIC(BIC_Pkgpc6))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc6/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc6/tsc);
>  	if (DO_BIC(BIC_Pkgpc7))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc7/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc7/tsc);
>  	if (DO_BIC(BIC_Pkgpc8))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc8/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc8/tsc);
>  	if (DO_BIC(BIC_Pkgpc9))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc9/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc9/tsc);
>  	if (DO_BIC(BIC_Pkgpc10))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10/tsc);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10/tsc);
>  
>  	if (DO_BIC(BIC_CPU_LPI))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->cpu_lpi / 1000000.0 / interval_float);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->cpu_lpi / 1000000.0 / interval_float);
>  	if (DO_BIC(BIC_SYS_LPI))
> -		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->sys_lpi / 1000000.0 / interval_float);
> +		output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->sys_lpi / 1000000.0 / interval_float);
>  
>  	if (DO_BIC(BIC_PkgWatt))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
> +		output(fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
>  	if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
> +		output(fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
>  	if (DO_BIC(BIC_GFXWatt))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units / interval_float);
> +		output(fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units / interval_float);
>  	if (DO_BIC(BIC_RAMWatt))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units / interval_float);
> +		output(fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units / interval_float);
>  	if (DO_BIC(BIC_Pkg_J))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units);
> +		output(fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units);
>  	if (DO_BIC(BIC_Cor_J) && !(do_rapl & RAPL_PER_CORE_ENERGY))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units);
> +		output(fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units);
>  	if (DO_BIC(BIC_GFX_J))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units);
> +		output(fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units);
>  	if (DO_BIC(BIC_RAM_J))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units);
> +		output(fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units);
>  	if (DO_BIC(BIC_PKG__))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
> +		output(fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
>  	if (DO_BIC(BIC_RAM__))
> -		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
> +		output(fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
>  
>  	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
>  		if (mp->format == FORMAT_RAW) {
>  			if (mp->width == 32)
> -				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) p->counter[i]);
> +				output("%s0x%08x", (printed++ ? delim : ""), (unsigned int) p->counter[i]);
>  			else
> -				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->counter[i]);
> +				output("%s0x%016llx", (printed++ ? delim : ""), p->counter[i]);
>  		} else if (mp->format == FORMAT_DELTA) {
>  			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
> -				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), p->counter[i]);
> +				output("%s%8lld", (printed++ ? delim : ""), p->counter[i]);
>  			else
> -				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), p->counter[i]);
> +				output("%s%lld", (printed++ ? delim : ""), p->counter[i]);
>  		} else if (mp->format == FORMAT_PERCENT) {
> -			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->counter[i]/tsc);
> +			output("%s%.2f", (printed++ ? delim : ""), 100.0 * p->counter[i]/tsc);
>  		}
>  	}
>  
>  done:
>  	if (*(outp - 1) != '\n')
> -		outp += sprintf(outp, "\n");
> +		output("\n");
>  
>  	return 0;
>  }
> @@ -5135,7 +5161,8 @@ int initialize_counters(int cpu_id)
>  
>  void allocate_output_buffer()
>  {
> -	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
> +	output_buffer_size = (1 + topo.num_cpus) * 1024;
> +	output_buffer = calloc(1, output_buffer_size);
>  	outp = output_buffer;
>  	if (outp == NULL)
>  		err(-1, "calloc output buffer");
> 
