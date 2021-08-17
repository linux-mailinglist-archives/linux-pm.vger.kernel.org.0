Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14953EF0F3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhHQRaY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 13:30:24 -0400
Received: from first.geanix.com ([116.203.34.67]:37258 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhHQRaW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Aug 2021 13:30:22 -0400
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 00493440D69;
        Tue, 17 Aug 2021 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1629221387; bh=FPnsNEknMW51PjerbPw5J1Vc/K/EFlv5JT8sE/sLHfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FocYJlrLLN/FjgC7UEIOSvuWXLQkzlYHJxyZ0kHjHEjEbDL8Yipr6SsDANKazVLzt
         fkTyu23e5djs4hobO31ztzJD9a7vqqKYgEx9tcrOqXo+pJO4HVphBVX+rB1TbZ5WDM
         bxvNJW7BOBLFfQs36n77xGq4HdzEsNsikHHt9h8LDPpsQfoDFrRfhgNNpuSoCH1f/u
         VRCfZJ0ndeFJn43kMniI+72vvES/E8rNia8la4NdmvJ6/Grkz/zsraE1z9AE78pF4Q
         J/kP9pYVlOmdcBq1c1gTbDXJorEW1y4nxtA39lpj5XfHWt12yZ7OqMu5Jl/H6DmFVi
         AA/LI5XfsaxAA==
Date:   Tue, 17 Aug 2021 19:29:45 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     s.hauer@pengutronix.de, miquel.raynal@bootlin.com, richard@nod.at
Cc:     linux-pm@vger.kernel.org, han.xu@nxp.com,
        linux-mtd@lists.infradead.org
Subject: Re: [BUG RESEND] unsuspend failure under load
Message-ID: <20210817172945.pr26wnoum7y5d7px@skn-laptop>
References: <20210705065833.2ezlhaspkkju4bh7@skn-laptop>
 <20210706093541.f4kjxqrkft7fqbcx@skn-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210706093541.f4kjxqrkft7fqbcx@skn-laptop>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 06, 2021 at 11:35:44AM +0200, Sean Nyekjaer wrote:
> On Mon, Jul 05, 2021 at 08:58:38AM +0200, Sean Nyekjaer wrote:
> > Hi Miquel and Sascha,
> + Richard + linux-pm
> > 
> > We are having some trouble when our i.MX6 unsuspends while writes to
> > ubifs is in progess. In the log it looks like it syncing the filesystem
> > before suspend.
> > 
> > The SoC a i.MX6ul/ull, the issue is (lucky for us) quite easy to reproduce.
> > The reproduce script: [0]
> > Kernel log when it happens: [1]
> > 
> > I have bisected the bug to: ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
> > 
> > Any idea to where I should start looking? or to what happens?
> > 
> > Esben have posted to patches that relates to suspend/unsuspend but it
> > doesn't seem to releated to this issue.
> > 5bc6bb603b4d ("mtd: rawnand: gpmi: Fix suspend/resume problem")
> > d70486668cdf ("mtd: rawnand: gpmi: Restore nfc timing setup after suspend/resume")
> > 
> > /Sean
> 
> nand_resume() is called some time after ubi_io_write tries to write. Thats why
> mtd_write() is returning -EBUSY.
> 
> I have tried patch [3], and it seems to fix it.
> I think it would be okay to add the retry option, but the mdelay is not
> obviously a nogo.
> 
> Any idea to how we could wait here for the nand_resume() to be called?
> 
> @linux-pm:
> I have noticed "Filsystems sync" happens before "Freezing user space
> processes".
> If I apply patch [4] (without [3]), it would also fix our issue. But I
> don't have en insight in to what impact the change might have.
> 
> /Sean
> 

Ping Miquel + Sascha,

Have you had time to take a look at this?

/Sean
