Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9E3C1B8B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 00:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhGHWpF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 18:45:05 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:18907 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhGHWpE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jul 2021 18:45:04 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GLWWZ4xMKzMT;
        Fri,  9 Jul 2021 00:42:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1625784138; bh=PSGUwpFBwl/ZrrEQdoJ/3g3P6zMIBB0aEwyRK24KGdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpJrlN9fSLcRGXrVBz/u4Ox6E8T6/+j0WX2vMpzJfMtVILDgGtfIm2/grSi/bu88e
         cV+g0IvmKehJVnwbfRui4NttIqfc6IpFkXLDJnncIT6nQZsLCN5AHU9xBVfN9pcjan
         XQPQChuYtn5qO5pyzEpyyG3eLeymXhyrzXTXaSf0P1v5R2K1WMTBaqtLsaC63MZj/S
         hjr3s5+e91yZ6vlVBEXx29kYxGB8CWbUWBjU6VvPVldVfxgQmZWI5BORiE+6x2ErnH
         k9c0MVXdUuXq3WMHc62okDU/wyrSXqo9b+AEydZ0XFmAc/o/GKOUBqCPp4IbgIg9q9
         pWKOtrKjSpngQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Fri, 9 Jul 2021 00:42:17 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 05/12] usb: otg-fsm: Fix hrtimer list corruption
Message-ID: <YOd/SfxC26esmVXU@qmqm.qmqm.pl>
References: <20210701022405.10817-1-digetx@gmail.com>
 <20210701022405.10817-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701022405.10817-6-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 01, 2021 at 05:23:58AM +0300, Dmitry Osipenko wrote:
> The HNP work can be re-scheduled while it's still in-fly. This results in
> re-initialization of the busy work, resetting the hrtimer's list node of
> the work and crashing kernel with null dereference within kernel/timer
> once work's timer is expired. It's very easy to trigger this problem by
> re-plugging USB cable quickly. Initialize HNP work only once to fix this
> trouble.
[...]
> -	INIT_DELAYED_WORK(&fsm->hnp_polling_work, otg_hnp_polling_work);
> +	if (!fsm->hnp_work_inited) {
> +		INIT_DELAYED_WORK(&fsm->hnp_polling_work, otg_hnp_polling_work);
> +		fsm->hnp_work_inited = true;
> +	}
> +

Maybe you could just add an initialization function to be called by
users of otg_fsm? It seems that only chipidea driver uses this
struct currently.

Best Regards
Micha³ Miros³aw
