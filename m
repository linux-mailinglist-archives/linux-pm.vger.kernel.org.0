Return-Path: <linux-pm+bounces-31483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F2AB13B6B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 15:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646CF16B3A6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD07C267732;
	Mon, 28 Jul 2025 13:23:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187C67261C;
	Mon, 28 Jul 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709007; cv=none; b=VGsBn2aAj4u2Wj05f9j+V2dTjKZuGUExCxJIQBvTsmP5KjJy9jNt+X0zEGI5uvxMkOfXlfr4T587pcdA6Vs7cnw/eXeS3+t5uecZOdF5wE3FFQ2ow4LoDHB41zOkIs5gNTnxDHLtrlfeJjZBZNPZazzYVNSt2AICIdtRt0pkIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709007; c=relaxed/simple;
	bh=NAQ/zJ7Cd0gCK86SJM5nKyxBxJiSPDXbYTrj9hDZGKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7Lh9TfNJxfPgAP2RsgjsNToUPJRQh54+IRA3Jz35xwDNd8+b8pc25RRZ/uraa2smVTzXxoRbzOzgfQbKhm/pJO2YQgvS3wJ5VkYIjYDy+Fn/ksaceWCVuq5AddFQUH410gYkNWk5JWH/Sq/NJk40axCPBWb6i3L76sN3lA5MtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3151516;
	Mon, 28 Jul 2025 06:23:17 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54A813F66E;
	Mon, 28 Jul 2025 06:23:20 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:23:17 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Elliot Berman <quic_eberman@quicinc.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Message-ID: <20250728-exotic-armadillo-of-upgrade-fbebc1@sudeepholla>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b81aa592-a66b-457b-9f42-df4505b28508@kernel.org>
 <3gtlf5txxtioa5bvo6o467jupyoam4hjhm2mdiw5izv5vbl3tz@drndgp3tcrgo>
 <bcef34c3-98b4-454c-8138-c73729e17081@kernel.org>
 <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
 <2a39c0ab-edd4-402c-95a0-a6286f03102a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a39c0ab-edd4-402c-95a0-a6286f03102a@kernel.org>

On Mon, Jul 28, 2025 at 02:23:14PM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2025 14:03, Dmitry Baryshkov wrote:
> >>
> >>> and the reboot-mode is defined in the
> >>> previous patch. So, I'd assume, the path is defined.
> >>
> >> As I said, path is not. only psci/reboot-mode is.
> > 
> > Do we have an _actual_ use case where PSCI node is not at at root node? 
> 
> Yes, many cases, because it belongs as well to firmware node.
> 

+1, I was about to make similar comment. /psci predates the formal push
to put all firmware related nodes under /firmware, so /firmware/psci is
equally possible path and should be recommended one so that all such
firmware related nodes are contained under /firmware.

-- 
Regards,
Sudeep

