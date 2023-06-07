Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CD725A6C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbjFGJaN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbjFGJ3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 05:29:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB46AA
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 02:29:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso1120028a12.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 02:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686130188; x=1688722188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2BLecNjxkMJZi1ruU8F6LcBaR2Y9Qu96nuXiY0dXPmk=;
        b=isP58o13oLsDF+FT8fOKygUY77IyyakLSsuA714GY1lg0P+CeKzRvWMTlV1kuFQo2n
         BWgCyp2VsQ8jpwmfvC+c9wAaYbmtRXwiOT5k7UIsn8xjVJTEMSGFVXZrLOGx4sWely/y
         MhvK7A6e8b9M43nFQ4jFXejGtheuR34J3JgfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130188; x=1688722188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BLecNjxkMJZi1ruU8F6LcBaR2Y9Qu96nuXiY0dXPmk=;
        b=TeAvBzccXZSKlHy89T60LFrxkrhlhY+BkNMgzTu2j857m1p3+fuPCLM86+7hH2NuG/
         2LpbRWUChlhLzAEiQSAgWeAE/gqZMbec+1riO5Anr8FcWMBQBKtJbLdKo/Oyu5Kby8V8
         ByYmLxuHXd24tdLx/fESiH/RhmqdV3ApdSjfW3TFIMjW5Bib35MRk3yEvITAwoP+8LO8
         1XVIzYI4AmkX3U6QtrJxeMbzXmUaELr0g7FSpnf06Y6ZvP7xGO9F0RvVK4Gm8NxrL4Vk
         aC304VPmdAo+DaxmfFXcYZ61/FmVARds6WL9454W2DPVrUzu1ZEkb7Zhbuee/rc9RPpi
         CCDA==
X-Gm-Message-State: AC+VfDxrQ3cTcUI7WuLAuY+r/gc/BC6aEGPBEo//jQ6kyXdQYYvO3boT
        AGxk+A4x0E4vv2PD3ORvM8fdReGggyr4vt8z7N9CwQ==
X-Google-Smtp-Source: ACHHUZ4RtZ8bbXfXPQLckp4Q6RLjZQVlrtyxd2G4isYyaOtvgQlLxX+BwNlbYVP/XvkkNne4dmBuvgtlrW/TnHr5DdE=
X-Received: by 2002:a17:907:72d0:b0:94f:6218:191d with SMTP id
 du16-20020a17090772d000b0094f6218191dmr5673140ejc.32.1686130188072; Wed, 07
 Jun 2023 02:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
 <5d69a11e-c64e-25dd-a982-fd4c935f2bf3@fastmail.fm> <CAJfpeguQ87Vxdn-+c4yYy7=hKnSYwWJNe22f-6dG8FNAwjWBXA@mail.gmail.com>
 <9f79a2b7-c3f4-9c42-e6f3-f3c77f75afa2@fastmail.fm>
In-Reply-To: <9f79a2b7-c3f4-9c42-e6f3-f3c77f75afa2@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Jun 2023 11:29:36 +0200
Message-ID: <CAJfpeguXBpyr_3FV1u-VRA9ZSqmGKVWFWZsXPqB-Tqa_JAx=uw@mail.gmail.com>
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

On Wed, 7 Jun 2023 at 10:13, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> Assuming a fuse server process is not handing over requests to other
> threads/forked-processes, isn't the main issue that all fuse server
> tasks are frozen and none is left to take requests? A single non-frozen
> thread should be sufficient for that?

This *might* work.  But there could be auxiliary threads, or the
initial thread could be killed, etc.  It would not be reliable.

> Ah, when all non flagged processes are frozen first no IO should come
> in. Yeah, it mostly works, but I wonder if init/systemd is not going to
> set that flag as well. And then you have an issue when fuse is on a file
> system used by systemd. My long time ago initial interest on fuse is to
> use fuse as root file system and I still do that for some cases - not
> sure if a flag would be sufficient here. I think a freezing score would
> solve more issues.
> Although probably better to do step by step - flag first and score can
> be added later.

I'm not sure how systemd interacts with the freezing process.  If it
does, then the only sane thing to do is to make sure it doesn't have
any filesystem interaction during that time.

Hibernation is a different matter, because it needs the filesystem to
be in a working state while all userspace is frozen.  Hibernate to
fuse would bring up a lot of interesting design questions.

Thanks,
Miklos
