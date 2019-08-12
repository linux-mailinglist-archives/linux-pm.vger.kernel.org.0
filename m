Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA278A4B7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHLReo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 13:34:44 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41928 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfHLReo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 13:34:44 -0400
Received: by mail-vk1-f194.google.com with SMTP id u64so20870530vku.8;
        Mon, 12 Aug 2019 10:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCsKdiFdCyUb9h1XpQVRtFcaXFlzTncnJBLcRKOgyMM=;
        b=AnxMh+t8b0773ZzHDr31aS5lKDV9T9SzVCmQT/Sw3iVpt8oCqyN202akVsNfKec/4B
         dep1gbQs/pKoJxl532mIRPpFyXSYpmNB+Lot3bcgzemFI4D5rIhrxkSNvCqyurS5nV79
         ANj/uRGKGnw2Wv/3MDh82P52VMctHhOvyvjERGzOWPfrqwqHB4eEoHiYIhhm+waYyoIR
         omYnxcomRI3zXRyWB+vMFC4c9HKDF9sqSAtf46SV/nnyQC+ep262OZzJQsX+YcrOtyR6
         70wUaMV3/vKtHf7K8X860ADjdACgnZoWdMgxzxyTfpllnlMq0oL5fL1SQTllwijfxt0k
         d9IA==
X-Gm-Message-State: APjAAAVctJ51NxmI66r0mPP54LQ/en4JATnnaP+/KNYKBOF9FMOK0uwv
        Moc5ohwGFZZ2fds4ElPcR54LFKuf2MkW6XUFIzs7KGxxXVMbUA==
X-Google-Smtp-Source: APXvYqzcrQcBsk0/Yrys6c8GgXQrSpsNz4FqdTvJYCSbqFE1AU6tZPX+nx2Ca0ELNiwlAPTAwEcFEPS8L5YbFKICUH4=
X-Received: by 2002:a1f:d687:: with SMTP id n129mr12600410vkg.71.1565631281261;
 Mon, 12 Aug 2019 10:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190809002104.18599-1-stancheff@cray.com> <20190809002104.18599-2-stancheff@cray.com>
 <CAK7LNAScm9P+QMZiqqSQnOoPsN54OTcTGpaDgxTbjJ_knoeGhA@mail.gmail.com>
In-Reply-To: <CAK7LNAScm9P+QMZiqqSQnOoPsN54OTcTGpaDgxTbjJ_knoeGhA@mail.gmail.com>
From:   Shaun Tancheff <shaun@tancheff.com>
Date:   Mon, 12 Aug 2019 12:34:30 -0500
Message-ID: <CAJ48U8Xp40is+R1dMW8sXq77ZS5D_h+hHte5Mq5eOrtpb41Qxw@mail.gmail.com>
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

On Mon, Aug 12, 2019 at 10:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Aug 9, 2019 at 9:21 AM Shaun Tancheff <shaun@tancheff.com> wrote:
> >
> > When building a tree of external modules stage 2 fails
> > silently as the root modules.order is empty.
> >
> > Modify the modules.order location to be fixed to the
> > root when KBUILD_EXTMOD is specified and write all
> > module paths to the single modules.order file.
>
> Could you try v5.3-rc4 please?

So it seems we are using 'subdir-m' but that is now gone?

Is there a recommend pattern for backward compatibility?

Thanks!
>
> > Signed-off-by: Shaun Tancheff <stancheff@cray.com>
> > ---
> >  Makefile               | 1 +
> >  scripts/Makefile.build | 8 +++++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 23cdf1f41364..a9964492f47e 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1622,6 +1622,7 @@ $(module-dirs): prepare $(objtree)/Module.symvers
> >
> >  modules: $(module-dirs)
> >         @$(kecho) '  Building modules, stage 2.';
> > +       $(Q)$rm -f $(KBUILD_EXTMOD)/modules.order
> >         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> >
> >  PHONY += modules_install
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 0d434d0afc0b..f9908b3d59e0 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -64,7 +64,13 @@ builtin-target := $(obj)/built-in.a
> >  endif
> >
> >  ifeq ($(CONFIG_MODULES)$(need-modorder),y1)
> > +ifneq ($(KBUILD_EXTMOD),)
> > +modorder-target := $(KBUILD_EXTMOD)/modules.order
> > +modorder-add := >>
> > +else
> >  modorder-target := $(obj)/modules.order
> > +modorder-add := >
> > +endif
> >  endif
> >
> >  mod-targets := $(patsubst %.o, %.mod, $(obj-m))
> > @@ -423,7 +429,7 @@ endif # builtin-target
> >  $(modorder-target): $(subdir-ym) FORCE
> >         $(Q){ $(foreach m, $(modorder), \
> >         $(if $(filter %/modules.order, $m), cat $m, echo $m);) :; } \
> > -       | $(AWK) '!x[$$0]++' - > $@
> > +       | $(AWK) '!x[$$0]++' - $(modorder-add) $@
> >
> >  #
> >  # Rule to compile a set of .o files into one .a file (with symbol table)
> > --
> > 2.20.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada
