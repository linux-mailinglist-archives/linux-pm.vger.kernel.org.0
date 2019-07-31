Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069877CDA6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfGaUCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 16:02:43 -0400
Received: from ms.lwn.net ([45.79.88.28]:56022 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbfGaUCn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Jul 2019 16:02:43 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D82EC6D9;
        Wed, 31 Jul 2019 20:02:42 +0000 (UTC)
Date:   Wed, 31 Jul 2019 14:02:39 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/26] docs: power: add it to to the main
 documentation index
Message-ID: <20190731140239.34e3ca40@lwn.net>
In-Reply-To: <20190731165859.10b439c8@coco.lan>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <5417112ea7a391e6622c46bf833b7d6a5725c158.1564145354.git.mchehab+samsung@kernel.org>
        <20190731130338.6de6c5d7@lwn.net>
        <20190731161606.2572a567@coco.lan>
        <20190731133443.49368cbb@lwn.net>
        <20190731165859.10b439c8@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 31 Jul 2019 16:58:59 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > - [PATCH v2 07/26] docs: w1: convert to ReST and add to the kAPI group of
> >   docs
> > 
> > 	Gives me the dreaded "could not build fake ancestor" error, I
> > 	don't really understand why.  
> 
> That's new! What Sphinx version are you using?

That's a "git am" error, sphinx doesn't enter into the picture...

jon
