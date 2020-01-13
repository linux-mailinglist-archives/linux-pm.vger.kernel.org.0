Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B6213950E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 16:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgAMPlm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 10:41:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38433 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPll (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 10:41:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so10175499wmc.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 07:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zVepZqkYF5hgsjfRDiQi79JHf/R8xsj0cv9UPX8Y8Wg=;
        b=LoAGK6vauKHIa/kKGyOFfbtKghq++NrS/YeP4ba91AtUNj9T8ekcWtLW3cbbHJnrQb
         dHkJZi0oa/Wx5uY+iAgwlg0YKpWVMS5GGbYAhuTm8x1/X4jHEAZEP5qCvwB2+gGkCnMM
         uNoP2JGUsgcvHcmJOha6tFC71hENNL4NGUHrVKTj/Sr3oTNb5h+0BIKMVdaqA8r83YTP
         abiksKZIi+NM0l1e4fQrN95jdk+KZaZm3YQSV76wvJQgrNG8UhirRyFT35QnQ/zTKEPK
         BlVChDtukGGcnUA/6rBLJSKXpw2Z5B2IBY5LECJpqSpxIU6xHVYPbGqVK8J8kbiGfqIV
         FiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zVepZqkYF5hgsjfRDiQi79JHf/R8xsj0cv9UPX8Y8Wg=;
        b=fwu3yRZWxXYF+R274URJUorMg6nd9Vst6bBsRTeqv3tKo3B5Tut7rRGlsTpaINoVL1
         udKpmAhBCqjpuixjyWrah7wyNN2ENN0S4PnhIei0+sJ8FSB/KRi0BafD2BP/WnW0sW9J
         ece9R7i1lmP+XZX5IItKhkTDP5beVx/RBymPRTJ3HHN2625lfxoMD+qVH1HHi3xGegLm
         NUGbgwQvSkL1iGinKvQ6zdTbwxZ/hN0p+9ltgkY6uCgdsEoYgZjfr8EoBopTs7b4QtyQ
         BCoJjyNGtkfIZRpbBuuvVNGCX2ETK0dXiXxM3ybaFvpeTa5KoYrRbB8/xeCp53h9FqtD
         xaqg==
X-Gm-Message-State: APjAAAV2pBCQP3KfWUO+fFi1LxxzWvbRWd/KBP9i6X1hMtINcmt5BxdN
        /VrdqKE1ID4dVT3f/pGgvg5YrN7kjdU7Y6V5c/Qg/Q==
X-Google-Smtp-Source: APXvYqyLV8bFhdqaZbxzI4KlclgNJZA5IeK6uDfadwC5QDxHjswSEZtmYnp7EtvzdeqIWRtxqBgoTNK9Xgq7ppP1Ecc=
X-Received: by 2002:a1c:4144:: with SMTP id o65mr21426245wma.81.1578930099502;
 Mon, 13 Jan 2020 07:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20191223211309.GA4609@sig21.net> <20200113092604.GA26365@sig21.net>
 <CAG_fn=WSUGq_UZZOCQRbaKDE01yA6dLLqToOBWZ=0s5uxMwatw@mail.gmail.com>
In-Reply-To: <CAG_fn=WSUGq_UZZOCQRbaKDE01yA6dLLqToOBWZ=0s5uxMwatw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Jan 2020 16:41:27 +0100
Message-ID: <CAG_fn=V0nTqsFxYAuH0K3cJxx3nWitG50VkYOQ8MHNO+H8hfKQ@mail.gmail.com>
Subject: Re: init_on_free breaks hibernate
To:     Johannes Stezenbach <js@sig21.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.cz>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Resuming doesn't work for me in your setup with upstream kernel and
> init_on_alloc/init_on_free disabled.
> To hibernate, I did:

Ok, I've managed to resume by running QEMU with -append "... resume=3D/dev/=
vda".
The memory corruption is also reproducible for me, taking a look.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
