Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1497A1798EB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 20:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbgCDTXD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 14:23:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54875 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387711AbgCDTXD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 14:23:03 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.55.45])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 024JM4WA436200
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 4 Mar 2020 11:22:05 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 024JM4WA436200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1583349727;
        bh=g6Mtry4glpDMxH5UiOpY16heGYyer5fR7lVfPBWaveE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ar6nn8Ge/T+692bP42wyhN6/gA6zy1dzCiGF74CRXJXFqjrk6VwRkFpBhRP3+cZ6P
         aoecjqhhdSeSkR9EesGi+ThpGixJViS9m59hDZE5MkhJCppsl9CGI+XaXJHL6N9PSz
         N15YsSpDSe2BGbMQ73a5iqbaYgTLZGuuCk9xtQ+bYyE3yGCxvvNHQZ7Xw/jQnA8xUa
         jCODCawM3hNRUyrc1PnA5eoR37ZT81R1OELgMwfxsZpMMFvL9tLT1LJphQQCaZE+6J
         TgBBCCGkC2zFLRAajE3d9FAm6PTlGUqxGMq/StoWIgr6Tz8ZPVJwmUM93IFzinAgT+
         QzoETf31D45JA==
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Allison Randal <allison@lohutok.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
 <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
 <202003031314.1AFFC0E@keescook>
 <20200304092136.GI2596@hirez.programming.kicks-ass.net>
 <202003041019.C6386B2F7@keescook>
 <e60876d0-4f7d-9523-bcec-6d002f717623@zytor.com>
 <CAJcbSZHBB1u2Vq0jZKsmd0UcRj=aichxTtbGvbWgf8-g8WPa7w@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <627fe5d2-e6c3-4eff-1a58-14e17dc04ac5@zytor.com>
Date:   Wed, 4 Mar 2020 11:22:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJcbSZHBB1u2Vq0jZKsmd0UcRj=aichxTtbGvbWgf8-g8WPa7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-04 11:19, Thomas Garnier wrote:
>>
>> The huge memory model, required for arbitrary placement, has a very
>> significant performance impact.
> 
> I assume you mean mcmodel=large, it doesn't use it. It uses -fPIE and
> removes -mcmodel=kernel. It favors relative references whenever
> possible.
> 

I know... this was in reference to a comment of Kees'.

	-hpa

