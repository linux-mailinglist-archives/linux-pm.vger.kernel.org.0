Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E35C35893B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhDHQF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 12:05:56 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:44000 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhDHQFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 12:05:55 -0400
Received: by mail-oo1-f53.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so621861ooa.10;
        Thu, 08 Apr 2021 09:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89GBzc2bbepFcIw25Q1AatCj5mIj6s7KJYpVy/c3qPA=;
        b=P0t8He/1VAEjZ7GKaTsvjk/ibBrjeSyB1+JRlXczLxC3pLPfeSdH90fsqsugwyFk09
         lKr2Dj6WyOim0F7CVlSLfraAwKjUi9+u6+RAu+7TTBA0NGAOU0B4Nk8WjwKoNyYbA4+M
         1nm44J6lSFfkYILeSKdUK5YM+wGPmfFA04/76QBY8MQZaY9DnlsagVKxJxlzlOYut0o1
         d4fKjHqRrdFh44zQiR8iMjiIEVf87ExPcllkqm5qd8xFMHbXU+VmVcMCZik+SifkDLMi
         q0njsoEc2j1Tb79nW0UQlmqbk/bBq/W3M4NEeSRi3lQuK6xg2KPieIZJ6IXihy5rMF55
         9YeA==
X-Gm-Message-State: AOAM531I8Zqa8n8k3dLoVW/klZv6g72QU36fxwrTkT0HY4glPrxaSxaQ
        /XDC/0xMwJGVjy1Z7on4cxLbychzpO46HnqpDzY=
X-Google-Smtp-Source: ABdhPJzEV++CuhlA2YB8TcryrXXxfR5W+L9v5/DP3P/8iIkl8mXys5IFjX8yHkHEpgm9HpOWMh5BKf7s03p90uLLd18=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr8131686oou.44.1617897944147;
 Thu, 08 Apr 2021 09:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210408131506.17941-1-crecklin@redhat.com> <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
 <YG8gqZoZGutPmROz@sol.localdomain>
In-Reply-To: <YG8gqZoZGutPmROz@sol.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 18:05:33 +0200
Message-ID: <CAJZ5v0g65irXKmy7pdgD8-5KWrxdtwiWbJsBD2A=PKf1D3RVZg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, Simo Sorce <simo@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 5:26 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Apr 08, 2021 at 03:32:38PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 8, 2021 at 3:15 PM Chris von Recklinghausen
> > <crecklin@redhat.com> wrote:
> > >
> > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > integrity check and is not available. Use crc32 instead.
> > >
> > > This patch changes the integrity check algorithm from md5 to
> > > crc32. This integrity check is used only to verify accidental
> > > corruption of the hybernation data
> >
> > It isn't used for that.
> >
> > In fact, it is used to detect differences between the memory map used
> > before hibernation and the one made available by the BIOS during the
> > subsequent resume.  And the check is there, because it is generally
> > unsafe to load the hibernation image into memory if the current memory
> > map doesn't match the one used when the image was created.
>
> So what types of "differences" are you trying to detect?  If you need to detect
> differences caused by someone who maliciously made changes ("malicious" implies
> they may try to avoid detection), then you need to use a cryptographic hash
> function (or a cryptographic MAC if the hash value isn't stored separately).  If
> you only need to detect non-malicious changes (normally these would be called
> "accidental" changes, but sure, it could be changes that are "intentionally"
> made provided that the other side can be trusted to not try to avoid
> detection...)

That's the case here.

> then a non-cryptographic checksum would be sufficient.
