Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD879E81D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjIMMew convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 13 Sep 2023 08:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMMev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 08:34:51 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D73719AC
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 05:34:47 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5733d11894dso1352801eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 05:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694608487; x=1695213287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ljq0NFVb2Hu+WPT1nFhrkMKmUcRqniuvHECzbqsDET4=;
        b=RpmhgrpKpjESUV2Qn/hHtQ1nSQP/wSUa+9q5JM77HaZxpNeMvlCIxceATq/VtSB3iH
         x8lYNbY7nHw9ZJlon4vRmY+cdvvIajskhUDV1QJ4jdReXsYX7D8sy5yoUMjqN6lwqb69
         yuZ4tlZyixXv4/TqMlcgWaiDbJaer3HMYwUSHThDpUCVCEAj0rdgGQBOnYYcNaFPmiet
         6Lf7UluKB5Xi3ers2hr9VhsaHewVJC4ZrtQFe9TGfqwjEpdViLAhLT6seMxRwaLiz7Tj
         ZLHZzvaDz1+5jBMoe4K9hag5KD02ptoWgmtzfyDbr+KrMlmxIEsCOZFSw66TT7aTxSbB
         ytxw==
X-Gm-Message-State: AOJu0YwWyDeh64FsVzPozCxUEKA7MhRQkyoxEsn+afdbYk4HJ9qkZ8FY
        b8UKww25mXsl/lkkTvNWelA4hG8WapW7gMMlN/s=
X-Google-Smtp-Source: AGHT+IG4m+WzgmU7hxodoJmqeJEPGXc9yJTo7xfZkQQWrUZY/+KZ8WUiem5kAtkNU4Mptdredp0Qi0QS90ShiUBHs+k=
X-Received: by 2002:a05:6870:501:b0:1d5:bda7:1317 with SMTP id
 j1-20020a056870050100b001d5bda71317mr2528125oao.5.1694608486745; Wed, 13 Sep
 2023 05:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230710093100.918337-1-dedekind1@gmail.com> <52419d763dbd93e91499084c2bf4c04b199857a3.camel@gmail.com>
 <33af8e4b992f766b14b3b42939f5ae7701837847.camel@gmail.com>
In-Reply-To: <33af8e4b992f766b14b3b42939f5ae7701837847.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Sep 2023 14:34:35 +0200
Message-ID: <CAJZ5v0jzJTjOE4zbVnVuhegXC7+n0eu0v9vEsSVTFc37-p29zw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 13, 2023 at 1:37 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Mon, 2023-08-28 at 19:43 +0300, Artem Bityutskiy wrote:
> > Hi,
> >
> > On Mon, 2023-07-10 at 12:30 +0300, Artem Bityutskiy wrote:
> >
> > > Artem Bityutskiy (4):
> > >   x86/umwait: use 'IS_ENABLED()'
> > >   x86/mwait: Add support for idle via umwait
> >
> > If these 2 patches are OK now, is there a chance to get them merged?
>
> Hi, I wonder if these 2 patches have any chances to get merged?
>
> May be there is something I am expected to do have not done? If so, please,
> accept my apologies and give me a direction.

I think that they were based on the Arjan\s changes that got dropped.
If so, they need to be rebased and resent.
