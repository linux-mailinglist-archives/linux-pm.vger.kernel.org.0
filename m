Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0127430A5
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jun 2023 00:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjF2Wgy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jun 2023 18:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjF2Wgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 18:36:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650E3A92
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 15:36:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688078188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TQ1Yhb/WkF6pZDCEQiQ4USxCt0k8c9C6ZsTem9nj0LA=;
        b=pvxj+gk9nu4CD0FeNIv0m2kDSVT3+JJXXqCo1b7Rbn3F07b4bEcSc50wli775y1a4wXg/o
        tNKmcSikr+A3LkR2Eq40s8D8ozCynk0Hi6BtWAoerwDCER4uS7bwAPoOehoP+fLK8Mojgo
        IuMTm7GjL+TiT2nyHFvlFT05WzX3PQKnvvQOpg5GK7fk45bxjMDfUrjhP6k7BphnLg8NhW
        WjHX2itl301K9LSJbj+4+3faT1dbUxZdgUgq/GPC0Jhw9IFmtxXgCGGWc9QPOCc4yjeiBo
        tRwdBDfyv4Y3JTj3mEf2c2ur/h4uA4aHzvd7Vdvjmy8EiPjFgi3+X80PTLuy7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688078188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TQ1Yhb/WkF6pZDCEQiQ4USxCt0k8c9C6ZsTem9nj0LA=;
        b=O4u7onlLPAe7wXIgGXb24uogKYVPwDQbeg0sHPB65MQAcpv/pTmyFhSiP0bsni2xgwRTVi
        igU7HFeO47THEgBg==
To:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mwait: Add support for idle via umwait
In-Reply-To: <87352a0vu4.ffs@tglx>
References: <20230610183518.4061159-1-dedekind1@gmail.com>
 <20230610183518.4061159-2-dedekind1@gmail.com> <87352a0vu4.ffs@tglx>
Date:   Fri, 30 Jun 2023 00:36:27 +0200
Message-ID: <87wmzlzyj8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 30 2023 at 00:04, Thomas Gleixner wrote:
>> +static inline void __umonitor(const void *rcx)

These inlines must be __always_inline to prevent the compiler from
instrumenting this.

For further information see:

  0e985e9d2286 ("cpuidle: Add comments about noinstr/__cpuidle usage")
  2b5a0e425e6e ("objtool/idle: Validate __cpuidle code as noinstr")

Thanks,

        tglx
