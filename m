Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EACE725502
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbjFGHFE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 03:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjFGHEt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 03:04:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A55124
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 00:04:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9745c5fed21so886197366b.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686121486; x=1688713486;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p+TSFNVv5FXtju55va0ALmUKjM4M5e7S84HkiGtatA=;
        b=qYgyVxs0WMn1vKG+jxJ0y4mvKv3Thpo/ZhAqR7byxJEP5PqKStJJVS5ZMi2PW0ziFT
         TWI66pPrbWo31SXzDgMDJ73f7Pour9PbD95N3OOCPOqVNtbf6D49U6vAd5Sy4if6rCGj
         zzecH4IC0qpn242+M0y+Axo6gmqGLEwwif0No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121486; x=1688713486;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p+TSFNVv5FXtju55va0ALmUKjM4M5e7S84HkiGtatA=;
        b=cPGfNF1PhGYnCL4eSlTJJunhPBvoK9HDpld8jjlQF1gbf5AzjGvf/ax91QlSyuXVhS
         RUmURkRu/z9i0xif0C0XnpehWdZNJyar+SInakAPuxqU7GXFiF9GTTG9217VL55DU0dF
         Uhbd7mTnSORzx7pBQMjRGhOJiEr7Kilav2UKh96gJJpFGcjJ5OC4cTukDDZwHG38md/j
         JmfTEfiZDCOkr+21XAs2RgOPvtphi2G3kCArBX6CBSR7Kz8vPU2ltxQNUSKPbiP4ESY7
         wVwZZUtBj0J35O0/ssA8OgmJIH1f9jkmD6hURos2kd2lkXP0TXXM/M+0i7zxkiPI7tuQ
         Y55Q==
X-Gm-Message-State: AC+VfDwQXLfGsVj0Z6pnaj7CqJl/n3S73J4tIHx2tmRs/VCA61cf0Csu
        yD7AMOI5EpKEVkM++SWfRctftzEIJILYAUyrH3kUSw==
X-Google-Smtp-Source: ACHHUZ5O6P6Ctx7whsn/LVb52iLqxk9/bHPsrMe7SCaDvKVr1BfKXx/PamP+VSeiiK4bba/5uhaRCaR/7Mc3d8baZ+8=
X-Received: by 2002:a17:906:5d0b:b0:974:4457:b6f with SMTP id
 g11-20020a1709065d0b00b0097444570b6fmr6450613ejt.23.1686121486050; Wed, 07
 Jun 2023 00:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com> <871qiopekm.fsf@vostro.rath.org>
In-Reply-To: <871qiopekm.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Jun 2023 09:04:34 +0200
Message-ID: <CAJfpegvMNqZiNp9wWvqtgOiBHGd48C1+2ZtMt1i_gtE6v+X7fA@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>,
        Askar Safin <safinaskar@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-pm@vger.kernel.org,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 6 Jun 2023 at 21:37, Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Jun 06 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourcefor=
ge.net> wrote:
> > On Sun, 14 May 2023 at 00:04, Askar Safin <safinaskar@gmail.com> wrote:
> >>
> >> Will this patch fix a long-standing fuse vs suspend bug? (
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D34932 )
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
> > (PF_FREEZE_LATE) that is inherited across fork/clone.
>
> Is that the same as what userspace calls PR_SET_IO_FLUSHER? From
> prctl(2):
>
>    PR_SET_IO_FLUSHER (since Linux 5.6)
>           If a user process is involved in the block layer or filesystem =
I/O  path,  and
>           can allocate memory while processing I/O requests it must set a=
rg2 to 1.  This
>           will put the process in the IO_FLUSHER state, which allows it  =
special  treat=E2=80=90
>           ment  to make progress when allocating memory. [..]
>
>           The calling process must have the CAP_SYS_RESOURCE capability.[=
...]

This is the issue.   We want suspend to work without needing privileges.

>
>           Examples  of  IO_FLUSHER  applications are FUSE daemons, SCSI d=
evice emulation
>           daemons, and daemons that perform error handling like multipath=
 path  recovery
>           applications.

This looks incorrect.  FUSE shouldn't need this because it manages
writeback in a way not to require such special treatment.

It might make sense to use the prctl(2) API for this, but honestly I
prefer pseudo fs interfaces for such knobs.

Thanks,
Miklos
