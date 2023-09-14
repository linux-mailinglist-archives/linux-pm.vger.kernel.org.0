Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70907A06EF
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbjINOJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjINOJy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 10:09:54 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C4DF
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 07:09:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7830c5b20aso1470858276.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694700590; x=1695305390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9IGYP5VQdwee25nV5jOO+j3P/uh5L2lbtVFrt/kEhY=;
        b=s0LMxQAlq9b2S0ajyPyx0nG5jUtvOPFlOp8NcK0rHZkq/rYDhOrI4dLAQhtKgKo0uM
         rNf5p1V2JzOkF68J/bXvLmAsJlnDiXmxPnMXMTHOEUnyIBeeuV2eIH9oemLR0LkpgzXh
         l3oYP3d6/Rii7MhBMCuPVbR5xzFsjjncL/LWsc/lBSityhRenRMJGOLNR5c0rTjK+h99
         riaw/5LzOBvwcjhoydeMNVfg1TgPohCt7LLDlwM+9HsnzlxYh4hwkGhgT/HDeQgM0NYJ
         jkLkygkY5qFmUJILhR1swIS4mNchu5a+6KNzQiuaa+5z35QXbSxr0pF8e2KkQ1J6a76j
         kv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694700590; x=1695305390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9IGYP5VQdwee25nV5jOO+j3P/uh5L2lbtVFrt/kEhY=;
        b=CbGQ4/kNF69LFIx8n1+96q4a/yG683RtwCZbT7PwEnOyJE4RLyT/XvauiNTakwNRAx
         Aw/tiWXNj+esSEfALLwQI+8fouByLGfVeDTMvfEeT+Gm/bJ8wPyDo290XQqUuMKJkFHR
         27hWPfkEWX10m54cvJCqLnoko7obwfoEcC7iXLDNtJ47V1jBI+7/vuNoUUziVYOuxQ0n
         rQjsElSDB7hRWJEmGzrfRx+Zf8tgkGuRuk5RFuTPt/ed6Mn5ZJowFA6XTM5/N8hGNRM4
         CEVplrnfl4pKqxFEe6ZL/kVBQjr9b426vr8R6JRyvk4199cgK6qr+mjWfYe0HpQQtjo3
         BlRQ==
X-Gm-Message-State: AOJu0YzRg6vNORzlmfwTVqql40JCtZnuicr+tzS2bsNtRkUtMpxDuzLo
        osocKBGLdGhOUjHx/ZiZwSWzKeyLRQ4ahJn4eQIzrnAPvavByvLcnTY=
X-Google-Smtp-Source: AGHT+IEyLK5w2EfQvefblMOe1KUYzBa/9AVnRDeL+Ut6bf+JBgWjwLbElfH0D8BGNdeScufwUK1hsKQJF+zOJRBa99Y=
X-Received: by 2002:a25:7714:0:b0:d07:b677:3349 with SMTP id
 s20-20020a257714000000b00d07b6773349mr1369288ybc.25.1694700590048; Thu, 14
 Sep 2023 07:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
 <CAPDyKFoENVp7+VjKkPpJWDecowxYD=QM6TSa6HjyzOZ=z7r81w@mail.gmail.com> <CAL_JsqLxxmdPTLhZ6MTfuAcM0V7pmfRLiK8L3AZhhQKcvy_PCw@mail.gmail.com>
In-Reply-To: <CAL_JsqLxxmdPTLhZ6MTfuAcM0V7pmfRLiK8L3AZhhQKcvy_PCw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:09:14 +0200
Message-ID: <CAPDyKFo-KXK37iRwXZ631MH6L5_RbaezGUz5GAn8cVt4OzOApQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] Missed starfive pmdomain changes for v6.6, now for v6.7
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>, arnd@arndb.de,
        changhuang.liang@starfivetech.com, jiajie.ho@starfivetech.com,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        walker.chen@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Sept 2023 at 15:57, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 13, 2023 at 5:31=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 13 Sept 2023 at 15:56, Conor Dooley <conor@kernel.org> wrote:
> > >
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Hey Uffe,
> > >
> > > Here's those missed changes in patch form. I figured it might be a bi=
t
> > > easier this way given the name of the subsystem is in flux, doubly so=
 if
> > > you'd like to put the header change of Rob's on fixes.
> >
> > Not sure we really need to queue up patch 1 for fixes - or is it
> > fixing a real problem for us?
>
> It's a dependency to remove some implicit includes, but I still have
> more fixes for 6.6 so either is fine.

Okay, I keep it for v6.7 then. Just let me know if things change then
I can move it to v6.6-rcs

Kind regards
Uffe
