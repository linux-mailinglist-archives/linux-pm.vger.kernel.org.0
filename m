Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83435F22F1
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 00:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbfKFX7M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 18:59:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43406 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfKFX7M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 18:59:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id j5so69385lfh.10;
        Wed, 06 Nov 2019 15:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DYf8aAMmRvjXUQpfphEhKk+3TLfQLLQK5Utz/xmwQg4=;
        b=eNEWXheYDRU8KdxiR6Eq6OKP9rbfiwIXWnSwfYK3lptAs0cRbbRl01t9JcVXalaIh5
         y5sxUuHGokzteBEcjK8mBHHkoLq7JHMnn23V5W2mJhBUiIUgrvl3oF1pq+sr1z6cBJxv
         w3eHDjFYfJezAaK/NsMEUKVVIZJ5TFDG0We2gyWI/AhQ9SkdJVHsJ0ZneMp9Jx+SgXap
         z+nmvDEKuEG02F8kN6/mSP+9g9L/m4RB4Wh4NGMx1ahdpnOvw+Wkbk/+oPC0sNKgqNHa
         y7BNrhoLlxgtUoxnGZN71FSRLbeSQtVJfsGUeU2dF8SNF0Z5rBiZap12A/JP43u9aKuf
         FaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DYf8aAMmRvjXUQpfphEhKk+3TLfQLLQK5Utz/xmwQg4=;
        b=SqkNxOm9mNNmMAaYq8NtzL+t8ik8a+7v4+MP8MbZprxUKbwjkSX39EkSDwbvWmBVd3
         4ItxkcdAjvC9Vytfni3NHfoXcu1p291bWS6R8acEqMha7X/60KvP9CGVScK1Ep3CkBJ7
         6D28jrG+TOVK/6t54tcEs1KSwy8PuW5QJcHg1PQrzCQgAHakN5sSayq3CQqhO+cpMmnA
         hHxRRRWyMi/5MmeEmzx9za2Vy5jPZD2SsZFtPYYXyGyLs/5DKpD8eqCigPla1MDN32hQ
         M6UY5UisbQ7cu2YJUMNPzM1vDIcI1UwrkHP91nVJEYyR7PeLjYjy4jxOcNNAbfQyMUU3
         VUIg==
X-Gm-Message-State: APjAAAXCrBTX2BgJnHkFmcBMdwPhGoF0cJIV3WxPGDrVBivSrvA1L8Qu
        TtUmQC0PnUgXQ/FK2B+Oub/25IL8wlYao8mC1/k=
X-Google-Smtp-Source: APXvYqztjgeRQgd01HKyl8vySOmEV7cS+8kabNLlMrm2GoVNxgvas+z4ZglnjF6coc9mkDxpziUQPrtI7QW8056NeqM=
X-Received: by 2002:a19:6454:: with SMTP id b20mr69757lfj.159.1573084748421;
 Wed, 06 Nov 2019 15:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20191029223214.18889-1-linux@roeck-us.net> <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
 <20191106212921.GA7020@amd>
In-Reply-To: <20191106212921.GA7020@amd>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 6 Nov 2019 15:58:56 -0800
Message-ID: <CAFXsbZrGudirV7j9=h_BHG3HGAVs_zGRpgz7J4DRy2SxioVvLQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Keith Busch <kbusch@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >
> > This looks fine to me, but I'll wait a few more days to see if there ar=
e
> > any additional comments..
>
> User wants to know temperature of /dev/sda... and we already have an
> userspace tools knowing about smart, etc...

At least for my use cases, being able to use the thermal subsystem of
the kernel to cool things down when the SSD gets too hot is important.
Is there a way to do this with userspace tools feeding back to the
kernel's thermal subsystem?

>
> pavel@amd:/data/film$ sudo hddtemp /dev/sda
> /dev/sda: ST1000LM014-1EJ164: 48=C2=B0C
>
> I see we also have sensors framework but it does _not_ handle
> harddrive temperatures.
>
> Does it need some kind of unification? Should NVMe devices expose
> "SMART" information in the same way other SSDs do?
>
> Best regards,
>                                                                 Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
