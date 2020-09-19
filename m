Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D11E270FA3
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgISQsT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Sep 2020 12:48:19 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60458 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgISQsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Sep 2020 12:48:19 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3DDCF1C0B90; Sat, 19 Sep 2020 18:48:17 +0200 (CEST)
Date:   Sat, 19 Sep 2020 18:48:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Martin Li??ka <mliska@suse.cz>,
        Roman Kiryanov <rkir@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200919164817.GA18978@ucw.cz>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
 <20200915182530.GV14436@zn.tnic>
 <CAKwvOdkKk1KuAFDoWNLnMUi3_JnV7atDFnvS7CdkgNXnNg0p1g@mail.gmail.com>
 <20200915202034.GZ14436@zn.tnic>
 <CAKwvOdmmXEu40m9bVL9zY5XyBRs2f15cs3FZQLCCh4u3i07pDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmmXEu40m9bVL9zY5XyBRs2f15cs3FZQLCCh4u3i07pDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> > Because I'm willing to
> > bet a lot of cash that no one runs bleeding egde 5.9-rcX in production
> > over there right now :-)
> 
> I guess you're paying for beers then.  "Android Common Kernels" run
> mainline.  (They're a bit esoteric in terms of "production" but
> cuttlefish virtual devices are running Android on mainline).
> 

You run mainline kernels but modules to support hw are
out_of-tree, right?

I'm looking for usable cellphone running mainline.

    	    	       		 	 Pavel
