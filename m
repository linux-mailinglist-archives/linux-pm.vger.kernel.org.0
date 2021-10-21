Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82F435FEF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 13:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJULIj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 07:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhJULIj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 Oct 2021 07:08:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 399AA60FF2;
        Thu, 21 Oct 2021 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634814383;
        bh=migNMOvIkZ7+9DZqjiTXUsnT8m2WwgZASseFr/ObM4k=;
        h=Date:From:Subject:To:Cc:From;
        b=nJmgPsSY/CdNkM8qjX/iW2e39uBxLPeKaiCKPjYeTFGx2gK4V/itX16lYq2ZXNDE2
         UAjElNf4PXuJKCPvrTnpsXVgqTwh9XxsABXL5T1y2VhBiWAkQupuXvxQHBVBrZTFDJ
         IHu78rVFkN8eovFBFe09nhsOxtolIvMYkFjuk4IKMeNA3ZGWRNkjZQTNnNhu2Qdc+V
         wySYfOtNL1jPiY56XQeYANANa1wJW1FBpky7PLKE6GojPPh981l3O4s0qUPosrspPb
         sRIYb7xJKICB3N+tJ/y6q33GX5s/WPAAy2B4SUBzcUEe2XIPYPN/phbYXMzkp8bSD4
         0xcBiVDKSCANw==
Message-ID: <42432cc2-5cb2-ea74-0980-8575e3a343fd@kernel.org>
Date:   Thu, 21 Oct 2021 14:06:17 +0300
MIME-Version: 1.0
From:   Georgi Djakov <djakov@kernel.org>
Subject: SCMI protocol for interconnect scaling
To:     linux-pm@vger.kernel.org,
        linaro-open-discussions@op-lists.linaro.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        souvik.chakravarty@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi all,

I am recently getting questions about hooking the interconnect framework
to SCMI, so i am starting a discussion on this problem and see who might
be interested in it.

The SCMI spec contains various protocols like the "Performance domain 
management protocol". But none of the protocols mentioned in the current
spec (3.0) seem to fit well into the concept we are using to scale
interconnect bandwidth in Linux. I see that people are working in this
area and there is already some support for clocks, resets etc. I am
wondering what would be the right approach to support also interconnect
bus scaling via SCMI.

The interconnect framework is part of the linux kernel and it's goal
is to manage the hardware and tune it to the most optimal power-
performance profile according to the aggregated bandwidth demand between
the various endpoints in the system (SoC). This is based on the requests
coming from consumer drivers.

As interconnects scaling does not map directly to any of the currently
available protocols in the SCMI spec, i am curious whether there is
work in progress on some other protocol that could support managing
resources based on path endpoints (instead of a single ID). The
interconnect framework doesn't populate every possible path, but
it exposes endpoints to client drivers and the path lookup is dynamic,
based on what the clients request. Maybe the SCMI host could also expose
all possible endpoints and let the guest request a path from the host,
based on those endpoints.

There are already suggestions to create vendor-specific SCMI protocols
for that, but i fear that we may end up with more than one protocol for
the same thing, so that's why it might be best to discuss it in public
and have a common solution that works for everyone.

Thanks,
Georgi
