Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16351322CD2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Feb 2021 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhBWOuk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 09:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhBWOuc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2021 09:50:32 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD59FC061786;
        Tue, 23 Feb 2021 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xaG2XnjEAwC4M07KJBi3PgFXfaTqupRbx3G9e9s1FeY=; b=E/QMLfDmUfV2jMzZ8VVexuOQMc
        mEHrlLj2nUZIRlV+ooE9RpEy/topEzz45PJXZ9a6GIEsWqzknz47U5LZ8eF7+2DC1a0ETz3NbStmT
        I50Ptd1+YOhlz6jsJlLFWm4IUBGf8VkeNU5JRCeKLkC147ph7t213e3tjaEIQJqy7CBk=;
Received: from p200300ccff188c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff18:8c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lEZ0V-0003Xb-15; Tue, 23 Feb 2021 15:49:47 +0100
Date:   Tue, 23 Feb 2021 15:49:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Dan Murphy <dmurphy@ti.com>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: bq27xxx: fix sign of current_now for
 newer ICs
Message-ID: <20210223154946.1ef58514@aktux>
In-Reply-To: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
References: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Feb 2021 15:11:20 +0100
Matthias Schiffer <matthias.schiffer@ew.tq-group.com> wrote:

> Commit cd060b4d0868 ("power: supply: bq27xxx: fix polarity of current_now")
> changed the sign of current_now for all bq27xxx variants, but on BQ28Z610
> I'm now seeing negated values *with* that patch.
> 
> The GTA04/Openmoko device that was used for testing uses a BQ27000 or
> BQ27010 IC, so I assume only the BQ27XXX_O_ZERO code path was incorrect.
> Revert the behaviour for newer ICs.
> 
> Fixes: cd060b4d0868 "power: supply: bq27xxx: fix polarity of current_now"
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> @Andreas Kemnade: It would be great to get a confirmation that the
> Openmoko battery indeed uses BQ27000/BQ27010 - I was having some trouble
> finding that information.
> 
I can confirm that.
here is the corresponding schematic:

http://people.openmoko.org/tony_tu/GTA02/hardware/GTA02/CT-GTA02.pdf

Regards,
Andreas
