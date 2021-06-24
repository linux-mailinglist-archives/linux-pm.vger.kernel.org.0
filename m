Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C006D3B2B64
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFXJal (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhFXJak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 05:30:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EFDC061756;
        Thu, 24 Jun 2021 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dHjovZ7JZsV7a9rYd8UT8geIkI3WgRfMZGr/ANSnQfc=; b=hHT9l1sfvrpi3bnViNFQ2GWsK3
        r5ce1EX9rE5gACCBCZ22LjM4UW8ya+hjfeNbOpOej6CaawF4Q4LlDNbYscJ1AerCoai1ZYBFeEfDD
        8Uet7RciNtzvHdEpMwlg0F6NLjDOJESf8OQcCgqjPI1N3DtX0T3myDI72m/8Ne8jtnicOMtds/x5U
        YOxVZbX5uGZfPdDoqzuxxotXTUOlBGUbUS3rdI6jPayBkHaa5D+8ZVXMl7ccxVreIopu08zMqxO2y
        AnsU606yN4UN4wn7Nvf7PvmT2Az2QdbhkfS1n7cndx83ngvsJNjl39b4QTTuxUk6z9bKktd4vJO7b
        O5c0gCAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwLdd-00GOuh-G2; Thu, 24 Jun 2021 09:27:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0B08300258;
        Thu, 24 Jun 2021 11:27:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A054B2B64C060; Thu, 24 Jun 2021 11:27:07 +0200 (CEST)
Message-ID: <20210624092156.332208049@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:21:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] Freezer rewrite
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Now with a completely different approach to freezing the special states.

Patches go on top of tip/master, as they depend on the
task_struct::state rename.

