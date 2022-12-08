Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB52647253
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLHO6b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 09:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLHO63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 09:58:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB4BF71
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 06:58:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h10so1924212wrx.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2022 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U59H1v37fnrRuO5gY9YEIJq45nAGp9i0WZRmt0YHAV0=;
        b=sAtKmSnbD3QKlav53j+c7KsUgjOq+FGOo1ZO8mmvgQ+fXCpIh1w5ZUV4IsTe4/5jf1
         N/7HntUn2cy/4FaPDS1Jr3ka1ji2N5wEnWHkBr0AMbLSjm9O0I5MQu9MNWjuiC5DjLqI
         Ihz3U5McYq50fi8U71OooOUR9kZ7lLQWdEwlJwx7YbhWUeeqkuqa5p6vSN4bntoSka77
         MDvi+ysyOuJZHI6tcSDufLHoY+tPfRA6ySlW910Ap+grOTNNBDnxxdIBQoNU8RnPYe/+
         ywJC6uI3ietCuxNqCr8M2UFcFBQYT9GH+jbBZOjdinKbftXtU+b0GiNYpLBTNcZuAI5/
         fAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U59H1v37fnrRuO5gY9YEIJq45nAGp9i0WZRmt0YHAV0=;
        b=xOkId7R9zn8x37I4rB2ejFu+terCyyBbNb4kvevgYQNTaZ5hvPUUV/Hc0e706JPhre
         czdfmHFo0qN/xn9COVm4vEHa+R0+9c2CkZ/D/sAKtucDzHYfCIKzpS9i/vR9WtywA6fJ
         6AIhAgF61rbe7Tqeoxb9djJ0C6qJg9lBtznyjTIHIUqy92FvzNHtWK4JzCl0TkHGYOpd
         fDCKT6oFqMVyC8dZ2a97eq8tlqjKMRvkF08Uv2SWGZbUxbv9ALcV2XA+V8hbMSbelX6o
         d1PXPUke6UhM5NeNdEC9yhhKs93CRMazENP/DbPVw6AI2OEIXTU0roI7eBZLOOJK///y
         LbvQ==
X-Gm-Message-State: ANoB5plEcJ+qK6up2TseNDo1puXJnZtivZnsiQrwrhJi888VANBcy0sZ
        UMVTUd2ligCKAlVQihHM1V5www==
X-Google-Smtp-Source: AA0mqf71X822z99TPqBxMJl7WdxzFzoHxz7hLc2sjMC48Lwb6t6ILfwEwxrbDYxx+lyPmkhLqm6ytQ==
X-Received: by 2002:a5d:51cd:0:b0:242:17d3:a9f9 with SMTP id n13-20020a5d51cd000000b0024217d3a9f9mr1590705wrv.68.1670511507440;
        Thu, 08 Dec 2022 06:58:27 -0800 (PST)
Received: from airbuntu ([2a00:79e1:abc:9:c7d:8d2a:a83c:450a])
        by smtp.gmail.com with ESMTPSA id p1-20020adf9d81000000b0024258722a7fsm13289723wre.37.2022.12.08.06.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:58:27 -0800 (PST)
Date:   Thu, 8 Dec 2022 14:58:25 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH v2] sched/fair: Fixes for capacity inversion detection
Message-ID: <20221208145825.gt3rsysykqaklrwt@airbuntu>
References: <f06321f0-def6-6f9d-b72f-f700e7e9a60a@arm.com>
 <20221208145409.453308-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208145409.453308-1-qyousef@layalina.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/08/22 14:54, Qais Yousef wrote:
> Traversing the Perf Domains requires rcu_read_lock() to be held and is
> conditional on sched_energy_enabled(). rcu_read_lock() is held while in
> load_balance(), add an assert to ensure this is always the case.

Err that should say instead

	Traversing the Perf Domains requires rcu_read_lock() to be held and is
	conditional on sched_energy_enabled(). Ensure right protections applied.

Peter, let me know if you want me to resend with that fixed or happy to apply
yourself.


Thanks!

--
Qais Yousef

> 
> Also skip capacity inversion detection for our own pd; which was an
> error.
> 
> Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
> 
> Changes in v2:
> 
> 	* Make sure to hold rcu_read_lock() as we need it's not held in all
> 	  paths (thanks Dietmar!)
