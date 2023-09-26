Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B047AEB5E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjIZLW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 07:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjIZLW6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 07:22:58 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7428AFC
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 04:22:50 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a1ec43870cso2339477b3.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695727369; x=1696332169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSgW4LX4JUbEA5D+qEqJf6N354eXZcLyKCwAX5DR+2c=;
        b=dle482l1tTgRfVkL6hNAanIXy7t1HhSmXrKW/5vRpCEyOoU3NXKL1FcFe3m5/bSCf9
         0QDL2AR97X06juyHC+4O5MT1huVVnIhDkAQyArMDBPOHQF7LzgwtEdFfVGCZXtcOM4d7
         SaiyLnZgldWLZnQHHogXLCzTaCd1oo1I+cKhkBKDAhp2aGmQ23FSZsZoAJcrRG9mHYDS
         q50EI/CCWWWOCqm7++ky0nmlZC+fj4ugLN8NM10iVzu64xfw+NynXjmoR7mfkObuaCfX
         THY/IIvr0WHzDDmIKZ/0yNhvi1VQ2QQMszjzu07NH/9DrB31YVUY2qo+5l2GvI9IBbNh
         0a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727369; x=1696332169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSgW4LX4JUbEA5D+qEqJf6N354eXZcLyKCwAX5DR+2c=;
        b=QehjBcb9c6aj6GuaBvsRW+LjDSyKJeiIGbCb6GZXOfeIrCxwjGJTQff4Rxd8L7bybt
         tCYcANB51P3DRzBgi2DZRlMcMWiTlQ8BZ7BDL4F/lQ4HzEYjE/v0jGCyHOHj6kFOn89R
         yeWlf6qJE368W6JlpOamnv+QkBtdeO2urgffXpKbtEMe3WmKBMmXL+VAOk/IMGvh3jA3
         k1ah7sv+5PIKglyj2Efr/BMV7oSYrGt/HWhfdD9WSm8jy+uqvWOryjBMquBNlV5Lqwfm
         1+z8ncd9TSPs1r71KmxsZ61Cwz4pCfwxfmovvpZbXfORgryGRPnHAePPT1hZr4ps9cNK
         BoZA==
X-Gm-Message-State: AOJu0YzAGyRDga0IPAwhszBq0XHs5G/JArclPORuK5hR+VwkVYW8yl+B
        sDNIk8NNEylmR4rdkEmrMw30YsCAo/CakWC3p/lUN/NjP937ToqM
X-Google-Smtp-Source: AGHT+IF8+EP3qKO3+6vQiu7ilfzf8MAEdMbrx81nCcCeCherlXFPx5hr18Is6Hj+3VgIvZcu1mBSNS/hy/9TBb4Lssc=
X-Received: by 2002:a25:943:0:b0:d78:30b2:78f3 with SMTP id
 u3-20020a250943000000b00d7830b278f3mr8940351ybm.45.1695727369620; Tue, 26 Sep
 2023 04:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-void-drivers-soc-renesas-rmobile-sysc-v1-1-6648dfd854de@google.com>
 <CAMuHMdWiC4v9fctp18bRrEH-m_-0VjMg9+XpON8vdRYwniTU3g@mail.gmail.com> <CAMuHMdWk_jcZ1V7J68bw11YZ+EjEqAWOKHzanVyxo2zktbMteg@mail.gmail.com>
In-Reply-To: <CAMuHMdWk_jcZ1V7J68bw11YZ+EjEqAWOKHzanVyxo2zktbMteg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Sep 2023 13:22:13 +0200
Message-ID: <CAPDyKFqgsHYz1hfOQ=KniNJj+u7ZSMoxS03Rixj1n2AOUdSVaQ@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: fix -Wvoid-pointer-to-enum-cast
 warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 18 Sept 2023 at 11:21, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>
> Hi Ulf,
>
> On Wed, Aug 30, 2023 at 10:24=E2=80=AFAM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Aug 15, 2023 at 12:11=E2=80=AFAM Justin Stitt <justinstitt@goog=
le.com> wrote:
> > > When building with clang 18 I see the following warning:
> > > |      drivers/soc/renesas/rmobile-sysc.c:193:22: warning: cast to sm=
aller integer
> > > |               type 'enum pd_types' from 'const void *' [-Wvoid-poin=
ter-to-enum-cast]
> > > |        193 |                 add_special_pd(np, (enum pd_types)id->=
data);
> > >
> > > This is due to the fact that `id->data` is a void* and `enum pd_types=
`
> > > has the size of an integer. This cast from pointer-width to int-width
> > > causes truncation and possible data loss. Instead, cast to `uintptr_t=
`
> > > which has the same width as void*.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> >
> > scripts/checkpatch.pl:
> >
> >     WARNING: Reported-by: should be immediately followed by Closes:
> > with a URL to the report
> >
> > Hence changing the Link: tag to a Closes: tag.
> >
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Note: It should be noted that there is likely no data loss occurring =
in
> > > this case since the enum only has a few fields. The narrowing cast fr=
om
> > > pointer to int will not lose any data.
> >
> > Indeed, the theoretical narrowing could only happen on a 64-bit
> > platform, while this driver is only used on arm32.
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.7.
>
> As the Generic PM Domain providers were moved to drivers/pmdomain/
> in v6.6-rc2, and now have their own maintainer, I have moved this
> commit from renesas-drivers-for-v6.7 to renesas-pmdomain-for-v6.7[1],
> with s/soc/pmdomain/ in the oneline-summary.
>
> Ulf: if you prefer, you can still take this patch directly.
> Else I will send a PR after rc3 and/or rc5, like I do with my other
> renesas-<foo>-for-<version> branches.
> Thanks!

Apologize for the delay, been traveling lately. Anyway, I can
certainly pick up the patch and carry it for v6.7. Just let me know,
if/when you have dropped the patch from your tree.

[...]

Kind regards
Uffe
