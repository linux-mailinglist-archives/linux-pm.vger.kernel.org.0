Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECEF33A876
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 23:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhCNWNT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 18:13:19 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:18328 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhCNWMw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Mar 2021 18:12:52 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4DzDM52nMVz77;
        Sun, 14 Mar 2021 23:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1615759971; bh=z/wZYhYKwga+kEX//9REJYbUOgRuaiWaN10WwRJ8dFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqlCwzxvM4E2IujlpOXABaUeT85NM8/knGJmy/8Gvt9EkIEChk2BVux9wf09SCBRn
         yQPpibsKrmoWVPJLSlT1K0SaHHpyTG2yDOyV/nrN7AP1fCcVJvcFftl7h9m9LBHqx/
         /HxuxooscE5NW1ZA9VWebD0rTyULnySwyu48FUHgR6ak8S4ex5morpEL/krfOGZ9Fr
         IipC/pZa5CED+C0oW3dQdYF5xvSkJjPUly5D4fpH5Xj63HjohZZ9PEmwKybyyapyIL
         QLe3YJABNUdbEnD3Ni3/lKmD/xC355OXODOcJuYHUzoL9qehu7fPjV/JEiOQq40XyG
         RpC+KMLlNJ32A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 14 Mar 2021 23:11:30 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v15 2/2] drm/tegra: dc: Extend debug stats with total
 number of events
Message-ID: <20210314221130.GB2733@qmqm.qmqm.pl>
References: <20210311172255.25213-1-digetx@gmail.com>
 <20210311172255.25213-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210311172255.25213-3-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 11, 2021 at 08:22:55PM +0300, Dmitry Osipenko wrote:
> It's useful to know the total number of underflow events and currently
> the debug stats are getting reset each time CRTC is being disabled. Let's
> account the overall number of events that doesn't get a reset.
[...]

Looks good. It seems independent from the other patch.

Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
