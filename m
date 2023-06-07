Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4207B725554
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 09:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbjFGHWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbjFGHWD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 03:22:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FCA1BE2
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 00:21:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-97458c97333so928088566b.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 00:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686122516; x=1688714516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IkykQ6a3DCB99+PAB+xta6PE0OasMF6osqsUUIJWDTU=;
        b=m15iDCoLA13AdpTTCIlUidBMlAcZ949J6LP2g350UazLtJS739XNXxN1/xIcDgK7Dm
         q+n7YDxO4lFEI8K54HCpt+wTiUFcnAA2rlBI8X2rIJDF1Uk+SQ4dwh5vW14CKzild1G8
         9WZ1iHYRedBJhHtWFk2UTpj0t8UURnAIfqGMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686122516; x=1688714516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkykQ6a3DCB99+PAB+xta6PE0OasMF6osqsUUIJWDTU=;
        b=TiI61rhRs+fUkri3J9I3IiUXVFAJShU96+s/69dNZJ9dvRoj5cWOxkTFE7QaK51yja
         65wGuJpurCnGrJLVKdWtoigfQdI0359YE03bYyqwwxfmuv074Vfdg6oMaDbYTw1rBW+9
         eW3cxVMszrCAjG5jdu4Jif2MgfjczrZn42hxs+SBaodxfeKwDJT+yzX1hUbDk4zYFy9I
         JKcIq1GHWJQyrC+6nqcQH9I7halg+xK5q6dw7SBrvnGf7084YNcYecT8bcnP5PaQTIdh
         ISbbw+kS4YnMbhVNJdrdp+QInjEpm5w+D+DQW6UNXd//0vDXOuLqPi+v9rHqBT2OFrDX
         veIw==
X-Gm-Message-State: AC+VfDw8CeDr2B0eos2uTGILHgMLfjympX7o77LgvzQuiAltlJd/HSAa
        Hue6K11PIWnDy/mNzkNUvfrK4jVec/5ptC7vhtaPrQ==
X-Google-Smtp-Source: ACHHUZ72WiSikG+zP4lihP/nTsQ+FWkiSy+zK+QzDTlROATy9g3AlpaZn6g5I2RBlqp7a7C4xwfcMaAinPg0KSu/a4E=
X-Received: by 2002:a17:907:961f:b0:965:b087:8002 with SMTP id
 gb31-20020a170907961f00b00965b0878002mr5375859ejc.0.1686122516568; Wed, 07
 Jun 2023 00:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com> <5d69a11e-c64e-25dd-a982-fd4c935f2bf3@fastmail.fm>
In-Reply-To: <5d69a11e-c64e-25dd-a982-fd4c935f2bf3@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Jun 2023 09:21:45 +0200
Message-ID: <CAJfpeguQ87Vxdn-+c4yYy7=hKnSYwWJNe22f-6dG8FNAwjWBXA@mail.gmail.com>
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Askar Safin <safinaskar@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 6 Jun 2023 at 22:18, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 6/6/23 16:37, Miklos Szeredi wrote:
> > On Sun, 14 May 2023 at 00:04, Askar Safin <safinaskar@gmail.com> wrote:
> >>
> >> Will this patch fix a long-standing fuse vs suspend bug? (
> >> https://bugzilla.kernel.org/show_bug.cgi?id=34932 )
> >
> > No.
> >
> > The solution to the fuse issue is to freeze processes that initiate
> > fuse requests *before* freezing processes that serve fuse requests.
> >
> > The problem is finding out which is which.  This can be complicated by
> > the fact that a process could be both serving requests *and*
> > initiating them (even without knowing).
> >
> > The best idea so far is to let fuse servers set a process flag
> > (PF_FREEZE_LATE) that is inherited across fork/clone.  For example the
> > sshfs server would do the following before starting request processing
> > or starting ssh:
> >
> >    echo 1 > /proc/self/freeze_late
> >
> > This would make the sshfs and ssh processes be frozen after processes
> > that call into the sshfs mount.
>
> Hmm, why would this need to be done manually on the server (daemon)
> side? It could be automated on the fuse kernel side, for example in
> process_init_reply() using current task context?

Setting the flag for the current task wouldn't be sufficient, it would
need to set it for all threads of a process.  Even that wouldn't work
for e.g. sshfs, which forks off ssh before starting request
processing.

So I'd prefer setting this explicitly.   This could be done from
libfuse, before starting threads.  Or, as in the case of sshfs, it
could be done by the filesystem itself.

>
> A slightly better version would give scores, the later the daemon/server
> is created the higher its freezing score - would help a bit with stacked
> fuse file systems, although not perfectly. For that struct task would
> need to be extended, though.

If we can quiesce the top of the stack, then hopefully all the lower
ones will also have no activity.   There could be special cases, but
that would need to be dealt with in the fuse server itself.

Thanks,
Miklos
