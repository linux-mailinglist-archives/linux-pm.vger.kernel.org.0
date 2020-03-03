Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320A91777E6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgCCNzB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 08:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729248AbgCCNzB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 08:55:01 -0500
Received: from onda.lan (x2f7fa80.dyn.telefonica.de [2.247.250.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657E320675;
        Tue,  3 Mar 2020 13:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583243700;
        bh=aL/HI0DDKlm/j/mIOIBL+d0TfZwS00SOm5iobK/Rlh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ne50dIHDiWbn+MqOVzT1GtckgXE/Pwkwk95hu3Q3zfp0wsqhFITnmtQQsSKaQ4KSG
         J5ihBqKh++/DEl3EYxtc0sEPqEvdidFsAg8MPR0h58nzQ0z+slLlUu6hJzuGnIQDF1
         Nd9JVu/bvakqKGYfFE/a/ApZHsi/+EJwFONv18Wo=
Date:   Tue, 3 Mar 2020 14:54:56 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 14/24] docs: cpu-freq: convert index.txt to ReST
Message-ID: <20200303145456.46c50f17@onda.lan>
In-Reply-To: <CAJZ5v0jOXFqkm4g=_WrZo6S-LBrWuqhckS7Yn29nE6hCfZCVzQ@mail.gmail.com>
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
        <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
        <20200302141916.1c6d8abe@lwn.net>
        <CAJZ5v0jOXFqkm4g=_WrZo6S-LBrWuqhckS7Yn29nE6hCfZCVzQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Em Mon, 2 Mar 2020 23:16:10 +0100
"Rafael J. Wysocki" <rafael@kernel.org> escreveu:

> On Mon, Mar 2, 2020 at 10:19 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > On Mon, 17 Feb 2020 17:20:32 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >  
> > > most of the stuff there can be re-used with ReST format,
> > > but we need to add an empty TOC and remove the existing
> > > entries, as the following conversion patches will be re-adding
> > > them, as they're converted.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> >
> > Rafael, do you want to carry the cpu-freq changes from this set, or should
> > I just apply the whole thing over here?  
> 
> I will take the ones that are applicable after rebasing on top of
> https://patchwork.kernel.org/patch/11411035/

Just rebased on the top of it (plus next-20200303) and sent.

Btw, patch 1/5 of such series is just a small fix for the above. It
addresses a Kconfig.x86 pointer to a documentation file that were moved
by the above patch. 

Feel free to merge it with patch #11411035 if you want.

Regards,
Mauro
