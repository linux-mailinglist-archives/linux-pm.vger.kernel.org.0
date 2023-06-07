Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31FC725AF6
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbjFGJpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbjFGJpw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 05:45:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5B172B
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 02:45:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so1139726a12.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686131150; x=1688723150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79vzDiF+tHrnH1dRnmQpod9DfGlW5ryqo0lz5n79FPI=;
        b=FJamJYdT3if+5bC5MiBpMp+FFu/lOoO4qwlYSJv9n0/h/OCDUjBN+06Y5+uXbPlxGg
         WzF23UIBA7vCWADd8Vks7i2cG2U4opcA9P/78wHN/K4fj8HGhf6KnCl8YjjpgJJVnvlB
         hiZSt/O06mq6yVTGbe1Xbm78hWMDypBHvsUI14YH2ldWO/fNP5glJNykhF7/3t13XEm8
         J+PFP/ZVX+XFyUteBqBkDLqr81iNO7g4hjhPuN5y9T9TIVwh6rNLUX/Nk3vsBKiV6F+x
         GXhYFeACevO08CL9xeeLqMtmWxMOgxDUBpFi70eYskDjDqEfgVaRrrjyxsUtCDN7+EvU
         utwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686131150; x=1688723150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79vzDiF+tHrnH1dRnmQpod9DfGlW5ryqo0lz5n79FPI=;
        b=U9BAL6JjVxriOJHHRtkZno5UchCTf/RKuoAxXpTvrzogLkt9OIAz5SOKUpvGVYdTNo
         kdZ+chV2kaHr+QMdhk3T6DXhmCYL0oPD9Ecs/w6ibCECL0KiPlPfsKQV6Bzi1Ks+c8Rj
         43G4j8io9CG0yCwEC68atztexdW8O0SMt7pMTq7oB0EO8YtSAX5JA7oIrJoCp6xonedi
         D3NLxVqkQDT7yAhHiKbaYMzgGgIzjIGcRgC3IreGd/lqel4ETeyXe7yVHMPxe1Px5znd
         x/1XumisuvkO+3bkGYSDFIhTN3vlj+JVOVrvzGYD1bhPFx2AjO14NBfFBnwn3t2sLLYg
         GbFQ==
X-Gm-Message-State: AC+VfDzN8dh0ejG/H8vASJZY+XH+p8SLU6EQZBK4pg/9X0G0XnYMpkg8
        3tM1egiqQJYQsoTgmIbNif42CQby1BHiHVfPk2eh5g==
X-Google-Smtp-Source: ACHHUZ6S5zCcoB3bV8vZmXpO8sNjvRC4rvkXRPMqlcDG+MUEcxQoM5+7tlD1+Znnck9OUJnJex1d7ZYhdubt6xLn55E=
X-Received: by 2002:aa7:c3c3:0:b0:516:3261:17d with SMTP id
 l3-20020aa7c3c3000000b005163261017dmr3783303edr.20.1686131149770; Wed, 07 Jun
 2023 02:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-29-hch@lst.de>
In-Reply-To: <20230606073950.225178-29-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 7 Jun 2023 11:45:39 +0200
Message-ID: <CAMGffEk2LB0CDqR6DJczhejkkyK1Q5Ybu-wJ_fr99O0fXa-pew@mail.gmail.com>
Subject: Re: [PATCH 28/31] block: replace fmode_t with a block-specific type
 for block open flags
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 6, 2023 at 9:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> The only overlap between the block open flags mapped into the fmode_t and
> other uses of fmode_t are FMODE_READ and FMODE_WRITE.  Define a new
> blk_mode_t instead for use in blkdev_get_by_*, ->open and ->ioctl and
> stop abusing fmode_t.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/um/drivers/ubd_kern.c          |  8 +++---
>  arch/xtensa/platforms/iss/simdisk.c |  2 +-
>  block/bdev.c                        | 32 +++++++++++-----------
>  block/blk-zoned.c                   |  8 +++---
>  block/blk.h                         | 11 ++++----
>  block/fops.c                        | 26 +++++++++++++-----
>  block/genhd.c                       |  8 +++---
>  block/ioctl.c                       | 42 +++++++++--------------------
>  drivers/block/amiflop.c             | 12 ++++-----
>  drivers/block/aoe/aoeblk.c          |  4 +--
>  drivers/block/ataflop.c             | 25 +++++++++--------
>  drivers/block/drbd/drbd_main.c      |  7 ++---
>  drivers/block/drbd/drbd_nl.c        |  2 +-
>  drivers/block/floppy.c              | 28 +++++++++----------
>  drivers/block/loop.c                | 22 +++++++--------
>  drivers/block/mtip32xx/mtip32xx.c   |  4 +--
>  drivers/block/nbd.c                 |  4 +--
>  drivers/block/pktcdvd.c             | 17 ++++++------
>  drivers/block/rbd.c                 |  2 +-
>  drivers/block/rnbd/rnbd-clt.c       |  4 +--
>  drivers/block/rnbd/rnbd-srv.c       |  4 +--
Acked-by: Jack Wang <jinpu.wang@ionos.com> # for rnbd.
