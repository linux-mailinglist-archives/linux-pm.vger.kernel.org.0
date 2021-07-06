Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E88E3BD77C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhGFNPh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhGFNPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 09:15:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC676C061574;
        Tue,  6 Jul 2021 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DoleCSfXZRqJqk+8Uus+H8azrh/FQtHo5miIEnjjZSE=; b=EhoTFI5CbB/P8N7Dc8uFqRWzCK
        gnYUF+iYbO6MPeKxzO5mZyoPBEyoRpfNY5V7lq0v3z2QguWbw30Oke6lU/uZA9eANFMgUOelZomLb
        Rt/XTW7qVdErspi/WFYhJ30GxgeE794ywKB++UedGSZSdUQtTPV1wUxiagUdEz9+gNbSvFO1LVhN1
        j4J39adBwAqE1GdfpolRzeZiwSXxR+hAuo2y+wOOc6uQIV7842cfO6BPCr8I5h8gN94ZCaohQHeCs
        pUE02BPSajTIUEaM/TiJijEuaSzwsDqxrBotZaOPys4+l+SWnswAcJRbditL2wXFZdpfGbnRPzsNe
        +bUeXNuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0ksM-00F32U-FR; Tue, 06 Jul 2021 13:12:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64A87300056;
        Tue,  6 Jul 2021 15:12:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 315C1201C57F9; Tue,  6 Jul 2021 15:12:32 +0200 (CEST)
Date:   Tue, 6 Jul 2021 15:12:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Freezer rewrite
Message-ID: <YORWwNwIFqMmiGXz@hirez.programming.kicks-ass.net>
References: <20210624092156.332208049@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624092156.332208049@infradead.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 24, 2021 at 11:21:56AM +0200, Peter Zijlstra wrote:
> Hi all,
> 
> Now with a completely different approach to freezing the special states.

Oleg, could you please have a look at this?
