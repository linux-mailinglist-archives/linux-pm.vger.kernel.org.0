Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BBE3C158
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbfFKCtO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 22:49:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59410 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390244AbfFKCtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 22:49:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2717A6077A; Tue, 11 Jun 2019 02:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560221353;
        bh=w8yBBlzJMcdsXVSM0jRBIZSjIf9XdVzNZYd6aoDCNoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d+4GGBd39eibRKM1sBEUZR+j3f5rdQlt46jo1eBDa9cy1mn1bnclpysBcKAS0wGMY
         AWJRDq96UML+CG68PUHSYVOobtyBt4vGp7gVd7vYpFFGhzc6Nia4FloMju7Kx/3HN7
         MDqOlX7WrWodGG2sbAt4X8UBIU51QW3QBEc2ET5o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E90DC607C6;
        Tue, 11 Jun 2019 02:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560221352;
        bh=w8yBBlzJMcdsXVSM0jRBIZSjIf9XdVzNZYd6aoDCNoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PrtygVhsWRLs+CgjQ0oEXGUZVlwAwJsyk2ZMjT/VpXsqlPeCj1okGFUiTOHkouN1E
         bpvoUzJP7mS9ubKn9+/3rv194g4QCmhzlZs/XDQ6kKJx9QV82AFTrWA/yvbrfQ6toB
         LmmrpKJzPZKVX/Vut8wytc6wZNpOsLc48Hk9CtZk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E90DC607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Received: by mail-ed1-f44.google.com with SMTP id k21so14229948edq.3;
        Mon, 10 Jun 2019 19:49:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXOwtg0iRCB0itWEUx70CJgCnIzN4uBQCDBZcvM+6pCJR8QvHec
        eDo0XTaDfNOXVFpREZH1WrRGBHp8xX3H4S4t9SU=
X-Google-Smtp-Source: APXvYqxvPmnZwsBXrmtO8FQpzDanJon6A2pHK0HutU2cDmxEfYa0Q3JL20t0hmqIdlsI34/oPqzYKiIaSCXWVxcOHng=
X-Received: by 2002:a17:906:2415:: with SMTP id z21mr44138407eja.211.1560221350698;
 Mon, 10 Jun 2019 19:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org>
In-Reply-To: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org>
From:   Pavan Kondeti <pkondeti@codeaurora.org>
Date:   Tue, 11 Jun 2019 08:18:58 +0530
X-Gmail-Original-Message-ID: <CAEU1=Pk2HVHApjRkAtL0H1wa6GUejs4af3KodQ8TgJmJ6bh-Wg@mail.gmail.com>
Message-ID: <CAEU1=Pk2HVHApjRkAtL0H1wa6GUejs4af3KodQ8TgJmJ6bh-Wg@mail.gmail.com>
Subject: Re: [PATCH] cpu/hotplug: Abort disabling secondary CPUs if wakeup is pending
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael/Thomas,

On Mon, Jun 3, 2019 at 10:03 AM Pavankumar Kondeti
<pkondeti@codeaurora.org> wrote:
>
> When "deep" suspend is enabled, all CPUs except the primary CPU
> are hotplugged out. Since CPU hotplug is a costly operation,
> check if we have to abort the suspend in between each CPU
> hotplug. This would improve the system suspend abort latency
> upon detecting a wakeup condition.
>

Please let me know if you have any comments on this patch.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
