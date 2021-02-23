Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C3322CE8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Feb 2021 15:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhBWOyU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 09:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232520AbhBWOyS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Feb 2021 09:54:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED19164E12;
        Tue, 23 Feb 2021 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614092018;
        bh=OM4cSQCV8yXeiUPJwhUhjpxUXGQYw13IEBaq41dXDGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGU+j7EQQ2t8KbwUIJxd7loy8zUA1jLuw2dGQPrVXAcKUzwFESYQF6diMDL3UIGZ8
         UpLCPAo62vTnHkKlD7vElszn1Hozun4b7rONR8m23vSVN+XyhTqkV05LEWizHkz2VU
         m1uaEPgtWWq7+vMuREIBY6ZQIEXDTSt8R2I1d3qdn4YRQ4fGe2piacu9m7c0z9vydo
         Q3eYvn1NPlPojp1YJyLZv2Vs7PFj7QaOfgGdBEFpCPBq+/FpcDYV0kgQPfjOPjF0eT
         cnh06GLAwVXD8n2HED9ORMQow6kAZfLHMLndv7/MGi904o9Hkv3RIKyHGLuMVBIH6i
         SzQJuPcsa28xw==
Received: by pali.im (Postfix)
        id A00E2CAE; Tue, 23 Feb 2021 15:53:35 +0100 (CET)
Date:   Tue, 23 Feb 2021 15:53:35 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: Re: [PATCH 1/3] power: supply: bq27xxx: fix sign of current_now for
 newer ICs
Message-ID: <20210223145335.2vsfclgeqpsmacfp@pali>
References: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
 <20210223154946.1ef58514@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223154946.1ef58514@aktux>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 23 February 2021 15:49:46 Andreas Kemnade wrote:
> On Tue, 23 Feb 2021 15:11:20 +0100
> Matthias Schiffer <matthias.schiffer@ew.tq-group.com> wrote:
> 
> > Commit cd060b4d0868 ("power: supply: bq27xxx: fix polarity of current_now")
> > changed the sign of current_now for all bq27xxx variants, but on BQ28Z610
> > I'm now seeing negated values *with* that patch.
> > 
> > The GTA04/Openmoko device that was used for testing uses a BQ27000 or
> > BQ27010 IC, so I assume only the BQ27XXX_O_ZERO code path was incorrect.
> > Revert the behaviour for newer ICs.
> > 
> > Fixes: cd060b4d0868 "power: supply: bq27xxx: fix polarity of current_now"
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> > 
> > @Andreas Kemnade: It would be great to get a confirmation that the
> > Openmoko battery indeed uses BQ27000/BQ27010 - I was having some trouble
> > finding that information.
> > 
> I can confirm that.
> here is the corresponding schematic:
> 
> http://people.openmoko.org/tony_tu/GTA02/hardware/GTA02/CT-GTA02.pdf
> 
> Regards,
> Andreas

Nokia N900 has BQ27200 connected via i2c. CCing Maemo mailing list maemo-leste@lists.dyne.org
