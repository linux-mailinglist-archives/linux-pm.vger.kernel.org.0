Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E12B696E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgKQQI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 11:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKQQI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 11:08:58 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B05C0613CF
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 08:08:58 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 237B0221;
        Tue, 17 Nov 2020 16:08:57 +0000 (UTC)
Date:   Tue, 17 Nov 2020 09:08:56 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilina@codeaurora.org, lukasz.luba@arm.com, rkumbako@codeaurora.org,
        rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] Documentation/powercap/dtpm: Add documentation
 for dtpm
Message-ID: <20201117090856.27eddac7@lwn.net>
In-Reply-To: <20201116152649.11482-3-daniel.lezcano@linaro.org>
References: <20201116152649.11482-1-daniel.lezcano@linaro.org>
        <20201116152649.11482-3-daniel.lezcano@linaro.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Nov 2020 16:26:47 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> The dynamic thermal and power management is a technique to dynamically
> adjust the power consumption of different devices in order to ensure a
> global thermal constraint.
> 
> An userspace daemon is usually monitoring the temperature and the
> power to take immediate action on the device.
> 
> The DTPM framework provides an unified API to userspace to act on the
> power.
> 
> Document this framework.

It's always refreshing to see documentation show up with a new feature! :)

That said, it's clear that you haven't built the docs with this new
material.  There's a couple of little things I would ask you to do...

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/power/powercap/dtpm.rst | 222 ++++++++++++++++++++++++++
>  1 file changed, 222 insertions(+)
>  create mode 100644 Documentation/power/powercap/dtpm.rst

You also need to add this new file to index.rst

> diff --git a/Documentation/power/powercap/dtpm.rst b/Documentation/power/powercap/dtpm.rst
> new file mode 100644
> index 000000000000..ce11cf183994
> --- /dev/null
> +++ b/Documentation/power/powercap/dtpm.rst
> @@ -0,0 +1,222 @@
> +==========================================
> +Dynamic Thermal Power Management framework
> +==========================================
> +
> +On the embedded world, the complexity of the SoC leads to an
> +increasing number of hotspots which need to be monitored and mitigated
> +as a whole in order to prevent the temperature to go above the
> +normative and legally stated 'skin temperature'.
> +
> +Another aspect is to sustain the performance for a given power budget,
> +for example virtual reality where the user can feel dizziness if the
> +performance is capped while a big CPU is processing something else. Or
> +reduce the battery charging because the dissipated power is too high
> +compared with the power consumed by other devices.
> +
> +The userspace is the most adequate place to dynamically act on the
> +different devices by limiting their power given an application
> +profile: it has the knowledge of the platform.
> +
> +The Dynamic Thermal Power Management (DTPM) is a technique acting on
> +the device power by limiting and/or balancing a power budget among
> +different devices.
> +
> +The DTPM framework provides an unified interface to act on the
> +device power.
> +
> +===========
> +1. Overview
> +===========

Please follow the sequence of subheading markers described in
Documentation/doc-guide/sphinx.rst.  This one should be:

	Overview
	========

(I took out the section number because that's not really needed in the RST
world, but that's up to you).

> +The DTPM framework relies on the powercap framework to create the
> +powercap entries in the sysfs directory and implement the backend
> +driver to do the connection with the power manageable device.
> +
> +The DTPM is a tree representation describing the power constraints
> +shared between devices, not their physical positions.
> +
> +The nodes of the tree are a virtual description aggregating the power
> +characteristics of the children nodes and their power limitations.
> +
> +The leaves of the tree are the real power manageable devices.
> +
> +For instance:
> +
> +  SoC
> +   |
> +   `-- pkg
> +	|
> +	|-- pd0 (cpu0-3)
> +	|
> +	`-- pd1 (cpu4-5)

This formatting will throw errors when you try to do the docs build.  The
easiest solution is to put literal blocks like this into ... a literal
block.  And that is most easily done by putting a double colon at the end
of the leading line:

   For instance::
   
The same will need to happen for all the rest of the ascii art.

> +* The pkg power will be the sum of pd0 and pd1 power numbers.
> +
> +  SoC (400mW - 3100mW)
> +   |
> +   `-- pkg (400mW - 3100mW)
> +	|
> +	|-- pd0 (100mW - 700mW)
> +	|
> +	`-- pd1 (300mW - 2400mW)
> +
> +* When the nodes are inserted in the tree, their power characteristics
> +  are propagated to the parents.

I suspect you'll also need to indent the literal block another space or two
to separate it from the bulleted list.

You don't have any kernel-doc directives to bring in the kerneldoc comments
from the code.  The code itself *does* have those comments, so you might
want to add those.

Thanks,

jon
