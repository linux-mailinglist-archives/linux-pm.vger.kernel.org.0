Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6417338E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 10:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1JOS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 04:14:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1JOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 04:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=ABQ/PPo1SyiNv8cj/FKAzTk1cr6OrMdoykpYE3I4QAw=; b=jC8RONz2FazLAGP12/noAgSXEt
        wHKhA0l5vUvx4U182++Ls21TleVx1FQYcu82li60d1O3fNXqW2+f9Gt2oCZyBstt1lItso22h0pZq
        5WUN3YY/wqBu1AF+txAZcIM6R6DZ1h0Dspbkw5AgHevLudrlk0iyA/ly2sAdkghnYuJxAQ3vsYd+Z
        sp99AYkoKALWi0wAlBARP+fhc9Ma/AtPBLJk/KShw164EFpqwEKbeyAG+WiJg+YNfT/s/OCAAx6vh
        mySkb8YYivWB2Ucu2Z9J6LHHgfcNk9ugqVUzlksZHXtAvpndeeQHPxSbMwd7Lm5FEZSd4VqyO9nLt
        Q8YKRl+g==;
Received: from ip-109-41-131-202.web.vodafone.de ([109.41.131.202] helo=onda.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7bir-0007du-0w; Fri, 28 Feb 2020 09:14:17 +0000
Date:   Fri, 28 Feb 2020 10:14:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 14/24] docs: cpu-freq: convert index.txt to ReST
Message-ID: <20200228101412.5b57c427@onda.lan>
In-Reply-To: <CAJZ5v0jsQ51cp3LQ8qjmMj6tZJPC=t9Y_5SN78fLWe0mpJX08g@mail.gmail.com>
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
        <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
        <CAJZ5v0jsQ51cp3LQ8qjmMj6tZJPC=t9Y_5SN78fLWe0mpJX08g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Em Mon, 17 Feb 2020 21:06:20 +0100
"Rafael J. Wysocki" <rafael@kernel.org> escreveu:

> On Mon, Feb 17, 2020 at 5:20 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > most of the stuff there can be re-used with ReST format,
> > but we need to add an empty TOC and remove the existing
> > entries, as the following conversion patches will be re-adding
> > them, as they're converted. =20
>=20
> I see a very little value in converting the files in the cpu-freq
> directory from .txt to .rst, which I have told you at least twice.
>=20
> They are just old-style driver API documents for cpufreq, but moving
> them under driver-api/ as they are would not be a good idea IMO,
> because at least some of them are outdated (note that the admin-guide
> part of the cpufreq documentation, in the .rst format, is located
> under admin-guide/).
>=20
> I haven't had the time to write a proper replacement for them yet and
> honestly I find it quite obnoxious to see these reoccurring attempts
> to blindly convert them to .rst without taking care of their contents
> and location.
>=20
> I will take care of these files at one point as promised, but that's
> not going to happen today or tomorrow and please just leave them alone
> if that is not a big deal.

Sorry, I completely forgot that you asked to skip the old cpufreq docs.
My bad!

The thing is that I have now fully converted all docs to ReST (with a
handful exceptions for things that may not make sense to convert, like
configuration files that ends with .txt).

As a matter of helping those (like me) that are trying to finish this
huge conversion/reorganize task, I would very much prefer to keep those
files converted somewhere (or trashed, if their contents is now completely
garbage).

One of the things we discussed at linux-doc ML is to create a "staging"
area where we can place:

- things that aren't ready to be at the main documentation body yet;
- too obsolete docs that may require major work;
- things that we didn't find a good place to put yet.

=46rom the last discussions, it seems we reach a consensus about creating tha=
t.

So, I should be preparing a separate patchset adding a Documentation/staging
dir.=20

Would it be OK for you if I change the cpufreq patches on this series to
be moving those into a new Documentation/staging/cpufreq directory?

Regards,
Mauro
