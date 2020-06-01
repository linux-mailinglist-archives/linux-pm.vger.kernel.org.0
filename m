Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7DC1EA854
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 19:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFARSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 13:18:08 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:37802 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgFARSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 13:18:08 -0400
Received: from [10.0.2.15] ([93.22.149.119])
        by mwinf5d64 with ME
        id ltHv220022aoEEt03tJ3C9; Mon, 01 Jun 2020 19:18:06 +0200
X-ME-Helo: [10.0.2.15]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Jun 2020 19:18:06 +0200
X-ME-IP: 93.22.149.119
Subject: Re: [PATCH] kernel: power: swap: mark a function as __init to save
 some memory
To:     Joe Perches <joe@perches.com>, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, Dan Carpenter <error27@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
 <effe3cde7b1f188427c42c476f5a96251d837416.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <71346705-6882-d2ca-3c53-1a5b23d66bbf@wanadoo.fr>
Date:   Mon, 1 Jun 2020 19:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <effe3cde7b1f188427c42c476f5a96251d837416.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le 01/06/2020 à 00:11, Joe Perches a écrit :
> (adding Dan Carpenter)
> 
> On Sun, 2020-05-31 at 23:00 +0200, Christophe JAILLET wrote:
>> 'swsusp_header_init()' is only called via 'core_initcall'.
>> It can be marked as __init to save a few bytes of memory.
> 
> Hey Dan
> 
> smatch has a full function calling tree right?
> 
> Can smatch find unmarked functions called only by __init
> functions so those unmarked functions can be appropriately
> marked with __init like the below?
> 

Hi, in case of interest for anyone, I actually find such things as follow:
    - grep to spot xxx_initcall macro (see comments in the perl script 
below)
    - a perl script which tries to spot missing __init

The false positive rate is low.
Feel free to use and propose patches based on it.

CJ

________________________________________________
#!/usr/bin/perl

use warnings;
use strict;

# grep -r --include=*.c -E 
'^[[:space:]]*(early|core|postcore|arch|subsys|fs|device|late)_initcall\(.*\)' 
* > tmp.txt
my $tmp="tmp.txt";

open(my $fh, "<", $tmp);
while (my $line = <$fh>) {
         # Each line looks like:
         #      net/mac80211/main.c:subsys_initcall(ieee80211_init);
         if ($line =~ /^(.*):.*\((.*)\)/) {
             system("grep -E '$2\\(void' $1 | grep -v -E '__.*init'");
         }
}
close($fh)


>> ---
>>   kernel/power/swap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index ca0fcb5ced71..01e2858b5fe3 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -1590,7 +1590,7 @@ int swsusp_unmark(void)
>>   }
>>   #endif
>>   
>> -static int swsusp_header_init(void)
>> +static int __init swsusp_header_init(void)
>>   {
>>   	swsusp_header = (struct swsusp_header*) __get_free_page(GFP_KERNEL);
>>   	if (!swsusp_header)
> 
> 

