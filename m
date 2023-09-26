Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7DA7AF078
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjIZQRr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjIZQRq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 12:17:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DD10A
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 09:17:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-578b4997decso7151536a12.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695745058; x=1696349858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+SnA92wnN6Pe5sjQR6yfLakYoxIuu3kYpagASz8Rzk=;
        b=pMy6TrBV9P+SC6Y+6TIJQoXa+vRrub/0R6I0wSSflwghxdHmHhQk+e9m8zaNZAeGRU
         YTsHQRLNnkyyPSkdbczHNLq00In40KAs38NVrpODyrdj/jVdvs4bbGe4HON/9ZiWhE4E
         72o23vW6XLmcmh4pUG9i5FgoIl8hFw0bwQ2PtcvL0VfXUDMWZrJ7UFG5W2GXgCdmk5Xh
         RiWAJhMktQ0YjcMk9Fc98DAq3tKXmYmmfK8j7DSCehaV0ynkhIdZEkgtZ1lBAGXhyomT
         mpFsSgAQQwM0N1+G9L8KlN42cdEQk31ugazcRLDSAuiNR+0YpvL+Fw/w3YT1gGIzTcLd
         uahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695745058; x=1696349858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+SnA92wnN6Pe5sjQR6yfLakYoxIuu3kYpagASz8Rzk=;
        b=XT6aItp+R9g+J/et4kJhoBKBBwjlwwdFgQ1x4pgC+oY/o4ApVJmrcMFzloVKQiFbdq
         THcXnGckSGKtW3DBuo4uu5pbRQsx87cCN/29O8aOwTy+ntgS/b+gidhRpE2Yr/92zGdC
         qzr8gLt+8y/v6Uq9qjCl7mnMSNPcHUI1qjF/GhgMMCQtTkcUhUjr5x2NUWbEvfJuoCnF
         r3cY9FUnssv2PxJtUNAASIaYfGaZfamNYKQnbnQIu71mr2ACdGnqZBdOhIFDk2dLaeBD
         bl/noFwtITyakJvNWK2c/n6fjpcawsw5wXtynLFSeQ6KPaCIg6staoY64PRDO39qMEcD
         NUBg==
X-Gm-Message-State: AOJu0YycHEyKSlyb3LnorqZRdNjcjncon7VLzGOe38b1vt8o86J4+5Ji
        /+Plk+THovFhk36D0bLxM1tl3w==
X-Google-Smtp-Source: AGHT+IHCbbHHAA3sQLh2bCKbGTQgIbdG00VVKR9iZ1d7kltCO0aMrFD3AdKvTQcMIQM6IAct0jmC+g==
X-Received: by 2002:a05:6a20:3cac:b0:158:17e6:7a6 with SMTP id b44-20020a056a203cac00b0015817e607a6mr13116705pzj.42.1695745058075;
        Tue, 26 Sep 2023 09:17:38 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id s8-20020a63b408000000b0055bf13811f5sm8467985pgf.15.2023.09.26.09.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:17:37 -0700 (PDT)
Date:   Tue, 26 Sep 2023 16:17:33 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH v4 0/2] Avoid spurious freezer wakeups
Message-ID: <ZRMEHb3_0Ku1UuK_@google.com>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 08, 2023 at 03:49:14PM -0700, Elliot Berman wrote:
> After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
> tasks that transition directly from TASK_FREEZABLE to TASK_FROZEN  are
> always woken up on the thaw path. Prior to that commit, tasks could ask
> freezer to consider them "frozen enough" via freezer_do_not_count(). The
> commit replaced freezer_do_not_count() with a TASK_FREEZABLE state which
> allows freezer to immediately mark the task as TASK_FROZEN without
> waking up the task.  This is efficient for the suspend path, but on the
> thaw path, the task is always woken up even if the task didn't need to
> wake up and goes back to its TASK_(UN)INTERRUPTIBLE state. Although
> these tasks are capable of handling of the wakeup, we can observe a
> power/perf impact from the extra wakeup.

This issue is hurting the performance of our stable 6.1 releases. Does
it make sense to backport these patches into stable branches once they
land in mainline? I would assume we want to fix the perf regression
there too?

--
Carlos Llamas
