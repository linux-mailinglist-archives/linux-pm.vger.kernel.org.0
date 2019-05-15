Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1271FD7C
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 03:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEPBqW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 May 2019 21:46:22 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:49734 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfEOXkn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 19:40:43 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x4FNeUEF017088
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 May 2019 08:40:30 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4FNeUqA023708;
        Thu, 16 May 2019 08:40:30 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4FNeF9S014206;
        Thu, 16 May 2019 08:40:30 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-422821; Thu, 16 May 2019 08:39:41 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Thu,
 16 May 2019 08:39:40 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     "prarit@redhat.com" <prarit@redhat.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] x86/turbostat: Dynamically increase output buffer
Thread-Topic: [PATCH] x86/turbostat: Dynamically increase output buffer
Thread-Index: AQHVC3d2VRFpY96g80aQIaN9QE9VcQ==
Date:   Wed, 15 May 2019 23:39:40 +0000
Message-ID: <20190515233949.GA4369@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20190515170227.21673-1-prarit@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <49B3319639CA4348A58859C7A7316AE0@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prarit,

> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index c7727be9719f..12c6be991968 100644
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
> +	char *new_output_buffer;
> +
> +	va_start(argptr, fmt);
> +	va_copy(argptr2, argptr);
> +	curr_buf_size += vsnprintf(NULL, 0, fmt, argptr2);
> +	if (curr_buf_size >= output_buffer_size) {
> +		/* increase the output buffer size by 1024 */
> +		output_buffer_size += 1024;
> +		new_output_buffer = calloc(1, output_buffer_size);
> +		if (!new_output_buffer)
> +			err(-1, "calloc new output buffer");
> +		strncpy(new_output_buffer, output_buffer,
> +			(int)(outp - output_buffer));

You allocate a new buffer and copy data unconditionally in every buffer
extension, which looks to me slow/inefficient.
Why don't you using realloc() as done in my previous patch
(https://lkml.org/lkml/2019/4/18/1330)?
realloc() internally relocates the buffer if necessary (i.e. overlapping
is detected).
If you are worry about zeroing of the extended region, you may add memset().

> +		outp = new_output_buffer + (outp - output_buffer);
> +		free(output_buffer);
> +		output_buffer = new_output_buffer;
> +	}
> +	outp += vsprintf(outp, fmt, argptr);
> +	va_end(argptr);
> +}
>  
>  void print_header(char *delim)
>  {
> @@ -632,173 +659,173 @@ void print_header(char *delim)
...
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
> +		output("pc10: %016llX\n", p->pc10);

You can remove the duplicate line.

Thanks,
Naoya Horiguchi
