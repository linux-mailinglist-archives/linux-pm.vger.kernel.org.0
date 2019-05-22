Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57801266D7
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 17:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfEVPYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 11:24:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45417 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfEVPYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 11:24:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so1482564pgi.12
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SURayyOYonfMQF3p+qt0LNX59Tqnf3GP1uPSpa/EBis=;
        b=Qr8Q2vLkgtEVbeVeIsJZbM3cdgh5VU0oITbm/ztMyPP+VS7kYsjgFkIIxRFPUZbHIZ
         1QB6lYKXLiUVt60HC7XHZRho4moOISJMLlwkBZ6oLduDNg4qx2IZa5m+Wx+YYKjuJ1Ox
         KfXTmR1ldgvWtYkzAdVM7wxFMOyGIv6p2oI/ql/jE1eN+oGCGADdusxmfZs9wyFalzqo
         bjSMcLfx0NWdCcPm7I9avDWH/DA7LnApGoeeKHrNxtDQJwxio1rjaMBi31MbLG6Qtdyd
         EW0lhwA4YJjA2vKT6ndVGwqYjwGxpoj2hw4jn0raqgGncx0MZnsInk/Vrg7UTjgkjPEZ
         Fypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SURayyOYonfMQF3p+qt0LNX59Tqnf3GP1uPSpa/EBis=;
        b=MZmhK7wdms4dnnefZwkd8t5asaooaNV9dE2gjX9o5iYWEaKtlnZuauhKwcl1/x3mwy
         L9pxplIqpFVGBs2Lqd9mSz/C/OtwSI23vuYgU/KrOf52devV2UXU9eEEjrtQe7bm7y1S
         N9NKPvOPQ6CErR4k8RD9b94xk2r3GY/VS2+kn5oEBob4WU7iXxGFOI/Vb8WvYwU8fOsm
         GDokxiD/KIpCkawog2rD+N2sFreEqJyVONYDfbj+3T2sd0WwpzeifYh80od8hUcDqK5j
         92JkTbEK4CVm5JNplPI71+APzo5NRjH6BZ5+jdBc0w8asPIX+xpizcNir8MIyzKxMG31
         pI5g==
X-Gm-Message-State: APjAAAWQNMvP2kj0t9kkgGFjwBpVksKTQgnsvxc4KBVtL/UMmgwaxEW9
        lugOK6ruYwrOEK+VlHaTuloF/mMBfk3NmCjoSQqWE2kAv7o=
X-Google-Smtp-Source: APXvYqzfc8bnKzStaA4lhtXR/bYP+SGWLUVkwwXrb5a1uPIjjrbEbr/yUMGMjoXNuecVLjRo9VVNTjJEn4xwQBH5nu8=
X-Received: by 2002:a63:d150:: with SMTP id c16mr90506891pgj.439.1558538677765;
 Wed, 22 May 2019 08:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-2-git-send-email-akinobu.mita@gmail.com> <DM6PR04MB57543310310DD72F98E361AD86070@DM6PR04MB5754.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB57543310310DD72F98E361AD86070@DM6PR04MB5754.namprd04.prod.outlook.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 23 May 2019 00:24:27 +0900
Message-ID: <CAC5umyg9_46ckKXnZG54ZyJxdpZSQm+yA9FXdW16bQW-qFkT4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] nvme: Export get and set features
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8822=E6=97=A5(=E6=B0=B4) 2:23 Chaitanya Kulkarni <Chai=
tanya.Kulkarni@wdc.com>:
>
> On 5/21/19 9:05 AM, Akinobu Mita wrote:
> > From: Keith Busch <keith.busch@intel.com>
> >
> > Future use intends to make use of features, so export these functions. =
And
> > since their implementation is identical except for the opcode, provide
> > a new convenience function that implement each.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/nvme/host/core.c | 22 +++++++++++++++++++---
> >  drivers/nvme/host/nvme.h |  4 ++++
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index d352145..c04df80 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1113,15 +1113,15 @@ static struct nvme_id_ns *nvme_identify_ns(stru=
ct nvme_ctrl *ctrl,
> >       return id;
> >  }
> >
> > -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsi=
gned dword11,
> > -                   void *buffer, size_t buflen, u32 *result)
> > +static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,
> > +             unsigned dword11, void *buffer, size_t buflen, u32 *resul=
t)
>
> Your patch is generating warnings, can we please avoid these warnings ?
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #28: FILE: drivers/nvme/host/core.c:1116:
> +static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,

OK.  I'll convert all 'unsigned' to 'unsigned int' in this patch.
