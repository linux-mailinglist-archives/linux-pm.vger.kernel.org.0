Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1AFE85A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOW7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 17:59:19 -0500
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:59278 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKOW7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 17:59:19 -0500
X-Greylist: delayed 2624 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 17:59:17 EST
Received: from av3.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id xAFMEr1p017647;
        Fri, 15 Nov 2019 22:14:55 GMT
X-AuditID: 8b5b014d-771ff70000003678-bf-5dcf235dc69b
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id C0.AA.13944.D532FCD5; Sat, 16 Nov 2019 00:14:53 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 16 Nov 2019 00:14:52 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: QEMU RISC-V virt machine poweroff driver
Organization: FORTH
In-Reply-To: <20191107212408.11857-1-hch@lst.de>
References: <20191107212408.11857-1-hch@lst.de>
Message-ID: <cca46a52ee91548962e2f9da4cf2202e@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.9
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXSHT1dWTdW+XyswcZjPBbzj5xjtVi5+iiT
        xefeI4wW2z63sFksvX6RyeLl5R5mi7ZZ/Bate4+wW5zeXeLA6bFm3hpGjzcvX7J4bFrVyeax
        eUm9x+6bDWwel5qvs3t83iQXwB7FZZOSmpNZllqkb5fAlfHj8SPWghlsFX8mdLM1MM5g7WLk
        5JAQMJF43XGSBcQWEjjCKLHsUC1E3FRi9t5ORhCbV0BQ4uTMJ2A1zAIWElOv7GeEsOUlmrfO
        ZgaxWQRUJWZcXQFmswloSsy/dBCsXkRASeLpq7NA9VxA9TuZJDYeXQO2WBhoQUfrTTYQm19A
        WOLT3YtAcQ4OTgEDiYNvJCHu0ZeYvm8iO0iYV8BF4tlxV4jTVCQ+/H7ADmKLCihL3Dz8nH0C
        o+AsJJfOQnLpLCSXLmBkXsUokFhmrJeZXKyXll9UkqGXXrSJERwRjL47GG9vfqt3iJGJg/EQ
        owQHs5II746KE7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEefO4l8cKCaQnlqRmp6YWpBbBZJk4
        OKUamOb3XT0b8jIwkOOxa7xm1dyvE2fzTVNlcTzyIHRmrIvUgc2T7tQv+F+hlvRG52Ls7wU1
        uhIzbW18BJe9MX+4P+ljhvTU9qp1140MrLceV2ub7lzVZPq3nzeuY1VHAn9E7H1uhy9u/85d
        ufNqreyKif2i2yLlhA7wLJg6952y01nV13eSKxn/bbz09qPOIw71U2UBh14l7+GJOe6ys+WG
        +YfiiMO/7p4JmvTx9zvR0JxNoawnWWpefCtYaLqsT+bgpR1HJk7+/ED8y9WJNab/hM5uzZm0
        Zll3Ku+WtT8tVFmu923c7jvnr2msNZcVy6GeRzv3+XzZmVW9bMu7n24BtS+F/hcE2M5X+MD6
        ck3omRkHlFiKMxINtZiLihMBSll9NvcCAAA=
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Fri, 15 Nov 2019 22:14:55 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av3.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Fri, 15 Nov 2019 22:14:55 +0000 (GMT)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Στις 2019-11-07 23:24, Christoph Hellwig έγραψε:
> Hi all,
> 
> this patch add a driver for the test device in the Qemu RISC-V
> virt machine which allows properly shutting down the VM.
> It also is added to the riscv defconfig given that qemu-virt
> is the most popular riscv platform.
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

We do this already through OpenSBI, I contributed a patch for this some 
time ago.

https://github.com/riscv/opensbi/commit/51e543511a7425da1a5378e149de0b45928c7111#diff-36ecc47313ff13e406c53b99471f294e

Last time I checked I could just halt and the system would shut down 
properly.

Regards,
Nick
