Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A5813A56C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 11:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgANKHc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 05:07:32 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40431 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgANKHb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 05:07:31 -0500
Received: by mail-wm1-f47.google.com with SMTP id t14so12967679wmi.5
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1+lSOJ02OVX3YT6g7066pemLn3Yqrwk342Rp+oY/5V0=;
        b=VQ4Mui+lUW2MrxjWen9nR8vJngQ31b9sTsv/TfXEulKdvQVLYqMhsbsQVf4HaNoC+A
         ks091jrnpiTdWelOyuhdceCf4n5mnwew8zvwCqKN4bJmkRgoxnEMU6aSfYGuKWBrbs9w
         L/8ZTOVCSI43LMonIwjg5jNjNULreksDU8hbF+INV2ZZgVFIlVKQBNSYFV+oElXt1CoZ
         q7p0NtzZ7KVJPOs14gnqZDkJnSZzmuMDGL+WeT715PyirAT/YjDfEik4XdByzGHmlPnx
         CY9SK+E6eRKqBomD4uavDJi6eWBav0YgxVhO0eZnLZJQ4kv8BwLZ0n2QL07/wGrzriBJ
         1IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1+lSOJ02OVX3YT6g7066pemLn3Yqrwk342Rp+oY/5V0=;
        b=Ui2jjG74cfS1u9tmT6YyCdphJD62gL+Itfw0mSmyyt6vgHN7+Jz4Gr61Q84j+ZX9bG
         fy+atg3mRvFSX1s91k8t152gi7WKBuss6/NuWv0QjROlHEl7CGW+1O+JXSevStv/xMYB
         eRUXo6aQU8hroLfPr/1PVhVw2FxyxOJq+n4t5qF4FCyy5sse7JVNF6Igk7NOQKM7GxlX
         nmZb6Gg0zhoUhTdziPviUPAkwTradF+S+ihMUpFAI0SfR6mU/Bhi1KjTsykch5Tgc7TT
         SGTjCPCxDXu1cNaEdVSKdyn/G9brAFnxto0vEl+xd64X6uv7KohO057dwpjEdmdy2IS2
         CxBA==
X-Gm-Message-State: APjAAAXePLLAeijwcpdFsEDiH3ihV2sUc2NEmY8pxQDpOLr9YCFjWFIU
        wgNR7uR86oF80a4YVxYP63OoINDKQovY6ypeSZqpTw==
X-Google-Smtp-Source: APXvYqxy0RpB/nt/jc6EA9ztk6i6WDr9odhU4lbUOGxvph7YggwiBT3Ij+MwVQ09c9nENpgej0sHDvhojl9gRgYiuCM=
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr407712wmj.175.1578996449850;
 Tue, 14 Jan 2020 02:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20191223211309.GA4609@sig21.net> <20200113092604.GA26365@sig21.net>
 <CAG_fn=WSUGq_UZZOCQRbaKDE01yA6dLLqToOBWZ=0s5uxMwatw@mail.gmail.com>
 <CAG_fn=V0nTqsFxYAuH0K3cJxx3nWitG50VkYOQ8MHNO+H8hfKQ@mail.gmail.com> <20200113171557.GA8544@sig21.net>
In-Reply-To: <20200113171557.GA8544@sig21.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Jan 2020 11:07:18 +0100
Message-ID: <CAG_fn=UgU3vibsaug6p35Xs1dzLgBecA48t-PqS9OtRTHNu54g@mail.gmail.com>
Subject: Re: init_on_free breaks hibernate
To:     Johannes Stezenbach <js@sig21.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.cz>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 6:16 PM Johannes Stezenbach <js@sig21.net> wrote:
>
> On Mon, Jan 13, 2020 at 04:41:27PM +0100, Alexander Potapenko wrote:
> > > Resuming doesn't work for me in your setup with upstream kernel and
> > > init_on_alloc/init_on_free disabled.
> > > To hibernate, I did:
> >
> > Ok, I've managed to resume by running QEMU with -append "... resume=3D/=
dev/vda".
>
> Strange about the resume=3D/dev/vda, it worked for me the way I described=
 it.
> Maybe device numbers are dynamic, 254:0 is what I got from ls -l /dev/vda=
.
Indeed, for me it's 253:0, and resuming from console works with that number=
.

> > The memory corruption is also reproducible for me, taking a look.
>
> Great!
>
> Johannes



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
