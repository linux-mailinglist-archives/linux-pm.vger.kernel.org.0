Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42160F38BA
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 20:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfKGThA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 14:37:00 -0500
Received: from ms.lwn.net ([45.79.88.28]:39222 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfKGThA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Nov 2019 14:37:00 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 619206EC;
        Thu,  7 Nov 2019 19:36:59 +0000 (UTC)
Date:   Thu, 7 Nov 2019 12:36:58 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Louis Taylor <louis@kragniz.eu>
Cc:     georgi.djakov@linaro.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api: make interconnect title quieter
Message-ID: <20191107123658.5bd0e1b7@lwn.net>
In-Reply-To: <20191101193314.67994-1-louis@kragniz.eu>
References: <20191101193314.67994-1-louis@kragniz.eu>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri,  1 Nov 2019 19:33:14 +0000
Louis Taylor <louis@kragniz.eu> wrote:

> This makes it consistent with the other headings in the Linux driver
> implementer's API guide.
> 
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  Documentation/driver-api/interconnect.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
> index c3e004893796..cdeb5825f314 100644
> --- a/Documentation/driver-api/interconnect.rst
> +++ b/Documentation/driver-api/interconnect.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  =====================================
> -GENERIC SYSTEM INTERCONNECT SUBSYSTEM
> +Generic System Interconnect Subsystem
>  =====================================

Applied, thanks.

jon
