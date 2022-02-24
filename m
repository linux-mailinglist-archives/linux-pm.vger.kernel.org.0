Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607654C3147
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 17:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiBXQaF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 11:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBXQ37 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 11:29:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE091B1DC2
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 08:29:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gi6so2469671pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=T7PgXtspHRkVZCghybiHkaXnWH3fbQ8rga8QRtJEmw8=;
        b=B2ti53YHjDw0gUmiMlGW/3xlqSOtz0I+UcdKE/ns3nHH9pUAPKJKrNJUEu3MgOqM73
         lsWjpC5ON0v3lbono4wW98tHaNuRjDDFllBdQgrPeczvw12lNuS9+7DM6EEwUqq6PubI
         cdPihTsJNmNoxJsZsc4EF0I7KkSZCE7hvJqTYCHgQNZTJ3jAXpZTMM/USDk1JMQYGNWB
         Tu5HLF4jPQvMn+8LxxAaIEg9yQPsKHyrPo3on+Ht3dWGwgl72l4QmjtDGHweMUfzWRRj
         D9Yc9Rz+2KHGUG+LuuC0t5NR2M+hzG5r1t7xNQeG++iYuHewgbZLsF4N2QpAuw2zf8dd
         Tllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=T7PgXtspHRkVZCghybiHkaXnWH3fbQ8rga8QRtJEmw8=;
        b=I2Ld7eQmN1eKF5+8xfjmDY0tusG7sGz+mERRqbrBMS/rpOluu+Z7BCz7hzq1OtAS6B
         7tIpPJ9H0K0GnoYl9IhWMqWj9aXz3QG7UUWo4tR4Ol2DtGmlRor2P1T5CAFERSArUkal
         nlK2Jy2NwYq3l2U6TgEMudYiUCIm7PVJyGG+OGblaBk8tsRNV18+g+j3dNJYmY2NWmlA
         1VzaT2maYOZHBEwAnrPUpFWLXVocZDVT9KbayN5mXORm8TZTFkOX3+CltTsWTgm8vMik
         /bta2MNSnXv3K/C3RfsXjiMIiV9KOqu/PFBr7HG2/SFrQxrWJzJ9F6olByMKz0tA4ynw
         awTQ==
X-Gm-Message-State: AOAM532gvlNEQMxibfbQA3p94zxLWdGMo/9zIQhnn1shR2DT+wuEJGGS
        xR0APaej8NB1FbBaJUnfTFTNPA==
X-Google-Smtp-Source: ABdhPJxmyWsz8cN2la6vxfYrBDzyMY/JVENtTidix+3gly/weK1/VDNrwyEuBpaA2FP4/nQsvLIITA==
X-Received: by 2002:a17:902:f707:b0:14a:fd51:3b5f with SMTP id h7-20020a170902f70700b0014afd513b5fmr3544426plo.98.1645720165588;
        Thu, 24 Feb 2022 08:29:25 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id on17sm3203862pjb.40.2022.02.24.08.29.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:29:24 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     <paulmck@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'srinivas pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Zhang, Rui'" <rui.zhang@intel.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>, <stable@vger.kernel.org>,
        <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>,
        "'Feng Tang'" <feng.tang@intel.com>
References: <e185b89fb97f47758a5e10239fc3eed0@intel.com> <CAAYoRsXbBJtvJzh91nTXATLL1eb2EKbTVb8vEWa3Y6DfCWhZeg@mail.gmail.com> <aaace653f12b79336b6f986ef5c4f9471445372a.camel@linux.intel.com> <20220222073435.GB78951@shbuild999.sh.intel.com> <CAJZ5v0iXQ=qXiZoF_qb1hdBh=yfZ13-of3y3LFu2m6gZh9peTw@mail.gmail.com> <CAAYoRsX-iw+88R9ZizMwJw2qc99XJZ8Fe0M5ETOy4=RUNsxWhQ@mail.gmail.com> <24f7d485dc60ba3ed5938230f477bf22a220d596.camel@linux.intel.com> <20220223004041.GA4548@shbuild999.sh.intel.com> <CAJZ5v0jsy0q3-ZqYvDrswY1F+tJsG6oNjNJPzz9zzkgdnoMwkw@mail.gmail.com> <20220224080830.GD4548@shbuild999.sh.intel.com> <20220224144423.GV4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220224144423.GV4285@paulmck-ThinkPad-P17-Gen-1>
Subject: RE: CPU excessively long times between frequency scaling driver calls - bisected
Date:   Thu, 24 Feb 2022 08:29:22 -0800
Message-ID: <002901d8299b$af50d6d0$0df28470$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJoYM4LcAz85xHF3s1ly2J0+vMjpQK6V02BAMrH5oYB+Ch6FQG4OsPxAq/kLv0CiDg/5AHRugzUAltSUdoBsNWicwNgeW4nqtUP4XA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2022.02.24 04:08:30 Paul E. McKenney wrote:
> On Thu, Feb 24, 2022 at 04:08:30PM +0800, Feng Tang wrote:
>> On Wed, Feb 23, 2022 at 03:23:20PM +0100, Rafael J. Wysocki wrote:
>>> On Wed, Feb 23, 2022 at 1:40 AM Feng Tang <feng.tang@intel.com> wrote:
>>> 
>>> But this is not related to idle as such, but to the fact that idle
>>> sometimes stops the scheduler tick which otherwise would run the
>>> cpufreq governor callback on a regular basis.
>>> 
>>> It is stopping the tick that gets us into trouble, so I would avoid
>>> doing it if the current performance state is too aggressive.
>> 
>> I've tried to simulate Doug's environment by using his kconfig, and
>> offline my 36 CPUs Desktop to leave 12 CPUs online, and on it I can
>> still see Local timer interrupts when there is no active load, with
>> the longest interval between 2 timer interrupts is 4 seconds, while
>> idle class's task_tick_idle() will do nothing, and CFS'
>> task_tick_fair() will in turn call cfs_rq_util_change()
>
> Every four seconds?  Could you please post your .config?
>
>							Thanx, Paul

I steal the kernel config from the Ubuntu mainline PPA.
See also earlier on this thread:

https://lore.kernel.org/linux-pm/CAAYoRsXkyWf0vmEE2HvjF6pzCC4utxTF=7AFx1PJv4Evh=C+Ow@mail.gmail.com/

but relevant part copied here:

> I steal the kernel configuration file from the Ubuntu mainline PPA
> [1], what they call "lowlatency", or 1000Hz tick. I make these
> changes before compile:
>
> scripts/config --disable DEBUG_INFO
> scripts/config --disable SYSTEM_TRUSTED_KEYS
> scripts/config --disable SYSTEM_REVOCATION_KEYS
>
> I [will] also send you the config and dmesg files in an off-list email.
>
> [1] https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.17-rc3/

I put the same one I sent Feng on my web site where I was
sharing stuff with Srinivas (coded to avoid the barrage of bots):

double u double u double u dot smythies dot com/~doug/linux/s18/hwp/srinivas/long_dur/
 
... Doug


