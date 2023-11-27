Return-Path: <linux-pm+bounces-277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820A7FA40A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692F5B21008
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA0431739;
	Mon, 27 Nov 2023 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FE88C2;
	Mon, 27 Nov 2023 07:05:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCCB02F4;
	Mon, 27 Nov 2023 07:06:29 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 129883F6C4;
	Mon, 27 Nov 2023 07:05:40 -0800 (PST)
Date: Mon, 27 Nov 2023 15:05:38 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: arm: Avoid polling for scmi_perf_domain
Message-ID: <ZWSwQklU0MFQLMeI@bogus>
References: <20231127135033.136442-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127135033.136442-1-ulf.hansson@linaro.org>

On Mon, Nov 27, 2023 at 02:50:33PM +0100, Ulf Hansson wrote:
> It was a mistake to prefer polling based mode when setting a performance
> level for a domain. Let's instead rely on the protocol to decide what is
> best and thus avoid polling when possible.
>
> Reported-by: Nikunj Kela <nkela@quicinc.com>
> Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")

Ah, I hadn't even noticed before  :). Anyways,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

