Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A230653C
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 21:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhA0Uei (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 15:34:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:43802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbhA0Ueh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 15:34:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE6F9ACBA;
        Wed, 27 Jan 2021 20:33:54 +0000 (UTC)
Date:   Wed, 27 Jan 2021 21:33:46 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Artem Bityutskiy' <dedekind1@gmail.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Len Brown' <lenb@kernel.org>,
        'Linux PM Mailing List' <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] tools/power/turbostat: fix compatibility with older
 kernels
Message-ID: <20210127203346.GE8115@zn.tnic>
References: <20210127132444.981120-1-dedekind1@gmail.com>
 <20210127185957.GD8115@zn.tnic>
 <002201d6f4e9$1e9f6c10$5bde4430$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002201d6f4e9$1e9f6c10$5bde4430$@net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 27, 2021 at 12:15:10PM -0800, Doug Smythies wrote:
> It is supposed to work with old kernels. Here is a quote from Len from
> [1] (2019.09.05) :

Yeah, reportedly, this is the general strategy with tools in tools/.

> Which is also what I do. I was also trying, so far without success, to
> get a distro to relax its stringent, unnecessary, turbostat dependency
> checking [2].

I see.

> Yes agree, the information is still required.

Yeah, lemme do a proper patch tomorrow.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
