Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91E7D6ED
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 10:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfHAIIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 04:08:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35492 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbfHAIH7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 04:07:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id w20so68257417edd.2;
        Thu, 01 Aug 2019 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/A98ENoFGQr2SCQn9ABBf4M5URnbGIlXVcItSyIlQIY=;
        b=Wpfuc/Jm6RyYET0+1F4x08xRLhNOqe5AZMmhCVijzNJP0ZYLJnTwSDSFDJw4yTm9ts
         GEQJ0hM6YnpfnbAcWoA1PXGG/NunmgXCF89xCSgAx4qkFc7lBDGuN6lm3Nz3JTSNMpFw
         pAlgYEVRRXnQmVqy41rIOnkkXV1TE9BmCOMSiQpQO3QsPYXzCCgzPucE8gKyMfAGlgWP
         hiN1704KehFy0lXo+asJa+it+YSV4ckYq0QfCU8uKWBKFdcIiCPH6ivx54ru8hjqxAfm
         X/oIQPD6gH/w4WFdbmMNAWbpaL478XNI6RiZJ459MJIPGS+uN4UxDnXNmt4Gi538CCDC
         Amww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/A98ENoFGQr2SCQn9ABBf4M5URnbGIlXVcItSyIlQIY=;
        b=okGLzs99uJLZdKoWoAKbLGFpFKid41ifYOdf4qpFqFgadgvvg1J+/nTm4hQtybW/zh
         zvtPrTl0bGzYstJfTw+LdMJKtdH3xx5KIxf0YKiFzn+4Azrz6l6OFCHLyhjuGZYgY73E
         VV8vQwZ1SpMqNUK6drKXS16tyWVxPDS9EJ5tflyoj37bnDXuuZOpNt7GTyYSNw/k775s
         tqtZYdvje6tyULp2G/A5FljSTaIgZ833K6WLD95AFJck10Hd53ctlTjDZut8PHheb1dw
         +cMZeBgiyIOwKgC26yGnmmxxz8JMS/bs7fSev/22W648IgAWHXWkrmIgf1Y543maIKl1
         ErGw==
X-Gm-Message-State: APjAAAUGWj9gRhlXRvI6r3tsvjvs4i5aK6Kkdk8bsbsE4BnXI5+2BpZx
        J6LdzzNHAsSHgzZyj3Hu0wYRznuw7JK4ffIedBq8qvlyfms=
X-Google-Smtp-Source: APXvYqz1uwxLNSvD1OY5M5VgD6Oshlf7Q3vqRumXchcxbJpiZ6TcvfXvmGTOuvRZYUmwhvOYdd5AJ1jHDmJNpEIKpCQ=
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr84112001edq.124.1564646877779;
 Thu, 01 Aug 2019 01:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190729151454.9606-1-hslester96@gmail.com> <20190729191511.GB2023@amd>
In-Reply-To: <20190729191511.GB2023@amd>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Thu, 1 Aug 2019 16:07:47 +0800
Message-ID: <CANhBUQ3beB_aHMJSy9G942oUo_BT=x0w3gB3Vip_-nJxVjqu8A@mail.gmail.com>
Subject: Re: [PATCH 07/12] power: Replace strncmp with str_has_prefix
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pavel Machek <pavel@ucw.cz> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon 2019-07-29 23:14:54, Chuhong Yuan wrote:
> > strncmp(str, const, len) is error-prone.
> > We had better use newly introduced
> > str_has_prefix() instead of it.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  kernel/power/hibernate.c | 8 ++++----
> >  kernel/power/main.c      | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index cd7434e6000d..49d4bfdb2b67 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -1188,15 +1188,15 @@ static int __init resume_offset_setup(char *str=
)
> >
> >  static int __init hibernate_setup(char *str)
> >  {
> > -     if (!strncmp(str, "noresume", 8)) {
> > +     if (str_has_prefix(str, "noresume")) {
> >               noresume =3D 1;
> > -     } else if (!strncmp(str, "nocompress", 10)) {
> > +     } else if (str_has_prefix(str, "nocompress")) {
> >               nocompress =3D 1;
>
> Ok, old code is bad, too... but this makes the error visible. We do
> not want "noresumenextmonday" to set noresume =3D 1, right?
>

I am not clear about the semantic of the code.
Therefore, what is the right way to fix this error?

>                                                                 Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
