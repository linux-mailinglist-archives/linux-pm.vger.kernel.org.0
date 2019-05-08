Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC017672
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfEHLJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 07:09:55 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49746 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfEHLJz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 07:09:55 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id C28EB25AF6B;
        Wed,  8 May 2019 21:09:52 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B47929403E0; Wed,  8 May 2019 13:09:50 +0200 (CEST)
Date:   Wed, 8 May 2019 13:09:50 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH repost] thermal: rcar_thermal: update calculation formula
 for E3
Message-ID: <20190508110947.wtkhj6p45zumzaxz@verge.net.au>
References: <20190418071514.13027-1-horms+renesas@verge.net.au>
 <20190418081209.GT28515@bigcity.dyn.berto.se>
 <CAMuHMdVX5t-Q5tM5bj95muAZ+8+phohtQSsAO-rCeCofiqVMKQ@mail.gmail.com>
 <20190426095511.tkgbxkf43psesgkv@verge.net.au>
 <20190507221446.GB16573@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507221446.GB16573@bigcity.dyn.berto.se>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 08, 2019 at 12:14:46AM +0200, Niklas Söderlund wrote:

...

> > From my PoV I think the patch is fine in its current form.
> > Niklas do you feel particularly strongly about changing it?
> 
> No I do not feel strongly about this and would be fine with the patch in 
> it's current form. With and update commit message to mention V3M and D3 
> feel free to add
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks Niklas,

I have gone ahead and posted
[PATCH v2] thermal: rcar_thermal: update calculation formula for R-Car Gen3 SoCs
