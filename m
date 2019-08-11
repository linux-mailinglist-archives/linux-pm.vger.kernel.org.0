Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7C89254
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHKPda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 11:33:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33901 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHKPda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 11:33:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so66688224edb.1;
        Sun, 11 Aug 2019 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LfMEDWO38iSQdUunD3Hlo38F1+ICCQ2/45EAVCriAGU=;
        b=RuuhpUV689wLH1DbjcLv4FhAUABCkgt82R1kvweXIITporFlF1QKQPG7lAG+W1AaCy
         sKZoPqipL5rdQNoz++R8piru/ObupX5XI3F2Up/PoXeUPI2H65vb7Wl6QHFT62rv5XrR
         7zxELGop2IU1DulIwAOA0ggsZ3cd20qUpH4laFbz9bJn7ZvrNQJSycCereePjVdu3/Mk
         qQSjKmPKaslGJW5oa1DnPEQ5udoBr8NMaWkccNOp1ZyKEm4DViHQuBfrv4Nu+BB2WMlP
         f7qpHePH1TfDluHZj3bh0NHpwqgjvdIcNSNU6R9f+t7qhJ1jUd4PnzzGyfd7OYsTU7bR
         n9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LfMEDWO38iSQdUunD3Hlo38F1+ICCQ2/45EAVCriAGU=;
        b=bkK9Isv09xy7CdejWYQhXBfdHgGylbtNvOK5gHwy0jsrtZZON7jL262UGMDTZWW85a
         54q1Zwfov84yJ2+DBdhID2ZEdkLK2Bz7oHnHZIAxQz7ASLvkdL1eV9m/sm39wgR/ZSwK
         xjVWjQykNYofAeMrneZ3vrTZA9PTYS5uqYT7+Lc0EmzcCIiZwxsMhe8lcGRkpBuVYovW
         RfY/JL+jU8/vSLGRbseIcSMg0gSz3MLqwRTohpJV/DAdE0Hnay2snjpsmYOLRNYsudfS
         WFKJKW+4U/0tagPfp94hMmneELVk7oWonGXQWy25HeVUedNnOitPjVcJo7yKdAW016nA
         5LVg==
X-Gm-Message-State: APjAAAW/doPUFkcybi1KA0dVUgpj3xuYwxiT1+Z8HCjN/QK/BORJJATm
        AsH+eNRUg8akL2xtnnfsWeg=
X-Google-Smtp-Source: APXvYqyfFv9/ip91xdh1XW8s+k1djdxmFVOY71xWnEgjW3JNlPgvdFxUn2BiYRCXMVowcqsNE/G51w==
X-Received: by 2002:a05:6402:397:: with SMTP id o23mr32658840edv.68.1565537608022;
        Sun, 11 Aug 2019 08:33:28 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id c1sm102702edn.62.2019.08.11.08.33.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 08:33:27 -0700 (PDT)
Date:   Sun, 11 Aug 2019 17:33:26 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [Linux 5.2.x]
 /sys/kernel/debug/tracing/events/power/cpu_idle/id: BUG: kernel NULL pointer
 dereference, address: 0000000000000000
Message-ID: <20190811153326.GA8036@eldamar.local>
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de>
 <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de>
 <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de>
 <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
 <alpine.DEB.2.21.1908110822110.7324@nanos.tec.linutronix.de>
 <20190811094630.GA18925@eldamar.local>
 <alpine.DEB.2.21.1908111456430.7324@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908111456430.7324@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thomas,

On Sun, Aug 11, 2019 at 02:58:15PM +0200, Thomas Gleixner wrote:
> Salvatore,
> 
> On Sun, 11 Aug 2019, Salvatore Bonaccorso wrote:
> > On Sun, Aug 11, 2019 at 08:22:35AM +0200, Thomas Gleixner wrote:
> > > On Sat, 10 Aug 2019, Paul Menzel wrote:
> > > > For the record. It is also reproducible with Linux 5.2.6, and trying to print
> > > > the file contents with cat already fails.
> > > > 
> > > > ```
> > > > $ sudo ls -l /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > > -r--r--r-- 1 root root 0 Aug 10 23:05
> > > > /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > > $ sudo cat /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > > Killed
> > > > ```
> > 
> > This seems to be related to https://bugs.debian.org/934304 (in
> > particular https://bugs.debian.org/934304#29). The mentioned patch
> > features/all/lockdown/0031-tracefs-Restrict-tracefs-when-the-kernel-is-locked-d.patch
> > is a backport of https://patchwork.kernel.org/patch/11069661/ with
> > only change that it is converted back to the non-LSM lockdown API.
> 
> So that's a debian kernel specific issue?

"yes". A kernel build without the above patch does not exhibit the
issue. So the issue is specific to that lockdown patch ("tracefs:
Restrict tracefs when the kernel is locked down").

Steven and Matthew are both CC'ed.

Regards,
Salvatore
