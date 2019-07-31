Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BE87CCCA
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 21:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfGaTep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 15:34:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:55876 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfGaTep (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Jul 2019 15:34:45 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4AF156D9;
        Wed, 31 Jul 2019 19:34:44 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:34:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/26] docs: power: add it to to the main
 documentation index
Message-ID: <20190731133443.49368cbb@lwn.net>
In-Reply-To: <20190731161606.2572a567@coco.lan>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <5417112ea7a391e6622c46bf833b7d6a5725c158.1564145354.git.mchehab+samsung@kernel.org>
        <20190731130338.6de6c5d7@lwn.net>
        <20190731161606.2572a567@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 31 Jul 2019 16:16:06 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> The remaining ones in this series aren't there yet.
> 
> From this series, besides this patch, you can also exclude patch
> 25/26, as it seems that Paul will merge via RCU tree.
> 
> The remaining ones apply cleanly on the top of docs-next
> (I tested applying them on the top of your tree yesterday).

Hmm...really?

- [PATCH v2 03/26] docs: powerpc: convert docs to ReST and rename to *.rst

	Seems to already be applied.

- [PATCH v2 07/26] docs: w1: convert to ReST and add to the kAPI group of
  docs

	Gives me the dreaded "could not build fake ancestor" error, I
	don't really understand why.

- [PATCH v2 08/26] spi: docs: convert to ReST and add it to the kABI
  bookset
- [PATCH v2 16/26] docs: fs: cifs: convert to ReST and add to admin-guide
  book

	Likewise

I've applied the others, so we're getting closer...

jon
