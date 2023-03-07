Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81776ADE12
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 12:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCGL4B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 7 Mar 2023 06:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCGL4A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 06:56:00 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006F367DC
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 03:55:58 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id da10so51220217edb.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 03:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678190157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mNTj4DWql2gU30AnPn/RhSeO4GlG9ZsZgvXSz5osFk=;
        b=8ElzgYov/cgg+GV7Y5GLLbYowDnIKFPDH/cC/Nadtt7AmH9GxZ8+25S1xm/OtbSWcp
         amJ4bR8RHeSwcfzfZHG6uN4f/vgGTFhY+ORZ+Sq1pRXFGT0EiZ8KkJ/AbRHlVUkdAYVI
         tlN6zep8uF+DUI2s5IK1YIsOuWXWgFNXXWL6lpfxZ2X25ajSqbQ3/T+tT5JHAlYeTZDH
         5+nVHxR6HN9uKsQBU000DTfib5HnuU8bw0NZnmM4RyTV+Oh3WboePAV5boUtWDgrncZq
         SSEu2uQrwerXocMEO+rCrnC36fSElCiRPS9qySkOM1gWunySPgz/ViuYuS3Usm2Etw9a
         DWDQ==
X-Gm-Message-State: AO0yUKU1S3bbO3PJbIbQFaKX9NJXLzz6GXTivUjgNPzZp2ivS5ITmYNV
        UjHPeybcM/CeXTTDWq6uHmEcVith3JPn99/Q+cFPsbLG50o=
X-Google-Smtp-Source: AK7set9hsYynB9Wv/XgIPUWuRXPtus14L5IWoZ153Mfq7e6xDAojf4Ak+W/CzFfGgtMNQN7Xb1uvXzW8ao8THedVm2k=
X-Received: by 2002:a17:906:388d:b0:877:e539:810b with SMTP id
 q13-20020a170906388d00b00877e539810bmr7095178ejd.2.1678190157036; Tue, 07 Mar
 2023 03:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20230306123418.720679-1-dedekind1@gmail.com> <20230306123418.720679-2-dedekind1@gmail.com>
 <20230306145524.GF1267364@hirez.programming.kicks-ass.net>
In-Reply-To: <20230306145524.GF1267364@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 12:55:45 +0100
Message-ID: <CAJZ5v0iAitp+4UHfSJWyNACYthRHCSj5nBpJ1_5Zzq4fnJNKeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/mwait: Add support for idle via umwait
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 6, 2023 at 3:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 06, 2023 at 02:34:16PM +0200, Artem Bityutskiy wrote:
> > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> >
> > On Intel platforms, C-states are requested using the 'monitor/mwait'
> > instructions pair, as implemented in 'mwait_idle_with_hints()'. This
> > mechanism allows for entering C1 and deeper C-states.
> >
> > Sapphire Rapids Xeon supports new idle states - C0.1 and C0.2 (later C0.x).
> > These idle states have lower latency comparing to C1, and can be requested
> > with either 'tpause' and 'umwait' instructions.
> >
> > Linux already uses the 'tpause' instruction in delay functions like
> > 'udelay()'. This patch adds 'umwait' and 'umonitor' instructions support.
> >
> > 'umwait' and 'tpause' instructions are very similar - both send the CPU to
> > C0.x and have the same break out rules. But unlike 'tpause', 'umwait' works
> > together with 'umonitor' and exits the C0.x when the monitored memory
> > address is modified (similar idea as with 'monitor/mwait').
> >
> > This patch implements the 'umwait_idle()' function, which works very
> > similarly to existing 'mwait_idle_with_hints()', but requests C0.x. The
> > intention is to use it from the 'intel_idle' driver.
>
> Still wondering wth regular mwait can't access these new idle states.

But is this a question for Artem to answer?
