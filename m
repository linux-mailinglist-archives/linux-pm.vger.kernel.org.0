Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A650B7CC6F
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 21:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfGaTDk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 15:03:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:55670 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfGaTDj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Jul 2019 15:03:39 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3A12D6D9;
        Wed, 31 Jul 2019 19:03:39 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:03:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/26] docs: power: add it to to the main
 documentation index
Message-ID: <20190731130338.6de6c5d7@lwn.net>
In-Reply-To: <5417112ea7a391e6622c46bf833b7d6a5725c158.1564145354.git.mchehab+samsung@kernel.org>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <5417112ea7a391e6622c46bf833b7d6a5725c158.1564145354.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Jul 2019 09:51:11 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> The power docs are orphaned at the documentation body.
> 
> While it could likely be moved to be inside some guide, I'm opting to just
> adding it to the main index.rst, removing the :orphan: and adding the SPDX
> header.
> 
> The reason is similar to what it was done for other driver-specific
> subsystems: the docs there contain a mix of Kernelspace, uAPI and
> admin-guide. So, better to keep them on its own directory,
> while the docs there are not properly classified.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

So this one went upstream with the PDF fixes pull, right?  I'm a little
surprised to see it here now.

Thanks,

jon
