Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541816A565E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 11:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjB1KLc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 05:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjB1KLb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 05:11:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C04279BA
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 02:11:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eg37so37436101edb.12
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 02:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6Fv7RTV/cqUZMpJPGCtJkqonct+qD11isgF65yAGj4=;
        b=YBG5s1p2PS1z9HODxaNL8yf8qog6v3brhMkl8CS2GTwl9MOdMdEtZ5NW5bZJ+Y4rT1
         +/u9TrEz9EDYB5GGW/9LkF0Q7WMixykdcJhzIzwWOCRGiC1hq1HwMfMAyOuOBQOa+5pZ
         hGQbTOpmGJn+HrSHTGx4J69ZkuFRPN6sWSOf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6Fv7RTV/cqUZMpJPGCtJkqonct+qD11isgF65yAGj4=;
        b=V4vMuFMPDlsEB3TSFfQVu558tiUV+xqh94hakOf5tOEaQuj+mSWmGjRSwVLW6RTAnW
         j/IkZkI5tCLhPXpOzXXFcJzn/Qmt3JltmU7Swzxk3wRbfhyDuyeNheM+iDeIESDkBSqX
         88LpT68L0XOX3ozaUMxo59CRdNawRduWmDposE7ZrtWdyf8AQlbi8iIWLZiOlaX7/2r7
         8vKZfbmFSLGLHwK4LxykYvyQ2d+pD7z3CtRJmv846UmOnPWK57w4NOtZ7OnxDn2fXf54
         ekWzVQDJcrp3gAMQDgKFFKRw8mC1adPMHVW5kj/cpxZM7HZRRTjKWkZXcE6zUECMzirB
         QRTg==
X-Gm-Message-State: AO0yUKUH6sbnK75VhsgQ2fVsBY/gJ7prsPZqtW4egEleH4IDsacXrYij
        WVnyqb7RkOdpHbLYPZxByBdVXwgJMyTWOw9D4O4=
X-Google-Smtp-Source: AK7set+3c96lhGiqS2feUoJcQMlBtdY5frCscnox3t28nOXGblNAjW6/DSs432xeBto7hDq8K+g8Uw==
X-Received: by 2002:a17:907:6e8e:b0:8ea:a647:a5aa with SMTP id sh14-20020a1709076e8e00b008eaa647a5aamr12747547ejc.38.1677579088298;
        Tue, 28 Feb 2023 02:11:28 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b008f702684c51sm4238676eja.161.2023.02.28.02.11.26
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:11:27 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id cy6so37622282edb.5
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 02:11:26 -0800 (PST)
X-Received: by 2002:a17:906:a84f:b0:8bf:e82a:2988 with SMTP id
 dx15-20020a170906a84f00b008bfe82a2988mr1016434ejb.4.1677579086373; Tue, 28
 Feb 2023 02:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20230227121318.2116638-1-md@chromium.org> <ae60774a-63ba-e4ab-b434-d3c38cb897e2@suse.com>
In-Reply-To: <ae60774a-63ba-e4ab-b434-d3c38cb897e2@suse.com>
From:   Michal Dubiel <md@chromium.org>
Date:   Tue, 28 Feb 2023 11:11:15 +0100
X-Gmail-Original-Message-ID: <CAPxDTA8BQDL1hrRRyUjCes77mQ926206i00q1nCEo55RB2CRzQ@mail.gmail.com>
Message-ID: <CAPxDTA8BQDL1hrRRyUjCes77mQ926206i00q1nCEo55RB2CRzQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Suppress warning on resume attempt of explicitly
 frozen processes
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 27, 2023 at 4:19 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> On 27.02.23 13:13, Michal Dubiel wrote:
> > Hi,
> >
> > The following patches disable warning message for thawing attempts of
> > processes that belong to a cgroup that has been intentionally frozen. This
> > happens in the following example situation:
> > 1. A cgroup is frozen by writing "FROZEN" to freezer.state cgroupfs file.
> > 2. System goes to suspend.
> > 3. System resumes from suspension.
> > 4. The cgroup is thawed by writing "TWAWED" to freezer.state cgroupfs file.
> >
> > On 3, kernel tries to thaw the frozen processes. However, the processes of
> > the freezing cgroup should not be thawed in that step, but rather in 4,
>
> Isn't the core issue here that processes frozen from user space and
> tasks frozen due to a PM transition are not in the same state?
> That is instead of inventing substates for a specific state you
> should have a new state?

Please correct me if I misunderstood your comment. I believe that
effectively we already have a separate states for task freezing due to
PM transition and due to userspace requests and the kernel is able to
differentiate between the two (e.g. there is cgroup_freezing()
function to check for that).
The issue was that this information was not used when thawing the
processes on the system resume. The used freezing() function returns
true for tasks that are freezing for any reason. I've proposed another
function that returns information about the reason why the task is
freezing so that the information can be used and acted accordingly
when needed, without breaking the existing freezing() function
operation.

Regards,
Michal
