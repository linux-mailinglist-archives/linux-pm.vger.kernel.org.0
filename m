Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5FC22C3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfI3OIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbfI3OIt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 10:08:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13773216F4;
        Mon, 30 Sep 2019 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852528;
        bh=PXtxWpDmdWTau2Dakee48K9u96lf4TbmFa7hbXULlLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sT9Dx3r+gjbRR4mnmUHKMFb+9NkvtkNJ9I7fBv+aHbC7lWnVl6e7XCsLAbYvG4UV3
         fOTGIJL7MtnRwIZ6HEf/FGgoUmFasTeTadmf1LWJ1UOmV4a6YAQBE4kwzHQeER3sPQ
         tpkqZBgtxq5nY6gcSdMwF9LLe6eC3RVU4dxzwR1g=
Date:   Mon, 30 Sep 2019 10:23:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     linux-pm@vger.kernel.org, madhuparnabhowmik03@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, sre@kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH 4/4] Driver: Power: Supply:
 abx500_chargalg: Fixed a few coding style errors
Message-ID: <20190930082303.GC2036553@kroah.com>
References: <20190929181906.GA21828@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929181906.GA21828@madhuparna-HP-Notebook>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 29, 2019 at 11:49:10PM +0530, Madhuparna Bhowmik wrote:
> This patch fixes a few coding style errors and warnings
> detected by checkpatch.pl:
> 
> WARNING: please, no space before tabs
> ERROR: code indent should use tabs where possible
> WARNING: please, no spaces at the start of a line
> WARNING: Unnecessary parentheses
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: Prefer 'long' over 'long int' as the int is unnecessary

I know for the subsystems I maintain, I would require this to be broken
up into "one logical change per patch" so be aware that this might also
need to be done here too.

good luck!

greg k-h
