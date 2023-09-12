Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0253C79DBC4
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjILWTy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 18:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjILWTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 18:19:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D3C10C7
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 15:19:50 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59b4ec8d9c1so53816857b3.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694557189; x=1695161989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tKmGVB6Mvfy9DEZwN7tyTLoBZ0QSjfmL2YVCLgau6c=;
        b=LUfeTiNMnc7PJGXCK5qChR17Fi6UjXAQEbTj0Z98/oaPbxC8Dc05qs5WoAIKFwjVbA
         EHeE7lOjeTi4z3cEoAFQAwhEH1LRhMDJ+nRmmsfRVdqO0YBXOVOTSzChpLUUnka4Mgwg
         tu34u9GyFkaUzAf/DFnyEJ1EpyrS9XvONZ8irbu6tIrReUx22hGHQ7VcqJrZB02nJmgt
         LN4DQ7Hyi+OKqz603MdnEjOgf2XT/4nho7uqgZkJ+IdomHruu3bJcDD4DMZRmiFmSm4c
         I4jUU/ACHErmJQsQMJXO4fk8V2Zw6NF8rloHOl6nQkSSTZ4LpiIuPB59nMispJf6QORr
         zbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694557189; x=1695161989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tKmGVB6Mvfy9DEZwN7tyTLoBZ0QSjfmL2YVCLgau6c=;
        b=bSZgkbIVXSLUDLaLP/EnNCbd8mNuopmW5fwsKerkWyXkowI6aN2WvT4Th86cF6VZPP
         MKxEi4fB7SLIuMgLl3UQWGL80V5VkNGTip7sNhJ44Utj1I5XYHlvNrr4jt06i7krvMDa
         2tQqZg/UmjFPCIhZ7jqMxBSg9i0rrr3T7C3AYTtAfASBzTraRGJR7FXaO49NvKUrQ4em
         MtvRzARpm+jW/KrIA/zAinZAJB51Q5oL6xkQ1jf7UkgRX63zhNuXlop5lalHQY5UhdRN
         WKofOv8Nx8WwufRUx5gohLdIKs+TSVZebik+MEatHKQlfA2EKWERt2YhyYWV6tSCC9Jy
         2H8w==
X-Gm-Message-State: AOJu0YzwPUkKs6gfJV72mkghi1AN0WSJybc6uavCY/3WPcqOE6npBeKG
        mAI50Y/ZyUHtNgDdTjTXR5sBHI6g+YwCuojzQjuXbg==
X-Google-Smtp-Source: AGHT+IFiLeNSnjgZpmmgdTv96jm6J2pT52BayzOGIvFNAoKpcvCnfMU0seLr8MHIhNzj8YZ96QniefWRD+waffsjE+c=
X-Received: by 2002:a25:ed08:0:b0:d1c:bb1d:238a with SMTP id
 k8-20020a25ed08000000b00d1cbb1d238amr586222ybh.52.1694557189538; Tue, 12 Sep
 2023 15:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
 <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
 <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com>
 <CAPDyKFpUUJeGD77GTYCk59cvW=SdGTkOEXH4dap1JQWekAa0Eg@mail.gmail.com> <d1d6b2a2-8be1-4269-a504-5762b94df77a@app.fastmail.com>
In-Reply-To: <d1d6b2a2-8be1-4269-a504-5762b94df77a@app.fastmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Sep 2023 00:19:13 +0200
Message-ID: <CAPDyKFqt7UWHoiTGsg_PCdU92iFgh7p25FtCkhf5bU_0sDuD=Q@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 Sept 2023 at 15:58, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Sep 11, 2023, at 13:28, Ulf Hansson wrote:
> > On Mon, 11 Sept 2023 at 09:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>
> >> And I just realized you moved the code and Makefiles to drivers/genpd/,
> >> but not the Kconfig symbols and logic, which still lives under
> >> drivers/soc/.  So resolving that (and the name) is something that
> >> should be resolved sooner rather than later...
> >
> > In regards to the name, I am relying on input from Linus to make a
> > final decision before I send a patch. In regards to this, I have also
> > started working on a documentation patch for genpd. It needs some more
> > polishing before I can send it though.
>
> I'm fairly sure that Linus was instead waiting for you to send
> a patch or pull request for the rename. Please just pick a name
> that you like and that Linus hasn't already objected to and send
> it so the rename makes it into -rc2 for others to base on.
>
> If anyone has objections to the new name, you'll find out about
> it then, but I think we trust your judgement here.
>
>      Arnd

Alright. One can interpret silence differently. :-)

Anyway, I have followed your advice and submitted a patch. I have
queued up a couple of patches for "genpd" already, but it's still easy
to rebase them after a rename, so not a big deal for me at the moment.

Kind regards
Uffe
