Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1E6B9615
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjCNN1C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 09:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjCNN0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 09:26:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB15F23A
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=az1MUAVD1P3yqp0KY/PkkE4jPyfV63W+dgGR+4AeYZ4=; b=GpGW0Fv5lFPmzRECn30IXx0WUe
        OiZR9LYq+LBxrNctyG62UnbLezYDIZyCzIEfom8RMy3C3Fvnhr3CegNEto+t+3tgR6kPuL/SYEELp
        7NcpxPs/7IXkB9HkzpVEk9NieAO849r5AeLK2yQI2BDsoKklqRnA/2at9NatrfQdb2KYieumCcQ7+
        91NQUZ+iXu3PmtPsDZGTZXLdCiUOSXKe+bow4/UCEAUhEJDrwIVDcKYHBZoZfRTAGK62JyVpEl10/
        duXMzxyPjTECyBbb5420JOQod3mYbRbeRrqi/0bXNYQkO1vgMtVtabbAh8o9/M1PsvX1DN40pg2wO
        4alvTn+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc3hz-00CtY8-Qc; Tue, 14 Mar 2023 12:24:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33EAD300642;
        Tue, 14 Mar 2023 13:24:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 117A8212CB3D9; Tue, 14 Mar 2023 13:24:51 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:24:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
Message-ID: <20230314122450.GH1845660@hirez.programming.kicks-ass.net>
References: <20230306123418.720679-1-dedekind1@gmail.com>
 <20230306123418.720679-4-dedekind1@gmail.com>
 <20230306153215.GG1267364@hirez.programming.kicks-ass.net>
 <CAJZ5v0gFrWCdyVNPUoU4tq2vTzcx5WtzvhbXVx1WeyTtt=Gqvg@mail.gmail.com>
 <20230308123222.GF2017917@hirez.programming.kicks-ass.net>
 <12e008c7fd280c8abc45f417f64bb782485a40b8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e008c7fd280c8abc45f417f64bb782485a40b8.camel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 09, 2023 at 10:01:57AM +0200, Artem Bityutskiy wrote:

> Could you please help by giving a hint how to verify?

I think you need both:

DEBUG_ENTRY and TRACE_IRQFLAGS

I can reproduce with:

make O=defconfig-build defconfig
cd defconfig-build
../scripts/config --enable INTEL_IDLE
../scripts/config --enable DEBUG_ENTRY
../scripts/config --enable IRQSOFF_TRACER
cd ..
make O=defconfig-build -j32 vmlinux


But typically it is useful to have a .config with lots of tracing and
debug (including lockdep and debug_entry) enabled for this stuff.
