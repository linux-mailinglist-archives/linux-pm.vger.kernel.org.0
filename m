Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1E20663
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEPLxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 07:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19201 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfEPLxX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 07:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C055305B418;
        Thu, 16 May 2019 11:53:23 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5742600C4;
        Thu, 16 May 2019 11:53:22 +0000 (UTC)
Subject: Re: [PATCH] x86/turbostat: Dynamically increase output buffer
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20190515233949.GA4369@hori.linux.bs1.fc.nec.co.jp>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <c9d381c9-6db4-326d-ceba-ebc5baca36cd@redhat.com>
Date:   Thu, 16 May 2019 07:53:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515233949.GA4369@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 16 May 2019 11:53:23 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/15/19 7:39 PM, Naoya Horiguchi wrote:
> Hi Prarit,
> 
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index c7727be9719f..12c6be991968 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -625,6 +625,33 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
>>  	return retval;
>>  }
>>  
>> +static int curr_buf_size;
>> +static int output_buffer_size;
>> +
>> +void output(char *fmt, ...)
>> +{
>> +	va_list argptr;
>> +	va_list argptr2;
>> +	char *new_output_buffer;
>> +
>> +	va_start(argptr, fmt);
>> +	va_copy(argptr2, argptr);
>> +	curr_buf_size += vsnprintf(NULL, 0, fmt, argptr2);
>> +	if (curr_buf_size >= output_buffer_size) {
>> +		/* increase the output buffer size by 1024 */
>> +		output_buffer_size += 1024;
>> +		new_output_buffer = calloc(1, output_buffer_size);
>> +		if (!new_output_buffer)
>> +			err(-1, "calloc new output buffer");
>> +		strncpy(new_output_buffer, output_buffer,
>> +			(int)(outp - output_buffer));
> 
> You allocate a new buffer and copy data unconditionally in every buffer
> extension, which looks to me slow/inefficient.
> Why don't you using realloc() as done in my previous patch
> (https://lkml.org/lkml/2019/4/18/1330)?

Oh, I didn't see your patch.  Has Len commented on it?

> realloc() internally relocates the buffer if necessary (i.e. overlapping
> is detected).> If you are worry about zeroing of the extended region, you may add memset().

How about this?  Why don't I add the memset, remove the extra line below, and
use your append_to_output_buffer(), but rename it to just output()?

I'll add a Signed-off-by: from you and resubmit?  Are you okay with that?

P.

> 
>> +		outp = new_output_buffer + (outp - output_buffer);
>> +		free(output_buffer);
>> +		output_buffer = new_output_buffer;
>> +	}
>> +	outp += vsprintf(outp, fmt, argptr);
>> +	va_end(argptr);
>> +}
>>  
>>  void print_header(char *delim)
>>  {
>> @@ -632,173 +659,173 @@ void print_header(char *delim)
> ...
>>  		if (DO_BIC(BIC_Pkgpc6))
>> -			outp += sprintf(outp, "pc6: %016llX\n", p->pc6);
>> +			output("pc6: %016llX\n", p->pc6);
>>  		if (DO_BIC(BIC_Pkgpc7))
>> -			outp += sprintf(outp, "pc7: %016llX\n", p->pc7);
>> -		outp += sprintf(outp, "pc8: %016llX\n", p->pc8);
>> -		outp += sprintf(outp, "pc9: %016llX\n", p->pc9);
>> -		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
>> -		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
>> -		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
>> -		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
>> -		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
>> -		outp += sprintf(outp, "Joules COR: %0X\n", p->energy_cores);
>> -		outp += sprintf(outp, "Joules GFX: %0X\n", p->energy_gfx);
>> -		outp += sprintf(outp, "Joules RAM: %0X\n", p->energy_dram);
>> -		outp += sprintf(outp, "Throttle PKG: %0X\n",
>> +			output("pc7: %016llX\n", p->pc7);
>> +		output("pc8: %016llX\n", p->pc8);
>> +		output("pc9: %016llX\n", p->pc9);
>> +		output("pc10: %016llX\n", p->pc10);
>> +		output("pc10: %016llX\n", p->pc10);
> 
> You can remove the duplicate line.
> 
> Thanks,
> Naoya Horiguchi
> 
