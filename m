Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34081F13F7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 09:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgFHHup (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 03:50:45 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:53931 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbgFHHum (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 03:50:42 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49gQR427lLz2d;
        Mon,  8 Jun 2020 09:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591602640; bh=1E5TLFv0Qix6OuC8g563KyHdAer+hGy3zGxRZ3URGDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lu9kB5ghtQ+L+JZed3mX4EQCmuQ1enh5MasGPi2Xm9/SRiSVO9GJtM/hhVdqmGbRQ
         y4orwsM+PhC1jpt5YQxyTpe2zH+FTKYZTd9gBi9Ph3lgWcvJwtazj1GY0oFRgDApbr
         rtqEasRwT0tGXXsP9GguvquX9/yHU4O/nRUJX+NwC1ox/TPsq+rRF9k+VFBVRHVI4d
         MNW3LwUgYs7mWSwiOkNpeLwTMPkmpj3xeuOLQojm7sup22PE6KyARhn6XQx77azo+X
         ot+kl5M/01i/6D8xDo5FjokwKazFSSja9k+YDGXSqa+i4H8dINzKHMylei7vy2Jdjq
         aa8mMQ0y9a35A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 8 Jun 2020 09:50:39 +0200
From:   Michal Miroslaw <mirq-linux@rere.qmqm.pl>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RFC v2] PM-runtime: change the tracepoints to cover
 all usage_count
Message-ID: <20200608075038.GB1124@qmqm.qmqm.pl>
References: <cover.1591600914.git.yu.c.chen@intel.com>
 <0a3ae7be4c467912327005995b1defb4fefd8101.1591600914.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a3ae7be4c467912327005995b1defb4fefd8101.1591600914.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 08, 2020 at 03:42:15PM +0800, Chen Yu wrote:
> Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> has added some tracepoints to monitor the change of runtime usage, and
> there is something to improve:
> 1. There are some places that adjust the usage count have not
>    been traced yet. For example, pm_runtime_get_noresume() and
>    pm_runtime_put_noidle()
> 2. The change of the usage count will not be tracked if decreased
>    from 1 to 0.
> 
> This patch intends to adjust the logic to be consistent with the
> change of usage_counter, that is to say, only after the counter has
> been possibly modified, we record it. Besides, all usage changes will
> be shown using rpm_usage even if included by other trace points.
> And these changes has helped track down the e1000e runtime issue.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: According to Michal's suggestion, adjust the commit log
>     to better describe the meaning of this patch.
> --
>  drivers/base/power/runtime.c | 38 +++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
[...]

Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
