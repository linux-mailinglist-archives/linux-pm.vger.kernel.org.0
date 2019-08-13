Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374658C424
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 00:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfHMWKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 18:10:25 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45840 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfHMWKY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 18:10:24 -0400
Received: by mail-vs1-f66.google.com with SMTP id h28so73240935vsl.12;
        Tue, 13 Aug 2019 15:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTOCmMlUQI4Ou/DijdBIjbiZAWNFSaKrQKnKPO3XY8o=;
        b=TUXM+SPFHY3k76fw8TXX2rhKycxcNktfOaZmgKU4b05jYMOsBfnQTSa6wAGSzcquwc
         MvbBrJYiikbfk6Dc9dpqyEpUJFj5lG/DH3wT0dcXqDlKjhP2wLCdrS3sLblnypg1S1KW
         n3wCmdf970WgN5xOMzjyoxG+7MDhsDFKt4MDdqPcEipKympffRDhsN2tYcWFtDqdlZKL
         Bk+gEc+Ez6IUOcISTpI99hlEKKUpQCNErgLyh4+Qic3zFwvDzXiKc2YGF0iGL7hqjSHM
         uJ1wk1qJLMr1fhR1VXlxpHjW5NpZiIsm93WCxN5G3zqbFllSpm7sYPIEA/PDZHWCFCLv
         SWLw==
X-Gm-Message-State: APjAAAXsbQjFexFM55EVRuyVPjWaKNGH+pM4JcZ1MwpmJKlxQywOcQa0
        mST90q5rX68b1vg3L3etjS9HKzBUEDWCogrkif8=
X-Google-Smtp-Source: APXvYqz0UYBfkcWb8zAzxB0wr6Gyxnzd4i5JutnFy3WCLJjC4APDP1rokNzg6YVyPjaXbINByjUSBwqnadpRO9ZhE9M=
X-Received: by 2002:a67:cd09:: with SMTP id u9mr26551154vsl.222.1565734223495;
 Tue, 13 Aug 2019 15:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190809002104.18599-1-stancheff@cray.com> <20190809002104.18599-2-stancheff@cray.com>
 <CAK7LNAScm9P+QMZiqqSQnOoPsN54OTcTGpaDgxTbjJ_knoeGhA@mail.gmail.com>
 <CAJ48U8Xp40is+R1dMW8sXq77ZS5D_h+hHte5Mq5eOrtpb41Qxw@mail.gmail.com> <CAK7LNAT5OVcw9tJtaR8VE_JEemAzkqV6FeSHPEy38wotxjhkZg@mail.gmail.com>
In-Reply-To: <CAK7LNAT5OVcw9tJtaR8VE_JEemAzkqV6FeSHPEy38wotxjhkZg@mail.gmail.com>
From:   Shaun Tancheff <shaun@tancheff.com>
Date:   Tue, 13 Aug 2019 17:10:12 -0500
Message-ID: <CAJ48U8UKzGPj7JM2z2vnTDC4fT_7+X2NXVLf1T116-ym50i=xQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: recursive build of external kernel modules
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Shaun Tancheff <stancheff@cray.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 8:07 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Aug 13, 2019 at 2:34 AM Shaun Tancheff <shaun@tancheff.com> wrote:
> >
> > On Mon, Aug 12, 2019 at 10:24 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > On Fri, Aug 9, 2019 at 9:21 AM Shaun Tancheff <shaun@tancheff.com> wrote:
> > > >
> > > > When building a tree of external modules stage 2 fails
> > > > silently as the root modules.order is empty.
> > > >
> > > > Modify the modules.order location to be fixed to the
> > > > root when KBUILD_EXTMOD is specified and write all
> > > > module paths to the single modules.order file.
> > >
> > > Could you try v5.3-rc4 please?
> >
> > So it seems we are using 'subdir-m' but that is now gone?
> >
> > Is there a recommend pattern for backward compatibility?
> >
> > Thanks!
>
>
> Please convert
>
> subdir-m += dir1
> subdir-m += dir2
>
> into
>
> obj-m += dir1/
> obj-m += dir2/

After working through some local quirks everything is working now.
Thanks!

>
>
> Thanks.
>
> --
> Best Regards
> Masahiro Yamada
