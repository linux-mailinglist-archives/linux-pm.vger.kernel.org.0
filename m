Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0657CC9C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 21:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfGaTQT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 15:16:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbfGaTQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 15:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FgaF9lM7xfyfcZy3IOXSwiz5WCzyc5sql4EmtR8rNUo=; b=EoH8TFO7oViPkyjnauS6zNinP
        /IbB1vIQAamYawQ9ZvngjTA+Og5F1MiZ901K8+Sh+9t4TErTHY/wVTVkXyXxLweXdIrDU3FJ0kbmF
        6j9ElXg3xi06XeC02/hMF9Ly9ikogRWEyjbsBViCcEhvN/F1YQsu1z0ozoftCRf9BwQlH/inLT+HJ
        mMDBfH7H+V1drTeGDnyV9L06U2wv1WDQwExb8R3TtTS3+p9dt61zV2nJl2appdTctBK1W/KWSTYRl
        xJIjRZbZyECeZZ47XWVAnCd6ykeohOc//FqQZr4+5SCAX7ITNfTWP+McEGUicn1F22Asxm92PfUHm
        Q6E/LczaQ==;
Received: from [191.33.152.89] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsu56-0002vG-Bc; Wed, 31 Jul 2019 19:16:12 +0000
Date:   Wed, 31 Jul 2019 16:16:06 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/26] docs: power: add it to to the main
 documentation index
Message-ID: <20190731161606.2572a567@coco.lan>
In-Reply-To: <20190731130338.6de6c5d7@lwn.net>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <5417112ea7a391e6622c46bf833b7d6a5725c158.1564145354.git.mchehab+samsung@kernel.org>
        <20190731130338.6de6c5d7@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Em Wed, 31 Jul 2019 13:03:38 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri, 26 Jul 2019 09:51:11 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>=20
> > The power docs are orphaned at the documentation body.
> >=20
> > While it could likely be moved to be inside some guide, I'm opting to j=
ust
> > adding it to the main index.rst, removing the :orphan: and adding the S=
PDX
> > header.
> >=20
> > The reason is similar to what it was done for other driver-specific
> > subsystems: the docs there contain a mix of Kernelspace, uAPI and
> > admin-guide. So, better to keep them on its own directory,
> > while the docs there are not properly classified.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org> =20
>=20
> So this one went upstream with the PDF fixes pull, right?  I'm a little
> surprised to see it here now.

Yeah, this specific patch went together with the PDF fixes.=20

The remaining ones in this series aren't there yet.

=46rom this series, besides this patch, you can also exclude patch
25/26, as it seems that Paul will merge via RCU tree.

The remaining ones apply cleanly on the top of docs-next
(I tested applying them on the top of your tree yesterday).

Thanks,
Mauro
