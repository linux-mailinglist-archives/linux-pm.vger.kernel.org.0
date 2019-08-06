Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA983584
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfHFPnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 11:43:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35336 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfHFPnu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 11:43:50 -0400
Received: from zn.tnic (p200300EC2F0DA00008E04FA4C58F7CE4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a000:8e0:4fa4:c58f:7ce4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42CB21EC0C42;
        Tue,  6 Aug 2019 17:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565106228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TDFDazt6//hwNfwRMzmVKFiu4ldxLz+yMwXDE8Lj5Eo=;
        b=dt2cjv9ck6Riog7ad+ewdarAX2dM8UrmZhk8qdfxpW8EfZWGjwleuVrU4g1cmXqrcn8Kh+
        TWcpA8A1qy+/qbzkXNRCP6wNTc/+TBGiGV3muxnmmGbdGi77lel3IPkl79O3Iqqfn0x3XN
        2iqBRrkAzDyyrAqpiKzGnDMqxESTm0c=
Date:   Tue, 6 Aug 2019 17:43:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 00/11] x86: PIE support to extend KASLR randomization
Message-ID: <20190806154347.GD25897@zn.tnic>
References: <20190730191303.206365-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 12:12:44PM -0700, Thomas Garnier wrote:
> These patches make some of the changes necessary to build the kernel as
> Position Independent Executable (PIE) on x86_64. Another patchset will
> add the PIE option and larger architecture changes.

Yeah, about this: do we have a longer writeup about the actual benefits
of all this and why we should take this all? After all, after looking
at the first couple of asm patches, it is posing restrictions to how
we deal with virtual addresses in asm (only RIP-relative addressing in
64-bit mode, MOVs with 64-bit immediates, etc, for example) and I'm
willing to bet money that some future unrelated change will break PIE
sooner or later. And I'd like to have a better justification why we
should enforce those new "rules" unconditionally.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
